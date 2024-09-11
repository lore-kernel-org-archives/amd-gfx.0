Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA23EE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 15:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DACB10E038;
	Wed, 11 Sep 2024 15:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lLvL0dQj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0024810E038
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 15:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhRrpFf+7j5i3YcnvCYDoAvhv2l2idAT+xDqmOrznU+QNS7/2J0Cd/9uH0iNA2vpk9VvORP1XBZ89Hq2mWfEtsaDTzBVML+egcVCBGLpifC0SRd6zUtmZ0F5oWEREj9QZlj7q6bbbox7abL6U1g6qqtJnl5Nns4UcN2WXMrqUR14VnlG9L1tcWVc29DxlWHoABYzdxgTJSDsTBSxyQppWPKBlCy696R94p3R/yzXA95+v2Si5i+mDHa68lFBiaQGNMv24t1ATZby41W0UY0joDH9yDUPcDPpgg2XVp7X8ufrJnRXQK/Ptmga+C66gMpUjDv/g5BACVDuvkx9C3mduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb6r1o2fTt+RYP1MLdsRwEymd6XSJ2Z6iC5zclwkFBA=;
 b=u+wcqBv/kv5CKrBK22wMJa15jr5WlalsNyC3Uc97fi7BFIpSLumBjLqGcEjRddVPTJfwS2W1Cd1CIYHNXuUk0dRK95ai0QyYLn7nHfFOUWW/2lewC6C4mRbUQAUlGStrP2ihdMr+pjSeIXCBFBcWP16IQ8eGvWjk6ar0z8fmxSn95LMJYCL3Nr7g2ghAXcXwZpeX0VCy3WgmZp7dPqpgh28iqQlXvzcvEPoYYt99Wb2DuG95CQk2tZLQlNBPMv9WO6rYXtW6cOe6v/2oZJRNJUbrh7mr2w1+a2bad9CATsUI64cNgCQg+FSBC8fQ7l6Pz1MYHy1ZJWN1KQB4uMTULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb6r1o2fTt+RYP1MLdsRwEymd6XSJ2Z6iC5zclwkFBA=;
 b=lLvL0dQjWdhcPpGCuxDKWDDr47QWxuRDPN4tppNEjdp/D3jrTBKfehXy2r4m7CukrWgYWfl2SEkp7ZcKh/UBZ9IlJBzNdS+bdllka0fcMTPHj+OOSI4/BU0tZz4eQmxfnDxco7o4z74CZhNJLlC+LSAROr7a2NhyDiiNfC1bAjo=
