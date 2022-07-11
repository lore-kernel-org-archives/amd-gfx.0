Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66351C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 18:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E147790727;
	Mon, 11 Jul 2022 18:54:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8FD90727
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 18:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRbSUlCge3IeBR92wzmgOTGwJcs9Hkkb5O++IEPDWAbwIA+Q7+jtgyae22WyBwEPWTdCu6M2p5EzUn0Cg2aAfTCKYqWgWb6ePZQxy3nKnqWOW1q94TDmdkKl2zkE2nEbSn22ZmFf5dnTLak6MQ2p8fm8pgUBvfBaCzWmhXjrss69vSw9PsYnTWiy8qmQDuZ1g9NiqUSm0k8lO8MzXG/tAdDITWzH7AjfvnGhbsZllorJmsaTJezCR7aD5dgi/VjUG7cKK0LN+y+o642BCM9Wyu9ySbmv6FCw9Te34mVWlqxnI4AviZzTP3dGZ4479AifEKc04krT4HPCX0peerSatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyrXyNaUa4Nr8kG3yCafy1VLAD/YtXo7FoKPCSK9HWY=;
 b=MLfxNJeSATyeFYmOodmqkMSpG3MDwHMj9fJbl5Sa4UTg8sGdkU9tXwbm+mxGvPe6EAGP6TR68IuuCkUTwptnjGUkReMo/Uvhjt3s1o1tAagwdwONoRaVxUir77W6fDBaTaES55gYSid30w5/04mVfouO100qVTWJEDD+CGHKFgWEXySSEb49NBwx/Vl1l+SdO67AMWP9iIDWwELG2iuehHEgsRczmpqzsZo2cgZ8LVqeVakmIOpO/3pNcIvXIZKBMNHw/U6ben1f638DyBxalFxXRrlCMZUKZVbu8fPCJJuAk2UtZm3IwtVQMQRJ1ZmdlrCBe7XQTAihuMvmd7MCHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyrXyNaUa4Nr8kG3yCafy1VLAD/YtXo7FoKPCSK9HWY=;
 b=oGKwruXEvqLQHHQkqldEmob9/HFyi3UXmNJEcvazvuvzY2EvDkk7Cc2WQIhaN7fdUxoOIPIr56qMLYq0nIAph291pKeqANSbaLHgK0uUXGKURoNZOvwy3EFvLQJhXUbya55T8JgfaiUGfS82wDFOs5WUigJGa604C923uVYbpBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1375.namprd12.prod.outlook.com (2603:10b6:300:10::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 18:54:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 18:54:01 +0000
Message-ID: <d8e55c48-6a8f-5e65-5ff8-386086fedb67@amd.com>
Date: Mon, 11 Jul 2022 14:54:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdkfd: Process notifier release callback don't
 take mutex
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220707212340.23118-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220707212340.23118-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:610:55::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa0a22b6-b160-4758-461c-08da636eb83a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1375:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2q6qIpwsZ3tbNkG6Ly2GB0qcLn9Idkia0O5jc1w7Fhmlb8Qu0NnleFYOxoBRIgR8ZyMnNL8/rFXXqKC3Q2jmgi+0HoE5U+r8g8z+j2BtubJw+zwlRi41cTMNQ4hLAwYwk1NLWXo5lvufPkocU0rWlgpRk/C1fEXtUalVuw8Q5HC1otI1aGFds5xiAFKE0RZ7cC0RieWC+uZYBA7eARcUG9+OWyxoEXOq74BdxqE8uD6+xzONgj8KrTh4tXkIfVWFHxmO/dwa6TQPKZe1Y5Wli7my2FK2f53ZWJN0jCuj4/WnWUROtXDxHRDARy1NlD9Oy194Vre8TaXJMqnCoioITgXKd53/SpGaF0zEWvtrBA3Lnt0KG2pb0ir0cYi34/2PVa0VxxSFfRNlsZmgixJMYoVbJ036OCtsRbeNe21Pg+BcOcBjlk17zrTPkqltNp/pc5/r1ZNBB9L01QtmPZ6M0DuxcchL5aG+2FXPINQJVTCtW97O4cRjvTtXXkj6UMjQ0jtQwJNnfzFKTaHI5PybllVb6tZZXY5YhgSYzdEr7rt/2oBji2gWHAqQAp6yq5AqhL1RdRVJu4XgdiV7pM0zSoXWa/jMxxP1t8f4mpyqtlk8QRK4hTOJk0+F69+QcrZtbujGGs/xeeoCLEVBoYXLJ4LLNLI5aECwUL8oUYoL6njBXEQfSzGBXIgJPlKqbrbHkBiEwzuV0rylEFVUWzs1xFJQs4Rfbxqq2g4Qp6XVvSbaGaufipTnbjuHmBqLNabtK711YzkWUen5qHzkcYw/pwR1mQH2KzMfGyxGV8t5oGi4jysSndWC5WL8MphSjif7EDJUfEC1xpNzMl4HFmduX8x4p/JMfQYl6eFChkxAkdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(2616005)(6506007)(478600001)(53546011)(316002)(36756003)(6512007)(2906002)(186003)(41300700001)(31686004)(36916002)(6486002)(26005)(5660300002)(31696002)(38100700002)(44832011)(83380400001)(66556008)(66946007)(66476007)(8936002)(86362001)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0RVVE8va0NiQ043ek1naDE4RkVSNk5kYklKamk3b3hYN0ZYbkZCZlR3MVdl?=
 =?utf-8?B?TnlVUGsrTlRFak9sY3I4Sm5uSURKeVVDYkdTeUFnR2pJQUpCVSswWVJLdGhm?=
 =?utf-8?B?RDVobEhGakpYVXlGczA4dGRCeDdiTTJuaW5SWnhmcWpjR0RWTGhoWGZvMXlN?=
 =?utf-8?B?aDhBdkR6dXBsTjF4dC9iYXVlMkdYTDNPUXU5aUlWYUUwSkl0UkZYVHVCMFY1?=
 =?utf-8?B?SVFQTHNXRVZlSWMxS3pEdVA4TU4xM3JuRGZHWjZ2NWRyUTdqUjVpUmxpNVMy?=
 =?utf-8?B?VWM3QnlnNitHdjczemFlNUw3Z0FaUFA3VHhIMU5Qem5VWlNMZHMwT0h5RnI1?=
 =?utf-8?B?OFlBbExpUkQwTUZEVFhFWjRkY21wbkh2aTEzbFI4c1FDQ3Zad2VMMFNQd0ti?=
 =?utf-8?B?T2paSGEzU3gwOU85OTNqUUtTVTNyQUMvNVl4aThEcnk3TEZXbytPUzB3YXdO?=
 =?utf-8?B?K1doYVNYZE5DRUVnZnhlaW00ZVhzNG0xajF5TG1SNnJCQUt5WEg0TnFkUkFQ?=
 =?utf-8?B?amVrdm83N1hZaHo1dTNzb0NxKzUxVDNoS2EzYjhXbXJZa0hOK3RIVEFURzds?=
 =?utf-8?B?YWc3NjFhZ05BMWt0N1VRRFRjTTllTlBJcGQxUmJ2QnB2NWEwckdubWVPTkxs?=
 =?utf-8?B?WFJMUU9IU0NpZlYrRDA0VGtHTEV6V24xRjFTTUlValk1cU1lOGJaK1FmdmFi?=
 =?utf-8?B?aUVWYkMrUTFCTk8zKzVTRVJqcFFMWGozN1FYbXVRbC9OQ1FRL2J4VlpQNTdY?=
 =?utf-8?B?RmtBZkNOQXVnaUZlNHNoT01LZ2hXSjRkNHVBa0RxcU5YUDBqOE1hT05qenFF?=
 =?utf-8?B?YVBHVXNjN01mVkRLemNpU1EyWW8vR3ZHK3VuMFRmTlJVc2k4cEQ4OFVZMG1W?=
 =?utf-8?B?NnUxb0lsNDBZNWpkdmljT2RZa3ZsVG91Y05MOEF2RGtvQjVORWllSlhPK3Jx?=
 =?utf-8?B?NWxVaWNVZkFTeU90WVdxSy9OZytjMXZUcGxMaXIxVFdOdlB6QTJaQ1o1aVYv?=
 =?utf-8?B?UGhTRUhqa0tqMXpqSGsvVU04ckZhN25xTkV5RS81Q2c5ZW9iSEcvVHlrWUxW?=
 =?utf-8?B?bFh6VjlkL1lPeUxYOWh3VDJXMTR3V0lCdGlWbGZmS3k1TzRLcmRqZXllcm9k?=
 =?utf-8?B?UnY5c0xoM012SFFKa0VtSnMyM0pjSWpBQkwvWlcxUHdjUisxNHJXSnFNYTE0?=
 =?utf-8?B?T09UUitMK3ZTRjNaU3k5U3IrcUg5N09zdXlZR0N2RUc3VEJCSGczVEpES1Uv?=
 =?utf-8?B?ek1hWVh1bE5yWEVTZEVHU24rTTN2dVY1bWZheHpaVEhPMmZGU2trWjFrVzRp?=
 =?utf-8?B?TmRSS296Z3hQbjRQemErVEdYNkRLTWJpOHBCb0NqRVFya2ZZUnU1bFVXdnhI?=
 =?utf-8?B?b2h2NTR5elZqZzcreWJLdTJsMkk5QSsxdkNZQjRsdjJIbzVxRU56NWExSVZo?=
 =?utf-8?B?OVZON21oK29Zb3VXMjFEN1RKRDlMdDRMbUJkSW1FbHlRL2o3dVN0SjFGNnVs?=
 =?utf-8?B?U1ZNWHV4cXU5RUJ4NlJMekZhN0ZjSDY4bjloRUg3S3dBRHVzSVd0RzFoS0dF?=
 =?utf-8?B?MlgxSHFLK1JuNUd5MnNKekI5Q2ZmS0xSWGZLSHNtOE5mejk0L0plMTByRm1n?=
 =?utf-8?B?Vy9XY1oyS1lJcHNsazE4aVJtL0FMeEFRY2Fxc1pHVjMyYUh0U0k0MHlqTmFv?=
 =?utf-8?B?K1VjbTk3Ykhrb2VpTExYMWtpWENpb0t4Q3F1d09HRzZ2UkNWMm9qakJEZ1FQ?=
 =?utf-8?B?Rm1aQ2pzTm1QOU1Wd042UXIyNDhjNnRuUE9KeHJFdlpWQXp3M3NVT2IvQ01s?=
 =?utf-8?B?cnFwVDZiRU14T1pUSHU1VXNhczFNdUVZUVJ2OXVBdVkwelU4WkNmdm9RTnoz?=
 =?utf-8?B?dStLdnRWamRjZ3ZTUUlaRzhPTXdtRUk4UWQxUnl1VVZLdFNuOXlHZzgzaEdx?=
 =?utf-8?B?dWpZRHp1NlBmdDljTU5YbzFEc0w0eVc1Znd0T3ZPTSs2UFhnUlh4OXdKQktr?=
 =?utf-8?B?Y3ZCeEpPdGRnWndPaWg5L1d6VDN2MWdXMzFSd0tRTlJoRk9jaENkSjBwYTV5?=
 =?utf-8?B?dmlCeXg2T0RoMVkyOWJjMzExUmtwZlJ0ZEhrTFVTaHVOR25WWW9naXNjTE9Z?=
 =?utf-8?Q?msXQ+lgwp0o2oa/0hBajgpmH4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0a22b6-b160-4758-461c-08da636eb83a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 18:54:01.6600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3etJ72ZSMDIpyZkNiTalaaklv3Uov3CRLqQJ4CwhvCpiGnZaeYUxlBk2jUE8e4RyYnEtLmO2cNslTUdY217jiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1375
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

On 2022-07-07 17:23, Philip Yang wrote:
> Move process queues cleanup to deferred work kfd_process_wq_release, to
> avoid potential deadlock circular locking warning:
>
>   WARNING: possible circular locking dependency detected
>                 the existing dependency chain (in reverse order) is:
>        -> #2
>          ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}:
>          __flush_work+0x343/0x4a0
>          svm_range_list_lock_and_flush_work+0x39/0xc0
>          svm_range_set_attr+0xe8/0x1080 [amdgpu]
>          kfd_ioctl+0x19b/0x600 [amdgpu]
>          __x64_sys_ioctl+0x81/0xb0
>          do_syscall_64+0x34/0x80
>          entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>        -> #1 (&info->lock#2){+.+.}-{3:3}:
>          __mutex_lock+0xa4/0x940
>          amdgpu_amdkfd_gpuvm_acquire_process_vm+0x2e3/0x590
>          kfd_process_device_init_vm+0x61/0x200 [amdgpu]
>          kfd_ioctl_acquire_vm+0x83/0xb0 [amdgpu]
>          kfd_ioctl+0x19b/0x600 [amdgpu]
>          __x64_sys_ioctl+0x81/0xb0
>          do_syscall_64+0x34/0x80
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>        -> #0 (&process->mutex){+.+.}-{3:3}:
>          __lock_acquire+0x1365/0x23d0
>          lock_acquire+0xc9/0x2e0
>          __mutex_lock+0xa4/0x940
>          kfd_process_notifier_release+0x96/0xe0 [amdgpu]
>          __mmu_notifier_release+0x94/0x210
>          exit_mmap+0x35/0x1f0
>          mmput+0x63/0x120
>          svm_range_deferred_list_work+0x177/0x2c0 [amdgpu]
>          process_one_work+0x2a4/0x600
>          worker_thread+0x39/0x3e0
>          kthread+0x16d/0x1a0
>
>    Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>          ----                    ----
>     lock((work_completion)(&svms->deferred_list_work));
>                                  lock(&info->lock#2);
>               lock((work_completion)(&svms->deferred_list_work));
>     lock(&process->mutex);
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fc38a4d81420..3c9cf9bdb63f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1115,6 +1115,15 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	struct kfd_process *p = container_of(work, struct kfd_process,
>   					     release_work);
>   
> +	kfd_process_dequeue_from_all_devices(p);
> +	pqm_uninit(&p->pqm);
> +
> +	/* Signal the eviction fence after user mode queues are
> +	 * destroyed. This allows any BOs to be freed without
> +	 * triggering pointless evictions or waiting for fences.
> +	 */
> +	dma_fence_signal(p->ef);
> +
>   	kfd_process_remove_sysfs(p);
>   	kfd_iommu_unbind_process(p);
>   
> @@ -1179,20 +1188,8 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
>   	cancel_delayed_work_sync(&p->eviction_work);
>   	cancel_delayed_work_sync(&p->restore_work);
>   
> -	mutex_lock(&p->mutex);
> -
> -	kfd_process_dequeue_from_all_devices(p);
> -	pqm_uninit(&p->pqm);
> -
>   	/* Indicate to other users that MM is no longer valid */
>   	p->mm = NULL;
> -	/* Signal the eviction fence after user mode queues are
> -	 * destroyed. This allows any BOs to be freed without
> -	 * triggering pointless evictions or waiting for fences.
> -	 */
> -	dma_fence_signal(p->ef);
> -
> -	mutex_unlock(&p->mutex);
>   
>   	mmu_notifier_put(&p->mmu_notifier);
>   }
