From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/radeon: handle runtime pm in fbcon (v2)
Date: Sat, 3 Sep 2016 15:07:52 +1000
Message-ID: <19ade2e9-3fd5-a614-6ec8-a07147444ab1@folklore1984.net>
References: <1472829513-4539-1-git-send-email-alexander.deucher@amd.com>
 <1472829513-4539-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2103268018=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472829513-4539-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2103268018==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KC2vGV5o9s3PuDA5F0DTr1ixTT1QQ3pSF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KC2vGV5o9s3PuDA5F0DTr1ixTT1QQ3pSF
Content-Type: multipart/mixed; boundary="D7AnlD9qlILAWf3cLTVvNhwfbQk41XWdD";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <19ade2e9-3fd5-a614-6ec8-a07147444ab1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/radeon: handle runtime pm in fbcon (v2)
References: <1472829513-4539-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
 <1472829513-4539-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1472829513-4539-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--D7AnlD9qlILAWf3cLTVvNhwfbQk41XWdD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/03/2016 01:18 AM, Alex Deucher wrote:
> Ported from nouveau.
>=20
> v2: re-enable runtime autosuspend in the error case
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/radeon/radeon_fb.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeo=
n/radeon_fb.c
> index 0e3143a..6b2537d 100644
> --- a/drivers/gpu/drm/radeon/radeon_fb.c
> +++ b/drivers/gpu/drm/radeon/radeon_fb.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/fb.h>
> +#include <linux/pm_runtime.h>
> =20
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
> @@ -47,8 +48,35 @@ struct radeon_fbdev {
>  	struct radeon_device *rdev;
>  };
> =20
> +static int
> +radeonfb_open(struct fb_info *info, int user)
> +{
> +	struct radeon_fbdev *rfbdev =3D info->par;
> +	struct radeon_device *rdev =3D rfbdev->rdev;
> +	int ret =3D pm_runtime_get_sync(rdev->ddev->dev);
> +	if (ret < 0 && ret !=3D -EACCES) {
> +		pm_runtime_mark_last_busy(rdev->ddev->dev);
> +		pm_runtime_put_autosuspend(rdev->ddev->dev);
> +		return ret;
> +	}
> +	return 0;

Hi Alex,

Minor question - in the case of (ret =3D=3D -EACCES) is that still regard=
ed
as successful in the context of radeonfb_open()'s call?

If it indeed is then,

Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

Thanks for your time,
Edward.

> +}
> +
> +static int
> +radeonfb_release(struct fb_info *info, int user)
> +{
> +	struct radeon_fbdev *rfbdev =3D info->par;
> +	struct radeon_device *rdev =3D rfbdev->rdev;
> +
> +	pm_runtime_mark_last_busy(rdev->ddev->dev);
> +	pm_runtime_put_autosuspend(rdev->ddev->dev);
> +	return 0;
> +}
> +
>  static struct fb_ops radeonfb_ops =3D {
>  	.owner =3D THIS_MODULE,
> +	.fb_open =3D radeonfb_open,
> +	.fb_release =3D radeonfb_release,
>  	.fb_check_var =3D drm_fb_helper_check_var,
>  	.fb_set_par =3D drm_fb_helper_set_par,
>  	.fb_fillrect =3D drm_fb_helper_cfb_fillrect,
>=20


--D7AnlD9qlILAWf3cLTVvNhwfbQk41XWdD--

--KC2vGV5o9s3PuDA5F0DTr1ixTT1QQ3pSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXylqoAAoJEP4bvbfZuWjbvUYP/0aNfjiiqK4ccWRzpQbdmiZv
xD7XDnmrcxYbWYIzdVAySP3QiLOi9kBDaIyS9+JD1dVlg/jQnmg84WJ6KA4slGKu
wFMKa/Jl34lOrcwaBZxouf4HEyhNd/2+s85DLwsI3JTsAFMnmHR17PctDKkpOS5k
dpuO65vqev4gk9c89gCH56n8H5s7RXGRM8PNrKmRe2UYQDDMnrrn7yYE5/8xfRMx
ZwKI/1eI8YqZPIrAH8zLQwYk5QlJI+TV4ZZdIikijG+VGCM99SyaZGMRgFuPOkZk
co2E9/r2LmBfugkx4+Fg3gbRt+d8YT+gLhjBZaUkL9h6s2aTTjUmHoL/B3O5HKKH
G1itQYAkFnrCmKGqBH7jHg9iB8pBZuLe4aWN4831XznTi0TCogK/YbFsTVbJKfJr
z1meAyPX+ykdccU9DF9sY7H2SdRauyUfUWc2riiaUufLF/dhR/nx8+/6e+1iaWDW
gKiTy0su787gwwwjDqUVxIp/ecJwEhi3C8TFbQTApP8xql5GEtPp8mKrYxmUtNud
+mDD+waS3S2BEpjN/QA6zx/bnnh1s7/JZeISh61ebMKNPmo5mnDsBRIKuiGUis/K
if76nIM7ntc4WxzsXLQhv2hi2qw/8ce11R8NnMbVduUZj97iAbUCBSUDh9j5qpw2
6O4P9GH5YE7VFwiGiH03
=XDqq
-----END PGP SIGNATURE-----

--KC2vGV5o9s3PuDA5F0DTr1ixTT1QQ3pSF--

--===============2103268018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2103268018==--
