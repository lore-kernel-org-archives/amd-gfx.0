Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F204ED7B8D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 08:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259FD10E5B1;
	Tue, 14 Apr 2026 08:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RkZcR5wy";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2182010E5B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 08:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8zDoMr8cP0U+Y/AAYW6k0nPHXjJUmv/Q6KsqMiFI9plK59AxNMMt8l6vKY8u5wI+4vay8ePc0enkB1NrnlsntVtzl43KFNMAEyRJMSGWFLKO72XwRAe44DkeXvexYMRGplukHfhYPNtl5+toI5f7MlK7GAZXaoP+xUCD1J2W5yoe3Z0giP43dQ8OlBC5ApUFLXsna+t3gHNCScd7+SeB4vqJg5BZGDLB00NzyKABo4vRIIsXsFJIogwe/qvP5Iks3EkcD0HEGqDN5D2jtFxFzIH3z95IvUFc0bcTsd3zx/TMGCm1Ne2vctU3rfpFYPY5W6Vk5l++IOUhUaVnAbTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQWltDqAi7QByMjrUpLV22jC3arbrcZR/f7ASjhfW5k=;
 b=sBSMMxTLAlKhi6h77c2mMcYU9BQq6QJODtwbs9Lfls6ehoSmbXaBvWp0W/powx4YdeGHNsBi9BE0FCM1AWPh2q/gvSXgzb3MWfNZbrlokfpVso6jVyPcRUJc6mPLpXBl9aV6PrUnHlLlboHZYzwwAgyrvYnVgodzcDMz9RxuG+gvCSaJ2EGxXJjZfGu+Im9a6501lHjE7V0uKEdKuVirpdatUkf4Ja/OwffqFYBFfani/3vi2kEe15BT4vQ5Znn6hFl1hOP563KuXTmhkgkEf0Kw/yC4+MhZoYlXx9HYVemuRk3EaC7DpN/cdl33R/GyLhRf3fOd0NLDPnBA1Wu2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQWltDqAi7QByMjrUpLV22jC3arbrcZR/f7ASjhfW5k=;
 b=RkZcR5wydkBafZCWAGgkTuGU3YRZV2+RyKLz6EsvDUy4djX0pUOIGhlMt6oXO8bxTMKqRpDe34R3VEJduPzDTOCZ3zNZlU0LOOr1iFIe3HXOhyOTdK/oBgvKblY25KtetGb9/8uxDw7OrcUwthUXuteTusKWQ3iFI8dItD7rHsI=
Received: from BY3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:254::19)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:59:41 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::ee) by BY3PR05CA0014.outlook.office365.com
 (2603:10b6:a03:254::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 08:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 08:59:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Apr
 2026 03:59:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Apr
 2026 03:59:39 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 03:59:27 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 1/8] drm/amdgpu: add coordinated MEC pipe reset for GFX
 compute queues
