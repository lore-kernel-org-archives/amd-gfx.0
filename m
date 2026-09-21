Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02088C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F8110E574;
	Mon, 21 Sep 2026 07:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2wkVf2pi";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C01310E597
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzNrUxMJhbO+aoFUrUTkIxK7J5HXkKDg1cqm6Vpte6nOK9i6Q6A9gX+ojK6BdTFktqJHYA0B+zL8lqmxlaVX3VqhlNNZXSP94xaFvOtO5QVbDqkFgNDKwTuwb2gRvDwzb//mPMMVtYFY7vDwSwhYYZq0OttQRY0W4ksAkSnNB7ehJBKnFwPVB6VV+QORYbiYjRhpKE/u2X1k9NouAc4xSdsarLw4vP6J51/ARSe/jhAa3x4HTgjYZc1/IWPoN5Mg1KIEHTrSkUNYe+mIkfX+/7C7LIsBHOVx/734GmVf4so05614EW1Li0TdXN9NJWN1inwyYUfAm+mkJB6oPtZvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdrAOuT9yuAkDeQ7MwlC4cN5C+zoCorzJQVyxsTpwUc=;
 b=SjIQDu+qlVzAxzpQ0NCaaGbpOamfqtbZ/H93Pfu7jqTECEPWl69tJjd0AfmTAzbYsVvuBCFfX1oiQfJ6IKk6mT0TeiPjF0zrVWLQoeBOkCVvSZQtrTE+o/P15vJRGfwc9V5V1unYC9ZRmamm7VrNNG1MwuJthap+uqnI9riiXK/5R2fUAcNsHqfaz7H/ks8Fw1J+fYdYXzj4sSdIXQe/VkUoiPrhuAtI+k/gjhry4ffxQdnz5WsQUlyJYE2cIo2GkH37nv3l9yWe/4ziID2/SBBqn5WgEasaRhDXx2qwvTdWU/XvYxWeoxF13PbiFH80POYQHUmPsgwUvZX7ekVs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdrAOuT9yuAkDeQ7MwlC4cN5C+zoCorzJQVyxsTpwUc=;
 b=2wkVf2pi99QRISI0LzJoFbQc64W/FfcGJNoHFpiEXQP27Cv5/uu7AHpWbMVMoxIM56+oa0IEiflgZDLG2r8ZD8sL6crcmOAK6ucVn2Jbv4NQVx1hluRbfDIVglEQbFfDqueDhqVq0By3unVMt/mVbJytNzNJ1fGbpDr3vB4XAKk=
Received: from BL1PR13CA0176.namprd13.prod.outlook.com (2603:10b6:208:2bd::31)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Mon, 21 Sep
 2026 07:53:42 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::af) by BL1PR13CA0176.outlook.office365.com
 (2603:10b6:208:2bd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Mon, 21
 Sep 2026 07:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:38 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 06/21] drm/amdgpu/mes11: restore collateral gfx queues after
 pipe reset
Date: Mon, 21 Sep 2026 15:51:13 +0800
Message-ID: <20260921075326.2409021-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: a6769005-fae5-4b2a-a42a-08df17b57409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Y9os3Tv4MsSDiDxWRX/riov4ZoBhP42kXj7q9kcd8C13r1kuq+n0CC8q1bBefDzfe4ufSOOScy6rbVESZ2B09WntjrwTXREszZHBxSn+3oyT/xsjpgvlYkUM/+g2BVro+j3JI+Ct3M1Z06Z45/LGGSGUQdnx5yuBCrei7AzUyGa0VJVjxh5TcbjdUsq48Xd1HIlrysm45YArqYlAo7Or6uEqMADpbws5tD6VimVAF5NB5mLMnr0RSWcQrwpo3L+bo8gSLqS+8pe5na3VaOkq+wWBwKxV6WW7kLAXmbZ8tAI3eM00VOBgECPKV5Gnze1qXpolWh75l4oq36waTUAqbtDjJ06jSTredlyPJ9Qd1GIti/ZBctj0/hlMyPqhkMfqXrGONODPWLgvedoy5NJnjqqAVJPPickydw+/Lj/zwGuJts89tpiCXeaeDV0olUwiG5f4+ls+MEbIgLW1t18x4MTUcA1IMEv5DSrReUt+ehHyGjgmMeHQd0QPP5+KUZu8jSqqD0wI1+TMz5zkhQHLkOnFsScklvKbsugStWbf+jAWOfTkIzuIyqd0lwwaAe9HQFehUAngvkeGOXsFZW6kJdAhHhYr4c/pXsDlbij5euCCBuCpVwwn9w3Cr5j7NFXu2s0SNm7N1xBZ/xTGgPuy2wP67nap9KpMvcnblAWLIMAVZgSxIn7xi66nhQKyeRJ5x48C/UlgrvMRPMclJBWJvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KFPGEwG0Fd3a51VVrw+wiag+lbpkbQNH1XEXv8KI4o1h0GWe4QvF12XyF+9siPWGUqAGB3LTxF3Zghk6p03+Mh6hPaDl9TG7V9A9DW1UvbmFP74ty9z3Ar+07osHMbGY7ubD1PEGSe26baZpPRw1m/xgVHRFJb+H6HrV8Ys7ZI+NC9LoaecaEvpQQJaUHa3jFTNftYX9JaYDSIc8cNdBPovr/wSDzaAAXBZzLHQNmaPCpjs1dJQL284aVnPcNTz8DprRoTal7pt+k3pV+UtGDh2BCZd2VtjWQJQE8keAaYMZU49Gi1A0zc4LP+gxDnXq0oHtUtN3pGBAN9iS3DXDv0Qy+yfoi866wArGh3SHNnWj0tx4oDiQhIRK3jDeu0evO1cMYrzHrgsXSD9ogSF9mDdP5fDg/c+zmxr0LR1l7MDZIepI2nL5ySCGrPIeUl5i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:41.1919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6769005-fae5-4b2a-a42a-08df17b57409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
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
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 137 ++++++++++++++++++++-----
 1 file changed, 110 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c81e4b8616d0..be3941ae337a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -410,19 +410,85 @@ static bool mes_v11_0_pipe_reset_support(struct amdgpu_device *adev)
 	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
 	return false;
 }
