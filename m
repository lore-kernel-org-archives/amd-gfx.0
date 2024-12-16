Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF72E77180
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 17:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE0910E732;
	Mon, 16 Dec 2024 17:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KADxIlA6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E669010E732
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 17:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lef6XHdO8UoUOGZCY4/pJRZ0zkdZ/igV0biZx5Q5A4SUOnK2wvFp8dmshYtfeWSDYkzsYaYJ0R56KRxJ/091slfBPbpzvGZObb6LfGrGM3Wlp8VehBhMzvn7g6s2q85DNtjiVi93x4QCft8RLKx+h52FqsV7lAMap3nLKrN0zsrqi/XTn0C5sJv2RwnCtxVHhD+X0NyTXP3RRq+2xSfd+QbAyaD8FbhMPJzElk6fxzaE0SBIwZKKBBEPCfBy7RIornAVAiiw9sd9mghWGwmtFakC0lyeivDzGK/e/MtPsUgGGFuqD4Su4CU26llpHHewaQ0/Bcyy5qFXngbTWRTeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq1WOqDxtN3X4YV7+lUfcO9KG3V556Anj0rY44d+Kw4=;
 b=JLiTRtkPFOnQ/aLQ06D7QHn9i1GLQ6o5wUJ7SKdjkz+TyHb56YCVo00UxZQB6bSwv2wCYUqsblrrOz86q0u1cYyu8nyjl9t+Wh0mZM41zHOcRdeTqvkir8MUbAfYZj5YkdcBVYK4LOLtp53Seik/Vhd4vtRqaDP23vv15BNLjCGFCU5gRSDay9f6GotDK2vvLRgi0JAvzr55KO37S/GcgllM7uumcqQRGCqqeuRbRT4dft48j2tRg6lcYzHpFEZ+2KVkmghyVDcnkEHXL9jkvLmqkjxP1Tzm7gs9e6xGSXn1Ff3sgg4mwcGZVNNweusxy9ewjAdU9uBlxj9Ir6MaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq1WOqDxtN3X4YV7+lUfcO9KG3V556Anj0rY44d+Kw4=;
 b=KADxIlA6ZxNlYBc2L5JWQEw+KlN/IU3mEVx5U6CsTLSBIZQ3UDkyMufOWPqfOyQEaGXnGsnqx0S6R9siYCfMhDoMVRLDmSsWpTMwpDir30+LMHH5GgoGNsW2hHQ+mR6vvV3gxv5SPG7XCSmA3+2g4W1hVDyvsc0R/F5ay3lVAx0=
Received: from MN0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::6)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 17:49:36 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::42) by MN0P220CA0014.outlook.office365.com
 (2603:10b6:208:52e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 17:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 17:49:35 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 11:49:34 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v12 5/5] drm/amdgpu: track bo memory stats at runtime
