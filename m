Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9208C982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 12:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6C910E8BF;
	Fri, 18 Sep 2026 12:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y/waEmnP";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1EC10E8BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 12:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB03xi181xEMo0Ln7UsU2LsR2MbcY/Ctoknmx+Xof1JIMHR0Fs3CGxPW0Rj8SSsgwdMwNI89bQJALTAUBe4/dF0Zw+0HCAlTDVr+mLgmeddKu8uzSpedbEsBpB252Hs2zuI55qtCcNzs3iYo9deHQE1MeYTrgsdvp8BcjTE2W7NtNByjMC19a6SuDJk1YpO4CKMR0IsCE5993hW5IxuSdpJ0O70mzbDb1B3kMJu8pmFliB20t+wk/26nmFpHDQYI2Vm2xItUmJmbznPzLF1ayVO+RLwyt9VohAvDjlZjRIHItMkA+yVNwADzxzdt32iMY+AK8c4cOCLoF5Mughx8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn7WQaTSuI0gk5UGFzsaSq8cRthdOkzSq9hf/fo7nXw=;
 b=v0cRAMqQoG9tHu3pgB1xtYE6regb4SCT4ZZmbXWWqFEvkZ3j7niM3/vbfpbQd/xbHSx5i7k0ccwT8PZ+GpOeWWSlHaatR1JdQDRXHJNT85Qzcv1M6Gt8NqrpcbbL1LEQe0DofOtL4vL82h5OMNwSdugQeCkYFVazt46RZIityV+D/djDv+y4/eZAflsBqEBfEiNHL1n/VHP0l/bxIr/adp6t9mLyqdec3kmYOQSa+TihxIiv4RwNlZ1hIqJ75fsR82moU7FMDQv7+m67pU5p2GvP4R4gKw1SPmyYEvohtC0ME0j2TB7+FP2uIay+Qd6O/x3XPiYDpd/u7k2O7ssUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn7WQaTSuI0gk5UGFzsaSq8cRthdOkzSq9hf/fo7nXw=;
 b=y/waEmnPv77LyKkfK9B5ySdRcWmWpOpjVlNeLktGZ5TB9F0Eqkdzo01rpvMzMmn0fzjsPzfBU5+8g9rCzVobqtjQIJz+HyJk3aR4m+P9FzFqJk9kWZje/I7m59HI/z1XkRGdn+KQN8BQsmepExgawypLp6v8UZQQCfDRlCQSevM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 12:17:31 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 12:17:24 +0000
