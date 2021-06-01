Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE325C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AED6136E
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AED6136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E906EACA;
	Tue,  1 Jun 2021 18:50:48 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E8316EACA
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 18:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFr84oov3vXgY4xC98R1UCA88XyKSVZw+vfp5suu4lLkZhiKeSj38Rjsnrh5z++insvI0zXog8n+Ye8kHBaGAstLSTOuRFO0pP51vXQMvHy14rxvoetuA0p7p6Bg2O/0n0tXIL5/4grRxueGTxuTUBONa1MfDfS0C0TELl5oC7jiM8Xytjik2zaZYW5RmiIIhbtw2SGzFbvnVoAf4apdGcLFXE5TQt2gwEJU9KjCTeh9M72RaHBeDWp1QsELhvNBj9sjgw877i16i6emO/dRlSfvGInnOfqFb248GM3+rNIM6WO+nz1IJDKiyHF4J9XyEfybM0KOeiXcUbCLH+SNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNW8g9FpTw2Mzr29yGw6rw7/wTFGpcuBLpMYLlG4eYw=;
 b=a9TseWHh/1oH94iyZP6UyO6XjNxMkEAxCEmDNuGaU5BFtRecy/3av891ZgcPDEPeVrzknsERGThlBU4x9n9snf1M1suXl7jaUWraJcepzbVSuVKY2cs/WSV4jLLiJ1y6mHRwSKVioDCO+s4hsf63Pd5OeA5Ld/lUt91zjCqb/VUv07f5yP3oKNraEfz4R7R3uOiXKlsS6Jmq1lmnJJBBrfGJIV4GaBSfpQ9O4IJe27RQyDMZjFM3mce96zF13t2naLv7nrkk/MRIeMvXf1IMQtT3ZcqQ1GFQyj3dElTLTYqn5G7oU0l9PCkmF8hWgJnt+VgvvaEBAISsqKC1fYOAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNW8g9FpTw2Mzr29yGw6rw7/wTFGpcuBLpMYLlG4eYw=;
 b=5caJDpQdeT27f5yFD57NS5MLcZi0GfGjMWxA2vrzeDPA/0/UYTsjlcS460O6sRDCmi7PMymw9xnBynqWN4RVfBZpAKgqoBXniNxeUtRBGQRkkB7+7awPqcC1C5qV9Ru8dTrgaBmPPxykW3WYNg79yY0/MlGGOaEjy6YRiWe19kU=
Received: from BN0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:408:ec::11)
 by BYAPR12MB4744.namprd12.prod.outlook.com (2603:10b6:a03:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 18:50:45 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::37) by BN0PR04CA0096.outlook.office365.com
 (2603:10b6:408:ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 18:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 18:50:44 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:50:44 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: optimize memory mapping latency
Date: Tue, 1 Jun 2021 14:50:26 -0400
Message-ID: <20210601185026.673275-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50a6e6f-3a79-4c1e-9576-08d9252e29ca
X-MS-TrafficTypeDiagnostic: BYAPR12MB4744:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4744E1D104D5DCBE5C156D92823E9@BYAPR12MB4744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nB/vM2VSQ0rMGh4x60pk2hn0DR9AiahGxi1TUarh2pmRPeNUsWaHfh1rHEDs+8gLdSwWNzXmzsBvTD09pBkkfHEXKKF78WahZhbfpBoMGQL3ApREq87Ui7Bk8n/E/ZYguoaXiYLQfwfIkHkxo+8qIKWntvwheZx/tbqdl06K1xVIP3YWpG9V5KDj0kjDdG67sO/JHyZaSOi8g9SjGYF8roiAJ3f/qXDwfufXQoKGGGptemBErMicbcUvDomG42afLNYElJT8jUhdvDdtixsj2LFITQc4FO+9gMkHQ3OQk/ME7yvYhGE4pf6L9Qeqqz2oicyMEDvweuVyuLy+XJpusJqsJWOIWAWCKz2OnG6RXQ449TXYu9UTJzb8qcoYogRIY+5IkBmHY392pt5BDmr0zytXB/8Dj86P+XrhQ9hsbSYD2ZAhZg5fWJdeqXQMJL3HxRRQnEIIpb0UkfBu9wrWZEDjXBkB3+1ZbyYu0eegBrseaklRI9xdGQF71pgtr4O0tEEn7n62kj4hixoB2LoNKGUuSz4V+IumPHdOrkzGov0UKryQsgSBMZCbYM344NfsNKxfXKvuQWRDbwOca/3/amFIbFAvvi5EdM6YDp0VKt1tfN/KeOCHuFQ6GNfLwF5vQq2vF7ILhjWhxq+ZD//MrOyXKuB+x/BzAQrGkX0PHmp09vKf4zumKmYp3wy9gFTz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(136003)(346002)(376002)(46966006)(36840700001)(2906002)(82310400003)(36756003)(478600001)(6666004)(82740400003)(81166007)(16526019)(47076005)(70586007)(356005)(26005)(86362001)(5660300002)(186003)(83380400001)(1076003)(316002)(6916009)(8936002)(36860700001)(4326008)(8676002)(70206006)(2616005)(426003)(7696005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 18:50:44.9061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50a6e6f-3a79-4c1e-9576-08d9252e29ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4744
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. conditionally flush TLBs after map.
2. add heavy weight TLBs flushing after unmap.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 21 ++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 27 +++++++++++--------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 ++---
 8 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2560977760b3..8f2d6711e12f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -280,7 +280,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv,
 		uint64_t *size);
 int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv);
