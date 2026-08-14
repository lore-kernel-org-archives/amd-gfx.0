Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781D8C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 07:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA96010F28D;
	Fri, 14 Aug 2026 07:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3fYxv6eS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B3610F0E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 07:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfoV1KUNaOQ4mfVJzd+mrVaip5kYuP/jZ5favKU7nWje1HTNF+AKpvQDOtwg7BCWBH6bWs6lOMxBTiquiWRhIK871IPxO+ebuy7FycRnDfdspZZogiSfWM+38C1RXCCv7C2r/zYqNQ8r3zgUmZ6eVwdkVRifCMDZ7oa/E8h83eRqCx1q1T6zewFg9/qBttGxH3KYj0W+5s45ibQXWAh9P0lujp5d3zrfB67BcwYF4IcYpeMt3Y6d9su4WMsKUaauiYN60NCCcs4j3lyU/Lx0w4ht+Nr/vYlVChLugbVjf/mXWArMcZhSM0v8FCCHr0AgRmmei53hWTOSfl4eHYmPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJGhDekcVHJYUAGeaYQd6IMS2I2jcd3yUfYvafUmTF4=;
 b=B1mWKfT5hFAfGS/ahRSFuCsZfhB56OGRVh3D9ZBqDUlOZErqj0s0cEbHS8QguFkenpmJkPF0zU072orxMaBk0JFwYLo7+ixKwvfr+CUWTx2/sDdu1ahHsvdcHEMG3tLaGq7MLImgFsmy5QEsrFwJtMrwihqM+tomiBoTmm+zxjDSGWbg5xQA0Lc0A0T286c9LxwmfW5SzT+IFsgvkUY8InSNUgcQnevltn7ec3Zr2u5lir7PUx0nBnqusUXBW9zWcOH9LHYfsvlnF6OypTap8BC6XDJzigbZwODcsJPn6HX+rNLAvAsw3xslKwftUQonA0xJyeu4Jm6K03LMtA+Uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJGhDekcVHJYUAGeaYQd6IMS2I2jcd3yUfYvafUmTF4=;
 b=3fYxv6eSxZtud9JkHjTxBRaVPnyt7YEM4FZ7G//8tmqKqV1//66Qzdsn5pdDgufm/QASMi3zNOse2O6WQdaJzN2cI4wExyXLcbep8bPBSzoQ6dKFYOZ7XSDlwAYXLbPiKQmbFmwtdYbbKgzt3NrAeumaVs/FcAKGnbklHtd5E9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB9476.namprd12.prod.outlook.com (2603:10b6:8:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 07:07:42 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 07:07:42 +0000
