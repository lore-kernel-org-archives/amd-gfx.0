Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12704C44539
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 12:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9615C10E248;
	Wed, 22 Jul 2026 12:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yV6pahd3";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0EC10E248
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 12:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDbZ3Wj+6qK8V+z+R9VvW6qSRkoCyQSLW48ODfn4uWGe7VAJopcodnawB6TdK0u09O+O5G7d8gLM3l96JrGGbGnqb3rp5ceCMaheJA2IEYpLhikbrLE7iK8DY3W2Qo06uMRLn+CCsRMz8Sw7y+2TfSM4SInK4SeE0CzB6oDORuth8BsJ0P5jJO/dE3GOrQNseFjqm5k9IzN6GPi/+BD8C3Jj0p2d+Yyj4zHqMRAHChPyf1Q7q7BJuVWnbxUtV92NhCJw7DL2iW2gDIjZT52cO+giAgJWmFagiHuWSr5RzObvu7bI+E5crh+ZYwkH+RnTDrJ59HVCJcRyMsu9BW5K+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKYRpUpsKJC0fvOVTQ/A/wlFYxhRw68tXUZElq7BfyY=;
 b=Rx+JoRf5OS0YavGyf7eRbBUHBipexRYBTQnHQvMxvLs+zl89WvCKsGTixfALCaJjRwWvFcFVJ5uRUOXq3cr7a09CHLeSvTIixVLgw2RVN7mokn2sZriaRykXqPMCx6Y2F0+8pB+6O2N5smJRGyXrzF2+u2VB3HKNvyzqRgsjr2Sx3nXMd4LxwgKC7rWyjwQ2uG4Mp+hVxWez41DZfhyJuR4PYgk35a5eOeVoRi8Ewje1NCsnSmjlDcp0gdpDw1dUCWKg0fOM+BlvihQrncywN3GsA+Q3Ht2COhQgVg1G8eBlxNtE2jk12kCgxISMxIzeaLs7qoePyfnASodQz2vefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKYRpUpsKJC0fvOVTQ/A/wlFYxhRw68tXUZElq7BfyY=;
 b=yV6pahd3D+OzQfT+LPw1ie1fHw+yqq+I+hjjeSZKsJHFS1ENV5c6gSRcNtQdkaa73qSYCNE1BAZ2C1Me+fSAnscwwdDmeqgmtTyt13sGul3lHc8sjLSbpLQkW8vw2LS3FArGxYk9ITRwsH9C6raO8msiuo4CgXndvSy5LNbX8bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:11:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 12:11:10 +0000
