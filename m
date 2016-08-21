From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 5/6] drm/amdgpu: use fence-array for ctx release
Date: Sun, 21 Aug 2016 16:42:53 +1000
Message-ID: <56580e14-9d77-f85c-20ce-a32971d9bce2@folklore1984.net>
References: <1471506618-29849-1-git-send-email-David1.Zhou@amd.com>
 <1471506618-29849-6-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0819536534=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471506618-29849-6-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: David.Mao-5C7GfCeVMHo@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0819536534==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mimLwFw5c7eaNslP3sW9BrRiNo4OM82mi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mimLwFw5c7eaNslP3sW9BrRiNo4OM82mi
Content-Type: multipart/mixed; boundary="skcJAa56TxAed465VJILwVg8RHPjaPMJb"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David.Mao-5C7GfCeVMHo@public.gmane.org
Message-ID: <56580e14-9d77-f85c-20ce-a32971d9bce2-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 5/6] drm/amdgpu: use fence-array for ctx release
References: <1471506618-29849-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1471506618-29849-6-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1471506618-29849-6-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--skcJAa56TxAed465VJILwVg8RHPjaPMJb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/18/2016 05:50 PM, Chunming Zhou wrote:
> benifits:
> 1. don't block userspace release at all.
> 2. make sure userspace can look up dependency if fence isn't signaled.
> If they cannot find ctx, that means the dependecy is signaled.
>=20
> Change-Id: I9184a7bb4f5bb6858c2dd49cfb113eeee159cf71
> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 51 +++++++++++++++++++++++++=
+++++++-
>  2 files changed, 53 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 6d770c2..b6320e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -35,6 +35,7 @@
>  #include <linux/interval_tree.h>
>  #include <linux/hashtable.h>
>  #include <linux/fence.h>
> +#include <linux/fence-array.h>
> =20
>  #include <ttm/ttm_bo_api.h>
>  #include <ttm/ttm_bo_driver.h>
> @@ -1025,6 +1026,8 @@ struct amdgpu_ctx_ring {
> =20
>  struct amdgpu_ctx {
>  	struct kref		refcount;
> +	struct fence_cb         cb;
> +	struct work_struct      release_work;
>  	struct amdgpu_device    *adev;
>  	unsigned		reset_counter;
>  	spinlock_t		ring_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.c
> index 01d5612..23afe92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -27,6 +27,7 @@
> =20
>  static DEFINE_MUTEX(amdgpu_ctx_lock);
>  extern struct idr amdgpu_ctx_idr;
> +static void amdgpu_ctx_release_work(struct work_struct *work);
> =20
>  static int amdgpu_ctx_init(struct amdgpu_device *adev, struct amdgpu_c=
tx *ctx)
>  {
> @@ -37,6 +38,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev=
, struct amdgpu_ctx *ctx)
>  	ctx->adev =3D adev;
>  	kref_init(&ctx->refcount);
>  	spin_lock_init(&ctx->ring_lock);
> +	INIT_WORK(&ctx->release_work, amdgpu_ctx_release_work);
>  	ctx->fences =3D kcalloc(amdgpu_sched_jobs * AMDGPU_MAX_RINGS,
>  			      sizeof(struct fence*), GFP_KERNEL);
>  	if (!ctx->fences)
> @@ -120,13 +122,60 @@ static int amdgpu_ctx_alloc(struct amdgpu_device =
*adev,
>  	return r;
>  }
> =20
> +static void amdgpu_ctx_release_work(struct work_struct *work)
> +{
> +	struct amdgpu_ctx *ctx =3D container_of(work, struct amdgpu_ctx,
> +					      release_work);
> +	amdgpu_ctx_fini(ctx);
> +}
> +
> +static void amdgpu_ctx_release_cb(struct fence *f, struct fence_cb *cb=
)
> +{
> +	struct amdgpu_ctx *ctx =3D container_of(cb, struct amdgpu_ctx,
> +					      cb);
> +	schedule_work(&ctx->release_work);
> +	fence_put(f);
> +}
> +
>  static void amdgpu_ctx_do_release(struct kref *ref)
>  {
>  	struct amdgpu_ctx *ctx;
> +	struct fence **fences;
> +	struct fence_array *array;
> +	int i, j, k =3D 0, r;
> =20
>  	ctx =3D container_of(ref, struct amdgpu_ctx, refcount);
> =20
> -	amdgpu_ctx_fini(ctx);
> +	fences =3D kmalloc_array(sizeof(void *), AMDGPU_MAX_RINGS *
> +			       amdgpu_sched_jobs,
> +			       GFP_KERNEL);
> +	if (!fences)
> +		return;
> +	for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		for (j =3D 0; j < amdgpu_sched_jobs; ++j) {
> +			if (ctx->rings[i].fences[j])
> +				fences[k++] =3D fence_get(ctx->rings[i].fences[j]);
> +		}
> +	}
> +	if (k =3D=3D 0) {
> +		amdgpu_ctx_release_cb(NULL, &ctx->cb);
> +		kfree(fences);
> +		return;
> +	}
> +
> +	array =3D fence_array_create(k, fences, fence_context_alloc(1),
> +				   1, false);
> +	if (!array) {
> +		for (j =3D 0; j < k; ++j)
> +			fence_put(fences[j]);
> +		kfree(fences);
> +		return;
> +	}
> +	r =3D fence_add_callback(&array->base, &ctx->cb, amdgpu_ctx_release_c=
b);
> +	if (r =3D=3D -ENOENT)
> +		amdgpu_ctx_release_cb(&array->base, &ctx->cb);
> +	else if (r)

Could be wrong but should this be (r < 0) ?

Kind Regards,
Edward.

> +		DRM_ERROR("fence add callback failed (%d)\n",  r);
>  }
> =20
>  static int amdgpu_ctx_free(uint32_t id)
>=20


--skcJAa56TxAed465VJILwVg8RHPjaPMJb--

--mimLwFw5c7eaNslP3sW9BrRiNo4OM82mi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXuU1tAAoJEP4bvbfZuWjb8xwQAJMWceMYOZnNzYaIGr484fwK
msXryHOHB7+6DFiDoHH2ZQmNiW4HMesbw1hbAlhyEpo9dsj+fUiQe+m1Wpy+QSy/
74cRTrEC1VpQTkBRq632WrghTKcltSPqRAWsVclnOJelJQecnQn+uZ3/P2cWQ9Zk
het4pO1rJ/g+TbLPUIQnpSizG/LgSEw/Gp0fYztNw1GiDQNYGqtkP2HhZPlT0+h2
etuLa+AszSr7E582vhj5qtt9BKMv9S+q5WriQb6BDb39vXTuEd8znmA9AA8dLNHD
dZvoTdIW06jFeTzwREY/Lj+Uv3tdqGBaGUVWG+PUq8eOQokTp6/kL9SFVzjKfHGZ
0BUcXpFGjzQ0k35aUSqEuJR1uzyUNLp43E2qFx1uJTdL/ibaK0fzB8SWgGXsI3W/
IN2mTSClNSXYZ8g5V5yDQGnxfTooHMK1xEXt+ZNYPrnNBR3QSh3ZRJAfGsKvSWCo
QBApY4mHvIjQYb1H1RC+JC8MeoxOVgn1TydButuotM6dnqsQxbGrLRjXRgViPtfu
Ju5NU7IrLYXP3k6Ad4vBELwlTg+ydb2eX+RtHkKK4h3Q8JyKLZz1tleQNu6M5l2J
n36lSCiWDQODOKzzE1XQByaJIbO4yiF91BLJNCFSaXviw+aZRYtapF39RklcsJUN
MWLjlX91AxZLY4V0QpH6
=QN3n
-----END PGP SIGNATURE-----

--mimLwFw5c7eaNslP3sW9BrRiNo4OM82mi--

--===============0819536534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0819536534==--
