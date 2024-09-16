Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F2DC3ABB2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Sep 2024 14:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0675910E38A;
	Mon, 16 Sep 2024 14:01:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ASE3uURv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E907F10E38A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 14:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXAHaSU56nF8ES9KQ/Yqs/lMLBocgmDC69lbga3dHkTSvJUnuVAV7mc7S1Rlqz00Q9EvwZjJR2fntX9UD1SOO3lC/RnOB4/ZA/k6pbR1GACIV/lVEGTDN8oyYWWHKAlVbOx7xHLfq+JCPWO4VH896U+WrZ9WbV1444RVOeh9Zt+LmacndNT+YkAyLDTkm06mbnnl5VIxzwTzkigXSuDq0UzaBfqmwYXAbXLYi7UfJKtmDwjgt9EU2kxdrlRCl9bmJA3JgLHnO7nVcssGqXMHCoUh+X+JkVcErvGhn9oM5bZVjSYtUUY4K4eSWC/rOHNAPGXck0KmAKhyqbvJnsTb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gye9RZndlP630emnQ0M45960NMnloJ5NCE8AEj9u9ds=;
 b=ZrrZr/eei+EWkKMunM1HOc6NID5pNAMAiyjAfKH/GzUpw15fN7BV6zlaEkYDiQDt5QcSwOTZmoDbRaWsfm+GWFuIby7qEDB1DB9MyeQ48Fqdx/3Pb4mY30LQ3/VSWqVBKNF9Aekk4dAXlcKeiipswR6wVstlKFi5nl+18FWiOscOjmddUacgzZ0O8ZQC51Gr1f5YwKIvNn96KyXIXuU2yNSzQGW4DXYvoxzOQKPTKjK05wkRLAAJf++ObJVUvnC3Ygjs5p3tJux/Jf3D5XAJs3ScH0ICFWhbBbqIprcUepSsid99+0IT1oFeFtXoHbkiw9QzNi2FiGZm196+sc45zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gye9RZndlP630emnQ0M45960NMnloJ5NCE8AEj9u9ds=;
 b=ASE3uURvxgELTv9T3iKQTYlruPzbEm3IYsgVEqbYgrxgkVUq2BimnMJJ+TVTtfmNbK+eG9voQS5nkLNwShJyn/h9MWIEWjxkqDCpWP34kFPn0+WZeKQA22zVA/SBpGgxto/E9QwAzf98O6CTLICyVTEOHQmKbolo9HPZ4GCohxQ=
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 14:01:00 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::35) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 14:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:01:00 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 09:00:57 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v4] drm/amdgpu: track bo memory stats at runtime
Date: Mon, 16 Sep 2024 10:00:45 -0400
Message-ID: <20240916140045.8338-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911151329.9438-3-Yunxiang.Li@amd.com>
References: <20240911151329.9438-3-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 2998393d-5f3e-4470-1b51-08dcd657fea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+kAFbtRD8enpjYuhTJIrxyfuf264WGKnrPfHoh3fc5rnQba6icG8otOB0SKw?=
 =?us-ascii?Q?9xVOw/Ao4U4N5D5dqIF/Y8kjgsPFJI9StnVXCOLCo+G0GbK1j2dvnFO++Mxc?=
 =?us-ascii?Q?yzvgMr4OJ755Lo1YD2sSiy3GPjIp7UcjRFYmZnl/fYo4vudKoiNHuSc8iDvq?=
 =?us-ascii?Q?edJv6hTEsCxshLaYF4IVgm1cc41lvCoH1aMxRA7i+oISN8CXsHSZfJOgh/kh?=
 =?us-ascii?Q?AeEhWY0z6PH49cKTdm/hoi+zQK/bRtGazgH7xVuVIpivXsFYTzXsAy+4BRUJ?=
 =?us-ascii?Q?JnuUCeGCLJIYomAN1yYafNICv7MT2yvSKvJy8mdUWLnfcgKSwZWNrLzMUYxq?=
 =?us-ascii?Q?dhvwZSj/9wem+3+uZ1ERojqwpK+27lS3wSdjTHeSsZcv1k4WCboiMOhwRo9C?=
 =?us-ascii?Q?HYn1lTOci2vzUfQm5dhK3Oa6+8M13AZs7C3TSZ5vr+VmNHz+3ixo1SisbIlw?=
 =?us-ascii?Q?RRVHOLnEl2G0yAzxyVQoMgn9V9vG0a8N/iKGNueu074yk8+SXRHoyTxr4+zY?=
 =?us-ascii?Q?Jkd7otwjmRHDTkcebfxUHhDC0F8J8VPdc7q+kXDfLEIVksAKaGvEYUuYZr6B?=
 =?us-ascii?Q?mXeCe+qX0zql3j8sy7vJWDj0WbGMtFIUn+cuQ/62KdzdxTzSuAiZsHW61w4O?=
 =?us-ascii?Q?jblqNiV3oH9bRujBv3Q/7B597r2E2zs94sBBOf+9RnaLbWhj2E2hsHO3oQv2?=
 =?us-ascii?Q?ZUPvVnkLlvnJFMu5GGD57ru5ELc9Su35oMQkXgo6N+dhlfRHIV2Mhf8JCZC9?=
 =?us-ascii?Q?OZebcUlgzU9ntw8IlpICdXYId4am+cYsfqGKDgtBiZnILL1URNwOngT5P3jz?=
 =?us-ascii?Q?7QR1saUIGWVrcE8fzgJ21rdCjbL3h2DgmWiPpg2wLVwXZ+V770ArnkS3RMDG?=
 =?us-ascii?Q?gF0kXhqgWe6dkzKkRH4zhH8BJoKNASDQsInB1YWAsiDAtwIV3UJfXOAyor7e?=
 =?us-ascii?Q?Qfl0A74Uzw0xEkvZrq5E7DIIIQQRfh6Umjmu5JpYx1EtKUBbp0k6CgpO2oSy?=
 =?us-ascii?Q?vrleHTtxdIsaWlMSvBdy7j0eOt0X9z2Qh2YKMaa5YIY74JcYJGTnt/eltwtp?=
 =?us-ascii?Q?rF819puN7R4ZgCFfW+RhnhnPPG3mYQvTImVXwFPbJpkfQMEI9NE+EvIKub0S?=
 =?us-ascii?Q?lpCUa9IEVpXX66/IGDhcBQ5FE1ig7JysplWHMzVge2Bpm1Udevyq+HqafKx+?=
 =?us-ascii?Q?HVkB4XCByukVvQ9A0jCLGFeDOE6qmEp+Q57wtlLLM1i8xDbiYLELO5H9hDM8?=
 =?us-ascii?Q?Q6AIGumedKOceVziToVBa0FrjBgvlFP9Y8qdHz+zHm8Cga22Pe7NC/id+KX3?=
 =?us-ascii?Q?onRD89yCUAkau8Kj+GkUnHrUbVM81ETSvRQl1mF0NEtJC42UAIk0wokwGsK+?=
 =?us-ascii?Q?8nnRHbtBTXSDcxnrxR2dgovkXlC/HHQ92AJs1kO6BnxXS1/ByUUb/cScpfRM?=
 =?us-ascii?Q?24Zt9QCklxXC2l/iuPAGfm4bQvJhBzyd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:01:00.0871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2998393d-5f3e-4470-1b51-08dcd657fea4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

