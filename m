Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB7C3ABDD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 18:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18D210E457;
	Mon, 19 May 2025 18:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4l3mHoO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4504310E441
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 18:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2U2LXRdljywzQ3Swo9FQuDUhFRgHVYZfZw5oWXSlIOxgCAwkPG4q+LDxG/tUXhgQE8YPohjVVdrPPNBr1dRnonnDuvWfmoTA/dW4ZSw0bUAZKAz4WGlRQwcR4IxBb4A5Efzx07TDkhviPkZddX7Z7/YShgqF7jDwPUynP60h4EkSOlK8w+5I95Wkt/Dc/ZcoaSFR/oGDA/UuwkYBI4pA6DL6I7pnvWaDz3mzU8NiklFIKvu5u89/IUSOoTwVuflV23CmXvxhbHKR7W905CP62MbvsW658b6RcDLSt4Kl/GyRQgJLMsUDQO8INcEpJUNWfVAcYuYGzjbIdk7HN+mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M50TuH7SEzQIWCUBwXqQmRhmvyASn9U5VhgPTgRp6O8=;
 b=my34FxCWBuBXXNjXYKxJWX3AZqpeBarW59qBa1rAiApSooNVAIQub40s+YeCb74rrzGc+nlNNBSnUin2nLEU1mrLDCjOe/5hD53dqlaSGG2VXLV5QV1lurnlVgWnG3/vQtCAEoLLEdmwNYffqFDrXCqp3jVjhdJiBM4XRvWkkrtYkXZSSEwJ7A3EiQD+Z6mM/h+dScv3LWXQ4Sh03OxiarscD00NnG/1tkf6eoBtw9OeaazwVXKFZl8kpCiDpa8+Z71zf2yVGiDVfR169sKf9A1+ke8YkSUFFCA6bgKnoneTNs0R+b3lwDIWFBlTheo8N1rGbzbut7UU0etD5EChRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M50TuH7SEzQIWCUBwXqQmRhmvyASn9U5VhgPTgRp6O8=;
 b=C4l3mHoO4xrwP3LquNqCy4mF1fAstF7Qz9apLPXyNZ+e75odue06MWApj6GYcRabUizqe/me0SO6299EKyFr1zdnXXSKU4KBPvWXlFUc8kXrx3D4DKYxmXhSu5S9ojOir1fdFfpk+FMjOd01uZD8f84Ms7pQ9bFkcew9M2mVADE=
