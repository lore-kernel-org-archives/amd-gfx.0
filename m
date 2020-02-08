Return-Path: <SRS0=8Nbv=34=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED599C35250
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2020 15:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D8721775
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2020 15:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="azuzSyTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D8721775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FA76E369;
	Sat,  8 Feb 2020 15:57:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C95E6E369
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2020 15:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7it2257FMbJFwslx+rWcSLXzZIFIUj9wEV2VgrhVYcAClVRpElQHUZtotFAewMOR7KWYSqT81HvYkfF8YNYgd4oKru4P7JmnRRItRBakp9+CVswA3CyPJxOjdsvVV1XZbMU1D4/eYN5ZpmmM3ThWAOqgQwUrevmcnKmROlEGEl882vnQf5y/bnxxVJ2R1xQ+L57k8XTdcBDi9VAQqm7dT7GtQNBgPlHLCMQ9ec6V0S0/t4UUODryIjnKSFXYSSw6t3TV/qmkMJxM2DmGGAUu+F2ZmWK87f4OzRfgv/BWVlhVQVceJGfc7QGtvhXHLZgBPiKZWmPsRfH1jkPA9ywxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l7oSZoH2k3DSQy1pYBfXJEQ/UhQ8AvTggRAFECNaao=;
 b=JaLfChitDUnN7TVaIAhg2DEnzW2x1CEZgRdz6k2mqunuvcejjizmhLL56YB33tcxuuJX4mc64Zv+wCYS4Kw8JvnTBXnOC0xZbx03DtGN1aVYHNdMhtFy2+L1nkdTl9DtLXGLahrdSU+Rq6D2WUF+8S8i0d8rqbHx2dqCEoCJ+8w4aNaaqGVZhIVAnZWfM0x316+e2Ez3K1Y9bOPf8c4BJTXIeJT4xZvXYFGsSSPqFRa9vrKlkCrxadfxq30ahee2TWffo4QO2waVPmXWYTRGMKI/HMM/wEDtcjcDt2hORZrkTq2mptxcw8qfp09E6hM7dMdMrp6YpLyPRf8paBOCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l7oSZoH2k3DSQy1pYBfXJEQ/UhQ8AvTggRAFECNaao=;
 b=azuzSyTg7Vp17xgNxXFcafmVkh79dCh2VD2lMfVa8um6/9cH+A10VvYvzrfPAnX071KiaFQQbf4+PH8N9ayTZI/mFduZSc7gzrCHq1DvW4Jt6sJIt/ZF7TtAj2lQa1WqTUxQy1UACzkGC/T3CIVzCTBhHRrE4lnZPI9nZRxENzE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1593.namprd12.prod.outlook.com (10.172.40.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Sat, 8 Feb 2020 15:57:29 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2707.027; Sat, 8 Feb 2020
 15:57:29 +0000
Subject: Re: [RFC PATCH v4] drm/amdgpu: Remove kfd eviction fence before
 release bo
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <SN6PR12MB28001FE5A3616729FC7D5E03871F0@SN6PR12MB2800.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4733e64d-fe03-962a-b07d-70e4b1582605@amd.com>
Date: Sat, 8 Feb 2020 16:57:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <SN6PR12MB28001FE5A3616729FC7D5E03871F0@SN6PR12MB2800.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26 via Frontend Transport; Sat, 8 Feb 2020 15:57:28 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24e074e1-7884-4414-76a4-08d7acaf99d2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1593:|DM5PR12MB1593:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1593B5D9D398245529B20A15831F0@DM5PR12MB1593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(86362001)(2906002)(5660300002)(6486002)(31696002)(316002)(66946007)(66476007)(478600001)(4326008)(54906003)(66556008)(110136005)(52116002)(2616005)(186003)(16526019)(81156014)(81166006)(36756003)(8676002)(31686004)(6666004)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1593;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgETQI6vJrHkpdc5ile2uz6cz4IpLkg7Uoo7u1AP8xU1Wq7NjTcAJcuyGJVeuxYVyu7IVHJ7wSabe3MCYnjZZe0pNUd+AsMLqwZrz24U0JlKNeLCsKVhORSLBBZq0qtl3S/HQiaZrrzzzUt6c/H8UG/jRClwHX69zcn59lxH99BNofnSzFCfXQ4of+2c6fq9t3rDCLy51nllyzzLbtZ57GlG6rfUopDzBdrb8YrLnS2NrjpcGpFlaqRvJHB6nX40AQGVjX4EmqHj3HGh+lTWgDZqfX3djS/SET5Qy4oewjOmwCddmOGA64NleO4mXRCvkBOfPC1sPadm2am8J+ilqKujfB5Ky4XrCMcwgrrO7ZBjf9sDfkbVNAFxhc5XQbeXFaWHh7UkhRXniHOxTMiFMyFKVIWBh07Bn+u91HwngMyoj+r68aam19ZewwlK/qJm
X-MS-Exchange-AntiSpam-MessageData: 8iDWXlXHSRCsGUNzKTcbkEK62kJ824irYrrbS9stgHnKIseqjX/+3xoVLM59cNJbFP0bTj2LcUZmV8XBhjdC2CtXYur8YjLTb/3nUfq9AUcuBPjgelH9Bbu2iRd+MiAmTzkMTS7vvHmpqLRVSi1vUx/djZPowNspmg+b3K1HJ4UJbDd2wmhGDSAuxv4Pm/C2p6lNLaxmOG72KufHOyzupA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e074e1-7884-4414-76a4-08d7acaf99d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 15:57:29.8174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VA4+tG/ZzbpGNUkczqe4WwYXJSynDjDioFOVho/OCqEvSURUml29N6/c/fhNnRqJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1593
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

Am 08.02.20 um 16:09 schrieb Pan, Xinhui:
> No need to trigger eviction as the memory mapping will not be used anymore.
>
> All pt/pd bos share same resv, hence the same shared eviction fence. Everytime page table is freed, the fence will be signled and that cuases kfd unexcepted evictions.
>
> Signed-off-by: xinhui pan <xinhui.pan@example.com>
> ---
> change from v3:
> fix a coding error
>
> change from v2:
> based on Chris' drm/ttm: rework BO delayed delete patchset.
>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 36 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  1 +
>   drivers/gpu/drm/ttm/ttm_bo.c                  | 16 +++++----
>   5 files changed, 49 insertions(+), 7 deletions(-)
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
> index ef721cb65868..d4b117065c1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -276,6 +276,41 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>   	return 0;
>   }
>   
> +int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_bo *root = bo;
> +	struct amdgpu_vm_bo_base *vm_bo;
> +	struct amdgpu_vm *vm;
> +	struct amdkfd_process_info *info;
> +	struct amdgpu_amdkfd_fence *ef;
> +	int ret;
> +
> +	while (root->parent)
> +		root = root->parent;
> +
> +	vm_bo = root->vm_bo;
> +	if (!vm_bo)
> +		return 0;
> +
> +	vm = vm_bo->vm;
> +	if (!vm)
> +		return 0;
> +
> +	info = vm->process_info;
> +	if (!info || !info->eviction_fence)
> +		return 0;
> +
> +	ef = container_of(dma_fence_get(&info->eviction_fence->base),
> +			struct amdgpu_amdkfd_fence, base);
> +
> +	BUG_ON(!dma_resv_trylock(&bo->tbo.base._resv));
> +	ret = amdgpu_amdkfd_remove_eviction_fence(bo, ef);
> +	dma_resv_unlock(&bo->tbo.base._resv);
> +
> +	dma_fence_put(&ef->base);
> +	return ret;
> +}
> +
>   static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
>   				     bool wait)
>   {
> @@ -1051,6 +1086,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   		WARN_ON(!list_empty(&process_info->userptr_valid_list));
>   		WARN_ON(!list_empty(&process_info->userptr_inval_list));
>   
> +		vm->process_info = NULL;
>   		dma_fence_put(&process_info->eviction_fence->base);
>   		cancel_delayed_work_sync(&process_info->restore_userptr_work);
>   		put_pid(process_info->pid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6f60a581e3ba..3784d178c965 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1307,6 +1307,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   	if (abo->kfd_bo)
>   		amdgpu_amdkfd_unreserve_memory_limit(abo);
>   
> +	amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
> +
>   	if (bo->mem.mem_type != TTM_PL_VRAM || !bo->mem.mm_node ||
>   	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
>   		return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 247f328b7223..eca4ec66c1ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3109,6 +3109,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	}
>   
>   	amdgpu_vm_free_pts(adev, vm, NULL);
> +	root->vm_bo = NULL;
>   	amdgpu_bo_unreserve(root);
>   	amdgpu_bo_unref(&root);
>   	WARN_ON(vm->root.base.bo);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 6c3cea509e25..855d3566381e 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -399,8 +399,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>   	BUG_ON(!dma_resv_trylock(&bo->base._resv));
>   
>   	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
> -	if (r)
> -		dma_resv_unlock(&bo->base._resv);
> +	dma_resv_unlock(&bo->base._resv);
>   
>   	return r;
>   }
> @@ -565,9 +564,6 @@ static void ttm_bo_release(struct kref *kref)
>   	int ret;
>   
>   	if (!bo->deleted) {
> -		if (bo->bdev->driver->release_notify)
> -			bo->bdev->driver->release_notify(bo);
> -
>   		drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
>   		ttm_mem_io_lock(man, false);
>   		ttm_mem_io_free_vm(bo);
> @@ -581,6 +577,14 @@ static void ttm_bo_release(struct kref *kref)
>   			dma_resv_wait_timeout_rcu(bo->base.resv, true, false,
>   						  30 * HZ);
>   		}
> +
> +		spin_lock(&ttm_bo_glob.lru_lock);
> +		if (bo->type != ttm_bo_type_sg)
> +			bo->base.resv = &bo->base._resv;

This still doesn't works correctly and can cause very subtle crashes.

I will try to send out a patch set on Monday which should work.

Christian.

> +		spin_unlock(&ttm_bo_glob.lru_lock);
> +
> +		if (bo->bdev->driver->release_notify)
> +			bo->bdev->driver->release_notify(bo);
>   	}
>   
>   	if (!dma_resv_test_signaled_rcu(bo->base.resv, true)) {
> @@ -599,8 +603,6 @@ static void ttm_bo_release(struct kref *kref)
>   		}
>   
>   		spin_lock(&ttm_bo_glob.lru_lock);
> -		if (bo->type != ttm_bo_type_sg)
> -			bo->base.resv = &bo->base._resv;
>   		kref_init(&bo->kref);
>   		list_add_tail(&bo->ddestroy, &bdev->ddestroy);
>   		spin_unlock(&ttm_bo_glob.lru_lock);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
