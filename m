From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Wed, 19 Apr 2017 10:09:56 +0300
Message-ID: <20170419100956.78e4a7ab@eldfell>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell>
 <1491833847.30990.77.camel@redhat.com>
 <20170410180941.43922e25@eldfell>
 <CAKb7UvhbgSGwx-2EsrQrHmghzYqO9AhRQ10bDWKfdcXHc3fJeQ@mail.gmail.com>
 <20170411103101.0497fe08@eldfell>
 <CAKb7UviNeLJAHtBQt2NgbEMOSz1sYneiB7i0CUDOBQRt=8OqNw@mail.gmail.com>
 <CAKb7UvgVD3Uf79noXMOcBjJYeeF6st21R3JBNvT-VVSNb8EH+Q@mail.gmail.com>
 <e94bde35-d3f5-fa98-cc64-6d48b37ec21f@daenzer.net>
 <CAKb7UviAoSh6F1v9kCThayVwnWKKi+w1KDLTHHGsLeS95o+Pjg@mail.gmail.com>
 <fe944ecc-3ca4-26d8-77bc-873a53dcbb3f@daenzer.net>
 <1492510440.27392.27.camel@redhat.com>
 <4230c093-6a8a-76d6-dce8-f9b2300fa70f@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1772626679=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4230c093-6a8a-76d6-dce8-f9b2300fa70f-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?UTF-8?B?RMOkbnplcg==?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============1772626679==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eMDPd5Br83l0AbWqfiiudJG"; protocol="application/pgp-signature"

--Sig_/eMDPd5Br83l0AbWqfiiudJG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Apr 2017 10:01:47 +0900
Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

> On 18/04/17 07:14 PM, Gerd Hoffmann wrote:
> >   Hi,
> >  =20
> >>> Quite true that this proves nothing. However one should note that
> >>> fbcon -> fbdev works, =20
> >>
> >> BTW, this supports Gerd's patch, since the KMS fbdev emulation code us=
es
> >> e.g. DRM_FORMAT_XRGB8888 for depth/bpp 24/32, and the fbdev API uses
> >> native endian packed colour values. =20
> >=20
> > Same is true for DRM_IOCTL_MODE_ADDFB, with depth/bpp 24/32 you'll get
> > DRM_FORMAT_XRGB8888 (only DRM_IOCTL_MODE_ADDFB2 allows userspace specify
> > fourcc formats directly). =20
>=20
> Right, and since all major Xorg drivers use DRM_IOCTL_MODE_ADDFB,
> they're effectively using DRM_FORMAT_XRGB8888 as native endianness as wel=
l.

I sincerely hope this doesn't actually force us into a place where we
have XRGB8888 (and ARGB8888?) as native-endian, but the other format
codes - since being used explicitly - must be kept as little-endian
because they were used like that honouring the documentation we have
atm. It's starting to resemble the wl_shm format codes problem we have
on Wayland for BE.

Has this now turned into a question of what the kernel drivers do
with the DRM pixel format codes?

Hmm, I suppose that has been the question all along... userspace uses
whatever formats that look right, new kernel drivers come along and fix
themselves to work with whatever userspace uses? And the people who get
it wrong are the ones who only ever test on LE and trust the docs...


Thanks,
pq

--Sig_/eMDPd5Br83l0AbWqfiiudJG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlj3DUQACgkQI1/ltBGq
qqdd1hAAqFwLsQ3oxyLk6Xa5Rxt9ruZpZb8Jk9DGA/VhEveweTlY8tGF6d60spP/
R8LYdMqZhZVcub4WZ1oHpUPiIQYCYPyKk5OogTnyAs8W60qhTMM0Emu6ejHz5uXD
I0msLQ6h6cmeZOBTAIvkx2UNMoz/A6m+ORvvBJKuxUF65b1hEVfu3ae11m8JO+r6
Irj+HhnMNgrcDNhjR+E2dnc9d+hyeDDLycXLJe03W3KAI134Tq9B1RiDyILGGcET
0jbSMWR2dhdnbt//VNsn/NeWDI07uYQ7gkpUTQIohxFU2jvn0wbolhVlt+WpNxpG
MA5jwAxutHH1tHDg1GFzGU16hXpy4K63Ln9mlR3VQ3PcZl1HTwNqNBmQdQZ/zUUS
5IKcy06XmG8qJ3437RhOCU07Fjf94fVMeayFM4K7LYPJQB/YJTZlHMgNudlsFZPw
Ir3dPYSXLdhhnkhowXQDO2yI+JIjiJdumhi3GzDegdv6YFMqvpeD0ZMFgcTheIPA
2LB/WqIphWEebsqx+g200+fcEQzncmznhT0h46BKdB0/tBtnSW/baVLDBb1dEtkU
01R2vjV//GV+qoyU7WrMrrZl2zWm5hm2UVxcRo7gKc791hKXUhL11F4KSR6mxd4J
cz/rLRzgWE5JSzALOSevLuPXLJOb9L1KW75c+p58Aug6FwgSVtA=
=m/d/
-----END PGP SIGNATURE-----

--Sig_/eMDPd5Br83l0AbWqfiiudJG--

--===============1772626679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1772626679==--
