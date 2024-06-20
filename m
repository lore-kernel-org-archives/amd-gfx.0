Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A05EC27C53
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 00:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36AF810E0AB;
	Thu, 20 Jun 2024 00:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gn6ZZhcN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D842710E0AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 00:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Slzal92cq+ncbM/sn2ygesyEX4g11VE5zwrSowhCf8fy8EhCpcyipI06botLSXpKgsCLy4KnNPz1HHjU/FSFZW+zGDn5XNLPdmzxv3W9Ho78Z7ZsDpFDCXVHu09iUwTQt6DfxuyIVeejjU2DiikADYPstC9f05VP1Rtz1LGAixpEZ0M6IzAVJEhMbltVwnxPCTSdD1Xl8tKnrKEdRRorR3Zid51jqDbx/M6qtYwtiEYDrBmQUTsTij/f2Tweu6gFGjzPSbIOt0kWH3hUbJslR9hiuDibMU5cjP2+Rp7FHZJ3ZKtnxUUF0y+QSUFu6Dbgsb+LCCtp9VtcR8Lqor7MCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG8QGqR3XiQOW8vz8AiAJCSfnWnxRGh57GzOwz8eGFw=;
 b=lPqEuNX6uHg+J6/FTuDdl1WNH3gRAxfMaVasBcfb71P5UfEXwxoYghQwurM1PuD5DZ1gzIZoSqQTIy6lvPQO0NOSNFNUgwi2hShpqaDjeghcZIJDiZzA6TQkNz4m8I1RDKzAeDUXiHaFoc1j4dKHivAX0LdDX6VuLmHwD9cphhuQCAcyZx74VXqMjOhYhJpObtLyzrvNnkHRtjn2bDErS1q2boed9jg30j37XTmAvdSk9wrjJNm9vaVS2dU4PjgUXJ4n+frqcjkx+Iu+n8Ld7LQFy86ddP0vp57qhinOvXb8Hf62Q3ej5bEZ6pYJN7S+zn6eJ9HS2E3UtW3tA8Jn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG8QGqR3XiQOW8vz8AiAJCSfnWnxRGh57GzOwz8eGFw=;
 b=Gn6ZZhcNqhRTTvUh12MpnK9ndl4MSgvnWq1iNHyu4ZBTVh3gBxLJJUxoGT5Z7XF62WsFlsFl+9MBTAEDCMrZ2B+VKWXsKetpwbybyFvWxdNuciFLzfyvIHr/a4nkns1pIxeBI3sGIsWfiYo/VrTzlpysTRBowjUbrYdDW/wPZ7E=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 00:30:28 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::67) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Thu, 20 Jun 2024 00:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 00:30:27 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 19:30:25 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdgpu: track bo memory stats at runtime
