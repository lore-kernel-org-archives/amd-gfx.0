Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031BFD70DF2
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 18:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C9810ED25;
	Thu, 28 Nov 2024 18:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B/a3ny01";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA5110ED42
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 18:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZmP0H+/p+cMMHPCKO+uVEP1rs/eXML2g5rN8jLKLJZ3NU/EzNugqqtUWrKM0l2vnNz/tgs/PR4+cfrQ5xGKLO/xHtSrn2xLeYpQnH8hB0cFLamnvToC0Q+s5kor7vA5U+eYJoC8uMMLa+MN6kM7IPhtxugturrcDYzZeeozixcviD4hPN3iSSBc6ZC/v7/4OFwjiwLwS/gB5beWlSp/IUPTcBsNtE2DxX78wLceoGCBgUjJEzL5bjONk1YRFaFtoOxq/cxxHE4mxrefsIJAUq9VDkHDTjrKs1GtsW3z/FNcCPpNqIgx3N90/XBZYzUUrEaAK/+fWrYhLkHFBXEjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp1UvNkgBx/qvyeqZI6MiZA7IVT/Q8Cxrr4dh8sKG1M=;
 b=FkgRcCwrc8MDkvB3P6Dr3FAj4hQPnhKHojHNOvjgB1HjmPT33AlDDWoKWjkPbAoudU8vP6hYw/piV94fI7541uEUzj/BshskpBMJDN/wN0DltZIEDtsothIwsMVgrrjjtsyNSWvyQbaWrxcY0WQTd4xBlNtg9PQ+FD5dXuE0dzYKLx5RMPwUNs0R5elC/dTJc/D9gYAmmHm9qdzI87T64nRUx3zhXza0DaWtRCao/TqBMjuCj1aXujENQcCs9mb22jYv9HZGQXn90PofXB91j9qeTyogZtuyO0nhM4jqie+CGNMMEkIWNnnMQv7SQqmgcYhOxGU8rofuPWpey0uuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp1UvNkgBx/qvyeqZI6MiZA7IVT/Q8Cxrr4dh8sKG1M=;
 b=B/a3ny01plqbGtdjrtQRY5FCJ+R9TnZlfKnrJwPTVLbWuw7pzV/Mhgsoi3y/sumgdK90tKgjnv0HBNbO6ZB6k8X7Ld+QIBkZElYGS8kxincEzHmshiYfWjJ6kESpdW3vC3lTPmXTel0jIR4h9XyTNw9gD6sikEpuUPtjWcUiyG0=
Received: from MN2PR02CA0036.namprd02.prod.outlook.com (2603:10b6:208:fc::49)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 18:54:30 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::5a) by MN2PR02CA0036.outlook.office365.com
 (2603:10b6:208:fc::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Thu,
 28 Nov 2024 18:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 18:54:30 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 12:54:27 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v9 5/5] drm/amdgpu: track bo memory stats at runtime
Date: Thu, 28 Nov 2024 13:54:04 -0500
Message-ID: <20241128185404.2672-6-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128185404.2672-1-Yunxiang.Li@amd.com>
References: <20241128185404.2672-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: c41c0f49-a666-4625-0b4a-08dd0fde172f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SsNW63I6x6XwPewYa8n+H+1CxPGy2twLVpdMpmq+if3PcMPmHnDNEHL9oE7W?=
 =?us-ascii?Q?fHh/de0uiabWzPIWSlHmbZisOLi2VLMYShhGnJucWgVZnaIZVCagh/K/Bnq6?=
 =?us-ascii?Q?eOONqTG+mOwffgglPtNiUqhX00Fp2ssLFiV2QrvhiNLzgcQ0wS4URjWTybD4?=
 =?us-ascii?Q?e6OuX+zes+6/6ef42cLyXa0Sbk0+ugi1S+Bc1rmv0cBjqyZIUlxcLgygmV7S?=
 =?us-ascii?Q?dP+7Hkwznh0D5V7Y9RzqlMUA738JkyooQ0vvNnQ02XmNPfPZqEScdzDobabY?=
 =?us-ascii?Q?SlPy5L2AEY4DUoc4jQ+s44FNB7I31UyEzv7LxOomDJcTq5MInZvtJGJW9czO?=
 =?us-ascii?Q?q6esO4SwA9xmbyEh26GdILUh6USMBjI1eNNuX9Ly4JKVWGbwM+V1IXHFJZk9?=
 =?us-ascii?Q?Cxfn0CeiQXSJVdEg0c9Pdzayh5Js7KhHF/EtYt/gNL74kd/bBkCDYXlCVrtu?=
 =?us-ascii?Q?RGWNPDC9hsCjSjhRhLyOZwH71ShdyvSp9zW5ucrS/PsS0siOVWaKiafbKZb+?=
 =?us-ascii?Q?V3fsc1MrQmX20LsXc6EMAxTmasOS/SFbfnLiVLKeKGhvC1HjacG0fIZnqaXa?=
 =?us-ascii?Q?uhvhAikiSuv9goLMjhLflTr4XeYByyXyF4SvexRO0nvIJUwJpZB/EFZCT/9G?=
 =?us-ascii?Q?mOPbC+p/ZP8V+x+4OUQTNYpwfxCavObBNdVmxrBDWPCiV/vlLEMkIVcglc4m?=
 =?us-ascii?Q?Qz5d9bA9OEIXyCSzQAG76a0ZCGzMUaBckBd13lc3zc1A6dZB/mBTAdqCz29n?=
 =?us-ascii?Q?f5SPbwq27xPeBbLTW+9XxnUgiYfNYRKo7YKFAW2ob52IPauMoRCxmN28t35l?=
 =?us-ascii?Q?4W/hG9LlYuDzy1aWsqNVfsvU/7GI8QCNukszEp3JoLAldSEOXbcubigKAYoA?=
 =?us-ascii?Q?K6KjKBAjQmyFhAo+AHfGh26YZ+NwsueBhWLobi4uKP4nFBCJ7FHwq//2OK8u?=
 =?us-ascii?Q?ve/Hm7DtdBWpYQe6vqNTlo9X1jNOlwD4cL91dWC2KM95o+ZlckuCzgzLtl6/?=
 =?us-ascii?Q?0GyJNTKCmmKarzdBx5UULJUZtTPVQb6fUgud/KLTjQ/1ABdQQ6VEsODdIP55?=
 =?us-ascii?Q?6tEbrEPKJoYfKnRC2xPfY4zD9mB7Wh230oDgrsj8oKIl+KTMmSLbipA68icX?=
 =?us-ascii?Q?7kiop0y7UKTwKnT8T5c7nwo1p31xWyiV+CEPUwNeu2W6XIIW+h5fHNBn0FN3?=
 =?us-ascii?Q?LyXDqPMZaOPEUktufoOOMLFw29ZxJY8JKM5hJa6gWxe97CcdFHYrhX76qaU7?=
 =?us-ascii?Q?Vk6WMGrrKL97xkWI1BPmDVQWsI9GF7yeXSpuuxFw8RsEemTrE7yx0CP4/B7H?=
 =?us-ascii?Q?zcmdzIdE9RVujzyV07IcxDDu3sRVIQfBM4Af6OJdzLuujNRfJxXOXWextgoL?=
 =?us-ascii?Q?LRa6GbA5rCICveYEf2oDyMjsgMEl+lc9cFvB0kzzvLGH2zN75jRvDBkV3su3?=
 =?us-ascii?Q?sBzVUrPAwmEkd+Kowy6E0V/HOkN66e1d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:54:30.1968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41c0f49-a666-4625-0b4a-08dd0fde172f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

