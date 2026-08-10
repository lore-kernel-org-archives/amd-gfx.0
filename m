Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CAFC5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5353010E133;
	Mon, 10 Aug 2026 03:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fdkiq9ma";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C333C10E133
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhf6Gsm89TWUO2TlrUYFJM4ld6oJB0t1MUiWxAFlEjhyyoku1Y/GKKWKRUCVYqQmaMnMCTBDAmc8M5l5LkRbzjmAMfPvO7Uq3/T6BJXlQv3+/gtR0XmmNRL3+OFpsIX5duZDT3VNNaMzEbIzvWyIm9nAMceNgFSGJdlv4e8rXtKB8Gb64DJGpOHpIEGaqNDCAen+Vl0zr97RkHgyNry3/LGuKPqZVMdT3UNZeFEcWWYfvhycLqkGglgIuQ3Ryd5R5Jm5FAa9dYI/R0gBa35uwyRdB30utSYctpF4u9s5bxzQnhhZp4Oukw7RegX8AB5Eapt8fKVJ9VqYrfbrQGVDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y437R9gMIcSYyeii+N4MQ1VbWTzM+QaKRwWkvtEw0Vw=;
 b=HJ3jV1qkzZCQdhGPq0EgGttKdXEgm6tEJCYfT7mJ01QXTlzzMrVic2gD8FI3IEvN9Z5VllR7LOwQXosrX5sj4oUM4ns/ZE4XXdP1nusHOJilyz5Gmm0PAbphN176R+sxyGRS6RGqmojQiDkSm7zeLhHyEm7gpNybIyDVnYhFWwgLfOHFuN/KeSFdwaRYqp/wa+DY62RQ1wnFNMDz+7G4jB26XwCvlSnvlyFMX6zhLI1gfyLCIQpsY2aLV5C+/Inc3qnoqtrQXI88nAqOi5Go7MvOhH/mHPfQ7Fxat4ZLqDv8GokklsGY40cCcTD2qgsZxbfrW1ikaX3AVO2ENl9JcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y437R9gMIcSYyeii+N4MQ1VbWTzM+QaKRwWkvtEw0Vw=;
 b=fdkiq9majyuP/cFXE4XQzp6SYRBAhHDTy+Hr3B6ej6u4WQV3wL25xnth9Va6B6QJb9mvXsl+3YUWw4QGszRfrlJCukMrla2s8ZT+M9p+q1LmTFE3OKlhu6elv1r3e1YAOV9SNiV9NyO/hk2Z48HY2fzla7TKzsbSr7qA3fB5TBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:43:48 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 03:43:47 +0000
Message-ID: <b39d74e8-b8fd-4b6c-a171-5d242b35b2fb@amd.com>
Date: Mon, 10 Aug 2026 09:13:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: compute SMU v15.0.0 gpu_metrics from
 accumulator table
