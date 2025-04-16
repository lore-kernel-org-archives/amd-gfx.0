Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850DFC369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 08:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CB910E897;
	Wed, 16 Apr 2025 08:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A88KkV+V";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04C810E897
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 08:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwC9eDE/kF5va6U5PRcBW9EgNm0eA7UFIfnWsqpw7qNctgoZnuKTQON3EVwVTe8SGzwlQdWy1xPLeYOOMuy4mP3UgQKKW06oR2fWg7Cu8pbmu83RoRI5vRMjxwk32ea66WE0JhcBuKZ0m7mp4NhmtjrcF9tasF8oKrP1Lcy80jMNPlV07ybIee5CAuiS/w9cn2Y7Gg5E48AvoE63jBe1GVtSDuDx3TVKPLJW/T0TwQgg3D4IhWKK0IR2WwIkO3SbPW0Q7rSI8aAjk6yGEnhpj+surhV+/WhRNLSw2yEtH8JQg5IGfSox60EYWSVIkKv9YlRcIkDaee0YmyFv7z7gsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGCZj8nxER6FE6KGwZlx+jFAUeIiiWxo5XYeE1ZehHs=;
 b=psBq2ZKtC8DLvNs+H/UWU8Py2oRKBqBIHCqb4WK+4lXramuD7duEqiCJeCrYRdG17amGV/Hx28qE84cTQGHE/WpGkrUzkbopxTpBEqavmINCqHTW5m3Gi9S85Jh+WvJyLYr8ebZ7mdhKDtVCxTwKEzC4KCkGKlVxjeZLuWSrXWIP8m5MuPqOzWBWiO/U39WNG1HOjl0QBDUoINA7GzKoP8WQcaSp0ELk7snRq5kBFPlDpTJZjSIbTwsAYHJW3p99fRk9OizZ/RWXLUn32KSa55f3hOnOS8UF/g3QNxPdz0UrRKO4bx+sT83l0pCsB1SV55IUchRWeaTa4DKzDeNbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGCZj8nxER6FE6KGwZlx+jFAUeIiiWxo5XYeE1ZehHs=;
 b=A88KkV+VCxRqDOtHs+fZsqGCADcMVng5T0ggj8AL+crZSkemoXhBKYjcgMD1G5nhXDtrPXfY8oFcMH8xnTMYrKWCv/UZVy2t8UrIiq2k3vsHqRnEXKI1jVuwtozUN+jYbWIz0Im5dVfIzxTwbolt6q31v76zyUU+fhZPfl229kU=
