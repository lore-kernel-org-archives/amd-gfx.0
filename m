From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: add the interface of waiting multiple
 fences
Date: Wed, 19 Apr 2017 01:47:28 +1000
Message-ID: <025d8078-e9e7-a958-02f9-d221e26960b8@folklore1984.net>
References: <20170413144756.30734-1-nhaehnle@gmail.com>
 <20170413144756.30734-2-nhaehnle@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0578643686=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170413144756.30734-2-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>, "monk . liu" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0578643686==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CtRJ6fmHqKrduleHQJecenaEDN3qQCH0A"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CtRJ6fmHqKrduleHQJecenaEDN3qQCH0A
Content-Type: multipart/mixed; boundary="FRWiEe4bCMukE0wQUToqvks82qpQ9Lj1a";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "monk . liu" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>,
 =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
Message-ID: <025d8078-e9e7-a958-02f9-d221e26960b8-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: add the interface of waiting multiple
 fences
References: <20170413144756.30734-1-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <20170413144756.30734-2-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20170413144756.30734-2-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--FRWiEe4bCMukE0wQUToqvks82qpQ9Lj1a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 04/14/2017 12:47 AM, Nicolai H=C3=A4hnle wrote:
> From: Nicolai H=C3=A4hnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
>=20
> Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> [v2: allow returning the first signaled fence index]
> Signed-off-by: monk.liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> [v3:
>  - cleanup *status setting
>  - fix amdgpu symbols check]
> Signed-off-by: Nicolai H=C3=A4hnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org> (v1)
> Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org> (v1)
> ---
>  amdgpu/amdgpu-symbol-check |  1 +
>  amdgpu/amdgpu.h            | 23 ++++++++++++++
>  amdgpu/amdgpu_cs.c         | 74 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 98 insertions(+)
>=20
> diff --git a/amdgpu/amdgpu-symbol-check b/amdgpu/amdgpu-symbol-check
> index 4d1ae65..81ef9b4 100755
> --- a/amdgpu/amdgpu-symbol-check
> +++ b/amdgpu/amdgpu-symbol-check
> @@ -26,20 +26,21 @@ amdgpu_bo_va_op_raw
>  amdgpu_bo_wait_for_idle
>  amdgpu_create_bo_from_user_mem
>  amdgpu_cs_create_semaphore
>  amdgpu_cs_ctx_create
>  amdgpu_cs_ctx_free
>  amdgpu_cs_destroy_semaphore
>  amdgpu_cs_query_fence_status
>  amdgpu_cs_query_reset_state
>  amdgpu_cs_signal_semaphore
>  amdgpu_cs_submit
> +amdgpu_cs_wait_fences
>  amdgpu_cs_wait_semaphore
>  amdgpu_device_deinitialize
>  amdgpu_device_initialize
>  amdgpu_get_marketing_name
>  amdgpu_query_buffer_size_alignment
>  amdgpu_query_crtc_from_id
>  amdgpu_query_firmware_version
>  amdgpu_query_gds_info
>  amdgpu_query_gpu_info
>  amdgpu_query_heap_info
> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
> index 55884b2..fdea905 100644
> --- a/amdgpu/amdgpu.h
> +++ b/amdgpu/amdgpu.h
> @@ -900,20 +900,43 @@ int amdgpu_cs_submit(amdgpu_context_handle contex=
t,
>   *	 returned in the case if submission was completed or timeout error
>   *	 code.
>   *
>   * \sa amdgpu_cs_submit()
>  */
>  int amdgpu_cs_query_fence_status(struct amdgpu_cs_fence *fence,
>  				 uint64_t timeout_ns,
>  				 uint64_t flags,
>  				 uint32_t *expired);
> =20
> +/**
> + *  Wait for multiple fences
> + *
> + * \param   fences      - \c [in] The fence array to wait
> + * \param   fence_count - \c [in] The fence count
> + * \param   wait_all    - \c [in] If true, wait all fences to be signa=
led,
> + *                                otherwise, wait at least one fence
> + * \param   timeout_ns  - \c [in] The timeout to wait, in nanoseconds
> + * \param   status      - \c [out] '1' for signaled, '0' for timeout
> + * \param   first       - \c [out] the index of the first signaled fen=
ce from @fences
> + *
> + * \return  0 on success
> + *          <0 - Negative POSIX Error code
> + *
> + * \note    Currently it supports only one amdgpu_device. All fences c=
ome from
> + *          the same amdgpu_device with the same fd.
> +*/
> +int amdgpu_cs_wait_fences(struct amdgpu_cs_fence *fences,
> +			  uint32_t fence_count,
> +			  bool wait_all,
> +			  uint64_t timeout_ns,
> +			  uint32_t *status, uint32_t *first);
> +
>  /*
>   * Query / Info API
>   *
>  */
> =20
>  /**
>   * Query allocation size alignments
>   *
>   * UMD should query information about GPU VM MC size alignments requir=
ements
>   * to be able correctly choose required allocation size and implement
> diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
> index fb5b3a8..707e6d1 100644
> --- a/amdgpu/amdgpu_cs.c
> +++ b/amdgpu/amdgpu_cs.c
> @@ -436,20 +436,94 @@ int amdgpu_cs_query_fence_status(struct amdgpu_cs=
_fence *fence,
>  	r =3D amdgpu_ioctl_wait_cs(fence->context, fence->ip_type,
>  				fence->ip_instance, fence->ring,
>  			       	fence->fence, timeout_ns, flags, &busy);
> =20
>  	if (!r && !busy)
>  		*expired =3D true;
> =20
>  	return r;
>  }
> =20
> +static int amdgpu_ioctl_wait_fences(struct amdgpu_cs_fence *fences,
> +				    uint32_t fence_count,
> +				    bool wait_all,
> +				    uint64_t timeout_ns,
> +				    uint32_t *status,
> +				    uint32_t *first)
> +{
> +	struct drm_amdgpu_fence *drm_fences;
> +	amdgpu_device_handle dev =3D fences[0].context->dev;
> +	union drm_amdgpu_wait_fences args;
> +	int r;
> +	uint32_t i;
> +
> +	drm_fences =3D alloca(sizeof(struct drm_amdgpu_fence) * fence_count);=

> +	for (i =3D 0; i < fence_count; i++) {
> +		drm_fences[i].ctx_id =3D fences[i].context->id;
> +		drm_fences[i].ip_type =3D fences[i].ip_type;
> +		drm_fences[i].ip_instance =3D fences[i].ip_instance;
> +		drm_fences[i].ring =3D fences[i].ring;
> +		drm_fences[i].seq_no =3D fences[i].fence;
> +	}
> +
> +	memset(&args, 0, sizeof(args));
> +	args.in.fences =3D (uint64_t)(uintptr_t)drm_fences;
> +	args.in.fence_count =3D fence_count;
> +	args.in.wait_all =3D wait_all;
> +	args.in.timeout_ns =3D amdgpu_cs_calculate_timeout(timeout_ns);
> +
> +	r =3D drmIoctl(dev->fd, DRM_IOCTL_AMDGPU_WAIT_FENCES, &args);
> +	if (r)
> +		return -errno;

Hi Nicolai,

you will leak drm_fences here on the error branch.

> +
> +	*status =3D args.out.status;
> +
> +	if (first)
> +		*first =3D args.out.first_signaled;
> +
> +	return 0;
> +}
> +
> +int amdgpu_cs_wait_fences(struct amdgpu_cs_fence *fences,
> +			  uint32_t fence_count,
> +			  bool wait_all,
> +			  uint64_t timeout_ns,
> +			  uint32_t *status,
> +			  uint32_t *first)
> +{
> +	uint32_t i;
> +	int r;

no need for a intermediate ret, just return amdgpu_ioctl_wait_fences()
directly?

> +
> +	/* Sanity check */
> +	if (NULL =3D=3D fences)
> +		return -EINVAL;
> +	if (NULL =3D=3D status)
> +		return -EINVAL;
> +	if (fence_count <=3D 0)
> +		return -EINVAL;

may as well combine these branches?

if (!fences || !status || !fence_count)
	return -EINVAL;

as fence_count is unsigned.

Kind Regards,
Edward.

> +	for (i =3D 0; i < fence_count; i++) {
> +		if (NULL =3D=3D fences[i].context)
> +			return -EINVAL;
> +		if (fences[i].ip_type >=3D AMDGPU_HW_IP_NUM)
> +			return -EINVAL;
> +		if (fences[i].ring >=3D AMDGPU_CS_MAX_RINGS)
> +			return -EINVAL;
> +	}
> +
> +	*status =3D 0;
> +
> +	r =3D amdgpu_ioctl_wait_fences(fences, fence_count, wait_all, timeout=
_ns,
> +				     status, first);
> +
> +	return r;
> +}
> +
>  int amdgpu_cs_create_semaphore(amdgpu_semaphore_handle *sem)
>  {
>  	struct amdgpu_semaphore *gpu_semaphore;
> =20
>  	if (NULL =3D=3D sem)
>  		return -EINVAL;
> =20
>  	gpu_semaphore =3D calloc(1, sizeof(struct amdgpu_semaphore));
>  	if (NULL =3D=3D gpu_semaphore)
>  		return -ENOMEM;
>=20


--FRWiEe4bCMukE0wQUToqvks82qpQ9Lj1a--

--CtRJ6fmHqKrduleHQJecenaEDN3qQCH0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9jUQAAoJEP4bvbfZuWjbmg0P/35RHQw9bAnUSp1Qhfti0t5x
TWe0in1IHhPwJ/OdC2zOADXtIeJxsLPjXOsa7Oinrgy4zQWcaRV420tyFEkN2fiK
p74QpRg1avdg4Y4i3SCPyc1Dioh1Rdis3Zih4kwq2hk1ZomJebVfrbGltETkswQb
qeq0yyWXpePAPtIdOGCf44+Ih6xTgHb7W4J5J/NzAZckXuBLsa0d7JhJTfVW6Buh
qI+N3PSe2aUI8Oi+NEzJLOu3xsOnzRXRZBl0L7j4Go6OoihvN83X9vyk7Wxc2DVK
8peK7AS+R6ovOTZ2XvQqw7XFEvBVFmNZbPcG5VsjgTLLlVjN28AuzS+Q3kGnJDE8
jCVhhWt50xmgnPZIKFIiS9qvfLMaJ/AROun2xV3yf8jYEGLR9XfJK9vcZej7b+PK
QjShC2fTrW0+CF5C11WomapTjiN7HMQKkMVusWHismBmX/RIVxzuidDirnPn5t3k
DQz+ed/7gNHzOxS8J+kueV5J2IzE0ccAUJ1uYV+yoToSio5KG4hMgEhW5LHrFG7f
O7m4PsI4KYeoLYSYVGylTex15zAQOOQfcRtDwhufXiTRbmFMyvceD+wSU4zg3VPT
9r24sUmAbm966jlQZFKIClpLDwU+hMPQIXQXWw1w7f3eLybe/XGW/2fIf2zARRGP
zE1wfwoDkgwp+20PZ7hL
=H+JX
-----END PGP SIGNATURE-----

--CtRJ6fmHqKrduleHQJecenaEDN3qQCH0A--

--===============0578643686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0578643686==--
