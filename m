Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCDDCD4855
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 08:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C5110E9C9;
	Tue, 12 May 2026 08:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4CBZPcTz";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B8F10E9C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 08:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7gNriQ95x7+NgDr8dsd8mheu2f92N7cGnCzz/LpgiOiANekvFW3Fdd6dSWZoSvieCk0GIrY72XypnA/4yZuyPiRbTA8gDqja0AZwTKWKbDCtBMckxaHcZCWEiOJKWSH7XuRemLuJaltpPakTicbJbjYg8Sbc1+QC1EtBhbuA9h3sF9imPrr7R0Ofb1vJ6kbRMzLiSUG9eWJtpgSyN36x7TtBote+aL+AI8OdOW7jyvEgbw8Vjg4Gyo32b8ja7FKQB1cyeN6Qo0Sbr7LzoHbWwlmdQKroIKZ7kKuhOuBBYHNYG+X3K/eAWe+MhR/Z8WQA9h9Gxx7/3ljcxgf4Hh8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQE8LmfDT2E8NHYEfpweYKIA26lUoaH+cDvlS/g86EM=;
 b=sP9sJXY5ZJ7YiMQqHfKrfUVFVWDnJo08m8iGPijclMt7vc5PnconL+t1a+7DPxlJ0IH5R6+7FbDx6o8Oljr52VTmP+ETD8+fr5wKhHSFZwyMcxj+ApK/oSbtIyMs2gvCzTggxlWmiH9mFVDp/qf5JZG2gJwBVsesBH1KpZ39YjTa/y5Z9OtJpHaweNP8rNDPAN/+/RlkNX6ImXDdD/NiXAlSlHywcwqlTATMa2Q13jpWoEmQmGkbE4m0Xqr6g8gRxX5zyT4+jSvkM90Y6DDXO+OwGn2RlGZQTD5KsdJCQkNUW0yqHZ3U06B6+8pQ2V6k8UfuorWeGvbu0BZDGTf0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQE8LmfDT2E8NHYEfpweYKIA26lUoaH+cDvlS/g86EM=;
 b=4CBZPcTzhCq7eeBQjN+dHF1D4K4A6Jv9RCmgSTTwuzf4sTK8/+QWJq06GMm9fCWwgbXSxQ10M733o4fNR43VcGpHubKLHcvpysIAFihk8Zl5xTjl+F8P6PhvdNUZaP5+/N1jl8m/2cTrNtDI/40aGQMgdKTEDr+5mk+IT4rUcvs=
Received: from BYAPR02CA0071.namprd02.prod.outlook.com (2603:10b6:a03:54::48)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 08:49:12 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:54:cafe::58) by BYAPR02CA0071.outlook.office365.com
 (2603:10b6:a03:54::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 08:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Tue, 12 May 2026 08:49:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 03:49:11 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 03:48:59 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Manu Rastogi <manu.rastogi@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 4/5] drm/amdgpu/gfx_v12_0: fix MEC pipe reset ordering
