Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29F7C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3693611B992;
	Thu, 30 Jun 2022 14:36:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9552D11B989
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8dQ0SIg5FVdPMuNpHpJuexEIgy6CK2mHfjZog+agXT0FsWqfDquDnDeyWSW20jH5a8LI0QjM2us81x45XUEBh7WE23h8KY7TU5MTBjwJkFRsVxK4zfz+1B8BPTVUEVZ2FSXqGkU04kh3PlqIGXLycwv72tMi/r+3Z0E9zoiM0tAuNp2ht7c9ERzv8ZiM34HEq0OwlEqaPDsj4faSf1ZUCvEERwifNGmnhkTwMHvEaNYByaUI3LhhmlJkwSOIboUpVpFuz97Gpjr487mozh23GVsFjVqGHp/jzvtQ1pP7OfnVV02VpgKqSNBhCwhndJfHi0fddYy5IAxwnXs/SAY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GviSplbiXMdgsB+Q0PSlqGO723Z87acTgjJL2hpulYI=;
 b=eX677GJ76WoetX+aYBn6XHuQF+wamCr0MqpGzxnklGMtJiUNZhrbVZLF9EbRJb9pOdfAlEJdD18Yejuxlw4xRF1GeP/PMmgjNtHsbdgSwdNlFCk7o5M/GwrhMKuF0o7VMr9Ujj8zE1U12G574eCj4EH3/6v9ao7oNaicLGk7v3tOPBaKkg3UnHYF1yGIEsE8CqLoBFFSHf4XmMkeypyky4tfynyn+4FCCpSsFb9Uvh4GqzfMtG9ewyUvhnwPa5m70d29nbocXwbOSBqzKZX6VbzwwjMdUpwaAqh4/SxzFqbaZQYyON6dCWocitIud4OHNd7YcoZWxFhQo3wUkeQnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GviSplbiXMdgsB+Q0PSlqGO723Z87acTgjJL2hpulYI=;
 b=jmEUdbO8Gy+4U8dWDu9AhpG3SpsxjzZXFtLFbWD6rCry56fOjB35vMTE8hKDREr8S9f+ca40khWtRtrINm2T37cjJdG/Ur+awkQWlfpCAwv1dESaiy1P7mWkX2FValuTUAGPPjlo2Po5y3ZUFBhrvWMvzAKrSXc3UhXkTQd6a7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 14:36:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 14:36:10 +0000
Message-ID: <26efbe54-e5f9-cf94-ab6b-e4fe5a261eef@amd.com>
Date: Thu, 30 Jun 2022 10:36:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 5/11] drm/amdkfd: Add user queue eviction restore SMI
 event
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628145020.26925-1-Philip.Yang@amd.com>
 <20220628145020.26925-6-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220628145020.26925-6-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a8fe746-6409-4eef-f448-08da5aa5dfef