Date: Mon, 16 Dec 2024 12:49:24 -0500
Message-ID: <20241216174924.2292-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <868538e7-fb2f-4f75-8a7c-a995a733e8b0@amd.com>
References: <868538e7-fb2f-4f75-8a7c-a995a733e8b0@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaa0b29-337c-4230-275b-08dd1dfa0151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L3UrExfP2C2TwAXGnXOEBkydZCYU7XGzRrbEs9NfrekLrbz8DlfLWoBQ55Cc?=
 =?us-ascii?Q?AZBipR9iyCTmr68Dku5nTXDMRvgWJ/Er7PIhEBd3AbPvPwNzsGMtsvAOc4zK?=
 =?us-ascii?Q?AQFA7tJ6/KLiWNBHda3TSvIhrPj/YUmYDkxcyJI/YoVGmPFwDsEV8bqlYSWa?=
 =?us-ascii?Q?hgD/De22OW/DjPj4zja14z3YxhpRJQ0mjs+48AMEHE/mx9mdogtVvyJEg0A6?=
 =?us-ascii?Q?SvGgVnyz/1FQ280LKcnNZMw3etzGAlVLjsXO1paQEdcBAFrZOO+WiQhPJk6p?=
 =?us-ascii?Q?fi/r7NCmzxEwR8+vu0w8SHKJjV84JZ6mjBzOwJr5tzJD1gq7wD7ocbRXeDMb?=
 =?us-ascii?Q?I+8RudMUde9+rPk2pTn6WKJzP8tj4W1CWzR0S4MKuU0g+z0of9DJE/KYYzTT?=
 =?us-ascii?Q?kxIiPyvYwNNtaLJuEbN3ZJjAQnlGHfiEvrBigROWy1PA5Zl5rIMbFo2rIsVl?=
 =?us-ascii?Q?507VzeT9yrvXfyFQrumsbs/yJqiy+hCn3W5FK6QWolGvzoEL4dOui7B5ToH+?=
 =?us-ascii?Q?0bDUkGG1cXwXl+5nm7QhMBjTVRvOLHmze0TE4XWrKNa7fC1cX62qv06PklEB?=
 =?us-ascii?Q?2i0wMMvU2y99DPMaO2NY86cjeX2TQ0wnMvNJv25eWbE5WPEidmADi8h2r4lN?=
 =?us-ascii?Q?erG/f6e9HEubHNK1tbqyN8ZMkMoqVg+DUcX2RN4vmsrZQInkbdIH8Jj42LeK?=
 =?us-ascii?Q?hk7aVKVMIIkKU1j/akVCeZf/Epk2tNg/wvBJU8ovyGjNpIslG6L7gH5zr6ES?=
 =?us-ascii?Q?lND/MAN1pkizITUeJ3wdhqTnH4a4HDGE3/kRZu5tgi4T5pVs05vYcj2TOs6s?=
 =?us-ascii?Q?8VKzA/CNCcPtPO0kcolYKs8QJGJG3GLKVDtaDbKM0RAwQo7TX36Jz4mPGcuh?=
 =?us-ascii?Q?Uvx732++TYZIowWutQwcdgvjCoEqzWYqcg7ECgwLzjLK3ZfsAZSFxSVS15Df?=
 =?us-ascii?Q?T5FpeaOENSL9q2gsGtE+LeoEWaIP2TQONnr0DyzCVIGLEJWUqr24l+1XLyMQ?=
 =?us-ascii?Q?LwzXu++OJNdP0IByzxQEdwqNEZw25+AlT7hqszS2XcfVjZq6CMB8jcz/cz4R?=
 =?us-ascii?Q?mDcCh2FxEaY6tAQWAM7fllVSelW2wttKRJOtzZM3gcDiYNPJFaWg0nQgO4pj?=
 =?us-ascii?Q?xtlyamFGTU+IJVQfAimFGVrdMiMl0xBiz46L+9YW5D03ToMnd3vTsb0TBSBy?=
 =?us-ascii?Q?AnpHJCgXFrTXdIabrCpxvhceTiD7EcrP6I3WfCdZoGicuSSCZBIz5aLAl6ib?=
 =?us-ascii?Q?9aHD3oXtXh3mo1PS+izxcp8bIep7kLQRfZsovIe60QxDttyiM1c0KwEJaP0c?=
 =?us-ascii?Q?+I//pJ2DPXaL7SZY2JEcMueINJJM27EHdx4IP3xuRBfT5trHCdCIVlRbThxw?=
 =?us-ascii?Q?Rf5l5pHbPEH6u2M3Amp3IRNL4cNwfaQzoiVg06hzHbRXKlp46uutJ2hMVjeY?=
 =?us-ascii?Q?N73iH248Nq0kr0Dtg/0sZmZ4cH2w6/0Vkhxd/cxyjW3U8qDLkrjGCRr+HCZv?=
 =?us-ascii?Q?cbCldszItztgYLc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:49:35.6978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaa0b29-337c-4230-275b-08dd1dfa0151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
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

Before, every time fdinfo is queried we try to lock all the BOs in the
VM and calculate memory usage from scratch. This works okay if the
fdinfo is rarely read and the VMs don't have a ton of BOs. If either of
these conditions is not true, we get a massive performance hit.

In this new revision, we track the BOs as they change states. This way
when the fdinfo is queried we only need to take the status lock and copy
out the usage stats with minimal impact to the runtime performance. With
this new approach however, we would no longer be able to track active
buffers.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v12: call update_shared in amdgpu_dma_buf_attach

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 110 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 205 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  23 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 9 files changed, 232 insertions(+), 139 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b144404902255..9f627caedc3f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -36,6 +36,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_vm.h"
 #include <drm/amdgpu_drm.h>
 #include <drm/ttm/ttm_tt.h>
 #include <linux/dma-buf.h>
