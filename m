Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8E606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WiqPDW3o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC561123C5;
	Thu, 22 Oct 2026 08:20:39 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846221123C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmQh61qrXlPHGSUj5BidTxaYZ2saGSDhpUHVjPWKCDBPGdiBGpqMCrvE8bbwXb/pl5HMVHF6Ljhz0fAj9380qWMcRSqhMoASO1KOX/aQzHAG0q65ndSGhKKrYp4xa/J7J/aChLOXD3TDOeHmFzfSLf22wcm30ULwWitGy3EXDwY6yxq9vGBfqOSQTS4bKYs3wRpbHNSSB4rZNVBgAcFvgott+MExscFHSIE7oEgiVZhkf7BsHKkYUxDbRl3aMfdD11SMKM7OVvRS24HYFizJ8ahWn5cql5f3ye60oU5KJR+YHd/fuQhnGwI8jhYyGRmSIjwBL1iH9f9vJ6Df/j92lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osPdT9nEDWStt45BIk4NCtc0Ydiap1dYXlxNVD8JRWc=;
 b=S6XYk4/DjG3CgW/FSHnbZQ9Yd9vqdkUOfHHmvpgixjmAIpMvilido0dHe1CSeVsZi+i4DN1qyKRrs6NsSABTCY/2X+/Ym9j6HB3+mwGJowEk8larPctAcHn8QFz7jgLTbNMiR41wQ/kXUGWDuzXgiinCRxc30AJ9APHzd+RTF+BuRJqLc9l8istwHGYHBq3U1Mf0uqwzx4st9MgHTWiu0Hg6NSooiKlWcaxmzjMGNfZ0CVrtunUzqDllnhJ00DrOA2p3J7LxENDS0M4Tr+MIpN4PGc9ePPQSa4NzGUom8+L56P+r8eYG4F80LvcVVAOkypHtcC5tyXwZ7hwXK3jmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osPdT9nEDWStt45BIk4NCtc0Ydiap1dYXlxNVD8JRWc=;
 b=WiqPDW3of2PLxCRn8eT2h0LvHFdkm6YdPvvQnBETNUD3f7jYx7cMawkTOj8VdLC0B08HrGAmjlSygbLnrmYBuQ47gLDf2gILwJCSENWzDampK2DsYX89FnKSKUEJ5DlkDN/69i+zawRmQhjrFkFlC/YEiZeABxQnV2zbcxvdL5Y=
Received: from CH2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:5a::12)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:20:29 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::9e) by CH2PR08CA0002.outlook.office365.com
 (2603:10b6:610:5a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:28 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:26 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 05/15] drm/amdgpu/gfx12: read and restore the ring state of
 a gfx queue