Received: from MW4PR03CA0319.namprd03.prod.outlook.com (2603:10b6:303:dd::24)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 18:22:30 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::37) by MW4PR03CA0319.outlook.office365.com
 (2603:10b6:303:dd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Mon,
 19 May 2025 18:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 18:22:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 13:22:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: rework gfx11 queue reset
Date: Mon, 19 May 2025 14:22:08 -0400
Message-ID: <20250519182209.18273-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519182209.18273-1-alexander.deucher@amd.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b046af-693a-4a81-467b-08dd97021e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9h7K6beMqeXL/Vxz34pZcoF6ynk4Jn112joHYVk9VjgAAvggTSTc5TknO9KD?=
 =?us-ascii?Q?kFwXNjfxjIyUQik604lbHhGO2+jLOj5JiIRaZ6rINnJQIBCspkY/Wdrs8hno?=
 =?us-ascii?Q?cTKFLmoRx2FEZ1iZNZaCWMUYJ/nTQh/zE90vLv41FBytw3b6xfvpDYJermih?=
 =?us-ascii?Q?6FGmFPmEDnG3dWoMa7+yTkC5XMbUpKJmt/XlwYN/+mjDHdSBad+EKGXo7+Rp?=
 =?us-ascii?Q?Ux6OzPqF3aKrSHYkGS5t0ZZlNPVY9NiBcP+C/6BbBAltPH1011FjX4YggMSX?=
 =?us-ascii?Q?3j1skfJcX8QLZEECBmcL7is3q3scBTlRsmQt09JtnA8ELQkPXbNbciWkdd4M?=
 =?us-ascii?Q?uYn6naFym4e6j4MT4LneDuaqqGwKqnFKrBvRESPOwhw5IztMi4KuiRezPPtc?=
 =?us-ascii?Q?gG7d9qrD4RnKGdvV+OmcUCilLBTbqDm9/5YEtpYgnPB1LPL3QxefWf07rp4+?=
 =?us-ascii?Q?CnQq2Q9qBYsHLyS48/d5Lveg659J6wJwjFj2A1n+Wl/b3yQ6tggMFZDVKiDz?=
 =?us-ascii?Q?sSa27gItCh7B606BYGSsVCVPL8Hq2pZ14WcnBfDbEZKbzdiE3E9ZrQR1rbAZ?=
 =?us-ascii?Q?0HJdTnBu704s+/O11w98zqcPTd2Ojyw23D3T2nCb6mDl1KPIAw9W8mO2AhRr?=
 =?us-ascii?Q?xuvJlVdwtTf2wBZutBfgMUZmfp2DEIvwoS+39PDsNM6kwgZ5Ak+DGbwf+7ef?=
 =?us-ascii?Q?UQ9mWeVb7PR98LPeqSxC6yJxy+96IqfRNabCSIyreLN53qS0qrk0xXHUKXlj?=
 =?us-ascii?Q?RNLrEVEnAK/0lW9nHhYinYCSjdWmKUNopg1ulj7Q7lRbEx+DXwlqO2bg9Jhm?=
 =?us-ascii?Q?Q5MV8yDno0xJPp+hw36N/fvL50PeraZeW1/XadsJxPNosfUkz+KZOp/aRXuH?=
 =?us-ascii?Q?xtwm390qdrW7FFtlIKZLuZxXUh8Qxnp6qXm5eoA6ddt6KWyqjo0jPRJwyZoQ?=
 =?us-ascii?Q?JXLgrptpVq+IBYdCXjAAhzRbuUHgOrLnTSCJJD+dNYW+5cg31P55lwm0oci4?=
 =?us-ascii?Q?am9iGoM6nXE2muK/kbDMtBDRXwWRROaY7SpkbMure4rdjt5TSIgBegUnydBN?=
 =?us-ascii?Q?KK3mGQ9LZSLZ2mSvIriv9Klvabk5q5PpRZPj8nWNbnoe46WlvIdolfUZTjaa?=
 =?us-ascii?Q?JAoIo1j3ze6WZDb6HcRNxkJK/JrMHkLzgh8fVp0vBW50UbBIl1xKERPDCoEG?=
 =?us-ascii?Q?7NBRJ/OhQ0L/z9AMpmcva5gqvPVFsHZJz8iIQlGj8rhxlEBXYQpVI6RvYMiD?=
 =?us-ascii?Q?q7VvL/kKXc995XrLmthBbsfZVWdkYVtF+Xsas79OJPg0eNlesxVird6DXJkC?=
 =?us-ascii?Q?GR2/BmbcYYYkwQQZd/J2GY6hLyxZhHQ0uF/5fSvsDJGot1aYjGho+5wjm6iD?=
 =?us-ascii?Q?R0Q6/vrW9aPK9j29ElO+kLm81nxJ6hSU18F0N+QB0zSEHHri4nP6PKYtk4+z?=
 =?us-ascii?Q?Id4HE70MqeHmY1rsozrl0sct6860RNwXgca/EaFIibFjg663j00/nxd+oZPu?=
 =?us-ascii?Q?JfZcA31U9yIiXqQIAQR2hWHxTr7FWG5QVHqb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:22:30.4372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b046af-693a-4a81-467b-08dd97021e05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
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

Apply the same changes to gfx11 as done to gfx10.

Background is that we don't use per application kernel queues for
gfx11 on Linux for performance reasons.

So instead use the gfx10 approach here as well and only reset all
submissions from a specific VMID instead of the whole queue.

v2: fix up pipeline_sync count, only emit vmid reset on gfx (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 116 +++++--------------------
 1 file changed, 22 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index afd6d59164bfa..db69b76d6ab25 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5936,7 +5936,19 @@ static void gfx_v11_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
+	struct amdgpu_device *adev = ring->adev;
 
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		amdgpu_ring_emit_reg_wait(ring,
+					  SOC15_REG_OFFSET(GC, 0, regCP_VMID_RESET),
+					  0, 0xffff);
+		amdgpu_ring_emit_wreg(ring,
+				      SOC15_REG_OFFSET(GC, 0, regCP_VMID_RESET),
+				      0);
+		amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+				       ring->fence_drv.sync_seq,
+				       AMDGPU_FENCE_FLAG_EXEC);
+	}
 	gfx_v11_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
 			       upper_32_bits(addr), seq, 0xffffffff, 4);
 }
@@ -6278,21 +6290,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v11_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -6750,92 +6747,25 @@ static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
 	return false;
 }
 
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
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	u32 tmp;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
-	if (r) {
-
-		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
-		r = gfx_v11_reset_gfx_pipe(ring);
-		if (r)
-			return r;
-	}
-
-	r = gfx_v11_0_kgq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kgq\n");
-		return r;
-	}
-
-	r = amdgpu_mes_map_legacy_queue(adev, ring);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kgq\n");
+	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+	r = amdgpu_mes_wreg(adev, SOC15_REG_OFFSET(GC, 0, regCP_VMID_RESET), tmp);
+	if (r)
 		return r;
-	}
+	if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 8))
+		return -ENOMEM;
+	gfx_v11_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return gfx_v11_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -7196,7 +7126,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 		5 + /* update_spm_vmid */
 		5 + /* COND_EXEC */
 		22 + /* SET_Q_PREEMPTION_MODE */
-		7 + /* PIPELINE_SYNC */
+		7 + 7 + 5 + 8 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		4 + /* VM_FLUSH */
@@ -7231,7 +7161,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7273,7 +7202,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

