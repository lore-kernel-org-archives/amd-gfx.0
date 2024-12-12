Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E050FE7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 15:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8EA10EE19;
	Thu, 12 Dec 2024 15:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4jYUeqn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F1410EE1D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 15:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBry3iYssQLsh3z9jHtbu+x2HmRLW5Zlh5Ee51s3y6VS+H4/u0zf3aMkrgeKP1F4fwL2rEeX1B/1lVGEf7k6KtHX/bwuzCjC3wa3tyKIgLMEXI2aixIV4kHtSgeZhE5YIk5kqBJGbpjBXfW+jjh7vMUKPNIoaTKjhWeDCs4IDALABLrO6VjVUivcDI+XeKCKmbjq+BmGIxqMFw5Maow9V3z5lko2nImKGRYw95CgewBbYMYJDbBlcU07+tvebrU/DhL4a8RtEh+NGFEkqIfOXFngJ3dWHUtokfbnRlilPeSzhigCyndGhMo1/8wOml2U7BY6BnscxGGsy7GL152fIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA6YpkQqaTq8SvlAPsHGV4LuWNLk6Cldc6hbA2ErEbc=;
 b=SseUX0jd00QDgYBugrMftNY6uC3qO7emCTDs9hQtLNu9KLTQe2kf9x3I0xqEcspEuPgJsdoouoCIYM1v+IDxmCfB/YTI7KRF6hmdhs736AbTgVgjsypec/cDCQt3usJd2C6EfozFvcL94E5HFcwZoABQ87dSwQPOD2jHjN7HdAVfOfNjyOwNoXH6f3hG+5sEwelFfNqnZpkz7LQG8MMmMaseugBZWPpy3uxWieGW5iN0gDv+EeGeN8odLdX7GEUNGK2wDUXb5ZInaTtLQV+OfeEp+A7QVOq0WQJHuT8i0qkK4lB4gTwBuulryWGeZo4JfRQlP64MweUqVwdQXUWxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA6YpkQqaTq8SvlAPsHGV4LuWNLk6Cldc6hbA2ErEbc=;
 b=e4jYUeqnOgLasuxTG3sEt4Qrn5YLrNC7yLyMz4mwG7fVT3VnW10fgTkzhLvMUiwX0TDDXAKlqKFlQmJrummnmW+xxY+81dsKKYFUcOg1fZa6cljVqhb+K8R7J4Lv93tqz0TDGzEaxfJEARPN/zdUPtlM75qMbDZHOh0j6iwU+4s=
Received: from CH2PR10CA0010.namprd10.prod.outlook.com (2603:10b6:610:4c::20)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 15:52:25 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::5) by CH2PR10CA0010.outlook.office365.com
 (2603:10b6:610:4c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 15:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Thu, 12 Dec 2024 15:52:25 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 09:52:24 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v11 5/5] drm/amdgpu: track bo memory stats at runtime
