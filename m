Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42587C61DC2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 04:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9375F10E245;
	Wed, 26 Aug 2026 04:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4r6yi5g5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68CD110E245
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 04:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRYHlktclcpu9aQPYPOBHVJgCoGN4VrcL00t+89EExS8T+cZHuv7FLwAOPc9ML4HVw+Hhs7eCC5ceZ9V3CUSJkdx+FQCz4rR1Qu8H5+NJU9pi7uDsuYjGrmvpmKls7slDTqI0phHL6hsOWbKb4f/EZw+6iZ5KUqmEGzkAWUlTZdKF1RHc6fOlOLgKgVvquF+hfcDciJUbQ/HpoufaAo/rFCrB+OqUz6dAYSS43QcrmtIVUE0xbHFi+r552lz/Yi5n73j51WIgfV03xcGNymkmwR9agwJHvPJWfOIyX8ckNluruHExWLfE8udqd0bqrnYX/htBkZBzQGOAxCKFU6Q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmbvoVaUbEiMXFCHIxESVjILKlQG67mcZtqVoI7a41s=;
 b=kW2gb/BwlZ1hMI/14ToSwVHA1Ki33LgSt4eJz3BN1pelTEaP+qGVd2IlSLyeGr21pnSr4WktYWy0AjTVyhcHAPJHkKdEIXVWTgXNSlz//RrIpUpsfAV8xAep7ZRJfZ81yrQKJPiruhJkQNZ0SEa6/m5/esYZk330yavw87P69iEjtLel1lns6aSVKtlD42xXsJ6upnbxklAwO4109gS55UPGA0PROcpvCMnSe89TNAuQN/su7Joi4DBKI+GVTY2AaFhQLgS42L+vDkG8/GRnxQKF+W6LWDgFf0TCTXmrRiC1zk5CfbCp47JaaoZNQwj95hswREEE0+8NY33AQIRkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmbvoVaUbEiMXFCHIxESVjILKlQG67mcZtqVoI7a41s=;
 b=4r6yi5g5zkzmaBzXJeNVvmWYP1QEpcquHv+BdZzoBpLQ2oO1Chz8pLiFcMYKgXNasy0Kx3kZH3B5yldStNqFKhwDwlthb0xP931ADMZAst+jFYECyxqbo7BjssYaU+qXBiSDw4W6v7VCLDymJ7e+fCzP893cmz+Ay1ZGrqGEvHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 04:22:50 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Wed, 26 Aug 2026
 04:22:50 +0000