Date: Tue, 14 Apr 2026 16:58:48 +0800
Message-ID: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e7f3d0-fa42-452f-cd14-08de9a0429a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ylusraa63TqrAgJigx4NM8AJrYIx5yfyJ8An37KrKjzl59LuSIeRqElf95d/cepkCIRiVVLBvg8XiTzMNgriUbFY3IXiMYgl93F+h1jfY9igfE16kqNICHRPcjJdpBbf/qY0Q2y5aNREeL8wxKq2Wat8A+2W0ZMQOFg/XfboPWOVvjzErlKUkZUEjcQsKAV0NI7jtoqcgkybAHcNSNKGWdd7054o2El6Uhb5q7SBfRHKAeyxfAZ8GWfmTc7xonCckaS7dZHpD7+CLgLUJOPn72aYkBKURK1ezYBLtMqSq29Lt54A6VtZ2UeqdFOeRCxPSUYbhC75yUKupenW/39XgZgCQyCu7PjoRH/TK6MRYYMghQYaOfuTqpXOS7DH9wHHEUR2zfI7NaOqZHvI8yLdpv+drOzfEdlnqTyZ5Hb87ARcDFE0kQK+ea9ICFXCcKPtqxdAYmaDICpZX2Pvfqn8Ydo1Wt+BWrAOf/eDiEA7ES6xOsQu8FYWEEjJ+FlGvfIk9NfmeUfD5nQXRQFBMS6tN8HwXwIr4n12S/e7oIaq9jZf7ig9HxdrdKr8dybo3Jvlj7syzAHA3piKutI4qd3oE7+5uvuQJEbilofnpeHI89fW/ClB77RjfXDJsAtM97jN4mBhNfNUMcytlJBTZtSmMV2qOccIIRihAkI7s3HWh7s2T6KZ/l5n0plHpeUAC8f4Tms+aSWD1TvxExNgwPpdYMpR7fImsxx8fcAATse6+KKC+NWgMrTz8vJuRu8rjSbHxRRtNf5txVeC7NGtuk9BgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Tp+AqmPUzE3/j/QHc18geUKxsWpnIi5XhdVmSx2K1w9QJL6QNB0BiQN383ew2Q/BG+YnVWSYuf+DY3/vLdhlBofVyWhIwfWhCoJEgwE+a2dO/jh17wq7RbBIkbWeWsYB9QFJGbXYTnzomFdQrmC8ANgS5nggaFh2azo2+i8mi5ETfvoXwNoFbYzVryxhow1G7tmGXzXxxfo6+WM3DzjvssjefxsWjSR/MDfwJyfrFqufChMBRIA8xvCprdVOZYzW28hbuTU9AX+pShkq+6xmaiNgqsOE/PjMC8KXEpzeKx0uxODNMF2uAM8wjbGgxGo0PUI4ZJ9ffXWT+WGeE+7Q1hyBGm0W5/OaagdZBS9kHEtqFvdYO3MTzXuOxeH3NEEVPz9WckpAEvMWn49OeLkSGbSWRwH3JDfPno06/zPLWCleHCqwO9HbmHumD7vcbem
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:59:40.1327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e7f3d0-fa42-452f-cd14-08de9a0429a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4
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

Introduce a shared mutex and common helpers to serialize MEC pipe reset
sequences between KGD (DRM scheduler) and KFD (AMDKFD) paths. This
prevents races where one path could stop/start schedulers or reprogram
hardware while the other is in the middle of a pipe reset, potentially
leading to queue map/unmap corruption or HQD state mismatches.

The change adds:

  - mec_pipe_reset_mutex to struct amdgpu_gfx, initialized during
    device init.

  - amdgpu_gfx_mec_pipe_reset_prepare(): stops DRM schedulers and KFD
    scheduling for all compute rings on a given (xcc_id, me, pipe)
    tuple, backing up unprocessed commands except for an optional
    guilty queue that is already handled via the KGD ring reset path.

  - amdgpu_gfx_mec_pipe_restart_schedulers(): restarts all schedulers
    and KFD scheduling for the affected pipe.

  - amdgpu_gfx_mec_pipe_reset_recover_queues(): re-initializes and
    remaps each KCQ on the pipe, optionally using a timed-out fence for
    the guilty queue and collateral fences for others, then completes
    the ring reset helper sequence.

  - amdgpu_gfx_mec_pipe_reset_run(): the core orchestration routine
    that takes the mutex, invokes prepare, performs the HW pipe reset
    via either a KFD or KGD callback, restarts schedulers on error, and
    recovers queues.

The implementation correctly handles single and multi-XCC configurations
by offsetting into the compute_ring array per partition. The special
queue value AMDGPU_MEC_PIPE_RESET_NO_QUEUE allows KFD-initiated resets
where no single DRM KCQ is identified as the timeout victim.

Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 196 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  35 ++++
 3 files changed, 232 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fbdf458758d6..62d573b6135f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3742,6 +3742,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		amdgpu_sync_create(&adev->isolation[i].active);
 		amdgpu_sync_create(&adev->isolation[i].prev);
 	}
