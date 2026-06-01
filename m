Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF168CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690EB112DC6;
	Mon,  1 Jun 2026 05:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t8cPlVfe";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DC5112DC5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLI4DV+DOrKioomDWz4w9y+SHKxGOR6GYLAOkmEF6T8nrJOGfCD0onWfveOmdSH9/sqJEFzqMlQu0QNXxC9PfBGUUibSnam3z5WVA9ZfJBQ6svMrf02xLT9l5KkM5mx3RR1H/wfe6A6rJRNlWjZNzFsg+9tQj1s4I45/6c1rdjmBluGFoFJXxZ6sjo/9thJEaSFuhioyALq97FChBRoeNU5vuE5pkNKi3PYKfWsWSNcVwiyT++VkqIdqVsmgQ+Dqicy1TIg9Et3wCEWHr1Rlj9TeJCjJBqTVjTs1nOff8duTHVoDBeRF4zJkoUF6G/PFYR2aGHDbVC8bdUxNpcWAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya3khqUoCG7oqNJjQM1zuYlHCntmRbXlPhKfoZ0D6kE=;
 b=wH1M7CKoSUUJaifQ2pWkPR8CFtis3uUTNwMvJfO0lTMToult9eshma6HAfBxZ7T5bXEHpUeDiSzvo3Vsu/JkfEFwwbWKLykrfqlZI2yukp5ktltCs4JwFclfcDLaIlG+54QILNXrDZt2NYhPzZHsMqO5smdqr8ql/SHGgeyeBIz/ZsezOggl4noH6osVzY1EB1zlGaXU3PUxtMxrRPdfmN97XVG0igSJQ4HI1Suzz74jaRcYD3QXCrkwt4/oJF7M7FLbr3ejDzgn2k81854KpVi1c4gVtTDnxHqWioeUUGqz8auJTXVUss8+XmaHJXV1SbwGrje9OhMdXw9wxet/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya3khqUoCG7oqNJjQM1zuYlHCntmRbXlPhKfoZ0D6kE=;
 b=t8cPlVfeHjUrbarapztKHiJM4pqc0g9rp2P9vHjV5qDSdK206GDAlbe4eEAi5XhXBz53iGw2sg1eIYTW3lGMheccIIHIBnMOTYElJ28cJDdVFr/F3CgdVKJ7c5W6PNxV5HIqVjZ0w+0MZlQk3EdmMPbxj1A9gCRfM8AI5SpWN8Y=
Received: from LV3P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::28)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 05:52:38 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::6) by LV3P220CA0027.outlook.office365.com
 (2603:10b6:408:234::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:52:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:37 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:52:31 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 15/42] drm/amdgpu/mes11: move pipe reset to mes use_mmio
 patch
Date: Mon, 1 Jun 2026 13:49:01 +0800
Message-ID: <20260601055034.3700921-15-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da940e4-cc1a-439a-881a-08debfa1fd00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mdpszEU2ATQwNXtgpX27aBKJvctA4kIxKa83vVY4jlrtlaN1+fDA6Hfo2Nmivl+IlrHAaNy5YA894mZ3ttPAFrOQSAvfJb6gVjfkZP5VlQh/vf2qpYTchC6KguEonoVKqfKTAelENuOEYZSQaS+gXrOhIreLB08Neud8g0XzrdHWRKYP0ximwJ1rx2GKOg4pyQ8zTbeRRlBSslEGm/QodptuBZj4Lo/ZxTMZTDAdykaP1LURndRsbdUQrwCkAQ5ZAACBPH0rTxAhgW6utNI9ptdMaY1YRy79DNjr5n7tQ/PDhg6vfRGJ6ttXK/WpMDzeXTvhd9lqepjG4/b8rjHJvcEuMrbkcg6gb+NPJG/NpaWCPWCVL+orj5+hbXhQ+Hunc9KR5mLU3o5SuOnT7l4CkQLYD5Xs348TARPDP1m7i0ikohzrz1PJqmvGW/WffYsfl04uL1thffdQgzhmqBpJgm366e8teyunlvSsyM1N7Im7S3gsWWoiuF8WsXjeqc+KWhGvzf+W42zePPydUVhcAYzVwAQGk98yVoDJECZBRllP7xepd+FHkkqH/1Tt3Y1f7MAcnO7jrUqM9b0jEwyO013gstNSI5zexzD8mNVbljK9bWsZoGg7A/+e7MB0ncGOFUbrddGVvWZ4pkho795FIauVYDUyRNUBJgczWuOYE5Z+hbDD6ScEVp/JA1HHi6ceXyx78y0XUP+HIHVVAM6PgZqxCDTC8Bts4AXynex7pgM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: spat4V4diXWEu8wkUKQyD0Ku7Jgl3txmKwDjAdO6109OQkkvXWRmu4sx5VVG4gLQAJm2e2NtudWx96mEfS8Z/VWeqZJ6WAy7aYy1o/92S21m9c05+rNm7qUeGy7gW4YcYNS/tiXpdO+IQZKSEi7RpipExe0xrfwSTzkshKxCV1+HxCeVrrhFFK3sN/Z+yL8CM0v1r/pciic4jXQBI6aSj9mKmHlOEpp8P/FD8rFaBcZg/9NR2w/M5RQIqAn2V/pG2RelfClKck8lO/GuOvuz2zfbfDdPK0fS5JHVmkYPX8h9S8bGBmNOrLyj6iku26vcPwSuZakjlj7q6VLZkwRmQj/Wr2CPbGoaV+vmtta5+1mWdEUMYTJrcS3Jm4l8U91W9OdxtswVqadotNWdwYDSoNQFUXTEeqArk4KZWIjeNepvM6MuR30IQJ7vpDLD2SAa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:52:38.8073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da940e4-cc1a-439a-881a-08debfa1fd00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1
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