Message-ID: <d55402ab-24e0-4e7b-ad04-4cd4fe1dca98@amd.com>
Date: Tue, 25 Aug 2026 23:22:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Rename amdgpu_cwsr to amdgpu_trap
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260824185055.3975572-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260824185055.3975572-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0187.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::12) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcc481c-f8f9-4793-0b54-08df0329b06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|6133799003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GeSidL6V3kwlru9ZHjxEzmL9AYB0qQeJWKT41eh6ZsW4oM6Fcv635SbvWErBeNLjf6b5iIARfnTxMUjb9mSBbZwvr+1jVEdLjnDRFFqPm2rL9w+js4KX2Oz//i/6dITLi5+sqNnV9dQIqTXSN+NcF7cxo3tA/Hvul3XCPz/pDXVe3vu0Z0uzEWimL7HWMci61er95dgIOGmQ1R7qCJmluk6fG3KHFx1YqojsfBBBBj8mr/m85AT7LzU9BUWGeO8P1KIB8N1/EUNofHgYww6F6gzdO+xX5ElyohKSCxGYfLIeYqjq9redm3tGZBBHllIcls6INtvXG6If4mfetlAlKOxoSCLwlYmeVzCo7PIfIBsRWkLuaX92foVNcDJ2A2GFwdju1R/8eedppmODcm1X/8E4SghBl9Xh+UCK0A4VtFKAr9NzVpRRCL7CWKzqKmff+0+p6r9lHdsE3oWLtgu2YKkyG8AAdDIlGQSTt393SC+uYcCSAtWK/Zq9+w/WoRa9a/lkkELawSc/AWmUddKYjjjD9862BPhpE4n+1PRuf5HR2H4yrzm/eorSieDaePxqO47Rp+cdmO812OugNGcLijP/ri/V3G2pwlPDZZBmzlQnHU2dzYcS+TPZrtcdXGax3NEGUYUo4F7KFN20AzxGFqWp8AEweqBQ1pg3AuVlCh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(6133799003)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3dVbThJLzdvTW1maGdiRnYxQVg0bS9kd1F2VVZKT2hOR1AyRGJ3OUVjdHll?=
 =?utf-8?B?dU9xUVg3cllxZUxRSml2U2ovNFcwMGFFL3crWnFMUkZnMWRSK1NxNlRkQUd0?=
 =?utf-8?B?a0hvSkEyVkFZRjF5alJnM2sxeStoVnlGOUxCT3U0MEhZMWJvaWNseU9yYzNB?=
 =?utf-8?B?N3czSXRBdENqNlhUUlAwM0ZsNXNwRmovbDJLOXFxNzRtTURkNmJCK3RFOXRu?=
 =?utf-8?B?T25NTkRUbWorK1J2R0UvbUVGK096T2hrbmZGZ1Z3SWFuaTRFc25Zb0F2a2xN?=
 =?utf-8?B?UlVzbGVQRDBqLzU4S0NuWHFISndib0NlazVya0N1THp5cWUrMmNLcCt4VFJw?=
 =?utf-8?B?YzkwRDVqVTlLQm9RaVB4RVhjeVI1ZUlCNng1K3ZoWXhaS0ROTWxaK3pkeXpG?=
 =?utf-8?B?dERSSHFka1R1Wll3aVZjWVZNeVV2MDJBbVIyUnZSajZhalp4dFRBZWk3L2RN?=
 =?utf-8?B?VVFzYTBMWlVUWWVNdHZqZGNvek16eXdJZ3I5bUozZFU3TmF5cC9ySXFPZlhr?=
 =?utf-8?B?T0RFSmc3UmM3Y3JhSFMwY2k3aE5hOUZZaHpMbVpySmlFWk5IVExHK1liRDNQ?=
 =?utf-8?B?K3BHM3VWbU5sNlJGYmc0TnNkeFVLY0pFOUFaN0UyZzJ6KytDOTU3SENMUnlO?=
 =?utf-8?B?dHdUUVl0djJ2YUErVUVGUDJCY21hMlpZRjZxRWp5QlNYUWZnRTkraWVXNEI3?=
 =?utf-8?B?OUk1TjAyQmRXTmo2YXYvY2hZMjBPMGFzVFlJNTJ6VUtxVHJzRjA3YVU2MmEv?=
 =?utf-8?B?RlVnOXNVMEdxQW40U2NFYUJwS3MzWk95TDhNMnRBbm42UUVEM3czV2Q1d1A0?=
 =?utf-8?B?dEdQaU5KZi9QY29EUm91bm5ON0tUVUNib00yRTlvNjhkcW5TS2lRTEFWMG11?=
 =?utf-8?B?b0FLTWxnZ2hNb0hpc1pTRDVhMnh4dmdoeS9GaFNGY1BVNGM2cG43Yi9STE0w?=
 =?utf-8?B?S0hrUmNneUE3aVF2Qm4xVlF6WG83SWRVejltWFh5L1ZDRGp4cTlaUmpSdmx1?=
 =?utf-8?B?S1Bjb0FwYlJac2hvYlpyWHJyR1AvUC9sZFRBTTFTUkJaWXR5a1VhVk1qdzdE?=
 =?utf-8?B?WnBsUmJqK0IvakhZY3Z4TEJmOUN0am5MMllPcUFLeUYvTitvdzNBMGM0ME5r?=
 =?utf-8?B?RjFkMlVDbGRNQ1AyZkRCdndxbEo3U2FOWXl6MmdFSWxHQ0ZpRHozL084eFRU?=
 =?utf-8?B?YjV5cGVTR3NRZzc5ZHQvN2hDYXN1UDJZTWFwSG9GV1l5TFp0Z21XajBabHdV?=
 =?utf-8?B?Q0gvblpNTXl2ZlNuRWJJWm0wZ1Jod1VMRW1may9kOFlPbDd0MnpHWWorU3FF?=
 =?utf-8?B?Tis4am9mL3JpeFpMSjY4enlmV0RpQUpXRmE0R2FVVnRVVUs5ZUVKZjBrbkd2?=
 =?utf-8?B?cEpjSnU1NnU1cGE1RTR4TkJYY1kvUUhGWkNtNXVQM3pEY0JqTVliTnRXMzBX?=
 =?utf-8?B?OVBzblpKY2dDRzZza2VxVmxXS2pobU1ybzN5TFk3c3ZOL0pBcSt2UkJuWEJj?=
 =?utf-8?B?UWorTTFlQlVLNzFSUXVEZythSVIxSW5VRWw4L2p0TU9sc0dVcEV4MittTmFB?=
 =?utf-8?B?QlpoQWs1cjZYOHA3N3RWazA2REpObERJajNXS2pBTFRWa0ZkaVloRHFhN1Fz?=
 =?utf-8?B?NzRmT081cWNYWDR1WE9sNDNISjVvUkl6Z090Y0ZFOENHMU4rUmFLRmNjNjZN?=
 =?utf-8?B?YTlTbFVCWW1ld2NyNkdack9VWVJmTXVOTGgxa0x6QitiajNvU2Vobm9HK1RQ?=
 =?utf-8?B?Y0M5MmNmblJjTU9hQ1dFSWRaOEszYTd1YTUzVkl6MjRJM045MUZOdWpha1N3?=
 =?utf-8?B?QXlKMy9pV2N3dlZrYlozaWlXTHY4YWJhdHE2UVBFbDlMY29nNlBPSlNtRGxt?=
 =?utf-8?B?TWppcGtYcUFtUkNCK3B1K1ZyRmt1cjk0bUp1dG94czZiczlQRHlLdElIK1JW?=
 =?utf-8?B?R0I5Zm9IVGlpOUdIMWpkNzMyQ1g5UWR2cElIV09RT1VEY3RaTkFqQkJGUWRs?=
 =?utf-8?B?RDdIWHcrbXhtT2pTa3I1dWI1Z2N4anpyMWRxY1YyeG9aMHdzVUxsVW9GS0ll?=
 =?utf-8?B?Uy9yejlxT0VnTHlUb0o3QmJWR1RIemIrZjhnSkcyZEJxQzBIU2dYSGFaNm4w?=
 =?utf-8?B?KzVLRFBoY3RRRzAzeVQ0ZVlFdVVVTCtKUXdFdlQ2ZWhCUkk1L1JhSDdKOTht?=
 =?utf-8?B?Y3RyR2tNZGJEZXhONDhNZG4rWVlWakF0VExZb0tWem0xeXNYQS9rb0dCNE8y?=
 =?utf-8?B?ZkhUaEhOZzRQaUZ5MjdiK0N5ekcwbFhBZHNCVG5PY2NIOHQxNUhCblU3ckVU?=
 =?utf-8?B?aXcvekw2OC9LOVIyb2gyMU04RTg5VTdwSGljMHFNc1pnU3liTmtEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcc481c-f8f9-4793-0b54-08df0329b06b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 04:22:50.0931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd3QKqZznHEDHRd7SXXjsHWQOlgJz+3sKY5bz+udx6kQK64iZPXww7Q0kepxtjakjpVHCsoaXrfa2KR1TTzCIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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



