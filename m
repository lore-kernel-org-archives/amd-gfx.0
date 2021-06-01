Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924E9C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 21:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC94613B1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 21:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC94613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB9A6E0DD;
	Tue,  1 Jun 2021 21:30:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948976E0DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 21:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnLF8fcdE5dQReDYMbOt9NixFJxNoUAoS5/MJ+uymeKa7LP6GV8Nn+v/fcPNRiiaUuyGMnFKtibtaBbC3LLTYvOaT9WYMj6Lx1+0ii355wPQPUtQnMD+Z8GRXrIbzWsNKDYsXNkjQtcWiSJDt9cvdOhODdLOZVI+FBodHX7ggRXbREDZSdqqPvfCAx02SR0+OpTBBXD2SYrwLLu0r7XX8iNMISeCwWx8RmuOgSq/t3GNL6l7YPujrXTz8F+UukiPsC+qN2rDR9VvSOKd1DnfRCyoXEt0xIM4bRKI6VsAKSErgzcB0uEuKj8u/AXGZIMj6UWC0FMsPp5TXBpKvSmb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnZv9w9q1iiOw1cRmToO1SRR83U+AkItkkErhX/xHSU=;
 b=D01hR0/sJX90j9cI9ek9b7zKmMQZj1dfk6KtZROdQyGPGvh2q9Ptcc0o7hfrvij4V9wx2JJe3z/i5uasffZlNLHsAMfZqxDpqIc5rOmSFjGyHgHuaaebfuRXLd8CXWGNFN2BWciJd3MSaPYaXwF88+ahQTp2o1O0d5hkpl8/cG42+9Uic2eERbX3XUlo2g4F2CsnNAa3+Nevs3VFykexxsgOm2wZEMTMWOO7Q9UyyUygrJ8GhJK1n7i62I5cUVh1GKOb5/eOidd6qhVl0i3CJMtvN10ZInjSg2uT/ohtdx/pmTPFoJq/mqdC90dlBmcguSvCJ8AxfXim14GlVQ36hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnZv9w9q1iiOw1cRmToO1SRR83U+AkItkkErhX/xHSU=;
 b=qBljjzDJQFqm9TvNOt2QT0RP37OpquOJxSLqUJVzQRou5fEkOUG4jfU2l0+06NgUc2faDvyipGYL0z3MLQeYo3jBwl87rWoQa5coZwVmUb0RtbMqU+4+jIxUoYxDuvYyTkUZgiU0L54bACv5uc8tqtjmpUpayTXbxUrfb3EbBA0=
