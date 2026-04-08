Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0B5105D991
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 01:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED2A10E2D7;
	Wed,  8 Apr 2026 01:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rltGkCTW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE5810E2D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 01:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGWZDYm2WppoOoocGF5/yb3uUOLzAa5XfPOf7le+F+LXqgWlg7NyQg1A8YtlvFGTsf+ly6JJ66H3ro8sVV8c0w+upmlwvVgl3sJVkZAhl0nyOL72g4fZm8bbz6N3ToeauulCaqe88cLBx2kbqf8uFu3Gc/SULEukzKF9uh+UaWwC+YYyzecCxYQ5KyQ971Wsm7KAsl4S0k9v2LZF9MCn9Mpwm40BEUSJzWjPtCT+IXPxTNnrrejoStuedeCGS8CfQU7B9njrqwUzwOnWeEbvkqhLfWctJksAkChxhgnjixXYkRI2azQFe/PzYuUs1ML5Hu/oojAaqxrdFUeI5aYfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvCHYJB7ldtZVkLe50NjU4aDHTsWRCjBu6jKo5H2kyA=;
 b=nqn7tyKIft9twav+6/QdGDxRb7MvRXWVbzDpRvwsdKbK4NvbEMgmZjZE2BfcvSMZQ3DVurgSkeN+mdOHOMJPWf22eZVFOHtt5bxyKpBEJbJ7JPeUB8l6qrO8X8Eybgmlby2+GyFYbYsked9drH7EO+662lwbmWVWXiKSTRjw1F6jTk+4hez5+UbRjyAYihEZWk0wZzmuv+TTIeZIxCgFa5ep/XebctDTtRoizmRafA9mONFm2JlGPyzB7BBc6Qsp4gKrUz8C1Ywm6wuaNgYk0u5lgitSGzH4pKypZXIaCk8gpr1O/g9YPZUx/xBAxJuHg2odylavnh8iTw6BqutYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvCHYJB7ldtZVkLe50NjU4aDHTsWRCjBu6jKo5H2kyA=;
 b=rltGkCTWYFtVRRyR1tC3w1TCTz4p0lrokp5Ou3vkV59cc4T7nda/22WjyI1/yxEbErDR0ayOsH/Jpf2j2kA4SfiW7ozZ+SCh8xLJSFKZIaQQwXQVm+tDZsVf0aYKeNl/G3XlfOK+w0RnQ9+5FNzw9rEBpynzhHz/G0oMQtA1snA=
