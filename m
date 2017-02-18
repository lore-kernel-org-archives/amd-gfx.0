From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 17/35] drivers/gpu: Convert remaining uses of pr_warning
 to pr_warn
Date: Sat, 18 Feb 2017 16:03:46 +1100
Message-ID: <cf561df1-05ea-8da0-58ae-2b8664c395ab@folklore1984.net>
References: <cover.1487314666.git.joe@perches.com>
 <89288c2354690be744b72b27e39f317cb1c5310d.1487314667.git.joe@perches.com>
 <c78cbc49-9fd1-ae7c-3e8e-5fc3c76cd75f@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1889311106=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c78cbc49-9fd1-ae7c-3e8e-5fc3c76cd75f-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1889311106==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5QcFV2hM9LMj73vVNf6Nmbf3wwdB44lXE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5QcFV2hM9LMj73vVNf6Nmbf3wwdB44lXE
Content-Type: multipart/mixed; boundary="XF5DJvdlIoiBWcI1aDTdedCsuGIBpR1gW";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>,
 Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie
 <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <cf561df1-05ea-8da0-58ae-2b8664c395ab-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 17/35] drivers/gpu: Convert remaining uses of pr_warning
 to pr_warn
References: <cover.1487314666.git.joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
 <89288c2354690be744b72b27e39f317cb1c5310d.1487314667.git.joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
 <c78cbc49-9fd1-ae7c-3e8e-5fc3c76cd75f-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <c78cbc49-9fd1-ae7c-3e8e-5fc3c76cd75f-5C7GfCeVMHo@public.gmane.org>

--XF5DJvdlIoiBWcI1aDTdedCsuGIBpR1gW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/18/2017 01:22 AM, Christian K=C3=B6nig wrote:
> Am 17.02.2017 um 08:11 schrieb Joe Perches:
>> To enable eventual removal of pr_warning
>>
>> This makes pr_warn use consistent for drivers/gpu
>>
>> Prior to this patch, there were 15 uses of pr_warning and
>> 20 uses of pr_warn in drivers/gpu
>>
>> Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
>=20
> Acked-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

