Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FBEC3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 20:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AEDF10EB12;
	Thu, 18 Jul 2024 20:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0lCGOw7n";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CC510EB10
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 20:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeKuoXVRunofsqmT37GCsxMbtkWqIxW4MzfaglQ0mo7meuEMMZ1tsKMQhjwWCYhv5QxYqUat3VoXoBu79dJ7CsJ6aFyJxxGAJ/aC/jgmPCafk0SHIesYNbFLSe5dG6VHzTL2l1scu9xx5Vw0yeL5VlIgjtfzK6Co0HBKZE/6h8Je3sqNqemIWAaHSEN1ut8b/er5kxIfRc2wPvqaoyKhPGYjic4V5Z5nIkkdHTZ1K9QTzrP7zQBhPBa7GikOiOhpUbBOyhaEwMz9S/lTdAxJAeXtnfXCHIZ5JY5O7Rdb3LlnBBMqFTIQ6pRC+vcB219KcEeEdAB7jc8PhBXNSjSZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+va7Ced/kU+ghZ1/yOKdl7Xbvk0LD81x/MAHimkWZ0=;
 b=K4z5650hc3fOPMN97z2PNwEFoahRXlE3WGad4LZMNmOWCXsd/T42PWEjRIkGqNATEXHvlroOWR1KPemdeULOz70R6fGwr6PGM+87Wdm2xZTmfLXI+kF5CXuA7tBfLmTqt14OyImt7ALeKjxeN5FWWYscqfQklMASKE5MuY2mftr7FIMZWpAVIhh8/JkZrEMKtF5j913aPeXpFbYCowHD+rB1m69UfUZUWLH1Z4mg0PpTgocDT0XE7qIc2Da4T4u69sLHcbV3qNDUr7+sjUr18oDQIFMIuE72l3bxpD/uFR/Z8dEmdWYlNW6HynSsOawu1rRq50U4ZCIf590gE0aJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+va7Ced/kU+ghZ1/yOKdl7Xbvk0LD81x/MAHimkWZ0=;
 b=0lCGOw7n/CKBFVElPoyOQVAs9fO2wbbWS2bSYu2ASKuNCsqudqcrr6iMtYM4Smn/nlACdhDx1zsFCR1/fThqb/KOVp2IPEBRdPWbSwyLwaSC72xg0PJ8004V2VBfb6oXV1NlNmKkancaOjMgY5fw0km022argIH9pSLqeEo23j0=
