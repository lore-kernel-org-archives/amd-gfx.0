Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24837C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 08:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB87F10E21F;
	Wed,  5 Aug 2026 08:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEuC9fLE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013031.outbound.protection.outlook.com
 [40.93.196.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AC610E21F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 08:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWu7SA/vAjhmsp3kgU/5ZCni4D/nBEULtveaXfcfavyop85wmbxI4mGTqsPcPgTWpwsxvDFSuug3Zt4npuGmVOQE4HHYid0Cnk2hbTX/y5sf7sdV14nq0s776xK7htAAhBCHOCFHsWHnlwV+pqCT8v+KGQw5StTHXB92Q0iRlq0Ihfy0buMgd/4sywl3WHC1JC34G6XLX9QRSavP64haCgm9h0+Si6wmeaHizs35XHwyejsb/Hu+DtJv8PDvaup9nLCrc5YBcH4JUjcvfaFX4QUg/iFO6Na3Nw85U8KO7PFrTRnffMphrjSQ5oNMF2Nlcw/LeFebIC8ZOCptadgY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrP2Ms+VBTX8icAxajbKeqgf9fgGY3qRPbj4PXblvNM=;
 b=J9daQFXbXHWV0NELbysQcOlx7aF3gXaZk5+QNiAaQIJVWY0y2j4pya3TgRJOnet5gOK41FbVK1lDTGAByEbikrfVpyuLT5IOiMzRtAEbjwf6Ctl1sQ2TLlSHVveyffCyD1S+RNLHbzfaMjD/PlvbOjNtydQ03m3Mqqufl5EeyLrpFcENs7rNZ/16pi0DvjoMiAT1iltz59Ix1j+5LNklQ62ToaLiJHue86vZhfUdD8pJ/KcjgjxSrxZD2eAc/cc3nipgNajzR51i0yCP5FBZf5g2FHYRsOVzVWr+TFdcYQ6NGo0RquGN6s/i47G84OFsJpRHZydFQOAdGJrkW9AOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrP2Ms+VBTX8icAxajbKeqgf9fgGY3qRPbj4PXblvNM=;
 b=bEuC9fLEWCpkv1mMJNTrVAoS/24XiSs/eMboD9aceOBW4dEyKy5hYEl1XGJpkwxq6spxvFBD+YYM+QK24fGxdCvou8blW4mHFy+SGJsYFdq8InmbkWtqPOp0GpGv6CxB2VrxDapw/dRV4Mm5akrgv+3JxAUYeg+cKI/lP6ZTGmQ=
Received: from CH0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:610:119::15)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::621) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 08:58:41 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::2a) by CH0PR03CA0364.outlook.office365.com
 (2603:10b6:610:119::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.20 via Frontend Transport; Wed, 5
 Aug 2026 08:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 08:58:40 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 03:58:38 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <David.Francis@amd.com>, <Perry.Yuan@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: skip BOs being torn down during GTT recovery
Date: Wed, 5 Aug 2026 16:58:26 +0800
Message-ID: <20260805085826.2700421-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2c1388-b768-4d39-999d-08def2cfbedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Azb4M6AloFavmk1U/IGww+OrKKDYHSJ6rrhLAnsfNmulGITuQxcee5F1w3LrQeUXj9AtIpFeuKcKF3ZXseEBG3IfMQr7eiJRRrEQ9lEwQELnvsprjMQSZcwiB43BKSou2hjiK/x1ZhHhUlw2ELbVITlHFmNF2BKYSxkHoGg28sarrPxxc6TrN1AOKsOaqkq5j3lkE5IgI6gsoDOnQkKNJTKC38SR5CbPnG83QOSjIzTcj2RkU/eEnfZ5Zv8vZVPbXe4T/VofuZLFTQbbYZt5LnAwSLgTHdvQ5DGd5v5uq6hRa0cJ63cKulDir4cWhaPIVd+WdgvP/4eLlVXTzSBuyQ4E6KzTWoimsuGtzByc3k+NWcyFL+fEthZgRMEd7g8R7DRoA3Bf841JeHE4wS3DiPCP5nqi2GuKWsX8x4wEt9fyTfsIj+gP0+kcvMHFuh1jpbDJXLcYctnmTvGrMz2sCmGh3o/qQRkZqHpU2HEt3ojJMovqr4LMKGM2wtfudT3Yjjv699sK+EQli7H5zYmW7DNRNIPipRSiUFWH+6FmgKSfbMzxph5TZxS2NwAZ3e50mFCTN935JbRSfYM+M/halZfloHJWYWyOmo/KM3TPhDYWhQEGsxhlW/grlra1AC74AFWyLbYtybQm00zJhqkcXZIDGYZAfLcCJkdvykolI0Z39VII0pNdAeeGD9HNS+f3nQTl5hQtA1EZCYUeGBnREA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6gObcscJvwA5UbyyL1Y+MRYwT6HBvBGM1B31GEuLsgq/4+h6ZQxGRBvZBwb0amYT5jrmy1ODOc+XAZD5XXZ5pXyX/gRVH6QFhnes+iJnd0oDWYfu4xCErRqxl7xN6QropjPtGq8sR4UACDkNnVhmcSArCCNRJI6m8O2fyejSnUkfXKnaBK4L5GWClKPPm5/G8cV0NQ/XKmnKEtpjHVom/ZJBnrcQRRrLLciLjDe3bAadt+HU94UXnR2RE5fyRQhgsCRNgGpqBGid5qZFZxbyAd7KV7XviWKvWXzyZ9d5p1DeTs1bTkbDJUIFG4aTgwTSUP+4CsCWGuaPMqusC5juyXPuBl9Inj0n4qVR7EzV/jS9k8MUuWCt6U36vYCK/f+joQJXiZ0t6hp7CHDTwiXOfMP3YRvUtuL0rH9lP2Sg6LMoD03yU7INNQM/XBN6oPSF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:58:40.6935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2c1388-b768-4d39-999d-08def2cfbedc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8
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

Recolor the GTT node from amdgpu_bo_delete_mem_notify() so that recovery
skips it, reusing the existing color for ranges without a BO. The range
stays allocated until the resource is freed.

This prevents reset recovery from accessing a BO whose backing storage
is no longer valid.

v2: refine commit message. (David Francis)
v3: Remove new BO color. (Christian)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 23 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 0ea32561c4bc..6219233ff712 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -102,6 +102,29 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *res)
 	return drm_mm_node_allocated(&node->mm_nodes[0]);
 }
 
+/**
+ * amdgpu_gtt_mgr_mark_bo_teardown - exclude a BO from GART recovery
+ *
+ * @tbo: TTM BO whose TT backing is about to be destroyed
+ *
+ * Keep the GART range allocated until the resource is freed, but make recovery
+ * treat it like a range without a BO so it isn't touched after TT teardown has
+ * started.
+ */
+void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
+	struct ttm_range_mgr_node *node = to_ttm_range_mgr_node(tbo->resource);
+	struct amdgpu_gtt_mgr *mgr = &adev->mman.gtt_mgr;
+
+	dma_resv_assert_held(tbo->base.resv);
+
+	spin_lock(&mgr->lock);
+	if (drm_mm_node_allocated(&node->mm_nodes[0]))
+		node->mm_nodes[0].color = GART_ENTRY_WITHOUT_BO_COLOR;
+	spin_unlock(&mgr->lock);
+}
+
 /**
  * amdgpu_gtt_mgr_new - allocate a new node
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c4094edbdff1..a9067305b26d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1694,6 +1694,9 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
+	if (bo->resource && bo->resource->mem_type == TTM_PL_TT)
+		amdgpu_gtt_mgr_mark_bo_teardown(bo);
+
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

