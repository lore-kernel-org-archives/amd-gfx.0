From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/atom: remove a bunch of unused functions
Date: Sat, 22 Oct 2016 19:06:43 +1100
Message-ID: <77779d91-8ccd-4809-3630-c15bf7c5682d@folklore1984.net>
References: <1477079709-10093-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0060249293=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477079709-10093-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============0060249293==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hKxdPGB2O4K1w2DP5BxSMUa4jjB1XAq7O"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hKxdPGB2O4K1w2DP5BxSMUa4jjB1XAq7O
Content-Type: multipart/mixed; boundary="Kugs1it0cDxGNNjdOKlsV7TAJgd02PCXT";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <77779d91-8ccd-4809-3630-c15bf7c5682d-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/atom: remove a bunch of unused functions
References: <1477079709-10093-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1477079709-10093-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--Kugs1it0cDxGNNjdOKlsV7TAJgd02PCXT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 10/22/2016 06:55 AM, Alex Deucher wrote:
> Leftovers from the radeon.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 82 --------------------=
--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h | 10 ----
>  2 files changed, 92 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atombios.c
> index 76cbb1d..56a86dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1115,49 +1115,6 @@ int amdgpu_atombios_get_memory_pll_dividers(stru=
ct amdgpu_device *adev,
>  	return 0;
>  }
> =20
> -uint32_t amdgpu_atombios_get_engine_clock(struct amdgpu_device *adev)
> -{
> -	GET_ENGINE_CLOCK_PS_ALLOCATION args;
> -	int index =3D GetIndexIntoMasterTable(COMMAND, GetEngineClock);
> -
> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint3=
2_t *)&args);
> -	return le32_to_cpu(args.ulReturnEngineClock);
> -}
> -
> -uint32_t amdgpu_atombios_get_memory_clock(struct amdgpu_device *adev)
> -{
> -	GET_MEMORY_CLOCK_PS_ALLOCATION args;
> -	int index =3D GetIndexIntoMasterTable(COMMAND, GetMemoryClock);
> -
> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint3=
2_t *)&args);
> -	return le32_to_cpu(args.ulReturnMemoryClock);
> -}
> -
> -void amdgpu_atombios_set_engine_clock(struct amdgpu_device *adev,
> -				      uint32_t eng_clock)
> -{
> -	SET_ENGINE_CLOCK_PS_ALLOCATION args;
> -	int index =3D GetIndexIntoMasterTable(COMMAND, SetEngineClock);
> -
> -	args.ulTargetEngineClock =3D cpu_to_le32(eng_clock);	/* 10 khz */
> -
> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint3=
2_t *)&args);
> -}
> -
> -void amdgpu_atombios_set_memory_clock(struct amdgpu_device *adev,
> -				      uint32_t mem_clock)
> -{
> -	SET_MEMORY_CLOCK_PS_ALLOCATION args;
> -	int index =3D GetIndexIntoMasterTable(COMMAND, SetMemoryClock);
> -
> -	if (adev->flags & AMD_IS_APU)
> -		return;
> -
> -	args.ulTargetMemoryClock =3D cpu_to_le32(mem_clock);	/* 10 khz */
> -
> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint3=
2_t *)&args);
> -}
> -
>  void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *ade=
v,
>  					     u32 eng_clock, u32 mem_clock)
>  {
> @@ -1256,45 +1213,6 @@ int amdgpu_atombios_get_leakage_vddc_based_on_le=
akage_idx(struct amdgpu_device *
>  	return amdgpu_atombios_get_max_vddc(adev, VOLTAGE_TYPE_VDDC, leakage_=
idx, voltage);
>  }
> =20
> -void amdgpu_atombios_set_voltage(struct amdgpu_device *adev,
> -				 u16 voltage_level,
> -				 u8 voltage_type)
> -{
> -	union set_voltage args;
> -	int index =3D GetIndexIntoMasterTable(COMMAND, SetVoltage);
> -	u8 frev, crev, volt_index =3D voltage_level;
> -
> -	if (!amdgpu_atom_parse_cmd_header(adev->mode_info.atom_context, index=
, &frev, &crev))
> -		return;
> -
> -	/* 0xff01 is a flag rather then an actual voltage */
> -	if (voltage_level =3D=3D 0xff01)
> -		return;
> -
> -	switch (crev) {
> -	case 1:
> -		args.v1.ucVoltageType =3D voltage_type;
> -		args.v1.ucVoltageMode =3D SET_ASIC_VOLTAGE_MODE_ALL_SOURCE;
> -		args.v1.ucVoltageIndex =3D volt_index;
> -		break;
> -	case 2:
> -		args.v2.ucVoltageType =3D voltage_type;
> -		args.v2.ucVoltageMode =3D SET_ASIC_VOLTAGE_MODE_SET_VOLTAGE;
> -		args.v2.usVoltageLevel =3D cpu_to_le16(voltage_level);
> -		break;
> -	case 3:
> -		args.v3.ucVoltageType =3D voltage_type;
> -		args.v3.ucVoltageMode =3D ATOM_SET_VOLTAGE;
> -		args.v3.usVoltageLevel =3D cpu_to_le16(voltage_level);
> -		break;
> -	default:
> -		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
> -		return;
> -	}
> -
> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint3=
2_t *)&args);
> -}
> -
>  int amdgpu_atombios_get_leakage_id_from_vbios(struct amdgpu_device *ad=
ev,
>  					      u16 *leakage_id)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atombios.h
> index e4afb16..70e9ace 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> @@ -163,16 +163,6 @@ int amdgpu_atombios_get_memory_pll_dividers(struct=
 amdgpu_device *adev,
>  					    bool strobe_mode,
>  					    struct atom_mpll_param *mpll_param);
> =20
> -uint32_t amdgpu_atombios_get_engine_clock(struct amdgpu_device *adev);=