Date: Thu, 12 Dec 2024 10:52:06 -0500
Message-ID: <20241212155206.5030-6-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212155206.5030-1-Yunxiang.Li@amd.com>
References: <20241212155206.5030-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c92a35b-983d-4166-4bdc-08dd1ac4f94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vr8WiV9x69Vb9rFFMxlnWgqv005g0D59Ac7xXRtOPEsx9H+NwOK5XOLtL5xK?=
 =?us-ascii?Q?cdBeIxUmDbFmrKiUNBBUeKliMRvg8iqWfc8FAyWrvPum8cZaBWVH1KDb6tVN?=
 =?us-ascii?Q?/NoJnj7fdt8ci7I8WBiMhX+X8OxMEhfJr/3s/mP4AcZjTvToZHhGS6fVPFpF?=
 =?us-ascii?Q?cAym+WLKPaxOJp+sIwalr9mlFJRAdZe7ECSq2bxcygIoStop4jGfDP4kFkBr?=
 =?us-ascii?Q?iv1RVomhS1dQ6wxqSH+xRPkqesVwWai9Mtd0S//gUDPvQ/dBNtyaMzGJO8pW?=
 =?us-ascii?Q?avcSNCfQIj9i2RNGkogDkBmHRgeWClM5hKBOCnAcoxpXkrAI/iprTuDidS4/?=
 =?us-ascii?Q?u0RkCOaL06iZ2wyTlPZ7jt4HzB9sOT/bNTes2vj6UXZWC7HTTCIsE+EG+pwj?=
 =?us-ascii?Q?sPKtuYGwYTg17UMGfnT9DJtw/QNiEJUExaK9phN4KBwspUwXL0RjZCiKPVuQ?=
 =?us-ascii?Q?6/2NdUw16jLWikXkkir09Q1558Gx4zLA7fIurcWgvvYuEF0EYbVzRftaxgWy?=
 =?us-ascii?Q?jLtMpupDMsGxpQBhTxeuMwjzF8h+85rq2A8ECxlwkrwOZkKYTBG4wCbBhfvY?=
 =?us-ascii?Q?qVt/i8t3RoqdcTWQ5i539+IzFtoxv1OZZna8oMo9PhCuZtGd4gYvkhVUPeEX?=
 =?us-ascii?Q?2Zr59WIN+D08o+T3lJyiOjOnT3V0kdFPWNO7Y0xaluNSZSddaagADA4dVVWZ?=
 =?us-ascii?Q?221wqO19WisAjk1I5uMk3vnfRMwzHc1Aqmn+c1FJsrotBMu8+lwO/DMg7JeD?=
 =?us-ascii?Q?iPE98nnudl5L7eZ8B2jqC0GKZEqTU2IeSQgMq0w4pUySUzeINe4N3tnNnUxn?=
 =?us-ascii?Q?r+P5C5MUeD0CxOow7s81NikAdaFhw4QACFnsxIrw4sLOCIInGp6EEskr7GyI?=
 =?us-ascii?Q?RAyyz2I6f1FpWZvlJflX9fdkpk6qL0vCSJ4Uu2tykVRJ2N+r80yxWBZqAHeh?=
 =?us-ascii?Q?pxXHZZ6cIv5iu/rnzmQIF/otzTXk4/FjNiFMm03nO5pB7HzH4RFd/uPzCOA1?=
 =?us-ascii?Q?qBj7yHtsEt3EycfCAC6m3pbh4i7E3V8H+C5etHx/qj02krrhGQXgJb9YCsbu?=
 =?us-ascii?Q?buiCKWVovjQeHk36SZ4B3SAZnX+BRW6uvZFORJ8yjud0IFsXN7JPe/8K/+zM?=
 =?us-ascii?Q?oK5XdBPqxFMrsTUO5DSVxYncrVtHggWmfzQ7bg3rO4NllasRDPNGEIrQUVUb?=
 =?us-ascii?Q?Dg30qCtSLNW7IaCHA1JlvOsj4XFliU66IfiEOOTlSd+MiXs1xr6CFHsOZ1sc?=
 =?us-ascii?Q?4o03tQ89mUv2FEQFJvCrXAtQV5c6b5nCD3ci2aJsPc4vKhjrb/JCYkSdlF1L?=
 =?us-ascii?Q?8qwSfm6E8zzFHKTvPLCjojcEWvVzHjOJ8Bor5RE4FymBnII7nwbpUNUGSw26?=
 =?us-ascii?Q?n/lvpqgl5CZMi2VWalV1DX+hNgiY9wNl/7seOkUgHbEvpWDl9TCIKgX2wiFq?=
 =?us-ascii?Q?BotEXEKxcyjyKWvweZluo5TShEj5b6GW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 15:52:25.4045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c92a35b-983d-4166-4bdc-08dd1ac4f94d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 110 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 204 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  23 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |   1 +
 8 files changed, 228 insertions(+), 139 deletions(-)

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
index ce3314152d20f..bdc9a5bc4da46 100644
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
index 88173bd1f9a2c..48086ba82e53a 100644
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
@@ -2590,6 +2686,16 @@ void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
@@ -2613,7 +2719,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	amdgpu_vm_put_task_info(vm->task_info);
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
@@ -2661,6 +2766,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
index 6a1b344e15e1b..e742281b1ff7f 100644
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

