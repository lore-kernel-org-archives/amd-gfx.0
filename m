From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 13/13] drm/amdgpu: new queue policy, take first 2 queues
 of each pipe
Date: Sat, 4 Feb 2017 23:08:51 +1100
Message-ID: <86138a88-e90f-3234-7109-67ca0c427071@folklore1984.net>
References: <20170204045142.5596-1-andresx7@gmail.com>
 <20170204045142.5596-14-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0486900607=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170204045142.5596-14-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org, Felix.Kuehling-5C7GfCeVMHo@public.gmane.org, John.Bridgman-5C7GfCeVMHo@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0486900607==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XaSlQTcKXlh24REG7MlfRqIlo2Xs3op2X"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XaSlQTcKXlh24REG7MlfRqIlo2Xs3op2X
Content-Type: multipart/mixed; boundary="56t0AKWkRbpo1JTLBhXWW88Ac2bxhQtDt";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org, Felix.Kuehling-5C7GfCeVMHo@public.gmane.org,
 John.Bridgman-5C7GfCeVMHo@public.gmane.org
Message-ID: <86138a88-e90f-3234-7109-67ca0c427071-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 13/13] drm/amdgpu: new queue policy, take first 2 queues
 of each pipe
References: <20170204045142.5596-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <20170204045142.5596-14-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20170204045142.5596-14-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--56t0AKWkRbpo1JTLBhXWW88Ac2bxhQtDt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 02/04/2017 03:51 PM, Andres Rodriguez wrote:
> Instead of taking the first pipe and givint the rest to kfd, take the

s/givint/giving/

> first 2 queues of each pipe.
>=20
> Effectively, amdgpu and amdkfd own the same number of queues. But
> because the queues are spread over multiple pipes the hardware will be
> able to better handle concurrent compute workloads.
>=20
> amdgpu goes from 1 pipe to 4 pipes, i.e. from 1 compute threads to 4
> amdkfd goes from 3 pipe to 4 pipes, i.e. from 3 compute threads to 4
>=20
> Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c
> index 2218b65..da28174 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2810,7 +2810,7 @@ static void gfx_v7_0_compute_queue_acquire(struct=
 amdgpu_device *adev)
>  			break;
> =20
>  		/* policy: amdgpu owns all queues in the first pipe */
> -		if (mec =3D=3D 0 && pipe =3D=3D 0)
> +		if (mec =3D=3D 0 && queue < 2)
>  			set_bit(i, adev->gfx.mec.queue_bitmap);
>  	}
> =20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> index 04b4448..0a16cab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1436,7 +1436,7 @@ static void gfx_v8_0_compute_queue_acquire(struct=
 amdgpu_device *adev)
>  			break;
> =20
>  		/* policy: amdgpu owns all queues in the first pipe */
> -		if (mec =3D=3D 0 && pipe =3D=3D 0)
> +		if (mec =3D=3D 0 && queue < 2)
>  			set_bit(i, adev->gfx.mec.queue_bitmap);
>  	}
> =20
>=20


--56t0AKWkRbpo1JTLBhXWW88Ac2bxhQtDt--

--XaSlQTcKXlh24REG7MlfRqIlo2Xs3op2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYlcRXAAoJEP4bvbfZuWjbHRcP/iERM7crLE+pgl83oQ+tctL0
zQUT9Z6kJU6f0K4fevuWAvovLJ2x7QELncz5KGOVeBO2FEvaFuC8SB+RZAbuVfG6
Se4C+Z2bi53ycxAsqNWsoymNd2JL7dPcOqeEkJ4OYPhc1J887zOJNbeSirGkgptg
+xwb16REaa3y9lC9Gc1Ow8mPffRq7HFQ6HrdxlWJsrXIuAHijqkyuM0XSWZCctzR
qdjiXOjKabFiUESqa8UIpVGjYBP6O9zRC8crY7yD3yPpFUOVh7zVumFgGIGR2/8G
Ykr5X5qZU8ciSMxAoLmr1QwN9wUpHKo4Cu5W/smRG18vcvnVZqt5oRvs4M5H59DJ
Ggc3zWo3lcZAWAhVq9ouvMyQFx9fWhGkOPwuSG4pNsfuYrhdijPEJ2Cum9tmCZVx
T3EdjXIzV2MwgFg3g1RXtG/4XwOre89lT0ps2mUideLg8z2aKdQmuuTmY/NMcnMK
nj/x2fiEuMVVnOoodTZULphsTXfMOAwsVLjQ4vhU0mQz4gQcIu5hMDx+F8/0s4u2
mYi2Ork/GeNodpP3XotRvuwXHoKjPWe1rXWgHw+y+kJJIYuKSChuf87fTPf65PlL
9BjbCvQ2XFtD87CQRXrjtpY/ihD8FYn4bZuCsPkaV+juvusFdBtu5KCsKQNxQa4a
dl3ZxNFs9mHMW4baFkZm
=Z6Sy
-----END PGP SIGNATURE-----

--XaSlQTcKXlh24REG7MlfRqIlo2Xs3op2X--

--===============0486900607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0486900607==--