To: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260807122918.3677218-1-Shubhankar.MilindSardeshpande@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260807122918.3677218-1-Shubhankar.MilindSardeshpande@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0090.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c15cea5-db49-4cad-df90-08def69195b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: q+Ka1rocN+HSI0DQdeFgD93ElObTr7lC0dPGU6flyFrCmDCn3XmtzZKGvhWwc8sz4W7oop/xkdejYYMBKQEpmG3QspFmwexX9QFAQVc4Hb+ubm2Tbf5W6H6E6tPOOFbqfA2+fRk+bkPYGcAeUmWN6T66gPwaPWuFSjtkmOvaOkTUbM4DhXmaQ2pbnQ2FkbpFjpU58kMaTkMiUsQyYIRrL7ItVnq4mrImWn74MWuYFYIJUrlqnA25508Y6L7j9SsRkSs4E2SmgMVYUaZLT5NAAToAtNVdqvWzYcmHplR8YscTseo8o3QPNaPLz/JkrA5vUEqYqXQt+hTAmD+Gw/vy4oHDaeO4R3uhB4N3jJaMp1SSFhDI7hvrLFtWqx3VqK+/Eg5iPpV6s877Xc3DF+lSC/5gvVrEdUh1xsv6tTLsiHSoNthcxYWRQ71CrnofzMx23AyPYqs52D37/zO1oC3Qtpcyn5hY/zM1xzaH5xNXUG16rTkb6QoD5VeyF441cbPvdeIDM16ZuTN05hpnAgIhr0ajx5EOPEm16WupdIl9uHFgDKh94WJuZoQ3XOlhuPowV0tFm1FiY7pTPmHSbzp4TGEnsYUs+ENdhTroBrHB2WM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXBwQVd5aXFGaGdaRjBzMC9GZ3dQcVFrRXByaUJHclFnc1dvNXY2MWZRT2cv?=
 =?utf-8?B?SlM2Sk5ueW9vbHh4VzRtQkcyMGxtWXFUTUNpQWdTcm9IYnR4dW92QXBZL0NV?=
 =?utf-8?B?bUVuaEN4Si9VbFU5QVRHZVpEbTZDVWxXbWZUR3BuckRmQU12dVB0d2xveFJw?=
 =?utf-8?B?VnlMNDNMMmJzcSswZEp0d0tkWEhUUjZpSERoY2xueGxUdmRHZ2VIcER6SjRD?=
 =?utf-8?B?VEUxVTU2a0hoTWZDSXJmait5TUVSMnFjV1B1WGwwekQ0YkdBYUlSNDc4YkND?=
 =?utf-8?B?TU5saWdNczJ0RjBtUEpvYXhKQmt0NnpCWWE3VXBBYTZobzByU0wvUXpDWmhC?=
 =?utf-8?B?R0c1ZFo1aDBpeUp2ZkZNQnlOa2lmOE1LTk9sUE92U2l1Znl1Zi9BVWIvS0gz?=
 =?utf-8?B?Q093RXp5MnRReFVJWXA4WU5Mbk95SFFIMExLcVZxbDFRMTFiTEtST0JlZ1Vh?=
 =?utf-8?B?S3pLd3NOc01LUkc2ZVF4ZVVOSjFjRWY1NkI0VEZzdFpQa2c3OU15Ti9tZnIr?=
 =?utf-8?B?UUZab3d3ZjN1VEJST1JkN0Y5a1Fia2dKQlZIaCtYMlJIRjNwWEJMT0V6L3dq?=
 =?utf-8?B?akE2a1M1QnNEdFo5ZUlTRVdHYmNuWndac3B0TEZFazM3bmUza0VvZkxDYkx4?=
 =?utf-8?B?OGlUK3YvTXpoT0V1TzIxNTMySXpzRXZyQ0F5MmNvNmpwZ0pSQ3g4WmRWVWJJ?=
 =?utf-8?B?Z2t6aVRMdzcycmwyNjluMTBoMHF1QlMyRnR4d21BOEIxS3NDcjRuOEM0bk9s?=
 =?utf-8?B?Z2RWQ1ZseDJQOUJZblNkMGh2cDRDekUzVmdsL0lRNEk0a0tuMXBJMmlnR2tJ?=
 =?utf-8?B?b0c3cmZTYWNPdUJPd0MrbFFqbTd6RTZRcThqMTBCQlBsOGI3bkFsWXdHakgx?=
 =?utf-8?B?QUUvclJ5UnRoVWhSdHE4dGJNKysxbGh6SGJNWFNleitCQTRIZkJneXdhZHRJ?=
 =?utf-8?B?REM3cGtqNUQwcUM5RmE3bDVRODFtKy9ZeU94UTlsN0lodnJpbEpaL3Rya2FN?=
 =?utf-8?B?SyswcEJ0NnEzcmViRUMrM2RoKyt6RGdkdEJiM1kzc0xsNlB4emwya3F2UlhJ?=
 =?utf-8?B?QktXNVZmY2ZnbENSYlh3TnZwQ3VnVkFQYnFFNDdhVE90WVpkWkFLMTZtdFEz?=
 =?utf-8?B?RFhZTDZVNlRqUjc4TGNTWGErV2Nmb0VuSytuWmJkU1kwcFFmRnNpdmRBaS9J?=
 =?utf-8?B?Q1VwNkp5MHBERFhZb1kvdzJDeUR4KzMxem1Xak5mRHplSHB4NDZhMTdZd1NC?=
 =?utf-8?B?Rm5TWDY1RWtob3A0LzlTZGt4bC9MY2l4RVN5U2p3QXg1QTdLUis4VFlzcjRP?=
 =?utf-8?B?K3JjalF6NmR0V0xGN1QwVFFSWThIdDlJeHkwemdrMEhGWDFtV2JoWGlCaWQz?=
 =?utf-8?B?eTExM2lrTnZaWDJCRlUxeXpkZUZkZFJpWk9MUkNHTUJ4U2JYUjVZRDIzcHd1?=
 =?utf-8?B?WGhCRnNBUjdzYnJ6NXdiWTZ1ZGN5cUUzWCtNYUo2U1BUTy9xQm1oRVN3R3da?=
 =?utf-8?B?U2hWTGh2a3gzbVBDMFJZZ091VW5tc2RCc21BZVVGQmlqb3dZZ1JHSGtxaXFI?=
 =?utf-8?B?RTlRelNUR0NSZ241cWt3Q2dlV0t3Y3hpQ3UyMXVIeWVGejh5SVJnTE92ME4v?=
 =?utf-8?B?d0tkMnpWY3E0R0R5Vy9zZXZYcWxpUVhlbFI1UWRhMElPMUZ0Ukw3bnFycVQ3?=
 =?utf-8?B?WDhheDN3SXRJbFBleG1pcnphWkM2dHp1dmZ2eHNBZTUxQU04bWZjQlVCMmMr?=
 =?utf-8?B?eVlwWnpKM3psT0piR002dE9kak1OOHVWRUtQVlRNWjBCbkMrcjRHNUl3eUZ4?=
 =?utf-8?B?UHN1RzVvMUVUelpYNjUvVndLYXNQWC9ibHl4Rnl2VFRhRkxMbmU1UE5GcjB6?=
 =?utf-8?B?NjQzMUdKK3pkVU5QU0VJZDJheG52QzhPRG9ScERLNnFGY2lhaC9GQys4cWxh?=
 =?utf-8?B?dXUyOFBDcEZZQjFHWHIxelV3MEhmbzlPR3ZmZUtDdFhqcGZxYzc3aXM0WGQy?=
 =?utf-8?B?ZWRDR1NQdUY1b3FiUHhaTVNlSktwcVNnZDhKQUpkSmN5Z2t6TFJMUCtWZDlp?=
 =?utf-8?B?eHNpOElaZ2kvekpKSzgwcFZScG5QczA4L0d5dUZyeG1DRUE0ampCRDBRa2kz?=
 =?utf-8?B?RnV2TUNtQkZVL2JudGpxdnlOd3JpcWUwZTVsbzc5bmdwcjB6aXRsS2xBVTBW?=
 =?utf-8?B?QURKK1RyRVE3M2krc2Z1T1l6VkhPRk4ydnZBdTJWQ21LWnJDdUZTREwyVlYr?=
 =?utf-8?B?bmxiNDMvdm5Cd3I2VE8wbVkwNGtGYVVzSWl3UUtkS3ozSENoblRxZ203cTZm?=
 =?utf-8?B?Tk10ci9rRVBUS091VmJyeHJuSytNRjJIdnVodDNOSTBueXRBa2NGZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c15cea5-db49-4cad-df90-08def69195b2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:43:47.8319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLVvChQwZcsbivvAvHN2gkuOOtxsbqzN9OuUUDsSJeiTAr5WeQJKZ4VgsJyUKGY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
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



