Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA513CD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 07:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7761110F37E;
	Fri,  8 May 2026 07:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="piSec2GB";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED85E10F37E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 07:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovy0zOzYSHVc0F7xAqky2ttUyPNIqTP1zRdJpc+LR0iWVzSE6tUZkOk+Da0lT0Qjh7eipqPtnYrDX4nAxLBfp0QT8NCd41HwbwC9fdTyP8c8uHhhTjwtkxcHCuOPr0r2rE+BPmALHd1HZKSz2wNvPWk/RCJ78eSwDgz46t2T9NK6xNqSuw3URTpaBP5jSg0CIJEIH/ncUsqxZaQNF9rE4Q+3un+wjEsNZgIg7PnOK4VkOAohM0qY5VVn9ZnaptCY31xTio+0FYKXMYzlWf9pcbeCmgHXjS3qPHESAxPuD0u/xKgzNk4jwwYj2cInMpXigQyY0gs6qWUbEOwG5tGMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My3zSF9Y7O8ALCdwjMEnkS12azlUf6KsTU8vWwPCLs8=;
 b=Ksr1kjYDlmINYLHW82HeX6gMDb4N8zjiRhxezX50LOwXQz7SaLvSw6CQHyh9l2qeb34ZxSbMn+1FgB2c8ugh+cRnrF4HIdBZk7/lFpFFB9NZSjCnqX2YVN1S9WiHd4K4MYMgVm5x67HrwDUuJo4EE8pxWFkyOKIM6vCEpVcV6oEEoVN9hxdEOyVsgFMK+Ls7TskmlajM3dhjuuHV0q24jk6EFoD4+S7MMCeCEmnzRZ4DayX8bTSMkHUF5FmPNcrHLFWMMMb5U1hbBcKGnp9MCtgrNK55bAShWaH7j9kRFKgaCX2o/omK1WZ6FUNacIZTO444goLPwthVrHBVMlFUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My3zSF9Y7O8ALCdwjMEnkS12azlUf6KsTU8vWwPCLs8=;
 b=piSec2GBl/mxHuQmwCAt78Rct4STdslD0KcozV0fqTjQJ1GIGXt7YpPW0jQLtGgIoispQaKEA4D+1V0wuOYiF7SwOmAXq+IDznxjUvUCxCiOALe2xU3BOemIFJgxvUfUDp/YCPr8GJ0D3NgPyqMYpcKrK0CA7tSo82rxEtDKE1c=
Received: from BN9PR03CA0396.namprd03.prod.outlook.com (2603:10b6:408:111::11)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 07:14:18 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::f4) by BN9PR03CA0396.outlook.office365.com
 (2603:10b6:408:111::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Fri,
 8 May 2026 07:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Fri, 8 May 2026 07:14:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:14:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 00:14:15 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 02:14:04 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Manu Rastogi <manu.rastogi@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/gfx_v11_0: fix GFX11 MEC pipe reset ordering
Date: Fri, 8 May 2026 15:13:34 +0800
Message-ID: <20260508071351.442816-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260508071351.442816-1-Jesse.Zhang@amd.com>
References: <20260508071351.442816-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3cbcd5-a0bd-4199-ca07-08deacd16ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 36AT8BKGUQY6n9LVNuw3rom0b8BgDkNWARNxzI/c3Qa0Sm6Qw2a39GbzLCtEqQ55EApjZ+WnM37w3oldasAT8EYTbmTA/O+8NdwrxVAnpSZcrNBxA3dlJ4DR0yWwnUv6thCqtPJAqC+Ea6KEDywVaTjlbKYVTv5S6r4Dmy7+08MRLtQidvYlKL9lxG4f/5Vq4Nj6ilgPbO/YD7Cki9xUpbSzoP8IVILJcyl/0QAfhatiqgiwH0H/g+3D8r0xBav/vQTl66Iha+2aGkgYgghu8xmwJKBMvK86GsIVAFtS1JYlDJdehmQYP+DDzlvnUxzyNgfAUUxXMsRiPj5sEKHT2huBlZT4LFCMGRk837lSC+qjNypY36UH+aJMPlrriQvoJXOhwVyII3VbwvuO0crcBwD2mYt2PU5OwmqrG8Txq/cjAcYIASqdgbG8r6d16gC0trJqTtBzzY3dqE+5QLp6pO8vq6SwpG4U2j4PwdzhScWQqbOP9kwH7Nt1q/GEDFRCpJ8CMyolJpZlUPhDo/Gurch1t4kdzzenXDXB8tOahYfsKcm4c76wSmAF5M7Y2TahOiB1R1g2T/EqPTCZEu3hliUY8piCRIk8me6bYuEDXwcqYSxXHtsZd5+bJ4JHqvTVWbHj1VzwWP42rDk0gfBTk5nec0YSWi7YrLRBqBcYMoz9H9IYMbBGGgBmUp92hIsJaNnkT3mhtnZaV0v0rWifEeHibEILgnbvA3QtcGQygJQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6UKkH+xvjA/+nxGyR9smSpLdcGFqrV8ffHDZnk+HqsQuKgRGMG4JJPERQHgn9ZvgowpT6no7OEJp+f0vNtFL/WFVT2z0lDEF79GK/KaZ6RFww3ut2vjsH8VskeItzT5Trw5rQcHMDMoG3yPS0I4SUzXxQAjxlDTHLmAGhERNY1WYuLJ4Ptw9lpPPIbQSdEQMnSW37CRwDKN54M6/kburX1+kCqk2gVOpJuJq5RRX8WR50v+Ow17opcWlj+ieg6XHCEh1BjKXG0US1NMtWIzTP6IBHzYHa52ZpVszhzqu9dEW35fZ8rRDpXwKdRXUQpWPcpW5z1r4ZqgLnMn5Txiv1jxASpyf/uVNoHplFphXc5pK5wj3dJUEpN5Lo2+nQY6e2ub378q1420iKgY9BgKGkOXItjZVblpjH5SBAYCq3XDEY5oZZbzh7CYHKw91akBr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:14:17.4015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3cbcd5-a0bd-4199-ca07-08deacd16ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
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
down CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST via
gfx_v11_0_clear_hqds_on_mec_pipe(), then deassert reset. Avoids releasing
pipe reset while HQDs may still be active.

Legacy (non-RS64) path: read CP_MEC_CNTL for the reset mask instead of
reusing CP_MEC_RS64_CNTL state.

Wire reset_kcq into the new amdgpu_gfx_mec_pipe_reset_{prepare,
recover_queues} helpers so sibling KCQs on the same pipe are stopped,
restarted, and have their fences handled correctly.

Suggested-by: Manu Rastogi <manu.rastogi@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 151 +++++++++++++++----------
 1 file changed, 93 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fabdbbd0abb7..0e79336807de 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6874,11 +6874,34 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
+/* Caller must hold adev->srbm_mutex; pipe reset must be asserted. */
+static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
+					     u32 pipe)
+{
+	unsigned int q;
+	int j;
+
+	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+		soc21_grbm_select(adev, me, pipe, q, 0);
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
@@ -6888,69 +6911,73 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
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
@@ -6959,36 +6986,38 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
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
 
@@ -6996,7 +7025,7 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->srbm_mutex);
 	gfx_v11_0_unset_safe_mode(adev, 0);
 
-	dev_info(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
+	dev_dbg(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
 			r == 0 ? "successfully" : "failed");
 	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
 	 * reset status relies on the compute ring test result.
@@ -7016,9 +7045,15 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
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