X-MS-TrafficTypeDiagnostic: DM4PR12MB5937:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YOJlXk0h22TmBsOiGJEtBAwxbg0MKPezchF7fjl0iJIir79h6nMGjkbMGokqiklp67vec/FEZOrnf6D7VzPoJ2tER5kTvhCOi7x0eNr2iabg2l+X7ixokSlUcG1wBGdfPCciSnCX1NaGiddgXOJnImNoxvmA+Gbmv80WL3EGpmC/J08XGTxURuHucikcGV5QutHV2NSzsUwNZstxU5xDW/awbM1JTDifb2GzbtlXTI6UmGvgVvKwGTnmtn3TPX2nE+sb5fmsoI8RiNzoOgMB14uAUUHZQlHudRT4uZyBU0J34DmNfnxrhSvJxabBMT1WWOMt1fI4QtrpYXKtSsNlzjYxGEYpAPWjepT41zj7C8sONBbNlbuMqZ2C6E2z1SD1f02a+WT2LNpWrwsGUnWMCikAfuzrUXWGFdOVSSE+nMYknTfELvN4h5WxGDY+id4/4k5TiWx3o0EEThzfcJoyMswltinFk8cVri7BFlpRLNzL8TEApv5dYaIlzz3xzYeeHjG7UmDQxeJRwVgP5TdBQk7qlwubzhQVzhVnIkUu1vedZXoLMV1NJkbo9AQHD7P0CjcMLc2RaRdJf039JbSuuaGI91GfQZzPD4OFAdsHDFxN5NV5q8/TviXWnsfJFgs53iZ1AlGGTh2j7MUhH3PZ7d6Gb1a0hdNpcM95StHxuGQYgVvrYFRXu8wqnukdy2FhkZmKl43hoHEQSriRJW6Ed00NCkp7pN/Mye0WBAPKxQKyM0NKcq39emHAXFpTGq6gKkQQ0TxD/wpLZL0jppzYM7xpYVoZjpwDfEe9p9W3JprcX7ayGMqDjnevQUtTQCDtdrHTO3I1YLhctdBmuv89XXIeSHFwg0s2UeYH/uy1Ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(6486002)(44832011)(66556008)(66946007)(31696002)(8676002)(26005)(66476007)(86362001)(478600001)(6506007)(6512007)(41300700001)(83380400001)(8936002)(36756003)(2906002)(38100700002)(2616005)(316002)(31686004)(5660300002)(186003)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZ1WHpCQ0FySjRHUmtvOXVmWjBFbysrcUdrSDVFU1NsNEU1MGhyOGp3VmtJ?=
 =?utf-8?B?OEVDSGJJWWFySVBJZXVhYUVHNiswaGRSTmhHT1FwQmtKYWxUaU55Q0VGbzBq?=
 =?utf-8?B?UVB4YmtZa3QzVjdoaXRuc0s5RUo2WG1ERm43dTQyWDBIR01zY1psS0JzTUsx?=
 =?utf-8?B?K3M2NHpGRCswK1VwTVFPMnNkdHRMSGgxYktlYUVnSExMbWx0MmROMDdlSFdy?=
 =?utf-8?B?eFRINWRtSDF2RUFpWm1sYkxxZnp5ejdLcWZ3NjNQdVEvMHVZZVhMaVVGQkNl?=
 =?utf-8?B?ekZCR1ZrM21sNjFvdEVVcGx2VWFKZDBmb2FpSm5tK1FJTmlwMk1UU0FXT2s4?=
 =?utf-8?B?R0RFYkpGTTNaVDhPd3hmV25KRjF5eFNDYXpBZGJRaEdPSFVHVUV6bHNWbVFx?=
 =?utf-8?B?UjhTYkE0SS9hZGMzK1N0ZXhEd3J6Y0o0Uk9WOWg1ZEkybTMzZjF3VWFrUXN0?=
 =?utf-8?B?SDRFRlBtYUhnUUUySWZZd2g3bThJZTRNNXJBV1F1ekdidXVLeEw3MUZ0SEdh?=
 =?utf-8?B?RkRXOTM4UjBlWDU4dUNWRTZsanprL2NoV1l4a3RCQ0dWeWswYzBJWVIyY25V?=
 =?utf-8?B?V1lNMkMyTFRlRWFvajJ5VGtmWmxaOEt0U2tXMU1CMzJzSFdwdXA3UHlqNnVU?=
 =?utf-8?B?aDFadTE5a0R2RTV0VHBNVEY2ZjVpN29XNzZvTTdSYUhGeWdPc3hPR2gwZ1M5?=
 =?utf-8?B?WnlzU21uWEF3VjNqYWV3WVdlQitFQ0xtRjA4UDJXaHUzR1V5NnAvbmRnZ1pp?=
 =?utf-8?B?WW1LRmlKK0dGNTl4cmhXajBlUmQ2c0d5bTJWdjlLSU1LZGlLMHQ3bURTZytS?=
 =?utf-8?B?bjF3cEg4RmkrSFpGTWdlMkhPNXVrdEJPdWNvSFV4UUtkZG51azYzM0dyZUVr?=
 =?utf-8?B?ZTZPbEcveXFxUk9kN01YZ3BaT0doeUJEOTVuTFJmU1dtNXUydkI5SFBYZ2tU?=
 =?utf-8?B?emNxQVV5TVc1Z0U0cldGL1dlUmtTb0F3L016a2lvSHhqN1Y1MWFXSzB2d3p2?=
 =?utf-8?B?aUFIY3cxTmxndkpXMlFSSFkrYkowY05rR3RWWWxnZ2dvMnE1cGRkdW5nUnhn?=
 =?utf-8?B?OHpUNlBUbHhMMlpxNUVrY3NsRXVNTFNyS2VTVEs0Rm9BVzFNNGM0VWl1dExx?=
 =?utf-8?B?SjNoMEJZOWJxb2t6d1RPMHRkVjdxM01YSWQ1WStWdGwyRWNVYnFqWWplSC8w?=
 =?utf-8?B?ZTZNcHArTmtoSXFPd0lLYkY3NHpNeUR6aDR5QzV0Q1grd2FEZCtVbkZlUEd4?=
 =?utf-8?B?bHRCZkd0eThGNXBhNWVkcWZERXZRM0htK29IS0VmVm5QMEx0aFdSUk9hVkdi?=
 =?utf-8?B?aStIdVR6UnFqWjZpVmx2dnQzNk81UFIrRjk4MURsNDh0R3dnUU9VeGtLai9r?=
 =?utf-8?B?VUtuTnR2ZTA0QW9sVVF4aGlzV2lsNVJIcVZPOHpQOTg4cGs3bmJqRGpsaEpB?=
 =?utf-8?B?UzQ1S2p3ZzBMT1FZSjRDT0F3bCtHVWErN0RFVzZBUE5uOWlRL2lUU1BjYUF2?=
 =?utf-8?B?MmpHSDZQZVA1RWNPTW95VzcraXBLQ3BaN0FsU2YyVmcvb0ljd284RHZhMU96?=
 =?utf-8?B?YWRTYzRnTEJBREJqYll4OGVQbmEvWkg2Z3Z0a3gzNFhMcGcyYlVLY0lBU2Mw?=
 =?utf-8?B?bXQ5RngwbXJ3WjYxRE8wVUR3TzIzUVpMWDRlOGlKQ3ppQlFUQXNWWnVxMEFE?=
 =?utf-8?B?Z3VFMWdTRGJ1K3hyQkRxWTRIbkt6R1lpWXUweUJuQXgwWDNLNXNIeHJadjUx?=
 =?utf-8?B?a08vSzN4OS9KNTBxS3FGZG1pb0NTWVNicjJBLzk2STk5cy9Pd1E1ZXVoMWtI?=
 =?utf-8?B?bllPU2IwbkxqVnUzbW1lYTlhSVVnZjgwS1BPS1JuRW5NdGZSKzgvb0owNFBt?=
 =?utf-8?B?cC93eXBsZ2swTE5NNTRldFhoNkdBd3NBdkZ5VWpnRW81YkVzdGIrcUp1MStD?=
 =?utf-8?B?STdCVjlGcjlOeWw3S3dHcnFjMnl6SFFFVzgyTEk5cUtJRFRXb0VhbHpTczZu?=
 =?utf-8?B?UjYzZ1JtQ3dZcjNiL2xvQzIwei9mZUMvVHlCWThobjBuUFFaL3lNQk5EOWxY?=
 =?utf-8?B?MmhBaHlxb2dKMzl0TWpBLzZmNmNudXpRV3dIUlVwZDRnVkJnRERNdU9DemhY?=
 =?utf-8?Q?EhHayJvodeupjTNa+PIfBLysd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8fe746-6409-4eef-f448-08da5aa5dfef
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 14:36:10.0900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: se3IBuuyoAVfwPMW3w2Adqfoo8/1B/BOo+8vGR3xVqtFG0SzMYPQ7NVwp0aZ5Tia5WJPHSmOehjd0uOIq+THAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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

