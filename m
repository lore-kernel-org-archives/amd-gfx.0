From: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Fri, 21 Apr 2017 11:06:05 +0300
Message-ID: <20170421110605.1a255f44@eldfell>
References: <20170421075825.6307-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1072134364=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170421075825.6307-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============1072134364==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EPm_PO0l3PQr56drTIVeHE="; protocol="application/pgp-signature"

--Sig_/EPm_PO0l3PQr56drTIVeHE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Apr 2017 09:58:24 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> While working on graphics support for virtual machines on ppc64 (which
> exists in both little and big endian variants) I've figured the comments
> for various drm fourcc formats in the header file don't match reality.
>=20
> Comments says the RGB formats are little endian, but in practice they
> are native endian.  Look at the drm_mode_legacy_fb_format() helper.  It
> maps -- for example -- bpp/depth 32/24 to DRM_FORMAT_XRGB8888, no matter
> whenever the machine is little endian or big endian.  The users of this
> function (fbdev emulation, DRM_IOCTL_MODE_ADDFB) expect the framebuffer
> is native endian, not little endian.  Most userspace also operates on
> native endian only.
>=20
> So, go update the comments for all 16+24+32 bpp RGB formats.
>=20
> Leaving the yuv formats as-is.  I have no idea if and how those are used
> on bigendian machines.
>=20
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Ilia Mirkin <imirkin@alum.mit.edu>
> Cc: Michel D=C3=A4nzer <michel@daenzer.net>
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 82 +++++++++++++++++++++----------------=
------
>  1 file changed, 41 insertions(+), 41 deletions(-)

Hi,

just an idea - since we are not sure how the remaining formats are being
used, should those be marked somehow uncertain whether they are little
or native endian?

Otherwise the documentation will guide people to believe those are
certain, which OTOH might not be bad, because then it will make them
certain over time. Unless we would prefer everything to be native
endian?

This might be a chance to choose the endianess (native vs. little) for
all formats. Should we take it? Prefer native?


Thanks,
pq

--Sig_/EPm_PO0l3PQr56drTIVeHE=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlj5vW0ACgkQI1/ltBGq
qqdIyQ/8C7Ah0I9Lztc9lxRl7XwzdjBQFNtlugyDS1HrI8ZCZdiQALGSO8GcnlJF
VQh/7EnEf0zzz1R/u8Xfz/FBjglPi/E26IdPKEiQ802Mq2pQh/0XGmIrKLdPOzWC
V53rHtY9V6Vk3kGZ6jjQKarVRmSW1PQYWa/r3cy9KQnrVdV2finCMthM38XzPdYe
jr1uYJdjVLQC/WS7l7mboAECKF3w006GeIRjQRLQfaxNQutmTBBvrC2gNAJ1bxOj
7xl/Ukt8R4OGe9eAZjueothv+DehUY+es9qsV3/bzp4K1A01hkNUh0e9XtNb6/Dv
fyFokcEa8ZCY40NduXKwggC1EI+ye8W765roUAZvw1lhBd8TEC4qwyRUIRkjD/Yu
01iFuj54Odq18pkfjqmIopLTD3DyoHM4O+Wd1Hue87/LoFny/uH3Arf8klR0eVZH
2a2X4dUrRFy/pggOzX1AcI7hiHa8OAAeaGM1hcPVcIYgye/DWqDNsxDt2st8D4Lb
NziDEfxEVgeW0kHONKQyCF0twNAJ59QDDspTpKVpHrBjRDq+kgVDNFmKVvXx99tg
AHfu6RxnaafS1iOrHESgjt2uHsa6oAJSrV0PKphFQ/bNDfXyUiQmGjtZEReFWPpO
I1qjjvIbcayWluLKMOrWeo1UeoSvP+Dexh0tzsHPkLcQWUcpD0A=
=uWeD
-----END PGP SIGNATURE-----

--Sig_/EPm_PO0l3PQr56drTIVeHE=--

--===============1072134364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1072134364==--
