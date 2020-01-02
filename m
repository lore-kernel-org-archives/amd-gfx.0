Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F4CC2D0DC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 21:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A51D20863
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 21:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uPkP1QyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A51D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC796E0AD;
	Thu,  2 Jan 2020 21:42:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469C96E0AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 21:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETSwIatUXwj5He/iUYjZFJ1F8T+AMpvK7gWns2X+8Ae3on2MBYITF7Otw2C3dywVbdRPhue6Dqg1uD0cbd+yMBxtoWh1OLqERp0but1wHTlkojbOVdubl66XkGUxq+G6fupYsvupGEIC6f0f4NuVUHGDhS9fzkLlbhmouMYOlAJZIg8uidqcX4msna1SXUreYfmFSFsHTNa9lD7lIbWl6xeyGKD5EG4ZqXFzdbSShQrc5zBke+Lu2AarHOgSb0u/roDyF1RspfBeh0ycHFMI5cX0eknrTfOfOuUhoAHfCu+rxawqcmMtWCPSRbbqgpuc7MhTNy4VdowELpyYg+UwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5bp2F7i6LpsJmbDCv+lLSV6wANgfId03NnCVzomWPM=;
 b=JEMkZ3AnY9S1rhRAr/BrnMR9qw555h6QUyav8u/gix6eBvzKKg2MLAmt3TxtN/I9up8bl41Mhp4TR2PRg/AYdOfbxhKGpLS0QLFdcqYA6bKVYjwAx0uMR8YzlFWW6sJG6d6Mv4hFvYdc/HULmsd51uad0ToGFFNUrZ3PFH1LjUWlImPZUsMuKCcEoRpz1bFCxTcZPXMqPAmbOwFcrOIzUeOMLjLoe6dAL0sfi7VCxegwfto+C+5aOxgKbscKrN8H6mHVruP9Yl2tUqVgiucgIoIURy7BwyM9vg9SWgwvkDdeuqstl5rUZ6o4ICBko1EgdAHbhFeLBCu5FBWwQKUPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5bp2F7i6LpsJmbDCv+lLSV6wANgfId03NnCVzomWPM=;
 b=uPkP1QyQQ+3rKCs0b/iw7eclGaFJmnQYs4Hy0RuzX+xg7rtGoDPAs7HfIL3q8S9Zbc+0ySTfydvjdVgTIE/jMCzVzKAI19cEtICP9awqE6m3V2f5AMf42gMxKDyN8xASpQUr7bznQM+aw7PF2E3c3h5X9XHZeYaVD3292Sf6AC0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0169.namprd12.prod.outlook.com (10.174.106.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Thu, 2 Jan 2020 21:42:00 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2581.014; Thu, 2 Jan 2020
 21:42:00 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: Avoid reclaim fs while eviction lock
To: amd-gfx@lists.freedesktop.org
References: <20200102211147.26566-1-alex.sierra@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <31aebe62-0229-0b22-095f-2b68895a1d3b@amd.com>
Date: Thu, 2 Jan 2020 16:41:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200102211147.26566-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::22) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
Received: from [172.27.227.155] (165.204.55.251) by
 YTOPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend
 Transport; Thu, 2 Jan 2020 21:42:00 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4051d527-154d-4b02-9271-08d78fcc9966
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0169:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0169244CB87D8CB752D17C88F0200@DM5PR1201MB0169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-Forefront-PRVS: 0270ED2845
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(186003)(31686004)(52116002)(2616005)(36756003)(16526019)(6916009)(44832011)(6486002)(5660300002)(53546011)(956004)(26005)(316002)(16576012)(8676002)(478600001)(81156014)(81166006)(66946007)(2906002)(66556008)(86362001)(66476007)(8936002)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0169;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hnZxlvhlCX/dl/o5kRR/FEsMvAM6A9DCBPPo5f0pxUZwinhDf1Lipuixs0aXCzBsM6WDiqN0EsF1Tk2ZKv7delyiG6iQ70YfZsgwFax7pH3w3MNK65XbzzKRTrg0boc353jVRTaau/P7qQGvRkkwhcoRMoQxirrlLaF/7Af2Es4J+JFIp8iWiRRBnCM2aYqS91ZkotYhCXcijpWSr6/SjOPG44QtFzw8IHxhWW4kz2D5F1tIxxuh5Osr+kMSuBzOnqM95q4y44w2hf49Kg7nAAFbluNX2Ilbjnttwn7rsIVtpxvYUd5oBBI6YPYBQBwwtzRLnCaarx4y8i7Z1xq83n/6dOFaPMecxxLHwZdfKjUAab607m3Etu6RiowqXowqHZbm3B3EgqvuATxddsKnPjCFTe2U30+EUBPVCiQmQnFUaV47xxBDeMEHNJ9v2nI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4051d527-154d-4b02-9271-08d78fcc9966
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2020 21:42:00.8300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSheuTjWQVqXZSkyU0c5tItk37xgNXpSjd25BqAjXe0iIjqvrX9OF1MpkyPz+QvV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
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