+	mutex_init(&adev->gfx.mec_pipe_reset_mutex);
 	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9254..8118a91f6b64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/lockdep.h>
 #include <linux/pm_runtime.h>
 
 #include "amdgpu.h"
@@ -69,6 +70,201 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 
 }
 
+static bool amdgpu_gfx_ring_on_mec_pipe(struct amdgpu_ring *ring, u32 me, u32 pipe)
+{
+	if (!ring || !ring->funcs || ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
+		return false;
+	if (ring->no_scheduler)
+		return false;
+
+	return ring->me == me && ring->pipe == pipe;
+}
+
+/* Same layout as amdgpu_gfx_run_cleaner_shader(): block of num_compute_rings per XCC. */
+static unsigned int amdgpu_gfx_mec_pipe_compute_ring_base(struct amdgpu_device *adev,
+							 u32 xcc_id)
+{
+	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+
+	if (num_xcc <= 1)
+		return 0;
+	return xcc_id * adev->gfx.num_compute_rings;
+}
+
+/**
+ * amdgpu_gfx_mec_pipe_reset_prepare - stop schedulers before MEC pipe reset HW
+ *
+ * Backs up ring state for KCQs on (@xcc_id, @me, @pipe), stops their DRM
+ * schedulers, and stops KFD scheduling for the node. The MEC queue at
+ * @guilty_queue is skipped when it is not AMDGPU_MEC_PIPE_RESET_NO_QUEUE
+ * (already backed up by amdgpu_ring_reset_helper_begin() on the KGD path).
+ *
+ * Caller must hold &adev->gfx.mec_pipe_reset_mutex (e.g. via
+ * amdgpu_gfx_mec_pipe_reset_run()).
+ */
+void amdgpu_gfx_mec_pipe_reset_prepare(struct amdgpu_device *adev,
+				       u32 xcc_id, u32 me, u32 pipe,
+				       u32 guilty_queue)
+{
+	struct amdgpu_ring *ring;
+	unsigned int j, base;
+	bool skip_by_queue = (guilty_queue == AMDGPU_MEC_PIPE_RESET_NO_QUEUE);
+
+	lockdep_assert_held(&adev->gfx.mec_pipe_reset_mutex);
+
+	base = amdgpu_gfx_mec_pipe_compute_ring_base(adev, xcc_id);
+	for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+		ring = &adev->gfx.compute_ring[base + j];
+		if (!amdgpu_gfx_ring_on_mec_pipe(ring, me, pipe))
+			continue;
+		if (skip_by_queue || ring->queue != guilty_queue)
+			amdgpu_ring_backup_unprocessed_commands(ring, NULL);
+		if (amdgpu_ring_sched_ready(ring))
+			drm_sched_wqueue_stop(&ring->sched);
+	}
+}
+
+void amdgpu_gfx_mec_pipe_restart_schedulers(struct amdgpu_device *adev,
+					    u32 me, u32 pipe, u32 xcc_id)
+{
+	struct amdgpu_ring *ring;
+	unsigned int j, base;
+
+	lockdep_assert_held(&adev->gfx.mec_pipe_reset_mutex);
+
+	base = amdgpu_gfx_mec_pipe_compute_ring_base(adev, xcc_id);
+	for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+		ring = &adev->gfx.compute_ring[base + j];
+		if (!amdgpu_gfx_ring_on_mec_pipe(ring, me, pipe))
+			continue;
+		if (amdgpu_ring_sched_ready(ring))
+			drm_sched_wqueue_start(&ring->sched);
+	}
+}
+
+/**
+ * amdgpu_gfx_mec_pipe_reset_recover_queues - re-init KCQs after MEC pipe reset
+ *
+ * Re-inits and remaps every kernel compute queue on (@xcc_id, @me, @pipe),
+ * restarts schedulers, then amdgpu_ring_reset_helper_end() per ring.
+ * @guilty_queue: MEC queue index of the timed-out KCQ, or
+ * AMDGPU_MEC_PIPE_RESET_NO_QUEUE when every ring uses the collateral fence;
+ * @timedout_fence must then be NULL.
+ * @kcq_init: optional IP hook for kcq_init + MES remap.
+ *
+ * Caller must hold &adev->gfx.mec_pipe_reset_mutex (e.g. via
+ * amdgpu_gfx_mec_pipe_reset_run()).
+ */
+int amdgpu_gfx_mec_pipe_reset_recover_queues(struct amdgpu_device *adev,
+					     u32 xcc_id, u32 me, u32 pipe,
+					     u32 guilty_queue,
+					     struct amdgpu_fence *timedout_fence,
+					     amdgpu_gfx_kcq_init_queue_t kcq_init)
+{
+	struct amdgpu_fence collateral_reemit = {};
+	struct amdgpu_ring *ring;
+	unsigned int j, base;
+	int err = 0;
+	bool has_guilty = (guilty_queue != AMDGPU_MEC_PIPE_RESET_NO_QUEUE);
+
+	lockdep_assert_held(&adev->gfx.mec_pipe_reset_mutex);
+
+	if (has_guilty && !timedout_fence)
+		return -EINVAL;
+
+	collateral_reemit.context = (u64)-1;
+
+	base = amdgpu_gfx_mec_pipe_compute_ring_base(adev, xcc_id);
+	if (kcq_init) {
+		for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+			ring = &adev->gfx.compute_ring[base + j];
+			if (!amdgpu_gfx_ring_on_mec_pipe(ring, me, pipe))
+				continue;
+
+			err = kcq_init(ring, true);
+			if (err)
+				goto err_sched;
+			err = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+			if (err)
+				goto err_sched;
+		}
+	}
+
+	amdgpu_gfx_mec_pipe_restart_schedulers(adev, me, pipe, xcc_id);
+
+	for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+		ring = &adev->gfx.compute_ring[base + j];
+		if (!amdgpu_gfx_ring_on_mec_pipe(ring, me, pipe))
+			continue;
+
+		err = amdgpu_ring_reset_helper_end(
+			ring,
+			(timedout_fence && ring->queue == guilty_queue) ?
+				timedout_fence :
+				&collateral_reemit);
+		if (err) {
+			dev_err(adev->dev,
+				"ring %s failed recover after MEC pipe reset (%d)\n",
+				ring->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+
+err_sched:
+	amdgpu_gfx_mec_pipe_restart_schedulers(adev, me, pipe, xcc_id);
+	return err;
+}
+
+/**
+ * amdgpu_gfx_mec_pipe_reset_run - coordinate MEC pipe reset between KGD and KFD
+ *
+ * Takes &adev->gfx.mec_pipe_reset_mutex for the full prepare → pipe HW/reset →
+ * recover sequence so KFD and KGD cannot interleave scheduler stop/start,
+ * MES map/unmap, or HQD programming on the same device.
+ *
+ * @queue: MEC queue index (required when @kcq_pipe_reset is used).
+ * AMDGPU_MEC_PIPE_RESET_NO_QUEUE is only valid with @kfd_pipe_reset (KFD path;
+ * pass @timedout_fence NULL). At least one of @kcq_pipe_reset or @kfd_pipe_reset
+ * must be non-NULL.
+ * If both are provided, only @kfd_pipe_reset is invoked.
+ *
+ * Returns: 0 on success, or a negative error code.
+ */
+int amdgpu_gfx_mec_pipe_reset_run(struct amdgpu_device *adev,
+				  u32 xcc_id, u32 me, u32 pipe, u32 queue,
+				  struct amdgpu_fence *timedout_fence,
+				  amdgpu_gfx_kcq_mec_pipe_reset_t kcq_pipe_reset,
+				  amdgpu_gfx_kfd_mec_pipe_reset_t kfd_pipe_reset,
+				  amdgpu_gfx_kcq_init_queue_t kcq_init)
+{
+	int err;
+
+	if (!kcq_pipe_reset && !kfd_pipe_reset)
+		return -EINVAL;
+
+	mutex_lock(&adev->gfx.mec_pipe_reset_mutex);
+	amdgpu_gfx_mec_pipe_reset_prepare(adev, xcc_id, me, pipe, queue);
+
+	if (kfd_pipe_reset)
+		err = kfd_pipe_reset(adev, xcc_id, me, pipe);
+	else
+		err = kcq_pipe_reset(adev, me, pipe, queue);
+
+	if (err) {
+		amdgpu_gfx_mec_pipe_restart_schedulers(adev, me, pipe, xcc_id);
+		mutex_unlock(&adev->gfx.mec_pipe_reset_mutex);
+		return err;
+	}
+
+	err = amdgpu_gfx_mec_pipe_reset_recover_queues(adev, xcc_id, me, pipe,
+							queue, timedout_fence,
+							kcq_init);
+	mutex_unlock(&adev->gfx.mec_pipe_reset_mutex);
+	return err;
+}
+
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev,
 				     int xcc_id, int mec, int pipe, int queue)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b41da..a1f13262d782 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -527,6 +527,9 @@ struct amdgpu_gfx {
 	const void			*cleaner_shader_ptr;
 	bool				enable_cleaner_shader;
 	struct amdgpu_isolation_work	enforce_isolation[MAX_XCP];
+	/* Serialize MEC pipe reset prep/HW/recover between KGD and KFD */
+	struct mutex			mec_pipe_reset_mutex;
+
 	/* Mutex for synchronizing KFD scheduler operations */
 	struct mutex                    userq_sch_mutex;
 	u64				userq_sch_req_count[MAX_XCP];
@@ -603,6 +606,38 @@ int amdgpu_gfx_mec_queue_to_bit(struct amdgpu_device *adev, int mec,
 				int pipe, int queue);
 void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 				 int *mec, int *pipe, int *queue);
