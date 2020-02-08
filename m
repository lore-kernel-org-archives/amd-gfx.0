Return-Path: <SRS0=8Nbv=34=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FC5C35250
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2020 15:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2FC21775
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2020 15:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YvDHoUCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2FC21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8E96E339;
	Sat,  8 Feb 2020 15:09:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796096E339
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2020 15:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Npdgf3qtyFtzBaI/EaxmDNfNFUfGD5aHFvyGZltnDBi4b2TLVrGzxzc2UVVrzcx1PtLkgY/7ApfiDCKzRpzZzbegeAcAaDAqG6EP2q2A8J5lXeC2ncxaQWS9buFBNCx16dgqr8Pqu3aDUHiAPt3lTM2lDDCWzfdMMt6+tNwWFgPMu6jcK6bsxpwnCAbB6eNIqzFsaI6G8e5S/IEcTUwcLByu6gR6PN53dKvd5VY9DVWlwVrwLsLq3jcL4DRjHyw1D3wGYR1O+H8aSceS26pzpjTpIeTJN8NMu2x3kFfffmPmeqSAYoCpGZseEuakYOsblM0nYZpTUsWR8B8LHRTgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFap+ub07TgamepBB+YjfhrbuaAN/wIVSLvHDhHst8g=;
 b=A20UiwhX5D4Fkk3gQ2ZOPGmg6N6R3XFXUtnbVlJ/arfy8vUCvjbWnXWM8EyLoMbdGXeBuzlAbh08yMqOvo4xm2oAigE71DsL2hMJoV3JpV493Y4J+Xwj+ysb7t0j5g9vYhUImTMohcWD6LwcVB9BmWoyTb3KIRnXrxnJpoJOvTL/KpiN6MS+lOJdo1qRLxh22HJAocC7fPWMokr7b7AiPcw4eO95Z4OD5nGMqXNjbhXo/PwJ669yojzEV9TLxqebg7jGsQFXqtPEHKRN6mVZdKmlcO60vfBrdBWZw8DIgSGsFtpGW1D7APajaAWXgl2pJlRyLTz4OHv5W4fjba2GRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFap+ub07TgamepBB+YjfhrbuaAN/wIVSLvHDhHst8g=;
 b=YvDHoUCqgrIIDBU7n2pWm9m3PXRZ6/w/uUQRwQ/pn+Krh3yfFCs2lEF3JgE1dgDurSaEXCe1CNlpYdXmyh1skCEUgaCCJqoRENr647+Sns4JNlCF5IvrXDOMByYHChzp/m5aKBBkMkR5PHjghW2cFDvkiOBk2toIZq4Bi3Cp1Qo=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2766.namprd12.prod.outlook.com (52.135.107.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Sat, 8 Feb 2020 15:09:48 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2707.024; Sat, 8 Feb 2020
 15:09:48 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH v4] drm/amdgpu: Remove kfd eviction fence before release bo
Thread-Topic: [RFC PATCH v4] drm/amdgpu: Remove kfd eviction fence before
 release bo
Thread-Index: AQHV3pEcTPz+XSEFgkKEJ5z/+3bleg==
Date: Sat, 8 Feb 2020 15:09:48 +0000
Message-ID: <SN6PR12MB28001FE5A3616729FC7D5E03871F0@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-08T15:09:46.841Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 033aa798-ff5b-4b9b-634c-08d7aca8f05a
x-ms-traffictypediagnostic: SN6PR12MB2766:|SN6PR12MB2766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2766B48A1321865356302973871F0@SN6PR12MB2766.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 03077579FF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(2906002)(66476007)(66556008)(64756008)(66446008)(91956017)(76116006)(66946007)(7696005)(4326008)(6916009)(54906003)(316002)(86362001)(52536014)(478600001)(5660300002)(33656002)(26005)(6506007)(71200400001)(186003)(9686003)(8676002)(55016002)(81166006)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2766;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 783gy+5Ns0lW4FqGf/DMGS/Uh7LOwMiRZSAm0L+cqdh8/0JgpEs5brSmYkysL7qQYC8+t6GC7VK/EJecpnI8z6NqATBAi697iqsmNBUuAi8YeUGRP+tsDt72rH1s3C2uGDqkYR09gU7A8AL/51kwBQbUaMrpV7HjmAJbSMu3AZqlcB4S7ZPRqNq4XCMqTfLBvM4jCz+0ggpZK3qFK71QnltUiRcrvdSNyo2RwMfekSOjwbgVMsForsVZ+DeUTIg0I7KTs11Qgm9IlYM7++TjTsoAf7TY9FozqmuhOMicRuXGUgDtbCsKGGdjl9eFFE/yvUqP/Qg9Pwf0g5PgJdRKLAZdOgGhjpwWpSRNCDL0rqy6+1XV45q07TZ0WbAtFndiarj8Hl/gXr6yTu0dKTurkK68E3wSLatOzU5DJ5B2z6fW9wGypCc6tjplTZ0Q4KW0
x-ms-exchange-antispam-messagedata: zTcqCCYDFr5PL4BgLkwenTvSo+tGvtJfnNsyRNojTFHOYMdDV6QpOuNJprJaZN+9llkN+N2jnwfjZlieWNYOGdfpU9pcWsqKLJJ6n5XOqlRV5mclNC/meX+cXSeGDf2amzyr6YkUY9AZgvSe0dYFAQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033aa798-ff5b-4b9b-634c-08d7aca8f05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2020 15:09:48.2503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RLQKMMRDSQu8M0mQLE2bs5jnHAqHLYSr460g0dADQhcgOBJkJhhJYlZAjehkIGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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