Received: from DS7PR03CA0185.namprd03.prod.outlook.com (2603:10b6:5:3b6::10)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 01:16:14 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::23) by DS7PR03CA0185.outlook.office365.com
 (2603:10b6:5:3b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 01:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 01:16:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 20:16:13 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 20:16:01 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Manu Rastogi <manu.rastogi@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu/gfx_v11_0: fix GFX11 MEC pipe reset ordering
Date: Wed, 8 Apr 2026 09:15:08 +0800
Message-ID: <20260408011600.2512734-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 771b06b0-11fb-4205-0c25-08de950c6d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: v4fUFIgjWPDmJmgxTXkY9GzpkY+++zHMsr9iz+Bi3tsOmd7jqw+xZc7vZP8GF8O6C+XEjKMQz3PpBA5bkTCYxyeiwKxUV4HJAmEpGBsmLRfnwC3s4T76FNXhXCzAPcqe5AkyiKdsegstupKdhEGc9NwJFyN6WW7WdeMFKBeVwBN/Go3eZyQvmxsVMHJiy2vgnxLs1tTlgwuWiDfOiZHpJm6rm2oPQX3MzNXSx/gjQ8DwNSlG0IsEuW6BX2dN8makykjBJL3QTLE92OY48CSm1CyJB4bhb1wKp6fH2xPAqcgav9kv5ZZhGja8XbaREx6RAwBIJfwOtHG5oovBkKybCBk3Xcxt0lbk3KRvCNwVAw+Jf3GackTT6hUbmatbSKhIOJRRyGhWWKkxbM0KaBxBiUidqXBzuXDtzq0FtfMi2ztAivb98h7o7zP7aBYaN3VMZg9h8XKQYm4X8lYA7ug3WG6a+C77ROcwjiYlMuQvpqI/92LVP5QBhZsMr/mOZKFxmZxcPARne+5Tqr7gxJQsO5zYWcJf7/mmRxc/x4/3+/s0LDzOpXzAAZYO2xTesJPGnH7MCqyJHJ419v+ZE6/tegV5r3odORqgTWDo5da2UMnv+x1C6BZkOawCosZyIPKrVo3OCXI0p0wp33Z5UYaf8zShUDlmotVFkbIflC7rO63vuf1sSBID4ap5xczL2+3iSeOVhVzVu+XLVRpt5oCCe0KNpD3GhVyjAeHt6ij4u2G01oOluXw3EcUUoMDDqA8aOujEPYsmK/HMQE7/oEVcRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DKdPRsNQRxYQizP7pFRkHk55LalLx/FRjmC9gREoms7wDQMEYlzaIiQwSd1LbqSNjSkP3dfNcBIWNZgS2YsFlakFuR+YJ9NMyyzxOu9PhvCbab08a+bVugZf6149M2s0j5FbJY+WBTl4zWWhWkzayx/5KJ/lIgtJAFE8wgIFO1FlxWjQRFw1fkzt0jVg4lzpu8qlUwg0QdyMNW/ccBURhtpiwPH4xfTJj8O1R5PMkSN9PplO+zFau9UTGRbsDRpF6pn600ReTWsbam+9wlDd+9f9lCzTmEhWFq4CLTrqtnHGXA2FXzsZHfNr6u/N3VMBDvMKqMM9ti3t8SgyiKsTktIBbcm1AuWYzCseAbSbLsgWAvuWPUnhkTZavcphnu04mabFwzw2vj01GuK1k5iuYHpf453amCMDAdLmYE6vgYUN0gJfF8IJjer2h3abKO52
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 01:16:13.8825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 771b06b0-11fb-4205-0c25-08de950c6d55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908
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

Hold MEC pipe reset asserted, walk every queue on that (me, pipe) and tear
down CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST via gfx_v11_0_clear_hqds_on_mec_pipe(),
then deassert reset. Avoids releasing pipe reset while HQDs may still be
active.

Legacy (non-RS64) path: read CP_MEC_CNTL for the reset mask instead of
reusing CP_MEC_RS64_CNTL state.

V2:stop the schedulers for all queues on the pipe and then mark the fences with an error
and then make sure to re-enable and test all of the queues after the reset (Alex)

Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 133 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  11 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 157 +++++++++++++++---------
 3 files changed, 243 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9254..a30a21163d2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -69,6 +69,139 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 
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
+ * Backs up ring state for sibling KCQs on the same (me, pipe), stops their DRM
+ * schedulers, and stops KFD scheduling for the node. The guilty ring is already
+ * backed up by amdgpu_ring_reset_helper_begin().
+ */
+void amdgpu_gfx_mec_pipe_reset_prepare(struct amdgpu_device *adev,
+				       struct amdgpu_ring *guilty)
+{
+	struct amdgpu_ring *r;
+	unsigned int j, base;
+
+	base = amdgpu_gfx_mec_pipe_compute_ring_base(adev, guilty->xcc_id);
+	for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+		r = &adev->gfx.compute_ring[base + j];
+		if (!amdgpu_gfx_ring_on_mec_pipe(r, guilty->me, guilty->pipe))
+			continue;
+		if (r != guilty)
+			amdgpu_ring_backup_unprocessed_commands(r, NULL);
+		if (amdgpu_ring_sched_ready(r))
+			drm_sched_wqueue_stop(&r->sched);
+	}
+
+	if (adev->kfd.init_complete)
+		amdgpu_amdkfd_stop_sched(adev, guilty->xcc_id);
+}
+
+void amdgpu_gfx_mec_pipe_restart_schedulers(struct amdgpu_device *adev,
+					    u32 me, u32 pipe, u32 xcc_id)
+{
+	struct amdgpu_ring *r;
+	unsigned int j, base;
+
+	base = amdgpu_gfx_mec_pipe_compute_ring_base(adev, xcc_id);
+	for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+		r = &adev->gfx.compute_ring[base + j];
+		if (!amdgpu_gfx_ring_on_mec_pipe(r, me, pipe))
+			continue;
+		if (amdgpu_ring_sched_ready(r))
+			drm_sched_wqueue_start(&r->sched);
+	}
+
+	if (adev->kfd.init_complete)
+		amdgpu_amdkfd_start_sched(adev, xcc_id);
+}
+
+/**
+ * amdgpu_gfx_mec_pipe_reset_recover_queues - re-init KCQs after MEC pipe reset
+ *
+ * Re-inits and remaps every kernel compute queue on the guilty ring's MEC pipe,
+ * restarts schedulers, then for each queue calls amdgpu_ring_reset_helper_end()
+ * (ring test + fence error / reemit). Sibling queues use a synthetic fence
+ * context so collateral work is reemitted.
+ * @timedout_fence: timeout fence for the guilty ring; must be non-NULL.
+ * @kcq_init: IP hook (e.g. gfx_v11_0_kcq_init_queue).
+ */
+int amdgpu_gfx_mec_pipe_reset_recover_queues(struct amdgpu_device *adev,
+					     struct amdgpu_ring *guilty,
+					     struct amdgpu_fence *timedout_fence,
+					     amdgpu_gfx_kcq_init_queue_t kcq_init)
+{
+	struct amdgpu_fence collateral_reemit = {};
+	struct amdgpu_ring *r;
+	unsigned int j, base;
+	int err = 0;
+
+	if (!timedout_fence)
+		return -EINVAL;
+
+	collateral_reemit.context = (u64)-1;
+
+	base = amdgpu_gfx_mec_pipe_compute_ring_base(adev, guilty->xcc_id);
+	for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+		r = &adev->gfx.compute_ring[base + j];
+		if (!amdgpu_gfx_ring_on_mec_pipe(r, guilty->me, guilty->pipe))
+			continue;
+
+		err = kcq_init(r, true);
+		if (err)
+			goto err_sched;
+		err = amdgpu_mes_map_legacy_queue(adev, r, 0);
+		if (err)
+			goto err_sched;
+	}
+
+	amdgpu_gfx_mec_pipe_restart_schedulers(adev, guilty->me, guilty->pipe,
+					       guilty->xcc_id);
+
+	for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+		r = &adev->gfx.compute_ring[base + j];
+		if (!amdgpu_gfx_ring_on_mec_pipe(r, guilty->me, guilty->pipe))
+			continue;
+
+		err = amdgpu_ring_reset_helper_end(
+			r, r == guilty ? timedout_fence : &collateral_reemit);
+		if (err) {
+			dev_err(adev->dev,
+				"ring %s failed recover after MEC pipe reset (%d)\n",
+				r->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+
+err_sched:
+	amdgpu_gfx_mec_pipe_restart_schedulers(adev, guilty->me, guilty->pipe,
+					       guilty->xcc_id);
+	return err;
+}
+
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev,
 				     int xcc_id, int mec, int pipe, int queue)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b41da..a4a31fcd2d47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -603,6 +603,17 @@ int amdgpu_gfx_mec_queue_to_bit(struct amdgpu_device *adev, int mec,
 				int pipe, int queue);
 void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 				 int *mec, int *pipe, int *queue);
