From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove DRM_AMD_POWERPLAY
Date: Thu, 29 Sep 2016 10:13:14 +1000
Message-ID: <785320ed-54e1-ec48-c1f4-5088f52b015e@folklore1984.net>
References: <1475095354-2040-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0008226322=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1475095354-2040-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============0008226322==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D57Gc2RoLFtnOGRCSVu41jPU64c2GullD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D57Gc2RoLFtnOGRCSVu41jPU64c2GullD
Content-Type: multipart/mixed; boundary="5lIXKgsujjHob8VGVCIrfJg945flF3nRe";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <785320ed-54e1-ec48-c1f4-5088f52b015e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove DRM_AMD_POWERPLAY
References: <1475095354-2040-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1475095354-2040-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--5lIXKgsujjHob8VGVCIrfJg945flF3nRe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 09/29/2016 06:42 AM, Alex Deucher wrote:
> Powerplay is no longer optional after the recently cleanups
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig            |  1 -
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  4 ----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c | 13 +------------
>  drivers/gpu/drm/amd/powerplay/Kconfig         |  6 ------
>  5 files changed, 1 insertion(+), 25 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/powerplay/Kconfig
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/a=
mdgpu/Kconfig
> index 53cf397..61360e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -32,5 +32,4 @@ config DRM_AMDGPU_GART_DEBUGFS
>  	  Selecting this option creates a debugfs file to inspect the mapped
>  	  pages. Uses more memory for housekeeping, enable only for debugging=
=2E
> =20
> -source "drivers/gpu/drm/amd/powerplay/Kconfig"
>  source "drivers/gpu/drm/amd/acp/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> index 9ec262d..248a05d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -111,14 +111,10 @@ amdgpu-$(CONFIG_VGA_SWITCHEROO) +=3D amdgpu_atpx_=
handler.o
>  amdgpu-$(CONFIG_ACPI) +=3D amdgpu_acpi.o
>  amdgpu-$(CONFIG_MMU_NOTIFIER) +=3D amdgpu_mn.o
> =20
> -ifneq ($(CONFIG_DRM_AMD_POWERPLAY),)
> -
>  include $(FULL_AMD_PATH)/powerplay/Makefile
> =20
>  amdgpu-y +=3D $(AMD_POWERPLAY_FILES)
> =20
> -endif
> -
>  obj-$(CONFIG_DRM_AMDGPU)+=3D amdgpu.o
> =20
>  CFLAGS_amdgpu_trace_points.o :=3D -I$(src)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> index 28c6ea8..728e8ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -174,7 +174,6 @@ module_param_named(sched_jobs, amdgpu_sched_jobs, i=
nt, 0444);
>  MODULE_PARM_DESC(sched_hw_submission, "the max number of HW submission=
s (default 2)");
>  module_param_named(sched_hw_submission, amdgpu_sched_hw_submission, in=
t, 0444);
> =20
> -#ifdef CONFIG_DRM_AMD_POWERPLAY
>  MODULE_PARM_DESC(powerplay, "Powerplay component (1 =3D enable, 0 =3D =
disable, -1 =3D auto (default))");
>  module_param_named(powerplay, amdgpu_powerplay, int, 0444);
> =20
> @@ -183,7 +182,6 @@ module_param_named(powercontainment, amdgpu_powerco=
ntainment, int, 0444);
> =20
>  MODULE_PARM_DESC(ppfeaturemask, "all power features enabled (default))=
");
>  module_param_named(ppfeaturemask, amdgpu_pp_feature_mask, int, 0444);
> -#endif
> =20
>  MODULE_PARM_DESC(sclkdeepsleep, "SCLK Deep Sleep (1 =3D enable (defaul=
t), 0 =3D disable)");
>  module_param_named(sclkdeepsleep, amdgpu_sclk_deep_sleep_en, int, 0444=
);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_powerplay.c
> index 68ad241..7532ff8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c
> @@ -42,7 +42,6 @@ static int amdgpu_powerplay_init(struct amdgpu_device=
 *adev)
>  	amd_pp =3D &(adev->powerplay);
> =20
>  	if (adev->pp_enabled) {
> -#ifdef CONFIG_DRM_AMD_POWERPLAY
>  		struct amd_pp_init *pp_init;
> =20
>  		pp_init =3D kzalloc(sizeof(struct amd_pp_init), GFP_KERNEL);
> @@ -55,7 +54,6 @@ static int amdgpu_powerplay_init(struct amdgpu_device=
 *adev)
>  		pp_init->device =3D amdgpu_cgs_create_device(adev);
>  		ret =3D amd_powerplay_init(pp_init, amd_pp);
>  		kfree(pp_init);
> -#endif
>  	} else {
>  		amd_pp->pp_handle =3D (void *)adev;
> =20
> @@ -97,7 +95,6 @@ static int amdgpu_pp_early_init(void *handle)
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>  	int ret =3D 0;
> =20
> -#ifdef CONFIG_DRM_AMD_POWERPLAY
>  	switch (adev->asic_type) {
>  	case CHIP_POLARIS11:
>  	case CHIP_POLARIS10:
> @@ -120,9 +117,6 @@ static int amdgpu_pp_early_init(void *handle)
>  		adev->pp_enabled =3D false;
>  		break;
>  	}
> -#else
> -	adev->pp_enabled =3D false;
> -#endif
> =20
>  	ret =3D amdgpu_powerplay_init(adev);
>  	if (ret)
> @@ -144,12 +138,11 @@ static int amdgpu_pp_late_init(void *handle)
>  		ret =3D adev->powerplay.ip_funcs->late_init(
>  					adev->powerplay.pp_handle);
> =20
> -#ifdef CONFIG_DRM_AMD_POWERPLAY
>  	if (adev->pp_enabled && adev->pm.dpm_enabled) {
>  		amdgpu_pm_sysfs_init(adev);
>  		amdgpu_dpm_dispatch_task(adev, AMD_PP_EVENT_COMPLETE_INIT, NULL, NUL=
L);
>  	}
> -#endif
> +
>  	return ret;
>  }
> =20
> @@ -162,10 +155,8 @@ static int amdgpu_pp_sw_init(void *handle)
>  		ret =3D adev->powerplay.ip_funcs->sw_init(
>  					adev->powerplay.pp_handle);
> =20
> -#ifdef CONFIG_DRM_AMD_POWERPLAY
>  	if (adev->pp_enabled)
>  		adev->pm.dpm_enabled =3D true;
> -#endif
> =20
>  	return ret;
>  }
> @@ -216,7 +207,6 @@ static int amdgpu_pp_hw_fini(void *handle)
> =20
>  static void amdgpu_pp_late_fini(void *handle)
>  {
> -#ifdef CONFIG_DRM_AMD_POWERPLAY
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> =20
>  	if (adev->pp_enabled) {
> @@ -227,7 +217,6 @@ static void amdgpu_pp_late_fini(void *handle)
>  	if (adev->powerplay.ip_funcs->late_fini)
>  		adev->powerplay.ip_funcs->late_fini(
>  			  adev->powerplay.pp_handle);
> -#endif
>  }
> =20
>  static int amdgpu_pp_suspend(void *handle)
> diff --git a/drivers/gpu/drm/amd/powerplay/Kconfig b/drivers/gpu/drm/am=
d/powerplay/Kconfig
> deleted file mode 100644
> index af38033..0000000
> --- a/drivers/gpu/drm/amd/powerplay/Kconfig
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -config DRM_AMD_POWERPLAY
> -	bool  "Enable AMD powerplay component"
> -	depends on DRM_AMDGPU
> -	default n
> -	help
> -	  select this option will enable AMD powerplay component.
>=20


--5lIXKgsujjHob8VGVCIrfJg945flF3nRe--

--D57Gc2RoLFtnOGRCSVu41jPU64c2GullD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX7FyaAAoJEP4bvbfZuWjb/CwP/24MngfwJuTvL1BjvaUDBpKI
BLHzbukLr+6IOZ8h8/YR3meBDypXDzWiPbjQn6LeYDqIvrgUIsNQ4H4D2MptLj1z
m416jceI+QfTR5d5RksS6dli9nBeF4lGnivrX92IXJk1dF9dh/KWFepdE8NmUcPe
qSfvN/T/Lwnnm+Y5HDcS/8fClonertK42o62DzSayiU6Au9b+wAFLsx5ycov/ZxL
WG/hRHJE1pSLhfm8T5Db85uqm1WNyK4Az6jwsHspht/R7FI8kojS2n2v7ca2ahoD
v9eB7ZzbjfoxotMV4kl6yS3/CGAdW/7uFH2Q8rw+XhTnVZ2RGI6VrEKBkcK21TMl
6EcGsTTloKtElVi1cspDMPmyRr6NPsV8Hf9fqWpwD8FVCbTrHY5aRfrgN/CB9Bs8
DxEbEO936VFt6dvM9ligmZkiNlVL3a9xUTMoDdFZ5JVhQpVnFzJS1SJJaY6a5V27
KQGX2h4umiDWMZ+uMqcaCQNlXbqSQGDaysbXkFGmghX9J9fglywiQS/pwhjahd0r
ldaqw8rwtFgHUfREuEECNUHblTcmMKgtjZuwuEvmfN8bZEoepuvNV1BTc4ISy5bW
mOcTG4NejnP/zbE55YhGomYsLlAlB8tTlUXXwlleqdBseioaqBFXJT62EyTz+VES
FR3BUipT+1swFf1ASIty
=OTGn
-----END PGP SIGNATURE-----

--D57Gc2RoLFtnOGRCSVu41jPU64c2GullD--

--===============0008226322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0008226322==--
