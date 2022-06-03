Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB0EC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 18:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C9E11221C;
	Fri,  3 Jun 2022 18:50:49 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63BE11221C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 18:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDxM7I+Wtw69SmuIbj+oo9k6oXISZVczGorY7GwjRlL9xbr+1A2FajDJR5CaWB+P9xyki7idjr0ZRysmxE4BnHojQCDfMyy+uxuD1q//PTAdoxFsothBWudH+Kg9LVQm0BHpChVNQUjdJl1VRn0gYcT/+8quLyVNJdus3gFmSOMdUfsNXkadamduyLWe8nxGtxddF6eNhvhzkuccI/EwAu5ZN1LOL5copDOsMLkE17GIqnAgFyMfoS2bMOHtAymwD0z2ezuNQbgLWnoF8wkZSewyFWIz08uqQPGMzXHKCZItXGD1rKu4yo7nVRsNr/H7vFIt99m7LVpP5xkyDddPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aem/NfeXZ5NT9f1MDcRKQ/21+kXGO+n/UrSFMytNwRM=;
 b=VjNerFP4FmqPe2EjPan+soJ+QnMwe8IfkzuvTPzCOSAkWRcpX8zUhvrj8Y66or62dnQGPgFqju+IfrLDKLXjYLkHoHSMb1QfY3979ViDnyVIsMN3KDkuWyAA41ra6H9EALuPxzfwV+uqFByNZi2QwjxI17A+80qLz9L24mz2HNQs2+qgTgYSlofIRVkWZnV0xUOSVtwnEq7sie/08VcdYsPXWdOmP05PpQ3bR3bNppyls2F3Du6KfAQjgjbCIvqMoCqLVZszbY9rxVKzMmKF52Y6seRrCdAA4YXwCOhGb8keAu/Qf8bNEaa/buCeIgJNz/idd55WKuYeah1eVT7brA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aem/NfeXZ5NT9f1MDcRKQ/21+kXGO+n/UrSFMytNwRM=;
 b=It1CgAfmc5d85ViDnFt8fs7dmImhBHZvpSpqI5RgSE7MYS0xZSBXtXbaeDmStS6bMbGMktGevZ16OL04xw4nRbw67qheAZDrpRjqyIHzn3vJU8F6CshreE/RyDDIZr3r/walfgIu0djNY+JtZ+5/6XJfPRKxG91pBptWaNMKACs=