Message-ID: <5de4d9dc-5324-4fbb-8215-d4aac230f929@amd.com>
Date: Fri, 18 Sep 2026 17:47:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Program trap TBA/TMA for kernel-managed
 VMIDs
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
 <20260916053722.601067-4-srinivasan.shanmugam@amd.com>
 <04f954fd-bf4a-4677-ab0f-69b7a3edafc4@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <04f954fd-bf4a-4677-ab0f-69b7a3edafc4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c6ac19-164e-40b7-8884-08df157ecc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: VSbPy7mGYH4GJcIuw8VnsZxvO1JIp8cPHP3pop9jfImd2r9Oh0GB27bIJDcGHyetliTC0YjkR96x7K9REj0Q7hFOyyMHoAuPze2Y1VgOIDPFT8JE8R+HVhLHfotO8RH/H5XzELaKFWsG5HJE08vL0xrDclel0plAL2TN3054/4IaAl37Vz3xbzYl2PshvCNLXszf6wrz9TfNuCHDh4UMNaSVbZy0KK17ZsRMazTR8V3dWReGI7yh9xNvPwGBEvwRtHbp4qpmIB3OXVUGiXGhrehRj9Y79TlFhWPu5/zZf1XXrFUyifsK4bdH+D7FNJu5pCtWmNpYM1g576eFAhZt0gGBQsP5vSyX9s9v43Y37jElCLVyCLX/pblWKBuzb61ywXA31EkanXwfb0xGtGwMhBtFaLZNQaG9ryatejMjS1K9t/WEmjvscCYSexyaUjPEbPkeCcOap9MF/bdqWw5ejBXQ4n88wzr2yQ2kHccv9ev05tFa0fdWTCfUPzSJT9/j+4ugBhmvW12+fi8mbJoQXzUBDPs/Xijw07sjxSgx14A8/ZV8pETHEyEHIFOVh8FhveWj6b6Fbl87n+56Id0kbicZ/eTA5n1SF1lxV/g3V9QEbvGvSejFseloi9DHYECsoOY6Rj+hQA/UBsZRkEakpOP5rQJqm8+Z9D8YyJ1N15s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNWMGpPbG00UzBjNWVWSkNmanl2Q3FVNGpvd3RqdGd3YUpJRVppU2lvTlpS?=
 =?utf-8?B?MUUwVks2dXhPVjkzcHNPb01tRjVvWFNwOCtqZUsvbDVwcFVFdmdmR3o1Slhq?=
 =?utf-8?B?TzE4bWthdkQrWUlKS3hhZG5EU0tTb3lsdmM2aXNOMjZOT0lObGFLeUlFNDB6?=
 =?utf-8?B?aFMzU0hzZ21BREJhdGNueEQyL2orY1VSQW1UMGtzVkppbVZ2enNoaUJQY3Fq?=
 =?utf-8?B?cUdhZXgzaTdzQjJaUEVUUnYybG0wcHpXRldKQkY1ZkFkNU1Cd2NSRUVKaGFj?=
 =?utf-8?B?eXRIWWxrNFBXSHFxY1hoZG5ZQTdEM21xOHRMRDM5YnVPYm44bkJod0JHZ1By?=
 =?utf-8?B?THQzOGpOWFlwa2RnbzdURW5ReWxSUDE5cVVsQlpXT2cxR3RxL2dBZ2hBOS9V?=
 =?utf-8?B?REZ0SVFwYlFnZHNMUTNHSTY0UVNvR0U2QmVKT1pjL0lzZzBzWVBpcndFSGhK?=
 =?utf-8?B?VUdNbnNuM2hmenZXdVdMSklnZlJ6eWpxK0tjWElXbmRrVHd3YU5KY0hpVFRE?=
 =?utf-8?B?ZmhRT0k2TElqSnFSdDZzQTgrK3h6aUxlSXhUQkVubFBFS25HaklQY3VHcXJZ?=
 =?utf-8?B?YzMvaE9lZlpLNHVqN1hoVHJEZ2FqNmxMMnF3SDN1TTZGS3EyZ1R4VHE1b2ZI?=
 =?utf-8?B?MFBYUmtYWVkwVjk1WWI0OStvTWNybDQ1eXJsZEZRK3ZlTHhDZ1RTSEg1U1B3?=
 =?utf-8?B?emFjcU9xeDFTUTZ3dUlic1Jmb0hvTVZJQ09ldjgrYyt0ZkQ5QWxsYXZKQVBR?=
 =?utf-8?B?eE55WTYxS1BhWVFBcDlCbzJJQ24xcVJyeW5MdjJSalJrdTVYdEFicnJWb1Ax?=
 =?utf-8?B?ZGhLQlZvOFFmWnhxV2xOM0R5V3Z3L2VDTlozc1EvS2dEUkp6R2F1L3ErdHpJ?=
 =?utf-8?B?ZTNMLzJUYVZpWS9LZmcyQndSWUtBYUorRjJmSVpLMFVKYkVYZDlkTWlCOFJ3?=
 =?utf-8?B?NFdVYlNOblhlcUZNdVZoZEIyWk5NV2xXTGwyaXJuL2ptVjRHZVh0Ulp6YmlJ?=
 =?utf-8?B?YXdzNVh3Q0JCSHNRRWV2d3BidXNoYlVOVjF0dkRRTmpja2lMNFA1dDdlaFhj?=
 =?utf-8?B?SFpvY3hOWjJ0OTRCeXc2M1lvZVR4cURUOXI2czlMMDB6a0N1TTEwNHVNVml5?=
 =?utf-8?B?Y3AzWkRsdHd5SDg3K3JzZGhnNmlSYU1Vd3g2d1NHbEQ2SVgxZlBPaC9vUDFO?=
 =?utf-8?B?S1pqZ3d5SHZKSGd5VS82U1pSZG50T2VTS0duZWdYNUxtWnAvemtua0kreWdD?=
 =?utf-8?B?c210eVZiSVQ4RFFFcU1PdC9jbllQVWpEWmd2ZVhzWVVBSkNIZVVtbzdzaTh1?=
 =?utf-8?B?aWJhTFFBV0ZsS1hFME9tS0xOSEg4QS8zTUtQZy91Nk5SYmNwc0g5ZlI2OCt6?=
 =?utf-8?B?cEZZVGo0QTg5M2dzSmpNdS9nLzZ5OFoyOFRVcUZlbHF3c3dsaWxMNU9xanF3?=
 =?utf-8?B?T3Rla0lXclNhV3ZValo0MmcwdXZHUFRhb2kzWkFwK3ZrOHNhZ2YxOXRWaDFT?=
 =?utf-8?B?eEpLQnIrM0Nta3lndmNMdktTa01PbHFLbENJVlIwQ3FUV0laVUdlei8vMVFu?=
 =?utf-8?B?WFF3WVFEYVBqVFkrMUFFZGJkdGNSTXVxSUdIT0R4dHVKMDRVMXhEVXFuMTVu?=
 =?utf-8?B?eFRMUWlIRzduWHpFN2RQVTRsWktLVTBuemg0cHZyVlZWd21icjZkTDlFbUk1?=
 =?utf-8?B?Z21qMGlJOVk1OG55WHBxZzdmb3R2emxhU3k5S2JIV25qMndzMVhRcjV6VWRr?=
 =?utf-8?B?d2xtZ3JkcGU3ek8xZSs2bnNxMWdOVG9hS2U4VVl1NWVQYUdoK3FIbnQrVFdp?=
 =?utf-8?B?dmI3UUEvdkFuMFhkVysrUjhYd2RVNTFoK0NjM1FEOWxpR1VtcWhteUFuU21z?=
 =?utf-8?B?WkpucWNBTEpmRlZHbmU2eHdNQzBmWXRGMkc1SHpGTGJLMzl2WGZRN1BXNDhG?=
 =?utf-8?B?amFqSWdXeXdjUGNIaWdvNnV6ckpmcFBWZlYxR05FcW50WE9Bb1Qwc0dlUmNi?=
 =?utf-8?B?bVQxS1hRRU5OVWxlb0VRS3JxclVUZ3NHVVRGUjE4VUtVNzJPbHNrOEE2bDBk?=
 =?utf-8?B?VU41dGJqNWxCRjExTUxvdnZpYzhDZFA2OXNSR040K3N5M0tlYnVxbmsxQWlC?=
 =?utf-8?B?eWtOM2t5Q0ZoOXU1MUVxcHpWbVBTOERPeEp4NlZGem1GdmZFa0NtSHVOSXR0?=
 =?utf-8?B?eDRYVmxtK2xEaGpmL09WN0tGMFlzV3VLR2x3NWFTV0RGemNacE53bW42QWY5?=
 =?utf-8?B?d3MrMkRZNG9VR0dYaWR1SUc4Z2R6bGJZa2ZDYlhwQzJyaVZUdGFTOXRQMEVq?=
 =?utf-8?Q?bWwUP32W8VPs+uYrf3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c6ac19-164e-40b7-8884-08df157ecc04
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 12:17:24.6846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CPjfnclP92pGPIElDBRmeykgaCJEQ75iSTnCFa5RvJlUHgVcXFXEx8Xahi7rBgZT5MSziJVCM+RCtv9aNyl+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
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