Message-ID: <208faf20-8e6d-4d51-a719-c5f817649f61@amd.com>
Date: Fri, 14 Aug 2026 12:37:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Snapshot PPT limits for suspend and reset
 recovery
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260814052848.1293509-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260814052848.1293509-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: 91089c3a-5ae6-434f-ea58-08def9d2bb83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C/9Dyy9Nmw8RYLkfznR1QxxWvuQiT6TQn3BYLxnvGuHYilV+qGQUq6o8VvWSVgsa27PnWZ9zMkjyXUqfUXnFhF2p5aWgtk5eQylAdzXotObeqF5j+y+pMMhs3e5CBlBENeBYD1cJ6F1lTg5HeVpUGHVHZaF3KChTQuOTYo4Y2a3iABfMFMrYyISTl6M5b2Y5MCT9cP9UIdDCs2/dPxmEEqqAGsOZlNXmMglxt/T3MGd7d9B/rAwm/7l6lD3y3rXs5mcKUpv6gGNfllZl7KdimKwhGViUpBCcunDvFpVAZ86wsdfLm84EjELhAyZIs9eS7hLKzwvZpI6D0lQFF/1DB7/qhfXJ2bcAYO4KD4dFCPkVGq/gffpKC9QRDLqYhn5o9KXTK72PaOe8CzfjnBE+3QniqvBL4LTwLkjXvqLckTzvVu8YI8MEwDOLMv73Di6Hau0Zfmg+cUGV79yZeCcGTqniRO3o/KfMOlV+k6gqzbznBjo6mmPcVhw53w1GYOFXthjAxrGOY/x8ixEGnR9cHOEjPlBylTincptgswOekvHBCVpEtwWdsL6NAaJlO77FC+UoHosjHKqc8nSFXFbJLj3YfCbO0ikrg8HXuM+3ISmhoJOm862SbjKj7mxi1PEtDh+I45Q6mKjtOAxfGLHqqtb0/LCLolv9V0qyzhfT0bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXNYdlkxeWNaNzJQR2hJY0hQbS9pODBhWEd2STM3c1ptbWwrK1dSVnBzS3k4?=
 =?utf-8?B?cDJCSlpuV2lsaVdQOUNWd1MzbVRpdnAzMkpwd2pUNkN0eDRWbUpqWUhCeExt?=
 =?utf-8?B?WmtjTDg1b1hnWVhmMU90SjhZT1cvcEk0eStrL1p3SDk5N2w1SkJ5Q2FNRk56?=
 =?utf-8?B?SFYwakJ4TnNtZERkaW5ZdlNUVklmc0t5elFjaVBQb1EvYW1FWHR5Y2YxbTF4?=
 =?utf-8?B?VVZMcEFlc2NHLzJpY3hBajFHRlkzd1NJT1RNcHVNWDNPYlJ5VzM4Umlxbi9O?=
 =?utf-8?B?M1BmNWMwbk9kNVVENFowcVE0aUxFZWt2Vm1UenVaUXMvTnlnNEFIbC9IczR1?=
 =?utf-8?B?QkxqazNNVkp0YTBmbVVQa2dpNExDcWRHek5IMDJvV0dpSHdoSlVuRDhTZ2tN?=
 =?utf-8?B?OGp6cDVmN2hTV0wrWWtDcWJOVkU0TEdmdFp2eU9NM0hSdmtyalNkUzVEcjly?=
 =?utf-8?B?bFY3VjB5elM4WE9BN3l1clB6U3NYYnFkRjRqc0RoLzhLMGEzS1FMdisrZUpU?=
 =?utf-8?B?Z1hyeXN1R0lscnNlcEprajNHSDBiZHdiVUNEWDR6akxJSUxBR0pDSElkUWts?=
 =?utf-8?B?cUFyencvTDRwMmlxL0dHcTNrR3gyRGc1K1MySWRmWkg3OVoxZG9jVDF4a2pG?=
 =?utf-8?B?NWxuZWY4bHptNkVWQXJueGkxdEZTQnN2V05MSGZMazZidkFqcWxvaXlMbDhO?=
 =?utf-8?B?bjFFd3BwV3VjNkk2Q3dWRGlqR25KZEo5b0RoQW1RTVV5dXpqbVo4MzdUeFR4?=
 =?utf-8?B?RGkyZ00xMEJpU3VnNjhpU2hmZWFkY016MUxEK0UvNit0Q3JzNEJpekdwbTV6?=
 =?utf-8?B?ZjZoWUlqWWxSamNPL1RJR25FdGVkSUpraEtRMzloQ2tJTlZkcHpQek5IS096?=
 =?utf-8?B?Sm5EUWpSaWR3RVdsa09ETTF4UGd0anpKUzBIdXZ5TnJXR0Q4bmV2KytOdWJx?=
 =?utf-8?B?bkpvTkdLMiswNlcwVzRrbG5vZzZRMjV6cWlBcjVONFB0Z1NkMlBMRTc3WDZQ?=
 =?utf-8?B?bGovVmdwZlVwOWc3Q2g3OU13L0dTK1pUV09UL2ZKMUExcFpvVDA1ZTdTOUZC?=
 =?utf-8?B?UmVONWN2SW8yTk43ZWxFQWt1VDZZcFZuUHI4R2p6NzJlR0QrTitRdnJvaWZh?=
 =?utf-8?B?VkhnYUQxdUhTSGtnQ0ZxQ0R4aFhocklHaVAvOVAyYnpabXpMR2Y0Z2xHUDZp?=
 =?utf-8?B?ZzJYTVExUXBsWGtyWGFKRmk0ZU85czhjU1kxU0cxQ1dOZGN3VjltbFJBbVh6?=
 =?utf-8?B?UkZEVHVMZVI0RFFscGdtZnR4R1c5MEI1eURWVi9RdWhFbUpSSTVqZVpBTWFv?=
 =?utf-8?B?eEZ1RWp3MElKL1NicDNhYzZuNE5vSFFocTNQK2lxQThkR21ucCtVNkRwR1RK?=
 =?utf-8?B?eklKSXhYSi9TNDk1TGl0UTNOYmZOSGhxTFZCeGNtOW96RHZKNGYwQW41ejZ3?=
 =?utf-8?B?Z1BNaGM4SGQ2NkE1QnA0bWdmWjdiaXJOd1NPU2VPdGRIcDBGL2swaDJJTTNz?=
 =?utf-8?B?ZFdsNEJQbVAvN3RscXR6bzF2ZDRNZVl5QzU0MDYvd1JyeDNMZDlwbS8wWHlp?=
 =?utf-8?B?REZtNUFKQTR0TSt3TEtBMnkraEMyNm51WjQvSkZrOTl6eUZBOTgrR0FoY3do?=
 =?utf-8?B?V2xWVGhkS2M0Nlk1cUFVZFpMZXlTOFk2clBURklxaXg5TWpkRkd6dGNLczAz?=
 =?utf-8?B?TEthU1F0c09YSGxEUGd1djJlQitiNlpQU01JcGhmMnRsMzgzdTVpVFNtNmZp?=
 =?utf-8?B?eUhGNEVsSDM2RHJLb1hwNmducHplQWVLLzJKRnJkbWpwL1VYSWJPMVAvcEMx?=
 =?utf-8?B?Z0ZIVkZIaEpnV29QaTlDUkFDam5WS3NLcDV6N1ZHMDRZbTIwUHNZZ3pVSlpN?=
 =?utf-8?B?UXF4MEsySWlZemRIaElFT3piT1FCNmFsL3ZoNkwwcFdVNUJvdEEvQ2hSLzRI?=
 =?utf-8?B?bUM1aXYyVngrREZyQWszOXhCWjhwd2llaFhjUE8xQXRYUjVDa3hIeW9qR0lv?=
 =?utf-8?B?V1gwbEJOZm04L01VaFBHNmM1QTRqTCszTFkzOWtUMXl6bnVvbS9RaklLc1hC?=
 =?utf-8?B?b1ZmdDhNYlZvR0lRdE8rVnZrUHdQcENaUDQrbSs3WkE0bU0vUFlBRTBBbE9B?=
 =?utf-8?B?T1BWZWZnN2tBOXlyT2RVdW1qR2hEQ0JBeGVlOFVwN3FtVUk5RFYvQ3pFWTc5?=
 =?utf-8?B?bGlST0xHSFl3UmF5dWNZZGlvMzF2eEYrNlBNQ0NTTUNlRDRGOERNZWZNUElS?=
 =?utf-8?B?Y0FqV0JxWFdsQkZtNzR2Zi9CZjVRZy9JVUQ1dTdkU01KYW9QREozQkNDMzhJ?=
 =?utf-8?B?RFlCYXNtU0xtZWJvOHI0QnduTkRoa1d3bE52QThWaHlsODhhak9Qdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91089c3a-5ae6-434f-ea58-08def9d2bb83
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 07:07:42.2097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCrTqh+GlRR++/diqzDNCsyIA3uJ7qrCiEVKGzG8h1hj3aKdqcfKpmqtEd2HyXQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9476
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



