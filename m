Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C822CD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9E610E214;
	Fri, 22 May 2026 00:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MiPw91dv";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253D410E214
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5NV7t+TE3X2fo3FBflkDZBDWDNnvCRghaP1Boi0iT1ayq0fjyTOrtji1+xB9pY5X2R55/v9ep5jD13nsLuaygIfrk7rE+8EXGfkpTsAncGsf/0wsSzKcJkf9ophmjwncIFvz2Yb+/FjnW40Fk9322Y4/k7e4CCX/jWQ4tDWM8e9i55qmPIhVycxgnBslYjzOXBrQmVlY2lf27lSKNw3gAvZoRSjPfsnbrDlj6MbcPEoEaky/loBzZDHeJ7ILYQjVyjYg+01qJMtCSfzrqCilSQiG4VMkMxYN3LH/NTGUnnkg0EMfTMsIc2wyCNYlotmS3+VVYud5txfq6wbYjXPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh+evI+Ge4hg2Ee1DmclIkC/dQICFTkAbLoR/cQmfPM=;
 b=ElZ1P49UlDDkXfrD/gXG6rprUO3+SFfDAzQw+lc+Uy11l5zzBypwiDp+ZYhMtp7oTpA1b6wgcUBQ8IkfH47OhUKkfyMt1oIQ5xM4aR2S6ZMPgqYc66LUuLgCsuVpyZs3q6TM2LJEzkbE3oOiFdFnuHN/EPz4ggS9NyodktnascrLGme9tDk3jrmVBXBotP08952FhYL954h8h5J9ojBCmexGeuloUY0immE2jcrj6U8iWxhN+Aq2pHjCL7vS7H6sTmunnA7CmghTRj6h3YWWJaWu8KK+wUxoF1fERU/Nn7O4zpjHuQOR5/+cbtc3uT8MRA+1Lc4liNzbLV9pM861+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh+evI+Ge4hg2Ee1DmclIkC/dQICFTkAbLoR/cQmfPM=;
 b=MiPw91dvTohF3IX7R2V7XNp9DiC/dYZ8D/8tRzNJaV4QyDVAAdOlWxfGaXlvwimogmg3JJN03UxwA0dN1pchEvTacLN3nlS2yPQ5YsEoZJbcE//Pv28OfT6HjONQ4fWUGI3520tx9Wk5n+8xesGav86jxRtHHXA8lwmG7MnDsZU=
Received: from SJ0PR13CA0178.namprd13.prod.outlook.com (2603:10b6:a03:2c7::33)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:21:20 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a3) by SJ0PR13CA0178.outlook.office365.com
 (2603:10b6:a03:2c7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Fri, 22
 May 2026 00:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/42] drm/amdgpu/mes12: use proper grbm_select function
