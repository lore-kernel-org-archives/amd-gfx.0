Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61ECC54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 12:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1F210F0A2;
	Tue, 12 Mar 2024 12:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O6AaXYsE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B160C10EA82
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 12:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlVYk0mgYxLA/OqRrJwDz6TtZWCXdRNkC1vgbsToZp6zbrhvZ4VU9MynMt4ZJVUYEFDSCGo60kYdzY4TI/cjMhOUSEP9D8KwYBGFLwSD8xah+g18QVz3u6e/qDx5hiJSG7JLyKwQ0SAVrwruDlxZgiRIeUUdDQLczIXrOw+DdGKez0Twcg3xyWPOptA6lAIzQmB/p67RF+b8Q3Tcyhf4euqhkRM/bIWAHkBQ3IPlEc/XHMRs7igB6kzVhECSZ7os2N19UUDX+MbPh3ylt9CYMtz06dNc7hC3Id57PhtexS0OM0vqLniuIeJB1Qo6JtsKjYYzhPYfJxdlNmHYpr/APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwB85ue0vr0AVPOMQqtxzfnpzPnQLdQ9s6TVE8C9xEw=;
 b=T1DpXBuBf5w+wWvOBVPs9ofc7eS1DKHLRl1ifB91d/VAe0cJbfvnEoR+HM3h4/iaqFAfbpq3P6Ix8MeIoQ/sDXdknSAJRapRjoTdVbr2HNFWK5WmZ97CiOUAAL/bp2eNYLMjqZJeNlhVqFlTIbSAN27dp4vb78b4b8gZCvJpU/q/50PJxyy5KFJC+tFggAEAvWL3kF+pr3Xsqkw8SLvU+Ax0KD7nrWB8MgLcowi6AQCqpioWAIlvVTLpwfu55Vol/cyODPJbVDcEaDlyupBLOJgFD86ufGvtawH297XdYRJlIOcS0fhHHBxxJCI+l/nq5OnZk3NaD4ov7nVr3nKE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwB85ue0vr0AVPOMQqtxzfnpzPnQLdQ9s6TVE8C9xEw=;
 b=O6AaXYsEYxt6nja0TGWGJgIrgPdbdFllKLwq1YAi7TGx+8ZV6qrt4OHXNXryX2LGbrx3HjLjS1aFiCU/ts7Y+dQckFdcYrBUYnc8mEi5pw9NS8Qvfg6Vc9V9Cog9j9ALMgy5okp3uI7geEHdgBqEO5+mewDrZqjbWJq80AoOk2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 12:57:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 12:57:37 +0000
