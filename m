Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED6C352A4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 13:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8191214AF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 13:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hRou/Yv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8191214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06856E05D;
	Fri,  7 Feb 2020 13:43:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23EF6E05D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 13:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4zy9hnt3SZk3OEswh5wBjwrr/7rsMQVUUV6CD7OBz8YptgovS1NmwduimQ3V/CF98s5zvS297RM/d+xB4aPZiwlnoi2uUxNUYUkbfCKiv39JV0AIBR30uK6mK9k4mbds3gXWSLXLMuQFv+q+cWB/Yl+wqba1TaBgkWMbicepFJ0tbG+sueSOpwRhdwL83IufkvfMxqI9h3i+bKh2BT+YJf5QsclNIAjlMGZVH5s3nxgE4+j6SiCebme37ZVSfmJamjIYAuoteYUvqYIMd2BXa/6FRRoJIw0zWg8GOk7f/xUGCZ5+ZneLJJeLSP3uNb5BI7elWsv7944AMKB2d0OXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtyIit5ZBaHRYh7OMkyt81YblVbj/oKS+e/vGO1XTUQ=;
 b=FUhvtzYnyIWiXkItCdSynsE5BHeMFGumZv11WeDJfcwEfqottjvHNmcP+sSxjV07uzP8rd+2vuUiNQTg1NLboGYEWnO9+tUoUfdysokOgKgN2Bm8DdQcKApdv01LnUCW3NNHbNjPaXN5eUGUxNl/63qEZNwHGIz9dx9KB3WES1X3OwB2SHSJ76BoHeQfNUV2p5hA3LDvomFRJogIrPazArrNi8cJTb+0WPM7/1JrCRzhfibs5paIKGguJUHmNWn2tQZzeILhaq3sP7MhDPQThSNREUTThR9MntRROcPI6eWkXyWLQsIHQaAlnmx1e3cz13Y20yxSGYI2y+OnHsoXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtyIit5ZBaHRYh7OMkyt81YblVbj/oKS+e/vGO1XTUQ=;
 b=hRou/Yv/v3QY1dLHOXvu30K4xm/OL8pRsxPl6e49YXfBoUWdSc57UuJjnj6rOcTvefqP2P82hgx1sdjn4o1ocQ9qNG37szXXOuVb5DRDB1n5SUS2grBRaFoxt0rrU85PSszEHj1Z4ZXpyVlTSrHuZF6y259zMIeHr2ZB+qKS6D8=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.102.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Fri, 7 Feb 2020 13:42:57 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 13:42:57 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH v2] drm/amdgpu: Remove kfd eviction fence before release bo
Thread-Topic: [RFC PATCH v2] drm/amdgpu: Remove kfd eviction fence before
 release bo
Thread-Index: AQHV3byBMZGQB49AF0ajl7yjLfb9Dw==
Date: Fri, 7 Feb 2020 13:42:57 +0000
Message-ID: <SN6PR12MB2800576A6BF1C9C25C4ABA12871C0@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-07T13:42:56.513Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46829f61-1d8a-4b04-7339-08d7abd3a413
x-ms-traffictypediagnostic: SN6PR12MB2749:|SN6PR12MB2749:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB274902D1B5BCB824AC690654871C0@SN6PR12MB2749.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(189003)(199004)(33656002)(52536014)(316002)(86362001)(66556008)(64756008)(66446008)(9686003)(5660300002)(26005)(66476007)(54906003)(66946007)(71200400001)(55016002)(6506007)(4326008)(7696005)(2906002)(81166006)(8936002)(81156014)(478600001)(6916009)(186003)(8676002)(76116006)(91956017)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2749;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: opVABz2V7qcMzWUZYneOOZx5hzBajzROxzEdVnZIecUJhROW+cQGnYEZk4HXn/BrojRmJEhcnr2sI3Bcdn1mgG4u7Gckensm6hZaEaESU3gi8UmMj78D/HrEhQ2eLr7m8dpyX/V4xCyXpQESratDBXAigo80K/mLPRZir0tP2U6/XCR5UizhBLB89ppA0dYmuvTs6U7NsvXnQ93P9wxk7TZzrQSO1LpkGsnwNIxUVToS5Ssftinata7bRSpkC8VwssMf95vWAp3AiUNHvwJE4kJz+A3zh6i4/BYdHf1zBv/apvrDtCeJ5iFg+sm8u0ISDUrjDlsqYZ5jodJusYGdQOlk2JJn1YnTyrbKRmrwRWnsQWOeu5mWizZZNUoyoXOvnW8LBDpYC+Q4m22YdWBXSkKvmLeq8LKi1vAY58GiPSi3IwdjE9HgGQqxYdC/Lhh6LDMQfCbGqGeEZ/v/A9D+qPF2UhTw0CshzJ22qAtMbBShw1mbkXRTF6HWBCH8pARP
x-ms-exchange-antispam-messagedata: TJsC2A4yuE59vAHiGed6B7Iqz5PAyG+Lyb1tI40Zrg7csx2QDFjzJ9jJE2uY32L8qAVCnJTf7m53epGM07NgLwLu94zFN5ckVRh++ktpezLLv8lWvncd8cFMcI9v+d7yIdGRBrZviQklhR3M5CgfEw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46829f61-1d8a-4b04-7339-08d7abd3a413
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 13:42:57.3502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqnoFVV27JctfVKwk3qx4tHC18XpX5XwuYyESY10icspij6kh5h2YkznIf5NX0jD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
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
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to trigger eviction as the memory mapping will not be used anymore.

