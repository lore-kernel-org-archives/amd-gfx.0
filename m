Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D582CEE49BC
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 15:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2926310E056;
	Wed, 11 Sep 2024 15:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S9LwB64/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9571A10E038
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 15:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZpfNwp6KnxEoQ43buiDy7Lnv/CHXX8w2d+YsKpEc67nSSqypybgzV1YGT0qdAeSIm4HIgC8G2M8CyY23M6fxNtkT+4sz+hUtks/Kn/hlfGNXV0NBBhtpuvOTvt4dDAaqE7V1eru4O/gdSepS5ub8+sAA/GrPj9A7AqKwJGDyApA8pzPPZnJLX9FiPYThpGFcGONBFyP+uYxPzEyMwVdfgH9R2TUDoOhe32Fn5lZeNVjlGmrC+cokcRjNHPm2sq6v0QQ5Qe1x68ABvTOGp09ptvbwMKkJ5Xvk613SdH/l96Xq500vkW2uzHPwXvAWhoQ9V7Il//BxZd4Qf8/fW98aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBRJzBU6xpKoTN4ZFiYYH7oX99BQULJ6icRGUmzP+mU=;
 b=eGm7+tZRWc4BmxRUSz1B1iDNPOB9+/KVkYbbBrFWMdo4JnJw9h40mbs94yjulVKorAJVJ1+mFslQcMGaC89F/sn5FDeNoC8Iu9wAWAntXStzgHriLOBGUEOgtSRMWFtUvGlvBXQ4agxlT331EXadMJeVxd7hL0scdn8UsWmuUYdVleM3BPlYzzZ8NfixkvGkujN4PAVoJNF8VzLQcZCN+8/xJC8ornHy99W80jBvMdkrkEkuAvU1mytMUJ8zh0Us0EPytQyQbV6xXzNVycaWzYinqa6SqYpYz9mTQNtpeAfI+mNwPP2hGgXk/IwVm1wYvefycnrcSZq3Nd/aLOR/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBRJzBU6xpKoTN4ZFiYYH7oX99BQULJ6icRGUmzP+mU=;
 b=S9LwB64/a+q7v0GbL216L945sotZqsQ1PYfeJK0gQDiJRE1ovDW2KxwogisSMNOb+/vwql4IbMOX0t4GNoxXvUh/ffYtOvQToS8s9jO7NddQn36czAvO0cEaImCieDApyQuR8xLAd0l090GnaNu4gxI9iYVayPsZSYEMXcdoyFo=