Signed-off-by: xinhui pan <xinhui.pan@example.com>
---
change from v3:
fix a coding error

change from v2:
based on Chris' drm/ttm: rework BO delayed delete patchset.

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 36 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  1 +
 drivers/gpu/drm/ttm/ttm_bo.c                  | 16 +++++----
 5 files changed, 49 insertions(+), 7 deletions(-)

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
index ef721cb65868..d4b117065c1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -276,6 +276,41 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	return 0;
 }
 
+int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
+{
+	struct amdgpu_bo *root = bo;
+	struct amdgpu_vm_bo_base *vm_bo;
+	struct amdgpu_vm *vm;
+	struct amdkfd_process_info *info;
+	struct amdgpu_amdkfd_fence *ef;
+	int ret;
+
+	while (root->parent)
+		root = root->parent;
+
+	vm_bo = root->vm_bo;
+	if (!vm_bo)
+		return 0;
+
+	vm = vm_bo->vm;
+	if (!vm)
+		return 0;
+
+	info = vm->process_info;
+	if (!info || !info->eviction_fence)
+		return 0;
+
+	ef = container_of(dma_fence_get(&info->eviction_fence->base),
+			struct amdgpu_amdkfd_fence, base);
+
+	BUG_ON(!dma_resv_trylock(&bo->tbo.base._resv));
+	ret = amdgpu_amdkfd_remove_eviction_fence(bo, ef);
+	dma_resv_unlock(&bo->tbo.base._resv);
+
+	dma_fence_put(&ef->base);
+	return ret;
+}
+
 static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 				     bool wait)
 {
@@ -1051,6 +1086,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 		WARN_ON(!list_empty(&process_info->userptr_valid_list));
 		WARN_ON(!list_empty(&process_info->userptr_inval_list));
 
+		vm->process_info = NULL;
 		dma_fence_put(&process_info->eviction_fence->base);
 		cancel_delayed_work_sync(&process_info->restore_userptr_work);
 		put_pid(process_info->pid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6f60a581e3ba..3784d178c965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1307,6 +1307,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	if (abo->kfd_bo)
 		amdgpu_amdkfd_unreserve_memory_limit(abo);
 
+	amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
+
 	if (bo->mem.mem_type != TTM_PL_VRAM || !bo->mem.mm_node ||
 	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 247f328b7223..eca4ec66c1ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3109,6 +3109,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	}
 
 	amdgpu_vm_free_pts(adev, vm, NULL);
+	root->vm_bo = NULL;
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
 	WARN_ON(vm->root.base.bo);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 6c3cea509e25..855d3566381e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -399,8 +399,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 	BUG_ON(!dma_resv_trylock(&bo->base._resv));
 
 	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
-	if (r)
-		dma_resv_unlock(&bo->base._resv);
+	dma_resv_unlock(&bo->base._resv);
 
 	return r;
 }
@@ -565,9 +564,6 @@ static void ttm_bo_release(struct kref *kref)
 	int ret;
 
 	if (!bo->deleted) {
-		if (bo->bdev->driver->release_notify)
-			bo->bdev->driver->release_notify(bo);
-
 		drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
 		ttm_mem_io_lock(man, false);
 		ttm_mem_io_free_vm(bo);
@@ -581,6 +577,14 @@ static void ttm_bo_release(struct kref *kref)
 			dma_resv_wait_timeout_rcu(bo->base.resv, true, false,
 						  30 * HZ);
 		}
+
+		spin_lock(&ttm_bo_glob.lru_lock);
+		if (bo->type != ttm_bo_type_sg)
+			bo->base.resv = &bo->base._resv;
+		spin_unlock(&ttm_bo_glob.lru_lock);
+
+		if (bo->bdev->driver->release_notify)
+			bo->bdev->driver->release_notify(bo);
 	}
 
 	if (!dma_resv_test_signaled_rcu(bo->base.resv, true)) {
@@ -599,8 +603,6 @@ static void ttm_bo_release(struct kref *kref)
 		}
 
 		spin_lock(&ttm_bo_glob.lru_lock);
-		if (bo->type != ttm_bo_type_sg)
-			bo->base.resv = &bo->base._resv;
 		kref_init(&bo->kref);
 		list_add_tail(&bo->ddestroy, &bdev->ddestroy);
 		spin_unlock(&ttm_bo_glob.lru_lock);
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