On 9/18/2026 10:30 AM, Lazar, Lijo wrote:
>
>
> On 16-Sep-26 11:07 AM, Srinivasan Shanmugam wrote:
>> User-queue VMIDs receive their trap register state from MES/KIQ at queue
>> creation. Kernel-managed VMIDs do not; program them here.
>>
>> Add program_kernel_trap_tba_tma() to each gfxhub generation and call it
>> from setup_vmid_config(). No vmhub callback is introduced: the operation
>> is generation-specific and belongs in each gfxhub's own setup path.
>>
>> Both TBA and TMA addresses are GPU virtual addresses taken from the
>> common trap mapping established at vm_init. TRAP_EN is safe to set at
>> this point: any GPUVM assigned to a kernel-managed VMID already has a
>> valid trap mapping before it can execute work.
>>
>> TBA is the shared device-level ISA BO mapped into each VM at
>> AMDGPU_VA_RESERVED_TRAP_START. TMA starts at offset 0x1800 from the same
>> base, matching KFD_CWSR_TMA_OFFSET so both KFD and render-node VMs use
>> the same per-VM buffer layout.
>>
>> The helper is named program_kernel_trap_tba_tma() because it selects
>> each kernel-managed VMID and writes its TBA/TMA registers; it does not
>> configure the VMIDs themselves.
>>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  4 ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  9 +++++
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 35 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 35 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 39 +++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 35 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 35 ++++++++++++++++++
>>   7 files changed, 188 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> index 3313bc099cf4..d17f54ccadb0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> @@ -38,10 +38,6 @@
>>     extern int cwsr_enable;
>>   -#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
>> -#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
>> -#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
>> -
>>   #define SGPR_SIZE_PER_CU 0x4000
>>   #define LDS_SIZE_PER_CU 0x10000
>>   #define HWREG_SIZE_PER_CU 0x1000
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>> index 2d855433308a..5769c5acb5c0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>> @@ -26,6 +26,15 @@
>>   #include <linux/types.h>
>>   #include <linux/iosys-map.h>
>>   +/*
>> + * TBA occupies one page plus 2 KiB (0x1800). TMA starts at that 
>> offset.
>> + * Matches KFD_CWSR_TMA_OFFSET so both KFD and render-node paths share
>> + * the same per-VM buffer layout.
>> + */
>> +#define AMDGPU_TRAP_TBA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE + 2048) /* 
>> 0x1800 */
>> +#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
>> +#define AMDGPU_TRAP_TMA_OFFSET   (AMDGPU_TRAP_TBA_MAX_SIZE) /* 
>> 0x1800 */
>> +
>
> This doesn't work after the split to a separate tma bo. A new bo 
> mapping has to be at AMDGPU_PAGE_SIZE aligned offset. There is some 
> check like that in the mapping API is what I recall.

