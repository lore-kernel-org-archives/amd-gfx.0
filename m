Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DFAED7B8F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 09:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DBD310E5B4;
	Tue, 14 Apr 2026 09:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2bBD9eJp";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFBE010E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 09:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMYHGO0ydjlSES58wkMX8TDqtErohtJy3tAI6C95fEOqwWURO+SKo7E1fXwidTRnbmhxvu5DU8KMhSHdALZdTmvbgKzVFPZKljuQYisrWjiUqePckO4hraWgTTBwBYG+CISyYq50u7HJ4SGcnRAIs6dWjKWhjjIW4U7Be6VPeFPcNA6IxQ2YJ+K7NoY2Ovc6OQpmpJvLU3M7ZncKfVrOfVDM8FoBel3P9faBo7fDIah+FY7+dT1sWolPGkUAPq8HYzirjgIQMOGw46nUdc91lYEDdNE7hw9XtQKF1aNWfWzgkfr5XJWQf9/+AXeD1EDkeCpvyEh4plmxG40m5bzBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9Fd7ijmm5C4sEMayHvTo3OoAg+eSIBYvAgwjdBmYkA=;
 b=d0AYiG988uRYR3p5MZDpwEAezTBeHXp+KU6D8sUvSqvBgCdy2bPpzh4QN3pKZUrmRmn2lnJmqoWUA3DZ5Z17jDDoQFYQGB8F5uFZ92jDwkjrgUw1x3BNeWE/ZzPdrYaQhc6nXjLZbXwa6GXRNCgn6h5JeQavpvEahLc76k1ERf9bfm7DM/WKV/5aSgbjBnIK9Dpzwi1k8TYhey5DBrB6QF3Fc1JtgyHTmjVPYDTqHjxSbdYLIAsAW1NA4iEeZqKRgBoZZTY6C6pAofKS/PVnxMPZoBjh1zSkm0OtUatfSj6x/s1g3OJ9sHQkvOc7UnWSk+LRLXnVwEAhuZxT/i6Srw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Fd7ijmm5C4sEMayHvTo3OoAg+eSIBYvAgwjdBmYkA=;
 b=2bBD9eJpPK3Gxnc3vSKF4LeKuB9tRReDhvpueTOEnEM4kzNzTm/72xWHcbhL9Y4zdcVWtj2O5nVEI7tX+e8qMKSp54goZrhDHSGQ9aiOU42zzQm2ALDGGlfRqJFvynEyi6VQmWnvLdeMWeQBBhlLwuXC7reh3nDsEqoxH91PvfI=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:59:52 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::75) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 08:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 08:59:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 03:59:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 03:59:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 03:59:39 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Manu Rastogi <manu.rastogi@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 2/8] drm/amdgpu/gfx11: Refactor compute pipe reset and add
 HQD cleanup
Date: Tue, 14 Apr 2026 16:58:49 +0800
Message-ID: <20260414085926.3171086-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
References: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c40352-ffaa-41b3-8005-08de9a0430d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0zX19CqLCSSrY34lYKDobZwDPE+mfZ1r40J0yiVYn6LwjGzrF0UxB/nmjtj6j3WSTzxSpyWNnkcdgm8Jddi6lgfITmcdB/hnrFaL+faBjRN+RKtwwUlQacwfQzHQgu2beBya/n2eEq5JJYHor56uB7+A96yDluKjmydZZnOuuFVr5mshayivMANoD9uGNpdkjgaNpsFX5+AR7riO5e1tUa62uQaKwo0qFoZaOYPVtR+j28R5shBkHx5+bhpW2bhJwexk4hj8t5vtDyv7ETW/73hJpny8EUNPXvuipSD8VzpC6+HYOnSGdKc/uxk51cBvjnr/82uRBf+8qJWM+GcPoXB7AyIwsY6Jwp1b2quvzOGYGnvW/VgQIFd3SQa8rJDsSlU1srG98e0aVJ7N0V0MK0yCkHxqnR6PCG0EbbD2hqxjsRT1k/IOLxPh4ZuxCO0XHSftvDeHJbgbmGYA85LON1qpkVGOiv9X5eD3VW/EfMQeizicTVGdkmzW6I+SWWBhDZqLhyzLaY2LoUWR2Ior4KGln+2s1zNeyhGm/xMdGbSSkfsK6VFs3HL2Eogd1RkwJXetuuBYVJQaxCmsv+ZowCscqUTkQEL/Ajl2IS0DBvnGlp0WSm4SLqpK5ut8DzeG6n+jPjnVveHa5ouZTMv2allgEkaFE95LvtR+DVbBAlBzvZw3rG5YVM/GF1tohMPjYDpr+LF4+zZfCLBB+GSMPcUsnUqo5JZgfZX7vVb+5RPMvFd07d7978TZ1r1tu0T1bseLH9QqUe2EEcDKHQLmew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2VfxBMEHgrRS9WcOxWFi4O2dubb0czTJRBXTM/fFNSavy/pcmVfR/nrUCiIeUMxa6GFuFEHz/NJZWeV4meVOrSuv6Hvuc37iZdrt/25dNcf/t7K4t1CnsC7Twr66HByFjd4IZ8bku28QXJOkhUFXyIpswF9hJQMkumqL+GSJCdTZocvQOmZK2/od1sFD3irgAP1DLwXjf3sCqbmSlgYZKNTxfzwbazaRiavFVzwDZ88Sy+Z6IvG+ThcH+eET1N+lQFCPkAzIY+Bv8HgtpqstzrsoX8ohRxGOBPSUJ/X0LIrFoGZijxF6oihuyzhx9T/CgqmLEqMVNrb4DLYoRK3x4VuhyoNo9MdoyTPulWZU6wv8JmRX9JVSiuWkTjom38nBQ/LKE5mRZAR88kALO6bd4rrMACI6xvAsJdBHkXWi0mgtUo5xQc46Yu2rRXUBQBbB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:59:52.1491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c40352-ffaa-41b3-8005-08de9a0430d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
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

