From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: Fix trace include path (v2)
Date: Fri, 1 Sep 2017 19:48:00 +0200
Message-ID: <20170901174800.GE25142@ulmo>
References: <20170901161423.6737-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1662061548=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170901161423.6737-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org


--===============1662061548==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2017 at 12:14:23PM -0400, Tom St Denis wrote:
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
>=20
> (v2): Drop Makefile change too.
> ---
>  drivers/gpu/drm/ttm/Makefile    | 2 +-
>  drivers/gpu/drm/ttm/ttm_trace.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmpnVAACgkQ3SOs138+
s6ERzg/+MvIV9uX+F+bSxU7HukjH7PSxgGo0f8+asc2VSfpdmAFPlgVnL+QmZuV9
FVns0Szx14k3yoSohiL3J3uMD+xXh+sHGoJbn+ocECb2HjqyVr5NWp2lGuMmtr8n
mALa9mblZM9+fyCJkqh0jXmhJOT22tWde51rX/F5t5IfIKXVcSB97Auaxvzorduo
eUfIwHkE+IRf1Y447/lbC/DWkYvUeCsRgFOhGyIeesEDSJ5eY6maXRcxtfQXutJ8
8QFReztu56+l7qLOv73fVLaRT4xJCedJCyY5rzJmD169oH7pXy7EqqlMaOfQ0twz
PwxFJmHo0KW7DBDcDGg4WJ4qAs6LeZJKi88Py2Y5f9XlEFEpibb8gDfponkp3I0c
7cahaIVuQgpPJhaYfRy8wV8gptkYYUwqvbHfrg/KpksnXIGIDjmvB8skOP9gKZXJ
gZ2g/ZkSwRLw0HyLCpnvMKxOmb/KAkLKs9KkB3ebKwSsn9Q+eHJTWlztePLKB52p
402yJ6bDPeFHZDRUu3a0m+10i4ec/3zO1bV8btIZ/WmH4ggA1WgcNrwTBpw7p0zm
FYNVcHSUyQW2wGAOWlLKkJF569P4CyWW8B12t55Bq6dNhmyFXj+B3gPbAITXo0GK
RAL9Sd1D3BO6gaoHW8pzi3WL2v1cyatdq+vvkBgy5FXEm1jsOP4=
=UvSQ
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--

--===============1662061548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1662061548==--
