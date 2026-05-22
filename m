Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DE4CD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A5010E60D;
	Fri, 22 May 2026 00:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xbmKhd4m";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC5A10E58C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHCFQ+f4gM7H2ca7ZNc78UEW1X5hxy2Df/J3xx8M4c5RhsiyhYWNAAr45WlcjJ5UDXFlgLK8ZN4d+W78RqUcdf7vHo12G9gS5pXujQs9/t8wCjfstHKlO+RUWm5Y3jEvdJGoWWk7CnQbkxaitbue8F6p/OdfHmtB/QozQhxDMd/N5XNNTr8jBBSED8XJCzTIK7BLnXHa83uk9o/QZnW3hKna95eIcMX6bJHI/F5K8Kghs/gQ4tMej+u35XWax09Fx1YT/N3B+9J2OKCy9cDKY2hRv3idqc5PQgn2PMQgqTQdBDce2d27rUgp5Ct/jbJev6eGcSMDHZwsIsWf0b5skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMydrLs5px3yWLh8G4/tnu4AVDsCJRqin549wFhvVrY=;
 b=MqTfZ7X/Z385U9Tig9Qs+Hdz13ZuOJB4cBwfgZd8S6EQJz4nSwgtd+0Diy8+loKytQPWg/RVarUtlcgdcyUwtFzNYrSg6C3CWJxEAcsKwjn5JqfWaz+ZltetAVzVhmwL8mgLKDhaArXnyjh+GAR60W9tXZZmTkwaTRpSysAuzsMiYA9fYlp4FqKOwC7hOkwFcjadxeCdq9IEnWjC0KXZrv2MWDa/oQZ83FQ6Y0ozl5gKEARsIKO/4IgJORM6m7iiwHKF4dYXxRHyoC013roS6Qd/kQ1SjzooktlgOddnfPT+rJ+IkY6Qpl8iWkY4JLzZbHGyY7WzqkwiuBXYaAa0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMydrLs5px3yWLh8G4/tnu4AVDsCJRqin549wFhvVrY=;
 b=xbmKhd4moa563pU/UMNpqFljYQa5y3XVkc5yDMQ/HZpqjCDsR2gZwKYgdsq6R1NmgiPZUrRwpJ3MabDsnDrbnEuDDambp90mg0zCfMCexnWcihOdfw/23vVoj0yLmUSzWQR6GZNN12bq8ZfE9qd25sZMFCiDJIP6DCzEIWbfcCc=
Received: from DS1P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::14) by
 IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 22 May 2026 00:21:51 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:8:451:cafe::2a) by DS1P221CA0012.outlook.office365.com
 (2603:10b6:8:451::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Manu Rastogi <manu.rastogi@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset and add
 HQD cleanup
Date: Thu, 21 May 2026 20:20:20 -0400
Message-ID: <20260522002048.98506-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a292634-5507-40a2-1f6d-08deb7981e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|11063799006|3023799007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jjaWI0hS6xo+mAMHbz9iMuXYIqSHR42yNjIP7htUcxx+sWlf8r45DNS0MAQyAAoTIPb1jyb14JoIC/w9zzgbPWQXbYoavXMQ0bBJsUFNpw2jvukDb/XThKcKYRn903KSzr4jgqZqZ9NXV7jC4v3U2luAbH01UbcI4XNH38UkVGoDvmXOz1vLEwlvTqOKaKGehRLuYZ/mpOrdbpocZu+4/sVQiaqtiDzhf1lt6qD++UaijbWU70vA2IMu7cXdKgSUcYcERxSDuW0SJ/uEteEi/PmYMH4DpbLhcQYS49+xY3RbW6xXlwedjnsw1fV+Hs5L6OfS6Ym8eu8m8G544Voe+7i6wx2PBKh/rh2pY+Vi4jb74UlfXANHO8NdCpCYh8vFW5rNeYqtwfbUB3klhdgq9eYEjOdZQ6jKceCA7wNdMninInHVb+L90h4Ws9aUdZRvEuzVZm97JliuXM2P6VK7IxPob+8RhwnIHugtg5X95BRBhpS/gXraGy71j8QnPLljXFlHHGfElSek0Z7fPGA2RzfH2CS5jOQqzJMd1207SN8trdRDku7IL1Q8FIohc0PRw6RQE5Xt3wNX4Y7Ti06Pxg27Di4AIv56/oWEQ8nAcekWHshLnNI9h+0djTKFm7kDwZcCBeJqSwtZMPCAnaqhr/lsh7T42eAI7GCadjVCzumuaOvsZg49Pkapc2jWWh2Oz1KUSGq0Bd3RTCs4RuRyca432xtJD7ZZz5RJqFV77zA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(11063799006)(3023799007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J8hGjZNMqgPwSxmrcj5X0YXb9qU4gxrQd4so86v9mbXI0tTNeKDs1kn/dek+2XXLDSaE7N6xl6PCskPDKWh2AjbvvW5mwqRrUllNdX8HyjbqKNiC0szHWG/nOPpGdbuHkg1UQtHVkMi/rkNTJoRzhZqoqfT+zecBKvBh2BhtfAj+AlCqfscER/PPHKehXx++Bz+Ybqv0cl4kdTNakK4Y62AW2PyeJm8g1qZ7zUS92Q6q0OFDtJpVmhEXmCYS1pjrzWiYYiV8r9UYezMse3I0hb3LDuHF5Dot8x4618R/X+eXuDRbWKncdu8YsUxkJLRKTn+4sbvRX681UBNlkqJZ2oGsGh334etw540n7lTl05fRa3raBOXOSg+UpCwK5vHrIocGr+4N0Tb5gxsFKyLPozOifuI3l1A6uEg2tsb3HqfPvLZnGkHBXrCcNlbptLg6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:50.6450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a292634-5507-40a2-1f6d-08deb7981e76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

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

Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 123 ++++++++++++++++---------
 1 file changed, 77 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 4be650ce1fba7..d235e904b806b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5309,10 +5309,38 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
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
+static int gfx_v12_0_reset_compute_pipe(struct amdgpu_device *adev,
+					   u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_val, clean_val;
 	int r = 0;
 
 	if (!gfx_v12_pipe_reset_support(adev))
@@ -5320,75 +5348,78 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 
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
 
@@ -5405,7 +5436,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
-		r = gfx_v12_0_reset_compute_pipe(ring);
+		r = gfx_v12_0_reset_compute_pipe(adev, ring->me, ring->pipe, ring->queue);
 		if (r)
 			return r;
 	}
-- 
2.54.0

