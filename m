Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4087EC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 14:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E6610E454;
	Mon, 24 Jun 2024 14:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KhVthqdh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B8010E263
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 14:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQbyueT/ytwEI1ZpvG8C1ZY+uKgrgTAnl+HbP8MQU960zXUUg38P7ncrmw07tRSKZpouUs2dmDwlDDJk0ZZ6egBSJfzJAx1xt/l45UdHPQKJdGlsqAmQSUnHcG4bhDpIlOGchxqlv7cBFVvnHLEMLzGdo7csATSyKCMhMmiJxiYy9hmIVSVN3A+SfXjcKukgB1Sxt0PbNgBeyDbIZU7TwuEjAjrs3SUEMh5zGlrJfRfs6I+Uzq/9Sq6ZU6c1Av9Oyi6i5OTSSMDN52DBQdcfvUg/Sx2cjiitB6l1ZHE0Faj/4iCr9LYYMWplVaqLEBcOqdw4IvDfqTR+935utaTiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCFQN0vu4kFWFuFcyD86QWqyQQi253N8zNgjxoE8FMw=;
 b=LTQmpnot2Ets9NW58vr2V3O/WwUb0ckTOQ29mV/24WxjY38T5R5K3TwQDA0NVbUWyoarK8rolotMfkVI4U3fQj3wLNZkF8/udgU2NdmJIyiktao/22ZbYQUQonlHkiTxjjpZb9ORikx0ILvL7wLVIE+xy+OSBmnhznrRfl/PLEa/op12xR0agh48lMAD1t2K7NSHyRY00qY/B0aXqtld0cv3iaeshk/yCwsEC21v6rQdlFqBmWUJpMUKdjiayvbzND9dJUkE/c3AWuhb3x19L9fZUHVCCDcnavUVZ2VLU9MARi/Dhr9+kdHNBFVQgAIpL9gombGAhreYInNaJmqBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCFQN0vu4kFWFuFcyD86QWqyQQi253N8zNgjxoE8FMw=;
 b=KhVthqdho/nMvm5cZbsSBYJUG0C86aroAsNP5m0yM9bfauIejAnfXAM0kI7Tr/6fJ6hm2aLiOyztCkt+nFnZYNsZErt7q0yZoSdvCbotyMYlK4js7CLp45oBCjYvx1kz0IJyxKBfOc5ByYI7kQLx2LIaSoMH13/YWHhhzUlW3RU=
