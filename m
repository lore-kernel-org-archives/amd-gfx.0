From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: export gfx capability by gpu info
Date: Thu, 16 Feb 2017 15:37:39 +1100
Message-ID: <2ee3024b-cd44-9fd6-62f7-fb8117dd2e74@folklore1984.net>
References: <1487213588-26299-1-git-send-email-Jerry.Zhang@amd.com>
 <1487213588-26299-2-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0002676982=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1487213588-26299-2-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0002676982==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m2eSeMF0NAFSHrGDtmQR9kfr09D0jSsma"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m2eSeMF0NAFSHrGDtmQR9kfr09D0jSsma
Content-Type: multipart/mixed; boundary="GjWonWxtmx7vNXxcKLW3CmEl0v1vwvKJ0";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <2ee3024b-cd44-9fd6-62f7-fb8117dd2e74-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: export gfx capability by gpu info
References: <1487213588-26299-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
 <1487213588-26299-2-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1487213588-26299-2-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

--GjWonWxtmx7vNXxcKLW3CmEl0v1vwvKJ0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Question, is this a bit premature to have a new function and struct for
this, could it just be put in amdgpu_gfx for now or are we expecting
amdgpu_gfx_cap to start growing quickly with far more cap state info?

Kind Regards,
Edward.

On 02/16/2017 01:53 PM, Junwei Zhang wrote:
> Change-Id: Ibf3e4dbb7deb83271adabc275c9b7a0e0652541a
> Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 14 ++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           |  1 +
>  6 files changed, 35 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 1ad3f08..cdc2b2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -869,6 +869,10 @@ struct amdgpu_gfx_funcs {
>  	void (*read_wave_sgprs)(struct amdgpu_device *adev, uint32_t simd, ui=
nt32_t wave, uint32_t start, uint32_t size, uint32_t *dst);
>  };
> =20
> +struct amdgpu_gfx_cap {
> +	uint32_t gc_double_offchip_lds_buf;
> +};
> +
>  struct amdgpu_gfx {
>  	struct mutex			gpu_clock_mutex;
>  	struct amdgpu_gca_config	config;
> @@ -911,6 +915,8 @@ struct amdgpu_gfx {
>  	/* reset mask */
>  	uint32_t                        grbm_soft_reset;
>  	uint32_t                        srbm_soft_reset;
> +
> +	struct amdgpu_gfx_cap		cap;
>  };
> =20
>  int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> index 7f59608..e7aa382 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -618,6 +618,8 @@ static int amdgpu_info_ioctl(struct drm_device *dev=
, void *data, struct drm_file
>  			cap.flag |=3D AMDGPU_CAPABILITY_DIRECT_GMA_FLAG;
>  			cap.direct_gma_size =3D amdgpu_direct_gma_size;
>  		}
> +		cap.gc_double_offchip_lds_buf =3D
> +			adev->gfx.cap.gc_double_offchip_lds_buf;
>  		return copy_to_user(out, &cap,
>  				    min((size_t)size, sizeof(cap))) ? -EFAULT : 0;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c
> index ce75d46..a1e221b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1534,6 +1534,11 @@ static void gfx_v6_0_setup_spi(struct amdgpu_dev=
ice *adev,
>  	mutex_unlock(&adev->grbm_idx_mutex);
>  }
> =20
> +static void gfx_v6_0_cap_init(struct amdgpu_device *adev)
> +{
> +	adev->gfx.cap.gc_double_offchip_lds_buf =3D 1;
> +}
> +
>  static void gfx_v6_0_gpu_init(struct amdgpu_device *adev)
>  {
>  	u32 gb_addr_config =3D 0;
> @@ -1692,6 +1697,7 @@ static void gfx_v6_0_gpu_init(struct amdgpu_devic=
e *adev)
>  		     adev->gfx.config.max_cu_per_sh);
> =20
>  	gfx_v6_0_get_cu_info(adev);
> +	gfx_v6_0_cap_init(adev);
> =20
>  	WREG32(mmCP_QUEUE_THRESHOLDS, ((0x16 << CP_QUEUE_THRESHOLDS__ROQ_IB1_=
START__SHIFT) |
>  				       (0x2b << CP_QUEUE_THRESHOLDS__ROQ_IB2_START__SHIFT)));
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c
> index aaf66fe..e1e97ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -1876,6 +1876,11 @@ static void gmc_v7_0_init_compute_vmid(struct am=
dgpu_device *adev)
>  	mutex_unlock(&adev->srbm_mutex);
>  }
> =20
> +static void gfx_v7_0_cap_init(struct amdgpu_device *adev)
> +{
> +	adev->gfx.cap.gc_double_offchip_lds_buf =3D 1;
> +}
> +
>  /**
>   * gfx_v7_0_gpu_init - setup the 3D engine
>   *
> @@ -1900,6 +1905,7 @@ static void gfx_v7_0_gpu_init(struct amdgpu_devic=
e *adev)
> =20
>  	gfx_v7_0_setup_rb(adev);
>  	gfx_v7_0_get_cu_info(adev);
> +	gfx_v7_0_cap_init(adev);
> =20
>  	/* set HW defaults for 3D engine */
>  	WREG32(mmCP_MEQ_THRESHOLDS,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> index ce05e38..934fc71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -3826,6 +3826,19 @@ static void gfx_v8_0_init_compute_vmid(struct am=
dgpu_device *adev)
>  	mutex_unlock(&adev->srbm_mutex);
>  }
> =20
> +static void gfx_v8_0_cap_init(struct amdgpu_device *adev)
> +{
> +	switch (adev->asic_type) {
> +	default:
> +		adev->gfx.cap.gc_double_offchip_lds_buf =3D 1;
> +		break;
> +	case CHIP_CARRIZO:
> +	case CHIP_STONEY:
> +		adev->gfx.cap.gc_double_offchip_lds_buf =3D 0;
> +		break;
> +	}
> +}
> +
>  static void gfx_v8_0_gpu_init(struct amdgpu_device *adev)
>  {
>  	u32 tmp, sh_static_mem_cfg;
> @@ -3839,6 +3852,7 @@ static void gfx_v8_0_gpu_init(struct amdgpu_devic=
e *adev)
>  	gfx_v8_0_tiling_mode_table_init(adev);
>  	gfx_v8_0_setup_rb(adev);
>  	gfx_v8_0_get_cu_info(adev);
> +	gfx_v8_0_cap_init(adev);
> =20
>  	/* XXX SH_MEM regs */
>  	/* where to put LDS, scratch, GPUVM in FSA64 space */
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> index 04daab3..7064fdc 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -853,6 +853,7 @@ struct drm_amdgpu_virtual_range {
>  struct drm_amdgpu_capability {
>  	__u32 flag;
>  	__u32 direct_gma_size;
> +	__u32 gc_double_offchip_lds_buf;
>  };
> =20
>  /*
>=20


--GjWonWxtmx7vNXxcKLW3CmEl0v1vwvKJ0--

--m2eSeMF0NAFSHrGDtmQR9kfr09D0jSsma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYpSyXAAoJEP4bvbfZuWjbrbUQAJOm6SJi5+X3uBXP/Q1n2gOz
sE3XTwzP9IIQTxczXCXEoRiKsNnZ8aWxJqmxkZ1YevWMRpik+MOIWNsoQCtuaYu9
KWtNiVpeNqCxcl40u2i3iUzNzzj7tJ6oKqk0/Ab+63mZogJxGchBb1pzU0Wizqui
+Ou8KbhgZkfnrJ8yta2xrMEgAgsxzQqrwfY9amfNxP2EoIGcteLlB9/uwFlyk9Ju
Iksgffhgb6oKuFAb4OSyjnPGMdHXhcVKRQBTXlgmSb4Awv4ciL4TytAXIJtMa75x
Ro2oRcxzxDb17HTV9rj80rxmukR9mdXLjrDQxJ/Jgrr76OqFvOXa1s2UyTCLmvzX
/bCLCjRb9tfevGU5SRosNoAoYFO+sm7MWTMjZUFugd11ov+lCPctFkATrtOmL3yR
8uwDyPnNO4K8Ajr6qYoDRwtxgC/mm9UAzhZx98xSP73TDOVq5rrEFKxepzcqTY8q
B7vyUUThz/bYa4OCcmqZkVNbMCVUCbfT3gBV8+FOs5yit8VNnDdKkwXXPsPYGWVT
DYCiVZXsaBUqnpxiO+33UhgnhHIVkXlHeTpW/Et3UJUi+UMSWdKpKi+8gGvHgVUj
JhUnHwjX7v1sjMHdvcsZ9nmniO0oucKhhAUuQyeJhA+QRZSBXxnXH703oZvTiBmK
b4M/b36gGw701OJzwdE/
=tLBY
-----END PGP SIGNATURE-----

--m2eSeMF0NAFSHrGDtmQR9kfr09D0jSsma--

--===============0002676982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0002676982==--