One comment inline.

On 2020-01-02 4:11 p.m., Alex Sierra wrote:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 40 +++++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  6 +++-
>   2 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b999b67ff57a..d6aba4f9df74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -82,6 +82,32 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>   
> +/**
> + * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
> + * happens while holding this lock anywhere to prevent deadlocks when
> + * an MMU notifier runs in reclaim-FS context.
> + */
> +static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> +{
> +	mutex_lock(&vm->eviction_lock);
> +	vm->saved_flags = memalloc_nofs_save();
[yz] I feel memalloc_nofs_save() should be called before mutex_lock(). 
Not too sure though.
> +}
> +
> +static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
> +{
> +	if (mutex_trylock(&vm->eviction_lock)) {
> +		vm->saved_flags = memalloc_nofs_save();
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> +{
> +	memalloc_nofs_restore(vm->saved_flags);
> +	mutex_unlock(&vm->eviction_lock);
> +}
> +
>   /**
>    * amdgpu_vm_level_shift - return the addr shift for each level
>    *
> @@ -678,9 +704,9 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		}
>   	}
>   
> -	mutex_lock(&vm->eviction_lock);
> +	amdgpu_vm_eviction_lock(vm);
>   	vm->evicting = false;
> -	mutex_unlock(&vm->eviction_lock);
> +	amdgpu_vm_eviction_unlock(vm);
>   
>   	return 0;
>   }
> @@ -1559,7 +1585,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	if (!(flags & AMDGPU_PTE_VALID))
>   		owner = AMDGPU_FENCE_OWNER_KFD;
>   
> -	mutex_lock(&vm->eviction_lock);
> +	amdgpu_vm_eviction_lock(vm);
>   	if (vm->evicting) {
>   		r = -EBUSY;
>   		goto error_unlock;
> @@ -1576,7 +1602,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	r = vm->update_funcs->commit(&params, fence);
>   
>   error_unlock:
> -	mutex_unlock(&vm->eviction_lock);
> +	amdgpu_vm_eviction_unlock(vm);
>   	return r;
>   }
>   
> @@ -2537,18 +2563,18 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>   		return false;
>   
>   	/* Try to block ongoing updates */
> -	if (!mutex_trylock(&bo_base->vm->eviction_lock))
> +	if (!amdgpu_vm_eviction_trylock(bo_base->vm))
>   		return false;
>   
>   	/* Don't evict VM page tables while they are updated */
>   	if (!dma_fence_is_signaled(bo_base->vm->last_direct) ||
>   	    !dma_fence_is_signaled(bo_base->vm->last_delayed)) {
> -		mutex_unlock(&bo_base->vm->eviction_lock);
> +		amdgpu_vm_eviction_unlock(bo_base->vm);
>   		return false;
>   	}
>   
>   	bo_base->vm->evicting = true;
> -	mutex_unlock(&bo_base->vm->eviction_lock);
> +	amdgpu_vm_eviction_unlock(bo_base->vm);
>   	return true;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 100547f094ff..c21a36bebc0c 100644
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
> +	unsigned int		saved_flags;
>   
>   	/* BOs who needs a validation */
>   	struct list_head	evicted;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
