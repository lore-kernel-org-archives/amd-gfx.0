From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Tue, 11 Apr 2017 10:31:01 +0300
Message-ID: <20170411103101.0497fe08@eldfell>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell>
 <1491833847.30990.77.camel@redhat.com>
 <20170410180941.43922e25@eldfell>
 <CAKb7UvhbgSGwx-2EsrQrHmghzYqO9AhRQ10bDWKfdcXHc3fJeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0549231857=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKb7UvhbgSGwx-2EsrQrHmghzYqO9AhRQ10bDWKfdcXHc3fJeQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============0549231857==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AGXd/3dVDU64kRRgy0u5uok"; protocol="application/pgp-signature"

--Sig_/AGXd/3dVDU64kRRgy0u5uok
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Apr 2017 12:10:14 -0400
Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org> wrote:

> On Mon, Apr 10, 2017 at 11:09 AM, Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:

> > I also wonder if a real BE machine could have different results than
> > the virtual machine. =20
>=20
> I have a PPC G5 with an AGP GeForce FX 5200 that I can test things on,
> if necessary. (I got it specifically for this purpose, as the people
> who use this type of hw daily tend to perform updates rarely... in no
> small part due to the fact that updates tend to break the HW.)
>=20
> Just let know what you need tested, I should be able to turn it around
> within a couple of days.

That's part of my problem. I don't really know what should be tested.
What do people do with their BE machines that we should avoid breaking?

I suppose correlating with what Gerd was testing would be nice, i.e.
does X.org with modesetting look right with and without GLAMOR? Maybe
you also want to throw in xf86-video-nouveau for comparison.

As to what apps to test those with... Gerd? I presume anything that does
*not* use OpenGL, since we have doubts of Mesa's correctness on BE,
right? So maybe some of the traditional ancient X11 apps? xterm with
colours?

However, I totally agree with Alex that someone with a BE machine
should review the whole stack before we could be confident with anything.


Thanks,
pq

--Sig_/AGXd/3dVDU64kRRgy0u5uok
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAljshjUACgkQI1/ltBGq
qqd4fxAAoR8FANAGOx8K40e4NU05ZkDUhRoGMMKGE1lla7s30rCCAkE5TAMXJVIr
5AYJ52RWYOq4Z1WWfANjRce9iS2f2aRUOQx9Y8BlHYLBdf6xoL7lfhDA6zGc/OiC
kAXcpvGDGFyNrXxfByaW7gYcNUNPHCHNMkUivk6dHTQ+NbwtPqjbC32ITurVHQ7i
81WUObpQMn3pk33xei++4lQ4DRsV0YPGxYLkebnIQxtTK6AyICqiq+qX8PJCplvm
sktZ4krio5lScaOqpxkNammaRAS2xznVNObXGMkBOzk1+2XWKnN7U60Z04h/SMJc
PkIcoZ9jaiZdK3Nz4terdFhMRUBYeuJhhsdnF53wIcxRZSC+0JwzHd0885LQe/je
yyPl//O9AvHtllcwQwAT9exxhlOioBo5raldGhUi+L44qruY57GGDVf2NenA2WG9
KwphDtQbAoYYlT27rx2aEbpuc6xt2pJ+Y62AYx7tkCmQm2GB1+YvtF7HI8Vnl8wj
Vy+wUgU+IZmisZf3orDtk9pG5Tpv3RYgZknTlPTpt8HM0fn8Kf1GIrvjYwqTjMEc
MlZ92FwVNgjF9OsHM5n/NzqZmGO9sJCWJvryDBjApGs+LI+X3LHDrHrNZEqZSgSa
PRI72nEtTcjBb5ywNdmqWJ7yIrI4F9ToqTztVcxIUNTNByRvtTM=
=R/r6
-----END PGP SIGNATURE-----

--Sig_/AGXd/3dVDU64kRRgy0u5uok--

--===============0549231857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0549231857==--
