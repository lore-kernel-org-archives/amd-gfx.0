From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: trace amdgpu_job fence details
Date: Thu, 23 Feb 2017 10:49:41 +1100
Message-ID: <6fd12a6c-4f50-8f32-2c53-a164969b9f09@folklore1984.net>
References: <20170222234717.3854-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2046736117=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170222234717.3854-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2046736117==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WvPsVLSouns37sTOL4jD2sJRgoqIUP0Dw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WvPsVLSouns37sTOL4jD2sJRgoqIUP0Dw
Content-Type: multipart/mixed; boundary="onrp6b1Wh1COUDDjn663rXwGlIEal9Mo9";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org
Message-ID: <6fd12a6c-4f50-8f32-2c53-a164969b9f09-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: trace amdgpu_job fence details
References: <20170222234717.3854-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20170222234717.3854-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--onrp6b1Wh1COUDDjn663rXwGlIEal9Mo9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 02/23/2017 10:47 AM, Andres Rodriguez wrote:
> This trace is intended to provide the required information to associate=

> the completion of an amdgpu_job with its corresponding dma_fence_*
> tracepoints.
>=20
> Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> index 86a1242..84a04e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -177,6 +177,8 @@ static struct dma_fence *amdgpu_job_run(struct amd_=
sched_job *sched_job)
>  	/* if gpu reset, hw fence will be replaced here */
>  	dma_fence_put(job->fence);
>  	job->fence =3D dma_fence_get(fence);
> +	trace_amdgpu_job_attach_fence(job);
> +
>  	amdgpu_job_free_resources(job);
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_trace.h
> index a18ae1e..0a61ed9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -147,6 +147,28 @@ TRACE_EVENT(amdgpu_sched_run_job,
>  		      __entry->fence, __entry->ring_name, __entry->num_ibs)
>  );
> =20
> +TRACE_EVENT(amdgpu_job_attach_fence,
> +	    TP_PROTO(struct amdgpu_job *job),
> +	    TP_ARGS(job),
> +	    TP_STRUCT__entry(
> +			     __field(struct amdgpu_device *, adev)
> +			     __field(struct amd_sched_job *, sched_job)
> +			     __string(timeline, job->fence->ops->get_timeline_name(job->fen=
ce))
> +			     __field(unsigned int, context)
> +			     __field(unsigned int, seqno)
> +			     ),
> +
> +	    TP_fast_assign(
> +			   __entry->adev =3D job->adev;
> +			   __entry->sched_job =3D &job->base;
> +			   __assign_str(timeline, job->fence->ops->get_timeline_name(job->f=
ence))
> +			   __entry->context =3D job->fence->context;
> +			   __entry->seqno =3D job->fence->seqno;
> +			   ),
> +	    TP_printk("adev=3D%p, sched_job=3D%p, timeline:%s, context:%u, se=
qno:%u",
> +		      __entry->adev, __entry->sched_job,
> +		      __get_str(timeline), __entry->context, __entry->seqno)
> +);
> =20
>  TRACE_EVENT(amdgpu_vm_grab_id,
>  	    TP_PROTO(struct amdgpu_vm *vm, int ring, struct amdgpu_job *job),=

>=20


--onrp6b1Wh1COUDDjn663rXwGlIEal9Mo9--

--WvPsVLSouns37sTOL4jD2sJRgoqIUP0Dw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYriOVAAoJEP4bvbfZuWjbd48QAJxchJGtAaiVG177INqByHO+
DSMa0fbG4PyjaGi4/v8rNoGYrItRHLc1+Ugrv5G6ZZZFMzlbHnLgeZwcXSz3o2Tw
Ag/8MsOkgDfWvIwtR5fHmkyNTR7D4peBjtpzXbPgDS7tXoE+0QhR08m6ZlBPhheV
GTt+MUgGSvOFOjSdubu8Mw7Zd4Y12lvKUifrqqinneKi1oV1IeUZEA2gcql+nPTd
VjIuWQlsQSxjq+XkyRGcua3axyRnmJlHwtvGDz4C2hkwF/uHPzxHJBD8AnIE/NSd
Lrg+sPWSvmgn+fS3bVv9QATt+tX/+NqOXUczCYGYGpnPaJ15APFF0X8ld7dA90h0
i9ZTkuEIX+e/bFKEAxpmSWD9HJG8oVHuWfsyc/qBfGqVES0Ck8Y2zxPUF2GSY7Ic
hh0my/JUPyJQCuYoSCWHoNmaQdozGmy6PgakhqLWvuCfRdlGqXQEG82c4H7zHaip
/7qHQr9Ske9c/g65r8Ek0ZivvxXGtXe10hNNzNRXfz0OWyLkCpG+oixtqMaSTFtl
QaT52PfN8VcEhp/NQ15W7kxjzSUxLobmmZrS0+xcFniwjnXYAIJZdKjQHW0I8aG/
UTMs6PbaSq8ZAbtd4NVEDa40eThrf67bOiE4wfsBrhm/b7jHzxEnKkqtH8DmBEDq
Jy76yhevHos8m4HFyYtc
=x2mX
-----END PGP SIGNATURE-----

--WvPsVLSouns37sTOL4jD2sJRgoqIUP0Dw--

--===============2046736117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2046736117==--
