Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAC0C77B76
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 20:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE9310EEE0;
	Fri, 21 Apr 2023 20:11:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B973310E112
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 20:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddn9ntt9RSzdIrNjlEjOjIzlQhnmL1+I2QyeDpu3tzA6wZPy0lXVN923/wC17rUVycPGWw1zZY5nhORDlPpzIZBImo1FPkIbubC17BJJssiJZo67t+/NcZ0huEwOGpS7cNqcKWjWZbkv4yL1cFdwJYV55UbPwxZj/mTWz9jXXiDeapu8EFYayB5dKnFlu0JI+U0IBXBiczoL+0osJZjUgavU8u4mpcsomVgkubQWnhqB/tRwH8APIrsPF+4+I2Y6B0uBlksflnMXiHgZJbnilxiTxVz9td4M6kt6rYqpooydBXC0eZvYOk/wfbCVjGMc1ZkGMm+4YwtljNoOHvL8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkejA99ke9uL7J2LoWBQVEylzl7FyDgrHSwtVmTfK3I=;
 b=ef5Q/F2Gq03b7yYZkYgTWzskxeQ/rEODXsmG4ZnGgOcoj9GcI6cqZQy1ImOKkNoURvtlKXpkDC2JbZpZubF1J0opRxbzoG74LQ4EsE3JKmpCPF++uNN1c2PEIN8Jv35Q/A+Km0gi5ETMt+KJmk/S6lVicwEkNwKzIuMTEhqGNac4V1vWWS7SbIgPHJm/iwPGG7YK/mrlJGX5GsM2rzv+nBwyt5YaJ5b06rI5VFb9Nx+CYK2gJE8Tz7VNR4Iccqo/tvK3PUh4FyP/701C0CYigKEgDGgbs8Qm0HNDhw7gC+isReCFM1kwS/zTKaBpFWTC66vMYnQoCH6hbAfwwnTUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkejA99ke9uL7J2LoWBQVEylzl7FyDgrHSwtVmTfK3I=;
 b=X9F6xe7AS50W4KzAx/coSO6iXi1RRWLkMMMTuxKddoEMwo4jVj9Ri5ItQsSgESqfh3Xss1BtW9O8CPDYe/c//pDjokXiqUbaB1EM1gc4DX9qn9MAK0pRGt2YOMQCeRP4tGDwQiHXMh2DsOOqzaa1zTT95q9EYTJkTu5sqbMFH28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 20:11:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 20:11:21 +0000