Received: from BL1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:208:256::24)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 14:08:32 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::51) by BL1PR13CA0019.outlook.office365.com
 (2603:10b6:208:256::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Mon, 24 Jun 2024 14:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:08:32 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:08:31 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: track bo memory stats at runtime
Date: Mon, 24 Jun 2024 10:08:15 -0400
Message-ID: <20240624140815.18085-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624140815.18085-1-Yunxiang.Li@amd.com>
References: <20240624140815.18085-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 17341f2a-6f34-4764-6a5d-08dc94572153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|36860700010|376011|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ssZsonbuD9HO5EJifrGbnvWC9YEDw6b9E0GNsGzZPErSj7FZOi6DaoWi/+TL?=
 =?us-ascii?Q?i7ZLR2MoLCn8N/Zr2d7PeAqHSBjYISFATcgOm70xtU/VQtwi5/3IPVxgzdA4?=
 =?us-ascii?Q?p6FJZG8RGcsI5O31vE++byCRBikyHnTw1eKg5KCXzEJcG3nztkZG40kj4e4g?=
 =?us-ascii?Q?BePmpoRQBeOHECB2XMf8Vjytv07aQciORQysWwBiKd3UL1aA6of0L1I8oz95?=
 =?us-ascii?Q?zOUd1LeGa11HBjG1fX+qi2u80vSOHjDM9AaDQ/fFsiVTqu1oMxkOf8zXFfT0?=
 =?us-ascii?Q?DOUSzh09kyU3GBc+c0KuRQ5YSyCCU4EjvFmYz081y0T6vJhtOyswPUSycFUY?=
 =?us-ascii?Q?aST1qkoFcxt+R+EV7MguC0jE+++1oJgkJ29pRSrPkkZ6QcXgM9mSbdluC94v?=
 =?us-ascii?Q?XpSmud5o4fJPYxglquJeBhrkOdDD1F6vGuUWTojrvULGAzp20IxCuyVzd3Vm?=
 =?us-ascii?Q?9YWO+tRbsPLoOaFOUjCMbUBYSLdMNYSYK2DRzIbBx4tO2WbKxNHuFrjGLQrV?=
 =?us-ascii?Q?XGNZynLkVUGVCn8a0qoACGFX64aQ/tbw7wDPE9/6OKTqGqzfwymvkQWOlPoE?=
 =?us-ascii?Q?ShffnvqdrZ5ZAtCIff8p904zWrHdkP2/FLpm0VK21X1WmuZQ3z+GBJVNlZj2?=
 =?us-ascii?Q?lMqHK9PZBs8vGf5rYcLWO1Rtydr6oIqWuCEeGqIkABfwz3ss0sP9L8LBaUme?=
 =?us-ascii?Q?ZEPeif3LBo9J2zE5BcWnEF/O41L4xUGeYHEeYeXN9SSTOUczjah8/kMab1u7?=
 =?us-ascii?Q?tGrfysneZvfR36sQTXaGLF3prXggZWdFa9iPRXSnI60IH7frU00G7k9WHKQL?=
 =?us-ascii?Q?W1W4IefhqU/7QgAPvbMP0W78SWpgF2uwxXoRApWKDb1+X71yHu8NqZJOLPD+?=
 =?us-ascii?Q?TVIOTIZJph/2GZvfVvTBvr4jBFifOWFLzwavXOes5x2FXYsJQpXPI3ntInSX?=
 =?us-ascii?Q?sY8zFSLXlAapuXiGkDvy93V52/yWqRWSjYv0cPZGRSTLo3dEY+LYSHaVWwRo?=
 =?us-ascii?Q?kYEyUSBmILTf1myTessp+khb7a6AQROgG0CtaAuGYSGAS5L+ma8QAHjFjfhF?=
 =?us-ascii?Q?GZkTAYmPl9RNQ0a1O3620IyMiAOCAqDjEblEa+qYxouyoMB0Ut2//txdfhOc?=
 =?us-ascii?Q?lit9f6JOBwaxVViswl3syDMbfkAWGiyVMm6WeWUdgbZVIRYvFM4YpAWixNgk?=
 =?us-ascii?Q?z8frfHL34hpnm6nzbbWK6ClcvSL/irFikva3hDNMIUoKRR4g+NHziwWZ9+R6?=
 =?us-ascii?Q?OMG3zaBs7QDdz+e3uKm3VRdY5qetPY/z3bF/HkfWMFnIOHygZYY3T8U2OiaT?=
 =?us-ascii?Q?LUOtc3SOE8i3cAlLtMR6MFIY/tcD0cO3+K65zaz31NFa+/tGU7GTYjtiFirr?=
 =?us-ascii?Q?kBPls0zlAK3JeeoczWvVnDOIFDPfaKbtJybmRV/PRTHVz+ZDEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(36860700010)(376011)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:08:32.1323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17341f2a-6f34-4764-6a5d-08dc94572153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  21 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 183 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  32 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 8 files changed, 185 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ec888fc6ead8..397cb0f83811 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1166,7 +1166,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			if (!bo)
 				continue;
 
-			amdgpu_vm_bo_invalidate(adev, bo, false);
+			amdgpu_vm_bo_invalidate(bo, NULL, false);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 8e81a83d37d8..87fc3f37a1eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -190,6 +190,13 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 	}
 }
 
+static void amdgpu_dma_buf_release(struct dma_buf *buf)
+{
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(buf->priv);
+	amdgpu_vm_bo_handle_shared(bo, true);
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
+		amdgpu_vm_bo_handle_shared(bo, false);
+	}
 
 	return buf;
 }
@@ -345,7 +354,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	/* FIXME: This should be after the "if", but needs a fix to make sure
 	 * DMABuf imports are initialized in the right VM list.
 	 */