Date: Thu, 21 May 2026 20:20:14 -0400
Message-ID: <20260522002048.98506-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e57eaa-c1a7-43d9-a9d8-08deb79809b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 97jMTROIKjTxPxNYH5LWbnkrUZWLGdFOhRgiruwhXk5XEl7jBpKK3k8zmk8QBEC5x0QoOt9cMuCWE6NVX0RQtita1ivQJEHC8BI02ZKQ7vOMHFtJG/AWNySPnfPFRA7lPifyXZ6uOOuUopusL8UyynPk0pLx66SEc2CjBaRdVq7fsfYP8ieDuFbwVHeuH9uxo3au4GbdusOzUjM6Wh4xGe68kWnAC0HWsRWPX+XwqK37P+WO5JfJ1/jqRBO3e1Yc9mBBIHuoO5dOKPkBRYFhMV5J1xBSOEhU0iF2CFCisKHxJpPWODs1urkddcMOQi1XjRn8QYaNDU1qRZpQT0vfPr20COaDsEfNnK567fbVGiew9BponT//GgEiUqzm35UK5HG9YpIOk7uSIxX5Uw15Io4x+31UWEeNARoWZZ7xVnzs8ey8LCEGoV1atD/DffSUfMMovfkFzh8M8EvDl5KY/UbLdl6aaJ8tYJShwXVQ3DHVOiMNLM6mG+FYeD5VJsYHc3PjPHLE0MOjYmSxR2/bTQTEE0cjEuCC+AClIGe3cWNLHDnTMxdKIYjTnPc1lzL0P2mNJBnn/TNzFontXSsWiVtrM4GWrY1I3VUcIZL4ap1pQrOUzRlK48brAYL99PwBipAz3AnsQuBnVoHmAw/Wcg9xX8lpJC2o4GurRfE6Zj4Vn2lon/r+hZGY0F9TPzMkTcMDtszETIgT6Nbto+vcpv4E7EUL8bu2t5zGvLRBSbk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yl4VxG1XMVRNxl8Qo169geT7+R4aR46EHqvfTXJ8D/GPH6e2p6EXI8oTcRM5CeQrl1/cCl2ReCDq5Ro0cO2w4ydlUmps/D5nk1NoPBW7Pd1SIwYld5Cz4wSAJbFKRD84w3xi6MwAb2EO1e7hqKf4yUFmvnDQDl23cejssJlhiJKWWzhRxSh45yEQVACSVKlPRS8gCjTOYYtW1LtXv2mKsiTqMU7poHbPx9URpmiEDEa/h/POsQHybGuAfBRARtNhUvgj0xbWWeHrr6nHQP3CXXOw+phH4gK6BcmxMYQcF/0k1UgWYHO3eQtPpJu+DXz3FLvuQ0RLrpx6gw/BjGtDhFTz7gVq18yBQpZTq4am6vFJGb/JyR7CI1Io90CmEAY+nVE+Kzv1ZvJWRckPmUXZMZ8cWKbJtd9SdEP7wA1YmcTeeO+n+2KWWvCDAfLpL5rx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:15.8066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e57eaa-c1a7-43d9-a9d8-08deb79809b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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

s/soc21_grbm_select/soc24_grbm_select/

No functional difference as the register offsets are
the same.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345ea548..8d618df192856 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -26,7 +26,7 @@
 #include "amdgpu.h"
 #include "gfx_v12_0.h"
 #include "soc15_common.h"
-#include "soc21.h"
+#include "soc24.h"
 #include "gc/gc_12_0_0_offset.h"
 #include "gc/gc_12_0_0_sh_mask.h"
 #include "gc/gc_11_0_0_default.h"
@@ -442,7 +442,7 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 		mutex_unlock(&adev->gfx.reset_sem_mutex);
 
 		mutex_lock(&adev->srbm_mutex);
