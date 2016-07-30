From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 09/11] drm/amd: hw job list should be exact
Date: Sat, 30 Jul 2016 13:46:46 +1000
Message-ID: <dc00aaed-922d-eef2-5363-c923a84d9b1e@folklore1984.net>
References: <1469700828-25650-1-git-send-email-David1.Zhou@amd.com>
 <1469700828-25650-10-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0296064758=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469700828-25650-10-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
--===============0296064758==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8bULa9TIL5NQScMeK0giIgs5DOqNlnRhv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8bULa9TIL5NQScMeK0giIgs5DOqNlnRhv
Content-Type: multipart/mixed; boundary="IjtAATirxBfi74wq914WDq34qKtgvirot"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <dc00aaed-922d-eef2-5363-c923a84d9b1e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 09/11] drm/amd: hw job list should be exact
References: <1469700828-25650-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1469700828-25650-10-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1469700828-25650-10-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--IjtAATirxBfi74wq914WDq34qKtgvirot
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/28/2016 08:13 PM, Chunming Zhou wrote:
> hw job list should be exact, so deleting job node should be in irq
> handler instead of work thread.
> And Calculating time of next job should be immediate as well.
>=20
> Change-Id: I6d2686d84be3e7077300df7181c2a284fbcda9eb
Guessing this Gerrit/Jenkins CI change-id is usually dropped?

otherwise, Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 38 +++++++++++++------=
--------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c b/drivers/gp=
u/drm/amd/scheduler/gpu_scheduler.c
> index 9f4fa6e..69a9d40 100644
> --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> @@ -367,34 +367,32 @@ static void amd_sched_job_finish(struct work_stru=
ct *work)
>  	struct amd_sched_job *s_job =3D container_of(work, struct amd_sched_j=
ob,
>  						   finish_work);
>  	struct amd_gpu_scheduler *sched =3D s_job->sched;
> -	unsigned long flags;
> -
> -	/* remove job from ring_mirror_list */
> -	spin_lock_irqsave(&sched->job_list_lock, flags);
> -	list_del_init(&s_job->node);
> -	if (sched->timeout !=3D MAX_SCHEDULE_TIMEOUT) {
> -		struct amd_sched_job *next;
> =20
> -		spin_unlock_irqrestore(&sched->job_list_lock, flags);
> +	if (sched->timeout !=3D MAX_SCHEDULE_TIMEOUT)
>  		cancel_delayed_work_sync(&s_job->work_tdr);
> -		spin_lock_irqsave(&sched->job_list_lock, flags);
> -
> -		/* queue TDR for next job */
> -		next =3D list_first_entry_or_null(&sched->ring_mirror_list,
> -						struct amd_sched_job, node);
> =20
> -		if (next)
> -			schedule_delayed_work(&next->work_tdr, sched->timeout);
> -	}
> -	spin_unlock_irqrestore(&sched->job_list_lock, flags);
>  	sched->ops->free_job(s_job);
>  }
> =20
>  static void amd_sched_job_finish_cb(struct fence *f, struct fence_cb *=
cb)
>  {
> -	struct amd_sched_job *job =3D container_of(cb, struct amd_sched_job,
> -						 finish_cb);
> -	schedule_work(&job->finish_work);
> +	struct amd_sched_job *s_job =3D container_of(cb, struct amd_sched_job=
,
> +						   finish_cb);
> +	struct amd_gpu_scheduler *sched =3D s_job->sched;
> +	struct amd_sched_job *next;
> +	unsigned long flags;
> +
> +	/* remove job from ring_mirror_list */
> +	spin_lock_irqsave(&sched->job_list_lock, flags);
> +	list_del_init(&s_job->node);
> +	/* queue TDR for next job */
> +	next =3D list_first_entry_or_null(&sched->ring_mirror_list,
> +					struct amd_sched_job, node);
> +	spin_unlock_irqrestore(&sched->job_list_lock, flags);
> +	if (next)
> +		schedule_delayed_work(&next->work_tdr, sched->timeout);
> +
> +	schedule_work(&s_job->finish_work);
>  }
> =20
>  static void amd_sched_job_begin(struct amd_sched_job *s_job)
>=20


--IjtAATirxBfi74wq914WDq34qKtgvirot--

--8bULa9TIL5NQScMeK0giIgs5DOqNlnRhv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXnCMmAAoJEP4bvbfZuWjbFrsP/07RylsNTnnnqYjE9eP7ZXNN
q5KaCz0GAQFIF5jb9UVqTrBIaZtlruZMy1DJtnWZidUSG6ZqU7hqWKaz+l21NqTO
QwxZW8TrWKx4MrAlVe6ZZc+uEs0+8l4DnpvzrYQVJU1gDES+Ok7E8mVSJ64N5dDb
GnOvZ7XExN0r1JkZqp7v250W35ZcelB0tTQe1RgwgTBAwcJIUt1fUy+wClELZYHu
lA+9QfPpVtjMcLokiUFCnQTqcEIf3zNRwHQSdyCisujHbs0L8UuP36+ZrVnGWSZt
8jkfpzro1evqhpPsV4Yf/+oZL7ou0hsV7lMHauQMe5qMUVeq99lS3JG7aiX+sx2a
yH5fdNTWZNZwsp8yc5LgBPqOk80kDs3DQTYhhBbaHySu/1H5E9Zo7NE5tOuRFz71
YgompUOwjnK3to2CoFqKus/OC9dIMPLPyyihrHsrPHgXJkXsHK2AF5nqS/sd9NyR
ri4JNTd2vlUhy0KMYsXAgF2DkBYHrUQxw8u3u0rsCsn+IzTHmfyeWqkxA+kU7dBt
trvIXRLlcazyzdpgmu0EX5rUnnyOrodgObpjtCuyf9oCYaa8+NtPJww6V5eDX5VB
Mjwa2hoIqYBqFp/Tt73z8h6UgmhqGjgQ69CzsI4IUnRoQAXFlBPCHjwhRCBCn69i
x9ByMjDSct8aEGu7MvCE
=APQw
-----END PGP SIGNATURE-----

--8bULa9TIL5NQScMeK0giIgs5DOqNlnRhv--

--===============0296064758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0296064758==--