> -uint32_t amdgpu_atombios_get_memory_clock(struct amdgpu_device *adev);=

> -void amdgpu_atombios_set_engine_clock(struct amdgpu_device *adev,
> -				      uint32_t eng_clock);
> -void amdgpu_atombios_set_memory_clock(struct amdgpu_device *adev,
> -				      uint32_t mem_clock);
> -void amdgpu_atombios_set_voltage(struct amdgpu_device *adev,
> -				 u16 voltage_level,
> -				 u8 voltage_type);
> -
>  void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *ade=
v,
>  					     u32 eng_clock, u32 mem_clock);
> =20
>=20


--Kugs1it0cDxGNNjdOKlsV7TAJgd02PCXT--

--hKxdPGB2O4K1w2DP5BxSMUa4jjB1XAq7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYCx4UAAoJEP4bvbfZuWjbOJEP/jYLvOUtONZBTZ7ycV1DQrZk
mZKwDRIskrbbxOURqDv25cBQnmGxsHlNoMpyjIRdU1kOsYnvjmKEbY4ZYE/XnCZ2
WRNseyrldRSpirC3sM5STh4nTZ4CngadpGJiOXIf0qwIlYyPm1pQrPcvP9YllbqT
Ks9J84FFpziCFjzQLJ2tLYUU3Qgt39RV6wfu64tf/L6XMXo6DFhnlAkD8SBHxaVk
6K1wawQzia+lSenRLIszvabzpqC6FbL3PZTBv+4/23VR+UYGImcYPkWc3N0TglhX
GHwtcgqwxPJTUMTgweQUNazJyxDQwhiwvPYxH6t+ybCkoNBBCcB9ju/swnBqymhF
roO2WtHSf5krKl+DgGz69Q8jSBwW84vO/oIfSgbWHVKpVTF+037K7w39NPnDOSJU
TJqQc85jM/VYRNXU5vUkxtltNGLzLHgYdFEJlUyGdqix22DKyhQDAdHrCQ1xy9sb
/Hwbvj6B1AjMuSieSLe1fnc4XmpfUuEiOZG+bnIU3LgavzdPmM3AtqPvOwCXCalF
dNlt9rTOEY/rn63O+5wDfzh3jcGK7sv/I6rpSg7rlq/O9aG7na/HDkgBGCNn8Vr9
D011BPYxaUxfVTloQxoJCqB3PXG5uX4eOCw2YUvG7yhObqrhL+SWp99lxpAPoJ1m
kNw8aqehWS3MQEWbDLTR
=iDvy
-----END PGP SIGNATURE-----

--hKxdPGB2O4K1w2DP5BxSMUa4jjB1XAq7O--

--===============0060249293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0060249293==--
