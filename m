Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEC0CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 07:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB51410F385;
	Fri,  8 May 2026 07:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xGA4vyKI";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F78510F385
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 07:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmdGT7VUED8SQF/SuVr+/XSv+ag9lJ5CWkVUYXp/PUqk82ZOi087+xO8XuC5Lc1nyqLFWNjbP0xbcmsXqp2IwpcJ5Er26/dgUrlYJWV8CRuKVi3FhmOFg36y8bfJocHZDIhKo5S4V/iN3ygQcQMNl2j758lotsyF1T0lY80BypBbBDHm6qinjn5EtxPTnOuTxzV8av/hHzmV7S3NGeu0stCqoxYKf9HACpHt+X5o3b0JZliDHCupY8PKTS4O1GMNk/LIXD4d6xkSdhQ3r7GCpAkjBsTi6iVflVcKrTrrzKFYAOxbQ4DeYnnf3X+xUp14iVF6sftSt/2xYrtMteckoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBzfnL+7/Fp+jU0HI/GZhAlvw7/SVwzzrjaAUBzh9fE=;
 b=JAnN9xviWjmR9XW/2guHB9fMWhR5Z+WkmIb6n+t3TW3zSptutJvpdiPPonve4ZeBSCVYKeE98GUrsFaSe+SHaQNcP6k9ro7Me/ZAKfVu2lUsyluJlUz//JGvontWkinrRhlVmjZ0qfb2DwTGle/K4QpXZCbwS0ts4WruWAyOfSvJ/Ia4Jbxb9CdBs70Z1aIX8uTgUupf8o30VdUtOrq+pXsWnTlsmW2/ovJ/pBWLgb7auWtPG6gBNWVRNn60FEk59+u/uQdMKeEwqg+sx/XRzbh1FaTIa7motZ4pHQ401sYVEZ/tKfd6wNZGuc5cG7atHXEnPefHkF3R2TqYmXIwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBzfnL+7/Fp+jU0HI/GZhAlvw7/SVwzzrjaAUBzh9fE=;
 b=xGA4vyKIXvRTYITX/p2Ystjn0u7vKLiyk20Z9pb4Q5SooBoz0UnaYjWjSMZF8rwmcWgWOhCRRF/MxGmsRTu09vV/1jG4uH0yTDj5dy6fLOR0tscFTnZJmtDHCz+Me3tO/pbuYVtYZI56SLlGEtwMPcbhXXBbNretMysYF2uXy3s=
Received: from CH0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:610:cd::22)
 by CHXPR12MB999221.namprd12.prod.outlook.com (2603:10b6:610:2fa::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 07:14:36 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::1a) by CH0PR03CA0107.outlook.office365.com
 (2603:10b6:610:cd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Fri,
 8 May 2026 07:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:14:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 8 May
 2026 02:14:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 May
 2026 02:14:34 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 02:14:23 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Manu Rastogi <manu.rastogi@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/gfx_v12_0: fix GFX11 MEC pipe reset ordering
Date: Fri, 8 May 2026 15:13:36 +0800
Message-ID: <20260508071351.442816-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260508071351.442816-1-Jesse.Zhang@amd.com>
References: <20260508071351.442816-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CHXPR12MB999221:EE_
X-MS-Office365-Filtering-Correlation-Id: bd813db0-b72a-4d8c-b7de-08deacd175bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: +RDy047hw20UoVhG/s9aZUFIE415nq+iQAPFtPeXOPBGwVtTN5gMSv8cnE+rGNlyMBqE6Mm+ciiYNBKeX5d/a3uCsB3+CeM2ZLJBIypHvIU3jfcbwAPg+Jq8NQBmlxoT/dbqy6QFit5lgwuI25mc+lhqPfFg1P/wpnfhYVnFFWPXua+pqB2Jl9atOQXay+G1hAaqx5CjiJ5QluIkTbo0vsk3w85iUDLOj8hLmst9xyGMpWG+vL+j8e1wZnhDWugpVpsoZ/tnHhky9ywHB+VN3cW0DaJoDixequV12nN2+QWUokwBKMg53BajRfFwHJEF815WyO71DFLXOju5H0O/G9m8oF+L6SdbxbyPzUHaQQ/UI6v/HYpBpvDd76B+wq3vweuCIFQ9Zyc/owIEGfdHZnCaQLSRWSw6OZGD1phuFH8VOlDB76prOA7FI8k84dgZHnSPitYQ4MTfzkIb0wEIyntGZEiYCyZ/eOaJPfj/KzNJV4tWmYMV4ErWa5qdkW0aI1QVVCiLrrBHWCbittILLY4+/ITld6hPwXHFQ9WAlcydDAYpYwELLVOriOmRqj917AvwaPwktcQxdN3yaa0q17+x7gwAqXiQDNZBTtreH4Mu+g1qQD/dVeY2ILH1JmbSEVwo+ZsCTn1HcxtxMYTueX0EP6j8newzGqYFEp8dw0T9XGI25lwMFQKz4+ucCM6D0Z9FGGawW5rpyPfGhtQYhnqIa/erFrSiduV/Jus274o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m6SqIuiAqp2Icskaw+XHwIm6dr5ZPHkqo8BvpJW68DPgkef4bucNN7yKPZkKrqKzVXGX4GdnV7j8isOViyNQcouJUq3t1pAXxDEK+IsGw3sjvuOpixdlzKvrCq4V6iIuaImDAOkpItmIzDL4OwGz8j5NGYEp6pPBWQyHxLWnlapiPcPCOTsL5108Rgk8ZdhTuJgYXtGyxlcMzznQ6HlmCJXVx1U+4Fu7bMCpoLx3xK9S5JPJQi8QGGEazzluSNbdY5l392VPsHbV94W7zkMLTgi51qNqOymX9E6YyxOEnXueMzCFrB0UBkzoiMUjayJCCW+DkQaqR2mXel+AOPcS68pSOxwBt5rVIdMAjP4yQ8Zn8FZfzp3rd6p8P1bKIa1ERvH9xi5etn1eUP/+hoNyN09EndIbxCRAWtV/qHt5Z8NV/LX6qz1njL3RMbbv01c6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:14:35.6249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd813db0-b72a-4d8c-b7de-08deacd175bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999221
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 119 ++++++++++++++++---------
 1 file changed, 78 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f47928dcd848..935c747d4aa4 100644
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
 
@@ -5404,9 +5435,15 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
+		amdgpu_gfx_mec_pipe_reset_prepare(adev, ring);
 		r = gfx_v12_0_reset_compute_pipe(ring);
-		if (r)
+		if (r) {
+			amdgpu_gfx_mec_pipe_restart_schedulers(adev, ring->me, ring->pipe,
+							       ring->xcc_id);
 			return r;
+		}
+		return amdgpu_gfx_mec_pipe_reset_recover_queues(adev, ring, timedout_fence,
+								gfx_v12_0_kcq_init_queue);
 	}
 
 	r = gfx_v12_0_kcq_init_queue(ring, true);
-- 
2.49.0

