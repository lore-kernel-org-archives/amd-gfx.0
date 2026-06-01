Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4C3CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4C1112DC4;
	Mon,  1 Jun 2026 05:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0QNmuynt";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5854C112DC4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKAsaUwLjdsnidyztf5P5tq48mnyYGqCnOQGk9XxHI7Plj9e+MBJQXwLUH8Ty+U8IihSkVIEYr4blbTjcaGekYlNKPZCTETmfteMw4e5QGQfOpsgBgyeWdtsb2NynlcjcT5nzmyMu8w6dX/GkXBuCuSR6gUE7s/5sJSoVGODXHZL4BoLi5bQR0ahJTcGD79eBMCmL2Wcn0rAHnTpI+CGCdZn6/B4dPtZZxNtdO2hS4yMuRlupKjdqBAAy61oWueVvjPjMqgTUxOOVPw0WZG1K6p89YtqAxNPAqJ+4uz53qYLDpwS+yxqZGZ/V3LLQgDs8poE6ief/+I5H9T/R4u17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKWM632nQPJ8OainSrbGJ6FSWa1Q0cmkXIxNsY0BkbY=;
 b=g8LQH3KYJlmxWJwMss5mFDX33V5K3L66ENQvjiMMrkLX1wQ/bUFpaJO9dApdsXr+os/JCA0qadilkwOCJGAf8x6YarMsf2gs077ICGZDeTuXfc8kbrihGYdcstXmfttFsBB56MoMmj5SUE1X/0WZPdxKjSx2mbuK2PLyz+EvqEs3AdJPHvujGUavNr3ENWCYHtePq7O4ZvJgIlYJg7SC/qb33/qEnY2LEdkDmALGI3zVwJNPPLGfk/SJsxG+DeQv+7jhPN7dXt71C9VG4V77dCiR/AaFrcSLOCQ5VhQM2ylHwcoRkiVoJ8EObpCZFCsG4Bi5hw2JYVlKZgSG2jbvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKWM632nQPJ8OainSrbGJ6FSWa1Q0cmkXIxNsY0BkbY=;
 b=0QNmuynt4UjHLBnu7HKzXuOdidzwlyB4+n5Z7xK4CEq7Z0kcQsDQpoFG/e1iEdSgGR23daP/kLhc4oLdplGdnbykYDmKwblxSPX8BvD8npJ8wkzrQg/IiY/IidsZpm8dUIkGodRsn06dmSTT9Az7dx/iMBzfuB3ssPx/t2JcOKo=
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 05:52:32 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::65) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:52:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:31 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:52:19 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Manu Rastogi <manu.rastogi@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset and
 add HQD cleanup
Date: Mon, 1 Jun 2026 13:49:00 +0800
Message-ID: <20260601055034.3700921-14-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: d757f768-4cd1-4add-9742-08debfa1f8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: xVE4wxBTnC2xCo1xXmyzqf8t8koQafVHV42xXB9TWYijy6gpeDAhzyyUPT3kSLWIe9BqEDTBYXLEjK+hnfJ6J/0IyUlwbV8TIWM3RwvEP+JEuAZyzK4MozNNHspa0Qf4x4pPVUHSuYIqOc/U8hqJkN58+ha296y6DfPMeLirI+YGj89vNk2npuhXC67OftHD62UwfEdDl468cmHiaVzvA3UNqelDm7JP6HR9qEhdzanZbj60gb89MKNjPciqUJ5RN/7teRwrYGcy3kCiqys3oIV6P55N6+XmSSD45p2cKHOuEcmYZATAm7DMq8w54tszYDuDxKNjXqtaQ1seRiqo/WVjtlfd0fE/E/vA7BAkYTAO1HxyTSx8IFuMJTyxXOUPQXAkBbd/KnrWY4NC8caIHUxZKnvcYrhbCmq+/80Y2v2M8PwkoOAjXpee04TZFh3HeBGrheW21R0jEhfHfgBaH342zXS4HlwFkIEOORTH6j6Kao8MOU6cGxAz92MMDVUEyfGm2PuTWEsEg9P7gQvMqlZ6MY1ew3k0g9pCGLCoNb+rKWeKz4qA8uaXPU1IfLnJdPPldOu+UAm6jJKlaiRAKpCKlcwK46dXyboC9v77RozI7dkDDJf/vpo3DPipGadtSB7/dNmYhzv8ciEByu2g91ZNkhAf6x5nRg6+ryN038CmXE4NViRIxqhlyMuIyDF8pe+dwvnRjT7i3+TecrQvqD62eJf2LtrODJi70Yeo6kU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7CvWYfy7GIbX1YTO2Liy/Gthh4aHiSnwohLK7bePjxt71O2CkaeokyuKBrTMk0VwfxAQ7ATe3vgO9bKTJgEtTbV9UNNSYxJDFGvupzBEaGe30Eg2lcYeIMdOJ3vDsBxD37TfOT3Z5ByIfBEx4OzluRQ6pL2cMXFgUgVVlYli29grbbWMTipbvBh0He18RB1wQhAlkJVLxna9t5XjOaPqU5+4rFtE0nNKPTC/b9RsPmKW4PhZSXz0DbzZ7EIW2wNQL+xPi1MZVMdTpI8dink3+YLM9ZscQFlwHqpGTq5AAmiw2Ar/hqF/ViOuR51iMCl7tmlO6IeQOIYPL0SL1ZyPwJLUhISI8XBPZK15dWmskOLGQbwVWLG98Ms3RgsUH2qvmPnKz7Bxvhscp7bfBsGlbu5yOX4j/B6rOBo1HDlNU9QVAFH/IxCYbVYLIIc4QPtj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:52:31.8219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d757f768-4cd1-4add-9742-08debfa1f8d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
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

