Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E64606A324
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qoY43qBI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0C710FA95;
	Wed, 28 Oct 2026 08:58:10 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6791110FA81
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2lbXRR78m3SB4Xi9Z/PuaCQYkmV3aWwhUWpmoJF5mBltfx+Utc9fnjf+BwyWmm40QW4t05rBsljkLF3RBxMnzAv8xSC9RMAPMwp831RmcIuZ5rDnwW3OJGaRJhGrzPv+RQp6v5L5A6Z9iNBYv7KR5CslhsYxa/BFS8GtJgSzfGAuZYmL144DMK0u+JZJlQwjfdkQypp5LsBk4gcWRJgzWYCcCahRkgcCY2dTzBh5Ay703YQ8qSSkQIhMTAO/FoOsTxNPTQVhKSmsOEvP4ya+S9eHfahfgA17lV13NI6g3cGu84/KNonDe4pElnl++zTlN7zFAaU8cIEihmpcYeyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgH52MqVlLtWdpdWL/K5UE1RKVGZbFnnODOF9lRYOlY=;
 b=COuTG4dsH7lRUB9R+zF5CCI7cPAbAQTgj9trGP1krHjdr+uuPy/V1/DFXgO1DjiHIO3ePQiF0ZfcDCteU3tnliB/qJ5MTpkeLyuE6dWlQpwvkJrAs0QKzAHT0HsfSqAZEHK+pbeFmlyWXYfFt4zkwJu3GRM/5g5NrS/xqz16BFUWlqw9z/sglIWqKY/fUg4BnBmxdEuNdqtPf3FzR9tEq6iX5PJNf6HVqtqEsrb/P3YsGS3VmhKi/E/ic8UnM6/xE5TqVi6oAokzCf9sbx6Q5azwDL2ffzM91Xa7DtJyejE10naOb3p6sI/vMV42Fxnl0XJEsJBxoeuV3a0Eb8tHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgH52MqVlLtWdpdWL/K5UE1RKVGZbFnnODOF9lRYOlY=;
 b=qoY43qBIdB9F4hK+l9DNIAOYu0llhbQWnaqMUQ1HWZZxSRJC1ASFYoAgU1N6XXBihn+U9E6U4jHjIywdrPq4Hr9oChhI6TdYxZItZSAQHrOIPEDdGGB6HK10i8Mr8hl9e1DxKd7eRS8gkf+xrHyEMl9XS9gu3Kw6d6pJ+GN7rUo=
Received: from BY5PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:1e0::34)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:58:00 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::1e) by BY5PR03CA0024.outlook.office365.com
 (2603:10b6:a03:1e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Wed,
 28 Oct 2026 08:58:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:58:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:57:57 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 09/15] drm/amdgpu/gfx11: read and restore the ring state of
 a gfx queue
Date: Wed, 28 Oct 2026 16:56:40 +0800
Message-ID: <20261028085736.3808569-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d76814-6df0-4e1b-085e-08df34d191a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261026140227099003|261022105027099003|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|18002099003|6133799003|22082099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Xxl3RM8/HOn0mEDr5rQv0rkVrpQfWl7PzBcMkLtzCzlcKDXaSGA4xuVW6Kj9L+n6cfu0kwp2HoQSBBqm3dPgU5QYQiyT5d1T+VugwCtiEn+zX5blvJR8eBncezbvrly7PzC1F9IMVZL8QAhJ3yRnbp3op8Z5QXWbmjC7r5lsrUyilpn4SpaSSvkmodIjtxjr7BPF6I6RlI30iHSrKdzr62tS+s7Ov0WPLpP1avpMoO+RjtxW2QHXYGNDexg0Os3d1vhBNuZjst2V1etk3zd5O1RBysDjoK2iJ6l3usF2OyWvGm+XIh4SyhQT7L98wBMpGKzZ2PNLCQ6nFvK1ojYhDXYQzgX2XlnYkBzZQ7Tpm4xubjUyggVs0hDnt3PZD9FienG9rE2+/+RIap3mlTo1MtWL8JjtxYOoQkZOsbZJQuIpWi+FNgl6EV+2IFMq8LBdAXYGyaGpH+0HczBzRN5deD/mixDt11y0qLaImz2WFfZ4SH1G3+64D0L2NeG7HihcQxZORU+XN790zxzKAOEs8mtYL1nX1HNueRdsL8THYbQZaigmS3ZEqSd8qmOWh9N8X+iklhsPm2Bm28k6a80HVT3Ij9gPVM1Gza5lXJxpsS7IMdq0gpPxAo0V7WoqGyXMip23G1x+69jDL9lrGivy7Mz61UNL8bncCvP82OSP/XzEiw3t0oke+MX1OW3G/2pYRrzae6Xk6hxHeQ0ZXE6eTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261026140227099003)(261022105027099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(6133799003)(22082099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k/kuumw4U/BPW3Xiuhm32kapIDUEsNnIC+yVAwsWlALJZe5zgI3bmw1YMvOQwz5orfMNN4M+wORQpSPmkjgrChPVP00fbjcu7DjifhmZsfPace/NhXuLOJ9txDLnL4PfhLBXQwPCJUXDle6SOCih1rJ5tdjsRrormx3x1mm1J5LVQZbcVXwZrdQ7hdcAsYiSGkXWp88F7d8XuuXEwGgMzzC8v6pmugcXEdMq/SJF2YCqQkTq/uNJFBtkZvypQq/51ZJuYHc50zs8Ba0AhMGrYAgdgys34urtxSuX4VyVCT+eqL9yj6T+yRzJMPZHb+4UlASKQX0S1IwpEm/d+yOtpGIFWQwkPdRXdaeYLUU7i7dDIewdOrm8vYI6k+jRfsGnTvQxTU76CBJgXxpFiwL9HSVOgIh1I2A5/wpVabg8XIUU1alek/HydF6bcDOb4OdS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:58:00.4677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d76814-6df0-4e1b-085e-08df34d191a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
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
index e533a5939d02..a71dae5d0d3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -365,6 +365,12 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
 static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
 				  enum amd_ip_engine engine);
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