Received: from DS7PR03CA0301.namprd03.prod.outlook.com (2603:10b6:8:2b::8) by
 MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 20:39:38 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::21) by DS7PR03CA0301.outlook.office365.com
 (2603:10b6:8:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 18 Jul 2024 20:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 20:39:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 15:39:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx7: add ring reset callback for gfx
Date: Thu, 18 Jul 2024 16:39:21 -0400
Message-ID: <20240718203921.50563-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b98137-037b-406d-5457-08dca769be1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PgP7OTEOcz79PBeRrBDbNBS2Q1meNNmzVYvv84RTbWq3vK7zXwmTC2qz7AsO?=
 =?us-ascii?Q?VgJynb1/TVI4S0JDlic8QYkvM1O+DLpcysHsrHI2oY7NcgKhVaHXswoAlUPz?=
 =?us-ascii?Q?0RUXd1snDYNAU4klpPErZxVm5cI5mEfFdADq+ya2f4kco+42QcRlQfQHfzbH?=
 =?us-ascii?Q?/B8UmyRK6+BIhzGe/MOEA5hhD+tMepIUySxzz8IOcFA9J9VUDv/bv0FjY1Pb?=
 =?us-ascii?Q?KAke3aeWlzxNeBjStuK/2sAisEOfxq+VX31mrP6Q4Ac58GuT4jFyQgw5P7qa?=
 =?us-ascii?Q?mwb8QN1Rl4cXBAIXrEJ6JwMb31AQrncpz8x3/y9mbLyvwa/vVuAqMCbijzcV?=
 =?us-ascii?Q?2BXDOEw0IOo5ufrFoJCcqFQjHLPxPcwDn7DP4JK0CzRGXLCoZvGJyAkgsAmF?=
 =?us-ascii?Q?KgNPE7VuJ6lJiAApEQVz/NcEmHpWyX4dV/2u0/okdWEFTKHp3cBss23UiK9l?=
 =?us-ascii?Q?RUYEdxMvciPDEpMF6RIKvA4Sv24eJyLeSh0M6NgaQNqagj6WO2Iv5cOgknbI?=
 =?us-ascii?Q?0ApKFuyxSvMqieoXhi1AI2JemLsKknr67b5QHe27XudygxsmJ9Ms2rOsab8A?=
 =?us-ascii?Q?PUF3S/nw2eQtGmg163BJ/LBW6oyq+tzMRM3aiTjCsjtl7VEvJEA3K0Wr9a92?=
 =?us-ascii?Q?U4rb0HLvJBmYgxmPX4kjn62QL1X0hcuPcooPHdtqiJDwJXMhnnuPb3tW5A/2?=
 =?us-ascii?Q?49FP30ll9aYp0mw8t55Zzme/zwX2rD9RZFGB6AqwpK7X9eiv4YUsUgT7eA6c?=
 =?us-ascii?Q?BvOdEHq4L8qPbDt1pw3HUwlceK0xvhzS/i2M63LLHJE2Xo10whWS2YAhSxXq?=
 =?us-ascii?Q?fGy/mjE9PKzokV1PguOaasja9mLpn30cD4w1qmbagNryZol1YzFUCvJ6NgYZ?=
 =?us-ascii?Q?KHa7pDAPi4KJJN4D2DwEL7A++q947t5FldcwKtPRHj5w/YjvOrzcOnnvBCYR?=
 =?us-ascii?Q?SOwDOQV/5GpcOtxdebOlnJORn6AWO0R8gmpcMjZjqIfdhfdNx8W/5mvMl2ra?=
 =?us-ascii?Q?+rwcGOqupzkcFMwuH64XYlFxsccooVFp2aLHZ2wNo4O1oGqKAMG+iYQXlQ+Y?=
 =?us-ascii?Q?5d7TsG2C8m1lXquXnx24CRxACtJ5kWQe6+zd5Oh4q4TjADTBapz6n00gXeD2?=
 =?us-ascii?Q?wNjKEjvlnJqU8QQxVyRDFSt6udakNoc8QiJhoTxr5i9WQkUoswMdTOgZylL8?=
 =?us-ascii?Q?krWl+Dwr0YqX4fusBa5UOe5P20uHG3siGn3WzVlKZHO5f92C1xX8+xgRAOLL?=
 =?us-ascii?Q?ImS1xo4u5sTKua4wKCQSgqX4MRMYS6r7NWhWh1skb+6uN65n7ev7sCRfVeyN?=
 =?us-ascii?Q?Fk/JixtB2Be1h1pHPPiNFokWMhZ4Tq6nnkDFycYqH3LIZmnsZBrdK9ff0Ksu?=
 =?us-ascii?Q?r84ZTr6TnFujmsmy0jsTguhLIe8UdrqRBL6T5C0IXcJ62qX9SogeJlX7rlNQ?=
 =?us-ascii?Q?qX4qjaMb9X/JxRuP7AqV/gyCqsDFtMIu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 20:39:38.0800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b98137-037b-406d-5457-08dca769be1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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
 drivers/gpu/drm/amd/amdgpu/cikd.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 76 ++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cikd.h b/drivers/gpu/drm/amd/amdgpu/cikd.h
index 55982c0064b5..06088d52d81c 100644
--- a/drivers/gpu/drm/amd/amdgpu/cikd.h
+++ b/drivers/gpu/drm/amd/amdgpu/cikd.h
@@ -364,6 +364,7 @@
 		 * 1 - Stream
 		 * 2 - Bypass
 		 */
+#define		EOP_EXEC				(1 << 28) /* For Trailing Fence */
 #define		DATA_SEL(x)                             ((x) << 29)
 		/* 0 - discard
 		 * 1 - send low 32bit data
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 5fbdef04c9aa..d2c1665f3df0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2114,6 +2114,8 @@ static void gfx_v7_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
+
 	/* Workaround for cache flush problems. First send a dummy EOP
 	 * event down the pipe with seq one below.
 	 */
@@ -2133,7 +2135,8 @@ static void gfx_v7_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
 				 EOP_TC_ACTION_EN |
 				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 EVENT_INDEX(5)));
+				 EVENT_INDEX(5) |
+				 exec ? EOP_EXEC : 0));
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, (upper_32_bits(addr) & 0xffff) |
 				DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
@@ -4921,6 +4924,76 @@ static void gfx_v7_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }
 
+static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
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
+static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+					uint32_t val, uint32_t mask)
+{
+	gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
+}
+
+static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
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
+	gfx_v7_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
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
+	gfx_v7_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
+				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
+	gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
+	gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
 	.name = "gfx_v7_0",
 	.early_init = gfx_v7_0_early_init,
@@ -4972,6 +5045,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
+	.reset = gfx_v7_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
-- 
2.45.2