>=20
>> ---
>>   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c     |  2 +-
>>   drivers/gpu/drm/amd/powerplay/inc/pp_debug.h         |  2 +-
>>   drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c      |  4 ++--
>>   drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c   | 14
>> +++++++-------
>>   drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c |  4 ++--
>>   drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c     |  4 ++--
>>   6 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> index b1de9e8ccdbc..83266408634e 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> @@ -1535,7 +1535,7 @@ static int smu7_get_evv_voltages(struct pp_hwmgr=

>> *hwmgr)
>>                       if (vddc >=3D 2000 || vddc =3D=3D 0)
>>                           return -EINVAL;
>>                   } else {
>> -                    pr_warning("failed to retrieving EVV voltage!\n")=
;
>> +                    pr_warn("failed to retrieving EVV voltage!\n");
>>                       continue;
>>                   }
>>   diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
>> b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
>> index 072880130cfb..f3f9ebb631a5 100644
>> --- a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
>> +++ b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
>> @@ -37,7 +37,7 @@
>>   #define PP_ASSERT_WITH_CODE(cond, msg, code)    \
>>       do {                    \
>>           if (!(cond)) {            \
>> -            pr_warning("%s\n", msg);    \
>> +            pr_warn("%s\n", msg);    \
>>               code;            \
>>           }                \
>>       } while (0)
>> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c
>> b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c
>> index 0f7a77b7312e..5450f5ef8e89 100644
>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c
>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c
>> @@ -2131,7 +2131,7 @@ uint32_t fiji_get_offsetof(uint32_t type,
>> uint32_t member)
>>               return offsetof(SMU73_Discrete_DpmTable,
>> LowSclkInterruptThreshold);
>>           }
>>       }
>> -    pr_warning("can't get the offset of type %x member %x\n", type,
>> member);
>> +    pr_warn("can't get the offset of type %x member %x\n", type,
>> member);
>>       return 0;
>>   }
>>   @@ -2156,7 +2156,7 @@ uint32_t fiji_get_mac_definition(uint32_t valu=
e)
>>           return SMU73_MAX_LEVELS_MVDD;
>>       }
>>   -    pr_warning("can't get the mac of %x\n", value);
>> +    pr_warn("can't get the mac of %x\n", value);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
>> b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
>> index ad82161df831..51adf04ab4b3 100644
>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
>> @@ -122,7 +122,7 @@ static void
>> iceland_initialize_power_tune_defaults(struct pp_hwmgr *hwmgr)
>>           break;
>>       default:
>>           smu_data->power_tune_defaults =3D &defaults_iceland;
>> -        pr_warning("Unknown V.I. Device ID.\n");
>> +        pr_warn("Unknown V.I. Device ID.\n");
>>           break;
>>       }
>>       return;
>> @@ -378,7 +378,7 @@ static int
>> iceland_get_std_voltage_value_sidd(struct pp_hwmgr *hwmgr,
>>               return -EINVAL);
>>         if (NULL =3D=3D hwmgr->dyn_state.cac_leakage_table) {
>> -        pr_warning("CAC Leakage Table does not exist, using vddc.\n")=
;
>> +        pr_warn("CAC Leakage Table does not exist, using vddc.\n");
>>           return 0;
>>       }
>>   @@ -394,7 +394,7 @@ static int
>> iceland_get_std_voltage_value_sidd(struct pp_hwmgr *hwmgr,
>>                   *lo =3D
>> hwmgr->dyn_state.cac_leakage_table->entries[v_index].Vddc *
>> VOLTAGE_SCALE;
>>                   *hi =3D
>> (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[v_index].Leakag=
e *
>> VOLTAGE_SCALE);
>>               } else {
>> -                pr_warning("Index from SCLK/VDDC Dependency Table
>> exceeds the CAC Leakage Table index, using maximum index from CAC
>> table.\n");
>> +                pr_warn("Index from SCLK/VDDC Dependency Table
>> exceeds the CAC Leakage Table index, using maximum index from CAC
>> table.\n");
>>                   *lo =3D
>> hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_state.cac_leaka=
ge_table->count
>> - 1].Vddc * VOLTAGE_SCALE;
>>                   *hi =3D
>> (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_stat=
e.cac_leakage_table->count
>> - 1].Leakage * VOLTAGE_SCALE);
>>               }
>> @@ -414,7 +414,7 @@ static int
>> iceland_get_std_voltage_value_sidd(struct pp_hwmgr *hwmgr,
>>                       *lo =3D
>> hwmgr->dyn_state.cac_leakage_table->entries[v_index].Vddc *
>> VOLTAGE_SCALE;
>>                       *hi =3D
>> (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[v_index].Leakag=
e)
>> * VOLTAGE_SCALE;
>>                   } else {
>> -                    pr_warning("Index from SCLK/VDDC Dependency Table=

>> exceeds the CAC Leakage Table index in second look up, using maximum
>> index from CAC table.");
>> +                    pr_warn("Index from SCLK/VDDC Dependency Table
>> exceeds the CAC Leakage Table index in second look up, using maximum
>> index from CAC table.");
>>                       *lo =3D
>> hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_state.cac_leaka=
ge_table->count
>> - 1].Vddc * VOLTAGE_SCALE;
>>                       *hi =3D
>> (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_stat=
e.cac_leakage_table->count
>> - 1].Leakage * VOLTAGE_SCALE);
>>                   }
>> @@ -423,7 +423,7 @@ static int
>> iceland_get_std_voltage_value_sidd(struct pp_hwmgr *hwmgr,
>>           }
>>             if (!vol_found)
>> -            pr_warning("Unable to get std_vddc from SCLK/VDDC
>> Dependency Table, using vddc.\n");
>> +            pr_warn("Unable to get std_vddc from SCLK/VDDC Dependency=

>> Table, using vddc.\n");
>>       }
>>         return 0;
>> @@ -2146,7 +2146,7 @@ uint32_t iceland_get_offsetof(uint32_t type,
>> uint32_t member)
>>               return offsetof(SMU71_Discrete_DpmTable,
>> LowSclkInterruptThreshold);
>>           }
>>       }
>> -    pr_warning("can't get the offset of type %x member %x\n", type,
>> member);
>> +    pr_warn("can't get the offset of type %x member %x\n", type,
>> member);
>>       return 0;
>>   }
>>   @@ -2169,7 +2169,7 @@ uint32_t iceland_get_mac_definition(uint32_t
>> value)
>>           return SMU71_MAX_LEVELS_MVDD;
>>       }
>>   -    pr_warning("can't get the mac of %x\n", value);
>> +    pr_warn("can't get the mac of %x\n", value);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
>> b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
>> index 0e26900e459e..deec874d874f 100644
>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
>> @@ -2180,7 +2180,7 @@ uint32_t polaris10_get_offsetof(uint32_t type,
>> uint32_t member)
>>               return offsetof(SMU74_Discrete_DpmTable,
>> LowSclkInterruptThreshold);
>>           }
>>       }
>> -    pr_warning("can't get the offset of type %x member %x\n", type,
>> member);
>> +    pr_warn("can't get the offset of type %x member %x\n", type,
>> member);
>>       return 0;
>>   }
>>   @@ -2207,7 +2207,7 @@ uint32_t polaris10_get_mac_definition(uint32_t=

>> value)
>>           return SMU7_UVD_MCLK_HANDSHAKE_DISABLE;
>>       }
>>   -    pr_warning("can't get the mac of %x\n", value);
>> +    pr_warn("can't get the mac of %x\n", value);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
>> b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
>> index 331b0aba4a13..4d1439a498eb 100644
>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
>> @@ -2657,7 +2657,7 @@ uint32_t tonga_get_offsetof(uint32_t type,
>> uint32_t member)
>>               return offsetof(SMU72_Discrete_DpmTable,
>> LowSclkInterruptThreshold);
>>           }
>>       }
>> -    pr_warning("can't get the offset of type %x member %x\n", type,
>> member);
>> +    pr_warn("can't get the offset of type %x member %x\n", type,
>> member);
>>       return 0;
>>   }
>>   @@ -2681,7 +2681,7 @@ uint32_t tonga_get_mac_definition(uint32_t val=
ue)
>>       case SMU_MAX_LEVELS_MVDD:
>>           return SMU72_MAX_LEVELS_MVDD;
>>       }
>> -    pr_warning("can't get the mac value %x\n", value);
>> +    pr_warn("can't get the mac value %x\n", value);
>>         return 0;
>>   }
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--XF5DJvdlIoiBWcI1aDTdedCsuGIBpR1gW--