Message-ID: <0de168fb-a9b8-43ce-a85b-a31033478f15@amd.com>
Date: Wed, 22 Jul 2026 17:41:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: restore perf state after runtime resume
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260722103619.2737329-1-candice.li@amd.com>
 <EAYPR12MB9991584ED579327E914EB32293FCC12@EAYPR12MB999158.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <EAYPR12MB9991584ED579327E914EB32293FCC12@EAYPR12MB999158.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0247.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b252fe4-87fa-4493-af2d-08dee7ea50ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IXZYKyDONLd+oh1CPO0E+Ahc0fApAEWNxkWZzFiA+AWubmRlYXXtWk4Utl+w8+6+95ckZ3kCaepdGzNhIKcxZEvmm9RkgA/r3M/ZUPucldivvrpTL3UBvAMKuH8lcnnoNqootRyzm3BPdVtZi0utO8IUS5bw/qjqf2J2De5CPkyI0/V5dk1wMttsE4KXQwcaOCbiVxQd+z0vj7vC4q11RHwcLjUi/K3IDw82wiJAzh7CvAqKGzNxUSh+wDiaol1F6NXuca5sVwbBVQSOXqrM8LXdSIS99K2jQd6/+4KXoTA84zI/M4Z8FiiZTkz9m1JPVr1CWJW6imVhXVTMKddokQ6im6aWYxztt3UzHwk8BJEm8fx1Ba5xv82JKM35GDCYNOjv7lg3uND5pwg7Ij+0eKleaXpcyMhisWn7k60/7Z0fp4CCfqDDX4KbboQaUcRY36ySSdfLpmsRM/NIDVPvZT2E4UKRHwfQ+mOF9LyCUjPVGQNQ0r4Kk3qvgFsR8C4q4u3A+IUUoScKRmWgTRg4kUToDLqF7SaQ8cSEwC5PxV+O7/+/CRx5GKv62wTBhRMpk+sH3o+NO5wZSkmklY8vPIY3gMPR0o268EMY1u1ttyAJ4n03VbLD228owu5A0GWGAYs7zVvDYadwtE+poDsu5cxElGFOECWoEFP7/vq4lQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0srQ0pQbERzNWRESXJha2VDUkt6Y1JuWE9NZlVXVndyL1FmRHRhMmhZeXlM?=
 =?utf-8?B?MHV1TkJUUTlMTHhnUW9ydHI4YzVET2hSamExR0VBSXJmNUZiOWpFRXQrd3ha?=
 =?utf-8?B?akNhSmpVNlY2SCtSd2tOSUxoK0JYOFhVUXRoeUJlMmNYY2d1Z3B6NWY5bjk2?=
 =?utf-8?B?TVZIMWlsblFvVU1tMFhmeWRERkxPNm4va21nNFhtRUxkcHJCcG9rYnhOaUFC?=
 =?utf-8?B?akwwMTBkeEZmV0F1MVh4UkdUV1RqNXRobXNubC82VHBWSTd2MWlBVXFwTEo4?=
 =?utf-8?B?TXllWDFVUmdPa1VZMyt5Ynl4bEJGOXAvL1QzMDdhaVFGVEI5NWp5MHBLV2hZ?=
 =?utf-8?B?WTh1VXc2YU9kUzlCV1RhQ2lFaUJ5NVByRWFDSmI2NmJKanR2di9xb2JHN214?=
 =?utf-8?B?R0hjVklZaVFZanpiUTFXTDNJK0djUkhpd3ZML0dnQlh6MERiS2VJL0R3K25v?=
 =?utf-8?B?dWh0SkRGdjZwaVMxUW11c3VhbkVuVFJmOUZncXMxTWRxanlIZnZ0SDdMdUtC?=
 =?utf-8?B?VWpnRDkrN0VhSVU2eVFuYzQydEY5K20rcmd6bFhvN01BUUcvYWNUL1Joa09v?=
 =?utf-8?B?cDZUNThMZTBsTDZ2WlNKVjZwc1NNcldHalZRZndXWXBmbHhJRHBYREpRcUEz?=
 =?utf-8?B?YkFNaVFnblVWSExneDR6YkpMQ0QrWURsMmNPcWJkLzN3ZFgxMXlWbmx6SWhx?=
 =?utf-8?B?Y2h2SXVHWVpSZU0wWGNudCtXWjc5T2RUcnhSRGRuYXhHWjJVTElVSkJFNWtH?=
 =?utf-8?B?ckxpN1RNV0I3WURxL0ZYRVQzQUgrTmZycU1BeGszdzh5QnNqaEJ4Y2hDS3B5?=
 =?utf-8?B?NmFaYUlvOEY2MFk1YWY5V25nWHc3OW1UZGgxMXZhTGpuUnFrTi94eVVJTEFD?=
 =?utf-8?B?b3p0Uk43dDUvNm1QMk1XUmlZdDhXWEh0MWJ0Y3RLNEJtY09LQ1pyZFBkMFNM?=
 =?utf-8?B?SWVJeFY4ek1SYjJ3VExIdVdFLzY4RmpxZ256RFVkRnZ6alIweURxMEFJYzNX?=
 =?utf-8?B?Nlo0SUJQL3JUNU1QU0J3dDJjL0t0bUVIRWMxZlFPUXJoWWkvRWNkbEpGWm11?=
 =?utf-8?B?OTh2TjBwU2FPTWxmb281MjRWT291dkFEbjdXaVR5RndpcldiMXI4RUZiU1FN?=
 =?utf-8?B?YS82K3JZRDRnM2hTVE80MkI5ZGNKNDdpQ25DYm9SekpoYlZlemEvSkNuMjZP?=
 =?utf-8?B?RjlIUkRKa3ZHSXRYa1BLMncwRWM1S2lwakRnemYwQ3M5RUJZK0xKcUtNMTNp?=
 =?utf-8?B?NU1EZkNjNjZrY21vc25Wd1NPQVEyR0U4bTUzM0dCZGhWckRMUG5rbFZ2VWFh?=
 =?utf-8?B?Z0Zva1dUZ1hMbzduYS9CMzVGVjFWaFBUOWd6ZlErSmJMbGRGenM5ZUd5QWNF?=
 =?utf-8?B?RDJHNVJhemxFT3FUK3hnZmVzZUl6QlhVVGhzSm5tYStqbUtLV3lBVFhvNUQ4?=
 =?utf-8?B?dDIzMU5xSEh5UEtCK1c2Z3pWSitJbDJ0cTdvQkcyZ2dCMFNIcmVld1FkbG1V?=
 =?utf-8?B?Z1lyejc4eTN3OVFVWFgxZ0RwMlhteEJTMnBUYXhuNzB0OHYweFdBdXM3dGd6?=
 =?utf-8?B?aUVMK3R6SVdCN09HVlhxVk5JWi9TS0YyS2JHQ1hoSkZRMTUvbGpQQzNTWSs3?=
 =?utf-8?B?YzBMbUtOcEkzWkZ5TWNqRFpJYVNiREFXV3BwMk9zdkJYNUdXMlYyRGV2SXh3?=
 =?utf-8?B?eWtkSlRTNTZZd3BXQmVXNytQV000QWF4Y0FvZVJ1MXhRZDVBNEwyUVBQQ3NI?=
 =?utf-8?B?TThuUXBpR0tYRklPWWxKVCtyQ1hUU1BZM0U5NXNNYnEzOFBoM1owRi9vVkhu?=
 =?utf-8?B?RE40UnlmVVJFeGpicHEwT2lDVFpGUWNYZG5vYXNuVW1zYzgzRjRJQzYzSDJ1?=
 =?utf-8?B?aytBekIxR1F5SkRSM1p4N3UyUmh0VytjalI4cXRaNGZXbjRmdDFwR0ROUU9R?=
 =?utf-8?B?TzZ2c1c4dDJqUnRFa25xdTllanlzazJEaEdwOXdEdFVybWpMOFJnRUlGRWFF?=
 =?utf-8?B?a202UFNUMVRNZGE2V3FOamp2K3BPOEM2elF4dXNKYlZ1TUVTWTh4Z0J6d0lp?=
 =?utf-8?B?TXRiaG9OUEhQR2FobnVLbjFlRHVvTFJKTnNrR2w5d3FQTFo3ZXYzcTM4UWJH?=
 =?utf-8?B?MTl5U2RHTitUd2VpRzhWME9pY2paOEtCVjlkNDdYWWprUitJVElPV3B0T1Rx?=
 =?utf-8?B?TXNzbUpiR1ZxYVFEa1pGSWNLNnhEWlk1Yy9PTjRHR2MrbHlyTUlyU1VYRkZG?=
 =?utf-8?B?ZU9zeFduNlBReks5alIxZmFWUk5wSTlsUEhUSStDTzRUM1gzRDRzQ3ZnMmdQ?=
 =?utf-8?B?d3dnUXk4MGRDTHNLQSswbHJDRkdtQTBvZHZyZVh0K2JDU3E1Y213QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b252fe4-87fa-4493-af2d-08dee7ea50ea
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:11:10.2936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW1ta3+U0LZXDm4YoqqXMURKDALBNUhqz2LsAIJULxHWn1v26x9MsXLSsHf+seLb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
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