Am 2022-06-28 um 10:50 schrieb Philip Yang:
> Output user queue eviction and restore event. User queue eviction may be
> triggered by svm or userptr MMU notifier, TTM eviction, device suspend
> and CRIU checkpoint and restore.
>
> User queue restore may be rescheduled if eviction happens again while
> restore.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 12 ++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  4 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 15 ++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 35 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  4 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++--
>   9 files changed, 69 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index b25b41f50213..73bf8b5f2aa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -336,7 +336,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   }
>   #endif
>   /* KGD2KFD callbacks */
> -int kgd2kfd_quiesce_mm(struct mm_struct *mm);
> +int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
>   int kgd2kfd_resume_mm(struct mm_struct *mm);
>   int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
>   						struct dma_fence *fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5ba9070d8722..6a7e045ddcc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -32,6 +32,7 @@
>   #include "amdgpu_dma_buf.h"
>   #include <uapi/linux/kfd_ioctl.h>
>   #include "amdgpu_xgmi.h"
> +#include "kfd_smi_events.h"
>   
>   /* Userptr restore delay, just long enough to allow consecutive VM
>    * changes to accumulate
> @@ -2381,7 +2382,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
>   	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
>   	if (evicted_bos == 1) {
>   		/* First eviction, stop the queues */
> -		r = kgd2kfd_quiesce_mm(mm);
> +		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>   		if (r)
>   			pr_err("Failed to quiesce KFD\n");
>   		schedule_delayed_work(&process_info->restore_userptr_work,
> @@ -2655,13 +2656,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>   
>   unlock_out:
>   	mutex_unlock(&process_info->lock);
> -	mmput(mm);
> -	put_task_struct(usertask);
>   
>   	/* If validation failed, reschedule another attempt */
> -	if (evicted_bos)
> +	if (evicted_bos) {
>   		schedule_delayed_work(&process_info->restore_userptr_work,
>   			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
> +
> +		kfd_smi_event_queue_restore_rescheduled(mm);
> +	}
> +	mmput(mm);
> +	put_task_struct(usertask);
>   }
>   
>   /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the given
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index a0246b4bae6b..6abfe10229a2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2428,7 +2428,7 @@ static int criu_restore(struct file *filep,
>   	 * Set the process to evicted state to avoid running any new queues before all the memory
>   	 * mappings are ready.
>   	 */
> -	ret = kfd_process_evict_queues(p);
> +	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_RESTORE);
>   	if (ret)
>   		goto exit_unlock;
>   
> @@ -2547,7 +2547,7 @@ static int criu_process_info(struct file *filep,
>   		goto err_unlock;
>   	}
>   
> -	ret = kfd_process_evict_queues(p);
> +	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_CHECKPOINT);
>   	if (ret)
>   		goto err_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index c8fee0dbfdcb..6ec0e9f0927d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -837,7 +837,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>   	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
>   }
>   
> -int kgd2kfd_quiesce_mm(struct mm_struct *mm)
> +int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger)
>   {
>   	struct kfd_process *p;
>   	int r;
> @@ -851,7 +851,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
>   		return -ESRCH;
>   
>   	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
> -	r = kfd_process_evict_queues(p);
> +	r = kfd_process_evict_queues(p, trigger);
>   
>   	kfd_unref_process(p);
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 59ba50ce54d3..b9e7e9c52853 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -946,7 +946,7 @@ static inline struct kfd_process_device *kfd_process_device_from_gpuidx(
>   }
>   
>   void kfd_unref_process(struct kfd_process *p);
> -int kfd_process_evict_queues(struct kfd_process *p);
> +int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
>   int kfd_process_restore_queues(struct kfd_process *p);
>   void kfd_suspend_all_processes(void);
>   int kfd_resume_all_processes(void);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index a13e60d48b73..fc38a4d81420 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -43,6 +43,7 @@ struct mm_struct;
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_iommu.h"
>   #include "kfd_svm.h"
> +#include "kfd_smi_events.h"
>   
>   /*
>    * List of struct kfd_process (field kfd_process).
> @@ -1736,7 +1737,7 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
>    * Eviction is reference-counted per process-device. This means multiple
>    * evictions from different sources can be nested safely.
>    */
> -int kfd_process_evict_queues(struct kfd_process *p)
> +int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
>   {
>   	int r = 0;
>   	int i;
> @@ -1745,6 +1746,9 @@ int kfd_process_evict_queues(struct kfd_process *p)
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> +		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
> +					     trigger);
> +
>   		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
>   							    &pdd->qpd);
>   		/* evict return -EIO if HWS is hang or asic is resetting, in this case
> @@ -1769,6 +1773,9 @@ int kfd_process_evict_queues(struct kfd_process *p)
>   
>   		if (n_evicted == 0)
>   			break;
> +
> +		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
> +
>   		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
>   							      &pdd->qpd))
>   			pr_err("Failed to restore queues\n");
> @@ -1788,6 +1795,8 @@ int kfd_process_restore_queues(struct kfd_process *p)
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> +		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
> +
>   		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
>   							      &pdd->qpd);
>   		if (r) {
> @@ -1849,7 +1858,7 @@ static void evict_process_worker(struct work_struct *work)
>   	flush_delayed_work(&p->restore_work);
>   
>   	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
> -	ret = kfd_process_evict_queues(p);
> +	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>   	if (!ret) {
>   		dma_fence_signal(p->ef);
>   		dma_fence_put(p->ef);
> @@ -1916,7 +1925,7 @@ void kfd_suspend_all_processes(void)
>   		cancel_delayed_work_sync(&p->eviction_work);
>   		cancel_delayed_work_sync(&p->restore_work);
>   
> -		if (kfd_process_evict_queues(p))
> +		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
>   			pr_err("Failed to suspend process 0x%x\n", p->pasid);
>   		dma_fence_signal(p->ef);
>   		dma_fence_put(p->ef);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index ec4d278c2a47..3917c38204d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -283,6 +283,41 @@ void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
>   			  from, to, trigger);
>   }
>   
> +void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
> +				  uint32_t trigger)
> +{
> +	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_QUEUE_EVICTION,
> +			  "%lld -%d %x %d\n", ktime_get_boottime_ns(), pid,
> +			  dev->id, trigger);
> +}
> +
> +void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid)
> +{
> +	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_QUEUE_RESTORE,
> +			  "%lld -%d %x\n", ktime_get_boottime_ns(), pid,
> +			  dev->id);
> +}
> +
> +void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
> +{
> +	struct kfd_process *p;
> +	int i;
> +
> +	p = kfd_lookup_process_by_mm(mm);
> +	if (!p)
> +		return;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
> +				  KFD_SMI_EVENT_QUEUE_RESTORE,
> +				  "%lld -%d %x %c\n", ktime_get_boottime_ns(),
> +				  p->lead_thread->pid, pdd->dev->id, 'R');
> +	}
> +	kfd_unref_process(p);
> +}
> +
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>   {
>   	struct kfd_smi_client *client;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index ec5d74a2fef4..b23292637239 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -42,4 +42,8 @@ void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
>   void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
>   			     unsigned long start, unsigned long end,
>   			     uint32_t from, uint32_t to, uint32_t trigger);
> +void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
> +				  uint32_t trigger);
> +void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid);
> +void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5cead2a0e819..ddc1e4651919 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1730,14 +1730,16 @@ static void svm_range_restore_work(struct work_struct *work)
>   	mutex_unlock(&svms->lock);
>   	mmap_write_unlock(mm);
>   	mutex_unlock(&process_info->lock);
> -	mmput(mm);
>   
>   	/* If validation failed, reschedule another attempt */
>   	if (evicted_ranges) {
>   		pr_debug("reschedule to restore svm range\n");
>   		schedule_delayed_work(&svms->restore_work,
>   			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
> +
> +		kfd_smi_event_queue_restore_rescheduled(mm);
>   	}
> +	mmput(mm);
>   }
>   
>   /**
> @@ -1793,7 +1795,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   			 prange->svms, prange->start, prange->last);
>   
>   		/* First eviction, stop the queues */
> -		r = kgd2kfd_quiesce_mm(mm);
> +		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
>   		if (r)
>   			pr_debug("failed to quiesce KFD\n");
>   
