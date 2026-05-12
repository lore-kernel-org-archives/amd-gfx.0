Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA4DCD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 08:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AABD10E9C1;
	Tue, 12 May 2026 08:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x8kby1Rz";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E15D10E9C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 08:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXNfH+U+z/WHgSVZuKrxiEg5IivIEB+/IgyJcmAoZ+ftRYnNVbyGETLpM1sfk0ZbN9ydTohg+SVFg/bN5BWbncV0wCF2nVrRhMUbyAQBEhZ4RJ/7TsSwlA61GCZh++WQiWjg9P3ait/HnzRUN0Zb5TllE/py8yqKRfME56aIEcXo4oecKVyp2pftLgoGrVAawKj/wkIO+OQRVQ/Hi9m2gU+AmwXFTAcv50aqDXgBf107pDSD5JBfFkU4WuU+ZSgK25D5B++W68H8TqR+OKk4Khc2UfXwiJ3tt8NUifiWTxRYtK95r8TlViWG/HZm+bEAZil7ohl05FKgwG4hB7uawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m0q6X4mD15llD3JzdjKH4xAxnn08Uv3he4lpvDvcco=;
 b=s74Y2VrST9svwRoLNrqxyUfy3+LShFjyYFk7FSJLOD60XOpy6yPWMmnF67S2EdJuzIIsvAuwCPyla49/xNN8EAvG+7uqaTxIDfwL2jAx3Fv4MNS8kHkYGncnyLtFcJj/gw/gRgpURMVi5mb3lcGUGgoTXMwB9pxtEuVYPkVZaFt2tgbxI+0wHCji5XIm/mDu2VMDqdoy5tjT/zOopnek1R3YUh7/yR6rrAsxNabKwWHPG1Br/EJHvFsoFv2YSS36oeDaq/2KymppK8jAH1qsCDZgaBA8yw8UU27Sq50vmJ59EjXnppelsTqH4Vv7Iflu8vqMPLCIa3gib6CZ7b62hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m0q6X4mD15llD3JzdjKH4xAxnn08Uv3he4lpvDvcco=;
 b=x8kby1RznM/ErRGhORBeSOyihzfi4v1V2IIJuoZt3YeQZs1NFRmJvWRgi6ME0xoUvLI6kGv+DA/nMpfke2mw37ykT/BMDgcseodWIc97ExuALmNtCA+PMqs/stdWsdsXnmhXRlHYB7XE1hk6mf9skkAZQeEJGvrFt//Ke11ErbY=
Received: from SN7PR04CA0177.namprd04.prod.outlook.com (2603:10b6:806:125::32)
 by LVUPR12MB999185.namprd12.prod.outlook.com (2603:10b6:408:3a3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 08:48:53 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::51) by SN7PR04CA0177.outlook.office365.com
 (2603:10b6:806:125::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 08:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 08:48:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 03:48:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 03:48:52 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 03:48:40 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Manu Rastogi <manu.rastogi@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 2/5] drm/amdgpu/gfx_v11_0: fix GFX11 MEC pipe reset ordering
Date: Tue, 12 May 2026 16:46:15 +0800
Message-ID: <20260512084827.1630497-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260512084827.1630497-1-Jesse.Zhang@amd.com>
References: <20260512084827.1630497-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|LVUPR12MB999185:EE_
X-MS-Office365-Filtering-Correlation-Id: c649370f-6bdf-46f4-f618-08deb0034b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|11063799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2lQiKvUFYdm5ooDcwpBltFDXaL3PJnntrUwnJtkbD5lpofG1nNVRnbBD7oCoxdcm2T9mSm0jsO6uwe9PcAduYo3gBh4+Ps8b5LHklUCgRZxi1Q/71P+Sv/4fPq72RYhjlhYY2v559Y6tsuhd6zdUT7TUzLy7hoAdXktd+qP+560xw2ovKI/SQ0Xptv/J5B8CGI6Aj/ycuGVmpwPXV9eddwfH/s8N0rvPszt5Cd6i+b0JXwDf5seSVO6pDTU5slzr00U2qYHDVu/eUezanMXR8AABNqlhPpiano536osUY2hNPyVCmhL4kNpPJdnet5CpoOMBYo8IGPOwJrPqo+WCEYu+xIJgi63VFk3mwx65CcriN1T99oqtZsLLm+HqCQ5pY+mueKVXdNZBs+qLtlGntgte37o6nPV0OGinhXQRUedMC1GfMLYTJe4wXdO8I+qHk2/G9BvjWp9Fcq3Qq6rfzwjRQgoS8xk1qmtPOZMXv006+tB36Fh8BDL4lYKLZl90VpGh4pp4N2Bb/M2KmsJLwf0VppdUPCR1Ezs35Lb9JVWyDgbJf1i6grDYJ67jN3/ti7xabMxcYc0AK77NiHCSnL5to7t8ZPTZyJZro3Op1GdZrpC9JsCvJ88obu3YeMDYuf6EpdcdjVQsNnSIoj22APHiqgQv7o/Y43/25hf8BAPcCqHtb9L4CLjRQ/U49GagHVvs9K55QsXHr7sqv09K5nb0DUBAhLtrsVLKWfe/bAQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(11063799003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uSzdf8gjzxe+NTfJoCG9POOrzYUXuNBSclTg1/XZlyPIZBPuZFBjwVAKDMiLtNDr/zHFIFb+lRgM68DP9MbcrNuQg+93ZiLllq96JzayyCA5GmqtKGLspusCGv3Q0PyTdZ0CR2GzmaE8p0lm2CIGRT83JKzWGDtl6WaqZ6dtksfs+3j+kVce0fyyAkxXHZK5ivJ5g5ZEQZy0s6l4/QMEAlZu64LvQlipPfp/HmFlmTc1tiBz1y/ZEM2k7YkT91oQj6TL8iBsITgjtAbXthiX45LSm33aI3VyKr/S0L5f5dPFlNttYnrQRegU5pxZtf9/0Hkl4sBemvG/FnxcgD+Dp3Hg1AGF6Hbk2JR2QsBWg/s37pwdDLLeTMysuwiS4C/6jTvG1C2S8g8SdIyksg3x1aqWHA7oVhJRJE0oSDjwA1RthDn59KBVZErmWRNb871J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:48:52.9657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c649370f-6bdf-46f4-f618-08deb0034b70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999185
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

Suggested-by: Manu Rastogi <manu.rastogi@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 155 ++++++++++++++++---------
 1 file changed, 97 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fabdbbd0abb7..4db6b4e398e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6874,11 +6874,40 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
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
@@ -6888,69 +6917,73 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
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
@@ -6959,36 +6992,38 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
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
 
@@ -6996,7 +7031,7 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->srbm_mutex);
 	gfx_v11_0_unset_safe_mode(adev, 0);
 
-	dev_info(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
+	dev_dbg(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
 			r == 0 ? "successfully" : "failed");
 	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
 	 * reset status relies on the compute ring test result.
@@ -7016,9 +7051,13 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
+		amdgpu_gfx_mec_pre_pipe_reset(adev, ring);
 		r = gfx_v11_0_reset_compute_pipe(ring);
-		if (r)
+		if (r) {
+			amdgpu_gfx_mec_post_pipe_reset(adev, ring);
 			return r;
+		}
+		amdgpu_gfx_mec_post_pipe_reset(adev, ring);
 	}
 
 	r = gfx_v11_0_kcq_init_queue(ring, true);
-- 
2.49.0