Refactor gfx_v11_0_reset_compute_pipe() to accept explicit me, pipe, and
queue parameters instead of deriving them from the ring structure. This
enables the function to be used in generic pipe reset flows.

Introduce gfx_v11_0_clear_hqds_on_mec_pipe() to properly clear
CP_HQD_ACTIVE and CP_HQD_DEQUEUE_REQUEST for all queues on a given MEC
pipe while the pipe reset is asserted, ensuring the HQDs are torn down
correctly before deasserting reset.

Switch the KCQ reset path to use the common MEC pipe reset helper
amdgpu_gfx_mec_pipe_reset_run(), which coordinates the reset sequence
including KFD suspend/resume to avoid conflicts with user mode queues.

Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 177 +++++++++++++++----------
 1 file changed, 109 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ae39b9e1f7d6..e29e8e620699 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6906,11 +6906,39 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
+/*
+ * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
+ * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
+ * asserted; only then clear the pipe reset bit.
+ * Caller must hold adev->srbm_mutex.
+ */
+static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
+					     u32 pipe)
 {
+	unsigned int q;
+	int j;
 
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t reset_pipe = 0, clean_pipe = 0;
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
+static int gfx_v11_0_reset_compute_pipe(struct amdgpu_device *adev,
+					   u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_val, clean_val;
 	int r;
 
 	if (!gfx_v11_pipe_reset_support(adev))
@@ -6918,109 +6946,115 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 
 	gfx_v11_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	reset_pipe = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
-	clean_pipe = reset_pipe;
+	soc21_grbm_select(adev, me, pipe, queue, 0);
 
 	if (adev->gfx.rs64_enable) {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+		clean_val = reset_val;
 
-		switch (ring->pipe) {
+		switch (pipe) {
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
+		gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc21_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
 		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
 					RS64_FW_UC_START_ADDR_LO;
 	} else {
-		if (ring->me == 1) {
-			switch (ring->pipe) {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+		clean_val = reset_val;
+
+		if (me == 1) {
+			switch (pipe) {
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
 			}
 			/* mec1 fw pc: CP_MEC1_INSTR_PNTR */
 		} else {
-			switch (ring->pipe) {
+			switch (pipe) {
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
+		gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc21_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
 		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
 	}
 
@@ -7028,8 +7062,8 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->srbm_mutex);
 	gfx_v11_0_unset_safe_mode(adev, 0);
 
-	dev_info(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
-			r == 0 ? "successfully" : "failed");
+	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
+		me, pipe, queue, r == 0 ? "successfully" : "failed");
 	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
 	 * reset status relies on the compute ring test result.
 	 */
@@ -7048,9 +7082,16 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
-		r = gfx_v11_0_reset_compute_pipe(ring);
-		if (r)
-			return r;
+
+		amdgpu_amdkfd_suspend(adev, true);
+		r = amdgpu_gfx_mec_pipe_reset_run(adev,
+						     ring->xcc_id, ring->me, ring->pipe,
+						     ring->queue, timedout_fence,
+						     gfx_v11_0_reset_compute_pipe,
+						     NULL,
+						     gfx_v11_0_kcq_init_queue);
+		amdgpu_amdkfd_resume(adev, true);
+		return r;
 	}
 
 	r = gfx_v11_0_kcq_init_queue(ring, true);
-- 
2.49.0