On 8/24/26 13:50, Srinivasan Shanmugam wrote:
> CWSR (Compute Wave Save Restore) is only the context save/restore
> feature. The level 1 trap handler manages CWSR as well as the
> second-level userspace trap handler added for render-node user queues.
> Keeping the file and ioctl named after CWSR is misleading now that the
> code manages both levels of trap handling.
> 
> Rename files and ioctl to reflect the broader trap handler scope so
> future trap handler features have a natural home without further naming
> confusion.
> 
>    amdgpu_cwsr.c         → amdgpu_trap.c
>    amdgpu_cwsr.h         → amdgpu_trap.h
>    AMDGPU_CWSR ioctl     → AMDGPU_TRAP ioctl
>    amdgpu_cwsr_* symbols → amdgpu_trap_* symbols
> 
> The cwsr_enable module parameter and cwsr_trap_handler.h ISA binaries
> are not renamed — they are specific to the CWSR context save feature.
> 
> v2 (Alex):
> - Group the CWSR save area size fields into a nested 'cwsr' struct
>    inside amdgpu_trap_info. This keeps CWSR-specific data visually
>    separated from the broader trap handler infrastructure and makes
>    it clear which fields belong to CWSR vs future trap features.
> - Keep the local variable name 'cwsr_info' in amdgpu_kms.c since
>    that code only deals with CWSR save area sizes. Renaming it
>    'trap_info' was misleading as it has nothing to do with trap
>    handlers in general.
> - Rename cwsr_params to trap_params and rename the function
>    amdgpu_userq_input_cwsr_params_validate() to
>    amdgpu_userq_input_trap_params_validate(). The parameter type was
>    already renamed to amdgpu_trap_params but the variable name was
>    still cwsr_params, causing a mismatch.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  16 +-
>   .../amdgpu/{amdgpu_cwsr.c => amdgpu_trap.c}   | 265 +++++++++---------
>   .../amdgpu/{amdgpu_cwsr.h => amdgpu_trap.h}   |  52 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  13 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   7 +-
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  23 +-
>   include/uapi/drm/amdgpu_drm.h                 |  14 +-
>   11 files changed, 204 insertions(+), 206 deletions(-)
>   rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.c => amdgpu_trap.c} (63%)
>   rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.h => amdgpu_trap.h} (63%)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6fb0a913e33b..ec199715ee76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>   	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
>   	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> -	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
> +	amdgpu_wb.o amdgpu_trap.o amdgpu_events.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8eff6b9ebe81..e3763c197138 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -327,8 +327,8 @@ struct amdgpu_reset_context;
>   struct amdgpu_reset_control;
>   struct amdgpu_coredump_info;
>   struct amdgpu_video_codecs;
> -struct amdgpu_cwsr_isa;
> -struct amdgpu_cwsr_trap_obj;
> +struct amdgpu_trap_isa;
> +struct amdgpu_trap_obj;
>   
>   enum amdgpu_cp_irq {
>   	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> @@ -417,7 +417,7 @@ struct amdgpu_fpriv {
>   	struct xarray		bo_list_handles;
>   	struct amdgpu_ctx_mgr	ctx_mgr;
>   	struct amdgpu_userq_mgr	userq_mgr;
> -	struct amdgpu_cwsr_trap_obj *cwsr_trap;
> +	struct amdgpu_trap_obj *trap_obj;
>   
>   	/* Eviction fence infra */
>   	struct amdgpu_eviction_fence_mgr evf_mgr;
> @@ -965,7 +965,7 @@ struct amdgpu_device {
>   	 */
>   	struct amdgpu_kfd_dev		kfd;
>   
> -	struct amdgpu_cwsr_info *cwsr_info;
> +	struct amdgpu_trap_info *trap_info;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c924a55fd16f..380989f4c965 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -81,7 +81,7 @@
>   #include "amdgpu_events.h"
>   #include "amdgpu_virt.h"
>   #include "amdgpu_dev_coredump.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>   
>   #include <linux/suspend.h>
>   #include <drm/task_barrier.h>
> @@ -2395,7 +2395,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	r = amdgpu_cper_init(adev);
>   
>   	if (!r) {
> -		r = amdgpu_cwsr_init(adev);
> +		r = amdgpu_trap_init(adev);
>   		if (r == -EOPNOTSUPP)
>   			r = 0;
>   	}
> @@ -2797,7 +2797,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   {
>   	int i, r;
>   
> -	amdgpu_cwsr_fini(adev);
> +	amdgpu_trap_fini(adev);
>   	amdgpu_cper_fini(adev);
>   
>   	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7c473f60bd28..a93ee106ab92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -52,7 +52,7 @@
>   #include "amdgpu_sched.h"
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_userq.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>   #include "amdgpu_userq_fence.h"
>   #include "../amdxcp/amdgpu_xcp_drv.h"
>   
> @@ -3079,7 +3079,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
>   	/* KMS */
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f8a30e52e2a0..b89ee6d907d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -48,7 +48,7 @@
>   #include "amdgpu_userq.h"
>   #include "amdgpu_video_codecs.h"
>   #include "amdgpu_vm.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>   
>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>   {
> @@ -1499,15 +1499,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		int num_xcc, r;
>   
>   		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
> -		if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
> +		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>   			return -EOPNOTSUPP;
>   		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>   		cwsr_info.ctl_stack_size =
> -			adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +			adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>   		cwsr_info.dbg_mem_size =
> -			adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
> +			adev->trap_info->cwsr.xcc_dbg_mem_sz * num_xcc;
>   		cwsr_info.min_save_area_size =
> -			amdgpu_cwsr_size_needed(adev, num_xcc);
> +			amdgpu_trap_size_needed(adev, num_xcc);
>   		r = copy_to_user(out, &cwsr_info,
>   				 min((size_t)size, sizeof(cwsr_info))) ?
>   			    -EFAULT :
> @@ -1641,8 +1641,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   
>   	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>   
> -	if (amdgpu_cwsr_is_enabled(adev)) {
> -		r = amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap);
> +	if (amdgpu_trap_is_enabled(adev)) {
> +		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
>   		if (r)
>   			dev_dbg(adev->dev, "cwsr trap not enabled");
>   	}
> @@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   	}
>   
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> -	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
> +	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>   
>   	if (pasid)
>   		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> similarity index 63%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 7e5a08b0a1c8..27075d33cbc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -23,13 +23,13 @@
>   
>   #include "amdgpu.h"
>   #include "cwsr_trap_handler.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>   
>   extern int cwsr_enable;
>   
> -#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
> +#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
>   
>   #define SGPR_SIZE_PER_CU 0x4000
>   #define LDS_SIZE_PER_CU 0x10000
> @@ -38,12 +38,12 @@ extern int cwsr_enable;
>   #define DEBUGGER_BYTES_PER_WAVE 32
>   #define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
>   
> -enum amdgpu_cwsr_region {
> -	AMDGPU_CWSR_TBA,
> -	AMDGPU_CWSR_TMA,
> +enum amdgpu_trap_region {
> +	AMDGPU_TRAP_TBA,
> +	AMDGPU_TRAP_TMA,
>   };
>   
> -static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
> +static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
>   {
>   	uint64_t addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
>   
> @@ -52,7 +52,7 @@ static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
>   	return addr;
>   }
>   
> -static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
> +static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
>   {
>   	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>   
> @@ -63,80 +63,80 @@ static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
>   	return true;
>   }
>   
> -uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
> +uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc)
>   {
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>   		return 0;
>   
>   	return num_xcc *
> -	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
> +	       (adev->trap_info->cwsr.xcc_cwsr_sz + adev->trap_info->cwsr.xcc_dbg_mem_sz);
>   }
>   
> -static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
> -					 struct amdgpu_cwsr_info *cwsr_info)
> +static void amdgpu_trap_init_isa_details(struct amdgpu_device *adev,
> +					 struct amdgpu_trap_info *trap_info)
>   {
>   	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>   
>   	if (gc_ver < IP_VERSION(9, 0, 1)) {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx8_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx8_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
>   	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_arcturus_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_arcturus_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
>   	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_aldebaran_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_aldebaran_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
>   	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
>   		   gc_ver == IP_VERSION(9, 4, 4)) {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
>   	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
> +		trap_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
>   	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx9_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx9_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
>   	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_nv1x_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_nv1x_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
>   	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx10_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx10_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
>   	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
>   		/* The gfx11 cwsr trap handler must fit inside a single
>   			   page. */
>   		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
> +		trap_info->isa_buf = cwsr_trap_gfx11_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
>   	} else if (gc_ver < IP_VERSION(12, 1, 0)) {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx12_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
>   	} else {
>   		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
>   	}
>   }
>   
> -static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
> +static uint32_t amdgpu_trap_get_vgpr_size_per_cu(struct amdgpu_device *adev)
>   {
>   	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>   	uint32_t vgpr_size;
> @@ -164,7 +164,7 @@ static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
>   	return vgpr_size;
>   }
>   
> -static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
> +static uint32_t amdgpu_trap_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
>   {
>   	uint32_t lds_sz_per_cu;
>   
> @@ -173,11 +173,11 @@ static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
>   			(adev->gfx.cu_info.lds_size << 10) :
>   			LDS_SIZE_PER_CU;
>   
> -	return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
> +	return amdgpu_trap_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
>   	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
>   }
>   
> -static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
> +static uint32_t amdgpu_trap_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
>   {
>   	uint32_t sz;
>   
> @@ -188,8 +188,8 @@ static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
>   	return sz;
>   }
>   
> -static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
> -					    struct amdgpu_cwsr_info *cwsr_info)
> +static void amdgpu_trap_init_save_area_info(struct amdgpu_device *adev,
> +					    struct amdgpu_trap_info *trap_info)
>   {
>   	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
>   	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> @@ -209,10 +209,10 @@ static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
>   			       array_count / gfx_info->max_sh_per_se * 512) :
>   			   cu_num * 32;
>   
> -	wg_data_size = ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_cu(adev),
> +	wg_data_size = ALIGN(cu_num * amdgpu_trap_get_wg_ctxt_size_per_cu(adev),
>   			     PAGE_SIZE);
>   	ctl_stack_size =
> -		wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
> +		wave_num * amdgpu_trap_ctl_stack_bytes_per_wave(adev) + 8;
>   	ctl_stack_size =
>   		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
>   		      PAGE_SIZE);
> @@ -226,62 +226,62 @@ static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
>   	if (IP_VERSION_MAJ(gc_ver) == 10)
>   		ctl_stack_size = min(ctl_stack_size, 0x7000);
>   
> -	cwsr_info->xcc_ctl_stack_sz = ctl_stack_size;
> -	cwsr_info->xcc_cwsr_sz = ctl_stack_size + wg_data_size;
> -	cwsr_info->xcc_dbg_mem_sz = dbg_mem_size;
> +	trap_info->cwsr.xcc_ctl_stack_sz = ctl_stack_size;
> +	trap_info->cwsr.xcc_cwsr_sz = ctl_stack_size + wg_data_size;
> +	trap_info->cwsr.xcc_dbg_mem_sz = dbg_mem_size;
>   }
>   
> -int amdgpu_cwsr_init(struct amdgpu_device *adev)
> +int amdgpu_trap_init(struct amdgpu_device *adev)
>   {
> -	struct amdgpu_cwsr_info *cwsr_info __free(kfree) =
> -		kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
> +	struct amdgpu_trap_info *trap_info __free(kfree) =
> +		kzalloc(sizeof(*trap_info), GFP_KERNEL);
>   	void *ptr;
>   	int r;
>   
> -	if (!amdgpu_cwsr_is_supported(adev))
> +	if (!amdgpu_trap_is_supported(adev))
>   		return -EOPNOTSUPP;
>   
> -	if (!cwsr_info)
> +	if (!trap_info)
>   		return -ENOMEM;
> -	amdgpu_cwsr_init_isa_details(adev, cwsr_info);
> +	amdgpu_trap_init_isa_details(adev, trap_info);
>   
> -	if (!cwsr_info->isa_sz)
> +	if (!trap_info->isa_sz)
>   		return -EOPNOTSUPP;
>   
> -	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAGE_SIZE,
> -				    AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->isa_bo,
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TBA_MAX_SIZE, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT, &trap_info->isa_bo,
>   				    NULL, &ptr);
>   	if (r)
>   		return r;
>   
> -	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
> +	memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
>   
> -	amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
> -	adev->cwsr_info = no_free_ptr(cwsr_info);
> +	amdgpu_trap_init_save_area_info(adev, trap_info);
> +	adev->trap_info = no_free_ptr(trap_info);
>   
>   	return 0;
>   }
>   
> -void amdgpu_cwsr_fini(struct amdgpu_device *adev)
> +void amdgpu_trap_fini(struct amdgpu_device *adev)
>   {
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>   		return;
>   
> -	amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
> -	kfree(adev->cwsr_info);
> -	adev->cwsr_info = NULL;
> +	amdgpu_bo_free_kernel(&adev->trap_info->isa_bo, NULL, NULL);
> +	kfree(adev->trap_info);
> +	adev->trap_info = NULL;
>   }
>   
>   /*
>    * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
> - * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, and each
> + * it maps virtual address amdgpu_trap_tba_vaddr() to this VM, and each
>    * compute queue can use this virtual address for wave save/restore
>    * operations to support compute preemption.
>    */
> -static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
> +static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>   				  struct amdgpu_vm *vm,
> -				  struct amdgpu_cwsr_trap_obj *cwsr,
> -				  enum amdgpu_cwsr_region region)
> +				  struct amdgpu_trap_obj *cwsr,
> +				  enum amdgpu_trap_region region)
>   {
>   	uint64_t cwsr_addr, va_flags, va;
>   	struct amdgpu_bo_va **bo_va;
> @@ -292,20 +292,20 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
>   	if (!cwsr || !vm)
>   		return -EINVAL;
>   
> -	cwsr_addr = amdgpu_cwsr_tba_vaddr(adev);
> +	cwsr_addr = amdgpu_trap_tba_vaddr(adev);
>   
> -	if (region == AMDGPU_CWSR_TBA) {
> -		size = AMDGPU_CWSR_TBA_MAX_SIZE;
> +	if (region == AMDGPU_TRAP_TBA) {
> +		size = AMDGPU_TRAP_TBA_MAX_SIZE;
>   		bo_va = &cwsr->tba_va;
> -		bo = adev->cwsr_info->isa_bo;
> +		bo = adev->trap_info->isa_bo;
>   		va = cwsr_addr;
>   		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
>   			    AMDGPU_VM_PAGE_EXECUTABLE);
>   	} else {
> -		size = AMDGPU_CWSR_TMA_MAX_SIZE;
> +		size = AMDGPU_TRAP_TMA_MAX_SIZE;
>   		bo_va = &cwsr->tma_va;
>   		bo = cwsr->tma_bo;
> -		va = cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
> +		va = cwsr_addr + AMDGPU_TRAP_TMA_OFFSET;
>   		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
>   	}
>   
> @@ -317,7 +317,7 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
>   	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
>   	if (r) {
>   		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
> -			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
> +			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
>   		amdgpu_vm_bo_del(adev, *bo_va);
>   		*bo_va = NULL;
>   		return r;
> @@ -327,13 +327,13 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
>   	if (r) {
>   		dev_err(adev->dev,
>   			"failed to do page table update of %s region, err=%d\n",
> -			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
> +			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
>   		amdgpu_vm_bo_del(adev, *bo_va);
>   		*bo_va = NULL;
>   		return r;
>   	}
>   
> -	if (region == AMDGPU_CWSR_TBA)
> +	if (region == AMDGPU_TRAP_TBA)
>   		cwsr->tba_gpu_va_addr = va;
>   	else
>   		cwsr->tma_gpu_va_addr = va;
> @@ -341,9 +341,9 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
> -				    struct amdgpu_cwsr_trap_obj *cwsr,
> -				    enum amdgpu_cwsr_region region)
> +static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
> +				    struct amdgpu_trap_obj *cwsr,
> +				    enum amdgpu_trap_region region)
>   {
>   	struct amdgpu_bo_va **bo_va;
>   	uint64_t va;
> @@ -352,7 +352,7 @@ static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
>   	if (!cwsr)
>   		return -EINVAL;
>   
> -	if (region == AMDGPU_CWSR_TBA) {
> +	if (region == AMDGPU_TRAP_TBA) {
>   		bo_va = &cwsr->tba_va;
>   		va = cwsr->tba_gpu_va_addr;
>   	} else {
> @@ -374,15 +374,15 @@ static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **trap_obj)
> +int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj)
>   {
> -	struct amdgpu_cwsr_trap_obj *cwsr;
> +	struct amdgpu_trap_obj *cwsr;
>   	struct amdgpu_bo *bo;
>   	struct drm_exec exec;
>   	int r;
>   
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>   		return -EOPNOTSUPP;
>   	if (!vm || !trap_obj)
>   		return -EINVAL;
> @@ -390,7 +390,7 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (!cwsr)
>   		return -ENOMEM;
>   
> -	bo = adev->cwsr_info->isa_bo;
> +	bo = adev->trap_info->isa_bo;
>   	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>   	drm_exec_until_all_locked(&exec) {
>   		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> @@ -405,18 +405,18 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		}
>   	}
>   
> -	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TMA_MAX_SIZE, PAGE_SIZE,
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
>   				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
>   				    &cwsr->tma_cpu_addr);
>   	if (r)
>   		goto err;
>   
> -	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
> +	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
>   	if (r)
>   		goto err;
> -	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
> +	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
>   	if (r) {
> -		amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
> +		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
>   		goto err;
>   	}
>   
> @@ -433,38 +433,38 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> -int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> -				struct amdgpu_cwsr_params *cwsr_params,
> +int amdgpu_trap_validate_params(struct amdgpu_device *adev,
> +				struct amdgpu_trap_params *trap_params,
>   				int num_xcc)
>   {
>   	uint32_t min_size, max_size;
>   
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>   		return -EOPNOTSUPP;
>   
> -	if (!cwsr_params)
> +	if (!trap_params)
>   		return -EINVAL;
>   
> -	min_size = amdgpu_cwsr_size_needed(adev, num_xcc);
> +	min_size = amdgpu_trap_size_needed(adev, num_xcc);
>   	max_size = 2 * min_size;
>   	/*
>   	 * Only save area size details checked. Address validation needs to be
>   	 * carried out separately. User is expected to pass a cwsr buffer area
>   	 * with size >= ctl stack size + wg data size + debug memory size
>   	 */
> -	if (cwsr_params->cwsr_sz < min_size ||
> -	    cwsr_params->cwsr_sz > max_size) {
> +	if (trap_params->cwsr_sz < min_size ||
> +	    trap_params->cwsr_sz > max_size) {
>   		dev_dbg(adev->dev,
>   			"queue cwsr size 0x%x should be within min %u : max %u\n",
> -			cwsr_params->cwsr_sz, min_size, max_size);
> +			trap_params->cwsr_sz, min_size, max_size);
>   		return -EINVAL;
>   	}
>   
>   	return 0;
>   }
>   
> -void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **trap_obj)
> +void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj)
>   {
>   	struct amdgpu_bo *tba_bo;
>   	struct amdgpu_bo *tma_bo;
> @@ -473,7 +473,7 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
>   		return;
> -	tba_bo = adev->cwsr_info->isa_bo;
> +	tba_bo = adev->trap_info->isa_bo;
>   	tma_bo = (*trap_obj)->tma_bo;
>   
>   	if (!tba_bo || !tma_bo)
> @@ -496,8 +496,8 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		}
>   	}
>   
> -	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
> -	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
> +	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TBA);
> +	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
>   err:
>   	drm_exec_fini(&exec);
>   	amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
> @@ -505,9 +505,9 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	*trap_obj = NULL;
>   }
>   
> -static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
> +static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
>   					  struct amdgpu_vm *vm,
> -					  struct amdgpu_cwsr_usr_addr *usr_addr)
> +					  struct amdgpu_trap_usr_addr *usr_addr)
>   {
>   	struct amdgpu_bo_va_mapping *va_map;
>   	uint64_t addr;
> @@ -539,23 +539,23 @@ static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -static int amdgpu_cwsr_set_l2_trap_handler(
> -	struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -	struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_addr *tma,
> -	struct amdgpu_cwsr_usr_addr *tba)
> +static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +					   struct amdgpu_trap_obj *cwsr_obj,
> +					   struct amdgpu_trap_usr_addr *tma,
> +					   struct amdgpu_trap_usr_addr *tba)
>   {
>   	uint64_t *l1tma;
>   	int r;
>   
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>   		return -EOPNOTSUPP;
>   
>   	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
>   		return -EINVAL;
> -	r = amdgpu_cwsr_validate_user_addr(adev, vm, tma);
> +	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
>   	if (r)
>   		return r;
> -	r = amdgpu_cwsr_validate_user_addr(adev, vm, tba);
> +	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
>   	if (r)
>   		return r;
>   
> @@ -570,7 +570,7 @@ static int amdgpu_cwsr_set_l2_trap_handler(
>    * Userspace cwsr related ioctl
>    */
>   /**
> - * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
> + * amdgpu_trap_ioctl - Handle trap handler specific requests.
>    *
>    * @dev: drm device pointer
>    * @data: request object
> @@ -579,29 +579,28 @@ static int amdgpu_cwsr_set_l2_trap_handler(
>    * This function is used to perform cwsr and trap handler related operations
>    * Returns 0 on success, error code on failure.
>    */
> -int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
> +int amdgpu_trap_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> -	union drm_amdgpu_cwsr *cwsr = data;
> +	union drm_amdgpu_trap *cwsr = data;
>   	struct amdgpu_fpriv *fpriv;
>   	int r;
>   
>   	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>   
> -	if (!fpriv->cwsr_trap)
> +	if (!fpriv->trap_obj)
>   		return -EOPNOTSUPP;
>   
>   	switch (cwsr->in.op) {
> -	case AMDGPU_CWSR_OP_SET_L2_TRAP: {
> -		struct amdgpu_cwsr_usr_addr tba;
> -		struct amdgpu_cwsr_usr_addr tma;
> +	case AMDGPU_TRAP_OP_SET_L2_TRAP: {
> +		struct amdgpu_trap_usr_addr tba;
> +		struct amdgpu_trap_usr_addr tma;
>   
>   		tba.addr = cwsr->in.l2trap.tba_va;
>   		tba.size = cwsr->in.l2trap.tba_sz;
>   		tma.addr = cwsr->in.l2trap.tma_va;
>   		tma.size = cwsr->in.l2trap.tma_sz;
> -		r = amdgpu_cwsr_set_l2_trap_handler(
> -			adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
> +		r = amdgpu_trap_set_l2_trap_handler(adev, &fpriv->vm, fpriv->trap_obj, &tma, &tba);
>   	} break;
>   	default:
>   		return -EINVAL;
> @@ -610,13 +609,13 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	return r;
>   }
>   
> -int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
> -				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
> +int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
> +				    struct amdgpu_trap_obj *cwsr_obj,
>   				    bool enabled)
>   {
>   	uint64_t *l1tma;
>   
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>   		return -EOPNOTSUPP;
>   
>   	if (!cwsr_obj)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> similarity index 63%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index 06036954627e..6d4664469bad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -20,8 +20,8 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
> -#ifndef AMDGPU_CWSR_H
> -#define AMDGPU_CWSR_H
> +#ifndef AMDGPU_TRAP_H
> +#define AMDGPU_TRAP_H
>   
>   #include <linux/types.h>
>   
> @@ -31,11 +31,11 @@ struct amdgpu_device;
>   struct amdgpu_vm;
>   
>   /**
> - * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
> + * struct amdgpu_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
>    * @bo: Buffer object for CWSR area
>    * @bo_va: Buffer object virtual address mapping
>    */
> -struct amdgpu_cwsr_trap_obj {
> +struct amdgpu_trap_obj {
>   	uint64_t tma_gpu_va_addr;
>   	uint64_t tba_gpu_va_addr;
>   
> @@ -45,55 +45,57 @@ struct amdgpu_cwsr_trap_obj {
>   	void *tma_cpu_addr;
>   };
>   
> -struct amdgpu_cwsr_info {
> +struct amdgpu_trap_info {
>   	/* cwsr isa */
>   	struct amdgpu_bo *isa_bo;
>   	const void *isa_buf;
>   	uint32_t isa_sz;
>   	/* cwsr size info per XCC*/
> -	uint32_t xcc_ctl_stack_sz;
> -	uint32_t xcc_dbg_mem_sz;
> -	uint32_t xcc_cwsr_sz;
> +	struct {
> +		u32 xcc_ctl_stack_sz;
> +		u32 xcc_dbg_mem_sz;
> +		u32 xcc_cwsr_sz;
> +	} cwsr;
>   };
>   
> -struct amdgpu_cwsr_params {
> +struct amdgpu_trap_params {
>   	uint64_t ctx_save_area_address;
>   	/* cwsr size info */
>   	uint32_t cwsr_sz;
>   };
>   
> -struct amdgpu_cwsr_usr_addr {
> +struct amdgpu_trap_usr_addr {
>   	uint64_t addr;
>   	uint32_t size;
>   };
>   
> -int amdgpu_cwsr_init(struct amdgpu_device *adev);
> -void amdgpu_cwsr_fini(struct amdgpu_device *adev);
> +int amdgpu_trap_init(struct amdgpu_device *adev);
> +void amdgpu_trap_fini(struct amdgpu_device *adev);
>   
> -int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
> -void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
> -static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
> +int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj);
> +void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj);
> +static inline bool amdgpu_trap_is_enabled(struct amdgpu_device *adev)
>   {
> -	return adev->cwsr_info != NULL;
> +	return adev->trap_info;
>   }
>   
> -uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
> -int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> -				struct amdgpu_cwsr_params *cwsr_params,
> +uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc);
> +int amdgpu_trap_validate_params(struct amdgpu_device *adev,
> +				struct amdgpu_trap_params *trap_params,
>   				int num_xcc);
> -static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
> +static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
>   {
>   	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>   
>   	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
>   }
>   
> -int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
> +int amdgpu_trap_ioctl(struct drm_device *dev, void *data,
>   		      struct drm_file *filp);
> -int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
> -				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
> +int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
> +				    struct amdgpu_trap_obj *cwsr_obj,
>   				    bool enabled);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index feffebb210ea..db09e879b85e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -34,7 +34,7 @@
>   #include "amdgpu_hmm.h"
>   #include "amdgpu_userq_fence.h"
>   #include "amdgpu_trace.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>   
>   u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>   {
> @@ -249,9 +249,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>   	return -EINVAL;
>   }
>   
> -int amdgpu_userq_input_cwsr_params_validate(
> -	struct amdgpu_usermode_queue *queue,
> -	struct amdgpu_cwsr_params *cwsr_params)
> +int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
> +					    struct amdgpu_trap_params *trap_params)
>   {
>   	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
>   	struct amdgpu_device *adev = queue->userq_mgr->adev;
> @@ -260,16 +259,16 @@ int amdgpu_userq_input_cwsr_params_validate(
>   	int r;
>   
>   	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> -	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
> +	r = amdgpu_trap_validate_params(queue->userq_mgr->adev, trap_params,
>   					num_xcc);
>   	if (r)
>   		return r;
> -	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
> +	cwsr_size = amdgpu_trap_size_needed(queue->userq_mgr->adev, num_xcc);
>   	if (!cwsr_size)
>   		return -EOPNOTSUPP;
>   
>   	return amdgpu_userq_input_va_validate(
> -		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size,
> +		adev, queue, trap_params->ctx_save_area_address, cwsr_size,
>   		&queue->userq_vas.va.cwsr);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 26f7fef3048c..3e19bc6103a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -44,7 +44,7 @@ enum amdgpu_userq_state {
>   };
>   
>   struct amdgpu_mqd_prop;
> -struct amdgpu_cwsr_params;
> +struct amdgpu_trap_params;
>   
>   struct amdgpu_userq_obj {
>   	void		 *cpu_ptr;
> @@ -200,8 +200,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>   
>   void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>   					struct amdgpu_bo_va_mapping *mapping);
> -int amdgpu_userq_input_cwsr_params_validate(
> -	struct amdgpu_usermode_queue *queue,
> -	struct amdgpu_cwsr_params *cwsr_params);
> +int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
> +					    struct amdgpu_trap_params *trap_params);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 3fad95199e0c..6263f0f203af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -26,7 +26,7 @@
>   #include "amdgpu_gfx.h"
>   #include "mes_userqueue.h"
>   #include "amdgpu_userq_fence.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>   
>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -172,10 +172,10 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>   		queue_input.is_kfd_process = 1;
>   		queue_input.is_aql_queue = 1;
>   	}
> -	if (fpriv->cwsr_trap) {
> -		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
> -		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
> -		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
> +	if (fpriv->trap_obj) {
> +		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
> +		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
> +		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
>   	}
>   
>   	amdgpu_mes_lock(&adev->mes);
> @@ -455,7 +455,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   
>   	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>   		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> -		struct amdgpu_cwsr_params cwsr_params;
> +		struct amdgpu_trap_params trap_params;
>   
>   		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
>   			DRM_ERROR("Invalid compute IP MQD size\n");
> @@ -497,18 +497,17 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   			mqd_user->flags &
>   			AMDGPU_USERQ_CREATE_FLAGS_QUEUE_AQL_COMPUTE;
>   
> -		if (amdgpu_cwsr_is_enabled(adev)) {
> +		if (amdgpu_trap_is_enabled(adev)) {
>   			struct amdgpu_fpriv *fpriv =
>   				uq_mgr_to_fpriv(queue->userq_mgr);
>   			int num_xcc;
>   
>   			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>   							 fpriv->xcp_id);
> -			cwsr_params.ctx_save_area_address =
> +			trap_params.ctx_save_area_address =
>   				compute_mqd->ctx_save_area_va;
> -			cwsr_params.cwsr_sz = compute_mqd->ctx_save_area_size;
> -			r = amdgpu_userq_input_cwsr_params_validate(
> -				queue, &cwsr_params);
> +			trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
> +			r = amdgpu_userq_input_trap_params_validate(queue, &trap_params);
>   			if (r) {
>   				kfree(compute_mqd);
>   				goto free_mqd;
> @@ -518,7 +517,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   			userq_props->ctx_save_area_size =
>   				compute_mqd->ctx_save_area_size;
>   			userq_props->ctl_stack_size =
> -				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +				adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>   		}
>   
>   		kfree(compute_mqd);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9222be9a6d2a..552cbf483543 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -59,7 +59,7 @@ extern "C" {
>   #define DRM_AMDGPU_USERQ_WAIT		0x18
>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>   #define DRM_AMDGPU_PROC_OPTIONS		0x1A
> -#define DRM_AMDGPU_CWSR			0x1B
> +#define DRM_AMDGPU_TRAP			0x1B

I don't think you can do this.  Even if the definition is the same, it's 
going to break any userspace that was relying upon DRM_AMDGPU_CWSR 
define and need to have source changed when recompiling.

So I think you need to adjust it to have compatibility values something 
like this:

#define DRM_AMDGPU_CWSR			0x1B
#define DRM_AMDGPU_TRAP			DRM_AMDGPU_CWSR

>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -82,7 +82,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>   #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
> -#define DRM_IOCTL_AMDGPU_CWSR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
> +#define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)

Same as above comment.

>   
>   /**
>    * DOC: memory domains
> @@ -1748,10 +1748,10 @@ struct drm_amdgpu_info_cwsr {
>   };
>   
>   /* cwsr ioctl */
> -#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
> +#define AMDGPU_TRAP_OP_SET_L2_TRAP 1
>   
> -struct drm_amdgpu_cwsr_in {
> -	/* AMDGPU_CWSR_OP_* */
> +struct drm_amdgpu_trap_in {
> +	/* AMDGPU_TRAP_OP_* */
>   	__u32 op;
>   	struct {
>   		/* Level 2 trap handler base address */
> @@ -1765,8 +1765,8 @@ struct drm_amdgpu_cwsr_in {
>   	} l2trap;
>   };
>   
> -union drm_amdgpu_cwsr {
> -	struct drm_amdgpu_cwsr_in in;
> +union drm_amdgpu_trap {
> +	struct drm_amdgpu_trap_in in;
>   };
>   /*
>    * Supported GPU families