All pt/pd bos share same resv, hence the same shared eviction fence. Everytime page table is freed, the fence will be signled and that cuases kfd unexcepted evictions.

Signed-off-by: xinhui pab <xinhui.pan@example.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 78 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 10 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  5 +-
 drivers/gpu/drm/ttm/ttm_bo.c                  | 38 +++++----
 5 files changed, 111 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 47b0f2957d1f..265b1ed7264c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -96,6 +96,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 						       struct mm_struct *mm);
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
+int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
 
 struct amdkfd_process_info {
 	/* List head of all VMs that belong to a KFD process */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ef721cb65868..11315095c29b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -223,7 +223,7 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
 static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 					struct amdgpu_amdkfd_fence *ef)
 {
-	struct dma_resv *resv = bo->tbo.base.resv;
+	struct dma_resv *resv = &bo->tbo.base._resv;
 	struct dma_resv_list *old, *new;
 	unsigned int i, j, k;
 
@@ -276,6 +276,78 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	return 0;
 }
 
+int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
+{
+	struct amdgpu_vm_bo_base        *vm_bo = bo->vm_bo;
+	struct amdgpu_vm *vm;
+	struct amdkfd_process_info *info;
+	struct amdgpu_amdkfd_fence *ef;
+	struct amdgpu_bo *parent;
+	int locked;
+	int ret;
+	struct ttm_bo_global *glob = &ttm_bo_glob;
+
+	if (vm_bo == NULL)
+		return 0;
+
+	/* Page table bo has a reference of the parent bo.
+	 * BO itself can't guarntee the vm it points to is alive.
+	 * for example, VM is going to free page tables, and the pt/pd bo might be
+	 * freed by a workqueue. In that case, the vm might be freed already,
+	 * leaving the bo->vm_bo points to vm.root.
+	 *
+	 * so to avoid that, when kfd free its vms,
+	 * 1) set vm->process_info to NULL if this is the last vm.
+	 * 2) set root_bo->vm_bo to NULL.
+	 *
+	 * but there are still races, just like
+	 * cpu 1 		cpu 2
+	 * 			!vm_bo
+	 * ->info = NULL
+	 * free(info)
+	 * ->vm_bo = NULL
+	 * free (vm)
+	 * 			info = vm->info //invalid vm
+	 *
+	 * So to avoid the race, use ttm_bo_glob lru_lock.
+	 * generally speaking, adding a new lock is accceptable.
+	 * But reusing this lock is simple.
+	 */
+	parent = bo;
+	while (parent->parent)
+		parent = parent->parent;
+
+	spin_lock(&glob->lru_lock);
+	vm_bo = parent->vm_bo;
+	if (!vm_bo) {
+		spin_unlock(&glob->lru_lock);
+		return 0;
+	}
+
+	vm = vm_bo->vm;
+	if (!vm) {
+		spin_unlock(&glob->lru_lock);
+		return 0;
+	}
+
+	info = vm->process_info;
+	if (!info || !info->eviction_fence) {
+		spin_unlock(&glob->lru_lock);
+		return 0;
+	}
+
+	ef = container_of(dma_fence_get(&info->eviction_fence->base),
+			struct amdgpu_amdkfd_fence, base);
+	spin_unlock(&glob->lru_lock);
+
+	locked = dma_resv_trylock(&bo->tbo.base._resv);
+	ret = amdgpu_amdkfd_remove_eviction_fence(bo, ef);
+	dma_fence_put(&ef->base);
+	if (locked)
+		dma_resv_unlock(&bo->tbo.base._resv);
+	return ret;
+}
+
 static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 				     bool wait)
 {
@@ -1030,6 +1102,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 {
 	struct amdkfd_process_info *process_info = vm->process_info;
 	struct amdgpu_bo *pd = vm->root.base.bo;
+	struct ttm_bo_global *glob = &ttm_bo_glob;
 
 	if (!process_info)
 		return;
@@ -1051,6 +1124,9 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 		WARN_ON(!list_empty(&process_info->userptr_valid_list));
 		WARN_ON(!list_empty(&process_info->userptr_inval_list));
 
+		spin_lock(&glob->lru_lock);
+		vm->process_info = NULL;
+		spin_unlock(&glob->lru_lock);
 		dma_fence_put(&process_info->eviction_fence->base);
 		cancel_delayed_work_sync(&process_info->restore_userptr_work);
 		put_pid(process_info->pid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6f60a581e3ba..6ad12298fa84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1307,19 +1307,23 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	if (abo->kfd_bo)
 		amdgpu_amdkfd_unreserve_memory_limit(abo);
 
+	amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
+	abo->vm_bo = NULL;
+
 	if (bo->mem.mem_type != TTM_PL_VRAM || !bo->mem.mm_node ||
 	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
 		return;
 
-	dma_resv_lock(bo->base.resv, NULL);
+	/* Only kfd bo wipe vram on release. The resv is &_resv. */
+	dma_resv_lock(&bo->base._resv, NULL);
 
-	r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, &fence);
+	r = amdgpu_fill_buffer(abo, AMDGPU_POISON, &bo->base._resv, &fence);
 	if (!WARN_ON(r)) {
 		amdgpu_bo_fence(abo, fence, false);
 		dma_fence_put(fence);
 	}
 
-	dma_resv_unlock(bo->base.resv);
+	dma_resv_unlock(&bo->base._resv);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index cc56eaba1911..2b96447e30e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -945,7 +945,6 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 {
 	if (entry->base.bo) {
-		entry->base.bo->vm_bo = NULL;
 		list_del(&entry->base.vm_status);
 		amdgpu_bo_unref(&entry->base.bo->shadow);
 		amdgpu_bo_unref(&entry->base.bo);
@@ -3074,6 +3073,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
 	struct amdgpu_bo *root;
+	struct ttm_bo_global *glob = &ttm_bo_glob;
 	int i;
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
@@ -3105,6 +3105,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	}
 
 	amdgpu_vm_free_pts(adev, vm, NULL);
+	spin_lock(&glob->lru_lock);
+	root->vm_bo = NULL;
+	spin_unlock(&glob->lru_lock);
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
 	WARN_ON(vm->root.base.bo);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 1494aebb8128..706cd60eb9e0 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -429,8 +429,8 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 	BUG_ON(!dma_resv_trylock(&bo->base._resv));
 
 	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
-	if (r)
-		dma_resv_unlock(&bo->base._resv);
+
+	dma_resv_unlock(&bo->base._resv);
 
 	return r;
 }
@@ -455,23 +455,19 @@ static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
 	}
 }
 
-static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
+static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo, bool enqueue)
 {
 	struct ttm_bo_device *bdev = bo->bdev;
 	int ret;
 
-	ret = ttm_bo_individualize_resv(bo);
-	if (ret) {
-		/* Last resort, if we fail to allocate memory for the
-		 * fences block for the BO to become idle
-		 */
-		dma_resv_wait_timeout_rcu(bo->base.resv, true, false,
-						    30 * HZ);
-		spin_lock(&ttm_bo_glob.lru_lock);
-		goto error;
-	}
-
 	spin_lock(&ttm_bo_glob.lru_lock);
+
+	if (enqueue)
+		goto queue;
+
+	if (bo->base.resv != &bo->base._resv)
+		BUG_ON(!dma_resv_trylock(&bo->base._resv));
+
 	ret = dma_resv_trylock(bo->base.resv) ? 0 : -EBUSY;
 	if (!ret) {
 		if (dma_resv_test_signaled_rcu(&bo->base._resv, true)) {
@@ -504,7 +500,7 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
 		dma_resv_unlock(&bo->base._resv);
 	}
 
-error:
+queue:
 	kref_get(&bo->list_kref);
 	list_add_tail(&bo->ddestroy, &bdev->ddestroy);
 	spin_unlock(&ttm_bo_glob.lru_lock);
@@ -655,6 +651,16 @@ static void ttm_bo_release(struct kref *kref)
 	    container_of(kref, struct ttm_buffer_object, kref);
 	struct ttm_bo_device *bdev = bo->bdev;
 	struct ttm_mem_type_manager *man = &bdev->man[bo->mem.mem_type];
+	int ret;
+
+	ret = ttm_bo_individualize_resv(bo);
+	if (ret) {
+		/* Last resort, if we fail to allocate memory for the
+		 * fences block for the BO to become idle
+		 */
+		dma_resv_wait_timeout_rcu(bo->base.resv, true, false,
+				30 * HZ);
+	}
 
 	if (bo->bdev->driver->release_notify)
 		bo->bdev->driver->release_notify(bo);
@@ -663,7 +669,7 @@ static void ttm_bo_release(struct kref *kref)
 	ttm_mem_io_lock(man, false);
 	ttm_mem_io_free_vm(bo);
 	ttm_mem_io_unlock(man);
-	ttm_bo_cleanup_refs_or_queue(bo);
+	ttm_bo_cleanup_refs_or_queue(bo, !!ret);
 	kref_put(&bo->list_kref, ttm_bo_release_list);
 }
 
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
