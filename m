From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 3/3] drm/scheduler: modify args of drm_sched_entity_init
Date: Thu, 12 Jul 2018 10:51:12 -0700
Message-ID: <87pnzs9wbz.fsf@anholt.net>
References: <20180712063643.8030-1-nayan26deshmukh@gmail.com>
 <20180712063643.8030-4-nayan26deshmukh@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0699007433=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180712063643.8030-4-nayan26deshmukh@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: Nayan Deshmukh <nayan26deshmukh@gmail.com>, christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

--===============0699007433==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nayan Deshmukh <nayan26deshmukh@gmail.com> writes:
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/=
scheduler/gpu_scheduler.c
> index 3dc1a4f07e3f..b2dbd1c1ba69 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> @@ -162,26 +162,32 @@ drm_sched_rq_select_entity(struct drm_sched_rq *rq)
>   * drm_sched_entity_init - Init a context entity used by scheduler when
>   * submit to HW ring.
>   *
> - * @sched: scheduler instance
>   * @entity: scheduler entity to init
> - * @rq: the run queue this entity belongs
> + * @rq_list: the list of run queue on which jobs from this
> + *           entity can be submitted
> + * @num_rq_list: number of run queue in rq_list
>   * @guilty: atomic_t set to 1 when a job on this queue
>   *          is found to be guilty causing a timeout
>   *
> + * Note: the rq_list should have atleast one element to schedule
> + *       the entity
> + *
>   * Returns 0 on success or a negative error code on failure.
>  */
> -int drm_sched_entity_init(struct drm_gpu_scheduler *sched,
> -			  struct drm_sched_entity *entity,
> -			  struct drm_sched_rq *rq,
> +int drm_sched_entity_init(struct drm_sched_entity *entity,
> +			  struct drm_sched_rq **rq_list,
> +			  unsigned int num_rq_list,
>  			  atomic_t *guilty)
>  {
> -	if (!(sched && entity && rq))
> +	if (!(entity && rq_list && num_rq_list > 0 && rq_list[0]))
>  		return -EINVAL;
>=20=20
>  	memset(entity, 0, sizeof(struct drm_sched_entity));
>  	INIT_LIST_HEAD(&entity->list);
> -	entity->rq =3D rq;
> -	entity->sched =3D sched;
> +	entity->rq_list =3D NULL;
> +	entity->rq =3D rq_list[0];
> +	entity->sched =3D rq_list[0]->sched;
> +	entity->num_rq_list =3D num_rq_list;

The API change makes sense as prep work, but I don't really like adding
the field to the struct (and changing the struct's docs for the existing
rq field) if it's going to always be NULL until a future change.

Similarly, I'd rather see patch 2 as part of a series that uses the
value.

That said, while I don't currently have a usecase for load-balancing
between entities, I may in the future, so thanks for working on this!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAltHlRAACgkQtdYpNtH8
nuhMvQ//Wcz1buCOKMuI53t08PcjmBOxxPVyya7KDuCATogj5owUu1oOItzfLgyy
j3/vB7qbeU2Fgr+YpHegZm4ebKsYayfLBlA9UZfO02jy2emfEP/SC0t2GgQCG2d6
vtri3UHJNopqwLsFfqlBEIh8kTr/iBiEC6s0GtVQzYMphI/lEDmFRatgk3BADUyq
Op2IWbSBjeZSlwAoQKD91cAAmN/HOnfFm2lWOLwMh68opNHDmlGMU3lyAWyNDTAC
2TEin3N7xkXtUR34uUpTrE635UyKAmf4FTE8BpjpW9UQAw5Qo4ccRozlUM+K6EdX
61ALhXuM2jE6425U577yasB2HwyjtH684flwQUuO7n0TJbI9avxpg0KpTXbCRy0o
z1LVI7EL5aAk0JkNM1mFesb93eP/5KL6TspdUn96vGq/UH6sl5XlfIqKomrd6uys
JCBKwNkfO79ql7Z9ZWRWhk4txc7cTDKP5xmohDRcYgwSABLHepW5JIxCjN4skSfs
Qok3FHxg2/8fjtP3IgnYgIrgaejlcU9+26KcoOEEcgVEa+bLrTIwkBWUmFcF9WUi
UIYyBejX7/MYpEAFU/+t/AoW8X1l3xDZOY8dVAqtwaYZQA9vLSbdrWOsJvmxr75N
pwIGJzTmI6Wz8UTYnUisyeMVQcCmOuK15y5RhGx/p5v2IB/KUG8=
=WGXW
-----END PGP SIGNATURE-----
--=-=-=--

--===============0699007433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0699007433==--
