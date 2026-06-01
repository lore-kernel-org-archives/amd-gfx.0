Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A904FCD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44079112DC0;
	Mon,  1 Jun 2026 05:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cajeRKZ4";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BEF112DC0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dI6A72J95y9CkaqnP6QBTHJ54ae7SkS2NwvNGaDnyrgCzEBydtEqYv5oZxZTcCqKsVduCCEJC/M2pO4dIFOzfKP+RUZW63dWdflH0w4y+4Iu6ZR+oh1idKHOxH4IHVNtbgJhhNHaf7JyuQyJ25ZGkHgynbVJufEeiJbI2OvQ2ya7B8c1argZxwTcWHdz6aSvJdDXEWAd73/VQ74EW7FynXAsBGn0e2t2Vd7FLkNZwJ8+9Y73vOh8M/l1MLvljT0WxflMNmD0a/yt/tvI6j2ak2padI3uP4iz0s/JcInvtQxMmnYniJpVYAAAEd8n0uYe03CceadZFZMZWMZMa6yJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM/KmzmZ/c+lZ29ssM5tpAydk3+Wa4sJuyn7faLJ/W4=;
 b=yTzjHeGcWj53Y34vSUmbk8cmDyoIFzTM3E99XK2Co8WmGBfhItDzP1NV15RlIsKh+GbpD6HDnkjKngplEO6gM+e4DCNU4jbPo7kjDEFt+4EC2wQYxjLiOAeST8hN96b4XNaKuScQhFLKz5Tj2e9qPveYUrftlCidPwvB+qLXsq0aLTwNUt7e3B/BEqZ/5y7dZIXm00TU+9+VDRmUGhWNLhup903VW9Ed+rzPEnrGP8H2aHR49PMg4piQumwggsRp+rh5SXjiU4cawPFkHGCRUZdGSKi2rsBqgpLzUipnQWOhbLxprgCOVITr1c51/UtMF/Xz8bo/F3lPOVTdWmIlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM/KmzmZ/c+lZ29ssM5tpAydk3+Wa4sJuyn7faLJ/W4=;
 b=cajeRKZ4hijKO671eFtY/Rw7gYQQINl64eZWJ9yXQkxm7t3+pSNLk0Uyrk6rCMfEZLJTUTNLMa2cPMh79YrcTdk7b4Quq6K4CehE0pP0SvqiDwdkmnShNOKZudCW/GvxgbfK7crkKPRGmHe+ivfMFjOqG9Ym7lZf788oD2T/3fk=
Received: from BN0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:e7::6)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 05:52:20 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::4c) by BN0PR03CA0031.outlook.office365.com
 (2603:10b6:408:e7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:52:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:19 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:52:07 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Manu Rastogi <manu.rastogi@amd.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset and
 add HQD cleanup
Date: Mon, 1 Jun 2026 13:48:59 +0800
Message-ID: <20260601055034.3700921-13-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: c633e548-42d7-4646-c611-08debfa1f194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: 9tcUzfyaL7dJtp1rIhbh78KBLKS08Woxmp7u02ChyNZ2+QNHwwxjI88/N0/gDz5Iiqw2FyH3y90ll36QXA7rX7YsoGrVxt04/faVAPnQGw6JzjFJei5tYwxxvKJDkvadifQOK5pQ7qTr0c55MMxZmVwjCr8BCp/Dm0D4I0AfioGIe4JcNZTEHb3hZ2E4CVKdqI+sl9c7emymEHdnZ5ZiKX+c7mqlRRnSjjJrCz8p15XvdE8BWRW+c0eJEISTtpu8XAw1ZEGP59u88cMBO/HGEiVgSbltM2oCV3d0jVg5eaQdGbemFe8jg0HlrARny1wQ4G1w389QFuJZ6KkL+FcYddVfdZ4f7byTObaxRfAGnm7dLjjRQA4bId608rGbmVLZVUtd+DSAOnfwuAMBXHkEXhQw/7I4xDFWxLK+msaTGiY1YtUDSurYX7r5dPZspfXwKtGtLmZZgPDiNG0uXcWGz7qQBl7NbQXPHyxDu1jDWwlUNQA7LmYMCEbXUf3+BBD1EwRnoCs/nGpqYuMrq5tTwZSncDomPHUfufDatytsQaQeJ3+r9kVcY47kUGXKiZBet5SgyPOC6BGSIqWc88a7s4N9V+AWaIlRNKsofsvoOpXyRPCmhmg7n2ONfHPQ4sSuD19nmLW/Vdo89nMmhzSLb7d2DRMOJj7F2Q4WpsxGspStTVrj/JbMDtOj8Lgnn9xOOVm4ESFmVUSJVOIs4siAze5ASF3JNm0nw4FSmyZ6BWQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JRA343WpfLNbgkIafbEkY+1aEEv8Wkw9wCFZ1vyYAqr3qjreeb2k9jP3dcyANeOf5ZYxGf+hneLrr3rT0AC6vVwPcaBVF4jmju7exR8iToY39jjDw3Wx7S31XhKY1IYfPXMdaUTqptb8Cgwvi3fLxCt5Izdv6Fe+8ev30xJtz0h1jVYiesDKmF+DbDEnReeB1FEzwAtw5YTlQYfFjyrl3R1zUHfjmgtwLiehnbZvdeZFqSufrv7h1EH52oWPoe89qqiR0fY89uDE/l4fky9dQlTEhZrK1+u1wY/bZapqPeS1esZJQwyLFl68kjR55MdTYVg3Qt9Wd+8UaPHje6FbeKGViGoHqgdX2lntfHRJpI4Eqb5siKMg2l693MPIOKlMYWrAXAGUxGEfiNaq+LL//4gzm1l1gAMz+rUypPKqcMJ0r0zDrJrO3tQ9bIE6xTHN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:52:19.6485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c633e548-42d7-4646-c611-08debfa1f194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
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

v2: just update the sequence (Alex)
v3: directly clear ACTIVE and DEQUEUE_REQUEST (Shaoyun Liu)

Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 166 +++++++++++++++----------
 1 file changed, 100 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index dd4f33d2ce45..1995de5e6999 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6874,11 +6874,39 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
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
@@ -6886,109 +6914,115 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 
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
 
@@ -6996,8 +7030,8 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->srbm_mutex);
 	gfx_v11_0_unset_safe_mode(adev, 0);
 
-	dev_info(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
-			r == 0 ? "successfully" : "failed");
+	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
+		me, pipe, queue, r == 0 ? "successfully" : "failed");
 	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
 	 * reset status relies on the compute ring test result.
 	 */
@@ -7017,7 +7051,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
-		r = gfx_v11_0_reset_compute_pipe(ring);
+		r = gfx_v11_0_reset_compute_pipe(adev, ring->me, ring->pipe, ring->queue);
 		if (r)
 			return r;
 	}
-- 
2.49.0

