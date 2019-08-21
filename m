From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Nouveau] [Intel-gfx] [PATCH v6 08/17] drm/ttm: use gem vma_node
Date: Wed, 21 Aug 2019 13:55:23 +0200
Message-ID: <20190821115523.GA21839@ulmo>
References: <20190805140119.7337-1-kraxel@redhat.com>
 <20190805140119.7337-9-kraxel@redhat.com>
 <20190813151115.GA29955@ulmo>
 <20190814055827.6hrxj6daovxxnnvw@sirius.home.kraxel.org>
 <20190814093524.GA31345@ulmo>
 <20190814101411.lj3p6zjzbjvnnjf4@sirius.home.kraxel.org>
 <CACAvsv5Rar9F=Wf-9HBpndY4QaQZcGCx05j0esvV9pitM=JoGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0753479191=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACAvsv5Rar9F=Wf-9HBpndY4QaQZcGCx05j0esvV9pitM=JoGg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Ben Skeggs <skeggsb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, ML nouveau <nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, intel-gfx <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


--===============0753479191==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 04:33:58PM +1000, Ben Skeggs wrote:
> On Wed, 14 Aug 2019 at 20:14, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >
> >   Hi,
> >
> > > > Changing the order doesn't look hard.  Patch attached (untested, have no
> > > > test hardware).  But maybe I missed some detail ...
> > >
> > > I came up with something very similar by splitting up nouveau_bo_new()
> > > into allocation and initialization steps, so that when necessary the GEM
> > > object can be initialized in between. I think that's slightly more
> > > flexible and easier to understand than a boolean flag.
> >
> > Yes, that should work too.
> >
> > Acked-by: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Acked-by: Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Thanks guys, applied to drm-misc-next.

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1dMSYACgkQ3SOs138+
s6H8fQ/9F4UBF0EhVBpcsMNo5HI1kJ8KEkbiNqUWwZEh/kPLyWXoFWSWvA5FG+rP
521CfufMmyezTHxOkPww6VEUsgaV9yEl00jqIhclgA43sBeDziR4XGzGmA/hpdpc
ky8L49+C8mfoICLHeBjOSbSHoPhv7EqS1w8CtZkCZkf1nApk/R71bbYk6iz8zCCY
dhZo6PGTJMpOoEQtryLjL2NJxvJe57zzsltRKxl9uEnjeDF0LRzqHYZ1Lt/mvRMn
hXMXC1H+jOtP4p7OtP8zE6oM7desaJ2h4jXF1v1/AZHNUxQYtRohHNrYXBDqfQF5
stLLdOjynZ8rcjhObmi3GeLbVeD2wEQJ7Qp7OgTwqbHnE4wXmAYD4KuKboJrQI8t
0Hd25epBD/CHDgn7Kqoj8DRy5NArmeCGRDHVuFYF45utaectO7IzaxRD5zLRs6Q5
vAA0fiy8JVs6ppQ6B9GtlQcXEKbmywLhBAzHb/Q7hukhppOhS+BxZO0FASdPmPnH
0kjoVG0oz9oH8X/ciqubGIAUkrq+SP+OnPVvg1zGfAkxLSUTDKMZ4ZmP2vlrRzaf
KFbFX02Gu+VDe/o7Pcf9F8pDlWS+jQL6KN+PFo2tkGP8HvouRsIagyzY/AJD0xuP
Bb3DKPgm8W5/ggiLoiTbXz+CUWR25Hm2vBU/CZ9Uv9KBPgv95bA=
=lGaC
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

--===============0753479191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0753479191==--
