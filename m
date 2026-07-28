Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEBCC53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 05:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D31710E05D;
	Tue, 28 Jul 2026 05:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SA0RVlwY";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A132C10E05D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 05:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOY4quA6fW6Y4zQuxPyKnGzlFZKnqoXQjFlxZcNSl7lIdz46xFjge2N2L6/+U69wrsBkhP9Gf4fyG1TLCrHsdoqsovEQzx0NUz+Jv9a5K6CvbqZTIkBPhC+RlDVWQetstD7gDW3cxP0ALLiaK2nCQd69wi7m85Oijkg52qEmOOMXGJ+6jZ0vJu6X42+urRpCf653Zi0y92VnAvWnLi5xQYyf8Q1Da75L0le4HRlYpKiMaEnuh3Zbp4Lj9qWKdpIZExNc1ltyiaMjLLvdUkCbzK0gIjEq592oQJs+ebUsghZjGdXlbnCsPlUW/mN2UJ+4dx1F6X9YmzzcHn2w/rBTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdCfVYgNQ1u79vSttJ2FU/KtyE+vwkR0GOzzaZ7xndA=;
 b=X0Sb79GYewXKx9+0ImPTOrjPQ0Y7q0GLUCqs8U1qHERgogZykcvuNs3Fzvv8vUz/xrSAit/7bfGX/Jv9vmsa2cfIReQ8cMMfAW4OwQDudE1jY3ptnhFrJpsRZhUEne88tHXtwBzZ05oCJn3jgl8a17718AM4iIL/rgpRunebF6V75tiWv9CRTsevBSptITnbKAuYSskRhTzTGuuJz5zEWZ3meWJJpqaUwZd0QDcn7foi84CNBhQnx0SnOqdIun9QiZV1/egjmvllqKUZyQUgnc6dTDxULnNRuxILr0sm4th9U091gc5wQk6oZ+HwrW31IYEWyoOmvjGP5YnSpdqwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdCfVYgNQ1u79vSttJ2FU/KtyE+vwkR0GOzzaZ7xndA=;
 b=SA0RVlwYA+IgORxhY3OUTNHBAm76nIXMLSz0fESeugGZgqGfPzFHLa6ATvUVd1HIllJfJqXA5NZHH9InYKR+jW7e4hBEeF5zfwz3VA8esysX1MqZ/tZa6/NNjFSNq3IXJTkOirBrW68wzD0YwMMEfElHzJXAH1lMFBYTaw32MP4=