+		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv, bool *flush_tlb);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1fcfa172911a..14c8e23c68b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1117,7 +1117,8 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
 
 static int update_gpuvm_pte(struct kgd_mem *mem,
 			    struct kfd_mem_attachment *entry,
-			    struct amdgpu_sync *sync)
+			    struct amdgpu_sync *sync,
+			    bool *flush_tlb)
 {
 	struct amdgpu_bo_va *bo_va = entry->bo_va;
 	struct amdgpu_device *adev = entry->adev;
@@ -1127,6 +1128,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 	if (ret)
 		return ret;
 
+	bo_va->table_freed = false;
 	/* Update the page tables  */
 	ret = amdgpu_vm_bo_update(adev, bo_va, false);
 	if (ret) {
@@ -1134,13 +1136,17 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 	}
 
+	if (flush_tlb)
+		*flush_tlb = *flush_tlb || bo_va->table_freed;
+
 	return amdgpu_sync_fence(sync, bo_va->last_pt_update);
 }
 
 static int map_bo_to_gpuvm(struct kgd_mem *mem,
 			   struct kfd_mem_attachment *entry,
 			   struct amdgpu_sync *sync,
-			   bool no_update_pte)
+			   bool no_update_pte,
+			   bool *flush_tlb)
 {
 	int ret;
 
@@ -1157,7 +1163,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 	if (no_update_pte)
 		return 0;
 
-	ret = update_gpuvm_pte(mem, entry, sync);
+	ret = update_gpuvm_pte(mem, entry, sync, flush_tlb);
 	if (ret) {
 		pr_err("update_gpuvm_pte() failed\n");
 		goto update_gpuvm_pte_failed;
@@ -1687,7 +1693,8 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 }
 
 int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv)
