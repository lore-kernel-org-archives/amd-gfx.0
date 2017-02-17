From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 17/35] drivers/gpu: Convert remaining uses of pr_warning
 to pr_warn
Date: Fri, 17 Feb 2017 15:22:29 +0100
Message-ID: <c78cbc49-9fd1-ae7c-3e8e-5fc3c76cd75f@amd.com>
References: <cover.1487314666.git.joe@perches.com>
 <89288c2354690be744b72b27e39f317cb1c5310d.1487314667.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89288c2354690be744b72b27e39f317cb1c5310d.1487314667.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Am 17.02.2017 um 08:11 schrieb Joe Perches:
> To enable eventual removal of pr_warning
>
> This makes pr_warn use consistent for drivers/gpu
>
> Prior to this patch, there were 15 uses of pr_warning and
> 20 uses of pr_warn in drivers/gpu
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Christian König <christian.koenig@amd.com>.

> ---
>   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c     |  2 +-
>   drivers/gpu/drm/amd/powerplay/inc/pp_debug.h         |  2 +-
>   drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c      |  4 ++--
>   drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c   | 14 +++++++-------
>   drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c |  4 ++--
>   drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c     |  4 ++--
>   6 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index b1de9e8ccdbc..83266408634e 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1535,7 +1535,7 @@ static int smu7_get_evv_voltages(struct pp_hwmgr *hwmgr)
>   					if (vddc >= 2000 || vddc == 0)
>   						return -EINVAL;
>   				} else {
> -					pr_warning("failed to retrieving EVV voltage!\n");
> +					pr_warn("failed to retrieving EVV voltage!\n");
>   					continue;
>   				}
>   
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
> index 072880130cfb..f3f9ebb631a5 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
> @@ -37,7 +37,7 @@
>   #define PP_ASSERT_WITH_CODE(cond, msg, code)	\
>   	do {					\
>   		if (!(cond)) {			\
> -			pr_warning("%s\n", msg);	\
> +			pr_warn("%s\n", msg);	\
>   			code;			\
>   		}				\
>   	} while (0)
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c
> index 0f7a77b7312e..5450f5ef8e89 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c
> @@ -2131,7 +2131,7 @@ uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
>   			return offsetof(SMU73_Discrete_DpmTable, LowSclkInterruptThreshold);
>   		}
>   	}
> -	pr_warning("can't get the offset of type %x member %x\n", type, member);
> +	pr_warn("can't get the offset of type %x member %x\n", type, member);
>   	return 0;
>   }
>   
> @@ -2156,7 +2156,7 @@ uint32_t fiji_get_mac_definition(uint32_t value)
>   		return SMU73_MAX_LEVELS_MVDD;
>   	}
>   
> -	pr_warning("can't get the mac of %x\n", value);
> +	pr_warn("can't get the mac of %x\n", value);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
> index ad82161df831..51adf04ab4b3 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
> @@ -122,7 +122,7 @@ static void iceland_initialize_power_tune_defaults(struct pp_hwmgr *hwmgr)
>   		break;
>   	default:
>   		smu_data->power_tune_defaults = &defaults_iceland;
> -		pr_warning("Unknown V.I. Device ID.\n");
> +		pr_warn("Unknown V.I. Device ID.\n");
>   		break;
>   	}
>   	return;
> @@ -378,7 +378,7 @@ static int iceland_get_std_voltage_value_sidd(struct pp_hwmgr *hwmgr,
>   			return -EINVAL);
>   
>   	if (NULL == hwmgr->dyn_state.cac_leakage_table) {
> -		pr_warning("CAC Leakage Table does not exist, using vddc.\n");
> +		pr_warn("CAC Leakage Table does not exist, using vddc.\n");
>   		return 0;
>   	}
>   
> @@ -394,7 +394,7 @@ static int iceland_get_std_voltage_value_sidd(struct pp_hwmgr *hwmgr,
>   				*lo = hwmgr->dyn_state.cac_leakage_table->entries[v_index].Vddc * VOLTAGE_SCALE;
>   				*hi = (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[v_index].Leakage * VOLTAGE_SCALE);
>   			} else {
> -				pr_warning("Index from SCLK/VDDC Dependency Table exceeds the CAC Leakage Table index, using maximum index from CAC table.\n");
> +				pr_warn("Index from SCLK/VDDC Dependency Table exceeds the CAC Leakage Table index, using maximum index from CAC table.\n");
>   				*lo = hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_state.cac_leakage_table->count - 1].Vddc * VOLTAGE_SCALE;
>   				*hi = (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_state.cac_leakage_table->count - 1].Leakage * VOLTAGE_SCALE);
>   			}
> @@ -414,7 +414,7 @@ static int iceland_get_std_voltage_value_sidd(struct pp_hwmgr *hwmgr,
>   					*lo = hwmgr->dyn_state.cac_leakage_table->entries[v_index].Vddc * VOLTAGE_SCALE;
>   					*hi = (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[v_index].Leakage) * VOLTAGE_SCALE;
>   				} else {
> -					pr_warning("Index from SCLK/VDDC Dependency Table exceeds the CAC Leakage Table index in second look up, using maximum index from CAC table.");
> +					pr_warn("Index from SCLK/VDDC Dependency Table exceeds the CAC Leakage Table index in second look up, using maximum index from CAC table.");
>   					*lo = hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_state.cac_leakage_table->count - 1].Vddc * VOLTAGE_SCALE;
>   					*hi = (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_state.cac_leakage_table->count - 1].Leakage * VOLTAGE_SCALE);
>   				}
> @@ -423,7 +423,7 @@ static int iceland_get_std_voltage_value_sidd(struct pp_hwmgr *hwmgr,
>   		}
>   
>   		if (!vol_found)
> -			pr_warning("Unable to get std_vddc from SCLK/VDDC Dependency Table, using vddc.\n");
> +			pr_warn("Unable to get std_vddc from SCLK/VDDC Dependency Table, using vddc.\n");
>   	}
>   
>   	return 0;
> @@ -2146,7 +2146,7 @@ uint32_t iceland_get_offsetof(uint32_t type, uint32_t member)
>   			return offsetof(SMU71_Discrete_DpmTable, LowSclkInterruptThreshold);
>   		}
>   	}
> -	pr_warning("can't get the offset of type %x member %x\n", type, member);
> +	pr_warn("can't get the offset of type %x member %x\n", type, member);
>   	return 0;
>   }
>   
> @@ -2169,7 +2169,7 @@ uint32_t iceland_get_mac_definition(uint32_t value)
>   		return SMU71_MAX_LEVELS_MVDD;
>   	}
>   
> -	pr_warning("can't get the mac of %x\n", value);
> +	pr_warn("can't get the mac of %x\n", value);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
> index 0e26900e459e..deec874d874f 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
> @@ -2180,7 +2180,7 @@ uint32_t polaris10_get_offsetof(uint32_t type, uint32_t member)
>   			return offsetof(SMU74_Discrete_DpmTable, LowSclkInterruptThreshold);
>   		}
>   	}
> -	pr_warning("can't get the offset of type %x member %x\n", type, member);
> +	pr_warn("can't get the offset of type %x member %x\n", type, member);
>   	return 0;
>   }
>   
> @@ -2207,7 +2207,7 @@ uint32_t polaris10_get_mac_definition(uint32_t value)
>   		return SMU7_UVD_MCLK_HANDSHAKE_DISABLE;
>   	}
>   
> -	pr_warning("can't get the mac of %x\n", value);
> +	pr_warn("can't get the mac of %x\n", value);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
> index 331b0aba4a13..4d1439a498eb 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
> @@ -2657,7 +2657,7 @@ uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
>   			return offsetof(SMU72_Discrete_DpmTable, LowSclkInterruptThreshold);
>   		}
>   	}
> -	pr_warning("can't get the offset of type %x member %x\n", type, member);
> +	pr_warn("can't get the offset of type %x member %x\n", type, member);
>   	return 0;
>   }
>   
> @@ -2681,7 +2681,7 @@ uint32_t tonga_get_mac_definition(uint32_t value)
>   	case SMU_MAX_LEVELS_MVDD:
>   		return SMU72_MAX_LEVELS_MVDD;
>   	}
> -	pr_warning("can't get the mac value %x\n", value);
> +	pr_warn("can't get the mac value %x\n", value);
>   
>   	return 0;
>   }
