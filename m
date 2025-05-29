Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31122C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FB710E0AB;
	Thu, 29 May 2025 20:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S+3UsqHq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A96510E236
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALk/t9rneXX9JWlXefyDFxR1T81/elFbIisIsuVOSM7SJ2h13BvZ2ssVe6GuHwDVgaNhGGyhwUZ2IoBDwgu6k37rkaC2/gSmrIcDKBaDPzf08+eb5LIzueXj9lYTBSy92+mPUMQAAd7JKNrUgVBMVB6R+afib+bz/hAjFUOFOGcFyTZaILsIt+oTJVfqEPnMxqWPQUJ4OhErOqdjf3wOBwvhHBtkjRgF+iWRO8K1X2lgzJhSDcFfw2RWO/4ylPPJNr7NzegdUYAVf5oRZfu4cS0NsCcwp+Dev5Ac6hmIqMcbaOSK5Et6NTqCtBhLpA02qEC3dW2+HTCGT3cvPmuFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=kU/k1EoxOKJp3HvuhXBt3J+oH+Ya8XNiVm1VD4ilLREFJ7PqCr600G14T/ZU6XEuxu/6MrI57Nw4A0LeoDMrs5Uq57cl41wLtatbS2cH29eZUL+8+JXXgdLR/bHK9KsH9Kzlwd+OwnCfudbMK9LV9nr802YuZEZTLXU1ehNVI9opivAHoL9CgE4JlJ2bnBSTIEpiXUlsOahV66uarlxOgxg/jrBN7qpd2FFNfwwL2eWrdpbwLL4ibKtN/HKpIUc0a/o3/fhq/oLOkp6QaelMJmJwtqcsvfdE7lhlJ+47o44Q8I+Ehwbb3jgE5RehqE7HHQwD7MHBAw/cNbM5FajG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=S+3UsqHqQnUYRKdI971JvRPJoZ4cfblder+3GWpgVcay4QcUxbJCwrdt7PAzt5k0Q4m98Pwq5DgP3UfYfGYs5xaittcINg3PErBYxvVWfhJaGhFnIrcKuuYp8gDCe9nppHMaJi9TTMLRF9flDAoWF/BpcfxzoPMtCBiljJQEXdY=
Received: from MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::20)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 20:08:20 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::9a) by MW4P220CA0015.outlook.office365.com
 (2603:10b6:303:115::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Thu,
 29 May 2025 20:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/28] drm/amdgpu/gfx7: drop reset_kgq