Date: Wed, 19 Jun 2024 20:30:14 -0400
Message-ID: <20240620003014.21453-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5f71a8-423b-485b-0fa9-08dc90c02f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rGCbQtrHXoHP+T4c0AXINtBotwKTClgm45rqXQaKi95+PM3D+XWnr/3/N4Zh?=
 =?us-ascii?Q?nMmU6p9mZD/7q/6rGjX0lwZszK2rVcs9mUopO4VF1UNH8BdG9xKo6eIPEBmW?=
 =?us-ascii?Q?zUw6jcnue+ntv3KXjBZ1KvhojVB+e2Wi7lwLU8NhQmd8oIR/+bYpR8dwA5nV?=
 =?us-ascii?Q?2k4J8FWRTDNkhT45peQR29u0xOPQyOJhC1AzFj3/lzptMHD/eCalITV6nA3P?=
 =?us-ascii?Q?CMk1/aArlAQFVmvtl07ubylj7CrKdaiTV9oTXyUGZQKmwSIFvAcEXwuycIpV?=
 =?us-ascii?Q?7XvkLZXVemnYfYbwUlaTlzyMK5lT6WLyyOR5qi+CwijC9gPde5QOiL2XHSEH?=
 =?us-ascii?Q?rXeu87QskDLhcJH3+4r+CwH7hvWlq0HNM5E018w0T2j3QxP2ZCKNinMUVG4F?=
 =?us-ascii?Q?mM4YjyLzZfLh2bowdfwIBuFFZdXdpxfV5Y+xkjrA6Yld8p25qbJKBjsjCOS7?=
 =?us-ascii?Q?s7sXSGxX/D9cq2TQ187hxja9ecoENnGQ+omCIELCAzl7TUwQf1QAD3TtOMIZ?=
 =?us-ascii?Q?mCkY9js22mkPU6cGzHI3Yuu5glbWqJRM+QXUiNrAMCKVblepWnEnCuqw9Jzg?=
 =?us-ascii?Q?K55e9xe2aWTG8NF8uqtklMsBEIZ3dRPdAsfv6pLlpFHPnR/GkAsEbIjqXB3o?=
 =?us-ascii?Q?T8omVOQCA/DDviDOmFWz8W41Gu8buRriMdFoKAHNI7Yh+mMEVgjUY12rpZs8?=
 =?us-ascii?Q?8+yDTUDXPnJ8aZ6u2P1kJ7RhCQWa4Puva6bGzlm/IrDo8QyiTnnWl2fvDsZ+?=
 =?us-ascii?Q?4v3kuVahGpoth7DaXu446afUMptUOjRaaNfECR/c+DtDxxcDj4/K9ssZSDQN?=
 =?us-ascii?Q?cbGi9RguFKEq5rTv7lBy0AmmVi7Iz8EKXbQeB8gLoIwGAnwTQfUPKEwr5p86?=
 =?us-ascii?Q?0L4FkzyWBID+uwYYE7CcqVRXgSW5HZFjSpUOC1SqVTJjIA1ZJm0SIax4HSof?=
 =?us-ascii?Q?tRnXw7hqnKlCyfcxAk7axWuox2o5EPoEhlW1Sm3xD2e5aFIfQlQDOAaAZM5I?=
 =?us-ascii?Q?1FCg8FXVpNZQvj+0D2+wvvCuBa0sh3dfaGt1Ux+oVsvGOps0vNMIhZg6fxAY?=
 =?us-ascii?Q?h64gTGs0+PcLqCHty/nkuMEcjDqj2hjvmfdTXHBNak7EREwTvB8SbxxslNdN?=
 =?us-ascii?Q?Z5lfCxpWHptcr/BihAVbAujw89g2WNdLcEeA4a4XwkwSsASxCPEi6pQZFR3T?=
 =?us-ascii?Q?5JudPSkOV38jBeAoehThSr0iWSxEeewSV82LDzW9iDQHJDwT7EcQSx2xNYTf?=
 =?us-ascii?Q?UubzNSIqFnzOuLB4WrciMe5ZuDBlaIEC6/GDvzlfXAtWq0TWS/f8TY1TYKEX?=
 =?us-ascii?Q?g1Luw3kEXEg70OihMw0Fl4L8tvuaYRuZdApMFkg4ph9KVDVEIpA+Q9MHqr0R?=
 =?us-ascii?Q?3gJIo8G1e1m4a9hp8RTwDgdshVjfgpUkHyTxLVfpSfKlRcvKdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 00:30:27.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5f71a8-423b-485b-0fa9-08dc90c02f1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

To simplify the initial implementation, this revision drops tracking how
much memory is visible, since on modern systems all of vram can be
visible anyways. Also we do not track "unsharing" a BO, the shared stat
is only decreased when the BO is destroyed.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 26 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  6 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 52 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  | 31 ++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 15 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 47 +++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 25 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  1 +
 include/uapi/drm/amdgpu_drm.h               |  5 ++
 9 files changed, 111 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 8e81a83d37d8..cc78704a5f4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -35,6 +35,8 @@
 #include "amdgpu_display.h"
 #include "amdgpu_gem.h"
 #include "amdgpu_dma_buf.h"
+#include "amdgpu_object.h"
+#include "amdgpu_vm.h"
 #include "amdgpu_xgmi.h"
 #include <drm/amdgpu_drm.h>
 #include <drm/ttm/ttm_tt.h>
@@ -259,14 +261,36 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 {
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
 	struct dma_buf *buf;
+	struct amdgpu_vm_bo_base *base;
+	struct amdgpu_mem_stats stats = { 0 };
+	bool update_stats;
 
 	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) ||
 	    bo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
 		return ERR_PTR(-EPERM);
 
+	dma_resv_lock(bo->tbo.base.resv, NULL);
+	update_stats = !(bo->flags & AMDGPU_GEM_WAS_EXPORTED);
+	if (update_stats)
+		amdgpu_bo_add_memory(bo, &stats);
+	else
+		dma_resv_unlock(bo->tbo.base.resv);
+
 	buf = drm_gem_prime_export(gobj, flags);
-	if (!IS_ERR(buf))
+	if (!IS_ERR(buf)) {
 		buf->ops = &amdgpu_dmabuf_ops;
+		if (update_stats) {
+			for (base = bo->vm_bo; base; base = base->next) {
+				spin_lock(&base->vm->status_lock);
+				base->vm->stats.vram_shared += stats.vram;
+				base->vm->stats.gtt_shared += stats.gtt;
+				base->vm->stats.cpu_shared += stats.cpu;
+				spin_unlock(&base->vm->status_lock);
+			}
+			bo->flags |= AMDGPU_GEM_WAS_EXPORTED;
+			dma_resv_unlock(bo->tbo.base.resv);
+		}
+	}
 
 	return buf;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index c7df7fa3459f..9a40ff5c6dd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -85,16 +85,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
 	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
 	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