Message-ID: <636b1578-08d7-4a6f-a499-6dec02c58aa5@amd.com>
Date: Tue, 12 Mar 2024 18:27:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the ppfeature value
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240312105934.2291792-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240312105934.2291792-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0239.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae45d8b-b231-4637-5260-08dc4293fe46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Zmr29fWOHG4q8l43IDDeeNlUDH0IJ5PtOaRNrjts2skiLS6Vrs7ollfeB7XtKqgt0g38aQ4GRk9wuTNMPVLogRXJt3guLPw1u1FljhOE2K79C7GpH/NHlOf73AXi34Zz1thcIeQht02V/czTihZAML/Kc01JPHpVD0yIxptjAT30zbKlIBpMkXuO0hzm3QQ/si/eKLMmnmykuo8+vzg0EsiEvvwbK4q4R/Rq5oRvXrvGSrqvWgEr8RIuJ2CBawfrj49cTbaoVr/Vmky5c/NuCcwOiEoIUe2ax1E9qKggXWN8r3KbGS8bT6YUHmxs2wjz4OuRRb0W4crv+6Hn8ZN5Cdi12fLQeBhBDXZNKgARKEb0yAX6PYx4dh/u4gZNROIcC8XMoyetrPaMy39W4eObtXyKzawyKibPpLvB1mnD0tDAFNd0NyxM82ZWOBf2MPdh7hTJ2T2CqKTLQI76at+BWEZ2J1sC1yXoIUcakcTCjiGDrvkgeiK58dkVdvs1Fpt9Qgqd7eQBnc/YuP29AGfmUFxHFIBnhU8pg4eTP6Om9dYRnFvjSrLI//ann6TDvZhdVYG/exIjGhzMmJp+/E7bUUSVvT/T4pGju/VePd22RWxjJEoUWqD5DajRM7pevLAvIbzwqHQLZtfFRqi+0AW/+V4p+6/0EiikH36n2k+iCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmFEZTJ1VXJMRjB0SzZ5b3lDd0pJanZGMEJuMGNBZndTNit0NTNYVGFic3ZB?=
 =?utf-8?B?cU55R3RySzZmS0NRUTJKQTVIaE9DQmQrbWhqUTk1NVNmQVFpY1JNVFQ0QVVx?=
 =?utf-8?B?S0wwcHIreTE5UGx1SUJ2MEx1WWxIOXp4NnVYOEc4eklocXdUU1ZDcHVmWUVZ?=
 =?utf-8?B?UHozc1NIU1hTZTdKeDJHR0YrSWkzdnVzQU5RTWx6cEpDbVRFRXZqbzk2empK?=
 =?utf-8?B?SmY3U253d0pDbmhFQ1M0c1ViTFdnTFZRTjVXYUh2TjBmWGgrQ3hhMWhFb0Ux?=
 =?utf-8?B?enRndmxEeVR6QXNRaVdXYTZ4Mm9xMDIzNlZDREUzRTgwNkdnSk10Qng0amQw?=
 =?utf-8?B?UkdYN0c0R1A3aEUwanhsaHdScysxL3paU0FFMWdNUERUVTJwMWxCUjc2ZGNY?=
 =?utf-8?B?UFNLV0tCNzdMVkhZRFBZWjhEdnhIbnBUOEdqMUYwUVFYOW5XblgzTERCNk9n?=
 =?utf-8?B?T2lydEZOMU5wRjFzUW5veVlJbDd5eENYdzNDTVA1UVBvSUZXVm5MU1ZtREp0?=
 =?utf-8?B?RWZuNDNvV0lpSDMwWEhiRkk1cDBTRDcwc2I5bXhyZU1QbWFsQStMTWNoKzZ0?=
 =?utf-8?B?NUtPSGY1TlIyUkRWUytseUhGME8vSVdZS2V0R290dSsvaVRyY3BIU2hhT0dl?=
 =?utf-8?B?cEYzMi9mV0xVS1dTcFl5ZWV4ZzhnMGFSTnhMbEE0SXZJdEp0NjFDZWo2RGNY?=
 =?utf-8?B?a1pndE5oLzJmQmJQL1d2UFBaRFFIczNETy9McHNsSlpaL1l0UzZjMU5mbHY3?=
 =?utf-8?B?ekhLb0hMTUo5MEhkRkdnWVY1NUh4TFRJZDRVaHJ5OGQ1Ujd4MTFxQk1kMENP?=
 =?utf-8?B?dFA1WWxOaW91L3JvekpNMVJUWk0zWlp1dWY2NGVGdmRFZ0VmdEZJWlV4cjJX?=
 =?utf-8?B?eUFaSXA1MVBaSHoxdWtsSGFZYUNNSVRNUVlmYm9MTEEwMG1VNE5oSWFyVFN5?=
 =?utf-8?B?UEZySWZxTHJDYWwwOHFRcURmTDhzb0t5V1cyTXNVNFpLM09naWVSZTJwczk5?=
 =?utf-8?B?R3V3a1d4d2ZPQ21Sa3RnekJvU0dRR1prWUhjUEZDU2U5R0ppQ1dOK2dIVVdV?=
 =?utf-8?B?Z0ZaTEFVOEp2OWNBTGxKNFdzK2R0TVhTUUdkS1RmblE5YzlpdE81SGp3T0Rs?=
 =?utf-8?B?M3oxNkVzY2xFdFFxVnJwMkJzNFhyYnhRSFk4WHl2TmRzNXREWGIzRjA3cEpT?=
 =?utf-8?B?bDdISEE4N1BncDZFbUFiM2VFR2V5MHp2RGw5aDJJN3pPU1VnLzRieGp5cyt5?=
 =?utf-8?B?YjhlZVUyUHpwcnJ1K09FUCtzMXRKVTBvSVVadk1uQ3IzSExRQ3JLWnRzejRz?=
 =?utf-8?B?WFhPQ0F6RU1ZWC9GOWQ3eUNuZXZZc1l3blliZVA0cVowTXZuZkcwdGFEMjA5?=
 =?utf-8?B?K3hzTy9QMG5DZDhNc2F5OTVtS2hMZnZ6UDBSUGRaY3RQOTdNcGJSaWg3b0Jr?=
 =?utf-8?B?eURxSXVXaE50cHNlUWh1NlRNSGhaUWE0aWNEdDYxSWVWZ2lod2VEL1NlZDk5?=
 =?utf-8?B?V29paE1UWitUak1KTE9LS1pueE1mbXN0VEFuY2V2N3lBQncxU0trT1ZmRGRw?=
 =?utf-8?B?Y1VhTzQvTVV6dDZvUkNsT2VwRWx0K1ZqZndmMk5QZ25ERlpXL3Jhc1J1T2s4?=
 =?utf-8?B?MUlldnNLRVBIOFhPOXl1NExCWnl2RGdtYUpCMlYzTXlyaTJzRmF2NzlEcUNE?=
 =?utf-8?B?dUdLYS84T3dWbzRrK2VhblNtMDk4N1d4MHl3WWpNMGdLS2hsZEhyZVJYSUly?=
 =?utf-8?B?UmVtOThOY2YwVU9nVlpxNnJwZjZIakZaTklMcE9MU3hrWXFyMU5GMkNydG1U?=
 =?utf-8?B?eVZvbmtYaEpxMEw4MEdpK3Vna1dDWnJUVk5zeGp0ZTU2VThsSGQzci9waFpa?=
 =?utf-8?B?R0NwUDNPVGpNRXZrNmRiZWlpbHpoOTB2TGEydGYxTzdtYTZPbmxZY2xpUUhl?=
 =?utf-8?B?amRYRW1jdmhpdXpBUTlhR2w1K2VMZkczQmN2SmhIbHVOMDFtVVg4VVR0OTlu?=
 =?utf-8?B?YW5MVWY0bGp5dlFHRWF1UWRDNDg2SkRUeXUydzd4OWQ2VnBaMTZoS28yK3A5?=
 =?utf-8?B?VG94bk82L3Nwcm50VThCMG5EY1g5cTk2MFo1ZFVtZlh4UE1qSW0wTjR0OXl2?=
 =?utf-8?Q?is6KAKB+pRH/GG+tb7peO2eMZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae45d8b-b231-4637-5260-08dc4293fe46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 12:57:37.7595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBokd+oY98Gde+tFSZCEcN7w0wjheXLLPw0lZEtXshk/kzf3OZGITOeBLxDATOWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/12/2024 4:29 PM, Ma Jun wrote:
