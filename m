Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A781BC982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B4E10E410;
	Mon, 21 Sep 2026 07:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J3/RN9RP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013037.outbound.protection.outlook.com
 [40.93.196.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1520D10E410
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD/Jc69YVDWZGRrFNA9BCVnUGfWrhrpNYZwmuytsSo0CSPNQc4oPwrs08zzUfc/OsugHpO+AAcEup7P0qcg+H+h19MbNfL31LznDWZpOz+zF0Kzcez6zShaAV7u8nI+y5mdNVrgNZMq5/VA/YwBDN95eRcH5D4GoRv/n92/FkqwlpiFgOWNfnWiRMNk9THSDPiToRIW54QGsAH2o4EWKFcCr7ZOAdfkcE7hfLV2BbEecssTAc/JEz6kOAq0+tFOWd4zBGuqwU815trDGP2doDOV8w1vTZw0AdLAKYkTuPyzNoDxemVQmvOXiDq0JqSWEgiqYSjS9YCC3pk9ximhuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w51xXYmcQkXtT2dL7gACLn8sDJtjKuwStPADGwIq6eQ=;
 b=whhXAqOakczioayTeNALtr5ttSoxEMTnLORZSNNUvUZTkAS151QCeCenU54IForb3KUkHgrC3VcQRLiN/4d7fMzYplwnI1tWhAdcLeFivxeegoyKIlagNb9dC68FgcxYW2nxmBbqCDWm5CFl/bBTM+aH09caEek0jBwI2FotbsDp5jimvWG7cTQaqQlkwzEsALscOZ4BsUc4OHkNqff5jTzJfna341jJm3ug5VO9n3b4QnltikgEO0vS7Vanot/Ti36u3sfsfk8GhhrYH+mghazjIlJr2hWsXJ5CXIIfWGmgUnsLJEmP6x2Alue1RFPjUsZNa5C0xmbvtDzhjjAfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w51xXYmcQkXtT2dL7gACLn8sDJtjKuwStPADGwIq6eQ=;
 b=J3/RN9RPYmT4twgC9S/Jgz85A5Ty6qZvci0FVOAhEjuIQZXeoOahZE2mhw0Nns4qv2UjE4zz4SFTTuKsP880PL3hA1qbB+jRXBZdyqhkw5jLwhjPENT/mtO9bSBh1CfkfXU/w2QDjzyj81CzfBjmXvkMbtN+sEscPJ66O2kMPDE=
Received: from BN9PR03CA0105.namprd03.prod.outlook.com (2603:10b6:408:fd::20)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:38 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::4f) by BN9PR03CA0105.outlook.office365.com
 (2603:10b6:408:fd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Mon,
 21 Sep 2026 07:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:38 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:36 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 05/21] drm/amdgpu/mes12: restore collateral gfx queues after
 pipe reset
