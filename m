Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE475C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 20:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7369A10EB11;
	Thu, 18 Jul 2024 20:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEYzzNdC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F5A10EB10
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 20:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdEa1gA3XD1n27KzvgjbTlkljqkScXfrlukZYs8287ogxVX8xHP2P2pNKDvlaUtZ92NnQDmOItEHeqVtlN8C8CSn/jfSp3NwMh3qtD909PBVKJ5di+5OtGn61D/R8vLdbywyfWPI5mKBONmj+Rf9BG7+IZAUSXidvWdOL6ype0nJCs/DX3qBQDOBLHwA1gvEYF39/0TClzJgw1cG41yXU7+3rO+DWdQ9QD75oweJx3qe+VWlRMQh1sy1vfOKeOQcSH7kOoVvUP63rk1xzzvHEUhVu3nrdAVuM+g1jaWtDOYi+26vTuGmPJEGvA1vw9TUZpTG0DTfyTPCiLPR+TjSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF2KSCWwQv0uX6tH7r+y7xcL3M7Qg2LDfIJh4k62qto=;
 b=fEOUmVY26Y9tzpqA+ifL30ciBzRMbPtjz7VFwNg+IRKOBzLP0Px5v7E3nt1yXgpRoFjF9vvnpNnNC2U+VVKFZpkiWkoy6nqViIbPjHJxxsVbpzb0oVoB2kGEfs3vIzsEKRQBGk7UGvAda+AVNHTeU0sUT8VOEKqp3iJZXjF4ptFta4KwO+aHm1VzBUtwOtzNWLTT0LyvMrXVY3sSNMbjzE2wWmlymuqvlCy3ObZyGVDZz5wxD+HrfJMmopDh0MmIowHhgos4KOHD9uWU7ALjeVsbFAXhpQgugnvI+h5v4XlPUTNWt+CoGxdgPMSGeHVXxbcDc+mdZ4O6/SNE6AmNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF2KSCWwQv0uX6tH7r+y7xcL3M7Qg2LDfIJh4k62qto=;
 b=AEYzzNdCwROrsr6Sipn3nL+WoGays2Vyt4v1CeFmXcHSklSbd/1NOtCzdfDNzQSkwFd+sVX1MOUoPBeLS6pDJ9YFmANd8HtMNhMK7J5Z99FwWFOHTyff7Jk4hjy+O8MANDDPzJS551WLcHxhGAZKpB1LKsgsnwaFdRZfMItFK4k=