On 14-Aug-26 10:58 AM, Yang Wang wrote:
> The DPM user profile records driver-programmed policy, not the effective
> PMFW limits. Replaying it after recovery can restore stale policy.
> 
> Maintain a PMFW PPT snapshot:
> - Query supported PPT controllers before suspend and mode1 reset.
> - Save successful queries with the current OS AC/DC source.
> - Clear the selected source mask before capture to prevent stale replay.
> - Refresh the OS power source before recovery.
> - Synchronize the current source with PMFW before restoring PPT limits.
> - Restore PPT limits only when the snapshot source still matches.
> - Do not replay PPT policy on normal AC/DC changes.
> 
> Capture reset state before DPM and PMFW teardown.
> Add debug logging for the snapshot, restore order, and PMFW AC/DC sync.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 152 +++++++++++++-----
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   8 +-
>   3 files changed, 117 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index ce526db4d24a..c3688b3b12cc 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -508,7 +508,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>   			amdgpu_dpm_notify_ac_dc(adev);
>   
>   		if (is_support_sw_smu(adev))
> -			smu_set_ac_dc(adev->powerplay.pp_handle, true);
> +			smu_set_ac_dc(adev->powerplay.pp_handle);
>   
>   		mutex_unlock(&adev->pm.mutex);
>   	}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index bfe2c0bf426d..e5cb8d0420ab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -489,44 +489,122 @@ static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
>   		return;
>   }
>   
> -static void smu_restore_ppt_limits(struct smu_context *smu,
> -				   bool restore_defaults)
> +static void smu_save_ppt_limits(struct smu_context *smu)
>   {
> +	struct amdgpu_device *adev = smu->adev;
>   	enum smu_power_src_type power_source;
> -	struct smu_ppt_limit_range *range;
> -	uint32_t restore_mask;
> -	uint32_t limit;
> +	u32 limit;
>   	int i, ret;
>   
> -	power_source = smu->adev->pm.ac_power ?
> +	/* AC/DC is maintained by the OS and driver power-source events. */
> +	smu->ppt_limits.saved_ac_power = adev->pm.ac_power;
> +	power_source = adev->pm.ac_power ?
>   		SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
> -	restore_mask = smu->user_dpm_profile.ppt_limit_user_mask[power_source] &
> -		smu->ppt_limits.supported_mask;
> -	if (!restore_mask && !restore_defaults)
> -		return;
> -
> -	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
> +	smu->ppt_limits.saved_mask[power_source] = 0;
> +	dev_dbg(adev->dev, "PPT snapshot: source=%s\n",
> +		adev->pm.ac_power ? "AC" : "DC");
>   
>   	for (i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
>   		if (!(smu->ppt_limits.supported_mask & BIT(i)))
>   			continue;
>   
> -		if (restore_mask & BIT(i)) {
> -			limit = smu->user_dpm_profile.ppt_limits[power_source][i];
> -		} else if (restore_defaults) {
> -			range = &smu->ppt_limits.range[power_source][i];
> -			limit = range->default_value;
> -		} else {
> +		ret = smu_get_asic_ppt_limit(smu, i, &limit);
> +		if (ret) {
> +			dev_err(adev->dev,
> +				"Failed to save PPT%d limit: %d\n", i, ret);

Not all SOCs support all source/limit types. If it's not supported like 
EOPNOTSUPP, it should skip throwing this error.
>   			continue;
>   		}
>   
> +		smu->ppt_limits.saved_values[power_source][i] = limit;
> +		smu->ppt_limits.saved_mask[power_source] |= BIT(i);

This mask can be avoided by keeping the saved value as default power 
limit or 0. Also, the limit should be saved during any set/get call 
also. If the FW message fails during suspend/reset, the last known limit 
can be used. The FW message will indeed fail on some SOCs during RAS 
recovery.

> +		dev_dbg(adev->dev, "PPT%d snapshot: source=%s limit=%u\n",
> +			i, adev->pm.ac_power ? "AC" : "DC", limit);
> +	}
> +
> +	dev_dbg(adev->dev, "PPT snapshot complete: source=%s mask=%#x\n",
> +		adev->pm.ac_power ? "AC" : "DC",
> +		smu->ppt_limits.saved_mask[power_source]);
> +}
> +
> +static int smu_restore_ac_dc(struct smu_context *smu, u32 *restore_mask)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	enum smu_power_src_type current_source;
> +	enum smu_power_src_type saved_source;
> +
> +	*restore_mask = 0;
> +
> +	if (adev->in_suspend || amdgpu_reset_in_recovery(adev)) {
> +		/* The power source may change while the device is suspended. */
> +		adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> +		current_source = adev->pm.ac_power ?
> +			SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
> +		saved_source = smu->ppt_limits.saved_ac_power ?
> +			SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;

This logic is unnecessary. What all needs to be restored can be figured 
out from the saved limit value itself.

> +		*restore_mask = smu->ppt_limits.saved_mask[saved_source] &
> +			smu->ppt_limits.supported_mask;
> +		dev_dbg(adev->dev,
> +			"PPT restore: saved source=%s mask=%#x, current source=%s\n",
> +			smu->ppt_limits.saved_ac_power ? "AC" : "DC",
> +			*restore_mask, adev->pm.ac_power ? "AC" : "DC");
> +		/*
> +		 * A snapshot is valid only for the source under which it was
> +		 * captured. Do not replay an AC snapshot after switching to DC,
> +		 * or vice versa. The current OS power source takes precedence.
> +		 */
> +		if (current_source != saved_source) {
> +			dev_dbg(adev->dev,
> +				"Discard PPT snapshot after source change: %s to %s\n",
> +				smu->ppt_limits.saved_ac_power ? "AC" : "DC",
> +				adev->pm.ac_power ? "AC" : "DC");
> +			*restore_mask = 0;
> +		}
> +	}
> +
> +	/*
> +	 * NOTE: Synchronize PMFW with the OS AC/DC source before restoring PPT
> +	 * limits so both sides use the same power policy. GPIO-controlled
> +	 * platforms perform the synchronization in PMFW.
> +	 */
> +	return smu_set_ac_dc(smu);

There is no need to associate ac/dc setting with PPT limit restore sequence.

> +}
> +
> +static int smu_restore_ppt_limits(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	enum smu_power_src_type power_source;
> +	u32 restore_mask;
> +	u32 limit;
> +	int i, ret;
> +
> +	ret = smu_restore_ac_dc(smu, &restore_mask);

This should only be about fetching the limits that need to be restored. 
No need associate ac/dc restore with this.

> +	if (ret)
> +		return ret;
> +	if (!restore_mask)
> +		return 0;
> +
> +	power_source = adev->pm.ac_power ?
> +		SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
> +
> +	dev_dbg(adev->dev, "PPT restore: source=%s mask=%#x\n",
> +		adev->pm.ac_power ? "AC" : "DC", restore_mask);
> +
> +	for (i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
> +		if (!(restore_mask & BIT(i)))
> +			continue;
> +

There is no need to keep a mask. The saved limit can be default limit or 
0 if not saved/changed. It just needs to check that value and decide 
whether to use that or not.

> +		limit = smu->ppt_limits.saved_values[power_source][i];
>   		ret = smu_set_ppt_limit(smu, i, limit);
>   		if (ret)
> -			dev_err(smu->adev->dev,
> +			dev_err(adev->dev,
>   				"Failed to restore PPT%d limit: %d\n", i, ret);
> +		else
> +			dev_dbg(adev->dev,
> +				"PPT%d restored: source=%s limit=%u\n", i,
> +				adev->pm.ac_power ? "AC" : "DC", limit);
>   	}
>   
> -	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
> +	return 0;
>   }
>   
>   /**
> @@ -954,15 +1032,9 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
>   		return ret;
>   	}
>   
> -	/*
> -	 * Explicitly notify PMFW the power mode the system in. Since
> -	 * the PMFW may boot the ASIC with a different mode.
> -	 * For those supporting ACDC switch via gpio, PMFW will
> -	 * handle the switch automatically. Driver involvement
> -	 * is unnecessary.
> -	 */
> -	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> -	smu_set_ac_dc(smu, false);
> +	ret = smu_restore_ppt_limits(smu);
> +	if (ret)
> +		return ret;
>   
>   	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>   	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
> @@ -997,8 +1069,6 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
>   		return ret;
>   	}
>   
> -	if (adev->in_suspend || amdgpu_reset_in_recovery(adev))
> -		smu_restore_ppt_limits(smu, false);
>   	smu_restore_dpm_user_profile(smu);
>   
>   	return 0;
> @@ -2202,6 +2272,9 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
>   	if (!smu->pm_enabled)
>   		return 0;
>   
> +	if (amdgpu_in_reset(adev))
> +		smu_save_ppt_limits(smu);
> +
>   	adev->pm.dpm_enabled = false;
>   
>   	ret = smu_smc_hw_cleanup(smu);
> @@ -2263,6 +2336,8 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
>   	if (!smu->pm_enabled)
>   		return 0;
>   
> +	smu_save_ppt_limits(smu);
> +
>   	adev->pm.dpm_enabled = false;
>   
>   	ret = smu_smc_hw_cleanup(smu);
> @@ -2778,7 +2853,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
>   	return smu_set_watermarks_table(smu, clock_ranges);
>   }
>   
> -int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
> +int smu_set_ac_dc(struct smu_context *smu)
>   {
>   	int ret = 0;
>   
> @@ -2796,11 +2871,12 @@ int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
>   				smu->adev->pm.ac_power ? "AC" : "DC");
>   			return ret;
>   		}
> +	} else {
> +		dev_dbg(smu->adev->dev,
> +			"PMFW controls %s mode through GPIO\n",
> +			smu->adev->pm.ac_power ? "AC" : "DC");
>   	}
>   
> -	if (restore_ppt_policy)
> -		smu_restore_ppt_limits(smu, true);
> -
>   	return 0;
>   }
>   
> @@ -3057,12 +3133,6 @@ static int smu_set_ppt_limit(void *handle, uint32_t limit_type, uint32_t limit)
>   	ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
>   	if (ret)
>   		return ret;
> -	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> -		smu->user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
> -		smu->user_dpm_profile.ppt_limit_user_mask[power_source] |=
> -			BIT(limit_type);
> -	}
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index d30951121e1f..9f85b302060e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -238,6 +238,10 @@ struct smu_ppt_limit_range {
>   struct smu_ppt_limit_context {
>   	struct smu_ppt_limit_range
>   		range[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
> +	/* PMFW state saved before suspend or mode1 reset. */
> +	u32 saved_values[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
> +	u32 saved_mask[SMU_POWER_SOURCE_COUNT];
> +	bool saved_ac_power;

There is no need to save this. If changed to a different source, use the 
last saved value for that source or keep the default.

Thanks,
Lijo
>   	uint32_t supported_mask;
>   };
>   
> @@ -251,8 +255,6 @@ enum smu_memory_pool_size {
>   
>   struct smu_user_dpm_profile {
>   	uint32_t fan_mode;
> -	uint32_t ppt_limits[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
> -	uint32_t ppt_limit_user_mask[SMU_POWER_SOURCE_COUNT];
>   	uint32_t fan_speed_pwm;
>   	uint32_t fan_speed_rpm;
>   	uint32_t flags;
> @@ -1954,7 +1956,7 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum pp_clock_type clk_type
>   
>   int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
>   
> -int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy);
> +int smu_set_ac_dc(struct smu_context *smu);
>   
>   int smu_set_xgmi_plpd_mode(struct smu_context *smu,
>   			   enum pp_xgmi_plpd_mode mode);

