Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3184CC98328
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 04:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECD510E75E;
	Mon, 28 Sep 2026 04:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uW9HSPF2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AFC10E75E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 04:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqN3LO3c90cEo/iGRBZKcZB00Aa+Kuai8p5G/QT/pY43enhbEgGiIFnRBjZM3b6FOOiiGbVwX/f6ENPlivMCc2LGtK/hQIoce+z/8qL3qJooxB7lQCbtprEQWS+mwM5UlwXtk/eESlOVzMy6OKC+qDIFlzJyCi96arGL6jkJWnELg5l8aVW3kIoW+A3CLdkNqPV2GNTuFKT/srIBwJE/REPb8+sb7g8CTJFjwG4Lwv8h3+3IyYiu6RQ0XBYewweDgog9N0l207YJQgsv4bdrl17A5VAZPM4KrueKq315lqOYtfmIXPBln+KFyL8yYwmJ63wsZGGdYs1a8TTt7bGFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUyBx2hBFhzoHvCe90ctlqqa+aa1rLojWWJjGnL3upo=;
 b=HkqDqlSSYRobyWFR2+aXdQEDJfF7/XpyGhP7LwMT3VxYAT8JO9wBcKBm37ihhFFL5wyNnYx+W+np9teau8tVtsl07WczSTWd3bcnQrcS/DSPmizZBThC5Bml29DsnkrZEgSHk2S8UzHO6YEgZ90xGoMXGwVkR3jH5SvVeMvia9mjUJlp8+GR+yui5qL773K6R4VcBxtiukiyzMcQLg+8earv15HSDAkdOmFuObxozh4wTz1ohEi37q6xozd9SdOLbuGjl5pluW808/RQgm/5jNtbpdtJwCCOx41/cuKYch3BcrtHrtK0WxtcDvJn+O9M+0cboUEqdyiL/qtioAYKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUyBx2hBFhzoHvCe90ctlqqa+aa1rLojWWJjGnL3upo=;
 b=uW9HSPF24sMVINQ063XIZ8VqWTFwzJjovBVmpoKOESi5SI7v4Scs7SrmbjyX1G7vutruupD/8HnAAHM1IBg+dCSerI7oa5YifTkVO8FL8rhHaTIitYvqh+i7gkGVr2HxENVSOXxO/2ZwJULgOalUEuK3WSHn3iB8oSFTLh/eAdM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:47:55 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:47:54 +0000
