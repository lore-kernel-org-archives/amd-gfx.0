From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix compile error due to 'endif' missing
Date: Mon, 16 Sep 2019 23:31:52 +0100
Message-ID: <20190916223152.GO4352@sirena.co.uk>
References: <20190916044651.GA72121@LGEARND20B15>
 <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0593260936=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Austin Kim <austindh.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roman.Li-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>


--===============0593260936==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dBmMfAlnUmK8h9+K"
Content-Disposition: inline


--dBmMfAlnUmK8h9+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2019 at 02:46:48AM +0900, Masahiro Yamada wrote:
> On Mon, Sep 16, 2019 at 1:46 PM Austin Kim <austindh.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > gcc throws compile error with below message:

> GNU Make throws ...

Xinpeng Liu via Nick Desaulniers sent a description of the problem and a
patch so I think I'll be able to fix this.  However...

> This is probably a merge mistake in linux-next.

> If so, this should be directly fixed in the linux-next.

> If it is not fixed in time,
> please inform Linus to *not* follow the linux-next.

...as I said before I think you definitely need to coordinate with the
DRM people - Nick Desaulniers' patch 0f0727d971f6f (drm/amd/display:
readd -msse2 to prevent Clang from emitting libcalls to undefined SW FP
routines) breaks in places that don't have merge conflicts due to this
change.  I wouldn't rely on the merge going well if things are sent
as-is, the only reason this one showed up was that other people were
adding new files to the Makefile.

I've CCed Nick.

--dBmMfAlnUmK8h9+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ADVcACgkQJNaLcl1U
h9CpTAf/WVlKZHB2Ctr3ilkr7vpfMjEg59XRGkehdnNZnbqDxT4ydz27T7yuIHCw
mtoSmDyKi0sUOxW3Jj09CRuMhmbu56hfaNodbB6Mf2fj7InHXHbJ+32kxgHg5wlS
QIPMHLqU9w7wvidN6Ry6d6sinfokqcaiZVbmp0Q7sGcEb4CpVUGK64zuS2thwjSO
7WdhJ55MC6yV2co4FYS8yp0hSFeSnudaMG1/n7yniVUKpRkCF/F0r+XdS0i/kfrf
uE7cqXSfgk/DqnwscbZwuiFo0QcPuUfAuc7nJRrJkIXxQjAacepligIXioedCkQ1
PK7Hsf/bRVBAE+piKlcp1DJe6TcPaw==
=valx
-----END PGP SIGNATURE-----

--dBmMfAlnUmK8h9+K--

--===============0593260936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0593260936==--
