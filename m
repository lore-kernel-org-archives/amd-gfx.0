From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v3 1/5] drm/scheduler: rework job destruction
Date: Mon, 15 Apr 2019 14:17:37 -0700
Message-ID: <878swb6k9a.fsf@anholt.net>
References: <1555357403-30813-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2081478644=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1555357403-30813-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

--===============2081478644==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org> writes:

> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> We now destroy finished jobs from the worker thread to make sure that
> we never destroy a job currently in timeout processing.
> By this we avoid holding lock around ring mirror list in drm_sched_stop
> which should solve a deadlock reported by a user.
>
> v2: Remove unused variable.
>
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D109692
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  17 ++--
>  drivers/gpu/drm/etnaviv/etnaviv_dump.c     |   4 -
>  drivers/gpu/drm/etnaviv/etnaviv_sched.c    |   9 +-
>  drivers/gpu/drm/scheduler/sched_main.c     | 138 +++++++++++++++++------=
------
>  drivers/gpu/drm/v3d/v3d_sched.c            |   9 +-

Missing corresponding panfrost and lima updates.  You should probably
pull in drm-misc for hacking on the scheduler.

> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sc=
hed.c
> index ce7c737b..8efb091 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -232,11 +232,18 @@ v3d_gpu_reset_for_timeout(struct v3d_dev *v3d, stru=
ct drm_sched_job *sched_job)
>=20=20
>  	/* block scheduler */
>  	for (q =3D 0; q < V3D_MAX_QUEUES; q++)
> -		drm_sched_stop(&v3d->queue[q].sched);
> +		drm_sched_stop(&v3d->queue[q].sched, sched_job);
>=20=20
>  	if(sched_job)
>  		drm_sched_increase_karma(sched_job);
>=20=20
> +	/*
> +	 * Guilty job did complete and hence needs to be manually removed
> +	 * See drm_sched_stop doc.
> +	 */
> +	if (list_empty(&sched_job->node))
> +		sched_job->sched->ops->free_job(sched_job);

If the if (sched_job) is necessary up above, then this should clearly be
under it.

But, can we please have a core scheduler thing we call here instead of
drivers all replicating it?

> +
>  	/* get the GPU back into the init state */
>  	v3d_reset(v3d);
>=20=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAly09PEACgkQtdYpNtH8
nuhi2Q/7B/vT7KybreXruLawEYm0HXhNOmjfwsk0NPSYllpNXT7pHHfL2vpyoL1+
qTKKv6u7KIR8iY4c23ZOv4+AmYwBG8pOmZ6k0bvbGOHG5O29GV6SpWFiGgq+oIcK
Ij1Hr9DZmal7Z49MQHZT6QON9D9LfdiJ2cCIghPDjYC3Vky8IFu+UvCRBtE7tFEr
o+c9jSF+t8/FQ5yn/Bn6CSzH1AmDITuaHdkSMZmtxfjKnhxGEd6hK83wny0Tx+x2
de45E3DpOKfj9RwLK+6h4ocuPTWcZFyYb+5kPjOWwM3GGWZOreUQWAG1MpqJ/uYO
/6kAafh+BFR70h5k0npQ2l//otMk5Pjxne0fPg8HTVYiEHwlEUv+SAwNsUEbDOFK
rcuS8DwCSBTFGESphgHWgSpjXcK7Kwpr49N8YMIyB3WTcX45fn0HqNgJB8ZZtQ3E
m5UFJOi3pQAfC8G6OO9ss3+dYo/9q55jp5erwpSrLqJ/WThDULEgq3TD4hYRJwE2
yXwszbE+IY7bHJIL0IakI7r1281P4MFM9hCbPlGPQWSsPmvqLEDn8itLQyl323io
b5FDVCGBocoVBQ9mbO0Ji4RE+3WTi3F4JryZ4eiaJWqD8FdHR8O+GqxStc0cV0Ah
Y3+yt0xcHwlu0nzHUj6syzozliQVxpXAP2PYQIRtPePIRmUh/g0=
=cA61
-----END PGP SIGNATURE-----
--=-=-=--

--===============2081478644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2081478644==--