-	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
-		   stats.visible_vram/1024UL);
 	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
 		   stats.evicted_vram/1024UL);
-	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
-		   stats.evicted_visible_vram/1024UL);
 	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
 		   stats.requested_vram/1024UL);
-	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
-		   stats.requested_visible_vram/1024UL);
 	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
 		   stats.requested_gtt/1024UL);
 	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1eadcad1856d..4d6fda142f65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -29,6 +29,7 @@
  *    Thomas Hellstrom <thomas-at-tungstengraphics-dot-com>
  *    Dave Airlie
  */
+#include "amdgpu_vm.h"
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/dma-buf.h>
@@ -1260,12 +1261,20 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_resource *old_mem = bo->resource;
-	struct amdgpu_bo *abo;
+	struct amdgpu_bo *abo, *tmp;
+	struct amdgpu_vm_bo_base *base;
 
 	if (!amdgpu_bo_is_amdgpu_bo(bo))
 		return;
 
-	abo = ttm_to_amdgpu_bo(bo);
+	tmp = abo = ttm_to_amdgpu_bo(bo);
+	if (tmp->parent && (amdgpu_bo_shadowed(tmp->parent) == tmp))
+		tmp = tmp->parent;
+	for (base = tmp->vm_bo; base; base = base->next) {
+		spin_lock(&base->vm->status_lock);
+		amdgpu_bo_sub_memory(tmp, &base->vm->stats);
+		spin_unlock(&base->vm->status_lock);
+	}
 	amdgpu_vm_bo_invalidate(adev, abo, evict);
 
 	amdgpu_bo_kunmap(abo);
@@ -1279,27 +1288,22 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			     old_mem ? old_mem->mem_type : -1);
 }
 
-void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
+void amdgpu_bo_add_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct ttm_resource *res = bo->tbo.resource;
 	uint64_t size = amdgpu_bo_size(bo);
-	struct drm_gem_object *obj;
 	bool shared;
 
 	/* Abort if the BO doesn't currently have a backing store */
 	if (!res)
 		return;
 
-	obj = &bo->tbo.base;
-	shared = drm_gem_object_is_shared_for_memory_stats(obj);
+	shared = !!(bo->flags & AMDGPU_GEM_WAS_EXPORTED);
 
 	switch (res->mem_type) {
 	case TTM_PL_VRAM:
 		stats->vram += size;
-		if (amdgpu_res_cpu_visible(adev, res))
-			stats->visible_vram += size;
 		if (shared)
 			stats->vram_shared += size;
 		break;
@@ -1318,19 +1322,35 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 
 	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
 		stats->requested_vram += size;
-		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-			stats->requested_visible_vram += size;
-
-		if (res->mem_type != TTM_PL_VRAM) {
+		if (res->mem_type != TTM_PL_VRAM)
 			stats->evicted_vram += size;
-			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-				stats->evicted_visible_vram += size;
-		}
 	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
 		stats->requested_gtt += size;
 	}
 }
 