Message-ID: <b8bf2cc9-6a72-5fce-e19f-cf69e37f382e@amd.com>
Date: Fri, 21 Apr 2023 16:11:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 09/12] drm/amdgpu: use doorbell manager for kfd process
 doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-10-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230412162537.1357-10-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0196.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed88d26-c1c9-4257-d64c-08db42a49317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIMUGcVnHikAW3ag/pOp9pxEV93Crg23NH2XM0aynBEzwJS1sHLpnlqu+w6oXTxvX4VkQXbRyWXjzwwG0aUILeHIS5Lx7/zp/Gw3S6S+csiEdzC7vw+Ipzp9Ny2bwjuz8cE31fuG3DaxvKCPtGxGxvYlsEFbxTB2LKrM+ffvLQcp+pI3cjDfKL2D/TrefMUoaYPPgDUa0nqlIhKv2s0tw+H1WGzbLmQIHJfye/92/9YyjLwTNuAUaOmXgdHi/GejlqggGtKce1+dP+QyjTKHxGm+km+lMl59930zMl36bEH1Z8bd5//DVoF5c42UFN3KOK5A613H1eqik2Z8HCWOWqcq+XgAGhDIDjLZgJP+DkghzRfPk+Td7PqUDczrGscn2PG62F+/FO40CvCR4lxF6ts92vnu6Qwczqvz0hDjQ1KAYcGFn/Nzl9V16uYWbn+jBVWCMpMTXqzE2HedLfMgfQxANB+bEfUygs90UWvrJ8PlwQhvuJ9+dpNNJUzCItNk6uwfN7GSrZStGsy59vTSCI7YBD9/QIM/61dZTkj6ISQS0SZRo2DvT/9wKd7NdsE9FmGms3IktOlQUyqYLYqEDCZtiALnsb1qqjF7xoKRuRyPbplll/kguLzuhp5ukE+bCCin4kH4TKhhV/+BnJ61ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(316002)(41300700001)(66946007)(66556008)(31696002)(4326008)(31686004)(66476007)(38100700002)(8676002)(44832011)(54906003)(8936002)(86362001)(478600001)(6486002)(36756003)(30864003)(2906002)(36916002)(5660300002)(2616005)(83380400001)(186003)(26005)(6512007)(53546011)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRUaEZJU2FjRlVob3JhVERFeHVyYWR1Nmc0VUp4c1BoZ3VTQ0Fwd3hJcExQ?=
 =?utf-8?B?M1dzSnNsNldhdEtnYXdrTEM4TE9JekZNdmVxdXlsK1VHYWN2eDBiS2E4RHh6?=
 =?utf-8?B?WnNFbGNSaUhQMXZNNjlMYm1CMkZGSElGblZVQkR5cXNZSTk1aHV3Z09mMFJP?=
 =?utf-8?B?RWNHMjlURjlRSlBwNnMvWEVHNWtoZmowSzQ1OXpqWGhxL0wxYzN4dWVvQStl?=
 =?utf-8?B?ZFBaQnNNd0ZrQ3g1ZXhqbVJhK2d3Z1dOWW5YcVZTdkNnMDlpMS9ZSUFHZURo?=
 =?utf-8?B?Y21nMkVqOWNNZEhYUzNQZDhmOHM2b29PZ3FqTXlFY0x1VjU4WW51LzhDRWIw?=
 =?utf-8?B?N1JySmk5ditKV21laTYxbmJmdXlkMVJFbWswazA4TG1jWmlTLzZmMVc1a1VQ?=
 =?utf-8?B?OGpidWM2bEtlcmhreFp3UFpSOHE0WXJwc0hZRFJZbk9sNVhmYnBjZW1zN0xx?=
 =?utf-8?B?V3hmUW10SjFMSmFjTUlIcmJBc3FIeG9GRWx2Z09WMmc3WksrKzBaakFpVXcw?=
 =?utf-8?B?d3lQdXpkUjMxQmNyQml3cGdLYUhvN3lGQmkwYTdtY0JnYWpWWVBEZ2l3S3Fr?=
 =?utf-8?B?SkhxY1l0N3FVV0tJNHFSdGpzcE1hSzJnZXh5TTVEcmpYTFA1bldyVFJ6SGd3?=
 =?utf-8?B?Qm1ZWUl1TjhuamZFTU5MS0EwdkZzdVFHNm1FcDl0SW1pRDFYUThXSEZlVmpY?=
 =?utf-8?B?V3NlYmd4UWxBWXBDaG9UWmdDY2lZeXFoMU4vY3BBQlQreEh3ZUhIaDJXTVh0?=
 =?utf-8?B?RVpJWTFsNWZvY3IxWUYydzEvVU9EY3U5K0k2MjFZYkZnZ0UzUzlmb3VxcHJC?=
 =?utf-8?B?UzNKRTNVRlE5S2wxRFlsbUVxTWozYkVRVjdkVnllNGNOMVUva1ZCN0tjV2RL?=
 =?utf-8?B?NU9GS1dsR296K2p1cGw0cW4yWGgvbXBaaStCSUxZUWlPbWtmL3RNb3NOZ2tH?=
 =?utf-8?B?VE03Y3MvQ3BtRjh0K21wTTdMdytjbEt0RFcramxGcmhtS0ZpUjVqTzlXWjh1?=
 =?utf-8?B?a0xxb2pUVDJLeTB4Sk1nL01SN1pyTmdNYm4wR0JIZGhoZDBoTStwZXYzYkI3?=
 =?utf-8?B?M0ZZcStocEFMTG9pWmhhQTNnVmNQM3VmUzdxRU9OeU0vSFdEbUNxVHdvVzJ0?=
 =?utf-8?B?MkR4cHdWbmFlYzdXK0gvMFB3aEczZ25xQU9aTEs4ckQwT3AwcVM0cGJweTdS?=
 =?utf-8?B?UmpUdUlvK2FibndMNFhnZjBMNWIrY3FIQTVJMC81Q2toa0FHb0JhTGJIbUJF?=
 =?utf-8?B?REhvQmo2V3Zpc28zdkdJdEJxQko0VmRLQ2hOZzAyUzA0di9aMjRIcTVFVk9w?=
 =?utf-8?B?TmNwaDhTNW1sS3pKYTVoeUkvWCtNdnEySlFIbCt6Lzh0aVplVjNYNFFXY3VY?=
 =?utf-8?B?UXNrNlBHODZha056OHplbFhZcy91UWJjeXgwclJBNHRyZ3ZGbkQ1QW5lTy9k?=
 =?utf-8?B?elNMc3k0dVlpTjFwRWVNbWw5ak1IYTcwUHNNalVnOHZrRTE3QUdKWmNQMzY1?=
 =?utf-8?B?VFJEckxzU3BiaTRsdWNXU3VPVzRYZE1uVkVwWjkvaS9CSjIxTFFoSk1SYVNF?=
 =?utf-8?B?dzJtYldPMDZlWkJEd1o0NTZFVGxhY3pTRi9JNXNoOFEvakJPN0Rwc291ZElC?=
 =?utf-8?B?bXhUZjRrTGpBMm54b0V1aTROWHR1ZjQ3a2J1NXB4QVN3c24za2w4TDRLeGgv?=
 =?utf-8?B?aVp2OFF5NWtZVmJSZngwVHJMUmQ0ZHpINmZua0xRSlovL2ljYzhnN243UkpP?=
 =?utf-8?B?d0RqUmlNaHhrK3hhcEJTQ2JWWTBCQmZqS2Z6aHNqV0hsNTFnaGVReEcvWmRI?=
 =?utf-8?B?SjA3bG1GM1AyYUprU1lSdHB5cENOQk94NFB0VW1sRmZUSjh1MExxODJpeDdG?=
 =?utf-8?B?ZVJXOWcvOUxiVGtrNnd5cTRxYWM5LzNQZG9KV1ZaVUMyajA1YTVlTDBmU3kx?=
 =?utf-8?B?aGkzUmxqWWFsVVMyK0pzQUhkY09DdVhMRGYwaWhIL0xsdDRVRENrcXBCcVFY?=
 =?utf-8?B?ek5OYlFMR0FUNkNiaTNZcW5qTWdVTUJmVnN0UERuUXZwZG9YL0pRUHh2SWxw?=
 =?utf-8?B?bVV5OTZtVDh6K1o0MUZKK0VKcHlVUzZxRmErdERMbkxSYno5YnNObm15K0Zm?=
 =?utf-8?Q?XrtxO5TqgPZ5m0Nqzl68msqDK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed88d26-c1c9-4257-d64c-08db42a49317
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 20:11:21.4350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4QP6BWbsZC1BPqL8c9j+5Q7P1VQ+sIDz0qTvqZ5vSRABIEBVquuTcULddN084CuxIG7uY9vlPgYZkWhDdRwyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-04-12 12:25, Shashank Sharma wrote:
> This patch:
> - adds a doorbell object in kfd pdd structure.
> - allocates doorbells for a process while creating its pdd.
> - frees the doorbells with pdd destroy.
> - removes previous calls to allocate process doorbells as
>    its not required anymore.
>
> PS: This patch ensures that we don't break the existing KFD
>      functionality, but now KFD userspace library should also
>      create doorbell pages as AMDGPU GEM objects using libdrm
>      functions in userspace. The reference code for the same
>      is available with AMDGPU Usermode queue libdrm MR. Once
>      this is done, we will not need to create process doorbells
>      in kernel.

