Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F290E7E35C
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 09:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92EC710F3F0;
	Fri,  3 Apr 2026 09:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MM3QdXt1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4CA10F3F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 09:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpm/rfQ/vnG3F7ezs6oPDkpO5ldygKaYiITrT9tEAIIyBrM2y4q+JK+sOuNNVnbEhpeTCZteyVM83vWqsXCwSg/JAWgARFDN+gEsbDbnPEHmiyhcxJPLISVFyikpBLN3qRmzCi8+RsHg81eB4hUPiG96XN601386a9zZE5Zl+fZ7Y+PrhMPoEwJMni1pQw72glu7sSGN+4YFjRQoYGZ4sMUHLHRCZTqGfo5XDuS/pJ1YzAke/4COBmKRieBQYFpc60zWHk4sYollmcaS0lDtKTtpR81+jiIp9Sc493BJrlDIsHvCVZnuGXSY8G18BwZwf+ghHr/FdiyLQzMQZfVwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5TQtd6jrVGgpoUMXkF9I7pPqmjLscvyLgGzIv8pE7c=;
 b=XsK5c3rvhngWZBrWee7xajyEsDYz52TfngVM8ZHtYOsOvJqiJqtjsrLPXM+YI7VO9+A+Gkbu+FH6wk++E2B2nu/msqsXyxY3S5MkQAR/IMBD2FFGw12cW+EGLTkY1Ks0u3b4o/QxUjlW5CaxhRBX0s88UVhxpEfCQv8ZSleMzvvvNTdtDacOpWY/hq/ITFHu47slt7nRJWwOqkQoSfC7FgeO+R0keaoKGioBz+EGhdAI4Fecq98zZD25WhJsSdpzpGBoJiSRwnCSvVC1UbWRBBEZKC8605TDUjHLrbghYOR16YHl/NxkQkWo1VKZYDRkikfJhCf33amdrNhvFzdN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5TQtd6jrVGgpoUMXkF9I7pPqmjLscvyLgGzIv8pE7c=;
 b=MM3QdXt1N1dudxBaR2k2UrrAa03e2O5R+emv8yjT2+ajRK5gjiNgs/BEnjt3Skc23iXqU/EhSgkEvE2oc5oZVCIi71NpHpjkSSV9L5dTpbUTvMhcTKp5WOfIJYp9QdUWeDkYtfJEYf2GEiOC9pu1dJtlXdJEKHswjJBe0M5O890=
Received: from BYAPR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:74::26)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 3 Apr
 2026 09:25:59 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::dd) by BYAPR05CA0049.outlook.office365.com
 (2603:10b6:a03:74::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 09:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:25:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 04:25:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 04:25:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Apr 2026 04:25:51 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, "Manu
 Rastogi" <manu.rastogi@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/gfx_v12_0: fix GFX11 MEC pipe reset ordering
Date: Fri, 3 Apr 2026 17:24:38 +0800
Message-ID: <20260403092529.2238333-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
References: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: cadd12bd-08c0-4fd3-0832-08de91630436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: AOD77BhKi4NVDUOJxz2bUdv9mcduTyA778HrvO1+puNNH2ZfSqgyCkNdksUbRYEQh+NrkBqZ0OUWC70hJNtQbUySGmpSZf160Ra8wWFBYCLw+9EDeTO5v+cfBj+qZIbvBsIz1dWJ/x62cg0KAn5mZ+f0WHEw2UDp5mh23N7oCL0E4tDgdAPtLdgPtC3+/DN7ZU0AVt/YPGjcIM0Sk/czMnljF0q6fWqfzbCG7ueJPH8Whc1T7YZBiCubkhJXogTgPYt/iP91lR9hnbi+gbWicN5nZ0o7/tUuhTOlOepRZz7ol3b7ymVzh3MAvneXFut9q7EVtqgI4ThUvf8rCwEbiJE3sUnCfMTGh8BUM6QHXRjAlv3ITbeVkqyZsRWtc6r5iWmcCpdZWRgoLoVzoP/ZvM3KHnwi/uOAf4iUNOlQW0RphVIjd9eiusaYuvBsVL3L97bHyyyeVrwTKqvAL9Kk2A/h0chvv2AzRDMCke4r8AjnVefvWiH+C1ZtQRyIdkgXNHBTd6S+j2U6yzcyKBQ9FYsuFxU4VT6oENztRxUqD7Ql0H5C3JRW9kMBUn1fJLvmPpGN2dWHHUX+oN0ZHtzd/uysHFQ1ZBExBgjCL97vkCuTC9nULVYlIaX15SJyvMw1pSrIs0o/JIL6skzuNfKkEuBq0YbWiOZPrR+eIWrTIR27URjANTEeZrD7s1xrge0ah33hxRAg7vcn3SECzQGEYtKdLPlCkvTAv5bwVsUfGl54BmhGe2R4YJbcZRQmsNl9wZK8fpp3V17AV4w1MWAjew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fLRs9Ra9/WbT8eZUBctdlokKFjHIgqUZEHbYeoK8MiUICJRDpcPlN+PZZA6KCLYbO7b8rFZjb9P+E0vKE76ea0Mpyz6o+hSeI5b9Nk/y1HnK5IATn/iNxc3CC+4KxjeFxKnOf1qQGM89SKERGI6CBbO/p9jUooLlQvdVaA50Sdp706iAMgc4nMRgwrJh4P+TXs/0njeT9OqSO38TPnqkri7Cg2h7uSjGKcyolzssAcMeuez13MyjRhWLGWDXvX9BNYC+ybThgbl9AFrSudKncrrXPFDBeUdck07ZFkiilNW+EssVrz2V4e3ucaudL5cifEm2/uG8+3xtw2UhRIB5tNE72+QquO2rXpoqG89+h9KJPskTnWagTx5dcHvdtPc62zeRqRmr/GQ579G+RbQfmambKQyCzi3uKAkMMTWR+6boOrhgZUVgOOzDxijzfpKp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:25:59.0283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cadd12bd-08c0-4fd3-0832-08de91630436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
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

Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 111 ++++++++++++++++---------
 1 file changed, 71 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 65f308b15691..7aa3853f8db7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5362,10 +5362,38 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
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
@@ -5374,74 +5402,77 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
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
 
-- 
2.49.0