Date: Mon, 21 Sep 2026 15:51:12 +0800
Message-ID: <20260921075326.2409021-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7633c684-106f-41c3-33db-08df17b57269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 87FGBaQDW+0P8HFYk4G+xRyIm+zvjdfC2/0EpTfvuBIUj8ZOm/RkM0Of1MEQh3wat2IYt0686vq9T/9KwdDOSmw523rTWnk76ipJhMhbFGMxwm+NECmWp4teWhf7XKTr1jxGp6zfiSQbyEizL9xtJQQqyDi56JqAl3ei+NO10YdFjxSn2/Ytf45VUquvEycC/lIc54wBNW5Tvs3TputhFJKYuxRagAZAjG0b8FZfxjh8K7Lmw++16LpFTRcBzfl2TbquLRkeVRy4gmkQvVljL6XBAX33JK7Dm08p1ltQJGpq05YuXeh3+NEHrX72fZFFh98kcgLRuYJPkoTvjuJUfstOs7mTd2qnMEqKqjMkZ6Xc9JKgBQJiMZStVM6W4sVsonG0pKVpMLrcHgRwKpsvzq+H0X0p5tVMPo69beS2FvmgtbAar5cI63io2ZMVTojEausaknMS5Xp5q8V27PWj7nGYO/GIB5bu6VGMI6en3/xhq8ik2iebXy0W1tWBUJ521GphRY+W3f99dHerSwAMmAxgl/78T4MGOHuuCghZ9Lo5c5wcAHvjzW+9G8fhSLvb3FTckoXupyDwdJrxOs6q1tIfVBQNXvOj0C8RuH+1x6RMtFI8OlT7+LgncZTZ+wiEMR0meGq7z4Nkxfe2NtGFv3qD013N7IMeAVk1sI0JETN2sXR/emJAhQhPrQcAtEOuU55zd4FeINFqRmtQ11mTaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: orOpjj0+RLlyTXWOZB2Jh2pAe8F/34WUBZzRHYe4kMh/n77O3lmbdsA9AhtoezmssQDEqABlpXi0FKChEcEdve7XO1vT83+hU+2MdUECBgLQViFzzNTLsfMa4iZMiLmkgy97JaJ0sAW1+lxgXvFfQDMVTZPuZdxzpwEE7imiGmPrrAh0H1z/dXQTGpsosSKn5gaxh/VC3tObvOXYt8CO2J7fP+3dfeqRno5b1klqoGf0dDmnnXjnMYhEqg4iHWrLX3gm0x+mrjt61b4vTnRHYZrb2FOs4xTPNacunlxHzMkBtmv8ADe/fSW9UeJQBhQGQ9WyukqRFoLsa4v0xcqSjZr9cBvhZAAaCDSviSAECT41NR5USiGHznJ9sPtfG+SYCIerBygTECna+ZY4MBVXYkCY9q5rKovLF2Y5bxIedEUO378r0vyucdNeVj7hj4WS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:38.5490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7633c684-106f-41c3-33db-08df17b57269
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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

A pipe reset restarts the shared PFP/ME, but CP firmware dequeues only
the requested queue. Wait for its CP_VMID_RESET bit and HQD_ACTIVE to
clear, and return -ETIMEDOUT if recovery does not complete.

Preempt each collateral kernel queue and wait for its HQD to deactivate
before rebuilding its MQD/ring and remapping it. Leave the guilty kernel
queue to the outer reset helper.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 111 +++++++++++++++++++++----
 1 file changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ee72afdb0a1d..41d6799177d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -425,11 +425,73 @@ static bool mes_v12_0_pipe_reset_support(struct amdgpu_device *adev)
 	return false;
 }
 
+/* Use MES callbacks directly while holding the MES lock. */
+static int mes_v12_0_restore_gfx_kernel_queue(struct amdgpu_device *adev,
+					      u32 me, u32 pipe, u32 guilty_queue,
+					      bool is_kq)
+{
+	struct amdgpu_ring *ring;
+	int i, j, r;
+
+	/*
+	 * Only the guilty HQD was dequeued; stop collateral HQDs before rebuild.
+	 * The outer reset helper restores the guilty kernel queue.
+	 */
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		struct mes_unmap_legacy_queue_input unmap = { 0 };
+		struct mes_map_legacy_queue_input map = { 0 };
+
+		ring = &adev->gfx.gfx_ring[i];
+		if (ring->me != me || ring->pipe != pipe ||
+		    (is_kq && ring->queue == guilty_queue))
+			continue;
+
+		unmap.action = PREEMPT_QUEUES;
+		unmap.queue_type = ring->funcs->type;
+		unmap.doorbell_offset = ring->doorbell_index;
+		unmap.pipe_id = ring->pipe;
+		unmap.queue_id = ring->queue;
+		r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &unmap);
+		if (r)
+			return r;
+
+		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+		mutex_lock(&adev->srbm_mutex);
+		soc24_grbm_select(adev, me, pipe, ring->queue, 0);
+		for (j = 0; j < adev->usec_timeout; j++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		soc24_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+		amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+		if (j == adev->usec_timeout)
+			return -ETIMEDOUT;
+
+		amdgpu_gfx_mqd_reset_restore(ring);
+
+		map.queue_type = ring->funcs->type;
+		map.doorbell_offset = ring->doorbell_index;
+		map.pipe_id = ring->pipe;
+		map.queue_id = ring->queue;
+		map.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
+		map.wptr_addr = ring->wptr_gpu_addr;
+		r = adev->mes.funcs->map_legacy_queue(&adev->mes, &map);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 static int mes_v12_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
-					 u32 me, u32 pipe, u32 queue)
+					 u32 me, u32 pipe, u32 queue,
+					 bool is_kq)
 {
-	uint32_t reset_pipe = 0, clean_pipe = 0;
-	int r;
+	bool has_kq = adev->gfx.num_gfx_rings >= 1;
+	uint32_t reset_pipe, clean_pipe;
+	int i;
 
 	if (!mes_v12_0_pipe_reset_support(adev))
 		return -EOPNOTSUPP;
@@ -438,6 +500,9 @@ static int mes_v12_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, me, pipe, queue, 0);
 