Date: Thu, 29 May 2025 16:07:32 -0400
Message-ID: <20250529200758.6326-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 20054601-59c4-457f-a2ef-08dd9eec8ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8nG+d98evC6E5Rwd/WzZ63LXNJuRpJTdsFiDieqG8pgxnkA8IPC2b3VSNQXb?=
 =?us-ascii?Q?mYgcdXTmH8zanwAXgoVh+XK9NmNtBVNupqxHVZIJ3FJSaOwEd9PXjzeF3WIi?=
 =?us-ascii?Q?IM/myJ3EUslY7vSUXGUA/jUGk3HOTe2VeTQUAYnLy4kIY6b4mSmo/bC4GRmH?=
 =?us-ascii?Q?2CpaYRg8dX2nLf1UqCFAMoKMe+M9+2+uqTWCzFPf4s9I5WsF0cdm8VWZn7do?=
 =?us-ascii?Q?q4OIgfUMQ/e7zdDBRzRStHjFmT7RvyswNvNxEQ9QDDOL3kgjHwLYPlT+k0zn?=
 =?us-ascii?Q?bF0fwd6PIWBRTWMu4nQqO6X8UZB10cKsJiLI9ZbLTBRPypJTAm22wHdj4EZY?=
 =?us-ascii?Q?fj39L8TSpQrpna4W5+FKc5l5WWymUXAbL22+YfOWYfsoaBQ14eo+X5xhnrBk?=
 =?us-ascii?Q?v24pE9Cn7RgByAEAmPADxHlnX+yhR1uJyBEF6xIv9APlbOwMLMJHeQNPwZ1m?=
 =?us-ascii?Q?CTRwxpruuAQ/S/dPI4B09x54dZJHXYigDAvZXH1mdmf+vwApizIO5i8iSJPT?=
 =?us-ascii?Q?0QfGLqRi3a8CmenJkZ/OPIDTxrLS4JOM2tvSo9+YqsEy4WLL8AhX81k/P75x?=
 =?us-ascii?Q?8iKYuT1Y7OYEP1nHsbx/wHLmxLBZGWw/+IVdUnenSP0utqq/1ucfeyKv3dkE?=
 =?us-ascii?Q?CQg2i8Gbi9qpmdWxoncsyFv0qLoexhKIo0Y66AEoPy39OTuCGfWhlne88SPF?=
 =?us-ascii?Q?s9XaPrp/+0YajJXPmc2zl+tc5CtccDfFarliTQF7Pw6X7Xv3QyAnmIRYiEur?=
 =?us-ascii?Q?lAOeMCR3j+EC0SNpvrIoSXe6ha+zeIcLEsZf1G84Vkom3qGfE5UY2SdaKJ1L?=
 =?us-ascii?Q?D7rSjJZHl9HbV9D7np4WrA9hhO41dspkHqitH6GAm3rsEvyYNXGxDKKdTlIJ?=
 =?us-ascii?Q?SKR/iqOpkqvhj4e09fRuWHMANsvv/URBjQkmByyefPqL7ccH9B/cy2MDxWW1?=
 =?us-ascii?Q?lqIInCu22WVW2gIkXqMoEHpkgVu2NgxmJPNJy+42U7nL+4icP9HgbvFQFxcM?=
 =?us-ascii?Q?J621F6LkJwcj4ktyoMtSr7g4lN/uKz6tCLsxpE1cNYevSkrj+4TTiyzlPuVZ?=
 =?us-ascii?Q?vtHmTK2Gw+qWKbpiVZr9WrlxsyGWFO+4p1fHHK/i9qk4xgM1GBHhSxKLs6Qs?=
 =?us-ascii?Q?iaAsQ/U7MeOdkqXKc/+DBt7ujtjJqg29Dz0kxNh/VQwyByE+kebcPnGSOgXg?=
 =?us-ascii?Q?UWVkJzZQylc3o1byXvaSEez3/M1zx8sO3qmqi2kbuL9IEYufd+WiCh4wCeoI?=
 =?us-ascii?Q?2KGeUmUYPN6MNRYlA3QTP/+DWAxx/hO9/0HvYvao0zNgHkYp78D6dL6bNIZl?=
 =?us-ascii?Q?eg8luZNiY8LfhRSJBi8cZfw/qurGcvL4EDgUCZ3qlrRxlV7HPZyggJ7KEpdt?=
 =?us-ascii?Q?/sHOCO4WOZll53r550b/A5qO3tYA7FDuaUMKZrNWkSAfz3/h13WojYYGmtPP?=
 =?us-ascii?Q?J/r7XPTpw7hkIf7SB1Tgiy2MOWynP6bmCARZGhUrfsyazyHDIEXK6j9M+M6R?=
 =?us-ascii?Q?uKKkZOCJdh4HAkdUaLJa/I734OHSf5N+TnCZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:20.0195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20054601-59c4-457f-a2ef-08dd9eec8ec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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

It doesn't work reliably and we have soft recover and
full adapter reset so drop this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 71 ---------------------------
 1 file changed, 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index da0534ff1271a..2aa323dab34e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4884,76 +4884,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }
 
-static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
-				  int mem_space, int opt, uint32_t addr0,
-				  uint32_t addr1, uint32_t ref, uint32_t mask,
-				  uint32_t inv)
-{
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
-	amdgpu_ring_write(ring,
-			  /* memory (1) or register (0) */
-			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
-			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
-			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
-			   WAIT_REG_MEM_ENGINE(eng_sel)));
-
-	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
-	amdgpu_ring_write(ring, addr0);
-	amdgpu_ring_write(ring, addr1);
-	amdgpu_ring_write(ring, ref);
-	amdgpu_ring_write(ring, mask);
-	amdgpu_ring_write(ring, inv); /* poll interval */
-}
-
-static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-					uint32_t val, uint32_t mask)
-{
-	gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
-}
-
-static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-	u32 tmp;
-	int r;
-
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, 5)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
-	gfx_v7_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
-		return -ENOMEM;
-	gfx_v7_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
-				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
-	gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
-
-	return amdgpu_ring_test_ring(ring);
-}
-
 static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
 	.name = "gfx_v7_0",
 	.early_init = gfx_v7_0_early_init,
@@ -5003,7 +4933,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
-	.reset = gfx_v7_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
-- 
2.49.0

