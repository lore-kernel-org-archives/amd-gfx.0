Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16468C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 15:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D787860F5A
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 15:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D787860F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827816E167;
	Mon,  8 Nov 2021 15:32:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3396E103
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 15:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+sq/Wp+X+9I9AEHhhqXas0HMBbyEBpEFUThXOrHzA80qti4mxEI/HupHTVWkFkP+eBxXUSImUVlF5XIJ4jKjMjOMJQrnEvnaoI7SqCCXBEm/qjPO+huxfbQYgCPa0UqiQrMGF/BQygBPGC0Hhyxd/096fyFIdUfBvhFjjG7Nn+/ZDJkldF5dnkjsqYdi5XaF84R8BkKn2BMtGgNUskf0NUMD3X6jnQyb6d0KSA+wIdy6+6Cbw9wXeyI7PjWMSpwogetSmkW6ZvzMEXGYSKpCjZM5mqnJzXBNq/2txRNHtT1CoCqdX5dEmZiI+TDShZgyEg10mUCGV8X4xnNfoh4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjEQE4kIjddDR7PYUTg8sYul33ila6hEkbYwAq3kFvw=;
 b=DKUgeNk7AOROTU+CRaCHq40btIb1r4uXXZXogAZv/IViUB+XWfUEMmPUiYgJqcY6uYGIEzJlG5RnTy4KVHBPNtCnsTVbLzB1Dk4qYUVCgXgdHdqC8OEsOeDv9Jd7Dny0111Cpm0XfMzjKUVxz2PhJPAsuD/+nkeN7wcGVuIAlhBQxQPQ04LeHwtHweId+T50G0lDiFm1t138D39BanAw2879QhpENRLJyOguDZm123YAtKw0vj0oZYAIWs/zniBfDGs8lJfoFPxlnl9XCK5+1VkpCD6f3tTJ/NNm1JltxU4XwbNP/a4UZ34DgJKdV4sdEFcdp+bI2NsBwq8flZyODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjEQE4kIjddDR7PYUTg8sYul33ila6hEkbYwAq3kFvw=;
 b=41CGKmR2dMPg0AbF1dgjgp07GgZyzdZ9n2Xo5chPlBUqoNyI3lI4aDNNVgyzhwqfXfVjetKciJXcCSh+XNJ95mxXm9XVmJu12/8BIguoNaDdStManoFyJenaY1OmXBb3EGYt85jsQ/plJzum7gwYOGHT9crLPSkYNYKMO6Rw2ro=