Received: from CH2PR14CA0047.namprd14.prod.outlook.com (2603:10b6:610:56::27)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 15:14:04 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::73) by CH2PR14CA0047.outlook.office365.com
 (2603:10b6:610:56::27) with Microsoft SMTP Server (version=TLS1_2,
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
 2024 10:14:01 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: track bo memory stats at runtime
Date: Wed, 11 Sep 2024 11:13:29 -0400
Message-ID: <20240911151329.9438-3-Yunxiang.Li@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 06415862-7b1e-489f-c66c-08dcd2745f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oyEgOH6qnj63TIVkBxBIWHPGgGkyhSjEOnH7u4KslfHqZrMurc2bwOx12d9m?=
 =?us-ascii?Q?dA2rDBkfD9jljGeGRLjPDw7ZdKScLLUy1z2bzCtIAqdGIAZ+tPX8CC5lmW8V?=
 =?us-ascii?Q?N4km8Q4r8waWm1vzIzeEx9NkMlyfzZ4FYEUyCMMi3zDyo0qcN47ZUyaEoEgh?=
 =?us-ascii?Q?SYM2fTvKXnsyRLY4vGcFGZGB+OBP75QwklQfo6Fg8hX5JhfUWkUdKncDQApe?=
 =?us-ascii?Q?0anJ9CGI1fVriDa01H3nHFemFEEf/69taeFyuPOcD2yL8SdGf2ojjI/gEtc7?=
 =?us-ascii?Q?V4MrfO0J2jb7sOHPZ2JIWfhwoze8yBpzmUF3bMSKnVDMyz/ThYNLigs3AdVh?=
 =?us-ascii?Q?rDoMmDIO6mpKny9kbswd4ow0TGvDr3AIXtd5AdFC6XlUmb4ari3Y0tOQDaoz?=
 =?us-ascii?Q?r2y3khFWYFCXahLMj64Ju+xN5iGh/daebLmjwaeIMIQZX6aHJdfxFTCCVunN?=
 =?us-ascii?Q?zOBNNlrFCTUsBGDYHoPat+7z2HKRzYRjhWcx+58eOmtZJSIBZR0HL2f1XRtc?=
 =?us-ascii?Q?27fMMtJYZRlwI+N80KjQbSu1Lj5e2YFMm9R48O61ET/GnGp1ozyOj4Ro4uxL?=
 =?us-ascii?Q?dq/VowPOc3lws7p76+Skbd6w7UYGI5DLZwZ6c3wCDtfXW0Aoa4GQ4Q+4jORG?=
 =?us-ascii?Q?C8sD8zviK8qI8T9b7noSa4YFYAAYhc+/nT1sbnZ7z/FIsBMp9IhoN+DIYSr+?=
 =?us-ascii?Q?7QQYYvKl7mGNpmYdsnc78oqU86WF6i1zIorJ+hmmOAu+i/7YLwVDWV0Op4tl?=
 =?us-ascii?Q?cT7Rc+ZczBC67s5UVQtmMnovJHoHqnmVObrRkFoU6TX69wbkEN73uT4JdnPL?=
 =?us-ascii?Q?yyjqp83TuCN/aiqK8NJWZtNguXyyopC+d6dT5vNqsvcvkndWM7zSSe+UW8Pj?=
 =?us-ascii?Q?67yHDVeDtKNJhRiGyDezjLzSCXLdeAotQsHFNdGpr29HhcMgls+xNIGGk9fo?=
 =?us-ascii?Q?B4HjHnL19mcY5YTf3UihyYFIV/LaaaCoSlqrtf8JPlUKSXsQmnf9wzXDbxlL?=
 =?us-ascii?Q?QDCZEvJkZAxO0Yz8JO87mYjNZzUbHkrIwxPRcZPk/rjv1k86FV9ycb7nMFp8?=
 =?us-ascii?Q?9ZMzJfcVKI5FG74f9hzOb6Ncs4Z/yAldMXeKAcO98hwoDebnhzzfirANMJmw?=
 =?us-ascii?Q?dq2pvwtzL/nu5KD7oeoO9ynEm5SDzg6SNkFadc4EuJoscB6OeaaloA0EIUkv?=
 =?us-ascii?Q?CQMSYcxChHaAOF7SI9ou4dHmyCQd6jsCE4Pre61iy6+vkU67csXRBR1wklzd?=
 =?us-ascii?Q?5RrQDt2pjFYlVjOkvXbnrukIwYTqNT3DA5CEMVEOCf0APTwn/WY15jJEVAwZ?=
 =?us-ascii?Q?aDEJhCSuirhnUatsf98KcPsvsm7bbC5CIX0dvmHr6m2kN8sCl+mdyHuf4yxP?=
 =?us-ascii?Q?ctlYn4x790o2hvtSjSfUZR7s25Mrok+mFItob03Br/eULMTCbzrYjojwNIyl?=
 =?us-ascii?Q?DSJsWw7Y3gJY81fhnbVtF/XjTpaxFF8h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:14:03.5605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06415862-7b1e-489f-c66c-08dcd2745f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  21 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 211 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  30 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 6 files changed, 213 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b14440490225..ecfaacf2a1c9 100644
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
index 6f169e0ea30f..701a1a49d724 100644
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
@@ -1089,51 +1196,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
 
@@ -2070,6 +2137,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			if (*base != &bo_va->base)
 				continue;
 
+			amdgpu_vm_stats_update(*base, NULL, bo->tbo.resource);
 			*base = bo_va->base.next;
 			break;
 		}
@@ -2135,6 +2203,26 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
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
@@ -2172,6 +2260,32 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 	}
 }
 
+/**
+ * amdgpu_vm_bo_move - mark the bo as invalid and update the mem stats
+ *
+ * @bo: amdgpu buffer object
+ * @new_mem: the new placement of the BO move
+ * @evicted: is the BO evicted
+ *
+ * Mark @bo as invalid.
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
@@ -2594,6 +2708,19 @@ void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
@@ -2665,6 +2792,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		}
 	}
 
+	if (!amdgpu_vm_stats_is_zero(&vm->stats))
+		dev_err(adev->dev, "VM memory stats is non-zero when fini\n");
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b4424a757b38..11140ec11fde 100644
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
+void amdgpu_vm_bo_handle_shared(struct amdgpu_bo *bo, bool unshare);
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

