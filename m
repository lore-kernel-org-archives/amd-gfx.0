From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: clear framebuffer with GPU
Date: Wed, 8 Feb 2017 15:01:06 +1100
Message-ID: <0b080624-7d4b-0aeb-1049-2c3637d66f64@folklore1984.net>
References: <1486517097-22328-1-git-send-email-Pixel.Ding@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1475018443=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1486517097-22328-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
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
To: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, Christian.Koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1475018443==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NS47aXFQMgJjXtu7defwNvUhcqfaGJWhO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NS47aXFQMgJjXtu7defwNvUhcqfaGJWhO
Content-Type: multipart/mixed; boundary="XVkDWoHoLuQ8wrdqCDG4iFN6Eu8QAbgPa";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, Christian.Koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <0b080624-7d4b-0aeb-1049-2c3637d66f64-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: clear framebuffer with GPU
References: <1486517097-22328-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1486517097-22328-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>

--XVkDWoHoLuQ8wrdqCDG4iFN6Eu8QAbgPa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/08/2017 12:24 PM, Pixel Ding wrote:
> CPU is not efficient to do this job. There's a failure caused by this
> is that handshaking gets timeout of SRIOV virtual function.
Can you fixup the commit message a little but otherwise,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

>=20
> Signed-off-by: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fb.c
> index 1e735c4..2867f55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -148,7 +148,8 @@ static int amdgpufb_create_pinned_object(struct amd=
gpu_fbdev *rfbdev,
>  	ret =3D amdgpu_gem_object_create(adev, aligned_size, 0,
>  				       AMDGPU_GEM_DOMAIN_VRAM,
>  				       AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -				       AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
> +				       AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> +				       AMDGPU_GEM_CREATE_VRAM_CLEARED,
>  				       true, &gobj);
>  	if (ret) {
>  		printk(KERN_ERR "failed to allocate framebuffer (%d)\n",
> @@ -242,8 +243,6 @@ static int amdgpufb_create(struct drm_fb_helper *he=
lper,
>  	/* setup helper */
>  	rfbdev->helper.fb =3D fb;
> =20
> -	memset_io(abo->kptr, 0x0, amdgpu_bo_size(abo));
> -
>  	strcpy(info->fix.id, "amdgpudrmfb");
> =20
>  	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->depth);
>=20


--XVkDWoHoLuQ8wrdqCDG4iFN6Eu8QAbgPa--

--NS47aXFQMgJjXtu7defwNvUhcqfaGJWhO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYmpgGAAoJEP4bvbfZuWjbFbQQAMlnBFCGWb6THde9QEmGYvRJ
Ay4YO3f4nzcMLDP0nF5uCK4ym6hCV7GEup/GnEYFIuSkCDnMPTMTSpGVy99cOTwv
R/JwA+dFxTLpdwXnZiMO70JO5gHInYX2anS1LAhYFOxrwEThyJqVSOD0YT/7gnjk
iTmZTRWXuXBS/5Ph+FfcWoiBN2BERFCjhjDETiETJGxCIgwQjgYs0pxODhWoAbea
v/K1Uh6AdjpSXOWrBUwVCjQMxlZ6820HjACteZaHgwtDofce+2VnSpfPvPHkBAWT
2+NDMNhkwJz4qRuW4r4DJhDwp4+gm3Qtpi1pNZUCmanPdXjQR3tL9N814QfSRTIw
tAZXfNw5I0Dse1OXYfnyePQPdRqHmcQdEaneGXsZESU07KZ9kuzSzgPpUtA80dhm
LtnxtLIiGZ28IMHZu7yZHxcIho9e5NxvMUx02uuZgzmZK5pyIAEllUJTbUYlJqhA
OoEFmLCTUawOZOlWmwV6mxBVSgC44ZMBSKdvMJALia2BBzxX4/u/iuWMsh5EjanZ
+wD0S6Q6xUXYawxoptfdPI5PSv9Kes3p5Zw4rhz4Fb32iXxr1/4CTtKDoH0QYtFu
KRYBkpiAL0HmWuIRgvNNVZjiorZQDjw8AOQw68ge45GypVqBRflHrk22cdYFf346
iwmdt4MjdoYt0AgxrzWh
=wwkZ
-----END PGP SIGNATURE-----

--NS47aXFQMgJjXtu7defwNvUhcqfaGJWhO--

--===============1475018443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1475018443==--
