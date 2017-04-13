From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Thu, 13 Apr 2017 10:44:38 +0300
Message-ID: <20170413104438.7775a28c@eldfell>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell>
 <1491833847.30990.77.camel@redhat.com>
 <20170410180941.43922e25@eldfell>
 <CAKb7UvhbgSGwx-2EsrQrHmghzYqO9AhRQ10bDWKfdcXHc3fJeQ@mail.gmail.com>
 <20170411103101.0497fe08@eldfell>
 <1491909833.30990.93.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1423717520=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491909833.30990.93.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============1423717520==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VlVKg/=g6TWHU8SOXzOk9Jo"; protocol="application/pgp-signature"

--Sig_/VlVKg/=g6TWHU8SOXzOk9Jo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Apr 2017 13:23:53 +0200
Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>   Hi,
>=20
> > > Just let know what you need tested, I should be able to turn it around
> > > within a couple of days. =20
> >=20
> > That's part of my problem. I don't really know what should be tested.
> > What do people do with their BE machines that we should avoid breaking?=
 =20
>=20
> For the virtual machine use case the bar is pretty low, it's mostly
> about a graphical server console.  Anaconda installer.  Gnome desktop
> with browser and standard xorg (xterm) + gtk apps.  No heavy OpenGL
> stuff.  No hardware acceleration, so if opengl is used then it'll be
> llvmpipe.
>=20
> Right now Xorg is important.  Not sure whenever wayland ever will be,
> possibly the ppc64 -> ppc64le switch goes faster than the xorg ->
> wayland switch.

Hi,

IMHO you can ignore Wayland for now I suppose, I just wanted to point
out that we have similar problems there and whatever you do with the
DRM format codes will affect things on Wayland too.

Once you get things hashed out on an X.org based stack, we can look
what it means for Wayland software.

After all, BE users are scarce and allegedly favouring old software to
avoid breakage; Wayland is new, and Wayland compositors still "rare",
so the intersection of people using both BE and Wayland and relying on
it to work is... minuscule? insignificant?

I don't mean to belittle people that use Wayland on BE, but by that one
bug report EGL is and probably has been broken, and it's unclear if
anything has ever worked.


Thanks,
pq

--Sig_/VlVKg/=g6TWHU8SOXzOk9Jo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAljvLGYACgkQI1/ltBGq
qqem8hAApPz46GfiiceXJchrlij5cFY2KaAEBH+qEIQvP48igrNKQ1xRPtX/95fe
QmjhoDOeLIzXLAsxWU2h0m6pEpU1Y1NQolRFijHqmWcqU7hVfDCpZCj//MSvk2Q+
T0aqY7RtfRn8rruJB1MqXdmYyRg5mKpPv4zyqZd5q4Rf4NxPb2/G6htFOA9DHSQR
utPNqW3W6hUXwNnjnxh6UTvKfpylx5HmOYX0v7gqCa2doiNm1aV9LZMyk3pjKpDl
NnXO8xt6X7R7wAx3JonWuUQOE6MPpKshlZBi7GTKu9NiPh8wyPWh+u8zOALCdTIy
3dL/sZwNA41lmaXKj/pEtOF3sJJ6f/YeFr1SRDasZwQ/F2D2pAYqmJwe6b3o7k+Z
UTCw6yabzfB1CIlVXbmiEumeLDojTay/LmPIs90+EiKomPTFnP/oUk5riuCUm7lb
2iY0erj/n31uBDLR4a+74gd4IFJEJnmmk/pHWQEAgvMx8r9yVwJrtDR3G+7C8iyy
OU9lyXH5dakBBzPtRzmHziVSHB8FXc8UC+Qn2qY1prlsDVkdxWYVxp6bKcxgwDgD
r3nNU57F5f4R0YYK+pexQOxNGP6+Yg+BcMeliQEI2kG5q5DMg7NG4vyjEEQZmcOa
IRC2tQbKRm+PlxP7g0Hub0FrhnHyXPJE/CpX7PJ8C+13i3X2wUw=
=enD7
-----END PGP SIGNATURE-----

--Sig_/VlVKg/=g6TWHU8SOXzOk9Jo--

--===============1423717520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1423717520==--