+
+/*
+ * Pass @queue == AMDGPU_MEC_PIPE_RESET_NO_QUEUE when no DRM KCQ is the timeout
+ * victim (e.g. KFD-driven pipe reset); all queues on the pipe are backed up in
+ * prepare and recover uses collateral fences only.
+ */
+#define AMDGPU_MEC_PIPE_RESET_NO_QUEUE		U32_MAX
+
+typedef int (*amdgpu_gfx_kcq_init_queue_t)(struct amdgpu_ring *ring, bool clear);
+typedef int (*amdgpu_gfx_kcq_mec_pipe_reset_t)(struct amdgpu_device *adev,
+					       u32 me, u32 pipe, u32 queue);
+typedef int (*amdgpu_gfx_kfd_mec_pipe_reset_t)(struct amdgpu_device *adev,
+					       u32 xcc_id, u32 me, u32 pipe);
+
+int amdgpu_gfx_mec_pipe_reset_run(struct amdgpu_device *adev,
+				  u32 xcc_id, u32 me, u32 pipe, u32 queue,
+				  struct amdgpu_fence *timedout_fence,
+				  amdgpu_gfx_kcq_mec_pipe_reset_t kcq_pipe_reset,
+				  amdgpu_gfx_kfd_mec_pipe_reset_t kfd_pipe_reset,
+				  amdgpu_gfx_kcq_init_queue_t kcq_init);
+
+void amdgpu_gfx_mec_pipe_reset_prepare(struct amdgpu_device *adev,
+				       u32 xcc_id, u32 me, u32 pipe,
+				       u32 guilty_queue);
+void amdgpu_gfx_mec_pipe_restart_schedulers(struct amdgpu_device *adev,
+					    u32 me, u32 pipe, u32 xcc_id);
+int amdgpu_gfx_mec_pipe_reset_recover_queues(
+	struct amdgpu_device *adev,
+	u32 xcc_id, u32 me, u32 pipe,
+	u32 guilty_queue,
+	struct amdgpu_fence *timedout_fence,
+	amdgpu_gfx_kcq_init_queue_t kcq_init);
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int xcc_id,
 				     int mec, int pipe, int queue);
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
-- 
2.49.0