Date: Thu, 22 Oct 2026 16:19:45 +0800
Message-ID: <20261022082011.331462-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca531f3-0076-42c8-625c-08df301554f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|261021121427099003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: y7WXFATdvntTaypy5qIBw3pcjQlZ3C1wYrL2RTLAHUdWhjj8Do24e5XM0k0W7vpZAbqqoojXafcoQCDMRAqewnjFmJh017FAIDChsgEuf+2l/CqTUr6DxYq7AOSlEmR4JT4GD/rKJCyppt4PV0kLxhFUNyl/b4dpd4T7enlKmKQ63uTyhKBfNxehTL9u4Qa8wUL6pBFlsvhHU3uQ4cnHNNz3e3ysjJH2ekY+nLiCIVWGxXZZgW5ZHqPUbKdboGAdLOaidduzmcu9wbysuEwyshsfNjuoZ0Lbno9NN61rNdS2MWJUvKtmcQ3QI+2096YJb8yO0WQ0xA9YSAxgzPeMDPYFRnOG2HTfEkApbdHuQmcB6HpRv9PzsRLoZSRxh2lS8G48Tq5RAWXOW0k/JJ6LPlkSR9DgaZswZpOv2sBBTKjXqhhWExDRBIyz1M0GsIOwziMLmIo+txmbqPT6nQ/ciDnc/U7712ue65AZdAc48S2OnooL1nJbeOArkm2CjEG+3AYmtKPXCBZatoNfK2MXwl6f1MG10nsO8YGVEVo5CVn8NOmWGcG3rPUC3GXUnSmQbMAdtuY4Y0mAWjvDvO8uCCHXb0/StN+ZR+EsxAFxNbGyG/MbjJvEojHU5ohKCYeB5PoYDnI3cntrjyScUtWN55YySk8h1Je2vBXro3nuM7lG7QJpuiOXJH3UAUqK+sKC9pHqqBZTXIrietmBOLpyYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(261021121427099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jQUJYwELgRAvb0wz1DHHY7qBg8hxiWVpOmt9tkppIFi4mP6lxwi40OYpKNCh4dqZvyaKkUI4MT1lKUVLuydvNRtNQvdPvTxwjbgtKVpe/W/ldnq5eEEAJZ8/H5fT+blLUta0ElYUiXU1C8G4IITd9JbrOC0uYQ4P8YDIxb4/y5EJMtSq+z2N//+z2NjBc2k0Lt+o1CUEVZXnXjbccnZixZw6Ub+LcqaSHsO2rnRiSdVVx4ElXKXCJpUsbRco8J2qXBpxrMNy5f6ViFos+MWXXG/orLwSvJiyu6+66C3NyOWzO3J2TJcUc/+eOCr7kC+iiSk7zeXaz8FCdRP45Wn2yv1B2CFIPg4K712wa3CAhW0xBI7dCm75w9XcxR7eu/6OxPzF3Clyoks1/y1Qixs/hI4XoFiWX9hQsvQmLyl+GMa1ospZZieo4jA2e1yYEqTG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:28.7550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca531f3-0076-42c8-625c-08df301554f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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
queue for gfx12:
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 85 ++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index dfc409e28914..b5f03f9a4ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -276,6 +276,12 @@ static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
 				  enum amdgpu_gfx_engine engine);
+static bool gfx_v12_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					struct amdgpu_gfx_hqd_ptrs *ptrs);
+static bool gfx_v12_0_restore_gfx_mqd_ring(struct amdgpu_device *adev, void *m,
+					   u32 ring_size,
+					   struct amdgpu_gfx_hqd_ptrs *ptrs);
 static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
@@ -962,6 +968,8 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 	.reset_engine = &gfx_v12_0_reset_engine,
+	.read_gfx_hqd_ptrs = &gfx_v12_0_read_gfx_hqd_ptrs,
+	.restore_gfx_mqd_ring = &gfx_v12_0_restore_gfx_mqd_ring,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
@@ -3973,6 +3981,83 @@ static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
 	return r;
 }
 
+#define GFX12_HPD_QUEUE_STATE_CONNECTED_MIN	3
+#define GFX12_HPD_QUEUE_STATE_CONNECTED_MAX	15
+
+static bool gfx_v12_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					struct amdgpu_gfx_hqd_ptrs *ptrs)
+{
+	u32 me, pipe, queue, status, state;
+
+	memset(ptrs, 0, sizeof(*ptrs));
+	ptrs->doorbell_index = doorbell_index;
+	if (!gfx_v12_0_detect_hung_queue(adev, doorbell_index, &me, &pipe, &queue))
+		return true;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, me, pipe, queue, 0);
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
+		state >= GFX12_HPD_QUEUE_STATE_CONNECTED_MIN &&
+		state <= GFX12_HPD_QUEUE_STATE_CONNECTED_MAX &&
+		REG_GET_FIELD(status, CP_GFX_HPD_STATUS0, MAPPED_QUEUE) == queue;
+out:
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	return true;
+}
+
+static bool gfx_v12_0_restore_gfx_mqd_ring(struct amdgpu_device *adev, void *m,
+					   u32 ring_size,
+					   struct amdgpu_gfx_hqd_ptrs *ptrs)
+{
+	struct v12_gfx_mqd *mqd = m;
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
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock = 0;
-- 
2.50.1