Refactor gfx_v12_0_reset_compute_pipe() to accept explicit me, pipe, and
queue parameters instead of deriving them from the ring structure. This
enables the function to be used in generic pipe reset flows.

Introduce gfx_v12_0_clear_hqds_on_mec_pipe() to properly clear
CP_HQD_ACTIVE and CP_HQD_DEQUEUE_REQUEST for all queues on a given MEC
pipe while the pipe reset is asserted, ensuring the HQDs are torn down
correctly before deasserting reset.

Switch the KCQ reset path to use the common MEC pipe reset helper
amdgpu_gfx_mec_pipe_reset_run(), which coordinates the reset sequence
including KFD suspend/resume to avoid conflicts with user mode queues.

v2: just update the sequence (Alex)
v3: directly clear ACTIVE and DEQUEUE_REQUEST (Shaoyun Liu)

Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 115 +++++++++++++++----------
 1 file changed, 69 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 4be650ce1fba..f7783129ecc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5309,10 +5309,30 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
+/*
+ * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
+ * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
+ * asserted; only then clear the pipe reset bit.
+ * Caller must hold adev->srbm_mutex.
+ */
+static void gfx_v12_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
+					     u32 pipe)
 {
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t reset_pipe = 0, clean_pipe = 0;
+	unsigned int q;
+	int j;
+
+	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+		soc24_grbm_select(adev, me, pipe, q, 0);
+		/* Start from a clean HQD dequeue state before forcing HQD inactive. */
+		WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
+	}
+}
+
+static int gfx_v12_0_reset_compute_pipe(struct amdgpu_device *adev,
+					   u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_val, clean_val;
 	int r = 0;
 
 	if (!gfx_v12_pipe_reset_support(adev))
@@ -5320,75 +5340,78 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 
 	gfx_v12_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
-	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	reset_pipe = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
-	clean_pipe = reset_pipe;
-
+	soc24_grbm_select(adev, me, pipe, queue, 0);
 	if (adev->gfx.rs64_enable) {
-		switch (ring->pipe) {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+		clean_val = reset_val;
+
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
+		gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc24_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
 		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
 				RS64_FW_UC_START_ADDR_LO;
 	} else {
-		switch (ring->pipe) {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+		clean_val = reset_val;
+
+		switch (pipe) {
 		case 0:
-			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE0_RESET, 1);
-			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE0_RESET, 0);
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+						  MEC_ME1_PIPE0_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+						  MEC_ME1_PIPE0_RESET, 0);
 			break;
 		case 1:
-			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE1_RESET, 1);
-			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
-							   MEC_ME1_PIPE1_RESET, 0);
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+						  MEC_ME1_PIPE1_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+						  MEC_ME1_PIPE1_RESET, 0);
 			break;
 		default:
-		break;
+			break;
 		}
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
-		/* Doesn't find the F32 MEC instruction pointer register, and suppose
-		 * the driver won't run into the F32 mode.
-		 */
+
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
+		gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc24_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
 	}
 
 	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	gfx_v12_0_unset_safe_mode(adev, 0);
 
-	dev_info(adev->dev, "The ring %s pipe resets: %s\n", ring->name,
-			r == 0 ? "successfully" : "failed");
-	/* Need the ring test to verify the pipe reset result.*/
+	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
+		me, pipe, queue, r == 0 ? "successfully" : "failed");
 	return 0;
 }
 
@@ -5405,7 +5428,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
-		r = gfx_v12_0_reset_compute_pipe(ring);
+		r = gfx_v12_0_reset_compute_pipe(adev, ring->me, ring->pipe, ring->queue);
 		if (r)
 			return r;
 	}
-- 
2.49.0