+		struct kgd_dev *kgd, struct kgd_mem *mem,
+		void *drm_priv, bool *flush_tlb)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
@@ -1775,7 +1782,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 			 entry->va, entry->va + bo_size, entry);
 
 		ret = map_bo_to_gpuvm(mem, entry, ctx.sync,
-				      is_invalid_userptr);
+				      is_invalid_userptr, flush_tlb);
 		if (ret) {
 			pr_err("Failed to map bo to gpuvm\n");
 			goto out_unreserve;
@@ -2469,7 +2476,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 				continue;
 
 			kfd_mem_dmaunmap_attachment(mem, attachment);
-			ret = update_gpuvm_pte(mem, attachment, &sync);
+			ret = update_gpuvm_pte(mem, attachment, &sync, NULL);
 			if (ret) {
 				pr_err("%s: update PTE failed\n", __func__);
 				/* make sure this gets validated again */
@@ -2675,7 +2682,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 				continue;
 
 			kfd_mem_dmaunmap_attachment(mem, attachment);
-			ret = update_gpuvm_pte(mem, attachment, &sync_obj);
+			ret = update_gpuvm_pte(mem, attachment, &sync_obj, NULL);
 			if (ret) {
 				pr_debug("Memory eviction: update PTE failed. Try again\n");
 				goto validate_map_fail;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ba1cf66e9172..d987acfa80a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -87,6 +87,7 @@ struct amdgpu_bo_va {
 	bool				cleared;
 
 	bool				is_xgmi;
+	bool				table_freed;
 };
 
 struct amdgpu_bo {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2c20bba7dc1a..03bfa1eba196 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1887,7 +1887,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping->start,
 						mapping->last, update_flags,
 						mapping->offset, mem,
-						pages_addr, last_update, NULL,
+						pages_addr, last_update, &bo_va->table_freed,
 						vram_base_offset);
 		if (r)
 			return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 960913a35ee4..136f77cadc2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1574,6 +1574,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	long err = 0;
 	int i;
 	uint32_t *devices_arr = NULL;
+	bool flush_tlb = false;
 
 	trace_kfd_map_memory_to_gpu_start(p);
 	dev = kfd_device_by_id(GET_GPU_ID(args->handle));
@@ -1637,7 +1638,8 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 			goto map_memory_to_gpu_failed;
 
 		err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-			peer->kgd, (struct kgd_mem *)mem, peer_pdd->drm_priv);
+			peer->kgd, (struct kgd_mem *)mem,
+			peer_pdd->drm_priv, &flush_tlb);
 		if (err) {
 			pr_err("Failed to map to gpu %d/%d\n",
 			       i, args->n_devices);
@@ -1658,16 +1660,18 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	}
 
 	/* Flush TLBs after waiting for the page table updates to complete */
-	for (i = 0; i < args->n_devices; i++) {
-		peer = kfd_device_by_id(devices_arr[i]);
-		if (WARN_ON_ONCE(!peer))
-			continue;
-		peer_pdd = kfd_get_process_device_data(peer, p);
-		if (WARN_ON_ONCE(!peer_pdd))
-			continue;
-		if (!amdgpu_read_lock(peer->ddev, true)) {
-			kfd_flush_tlb(peer_pdd);
-			amdgpu_read_unlock(peer->ddev);
+	if (flush_tlb) {
+		for (i = 0; i < args->n_devices; i++) {
+			peer = kfd_device_by_id(devices_arr[i]);
+			if (WARN_ON_ONCE(!peer))
+				continue;
+			peer_pdd = kfd_get_process_device_data(peer, p);
+			if (WARN_ON_ONCE(!peer_pdd))
+				continue;
+			if (!amdgpu_read_lock(peer->ddev, true)) {
+				kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
+				amdgpu_read_unlock(peer->ddev);
+			}
 		}
 	}
 
@@ -1766,6 +1770,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			amdgpu_read_unlock(peer->ddev);
 			goto unmap_memory_from_gpu_failed;
 		}
+		kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 		amdgpu_read_unlock(peer->ddev);
 		args->n_success = i+1;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2bd621eee4e0..904b8178c1d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -278,7 +278,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			qpd->vmid,
 			qpd->page_table_base);
 	/* invalidate the VM context after pasid and vmid mapping is set up */
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
 
 	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
 		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->kgd,
@@ -314,7 +314,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 		if (flush_texture_cache_nocpsch(q->device, qpd))
 			pr_err("Failed to flush TC\n");
 
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
 
 	/* Release the vmid mapping */
 	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
@@ -885,7 +885,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 				dqm->dev->kgd,
 				qpd->vmid,
 				qpd->page_table_base);
-		kfd_flush_tlb(pdd);
+		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
 	}
 
 	/* Take a safe reference to the mm_struct, which may otherwise
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ecdd5e782b81..edce3ecf207d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1338,7 +1338,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
 
 void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
 
-void kfd_flush_tlb(struct kfd_process_device *pdd);
+void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 3995002c582b..9708214116dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -689,7 +689,8 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	if (err)
 		goto err_alloc_mem;
 
-	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd, mem, pdd->drm_priv);
+	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd, mem,
+			pdd->drm_priv, NULL);
 	if (err)
 		goto err_map_mem;
 
@@ -2159,7 +2160,7 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
 			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
 }
 
-void kfd_flush_tlb(struct kfd_process_device *pdd)
+void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 {
 	struct kfd_dev *dev = pdd->dev;
 
@@ -2172,7 +2173,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
 							pdd->qpd.vmid);
 	} else {
 		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
-					pdd->process->pasid, TLB_FLUSH_LEGACY);
+					pdd->process->pasid, type);
 	}
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