@@ -60,6 +61,8 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
+	amdgpu_vm_bo_update_shared(bo);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 7717e3e4f05b5..91d638098889d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -60,7 +60,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	struct amdgpu_fpriv *fpriv = file->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
 
-	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST + 1] = { };
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 	ktime_t usage[AMDGPU_HW_IP_NUM];
 	const char *pl_name[] = {
 		[TTM_PL_VRAM] = "vram",
@@ -72,15 +72,8 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		[AMDGPU_PL_DOORBELL] = "doorbell",
 	};
 	unsigned int hw_ip, i;
-	int ret;
-
-	ret = amdgpu_bo_reserve(vm->root.bo, false);
-	if (ret)
-		return;
-
-	amdgpu_vm_get_memory(vm, stats, ARRAY_SIZE(stats));
-	amdgpu_bo_unreserve(vm->root.bo);
 
+	amdgpu_vm_get_memory(vm, stats);
 	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
 
 	/*
@@ -97,7 +90,6 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 
 		drm_print_memory_stats(p,
 				       &stats[i].drm,
-				       DRM_GEM_OBJECT_ACTIVE |
 				       DRM_GEM_OBJECT_RESIDENT |
 				       DRM_GEM_OBJECT_PURGEABLE,
 				       pl_name[i]);
@@ -115,9 +107,11 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
 		   stats[TTM_PL_VRAM].evicted/1024UL);
 	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
-		   stats[TTM_PL_VRAM].requested/1024UL);
+		   (stats[TTM_PL_VRAM].drm.shared +
+		    stats[TTM_PL_VRAM].drm.private) / 1024UL);
 	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
-		   stats[TTM_PL_TT].requested/1024UL);
+		   (stats[TTM_PL_TT].drm.shared +
+		    stats[TTM_PL_TT].drm.private) / 1024UL);
 
 	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 		if (!usage[hw_ip])
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index fe7ae45500639..9f1382ff9d813 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -43,6 +43,7 @@
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_vm.h"
 
 static int
 amdgpu_gem_add_input_fence(struct drm_file *filp,
@@ -288,6 +289,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	if (r)
 		return r;
 
+	amdgpu_vm_bo_update_shared(abo);
 	bo_va = amdgpu_vm_bo_find(vm, abo);
 	if (!bo_va)
 		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
@@ -362,6 +364,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 		goto out_unlock;
 
 	amdgpu_vm_bo_del(adev, bo_va);
+	amdgpu_vm_bo_update_shared(bo);
 	if (!amdgpu_vm_ready(vm))
 		goto out_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 951b20e40fd35..96f4b8904e9a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1258,7 +1258,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(abo, evict);
+	amdgpu_vm_bo_move(abo, new_mem, evict);
 
 	amdgpu_bo_kunmap(abo);
 
@@ -1271,75 +1271,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			     old_mem ? old_mem->mem_type : -1);
 }
 
-void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int sz)
-{
-	const unsigned int domain_to_pl[] = {
-		[ilog2(AMDGPU_GEM_DOMAIN_CPU)]	    = TTM_PL_SYSTEM,
-		[ilog2(AMDGPU_GEM_DOMAIN_GTT)]	    = TTM_PL_TT,
-		[ilog2(AMDGPU_GEM_DOMAIN_VRAM)]	    = TTM_PL_VRAM,
-		[ilog2(AMDGPU_GEM_DOMAIN_GDS)]	    = AMDGPU_PL_GDS,
-		[ilog2(AMDGPU_GEM_DOMAIN_GWS)]	    = AMDGPU_PL_GWS,
-		[ilog2(AMDGPU_GEM_DOMAIN_OA)]	    = AMDGPU_PL_OA,
-		[ilog2(AMDGPU_GEM_DOMAIN_DOORBELL)] = AMDGPU_PL_DOORBELL,
-	};
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	struct ttm_resource *res = bo->tbo.resource;
-	struct drm_gem_object *obj = &bo->tbo.base;
-	uint64_t size = amdgpu_bo_size(bo);
-	unsigned int type;
-
-	if (!res) {
-		/*
-		 * If no backing store use one of the preferred domain for basic
-		 * stats. We take the MSB since that should give a reasonable
-		 * view.
-		 */
-		BUILD_BUG_ON(TTM_PL_VRAM < TTM_PL_TT ||
-			     TTM_PL_VRAM < TTM_PL_SYSTEM);
-		type = fls(bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK);
-		if (!type)
-			return;
-		type--;
-		if (drm_WARN_ON_ONCE(&adev->ddev,
-				     type >= ARRAY_SIZE(domain_to_pl)))
-			return;
-		type = domain_to_pl[type];
-	} else {
-		type = res->mem_type;
-	}
-
-	if (drm_WARN_ON_ONCE(&adev->ddev, type >= sz))
-		return;
-
-	/* DRM stats common fields: */
-
-	if (drm_gem_object_is_shared_for_memory_stats(obj))
-		stats[type].drm.shared += size;
-	else
-		stats[type].drm.private += size;
-
-	if (res) {
-		stats[type].drm.resident += size;
-
-		if (!dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_BOOKKEEP))
-			stats[type].drm.active += size;
-		else if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
-			stats[type].drm.purgeable += size;
-	}
-
-	/* amdgpu specific stats: */
-
-	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
-		stats[TTM_PL_VRAM].requested += size;
-		if (type != TTM_PL_VRAM)
-			stats[TTM_PL_VRAM].evicted += size;
-	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
-		stats[TTM_PL_TT].requested += size;
-	}
-}
-
 /**
  * amdgpu_bo_release_notify - notification about a BO being released
  * @bo: pointer to a buffer object
@@ -1554,6 +1485,45 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 	return amdgpu_gmc_sign_extend(offset);
 }
 
+/**
+ * amdgpu_bo_mem_stats_placement - bo placement for memory accounting
+ * @bo:	the buffer object we should look at
+ *
+ * BO can have multiple preferred placements, to avoid double counting we want
+ * to file it under a single placement for memory stats.
+ * Luckily, if we take the highest set bit in preferred_domains the result is
+ * quite sensible.
+ *
+ * Returns:
+ * Which of the placements should the BO be accounted under.
+ */
+uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo)
+{
+	uint32_t domain = bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK;
+
+	if (!domain)
+		return TTM_PL_SYSTEM;
+
+	switch (rounddown_pow_of_two(domain)) {
+	case AMDGPU_GEM_DOMAIN_CPU:
+		return TTM_PL_SYSTEM;
+	case AMDGPU_GEM_DOMAIN_GTT:
+		return TTM_PL_TT;
+	case AMDGPU_GEM_DOMAIN_VRAM:
+		return TTM_PL_VRAM;
+	case AMDGPU_GEM_DOMAIN_GDS:
+		return AMDGPU_PL_GDS;
+	case AMDGPU_GEM_DOMAIN_GWS:
+		return AMDGPU_PL_GWS;
+	case AMDGPU_GEM_DOMAIN_OA:
+		return AMDGPU_PL_OA;
+	case AMDGPU_GEM_DOMAIN_DOORBELL:
+		return AMDGPU_PL_DOORBELL;
+	default:
+		return TTM_PL_SYSTEM;
+	}
+}
+
 /**
  * amdgpu_bo_get_preferred_domain - get preferred domain
  * @adev: amdgpu device object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ab3fe7b42da7a..375448627f7bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -305,9 +305,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
-void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int size);
+uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 					    uint32_t domain);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2852a6064c9ac..461fb8090ae04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -26,15 +26,15 @@
 
 #include <linux/dma-direction.h>
 #include <drm/gpu_scheduler.h>
+#include <drm/ttm/ttm_placement.h>
 #include "amdgpu_vram_mgr.h"
-#include "amdgpu.h"
 
 #define AMDGPU_PL_GDS		(TTM_PL_PRIV + 0)
 #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
 #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
-#define __AMDGPU_PL_LAST	(TTM_PL_PRIV + 4)
+#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 5)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1adca13bfb7f7..bd206ead2e9c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -36,6 +36,7 @@
 #include <drm/ttm/ttm_tt.h>
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
+#include "amdgpu_vm.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gmc.h"
@@ -310,6 +311,111 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 	spin_unlock(&vm->status_lock);
 }
 
+/**
+ * amdgpu_vm_update_shared - helper to update shared memory stat
+ * @base: base structure for tracking BO usage in a VM
+ *
+ * Takes the vm status_lock and updates the shared memory stat. If the basic
+ * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
+ * as well.
+ */
+static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	uint64_t size = amdgpu_bo_size(bo);
+	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+	bool shared;
+
+	spin_lock(&vm->status_lock);
+	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
+	if (base->shared != shared) {
+		base->shared = shared;
+		if (shared) {
+			vm->stats[bo_memtype].drm.shared += size;
+			vm->stats[bo_memtype].drm.private -= size;
+		} else {
+			vm->stats[bo_memtype].drm.shared -= size;
+			vm->stats[bo_memtype].drm.private += size;
+		}
+	}
+	spin_unlock(&vm->status_lock);
+}
+
+/**
+ * amdgpu_vm_bo_update_shared - callback when bo gets shared/unshared
+ * @bo: amdgpu buffer object
+ *
+ * Update the per VM stats for all the vm if needed from private to shared or
+ * vice versa.
+ */
+void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
+{
+	struct amdgpu_vm_bo_base *base;
+
+	for (base = bo->vm_bo; base; base = base->next)
+		amdgpu_vm_update_shared(base);
+}
+
+/**
+ * amdgpu_vm_update_stats_locked - helper to update normal memory stat
+ * @base: base structure for tracking BO usage in a VM
+ * @res:  the ttm_resource to use for the purpose of accounting, may or may not
+ *        be bo->tbo.resource
+ * @sign: if we should add (+1) or subtract (-1) from the stat
+ *
+ * Caller need to have the vm status_lock held. Useful for when multiple update
+ * need to happen at the same time.
+ */
+static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *res, int sign)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	int64_t size = sign * amdgpu_bo_size(bo);
+	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+
+	/* For drm-total- and drm-shared-, BO are accounted by their preferred
+	 * placement, see also amdgpu_bo_mem_stats_placement.
+	 */
+	if (base->shared)
+		vm->stats[bo_memtype].drm.shared += size;
+	else
+		vm->stats[bo_memtype].drm.private += size;
+
+	if (res && res->mem_type < __AMDGPU_PL_NUM) {
+		uint32_t res_memtype = res->mem_type;
+
+		vm->stats[res_memtype].drm.resident += size;
+		/* BO only count as purgeable if it is resident,
+		 * since otherwise there's nothing to purge.
+		 */
+		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
+			vm->stats[res_memtype].drm.purgeable += size;
+		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
+			vm->stats[bo_memtype].evicted += size;
+	}
+}
+
+/**
+ * amdgpu_vm_update_stats - helper to update normal memory stat
+ * @base: base structure for tracking BO usage in a VM
+ * @res:  the ttm_resource to use for the purpose of accounting, may or may not
+ *        be bo->tbo.resource
+ * @sign: if we should add (+1) or subtract (-1) from the stat
+ *
+ * Updates the basic memory stat when bo is added/deleted/moved.
+ */
+void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *res, int sign)
+{
+	struct amdgpu_vm *vm = base->vm;
+
+	spin_lock(&vm->status_lock);
+	amdgpu_vm_update_stats_locked(base, res, sign);
+	spin_unlock(&vm->status_lock);
+}
+
 /**
  * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with the vm
  *
@@ -333,6 +439,11 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
+	spin_lock(&vm->status_lock);
+	base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
+	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
+	spin_unlock(&vm->status_lock);
+
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
 
@@ -1083,53 +1194,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
-static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
-				    struct amdgpu_mem_stats *stats,
-				    unsigned int size)
-{
-	struct amdgpu_vm *vm = bo_va->base.vm;
-	struct amdgpu_bo *bo = bo_va->base.bo;
-
-	if (!bo)
-		return;
-
-	/*
-	 * For now ignore BOs which are currently locked and potentially
-	 * changing their location.
-	 */
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
-	    !dma_resv_trylock(bo->tbo.base.resv))
-		return;
-
-	amdgpu_bo_get_memory(bo, stats, size);
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
-		dma_resv_unlock(bo->tbo.base.resv);
-}
-
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int size)
+			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
 {
-	struct amdgpu_bo_va *bo_va, *tmp;
-
 	spin_lock(&vm->status_lock);
-	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
+	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
 	spin_unlock(&vm->status_lock);
 }
 