Message-ID: <a90b30be-fec9-409e-96f6-8acfa56cc293@amd.com>
Date: Mon, 28 Sep 2026 10:17:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Read RLC GPU clock on GFX12.1 VF
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Shaoyun.Liu@amd.com
Cc: Davis.Ming@amd.com, Gavin.Wan@amd.com
References: <20260924063519.688340-1-Victor.Zhao@amd.com>
 <20260924063519.688340-2-Victor.Zhao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260924063519.688340-2-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0081.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 07141e2b-9a58-4e7f-74d9-08df1d1ba909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FylsjS0jAdcP2MUftY7pqXbU/UcBPSyP4fRdMaIGQ3r+RpLbHubnC0crTp8hq/aua4O7i2a549+clTvEfDqMxDqng972TAbYfpL6tGGZziWoRVI1RO+H5WwU0fWN+A8cS3Q/bqFrFPriOTBfU8BCgBKmzcCZx0MzEa3vAeRmfhWa31giV3GzhVMJtgWdxeu9t6gdIuqRxJsxrh79atczKn/fZn4bwfB+wie0mI5+BcmdsbC/y2tvRTd9BZ6B13RSqMt/JP/t0dq2MflQQeXFJhIcDukYjQbW8rI13qxzctru1qZpwO7Ixap1ueIII3zTQKFGa05qaCoE4tdRUe+9j41NbMCiuTbw13tFI3OMTB4cLVEST1bgCMufEpgipMPVttWuPAQo+NT5yXG0+uULqWeWGJspf662jzq7qzLzM+sgUL1G88Iy7yW3BUJ0wq2dlF/e7Sn8Fm5lqj17BSMolq0GQZSQP1tU5JD6EurGCTpQ8Ya6LedQYCFOscpvAzra+6d6b76qByg3Kk4dEgZn3OthThs7QF3+bR8Z/TyB/JaW2GpvEYdLHY/TgsFpKLcfz+EC4pcV3RE7fkPOCFoJfcGR/R8fLRwBd43xVyiCGuU4V8Ojq7qh5Zb1TpVh4Ny5+I6BQo6aByOY0ayB+vCtjC7p+kJ7KPkdbpsLyLjmoEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZDMjhhTzFZTzJSVVh6RGVUNi9YUjJVenZyUzBXbklBY3F6VUwyZ1lBcWYr?=
 =?utf-8?B?VG1PUWxwZnEvZHpGSGdSTzJHdHNKT2toV3FXak5MVkx4eUh2TDQzazIrcG1R?=
 =?utf-8?B?bWJHSmxEL3dJY3ZKdkhJN2JjVUNVSGsyaU9sRElscTh3T3Zmc3lqbWtBVUhr?=
 =?utf-8?B?TkdDSUpPZ3UvODA5cFJKTU9qZ1l1ejBUdUd3bmlxODJNbmtjT2Q3ZitqOWdR?=
 =?utf-8?B?MUhVcXJ6Z3pKRFpZNVpTUHZtbzc1SlhUTU9PamZQa2lvY09lNFFUR0owTVp0?=
 =?utf-8?B?b3hOV2pjbzdRUGRhRFhtR1RVNUlFU0hwdFhxVTFqOW9wOFFvSFYrdTVVQXR5?=
 =?utf-8?B?SkhKcGxHaGN6VnU2YjFSYjJHY1pDY2xodC8wdlYvbG9uRGNVVS9qeXBvbjND?=
 =?utf-8?B?QmZob3doZnRiWEJSaWZzMWJmQXJMdjJscFR0SXZodWNJVEdhUytlRzRiN3d2?=
 =?utf-8?B?TU5jVjNRazhaRUhvTkJkRmg5MDlLazdWRm5pOTRBMDNYSzg5ZkZKcDF2b2hy?=
 =?utf-8?B?V2pmR2pVMVV0V05PM0R0K21ZaWVGUnJkM3V5a204bnJTQjhPRFRZdHoyd3Zy?=
 =?utf-8?B?SFcwc3dRZ3NFR2ZqZ1ZQdjB6aVhCV2x0U3NMVWZkQVkvU1hrZThtdUh0ZlpG?=
 =?utf-8?B?U3NLT1p2aWppcFd5VWh5RTdYQ2ZxVFRyekVBWUg5RVpSNUJQVlBCenNWdU5w?=
 =?utf-8?B?MkZqS21DaEZveStjYXRUbmd5dWNmY053VWdLd0pqbm81Ym5tTDhoWWFRQU92?=
 =?utf-8?B?M28ya3JqTytIRzZwL0Irc0pROVRFanRUOHR1a1VFR0swN3gzNmdNUVZMQklR?=
 =?utf-8?B?WWdpMGZKVGpsTUtCRkpPYXpwR3dtSkJHVVR2akNPL0luYlFHWEQvQzZVTlZR?=
 =?utf-8?B?eWwwdFErZlY3MnBMK2xCQjFsQVdtRmphb3MrYTVWU1liS3lxR1N2KzlzZ1ZV?=
 =?utf-8?B?Ym9KVkVnUEEwWWRiSjlIQytNK0F4UWtMRUVRd28xaGw3VGJySjBxV0JTdEtY?=
 =?utf-8?B?ZlU4cndNR1lGdjg2UDJONFd0cTd6V2FKVERaYUtwRExiV2orMlE3S3N2cFZz?=
 =?utf-8?B?clN0WlFjMnJMaVRzMW9OVG1YNHR4Qk1ZT3JiRWh6WFJyQ01yYnlCaWlyNjBo?=
 =?utf-8?B?bEV1bUt3VHVROVUvdTNJa0NOb2V0bUNQWU9ZTzBoODN4QTN4UUtCM0FGS0pE?=
 =?utf-8?B?R253QVByaythTEVYOXBHenphNW5FV2wvaUd1K3hmbk9INWZ2UCtoNExDOTRT?=
 =?utf-8?B?YkdCVUJ3MzJyWHVxdWxTczR4VDRuVjE4OUJvK2hmREQ5ZzM3UlVZSm9ROGdU?=
 =?utf-8?B?VlZwZFgzVjBYWlVVVDBqOHRzSjBReXZyN1FDRWdjUlJHbFd1ZGs3eHh2bGxI?=
 =?utf-8?B?UUR0bStOVHQ5Q2tlMnRRQzJBZDc2aTd3eTFJWWt3UXdvV1piSjdZaThXODRB?=
 =?utf-8?B?ell6Mk5md0plYklvMTRCVTNmdHRsM3BuWWUzMzVXdGtHZ2JwTk9NclEyaDhY?=
 =?utf-8?B?c3I5OWpMMjZlR2YzajJBS2MwQ0dqMnlacmtvM05Rc0IzSjJKOVBnSjV2M1k0?=
 =?utf-8?B?Z0oyU09KeEdKTmRtbzJBVnh3MysxYzRidHc2TEljZDJEQnVRQk9ERjRmcHB0?=
 =?utf-8?B?YkdsTURnNGgvN3QyVGEvbDZROWQ0VHJZMDRVYVpKeTJCK1Q1Sm5HWWM0V25Y?=
 =?utf-8?B?KytJcEdRNTk3bUxqR2w2WExmOVdqdzVONUJWdW0yRThTREo2d0NsVloxeUFo?=
 =?utf-8?B?U2xnS1BhRmRMYnNQTE5EUCtYSWhVVVhRVTZsaEZFNVUvUmYveHJ5MFVqWklZ?=
 =?utf-8?B?L2d3Yk1OSmxXSFRrQVVUWEg4UTJtb24wdk01UnFnMGQ4dlJHRS9Tb2tQNUNi?=
 =?utf-8?B?WlFpK3FXQ3grekl5U0FPVFBBbW83SEdRSGw0YWlWalAvZnpvOGtCUlZZRWtQ?=
 =?utf-8?B?eTFKQXErczJqRWF2RVM5RFhvd2RlZXZLM0dsMEhGczNhS1IxM2k3OVRlc0Jq?=
 =?utf-8?B?YlRwakpEaXZLM2VuZmpjNUF0Ry9kUG5sZkJ5dGdyU0NwTmw2TnpHSXZMSWxE?=
 =?utf-8?B?OTNlNWtrbVZCc0RCZTFZbE11bStibG1ON3pLN205UUxJd3ViUmtrZ2pORE42?=
 =?utf-8?B?NzZDQmFRU0pzT1grRkNESldpNXg0ZHkreWNZQ3NBdnJGZjBWQ1dwQ0Z5Wnlp?=
 =?utf-8?B?ZlM5ZTY5RXNRQzZLR2ZDd3V6N3Z5SkJTZzNsSTZiSWVQZmJZT3k1OFFEN0U4?=
 =?utf-8?B?bVloSHFWbWdkRW5wQ2ZNTlkzSmVvWUYyekRHSjVPTklka2tna280OXRPb29Q?=
 =?utf-8?Q?jYdIwip0jyN/GmtUo3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07141e2b-9a58-4e7f-74d9-08df1d1ba909
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:47:54.8685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpkQk3ztqGtWFvtl0ZEPoC62Tk3+T2omrUtX7f8N2JNnCMWIs28ZNceERN+vIVka
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
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



