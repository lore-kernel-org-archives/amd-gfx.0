Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF96ED12D43
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Nov 2024 15:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61CC10E2D5;
	Sun, 10 Nov 2024 15:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BBWdsZ9f";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2BA10E18A
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Nov 2024 15:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2+g1Gv/H2Acj7p9zk7sFygb46315ku0i/FgDZhgIkfQrrdzwpL2s0rtqHVk6bdOfbtMtvFD8wiOneX1tcS1tjIDiDcVQjbDVEIOZKYdW1MDgSyJPdB3susbMOUWCi4P60en8c8QTvVUzBHANzW7XhEHFe8zhmjS0tXPglXThNhz19p6wtldE07BQL5oyvQSlJI4vqsmtLZE4wMdLj6AADhmPMFzosGEjVFMw67XF5JWEGlp1dDvtMUfe4VVNbKuPcarETAzQYtGu9gBfErUJVO8s0ro5ljg+NX0OFtp+4dCLbokeLw7PtR05l2J/c3zaPVdTcJ49vjplK6mXPwvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NUuYBZ0vnOQeA4d96aVgAVI2imTTrv8G5DezK3xElc=;
 b=y82YIeaDz0iSZyGkYqq+jPP7cXcGeDUcz0kszJ5i5eiOldwdD0jckV4QL/4MV6oxxfyELgrNuB2ltIzBkuSYKO8oH/jHPslu1yO++73elwDunSSCjH5K8pPctnLJGGhTz78s8ki5CaICBd36nCT4THuFQ0W1oYQt2epHmkj7OmC+mIzFzzy913CT4QScsxzccVLEPwJXnU5onuq3QlMqel3TyYeNX8i1QZWsNkF7H+VUifR5+ncQiWpyK/1a5dAp3qB5xai78KXGeuPGRjt/EpjAmzigXmEZVObBQE2Vc+4fYYGRnb4Ru/lzIBg3p0uxR5vxuqdnKX14qejMBI0uaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NUuYBZ0vnOQeA4d96aVgAVI2imTTrv8G5DezK3xElc=;
 b=BBWdsZ9fgPJdA0T8ncQytGpd4EMsC5GM5FBzJtc91t07BfYBqFsEHgTbwUo5NGNxz4Pz0q2zEvhG7eGjkfxnCkP/bb4XlpzIn9v7gEVm4vBsuhnl2qFP4m1rwY5C/W1TNLwldrzo8vJrJnjRovQdDWHBqpk00dRdJZPZ2S/lweg=
