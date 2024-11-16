Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AFBD68BE1
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2024 04:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF0610E185;
	Sat, 16 Nov 2024 04:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKw6vef0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88DF10E191
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2024 04:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoB5JDlsJcjlWPQ9JX6aE0aY994/4ltubo/b7KKqnZn1nA9IwJ+JOpTHJ6+rWq/FKZiZJwloPFZSzIqKGQgZEoD1O2saaqRRd8Wil1tGcS8cfBbBdS6Q2h9y6d2aXe1jh/49oVph7nD2kTdXxMfK0EsPHB+2SJanIoSM/2c6uwQuXmhDZBP/UlrUA2ySpViYDYJ3FawQTuMgiL9+YKvYt/tjyTIFa5u68Qc2fu7HOXblno6q+CZdMYJXya/RI6Sb+C5dhYm0UESPA9+rXZpiq/+re1IjdiMpiWjyw8HU0fE4xQG5RDctw5gfBmzoYZjTPZxerxfDoXMZVy3pZhU4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voi1unhV5ZNC2kgBril1DIJ0Y8bzVJLkUhFep03uWqA=;
 b=fRd5pivW+C186oeN/2aqFddiWfWP7lzpp0dL3lWUXdUKyOrdlr9AsO6Aki+agqodcWHP+lWQjRuT3yxg4gtiPR9mzzHlAFdBP3KUdaS1mft7MUnFMXp2aksKGn1IZ8DYO/XXuFIISkCegLzzui8YW8MRgP7gBTgbLKdAbc3pcYkutkRkBg+lWGqeNqdczDKXEURJwn2r4X+ocp959Gh0NsH4JKzrq4NeaGiejScxUBJ0JWVsPskiBiIEfdH0/hc+EA16QkcRSNpbU5tn5SEW0mryHdPDYJlOI6kewX+0Dnax+o6F5bLcg/8atmpH3j3kzKl+MDo0lWo1FD2Jdsw5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voi1unhV5ZNC2kgBril1DIJ0Y8bzVJLkUhFep03uWqA=;
 b=yKw6vef0TuXdYpDS2hyxPsPqgYHJDjxPdSWPbr0Ma5B1sUELwXgrqfrOQMMz1W1Xfs9wXMzYvlWoBu/RF8igP21pVOGnbZMsNytlFtM97yR4znYfUGB8B4aOSz0qNV+gr9C3eeWwYmYENFwDDLGoeNZ7ZtmityJAiPxD12/8Sxs=
Received: from MW4PR03CA0146.namprd03.prod.outlook.com (2603:10b6:303:8c::31)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Sat, 16 Nov
 2024 04:45:16 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::e) by MW4PR03CA0146.outlook.office365.com
 (2603:10b6:303:8c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Sat, 16 Nov 2024 04:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Sat, 16 Nov 2024 04:45:16 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 22:45:13 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v8 5/5] drm/amdgpu: track bo memory stats at runtime