@@ -2076,6 +2145,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			if (*base != &bo_va->base)
 				continue;
 
+			amdgpu_vm_update_stats(*base, bo->tbo.resource, -1);
 			*base = bo_va->base.next;
 			break;
 		}
@@ -2174,6 +2244,32 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 	}
 }
 
+/**
+ * amdgpu_vm_bo_move - handle BO move
+ *
+ * @bo: amdgpu buffer object
+ * @new_mem: the new placement of the BO move
+ * @evicted: is the BO evicted
+ *
+ * Update the memory stats for the new placement and mark @bo as invalid.
+ */
+void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
+		       bool evicted)
+{
+	struct amdgpu_vm_bo_base *bo_base;
+
+	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
+		struct amdgpu_vm *vm = bo_base->vm;
+
+		spin_lock(&vm->status_lock);
+		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
+		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
+		spin_unlock(&vm->status_lock);
+	}
+
+	amdgpu_vm_bo_invalidate(bo, evicted);
+}
+
 /**
  * amdgpu_vm_get_block_size - calculate VM page table size as power of two
  *
@@ -2593,6 +2689,16 @@ void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = false;
 }
 
+static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm)
+{
+	for (int i = 0; i < __AMDGPU_PL_NUM; ++i) {
+		if (!(drm_memory_stats_is_zero(&vm->stats[i].drm) &&
+		      vm->stats[i].evicted == 0))
+			return false;
+	}
+	return true;
+}
+
 /**
  * amdgpu_vm_fini - tear down a vm instance
  *
@@ -2616,7 +2722,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	amdgpu_vm_put_task_info(vm->task_info);
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
@@ -2665,6 +2770,16 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	}
 
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
+
+	if (!amdgpu_vm_stats_is_zero(vm)) {
+		struct amdgpu_task_info *ti = vm->task_info;
+
+		dev_warn(adev->dev,
+			 "VM memory stats for proc %s(%d) task %s(%d) is non-zero when fini\n",
+			 ti->process_name, ti->pid, ti->task_name, ti->tgid);
+	}
+
+	amdgpu_vm_put_task_info(vm->task_info);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 6a1b344e15e1b..a3e128e373bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -35,6 +35,7 @@
 #include "amdgpu_sync.h"
 #include "amdgpu_ring.h"
 #include "amdgpu_ids.h"
+#include "amdgpu_ttm.h"
 
 struct drm_exec;
 
@@ -202,9 +203,13 @@ struct amdgpu_vm_bo_base {
 	/* protected by bo being reserved */
 	struct amdgpu_vm_bo_base	*next;
 
