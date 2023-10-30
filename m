Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48F0C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 08:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8C610E236;
	Mon, 30 Oct 2023 08:23:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92AE910E236
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 08:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJCsYwzVk/Fuq7NWpmYwgBmkFUeXI8jgVqM2V/hMFwz86uH0ZKW/PBZ/FBCvz/PGYAWp37dbW1O/aJ11iL24qrPVuJzv5gKoEZZb/aYKunCisG+8wm1EwKMFaSdjWWvNS1lywfF9zlJabi+/c9J1h6FrqMhkhW0skaRvY7fHs8OemvdHCWDsYJb9/363K7MngWddQTmXU+nXIpOxFuG19Cpc0H49mN9AMHIEspB7N+HnSoKCY/iIzL3dheMG/4OIQrlMOfYKlFUypCLS4zp/0qg/++zGEIrIyDY+NQFx9AXrpKgQNmSpCcjO5u3y210A8Amv5pIfCJ9at+CfoXe11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2rlyXEKGtfasJG9BVlwtVwnw78I228n8bBx/Mfb7Tk=;
 b=XB4s1rAzvbkfEdbAHB/JBdoEwoIXb7bRn4IybcIL6rGTU3oUf1XOBzrEgToUvszv4Ta1zXs9by81Pz2yBYOrE7uM2nqLBMN7lzLTjdNPs9skj+reZGJ+GU83lRMri5CWXeNynYN9/NKtK0/x9tCwR5A/0sfGxIXdM45plKUH/RwXhwjmYlpv0NR1lP+szGq0S1/1976kZOg/JIKmiQSOaW+9IAuqFATN2X43hffFr0nld9rv13FpGY2Wr2PslUuB4556Z8fBVd7ZSUBKAhG7bGCpTbC9+YhKcml/EE0QwcG4/FcXf0czdp+KVoHFmhwSFd80qNcXKdQzcwYBRm31bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2rlyXEKGtfasJG9BVlwtVwnw78I228n8bBx/Mfb7Tk=;
 b=ABeXYB3Hh2qSkGXxZZYV7JM/dz/OqAysxIM2myl5WCehpOQ/2Erc+ZwrsTghX2V3FV3g1lRupBRZToS35qfYaQDa1bADkqGKI5fy5lod4ZP/YcJcbxYF57e73HEQEY5bJQbasUuImbgiRAaTNSH5gP87UFS8mMs2z/Q+GLIBjZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 08:23:16 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::4ea:63c4:867:830e]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::4ea:63c4:867:830e%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 08:23:15 +0000
