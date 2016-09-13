From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/si/dpm: make a bunch of things static
Date: Tue, 13 Sep 2016 14:26:43 +1000
Message-ID: <3b479f68-4e55-df16-8752-d28a3cae426b@folklore1984.net>
References: <1473739884-13479-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0152785926=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473739884-13479-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0152785926==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mpmWKEjp5g43QtU1KFRfNWf3F0EKrCpD9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mpmWKEjp5g43QtU1KFRfNWf3F0EKrCpD9
Content-Type: multipart/mixed; boundary="MGnCg47jDSLtr137D3aAV8cSoT4PW5rru";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <3b479f68-4e55-df16-8752-d28a3cae426b-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/si/dpm: make a bunch of things static
References: <1473739884-13479-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1473739884-13479-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--MGnCg47jDSLtr137D3aAV8cSoT4PW5rru
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Patches 1&2 are,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 09/13/2016 02:11 PM, Alex Deucher wrote:
> remnants of the port from radeon.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c | 34 ++++++++++++++++-------------=
-----
>  1 file changed, 16 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/=
amdgpu/si_dpm.c
> index e4f7c10..374d92b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -91,7 +91,7 @@ union pplib_clock_info {
>  	struct _ATOM_PPLIB_SI_CLOCK_INFO si;
>  };
> =20
> -const u32 r600_utc[R600_PM_NUMBER_OF_TC] =3D
> +static const u32 r600_utc[R600_PM_NUMBER_OF_TC] =3D
>  {
>  	R600_UTC_DFLT_00,
>  	R600_UTC_DFLT_01,
> @@ -110,7 +110,7 @@ const u32 r600_utc[R600_PM_NUMBER_OF_TC] =3D
>  	R600_UTC_DFLT_14,
>  };
> =20
> -const u32 r600_dtc[R600_PM_NUMBER_OF_TC] =3D
> +static const u32 r600_dtc[R600_PM_NUMBER_OF_TC] =3D
>  {
>  	R600_DTC_DFLT_00,
>  	R600_DTC_DFLT_01,
> @@ -432,7 +432,7 @@ static const struct si_dte_data dte_data_malta =3D
>  	true
>  };
> =20
> -struct si_cac_config_reg cac_weights_pitcairn[] =3D
> +static const struct si_cac_config_reg cac_weights_pitcairn[] =3D
>  {
>  	{ 0x0, 0x0000ffff, 0, 0x8a, SISLANDS_CACCONFIG_CGIND },
>  	{ 0x0, 0xffff0000, 16, 0x0, SISLANDS_CACCONFIG_CGIND },
> @@ -1188,7 +1188,7 @@ static const struct si_dte_data dte_data_venus_pr=
o =3D
>  	true
>  };
> =20
> -struct si_cac_config_reg cac_weights_oland[] =3D
> +static const struct si_cac_config_reg cac_weights_oland[] =3D
>  {
>  	{ 0x0, 0x0000ffff, 0, 0x82, SISLANDS_CACCONFIG_CGIND },
>  	{ 0x0, 0xffff0000, 16, 0x4F, SISLANDS_CACCONFIG_CGIND },
> @@ -1825,10 +1825,10 @@ static const struct si_powertune_data powertune=
_data_hainan =3D
>  	true
>  };
> =20
> -struct rv7xx_power_info *rv770_get_pi(struct amdgpu_device *adev);
> -struct evergreen_power_info *evergreen_get_pi(struct amdgpu_device *ad=
ev);
> -struct ni_power_info *ni_get_pi(struct amdgpu_device *adev);
> -struct  si_ps *si_get_ps(struct amdgpu_ps *rps);
> +static struct rv7xx_power_info *rv770_get_pi(struct amdgpu_device *ade=
v);
> +static struct evergreen_power_info *evergreen_get_pi(struct amdgpu_dev=
ice *adev);
> +static struct ni_power_info *ni_get_pi(struct amdgpu_device *adev);
> +static struct  si_ps *si_get_ps(struct amdgpu_ps *rps);
> =20
>  static int si_populate_voltage_value(struct amdgpu_device *adev,
>  				     const struct atom_voltage_table *table,
> @@ -1850,8 +1850,6 @@ static void si_fan_ctrl_set_default_mode(struct a=
mdgpu_device *adev);
>  static void si_dpm_set_dpm_funcs(struct amdgpu_device *adev);
>  static void si_dpm_set_irq_funcs(struct amdgpu_device *adev);
> =20
> -extern u32 si_pciep_rreg(struct amdgpu_device *adev, u32 reg);
> -
>  static struct si_power_info *si_get_pi(struct amdgpu_device *adev)
>  {
>  	struct si_power_info *pi =3D adev->pm.dpm.priv;
> @@ -1954,21 +1952,21 @@ static void si_update_dte_from_pl2(struct amdgp=
u_device *adev,
>  	}
>  }
> =20
> -struct rv7xx_power_info *rv770_get_pi(struct amdgpu_device *adev)
> +static struct rv7xx_power_info *rv770_get_pi(struct amdgpu_device *ade=
v)
>  {
>  	struct rv7xx_power_info *pi =3D adev->pm.dpm.priv;
> =20
>  	return pi;
>  }
> =20
> -struct ni_power_info *ni_get_pi(struct amdgpu_device *adev)
> +static struct ni_power_info *ni_get_pi(struct amdgpu_device *adev)
>  {
>  	struct ni_power_info *pi =3D adev->pm.dpm.priv;
> =20
>  	return pi;
>  }
> =20
> -struct  si_ps *si_get_ps(struct amdgpu_ps *aps)
> +static struct si_ps *si_get_ps(struct amdgpu_ps *aps)
>  {
>  	struct  si_ps *ps =3D aps->ps_priv;
> =20
> @@ -3257,8 +3255,8 @@ static u32 btc_get_valid_sclk(struct amdgpu_devic=
e *adev,
>  				    max_sclk, requested_sclk);
>  }
> =20
> -void btc_get_max_clock_from_voltage_dependency_table(struct amdgpu_clo=
ck_voltage_dependency_table *table,
> -						     u32 *max_clock)
> +static void btc_get_max_clock_from_voltage_dependency_table(struct amd=
gpu_clock_voltage_dependency_table *table,
> +							    u32 *max_clock)
>  {
>  	u32 i, clock =3D 0;
> =20
> @@ -4308,7 +4306,7 @@ static void si_clear_vc(struct amdgpu_device *ade=
v)
>  	WREG32(CG_FTV, 0);
>  }
> =20
> -u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock)
> +static u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock)
>  {
>  	u8 mc_para_index;
> =20
> @@ -4321,7 +4319,7 @@ u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_cl=
ock)
>  	return mc_para_index;
>  }
> =20
> -u8 si_get_mclk_frequency_ratio(u32 memory_clock, bool strobe_mode)
> +static u8 si_get_mclk_frequency_ratio(u32 memory_clock, bool strobe_mo=
de)
>  {
>  	u8 mc_para_index;
> =20
> @@ -7561,7 +7559,7 @@ static int si_dpm_set_interrupt_state(struct amdg=
pu_device *adev,
>  }
> =20
>  static int si_dpm_process_interrupt(struct amdgpu_device *adev,
> -				    struct amdgpu_irq_src *source,=20
> +				    struct amdgpu_irq_src *source,
>  				    struct amdgpu_iv_entry *entry)
>  {
>  	bool queue_thermal =3D false;
>=20


--MGnCg47jDSLtr137D3aAV8cSoT4PW5rru--

--mpmWKEjp5g43QtU1KFRfNWf3F0EKrCpD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX14ADAAoJEP4bvbfZuWjbCQAQAM1Ta8HuvLwYw2PYm7KXtk7y
HlFw8qGTOH17cZaedyw/HLb+B1I6ReqmEygHD93XZUOTnLjcPSi/Vsvm209Nv05w
8YObWVZPLjF/jDqhOP3QNBIqLo5fYykVtwI20SdFEoxcoIbY28xqb0vqz/0RSrod
BHf2+gz6nhWjLc5o8gdpt3WV81nB245k+o4d2pC9F/ZFHj6Q675rPBtuu48rdUmi
aEMPXETp9rQskeyuU/dUmii3w7GBIlYWLUjbpw7ZYaHxvLkS+AKX0/oVMDXE294e
/j9GosyH/fZ4dbvd5oOKV+avMoG1iN1Absr9xDuNVfGlrRqLAh4DX2A/5Och613Y
thpYlNTLfMoIInXw3iJZ5O+ifWIiO5HwhfayC0Rugh2FwxqpcJAH6GvasjANoKZu
ZsLSZn8cEXyClv48TtykTYkuG5hnFX5TXh/znKL1DAsRKzfqc0bvocMosrcL86LR
GAAL3PWPkdRAVgINpCNJ8NdoH9xtaGZO2XKJBcSdbXeiBgDiqD3vIrsmLmvONNez
xnB6nFQlG0KumF9mwwBiUYs78nNdTRAFeEpUeOkcpJQTMq+c06ZlNawQuwk783Vx
KIAMwwe4h3hxZKqGxFptY6STFQqRcnZl3NgXxVUMSqycYcbiNurk3n6AToCgIDum
V86gbHZS9OchBcd+MmSo
=OMGB
-----END PGP SIGNATURE-----

--mpmWKEjp5g43QtU1KFRfNWf3F0EKrCpD9--

--===============0152785926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0152785926==--
