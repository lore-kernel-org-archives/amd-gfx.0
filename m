Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AADCD8CA8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 11:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D1810E25D;
	Tue,  9 Jun 2026 11:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zaigEuqT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D2A10E27A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 11:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRSnJDELwHarZIdnll0/HLsMV+nggp1rnqI+7wVDDphMaGaMG/5x9O0emMuoTT2IMZTix2UX58COZsSVByYAN3r9NfgZ7j7nRWnCUyHb/Qkpo1/fdNUHnMaOSIXrkfY/bvlCGbILNMf/eWaE3hmi1x4JLY7L0XeL9KyR53YLXP0HYV5L9y24ZEatJO12jCq9Bqn0shCIGye+aEe1d6VMoWeOq6BQ6X6RrqwAysZa7ELlAXJxjgM9BlCazCos2JG/Xzg3gCyNA4gqEPHTowu6pwSgca3tD41qfizc8S9fKgbp+XXD8e/B/lJ50RP4YnObCfOu7EvFdF4vtxMX9e0KMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnpLS+egWxc9DVcsigg806b2TizGdME8m0p8ocV+RSY=;
 b=JfiuruUgedrlloBL2S6O14StIqnPblmRwMK7u9M1PtipQnK5bMz3My2mjvzX2RD9VLVmGZ1iUE+kKyDg1vdtyHiMDPC94CNcupfN4Bv02yjahuOvXfmFdtMZkZ2Yew1iAROYPSl3vDAlsTLqB6/zPKvAWslvLpV3y/iHUYD8W2mpAaH1nraaKzwIFUIee1sjQ0vTUfXq27VFz1Ty0aGxRZ+jVaQBUJtwWN7FpmwzF11MaRypKP825TLKjqFKoTrT7qdRRpTjLT8lfrQOQve+Ars4jpCezhj1+59Og373Ccj3PPFaK4bQljmUB6aYVEnMvDGAf3nqX5VvklAY0nrsmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnpLS+egWxc9DVcsigg806b2TizGdME8m0p8ocV+RSY=;
 b=zaigEuqT0Tq4IXT43WfYfqi3Y/01GYGytr/AzHKgGT1IQBikvq/1pMJxreTcc+DZAU40sA1ivdCCYtU3pj6COQYx1RAUTKj433LCF+Gl0Pd3nZUCxqTl3pQ0TJ1toadsDNYBT1iMhd0FDxe6NZ4jy7FKt7a/q1iV8t9tb0716jU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 9 Jun 2026
 11:04:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 11:04:26 +0000
