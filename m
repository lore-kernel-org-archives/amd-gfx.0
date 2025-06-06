Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005C3C5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4402E10E83A;
	Fri,  6 Jun 2025 06:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MnF5de9f";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F1E10E068
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQyeLrMvUJbHLeph1ggI8JVb3yjRzG9X2oYBNbZOomUYVlOpws2PEhqb56U0b6XppQ9oGALlqjx7dJhG4VFUUa7EWNJm8ACkOWTqefP7v6I0Yks5uzXeFJNuz1QzDDBnvgyZHfpKmt9f74CfVosdjnKNXa2Y8dRxMhH+/yd/nFdyQYN7JOJWKhJLSt2MHsIY1/5IVxtHYJVKgsc871MrEXPIJLl5fahK5KmHDFQECCeZtltgDT/Pg5Z3v9afN8ZrCh6JguzJzrGWQot3IgzS0JqJWEmqkZmTfvmx0X8eOdrgeLs1iXVtJ1S45LQCTEUlit8ESpzhwmKpzOdbT84A8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=QDlU+6nk/Z/5xWUU+TGDulFTuFwcV9GsMem4FcmOs6kicZaIINPz9+U3weDKeaz3CyodzJnntotg5Z79NPxn/HQT2wmKL13YV7g+pXaaLsbmuNIupUVI3/Wm6JfbigsNQDEZigjNX7R9PIDwAVwSTP4U8rmiKq+VCBIau3VvOduX75XDITVVRw6UNwdRr87U8fAmYmWerJoQ0NepUbpv0IrJcxY0Y7JRQaTcpAk8RCfapjyNAREEBwbYm5ySgD2lrcvN/A5G5+vIyhn+eKgtgJlkfhYxI7HByEMo2MKmz1abPdsBEuML2m33UGYD8ONHaNsibqo4EIaCjJKBKm1j7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=MnF5de9fFEEmaYCSZCLR+1ranjvAS0WtgFB1/uIojRZzAgVGbPMLmGgIN9o2VUZwJvm+Fql52XSPwVIymhIFKlivOVItdZ5H3j8kd8I8p6dAIwngeqyxYfwNG162oJ9dXecuQPh00lizBzfbF+v0M8xm/9mMukt4igWqjKmMETU=
Received: from SJ0PR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:332::7)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 06:44:11 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::2b) by SJ0PR05CA0062.outlook.office365.com
 (2603:10b6:a03:332::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Fri,
 6 Jun 2025 06:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/29] drm/amdgpu/gfx7: drop reset_kgq
Date: Fri, 6 Jun 2025 02:43:27 -0400
Message-ID: <20250606064354.5858-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 12276a40-ddd9-4b9e-6a71-08dda4c58ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RnjTiMlafXcAFra0eJauv8sPZqTZlObp6tWpjef8MS2QYpxdDEKyXOTAtiit?=
 =?us-ascii?Q?M6Sv9E5c3sgf2FT6VnKvtA4DZiZom3BWg4HZLDJIgpfdov4/XbzuhaqnveY1?=
 =?us-ascii?Q?hQfpjxMB0fdRIlP6xkQQ7KsJk70D8e16gUtRE1xPGE+aTcNPS9XBzo7YOSNY?=
 =?us-ascii?Q?AEcGqjn7ltoMdW6evX9AmTZBVPBPZMQPzt0BQnN24cH8pxI7+u/PGc6dzMRh?=
 =?us-ascii?Q?nqgIRx0LYEBwQRct2smT0kkzXcIGRWwS3NTXXrFt7HJDdrrZ0CDQCrc+xLqZ?=
 =?us-ascii?Q?D00pkHX6d5YmtifKGgcTmvK9/YFGnw1uKIhM5v/ibJp5cRRl94VzRzPcp8hT?=
 =?us-ascii?Q?d8SA5oBiqmk0eMxuoSG8yIWPk6znopydJhv/N+yCemsi8Zb4JKSnNUNvLdQH?=
 =?us-ascii?Q?sY/R/acRPSGFMulTGfYZgkeb9bAjhyyMlNvjM3u7XGQSKNd9IGsTfTqeA+y4?=
 =?us-ascii?Q?MIeFLTchznQ2Eb23MZRKKdctlK211M5NopYmAINew111PUByLGAAqd68MY4H?=
 =?us-ascii?Q?7AIBf7uXcygNANj9gb5wPL9nNrpsnQJbPWwpJijegdgXWJyQC/rxg8XQQirA?=
 =?us-ascii?Q?2Bv8vL3qAwxmpsrpx15VM73y1LsJHXuM2SgfEjjLHhvPpJ8H69lCP6+2EaQ1?=
 =?us-ascii?Q?PhAHMgZoiC7FA0OhkfFZjNgF3QtgMQXohPJbPhQS6py2OBTtHLw5Iwxlnl+I?=
 =?us-ascii?Q?k8x2dTAHckZ02pBCh+4mGY8eZclsNzRkctWOTJfLs6PRIdxK7iQos9M3ZRk3?=
 =?us-ascii?Q?3U1nGYZ2utmK02eFy+qioV6AA64viF4egmeUppQbFCgss/8o2YpwV2Hx+aGP?=
 =?us-ascii?Q?BgpsofnIeAkDpsfep4GqSEe4FfJxj7afFsbwynBuxQxyelZANpZS6+u0OkIl?=
 =?us-ascii?Q?2huE6debkHB3P1EVcHmNcUdkKry4jKP6OCMTHfVeYZZi5CbILjIYHuqct/Q8?=
 =?us-ascii?Q?tpHXm8roST9f2AiyNM8pLrknc09pAIY/RwDZVAnDyzaOOP8QZwmTHDOPA/0x?=
 =?us-ascii?Q?Y1a5O8SYWwybh6AgR9WlL0oOaaG6sC8CNcZn5l+WoDbLEDp4jkdVbdVdwS5H?=
 =?us-ascii?Q?Ar8hMUo8BHd5Ye38LfU3HWzHBYn3IfCT7Yu08rtU0T9pThPaTXpDk4rmfIUa?=
 =?us-ascii?Q?lCDoF49IviYw18sMrdWw8H2Op59NQvPiYB3RuJX3qH1m4U14i5DkMrS3jM9k?=
 =?us-ascii?Q?quHR/JWuRWwvw68XOg6Dtur5LR/Sj76u1694eV2h6LlWFQLLW++AZ0dWD55/?=
 =?us-ascii?Q?Y4hTUFMY4yhwnqyvNrNp710cwnxWBzigIqZCBWAMank74JbLPQvpzCDzDjlX?=
 =?us-ascii?Q?26lG2rZK9BQq1HRRd4P1Re9Ho8UYicC5YvYG5L29yzZLm4pognRwPac5dtVJ?=
 =?us-ascii?Q?40JeiZn0goVCyOw+qQS+s5SU0Fj30AjwqcXYgHX0d6AcW8eN1blpQJYxxowc?=
 =?us-ascii?Q?bJSCyGEfSoAnOMUkLSC3gXsB5BHQECNeG4yE02Ea31+xxUXaSXu2UWQ8Lgfg?=
 =?us-ascii?Q?i3iNyV837pWLXu2bsWRqWy5bCpanHvMc5i0V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:11.3337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12276a40-ddd9-4b9e-6a71-08dda4c58ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