> Sometimes user may want to enable the od feature
> by setting ppfeaturemask when loading amdgpu driver.
> However,not all Asics support this feature.
> So we need to restore the ppfeature value and print
> a warning info.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 15 ++++++++++++---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f84bfed50681..d777056b2f9d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1548,12 +1548,14 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>  	return ret;
>  }
>  
> -int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
> +bool amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>  {
> +	bool od_support;
> +
>  	if (is_support_sw_smu(adev)) {
>  		struct smu_context *smu = adev->powerplay.pp_handle;
>  
> -		return (smu->od_enabled || smu->is_apu);
> +		od_support = (smu->od_enabled || smu->is_apu);
>  	} else {
>  		struct pp_hwmgr *hwmgr;
>  
> @@ -1566,8 +1568,15 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>  
>  		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
>  
> -		return hwmgr->od_enabled;
> +		od_support = hwmgr->od_enabled;
> +	}
> +
> +	if (!od_support && (adev->pm.pp_feature & PP_OVERDRIVE_MASK)) {
> +		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
> +		DRM_WARN("overdrive feature is not supported\n");
>  	}
> +
> +	return od_support;

Instead of doing this inside DPM API, suggest to keep it outside towards
the end of initialization phase.

Thanks,
Lijo

>  }
>  
>  int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 621200e0823f..0635f9d3a61a 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -551,7 +551,7 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
>  int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>  				       void **addr,
>  				       size_t *size);
> -int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
> +bool amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
>  int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>  			    const char *buf,
>  			    size_t size);