On 07-Aug-26 5:56 PM, Shubhankar Milind Sardeshpande wrote:
> Rework smu_v15_0_0_get_gpu_metrics() to derive values from the raw
> accumulator double-buffer instead of the firmware-computed SmuMetrics_t
> snapshot:
> 
> - Add SMU_V15_IOD_AVG()/SMU_V15_CCX_AVG() helpers: wrapping_sub() delta
>    over the sampling window, scaled by the caller's unit factor, then
>    descaled from 1024x fixed-point with >>10 (scale before shift to keep
>    sub-unit precision); typeof() preserves each field's width.
> - Reuse the same macro in smu_v15_0_0_compute_all_metrics(), dropping
>    the open-coded div_u64(..., 1024) boilerplate.
> - Drop the unused smu_v15_0_0_get_gpu_metrics_table() helper and the
>    SMU_TABLE_SMU_METRICS allocation.
> 
> Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
> Assisted-by: Claude:claude-opus-4.8

A couple of nits below -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

> ---
>   .../inc/pmfw_if/smu15_driver_if_v15_0_0.h     |  46 ---
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 282 +++++++++---------
>   2 files changed, 140 insertions(+), 188 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
> index a5d3e8d88860..94932d8f3e61 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
> @@ -182,52 +182,6 @@ typedef struct {
>   	uint32_t Spare9[8];
>   } DpmClocks_t_v15_0_5;
>   
> -typedef struct {
> -  uint16_t CoreFrequency[16];          //Target core frequency [MHz]
> -  uint16_t CorePower[16];              //CAC calculated core power [mW]
> -  uint16_t CoreTemperature[16];        //TSEN measured core temperature [centi-C]
> -  uint16_t GfxTemperature;             //TSEN measured GFX temperature [centi-C]
> -  uint16_t SocTemperature;             //TSEN measured SOC temperature [centi-C]
> -  uint16_t StapmOpnLimit;              //Maximum IRM defined STAPM power limit [mW]
> -  uint16_t StapmCurrentLimit;          //Time filtered STAPM power limit [mW]
> -  uint16_t InfrastructureCpuMaxFreq;   //CCLK frequency limit enforced on classic cores [MHz]
> -  uint16_t InfrastructureGfxMaxFreq;   //GFXCLK frequency limit enforced on GFX [MHz]
> -  uint16_t SkinTemp;                   //Maximum skin temperature reported by APU and HS2 chassis sensors [centi-C]
> -  uint16_t GfxclkFrequency;            //Time filtered target GFXCLK frequency [MHz]
> -  uint16_t FclkFrequency;              //Time filtered target FCLK frequency [MHz]
> -  uint16_t GfxActivity;                //Time filtered GFX busy % [0-100]
> -  uint16_t SocclkFrequency;            //Time filtered target SOCCLK frequency [MHz]
> -  uint16_t VclkFrequency;              //Time filtered target VCLK frequency [MHz]
> -  uint16_t VcnActivity;                //Time filtered VCN busy % [0-100]
> -  uint16_t VpeclkFrequency;            //Time filtered target VPECLK frequency [MHz]
> -  uint16_t NpuclkFrequency;            //Time filtered target NPUCLK frequency [MHz]
> -  uint16_t NpuBusy[8];                 //Time filtered NPU per-column busy % [0-100]
> -  uint16_t DRAMReads;                  //Time filtered DRAM read bandwidth [MB/sec]
> -  uint16_t DRAMWrites;                 //Time filtered DRAM write bandwidth [MB/sec]
> -  uint16_t CoreC0Residency[16];        //Time filtered per-core C0 residency % [0-100]
> -  uint16_t NpuPower;                   //Time filtered NPU power [mW]
> -  uint32_t ApuPower;                   //Time filtered APU power [mW]
> -  uint32_t GfxPower;                   //Time filtered GFX power [mW]
> -  uint32_t dGpuPower;                  //Time filtered dGPU power [mW]
> -  uint32_t SocketPower;                //Time filtered power used for PPT/STAPM [APU+dGPU] [mW]
> -  uint32_t AllCorePower;               //Time filtered sum of core power across all cores in the socket [mW]
> -  uint32_t FilterAlphaValue;           //Metrics table alpha filter time constant [us]
> -  uint32_t MetricsCounter;             //Counter that is incremented on every metrics table update [PM_TIMER cycles]
> -  uint16_t MemclkFrequency;            //Time filtered target MEMCLK frequency [MHz]
> -  uint16_t AieclkFrequency;            //Time filtered target AIECLK frequency [MHz]
> -  uint16_t NpuReads;                   //Time filtered NPU read bandwidth [MB/sec]
> -  uint16_t NpuWrites;                  //Time filtered NPU write bandwidth [MB/sec]
> -  uint32_t ThrottleResidency_PROCHOT;  //Counter that is incremented on every metrics table update when PROCHOT was engaged [PM_TIMER cycles]
> -  uint32_t ThrottleResidency_SPL;      //Counter that is incremented on every metrics table update when SPL was engaged [PM_TIMER cycles]
> -  uint32_t ThrottleResidency_FPPT;     //Counter that is incremented on every metrics table update when fast PPT was engaged [PM_TIMER cycles]
> -  uint32_t ThrottleResidency_SPPT;     //Counter that is incremented on every metrics table update when slow PPT was engaged [PM_TIMER cycles]
> -  uint32_t ThrottleResidency_THM_VDD;  //Counter that is incremented on every metrics table update when VDD thermal throttling was engaged [PM_TIMER cycles]
> -  uint32_t ThrottleResidency_THM_SOC;  //Counter that is incremented on every metrics table update when SOC thermal throttling was engaged [PM_TIMER cycles]
> -  uint16_t Psys;                       //Time filtered Psys power [mW]
> -  uint16_t spare1;
> -  uint32_t spare[6];
> -} SmuMetrics_t;
> -
>   //ISP tile definitions
>   typedef enum {
>     TILE_XTILE = 0,         //ONO0
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index 12fe2bc0488e..2bcd20072583 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -203,8 +203,6 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>   		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t_v15_0_5),
>   		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> -	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
> -		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   
>   	smu_table->metrics_table = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
>   	if (!smu_table->metrics_table)
> @@ -348,36 +346,6 @@ static int smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
>   				    smu_table->clocks_table, false);
>   }
>   
> -static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
> -							void *metrics_table,
> -							bool bypass_cache)
> -{
> -	struct smu_table_context *smu_table = &smu->smu_table;
> -	uint32_t table_size =
> -			smu_table->tables[SMU_TABLE_SMU_METRICS].size;
> -	int ret;
> -
> -	if (bypass_cache ||
> -		!smu_table->metrics_time ||
> -		time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
> -		ret = smu_v15_0_0_update_table(smu,
> -						SMU_TABLE_SMU_METRICS,
> -						0,
> -						smu_table->metrics_table,
> -						false);
> -		if (ret) {
> -			dev_info(smu->adev->dev, "Failed to export SMU15_0_0 metrics table!\n");
> -			return ret;
> -		}
> -		smu_table->metrics_time = jiffies;
> -	}
> -
> -	if (metrics_table)
> -		memcpy(metrics_table, smu_table->metrics_table, table_size);
> -
> -	return 0;
> -}
> -
>   /*
>    * Fetch a fresh metrics sample into the inactive buffer.
>    * Returns 0 if a new sample was copied, 1 if the cached sample is still
> @@ -424,85 +392,74 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
>   }
>   
>   /*
> - * Accumulators monotonically increase and roll over at their type width.
> - * Use the kernel wrapping_sub() API to compute the delta so the subtraction
> - * wraps modulo 2^n (correct across a single rollover) without tripping any
> - * wrap-around sanitizers.
> + * All accumulators below are 1024x fixed-point values in their native unit.
> + * The average over the sampling window is (curr - prev) / AccumulationCounter,
> + * still 1024x fixed-point. We multiply by @scale first (to preserve the

Better name as it as Q10 -> https://en.wikipedia.org/wiki/Q_(number_format)

> + * sub-unit fractional bits the scaled unit needs) and only then descale by
> + * 1024 with a >>10 shift. wrapping_sub() handles a single accumulator rollover
> + * without tripping wrap sanitizers; typeof() keeps the modular subtraction at
> + * the field's real width (the *_ResidencyAcc fields are u32, the rest u64).
> + *
> + * @scale folds in the unit conversion the consumer expects:
> + *   1    -> native unit  (MHz, %)
> + *   1000 -> W->mW, GHz->MHz, GB/s->MB/s, V->mV
> + *   100  -> C->centi-C
> + */
> +#define SMU_V15_IOD_AVG(field, scale)						\
> +	((uint32_t)((div64_u64(wrapping_sub(typeof(c->field),			\
> +					    c->field, p->field),		\
> +			       counter) * (scale)) >> 10))
> +#define SMU_V15_CCX_AVG(field, scale)	