Received: from MW4PR04CA0326.namprd04.prod.outlook.com (2603:10b6:303:82::31)
 by DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 21:30:21 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::8e) by MW4PR04CA0326.outlook.office365.com
 (2603:10b6:303:82::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Tue, 1 Jun 2021 21:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 21:30:20 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 16:30:19 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: optimize memory mapping latency
Date: Tue, 1 Jun 2021 17:30:06 -0400
Message-ID: <20210601213006.737593-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20b45e9c-090c-4567-75be-08d925447577
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:
X-Microsoft-Antispam-PRVS: <DM6PR12MB336963E674F54755E059E955823E9@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/ivg/V5Fb75VUFumpkgOrdxB+qm1nb9GYpBNM5D2LRq8RAQte6HS7pyj0KDrl4wZCoZ9Zwok/9FA/WNHRj/1gXq0KtO5f0N0x/5EicWvqHvy8Us5h8bMGYOtAkkBycRZr53xgyKFiHhHAiE0DOrCoD+BAAZAVzbyg+tWHu7PbVFn+5FXNqzhi4nNYZ3UTD8YLJ44sInFVkWIwWmA3MgbHD8jt+m57S6Z5hRxwY/AGL9SBfmc8R+L7o5mzfXZy/P8oMofOqwgVUZnxkP9hJ8EX+Ew7y35E6nfQkZr4QezJoS9Tayu2eV/z0nQNNI82P0tsqgD+3ND/I0V8UOnld5rHlp8vFvquHpdplttzWxiBGdPkzPG8dcOpyWpWykqvddiVHJoJGmIel9aU6Tg+iCS6IUmNYbrVz0wTNX4403bPezOwhhpP+k5WaG83WDI/5GvED2yCXuR5xi+4/ZFGIh/gz0j3LhJdxIIVW++3SGCYzrbrO+xsJ2kM6arD3DnhjpU+cSEATwggpjUO99uA5LmMW+IOjEhlxn1LK2ZDw0d0qlmXeZnbx6pWgP4Yp5qgbnNZbXnn80nw1F1v2vdM/T3vZFXeHDYBis6/cJn1jICe5xdBr0xVuq8lQbX5JXj+gekFQFCQPJZ/+cLfu4tYVyH8bi1yWxPnRsZ/k9+wmlnSkBYdUNL+U8KNYXFhE2aOOO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(1076003)(426003)(83380400001)(2616005)(82310400003)(8676002)(86362001)(81166007)(478600001)(356005)(70586007)(70206006)(4326008)(47076005)(316002)(36756003)(336012)(6666004)(6916009)(82740400003)(5660300002)(16526019)(186003)(36860700001)(7696005)(8936002)(30864003)(2906002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 21:30:20.6803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b45e9c-090c-4567-75be-08d925447577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
2. add heavy weight TLBs flush after unmap.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 10 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 27 +++++++++++--------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 ++---
 10 files changed, 46 insertions(+), 37 deletions(-)

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
index 1fcfa172911a..585b50b6009f 100644
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
@@ -1128,7 +1129,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 
 	/* Update the page tables  */
-	ret = amdgpu_vm_bo_update(adev, bo_va, false);
+	ret = amdgpu_vm_bo_update(adev, bo_va, false, flush_tlb);
 	if (ret) {
 		pr_err("amdgpu_vm_bo_update failed\n");
 		return ret;
@@ -1140,7 +1141,8 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 static int map_bo_to_gpuvm(struct kgd_mem *mem,
 			   struct kfd_mem_attachment *entry,
 			   struct amdgpu_sync *sync,
-			   bool no_update_pte)
+			   bool no_update_pte,
+			   bool *flush_tlb)
 {
 	int ret;
 
@@ -1157,7 +1159,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 	if (no_update_pte)
 		return 0;
 
-	ret = update_gpuvm_pte(mem, entry, sync);
+	ret = update_gpuvm_pte(mem, entry, sync, flush_tlb);
 	if (ret) {
 		pr_err("update_gpuvm_pte() failed\n");
 		goto update_gpuvm_pte_failed;
@@ -1687,7 +1689,8 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 }
 
 int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv)
+		struct kgd_dev *kgd, struct kgd_mem *mem,
+		void *drm_priv, bool *flush_tlb)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
@@ -1775,7 +1778,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 			 entry->va, entry->va + bo_size, entry);
 
 		ret = map_bo_to_gpuvm(mem, entry, ctx.sync,
-				      is_invalid_userptr);
+				      is_invalid_userptr, flush_tlb);
 		if (ret) {
 			pr_err("Failed to map bo to gpuvm\n");
 			goto out_unreserve;
@@ -2469,7 +2472,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 				continue;
 
 			kfd_mem_dmaunmap_attachment(mem, attachment);
-			ret = update_gpuvm_pte(mem, attachment, &sync);
+			ret = update_gpuvm_pte(mem, attachment, &sync, NULL);
 			if (ret) {
 				pr_err("%s: update PTE failed\n", __func__);
 				/* make sure this gets validated again */
@@ -2675,7 +2678,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 				continue;
 
 			kfd_mem_dmaunmap_attachment(mem, attachment);
-			ret = update_gpuvm_pte(mem, attachment, &sync_obj);
+			ret = update_gpuvm_pte(mem, attachment, &sync_obj, NULL);
 			if (ret) {
 				pr_debug("Memory eviction: update PTE failed. Try again\n");
 				goto validate_map_fail;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e9f9f462a652..e3df132e53a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -916,7 +916,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false, NULL);
 	if (r)
 		return r;
 
@@ -927,7 +927,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
 		bo_va = fpriv->csa_va;
 		BUG_ON(!bo_va);
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 
@@ -946,7 +946,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (bo_va == NULL)
 			continue;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2120a87a949f..eac2fd0048cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -696,7 +696,7 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			goto error;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2c20bba7dc1a..fed3d44b5ded 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1729,7 +1729,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	r = vm->update_funcs->commit(&params, fence);
 
 	if (table_freed)
-		*table_freed = params.table_freed;
+		*table_freed = *table_freed || params.table_freed;
 
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
@@ -1793,7 +1793,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * 0 for success, -EINVAL for failure.
  */
 int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
-			bool clear)
+			bool clear, bool *flush_tlb)
 {
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
@@ -1887,7 +1887,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping->start,
 						mapping->last, update_flags,
 						mapping->offset, mem,
-						pages_addr, last_update, NULL,
+						pages_addr, last_update, flush_tlb,
 						vram_base_offset);
 		if (r)
 			return r;
@@ -2141,7 +2141,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 	}
@@ -2160,7 +2160,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		else
 			clear = true;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, clear);
+		r = amdgpu_vm_bo_update(adev, bo_va, clear, NULL);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 67bba8462e7d..24a63e284a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -419,7 +419,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
-			bool clear);
+			bool clear, bool *flush_tlb);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 			     struct amdgpu_bo *bo, bool evicted);
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