Received: from BN6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:404:8e::32)
 by BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 15:32:54 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::f7) by BN6PR21CA0022.outlook.office365.com
 (2603:10b6:404:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.1 via Frontend
 Transport; Mon, 8 Nov 2021 15:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 15:32:54 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 09:32:53 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the freeing of compute pasids
Date: Mon, 8 Nov 2021 10:32:44 -0500
Message-ID: <20211108153244.1974943-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b76b5ee-b187-4d18-c47f-08d9a2cd0879
X-MS-TrafficTypeDiagnostic: BYAPR12MB2710:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2710C4A974FEAC40067334B985919@BYAPR12MB2710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVVa1THIBqX4+3QTZMHWSDKfZK50w+tDOat6qWDjtLUFQEXqX5Ulr7SjiLW6wzDWVNebdEmGx2eLt85Ww6A194rt8mprc0EE1SOp9CE94YQ3XhqY8C4E6vLfwzsNb1rQry3Fi6Kei23e+PcEopE/q3sF12rC2hdWwVT71X04cG1+X6Q7O/GPkL4vMZdUc/E9uel61raE9Ks+nN+3nHPp5KLzlcx7m7DeyY71w14MTLW2JC5gHuNiwjxrIRsquUxed6jWZwkBFsZmKscJzH01qWq16fOOeMFpVh3A9ogCJlpWuLtSWYtmItQosPNUN7nEo6s+G8MCMFqt16HQ4EmL7zndXzaV/rkRui2ngFxW4xgjPZs5G0tQE5lDdn3Qk40OY3DTRYyIsTX1iyFawGLLK5WFfayU9WZ5zaHZMgD/TfxynBGyOwvuhAZRzHKZzstJ3LbaqwOW1RMAGWfCkx5hLlBBwuEu4sV4cEqYHgi0RyGQsL+7HepMtLIzmL2kkKuGoVQuwzfHBhtvjGCQTZV9YkDcsdOE41XGTZhtGJiAv/Ol9t1JV9zV7Du6LV47VtNOT4wAtOCeXR0odI1j4uLU/8TQ/SQL0SKJc6lnfW+zxxCiqehBKdfVJvpohW87FId7oiESdKigKUs6DI2g/TFZyEPJTFEmhPyk/8FSn9bE11hwzVNaBmuR/A6OovgpT9XMkO4slMjLkVrU0d1oI5s8kb/xru5rLl4fzDeFPAt3EZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(81166007)(70206006)(7696005)(316002)(1076003)(6916009)(47076005)(6666004)(356005)(83380400001)(8676002)(336012)(70586007)(426003)(36860700001)(2906002)(36756003)(508600001)(2616005)(4326008)(26005)(5660300002)(44832011)(86362001)(186003)(16526019)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 15:32:54.3369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b76b5ee-b187-4d18-c47f-08d9a2cd0879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2710
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch removes the race condition where KFD and KMS both try to free
the pasid, depending on when the render node is closed.

KMS should not be freeing compute PASIDs during KMS' postclose.
Compute PASIDs are cleaned up during KFD cleanup in kfd_pasid.c , and
ida_free is not robust enough to gracefully handle double-frees.

Moreover, once we set the context to compute (is_compute_context=true),
that won't change during the lifespan of the process. Due to that, we
can guarantee that the pasid will be cleaned up during KFD cleanup.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 --
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 21 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 14 -------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  5 +----
 6 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 5f658823a637..9be2c0463ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -269,8 +269,6 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					struct file *filp, u32 pasid,
 					void **process_info,
 					struct dma_fence **ef);
-void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
-					void *drm_priv);
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		struct amdgpu_device *adev, uint64_t va, uint64_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 94fccf0b47ad..3bdebcee2380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1352,27 +1352,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 	}
 }
 
-void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
-					    void *drm_priv)
-{
-	struct amdgpu_vm *avm;
-
-	if (WARN_ON(!adev || !drm_priv))
-		return;
-
-	avm = drm_priv_to_vm(drm_priv);
-
-	pr_debug("Releasing process vm %p\n", avm);
-
-	/* The original pasid of amdgpu vm has already been
-	 * released during making a amdgpu vm to a compute vm
-	 * The current pasid is managed by kfd and will be
-	 * released on kfd process destroy. Set amdgpu pasid
-	 * to 0 to avoid duplicate release.
-	 */
-	amdgpu_vm_release_compute(adev, avm);
-}
-
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
 {
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 651c7abfde03..9849aaf736d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1280,7 +1280,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
-	if (pasid)
+	if (pasid && !(fpriv->vm.is_compute_context))
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
 	amdgpu_bo_unref(&pd);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0e7dc23f78e7..049b3f6d9cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3125,20 +3125,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	return r;
 }
 
-/**
- * amdgpu_vm_release_compute - release a compute vm
- * @adev: amdgpu_device pointer
- * @vm: a vm turned into compute vm by calling amdgpu_vm_make_compute
- *
- * This is a correspondant of amdgpu_vm_make_compute. It decouples compute
- * pasid from vm. Compute should stop use of vm after this call.
- */
-void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
-{
-	amdgpu_vm_set_pasid(adev, vm, 0);
-	vm->is_compute_context = false;
-}
-
 /**
  * amdgpu_vm_fini - tear down a vm instance
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 85fcfb8c5efd..6740362215fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -380,7 +380,6 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
 			 struct list_head *validated,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f29b3932e3dc..7c9c3295748a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1001,11 +1001,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
-		if (pdd->drm_file) {
-			amdgpu_amdkfd_gpuvm_release_process_vm(
-					pdd->dev->adev, pdd->drm_priv);
+		if (pdd->drm_file)
 			fput(pdd->drm_file);
-		}
 
 		if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
 			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
-- 
2.25.1