Date: Fri, 15 Nov 2024 23:44:52 -0500
Message-ID: <20241116044452.5925-6-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241116044452.5925-1-Yunxiang.Li@amd.com>
References: <20241116044452.5925-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a6121c-2ed9-42d7-cae1-08dd05f9774d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xnhKk+Y9FomYdAjwU9eJsnzS80OBPSX4hTbPhszfvSH4bkeVTI2ogAipBrYM?=
 =?us-ascii?Q?fhx7E26uWVuZctPv9w/NnTVvA8Vp1f4BkPWzGd8pIqC4q6lGpskbNabzw2WE?=
 =?us-ascii?Q?eMCSUJ5jWRki1I4J9di+iSN6zXQSFGoMZzGQOSaYyy2U//GgHX8tZ0gjQYCG?=
 =?us-ascii?Q?hduXwdjy+dOz2S3OVo3/rIY60dxnlB/Fm1hglfSAeeqNHoADClzNfMb+kcjW?=
 =?us-ascii?Q?YnWUSvffkirtfRKRdWxJ/zdhS1B336iWB7iKJISifzTxU0MV3Wb+m40igdsE?=
 =?us-ascii?Q?SucZsBbM6g5F240hLtxe3FKTSAJNqPwH0NG2nl66OlX8JJKGwXVfoFccoHFR?=
 =?us-ascii?Q?yQa/FVoRndL4jZpjIG21m5LKh8HNMoiB5JzzKJj6Wu1ZfLqBTEqvMRNr/kR1?=
 =?us-ascii?Q?oMjcCzj+SbY4FH5409NZ0KuidHSB1Y+XVaPea81poyOjr6OtYwGLFqftkp4m?=
 =?us-ascii?Q?9VUDOKraMyF4fhx45kEJ5ziVcRQhfdHjeCHCVy9EmuohGXg8k2JOrnKHL/TA?=
 =?us-ascii?Q?r48AdmUSr5XwyvdYWLM7oWFuJgx/oiNpGyK38IfLEuI48BxUVXD2zo4OrJn/?=
 =?us-ascii?Q?ronyOfB62WFC4k2js4JpZ0N1g2q2fPFgzm3Z9ikCsZgrvhlus/TMca7tYh2t?=
 =?us-ascii?Q?NJhkaH8JYmCEUhzWXMJCcHDCdl/Lhuxl2HXR090gFrNdqXG/HTHtdWwCUPF9?=
 =?us-ascii?Q?u7Khn0prGcjrUW4YH0P8FOs5ndnCFNfJFoViPRuPP9jUhvSI9ehMc7LDbuyB?=
 =?us-ascii?Q?8StWuICPAOpCgSOhKsti+y7DzeJoSFDV6H6t5gJQ9wVtbuOp52NeFztVNOHr?=
 =?us-ascii?Q?mLeliJFxziRkr6M/JM7l816KFzOXzT6M+Eecz3ucok06HeVDmgZn83GtEkO/?=
 =?us-ascii?Q?yelawJaEGZJ4aQ5NzTES/jEtft1nrN461oHVCwZcgWJ99SN3Lc3DX/+WMLfa?=
 =?us-ascii?Q?DBkh+A7j4SOm0DL+h9i8RasF87U6eBb7AgsB3UZjUVcbf7xUDSYeiFbSGFXN?=
 =?us-ascii?Q?+UnFjET1BW8UPZRmOjfZZow5nnrnPGrHDMmO+sOkc9tchAmbaY1uC1kXFeR7?=
 =?us-ascii?Q?/WtgttIE/4p3/FM0hvN2hIGLmlaaDWlomvoHZUn/8wA/e6US55eybhHDz1QT?=
 =?us-ascii?Q?tJC0X5mAIM6R7tLzLUh0fHZAmwalmt069jn1FkZoKBZje26dPH4t3bJxY1zR?=
 =?us-ascii?Q?iChcNApk8mHbzvjxSYtzbj0j5TcxUWDRCpusmFzqAoSap88sDGCdNLoYm95N?=
 =?us-ascii?Q?Niogc0gQXNS5SPdPgPQLA3laTzSIWInEmuO52UbiD8DiN71ci4vPlz54fZ4i?=
 =?us-ascii?Q?RNUqby7zL0JQRjxNLBurft8nIvp9S5hQSf+0CL0ZvLPJnRy/5IVjxPYHSFjW?=
 =?us-ascii?Q?A5r6RaeJCJZ5NS/4pe7t2ul0Egu0hxjxbvQj6z88zn2y6T09Jg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 04:45:16.1342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a6121c-2ed9-42d7-cae1-08dd05f9774d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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
v8: implement drm-total- and drm-resident- as discussed, tweaked
amdgpu_vm_update_stats parameters, and bug fixes

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 110 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 175 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 8 files changed, 204 insertions(+), 140 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b144404902255..423cea4e571ee 100644
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
@@ -190,6 +191,14 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 	}
 }
 