In this new revision, we track the BOs as they change state. This way
when the fdinfo is queried we only need to take the status lock and copy
out the usage stats with minimal impact to the runtime performance.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v3: add amdgpu_vm_bo_move function instead of changing
amdgpu_vm_bo_invalidate
v4: tweak function arguments and add missing doc string

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  21 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 238 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  30 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 6 files changed, 240 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b14440490225..2486cb25f519 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -190,6 +190,13 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 	}
 }
 
+static void amdgpu_dma_buf_release(struct dma_buf *buf)
+{
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(buf->priv);
+	amdgpu_vm_bo_handle_shared(bo, -1);
+	drm_gem_dmabuf_release(buf);
+}
+
 /**
  * amdgpu_dma_buf_begin_cpu_access - &dma_buf_ops.begin_cpu_access implementation
  * @dma_buf: Shared DMA buffer
@@ -237,7 +244,7 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
 	.unmap_dma_buf = amdgpu_dma_buf_unmap,
-	.release = drm_gem_dmabuf_release,
+	.release = amdgpu_dma_buf_release,
 	.begin_cpu_access = amdgpu_dma_buf_begin_cpu_access,
 	.mmap = drm_gem_dmabuf_mmap,
 	.vmap = drm_gem_dmabuf_vmap,
@@ -265,8 +272,10 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 		return ERR_PTR(-EPERM);
 
 	buf = drm_gem_prime_export(gobj, flags);
-	if (!IS_ERR(buf))
+	if (!IS_ERR(buf)) {
 		buf->ops = &amdgpu_dmabuf_ops;
+		amdgpu_vm_bo_handle_shared(bo, +1);
+	}
 
 	return buf;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1d2929ad8cbd..0320274e4edc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -37,6 +37,7 @@
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_cache.h>
 #include "amdgpu.h"
+#include "amdgpu_vm.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
 
@@ -1265,7 +1266,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(abo, evict);
+	amdgpu_vm_bo_move(abo, new_mem, evict);
 
 	amdgpu_bo_kunmap(abo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index e14b4fbb486e..1f419274e50c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -141,27 +141,6 @@ struct amdgpu_bo_vm {
 	struct amdgpu_vm_bo_base        entries[];
 };
 
-struct amdgpu_mem_stats {
-	/* current VRAM usage */
-	uint64_t vram;
-	/* current shared VRAM usage */
-	uint64_t vram_shared;
-	/* current GTT usage */
-	uint64_t gtt;
-	/* current shared GTT usage */
-	uint64_t gtt_shared;
-	/* current system memory usage */
-	uint64_t cpu;
-	/* current shared system memory usage */
-	uint64_t cpu_shared;
-	/* sum of evicted buffers */
-	uint64_t evicted_vram;
-	/* how much userspace asked for */
-	uint64_t requested_vram;
-	/* how much userspace asked for */
-	uint64_t requested_gtt;
-};
-
 static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
 {
 	return container_of(tbo, struct amdgpu_bo, tbo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6f169e0ea30f..da6ccc30f92c 100644
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
@@ -310,6 +311,129 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 	spin_unlock(&vm->status_lock);
 }
 
+/**
+ * amdgpu_vm_stats_update_shared - helper to update shared memory stat
+ * @base: base structure for tracking BO usage in a VM
+ * @sign: if we should add (+1) or subtract (-1) the memory stat
+ *
+ * Takes the vm status_lock and updates the shared memory stat. If the basic
+ * stat changes (e.g. buffer was moved) amdgpu_vm_stats_update need to be called
+ * as well.
+ */
+static void amdgpu_vm_stats_update_shared(struct amdgpu_vm_bo_base *base, int sign)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	struct amdgpu_mem_stats *stats;
+	int64_t size;
+
+	if (!vm || !bo || !(sign == +1 || sign == -1))
+		return;
+
+	spin_lock(&vm->status_lock);
+	stats = &vm->stats;
+	size = sign * amdgpu_bo_size(bo);
+	switch (bo->tbo.resource->mem_type) {
+	case TTM_PL_VRAM:
+		stats->vram_shared += size;
+		break;
+	case TTM_PL_TT:
+		stats->gtt_shared += size;
+		break;
+	case TTM_PL_SYSTEM:
+	default: // default is taken for private placements
+		stats->cpu_shared += size;
+		break;
+	}
+	spin_unlock(&vm->status_lock);
+}
+
+/**
+ * amdgpu_vm_stats_update - helper to update normal memory stat
+ * @base: base structure for tracking BO usage in a VM
+ * @new_mem: the new placement of the BO if any (e.g. NULL when BO is deleted)
+ * @old_mem: the old placement of the BO if any (e.g. NULL when BO is created)
+ *
+ * Takes the vm status_lock and updates the basic memory stat. If the shared
+ * stat changes (e.g. buffer was exported) amdgpu_vm_stats_update_shared need to
+ * be called as well.
+ */
+void amdgpu_vm_stats_update(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *new_mem,
+			    struct ttm_resource *old_mem)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	struct amdgpu_mem_stats *stats;
+	uint64_t size;
+	bool shared;
+
+	if (!vm || !bo || (!new_mem && !old_mem))
+		return;
+	spin_lock(&vm->status_lock);
+
+	stats = &vm->stats;
+	size = amdgpu_bo_size(bo);
+	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
+
+	if (old_mem) {
+		switch (old_mem->mem_type) {
+		case TTM_PL_VRAM:
+			stats->vram -= size;
+			if (shared)
+				stats->vram_shared -= size;
+			break;
+		case TTM_PL_TT:
+			stats->gtt -= size;
+			if (shared)
+				stats->gtt_shared -= size;
+			break;
+		case TTM_PL_SYSTEM:
+		default: // default is taken for private placements
+			stats->cpu -= size;
+			if (shared)
+				stats->cpu_shared -= size;
+			break;
+		}
+	}
+	if (new_mem) {
+		switch (new_mem->mem_type) {
+		case TTM_PL_VRAM:
+			stats->vram += size;
+			if (shared)
+				stats->vram_shared += size;
+			break;
+		case TTM_PL_TT:
+			stats->gtt += size;
+			if (shared)
+				stats->gtt_shared += size;
+			break;
+		case TTM_PL_SYSTEM:
+		default: // default is taken for private placements
+			stats->cpu += size;
+			if (shared)
+				stats->cpu_shared += size;
+			break;
+		}
+	}
+	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
+		if (!old_mem)
+			stats->requested_vram += size;
+		else if (old_mem->mem_type != TTM_PL_VRAM)
+			stats->evicted_vram -= size;
+		if (!new_mem)
+			stats->requested_vram -= size;
+		else if (new_mem->mem_type != TTM_PL_VRAM)
+			stats->evicted_vram += size;
+	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
+		if (!old_mem)
+			stats->requested_gtt += size;
+		if (!new_mem)
+			stats->requested_gtt -= size;
+	}
+	spin_unlock(&vm->status_lock);
+}
+
 /**
  * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with the vm
  *
@@ -332,6 +456,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 		return;
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
+	amdgpu_vm_stats_update(base, bo->tbo.resource, NULL);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -1089,51 +1214,20 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
-static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
-				    struct amdgpu_mem_stats *stats)
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
-	amdgpu_bo_get_memory(bo, stats);
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
-		dma_resv_unlock(bo->tbo.base.resv);
-}
-
+/**
+ * amdgpu_vm_get_memory - query the current memory statistics
+ *
+ * @vm: requested vm
+ * @stats: the place to copy memory stats to
+ *
+ * Takes the vm status_lock and copies out the memory stats from the running
+ * tally.
+ */
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats *stats)
 {
-	struct amdgpu_bo_va *bo_va, *tmp;
-
 	spin_lock(&vm->status_lock);
-	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
+	*stats = vm->stats;
 	spin_unlock(&vm->status_lock);
 }
 