On 22-Jul-26 4:43 PM, Zhang, Hawking wrote:
> AMD General
> 
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> 
> Regards,
> Hawking
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice Li
> Sent: Wednesday, July 22, 2026 6:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: restore perf state after runtime resume
> 
> Runtime suspend runs GFX hw_fini and clears perfmon clock gating while KFD keeps running, so block perf counters read zero after resume even though profiling remains enabled in software.
> 
> Re-apply UMD stable pstate for profile DPM modes and re-enable KFD perfcount after a successful runtime resume.
> 
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 46 ++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 17 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  8 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  1 +
>   6 files changed, 75 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 121282dd30c161..38974beb98ef88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -38,6 +38,7 @@
>   #include "amdgpu_reset.h"
>   #if IS_ENABLED(CONFIG_HSA_AMD)
>   #include "kfd_priv.h"
> +#include "kfd_device_queue_manager.h"
>   #endif
> 
>   /* Total memory size in system memory and all GPU VRAM. Used to @@ -280,6 +281,51 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc)
>          return r;
>   }
> 
> +void amdgpu_amdkfd_restore_profiler_after_runpm(struct amdgpu_device
> +*adev) { #if IS_ENABLED(CONFIG_HSA_AMD)
> +       struct kfd_dev *kfd;
> +       struct kfd_process *p;
> +       struct kfd_process_device *pdd;
> +       struct device_queue_manager *dqm;
> +       int i;
> +
> +       if (!adev->kfd.dev || !adev->kfd.init_complete)
> +               return;
> +
> +       kfd = adev->kfd.dev;
> +
> +       mutex_lock(&kfd->profiler_lock);
> +       p = kfd->profiler_process;
> +       if (!p || !kfd->profiler_perfcount_enabled) {
> +               mutex_unlock(&kfd->profiler_lock);
> +               return;
> +       }
> +       mutex_unlock(&kfd->profiler_lock);
> +
> +       mutex_lock(&p->mutex);
> +
> +       mutex_lock(&kfd->profiler_lock);
> +       if (kfd->profiler_process != p || !kfd->profiler_perfcount_enabled) {
> +               mutex_unlock(&kfd->profiler_lock);
> +               mutex_unlock(&p->mutex);
> +               return;
> +       }
> +       mutex_unlock(&kfd->profiler_lock);
> +
> +       for (i = 0; i < p->n_pdds; i++) {
> +               pdd = p->pdds[i];
> +               if (!pdd || !pdd->dev || pdd->dev->kfd != kfd)
> +                       continue;
> +
> +               dqm = pdd->dev->dqm;
> +               if (dqm && dqm->ops.set_perfcount)
> +                       dqm->ops.set_perfcount(dqm, 1);
> +       }
> +       mutex_unlock(&p->mutex);
> +#endif
> +}
> +
>   void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev)  {
>          if (adev->kfd.dev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 338412a750edf0..1be9d5ef97d6d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -164,6 +164,7 @@ void amdgpu_amdkfd_teardown_processes(struct amdgpu_device *adev);
> 
>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc);  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc);
> +void amdgpu_amdkfd_restore_profiler_after_runpm(struct amdgpu_device
> +*adev);
>   void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev);  int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev);  void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5362705143bc75..f7a1064c340692 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2920,6 +2920,21 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>          return 0;
>   }
> 
> +static void amdgpu_restore_perf_state_after_runpm(struct amdgpu_device
> +*adev) {
> +       enum amd_dpm_forced_level level;
> +       uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
> +               AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
> +               AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
> +               AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
> +
> +       level = amdgpu_dpm_get_performance_level(adev);
> +       if (level & profile_mode_mask)
> +               amdgpu_asic_update_umd_stable_pstate(adev, true);

This is supposed to be called before entering the force dpm level mode. 
It's better to move this logic inside swsmu late_init before reapplying 
the level.

Thanks,
Lijo

> +
> +       amdgpu_amdkfd_restore_profiler_after_runpm(adev);
> +}
> +
>   static int amdgpu_pmops_runtime_resume(struct device *dev)  {
>          struct pci_dev *pdev = to_pci_dev(dev); @@ -2964,6 +2979,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
> 
>          if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
>                  drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
> +
> +       amdgpu_restore_perf_state_after_runpm(adev);
>          adev->in_runpm = false;
>          return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2c1a936459ac87..2a140c40b53f9c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3347,6 +3347,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
>          if (op == 1) {
>                  if (!kfd->profiler_process) {
>                          kfd->profiler_process = p;
> +                       kfd->profiler_perfcount_enabled = false;
>                          status = 0;
>                          mutex_unlock(&kfd->profiler_lock);
>                          if (ptl->hw_supported) {
> @@ -3364,6 +3365,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
>                  }
>          } else if (op == 0 && kfd->profiler_process == p) {
>                  kfd->profiler_process = NULL;
> +               kfd->profiler_perfcount_enabled = false;
>                  status = 0;
>                  mutex_unlock(&kfd->profiler_lock);
> 
> @@ -3404,6 +3406,12 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
>          mutex_unlock(&p->mutex);
> 
>          dqm->ops.set_perfcount(dqm, args->perfcount_enable);
> +
> +       mutex_lock(&pdd->dev->kfd->profiler_lock);
> +       if (pdd->dev->kfd->profiler_process == p)
> +               pdd->dev->kfd->profiler_perfcount_enabled = !!args->perfcount_enable;
> +       mutex_unlock(&pdd->dev->kfd->profiler_lock);
> +
>          return status;
>   }
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 88191a4c165796..81055ada4f80b8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -389,6 +389,8 @@ struct kfd_dev {
>          struct mutex profiler_lock;
>          /* Process currently holding the lock */
>          struct kfd_process *profiler_process;
> +       /* Whether perfcount is enabled for profiler_process */
> +       bool profiler_perfcount_enabled;
>   };
> 
>   enum kfd_mempool {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index eb508fe3ded780..8b7020fc0577a2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1180,6 +1180,7 @@ static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_proce
>          if (pdd->dev->kfd->profiler_process == p) {
>                  pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
>                  pdd->dev->kfd->profiler_process = NULL;
> +               pdd->dev->kfd->profiler_perfcount_enabled = false;
>          }
>          mutex_unlock(&pdd->dev->kfd->profiler_lock);
>   }
> --
> 2.25.1
> 

