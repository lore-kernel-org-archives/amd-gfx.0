From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu: add new helper for in kernel allocations
Date: Wed, 27 Jul 2016 09:54:02 +1000
Message-ID: <d2ecae6c-fd41-24d2-9b20-76eb09ed5cae@folklore1984.net>
References: <1469520017-8422-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0990331770=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469520017-8422-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0990331770==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2IP6sjiCTwG0e6g5JP9oA9aQK0QKr4wG3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2IP6sjiCTwG0e6g5JP9oA9aQK0QKr4wG3
Content-Type: multipart/mixed; boundary="IpnnhouUvJ45Jrk5e8RhN8br9bU7374Pw"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <d2ecae6c-fd41-24d2-9b20-76eb09ed5cae-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu: add new helper for in kernel allocations
References: <1469520017-8422-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1469520017-8422-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--IpnnhouUvJ45Jrk5e8RhN8br9bU7374Pw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 07/26/2016 06:00 PM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> We often allocate, pin and map things at the same time in the kernel.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 63 ++++++++++++++++++++++=
++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 ++
>  2 files changed, 67 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> index 6f0873c..9357358 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -211,6 +211,69 @@ static void amdgpu_fill_placement_to_bo(struct amd=
gpu_bo *bo,
>  	bo->placement.busy_placement =3D bo->placements;
>  }
> =20
> +/**
> + * amdgpu_bo_create_kernel - create BO for kernel use
> + *
> + * @adev: amdgpu device object
> + * @size: size for the new BO
> + * @align: alignment for the new BO
> + * @domain: where to place it
> + * @bo_ptr: resulting BO
> + * @gpu_addr: GPU addr of the pinned BO
> + * @cpu_addr: optional CPU address mapping
> + *
> + * Allocates and pins a BO for kernel internal use.
> + *
> + * Returns 0 on success, negative error code otherwise.
> + */
> +int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
> +			    unsigned long size, int align,
> +			    u32 domain, struct amdgpu_bo **bo_ptr,
> +			    u64 *gpu_addr, void **cpu_addr)
> +{
> +	int r;
> +
> +	r =3D amdgpu_bo_create(adev, size, align, true, domain,
> +			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +			     NULL, NULL, bo_ptr);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) failed to allocate kernel bo\n", r);
> +		return r;
> +	}
> +
> +	r =3D amdgpu_bo_reserve(*bo_ptr, false);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r);
> +		goto error_free;
> +	}
> +
> +	r =3D amdgpu_bo_pin(*bo_ptr, domain, gpu_addr);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
> +		goto error_unreserve;
> +	}
> +
> +	if (cpu_addr) {
> +		r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> +		if (r) {
> +			dev_err(adev->dev, "(%d) kernel bo map failed\n", r);
> +			goto error_unreserve;
> +		}
> +	}
> +
> +	amdgpu_bo_unreserve(*bo_ptr);
> +
> +	return 0;
> +
> +error_unreserve:
> +	amdgpu_bo_unreserve(*bo_ptr);
> +
> +error_free:
> +	amdgpu_bo_unref(bo_ptr);
> +
> +	return r;
> +}
> +
>  int amdgpu_bo_create_restricted(struct amdgpu_device *adev,
>  				unsigned long size, int byte_align,
>  				bool kernel, u32 domain, u64 flags,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.h
> index bdb01d9..ae188a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -139,6 +139,10 @@ int amdgpu_bo_create_restricted(struct amdgpu_devi=
ce *adev,
>  				struct ttm_placement *placement,
>  			        struct reservation_object *resv,
>  				struct amdgpu_bo **bo_ptr);
> +int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
> +			    unsigned long size, int align,
> +			    u32 domain, struct amdgpu_bo **bo_ptr,
> +			    u64 *gpu_addr, void **cpu_addr);
>  int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
>  void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
>  struct amdgpu_bo *amdgpu_bo_ref(struct amdgpu_bo *bo);
>=20


--IpnnhouUvJ45Jrk5e8RhN8br9bU7374Pw--

--2IP6sjiCTwG0e6g5JP9oA9aQK0QKr4wG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXl/gfAAoJEP4bvbfZuWjb2AIP/1loIy8hIYto7tqLcWqozZVk
LT2S8zcsX1UlOfYD0s+BeIIp8lhAA86EN+hyW7FKecO5olvvOiiyF6l3pDYJM6Do
Qdl5bXSHX/qXcGTif0JGb27lxD9vqwj/B1vvf6WFzFqSj1s4JXg+rZSNisi63ZKD
DvM8StDdRMB95Om5IV/4YUwWIa8QeckxZpy/JvOssn/Em2mMZRn0SbSuN7OXeHcG
V2/Ga9VImY8/cndOexcXWplNLy/SXLTVokLAPAcI9KtwszZzpX75lTwzvWH89UCG
NsuQM929vN5+iS1s0VrNMcbpwT7wL0+rIQfjsurT7iPIR0yFnhSMyb6UNjfslqao
L3QJZUktNTrDDkXJigdwX8QAY3IBwRj1gGJh4YFED5ZR6vAW4Iuw6TP0yRCE6GET
5KZldJL71dMPRleqnpBT6HOM0629d+sRHsAk4z9PHP3SuaLbApAqDxUsvW4tHOnt
aIlH4w7FNEwNXqcPYi3temoBZzo70L+cH+Lirlw/cMelvgj6PrDReDWdi4892btQ
mivFKYkUK+rd3NID1yj1H9+EK7WgzuBg5IVXluSbif0y+GZUSeyFEhO2qKmxbnC1
pTnUt+LNqiUsLTc1LQv2zy+CVr7rLwiYWBXtBhZCZH8R+Ua1+SItcTDHMPxZQ0hP
8jmK2qdogOdfZ4XPouuB
=cll+
-----END PGP SIGNATURE-----

--2IP6sjiCTwG0e6g5JP9oA9aQK0QKr4wG3--

--===============0990331770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0990331770==--
