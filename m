From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Tidy up cz_hwmgr.c
Date: Sun, 21 Aug 2016 15:46:20 +1000
Message-ID: <8a55225b-71c8-0195-8e28-3fb022213771@folklore1984.net>
References: <20160818142951.779-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0993565005=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160818142951.779-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0993565005==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mjErq3TqRqvCOtT5UjuWHCo1oJu0pXiXq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mjErq3TqRqvCOtT5UjuWHCo1oJu0pXiXq
Content-Type: multipart/mixed; boundary="TJ9LLEqigTr4Jl4aGclvhEunvSqXrUrL2"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <8a55225b-71c8-0195-8e28-3fb022213771-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Tidy up cz_hwmgr.c
References: <20160818142951.779-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20160818142951.779-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--TJ9LLEqigTr4Jl4aGclvhEunvSqXrUrL2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/19/2016 12:29 AM, Tom St Denis wrote:
> Clean up whitespace and formatting.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c | 53 +++++++-----------=
--------
>  1 file changed, 13 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index a1c070766d6a..0d54226754d1 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -178,7 +178,6 @@ static int cz_initialize_dpm_defaults(struct pp_hwm=
gr *hwmgr)
>  	int result;
> =20
>  	cz_hwmgr->gfx_ramp_step =3D 256*25/100;
> -
>  	cz_hwmgr->gfx_ramp_delay =3D 1; /* by default, we delay 1us */
> =20
>  	for (i =3D 0; i < CZ_MAX_HARDWARE_POWERLEVELS; i++)
> @@ -186,33 +185,19 @@ static int cz_initialize_dpm_defaults(struct pp_h=
wmgr *hwmgr)
> =20
>  	cz_hwmgr->mgcg_cgtt_local0 =3D 0x00000000;
>  	cz_hwmgr->mgcg_cgtt_local1 =3D 0x00000000;
> -
>  	cz_hwmgr->clock_slow_down_freq =3D 25000;
> -
>  	cz_hwmgr->skip_clock_slow_down =3D 1;
> -
>  	cz_hwmgr->enable_nb_ps_policy =3D 1; /* disable until UNB is ready, E=
nabled */
> -
>  	cz_hwmgr->voltage_drop_in_dce_power_gating =3D 0; /* disable until fu=
lly verified */
> -
>  	cz_hwmgr->voting_rights_clients =3D 0x00C00033;
> -
>  	cz_hwmgr->static_screen_threshold =3D 8;
> -
>  	cz_hwmgr->ddi_power_gating_disabled =3D 0;
> -
>  	cz_hwmgr->bapm_enabled =3D 1;
> -
>  	cz_hwmgr->voltage_drop_threshold =3D 0;
> -
>  	cz_hwmgr->gfx_power_gating_threshold =3D 500;
> -
>  	cz_hwmgr->vce_slow_sclk_threshold =3D 20000;
> -
>  	cz_hwmgr->dce_slow_sclk_threshold =3D 30000;
> -
>  	cz_hwmgr->disable_driver_thermal_policy =3D 1;
> -
>  	cz_hwmgr->disable_nb_ps3_in_battery =3D 0;
> =20
>  	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> @@ -230,9 +215,7 @@ static int cz_initialize_dpm_defaults(struct pp_hwm=
gr *hwmgr)
>  				  PHM_PlatformCaps_DynamicPatchPowerState);
> =20
>  	cz_hwmgr->thermal_auto_throttling_treshold =3D 0;
> -
>  	cz_hwmgr->tdr_clock =3D 0;
> -
>  	cz_hwmgr->disable_gfx_power_gating_in_uvd =3D 0;
> =20
>  	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> @@ -447,19 +430,12 @@ static int cz_construct_boot_state(struct pp_hwmg=
r *hwmgr)
>  			(uint8_t)cz_hwmgr->sys_info.bootup_nb_voltage_index;
> =20
>  	cz_hwmgr->boot_power_level.dsDividerIndex =3D 0;
> -
>  	cz_hwmgr->boot_power_level.ssDividerIndex =3D 0;
> -
>  	cz_hwmgr->boot_power_level.allowGnbSlow =3D 1;
> -
>  	cz_hwmgr->boot_power_level.forceNBPstate =3D 0;
> -
>  	cz_hwmgr->boot_power_level.hysteresis_up =3D 0;
> -
>  	cz_hwmgr->boot_power_level.numSIMDToPowerDown =3D 0;
> -
>  	cz_hwmgr->boot_power_level.display_wm =3D 0;
> -
>  	cz_hwmgr->boot_power_level.vce_wm =3D 0;
> =20
>  	return 0;
> @@ -746,7 +722,6 @@ static int cz_tf_update_sclk_limit(struct pp_hwmgr =
*hwmgr,
>  		cz_hwmgr->sclk_dpm.soft_max_clk  =3D table->entries[table->count - 1=
].clk;
> =20
>  	clock =3D hwmgr->display_config.min_core_set_clock;
> -;
>  	if (clock =3D=3D 0)
>  		printk(KERN_INFO "[ powerplay ] min_core_set_clock not set\n");
> =20
> @@ -829,7 +804,7 @@ static int cz_tf_set_watermark_threshold(struct pp_=
hwmgr *hwmgr,
> =20
>  	smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,
>  					PPSMC_MSG_SetWatermarkFrequency,
> -				      cz_hwmgr->sclk_dpm.soft_max_clk);
> +					cz_hwmgr->sclk_dpm.soft_max_clk);
> =20
>  	return 0;
>  }
> @@ -855,9 +830,9 @@ static int cz_tf_enable_nb_dpm(struct pp_hwmgr *hwm=
gr,
>  		PP_DBG_LOG("enabling ALL SMU features.\n");
>  		dpm_features |=3D NB_DPM_MASK;
>  		ret =3D smum_send_msg_to_smc_with_parameter(
> -							     hwmgr->smumgr,
> -					 PPSMC_MSG_EnableAllSmuFeatures,
> -							     dpm_features);
> +							  hwmgr->smumgr,
> +							  PPSMC_MSG_EnableAllSmuFeatures,
> +							  dpm_features);
>  		if (ret =3D=3D 0)
>  			cz_hwmgr->is_nb_dpm_enabled =3D true;
>  	}
> @@ -1399,10 +1374,12 @@ int cz_dpm_update_uvd_dpm(struct pp_hwmgr *hwmg=
r, bool bgate)
>  						   PPSMC_MSG_SetUvdHardMin));
> =20
>  			cz_enable_disable_uvd_dpm(hwmgr, true);
> -		} else
> +		} else {
>  			cz_enable_disable_uvd_dpm(hwmgr, true);
> -	} else
> +		}
> +	} else {
>  		cz_enable_disable_uvd_dpm(hwmgr, false);
> +	}
> =20
>  	return 0;
>  }
> @@ -1687,13 +1664,10 @@ static int cz_store_cc6_data(struct pp_hwmgr *h=
wmgr, uint32_t separation_time,
>  	struct cz_hwmgr *hw_data =3D (struct cz_hwmgr *)(hwmgr->backend);
> =20
>  	if (separation_time !=3D
> -		hw_data->cc6_settings.cpu_pstate_separation_time
> -		|| cc6_disable !=3D
> -		hw_data->cc6_settings.cpu_cc6_disable
> -		|| pstate_disable !=3D
> -		hw_data->cc6_settings.cpu_pstate_disable
> -		|| pstate_switch_disable !=3D
> -		hw_data->cc6_settings.nb_pstate_switch_disable) {
> +	    hw_data->cc6_settings.cpu_pstate_separation_time ||
> +	    cc6_disable !=3D hw_data->cc6_settings.cpu_cc6_disable ||
> +	    pstate_disable !=3D hw_data->cc6_settings.cpu_pstate_disable ||
> +	    pstate_switch_disable !=3D hw_data->cc6_settings.nb_pstate_switch=
_disable) {
> =20
>  		hw_data->cc6_settings.cc6_setting_changed =3D true;
> =20
> @@ -1796,8 +1770,7 @@ static int cz_get_performance_level(struct pp_hwm=
gr *hwmgr, const struct pp_hw_p
>  	ps =3D cast_const_PhwCzPowerState(state);
> =20
>  	level_index =3D index > ps->level - 1 ? ps->level - 1 : index;
> -
> -	level->coreClock  =3D ps->levels[level_index].engineClock;
> +	level->coreClock =3D ps->levels[level_index].engineClock;
> =20
>  	if (designation =3D=3D PHM_PerformanceLevelDesignation_PowerContainme=
nt) {
>  		for (i =3D 1; i < ps->level; i++) {
>=20


--TJ9LLEqigTr4Jl4aGclvhEunvSqXrUrL2--

--mjErq3TqRqvCOtT5UjuWHCo1oJu0pXiXq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXuUAsAAoJEP4bvbfZuWjbpDYQAKZBSni6Sa+SpnDCXsgN7lUS
f6Up1aksQ5Kc5IhUggvIwGwMvedefJ4XjI3wMZzPKzidPerL1M6xTHAKZd8fNX5B
739Qt+sV9pVukRiBl0ogiM9cccfzeONPmmfGVwTFrEgQmXb7ZzCQQxxV97lPT3OR
lhanezJ0Jss6ShIVLXIVEtisJp/n8zwOYr4vMPg7FpDTx/N+F9JwoWxaDorSLq/F
PakxwyPWJxZoWbHBym2WLIQLglQJTlqzxbq3A4OJTljAfsPid/SM3Fs8D3O1B6du
sedenqUWK5Gg18h/v3bFfLucz+wn4jbgmrkJkZ//g9IyF00y37/eqVt0JIn5LQCy
DCn61TuIN6oavbJGpcy35H5eXPtSzko0wG6OqkLdd8BApNXiKLOGyXXKRcs1pSz0
oEagOzE6Zy1IsM34NmaKRqR0wU3RuNaZXIYLgYB+VIh34/7PvYIk82fsIkr9/iwz
WHJZ0KOSB29eLkv/F1iwVwaCFua+HVMwOTRaic2d/bM2pjp1boONGs4SclsOGGK0
MYd7r9cWqf5d7hlQ2+QMOxVJgE+Wq9U553TaYw7bvGlPcc3mkdHrihna7ggdCHZS
7tde6nrZ+To25cjzGj4wRfw0r0YCGMXIsjjsy8e7fJy7YylLsGaEJ+/eQRnI+YPu
QLnjhmNMwfTAkTUebcQE
=hkFn
-----END PGP SIGNATURE-----

--mjErq3TqRqvCOtT5UjuWHCo1oJu0pXiXq--

--===============0993565005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0993565005==--