On 24-Sep-26 12:05 PM, Victor Zhao wrote:
> [why]
> VF timestamp queries need a TSC sample independent of CP/MES.
> The SMUIO path is not safe on VF.
> 
> [how]
> Capture via RLC_CAPTURE_GPU_CLOCK_COUNT and read the consecutive
> count registers with amdgpu_mes_rreg64().
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index d6f70d33201a0..3c8133c94d6fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -3168,10 +3168,36 @@ static int gfx_v12_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return -ETIMEDOUT;
>   }
>   
> +static uint64_t gfx_v12_1_get_rlc_gpu_clock_counter(struct amdgpu_device *adev)
> +{
> +	uint64_t clock = 0;
> +	uint32_t reg;
> +
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
> +	if (amdgpu_device_skip_hw_access(adev) ||
> +	    !adev->mes.ring[0].sched.ready)
> +		goto unlock_reset;
> +
> +	mutex_lock(&adev->gfx.gpu_clock_mutex);
> +	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
> +	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
> +			       regRLC_GPU_CLOCK_COUNT_LSB);
> +	clock = amdgpu_mes_rreg64(adev, reg, 0);

The API error cases should be checked and the clock value (0?) should be 
returned accordingly to indicate an invalid counter value.

Thanks,
Lijo
> +	mutex_unlock(&adev->gfx.gpu_clock_mutex);
> +
> +unlock_reset:
> +	up_read(&adev->reset_domain->sem);
> +	return clock;
> +}
> +
>   static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *adev)
>   {
>   	uint64_t clock = 0;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return gfx_v12_1_get_rlc_gpu_clock_counter(adev);
> +
>   	if (adev->smuio.funcs &&
>   	    adev->smuio.funcs->get_gpu_clock_counter)
>   		clock = adev->smuio.funcs->get_gpu_clock_counter(adev);

