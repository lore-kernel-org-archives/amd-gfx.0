From: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Mon, 10 Apr 2017 16:12:14 +0300
Message-ID: <20170410161214.305f5daf@eldfell>
References: <20170410101202.19229-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0098430354=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170410101202.19229-1-kraxel@redhat.com>
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
Cc: Daniel Vetter <daniel.vetter@intel.com>, amd-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

--===============0098430354==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9jdcclavL1zJmOW8lVvMsJf"; protocol="application/pgp-signature"

--Sig_/9jdcclavL1zJmOW8lVvMsJf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Apr 2017 12:12:01 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Ok, this is really a kickstart for a discussion.  While working on
> graphics support for virtual machines on ppc64 (which exists in both
> little and big endian variants) I've figured the comments in the header
> file don't match reality.  They are not considered little endian (as
> suggested by the comments) but in practice are used as native endian.
>=20
> So, go update the comments.
>=20
> This patch switches all 32bpp / 8 bpc formats over to native endian.
> Those used/supported by ppc64 virtual machines (virtio-gpu/bochs-drm
> drivers).
>=20
> Given that DRM_FORMAT_BIG_ENDIAN isn't used anywhere in the codebase
> I suspect this problem applies to more formats.  When looking at
> drm_mode_legacy_fb_format it seems *all* RGB formats are actually
> native endian not little endian.
>=20
> Dunno where we stand in terms of YCbCr.
>=20
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Hi,

which software have you used as representative of "reality"?

I worry is that there is potential to have endianess bugs in every
layer of the graphics stack: driver, Mesa, display servers,
compositors, toolkits, and applications. What's worse, two wrongs might
sometimes make a right - incorrectly swapping twice gives you what you
expected in the first place.

We just had a detailed review to get a new pixel format
definitions list in Weston right for LE vs. BE and Pixman vs. DRM vs.
OpenGL. We took the DRM definition literally to be always described in
LE regardless of machine endianess:
https://cgit.freedesktop.org/wayland/weston/commit/?id=3D903721a6215f474787=
b5daf02761fbcb1d3a0bb5

We also have this fun problem in Wayland:
https://lists.freedesktop.org/archives/wayland-devel/2017-March/033492.html

To solve that problem, we would like to know if anything existing would
break for each possible solution, but no developers using BE have really
turned up.

We have known for a long time that at least Weston is likely broken on
BE wrt. pixel formats.

We also have a bug for Mesa EGL/Wayland:
https://bugs.freedesktop.org/show_bug.cgi?id=3D99638

> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 995c8f9..a7fc81d 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -85,15 +85,15 @@ extern "C" {
>  #define DRM_FORMAT_BGR888	fourcc_code('B', 'G', '2', '4') /* [23:0] B:G:=
R little endian */
> =20
>  /* 32 bpp RGB */
> -#define DRM_FORMAT_XRGB8888	fourcc_code('X', 'R', '2', '4') /* [31:0] x:=
R:G:B 8:8:8:8 little endian */
> -#define DRM_FORMAT_XBGR8888	fourcc_code('X', 'B', '2', '4') /* [31:0] x:=
B:G:R 8:8:8:8 little endian */
> -#define DRM_FORMAT_RGBX8888	fourcc_code('R', 'X', '2', '4') /* [31:0] R:=
G:B:x 8:8:8:8 little endian */
> -#define DRM_FORMAT_BGRX8888	fourcc_code('B', 'X', '2', '4') /* [31:0] B:=
G:R:x 8:8:8:8 little endian */
> +#define DRM_FORMAT_XRGB8888	fourcc_code('X', 'R', '2', '4') /* [31:0] x:=
R:G:B 8:8:8:8 native endian */
> +#define DRM_FORMAT_XBGR8888	fourcc_code('X', 'B', '2', '4') /* [31:0] x:=
B:G:R 8:8:8:8 native endian */
> +#define DRM_FORMAT_RGBX8888	fourcc_code('R', 'X', '2', '4') /* [31:0] R:=
G:B:x 8:8:8:8 native endian */
> +#define DRM_FORMAT_BGRX8888	fourcc_code('B', 'X', '2', '4') /* [31:0] B:=
G:R:x 8:8:8:8 native endian */
> =20
> -#define DRM_FORMAT_ARGB8888	fourcc_code('A', 'R', '2', '4') /* [31:0] A:=
R:G:B 8:8:8:8 little endian */
> -#define DRM_FORMAT_ABGR8888	fourcc_code('A', 'B', '2', '4') /* [31:0] A:=
B:G:R 8:8:8:8 little endian */
> -#define DRM_FORMAT_RGBA8888	fourcc_code('R', 'A', '2', '4') /* [31:0] R:=
G:B:A 8:8:8:8 little endian */
> -#define DRM_FORMAT_BGRA8888	fourcc_code('B', 'A', '2', '4') /* [31:0] B:=
G:R:A 8:8:8:8 little endian */
> +#define DRM_FORMAT_ARGB8888	fourcc_code('A', 'R', '2', '4') /* [31:0] A:=
R:G:B 8:8:8:8 native endian */
> +#define DRM_FORMAT_ABGR8888	fourcc_code('A', 'B', '2', '4') /* [31:0] A:=
B:G:R 8:8:8:8 native endian */
> +#define DRM_FORMAT_RGBA8888	fourcc_code('R', 'A', '2', '4') /* [31:0] R:=
G:B:A 8:8:8:8 native endian */
> +#define DRM_FORMAT_BGRA8888	fourcc_code('B', 'A', '2', '4') /* [31:0] B:=
G:R:A 8:8:8:8 native endian */
> =20
>  #define DRM_FORMAT_XRGB2101010	fourcc_code('X', 'R', '3', '0') /* [31:0]=
 x:R:G:B 2:10:10:10 little endian */
>  #define DRM_FORMAT_XBGR2101010	fourcc_code('X', 'B', '3', '0') /* [31:0]=
 x:B:G:R 2:10:10:10 little endian */

These format definitions are directly referenced by Wayland protocol
extension for dmabufs and Mesa (wl_drm), and they have been copied into
the Wayland core protocol for wl_shm. Changing their definition would
be... awkward.


Thanks,
pq

--Sig_/9jdcclavL1zJmOW8lVvMsJf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAljrhK4ACgkQI1/ltBGq
qqcb9RAAkRA8w847/fsE/Z3JmYR0e11J9lC8of+132+EYBZf1i9xneNBilcOp027
D92Cf7C9+4v6uhLKzYYlQrYnDmgDZv1qRcsxDXhaBL3WE2hHyqaILtwlKqxQ8SQS
CUFokrOcFxM5vuTVyymhAdPC8XwayCAg4vrt8ejxOfsMvdpBpWbihJRIkzTeSh//
JkNH1vfqgJ4ksf9+t7VKHeSQz54uCJhrASYCvlO4rh5E2xXD4yZ2jKKVAxo0wTvV
ufQlUMizbzxySdybfsXTapdi6/b9p5w5TGD9ok3/Jh4X0MFpgrAHozNfaA0tdbrN
BAvnZvT69d07AZhPS+KLzMKUgT2tGohTEX6aSGV2De+NQO+BvsP17k05PlWI2dn0
sRjMv049Ng66enRtim9UPhEqm9+foNJuvuaif9kQzgrHvAITso7UVBuWD4l6KpWc
s5WzkQrz+5xPD8c4Zm5WIeoKqjMbu6Pua4xgCaR5+2/GGRxdz0G3Lp82/jRos8Ym
fXR+8mi3ljjngMlGwXLkxCMk3XOZ3aYd09fhOCxkM03ZHZJfJj4pu+DBiLagZ+fX
qsXjdwkA8nl0VW3Wcu33VVW1LdZkTPx88ZJIRjh29y4Ye9R6q02hNu3i1TwMstvU
CGtaJJ7bGq/B1CtCSCibLdQQRrnI1uwVhqN19z8dbK/otlDoZ3s=
=VjC6
-----END PGP SIGNATURE-----

--Sig_/9jdcclavL1zJmOW8lVvMsJf--

--===============0098430354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0098430354==--
