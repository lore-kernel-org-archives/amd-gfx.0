Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69152C04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 13:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D88121741
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 13:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JyJsysKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D88121741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E01896EAC5;
	Fri,  7 Feb 2020 13:46:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8002D6EAC5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 13:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo4yF+88DqHddyJyMZKBy/P+RnnAaAAKIjIsfDJyp6Shk5tvAXAKGJTotTdw61OvZnRGJwPxwY8kZMknk1QSvwBULR51cOzo5v4UZufnNx/+uD52lzT2dbJ2zGO5rycWLhHPw52QMBp6vi1jcrUAEeaS5D0L1NFh1RmZnAzBrWdus73gGwibyA+2Sp6yLHP7sZNq7iz/sp3KQSrZIfbsFRDyKbier8g2/RGE30AYOG+vSv+iwf+mms5cNzUcxkNoHKeEc239fLI7uFQqKgwiERfRMHm5hsNxQL6ZTqZekDb9ZYPr9+L92QXJlowGG0cYS9ZbsLzm2s5GSBUDFTrl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1duYz9ip7jKUf3oKSBM1+qZmKfgjPe9tohmVaN3dpqE=;
 b=W3I/Etz6zXjQmN2R7s0mvnctvGLkIgdp252RvkfVtaSgd3z10Yfph+cMPS7vF3otrh5KLvunGilt4KJlUME8+7VTvwZkw8tuaXaLz3k+CCARc0TZNZC3sAK13ofAGR1Q7a632+qUDviiftOcnh1Ft7fpEGpHIePy4lzt0B6F/yJgQs2pNJm47CwEAZZSVN0wUD4WUN3tz7sZ9HOT6ftUWo1Xe3YfDYk88dIVc1LhoYGLlD/IhmnLYJftLc4xuo2C5cfOKE1hr6Hx9fT53Uh4djiNeSifFsPn9PqLSKO3FIaKuyuoGFL99qLNwJtLRDctJrFO5vm+vaHp/XfX+eZBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1duYz9ip7jKUf3oKSBM1+qZmKfgjPe9tohmVaN3dpqE=;
 b=JyJsysKV7Wy3rVBX1O7lS5Y3bZzhgzDM5FOx2sXrCYNpNVmJLchZao/iq6f5roZhWr7g6iv8zc01QRdpAcyCV8MkGjaIcyofM9zlnjW8weEaSfQdUtBqovaBIYe+kD3w0I9++VIQGzlWdxG9/nKMFn8z4jqfnZ79AUijrlR5YLQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1275.namprd12.prod.outlook.com (10.168.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 13:46:11 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 13:46:10 +0000
Subject: Re: [RFC PATCH v2] drm/amdgpu: Remove kfd eviction fence before
 release bo
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <SN6PR12MB2800576A6BF1C9C25C4ABA12871C0@SN6PR12MB2800.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a8c021fc-ee48-9af9-88ad-e1cd8b162efd@amd.com>
Date: Fri, 7 Feb 2020 14:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <SN6PR12MB2800576A6BF1C9C25C4ABA12871C0@SN6PR12MB2800.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 13:46:09 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da1c2613-0ac2-43b0-8eb9-08d7abd416fa
X-MS-TrafficTypeDiagnostic: DM5PR12MB1275:|DM5PR12MB1275:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB127561A3EFD4C8AB5FA3B5E8831C0@DM5PR12MB1275.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(199004)(189003)(86362001)(31696002)(2906002)(52116002)(316002)(8676002)(16526019)(186003)(81156014)(81166006)(6486002)(110136005)(66946007)(8936002)(66476007)(66556008)(54906003)(2616005)(36756003)(4326008)(31686004)(478600001)(6666004)(5660300002)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1275;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dS0HmOhmecifYCumrjXpaOhD1qE0lOPpjJ4CCOZYCfL+synDCIpLZGz8fGwd3EqRCx3g5btMJyhvSbr+rTGPdCSQfTXpMZqwbkBRFmpc5KZiIkLpJvvzktxgziZ51lGl54KJzR/Lqy23eJec1WgUmTJ3ZvfleSOTVCsJTqUDmSLHx7Bx3qC5CsOdBgK/mWdr8JSjy0poEQ5LC4CV9OOFeI1ar3JieOnzfhzRUtiXAn0iq6TD0v2lqNscDYmVkVFmS11jMJVCYcdLWOFGHIKBjFTVfvPvYHyNWEa1mI3XWNIhSMzM5LisE5H9VXj7kg3fbX//MUnN/gEOYYN2qvvqGfapw/+FEDNLsFXZqTTnDvPasQypSMB1Z12Z2x6HlP0Aq78zZ3TeIdXPw0cpUlMZaaXYndLj3sYbisBcuidfSQL7S1o5Y6QiVHs4YoEVUpOtBFbWLtWiPVauu7Ez/DQoPV4sLKKnHVSBl9BH1HBWNdEKdYzkbIjEWOGoOfUmzpsX
X-MS-Exchange-AntiSpam-MessageData: 9LA4e9v5uemMgYj7390c4dyu4sJ3Efhn1Q2EYpjBfvvn1rJLX5/NOtU9uvo+eUYZZrDGuGP/ZpjL+s1NiSPO+ePgQmAnUqWt/1Dy5hjk8Ze9PsZd4d+M9VbAf+JkDaS51Uw3BaGnH7Xej0osGXqO6kQbLaNuYoLg1gaUP96lR2x5Cnk0M+q63VMFpPrrh6/q9B3tf/vSXejb4RqizYuprw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1c2613-0ac2-43b0-8eb9-08d7abd416fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 13:46:10.7398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIEl6CsDnqjSl6vndg5y84ghoKJPvaFfEe2lKWn6f+U1SVACz56Nckfzx7j2xOm4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1275
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.02.20 um 14:42 schrieb Pan, Xinhui:
> No need to trigger eviction as the memory mapping will not be used anymore.
>
> All pt/pd bos share same resv, hence the same shared eviction fence. Everytime page table is freed, the fence will be signled and that cuases kfd unexcepted evictions.
>
> Signed-off-by: xinhui pab <xinhui.pan@example.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 78 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 10 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  5 +-
>   drivers/gpu/drm/ttm/ttm_bo.c                  | 38 +++++----
>   5 files changed, 111 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 47b0f2957d1f..265b1ed7264c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -96,6 +96,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
>   						       struct mm_struct *mm);
>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
>   struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
> +int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
>   
>   struct amdkfd_process_info {
>   	/* List head of all VMs that belong to a KFD process */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ef721cb65868..11315095c29b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -223,7 +223,7 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
>   static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>   					struct amdgpu_amdkfd_fence *ef)
>   {
> -	struct dma_resv *resv = bo->tbo.base.resv;
> +	struct dma_resv *resv = &bo->tbo.base._resv;

That won't work either and probably break a bunch of other cases.

Christian.

>   	struct dma_resv_list *old, *new;
>   	unsigned int i, j, k;
>   
> @@ -276,6 +276,78 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>   	return 0;
>   }
>   
> +int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_vm_bo_base        *vm_bo = bo->vm_bo;
> +	struct amdgpu_vm *vm;
> +	struct amdkfd_process_info *info;
> +	struct amdgpu_amdkfd_fence *ef;
> +	struct amdgpu_bo *parent;
> +	int locked;
> +	int ret;
> +	struct ttm_bo_global *glob = &ttm_bo_glob;
> +
> +	if (vm_bo == NULL)
> +		return 0;
> +
> +	/* Page table bo has a reference of the parent bo.
> +	 * BO itself can't guarntee the vm it points to is alive.
> +	 * for example, VM is going to free page tables, and the pt/pd bo might be
> +	 * freed by a workqueue. In that case, the vm might be freed already,
> +	 * leaving the bo->vm_bo points to vm.root.
> +	 *
> +	 * so to avoid that, when kfd free its vms,
> +	 * 1) set vm->process_info to NULL if this is the last vm.
> +	 * 2) set root_bo->vm_bo to NULL.
> +	 *
> +	 * but there are still races, just like
> +	 * cpu 1 		cpu 2
> +	 * 			!vm_bo
> +	 * ->info = NULL
> +	 * free(info)
> +	 * ->vm_bo = NULL
> +	 * free (vm)
> +	 * 			info = vm->info //invalid vm
> +	 *
> +	 * So to avoid the race, use ttm_bo_glob lru_lock.
> +	 * generally speaking, adding a new lock is accceptable.
> +	 * But reusing this lock is simple.
> +	 */
> +	parent = bo;
> +	while (parent->parent)
> +		parent = parent->parent;
> +
> +	spin_lock(&glob->lru_lock);
> +	vm_bo = parent->vm_bo;
> +	if (!vm_bo) {
> +		spin_unlock(&glob->lru_lock);
> +		return 0;
> +	}
> +
> +	vm = vm_bo->vm;
> +	if (!vm) {
> +		spin_unlock(&glob->lru_lock);
> +		return 0;
> +	}
> +
> +	info = vm->process_info;
> +	if (!info || !info->eviction_fence) {
> +		spin_unlock(&glob->lru_lock);
> +		return 0;
> +	}
> +
> +	ef = container_of(dma_fence_get(&info->eviction_fence->base),
> +			struct amdgpu_amdkfd_fence, base);
> +	spin_unlock(&glob->lru_lock);
> +
> +	locked = dma_resv_trylock(&bo->tbo.base._resv);
> +	ret = amdgpu_amdkfd_remove_eviction_fence(bo, ef);
> +	dma_fence_put(&ef->base);
> +	if (locked)
> +		dma_resv_unlock(&bo->tbo.base._resv);
> +	return ret;
> +}
> +
>   static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
>   				     bool wait)
>   {
> @@ -1030,6 +1102,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   {
>   	struct amdkfd_process_info *process_info = vm->process_info;
>   	struct amdgpu_bo *pd = vm->root.base.bo;
> +	struct ttm_bo_global *glob = &ttm_bo_glob;
>   
>   	if (!process_info)
>   		return;
> @@ -1051,6 +1124,9 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   		WARN_ON(!list_empty(&process_info->userptr_valid_list));
>   		WARN_ON(!list_empty(&process_info->userptr_inval_list));
>   
> +		spin_lock(&glob->lru_lock);
> +		vm->process_info = NULL;
> +		spin_unlock(&glob->lru_lock);
>   		dma_fence_put(&process_info->eviction_fence->base);
>   		cancel_delayed_work_sync(&process_info->restore_userptr_work);
>   		put_pid(process_info->pid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6f60a581e3ba..6ad12298fa84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1307,19 +1307,23 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   	if (abo->kfd_bo)
>   		amdgpu_amdkfd_unreserve_memory_limit(abo);
>   
> +	amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
> +	abo->vm_bo = NULL;
> +
>   	if (bo->mem.mem_type != TTM_PL_VRAM || !bo->mem.mm_node ||
>   	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
>   		return;
>   
> -	dma_resv_lock(bo->base.resv, NULL);
> +	/* Only kfd bo wipe vram on release. The resv is &_resv. */
> +	dma_resv_lock(&bo->base._resv, NULL);
>   
> -	r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, &fence);
> +	r = amdgpu_fill_buffer(abo, AMDGPU_POISON, &bo->base._resv, &fence);
>   	if (!WARN_ON(r)) {
>   		amdgpu_bo_fence(abo, fence, false);
>   		dma_fence_put(fence);
>   	}
>   
> -	dma_resv_unlock(bo->base.resv);
> +	dma_resv_unlock(&bo->base._resv);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index cc56eaba1911..2b96447e30e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -945,7 +945,6 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
>   {
>   	if (entry->base.bo) {
> -		entry->base.bo->vm_bo = NULL;
>   		list_del(&entry->base.vm_status);
>   		amdgpu_bo_unref(&entry->base.bo->shadow);
>   		amdgpu_bo_unref(&entry->base.bo);
> @@ -3074,6 +3073,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	struct amdgpu_bo_va_mapping *mapping, *tmp;
>   	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
>   	struct amdgpu_bo *root;
> +	struct ttm_bo_global *glob = &ttm_bo_glob;
>   	int i;
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
> @@ -3105,6 +3105,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	}
>   
>   	amdgpu_vm_free_pts(adev, vm, NULL);
> +	spin_lock(&glob->lru_lock);
> +	root->vm_bo = NULL;
> +	spin_unlock(&glob->lru_lock);
>   	amdgpu_bo_unreserve(root);
>   	amdgpu_bo_unref(&root);
>   	WARN_ON(vm->root.base.bo);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 1494aebb8128..706cd60eb9e0 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -429,8 +429,8 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>   	BUG_ON(!dma_resv_trylock(&bo->base._resv));
>   
>   	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
> -	if (r)
> -		dma_resv_unlock(&bo->base._resv);
> +
> +	dma_resv_unlock(&bo->base._resv);
>   
>   	return r;
>   }
> @@ -455,23 +455,19 @@ static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
>   	}
>   }
>   
> -static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
> +static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo, bool enqueue)
>   {
>   	struct ttm_bo_device *bdev = bo->bdev;
>   	int ret;
>   
> -	ret = ttm_bo_individualize_resv(bo);
> -	if (ret) {
> -		/* Last resort, if we fail to allocate memory for the
> -		 * fences block for the BO to become idle
> -		 */
> -		dma_resv_wait_timeout_rcu(bo->base.resv, true, false,
> -						    30 * HZ);
> -		spin_lock(&ttm_bo_glob.lru_lock);
> -		goto error;
> -	}
> -
>   	spin_lock(&ttm_bo_glob.lru_lock);
> +
> +	if (enqueue)
> +		goto queue;
> +
> +	if (bo->base.resv != &bo->base._resv)
> +		BUG_ON(!dma_resv_trylock(&bo->base._resv));
> +
>   	ret = dma_resv_trylock(bo->base.resv) ? 0 : -EBUSY;
>   	if (!ret) {
>   		if (dma_resv_test_signaled_rcu(&bo->base._resv, true)) {
> @@ -504,7 +500,7 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
>   		dma_resv_unlock(&bo->base._resv);
>   	}
>   
> -error:
> +queue:
>   	kref_get(&bo->list_kref);
>   	list_add_tail(&bo->ddestroy, &bdev->ddestroy);
>   	spin_unlock(&ttm_bo_glob.lru_lock);
> @@ -655,6 +651,16 @@ static void ttm_bo_release(struct kref *kref)
>   	    container_of(kref, struct ttm_buffer_object, kref);
>   	struct ttm_bo_device *bdev = bo->bdev;
>   	struct ttm_mem_type_manager *man = &bdev->man[bo->mem.mem_type];
> +	int ret;
> +
> +	ret = ttm_bo_individualize_resv(bo);
> +	if (ret) {
> +		/* Last resort, if we fail to allocate memory for the
> +		 * fences block for the BO to become idle
> +		 */
> +		dma_resv_wait_timeout_rcu(bo->base.resv, true, false,
> +				30 * HZ);
> +	}
>   
>   	if (bo->bdev->driver->release_notify)
>   		bo->bdev->driver->release_notify(bo);
> @@ -663,7 +669,7 @@ static void ttm_bo_release(struct kref *kref)
>   	ttm_mem_io_lock(man, false);
>   	ttm_mem_io_free_vm(bo);
>   	ttm_mem_io_unlock(man);
> -	ttm_bo_cleanup_refs_or_queue(bo);
> +	ttm_bo_cleanup_refs_or_queue(bo, !!ret);
>   	kref_put(&bo->list_kref, ttm_bo_release_list);
>   }
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
