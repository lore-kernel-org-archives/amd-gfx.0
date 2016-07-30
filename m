From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 01/11] drm/amdgpu: hw ring should be empty when gpu reset
Date: Sat, 30 Jul 2016 13:53:01 +1000
Message-ID: <3f22b390-32fd-2018-b8f3-1a2586534996@folklore1984.net>
References: <1469700828-25650-1-git-send-email-David1.Zhou@amd.com>
 <1469700828-25650-2-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0387918224=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469700828-25650-2-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0387918224==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4HsUuqwANDFAMalLCcaJIuEjH2ttebpNJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4HsUuqwANDFAMalLCcaJIuEjH2ttebpNJ
Content-Type: multipart/mixed; boundary="kTnpPdVWIvAidmgNpXgtxD4Kb3fQ2H9R0"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <3f22b390-32fd-2018-b8f3-1a2586534996-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 01/11] drm/amdgpu: hw ring should be empty when gpu reset
References: <1469700828-25650-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1469700828-25650-2-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1469700828-25650-2-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--kTnpPdVWIvAidmgNpXgtxD4Kb3fQ2H9R0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>


On 07/28/2016 08:13 PM, Chunming Zhou wrote:
> Change-Id: I08ca5a805f590cc7aad0e9ccd91bd5925bb216e2
> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 11 +++++++++++
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 43beefb..ebd5565 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1247,6 +1247,7 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *ad=
ev);
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>  void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);=

>  void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgp=
u_ib *ib);
> +void amdgpu_ring_reset(struct amdgpu_ring *ring);
>  void amdgpu_ring_commit(struct amdgpu_ring *ring);
>  void amdgpu_ring_undo(struct amdgpu_ring *ring);
>  int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *r=
ing,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index 7e63ef9..1968251 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2102,6 +2102,7 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)
>  			continue;
>  		kthread_park(ring->sched.thread);
>  		amd_sched_hw_job_reset(&ring->sched);
> +		amdgpu_ring_reset(ring);
>  	}
>  	/* after all hw jobs are reset, hw fence is meaningless, so force_com=
pletion */
>  	amdgpu_fence_driver_force_completion(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> index 9989e25..75e1da6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -110,6 +110,17 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring=
 *ring, struct amdgpu_ib *ib)
>  		ib->ptr[ib->length_dw++] =3D ring->nop;
>  }
> =20
> +void amdgpu_ring_reset(struct amdgpu_ring *ring)
> +{
> +       u32 rptr =3D amdgpu_ring_get_rptr(ring);
> +
> +       ring->wptr =3D rptr;
> +       ring->wptr &=3D ring->ptr_mask;
> +
> +       mb();
> +       amdgpu_ring_set_wptr(ring);
> +}
> +
>  /**
>   * amdgpu_ring_commit - tell the GPU to execute the new
>   * commands on the ring buffer
>=20


--kTnpPdVWIvAidmgNpXgtxD4Kb3fQ2H9R0--

--4HsUuqwANDFAMalLCcaJIuEjH2ttebpNJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXnCSdAAoJEP4bvbfZuWjbolgP/imgXP6s3Sc5rWbjiIxWudjk
5GqkV20ijvURb/slWqDajBLypuOajYqEufbYj5Ky693fnqd5xU1jaXslPldD8hcr
LsMLrWpdWaflMTcNfDP3nArJ7Zvu85lXWT3FNyajvjCCY3mJeM1L1jdIzj/cB0XI
GmrmCrCGteYHNtjNvNeMIjoL/TkgEphRlDDk+L2gS47NrEJKBis9sHcx2kFmAVV3
xfh7+L+CnRgl8pg6YFkgDW40r4KVGZaqLiA1mjX/bSZb5MHeZ6piSHbPa3bfWX2d
W697bVmrYfq8B9vPZ5EsocC3tWx5hyjpMEzBLhDZf8A0848jsHhnt9jovtfzimtT
+l+NPfnCA0Jr4dTCgqS4B2tN7uZYKh9c0vrzNj/jzGaKEbZUBPxgICjPIxEj+wm2
Y1mQ+NUkFISPC5xfR85kWmNhRiy681ty9fnlXZ4lT3WrHBURnsdNMJDZfZ3AZ2m7
TlhfujgSF7corXWWrBmdR51fIM8zxznbIZSdu3wLvoy8cUKJt0A7N0RweSmhlMLM
TKibM27llmLpuD+DMPeDenqXUQkmi2o55uz7YZ/bHnmyKR8ZSdCg2pmfGfdhKBU1
w5fBkAWY43dOC/FWTbKMXiqytzgv2dP/3NJbCnLIhUzDzGK9fmMtpsp9LVZClLEF
iQnwT1PW5r7sZ/Oo19Y9
=RtGI
-----END PGP SIGNATURE-----

--4HsUuqwANDFAMalLCcaJIuEjH2ttebpNJ--

--===============0387918224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0387918224==--
