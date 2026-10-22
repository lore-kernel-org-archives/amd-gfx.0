Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92F606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=axfNtCw8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C6C1123E4;
	Thu, 22 Oct 2026 08:21:01 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479F81123DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qle6jUutkif9J8j4V5kK219pv7r/1QNrh9yZJ2i0wM2DIT2pc38cXrOBILrslcq6d/31H7TbzNLA3UphFUvmuihmpfscyrL4pqNQ+R1u6AmTUUmQ9+FxPjEqgjih/jPX7okvN7HIenGdjuEIudqQLtKYfHTVhsRJo/1JyPQSyy3XYrcmrOzkH34KvHVkj7TlA2YjoZmC8hAZ71vK7LHKCZnsxilT04IjhHbOcRXkhnuUm1jm3RlM/G+RtN4+kim4y3QzUhdxQeVegT3wmZ5wLF3eo9XaPFcB+KeiwAYSZtqIJk80FFxAn5RayhDYNN6tphevg7DhW7QONUUPTfB3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAPYES4qTCX0PG9ApHQBA81SWokJAOlKKWL+vyKOfdQ=;
 b=Ud4Izsmo4kDrDfPaP/uAdHOF3rpCRQu8RLo+bPJst8tOiNuM61psX7+Jn2dZgXeg9CDG/+jqQ8YjJ2XZMN/nztq+m+ZJipwPsIoQLOuM8WSZW0Zm28YUIAPOtU3JZ0R5dlnHWgDaKkEvQ0nIrfjXVSjzq4SVBGh29VwxIm9BOnDeQmO5Q2vwRx1lCwtBZ6oBsOiuQ4UbNY7TRtFufIPBaQA3NdS0DSA8gVilzs88CGDEue+ituSbqfWIcjxbvEwfEgwlGbSB9rGOLjI493jpm08gaZfiUDPiCWiOO0FmTdE6U76UGCSD4kUK+HlQYioS8VDM90MbdU6b4486CV+1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAPYES4qTCX0PG9ApHQBA81SWokJAOlKKWL+vyKOfdQ=;
 b=axfNtCw8F0UEBAF7q5JJXxOh8yG5I+RPv+0Hs61MX511vfurN/gvaPfYgnnzTlXjxAFSG4+M1F2loUPJ+k/6OUtqG6qa6be4/VKnojV6aTjMZyTufWLwIRLACIhAcYp28uyttruULLrAhYucqr8xEKCL+wRBnmZ9xbi4cLFKHYQ=
Received: from CH0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:610:e6::21)
 by IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:20:52 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::66) by CH0PR03CA0286.outlook.office365.com
 (2603:10b6:610:e6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:30 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:28 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 06/15] drm/amdgpu/gfx11: read and restore the ring state of
 a gfx queue
Date: Thu, 22 Oct 2026 16:19:46 +0800
Message-ID: <20261022082011.331462-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a82cfb-4ea2-4936-64d0-08df3015627f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|6133799003|18002099003|10067099003|22082099003|261021121427099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: cAKemc2vPjR2d9cAQRBdiezFw/uKWALTGM4vq5ER0HqkIwt2CqV0Os0LKJuX7AIe93UFFZ2S590XtvLzHbful4ll8lrHGOaWOJnwm5RzqRBk9cZjIda+fWrykYFaruCSaO371fVBDUOh2Jc/KzbucfSwmt0jakbPBaWdLz0XNYY+PtaE4Tj/e1eBIz9xHmrdXdDIqZW6aBKND4tOpB8hGdFDnTDw5i4GN3ENUgf5tlf1HBwibKHHCeIh3t/tILE/Uvc2nthCV0eUEwbCKtnk0zy6m6Y8U3TDHnBj6+ow5ta2XAaS5w1kmv0HqY+xiPdtbvd0jCT/M2hp++h23q/ARlykSfD5NCwwFJP+Ts8N7zJZDL/GytJCRrLy77ED9+lyJbg0PU7N/4ehEsQaVeeVlXzfoHtgduFECwu19oo2fmGayukLAnvwyd0ozzcIFwVE3FfWSxmKzqWkTx/nGTmypjZJO4PBwKMHVcGXsPt+zV73thiy15PjTgSDPnQvdXdR8Pwx5r49D9HgsyPRe/cHwU9roTPYekxeOWu8fmS2NKZPL73VQHSwY2VUmRktcD/YiYCtrrZrsCeUozg++JHVrosMwevFGdqI4hS0CQK02ktasy4wtrAxomzrzX9yV5diDFgoGk7DOWtWncQ7Td+bGFs2tYJE1Lm9zQgKqGXdYYLIUzh36obI3xv/3gKwTi+k28c8KwAH+8Tmy4j28Dtcag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(261021121427099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lz/rAR9y3YsAWucYFsTeFqDC2IJJyRxsBTB0XEGrPqIbOneRtn3EwkOClS7ZKg7ky3Jpyq2vkQtA3Vh6XEiHw83kAomM+2QqOw+Kh2Pldifs1w5AbXnZrmwC5+3HvVuzFR6wp3gifTfdc5KkPkJR381FY/bhNssM6IXjhKwgpf/uHQrvWyy853agxNAFnKsfNjLHb0UhXYhDw6qDwzgLOoVL+cASvd1uDgqTdNaqHnX3jAApjXA5nhXd0E9witevajM6pYIlwEATHPmiIuOPj3tow/EdY6MaoGHxeHnHvUql7/blW33sen66fy9FHvq0V4pUe1witGl6fPuYyt/CNV5q0YKZkD6lpze+sArzxXebtCYjtPMPdzbtEqf2A87RQnvsbd1OR8v5U3HtLIbi7zRAl34ZzMjOhme+Aof2N1IHRxVn+c+0D+t4HaRnHQEu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:51.4463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a82cfb-4ea2-4936-64d0-08df3015627f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the gfx callbacks to read and restore the ring state of a gfx
queue for gfx11:
- read_gfx_hqd_ptrs() reads the HQD offset, CSMD read pointer and write
  pointer of the gfx HQD of a doorbell, and whether the queue is the one
  connected to its pipe;
- restore_gfx_mqd_ring() puts them in the MQD after a reset, for MES to
  map the queue again where it was. A queue switched out of the pipe
  resumes from the preemption status the PFP saved in its MQD, also in
  the middle of an IB. The queue the pipe was executing has its state in
  the PFP, which the reset cleared: it restarts after the work submitted
  so far instead, and that work is dropped.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 85 ++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 12b307e4106b..a2eaf416b12a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -365,6 +365,12 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
 static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
 				  enum amdgpu_gfx_engine engine);