+
+/* Use MES callbacks directly while holding the MES lock. */
+static int mes_v11_0_restore_gfx_kernel_queue(struct amdgpu_device *adev,
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
+		soc21_grbm_select(adev, me, pipe, ring->queue, 0);
+		for (j = 0; j < adev->usec_timeout; j++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		soc21_grbm_select(adev, 0, 0, 0, 0);
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
 static int mes_v11_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
-					 u32 me, u32 pipe, u32 queue)
+					 u32 me, u32 pipe, u32 queue,
+					 bool is_kq)
 {
-	uint32_t reset_pipe = 0, clean_pipe = 0;
-	int r;
+	/* gfx11 keeps a setup ring object even when kernel queues are disabled. */
+	bool has_kq = !adev->gfx.disable_kq && adev->gfx.num_gfx_rings >= 1;
+	uint32_t reset_pipe, clean_pipe;
+	int i;
 
 	if (!mes_v11_0_pipe_reset_support(adev))
 		return -EOPNOTSUPP;
-
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, me, pipe, queue, 0);
 
+	reset_pipe = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	clean_pipe = reset_pipe;
+
 	switch (pipe) {
 	case 0:
 		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
@@ -448,21 +514,35 @@ static int mes_v11_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
 		break;
 	}
 
+	/* Preserve ACTIVE/DEQUEUE so warm firmware can complete queue release. */
 	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
+	soc21_grbm_select(adev, me, pipe, queue, 0);
 	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
 
-	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
-						RS64_FW_UC_START_ADDR_LO;
+	/* CP firmware releases only the queue named in CP_VMID_RESET. */
+	soc21_grbm_select(adev, me, pipe, queue, 0);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_VMID_RESET) &
+		      BIT(16 + pipe * 8 + queue)) &&
+		    !(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
-	dev_info(adev->dev, "The gfx pipe reset to the ME firmware start PC: %s\n",
-			r == 0 ? "successfully" : "failed");
-	/* FIXME: Sometimes driver can't cache the ME firmware start PC correctly,
-	 * so the pipe reset status relies on the later gfx ring test result.
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
+	return mes_v11_0_restore_gfx_kernel_queue(adev, me, pipe, queue, is_kq);
 }
 
 /*
@@ -614,20 +694,6 @@ static int mes_v11_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int mes_v11_0_reset_pipe_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
-				     uint32_t me_id, uint32_t pipe_id,
-				     uint32_t queue_id, uint32_t vmid)
-{
-	struct amdgpu_device *adev = mes->adev;
-
-	if (queue_type == AMDGPU_RING_TYPE_GFX)
-		return mes_v11_0_reset_gfx_pipe_mmio(adev, me_id, pipe_id, queue_id);
-	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
-		return mes_v11_0_reset_compute_pipe_mmio(adev, me_id, pipe_id, queue_id);
-	else
-		return -EOPNOTSUPP;
-}
-
 static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				      uint32_t me_id, uint32_t pipe_id,
 				      uint32_t queue_id, uint32_t vmid)
@@ -722,6 +788,22 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 	return r;
 }
 
+static int mes_v11_0_reset_pipe_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				     uint32_t me_id, uint32_t pipe_id,
+				     uint32_t queue_id, uint32_t vmid,
+				     bool is_kq)
+{
+	struct amdgpu_device *adev = mes->adev;
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX)
+		return mes_v11_0_reset_gfx_pipe_mmio(adev, me_id, pipe_id,
+						  queue_id, is_kq);
+	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
+		return mes_v11_0_reset_compute_pipe_mmio(adev, me_id, pipe_id, queue_id);
+	else
+		return -EOPNOTSUPP;
+}
+
 static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
@@ -1084,7 +1166,8 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 		if (r)
 			return mes_v11_0_reset_pipe_mmio(mes, input->queue_type,
 							 input->me_id, input->pipe_id,
-							 input->queue_id, input->vmid);
+							 input->queue_id, input->vmid,
+							 input->is_kq);
 		return 0;
 	}
 
-- 
2.49.0

