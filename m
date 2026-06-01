Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994A5CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED1A112DBF;
	Mon,  1 Jun 2026 05:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBdPqPS2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BCF10E234
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGg/sd40gQr0P0JIpnw/WHO5leSrWMnAmFdJAfheFVQpWkRWSlDFoTbfnTGK19tgiwllaDbUiBUSALfQB9sEqxgCQl9Y68NsZor6klmSLEdfzp3pvYEx5GsH0Z0b702HBqqvn2KPFso3a+fVJSwGOzCMbmcP9fEHscWAnCTTKI+4XsDpY7BspwZTw63mptrfHY2dZEdbf3YLplb0dR7OlNH/qRLZI6gVYAQOdCiWl9+fvAEvGtD/tcLjCidG0c9YKmTxvINrdPEhQ5F0Fv/wrPLDG/VdARiGYCE5xRNILWjqNQl79xco8s2WkGJB/jIr0OdO8BqZ73NAxoRnOBpViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI0azATepsy6I0HONVJOM8y4wO2m1WS+kcpzXyRYXkQ=;
 b=VefoLtYOVmlz408xQCu+RQIX45gtcKthOxs7dd+oFTDYx2HCFO5sDcT613jzl3s+CWk4VGZXBXl2s6HqVUaB7ESSlF7qkaiCrj38TwyunIuJsxVnG2xxHYIkbraCdVC0yWzyfxLt8bEiJhyyyKnzcol3QhKGLjHMSxLZNpUgnsaF6v2IkpuYZ/2ZFr0vj3ySZJLSbnK4jArmhx34P7DulI/KE2eSQkXpcvsF4YlBCAIJTb861n9vafx8DqQy9LmMCM5bMofJeXHHiOGLGJCskChC6V8gLlKT/AnPWEptyWxEg8T3EmbSagjK7KmjwY+d9bqDoVGK7nzzGv9tkcgv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI0azATepsy6I0HONVJOM8y4wO2m1WS+kcpzXyRYXkQ=;
 b=aBdPqPS2F3GJT0Cug1Pu7QsGJEHUsupQqcofinslcDCb3+AgvEU6j0xndPu/GIiKFsy5c+PSbAIU+LT7lZg/Eby3jr+1mNcRWmLrdcFFFlAgvcAtIkkrrqOeK09W++LuwvuyXiaB20iJZTy57099j92i+mi93Eu3qc3ebMJ6ou0=
Received: from MN2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:208:239::8)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 05:51:29 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::10) by MN2PR08CA0003.outlook.office365.com
 (2603:10b6:208:239::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 05:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:51:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:28 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:51:22 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 08/42] drm/amdgpu/mes12: use proper grbm_select function
Date: Mon, 1 Jun 2026 13:48:54 +0800
Message-ID: <20260601055034.3700921-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a788c92-a24b-4d37-78ff-08debfa1d38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9/DEZUd65Ls81MJRI3BBa5SbUICouhXZ8RLsJDdcfs+VW73dhdyWdlxeDfSCuDeh6zW8clBqO/qu+GdAcsXBMWPosNZwdxLF+1BGo6OeeZuCq/Ubvjvtq80DblKdaeBeEQArV2ToEktdZJHwhfTiEBBnQWinkTeN0CLsUtFDePaic77w3nJ+g1ux4z7+ZzjXEquxuXKGi/g8M5dWaIJG6flDOCVT7uzI9WshcAeX2ZBLUyXZXHk99CSU8JGr69gRewvKYLi2YVAOasUnwiJoW5CHJcOpum3Jf/hNlA9ARwfvNSstTEttf6PSMv+s0F95kyiuxQbXHsYKYbDTgVJRasOxheGHPXto/HmSAwucxLoZE5xu+mluS3s1bJnEYIjZhoTv6rQW1n9XPCp6aSet0C8O1QkOE2P94gkcsQ2a5OWnTpY5lodGVDTpfWGyCAMy4CkLg8Ms2UmoRozAm6XZiiStUqTrV+z0N5bRHhNAykFYE11/pQ992wcwo+u9huB5gRTfQPP+yQoZmWjbMqnLsXh6J7bg67Kf6evmc0FJlhNRRLPdWJ5yn82T2CbU1IXJNbVeALaWLVH+0S0GJH20gdl6i52Q3UHgQQcQYM6SdrYmUBTZB6tq2ofGk1eS2WGKc8EF2xTDh30JECKQBR12ukkbHtxlsUIITUGKSbv3Roae846eQK0oJNnYAuzKZviWPAqPWCYJWnCpV+GSoWxG8EXDWOsM8T2YBUMDc2zpe90=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dq+JehhQlBfelezyM8zPKSDeheDL8+MAQYahKhpngBjZOABU3MN9hcd6SN+vmBtOgI4T+rGF1ANSfC4Yl67a2kaYpAa4xCSP2sTxOY1vIb647jN6H+Ib9PsQaFxufgn5bfWeXvaGqawIWDcXbGU7Mj+Epj4d6cgr7sZKxN1HDUJ6BdXBhHI55r2vJtGg1MxrQakIayZVlkgKN0hfYIqKg/q5PqnPpguG+Nz7zhCEnrczHAH/km4kXv/hnvpPK5WG+1+b94afNgCj/6ilzIFqyd08HKudcnlQozy/oXS/IN7dcOHlgFJIaf4EGoxbSa0R54P4E2Rt2WQGTxAl04AqVlw7oCfPWiAHcv34bQaOSFqgXdR9h+LRqZZXhieAbL8uUNwtXQgeo/mhww2DDDeSN43s0h+64tODt51/yxiZjo/xTjqz/mQyoNTrQ03eYxXf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:51:29.2459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a788c92-a24b-4d37-78ff-08debfa1d38a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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

s/soc21_grbm_select/soc24_grbm_select/

No functional difference as the register offsets are
the same.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345ea54..8d618df19285 100644
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
2.49.0

