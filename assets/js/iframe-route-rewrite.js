(function () {
  const cfg = window.JTD_IFRAME_ROUTES || {};
  const siteRouteBase = cfg.siteRouteBase || '/docs/';
  const baseDocRoot   = cfg.baseDocRoot  || '/DocumentationHTML/Documentation/html/';
  const lowercaseDirs = cfg.lowercaseDirs !== false;

  const docPathToSiteRoute = (docPath) => {
    if (!docPath.startsWith(baseDocRoot)) return null;
    const sub = docPath.slice(baseDocRoot.length);
    const parts = sub.split('/');
    const file = parts.pop();
    const dirs = lowercaseDirs ? parts.map(s => s.toLowerCase()) : parts;
    return siteRouteBase + (dirs.length ? dirs.join('/') + '/' : '') + file;
  };

  const rewriteLinksInIframe = (iframe) => {
    try {
      const w = iframe.contentWindow;
      const doc = iframe.contentDocument;
      if (!doc) return;

      if (!doc.querySelector('base[target="_top"]')) {
        const baseEl = doc.createElement('base');
        baseEl.setAttribute('target', '_top');
        doc.head.prepend(baseEl);
      }

      doc.querySelectorAll('a[href]').forEach(a => {
        const href = a.getAttribute('href');
        if (!href || href.startsWith('#')) return;
        const url = new URL(href, w.location.href);
        const route = docPathToSiteRoute(url.pathname);
        if (route) {
          a.setAttribute('href', route + url.search + url.hash);
          a.setAttribute('target', '_top');
        }
      });
    } catch (e) {
      console.warn('iframe-route-rewrite: cannot access iframe (cross-origin?).', e);
    }
  };

  const init = () => {
    const iframe = document.getElementById('docframe');
    if (!iframe) return;
    iframe.addEventListener('load', () => rewriteLinksInIframe(iframe));
    if (iframe.contentDocument && iframe.contentDocument.readyState !== 'loading') {
      rewriteLinksInIframe(iframe);
    }
  };

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();