-		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		soc24_grbm_select(adev, me_id, pipe_id, queue_id, 0);
 		/* wait till dequeue take effects */
 		for (i = 0; i < adev->usec_timeout; i++) {
 			if (!(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
@@ -454,13 +454,13 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 			r = -ETIMEDOUT;
 		}
 
-		soc21_grbm_select(adev, 0, 0, 0, 0);
+		soc24_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
 		dev_info(adev->dev, "reset compute queue (%d:%d:%d)\n",
 			 me_id, pipe_id, queue_id);
 		mutex_lock(&adev->srbm_mutex);
-		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		soc24_grbm_select(adev, me_id, pipe_id, queue_id, 0);
 		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
 		WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
 
@@ -474,7 +474,7 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 			dev_err(adev->dev, "failed to wait on hqd deactivate\n");
 			r = -ETIMEDOUT;
 		}
-		soc21_grbm_select(adev, 0, 0, 0, 0);
+		soc24_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	} else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
 		dev_info(adev->dev, "reset sdma queue (%d:%d:%d)\n",
@@ -1092,7 +1092,7 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 	if (enable) {
 		mutex_lock(&adev->srbm_mutex);
 		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
-			soc21_grbm_select(adev, 3, pipe, 0, 0);
+			soc24_grbm_select(adev, 3, pipe, 0, 0);
 			if (amdgpu_mes_log_enable) {
 				u32 log_size = AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE;
 				/* In case uni mes is not enabled, only program for pipe 0 */
@@ -1131,7 +1131,7 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 			WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
 
 		}
-		soc21_grbm_select(adev, 0, 0, 0, 0);
+		soc24_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (amdgpu_emu_mode)
@@ -1163,7 +1163,7 @@ static void mes_v12_0_set_ucode_start_addr(struct amdgpu_device *adev)
 	mutex_lock(&adev->srbm_mutex);
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		/* me=3, queue=0 */
-		soc21_grbm_select(adev, 3, pipe, 0, 0);
+		soc24_grbm_select(adev, 3, pipe, 0, 0);
 
 		/* set ucode start address */
 		ucode_addr = adev->mes.uc_start_addr[pipe] >> 2;
@@ -1172,7 +1172,7 @@ static void mes_v12_0_set_ucode_start_addr(struct amdgpu_device *adev)
 		WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START_HI,
 				upper_32_bits(ucode_addr));
 
-		soc21_grbm_select(adev, 0, 0, 0, 0);
+		soc24_grbm_select(adev, 0, 0, 0, 0);
 	}
 	mutex_unlock(&adev->srbm_mutex);
 }
@@ -1201,7 +1201,7 @@ static int mes_v12_0_load_microcode(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->srbm_mutex);
 	/* me=3, pipe=0, queue=0 */
-	soc21_grbm_select(adev, 3, pipe, 0, 0);
+	soc24_grbm_select(adev, 3, pipe, 0, 0);
 
 	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_CNTL, 0);
 
@@ -1236,7 +1236,7 @@ static int mes_v12_0_load_microcode(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
 	}
 
-	soc21_grbm_select(adev, 0, 0, 0, 0);
+	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 
 	return 0;
@@ -1383,7 +1383,7 @@ static void mes_v12_0_queue_init_register(struct amdgpu_ring *ring)
 	uint32_t data = 0;
 
 	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, 3, ring->pipe, 0, 0);
+	soc24_grbm_select(adev, 3, ring->pipe, 0, 0);
 
 	/* set CP_HQD_VMID.VMID = 0. */
 	data = RREG32_SOC15(GC, 0, regCP_HQD_VMID);
@@ -1434,7 +1434,7 @@ static void mes_v12_0_queue_init_register(struct amdgpu_ring *ring)
 	/* set CP_HQD_ACTIVE.ACTIVE=1 */
 	WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, mqd->cp_hqd_active);
 
-	soc21_grbm_select(adev, 0, 0, 0, 0);
+	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 }
 
@@ -1500,14 +1500,14 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 	    ((pipe == AMDGPU_MES_KIQ_PIPE) && !adev->mes.kiq_version)) {
 		/* get MES scheduler/KIQ versions */
 		mutex_lock(&adev->srbm_mutex);
-		soc21_grbm_select(adev, 3, pipe, 0, 0);
+		soc24_grbm_select(adev, 3, pipe, 0, 0);
 
 		if (pipe == AMDGPU_MES_SCHED_PIPE)
 			adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
 		else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
 			adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
 
-		soc21_grbm_select(adev, 0, 0, 0, 0);
+		soc24_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	}
 
@@ -1695,7 +1695,7 @@ static void mes_v12_0_kiq_dequeue_sched(struct amdgpu_device *adev)
 	int i;
 
 	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+	soc24_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
 
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
@@ -1719,7 +1719,7 @@ static void mes_v12_0_kiq_dequeue_sched(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI, 0);
 	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR, 0);
 
-	soc21_grbm_select(adev, 0, 0, 0, 0);
+	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 
 	adev->mes.ring[0].sched.ready = false;
-- 
2.54.0

