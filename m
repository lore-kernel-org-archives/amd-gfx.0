Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF75CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 07:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A893A10F36F;
	Fri,  8 May 2026 07:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NIMFL6lQ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE7110F36F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 07:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptEgQHxKoW26FWw6lTdfdvCw0RF7OFpnW/qWI/5FH4zkZv7c79gatemwCVaD9Su18eDmRs5O1F7EyUPLKoPM+tyO4tgS3Eb3H4mDSnoPQslO3oLv0nxD0D4jSr8GBh3Twm8OYEgp4Snbrs2NQO8Dr+c8+sITWkruO10gPovSoNct9tF4yX0Z1ZC9T756LrxfokdLEwLk06H61GEKERZGuD11QuDivDSXhyDS089IJglMrFzFosPLPf14qsyu17pU6r2+zMeZh7iGbyjDiNHVojHy189vv1B/MO5tZK5CXV1vuF32UDWOiAn0oUBWjkXhfPbGp4sBqqdscajcyAU6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtHmE3muEB4ytbG/aG4TlXSHXMboLMI4I4KGckVHj10=;
 b=NH0aPS7dk1aqQMyQS432TFbLyG97uPixqpUkx/DevtdrqwFhYG2TME93PtBglm0EwFkECO8yBv79IskjLUXqSi2ipNFoV/1ri6WBV86MOeJ10rqPOzNHLXCFwbiay4hOgNVodt/ujggbnKf8jxQ61k5MRrwjqWo+j/bhad8qbs4a6VtuZWhtsimpJd+lWD7l8GItgcFXnfsA1DgfAzyofJqxvjvfCTkPn+Vr89M+Wy8jyz9BzFVwxmf8bZDA5E8gfyHdMVPbvlp2sPzhUktUmk7sdaONPxAq35kGJqAufzoeXAG1dOA0IciDZX0pu412SNKKnAkS6qC8/lm7I9OzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtHmE3muEB4ytbG/aG4TlXSHXMboLMI4I4KGckVHj10=;
 b=NIMFL6lQKBc6Z10rDHZtqrjk0LTjUw6dq5xIq9HWvTojKSADJ69sajuI5fFdQNM91PYmxsUBD/c/kq0SHS8eKW7Xr5Q6z5NUkiMojwD0b8btXKgMpaM6maNNA/GOxaGLOFeMnmC4iupTfVyYLScPd8ZVmADRNaurN7V9ruJ4b3Q=
Received: from CY5PR19CA0112.namprd19.prod.outlook.com (2603:10b6:930:64::12)
 by IA0PPFA8EB66EE9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bde) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Fri, 8 May
 2026 07:14:04 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::34) by CY5PR19CA0112.outlook.office365.com
 (2603:10b6:930:64::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 07:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:14:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:14:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 00:14:03 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 02:13:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Manu Rastogi <manu.rastogi@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add MEC pipe reset helpers
Date: Fri, 8 May 2026 15:13:33 +0800
Message-ID: <20260508071351.442816-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA0PPFA8EB66EE9:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3b23d9-6e4d-4bee-3327-08deacd16328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: t3/ygAn6HK+XuozPdBy/kikVDWa2D3qpnT0lQVQ4l6PzoqOmtTG8MUAAoYJNIulHQaKcIRFLOkzyfKxpntxnBt1YlVFzIoTK3dWT4r3eH9L/Zv8gPHL2mxihBv84t743RN5+aCEBaQtcS21P/q/NffHBCIb8hV+93D+lG1H4FJBS8w3Yd14l5OqoLgQAncUB6v3eQFPs7V6e/OH+fV1aSw4wfcgRc0JC0WNenU0hNIAF/3gaiYUXcv+jN1N0GsNxhme1oyOhe1CucZbW8yJMR2WpT2lXithvMHKFuYYe4Gcl5FZBtBJh453PUz3VQpednNIAZPl7kkwRjsLuIyyw87xyDRyseULB9BC3Dh8LF5b2xe8eOIidqFvr4mDb9WanBqsShjhe6oIJNg7fn+xVxFwS4kVG3PrYt58y8kUSFsoUwbMhxQ58IjeTMlq59Nm/PlebG5Q1o8suzMVAykARdPVAEHxEobuyNm7amd3Aol77xRSv+GvnZSw1NGAzC4PjtziNCMJbiCfLX483lCWQmohkuCWLjAsOIiuwHWg9xQnxXCzECH70eNEg3J1GN9nr+NrELq85pzEgPI4BBn+5sOQzVGu0tuMXPw465pybqL+zL0bm7PoVO0Ko3sY8/vniDehVtYAPNPmcG0aAHMtznCaeoSSC+5FWSaP/8dzP67G44npSmfgZGhl749R8+MP990jxbE5lTkfCUATc9UjscfpwB1LEefZQiiLvKunbnN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rAY8eC5cGFHW3J+acOqp4YAuFCxReVyk3+v8RZuU1eczYSD1fg5m7E5Gqne1ATiCRTDROIKgwob53xc8L7Kf7gAQ+WrAA2YiZPsW3V9pEWHZuE9WWXTzseY4W3fjjHEim35hh3ba/t8FPc5t6msDIEqEav6XaWHXz7VauHH1QSCSguVCw1M51KA8iljBwCiu64verFvvWzr7uvVwm9tc+1ieJKFfOhnK6TsUPjulmfN8Kp/CBO7olcm+N3Pzfdm559VnT0DGpBKqxwiTFH9f5CNcKgqlUZzYHauQOe7+5tQQpC9+zEPeyKFOeIosFHNeAPUuGwCkceuE19ZeoHIzhBYvVU5XeN0n6ewgflJ45CTuHuEQ5WRvh9XDZNPWpqC+J6L5y9aBHhhQh08K9W3sINkQlI2lbH0+/p60vywmI+5J9PM4VQlG2/Quo6L61Yo/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:14:04.4367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3b23d9-6e4d-4bee-3327-08deacd16328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9
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

Add IP-agnostic helpers to coordinate a MEC pipe reset across all KCQs on
the same (me, pipe): prepare (back up siblings, stop schedulers, stop KFD),
restart_schedulers, and recover_queues (re-init/remap KCQs and run
amdgpu_ring_reset_helper_end on each — guilty gets the timeout fence,
siblings get a synthetic context so collateral work is reemitted).

Suggested-by: Manu Rastogi <manu.rastogi@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 115 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  11 +++
 2 files changed, 126 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 515cc4a2aeb4..8cfb73fda4bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -69,6 +69,121 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 
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
index 77050f9884f2..38b317b91bbe 100644
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
-- 
2.49.0