I like this approach of keeping existing functionality working, but 
having a transition path for user mode. If I understand it correctly, 
allocating doorbells as GEM objects would enable overcommitment of 
doorbells. That's a capability we haven't had in KFD up to now. Trying 
to launch too many processes that need doorbells would simlpy fail.

With overcommitment, idle processes could have their doorbells objects 
evicted, sot that active processes can work. Doorbell objects would need 
eviction fences to ensure that processes are not scheduled on the GPU 
while their doorbell allocation is in use by other processes. The 
doorbell offset in the queue properties would need to be updated when 
doorbells are validated and potentially moved to different physical pages.

These details would need to be worked out in kernel mode before user 
mode can transition to GEM for doorbell allocation.


>
> V2: - Do not use doorbell wrapper API, use amdgpu_bo_create_kernel
>        instead (Alex).
>      - Do not use custom doorbell structure, instead use separate
>        variables for bo and doorbell_bitmap (Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ----
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  8 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 65 ++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 21 +++---
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 22 +++----
>   6 files changed, 64 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6d291aa6386b..0e40756417e5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -327,12 +327,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_bind_process;
>   	}
>   
> -	if (!pdd->doorbell_index &&
> -	    kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> -		err = -ENOMEM;
> -		goto err_alloc_doorbells;
> -	}
> -

You're moving this to kfd_create_process_device_data, which means 
processes will allocate and pin doorbells, even if they never create 
queues. We specifically moved this to first queue creation to allow more 
ROCm processes to be started, as long as they don't create queues. This 
is important on systems with many GPUs where not all processes need to 
use all GPU. It also helps with certain tools that need to initialized 
ROCr to gather information, but don't need to create queues. See this 
patch for reference:

commit 16f0013157bf8c95d10b9360491e3c920f85641e
Author: Felix Kuehling <Felix.Kuehling@amd.com>
Date:   Wed Aug 3 14:45:45 2022 -0400

     drm/amdkfd: Allocate doorbells only when needed
     
     Only allocate doorbells when the first queue is created on a GPU or the
     doorbells need to be mapped into CPU or GPU virtual address space. This
     avoids allocating doorbells unnecessarily and can allow more processes
     to use KFD on multi-GPU systems.
     
     Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
     Reviewed-by: Kent Russell <kent.Russell@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


Until we have an alternative way to allocate doorbells that supports 
overcommitment, late doorbell allocation is an important feature. This 
change will cause regressions for some ROCm users.

Regards,
   Felix



>   	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
>   	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
>   	 */
> @@ -410,7 +404,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	if (wptr_bo)
>   		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>   err_wptr_map_gart:
> -err_alloc_doorbells:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> @@ -2163,12 +2156,6 @@ static int criu_restore_devices(struct kfd_process *p,
>   			ret = PTR_ERR(pdd);
>   			goto exit;
>   		}
> -
> -		if (!pdd->doorbell_index &&
> -		    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> -			ret = -ENOMEM;
> -			goto exit;
> -		}
>   	}
>   
>   	/*
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ecb4c3abc629..855bf8ce3f16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -371,7 +371,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>   			unsigned int found;
>   
>   			found = find_first_zero_bit(qpd->doorbell_bitmap,
> -						KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
> +						    KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>   			if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
>   				pr_debug("No doorbells available");
>   				return -EBUSY;
> @@ -381,9 +381,9 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>   		}
>   	}
>   
> -	q->properties.doorbell_off =
> -		kfd_get_doorbell_dw_offset_in_bar(dev, qpd_to_pdd(qpd),
> -					  q->doorbell_id);
> +	q->properties.doorbell_off = amdgpu_doorbell_index_on_bar(dev->adev,
> +								  qpd->proc_doorbells,
> +								  q->doorbell_id);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index 82b4a56b0afc..718cfe9cb4f5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -227,46 +227,47 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
>   
>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>   {
> -	if (!pdd->doorbell_index) {
> -		int r = kfd_alloc_process_doorbells(pdd->dev,
> -						    &pdd->doorbell_index);
> -		if (r < 0)
> -			return 0;
> -	}
> +	struct amdgpu_device *adev = pdd->dev->adev;
> +	uint32_t first_db_index;
>   
> -	return pdd->dev->doorbell_base +
> -		pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
> +	first_db_index = amdgpu_doorbell_index_on_bar(adev, pdd->qpd.proc_doorbells, 0);
> +	return adev->doorbell.base + first_db_index * sizeof(uint32_t);
>   }
>   
> -int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_index)
> +int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
>   {
> -	int r = 0;
> -
> -	if (!kfd->shared_resources.enable_mes)
> -		r = ida_simple_get(&kfd->doorbell_ida, 1,
> -				   kfd->max_doorbell_slices, GFP_KERNEL);
> -	else
> -		r = amdgpu_mes_alloc_process_doorbells(
> -				(struct amdgpu_device *)kfd->adev,
> -				doorbell_index);
> +	int r;
> +	struct qcm_process_device *qpd = &pdd->qpd;
>   
> -	if (r > 0)
> -		*doorbell_index = r;
> +	/* Allocate bitmap for dynamic doorbell allocation */
> +	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
> +					     GFP_KERNEL);
> +	if (!qpd->doorbell_bitmap) {
> +		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
> +		return -ENOMEM;
> +	}
>   
> -	if (r < 0)
> -		pr_err("Failed to allocate process doorbells\n");
> +	/* Allocate doorbells for this process */
> +	r = amdgpu_bo_create_kernel(kfd->adev,
> +				    kfd_doorbell_process_slice(kfd),
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &qpd->proc_doorbells,
> +				    NULL,
> +				    NULL);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate process doorbells\n");
> +		bitmap_free(qpd->doorbell_bitmap);
> +		return r;
> +	}
>   
> -	return r;
> +	return 0;
>   }
>   
> -void kfd_free_process_doorbells(struct kfd_dev *kfd, unsigned int doorbell_index)
> +void kfd_free_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
>   {
> -	if (doorbell_index) {
> -		if (!kfd->shared_resources.enable_mes)
> -			ida_simple_remove(&kfd->doorbell_ida, doorbell_index);
> -		else
> -			amdgpu_mes_free_process_doorbells(
> -					(struct amdgpu_device *)kfd->adev,
> -					doorbell_index);
> -	}
> +	struct qcm_process_device *qpd = &pdd->qpd;
> +
> +	bitmap_free(qpd->doorbell_bitmap);
> +	amdgpu_bo_free_kernel(&qpd->proc_doorbells, NULL, NULL);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 0b199eb6dc88..dfff77379acb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -661,7 +661,10 @@ struct qcm_process_device {
>   	uint64_t ib_base;
>   	void *ib_kaddr;
>   
> -	/* doorbell resources per process per device */
> +	/* doorbells for kfd process */
> +	struct amdgpu_bo *proc_doorbells;
> +
> +	/* bitmap for dynamic doorbell allocation from the bo */
>   	unsigned long *doorbell_bitmap;
>   };
>   
> @@ -1009,9 +1012,9 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
>   					unsigned int doorbell_id);
>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
>   int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
> -				unsigned int *doorbell_index);
> +				 struct kfd_process_device *pdd);
>   void kfd_free_process_doorbells(struct kfd_dev *kfd,
> -				unsigned int doorbell_index);
> +				 struct kfd_process_device *pdd);
>   /* GTT Sub-Allocator */
>   
>   int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 51b1683ac5c1..217ff72a97b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1037,10 +1037,9 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>   				get_order(KFD_CWSR_TBA_TMA_SIZE));
>   
> -		bitmap_free(pdd->qpd.doorbell_bitmap);
>   		idr_destroy(&pdd->alloc_idr);
>   
> -		kfd_free_process_doorbells(pdd->dev, pdd->doorbell_index);
> +		kfd_free_process_doorbells(pdd->dev, pdd);
>   
>   		if (pdd->dev->shared_resources.enable_mes)
>   			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
> @@ -1453,11 +1452,6 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
>   	if (!KFD_IS_SOC15(dev))
>   		return 0;
>   
> -	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
> -					     GFP_KERNEL);
> -	if (!qpd->doorbell_bitmap)
> -		return -ENOMEM;
> -
>   	/* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
>   	pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, range_end);
>   	pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
> @@ -1499,9 +1493,15 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   	if (!pdd)
>   		return NULL;
>   
> +	retval = kfd_alloc_process_doorbells(dev, pdd);
> +	if (retval) {
> +		pr_err("failed to allocate process doorbells\n");
> +		goto err_free_pdd;
> +	}
> +
>   	if (init_doorbell_bitmap(&pdd->qpd, dev)) {
>   		pr_err("Failed to init doorbell for process\n");
> -		goto err_free_pdd;
> +		goto err_free_db;
>   	}
>   
>   	pdd->dev = dev;
> @@ -1529,7 +1529,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   						false);
>   		if (retval) {
>   			pr_err("failed to allocate process context bo\n");
> -			goto err_free_pdd;
> +			goto err_free_db;
>   		}
>   		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
>   	}
> @@ -1541,6 +1541,9 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   
>   	return pdd;
>   
> +err_free_db:
> +	kfd_free_process_doorbells(pdd->dev, pdd);
> +
>   err_free_pdd:
>   	kfree(pdd);
>   	return NULL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 5137476ec18e..6c95586f08a6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -344,17 +344,19 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		goto err_create_queue;
>   	}
>   
> -	if (q && p_doorbell_offset_in_process)
> +	if (q && p_doorbell_offset_in_process) {
>   		/* Return the doorbell offset within the doorbell page
>   		 * to the caller so it can be passed up to user mode
>   		 * (in bytes).
> -		 * There are always 1024 doorbells per process, so in case
> -		 * of 8-byte doorbells, there are two doorbell pages per
> -		 * process.
> +		 * relative doorbell index = Absolute doorbell index -
> +		 * absolute index of first doorbell in the page.
>   		 */
> -		*p_doorbell_offset_in_process =
> -			(q->properties.doorbell_off * sizeof(uint32_t)) &
> -			(kfd_doorbell_process_slice(dev) - 1);
> +		uint32_t first_db_index = amdgpu_doorbell_index_on_bar(pdd->dev->adev,
> +									pdd->qpd.proc_doorbells, 0);
> +
> +		*p_doorbell_offset_in_process = (q->properties.doorbell_off
> +						- first_db_index) * sizeof(uint32_t);
> +	}
>   
>   	pr_debug("PQM After DQM create queue\n");
>   
> @@ -858,12 +860,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   		goto exit;
>   	}
>   
> -	if (!pdd->doorbell_index &&
> -	    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> -		ret = -ENOMEM;
> -		goto exit;
> -	}
> -
>   	/* data stored in this order: mqd, ctl_stack */
>   	mqd = q_extra_data;
>   	ctl_stack = mqd + q_data->mqd_size;