Received: from CH2PR10CA0027.namprd10.prod.outlook.com (2603:10b6:610:4c::37)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:40:26 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::61) by CH2PR10CA0027.outlook.office365.com
 (2603:10b6:610:4c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 05:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Tue, 28 Jul 2026 05:40:25 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:40:23 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: skip BOs being torn down during GTT recovery
Date: Tue, 28 Jul 2026 13:40:00 +0800
Message-ID: <20260728054000.443371-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 2801d332-3122-4b3e-7eda-08deec6ab9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: FL0v8cJGclWGYQ2YHlcUofS6avuUZeZPQCem5/UO4YaZLtUpQM4m67Q0CYf6GYP/Zm9QpUDRZymccP7CdsxPDgpPKrfTzRZMjZQl9kFbSYQSkM4N2jvZA4Z0IbML5rDzn3abuZChE7pGCSVTGrJZSxf0jptmoHqzMAFY3hxXQdb6ZbjrMgja/UO4UG6r1advVSugkrz42wXC2ejEPmKLwrywE041w/ULGv954r0rLMPR8HaB+aw25i4HerPw7KsNSoCsdT96ZprhEgYsr7GsY6cMWdcYk3IW5YoyOK1xHHRX6oT0dH2doxG/c1ByMdnUBR+verNCEcSvi6OkK7IV8RLumDcpeuHytLo7lARShwIKdNpFipsc2by+5GeQRIh0bgi4eJRPl6M4TyuGHRMZsN8arh4cwSDUlNo+awqzYzetTQfY6DT16iSC73NVnDC60tw4zocYOk+B8vmy4rTht04D0d+eICUZxz7j4t9tszMwn8yN/Xfs6q7cNjtg+lawzaFCDl810E8XsB/4Q8F1Fbz/5FTxdcUPPLsRoD6PJ8tI/2XM+6NjfVd7yCe6Iiz/im5na8s1n5/JCVvHb0TDHv/MwoGPJOtnnEp9pWFFALHUl2vJIOY1ANXNhtNMDZclfl/xlPZWCMYcUDDpfG9ezEfi7zujOjetkOd/5LqxFm+KvsQbvc1delbIrpTXoK8jTpCQ7fqr1pXbpIYwicVgGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5QoD3wrW7AeW/jZIpGCORFfMzl6n8vW6iFIynxlrWt7he5jLdNgddifRvX3P0Hfj/+4Q/y1v18tp92StDit34rlv1i+KLE7CsOq12GW6QiDZAGvF7wewnT+NBvHwV+YLXXSJHip0turBZ10Dz3ZkVyuRQulu7Ys3oGvZ3RIgk/cgiqHM8r05Y9ocvo92vOxqrIFq23G2+PmzyPOozQu9lC3QnltcqfA3x3kGH4T8o2TrIpq+TZk79eWhat0A4qxiwCdWCgzQhwHGqJjR4ua+y9Ynwf7+G7UzWcog3ECfFNDktlVAxn//FcA6TfIraV6aSrEZqpsvAd7BtH1lIsCK/55uMCXmdqQXgl7LmAnsmGehEe4j2o/PpFz4dl3t7QyVQip5WBKCnD4N9LpX0Bm876Z0R+ECK0Nh28uFNryWdTs6UQEZwGVDBOpK/t0NkDIf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:40:25.7646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2801d332-3122-4b3e-7eda-08deec6ab9a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

A GPU reset can race with BO teardown after the BO's GTT resource has
been marked for deletion but before its drm_mm node is removed. In this
window, amdgpu_gtt_mgr_recover() can treat the node as a live BO and try
to restore its GART mapping while its TT backing is being destroyed.

Mark the GTT node with a dedicated teardown color from
amdgpu_bo_delete_mem_notify(). During recovery, process only nodes
colored as live BOs, leaving both teardown nodes and nodes without BOs
untouched.

This prevents reset recovery from accessing a BO whose backing storage
is no longer valid.

kernel: amdgpu 0000:a3:00.0: GPU reset succeeded, trying to resume
kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
kernel: #PF: supervisor read access in kernel mode
kernel: #PF: error_code(0x0000) - not-present page
kernel: PGD 62256dd067 P4D 0
kernel: Oops: Oops: 0000 [#1] SMP NOPTI
kernel: CPU: 378 UID: 0 PID: 3775143 Comm: kworker/u1536:4 Tainted: G        W  OE       6.17.0-35-generic #35~24.04.1-Ubuntu PREEMPT(voluntary)
kernel: Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
kernel: Hardware name: Supermicro AS -4125GS-TNRT/H13DSG-O-CPU, BIOS 3.8a 11/01/2025
kernel: Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]
kernel: RIP: 0010:amdgpu_gart_map+0x60/0xc0 [amdgpu]
kernel: Code: 71 98 c3 48 89 45 d0 31 c0 c7 45 cc 00 00 00 00 e8 25 4b 9e c1 84 c0 74 39 48 89 d8 48 c1 e8 0c 89 c3 45 85 e4 74 23 41 01 c4 <49> 8b 0e 4c 8b 45 c0 89 da 4c 89 fe 4c 89 ef 83 c3 01 49 83 c6 08
kernel: RSP: 0018:ff4f7e3af8a1fb18 EFLAGS: 00010206
kernel: RAX: 00000000000002b6 RBX: 00000000000002b6 RCX: 0000000000000000
kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
kernel: RBP: ff4f7e3af8a1fb58 R08: 80c0000000000073 R09: ff4f7e4ad6b00000
kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000002b7
kernel: R13: ff2209225a000000 R14: 0000000000000000 R15: ff4f7e4ad6b00000
kernel: FS:  0000000000000000(0000) GS:ff22098108562000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000000 CR3: 00000064b7011002 CR4: 0000000000f71ef0
kernel: PKRU: 55555554
kernel: Call Trace:
kernel:  <TASK>
kernel:  amdgpu_gart_bind+0x1a/0x50 [amdgpu]
kernel:  amdgpu_ttm_gart_bind+0xd8/0xe0 [amdgpu]
kernel:  amdgpu_ttm_recover_gart+0x5f/0x80 [amdgpu]
kernel:  amdgpu_gtt_mgr_recover+0x43/0x70 [amdgpu]
kernel:  gmc_v12_0_hw_init+0x46/0x160 [amdgpu]
kernel:  gmc_v12_0_resume+0x14/0x40 [amdgpu]
kernel:  amdgpu_ip_block_resume+0x24/0x80 [amdgpu]
kernel:  amdgpu_device_ip_resume_phase1+0xce/0x180 [amdgpu]
kernel:  amdgpu_device_reinit_after_reset+0x13d/0x340 [amdgpu]
kernel:  amdgpu_do_asic_reset.part.0+0x56/0x1b0 [amdgpu]
kernel:  amdgpu_device_asic_reset+0x426/0x640 [amdgpu]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  amdgpu_device_gpu_recover+0x260/0x410 [amdgpu]
kernel:  amdgpu_debugfs_reset_work+0x68/0x90 [amdgpu]
kernel:  process_one_work+0x18e/0x3e0
kernel:  worker_thread+0x2e3/0x420
kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __pfx_worker_thread+0x10/0x10
kernel:  kthread+0x10a/0x230
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x121/0x140
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork_asm+0x1a/0x30
kernel:  </TASK>

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 36 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 0ea32561c4bc..1f9063b30526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -26,7 +26,9 @@
 
 #include "amdgpu.h"
 
+#define GART_ENTRY_BO_COLOR		0
 #define GART_ENTRY_WITHOUT_BO_COLOR	1
+#define GART_ENTRY_BO_TEARDOWN_COLOR	2
 
 static inline struct amdgpu_gtt_mgr *
 to_gtt_mgr(struct ttm_resource_manager *man)
@@ -102,6 +104,35 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *res)
 	return drm_mm_node_allocated(&node->mm_nodes[0]);
 }
 