Message-ID: <8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com>
Date: Mon, 30 Oct 2023 09:23:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdkfd: Run restore_workers on freezable WQs
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231027223911.2640763-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231027223911.2640763-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To DM6PR12MB3596.namprd12.prod.outlook.com
 (2603:10b6:5:3e::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c4d768-f43f-43ce-6f50-08dbd9217611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCJVyQBehO1CX5ivXaS+7awUwOov63G88LouIOrxqZ1jMl5Ux444+97bOkiFgfMj/QHQ/iEwEU8Wg616Tea/REm7EkRa3NbyYlBgrokD4cwsV9kHkCiwtNOWZpiBsLpe7hdIlbOlNP4ZsR5ifhowNTweKNK13bYAQobVFyRQtZ2/4+fS+UjsxADihxc10ITzPqoZloXw55bK2kgG6rP8C/pAo+qRDnB7WRpOD6A8sZX5YVghy1NVv+eQleoZS3kccI4VMQeWu4/m76PwxoTD9ms8SwOtoX+I1kAyk3BFjueOQbyj/Kg9n9PZaKM8S6z/brcYBT9ifd31ExoM6vk3EZrwkZSGc2sJY1ywEXRFaU19suQOZzSfWYcnRAr5mOLM3J2rAI7nHb2UBqIicPSTrA0XvLBoU0U/aga5X22sXygJHLCHHym+N74zbQVPBqHOLKvmY1U2AVUY75WidHv7RRKoKnlSTmyLlELSxZBUfkn9ns2M1uAvlpOA/ODRoOT+fnZlC8qYjkmE9dHVMHi1PlJ7zT1tDYWG+ViZRUhwYx7V0lk59SrHrnYV97WloAYfZmL/dcmFpoSWmw0esP37NEHyGEwwMkJmcjtVVG0BU+9LEeYLjhr2Uo2p3S01XpF4a32iN65EEacxN9CgRiPHew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(8936002)(8676002)(4326008)(83380400001)(5660300002)(41300700001)(316002)(66476007)(66556008)(66946007)(45080400002)(478600001)(6666004)(6486002)(2906002)(31686004)(6506007)(2616005)(26005)(6512007)(31696002)(36756003)(86362001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGpFd24vQTNGcFh6bFl2R1FCMmFSNG45NDRmdHE3eVozYTNKbkJpUFNoM3Rz?=
 =?utf-8?B?cTJhME4yLzFIbURES3loWEhZTXIrdEtSeWpOdjFtYy9XQk9hMkJyZzRnZldo?=
 =?utf-8?B?UDJ0WGE4NnAxR05mL2dSUVFScGh3dEllM2RUUVpjY3ZuVUFvcENkUVVCVi85?=
 =?utf-8?B?V3Nyb3RLdVluREdxbkQ4RjhvUS9oV0xyTzJLSm5yWVZLb0FVekU5blBGZ3Va?=
 =?utf-8?B?UzhMa1R5ZDFvZmpLcENxU0dHTXNXLyswUUtBSnByUDVqR0UxZzBpVVoydUFl?=
 =?utf-8?B?VWk2TDBSVG01dEhpUFUyQ2ZKRy9UM2UxTGttMEIwZk5FTHJiRXN5a3dQV0ti?=
 =?utf-8?B?M0dzTnlWQnpGTnBuTE5VSW5Pd3BxUUxEaDh6QXVjWjlNV3lnRkxlMkJWYy9I?=
 =?utf-8?B?SmU2Z0p4M1psYUJ6aEpKTVpYSG9ja3BYdzVHdW4wc0NZZStpVStnZFZIbi84?=
 =?utf-8?B?VndKQm53NmMvQi9NTzBTaDhkTytRQklqM1M0T1FOa2lXSm5oYWlta0tUajdN?=
 =?utf-8?B?NHEwU2M0RXF0Tmc3d0FxWm9TcDVqN0xwV1p2WE9hdkNvUmFKZkJ4MUVPTlJC?=
 =?utf-8?B?RWoxOWh0ZWVhNjVYb1J6WjZkdGJMZ2ZJYVVGdzJackxheTBjQW9sMFdFTU55?=
 =?utf-8?B?eXNpaWRZUjVDakFwSzEzVVZKaGVpOU1jMW8vOXhoeFpqd045NnIyeDRrSldZ?=
 =?utf-8?B?dVpmRmhLWXdRRE5MdHB4L2s3bDlzY3E3QnVGRUVOeHpCbmx5V1R1M3RwOHp6?=
 =?utf-8?B?WVllRUFlYXFUTkZPZmlUQVJjd25JTGphWGJLQm5pQ0k3dmo4dmhDVnhoS0RE?=
 =?utf-8?B?TWdqRDV6c3VLTVNaTy9JZjB2aStGTGlDNWVKVHRNTWdZS3J5bS84Y1pRNzZQ?=
 =?utf-8?B?SUdTa2pla1Ria3BSUVlZMEs2cmZuWTFGZzFHaDFwazJlOTZoQVQ2bE5uMmo5?=
 =?utf-8?B?MnlWaitQaVo3c1dQS2tjVHFNQkpyVmJDak5Eb2dZdmo2MC85ZVRyWEExeTFM?=
 =?utf-8?B?VjJLUlByb0VWb1pmSElmcVpMRThPUUdWQWlmOGdtSHBndWExNS9WVXh2dUh6?=
 =?utf-8?B?ZGpYSU1qUGN3bVNDSlNQc0xWUnlVWHY5cFJBbXEvcUxJTTIySXd4VGxzWU1s?=
 =?utf-8?B?TW9iMWVqQ1RCTEcwRnY0ZjRaV2UyZldBMy9Gd0N1WUVqdGNGVGliekhJTit6?=
 =?utf-8?B?TS80dnpqd3Fack1oZDJ0eG84b0dCb3VkUWI1cHdhb1F6QVFoTzdqb0lGS2Zm?=
 =?utf-8?B?Rm5USGxQMGE1VklBMjBkUHZndVloQklxdXlXTHRtZ01uMUpJNnp6RW1RKzZq?=
 =?utf-8?B?dUhuSDdIM1ZUQjVJVVdxNEVCUldTRDFjWEw4YVZrcDc3YWdmbzVWZlF6UTBw?=
 =?utf-8?B?Vzc1d3BheURiVGtWNUZTZ1d0Q3E0dXNRNzBFWCtpSlloZ2FOdUNxWTBlMURJ?=
 =?utf-8?B?RkM0QUtBTHhTcXo1TDdHTnpDVGVia1RHc0trYmd4UEdSa1ZFaG01Sjk0aU1Y?=
 =?utf-8?B?RUN0K3RYNjl0alVhWVBjRkhHNFljSUhNZ29GUmhaZWhUdTFwUXczazFCcWtP?=
 =?utf-8?B?cmpzV0dOaXNPa0x5QXZNTVRZaC9iazgvOVJNTktPbWZaRTlreHp4QU9jWFpZ?=
 =?utf-8?B?R2JmUlpSUlZSK0NSTHVlKzFJbzFWOWxuUm5vUUx4aXl0MXRSWjl3VC9SRDZJ?=
 =?utf-8?B?TGY1UlFUcFZqT3FqTzVQWFpRMnQ4NWRlZlBkK09hNHVyREJiUk1EaE1sSDRa?=
 =?utf-8?B?Q1BmQnJvWlBIRzBWSTkxbmlCQnNRNnYxM1M2WmJFYlFQckRLWGloMHVyYUxj?=
 =?utf-8?B?d2NxeG1SU3VYVzIrV05hTXU1YXBWZjNXVnJZSXVkUk9rZFlNMlhJSjhETTNY?=
 =?utf-8?B?aklvSS84WVFVaStjOGhmVjBlOXBQTG5NTHhNMHZ2V0hyODljY2xsZnZtNUFT?=
 =?utf-8?B?aDk3R2tiVXZucGx4bktHV0dkWFJrd09zSDljR25TZnBFZzl0aWtBalRNeHFX?=
 =?utf-8?B?Ym9Ba1RpR2lqZWFXZk1lanFYaE0vM2RDdmk5L29PM1FpQ2xBRzZVaTZuUUtU?=
 =?utf-8?B?ZGc5RnhWcDkwVjVGMU84a3NVR2xtVWgyMzd1Z3pEZnEyQXVWWFMwaE5XQnlw?=
 =?utf-8?Q?2+7s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c4d768-f43f-43ce-6f50-08dbd9217611
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:23:15.4924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJ8uF545P4P0RDla0zV1KCl2sRpdoejGaW3jj5FRC7/dBiKp8df02uJNZAq6xZp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.10.23 um 00:39 schrieb Felix Kuehling:
> Make restore workers freezable so we don't have to explicitly flush them
> in suspend and GPU reset code paths, and we don't accidentally try to
> restore BOs while the GPU is suspended. Not having to flush restore_work
> also helps avoid lock/fence dependencies in the GPU reset case where we're
> not allowed to wait for fences.
>
> This is an RFC and request for testing. I have not tested this myself yet.
> My notes below:
>
> Restore work won't be frozen during GPU reset. Does it matter? Queues will
> stay evicted until resume in any case. But restore_work may be in trouble
> if it gets run in the middle of a GPU reset. In that case, if anything
> fails, it will just reschedule itself, so should be fine as long as it
> doesn't interfere with the reset itself (respects any mechanisms in place
> to prevent HW access during the reset).
>
> What HW access does restore_work perform:
> - migrating buffers: uses GPU scheduler, should be suspended during reset
> - TLB flushes in userptr restore worker: not called directly, relies on
>    HWS to flush TLBs on VMID attachment
> - TLB flushes in SVM restore worker: Does TLB flush in the mapping code
> - Resuming user mode queues: should not happen while GPU reset keeps queue
>    eviction counter elevated
> Ergo: Except for the SVM case, it's OK to not flush restore work before
> GPU resets. I'll need to rethink the interaction of SVM restore_work with
> GPU resets.

It also sounds like the restore work is some high level work and 
shouldn't interact with the lower level GPU reset.

>
> What about cancelling p->eviction_work? Eviction work would normally be
> needed to signal eviction fences, but we're doing that explicitly in
> suspend_all_processes. Does eviction_work wait for fences anywhere? Yes,
> indirectly by flushing restore_work. So we should not try to cancel it
> during a GPU reset.
>
> Problem: accessing p->ef concurrently in evict_process_worker and
> suspend_all_processes. Need a spinlock to use and update it safely.
> Problem: What if evict_process_worker gets stuck in flushing restore_work?
> We can skip all of that if p->ef is NULL (which it is during the reset).
> Even if it gets stuck, it's no problem if the reset doesn't depend on it.
> It should get unstuck after the reset.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 49 +++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
>   4 files changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 54f31a420229..89e632257663 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1644,7 +1644,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
>   		goto out_unlock;
>   	}
>   	WRITE_ONCE(pinfo->block_mmu_notifications, false);
> -	schedule_delayed_work(&pinfo->restore_userptr_work, 0);
> +	queue_delayed_work(system_freezable_wq,
> +			   &pinfo->restore_userptr_work, 0);
>   
>   out_unlock:
>   	mutex_unlock(&pinfo->lock);
> @@ -2458,7 +2459,8 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>   				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>   		if (r)
>   			pr_err("Failed to quiesce KFD\n");
> -		schedule_delayed_work(&process_info->restore_userptr_work,
> +		queue_delayed_work(system_freezable_wq,
> +			&process_info->restore_userptr_work,
>   			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>   	}
>   	mutex_unlock(&process_info->notifier_lock);
> @@ -2793,7 +2795,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>   
>   	/* If validation failed, reschedule another attempt */
>   	if (evicted_bos) {
> -		schedule_delayed_work(&process_info->restore_userptr_work,
> +		queue_delayed_work(system_freezable_wq,
> +			&process_info->restore_userptr_work,
>   			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>   
>   		kfd_smi_event_queue_restore_rescheduled(mm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9cc32f577e38..cf017d027fee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -919,6 +919,7 @@ struct kfd_process {
>   	 * during restore
>   	 */
>   	struct dma_fence *ef;
> +	spinlock_t ef_lock;
>   
>   	/* Work items for evicting and restoring BOs */
>   	struct delayed_work eviction_work;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fbf053001af9..a07cba58ec5e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
>   	if (!kfd_process_wq)
>   		kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
>   	if (!kfd_restore_wq)
> -		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq", 0);
> +		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
> +							 WQ_FREEZABLE);
>   
>   	if (!kfd_process_wq || !kfd_restore_wq) {
>   		kfd_process_destroy_wq();
> @@ -1460,6 +1461,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>   
>   	kref_init(&process->ref);
>   	mutex_init(&process->mutex);
> +	spin_lock_init(&process->ef_lock);
>   	process->mm = thread->mm;
>   	process->lead_thread = thread->group_leader;
>   	process->n_pdds = 0;
> @@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
>   	return -EINVAL;
>   }
>   
> +static void signal_eviction_fence(struct kfd_process *p)
> +{
> +	spin_lock(&p->ef_lock);
> +	if (!p->ef)
> +		goto unlock_out;
> +	dma_fence_signal(p->ef);

This needs to grab the internal lock of the eviction fence, I'm not sure 
that has correct ordering with the newly added ef_lock.

> +	dma_fence_put(p->ef);
> +	WRITE_ONCE(p->ef, NULL);
> +
> +unlock_out:
> +	spin_unlock(&p->ef_lock);
> +}
> +
>   static void evict_process_worker(struct work_struct *work)
>   {
>   	int ret;
> @@ -1916,8 +1931,11 @@ static void evict_process_worker(struct work_struct *work)
>   	 * lifetime of this thread, kfd_process p will be valid
>   	 */
>   	p = container_of(dwork, struct kfd_process, eviction_work);
> -	WARN_ONCE(p->last_eviction_seqno != p->ef->seqno,
> -		  "Eviction fence mismatch\n");
> +	/* If the eviction fence is not valid, we're probably in a suspend
> +	 * or GPU reset cycle. There is nothing to do in this case.
> +	 */
> +	if (!READ_ONCE(p->ef))
> +		return;

This evict process work is high level I don't think it should have any 
dependency on the GPU reset.

Regards,
Christian.

>   
>   	/* Narrow window of overlap between restore and evict work
>   	 * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
> @@ -1930,9 +1948,7 @@ static void evict_process_worker(struct work_struct *work)
>   	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
>   	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>   	if (!ret) {
> -		dma_fence_signal(p->ef);
> -		dma_fence_put(p->ef);
> -		p->ef = NULL;
> +		signal_eviction_fence(p);
>   		queue_delayed_work(kfd_restore_wq, &p->restore_work,
>   				msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
>   
> @@ -1967,9 +1983,19 @@ static void restore_process_worker(struct work_struct *work)
>   
>   	p->last_restore_timestamp = get_jiffies_64();
>   	/* VMs may not have been acquired yet during debugging. */
> -	if (p->kgd_process_info)
> +	if (p->kgd_process_info) {
> +		struct dma_fence *ef = NULL;
> +
>   		ret = amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
> -							     &p->ef);
> +							     &ef);
> +		if (!ret) {
> +			spin_lock(&p->ef_lock);
> +			WARN_ONCE(p->ef, "Eviction fence is not NULL");
> +			WRITE_ONCE(p->ef, ef);
> +			spin_unlock(&p->ef_lock);
> +		}
> +	}
> +
>   	if (ret) {
>   		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
>   			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
> @@ -1994,14 +2020,9 @@ void kfd_suspend_all_processes(void)
>   
>   	WARN(debug_evictions, "Evicting all processes");
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> -		cancel_delayed_work_sync(&p->eviction_work);
> -		flush_delayed_work(&p->restore_work);
> -
>   		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
>   			pr_err("Failed to suspend process 0x%x\n", p->pasid);
> -		dma_fence_signal(p->ef);
> -		dma_fence_put(p->ef);
> -		p->ef = NULL;
> +		signal_eviction_fence(p);
>   	}
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fe937670c927..aa6c34127be9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1869,7 +1869,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   	/* If validation failed, reschedule another attempt */
>   	if (evicted_ranges) {
>   		pr_debug("reschedule to restore svm range\n");
> -		schedule_delayed_work(&svms->restore_work,
> +		queue_delayed_work(system_freezable_wq, &svms->restore_work,
>   			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>   
>   		kfd_smi_event_queue_restore_rescheduled(mm);
> @@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   			pr_debug("failed to quiesce KFD\n");
>   
>   		pr_debug("schedule to restore svm %p ranges\n", svms);
> -		schedule_delayed_work(&svms->restore_work,
> +		queue_delayed_work(system_freezable_wq, &svms->restore_work,
>   			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>   	} else {
>   		unsigned long s, l;