Message-ID: <4800bbb0-7c69-454d-a107-922f986c1ab0@amd.com>
Date: Tue, 9 Jun 2026 13:04:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] drm/amdgpu: include amdgpu_init_level.h only
 where needed
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-11-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-11-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcda81c-73b4-467c-a57c-08dec616de1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|22082099003|18002099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: gourIBSHAxl63cV+Dt/Yh/T4fabUtUfGSn68xF5llkTzdjZZD6uHi++LDm2g8oP6wLkZh9ublTjelVG0t38v2LY7OfnPij0fl28Tc5SMrHN7SER7jtV1QkwZiSBIcUdg6R0FUMAip0nDidWDnDl+jUNRAATvUovxCvOkOsFfEPEh3dfHOalyR39x/Ek06dYRdLgJ1ZzgpnojnCyQtG4fa1UMY9U+Oe40BG2lJUok34UrDH3ONkr7Byok2lG/Vbme607ntm8SUS5FQqjOQ+w+dZULvSzf+jwrknUZWBciK3ucacTFgItITVIbq95zdxej7RETAqoVqUTblLXBIc7/L1CADnCZJolVU61EKpSjUxAsXrJPHjlYQVE18BKRsmgaCuiB0jfDRYd5/6W9hdoz+RaU5IPVTiSJJRpVjI/T+fy/rJSx17u6YZgBQ490KOmqxyNa58QdSf+Z12z7CGNu+Z5WDsTv5bhwyZNcp4MPqLnzfYZV9g3BKl3uhKc4IgqnZ8hBD1RvZ/otGANppKmf105woxinhqr5+ylZ1f2I5ag2yiiH5xKN8wJn9TSdRJ3tfqh8MsuXWYoGS2BVxm4xsCo/l6dhEI21VDgOFlPNjsT+aMjxbi9fzQBvXFueVuIYW/1pD84DDSLE9j0EMKsdjFChwmptT7ZdHvmvADwltetSOX/FMAfXELhuBq9pn1Mb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDh4RGE4MjMwbW9PZDRaRGh5S1lDcDB6WWdWdFFyZ2xlQjlXTy95WkJ6KzI0?=
 =?utf-8?B?cEMzaks2UzNGUHIzdXZVM2VQbUNJMTBMbzVnMS9aaTUvUFZ1cnBLMXMwakpI?=
 =?utf-8?B?d3piZkE0ZmRZVTNTVlV5Z21FRWM3d3FKNWJRdnZmZThmYUhuN3FhSm14bm9j?=
 =?utf-8?B?NXJwOW5vZ0tWRHVTVCtrbEtWQ0hPdzRxMlpCcGFwd2xCV1ZQQjhrMmFqUmFH?=
 =?utf-8?B?Mll3MCtuK29jRmRRZ3lKT2RtTUpnM0t2NjIyOHRyN3A3QWtCMDB4Q1NjOEhX?=
 =?utf-8?B?clRHamVkV1JYdUJURW9aZTJtN3crZTdNOHJyWUFVNmZtcFdWVGRoM3h4K2hm?=
 =?utf-8?B?dk1samVEa2liSG84cG5sQmZPSFhjQ09CN21ZTWl2cXRpTml5QUN0cUl4TnZF?=
 =?utf-8?B?NS9JL3VuUDA4YStNTy9GT3hmVFJuMHVVVjMvazllcFZMV1VVSEpPVXMzOTZm?=
 =?utf-8?B?S3FNNDEzRHQveWtnOTZja3YvdlFCSUNJMUdVdHVVbkZ3VjB2c1VTU1l2VGZi?=
 =?utf-8?B?bjhOMUpQNzhUM0QvREVQZDU0TzlNZEVldVh3WW5kV0U4akF1RTRheUJxbkJ0?=
 =?utf-8?B?U21PUHVQL2luekUyTHllWDNGTlZNUHdzQmttbXVmMlVEZy94eHh1M1pWUkhS?=
 =?utf-8?B?UmdpQmI0MUsreVR2UEZSQ3RuVkNJQ2Y0MnN3Q09MdFpMUGJlMGVjcnMxdXVw?=
 =?utf-8?B?U1ByUjltbVJjVm9RSDJkWTh5Wm9jYWIvRXp3bFVpWThrYWIyYzlrWENSNm45?=
 =?utf-8?B?eWlIWHg0SVc2Z0tibjdCSkk1N0QzdU1MSHp6b1ZQQmZjOG5OSlpoOVdMMmc2?=
 =?utf-8?B?RzBCZWlKMHRCcHVSaFk5RXhqZDVpdERoSnpqMTlCNmdHNUw0MURYV0p6Qk5Y?=
 =?utf-8?B?Yi9vZCsyOXFxR1ZDOEJqYmFjV1JwZTJjbDd5bkVqVE9oWUpHOXh4RnNnVTc4?=
 =?utf-8?B?VDBTdUtvV3l3MGZYZXlZcGJ5c3NXZW1iakRLQzFTaDJLUjFWVlBMa0k3ZWRD?=
 =?utf-8?B?R1JWbkZjc1B0WjNZaVgvek9sbEhZQlF0SjBFd016K1d3UXdXOGpOR0FjR3Q5?=
 =?utf-8?B?REJwNitibkEzS2EyMEdhUUtrWXlZTTE3emUrdXpST3Fwa3Y3SXVFenJ6d1gz?=
 =?utf-8?B?RjFueXYvZTFFRVpjZDB1Ti9DQW5HSFU3elh1L0FwUnhlQytHRzNVdTlqZzNq?=
 =?utf-8?B?V3NvSk1nV3JiSlBaNU50bFlzQzZEdVNvcnROZHpFMlpCb0RlMHBkeXhnRjFo?=
 =?utf-8?B?U3o3c21oQW9MVDZ4bGtPaDVXMWdjdTZ4UHB6NFAwd293bjNFVUZDWXZISS9H?=
 =?utf-8?B?SWpncFpMQUtjbEZ2cDNaMmsxeTQrWWdhcXVJUml6U1NCNEN0SmJFWmtqRE0v?=
 =?utf-8?B?VmovK2dGd0thSENoMkNoVEtTRFhsalpoUWk5ejQxa2pETjA4V2h0RllPY01P?=
 =?utf-8?B?MWQxZEVFRVdHTHl3UlV2aWdIWURYeFBDeHRXeEMzeDN3cmJmYTdVdDZqQzJF?=
 =?utf-8?B?eDRjRFY4bkUwT01peGQyUlNoRHNIcnNKaW4wR1J5UjV6YVVwSTBrMHFGajF6?=
 =?utf-8?B?Mk03b1FiRXN6YUpMVS9TVTJYc1NrV1pKaFNkMFUrdVc0djl4cnF6aXN4OFJv?=
 =?utf-8?B?OG9ZS1FQZ3p2R0lDNi83RmVnMnZGemtHbWdWcFFpRnZuUUNTMlZzclF3cFZQ?=
 =?utf-8?B?a2NqZnE2UERVU21hVzFPT3dyayticnc5eHlnV1hKQTdOVWM2ZXg0eHoza3pR?=
 =?utf-8?B?OXk5QlEzQVFoclY3amZXMjZFUWtad213OWxJV1J4OWFtZTJ3VmtTWHV2Rzgx?=
 =?utf-8?B?ZFRpQ1ZIVW1zbTRaUFRxYTdrVnc4THpHc0Jlejh1eXQ2NFBXVDFvR241aXBD?=
 =?utf-8?B?d2pEdzl0M01wOHhBSFhRMUpTaENnNGJFOS9xY1lDc21RL0hqQnhLbXp0UTZl?=
 =?utf-8?B?dmZsMzVENnNYWmlxejlzSGJyVDVUMVdONCtpb2xyakt6VE5WZXVsNFpuVDZT?=
 =?utf-8?B?TWo2Tk5OaFAzU1lzZDNvTzFvV1FzMXZ3SitiSWxGaWowYmdPUUZTSzNRUjM1?=
 =?utf-8?B?UE9vTitaZ0RRWGxBVUhSMVZFK0MwMVYxUGRyMmhvQk91Nkh2YTI3VDQ5Y2pa?=
 =?utf-8?B?OEU5Y0l1SkJ3bkt6THFRbFFEYkJWVkZZdFRFUmlKdjFJK3VYai9iUjVzY0M5?=
 =?utf-8?B?QjgxcVdSNXRpeHZTOGN2amQ0TGp5MFVJbmcvVDVhY25nZUtqOExodUk1ckd3?=
 =?utf-8?B?S2ozaS8zZ2dRR3BQQ0w2MTBGc01ncGg0OGZjemlGV240bm9xVnZhZXZPR0dM?=
 =?utf-8?Q?Ty8cXS52zVII9Fnx99?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcda81c-73b4-467c-a57c-08dec616de1b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:04:25.4479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H7/mTdQlE8ZLeimqnnEwg4LVuIZjpIqySf7TiF7hoGcNVD4itdxLJpUJF2g/cy1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999202
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