+	reset_pipe = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	clean_pipe = reset_pipe;
+
 	switch (pipe) {
 	case 0:
 		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
@@ -463,22 +528,35 @@ static int mes_v12_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
 		break;
 	}
 
+	/* Preserve ACTIVE/DEQUEUE so warm firmware can complete queue release. */
 	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
+	soc24_grbm_select(adev, me, pipe, queue, 0);
 	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
 
-	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
-					RS64_FW_UC_START_ADDR_LO;
+	/* CP firmware releases only the queue named in CP_VMID_RESET. */
+	soc24_grbm_select(adev, me, pipe, queue, 0);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_VMID_RESET) &
+		      BIT(16 + pipe * 8 + queue)) &&
+		    !(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+
 	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
-	dev_info(adev->dev, "The gfx pipe reset: %s\n",
-			r == 0 ? "successfully" : "failed");
-	/* Sometimes the ME start pc counter can't cache correctly, so the
-	 * PC check only as a reference and pipe reset result rely on the
-	 * later ring test.
-	 */
-	return 0;
+	if (i >= adev->usec_timeout) {
+		dev_err(adev->dev,
+			"gfx pipe reset: CP front-end still busy, CP still wedged\n");
+		return -ETIMEDOUT;
+	}
+
+	if (!has_kq)
+		return 0;
+
+	return mes_v12_0_restore_gfx_kernel_queue(adev, me, pipe, queue, is_kq);
 }
 
 /*
@@ -679,12 +757,14 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 
 static int mes_v12_0_reset_pipe_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				     uint32_t me_id, uint32_t pipe_id,
-				     uint32_t queue_id, uint32_t vmid)
+				     uint32_t queue_id, uint32_t vmid,
+				     bool is_kq)
 {
 	struct amdgpu_device *adev = mes->adev;
 
 	if (queue_type == AMDGPU_RING_TYPE_GFX)
-		return mes_v12_0_reset_gfx_pipe_mmio(adev, me_id, pipe_id, queue_id);
+		return mes_v12_0_reset_gfx_pipe_mmio(adev, me_id, pipe_id, queue_id,
+						     is_kq);
 	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
 		return mes_v12_0_reset_compute_pipe_mmio(adev, me_id, pipe_id, queue_id);
 	else
@@ -1106,7 +1186,8 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 		if (r)
 			return mes_v12_0_reset_pipe_mmio(mes, input->queue_type,
 							 input->me_id, input->pipe_id,
-							 input->queue_id, input->vmid);
+							 input->queue_id, input->vmid,
+							 input->is_kq);
 		return 0;
 	}
 
-- 
2.49.0

