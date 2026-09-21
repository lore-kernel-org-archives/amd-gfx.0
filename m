Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77E2C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D39310E557;
	Mon, 21 Sep 2026 07:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jk+ZIBKx";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA4B210E52C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKeOVfraq/2q/FBF3mV+CkTUySzA3Fi4q8xGLFPVs68VvbxnTBtz3+ryxa7rR+eADQi20NhFUYKVe9xmJh0PMcjF+PkkYWbCHp34zlkxv+3StBcRce1c6zm8IyZwmUevXeVP/fXawomj2vo+yRZbgPvbcBEjZLppkdew7w0F06PXweyAwsaTqWcL85wN1CZQyOt/QlDFA7mfJVm5Fwt6nAulNFL+6zMBcLSJatIgsSgmDxgVCziC4U7KCq8RQ1AVM6RneHNlAckrEM1VfAGr7j9dQdeUxiZ3EHHZpC6fjV5hP81G9Je+AJ90RA7uPGh3GEtruIRwOmvjXj8BioJq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83l9QgVYSsaqaXwEo9PMpb57/ZDoxz3EkPDVWGDoQkw=;
 b=hXKUDC85XmZzsyGbRY3BG9lYi9HKqa27GrZaTveG6EH7v+reOQGyCuSNW39c/lPq4R9z3Onf3mZ2xcs/4cIXwIzBf4995F8rCz2h3VBU3LXLNmwSEV+ii5U3d2NyeTZrgMp94Nd4aED9ggDsQ3ftfknghF7THySGjvUqU/KSHTo0CetrgkyNWsv1pXZWS6ojMx7UYzn2c2igWLPeeM+4KNgReHniGEj6TMQq+SrcSbB3lP3nyLO47Had25tVRSh19xVeetiuz2orCJOLoF1faef0ibJNcUuDJlTfIRjagAj3ZBL7//vZgbybdDdoo4tQiuaSKYI+sP3bF+co223MhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83l9QgVYSsaqaXwEo9PMpb57/ZDoxz3EkPDVWGDoQkw=;
 b=jk+ZIBKxw7fIjbfCHIIU2AP3lZ1Dl7ajx+1bv9s//+G6hM8RIDi5QhSPPaRCUF03nH0WStn7DIWQvQcfn3R2rDLd94zyPgtHxyA4h9VqreIuzjUBBHHhaMsuBmKo/h/4m/n2FTVPsCSrlKwmLhHTpkyMW22+EHEhhfTRjvenngI=
Received: from SJ0PR03CA0265.namprd03.prod.outlook.com (2603:10b6:a03:3a0::30)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:54:07 +0000
Received: from BY1PEPF00026957.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::44) by SJ0PR03CA0265.outlook.office365.com
 (2603:10b6:a03:3a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026957.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:54:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:57 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 14/21] drm/amdgpu/gfx: add a shared gfx pipe reset helper
