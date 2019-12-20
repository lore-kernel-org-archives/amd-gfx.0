Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C814FC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 23:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790A12082E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 23:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k7f84osP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790A12082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C236ECD2;
	Fri, 20 Dec 2019 23:28:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513A16ECD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 23:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv3hIofZmLZTufFXHa7PUROE0rfQ0tvzswodJqS60fDSJveNeAcTq4z7Db19EepqDoeX+dzgb6aO2aZJLvnhsIN5bc6NkGDc9wbHjl/zKQO53iWWu96f14XVhS7vkbpLVe6D7CefaEhy0cVY7dZ7Sn8nFcuSmyx1cevyt3qOHEtlTfr4F2JJwSyTyvkDDfYsHovknxMVuGMjOKtWIJcIxP1Icjw88r8Onpn2trUuxCtHoFftIBQo9rlagfU5RSjwoCop8gFLEvKqJ/dB3PLqNgoBz39U0YSV/p2aCdpUAlgunhKsRCku3Lqsz1J+PmLhVX+PoZTsFDOVFkqxIuQasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNdf7AZVFyhrwcBuCwjbAx+3ItTNzyZVuHl/tcnbMiQ=;
 b=JsmKbFwKC+qZePsRFuC7n/M17FWAVIcwhqfIj/yecVleIfseNu6kMNtbAVwn/wNx7H/kKSIJaDksr8wMRfwZ7qkdO98JoTCd2d4rrVZ1tfPUJFq3uRoSD1Xw6GrvJtUAxD7dL2hcxzObC93y0NElDdXLqWmwERdqcHk4knTJkh4ee7PciB6UZstsB8FkCbwz7omZNpPYlcAfgKAKOBajtv8L8BfBE7FpdEvS8qpkuympbdOUsGzPJx6Nticn+OcOu0Q0FXpHatt/Vc8ZU6pr0o0UZpzm+v6nUvzndVDRGddWtcoFMRRFib7YOgZW6+EsdsA78tx3PAV6gtKe076w9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNdf7AZVFyhrwcBuCwjbAx+3ItTNzyZVuHl/tcnbMiQ=;
 b=k7f84osPDhrp4zdXcngs7a1PTdzHG1ck7NXxVp4S6g23LCzi2NUb/vT2jeVFEdWtRv0F9qtJbz4VCGbxzRZSLWfUZcPDqT1h2N8kve5RYjyjTRnJ5bB84LxUPICwWaC6woDKgYWkCIJOwENYirV7AOArlmulm2POYcRSukh98nU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0009.namprd12.prod.outlook.com (10.172.85.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 20 Dec 2019 23:28:22 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2538.019; Fri, 20 Dec 2019
 23:28:21 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: Avoid reclaim fs while eviction lock
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191220062442.33635-1-alex.sierra@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <0b53340d-8941-6a30-f3a6-19557a3b07e7@amd.com>
Date: Fri, 20 Dec 2019 18:28:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191220062442.33635-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::29)
 To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75603c6e-dc67-4c4a-2b3c-08d785a44d2c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:|DM5PR1201MB0009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00098C044A1DFAAF05B03B86F02D0@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:188;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(189003)(199004)(2616005)(2906002)(26005)(8936002)(66556008)(81156014)(8676002)(6486002)(316002)(66946007)(81166006)(36756003)(66476007)(44832011)(4001150100001)(478600001)(31686004)(53546011)(6506007)(6512007)(52116002)(186003)(5660300002)(31696002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0009;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFtod7pmIXLHjOq6i7lNqMh+iFleHjeNW0DA0HBDDGu1ZOyc8RbPetvKLTiDaffSd/7F3wmRKi0ffn1utfsnzz1V/kGj3V1xC77GE6pCZ5atsWRSKUKw8II41n+WcPQ8XdAhfmuO/xXfpGVIZsNqK/MOE4JYyEgqLLon5vNasAcVBGbNP66q/D5mCnlM4shhV8ig6h4ldJIZzHjQADD/hgnftAfI1nGC9SMKaIN9QBdRJC3boiJNDaYLklTEEydB921QPK6ZHcw7AGQ6dGGAhELf6NEz1Uz/vwbB5D1ZkAiX1akmBwuCmJWTWMCgTCJORHMaM441gGrBzpMJRmmjz6Lt9q7Xhy2o8fLS1UUjn1DxwAO4+Y2xCvNi2rTHpZbvbN2zQ+7o4in9ynxSplP2MujLjuAkL7H4rbcGCMaw0pdFkMjYRPGKjuiw96e3ZH58
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75603c6e-dc67-4c4a-2b3c-08d785a44d2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 23:28:21.6533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvD1Dwlc3BCSHRFymd73r14YEqV5utf7qt9D6JG/9tFZWkVlKhGqlM5OUDVz9wX6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

One style comment inline.

Yong

On 2019-12-20 1:24 a.m., Alex Sierra wrote:
> [Why]
> Avoid reclaim filesystem while eviction lock is held called from
> MMU notifier.
>
> [How]
> Setting PF_MEMALLOC_NOFS flags while eviction mutex is locked.
> Using memalloc_nofs_save / memalloc_nofs_restore API.
>
> Change-Id: I5531c9337836e7d4a430df3f16dcc82888e8018c
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 28 +++++++++++++++++++++++++-
>   2 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b999b67ff57a..b36daa6230fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -678,9 +678,9 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		}
>   	}
>   
> -	mutex_lock(&vm->eviction_lock);
> +	vm_eviction_lock(vm);
>   	vm->evicting = false;
> -	mutex_unlock(&vm->eviction_lock);
> +	vm_eviction_unlock(vm);
>   
>   	return 0;
>   }
> @@ -1559,7 +1559,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	if (!(flags & AMDGPU_PTE_VALID))
>   		owner = AMDGPU_FENCE_OWNER_KFD;
>   
> -	mutex_lock(&vm->eviction_lock);
> +	vm_eviction_lock(vm);
>   	if (vm->evicting) {
>   		r = -EBUSY;
>   		goto error_unlock;
> @@ -1576,7 +1576,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	r = vm->update_funcs->commit(&params, fence);
>   
>   error_unlock:
> -	mutex_unlock(&vm->eviction_lock);
> +	vm_eviction_unlock(vm);
>   	return r;
>   }
>   
> @@ -2537,18 +2537,18 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>   		return false;
>   
>   	/* Try to block ongoing updates */
> -	if (!mutex_trylock(&bo_base->vm->eviction_lock))
> +	if (!vm_eviction_trylock(bo_base->vm))
>   		return false;
>   
>   	/* Don't evict VM page tables while they are updated */
>   	if (!dma_fence_is_signaled(bo_base->vm->last_direct) ||
>   	    !dma_fence_is_signaled(bo_base->vm->last_delayed)) {
> -		mutex_unlock(&bo_base->vm->eviction_lock);
> +		vm_eviction_unlock(bo_base->vm);
>   		return false;
>   	}
>   
>   	bo_base->vm->evicting = true;
> -	mutex_unlock(&bo_base->vm->eviction_lock);
> +	vm_eviction_unlock(bo_base->vm);
>   	return true;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 100547f094ff..d35aa76469ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -30,6 +30,7 @@
>   #include <drm/gpu_scheduler.h>
>   #include <drm/drm_file.h>
>   #include <drm/ttm/ttm_bo_driver.h>
> +#include <linux/sched/mm.h>
>   
>   #include "amdgpu_sync.h"
>   #include "amdgpu_ring.h"
> @@ -242,9 +243,12 @@ struct amdgpu_vm {
>   	/* tree of virtual addresses mapped */
>   	struct rb_root_cached	va;
>   
> -	/* Lock to prevent eviction while we are updating page tables */
> +	/* Lock to prevent eviction while we are updating page tables
> +	 * use vm_eviction_lock/unlock(vm)
> +	 */
>   	struct mutex		eviction_lock;
>   	bool			evicting;
> +	unsigned int            saved_flags;
[yz] The tabs should be used here instead of spaces.
>   
>   	/* BOs who needs a validation */
>   	struct list_head	evicted;
> @@ -436,4 +440,26 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
>   
> +/* vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
> + * happens while holding this lock anywhere to prevent deadlocks when
> + * an MMU notifier runs in reclaim-FS context.
> + */
> +static inline void vm_eviction_lock(struct amdgpu_vm *vm)
> +{
> +	mutex_lock(&vm->eviction_lock);
> +	vm->saved_flags = memalloc_nofs_save();
> +}
> +static inline int vm_eviction_trylock(struct amdgpu_vm *vm)
> +{
> +	if (mutex_trylock(&vm->eviction_lock)) {
> +		vm->saved_flags = memalloc_nofs_save();
> +		return 1;
> +	}
> +	return 0;
> +}
> +static inline void vm_eviction_unlock(struct amdgpu_vm *vm)
> +{
> +	memalloc_nofs_restore(vm->saved_flags);
> +	mutex_unlock(&vm->eviction_lock);
> +}
>   #endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
