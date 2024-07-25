Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DBDC3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3564E10E86F;
	Thu, 25 Jul 2024 15:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ItFVVIKO";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B4310E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrC5bM1P72YARexN2SaKH+7/fKhAPH/oD4JE9hvSiMgN6squ4uky4TkoZ/r4X971kIvtZhmPRWVh4cmhgPGfnSv6H6Q4uoSb9YLhzhPGBhB9UG7NO/fRlwYaQuNKlJU1y3w6dcv/GZ21ihOR6Zisck0dMcJ25y7fb/8+69qEQ0jd0aT+26Cnr9V7IbprlmxsfAkg3ePgZ9hCOyUXFdIgNhNBb6tiLUqhmuMfnLGmOuExjvZA6PDDsHMdSOJ7/iMS4x+cB8/PcpD3IeNBrmwqymHYKET7KMgPc0idlsLHZ+CuDQihfjTZD8CfFhD2d9vxrNNPwg+zs78as9OvfwZu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/IO1zk2106ifAE13rHB3Ki1f0qIihHgNGDBznGmUwQ=;
 b=D4G52rWFaoD452e9yq0bktYNLadX88QAqDXtj9oSPGBxWu+FO1gjDI3npEixLrcNTwcZ80cAMdyQcVWeAi/h1HS5C1WSSPvK4rvfGWvzM06MNaAwEVPbnDNO9UVwd2thJhaN2uJfFdAT7hRfTXBo1lVCxx3g7IKwhzgvbuv/qXocf8JgaU1zElnpMnO/cGWinISUVBsEjPq3XqXydyuIrDHUSkFXCmVJlD9K9w/MdJxuoEJhmF6McuVT5lEo/cefM82FvPIURTx8FC+JYMMMorqhKEm9qk8iz06ERPxoBlS5GD1j8oeWWlPUKn65IxPQBUvjM0JqNEBXgQAy07Nf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/IO1zk2106ifAE13rHB3Ki1f0qIihHgNGDBznGmUwQ=;
 b=ItFVVIKObooP56v8I3zjEjtCbkjXbQL9odGTTNKfJU7ByWjBUjYcFlM8jtE74NzKcoM3EDnsTfE3zuavMy0bgyGsXHI07f9BccvB2UhPkf5FUlyta85qs3pD9VNZvJmGbybgN4HLE8fex4ZvCaDQe6xCbHghJ3hGfra+kz0rG48=
Received: from PH7P220CA0051.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::13)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 25 Jul
 2024 15:01:35 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::c4) by PH7P220CA0051.outlook.office365.com
 (2603:10b6:510:32b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/53] drm/amdgpu/gfx8: add ring reset callback for gfx
Date: Thu, 25 Jul 2024 11:00:44 -0400
Message-ID: <20240725150055.1991893-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4a371c-aff4-4201-372d-08dcacbaad14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K/LBaw/HKa1rjb3aZPCnvYZcYYs8/BpQU/+oD0RkDsDnRXDrZfdCZl4EuwK2?=
 =?us-ascii?Q?RzLBD8xEMWd6U/3Jb3S30TCXbumakCVlA8nRDU2XdpAMsmpd8cV5hNVstpwk?=
 =?us-ascii?Q?xhOV364ULgwG9jzzaI1rBhpSVDKU2nViuIKfP5eoTsxjHfXkbKYm+K/udSEs?=
 =?us-ascii?Q?eQnnSQwU88Owg7B/Sc3Tk1eQZlbW2pZEvNx6VdAgyTjnUOVKcI+Mw0xvW5ZG?=
 =?us-ascii?Q?KPYvfgfyeYRTo//nKi8DimigDQSAP2/k2KzeGnx86pW859QDTteqgAMIM5Ed?=
 =?us-ascii?Q?+4ZRbom8bs0oAEmC7Nh4e6foO0BBlsjyxIrrph1GTDicqFk6ZVSXFhzQOXN7?=
 =?us-ascii?Q?OBemkvnnzgTwBfh6L2xIxUZ6PleW0ORYvXWi2yYcNug1jdrT4NsBXDxdHh1b?=
 =?us-ascii?Q?1kCCt5fNWGOxLVyfulBg7ivLvS83sbpAdz/r41T4bHj3D5kz2Bzqsf+CfBEq?=
 =?us-ascii?Q?wJQmDMjlvZ9Ys+R6Zlf3LgNfwVIcPOvYtXFjogKVZYHdq3fd5qxlbwkXz5ez?=
 =?us-ascii?Q?vNA3o9un4WV6jprcmLTItQTDw4EKBwRl/IiwIeVFSlUDt03BUXyacOPA/3Mw?=
 =?us-ascii?Q?nu9hG8S5BaUheDUrYX5Bdflwn+jl8klOO0v4yEKxwb2ksJO9lQrpOu9Y8UCp?=
 =?us-ascii?Q?3l0F251pfUXacdJ0AII4yoHYs740VF2GN13OXH//Zp6eopOIG9Uq9kD4ynP2?=
 =?us-ascii?Q?cG7AcvQAIyZGYd3EkwRwsBh0L7alkwoFHbiyu7bH+BivW22zTgdc3Rum92bU?=
 =?us-ascii?Q?+Fs6TFoGTqE6Oi9FFfR82wH2VwFRBC+gqbTBU4u9LjdcH69PUt/H8ZQhEKvV?=
 =?us-ascii?Q?WukbucEVpAbYQ/FdnhF+Qs8+HWPTP/jk2OJAXxeVWHFKoBOewMS8gODicDkA?=
 =?us-ascii?Q?YnhJivq1q3wf/D65ig3F5dSnOQgb7pX1zX7PqgR1Ct3RAGNrWZrO72ESDkjG?=
 =?us-ascii?Q?b5gHRAj9sRNtw86fNET1ZmzhqTwoOfQq5+dRPTwUKURquaoox8Bua6bFNiNh?=
 =?us-ascii?Q?UQSQVpxG+rGcktx3/9BjKTk+6QADvwZLenvkbtx1ZVv9Bb4MLW8zdjGjXZUk?=
 =?us-ascii?Q?ulZfeKNBLqmGDNSnyRCN9SLMwZIZh2fjdAfmJFRKsDWkgfSP/OOdXHbSi60n?=
 =?us-ascii?Q?KMS1Go7CEzpasYiow1FIvF38BS2F4uC+jm/YvJ0YEYn8kt3uf7NwCJNddwv1?=
 =?us-ascii?Q?uvA11SAiHT+7rr+8zxpHegBqVCxthlbtgndaR3gkbFrrJYrinYty9BFqqkv2?=
 =?us-ascii?Q?sx9diNbmfK1I4o2VoBxpc2UKwOo2mNBOVT4uZUs759R1+Flnnp5vK7ovekGv?=
 =?us-ascii?Q?5gbmUVHMc8npy97a4vCPQQCDxANYs8+ckurbxsm8vdkf6JH+or5gvTbNb7gf?=
 =?us-ascii?Q?xvkKkJPETkfcCSZOh07lElcCApA9dKSutFvF2EI+HeVa2C+udP8AFoQhGBy0?=
 =?us-ascii?Q?+M3K0iCmJxSn37E7wFOvOcesgAou/NSb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:34.6195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4a371c-aff4-4201-372d-08dcacbaad14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
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

v2: fix operator precendence (kernel test robot)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 75 ++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vid.h      |  1 +
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index a1963e6c5cab..bc8295812cc8 100644
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
+				 (exec ? EOP_EXEC : 0)));
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

