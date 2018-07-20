From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/scheduler: modify API to avoid redundancy
Date: Fri, 20 Jul 2018 11:13:31 -0700
Message-ID: <874lgtbws4.fsf@anholt.net>
References: <20180720122106.10344-1-nayan26deshmukh@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1490789757=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180720122106.10344-1-nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

--===============1490789757==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> entity has a scheduler field and we don't need the sched argument
> in any of the functions where entity is provided.
>
> Signed-off-by: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 13 +++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c   |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++--
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c     |  3 +--
>  drivers/gpu/drm/etnaviv/etnaviv_sched.c   |  4 ++--
>  drivers/gpu/drm/scheduler/gpu_scheduler.c | 20 +++++++++++---------
>  drivers/gpu/drm/v3d/v3d_drv.c             |  4 +---
>  drivers/gpu/drm/v3d/v3d_gem.c             |  2 --
>  include/drm/gpu_scheduler.h               | 10 +++-------
>  13 files changed, 30 insertions(+), 42 deletions(-)
>

> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/=
scheduler/gpu_scheduler.c
> index dac71e3b4514..a3b55c542025 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> @@ -273,11 +273,12 @@ static void drm_sched_entity_kill_jobs_cb(struct dm=
a_fence *f,
>   *
>   * Returns the remaining time in jiffies left from the input timeout
>   */
> -long drm_sched_entity_flush(struct drm_gpu_scheduler *sched,
> -			   struct drm_sched_entity *entity, long timeout)
> +long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeou=
t)
>  {
> +	struct drm_gpu_scheduler *sched;
>  	long ret =3D timeout;
>=20=20
> +	sched =3D entity->sched;
>  	if (!drm_sched_entity_is_initialized(sched, entity))
>  		return ret;
>  	/**
> @@ -312,10 +313,11 @@ EXPORT_SYMBOL(drm_sched_entity_flush);
>   * entity and signals all jobs with an error code if the process was kil=
led.
>   *
>   */
> -void drm_sched_entity_fini(struct drm_gpu_scheduler *sched,
> -			   struct drm_sched_entity *entity)
> +void drm_sched_entity_fini(struct drm_sched_entity *entity)
>  {
> +	struct drm_gpu_scheduler *sched;
>=20=20
> +	sched =3D entity->sched;

Maybe fold the initialization into the declaration above, like you did
elsewhere?

Regardless, this is a wonderful cleanup of the API.

Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAltSJksACgkQtdYpNtH8
nujq4RAAmnAHLSgIF/WlAqiIJRsJimw0o9xXIEoNBxSdWUN42q0gsSPrAbBsHXeI
+QOaRwgybkJazQ1mI6l8oWwMN8K7wnIXRqGGF0v3lSX3snk49Xjs+vxoBw0iWS7r
7FNnajUXPXmot2FLi9cRiGR4xv8huaA+FHXUcqbk92EWxnIrBINwycCFJhC7LAHX
jVOKxP1Yvy0b4RnJRISG5howaXIZctFPaHpxllwVrgnIAfPCxhhsdN+huZEdhOQU
qrrDyqOUCwaPAR9lvxQvkOeWqx4IiK2Y8Ma7GBIF21eKhJWUEmXsgBmxwpiIMs3n
Bh90DBmn4ajL8IdnFeoyE9bs0+GSwKGxCZwuW8GPYiS7L9nmGDX9b22aBij2f40f
ril+InjnWwgDKpu7Jx/FHhQ74FRskFOYNCZGf3ico3wU24APC8KBU1p53uNPBhoe
ueLHGiJ2HXj3fp7hQWIlcIHHyZZTeiG8N5pTcq/Wy+o216vgeSTitR1X4EIGMI14
GAEg1fcBtmhwGh/d6K4rojPtsL512r8B/aYLxw96IWGBRCKT4AZ+ZI6yURHJICPl
n35HktgrVsCbiRtlqg1H0pGONMsFFfA1VQRKJD2Hd+8EEvUrl4/oE7+n1QayjuwV
ocWLGDvT426vIAsMb0lQMWGCfMS4VkThQ+4B9euwF/tFfxqCTDQ=
=PvSi
-----END PGP SIGNATURE-----
--=-=-=--

--===============1490789757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1490789757==--