+/**
+ * amdgpu_gtt_mgr_mark_bo_teardown - exclude a BO from GART recovery
+ *
+ * @tbo: TTM BO whose TT backing is about to be destroyed
+ *
+ * Keep the GART range allocated until the resource is freed, but prevent
+ * reset recovery from using the BO after TT teardown has started.
+ */
+void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
+	struct ttm_resource *res = tbo->resource;
+	struct ttm_range_mgr_node *node;
+	struct amdgpu_gtt_mgr *mgr;
+
+	dma_resv_assert_held(tbo->base.resv);
+
+	if (!res || res->mem_type != TTM_PL_TT)
+		return;
+
+	node = to_ttm_range_mgr_node(res);
+	mgr = &adev->mman.gtt_mgr;
+
+	spin_lock(&mgr->lock);
+	if (drm_mm_node_allocated(&node->mm_nodes[0]))
+		node->mm_nodes[0].color = GART_ENTRY_BO_TEARDOWN_COLOR;
+	spin_unlock(&mgr->lock);
+}
+
 /**
  * amdgpu_gtt_mgr_new - allocate a new node
  *
@@ -137,7 +168,8 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
 		spin_lock(&mgr->lock);
 		r = drm_mm_insert_node_in_range(&mgr->mm, &node->mm_nodes[0],
 						num_pages, tbo->page_alignment,
-						0, place->fpfn, place->lpfn,
+						GART_ENTRY_BO_COLOR,
+						place->fpfn, place->lpfn,
 						DRM_MM_INSERT_BEST);
 		spin_unlock(&mgr->lock);
 		if (unlikely(r))
@@ -248,7 +280,7 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
 	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
 	spin_lock(&mgr->lock);
 	drm_mm_for_each_node(mm_node, &mgr->mm) {
-		if (mm_node->color == GART_ENTRY_WITHOUT_BO_COLOR)
+		if (mm_node->color != GART_ENTRY_BO_COLOR)
 			continue;
 
 		node = container_of(mm_node, typeof(*node), mm_nodes[0]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5fe29e4972d8..6fa8301b8ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1676,6 +1676,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
+	amdgpu_gtt_mgr_mark_bo_teardown(bo);
 	amdgpu_bo_move_notify(bo, false, NULL);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index ff9e2e346609..af1e7fcc7175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -145,6 +145,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
+void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
 
 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
-- 
2.43.0