Received: from BN8PR15CA0005.namprd15.prod.outlook.com (2603:10b6:408:c0::18)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 08:50:41 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::26) by BN8PR15CA0005.outlook.office365.com
 (2603:10b6:408:c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 08:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 08:50:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 03:50:39 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add the evf attached gem obj resv dump
Date: Wed, 16 Apr 2025 16:50:26 +0800
Message-ID: <20250416085029.2278563-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: e91e2de5-ea38-4d4b-3240-08dd7cc3c46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dtVHjG/PfcOO7WtNd/T9F4xL+vO2MDNj3GrQGOfZdf3cPZ4WvPfW1wq827my?=
 =?us-ascii?Q?BBJdlLd43c7eZGkfyGVpwQmw3f+5/4ycMTXlsPsh9EmF0yOERXp/DYOnkQYQ?=
 =?us-ascii?Q?dJmJDF8Z0h+Vaju9wljqkeBE4gJGPRwI2i7K5InsMDQmsJi8fiVXCS9yBdBA?=
 =?us-ascii?Q?KdNSJy/P5T3WVdXRpZWr5yvE3CjqVAty42FyszFhkh0wrvJTg57ZfVUoS/tq?=
 =?us-ascii?Q?0srPXXlvuMLUCoE5bXq0eH4xE7wcrNQf1mlYSt8O2ferG5D0E4lxcy3xzxmn?=
 =?us-ascii?Q?lvOsAl/tTX2EbTqWOh69hq66F8zS/n68LC/i9/h/M/vekab+koALrvYC3ueV?=
 =?us-ascii?Q?MSElZcN0OhEll9018mXASgVvXmJGcEJ/3WClOmH7gaif66GCz9vId3AFqUQt?=
 =?us-ascii?Q?H1YOgpt9ehgqaDx7b4G/Ng5WKybFYbeNmBmYeGndKWdbTAs9FOt6blPVPjvr?=
 =?us-ascii?Q?W/B1bKvc39J5MZDQHnXxi53ZuKAG1tNPgnpQhGDiQLvbqlLiI36GSqgYX1vx?=
 =?us-ascii?Q?M1B86ps0DWZxBTgXKpAJh1eZA0+izt4q/5ny8+EQklqeJdpKenCs+pGGXAfM?=
 =?us-ascii?Q?FjfBbHY/9Yu8sguRGw5alW1gCkBPmwbGYh0Q+RCxdk0j5oYipACS0v88PXHa?=
 =?us-ascii?Q?FtvT07QmATjdVGV3rUtz42Lm4mPcpGWB/hB2WaQ2KAMe3OH7c6vT56CgRSHX?=
 =?us-ascii?Q?QHnfrBa6C+UZTvrhtz57MfDULwAHjjull0+zRfZd8Z40fq23O2GLRef9dgG4?=
 =?us-ascii?Q?j5hDxIFi7rwmv/n5ybnS+NHlV+gJYR2yF26vCGfi8U4dxXi0JxIQSON/E6eA?=
 =?us-ascii?Q?yJZSXCb14pJUwfhDPkxbuCSfbLUfX3NIR47GkowJ+69HUenkxHrncDFZs7Xv?=
 =?us-ascii?Q?2FGMa0cQj3WTb6Ec3mVs9R2zMqDe2Mrgk8mIiIxx1KvykfvPFlcltFxFgrFY?=
 =?us-ascii?Q?7d1AT6LuHCRRSxHc7tGJYDSI8Ij1fIxMAw2wgn3qEH0RT/pco9CGD/O3dlGb?=
 =?us-ascii?Q?k9F2uJQbB1dYRGD3HvrSSyfrx7T9Pc4jKVWcA6Pi8iSoKCqVsxR0C/gj/LXW?=
 =?us-ascii?Q?HaCwStoZ38S5fM1RbSqMdbJWx/mu/qbzr4iDz5gxZTKjg4+w6AAbJNFvTRF2?=
 =?us-ascii?Q?4AVzV0vYHoC1ky+EAmRBBpMInPMlzbLXwO5h97klfxO/83ZLt+zHeak3lZ4N?=
 =?us-ascii?Q?wJLJILcRjbl8u+JClrZYIIWiPdm9v0LK2Z9PxDyMYpwaw02Rf7Hy/qguWNqZ?=
 =?us-ascii?Q?inrweKYYYPucKCdbsbhAnq/k1lxqmWZBWx9M9EcR9Yg92F2yrbLM4Qkse1XU?=
 =?us-ascii?Q?ykuiD8t0WQo2QW+gZ6URak/S5yglbXBQCpGqD3w2loHqwrhSzSeNNsd40xyt?=
 =?us-ascii?Q?yQPpCnJyMISfOEStrzJjZCuIEiP9HmEChY0QmuH7Lbf5J+4tzefql4lvJugY?=
 =?us-ascii?Q?kQD3r6oWHQDnUX/00XcwYAM3hxePAaq05ZXxkA2Ux727wYDvw1NRZCbNhFxv?=
 =?us-ascii?Q?R6uyKHWNCBRIfIoTgGn98bqoXxs/C5yb4xqD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:50:41.2098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91e2de5-ea38-4d4b-3240-08dd7cc3c46f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

This debug dump will help on debugging the evf attached gem obj fence
related issue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  6 +++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 0075469550b0..7030d721196b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -86,6 +86,19 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 		if (ret) {
 			DRM_ERROR("Failed to attch new eviction fence\n");
 			goto free_err;
+		} else {
+			struct dma_resv_iter cursor;
+			struct dma_fence *fence;
+			static const char *usage[] = { "kernel", "write", "read", "bookkeep" };
+
+			dma_resv_for_each_fence(&cursor, obj->resv, DMA_RESV_USAGE_READ, fence) {
+				DRM_DEBUG("after attach evf the resv dump usage:%s\n"
+					   "after attach evf name:%s timeline name:%s seq:%lld %ssingned\n",
+					usage[dma_resv_iter_usage(&cursor)],
+					fence->ops->get_driver_name(fence),
+					fence->ops->get_timeline_name(fence), fence->seqno,
+					dma_fence_is_signaled(fence) ? "" : "un");
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d09db052e282..1e73ce30d4d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1675,7 +1675,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
 	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
 	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
-
+	/* Add the gem obj resv fence dump*/
+	if (dma_resv_trylock(bo->tbo.base.resv)) {
+		dma_resv_describe(bo->tbo.base.resv, m);
+		dma_resv_unlock(bo->tbo.base.resv);
+	}
 	seq_puts(m, "\n");
 
 	return size;
-- 
2.34.1