Received: from BN0PR04CA0127.namprd04.prod.outlook.com (2603:10b6:408:ed::12)
 by DM6PR12MB2652.namprd12.prod.outlook.com (2603:10b6:5:41::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 3 Jun
 2022 18:50:45 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::85) by BN0PR04CA0127.outlook.office365.com
 (2603:10b6:408:ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 18:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 18:50:44 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 13:50:44 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Document and fix GTT BO kmap API
Date: Fri, 3 Jun 2022 14:49:56 -0400
Message-ID: <20220603184956.24168-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd2348f2-c149-4534-ebf7-08da4591f756
X-MS-TrafficTypeDiagnostic: DM6PR12MB2652:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2652F3F49854E20432B23FD292A19@DM6PR12MB2652.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQi4mh3+uj6CCU9cK4VYji7W1xlPfMOhNvmREN6ea9+fdLYroJ6Ap6KbEfXTyk2BT4gmR8ywYzTm+D8dkoiZZJWsOh5f5ta11MPu5nUWYaXSqueBT1ex3UP7AubmAQfHDn0SESQ4Zh2tJdpLhaMxevyw5HhecmeEsUm3x/oT2s66t7tq/hQ3L524I/F+IbdkqgimIlkWJeR65eS6HgwHUjMtbV0zCWb7Kn2ke/mrtC2BTJSa8LC1SbJireTiVHssNQUQ9RX76SDS3OvRXMLjbrjtVXtc1LLZXGo6qUbe8AKZdaih3HMeXr4fM2fPblvz+I5wFY7V2NOaqEmE9zHoiQBL2X5VIydpBRY4hlrGy35XpNLlkTB8dMolNT3SlEXyyuR3wn7ho8eBOppAjBpp2nk13Fg1SsBTUIMM+H3wwkLn0VwN/7JbHJWVzYLeE22WEqgZTn9VUQWga8OoIksljX4XsX9XB2wyCTwmf4miDzXrW8dSwNnNmbK/QCDQ8Sfe4ODYzz4Q7Np7Jp74CNB6RkVfhXHn1DVRg0TcEi1Hhqahi/GMbB3NH4Yg4Nqo/Cku8goh1IrvlI/bkUjodnK+v0Qc0tmIKxYl1s9CEQO2GkjGHFXVfKV8OUX4wyRhNtLoifZ6Z1ItPLW/sM3xbBLIAoYgZpFSOlpAi4l97Sg2qIPDu/WaAfPU4tsfs7xg5jGpQ7CdqU41dkCENuMquLKO7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(36756003)(86362001)(83380400001)(70206006)(6666004)(1076003)(47076005)(336012)(16526019)(2616005)(186003)(82310400005)(81166007)(426003)(70586007)(8676002)(356005)(7696005)(36860700001)(2906002)(316002)(40460700003)(5660300002)(26005)(6916009)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 18:50:44.7964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2348f2-c149-4534-ebf7-08da4591f756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2652
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

Removed an unused parameter from two functions and added kernel-doc
comments.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 28 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  5 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  6 ++--
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..38c1a685cb24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -279,10 +279,9 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
-		struct kgd_mem *mem, void **kptr, uint64_t *size);
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
-		struct kgd_mem *mem);
+int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size);
+void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 054e4a76ae2e..763b9bf93671 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1942,8 +1942,21 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 	return ret;
 }
 
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
-		struct kgd_mem *mem, void **kptr, uint64_t *size)
+/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
+ *
+ * @mem: Buffer object to be mapped for CPU access
+ * @kptr[out]: pointer in kernel CPU address space
+ * @size[out]: size of the buffer
+ *
+ * Pins the BO and maps it for kernel CPU access. The eviction fence is removed
+ * from the BO, since pinned BOs cannot be evicted. The bo must remain on the
+ * validate_list, so the GPU mapping can be restored after a page table was
+ * evicted.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size)
 {
 	int ret;
 	struct amdgpu_bo *bo = mem->bo;
@@ -1994,8 +2007,15 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 	return ret;
 }
 
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
-						  struct kgd_mem *mem)
+/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
+ *
+ * @mem: Buffer object to be unmapped for CPU access
+ *
+ * Removes the kernel CPU mapping and unpins the BO. It does not restore the
+ * eviction fence, so this function should only be used for cleanup before the
+ * BO is destroyed.
+ */
+void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem->bo;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 4df9c36146ba..3942a56c28bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -377,8 +377,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 		return -EINVAL;
 	}
 
-	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->adev,
-					mem, &kern_addr, &size);
+	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(mem, &kern_addr, &size);
 	if (err) {
 		pr_err("Failed to map event page to kernel\n");
 		return err;
@@ -387,7 +386,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
 	if (err) {
 		pr_err("Failed to set event page\n");
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kfd->adev, mem);
+		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
 		return err;
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e3d64ec8c353..a13e60d48b73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -693,7 +693,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 	struct kfd_dev *dev = pdd->dev;
 
 	if (kptr) {
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(dev->adev, mem);
+		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
 		kptr = NULL;
 	}
 
@@ -733,7 +733,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
-		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev->adev,
+		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(
 				(struct kgd_mem *)*mem, kptr, NULL);
 		if (err) {
 			pr_debug("Map GTT BO to kernel failed\n");
@@ -999,7 +999,7 @@ static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
 	if (!mem)
 		goto out;
 
-	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kdev->adev, mem);
+	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
 
 out:
 	mutex_unlock(&p->mutex);
-- 
2.32.0