@@ -2070,6 +2164,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			if (*base != &bo_va->base)
 				continue;
 
+			amdgpu_vm_stats_update(*base, NULL, bo->tbo.resource);
 			*base = bo_va->base.next;
 			break;
 		}
@@ -2135,6 +2230,26 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 	return true;
 }
 
+/**
+ * amdgpu_vm_bo_handle_shared - called when bo gets shared/unshared
+ *
+ * @bo: amdgpu buffer object
+ * @sign: if we should add (+1) or subtract (-1) the memory stat
+ *
+ * For now the only thing this does is to update the per VM stats
+ */
+void amdgpu_vm_bo_handle_shared(struct amdgpu_bo *bo, int sign)
+{
+
+	struct amdgpu_vm_bo_base *bo_base;
+
+	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
+		bo = bo->parent;
+
+	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next)
+		amdgpu_vm_stats_update_shared(bo_base, sign);
+}
+
 /**
  * amdgpu_vm_bo_invalidate - mark the bo as invalid
  *
@@ -2172,6 +2287,32 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
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
+	if (new_mem) {
+		if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
+			bo = bo->parent;
+
+		for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next)
+			amdgpu_vm_stats_update(bo_base, new_mem,
+					       bo->tbo.resource);
+	}
+
+	amdgpu_vm_bo_invalidate(bo, evicted);
+}
+
 /**
  * amdgpu_vm_get_block_size - calculate VM page table size as power of two
  *
@@ -2594,6 +2735,19 @@ void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = false;
 }
 
+static int amdgpu_vm_stats_is_zero(struct amdgpu_mem_stats *stats)
+{
+	return (stats->vram == 0 &&
+		stats->vram_shared == 0 &&
+		stats->gtt == 0 &&
+		stats->gtt_shared == 0 &&
+		stats->cpu == 0 &&
+		stats->cpu_shared == 0 &&
+		stats->evicted_vram == 0 &&
+		stats->requested_vram == 0 &&
+		stats->requested_gtt == 0);
+}
+
 /**
  * amdgpu_vm_fini - tear down a vm instance
  *
@@ -2665,6 +2819,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		}
 	}
 
+	if (!amdgpu_vm_stats_is_zero(&vm->stats))
+		dev_err(adev->dev, "VM memory stats is non-zero when fini\n");
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b4424a757b38..396a4098ad0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -42,7 +42,27 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
-struct amdgpu_mem_stats;
+
+struct amdgpu_mem_stats {
+	/* current VRAM usage */
+	uint64_t vram;
+	/* current shared VRAM usage */
+	uint64_t vram_shared;
+	/* current GTT usage */
+	uint64_t gtt;
+	/* current shared GTT usage */
+	uint64_t gtt_shared;
+	/* current system memory usage */
+	uint64_t cpu;
+	/* current shared system memory usage */
+	uint64_t cpu_shared;
+	/* sum of evicted buffers */
+	uint64_t evicted_vram;
+	/* how much userspace asked for */
+	uint64_t requested_vram;
+	/* how much userspace asked for */
+	uint64_t requested_gtt;
+};
 
 /*
  * GPUVM handling
@@ -336,6 +356,8 @@ struct amdgpu_vm {
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
+	struct amdgpu_mem_stats stats;
+
 	/* Per-VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
@@ -515,7 +537,13 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
+void amdgpu_vm_stats_update(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *new_mem,
+			    struct ttm_resource *old_mem);
+void amdgpu_vm_bo_handle_shared(struct amdgpu_bo *bo, int sign);
 void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
+		       bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a076f43097e4..55a6004a226f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -586,6 +586,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	if (!entry->bo)
 		return;
 
+	amdgpu_vm_stats_update(entry, NULL, entry->bo->tbo.resource);
 	entry->bo->vm_bo = NULL;
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	if (shadow) {
-- 
2.34.1