Date: Mon, 21 Sep 2026 15:51:21 +0800
Message-ID: <20260921075326.2409021-14-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026957:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 766bdac0-1c46-4e94-ff3a-08df17b5835e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: xt9vyopSxA2vFCXnl5XA5VFD9A9Bvr17u/n7jwfHOn/nBAcP6CA5spBdN518hKdiq3tLPdff5VzEzrZT4iyV/DV622gdN3SEytuDVtv+GHlFZcp+K+6RQxe+RjrV+cr4oL5VGDUf8zxA1OG/5NbecvBn8QIe/BTclrPD5qcMYB0vEei+1aFLdjoiLt3A20x3Nv8MKeXXpUL8JxOJz4okDL2cOdfW9BNMcgwYTds0lgFNZgtAObJwJ0URECpMD9k2q/0Z5WHHgDhF6XzyHP/0BTWnyQRT5WcN/S8t8jkZ2NZTpj18hWYu4BTr6NiCrvaaEIA7HULfXVIYrO2anVLY71Z/Lic+/oiSZwSeVbua8kf/qir/tXYznJaftXwyEzRtivtvx1z98yUPCx3Ft7xP7zJIKbUVwjQHqoTq6g4RFF80ZLEJJ5RTK88QI9xJxs4GCxCAPCrNiwCWwdpVN9h4NPSd67wKLUTwn7JmT86XdOVRp3pJ+aYPEgoCs5NlfUqOtzMEzl8YmQxfvw54We5G0D5+ppxq+Xyy099WQtFUSLZqDcEDDGFx0fPFJ90MqqemB1mIfwXFXuoSUsHmh1ip71hb2lcuHKRhdVv5YAuFXn1YmGIpRGKtmXlhV0ap1+4lQyJtYJxMZneEx8vkFDNjNkQmpLRxjLo0DEQY30G5tgI+QTWcgGhe9LCfMkOGwpMZmf5tRoNtR/ynsi1bprLqAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EGAsdeA54eXyq7wYqk7x/LH5qCMZj2/X/HTiXQMwf+dAHkqut7LSk3DlFfyvasl4hS6gV1gpezdrXWiq7F58c7INKmxG2Ry1Nko8w334OMc9YiG38Mc7Aa5WG+oTR50ezhvRATpSlfFZdKsarrPFl69yehmSlVNC1an6db/k6OPE3iP2l9cUAnL8By2FMvbMYNsKfeOR34bV6q+6/eYKcwPY2y2vgMeIhlhswP1d2FEfoPd1J53BhMqGr8k471O7mPIRVtGE1RO9J6TigqaXDXgu+i9ti879v1aVeIkhX6t8t3rPzUIsFJj254yHNAoX0MVA5E8UNtgL5I3vKaUrfupmDg2OsBTtkOP2JULvz06raeZQsrbAC+b2keY70FHsfdCIkNH/wDWMKTGozLkcq5rIR2xZs5eDxlg3whRoJFlgQ695d4tf+vf6mUDcT7QR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:54:06.9199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766bdac0-1c46-4e94-ff3a-08df17b5835e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026957.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
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

Serialize GFX recovery with mec.reset_mutex and attempt MES suspend
before locating a user HQD. Back up collateral kernel rings before reset,
then resume MES before testing and replaying rebuilt rings.

Allow reset to proceed if suspend fails. Always attempt resume, report
reset or resume errors, and leave schedulers stopped on failure.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 115 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  16 ++++
 2 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b91bb5166ea8..2da839228911 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1704,7 +1704,6 @@ static ssize_t compute_partition_mem_alloc_mode_show(struct device *dev,
 			  amdgpu_gfx_compute_mem_alloc_mode_desc(mode));
 }
 

 static ssize_t compute_partition_mem_alloc_mode_store(struct device *dev,
 						struct device_attribute *addr,
 						const char *buf, size_t count)
@@ -2099,6 +2098,84 @@ static int amdgpu_gfx_mes_reset_queue_start(struct amdgpu_ring *ring,
 	return 0;
 }
 
+/*
+ * Reset one GFX queue and preserve collateral kernel rings on its pipe.
+ * Exactly one of @ring / @queue is non-NULL.
+ * This helper takes the reset mutex; callers must not already hold it.
+ */
+int amdgpu_gfx_reset_mes_gfx(struct amdgpu_device *adev,
+			     struct amdgpu_ring *ring,
+			     struct amdgpu_fence *guilty_fence,
+			     struct amdgpu_usermode_queue *queue,
+			     unsigned int vmid, bool use_mmio)
+{
+	struct mes_reset_queue_input queue_input = { 0 };
+	struct amdgpu_gfx_pipe_reset_ctx ctx;
+	u32 me = U32_MAX, pipe = U32_MAX;
+	int i, r, resume_r;
+
+	mutex_lock(&adev->gfx.mec.reset_mutex);
+
+	/*
+	 * Suspend before detecting the HQD to avoid resolving a slot MES remaps.
+	 * A hung queue can prevent suspend; still try reset and always resume.
+	 */
+	amdgpu_mes_suspend(adev, 0);
+
+	if (queue) {
+		u32 hw_queue_id;
+
+		queue_input.queue_type = queue->queue_type;
+		queue_input.doorbell_offset = queue->doorbell_index;
+		if (adev->gfx.funcs->detect_hung_queue(adev,
+				queue->doorbell_index, &me, &pipe,
+				&hw_queue_id)) {
+			queue_input.use_mmio = true;
+			queue_input.me_id = me;
+			queue_input.pipe_id = pipe;
+			queue_input.queue_id = hw_queue_id;
+		}
+	} else {
+		me = ring->me;
+		pipe = ring->pipe;
+	}
+
+	amdgpu_gfx_pipe_reset_prepare(adev, ring, me, pipe, &ctx);
+
+	if (ring)
+		r = amdgpu_gfx_mes_reset_queue_start(ring, vmid, guilty_fence,
+						     use_mmio);
+	else
+		r = mes_userq_reset_hw(queue, &queue_input);
+
+	resume_r = amdgpu_mes_resume(adev, 0);
+	if (!r)
+		r = resume_r;
+
+	/* MES must run before ring tests or replay. */
+	if (!r && ring)
+		r = amdgpu_ring_reset_helper_end(ring, guilty_fence);
+
+	for (i = 0; !r && i < adev->gfx.num_gfx_rings; i++) {
+		struct amdgpu_ring *cring = &adev->gfx.gfx_ring[i];
+
+		/* MQD rebuild clears wptr; replay only rings rebuilt by pipe reset. */
+		if ((ctx.replay_mask & BIT(i)) && !cring->wptr)
+			r = amdgpu_ring_reset_helper_end(cring, NULL);
+	}
+
+	/* Leave stopped schedulers to GPU recovery if any part failed. */
+	if (!r) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			if (ctx.sched_mask & BIT(i))
+				drm_sched_wqueue_start(&adev->gfx.gfx_ring[i].sched);
+		}
+	}
+
+	mutex_unlock(&adev->gfx.mec.reset_mutex);
+	return r;
+}
+
 int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence,