Received: from CH2PR14CA0048.namprd14.prod.outlook.com (2603:10b6:610:56::28)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 15:14:03 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::13) by CH2PR14CA0048.outlook.office365.com
 (2603:10b6:610:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 15:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 15:14:03 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 10:14:00 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: remove unused function parameter
Date: Wed, 11 Sep 2024 11:13:28 -0400
Message-ID: <20240911151329.9438-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911151329.9438-1-Yunxiang.Li@amd.com>
References: <20240911151329.9438-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: e0308371-7213-4cce-66e6-08dcd2745f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q0UPyMlmqEIba4nk3K5oWGAWvnVPOUM+xne3dQGIWublROx3HSRdWKAwl0A0?=
 =?us-ascii?Q?z9AWiXsjg8tYxIpaoupH3HEToqNuthE1tT8BlmiReHzbR57yHCjFziO9Insq?=
 =?us-ascii?Q?MjlEfPTGa9FprcpijNrC65o67nRy0yZ8OxyoD+rRmdxm8maYZS71m3AInZTi?=
 =?us-ascii?Q?AqlvDPrUKyuymE2SdgYC6iKM0ledMOxxFFzz3tJRQXMFtqqNU0GAioF5eEAC?=
 =?us-ascii?Q?aD0Vs33tTguiZnPfDjDVpQSdipnbvYXO99FYr+Q7YH5iUMLORRqahW6Ra7mx?=
 =?us-ascii?Q?wih2X1a74M/TtUv8G5bWSMA3uAfFDeIY6g9K5gRbt74tmRprKHADQ2VJ5XW3?=
 =?us-ascii?Q?VvqbD/ai+X85wXRIqkSg8pDF6jlZ3jejffOJ/GnpTXhu1upz1mWr9BWaY4Lx?=
 =?us-ascii?Q?topa+CGfrT0i60lXttZy9e1zZDVpYmI1oYJU6W6r5rYwJbgsqAeBeIvG9VRd?=
 =?us-ascii?Q?tSK4S8DyeyZ9DvQP6fetCTTVQVihs1skSgMYFuscv0WAcAk3B3DGqh3+FRfe?=
 =?us-ascii?Q?rE4Feq5XqsW8VL6Y6FfM/1ymCCanUoKDkuTY1ejiKV9SMyyPGLuLYuyUSaSw?=
 =?us-ascii?Q?dheJIhWomx98qvEfYbmrlrllSgpL+0mQ/Igk5a4JzBSU04aSFP7x4PgfamuD?=
 =?us-ascii?Q?3k1r3ZjeSqLUvlME5xVgLUPG4RCG+UBU9DvRAHDJ7/7RrJTwr6fJXS58pMYY?=
 =?us-ascii?Q?eKQddjX+lSSq3F2xHpibrNz81+36JmaPgYOAQWl41aCQzCeRR8BqmCYejcMO?=
 =?us-ascii?Q?wQip/L3PpkNKKvO9zi6SNlWUE1m/G/8GJQCraaw1VIWBtX79LH6+knCJvpfH?=
 =?us-ascii?Q?98SMPxDEzhPAMlakyqzcedg7urQ9UcKCzg++2459pxzfzXZujrHz2Ljoauow?=
 =?us-ascii?Q?vtxin3f6+FL8L78RZCoug3zJdoqYXXnWZQw65cZXOXruhz72/CjXjd2EwA7o?=
 =?us-ascii?Q?iixx4fYNMi7ouisaa+m3hBNdGUsTawuf6Ob2Ms3lDVqhQzwRly/T7vAIW80K?=
 =?us-ascii?Q?D0IuEoG6QJQ3YV9KzZA1PCZPKIMXO2CkuHfCudvm22442w6HJp3L7eGz1ooo?=
 =?us-ascii?Q?0LlhAUZ0mixhPD+le+7XrJTk+WzhNqrXCR+mUF9pUglEH7i29zB0IVjSUh9w?=
 =?us-ascii?Q?c3TDz5QZQsaZ7AqVAGZXRDtAVOWDgFfgJgRykWp+4v1nJBl9k2UA9qdnu2O6?=
 =?us-ascii?Q?8CWMGDHbxDXnCgy2k2n/jRLzW3qXiSzK0rDGbwdZQuvWdontAvC3CWXgrfbz?=
 =?us-ascii?Q?/Fa5+ArE92Va9vOgZ5SXuQf3RQ/rs1VO63BNYkRsz0wJ7oPwY0z1M148jjEY?=
 =?us-ascii?Q?1JgtbUO1n1kJKqpr1oLhtCifa5pd3j6oIuyj2pwYZwqxnl58YhwmuBTXW5de?=
 =?us-ascii?Q?DDSF/tF3RgvRqzAEUpCuLdY9MLFJeNxMC9969IrHxrn3IBvCk8rybfuaYbir?=
 =?us-ascii?Q?ELOJBMxc8+ufPayshMP2VV33OLFwAuI0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:14:03.1386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0308371-7213-4cce-66e6-08dcd2745f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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

amdgpu_vm_bo_invalidate doesn't use the adev parameter and not all
callers have a reference to adev handy, so remove it for cleanliness.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 3 +--
 6 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1e475eb01417..538d7523adcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1105,7 +1105,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	 * We can't use gang submit on with reserved VMIDs when the VM changes
 	 * can't be invalidated by more than one engine at the same time.
 	 */
-	if (p->gang_size > 1 && !p->adev->vm_manager.concurrent_flush) {
+	if (p->gang_size > 1 && !adev->vm_manager.concurrent_flush) {
 		for (i = 0; i < p->gang_size; ++i) {
 			struct drm_sched_entity *entity = p->entities[i];
 			struct drm_gpu_scheduler *sched = entity->rq->sched;
@@ -1189,7 +1189,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			if (!bo)
 				continue;
 
-			amdgpu_vm_bo_invalidate(adev, bo, false);
+			amdgpu_vm_bo_invalidate(bo, false);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 8e81a83d37d8..b14440490225 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -345,7 +345,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	/* FIXME: This should be after the "if", but needs a fix to make sure
 	 * DMABuf imports are initialized in the right VM list.
 	 */
-	amdgpu_vm_bo_invalidate(adev, bo, false);
+	amdgpu_vm_bo_invalidate(bo, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ebb3f87ef4f6..62c81b74c78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -838,7 +838,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -898,7 +897,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
 
 		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
-			amdgpu_vm_bo_invalidate(adev, robj, true);
+			amdgpu_vm_bo_invalidate(robj, true);
 
 		amdgpu_bo_unreserve(robj);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index bcf25c7e85e0..1d2929ad8cbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1258,7 +1258,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   bool evict,
 			   struct ttm_resource *new_mem)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_resource *old_mem = bo->resource;
 	struct amdgpu_bo *abo;
 
@@ -1266,7 +1265,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(adev, abo, evict);
+	amdgpu_vm_bo_invalidate(abo, evict);
 
 	amdgpu_bo_kunmap(abo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 48d0bec8e278..6f169e0ea30f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2138,14 +2138,12 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 /**
  * amdgpu_vm_bo_invalidate - mark the bo as invalid
  *
- * @adev: amdgpu_device pointer
  * @bo: amdgpu buffer object
  * @evicted: is the BO evicted
  *
  * Mark @bo as invalid.
  */
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted)
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 {
 	struct amdgpu_vm_bo_base *bo_base;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 52dd7cdfdc81..b4424a757b38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -515,8 +515,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
-- 
2.34.1

