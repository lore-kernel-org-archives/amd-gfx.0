From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu:fix virtual dce bug
Date: Thu, 16 Nov 2017 11:40:14 -0500
Message-ID: <1510850414.3218.161.camel@rutgers.edu>
References: <1510802063-20869-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0094774804=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1510802063-20869-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org


--===============0094774804==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-pGqXS83r3kAC/qH2yZ2m"


--=-pGqXS83r3kAC/qH2yZ2m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-11-16 at 11:14 +0800, Monk Liu wrote:
> this fix the issue that access memory after freed
> after driver unloaded.

can you please change the patch subject and commit message to something
more descriptive?

Jan

>=20
> Change-Id: I64e2488c18f5dc044b57c74567785da21fc028da
> Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/a=
md/amdgpu/dce_virtual.c
> index a8829af..39460eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -437,6 +437,8 @@ static int dce_virtual_sw_fini(void *handle)
>  	drm_kms_helper_poll_fini(adev->ddev);
> =20
>  	drm_mode_config_cleanup(adev->ddev);
> +	/* clear crtcs pointer to avoid dce irq finish routine access freed dat=
a */
> +	memset(adev->mode_info.crtcs, 0, sizeof(adev->mode_info.crtcs[0]) * AMD=
GPU_MAX_CRTCS);
>  	adev->mode_info.mode_config_initialized =3D false;
>  	return 0;
>  }
> @@ -723,7 +725,7 @@ static void dce_virtual_set_crtc_vblank_interrupt_sta=
te(struct amdgpu_device *ad
>  							int crtc,
>  							enum amdgpu_interrupt_state state)
>  {
> -	if (crtc >=3D adev->mode_info.num_crtc) {
> +	if (crtc >=3D adev->mode_info.num_crtc || !adev->mode_info.crtcs[crtc])=
 {
>  		DRM_DEBUG("invalid crtc %d\n", crtc);
>  		return;
>  	}

--=-pGqXS83r3kAC/qH2yZ2m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjGgSoFJq63cCYGKvY+M/tz9IsiAFAloNv24ACgkQY+M/tz9I
siBT5hAAzdl8JFO9vN1PHseCarvwfExstqDy4NjdXCtfKYA6QdU9qz/GlK8/i0fe
u0UhB+h4GFjEuO1cADyQxbGgxDy569OdahqSb1YXUYL+xivfHVnVezZRaTgS3nZK
JTxKoGISsLOCw5QETM7/X4GwcGk2L2dTLHMSnSW89fFlCvgiDg1Oz8YaC7RGuPh8
gMkKY0VdQk5FYCE0AXLPB43umwRqfzoO6FkehWKocqYCu4PZoibULvsQ80x2zQA4
1fn25S4A45RbM6YrA64ciV1isoohpN+GE4PNX11yRVnc4GxWRDhFUBcHmxsse9in
xBoAu+yrzMJGpqujdCke6/3jK50jR06NmRS5+S0tBi0b5dkvYYsDgDBXK+UOnL67
rieF+dsy/tzfxbBJ5e0Kf5Ms3as6LuNWBrZq5uoCLLOvsO2HfHzVJU0uylvngzjY
ypwKqbmip7lSmn8d6KCP460VNhgIXFzaklN5QtHBrwlzCiv1D104lnFx9S8ucBN9
K+rzwXyiOJQNs5vbKGuOqwq3R3yqD359rTWGpwdUTIFMx9wuRYGfD6wHHM5QJtgX
j0mdETQCHsF/fY8K7o4kHimz2VMcHnGLThyGA3WNK33NJqHMF3pEicnlTp5RkhRK
VmWeMLwWAi6fR5H73ljvTMW66I2FmfnbYc0kRSYUKBDgIbZr5EM=
=ynGk
-----END PGP SIGNATURE-----

--=-pGqXS83r3kAC/qH2yZ2m--


--===============0094774804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0094774804==--