Date: Tue, 12 May 2026 16:46:17 +0800
Message-ID: <20260512084827.1630497-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260512084827.1630497-1-Jesse.Zhang@amd.com>
References: <20260512084827.1630497-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: f114cc5f-903e-40a2-ea0d-08deb0035729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: qZj7N66nJAJX3q2M6gqYms3f7oQsGFgf5B3WQvKQtyUZXavaZnB0VuEFb2D+MrrvWDgBg7pFbyCGkwTM8PZFoWH5zhwXwkLR+/dpOe7OL+S28PeDEx0WGdh7fVJ69DD8E/ay9Tz0cVFJzbcp8FH5V+oyr8w9kJx/NCm4HB82rCsVlYUhHzQuVTcJ7kna2wWDqimyMI5PStejFSpmrena4qilo2nwkn+7OjUJzcbOqrvWCoG/XzFiigpt9GKuWD2F6btI0KhatOip1OLo2qaxxontXkp4WJU73K8Vm62MnmJTsFH/vgXvm0CB4l2rai3t//8k8O1vvtJ1+mPUd+gGBY6Ubp1Ssqa92Ir4SWIqzeFxshOybxBsRgVeTC/bLm8I/P3vnGrxXgWtT/2ac1tBE1MUaEtUVRTluctJ7JsdoO0fKRP92k48Yf1At67Rdfys6g/wxtKIaZg7B4aeSdsYyAm+6QHXAtIFduLUU9VI893cdVCsd/VGGkKfyZko9nM7FFvgCy5FkHIkO0u66KxdRRyCXniK8ghyAZF/ZS7/FR+IgHohKTy8fKEtfW5TgcbDR26gvQVt2hr0mk8zEoxCkIpgrbiCZVfyFCyzmp5tmh46np0/7mDuRWW9nRRbWpy8c/GFJgE3kAn9OwUJj+zLCUQ6RP6i3EIBc1HLgdXJU/c6C1nKlqL3XN5MsICMN/BCUeo416Ud0JT+VQRyHbcxyM7B4wiW50yvFvosyXQJahM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(11063799003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UEqvhgJ+HLRjk/uO4GU2yplRzYt7woY5h0DbzIEAstCvcBuhaAldnM1m+wMcnzPUEI5c7hE4zLSg/SergL+g4Zl8bzy1i3OHtGOw5Wfc27pB9kK9Mr1we5CSuuh8v2QDceZJTqgiOK6aD4q4jPcSRHcO7cdiihcrpJcLqsxwQTH/9VpcESfwSgDE5ynJMhQ+KFggrdFRfFmGF4w4SQmFD/oxHtV0CfRHTbE0jbNBxxTZurYDZb+AAIO7+jl93R/OBraTXsxY3JJnwwkQEh6/J0iL4fkOSMaQ4ifSGuHJk8ke3LzoBzsKdENhYZ6hMLrv5bngUxV833L43W11EC2YheURMHINxZw46hJg1B1KJ0tnScFrTJlce1A4k7wa47RRYOOCkOBWIehAjVjT3KMXGemlLplG/0z473hj3smp6KQzVdGitFWuGPK+YqHWb2p+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:49:12.5466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f114cc5f-903e-40a2-ea0d-08deb0035729
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

Hold MEC pipe reset asserted, walk every queue on that (me, pipe) and
tear down CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST via
gfx_v12_0_clear_hqds_on_mec_pipe(), then deassert.

Suggested-by: Manu Rastogi <manu.rastogi@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 117 ++++++++++++++++---------
 1 file changed, 76 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f47928dcd848..265ffca70ca2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5309,10 +5309,38 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
+/*
+ * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
+ * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
+ * asserted; only then clear the pipe reset bit.
+ * Caller must hold adev->srbm_mutex.
+ */
+static void gfx_v12_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
+					     u32 pipe)
+{
+	unsigned int q;
+	int j;
+
+	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+		soc24_grbm_select(adev, me, pipe, q, 0);
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
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
+	}
+}
+
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	uint32_t reset_pipe = 0, clean_pipe = 0;
+	uint32_t reset_val, clean_val;
 	int r = 0;
 
 	if (!gfx_v12_pipe_reset_support(adev))
@@ -5321,74 +5349,77 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	gfx_v12_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	reset_pipe = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
-	clean_pipe = reset_pipe;
-
 	if (adev->gfx.rs64_enable) {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+		clean_val = reset_val;
+
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
+		gfx_v12_0_clear_hqds_on_mec_pipe(adev, ring->me, ring->pipe);
+		soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
 		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
 				RS64_FW_UC_START_ADDR_LO;
 	} else {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+		clean_val = reset_val;
+
 		switch (ring->pipe) {
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
+		gfx_v12_0_clear_hqds_on_mec_pipe(adev, ring->me, ring->pipe);
+		soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
 	}
 
 	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	gfx_v12_0_unset_safe_mode(adev, 0);
 
-	dev_info(adev->dev, "The ring %s pipe resets: %s\n", ring->name,
-			r == 0 ? "successfully" : "failed");
-	/* Need the ring test to verify the pipe reset result.*/
+	dev_dbg(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
+		r == 0 ? "successfully" : "failed");
 	return 0;
 }
 
@@ -5404,9 +5435,13 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
+		amdgpu_gfx_mec_pre_pipe_reset(adev, ring);
 		r = gfx_v12_0_reset_compute_pipe(ring);
-		if (r)
+		if (r) {
+			amdgpu_gfx_mec_post_pipe_reset(adev, ring);
 			return r;
+		}
+		amdgpu_gfx_mec_post_pipe_reset(adev, ring);
 	}
 
 	r = gfx_v12_0_kcq_init_queue(ring, true);
-- 
2.49.0