CoreAvg may be a better name. For readability, pass ccx/core also as 
arguments.

					\
> +	((uint32_t)((div64_u64(wrapping_sub(typeof(curr->CCX[ccx].field[core]),	\
> +					    curr->CCX[ccx].field[core],		\
> +					    prev->CCX[ccx].field[core]),	\
> +			       counter) * (scale)) >> 10))
> +
> +/*
> + * Compute the windowed average of every sensor exposed through read_sensor and
> + * cache it in avg_metric[]. Units here follow the hwmon/sysfs sensor ABI
> + * (milli-C, mW, mV), which differs from the gpu_metrics scaling used in
> + * smu_v15_0_0_get_gpu_metrics(). SMU_V15_IOD_AVG() relies on the c, p and
> + * counter locals declared below.
>    */
>   static void smu_v15_0_0_compute_all_metrics(
>   		uint32_t *avg_metric,
>   		MetricsTable_t *prev,
>   		MetricsTable_t *curr)
>   {
> -	uint64_t counter, val;
> -	uint32_t mw;
>   	MetricsTable_IOD_t *p = &prev->IOD;
>   	MetricsTable_IOD_t *c = &curr->IOD;
> +	uint64_t counter;
>   
>   	counter = wrapping_sub(u32, c->AccumulationCounter, p->AccumulationCounter);
>   	if (!counter)
>   		return;
>   
> -	/* Accumulator-based clock frequencies (fixed-point /1024) */
> -	val = wrapping_sub(u64, c->GfxclkFreqEffAcc, p->GfxclkFreqEffAcc);
> -	avg_metric[METRICS_AVERAGE_GFXCLK] = div_u64(div64_u64(val, counter), 1024);
> -
> -	val = wrapping_sub(u64, c->SocclkFreqEffAcc, p->SocclkFreqEffAcc);
> -	avg_metric[METRICS_AVERAGE_SOCCLK] = div_u64(div64_u64(val, counter), 1024);
> +	/* Effective clocks: accumulator already in MHz. */
> +	avg_metric[METRICS_AVERAGE_GFXCLK] = SMU_V15_IOD_AVG(GfxclkFreqEffAcc, 1);
> +	avg_metric[METRICS_AVERAGE_SOCCLK] = SMU_V15_IOD_AVG(SocclkFreqEffAcc, 1);
> +	avg_metric[METRICS_AVERAGE_VCLK] = SMU_V15_IOD_AVG(VclkFreqEffAcc, 1);
> +	avg_metric[METRICS_AVERAGE_UCLK] = SMU_V15_IOD_AVG(MemclkFreqEffAcc, 1);
> +	avg_metric[METRICS_AVERAGE_FCLK] = SMU_V15_IOD_AVG(FclkFreqEffAcc, 1);
> +	avg_metric[METRICS_AVERAGE_NPUCLK] = SMU_V15_IOD_AVG(NpuhclkFreqEffAcc, 1);
>   
> -	val = wrapping_sub(u64, c->VclkFreqEffAcc, p->VclkFreqEffAcc);
> -	avg_metric[METRICS_AVERAGE_VCLK] = div_u64(div64_u64(val, counter), 1024);
> +	/* Activity: accumulator already in %. */
> +	avg_metric[METRICS_AVERAGE_GFXACTIVITY] = SMU_V15_IOD_AVG(GfxBusyAcc, 1);
> +	avg_metric[METRICS_AVERAGE_VCNACTIVITY] = SMU_V15_IOD_AVG(VcnBusyAcc, 1);
>   
> -	val = wrapping_sub(u64, c->MemclkFreqEffAcc, p->MemclkFreqEffAcc);
> -	avg_metric[METRICS_AVERAGE_UCLK] = div_u64(div64_u64(val, counter), 1024);
> +	/* Power: accumulator in W -> mW (hwmon/debugfs). */
> +	avg_metric[METRICS_AVERAGE_SOCKETPOWER] = SMU_V15_IOD_AVG(ApuPowerAcc, 1000);
> +	avg_metric[METRICS_CURR_SOCKETPOWER] = SMU_V15_IOD_AVG(SystemPowerAcc, 1000);
>   
> -	val = wrapping_sub(u64, c->FclkFreqEffAcc, p->FclkFreqEffAcc);
> -	avg_metric[METRICS_AVERAGE_FCLK] = div_u64(div64_u64(val, counter), 1024);
> -
> -	val = wrapping_sub(u64, c->NpuhclkFreqEffAcc, p->NpuhclkFreqEffAcc);
> -	avg_metric[METRICS_AVERAGE_NPUCLK] = div_u64(div64_u64(val, counter), 1024);
> -
> -	/* Activity (fixed-point /1024) */
> -	val = wrapping_sub(u64, c->GfxBusyAcc, p->GfxBusyAcc);
> -	avg_metric[METRICS_AVERAGE_GFXACTIVITY] = div_u64(div64_u64(val, counter), 1024);
> -
> -	val = wrapping_sub(u64, c->VcnBusyAcc, p->VcnBusyAcc);
> -	avg_metric[METRICS_AVERAGE_VCNACTIVITY] = div_u64(div64_u64(val, counter), 1024);
> -
> -	/*
> -	 * Power: accumulator holds a 1024x fixed-point value in Watts.
> -	 * Average it into milliwatts, which is the unit expected by
> -	 * power sensor consumers (hwmon/debugfs).
> -	 */
> -	val = wrapping_sub(u64, c->ApuPowerAcc, p->ApuPowerAcc);
> -	mw = div_u64(div64_u64(val, counter) * 1000, 1024);
> -	avg_metric[METRICS_AVERAGE_SOCKETPOWER] = mw;
> -
> -	val = wrapping_sub(u64, c->SystemPowerAcc, p->SystemPowerAcc);
> -	mw = div_u64(div64_u64(val, counter) * 1000, 1024);
> -	avg_metric[METRICS_CURR_SOCKETPOWER] = mw;
> -
> -	/*
> -	 * Temperature: accumulator holds a 1024x fixed-point value in
> -	 * Celsius. Descale by 1024 and convert to millidegrees C as the
> -	 * hwmon/sysfs consumers expect (temp*_input is in millidegrees).
> -	 */
> -	val = wrapping_sub(u64, c->GFX_TempAcc, p->GFX_TempAcc);
> +	/* Temperature: accumulator in Celsius -> millidegrees C (temp*_input). */
>   	avg_metric[METRICS_TEMPERATURE_VRGFX] =
> -		div_u64(div64_u64(val, counter) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES, 1024);
> -
> -	val = wrapping_sub(u64, c->STT_APU_HotSpotTempAcc, p->STT_APU_HotSpotTempAcc);
> +		SMU_V15_IOD_AVG(GFX_TempAcc, SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
>   	avg_metric[METRICS_TEMPERATURE_HOTSPOT] =
> -		div_u64(div64_u64(val, counter) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES, 1024);
> -
> -	/* Voltage: accumulator holds a 1024x fixed-point value in Volts;
> -	 * convert to millivolts for the hwmon/sysfs consumers.
> -	 */
> -	val = wrapping_sub(u64, c->VDDCR_GFX_TelemetryVoltage, p->VDDCR_GFX_TelemetryVoltage);
> -	avg_metric[METRICS_VOLTAGE_VDDGFX] = div_u64(div64_u64(val, counter) * 1000, 1024);
> +		SMU_V15_IOD_AVG(STT_APU_HotSpotTempAcc, SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
>   
> -	val = wrapping_sub(u64, c->VDDCR_SOC_TelemetryVoltage, p->VDDCR_SOC_TelemetryVoltage);
> -	avg_metric[METRICS_VOLTAGE_VDDSOC] = div_u64(div64_u64(val, counter) * 1000, 1024);
> +	/* Voltage: accumulator in Volts -> millivolts. */
> +	avg_metric[METRICS_VOLTAGE_VDDGFX] = SMU_V15_IOD_AVG(VDDCR_GFX_TelemetryVoltage, 1000);
> +	avg_metric[METRICS_VOLTAGE_VDDSOC] = SMU_V15_IOD_AVG(VDDCR_SOC_TelemetryVoltage, 1000);
>   }
>   
>   static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
> @@ -714,61 +671,99 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
>   	struct gpu_metrics_v3_0 *gpu_metrics =
>   		(struct gpu_metrics_v3_0 *)smu_driver_table_ptr(
>   			smu, SMU_DRIVER_TABLE_GPU_METRICS);
> -	SmuMetrics_t metrics;
> -	int ret = 0;
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	SMU_15_0_0_MetricsInfo_t *metrics_info =
> +		(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
> +	uint32_t all_core_power = 0;
> +	MetricsTable_IOD_t *p, *c;
> +	MetricsTable_t *prev, *curr;
> +	size_t i, ccx, core;
> +	uint32_t coreclk;
> +	uint64_t counter;
> +	int ret;
>   
> -	ret = smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
> -	if (ret)
> +	/* Refresh the accumulator double-buffer (may reuse a cached sample). */
> +	ret = smu_v15_0_0_get_metrics_table(smu, metrics_info);
> +	if (ret < 0)
>   		return ret;
>   
> +	curr = &metrics_info->metrics[metrics_info->active_idx];
> +	prev = &metrics_info->metrics[!metrics_info->active_idx];
> +	c = &curr->IOD;
> +	p = &prev->IOD;
> +
>   	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 3, 0);
>   
> -	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
> -	gpu_metrics->temperature_soc = metrics.SocTemperature;
> -	memcpy(&gpu_metrics->temperature_core[0],
> -		&metrics.CoreTemperature[0],
> -		sizeof(uint16_t) * 16);
> -	gpu_metrics->temperature_skin = metrics.SkinTemp;
> -
> -	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
> -	gpu_metrics->average_vcn_activity = metrics.VcnActivity;
> -
> -	memcpy(&gpu_metrics->average_core_c0_activity[0],
> -		&metrics.CoreC0Residency[0],
> -		sizeof(uint16_t) * 16);
> -	gpu_metrics->average_dram_reads = metrics.DRAMReads;
> -	gpu_metrics->average_dram_writes = metrics.DRAMWrites;
> -
> -	gpu_metrics->average_socket_power = metrics.SocketPower;
> -	gpu_metrics->average_apu_power = metrics.ApuPower;
> -	gpu_metrics->average_gfx_power = metrics.GfxPower;
> -	gpu_metrics->average_dgpu_power = metrics.dGpuPower;
> -	gpu_metrics->average_all_core_power = metrics.AllCorePower;
> -	gpu_metrics->average_sys_power = metrics.Psys;
> -	memcpy(&gpu_metrics->average_core_power[0],
> -		&metrics.CorePower[0],
> -		sizeof(uint16_t) * 16);
> -
> -	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
> -	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
> -	gpu_metrics->average_vpeclk_frequency = metrics.VpeclkFrequency;
> -	gpu_metrics->average_fclk_frequency = metrics.FclkFrequency;
> -	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
> -	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
> -
> -	memcpy(&gpu_metrics->current_coreclk[0],
> -		&metrics.CoreFrequency[0],
> -		sizeof(uint16_t) * 16);
> -	gpu_metrics->current_core_maxfreq = metrics.InfrastructureCpuMaxFreq;
> -	gpu_metrics->current_gfx_maxfreq = metrics.InfrastructureGfxMaxFreq;
> -
> -	gpu_metrics->throttle_residency_prochot = metrics.ThrottleResidency_PROCHOT;
> -	gpu_metrics->throttle_residency_spl = metrics.ThrottleResidency_SPL;
> -	gpu_metrics->throttle_residency_fppt = metrics.ThrottleResidency_FPPT;
> -	gpu_metrics->throttle_residency_sppt = metrics.ThrottleResidency_SPPT;
> -	gpu_metrics->throttle_residency_thm_soc = metrics.ThrottleResidency_THM_SOC;
> -
> -	gpu_metrics->time_filter_alphavalue = metrics.FilterAlphaValue;
> +	counter = wrapping_sub(u32, c->AccumulationCounter, p->AccumulationCounter);
> +	if (counter) {
> +		/* Temperatures: accumulator in Celsius -> centi-C. */
> +		gpu_metrics->temperature_gfx = SMU_V15_IOD_AVG(GFX_TempAcc, 100);
> +		gpu_metrics->temperature_soc = SMU_V15_IOD_AVG(SOC_TempAcc, 100);
> +		gpu_metrics->temperature_skin = SMU_V15_IOD_AVG(STT_APU_SkinTempAcc, 100);
> +
> +		/* Activity: accumulator already in %. */
> +		gpu_metrics->average_gfx_activity = SMU_V15_IOD_AVG(GfxBusyAcc, 1);
> +		gpu_metrics->average_vcn_activity = SMU_V15_IOD_AVG(VcnBusyAcc, 1);
> +
> +		/* Bandwidth: accumulator in GB/s -> MB/s. */
> +		gpu_metrics->average_dram_reads = SMU_V15_IOD_AVG(DramReadBandwidth, 1000);
> +		gpu_metrics->average_dram_writes = SMU_V15_IOD_AVG(DramWriteBandwidth, 1000);
> +
> +		/* Power: accumulator in W -> mW. */
> +		gpu_metrics->average_apu_power = SMU_V15_IOD_AVG(ApuPowerAcc, 1000);
> +		gpu_metrics->average_gfx_power = SMU_V15_IOD_AVG(VDDCR_GFX_TelemetryPower, 1000);
> +		gpu_metrics->average_dgpu_power = SMU_V15_IOD_AVG(dGpuPowerAcc, 1000);
> +		gpu_metrics->average_sys_power = SMU_V15_IOD_AVG(SystemPowerAcc, 1000);
> +		/* No dedicated socket accumulator: APU + dGPU, matching PPT/STAPM. */
> +		gpu_metrics->average_socket_power =
> +			gpu_metrics->average_apu_power + gpu_metrics->average_dgpu_power;
> +
> +		/* Effective clocks: accumulator already in MHz. */
> +		gpu_metrics->average_gfxclk_frequency = SMU_V15_IOD_AVG(GfxclkFreqEffAcc, 1);
> +		gpu_metrics->average_socclk_frequency = SMU_V15_IOD_AVG(SocclkFreqEffAcc, 1);
> +		gpu_metrics->average_vpeclk_frequency = SMU_V15_IOD_AVG(VpeclkFreqEffAcc, 1);
> +		gpu_metrics->average_fclk_frequency = SMU_V15_IOD_AVG(FclkFreqEffAcc, 1);
> +		gpu_metrics->average_vclk_frequency = SMU_V15_IOD_AVG(VclkFreqEffAcc, 1);
> +		gpu_metrics->average_uclk_frequency = SMU_V15_IOD_AVG(MemclkFreqEffAcc, 1);
> +
> +		/* Per-core metrics: report only active cores (non-zero effective
> +		 * clock), flattening CCX-major into the 16 gpu_metrics slots.
> +		 */
> +		i = 0;
> +		for (ccx = 0; ccx < METRIC_CCX_MAX &&
> +			      i < ARRAY_SIZE(gpu_metrics->current_coreclk); ccx++) {
> +			for (core = 0; core < NUM_MAX_CORES &&
> +				       i < ARRAY_SIZE(gpu_metrics->current_coreclk);
> +			     core++) {
> +				/* Effective clock gates whether the core is active. */
> +				coreclk = SMU_V15_CCX_AVG(Core_FREQEFF, 1000);
> +				if (!coreclk)
> +					continue;
> +
> +				gpu_metrics->current_coreclk[i] = coreclk;
> +				gpu_metrics->temperature_core[i] =
> +					SMU_V15_CCX_AVG(Core_TEMP, 100);
> +				gpu_metrics->average_core_c0_activity[i] =
> +					SMU_V15_CCX_AVG(Core_C0, 1);
> +				gpu_metrics->average_core_power[i] =
> +					SMU_V15_CCX_AVG(Core_POWER, 1000);
> +				all_core_power += gpu_metrics->average_core_power[i];
> +				i++;
> +			}
> +		}
> +		gpu_metrics->average_all_core_power = all_core_power;

The name gives the impression that it's average of all core powers 
(all_core_power / total_num_cores). Currently, it is the sum of of all 
core powers.

Thanks,
Lijo

> +
> +		/* Throttle residencies: accumulator in % (semantics differ from
> +		 * the PM_TIMER cycle counters exposed by the legacy metrics path).
> +		 */
> +		gpu_metrics->throttle_residency_prochot =
> +			SMU_V15_IOD_AVG(PROCHOT_ResidencyAcc, 1);
> +		gpu_metrics->throttle_residency_spl = SMU_V15_IOD_AVG(SPL_ResidencyAcc, 1);
> +		gpu_metrics->throttle_residency_fppt = SMU_V15_IOD_AVG(fPPT_ResidencyAcc, 1);
> +		gpu_metrics->throttle_residency_sppt = SMU_V15_IOD_AVG(sPPT_ResidencyAcc, 1);
> +		gpu_metrics->throttle_residency_thm_soc = SMU_V15_IOD_AVG(THM_ResidencyAcc, 1);
> +	}
> +
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
>   	*table = (void *)gpu_metrics;
> @@ -778,6 +773,9 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
>   	return sizeof(struct gpu_metrics_v3_0);
>   }
>   
> +#undef SMU_V15_IOD_AVG
> +#undef SMU_V15_CCX_AVG
> +
>   static int smu_v15_0_0_mode2_reset(struct smu_context *smu)
>   {
>   	int ret;

