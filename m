From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 15/18] drm/amd: block entity
Date: Fri, 12 Aug 2016 19:42:29 +1000
Message-ID: <f8dfeb55-132f-1ddf-2e2f-02776aa5d3e0@folklore1984.net>
References: <1470983947-32579-1-git-send-email-David1.Zhou@amd.com>
 <1470983947-32579-16-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1590202586=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470983947-32579-16-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
--===============1590202586==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LIDEubRJQrhq2sDKR7kVbPuhuFOSPKIPe"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LIDEubRJQrhq2sDKR7kVbPuhuFOSPKIPe
Content-Type: multipart/mixed; boundary="w0hbDsg61ESIMlMR1sQII1O1tgl2DT5pt"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <f8dfeb55-132f-1ddf-2e2f-02776aa5d3e0-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 15/18] drm/amd: block entity
References: <1470983947-32579-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1470983947-32579-16-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1470983947-32579-16-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--w0hbDsg61ESIMlMR1sQII1O1tgl2DT5pt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/12/2016 04:39 PM, Chunming Zhou wrote:
> Change-Id: Iba210e0d007a249a90f955f5ac9c3803cc40def2
> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 7 ++++++-
>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c b/drivers/gp=
u/drm/amd/scheduler/gpu_scheduler.c
> index f750d4a..78d34d5 100644
> --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> @@ -109,6 +109,11 @@ amd_sched_rq_select_entity(struct amd_sched_rq *rq=
)
>  	return NULL;
>  }
> =20
> +void amd_sched_block_entity(struct amd_sched_entity *entity, bool bloc=
k)
> +{
> +	entity->block =3D block;
> +}
Why is this function necessary, did I miss something?

> +
>  /**
>   * block all entity of this run queue
>   *
> @@ -122,7 +127,7 @@ int amd_sched_rq_block_entity(struct amd_sched_rq *=
rq, bool block)
>  	spin_lock(&rq->lock);
> =20
>  	list_for_each_entry(entity, &rq->entities, list)
> -		entity->block =3D block;
> +		amd_sched_block_entity(entity, block);
> =20
>  	spin_unlock(&rq->lock);
> =20
> diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h b/drivers/gp=
u/drm/amd/scheduler/gpu_scheduler.h
> index 8ea0374..da01051 100644
> --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> @@ -159,4 +159,5 @@ int amd_sched_job_init(struct amd_sched_job *job,
>  void amd_sched_hw_job_reset(struct amd_gpu_scheduler *sched);
>  void amd_sched_job_recovery(struct amd_gpu_scheduler *sched);
>  int amd_sched_rq_block_entity(struct amd_sched_rq *rq, bool block);
> +void amd_sched_block_entity(struct amd_sched_entity *entity, bool bloc=
k);
>  #endif
>=20


--w0hbDsg61ESIMlMR1sQII1O1tgl2DT5pt--

--LIDEubRJQrhq2sDKR7kVbPuhuFOSPKIPe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXrZoFAAoJEP4bvbfZuWjbsHkP/Ayg7HxwQWc42SE+uxeIp/YA
sKKN/bt5rv7fjMTVrWs/kokiNR0f8kwGGg7hhPA2rVZX9lAVps1lse7VcIqsJLGp
1KzDKEZTSazJ2fEPyVvFExDIIAlRbtl+w+NLKftI1676IDuTCQITKTHek+7nrz+y
qjTDZg4a2LlHjqSzkQ1c1PPbuXZiFzNNR4OHeP8QptEw7Dzvb2CgsNbO0uOzYuUL
bVBQrG+TQr2wvClcufs25joP0i2yHc/8ha7WLm/AbB9CKQC3qNLljwUSxv7uPWsj
x0+S49O7+WINESsSjI5F60i7XHa/kEDqnRpHMmp7ZvJuQxdhWLCtkf4xa3yR6GNj
ktN0Q1DlVB0gsH05BUuMv368MJQQxno523ny7HHu2azr8+mgDKNHhBSoF0C9KgRo
zQ7go+DqEt1YjSFZzXmP2jQxlcnJvh2fdRB57gdgJFwqAxCD6vtwrNNolwfY6IAP
VVt7/YLXo9N3c3H4v15+qieehqr7LDvTdjEFYLVkpnum89PNlwVDJi1h/dMeis0D
bHxUaH8OJw4RBM+5SGgV+/elW5QpCk0LdmBpPHV8Vnlkk3jX2DupeUe2PaEEt4yx
TMZLDQZBIoeA4Ju1TZcai2LQdv2lXO49lUtX5E3lVAqG9Khk5TTnJwejKEUwjxog
GJkQBA981BwfQqgYRCwJ
=e3py
-----END PGP SIGNATURE-----

--LIDEubRJQrhq2sDKR7kVbPuhuFOSPKIPe--

--===============1590202586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1590202586==--