+void amdgpu_bo_sub_memory(struct amdgpu_bo *bo,
+			  struct amdgpu_mem_stats *stats)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_mem_stats bo_stats = { 0 };
+	uint64_t *stats_arr = (uint64_t *)stats;
+	uint64_t *bo_stats_arr = (uint64_t *)&bo_stats;
+
+	amdgpu_bo_add_memory(bo, &bo_stats);
+
+	// stats is a struct with all uint64_t members so we cast and loop over it like an array
+	for (int i = 0; i < (sizeof(*stats) / sizeof(*stats_arr)); ++i) {
+		if (stats_arr[i] >= bo_stats_arr[i]) {
+			stats_arr[i] -= bo_stats_arr[i];
+		} else if (bo_stats_arr[i]) {
+			stats_arr[i] = 0;
+			dev_err(adev->dev,
+				"amdgpu memory stats doesn't match, some bo was missed?\n");
+		}
+	}
+}
+
 /**
  * amdgpu_bo_release_notify - notification about a BO being released
  * @bo: pointer to a buffer object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index bc42ccbde659..23c1c9385f7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -135,33 +135,6 @@ struct amdgpu_bo_vm {
 	struct amdgpu_vm_bo_base        entries[];
 };
 
-struct amdgpu_mem_stats {
-	/* current VRAM usage, includes visible VRAM */
-	uint64_t vram;
-	/* current shared VRAM usage, includes visible VRAM */
-	uint64_t vram_shared;
-	/* current visible VRAM usage */
-	uint64_t visible_vram;
-	/* current GTT usage */
-	uint64_t gtt;
-	/* current shared GTT usage */
-	uint64_t gtt_shared;
-	/* current system memory usage */
-	uint64_t cpu;
-	/* current shared system memory usage */
-	uint64_t cpu_shared;
-	/* sum of evicted buffers, includes visible VRAM */
-	uint64_t evicted_vram;
-	/* sum of evicted buffers due to CPU access */
-	uint64_t evicted_visible_vram;
-	/* how much userspace asked for, includes vis.VRAM */
-	uint64_t requested_vram;
-	/* how much userspace asked for */
-	uint64_t requested_visible_vram;
-	/* how much userspace asked for */
-	uint64_t requested_gtt;
-};
-
 static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
 {
 	return container_of(tbo, struct amdgpu_bo, tbo);
@@ -341,7 +314,9 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
-void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
+void amdgpu_bo_add_memory(struct amdgpu_bo *bo,
+			  struct amdgpu_mem_stats *stats);
+void amdgpu_bo_sub_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats);
 void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
 int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9a92dd3c9fb8..af1b480ea4d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -478,6 +478,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	struct amdgpu_device *adev;
 	struct amdgpu_bo *abo;
 	struct ttm_resource *old_mem = bo->resource;
+	struct amdgpu_vm_bo_base *base;
 	int r;
 
 	if (new_mem->mem_type == TTM_PL_TT ||
@@ -494,14 +495,14 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			 bo->ttm == NULL)) {
 		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		return 0;
+		goto out;
 	}
 	if (old_mem->mem_type == TTM_PL_SYSTEM &&
 	    (new_mem->mem_type == TTM_PL_TT ||
 	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
 		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		return 0;
+		goto out;
 	}
 	if ((old_mem->mem_type == TTM_PL_TT ||
 	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
@@ -514,7 +515,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_resource_free(bo, &bo->resource);
 		ttm_bo_assign_mem(bo, new_mem);
-		return 0;
+		goto out;
 	}
 
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
@@ -528,7 +529,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		/* Nothing to save here */
 		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		return 0;
+		goto out;
 	}
 
 	if (bo->type == ttm_bo_type_device &&
@@ -575,6 +576,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (evict)
 		atomic64_inc(&adev->num_evictions);
 	atomic64_add(bo->base.size, &adev->num_bytes_moved);
+out:
+	for (base = abo->vm_bo; base; base = base->next) {
+		spin_lock(&base->vm->status_lock);
+		amdgpu_bo_add_memory(abo, &base->vm->stats);
+		spin_unlock(&base->vm->status_lock);
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..b373bafa7b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -332,6 +332,9 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 		return;
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
+	spin_lock(&vm->status_lock);
+	amdgpu_bo_add_memory(bo, &vm->stats);
+	spin_unlock(&vm->status_lock);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -1088,51 +1091,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
 
@@ -2049,6 +2012,8 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 	}
 
 	spin_lock(&vm->status_lock);
+	if (bo)
+		amdgpu_bo_sub_memory(bo, &vm->stats);
 	list_del(&bo_va->base.vm_status);
 	spin_unlock(&vm->status_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 046949c4b695..3f9650ac612e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -42,7 +42,28 @@ struct amdgpu_bo_va;
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
+
 
 /*
  * GPUVM handling
@@ -336,6 +357,8 @@ struct amdgpu_vm {
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
+	struct amdgpu_mem_stats stats;
+
 	/* Per-VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e39d6e7643bf..ed98bc78c8e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -595,6 +595,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
 	spin_lock(&entry->vm->status_lock);
+	amdgpu_bo_sub_memory(entry->bo, &entry->vm->stats);
 	list_del(&entry->vm_status);
 	spin_unlock(&entry->vm->status_lock);
 	amdgpu_bo_unref(&entry->bo);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3e488b0119eb..7ddf020817e1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -174,6 +174,11 @@ extern "C" {
 /* Set PTE.D and recompress during GTT->VRAM moves according to TILING flags. */
 #define AMDGPU_GEM_CREATE_GFX12_DCC		(1 << 16)
 
+/* Flag that BO was exported at one point and counts torwards the "shared"
+ * memory stats. Once set it does not get cleared until the BO is destroyed.
+ */
+#define AMDGPU_GEM_WAS_EXPORTED 		(1 << 17)
+
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
 	__u64 bo_size;
-- 
2.34.1

