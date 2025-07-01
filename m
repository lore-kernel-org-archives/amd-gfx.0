Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EDFC83F0A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A8110E63A;
	Tue,  1 Jul 2025 18:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xsrPWvyk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF9210E635
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZRZOfar3oc/aa1O3g0TaaJTkR/dKD1UgE/x1HxYNC4fy+u7BvnIaCkIbm9AJDR+PfLrzcKvXD9pddXF8mARnNTw2jO4fuFRL1Mipu3NiQfSUnPYXmhxn0RvQKoTypiW7H/ELzcgBrl8UUdGZWTZqw6BTd+XHmjlqz2d0BrA0ULYjax9BQxFhadUxK158nAAoVFR9ZWd9ujqYE5S5csKmBZBwzNtpmb3QiA/lF1FLdc4PBOoOCue1DIZi32TQg6uQFKQb1kMPGbAqbsjE8BA9yfRgoaIknnygNJnPuHvFVoDWerRZbqb4AEWXFBXpE0yIRmFRTHLYz1HJDSGHLDT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR7EbpJz/UZJOLP1Lfz/FJo0bHrvLbcJpPFds4JMbg8=;
 b=Fr4KuPPT0aD0fUC//VFgeC0H55PHG7jpoPSK/AFmiNKM16L39knQdmwQjv96jWL3PKBxAMHqtYqdDn5D9P68HCj7cLA3PWChEzolJZcJMFyB1Y6Ym2u2LJePzTGC8vX2+RTPiqx3JUAPYTCzGD0Uy4Nj2B79U2mufTyO7kqZydFA218LPyliyqLGCJZA9vAOJqZBX3rl+hfzj9UHa4zFcwEgTb4o+z0pQSj14z7Zt/4ZtqUcUu7roOtRL1cSfNWvyoNjSE44IgwhyN6zQJ8eLYQaDiC2nykVO53V85jjY1UDcZZ/X7ZbFcU/7hgMc76DTXcg+fhxTJiFGfVMILyEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR7EbpJz/UZJOLP1Lfz/FJo0bHrvLbcJpPFds4JMbg8=;
 b=xsrPWvykGAH0viXaa9cXl1ppJAQDw/nOzdccL8NYiupDzE91y4YLGEXSjt7xZx7U5WUimLlgp9zIPztgtrrLQv7IVDj6tHzMpiDJXQeLsivkAxwnj7OuT/vmKn6qcs9HSRDx9aSVs9gqqXj5KGEZWvwTyg/Bi3J1JzxTT/TUv5w=
Received: from SJ0PR03CA0137.namprd03.prod.outlook.com (2603:10b6:a03:33c::22)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 1 Jul
 2025 18:45:11 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::72) by SJ0PR03CA0137.outlook.office365.com
 (2603:10b6:a03:33c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 18:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/28] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:31 -0400