Received: from CH2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:610:60::31)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Sun, 10 Nov
 2024 15:42:27 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::da) by CH2PR14CA0021.outlook.office365.com
 (2603:10b6:610:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Sun, 10 Nov 2024 15:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Sun, 10 Nov 2024 15:42:27 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Nov
 2024 09:42:26 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Date: Sun, 10 Nov 2024 10:41:52 -0500
Message-ID: <20241110154152.592-5-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241110154152.592-1-Yunxiang.Li@amd.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a92ff8a-0a4c-40d2-989c-08dd019e47ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?koS1BK+PtocLZBleHB52GAsejJqUHuXCuN7gthdDGr7wWEusuTsMkKDVeHDt?=
 =?us-ascii?Q?lKCo6z4YUD9VOCXvFrfMvwgfyxckSqXoLf+rzU2RDPEevFNyFaVfjQyICzbJ?=
 =?us-ascii?Q?ttt2LzrFPeukpPMLxdpyg0VAJ/bLNVU00h6EoxDBKEbWcc+6npf+892IAfCH?=
 =?us-ascii?Q?YqxfKOwpbc72Yp9zxiFNPhxV93mMCAZSSkHGcl7V2F526apa5/bAV0OtpSQe?=
 =?us-ascii?Q?HyPT6UJxBjDHYueXXJ2IBMbi4+UXM8P811pQETKFb1oRplWuZ5kzlyinRO85?=
 =?us-ascii?Q?Y6/hf+YtYeNlOAsH2QGhBa5zp8IVNd6MRaDZ12ufpfupHfBojHICYlpQESsi?=
 =?us-ascii?Q?G8pKANUCc13YEvhEtZjRHdou5+cnhPkxkl2JjGLYBYHi+Drg6PWFWCUh9Ood?=
 =?us-ascii?Q?vgpCfWYMGsAF5xpG7ox8w8XJgRXf/cxbhR/6YJzfjw/2DsliS3y9iDcjKgzM?=
 =?us-ascii?Q?HQbrcQQRdEHDoQlN0A55h/L8sPCqrl/qts+oiv5BoxZg7XhMfJQ+71mRKmiS?=
 =?us-ascii?Q?t7ORFI1DBij+BX3KwFVoJsIXGsUvCgckNtSX8o7s/98+HrBCepUwGzU7JFkJ?=
 =?us-ascii?Q?QrABWzWQMR8RAeLirdegBVd29N24s0Q9Z2aWOVZRs22oj1QjP6eyAoY1EAY7?=
 =?us-ascii?Q?N/zXgjpWtf75kR2li60YeT4xYRp9GiHvScmD3V0bxhRSg16f6pxRTjxZnsA6?=
 =?us-ascii?Q?5k7r2VCfLBDNeVuAyD1BJUIk3lA2KzKZuAOnAfhxMzG6cmd5L35yTOaRnSqI?=
 =?us-ascii?Q?tCMi/ATvLrLy8+y6lNWgjrBrhfKI63Y8TGHFUar9HfJfr9bgXMtG7oOXw1xG?=
 =?us-ascii?Q?7VnYO3TRu+W/emHPfNXH7M+VicO9Yr9xx+uE6GbVz5dVzpdSAwAzkMq4isrQ?=
 =?us-ascii?Q?+GEpQ/OabFU2ZxAJz+1dcW39KlNm1Z+1LSYISugEeJ0AKTHBBBrhceeLFGJZ?=
 =?us-ascii?Q?sjlJpEU5+GwKfJnsBuDbeOIZcIRz25xWudKPQYJPUovi3/SUl/iHNY5EJEot?=
 =?us-ascii?Q?vheuoBYk3voYIB6GMN02SYVtYoGtvL5Fwud/DJ8CIZvz0wZHsq1FNl+BpO+M?=
 =?us-ascii?Q?1w/7LISyWDMj/0vV05lw7tECMMu8KutN8sVNBsy5jQNbU5v73scMPPIQJ52A?=
 =?us-ascii?Q?yIhiv5ANRGaUDTIpHrAT4zB8Mr3w/Lp2qLBCzbh6sb3whnU5d5p1gAKnjLMK?=
 =?us-ascii?Q?K5TgbuKYjHGUY55MLNpwJSuBUBQOGwj0+VkVBsaqIoqT1fSrQPoAxEUOw46N?=
 =?us-ascii?Q?o0d3uJXxUduzpk9ZmZj1YVDOwaJWwRpWsmvTQBqda0Ro4ljckSjT7m+nkCM6?=
 =?us-ascii?Q?igx/S9RH5A3OkT2rw3coFX1cAYXCaxaIuhArYFc0tOgY2SVnmmtado5/i3jU?=
 =?us-ascii?Q?qFP75xvFZ1ugL+FRR/+fi/S5Dvg69RUTV/SWoT+cQWhZTQv7qw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 15:42:27.4429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a92ff8a-0a4c-40d2-989c-08dd019e47ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
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
v7: fix style and other minor issues, the best definition of drm-total-
is still an open question but that feel like a seperate patch series
since it would also affect other drivers

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  98 +++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 193 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 8 files changed, 207 insertions(+), 133 deletions(-)

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
index 7717e3e4f05b5..1a74d8d9dedb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -60,7 +60,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	struct amdgpu_fpriv *fpriv = file->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
 
-	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST + 1] = { };
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST] = { };
 	ktime_t usage[AMDGPU_HW_IP_NUM];
 	const char *pl_name[] = {
 		[TTM_PL_VRAM] = "vram",
@@ -74,13 +74,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	unsigned int hw_ip, i;
 	int ret;
 
-	ret = amdgpu_bo_reserve(vm->root.bo, false);
-	if (ret)
-		return;
-
-	amdgpu_vm_get_memory(vm, stats, ARRAY_SIZE(stats));
-	amdgpu_bo_unreserve(vm->root.bo);
-
+	amdgpu_vm_get_memory(vm, stats);
 	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
 
 	/*
@@ -97,7 +91,6 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 
 		drm_print_memory_stats(p,
 				       &stats[i].drm,
-				       DRM_GEM_OBJECT_ACTIVE |
 				       DRM_GEM_OBJECT_RESIDENT |
 				       DRM_GEM_OBJECT_PURGEABLE,
 				       pl_name[i]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index f0486519bee84..ec9b013a15d81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1156,7 +1156,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(abo, evict);
+	amdgpu_vm_bo_move(abo, new_mem, evict);
 
 	amdgpu_bo_kunmap(abo);
 
@@ -1169,75 +1169,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
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
@@ -1452,6 +1383,33 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 	return amdgpu_gmc_sign_extend(offset);
 }
 
+uint32_t amdgpu_bo_get_preferred_placement(struct amdgpu_bo *bo)
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
index be6769852ece4..bd58a8b0ece66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -30,6 +30,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include "amdgpu.h"
+#include "amdgpu_ttm.h"
 #include "amdgpu_res_cursor.h"
 
 #ifdef CONFIG_MMU_NOTIFIER
@@ -300,9 +301,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
-void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int size);
+uint32_t amdgpu_bo_get_preferred_placement(struct amdgpu_bo *bo);
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 					    uint32_t domain);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2852a6064c9ac..a9088e864fde4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -26,8 +26,8 @@
 
 #include <linux/dma-direction.h>
 #include <drm/gpu_scheduler.h>
+#include <drm/ttm/ttm_placement.h>
 #include "amdgpu_vram_mgr.h"
-#include "amdgpu.h"
 
 #define AMDGPU_PL_GDS		(TTM_PL_PRIV + 0)
 #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d0db155a9ab7c..032e672b1299f 100644
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
@@ -310,6 +311,92 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
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
+	struct ttm_resource *res;
+	int64_t size;
+	uint32_t type;
+
+	if (!vm || !bo)
+		return;
+
+	size = sign * amdgpu_bo_size(bo);
+	res = bo->tbo.resource;
+	type = res ? res->mem_type : amdgpu_bo_get_preferred_placement(bo);
+	if (type >= __AMDGPU_PL_LAST)
+		return;
+
+	spin_lock(&vm->status_lock);
+	vm->stats[type].drm.shared += size;
+	vm->stats[type].drm.private -= size;
+	spin_unlock(&vm->status_lock);
+}
+
+/**
+ * amdgpu_vm_update_stats - helper to update normal memory stat
+ * @base: base structure for tracking BO usage in a VM
+ * @new_res:  if not NULL, the ttm_resource to use for the purpose of accounting
+ * (i.e. ignore the one in the BO)
+ * @sign: if we should add (+1) or subtract (-1) from the stat
+ *
+ * Takes the vm status_lock and updates the basic memory stat. If the shared
+ * stat changed (e.g. buffer was exported) amdgpu_vm_update_shared need to be
+ * called as well.
+ */
+void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *new_res, int sign)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	struct ttm_resource *res;
+	int64_t size;
+	uint32_t type;
+	bool shared;
+
+	if (!vm || !bo)
+		return;
+
+	size = sign * amdgpu_bo_size(bo);
+	res = new_res ? new_res : bo->tbo.resource;
+	type = res ? res->mem_type : amdgpu_bo_get_preferred_placement(bo);
+	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
+
+	if (type >= __AMDGPU_PL_LAST)
+		return;
+
+	spin_lock(&vm->status_lock);
+
+	if (shared)
+		vm->stats[type].drm.shared += size;
+	else
+		vm->stats[type].drm.private += size;
+	if (res)
+		vm->stats[type].drm.resident += size;
+	if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
+		vm->stats[type].drm.purgeable += size;
+
+	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
+		vm->stats[TTM_PL_VRAM].requested += size;
+		if (type != TTM_PL_VRAM)
+			vm->stats[TTM_PL_VRAM].evicted += size;
+	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
+		vm->stats[TTM_PL_TT].requested += size;
+	}
+
+	spin_unlock(&vm->status_lock);
+}
+
 /**
  * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with the vm
  *
@@ -332,6 +419,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 		return;
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
+	amdgpu_vm_update_stats(base, NULL, +1);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -1082,53 +1170,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
 
@@ -2075,6 +2121,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			if (*base != &bo_va->base)
 				continue;
 
+			amdgpu_vm_update_stats(*base, NULL, -1);
 			*base = bo_va->base.next;
 			break;
 		}
@@ -2140,6 +2187,22 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
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
@@ -2173,6 +2236,28 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
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
@@ -2589,6 +2674,16 @@ void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = false;
 }
 
+static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm)
+{
+	for (int i = 0; i < __AMDGPU_PL_LAST; ++i) {
+		if (!(drm_memory_stats_is_zero(&vm->stats[i].drm) &&
+		      vm->stats->evicted == 0 && vm->stats->requested == 0))
+			return false;
+	}
+	return true;
+}
+
 /**
  * amdgpu_vm_fini - tear down a vm instance
  *
@@ -2612,7 +2707,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	amdgpu_vm_put_task_info(vm->task_info);
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
@@ -2660,6 +2754,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
index 6a1b344e15e1b..30efe9c9c08ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -35,6 +35,7 @@
 #include "amdgpu_sync.h"
 #include "amdgpu_ring.h"
 #include "amdgpu_ids.h"
+#include "amdgpu_ttm.h"
 
 struct drm_exec;
 
@@ -327,7 +328,8 @@ struct amdgpu_mem_stats {
 	/* buffers that requested this placement */
 	uint64_t requested;
 	/* buffers that requested this placement
-	 * but are currently evicted */
+	 * but are currently evicted
+	 */
 	uint64_t evicted;
 };
 
@@ -345,6 +347,9 @@ struct amdgpu_vm {
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
+	/* Memory statistics for this vm, protected by the status_lock */
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST];
+
 	/* Per-VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
@@ -525,6 +530,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
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
@@ -575,8 +585,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int size);
+			  struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST]);
 
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct amdgpu_bo_vm *vmbo, bool immediate);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48fa..384526d10a3bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -537,6 +537,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	if (!entry->bo)
 		return;
 
+	amdgpu_vm_update_stats(entry, NULL, -1);
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
-- 
2.34.1

