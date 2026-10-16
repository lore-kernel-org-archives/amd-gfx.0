Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD02CCF2C3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 18:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCD310E0AC;
	Fri, 16 Oct 2026 18:42:34 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FE010E3C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 18:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzkDtMRXL6DGAfMl6YDZnTL//1JOPnso6C55bs2ChU3m5SJuCduuNM4+jMacuPsIdKn8oijK+kvT4zdW1LbsjDCjyOo/Y/TKO6Vj81gqaF9oCwUuwUheDY+eHw75B7oImqod3aUrv6cAsPo63RYmcMgY/KwhmmRcVTz5QzQCVBgzFKbp8ye21MpnjxzoO3KHltLJ8R6AFrhBm9R7OblmObc3qT288gAN7m0RyfKqd9y1v1785/bLzlwcfLlLg2WgFDsh4AXHCIeCEoealOPfjr54Fjb70LhaFDCM7WT2YlTtiLgteGAGVsjct7e5UekypAx8MBiTe1oWUVmfEq89HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gctRo0M49UOOUJZaK/ADV7Re9LYnvT/84YGWiD/DnWc=;
 b=YtC+aEg4XiBk0v4uSueruXStsavwL/zovUx6Gn3B1YBUsm8yQMnYomvFYwwN8Em9haJzM+wH3W/JKJXFvVlfwJ0B1EhV7BIGqmMZ80hqSUw53kIjyfkogGN3aZn+uaXW8sAnP2Fv0GSk4dE7h7y7V57HccaN6ZVJwwi6qS6bFG1H6CeTDhLHlbYID3CnPKmMFHJKm9wdd3K8/t6s411fh5RqCjg/p7SrzZ9bEMxe/k1DfY6KYsJBT8TjyEYfd+m2q+iMAFdRP2RRXhZqBlxchPHwLoW9Resp2RTRIg9IhvdsNL49E2NJ6twZ2IR6GGHrq3BTvEgUNjiUevGyAjXYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gctRo0M49UOOUJZaK/ADV7Re9LYnvT/84YGWiD/DnWc=;
 b=f83SjQ2wc708X/xl0UY9aBkzgIdritZx+Qmnug/b8XVixW9NdRLSE+vUBseW1BH08OicnvE6Nmcs7a7ZAUTeUf1JHJgs7O1Mlaze/GU8VWrs/bZ9DId44hSQkEmbu1d4my9nYI41vqPYTBXUzg+OPC4Z8ju8DL7+Wy+MJi+DPaU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by PH6PR12MB366721.namprd12.prod.outlook.com
 (2603:10b6:510:3de::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 18:42:25 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 18:42:25 +0000
Message-ID: <a5fb7c11-787d-4d88-ba5d-e77324bd91c1@amd.com>
Date: Fri, 16 Oct 2026 14:42:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdkfd: wait for a GPU reset before freeing a BO
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Kent.Russell@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20261016153236.1163913-1-William.Palacek@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261016153236.1163913-1-William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0491.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::28) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|PH6PR12MB366721:EE_
X-MS-Office365-Filtering-Correlation-Id: e0788fb9-0b53-4499-339b-08df2bb5387b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|10067099003|260925021311599003|260925021911599003|260925022911599003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: UYBQcaAp/Dtd71SBOpHyzGs96Xn9gyJUAQ4z7/yKApA9Apx1urXVp0EtqifhVcFW5oDD4bDplpzPGqrL9xBaOxnIb2PRQnBX2MB984IMI0bLpvhX9734+Zya5NUHvyZLzzraAg3p9IF4Q9w/tgwjYeInviC1L9Za4v0Ijge+smFZRDHxxQec/zjNcNwhtjIs7j31M8XGkn+nqIxc/Ci/Pomd/w6ep/sRFCDJ4NgW9Z8YOTix+anIL3oCoIcA41KYfG1xh0wPnJWhI5UedHYgerbzwrxbmKUys9hVFTaftnGfum1voPTcVhtJWPgIwGEJrTDS6K3iBuZifZf2wuyMf42lFxJSdsc30lJmeU35HygNWSvKEjUqi0uCcE6AM0HlGHv6vlppcbcnRq80A4obTjWyzkJ6Demye5bTxTuELO9xxZ/1PthC4jUSeflnD3oCcTeHMCb76bMG+b0m7s7QNCA8rCgQvG6Ddi/0Trx+YHnbGmRjoDmFuqgkYNkSuCd29aCoxKE1AmkN9sPM0HWwW+zNmWS72RiNzBVR2qzK+LGHintIlnHJn3cJei7KfMGXBTgDFGrFGdAKv4gQFR4N4sLVs/jXXgPZpFuEGsdecTmug0dFylCRgRfhxhxcZGr+yLq8NxfvGyixGIL0XJ2sidIKMhBIsFAho8LRb00fFJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003)(5023799004)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVM0OUhrL1JGSFYrNGgrbzF1cVJhamgzYWFGWWhZMlEwMG9GcUhkZ1Z0bzlo?=
 =?utf-8?B?QlNJVStuZEZZeTdNUFBMdlpVNkM5V0ZLdGFiUWNoelRmZlpFNGVSR0xkNlRJ?=
 =?utf-8?B?a00yRlBNTTJxUHcxdEtyY25iRDEzMWtsRzVRQytYcXhlR2w0d2UvWFFRRWUz?=
 =?utf-8?B?SHUvS0R5Ti9WQlhZQllPOFMwQ09ySVpOU1ZSaEZvV0ZJVGhEdXdleVR1bWhR?=
 =?utf-8?B?VFVkYTJzOGZqNHJpUUg0NlJIR25RaVZFR1lUSVFHbE9ZU25YWGJGWkY1MXRK?=
 =?utf-8?B?MU9YbnpNM2Z5VU5BTURTOFFGcEhHak43T2ROS2Y0QW5qQzZFZXZzdGFDRXVX?=
 =?utf-8?B?Nk14VTJsSC9qSHhuQ2hqUmxzZk9SVWZhZ0FhMTRlUmhQSHBPOXRqVFkzSTFP?=
 =?utf-8?B?TDJER2YvOGkrV1FGNVRQcjJkQXJaMEI1a25TdjNQY1pqdjZTM2NMTTdkVEJ5?=
 =?utf-8?B?RnpiNDlFR3ByblBZbzlOWUh2a0ZYWS9wNjF6ME5seXVjbGtNRmQzaDRtYVEw?=
 =?utf-8?B?cTVuTzhhUUpzUUR4TWtrNklMRVUya3lPL0QwbE5ucm40ckhwVHo2VFNhdkpJ?=
 =?utf-8?B?cWtnY2xaZGdzcGtIeTFoNHp1RStucGlKRUU4UEZQVW9TYWdyTDNQNmY4dmNj?=
 =?utf-8?B?NEc3eDdCUVpJT2oxVEZIbHZnQ3pHNkFjeVBSYWVCOW5iSXQ4VzRqTzAwcXJk?=
 =?utf-8?B?NHZkeXViYWswSVJMaTQ4bW50akgxNDA0Sllrc1VubHhWUmI5NTJHVnZqVmJj?=
 =?utf-8?B?KzVHbTdVOU9VZmFQZ1NzNjErZlB6ZlNpUS9YbkNDbWUxNkw2SXRuTkQ3RFJ0?=
 =?utf-8?B?emtkSi95MkQyUzg2Nk9sKyszV0JHV0kxRHZZdkRnSnpoVVJwM2hxcVRZaStx?=
 =?utf-8?B?VDRjWlFCNzQrSUI0a0FFQUtoSkdPZlFyc3R2SDdiSXlhM2VTa3N3UGF2M29j?=
 =?utf-8?B?alpiRmRkWnRmUFVvWlNXN3dWdUU5dnhWMFdhVUxrbHovTTErc09oUnFud0pv?=
 =?utf-8?B?UkF5OGFuc0FkTmIxbFlJYit1TERwMnNVSHpSWlJUbTBsZmpvMjRGR3hQK1Zi?=
 =?utf-8?B?b3FReEZGUHhlVWs1dDZqTWpHVWFPNEY5c2F3RU5MaE42TXg0SVhvNitqKzY4?=
 =?utf-8?B?SURSdmJrV28vVlBEOFZMODVGL1JnanV2c2RiNXdGUmZvVkJFeE03QWNBM1Bz?=
 =?utf-8?B?Tzl0SUdCdERsa1ZXTjIwUzM0VmdIZEdzdWYzREQ5eWUwOTJzdDZNSklNa1la?=
 =?utf-8?B?Z3IxRHJBaDB6MHZXQzhSbjhyZGQ3eS83UlBVOTBBWTR5d1h6c0VpS25zQlk4?=
 =?utf-8?B?T1Vic1Q2MDJwMWV3djJBV29vd1FtNytjZ1RHaXk1dEgvZlRROVBiRTFsQW5C?=
 =?utf-8?B?YVZnM2ZJWk9ic0dBdGM2emdvZzJnTUthbS9JQUpTSDFjRDlxOUFjOXp3aVB6?=
 =?utf-8?B?Tm53RURDd0JnRjN4QmdhVDBsTXFyd3dZd0diZTlkK0lBUWZVTUFFUkxDN1lN?=
 =?utf-8?B?ZW5qK3Q0aWFEQTJhYk9GMmhnTitocTFLakpDYnkzYUNQa2hsb3haWG1DTkFz?=
 =?utf-8?B?Y0UwQnpzby9ucWVtRHF5eUhFK2lFcytnYWluM0t6UHcvY1NhSkFwSENoeDk1?=
 =?utf-8?B?TEFucGtNRDRrVlRORWFkWDdpUGZWRDZXVFdPQVJDQnp3clkvMXpQQzZHYWN0?=
 =?utf-8?B?bkRZUk13eWt0YmtqTHpHN09NTjJidVZ6TG1sWStMajhCQWFSUDRUV3NXMm1u?=
 =?utf-8?B?SXE5cEpDbkNlQnV5dkdCUjJnTmtOeGZINGR3dnVYQlFnMXBxUVkybUZJcm5Y?=
 =?utf-8?B?MitlVEVaMkdtR2JrVTJTMlE0VkFtRmhoemdNR0VkY1ZmcTlrVjhDWEp3QzN6?=
 =?utf-8?B?YmZwUEN4N1dIQ2JpREZWWWswV0d3aFVsR3JMS1phT2xRWTY1WHMvOVJiUGpm?=
 =?utf-8?B?Vmo2SUxCajRlVmsvY2E4cFdPdlJRL210K1VpQmhMTm1JUUdsa2tXMEZzbDFi?=
 =?utf-8?B?SENVWFYxcExTenlBejg0bElQcW8vMGd2djFLZE53bGRIWHdZa0U5TFNjNlVD?=
 =?utf-8?B?V29jdnlBOXF3SHUzUVRkZ2xORmZpbXZjNm0ySFR0L3BOcit5ZGtWSDNocE9j?=
 =?utf-8?B?RGYrYTdyMW5ZeTRRV3EwWXBUandWZHMvdTJ5dEtwSzBzWGpoZ3lrRXZyQ205?=
 =?utf-8?B?NUV0RHN0K1dhNlhNYllFbG5uUkdYN1p2ZXpGMHl3RkovR1p2SEVYQTlWVDNM?=
 =?utf-8?B?RWIzeTRDWXVSczh6cnFwNGI1R1pTZ3lrRUpSVTVYWU5jTEpSQUtqSGFpZEo2?=
 =?utf-8?B?bllNVytGeXlXUUk2UUhUY3loZHNSWVIzTUw5amxvbStJNFZrQ1FHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0788fb9-0b53-4499-339b-08df2bb5387b
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 18:42:25.0157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIqsn3Vs8pwqbqp4883Ybn7Ocb4sx4wn7Kd0jm33tzI5dLGLIwIoHMw310wJl+HvtG0UyjrNkmyoel8YLj/btA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB366721
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