+static void amdgpu_dma_buf_release(struct dma_buf *buf)
+{
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(buf->priv);
+
+	amdgpu_vm_bo_update_shared(bo, -1);
+	drm_gem_dmabuf_release(buf);
+}
+
 /**
  * amdgpu_dma_buf_begin_cpu_access - &dma_buf_ops.begin_cpu_access implementation
  * @dma_buf: Shared DMA buffer
@@ -237,7 +246,7 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
 	.unmap_dma_buf = amdgpu_dma_buf_unmap,
-	.release = drm_gem_dmabuf_release,
+	.release = amdgpu_dma_buf_release,
 	.begin_cpu_access = amdgpu_dma_buf_begin_cpu_access,
 	.mmap = drm_gem_dmabuf_mmap,
 	.vmap = drm_gem_dmabuf_vmap,
@@ -265,8 +274,10 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 		return ERR_PTR(-EPERM);
 
 	buf = drm_gem_prime_export(gobj, flags);
-	if (!IS_ERR(buf))
+	if (!IS_ERR(buf)) {
 		buf->ops = &amdgpu_dmabuf_ops;
+		amdgpu_vm_bo_update_shared(bo, +1);
+	}
 
 	return buf;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 7717e3e4f05b5..e625e2481747e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -60,7 +60,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	struct amdgpu_fpriv *fpriv = file->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
 
-	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST + 1] = { };
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST];
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index a9aaf8f7cb4f1..51205704148c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1157,7 +1157,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(abo, evict);
+	amdgpu_vm_bo_move(abo, new_mem, evict);
 
 	amdgpu_bo_kunmap(abo);
 
@@ -1170,75 +1170,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
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
@@ -1453,6 +1384,45 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 	return amdgpu_gmc_sign_extend(offset);
 }
 
+/**
+ * amdgpu_bo_mem_stats_placement - bo placement for memory accounting
+ * @bo:	the buffer object we should look at
+ *
+ * BO can have multiple preferred placements, but for the purpose of accounting
+ * we want to file it under a single placement to avoid double counting.
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
index be6769852ece4..23d2c6ab9d627 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -300,9 +300,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
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
index 2852a6064c9ac..86cb83fb2283c 100644
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
+#define __AMDGPU_PL_LAST	(TTM_PL_PRIV + 5)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d0db155a9ab7c..26effcf703d47 100644
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
@@ -310,6 +311,74 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 	spin_unlock(&vm->status_lock);
 }
 
+/**
+ * amdgpu_vm_update_shared - helper to update shared memory stat
+ * @base: base structure for tracking BO usage in a VM
+ * @sign: if we should add (+1) or subtract (-1) from the shared stat
+ *
+ * Takes the vm status_lock and updates the shared memory stat. If the basic
+ * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
+ * as well.
+ */
+static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base, int sign)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	int64_t size = sign * amdgpu_bo_size(bo);
+	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+
+	spin_lock(&vm->status_lock);
+	vm->stats[bo_memtype].drm.shared += size;
+	vm->stats[bo_memtype].drm.private -= size;
+	spin_unlock(&vm->status_lock);
+}
+
+/**
+ * amdgpu_vm_update_stats - helper to update normal memory stat
+ * @base: base structure for tracking BO usage in a VM
+ * @res:  the ttm_resource to use for the purpose of accounting, may or may not
+ *        be bo->tbo.resource
+ * @sign: if we should add (+1) or subtract (-1) from the stat
+ *
+ * Takes the vm status_lock and updates the basic memory stat. If the shared
+ * stat changed (e.g. buffer was exported) amdgpu_vm_update_shared need to be
+ * called as well.
+ */
+void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *res, int sign)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	int64_t size = sign * amdgpu_bo_size(bo);
+	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+	bool shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
+
+	spin_lock(&vm->status_lock);
+
+	/* For drm-total- and drm-shared-, BO are accounted by their preferred
+	 * placement, see also amdgpu_bo_mem_stats_placement.
+	 */
+	if (shared)
+		vm->stats[bo_memtype].drm.shared += size;
+	else
+		vm->stats[bo_memtype].drm.private += size;
+
+	if (res && res->mem_type < __AMDGPU_PL_LAST) {
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
+
+	spin_unlock(&vm->status_lock);
+}
+
 /**
  * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with the vm
  *
@@ -332,6 +401,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 		return;
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
+	amdgpu_vm_update_stats(base, bo->tbo.resource, +1);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -1082,53 +1152,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
+			  struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST])
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
+	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_LAST);
 	spin_unlock(&vm->status_lock);
 }
 
@@ -2075,6 +2103,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			if (*base != &bo_va->base)
 				continue;
 
+			amdgpu_vm_update_stats(*base, bo->tbo.resource, -1);
 			*base = bo_va->base.next;
 			break;
 		}
@@ -2140,6 +2169,22 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 	return true;
 }
 
+/**
+ * amdgpu_vm_bo_update_shared - called when bo gets shared/unshared
+ *
+ * @bo: amdgpu buffer object
+ * @sign: if we should add (+1) or subtract (-1) the memory stat
+ *
+ * Update the per VM stats for all the vm
+ */
+void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo, int sign)
+{
+	struct amdgpu_vm_bo_base *bo_base;
+
+	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next)
+		amdgpu_vm_update_shared(bo_base, sign);
+}
+
 /**
  * amdgpu_vm_bo_invalidate - mark the bo as invalid
  *
@@ -2173,6 +2218,28 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
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
+		amdgpu_vm_update_stats(bo_base, bo->tbo.resource, -1);
+		amdgpu_vm_update_stats(bo_base, new_mem, +1);
+	}
+
+	amdgpu_vm_bo_invalidate(bo, evicted);
+}
+
 /**
  * amdgpu_vm_get_block_size - calculate VM page table size as power of two
  *
@@ -2589,6 +2656,16 @@ void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = false;
 }
 
+static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm)
+{
+	for (int i = 0; i < __AMDGPU_PL_LAST; ++i) {
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
@@ -2612,7 +2689,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	amdgpu_vm_put_task_info(vm->task_info);
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
@@ -2660,6 +2736,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		}
 	}
 
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
index 6a1b344e15e1b..257cea4e4f23e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -35,6 +35,7 @@
 #include "amdgpu_sync.h"
 #include "amdgpu_ring.h"
 #include "amdgpu_ids.h"
+#include "amdgpu_ttm.h"
 
 struct drm_exec;
 
@@ -324,10 +325,7 @@ struct amdgpu_vm_fault_info {
 struct amdgpu_mem_stats {
 	struct drm_memory_stats drm;
 
-	/* buffers that requested this placement */
-	uint64_t requested;
-	/* buffers that requested this placement
-	 * but are currently evicted */
+	/* buffers that requested this placement but are currently evicted */
 	uint64_t evicted;
 };
 
@@ -345,6 +343,9 @@ struct amdgpu_vm {
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
+	/* Memory statistics for this vm, protected by the status_lock */
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST];
+
 	/* Per-VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
@@ -525,6 +526,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *new_res, int sign);
+void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo, int sign);
+void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
+		       bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
@@ -575,8 +581,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int size);
+			  struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST]);
 
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
2.34.1