+
+typedef int (*amdgpu_gfx_kcq_init_queue_t)(struct amdgpu_ring *ring, bool clear);
+
+void amdgpu_gfx_mec_pipe_reset_prepare(struct amdgpu_device *adev,
+				       struct amdgpu_ring *guilty);
+void amdgpu_gfx_mec_pipe_restart_schedulers(struct amdgpu_device *adev,
+					    u32 me, u32 pipe, u32 xcc_id);
+int amdgpu_gfx_mec_pipe_reset_recover_queues(
+	struct amdgpu_device *adev, struct amdgpu_ring *guilty,
+	struct amdgpu_fence *timedout_fence,
+	amdgpu_gfx_kcq_init_queue_t kcq_init);
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int xcc_id,
 				     int mec, int pipe, int queue);
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ae39b9e1f7d6..a25fc25279b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6906,11 +6906,40 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
+/*
+ * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
+ * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
+ * asserted; only then clear the pipe reset bit.
+ * Caller must hold adev->srbm_mutex.
+ */
+static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
+					     u32 pipe)
+{
+	unsigned int q;
+	int j;
+
+	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+		soc21_grbm_select(adev, me, pipe, q, 0);
+		/* Start from a clean HQD dequeue state before forcing HQD inactive. */
+		WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
+		if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+			WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+			for (j = 0; j < adev->usec_timeout; j++) {
+				if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+					break;
+				udelay(1);
+			}
+		}
+
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
+	}
+}
+
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 {
 
 	struct amdgpu_device *adev = ring->adev;
-	uint32_t reset_pipe = 0, clean_pipe = 0;
+	uint32_t reset_val, clean_val;
 	int r;
 
 	if (!gfx_v11_pipe_reset_support(adev))
@@ -6920,69 +6949,73 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
 
-	reset_pipe = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
-	clean_pipe = reset_pipe;
-
 	if (adev->gfx.rs64_enable) {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+		clean_val = reset_val;
 
 		switch (ring->pipe) {
 		case 0:
-			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
-						   MEC_PIPE0_RESET, 1);
-			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
-						   MEC_PIPE0_RESET, 0);
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE0_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE0_RESET, 0);
 			break;
 		case 1:
