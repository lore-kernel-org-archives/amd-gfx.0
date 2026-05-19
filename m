Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B727CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2A810EE11;
	Tue, 19 May 2026 18:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pfx7dQxu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB6F10EE11
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXw30FZwS2szFa86Tp1uTJKW2oDPDBstyFPtm41KqEYo2x9tPLtN4fduEiBNldyjPjYR6vMQRMYTXqa2tsdC23RtKLS/hMkserxu+RWRy35yt7pLJvP4A1IAYXICQwk6CMmI1GXP8vzwlbMQac16LMHMv7u/R6uk9GcJsX/pOeMj7EqcLxIpKo+bm4ynGZRPg7xX7NtV0LLbPy1fmxSVpCkMSF8873QD9xSLxkFBfhUOTVub2QPKpmoG4NSogzxN+o1TaErL51WrKpG020P9uH9WyAysYKgxysDCdJzDYFVU3ciiLkxQlYdTHSJRL52oIkef0uu+5eCsMk4f1IhbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh+evI+Ge4hg2Ee1DmclIkC/dQICFTkAbLoR/cQmfPM=;
 b=iSJqKjPDfYtmv5p2c+aUQeDo892OhVn8dggEA84XbWZ4fdsx9ULAAp9ttjdYMxRMvx+7MVamWNLnQjo3TpmpEjx+9s7Rfr5/1d/TyQtalCvTaA0gGEqkAEIGBHZ3P0kyu9BHyl/jJrUyx+DWejs0/kxzaNcMTplzYGy3LZYkUKxuLrJebgBcSRw+jwk/0hpRvZpvV0MPuxco5ol/j4Yo3bj9YnslQSlyQ/0NwJNCvzCXPpa7CI+feuIozyY16LU1aeuG/N2q040UDJvOvxMobCcRk2L8cdpP6r1OhcQgDaB/2DAxcEHb/+r8Nbf2NEHF25K1UbOtZSmbKNq0WysgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh+evI+Ge4hg2Ee1DmclIkC/dQICFTkAbLoR/cQmfPM=;
 b=Pfx7dQxuZKxwWGaJj67efBLgAqiCW6EtY/TuMTvgVh4WSW6wCajlotH+5t68owd+UhNaUViuQK/LO3St4cnSfEsX+3zmkfl3liHgNHROd0szgILDtLQJkufSMYDmVT3rtyp7NcwB0HhS8K1hYdsvOUFe+XTnbEWY8KrBtjtZvV0=
Received: from SN7PR04CA0091.namprd04.prod.outlook.com (2603:10b6:806:122::6)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 18:32:04 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::52) by SN7PR04CA0091.outlook.office365.com
 (2603:10b6:806:122::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 18:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:32:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 19 May
 2026 13:31:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 May
 2026 13:31:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:31:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu/mes12: use proper grbm_select function
Date: Tue, 19 May 2026 14:30:47 -0400
Message-ID: <20260519183055.22275-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 872fa4e4-4cb0-4821-a333-08deb5d4ed00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: pJMTtUC0Jan1rn1xyMyomIDxOiJ5IMJSE188E/1zqTXvPEnd/xqxZMWwH7GapQCeD5PsV0IOHzYmkgHpbdtCm4hbL80One4GZb1fknIxIdZ3Yzj2AMl6vwUjBLuaX4DOFz1ryqrN+XFPEqfbP7NW6gf3z3b5c0FxkLS6oDRmav4uG/XB006WGr5Z6VbLoZUGQlXlFVxR1vLTnLgnEpfTxQxstHkERuFgP8apVQYgDsDF8pYCKIyIq/QdHabU1eXlimMdhP+kCbmpB4JjBeM+QQYqg8jvhoU+1yfXIHrRgtqDvLioOdLl+f/+1tgfN/sk5n8mHFThBHJDLhm6PagtmYwFrWEnre/B27QSTJvRWZXpabyBsj63nZO2Sx2X47gis2Tgol6xqODMM3bKGR5uoxFF3rs3FA4/UWV+l0vxpaDdwZRuJi0wgrV5BzIzOmZtGgIQc6roCHNSXmfKq27599G13Cfj4IVEYBCVPDSTqSLsuqQTfIaD5y0MbzAoSwzSopUujvcmagB4v8XF9iqrU3MPMaCA0F5zE17cmNOQjx8uX0z5engfKWg7dxcjWCsQwowfhZVAx0z54oPLXF4rkEJUX7JtvLfazzJJGTKyMKzBna9nluL9vwQZ1bri9aeH/S5f5x4xHN4qK5RiOmTzJViTxuwjxJfsbOGzMplpaJxoB3htSSChbnkNbkUKpYRUaLCLEXAIg5DMJ1BwHAmEf4T6mYF23+p09h5vxNLp1q0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WM20543d8BbHotQsoleJLyQIt/RBr7/qGSVUOimHigJL8wnOfVLktbz2hZvVdDS1BBWFd5uSGi62Ls74b+khwgQg+1va1Hxa2qAXi8dRtJNxCo/k5K4ClNTvcaclb57ojiXU5nSocGvxOy5nC9dOmm3TXruzao7CZinJN1EY0aUfHVYklSu4hagCQmrwMq0oNDX1XwkBLvaCJm39B0qnrGV4j/AewC6ilOQUyf2Xg73aFN/nRvB+1B/2IdqYrwcOo2OcXJNiQffLNqLzFzXDRE4tF/ks+NWbAe62x61vPSAv/lQhPtzk5BTC/W8Ycq27qK+4M16LtqX1e2Q2NjrwcmdKknGptAis9zB1e8/mPgd0YIE8xqpHhSrYwRADv25+s0mctDDUjkGwtTaXmshWWCHEkWgORes9WeoRmjDmdSnoscunbd5kZUOFWA1gJiRB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:32:04.6476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872fa4e4-4cb0-4821-a333-08deb5d4ed00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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