Message-ID: <20250701184451.11868-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: cdef572c-dff9-48fa-b9ca-08ddb8cf68d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aP+r2Yq0/4U6XAn2BLZNSiQ+a1AdMfjDrD8hwjHKrqCosQRnya/KiF9JQVIy?=
 =?us-ascii?Q?vJOojE2nF7I6/AQZY20K7XtSTaxvFzZa95WsbLdyPpw57/PRILyRKMGTTz+8?=
 =?us-ascii?Q?XaaD6tseRCLND2YzhPV+V7AdY1z806+IP1VhEfocuoLmZzPMp9Yvhky4UxIv?=
 =?us-ascii?Q?UszzyNx3+UefMikhPnsKRJkT7or+lmISl/A0PXDjxdPaKq2llar7WH7JACWR?=
 =?us-ascii?Q?jkVNU0x0l/jYGnlMwfGjWX7PNt1/Wnfwf9HjEHUaQ+tBtdu4eewSpt5AADqf?=
 =?us-ascii?Q?qvj6hGqx38jWedI3u673y1ucZI8p+KousWLlJu+0C+gCoxCi3rzjmjTPOFN7?=
 =?us-ascii?Q?PKOQg7msJh0Y5zkpdCt4TNpjPRsb5Se+n+3ORG4d8j1GqPIJ/hul4236b/wV?=
 =?us-ascii?Q?08528SML5hP2uM5ZQpCsCMyUhUv854cj+ubbD2BmDbbFDvSP43mM5R3uYqXn?=
 =?us-ascii?Q?i3JPRCEHii+Y9354O4JuJnnmSOFXFFtkfdGGFJiLaQ5sxrnw5J8k/pwDz/NY?=
 =?us-ascii?Q?joOLxsJl2gmSYCZAeMRl6dVcbimNbv0D1/R2GcwnHOp9AsDrgBdHo/MqD3el?=
 =?us-ascii?Q?ruaOOlcuNakZDdgDc6SE8bjhFg11AG2NRsinKUNHtvZHzr7owJ6pA+EMskv2?=
 =?us-ascii?Q?Y+t5wGNnBg38nxgKDxrPWZ8qXhv0vFtugViR5SlcK9lIa3uNVzR7tE/iS5AM?=
 =?us-ascii?Q?MJvZ7jBbcNOL08dMGOuHC+jPiasEqAs8QkwKTHnCkke2INqgQ18d/1ZiyRDI?=
 =?us-ascii?Q?RJmt1ctwiR/guMRtHgvRWMLQfzSK1ijgnkH/sMFLK8J/rh0KnQHW4Qr6Lwen?=
 =?us-ascii?Q?gCfcrNpHAVjfFZ5fcWc1tEOVgmZIAqaDjXJrkd9Fs8F8DkLEhCOU6XTeKjzL?=
 =?us-ascii?Q?timTUSee9ByMV2pSIqf2YRZ5VGSVugLBU/zcS3jjcSJT+saHer7bokGEfVIY?=
 =?us-ascii?Q?qfTMzmSgpdZvRuVla5GnxOa2zKZOnC3lvPSQ5NVnc7qXJDpQD0W29o3pwWhj?=
 =?us-ascii?Q?NV3OJL12Ow9GbL0mNAsen1mij0oXzQ24OkxODWKn8raz7aQoSCGweVcR2Lfy?=
 =?us-ascii?Q?x0JEQ6bEagv4x8Ly81U3kDpAmke5nCtk6Mc1IKRq1xGsAj0BeGZBXYOM4hiS?=
 =?us-ascii?Q?T9EWaHvPo9gIeC+Cn3Rh+jp+rUxaKJuD7LnvbG4Rud5lKz7wW2G0OXRv+R33?=
 =?us-ascii?Q?Q8QtZc/H2Tia/ZVbmPRVUBpqBTGLNt8rm3U0LVNsvCfPXuVFw1B+SWNkyagM?=
 =?us-ascii?Q?HGM3dD9K0L/kKS0Qi6kZc/eX0a3EiFx32z8XeuVos0eSL1xJNQ/NdkThbAYX?=
 =?us-ascii?Q?9zxTrlFg4cKcAWapny9Llslpzhf7LcxjtDgBeF/WztIFcDI9+zW0Akz0fpKD?=
 =?us-ascii?Q?9REz4VKg+fy6q1PZ+/o7pfvN5rUE1GBQwKjGfDjZmnZx1SjC4x7PtCcteFt6?=
 =?us-ascii?Q?5jaecHsrT/K4wf3S0ZkF3z/IabAxi/RA6LmvfhJexWQqh+ieaJ1iKUZwDvyu?=
 =?us-ascii?Q?gPCDoBjWwXWNrfL2OqTyV8pGQztdx/58C6aL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:11.1850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdef572c-dff9-48fa-b9ca-08ddb8cf68d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e4fc42470cf3e..a3be2b46177c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4690,21 +4690,6 @@ static void gfx_v12_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v12_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v12_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -5317,7 +5302,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
@@ -5339,12 +5324,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5440,7 +5420,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
@@ -5461,12 +5441,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
@@ -5544,7 +5519,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
@@ -5583,7 +5557,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.50.0