-			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
-						   MEC_PIPE1_RESET, 1);
-			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
-						   MEC_PIPE1_RESET, 0);
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE1_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE1_RESET, 0);
 			break;
 		case 2:
-			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
-						   MEC_PIPE2_RESET, 1);
-			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
-						   MEC_PIPE2_RESET, 0);
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE2_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE2_RESET, 0);
 			break;
 		case 3:
-			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
-						   MEC_PIPE3_RESET, 1);
-			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
-						   MEC_PIPE3_RESET, 0);
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE3_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE3_RESET, 0);
 			break;
 		default:
 			break;
 		}
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
+		gfx_v11_0_clear_hqds_on_mec_pipe(adev, ring->me, ring->pipe);
+		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
 		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
 					RS64_FW_UC_START_ADDR_LO;
 	} else {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+		clean_val = reset_val;
+
 		if (ring->me == 1) {
 			switch (ring->pipe) {
 			case 0:
-				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE0_RESET, 1);
-				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE0_RESET, 0);
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE0_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE0_RESET, 0);
 				break;
 			case 1:
-				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE1_RESET, 1);
-				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE1_RESET, 0);
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE1_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE1_RESET, 0);
 				break;
 			case 2:
-				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE2_RESET, 1);
-				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE2_RESET, 0);
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE2_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE2_RESET, 0);
 				break;
 			case 3:
-				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE3_RESET, 1);
-				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE3_RESET, 0);
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE3_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE3_RESET, 0);
 				break;
 			default:
 				break;
@@ -6991,36 +7024,38 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 		} else {
 			switch (ring->pipe) {
 			case 0:
-				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME2_PIPE0_RESET, 1);
-				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME2_PIPE0_RESET, 0);
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE0_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE0_RESET, 0);
 				break;
 			case 1:
-				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME2_PIPE1_RESET, 1);
-				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME2_PIPE1_RESET, 0);
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE1_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE1_RESET, 0);
 				break;
 			case 2:
-				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME2_PIPE2_RESET, 1);
-				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME2_PIPE2_RESET, 0);
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE2_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE2_RESET, 0);
 				break;
 			case 3:
-				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME2_PIPE3_RESET, 1);
-				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME2_PIPE3_RESET, 0);
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE3_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE3_RESET, 0);
 				break;
 			default:
 				break;
 			}
 			/* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
 		}
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
+		gfx_v11_0_clear_hqds_on_mec_pipe(adev, ring->me, ring->pipe);
+		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
 		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
 	}
 
@@ -7028,7 +7063,7 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->srbm_mutex);
 	gfx_v11_0_unset_safe_mode(adev, 0);
 
-	dev_info(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
+	dev_dbg(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
 			r == 0 ? "successfully" : "failed");
 	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
 	 * reset status relies on the compute ring test result.
@@ -7048,9 +7083,15 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
+		amdgpu_gfx_mec_pipe_reset_prepare(adev, ring);
 		r = gfx_v11_0_reset_compute_pipe(ring);
-		if (r)
+		if (r) {
+			amdgpu_gfx_mec_pipe_restart_schedulers(adev, ring->me, ring->pipe,
+							       ring->xcc_id);
 			return r;
+		}
+		return amdgpu_gfx_mec_pipe_reset_recover_queues(adev, ring, timedout_fence,
+								gfx_v11_0_kcq_init_queue);
 	}
 
 	r = gfx_v11_0_kcq_init_queue(ring, true);
-- 
2.49.0