On 6/8/26 21:47, Shahyan Soltani wrote:
> Remove #include "amdgpu_init_level.h" from amdgpu.h and add forward declaration
> of struct amdgpu_init_level.
> 
> Add #include "amdgpu_init_level.h" into files aldebaran.c, amdgpu_device.c,
> amdgpu_gmc.c, amdgpu_reset.c, gmc_v9_0.c, sienna_cichlid.c, smu_v13_0_10.c,
> soc15.c, amdgpu_pm.c, and smu_v11_0.c.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

When amdgpu_init_level.h is renamed to amdgpu_device.h the patch is

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c         | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c      | 1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c          | 1 +
>  drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c    | 1 +
>  drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c      | 1 +
>  drivers/gpu/drm/amd/amdgpu/soc15.c             | 1 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 +
>  11 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index a7bc65099755..197876021b73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -30,6 +30,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_psp.h"
>  #include "amdgpu_xgmi.h"
> +#include "amdgpu_init_level.h"
>  
>  static bool aldebaran_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 06e61d66dcf3..a733ebb61300 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -116,7 +116,6 @@
>  #include "amdgpu_ip.h"
>  #include "amdgpu_acpi.h"
>  #include "amdgpu_mqd.h"
> -#include "amdgpu_init_level.h"
>  #include "amdgpu_video_codecs.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
> @@ -329,6 +328,7 @@ struct amdgpu_reset_context;
>  struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
>  struct amdgpu_uid;
> +struct amdgpu_init_level;
>  
>  enum amdgpu_cp_irq {
>  	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 20b67897d7ff..e7e60dba1e4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -79,6 +79,7 @@
>  #include "amdgpu_virt.h"
>  #include "amdgpu_dev_coredump.h"
>  #include "amdgpu_uid.h"
> +#include "amdgpu_init_level.h"
>  
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 13bec8461cde..e55fa66f7daa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -35,6 +35,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_init_level.h"
>  
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index da77e0ef129b..78121e698151 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -25,6 +25,7 @@
>  #include "aldebaran.h"
>  #include "sienna_cichlid.h"
>  #include "smu_v13_0_10.h"
> +#include "amdgpu_init_level.h"
>  
>  static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ced0f3941863..8b0aaa912a8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -64,6 +64,7 @@
>  
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
> +#include "amdgpu_init_level.h"
>  
>  /* add these here since we already include dce12 headers and these are for DCN */
>  #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x055d
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 2594467bdd87..940092d8bd1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -30,6 +30,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_psp.h"
>  #include "amdgpu_xgmi.h"
> +#include "amdgpu_init_level.h"
>  
>  static bool sienna_cichlid_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> index 70569ea906bc..93bc343fdfeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -28,6 +28,7 @@
>  #include "amdgpu_ring.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_psp.h"
> +#include "amdgpu_init_level.h"
>  
>  static bool smu_v13_0_10_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 87b398dd0769..49b9d81cf8ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -77,6 +77,7 @@
>  #include "mxgpu_ai.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
> +#include "amdgpu_init_level.h"
>  #include <uapi/linux/kfd_ioctl.h>
>  
>  #define mmMP0_MISC_CGTT_CTRL0                                                                   0x01b9
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 0c58d23013f4..2b138c85cf60 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -27,6 +27,7 @@
>  #include "amdgpu_drv.h"
>  #include "amdgpu_pm.h"
>  #include "amdgpu_dpm.h"
> +#include "amdgpu_init_level.h"
>  #include "atom.h"
>  #include <linux/pci.h>
>  #include <linux/hwmon.h>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 98e7109bbc95..0ca961177c7c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -37,6 +37,7 @@
>  #include "soc15_common.h"
>  #include "atom.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_init_level.h"
>  #include "smu_cmn.h"
>  
>  #include "asic_reg/thm/thm_11_0_2_offset.h"