--5QcFV2hM9LMj73vVNf6Nmbf3wwdB44lXE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYp9WyAAoJEP4bvbfZuWjbN18QAM+M2JXuH6IP6K/YkpNEWwZZ
kEzSW/kO7nRs0zoFF4kKOLtYlRmpAVV/Wv4DqSTImmys4/ac5xICBE9Ke1b+l5a5
ui7Ie1QX7rs5JBEm3fOIKAhgMIapVsDf978VNRvx7Z7hWgbP4aXKyqwpPmznbtae
ufiPHhHarvmBvMKcaNi7HPUJxz5TZAKNrrHHAmnU6BG5MdRB+mMjwk09x26LHw5c
06/9wRqasjB3i/pfrho/bux+0bPr5hfuED3nRuY3QfsbJcF0cv3M6W5buxATkJXz
umNR2d431iFizR/oMSQ7nsIdFCgIYH+cgM6iTKyqXhUIvEv6NzJDcCGyacOB8Ugq
XUvv/a3Ar8Hm2LkJyK1B38A1DvDu864jxMAJZMs3K3hi5muWmYkfxENayC+yjuYT
A7kGWwkc0/NVrQtR5BiDveAUiL4otgtyovuDrrJrObNF8cfM4quhs/AfDRIcR6z0
Wo9QBrFZprjW3ya9+1RnWGU7u4PelM8laBW9rLviIq8hPh4jwmABTDxfAyRBiywa
NwN2icN0WSdXfLsphdMkLOHWwxTL1r4l6qq2OH7H14rNdfx3KLZKKtuhwsHPoXcH
NTDJeUJtnV3H3VR8VbX6Nz8UnTtncWKraXevthBlLLs85n66Uxs1PuCbwhBQ2+Gw
ot8/tF9VY5ZfIkXRr8oZ
=NCga
-----END PGP SIGNATURE-----

--5QcFV2hM9LMj73vVNf6Nmbf3wwdB44lXE--

--===============1889311106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1889311106==--