+static bool gfx_v11_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					struct amdgpu_gfx_hqd_ptrs *ptrs);
+static bool gfx_v11_0_restore_gfx_mqd_ring(struct amdgpu_device *adev, void *m,
+					   u32 ring_size,
+					   struct amdgpu_gfx_hqd_ptrs *ptrs);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 
@@ -1153,6 +1159,8 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 	.detect_hung_queue = &gfx_v11_0_detect_hung_queue,
 	.reset_engine = &gfx_v11_0_reset_engine,
+	.read_gfx_hqd_ptrs = &gfx_v11_0_read_gfx_hqd_ptrs,
+	.restore_gfx_mqd_ring = &gfx_v11_0_restore_gfx_mqd_ring,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
@@ -7092,6 +7100,83 @@ static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
 	return r;
 }
 
+#define GFX11_HPD_QUEUE_STATE_CONNECTED_MIN	3
+#define GFX11_HPD_QUEUE_STATE_CONNECTED_MAX	15
+
+static bool gfx_v11_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					struct amdgpu_gfx_hqd_ptrs *ptrs)
+{
+	u32 me, pipe, queue, status, state;
+
+	memset(ptrs, 0, sizeof(*ptrs));
+	ptrs->doorbell_index = doorbell_index;
+	if (!gfx_v11_0_detect_hung_queue(adev, doorbell_index, &me, &pipe, &queue))
+		return true;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, me, pipe, queue, 0);
+	ptrs->on_hqd = RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) &
+		       CP_GFX_HQD_ACTIVE__ACTIVE_MASK;
+	if (!ptrs->on_hqd)
+		goto out;
+	ptrs->mqd_addr = RREG32_SOC15(GC, 0, regCP_GFX_MQD_BASE_ADDR) |
+			 (u64)RREG32_SOC15(GC, 0, regCP_GFX_MQD_BASE_ADDR_HI) << 32;
+	ptrs->offset = RREG32_SOC15(GC, 0, regCP_GFX_HQD_OFFSET);
+	ptrs->csmd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CSMD_RPTR);
+	ptrs->wptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR) |
+		     (u64)RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR_HI) << 32;
+	status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+	state = REG_GET_FIELD(status, CP_GFX_HPD_STATUS0, QUEUE_STATE);
+	ptrs->connected =
+		state >= GFX11_HPD_QUEUE_STATE_CONNECTED_MIN &&
+		state <= GFX11_HPD_QUEUE_STATE_CONNECTED_MAX &&
+		REG_GET_FIELD(status, CP_GFX_HPD_STATUS0, MAPPED_QUEUE) == queue;
+out:
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	return true;
+}
+
+static bool gfx_v11_0_restore_gfx_mqd_ring(struct amdgpu_device *adev, void *m,
+					   u32 ring_size,
+					   struct amdgpu_gfx_hqd_ptrs *ptrs)
+{
+	struct v11_gfx_mqd *mqd = m;
+	u32 wptr = lower_32_bits(ptrs->wptr) & ((ring_size >> 2) - 1);
+	u32 *status;
+
+	/*
+	 * MQD dwords 32-41 (reserved_32..41) are the PFP preemption status,
+	 * mcbp_status_pfp: the offset and chained IB size and address of IB1
+	 * (32-35) and IB2 (36-39), rb_preempt (40: preempted in the ring) and
+	 * completion_status (41: 0 IB not started, 1 preempted inside an IB,
+	 * 2 IB completed, 3 IB resumed). The PFP saves it when the queue is
+	 * switched out of the pipe and resumes from it when the queue runs
+	 * again, at the HQD offset. That survives the reset for a queue that
+	 * was switched out. The queue the pipe executed has its state in the
+	 * PFP, which the reset cleared: restart it at the write pointer with
+	 * no IB to resume, and drop its work in flight.
+	 */
+	if (ptrs->connected) {
+		mqd->cp_gfx_hqd_offset = wptr;
+		mqd->cp_gfx_hqd_csmd_rptr = wptr;
+		for (status = &mqd->reserved_32; status <= &mqd->reserved_41; status++)
+			*status = 0;
+	} else {
+		mqd->cp_gfx_hqd_offset = ptrs->offset;
+		mqd->cp_gfx_hqd_csmd_rptr = ptrs->csmd_rptr;
+	}
+	mqd->cp_gfx_hqd_wptr = lower_32_bits(ptrs->wptr);
+	mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(ptrs->wptr);
+	mqd->cp_gfx_hqd_active = 0;
+
+	return ptrs->connected;
+}
+
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
-- 
2.50.1

