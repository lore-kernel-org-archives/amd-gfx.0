From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: update kernel-doc for some functions
Date: Mon, 24 Oct 2016 09:29:45 +1100
Message-ID: <20d1f285-6a45-fe57-404a-1974b4e62a49@folklore1984.net>
References: <1477247507-11378-5-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1766783006=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477247507-11378-5-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1766783006==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rX0t1dA0wnM0X1Spds01w1e5h5BE5jn6v"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rX0t1dA0wnM0X1Spds01w1e5h5BE5jn6v
Content-Type: multipart/mixed; boundary="j8Wj2FS0qB7LfbEwNUp9XgcSePtUI1idT";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <20d1f285-6a45-fe57-404a-1974b4e62a49-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: update kernel-doc for some functions
References: <1477247507-11378-5-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1477247507-11378-5-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--j8Wj2FS0qB7LfbEwNUp9XgcSePtUI1idT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 10/24/2016 05:31 AM, Grazvydas Ignotas wrote:
> The names were wrong.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/scheduler/sched_fence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/scheduler/sched_fence.c b/drivers/gpu/=
drm/amd/scheduler/sched_fence.c
> index 6b63bea..3653b5a 100644
> --- a/drivers/gpu/drm/amd/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/amd/scheduler/sched_fence.c
> @@ -103,7 +103,7 @@ static void amd_sched_fence_free(struct rcu_head *r=
cu)
>  }
> =20
>  /**
> - * amd_sched_fence_release - callback that fence can be freed
> + * amd_sched_fence_release_scheduled - callback that fence can be free=
d
>   *
>   * @fence: fence
>   *
> @@ -118,7 +118,7 @@ static void amd_sched_fence_release_scheduled(struc=
t fence *f)
>  }
> =20
>  /**
> - * amd_sched_fence_release_scheduled - drop extra reference
> + * amd_sched_fence_release_finished - drop extra reference
>   *
>   * @f: fence
>   *
>=20


--j8Wj2FS0qB7LfbEwNUp9XgcSePtUI1idT--

--rX0t1dA0wnM0X1Spds01w1e5h5BE5jn6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYDTnZAAoJEP4bvbfZuWjbkXEP/jXKSaVMJlHI5Up6AiIk6WRi
/Qzs3EYdswXBUpCSBLTTzBdR0jGZ7JwhKcESDm7VTl6G7uCkLr5ZdC5AQ6yU+Vjp
IOJRMBMmgFlzBbK2Z7kJGLtoWcaIlMbf26PQfWdsov5FVz4yUWDE8oYkeejQ37Ef
FJGJj7BuGwtnQrrJBhFpbttAFvV+kDDWug33MvqZkHRHk306IcHrHojmSmMV2vVM
T8Y4bz8vHxLRbxoj743lTXnnDElDZoOMgU/0bSrzvygYj3HuyYXj6StkLTrgS6ss
quOoE7jflB1vPdqjrey+ebpX4X0wW5v2ImBWbt5zeltFG2R2ny41Uo4AJQLB0j6p
mxVBngOo7YgahP57uUDV12X+1CD5tSZuplkXjAzPwF2FA50QnQaRZt1VWYMBf06i
kcSXBcmp8CeTyBArPy8beb9lmVVckBK1uhu+f5JAR0eol5GbjIRri8owpHlZFpVW
D1uQPK1Y0aMqKxJNn3Ei0f4qHIdJWGVAm2hfhZU5iGAOGA62K2rf5fTvuQzjwR9c
D0v1Iw4CxykivPGd2KDr+rLaR+cybouqJeLJxAC74S/XRjHKYZOY9PqZyONhbKOw
n1JQxbkXBOA/d0mSHw78deCcXs3GLFtl377e971lijvPeOH0PkwlzGB3Yc2mi9d2
V7ok/f+ow4zXBR0Q/LVW
=cxzg
-----END PGP SIGNATURE-----

--rX0t1dA0wnM0X1Spds01w1e5h5BE5jn6v--

--===============1766783006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1766783006==--