On 2026-10-16 11:32, William Palacek wrote:
> When a GPU reset takes the reset domain, KFD eviction cannot unmap
> user queues: execute_queues_cpsch() fails its trylock with -EIO, so
> the queues keep running until the ASIC is reset. The TLB flush is also
> skipped while the reset is in progress. If the process unmaps and frees
> a BO in that window, its pages are released while a queue can still
> access them through stale translations.
>
> On MI300X, munmap() then crashes in free_swap_cache() on a small bogus
> page pointer in its mmu_gather batch page:
>
>    BUG: unable to handle page fault for address: 0000000000002900
>    RIP: 0010:free_swap_cache+0x5/0xb0
>    Call Trace:
>     free_pages_and_swap_cache+0x3a/0x60
>     tlb_batch_pages_flush+0x43/0x80
>     tlb_flush_mmu+0x3d/0x110
>     zap_pte_range+0x80d/0xcd0
>     ...
>     do_vmi_align_munmap+0x3e8/0x5b0
>     do_vmi_munmap+0xdf/0x190
>     __vm_munmap+0xad/0x180
>     __x64_sys_munmap+0x1b/0x30
>
> In a traced crash the bogus pointer was the read pointer value of an SDMA
> queue the process had just destroyed, at the read pointer's page offset:
> the queue's writeback landed in its freed rptr page after the page was
> reused as the batch page.
>
> commit f0b4440cdc18 ("drm/amdkfd: Fix mode1 reset crash issue") fixed
> this race on process exit by waiting for the reset to complete before
> freeing the process's BOs. Free through the ioctl has the same race.
> Wait for the reset there too, using the same helper.
>
> Fixes: 9c33e5fd4fb6 ("drm/amdgpu: fix locking scope when flushing tlb")
> Signed-off-by: William Palacek <William.Palacek@amd.com>

