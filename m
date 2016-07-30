From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 03/11] drm/amd: add recover run queue for scheduler
Date: Sat, 30 Jul 2016 13:52:38 +1000
Message-ID: <1844bba5-25b0-65e5-045c-5ae4c9b22baf@folklore1984.net>
References: <1469700828-25650-1-git-send-email-David1.Zhou@amd.com>
 <1469700828-25650-4-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0410146017=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469700828-25650-4-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
--===============0410146017==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LegVbcXFq4h7poo6MrMeQr8WU3vFGd262"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LegVbcXFq4h7poo6MrMeQr8WU3vFGd262
Content-Type: multipart/mixed; boundary="hDqNIGQD4IOliaas5c4xOISdDoNNiK0vn"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <1844bba5-25b0-65e5-045c-5ae4c9b22baf-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 03/11] drm/amd: add recover run queue for scheduler
References: <1469700828-25650-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1469700828-25650-4-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1469700828-25650-4-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--hDqNIGQD4IOliaas5c4xOISdDoNNiK0vn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 07/28/2016 08:13 PM, Chunming Zhou wrote:
> Change-Id: I7171d1e3884aabe1263d8f7be18cadf2e98216a4
> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h b/drivers/gp=
u/drm/amd/scheduler/gpu_scheduler.h
> index a1c0073..cd87bc7 100644
> --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> @@ -112,7 +112,8 @@ struct amd_sched_backend_ops {
>  };
> =20
>  enum amd_sched_priority {
> -	AMD_SCHED_PRIORITY_KERNEL =3D 0,
> +	AMD_SCHED_PRIORITY_RECOVER =3D 0,
> +	AMD_SCHED_PRIORITY_KERNEL,
>  	AMD_SCHED_PRIORITY_NORMAL,
>  	AMD_SCHED_MAX_PRIORITY
>  };
>=20


--hDqNIGQD4IOliaas5c4xOISdDoNNiK0vn--

--LegVbcXFq4h7poo6MrMeQr8WU3vFGd262
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXnCSGAAoJEP4bvbfZuWjbsE0QANnMj2+svtnpZSXUQroWPbOB
QGuyENRrQ4EvGWigR4VSuEsKQSD1pgQHCI88lme5CdG+L2DoT0hUjrEePrWClhWn
MUHHH0kti9R2vFVC85G8xzCVlU3WZki4rSFMg0S2B8b7s73cWLtvscNOCdC2Mmnj
Xvio5gn62e8emA66R/lHY3xcMV8HOivhpZe/unTxGPvPpnPaPo8F8r90GUtwsmCP
yZe0xRilvu3orTR5so2F8BIZ4ZapVtojci1zObXIjDTYperIut1Y9l6yKlz3kHke
OLtm+5Nww0E7lmvFQzQjozGlVTMRyy1Z2XlduADFEiQ6+VKaopsN7MkDDZBmMWtg
6Ckt+ngkncbv4vvdkvFu3nWjqSq5moyrbuo75oOhPodZ5n/N+6+fIt7WN17FvVvd
+wrFveI1ajUwx0glaIt0+ldG/4CoZkbu2u8aUPkpIBFmk7GtrUx7hqLFAUu6JlH2
6E9NWIiD6wsAT0+A9N5b0URFX/EJpptyo0gR2Ecekq8aPThvrKMEYbmEfvS3Iz0S
UGAJ0M8JxqX530vluK6DdjDeC26Vx6satBTyyZPQYPbnD6Nk3X4zi6X9EPhYI2xQ
E3eo6xCrVDuaf6qNy9BgUYtBkQ1MotH22mjWh4dQVUfiT+B3r5t8EjofnROu8L0n
QXd6TmGPE3qv1jpw5O2S
=XwJl
-----END PGP SIGNATURE-----

--LegVbcXFq4h7poo6MrMeQr8WU3vFGd262--

--===============0410146017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0410146017==--