From: Alex Deucher <alexander.deucher@amd.com>

This makes the code flows cleaner and it's only supported on
the use_mmio path.

v2: fix typo
v3: fix typo
v4: directly clear ACTIVE and DEQUEUE_REQUEST (Shaoyun Liu)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 244 +------------------------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 244 ++++++++++++++++++++++++-
 2 files changed, 244 insertions(+), 244 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1995de5e6999..f268d46e0759 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6775,69 +6775,6 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
-static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
-
-static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t reset_pipe = 0, clean_pipe = 0;
-	int r;
-
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
-	gfx_v11_0_set_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	switch (ring->pipe) {
-	case 0:
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   PFP_PIPE0_RESET, 1);
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   ME_PIPE0_RESET, 1);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   PFP_PIPE0_RESET, 0);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   ME_PIPE0_RESET, 0);
-		break;
-	case 1:
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   PFP_PIPE1_RESET, 1);
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   ME_PIPE1_RESET, 1);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   PFP_PIPE1_RESET, 0);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   ME_PIPE1_RESET, 0);
-		break;
-	default:
-		break;
-	}
-
-	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
-	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
-
-	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
-						RS64_FW_UC_START_ADDR_LO;
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	gfx_v11_0_unset_safe_mode(adev, 0);
-
-	dev_info(adev->dev, "The ring %s pipe reset to the ME firmware start PC: %s\n", ring->name,
-			r == 0 ? "successfully" : "failed");
-	/* FIXME: Sometimes driver can't cache the ME firmware start PC correctly,
-	 * so the pipe reset status relies on the later gfx ring test result.
-	 */
-	return 0;
-}
-
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
@@ -6849,13 +6786,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r) {
-
-		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
-		r = gfx_v11_reset_gfx_pipe(ring);
-		if (r)
-			return r;
-	}
+	if (r)
+		return r;
 
 	if (use_mmio) {
 		r = gfx_v11_0_kgq_init_queue(ring, true);
@@ -6874,170 +6806,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-/*
- * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
- * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
- * asserted; only then clear the pipe reset bit.
- * Caller must hold adev->srbm_mutex.
- */
-static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
-					     u32 pipe)
-{
-	unsigned int q;
-	int j;
-
-	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
-		soc21_grbm_select(adev, me, pipe, q, 0);
-		/* Start from a clean HQD dequeue state before forcing HQD inactive. */
-		WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
-		if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
-			WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
-			for (j = 0; j < adev->usec_timeout; j++) {
-				if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-					break;
-				udelay(1);
-			}
-		}
-
-		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
-	}
-}
-
-static int gfx_v11_0_reset_compute_pipe(struct amdgpu_device *adev,
-					   u32 me, u32 pipe, u32 queue)
-{
-	uint32_t reset_val, clean_val;
-	int r;
-
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
-	gfx_v11_0_set_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, me, pipe, queue, 0);
-
-	if (adev->gfx.rs64_enable) {
-		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
-		clean_val = reset_val;
-
-		switch (pipe) {
-		case 0:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE0_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE0_RESET, 0);
-			break;
-		case 1:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE1_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE1_RESET, 0);
-			break;
-		case 2:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE2_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE2_RESET, 0);
-			break;
-		case 3:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE3_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE3_RESET, 0);
-			break;
-		default:
-			break;
-		}
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
-		gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
-		soc21_grbm_select(adev, me, pipe, queue, 0);
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
-		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
-					RS64_FW_UC_START_ADDR_LO;
-	} else {
-		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
-		clean_val = reset_val;
-
-		if (me == 1) {
-			switch (pipe) {
-			case 0:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE0_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE0_RESET, 0);
-				break;
-			case 1:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE1_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE1_RESET, 0);
-				break;
-			case 2:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE2_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE2_RESET, 0);
-				break;
-			case 3:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE3_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE3_RESET, 0);
-				break;
-			default:
-				break;
-			}
-			/* mec1 fw pc: CP_MEC1_INSTR_PNTR */
-		} else {
-			switch (pipe) {
-			case 0:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE0_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE0_RESET, 0);
-				break;
-			case 1:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE1_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE1_RESET, 0);
-				break;
-			case 2:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE2_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE2_RESET, 0);
-				break;
-			case 3:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE3_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE3_RESET, 0);
-				break;
-			default:
-				break;
-			}
-			/* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
-		}
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
-		gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
-		soc21_grbm_select(adev, me, pipe, queue, 0);
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
-		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
-	}
-
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	gfx_v11_0_unset_safe_mode(adev, 0);
-
-	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
-		me, pipe, queue, r == 0 ? "successfully" : "failed");
-	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
-	 * reset status relies on the compute ring test result.
-	 */
-	return 0;
-}
-
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
@@ -7049,12 +6817,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r) {
-		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
-		r = gfx_v11_0_reset_compute_pipe(adev, ring->me, ring->pipe, ring->queue);
-		if (r)
-			return r;
-	}
+	if (r)
+		return r;
 
 	if (use_mmio) {
 		r = gfx_v11_0_kcq_init_queue(ring, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a926a330700e..9fe8bbbadb4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -390,6 +390,236 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static bool mes_v11_0_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/* Disable the pipe reset until the CPFW fully support it.*/
+	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
+	return false;
+}
+static int mes_v11_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
+					 u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!mes_v11_0_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, me, pipe, queue, 0);
+
+	switch (pipe) {
+	case 0:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 0);
+		break;
+	case 1:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 0);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
+
+	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
+						RS64_FW_UC_START_ADDR_LO;
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_info(adev->dev, "The gfx pipe reset to the ME firmware start PC: %s\n",
+			r == 0 ? "successfully" : "failed");
+	/* FIXME: Sometimes driver can't cache the ME firmware start PC correctly,
+	 * so the pipe reset status relies on the later gfx ring test result.
+	 */
+	return 0;
+}
+
+/*
+ * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
+ * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
+ * asserted; only then clear the pipe reset bit.
+ * Caller must hold adev->srbm_mutex.
+ */
+static void mes_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
+					     u32 pipe)
+{
+	unsigned int q;
+	int j;
+
+	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+		soc21_grbm_select(adev, me, pipe, q, 0);
+		/* Start from a clean HQD dequeue state before forcing HQD inactive. */
+		WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
+	}
+}
+
+static int mes_v11_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
+					     u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_val, clean_val;
+	int r;
+
+	if (!mes_v11_0_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, me, pipe, queue, 0);
+
+	if (adev->gfx.rs64_enable) {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+		clean_val = reset_val;
+
+		switch (pipe) {
+		case 0:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE0_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE1_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE1_RESET, 0);
+			break;
+		case 2:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE2_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE2_RESET, 0);
+			break;
+		case 3:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE3_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE3_RESET, 0);
+			break;
+		default:
+			break;
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
+		mes_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc21_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
+		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
+					RS64_FW_UC_START_ADDR_LO;
+	} else {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+		clean_val = reset_val;
+
+		if (me == 1) {
+			switch (pipe) {
+			case 0:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE0_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE1_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE2_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE3_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec1 fw pc: CP_MEC1_INSTR_PNTR */
+		} else {
+			switch (pipe) {
+			case 0:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE0_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE1_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE2_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE3_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
+		mes_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc21_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
+		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
+	}
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
+		me, pipe, queue, r == 0 ? "successfully" : "failed");
+	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
+	 * reset status relies on the compute ring test result.
+	 */
+	return 0;
+}
+
+static int mes_v11_0_reset_pipe_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				     uint32_t me_id, uint32_t pipe_id,
+				     uint32_t queue_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = mes->adev;
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX)
+		return mes_v11_0_reset_gfx_pipe_mmio(adev, me_id, pipe_id, queue_id);
+	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
+		return mes_v11_0_reset_compute_pipe_mmio(adev, me_id, pipe_id, queue_id);
+	else
+		return -EOPNOTSUPP;
+}
+
 static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				      uint32_t me_id, uint32_t pipe_id,
 				      uint32_t queue_id, uint32_t vmid)
@@ -762,10 +992,16 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
 
-	if (input->use_mmio)
-		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
-						  input->me_id, input->pipe_id,
-						  input->queue_id, input->vmid);
+	if (input->use_mmio) {
+		int r = mes_v11_0_reset_queue_mmio(mes, input->queue_type,
+						   input->me_id, input->pipe_id,
+						   input->queue_id, input->vmid);
+		if (r)
+			return mes_v11_0_reset_pipe_mmio(mes, input->queue_type,
+							 input->me_id, input->pipe_id,
+							 input->queue_id, input->vmid);
+		return 0;
+	}
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
-- 
2.49.0