As an immediate fix for this issue, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

@Christian, I raised the question, whether a more general fix is needed 
for freeing memory while a GPU reset is in progress. Generally the GPU 
is in an unknown state and some queues may still be running and 
accessing memory. Meanwhile all fences get force-signaled (as I 
understand it, I didn't check where this happens in the sequence). I 
suspect this could affect applications using the render node API as 
well. Do we need a way to delay freeing of TTM BOs during resets 
somewhere in the amdgpu_ttm or amdgpu_object code?

Somewhat related, do we need to make MMU notifiers wait during GPU 
resets to prevent releasing of system memory pages while the GPU is in 
an unknown state?

Regards,
   Felix


> ---
> Christian, Felix suggested asking you about a lower-level fix. In the
> traces, the TLB flushes during the reset returned right away without
> flushing, because amdgpu_gmc_flush_gpu_tlb_pasid_xccs() returns 0 when
> it can't take the reset domain lock. So callers free memory the queue
> can still access until the ASIC reset. The SVM munmap path goes through
> the same flush. Felix thought a more general solution may be in
> amdgpu_object.c or amdgpu_ttm.c. amdgpu_bo_release_notify() already adds
> the wipe-on-release fence so TTM delays freeing the BO. Could a fence
> that signals when the reset completes hold the pages the same way, or is
> there a better place?
>
> v5: new approach, replaces "drm/amdkfd: discard interrupts during a GPU
>      reset" (v4) and "drm/amdgpu: preempt KFD queues before taking the
>      reset domain lock" (v1-v3)
>      - v4 did not address the munmap Oops (Felix). Fix the cause instead:
>        BOs freed during a reset while user queues still access them
>      - Reuse kfd_process_wait_gpu_reset_complete() from commit
>        f0b4440cdc18 in the free-memory ioctl; no queue unmap, nothing sent
>        to the GPU during the reset (Christian)
>      - Drop the interrupt discard from v4
>
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
>   3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b3ebbee76088..0953d823c345 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1305,6 +1305,9 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>   		goto err_unlock;
>   	}
>   
> +	/* Queues a reset could not stop may still access the buffer */
> +	kfd_process_wait_gpu_reset_complete(p);
> +
>   	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev,
>   				(struct kgd_mem *)mem, pdd->drm_priv, &size);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 7a365fca68e4..25f57dd59bfd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1126,6 +1126,7 @@ void kfd_unref_process(struct kfd_process *p);
>   int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
>   int kfd_process_restore_queues(struct kfd_process *p);
>   void kfd_suspend_all_processes(void);
> +void kfd_process_wait_gpu_reset_complete(struct kfd_process *p);
>   int kfd_resume_all_processes(void);
>   
>   struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index e742ef206abd..7750741444ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1291,7 +1291,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   /*
>    * If any GPU is ongoing reset, wait for reset complete.
>    */
> -static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
> +void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
>   {
>   	int i;
>   