@@ -2299,6 +2376,41 @@ static void amdgpu_gfx_reset_stop_compute_scheds(struct amdgpu_device *adev,
 	}
 }
 
+/* Caller holds reset_mutex and attempted MES suspend before HQD lookup. */
+void amdgpu_gfx_pipe_reset_prepare(struct amdgpu_device *adev,
+				   struct amdgpu_ring *guilty_ring,
+				   u32 me, u32 pipe,
+				   struct amdgpu_gfx_pipe_reset_ctx *ctx)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	lockdep_assert_held(&adev->gfx.mec.reset_mutex);
+	ctx->sched_mask = 0;
+	ctx->replay_mask = 0;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		ring = &adev->gfx.gfx_ring[i];
+		/* An unresolved userq slot requires protecting every GFX pipe. */
+		if (ring == guilty_ring ||
+		    (me != U32_MAX && ring->me != me) ||
+		    (pipe != U32_MAX && ring->pipe != pipe) ||
+		    !amdgpu_ring_sched_ready(ring))
+			continue;
+
+		if (!drm_sched_is_stopped(&ring->sched)) {
+			drm_sched_wqueue_stop(&ring->sched);
+			ctx->sched_mask |= BIT(i);
+		}
+
+		if (amdgpu_fence_count_emitted(ring)) {
+			amdgpu_ring_reset_helper_begin(ring, NULL);
+			if (ring->ring_backup_entries_to_copy)
+				ctx->replay_mask |= BIT(i);
+		}
+	}
+}
+
 /*
  * Match the MES-reported hung doorbell against a compute ring and run
  * the reset. On hit, the matched ring and its guilty fence are returned
@@ -3096,4 +3208,3 @@ int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	return 0;
 }
-
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index c948fd2130a0..855651f0c930 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -700,6 +700,22 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence,
 			       bool use_mmio);
 void amdgpu_gfx_mqd_reset_restore(struct amdgpu_ring *ring);
+struct amdgpu_gfx_pipe_reset_ctx {
+	/* Schedulers stopped by this reset. */
+	unsigned long sched_mask;
+	/* Rings with backed-up commands. */
+	unsigned long replay_mask;
+};
+
+void amdgpu_gfx_pipe_reset_prepare(struct amdgpu_device *adev,
+				   struct amdgpu_ring *guilty_ring,
+				   u32 me, u32 pipe,
+				   struct amdgpu_gfx_pipe_reset_ctx *ctx);
+int amdgpu_gfx_reset_mes_gfx(struct amdgpu_device *adev,
+			     struct amdgpu_ring *ring,
+			     struct amdgpu_fence *guilty_fence,
+			     struct amdgpu_usermode_queue *queue,
+			     unsigned int vmid, bool use_mmio);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
-- 
2.49.0

