Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86CFC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E1A20866
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QvGvI0jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E1A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7B26ECAD;
	Fri, 20 Dec 2019 21:39:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3306ECAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 21:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbzRffvKnAg7rOvxF3Kq+mXSsXR+i9metO9zHsLId2MDwKFnsoppXZ8g0px051Gwoi7mM9pPxH7IL949sh5mtH53mYZHHptCPgxxeLlgPGhuaUcViqGe7/y0/Hggquifc7nQKIJufl+ECkFVj8Sn/ViqPPItuuLSoYkHoTCyQxmlim0PYtw7RtFmdioTZkPpgiWP79vbIl9vHDKY3Kv1Le8aLVc5RUzv6XNjk6zeskR8lp6lbhwKwzPxHfRrl1SqFyHS9kFE4XYT0dGfSS+yCM2/Z9U5PBCSSMSQ33uDv4QAPCDi3aknVCbmb+XTxXo6lU52hJGaN0SqC5hEHLRK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM9BxDgVkrZwOvEzjmnKETPTsJ9dQXzwbebOfYJIreA=;
 b=iXw1a2Rubk+DfpfBtCIsO6hpZaM44StOx0GUsZW5EegMJwMz/E/QCh4oN+0qzhypw346l+bLQFKwyUglX5p1VaOPbV4nDWyRKYZoQx7QKES3paN49A+WSWq1L7LS0ls/lplnbOSWU2+T73rxFu/WmwHxtNOa2SrO4pOavW/ylKwcYmQVm5CE2gyFx12JrpPhWnXvlaCiuybBbaLAb8cIvrRnqlzScaQCuiL5oRMJnSsovNgFlm7K1ql4UIYCNSP/h/yE05q73hEKRsKF5h1nvFZhFm3AjFEyAAHH129rwWNfvr6/2+W7hkORG2bBOHntBUTFYz/9+3otujFFx7wsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM9BxDgVkrZwOvEzjmnKETPTsJ9dQXzwbebOfYJIreA=;
 b=QvGvI0jcEcqL86UDT39NoQ7EXNFydjzFp3YPFuovCdqXL2P8hFdsnf0bzKrglFAXEQXXLCIboPwPp95vP8ymzvmdyWG+BGxF0ubY0quG8Qsa7fKl5KFqvzfaKN+oiVIMeznCoRdphqvs2ZM+iLr7UGev9O8qflTmAQ4GVnot7PE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3134.namprd12.prod.outlook.com (20.178.241.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 21:39:19 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 21:39:19 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: Avoid reclaim fs while eviction lock
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191220062442.33635-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1cb9643b-140d-2d20-5c79-5562001e59cc@amd.com>
Date: Fri, 20 Dec 2019 16:39:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191220062442.33635-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::29) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 21:39:18 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 957777bc-32d4-4dcb-a4a2-08d785951197
X-MS-TrafficTypeDiagnostic: MN2PR12MB3134:|MN2PR12MB3134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31348D0C2AD8C36202BA3070922D0@MN2PR12MB3134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(31696002)(5660300002)(66946007)(478600001)(81156014)(81166006)(44832011)(86362001)(36756003)(31686004)(186003)(6486002)(4001150100001)(16526019)(66476007)(8936002)(8676002)(2906002)(316002)(956004)(52116002)(53546011)(66556008)(16576012)(26005)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3134;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ivxdOj7kLK66625kpK5GIV6lmsL515f7IY0BJO3muTzbz8Wy1COhaD4EQIH+RcxLW8ZzSbslu7bdRJM0ASpRc1KiuBn9tyRa8OkjO/tATQ71b9XNxwJxTdpef5O4QLNhSnisDnZ3YsmGYKO0GLzZ0kjWDhixK3aWgc+s3PzvEJ4LCiaHSjP6aOC/oTF6gK1fZVwiL416EiUZHqSgX7hXtr8veiW1XaEfKbm7NpnEN5WLTz7yRFOsOPLZgS67TcAQiTcDdxMGWo79joU71IAkh/s2EtlV3j2LrCPXGrm2tHgdtmqvIOzJgFWSXSJhzB45kjVb6En4AeLZFxpQqVXRNJ21NCsE5E+LRz62TrwZQjAvuGA6FSyXf5ZP8otJHOguCJBur9CmX5rmQuv1rnQVK5oZ0vDMq2Hr6MIa1F5TEwd3jyaokrcLYLoXhCTUxWp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957777bc-32d4-4dcb-a4a2-08d785951197
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 21:39:18.9355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkwIwsD7jbAswz+cALJJfC/LCyC0I6zeY7cfj6yt5BDmC+uX6f7BCllHpmAowb0IT7XowBn6VbmMf1vwWcyn7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3134
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

On 2019-12-20 1:24, Alex Sierra wrote:
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
This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

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
