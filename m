Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0071C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A65410E632;
	Wed, 28 May 2025 17:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0T7OBaFU";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E5F10E6C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mv6svGD4SeeGk01boDjlftdgwaf8V/VaRS9hxRw4q67QDu1iwwXGqupFBA0R9k0ntjODK/QFWsCbLs4oWgkAyp14h+szMffOcGLrd1VHoOpOC+u1O8ZWY3O8txnafJ2W6NJzr/a6PjySb6iuhn3zLx3MYQ0BxcI82yLkjg4evmj+CXKO4IMlXEw5GP9A0hvmhDgXkHmfCUI6D+BervIlvNdh+slT0D2yQVUPxaf0y+z+4N7cXvHXzxZRpWaLpDKwrH+j3PMr2CiKpXRe4H6dW17cDPSuU1kVdkC1SbA/2UgF/sNNj9wlehBiMddIsuKClfWkxig5TAVZNkRYWUlbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=rF12eL4UTbhqYds5XwSUWOvopRRbxznHylQ3IRfPQGQV5AvkLyuXDwDOQN0NsRS/sOX8jT9ULqkIYBm4dpm8eWsfSR8wQL5Q354yknazOdpXD6s9+LEj3L6YeSjpTlmPVEKtBVR72nx7a2zfZ6QbX/bknUwk7qFp4DuJdJ8qgv8l8xxwKaSPQsgesk1gbdXUpShHG9HoSQBl+jmRGER0/OGLRpwks9QMPYKzxZIiLvocnDnX79k3RdqE7JS3UjqUhg9heJJEaJdrforu5BtjHz8z7SpEeCqPJq7d1DeP7nN3UW9oyrLDwx8jo4omEGpu9Xg4S+v56gXEE4LNSCxb/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=0T7OBaFUgeBJBtL1K4e5r96X6k9TC76IndIhR1mtiLZjGJXJRxmRJDTA2xMqd+hFwCwt5esk5qygUbP05dIHEyfHfFwuchvrXG0DpVcxBKTzG+gj7TJDSUDbg5iIUBOg8Vmajf53tJ0JUI+RbaivV9fy15CltNsVXa/eBr2svwE=
Received: from BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::9)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 17:28:19 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::e3) by BL1P222CA0004.outlook.office365.com
 (2603:10b6:208:2c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Wed,
 28 May 2025 17:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/16] drm/amdgpu/gfx7: drop reset_kgq
Date: Wed, 28 May 2025 13:27:49 -0400
Message-ID: <20250528172801.34424-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c316b1-04d8-484e-0b29-08dd9e0d09ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WrAxRtoojoAY7cVb5O26gEiQXkdQDCjvajmFg22OU+SVhR0NVKfAkI/KQwlR?=
 =?us-ascii?Q?fo6OtVLXwgZABlEQFyiK2iuiQEcoq2VFQgt86WJafsxIEkGeRbsx5uafLOZx?=
 =?us-ascii?Q?j5jAFMDWssFI7rbxO6HqT5PKRGS5losFwa1aSyx0dXopo6bUu3DKZEyMDR3O?=
 =?us-ascii?Q?2B306OvzHqLBkyyZNqYJWzsDKxhjmvDbvC/U1EPL+ao9h7bc9K8HG6OqfzR/?=
 =?us-ascii?Q?tyTM+wpZoUmm9RUWPlmsKI+Hp+gR6/fXAUR6hYK3tbV8z7LsnId8DQ75tmAM?=
 =?us-ascii?Q?Bna/LOWroSd1ET8tkOrPQFDA6ybxxAU+//VAA0HmHv4E+PvQiWA1uHqgRfN3?=
 =?us-ascii?Q?ZQFJBg3is7atycDeO+yhO+baS5rQLrl2LXFA+3GxyMP2WRSMeScvc3epedqb?=
 =?us-ascii?Q?/GMtbXYjPiXIhn9LTPzhYPyk192J33q6Ed3z9sIGQ56Au1gEyprVlocHzKBm?=
 =?us-ascii?Q?HUE/gPOYrXj4a+W+ITRQ6qognC9V+PhbDkdeP8h4W6W5WSnIJ0pVLT6QYzd0?=
 =?us-ascii?Q?LETBunEBf4djtH9xGmFRFvHcYW8T3jgRx56wD2GpkmSrtSC+reBDFWgDl2fp?=
 =?us-ascii?Q?oM8q88kxNGbFwfh5IP+OMMh4HpaOJdR4a0B4jvIOnvfZCNbMu84mNn92IspZ?=
 =?us-ascii?Q?DJTucpleddJ0Na+TLRoXi/d/7KeYGWihRrRoJ4IZA9GRYznZv9+o35AoH4aF?=
 =?us-ascii?Q?GBMbmNYassQO4gvSPlGZGnFnTVhdeVpapowj6yR8fDGLQagbrMmWRzFcff4J?=
 =?us-ascii?Q?qHZ1AOWlHpkt06bCKwzA55NDzojvaQ+5lhCh/MK6V1pEv3XLs1fg3mF3c2RQ?=
 =?us-ascii?Q?C/De77zQNKy5AledLf9SkArHA7/2CP+UZyQbhmkLeIO9EYz1mJfpRktLWQQi?=
 =?us-ascii?Q?9twteeXD3Z+x7VQzv9DHYZWOmnCY57S0xDDtz5qvt6PttHk0otMMBbJ5ay38?=
 =?us-ascii?Q?8p1Z3Ny/5Hi7FaV5ReEfvyE4cVjCh3zSJQkMgoymOGyd+Tp+pljTmPoUCjp4?=
 =?us-ascii?Q?ZSZ/LFREZdSyvdpbEjBKsuMfaXBGNXN4HwuUfzHvklnvarlSZwYS13gG8YRo?=
 =?us-ascii?Q?TWds7XATmaPP+87iAYbFE0FWq6gSWfvPxwOOow6v32PKgtBWcYA6vc6rixff?=
 =?us-ascii?Q?O5grK1kfpZNjnP9mzWgbkfAsrPF5RVcdvonfpj16X5AWjyoXAlG6A4g5lcB1?=
 =?us-ascii?Q?amqsKCgl+LnRBTBH2RCGdQz0D1G/ntvqzNYemk5G4HsrFFAQoy36ZH1Gbd2Z?=
 =?us-ascii?Q?CeUZuV+qOl6FX2yebVfTBgPLAU9TQvZ5Y7VnqCU5VMihbBr4Wm/d50WuFJAq?=
 =?us-ascii?Q?gWtJvhowcezT08TLcKzCs6hBnAzS4Qu621DXixpDAodkP8T75g6ivBkkdC15?=
 =?us-ascii?Q?ncrQ4fZsaMt4rJlVgMA2HRteZ87YlxIyYsoOgGgvxkT/GsKDD0ssRKLMy6yk?=
 =?us-ascii?Q?7pm/VFRNrPkAAtRQ1iEoo5HCMrAxT/PNxPDSPecBm22rGD9weSXcS4vftfDg?=
 =?us-ascii?Q?NqtCPrUuazo4G3bQt8bFknyIRqSdtvz1Y7I7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:18.9706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c316b1-04d8-484e-0b29-08dd9e0d09ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
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