-	/* protected by spinlock */
+	/* protected by vm status_lock */
 	struct list_head		vm_status;
 
+	/* if the bo is counted as shared in mem stats
+	 * protected by vm status_lock */
+	bool				shared;
+
 	/* protected by the BO being reserved */
 	bool				moved;
 };
@@ -324,10 +329,7 @@ struct amdgpu_vm_fault_info {
 struct amdgpu_mem_stats {
 	struct drm_memory_stats drm;
 
-	/* buffers that requested this placement */
-	uint64_t requested;
-	/* buffers that requested this placement
-	 * but are currently evicted */
+	/* buffers that requested this placement but are currently evicted */
 	uint64_t evicted;
 };
 
@@ -345,6 +347,9 @@ struct amdgpu_vm {
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
+	/* Memory statistics for this vm, protected by status_lock */
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
+
 	/* Per-VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
@@ -525,6 +530,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *new_res, int sign);
+void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo);
+void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
+		       bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
@@ -575,8 +585,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int size);
+			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM]);
 
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct amdgpu_bo_vm *vmbo, bool immediate);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48fa..b0bf216821152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -537,6 +537,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	if (!entry->bo)
 		return;
 
+	amdgpu_vm_update_stats(entry, entry->bo->tbo.resource, -1);
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
-- 
2.47.0

