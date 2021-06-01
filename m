Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D80C47092
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 22:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4D7613AD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 22:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4D7613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8EB6EB2B;
	Tue,  1 Jun 2021 22:59:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F3D6EB2B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 22:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH86Fx9eOzOoZKqdJqPaJ3OppKKzv5gGMY0YSFjhiCGL0xnyoFV+t667kxOOyY8tTUiXrxp/AMxy5bqhhUk5ofYDjJYw27WIruzrLk8wsq5CzfAk2BZVuiV5mrL6aFLIpVtOZZUxKdzA1GGGXe8bmvTN0zJZSy5VHNaTEf0hGzyGzO4OeIWr0l5AZ+shFT7Jjd8hQFhg46HxZ89P+67jEAcBPOsimx8KIJBJ6ipSsLCdPLGnkbNVF28ELL3BEc2+alMUllGk3D/FUBYK3UY2HhWazxZ+pUEQ4H1MQSF/bVXLtna47+3VV7EUG6cxxQQhrFAUjWs5vO+QxknoOJHfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLXyG4891ZoQft24BDJyImvCbtCfw54W8Pb1q6fKkZI=;
 b=HIFAiOa9wKY5Wg/V9gaHWXEz1T3sWBm71oeAtmxZVn2+04z/1vxKp3UoDL70Acwuw7T4RzApdEmmEnOZ7PLEgepG/QhSrR3AWjU9DHuMODJ2R2Dhw10NTJNMlkW6M73uyS46XVIWW0OWYN2IQj7Y27jt40NC6rss+MxjDsjFKG4guKCEaRmdgXpc5yMnWQtQMzC474St8lbPGfBhtLJ+cLS9BxKLIEQiEeY5tMvhn47niZsF/N3vPhp9JGo9aea/HrPhA1oTEylvF5aKzdrFR9xO+N+tF71Cc9oT7ZuLDrKAYRFbvJQj9EDxgnitaDxJebFHOZikSfCm7vYH9xU2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLXyG4891ZoQft24BDJyImvCbtCfw54W8Pb1q6fKkZI=;
 b=0HxKuOS+UGFPMG3Zk0LWFGFPDyk1yuVoEAekfhGY5whr2qdKCYHf77b/kIfkKfMZIz82DO8bHWQdkW2d34NWZMdp0vI3BhJZjBjRZFxcKNNiEEqCsluEqoTt7rXeezc+VU7ZW/6p2gpj/zCJdpudtDYDRiXlQeynToko/gL2W/M=
Received: from BN9PR03CA0255.namprd03.prod.outlook.com (2603:10b6:408:ff::20)
 by BN8PR12MB3010.namprd12.prod.outlook.com (2603:10b6:408:63::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 22:59:27 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::7c) by BN9PR03CA0255.outlook.office365.com
 (2603:10b6:408:ff::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 22:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 22:59:27 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 17:59:24 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdkfd: Make TLB flush conditional on mapping
Date: Tue, 1 Jun 2021 18:59:07 -0400
Message-ID: <20210601225907.749049-4-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601225907.749049-1-jinhuieric.huang@amd.com>
References: <20210601225907.749049-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30c09a54-6e1b-4b5e-c55b-08d92550e811
X-MS-TrafficTypeDiagnostic: BN8PR12MB3010:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3010AE3F57E107442F9D6D23823E9@BN8PR12MB3010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3iJtGuxXcqhf097L7B/6TQP68RdwumW38G9KU0nLow+DtxCFF+UyHzGG7/Z36RkNRjbWeK0KqBEeyEXyV77TShhz830NvDrwpgNhgEgWh8Z5sU7u7ygO1pugGvHSj1ghflQ3IUH5G+MMMnzO0nZPWmft4w3FLLnccCarTomHEgNgpw4TKb1b4Cb8n34SSXI+HUDESZqAViXDh9SGdbav04NK+Z4dsACb378bwOTeqRE7gEytAjR5531sUQ/QMlDJwLtfR/A3NG2kPK/YTMr3h32LJR0udwAMfu+6JMgB+Qj2Jxxf8nYGO7pr7K0+PTOugiyIZ1Bz7Q7Eg3WCewySxGeOEAx4YK4LV922R4/8k7+KR+6D56USaTDQcRrxF49RjFXtqkbn4VaNxxNeeTrx25GAsK1n0KsJgeiBildPaTOhcTQhMaHgkO9zmKmmuglK6cG/x5UNeD1/ca6NfaNfQRJDHm/YgeAWK0z8yztWPknkAjn6mXm3jcmRA64Zh9H6npF9eDAuCOr93x5Diu+U6pkxxY11mMcPGLyBpOaOfqaX1Sm7yeAEGAZYQ1MtjFmoV6l+HSS8Nkh4S1gPohEp5mPfcLZcNDFu03Jsamk/QjYBo4qHvlRtUiAbDtr0Re6SrpRawElrgLdlpRYJ1QJrm6m1Z+ylCyBAlUtN/legNFfxCI7myDPEPmQpgpA5tvc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(6916009)(2616005)(70586007)(7696005)(6666004)(8936002)(356005)(36756003)(1076003)(336012)(186003)(16526019)(83380400001)(5660300002)(8676002)(316002)(26005)(82310400003)(426003)(81166007)(82740400003)(478600001)(47076005)(86362001)(2906002)(4326008)(36860700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 22:59:27.0291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c09a54-6e1b-4b5e-c55b-08d92550e811
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3010
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

It is to optimize memory mapping latency, and to aviod
a page fault in a corner case of changing valid PDE into
PTE.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 ++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 25 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  3 ++-
 4 files changed, 28 insertions(+), 21 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 98f1d2b586c5..441d9ad955d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1574,6 +1574,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	long err = 0;
 	int i;
 	uint32_t *devices_arr = NULL;
+	bool *flush_tlb = false;
 
 	trace_kfd_map_memory_to_gpu_start(p);
 	dev = kfd_device_by_id(GET_GPU_ID(args->handle));
@@ -1637,7 +1638,8 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 			goto map_memory_to_gpu_failed;
 
 		err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-			peer->kgd, (struct kgd_mem *)mem, peer_pdd->drm_priv);
+			peer->kgd, (struct kgd_mem *)mem,
+			peer_pdd->drm_priv, flush_tlb);
 		if (err) {
 			pr_err("Failed to map to gpu %d/%d\n",
 			       i, args->n_devices);
@@ -1658,19 +1660,20 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	}
 
 	/* Flush TLBs after waiting for the page table updates to complete */
-	for (i = 0; i < args->n_devices; i++) {
-		peer = kfd_device_by_id(devices_arr[i]);
-		if (WARN_ON_ONCE(!peer))
-			continue;
-		peer_pdd = kfd_get_process_device_data(peer, p);
-		if (WARN_ON_ONCE(!peer_pdd))
+	if (flush_tlb) {
+		for (i = 0; i < args->n_devices; i++) {
+			peer = kfd_device_by_id(devices_arr[i]);
+			if (WARN_ON_ONCE(!peer))
 			continue;
-		if (!amdgpu_read_lock(peer->ddev, true)) {
-			kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
-			amdgpu_read_unlock(peer->ddev);
+			peer_pdd = kfd_get_process_device_data(peer, p);
+			if (WARN_ON_ONCE(!peer_pdd))
+				continue;
+			if (!amdgpu_read_lock(peer->ddev, true)) {
+				kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
+				amdgpu_read_unlock(peer->ddev);
+			}
 		}
 	}
-
 	kfree(devices_arr);
 
 	trace_kfd_map_memory_to_gpu_end(p,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 72741f6579d3..9708214116dc 100644
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
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