Received: from DS7PR03CA0312.namprd03.prod.outlook.com (2603:10b6:8:2b::21) by
 MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 20:39:37 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::1d) by DS7PR03CA0312.outlook.office365.com
 (2603:10b6:8:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 18 Jul 2024 20:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 20:39:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 15:39:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx8: add ring reset callback for gfx
Date: Thu, 18 Jul 2024 16:39:20 -0400
Message-ID: <20240718203921.50563-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718203921.50563-1-alexander.deucher@amd.com>
References: <20240718203921.50563-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c40dce-7f4f-4042-bc6d-08dca769bda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d+1csNGwmfbYit30w//R6l8sWrFHIOmPIua9GShdmelrchMpa1+AQPNqe+nk?=
 =?us-ascii?Q?51mXzEYJ07YmtI0OCTPnq4DfFGDtqB3a6Sc5d6wwdN+hVvJq2BDWqLHLBLMj?=
 =?us-ascii?Q?XSSTP9PEYhEzv2T7RpXgwqRdMuAkb57mTrntSQqOHy95dtrMuk/Kve0WxhdC?=
 =?us-ascii?Q?LB+f+ULanyLP062q4MY8+UPKT+W+c9Sodzj9h/hFr1Zhm9nWCNmY+Q8AHyOL?=
 =?us-ascii?Q?7mSEYySSwtu7p2hJWHaKFBnsq4oZ/KaYiEQRP7Orrq4llQRM7VoGzEthPgmg?=
 =?us-ascii?Q?Xellw3fPU0gWAqdfTLRdYbHsCvaQseVnYzg1PokvI/QViVR1sNYCGg/YcHka?=
 =?us-ascii?Q?3VShSiDMVoS09ekfAwuNK28oVyjPCVVj8CSlbLZdc8D5R2qQNz+ronoaHuN/?=
 =?us-ascii?Q?eYrBnkazfbLAaUZ5gN5ndq3VXrele+YFfegswfakpOtQkIVUSBd44aCQvaoh?=
 =?us-ascii?Q?QJGuw07U68E1BWqilMNGza68Q6+oHAb714ugHujCwOaZc+f6ZfgtN3qziKbT?=
 =?us-ascii?Q?DTTs6fu3j4WYv1BP6clRtLstVH9X9pVjK3yXyQk8tmAcBp3Ruj6wmPGFO4bl?=
 =?us-ascii?Q?0lPhz20KaLAAvt6qRtcQjB9ibLTTEJufricc5dBEWCugwOBJiUtBk9f0OAEk?=
 =?us-ascii?Q?5uTcbjkHajQuG1osYjWuhk2ufaw2LpfH8d/pD62/9cSP/tMogyCnc+iYl7vf?=
 =?us-ascii?Q?4FE/X5NWHDpkvyx726yVwrhuDYTm3h/2gZbcDsZOC2s7TEgWtJvrbNpAs+JR?=
 =?us-ascii?Q?dhVR8JgYQ6K6t/PR+AtPi2oJzPxP6kIimte+6IKG/X9GZxBMeOA685YoEO93?=
 =?us-ascii?Q?d8uFG2AvNQIMmf8jOVufHT5pJCzQLZAeEaQhb2GQMqm0YEjATLbsIls+cTxb?=
 =?us-ascii?Q?3ZXKc6nlKr9DPLiWZ3ckWdlhdCEL+Tonpc/FHpoVSc9VSF90iSYsKV8MXUOl?=
 =?us-ascii?Q?Z9FgSouk9v56pr4eusJPXPKhwQqYqDiz+PZeKSsGadKWQBDEV/fQDRBEITQW?=
 =?us-ascii?Q?hM54LDEksGFVVnDisPE4uFP7GvQ9s204922D34HDZz0QH2blCFdeLGbGKhbo?=
 =?us-ascii?Q?jV+Exoiu7UAQRdPvRMJ5XjMgMrrX7jTIL73KbEFOczDP7n1x1pQL5I+HqK1D?=
 =?us-ascii?Q?dD54/TdRAzbBBRV6zVeb9W6FYCPbZpET9fT7ellD996sgflZA9pSkDiVkJOL?=
 =?us-ascii?Q?aorrS6VDP0OnCWGY6d2dWqZmx4/tiLEIhGm3M4lkc/pXUhuCa15csu4I5FMA?=
 =?us-ascii?Q?qcK5Gee8Nmnb659vchXsf3eq1F77GVybZt+HksxwW/E9OkYRYXBl7WUpSbwX?=
 =?us-ascii?Q?+6DIL1u1yUfyUcM9LqAD52w46wj8r9Z6gkckeeCwgsC369OSVQgCSD2ZOLcp?=
 =?us-ascii?Q?ZM5lYoyTC0sC6HVwDaahCmEkhUGfj6Byv3bc0R85M7rvNSBI5h172HnpDEA3?=
 =?us-ascii?Q?aW2X8AZxRI81ELz7+SngWVNt1SiKyzfD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 20:39:37.3456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c40dce-7f4f-4042-bc6d-08dca769bda4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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

Add ring reset callback for gfx.  Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 75 ++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vid.h      |  1 +
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index a1963e6c5cab..6b9216b25991 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6149,6 +6149,7 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
 
 	/* Workaround for cache flush problems. First send a dummy EOP
 	 * event down the pipe with seq one below.
@@ -6172,7 +6173,8 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 				 EOP_TC_ACTION_EN |
 				 EOP_TC_WB_ACTION_EN |
 				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 EVENT_INDEX(5)));
+				 EVENT_INDEX(5) |
+				 exec ? EOP_EXEC : 0));
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, (upper_32_bits(addr) & 0xffff) |
 			  DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
@@ -6380,6 +6382,34 @@ static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 	amdgpu_ring_write(ring, val);
 }
 
+static void gfx_v8_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
+				  int mem_space, int opt, uint32_t addr0,
+				  uint32_t addr1, uint32_t ref, uint32_t mask,
+				  uint32_t inv)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
+	amdgpu_ring_write(ring,
+			  /* memory (1) or register (0) */
+			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
+			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
+			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
+			   WAIT_REG_MEM_ENGINE(eng_sel)));
+
+	if (mem_space)
+		BUG_ON(addr0 & 0x3); /* Dword align */
+	amdgpu_ring_write(ring, addr0);
+	amdgpu_ring_write(ring, addr1);
+	amdgpu_ring_write(ring, ref);
+	amdgpu_ring_write(ring, mask);
+	amdgpu_ring_write(ring, inv); /* poll interval */
+}
+
+static void gfx_v8_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+					uint32_t val, uint32_t mask)
+{
+	gfx_v8_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
+}
+
 static void gfx_v8_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6856,6 +6886,48 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 
 }
 
+static int gfx_v8_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	u32 tmp;
+	int r;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, 5)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+	gfx_v8_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		return r;
+
+	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
+		return -ENOMEM;
+	gfx_v8_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
+				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
+	gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
+	gfx_v8_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -6923,6 +6995,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync,
+	.reset = gfx_v8_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vid.h b/drivers/gpu/drm/amd/amdgpu/vid.h
index 80ce42aacc0c..b61f6b838ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vid.h
+++ b/drivers/gpu/drm/amd/amdgpu/vid.h
@@ -246,6 +246,7 @@
 		 * 1 - Stream
 		 * 2 - Bypass
 		 */
+#define		EOP_EXEC				(1 << 28) /* For Trailing Fence */
 #define		DATA_SEL(x)                             ((x) << 29)
 		/* 0 - discard
 		 * 1 - send low 32bit data
-- 
2.45.2

