Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE11C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C8DB10E86E;
	Thu, 25 Jul 2024 15:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ovesn1Xn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5201D10E84D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUMPeR9iSbdfgzMysgXh80erNH6q6Cjegak8r0Jm4Vtqafg1dUrNWj0PtmE5eOHiTIIU+E7dqllzp8NpoolbavcMT4+U+Qvp+QoQfT8/+8Ewu4B5T8bEB6KpskZEzmRScHAQo/H1bYZJBL+mW4bGxbDD0+u3H0ZgZcFmKVG+HOMxlQZvtGbDDcUJAVqahTR3ifM3FNP+/dOuPTODOLZ38G2Faez+7kqZ5D1Eo1xWLsfNlcHn9QWAdYUgsKjFUhvlTiMJvFU0PmGOoAz2jR89jLMkVNTlr+g6r/9Gnsv7FcyXoS6p1BQ2JDfxwIQRsXhtAEGIuli5rhsbFCC5ZCSmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czjbkUaXxzyezOQN4hj/uVNrzrefWMvE4wYDkpuMURM=;
 b=raTaVBAXWXsDRbbSuvpgY7L6gEfNXuDX5sXp5n+wzz8E1vCIwlOLfEAcyZV1gkjqcvEQft700Oj3M4+qxHM71nmt+Mziase0x4O40DJW70qt/C8OTMpcoWVMVCFspYyqZVTHD4SYU19a9BavtKVlVU0qe7er0DXaGtoEPZDX9HleYlQ1x7XeLHqSB28rFNNc5hzGM0FYN1TCuhdZ20cHZMACuyAOdWnzvxZAWMpl1P2Zkm9kFjUX1VEk+OAVQUqMTWNagOjBQ54DaOetrRXzG3pCwvK0yfJSpLxcRSuzQr+C76u2QXL5TcghmcYLD2l/T4dFaACVlss63jtch9wVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czjbkUaXxzyezOQN4hj/uVNrzrefWMvE4wYDkpuMURM=;
 b=ovesn1XnqavmDDGsrbDACZijoHMJPdobWMFEaH5cSkfq2FIvoILfnisL0hPjvviNMCmFG+vp8NHGK2XeSNEYdeQpsx6c2YOHbUkXMauC6sVXwIv7ZGnNIFtNw5lL80xAkXHinJGoc69CM2QgcmyNi/RmWsAQmySrTEuFye8J8sg=
Received: from PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::18)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 25 Jul
 2024 15:01:35 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::aa) by PH7P220CA0118.outlook.office365.com
 (2603:10b6:510:32d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 43/53] drm/amdgpu/gfx7: add ring reset callback for gfx
Date: Thu, 25 Jul 2024 11:00:45 -0400
Message-ID: <20240725150055.1991893-44-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 647c5584-f9ca-45a7-9f71-08dcacbaad31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NTspR8Bjm+OgX/IhkedgogyIOsynXwQ9Htj6mfBAUF4bOa91Bz6Cuzu+B3JX?=
 =?us-ascii?Q?9pSyfb3yrNQ0ERV/2VqiNw8yPgmJgCjwgEmUxRCXCqG0SccGz1m4FQvJhNTP?=
 =?us-ascii?Q?+9bYRpNM0H9lJ7FZFcj9/XDK/jkqAm2UoY3dnlHB0LEsIzOlPaAIM3MrvvLe?=
 =?us-ascii?Q?FSRMVxhEIemLR8DKPGRI+/yG0lcQBAWQsBrsLqA7FHILjc9EYzgSgPhv9q2E?=
 =?us-ascii?Q?dGPKL0g3MkpPvQkd2ohJjNCCx4jblQ6xO0EY4GATG65WxGUfBr/GVIwSob+m?=
 =?us-ascii?Q?23gaZD9ALT14GMh/4vc1bjbA4pkgl558mUBDoTDV+eX7Bkw4hiHvZyxCjbZb?=
 =?us-ascii?Q?Y0ISol7vnycEyra4LQNlh45v551jLzcFYcZvZEbveAnr3EsgEuk9z3wwWvn2?=
 =?us-ascii?Q?M52F6jdn/FTuFCmFP1TSyBci43vIDgTEuSM3A19b2KfmwQOM4zHxADiGzZtk?=
 =?us-ascii?Q?qlHmUpox03FBSmI6Sh3L1R+r1Qlr+WKje9Vi6VS2SOpczXLBNmCbDT4f/Lsi?=
 =?us-ascii?Q?oVSqlScrFvRP+ny8cZVo/K+qWNovdeDE/ywk1cZJs/Lvu9Du/3qaDDYkUH8T?=
 =?us-ascii?Q?2pC1LDwDJmdfe4nezGQFcjpXqnJ8z2X43028GMp7/6YkuMViHllCqQVhNXtV?=
 =?us-ascii?Q?S+oUvAAMjhRmn0+rDNzQHOvmuP/2v+zCd+AZ7IMTekmmgsd2z22bhdGGQS4q?=
 =?us-ascii?Q?Rz8XE3uymjfBZojkCrgOoqvIBfbf5nQ6rrVozLlBSzTuW3yeINU2pxxLm97+?=
 =?us-ascii?Q?A1NDuEyCspKimkkHxWFh5VwwMk1UuLlJ9vhKoHXFe1yGj1pBzuCcIvOMkguR?=
 =?us-ascii?Q?wRPC09Awh/Cjpn5zUzuspd/TsG+9/vd1GreERp1smC9YWPXKvER1ddBLdRYn?=
 =?us-ascii?Q?TIhv/fo79xQdsV98Yjyuh99kJ/Td8B04i75UqMaaRedydpMm3lkRAiJbOnm9?=
 =?us-ascii?Q?yAsO0ra/hZZCpphuEgQj08OLjb4iXGsZMo+GiL01zwQa5pwQzVxbcyoQ/1sa?=
 =?us-ascii?Q?ZETrfiCnWAiLvYOOpc8vJ7hHKaWGd/Oi49njnA8uEDC44VCQlszJt6kdacxJ?=
 =?us-ascii?Q?OLxRpnRPoJ28M1DtJgQFQjtTzBYPcLUBjvgbMkpxxqc1KobCQwjmBXp7RWRf?=
 =?us-ascii?Q?zXVbJvCFSk36RtoVYB/PcDJuo4fHtak1Of3vHptKLAb+cRBF9XuzK2apqYPh?=
 =?us-ascii?Q?B1XUXKpKCySo5f9C42COwdiyNMo57YxOD/LreBxKOGiGsH3xMT/U/Q69cHyg?=
 =?us-ascii?Q?zNam8/yMpHIa3DQJQMm/x0Y1MfzQN+h2nZJiVm5wAb2N0RrBQOkCoVZmILyd?=
 =?us-ascii?Q?6jP2iZbMMOefKyAQQMdKTaFTR1nKrje6Y/Ky7bFS5MXBrlPHo3/jH4jD56X/?=
 =?us-ascii?Q?LDaWUQlyrlTg8NXbtmEtXDFCQojk4BCYdBaJ658Ooskn4yVlj63FZtgcftn9?=
 =?us-ascii?Q?5bM5S8yn0QxaNQrnX0hWT96+SEzfwtvO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:34.7654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647c5584-f9ca-45a7-9f71-08dcacbaad31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
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
index 5fbdef04c9aa..f146806c4633 100644
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
+				 (exec ? EOP_EXEC : 0)));
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