-	amdgpu_vm_bo_invalidate(adev, bo, false);
+	amdgpu_vm_bo_invalidate(bo, NULL, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 1f22b4208729..1cd28fc1dcf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -843,7 +843,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -903,7 +902,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
 
 		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
-			amdgpu_vm_bo_invalidate(adev, robj, true);
+			amdgpu_vm_bo_invalidate(robj, NULL, true);
 
 		amdgpu_bo_unreserve(robj);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index bcf25c7e85e0..469bb600bcaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -37,6 +37,7 @@
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_cache.h>
 #include "amdgpu.h"
+#include "amdgpu_vm.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
 
@@ -1258,7 +1259,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   bool evict,
 			   struct ttm_resource *new_mem)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_resource *old_mem = bo->resource;
 	struct amdgpu_bo *abo;
 
@@ -1266,7 +1266,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(adev, abo, evict);
+	amdgpu_vm_bo_invalidate(abo, new_mem, evict);
 
 	amdgpu_bo_kunmap(abo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 218919fc13ec..c65463f66cb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -135,27 +135,6 @@ struct amdgpu_bo_vm {
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
index 3abfa66d72a2..8dd239912bb9 100644
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
 
+static void amdgpu_vm_stats_update_shared(struct amdgpu_vm_bo_base *base,
+				      bool unshare)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	struct amdgpu_mem_stats *stats;
+	uint64_t size;
+
+	if (!vm || !bo)
+		return;
+
+	spin_lock(&vm->status_lock);
+	stats = &vm->stats;
+	size = amdgpu_bo_size(bo);
+	switch (bo->tbo.resource->mem_type) {
+	case TTM_PL_VRAM:
+		stats->vram_shared += unshare ? -size : size;
+		break;
+	case TTM_PL_TT:
+		stats->gtt_shared += unshare ? -size : size;
+		break;
+	case TTM_PL_SYSTEM:
+	default:
+		stats->cpu_shared += unshare ? -size : size;
+		break;
+	}
+	spin_unlock(&vm->status_lock);
+}
+
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
+		default:
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
+		default:
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
@@ -332,6 +438,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 		return;
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
+	amdgpu_vm_stats_update(base, bo->tbo.resource, NULL);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -1088,51 +1195,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
 
@@ -2043,6 +2110,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			if (*base != &bo_va->base)
 				continue;
 
+			amdgpu_vm_stats_update(*base, NULL, bo->tbo.resource);
 			*base = bo_va->base.next;
 			break;
 		}
@@ -2108,17 +2176,37 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 	return true;
 }
 
+/**
+ * amdgpu_vm_bo_handle_shared - called when bo gets shared/unshared
+ *
+ * @bo: amdgpu buffer object
+ * @unshare: bo got unshared
+ *
+ * For now the only thing this does is to update the per VM stats
+ */
+void amdgpu_vm_bo_handle_shared(struct amdgpu_bo *bo, bool unshare)
+{
+
+	struct amdgpu_vm_bo_base *bo_base;
+
+	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
+		bo = bo->parent;
+
+	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next)
+		amdgpu_vm_stats_update_shared(bo_base, unshare);
+}
+
 /**
  * amdgpu_vm_bo_invalidate - mark the bo as invalid
  *
- * @adev: amdgpu_device pointer
  * @bo: amdgpu buffer object
+ * @new_mem: the new placement of the BO move, NULL if just invalidate
  * @evicted: is the BO evicted
  *
  * Mark @bo as invalid.
  */
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted)
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
+			     bool evicted)
 {
 	struct amdgpu_vm_bo_base *bo_base;
 
@@ -2129,6 +2217,9 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
+		if (new_mem)
+			amdgpu_vm_stats_update(bo_base, new_mem, bo->tbo.resource);
+
 		if (evicted && amdgpu_vm_is_bo_always_valid(vm, bo)) {
 			amdgpu_vm_bo_evicted(bo_base);
 			continue;
@@ -2640,6 +2731,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		}
 	}
 
+	if (memchr_inv(&vm->stats, 0, sizeof(vm->stats)))
+		dev_err(adev->dev, "VM memory stats is non-zero when fini\n");
+	else
+		dev_dbg(adev->dev, "VM memory stats is zero when fini\n");
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 046949c4b695..13e1ec4deb05 100644
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
 
@@ -514,8 +536,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_stats_update(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *new_mem,
+			    struct ttm_resource *old_mem);
+void amdgpu_vm_bo_handle_shared(struct amdgpu_bo *bo, bool unshare);
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
+			     bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e39d6e7643bf..841a575cb18d 100644
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

