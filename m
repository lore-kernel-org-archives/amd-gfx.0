From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 3/4] drm: Document variable refresh properties
Date: Fri, 26 Oct 2018 14:37:19 +0300
Message-ID: <20181026143719.01381cdd@eldfell>
References: <20181011163942.28267-1-nicholas.kazlauskas@amd.com>
 <20181011163942.28267-4-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0332818700=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181011163942.28267-4-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
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
To: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: daniel.vetter-/w4YWyX8dFk@public.gmane.org, michel-otUistvHUpPR7s880joybQ@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Marek.Olsak-5C7GfCeVMHo@public.gmane.org

--===============0332818700==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Q3UrFW7TGHYi7FQ9qIaAqn4"; protocol="application/pgp-signature"

--Sig_/Q3UrFW7TGHYi7FQ9qIaAqn4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Oct 2018 12:39:41 -0400
Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:

> These include the drm_connector 'vrr_capable' and the drm_crtc
> 'vrr_enabled' properties.
>=20
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
> ---
>  Documentation/gpu/drm-kms.rst   |  7 +++++++
>  drivers/gpu/drm/drm_connector.c | 22 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> index 4b1501b4835b..8da2a178cf85 100644
> --- a/Documentation/gpu/drm-kms.rst
> +++ b/Documentation/gpu/drm-kms.rst
> @@ -575,6 +575,13 @@ Explicit Fencing Properties
>  .. kernel-doc:: drivers/gpu/drm/drm_atomic_uapi.c
>     :doc: explicit fencing properties
> =20
> +
> +Variable Refresh Properties
> +---------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_connector.c
> +   :doc: Variable refresh properties
> +
>  Existing KMS Properties
>  -----------------------
> =20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index f0deeb7298d0..2a12853ca917 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1254,6 +1254,28 @@ int drm_mode_create_scaling_mode_property(struct d=
rm_device *dev)
>  }
>  EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
> =20
> +/**
> + * DOC: Variable refresh properties
> + *
> + * Variable refresh rate control is supported via properties on the
> + * &drm_connector and &drm_crtc objects.
> + *
> + * "vrr_capable":
> + *	Optional &drm_connector boolean property that drivers should attach
> + *	with drm_connector_attach_vrr_capable_property() on connectors that
> + *	could support variable refresh rates. Drivers should update the
> + *	property value by calling drm_connector_set_vrr_capable_property().
> + *
> + *	Absence of the property should indicate absence of support.
> + *
> + * "vrr_enabled":
> + *	Default &drm_crtc boolean property that notifies the driver that the
> + *	variable refresh rate adjustment should be enabled for the CRTC.

Hi,

where is the documentation that explains how drivers must implement
"variable refresh rate adjustment"?

What should and could userspace expect to get if it flicks this switch?

I also think the kernel documentation should include a description of
what VRR actually is and how it conceptually works as far as userspace
is concerned.

That is, the kernel documentation should describe what this thing does,
so that we avoid every driver implementing a different thing. For
example, one driver could prevent the luminance flickering itself by
tuning the timings while another driver might not do that, which means
that an application tested on the former driver will look just fine
while it is unbearable to watch on the latter.


Thanks,
pq

> + *
> + *	Support for variable refresh rate will depend on the "vrr_capable"
> + *	property exposed on the &drm_connector object.
> + */
> +
>  /**
>   * drm_connector_attach_vrr_capable_property - creates the
>   * vrr_capable property


--Sig_/Q3UrFW7TGHYi7FQ9qIaAqn4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlvS/G8ACgkQI1/ltBGq
qqfZVw//ZsPlC7x0xSry7eF9rfnwECAjsJtIxsxssh1WkJjui/fePTnw7H5+q7/X
WBPJHQzaUTxbvMyg+ijEkBR+1r2R0jKmILTqHD8hT1wpJel7H/PMVpBdssqualMM
iUeVfQnLRZ/3crZUZticeKgODRyvCqgkC0dOs+MxuWFv2qJXaRR9BuGa4gYEy+rv
ME7GF74yUCsr6i6mWj5GjT0FJLln80lkklyQIPfUQvNS5kSzhY7nF4GcnT6d1h77
KrQHFvmMN6QdlyKMySVtWh5VHocFcZ8PNCnVyODMbco4EQhv0NZBItGprZOObicW
Gf39QN6D/+2eszXNPZA2btXIIy0fCLVA3RcHHWr+sEJAPXfutt+KY3teV2sPixda
LlRFXYG/EohAYdcsBHfQkxFWD0trhBqmQ2mgZJhds7LjUZu+y1RSF/T+hrYk2BP7
JVfuMZssQzGDWG32SPViVHHdkxsMZbGX05ZBj2NHdM5VCeoSat3Cm/I34v+o0cpn
3gw9XcPfQEzSkJ6ZBmLZRX4XTJUszbW0wfgZH9Y6anrqV6pYWsUnT6dAVE7cHTnj
6cURXu+d96zYIhFaPRVPkbFgNEhK072f7FqL/MzuUIAA0Nl1NcPm9Wc/j/isPhMB
VMphgC3WSIgi+culc10NgecSWxekX+PcMpU+0bHuzb1TyLUdopA=
=HxRX
-----END PGP SIGNATURE-----

--Sig_/Q3UrFW7TGHYi7FQ9qIaAqn4--

--===============0332818700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0332818700==--