I checked the VM mapping validation and confirmed that the separate TMA 
BO needs GPU page alignment.

Since the UQ trap region reserves three pages, I'm planning to keep the 
TBA at AMDGPU_VA_RESERVED_TRAP_UQ_START and place the TMA after the 
two-page TBA, at TBA + 2 * AMDGPU_GPU_PAGE_SIZE.

I'll keep this layout inside amdgpu_trap and return both addresses 
through the helper you suggested.

Just to confirm, is this the layout you had in mind?

Thanks, Srini

>
>>   struct amdgpu_bo;
>>   struct amdgpu_bo_va;
>>   struct amdgpu_device;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
>> index 652eea6eae4a..687268e23344 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
>> @@ -22,6 +22,7 @@
>>    */
>>     #include "amdgpu.h"
>> +#include "amdgpu_trap.h"
>>   #include "gfxhub_v11_5_0.h"
>>     #include "gc/gc_11_5_0_offset.h"
>> @@ -290,6 +291,37 @@ static void 
>> gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
>>     }
>>   +static void
>> +gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>> +{
>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>> 0x1800 */
>
> Better to get it through a helper like amdgpu_trap_get_l1_addr(tba, 
> tma). The layout needs to stay within amdgpu_trap.
>
> Thanks,
> Lijo
>
>> +    int vmid;
>> +
>> +    if (!amdgpu_trap_is_enabled(adev) ||
>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>> +        return;
>> +
>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>> +
>> +    mutex_lock(&adev->srbm_mutex);
>> +    for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
>> +                 lower_32_bits(tba_addr >> 8));
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
>> +                 upper_32_bits(tba_addr >> 8) |
>> +                 (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
>> +                 lower_32_bits(tma_addr >> 8));
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
>> +                 upper_32_bits(tma_addr >> 8));
>> +    }
>> +    amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
>> +    mutex_unlock(&adev->srbm_mutex);
>> +}
>> +
>>   static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device 
>> *adev)
>>   {
>>       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>> @@ -337,6 +369,9 @@ static void 
>> gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>>       }
>>         hub->vm_cntx_cntl = tmp;
>> +
>> +    if (amdgpu_trap_is_enabled(adev))
>> +        gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
>>   }
>>     static void gfxhub_v11_5_0_program_invalidation(struct 
>> amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
>> index 6cbf837d50dd..b521a6c6eaf6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
>> @@ -22,6 +22,7 @@
>>    */
>>     #include "amdgpu.h"
>> +#include "amdgpu_trap.h"
>>   #include "gfxhub_v12_0.h"
>>     #include "gc/gc_12_0_0_offset.h"
>> @@ -295,6 +296,37 @@ static void 
>> gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
>>     }
>>   +static void
>> +gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>> +{
>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>> 0x1800 */
>> +    int vmid;
>> +
>> +    if (!amdgpu_trap_is_enabled(adev) ||
>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>> +        return;
>> +
>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>> +
>> +    mutex_lock(&adev->srbm_mutex);
>> +    for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
>> +                 lower_32_bits(tba_addr >> 8));
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
>> +                 upper_32_bits(tba_addr >> 8) |
>> +                 (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
>> +                 lower_32_bits(tma_addr >> 8));
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
>> +                 upper_32_bits(tma_addr >> 8));
>> +    }
>> +    amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
>> +    mutex_unlock(&adev->srbm_mutex);
>> +}
>> +
>>   static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>> @@ -342,6 +374,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct 
>> amdgpu_device *adev)
>>       }
>>         hub->vm_cntx_cntl = tmp;
>> +
>> +    if (amdgpu_trap_is_enabled(adev))
>> +        gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
>>   }
>>     static void gfxhub_v12_0_program_invalidation(struct 
>> amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
>> index 4c2fd1e6616e..ac52ccda713d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
>> @@ -21,6 +21,7 @@
>>    *
>>    */
>>   #include "amdgpu.h"
>> +#include "amdgpu_trap.h"
>>   #include "amdgpu_xcp.h"
>>   #include "gfxhub_v12_1.h"
>>   @@ -406,6 +407,41 @@ static void 
>> gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
>>       }
>>   }
>>   +static void
>> +gfxhub_v12_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>> +{
>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>> 0x1800 */
>> +    int xcc, vmid;
>> +
>> +    if (!amdgpu_trap_is_enabled(adev) ||
>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>> +        return;
>> +
>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>> +
>> +    mutex_lock(&adev->srbm_mutex);
>> +    for_each_inst(xcc, adev->gfx.xcc_mask) {
>> +        for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; 
>> vmid++) {
>> +            amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, xcc);
>> +            WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_LO,
>> +                     lower_32_bits(tba_addr >> 8));
>> +            WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_HI,
>> +                     upper_32_bits(tba_addr >> 8) |
>> +                     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>> +            WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_LO,
>> +                     lower_32_bits(tma_addr >> 8));
>> +            WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_HI,
>> +                     upper_32_bits(tma_addr >> 8));
>> +        }
>> +    }
>> +    /* Reset the VMID selector on every XCC instance. */
>> +    for_each_inst(xcc, adev->gfx.xcc_mask)
>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
>> +    mutex_unlock(&adev->srbm_mutex);
>> +}
>> +
>>   static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device 
>> *adev,
>>                              uint32_t xcc_mask)
>>   {
>> @@ -468,6 +504,9 @@ static void 
>> gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
>>             hub->vm_cntx_cntl = tmp;
>>       }
>> +
>> +    if (amdgpu_trap_is_enabled(adev))
>> +        gfxhub_v12_1_program_kernel_trap_tba_tma(adev);
>>   }
>>     static void gfxhub_v12_1_xcc_program_invalidation(struct 
>> amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> index 9ea593e2c719..ba2d5d719474 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> @@ -22,6 +22,7 @@
>>    */
>>     #include "amdgpu.h"
>> +#include "amdgpu_trap.h"
>>   #include "gfxhub_v2_0.h"
>>     #include "gc/gc_10_1_0_offset.h"
>> @@ -280,6 +281,37 @@ static void 
>> gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
>>     }
>>   +static void
>> +gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>> +{
>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>> 0x1800 */
>> +    int vmid;
>> +
>> +    if (!amdgpu_trap_is_enabled(adev) ||
>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>> +        return;
>> +
>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>> +
>> +    mutex_lock(&adev->srbm_mutex);
>> +    for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
>> +        WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
>> +                 lower_32_bits(tba_addr >> 8));
>> +        WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
>> +                 upper_32_bits(tba_addr >> 8) |
>> +                 (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>> +        WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
>> +                 lower_32_bits(tma_addr >> 8));
>> +        WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
>> +                 upper_32_bits(tma_addr >> 8));
>> +    }
>> +    amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
>> +    mutex_unlock(&adev->srbm_mutex);
>> +}
>> +
>>   static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>> @@ -327,6 +359,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct 
>> amdgpu_device *adev)
>>       }
>>         hub->vm_cntx_cntl = tmp;
>> +
>> +    if (amdgpu_trap_is_enabled(adev))
>> +        gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
>>   }
>>     static void gfxhub_v2_0_program_invalidation(struct amdgpu_device 
>> *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
>> index 9e6a6e13dec0..204a8817df30 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
>> @@ -22,6 +22,7 @@
>>    */
>>     #include "amdgpu.h"
>> +#include "amdgpu_trap.h"
>>   #include "gfxhub_v3_0.h"
>>     #include "gc/gc_11_0_0_offset.h"
>> @@ -287,6 +288,37 @@ static void 
>> gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
>>     }
>>   +static void
>> +gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>> +{
>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>> 0x1800 */
>> +    int vmid;
>> +
>> +    if (!amdgpu_trap_is_enabled(adev) ||
>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>> +        return;
>> +
>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>> +
>> +    mutex_lock(&adev->srbm_mutex);
>> +    for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
>> +                 lower_32_bits(tba_addr >> 8));
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
>> +                 upper_32_bits(tba_addr >> 8) |
>> +                 (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
>> +                 lower_32_bits(tma_addr >> 8));
>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
>> +                 upper_32_bits(tma_addr >> 8));
>> +    }
>> +    amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
>> +    mutex_unlock(&adev->srbm_mutex);
>> +}
>> +
>>   static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>> @@ -334,6 +366,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct 
>> amdgpu_device *adev)
>>       }
>>         hub->vm_cntx_cntl = tmp;
>> +
>> +    if (amdgpu_trap_is_enabled(adev))
>> +        gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
>>   }
>>     static void gfxhub_v3_0_program_invalidation(struct amdgpu_device 
>> *adev)
>
