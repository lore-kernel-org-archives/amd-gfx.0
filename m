Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D74CD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD6C10F489;
	Fri, 22 May 2026 00:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EFq1++Wl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD66110F474
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvdLU18si5SaoEPttPoKLLukZtyzkqYF59qkWaWHzAl/KVzx3ZTonuONBjqrW7dNAApis172lQBzEfE1cchMBXuhjroPJV2j+HNA0b+20b6mo0oUflSFUN84jhMmLOqd6KrYdC2xS6pyF2WHN6X02JYW7bOz2NbXyVLHq1SAIPI2fKLGpBcpne/lOkPcBPoutvv3T9e3KSsN5sUdK1QhzaCRaMzWzPF3LHxjfTsUNSEhoFweadlsgLtfhwzPl7ejT1yHvcO5/FB5RtdUOmQkqlLbrL1nkrR38eKpc3evo73/DqKCcYCbBBWo4C44UZoTdtYssw8sup1ggF0JMbAm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgLXHuzcU2Rg3/+r4svIfg254PUQ3Lyv47oMvn3I790=;
 b=YYV29WEKb1op7YP/W4sPtUnIYlb6gzGkLON7M7BEauQvsVwtemZ/VzM14O8uDotRQaWv4NGBIqbleyPb6osv85SiBPYQonoqKaueRODG+pV/6LfGjynuk7DvDh+mRXvofSqFl3j62O3KyPI5YRyxABr0VrPqlpYWDlehtjHpxKX/Ab2feseBj2s1pCR2Lqd6AWKD4mMmgJfvmG0LTWCgKCvYGqtpE9mZfdlDhxcVikSJRhp4WX/Pq2dzbYTEkPs8nnOYP+prWew9nq6Gw/rjX8ERx+LupS1KkU3F4826MPc7et5OqqguBppI1IkMlu6twg6Hl/NNQKK8G+lx1y4Xug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgLXHuzcU2Rg3/+r4svIfg254PUQ3Lyv47oMvn3I790=;
 b=EFq1++Wlanv+Z6cMoM81U264WIGynFe6im1MIwk+UAa91l+yBRV7+l+I+2k42jj5kKzCdsXEsAaa9OqIT3UAQc2wyVTGOARjQ+2PRhn44uqefTmqOL0qHfGYHBMd60Q6gzpPaOgPJ+qEw4kFQ8Oo1ciLFbl2G+II9Dyslr5sn0Y=
Received: from CH2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:610:51::34)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:21:52 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::9c) by CH2PR15CA0024.outlook.office365.com
 (2603:10b6:610:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:21:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:21:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/42] drm/amdgpu/mes12: move pipe reset to mes use_mmio patch
Date: Thu, 21 May 2026 20:20:22 -0400
Message-ID: <20260522002048.98506-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5e9dbc-fab3-4c78-de62-08deb7981f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: tE7mc9p5MDhXb0PaVqHEjIUEOLbIvsLZ58ujH45YQdbkhELZ5occF8T0MdJjs0XAeXe9rgdJm1A/itmEoq6a1eA0evjyNsSXp3yZ2e9eTIL2Nl+IIQLI7uYlbx/vrwDfmvlPXu6VdQT7/ewpkEXv6JdxdWIqudX16BqLqB+Z7J7KHuXwBBXpZ9EV+TxZD53G3F6wmUwBpIVXtlcRrpo7EAflaTaotb+VWXw9boyf5dDcM7eBbXIhrZgvFjaZ3vwLsKG3+KvC+IbUh2FyZDLGdBDOumVXqUAQSecJn9qQnX1Ub39vRwyYasIK7EdFg/4oa+dFFeOHz9v0IWMJkoYXiptMJj4XjV4EfSZDFN2nkxJPA0hnYEk1PS6BjBWxiUTZO0IansDDMII5coh9+PLCKWPqHtQuu7lVLm5GSbi/m8bL7AaibhFjOn+TfBEj8fXZPaudFs8DZBjETv6+Fj45SoAB8AOigw31AtAlTv/QbDp4UGvRq0NkkY9rP039/kgAjwE4nv1b/OmDzhaufugLbn6Iuiaxiggv1ZduoMK/5N9J8sasDiC6KO1lhahLsdWZ584MFNA2KmNHl2bPi/QrlEcaGzIfPNYqlNBITXbyeGeaoGm5HL19wCe5bpebomU58O6xuPnk/paEDUK9gX/4rEqhSa4O2tku2/krF9nit1eTuymtZ8Rf9v3ptEhJXsFUlkG9Y3iS08W/zvZT86gf2ZeRQhafSJ8ccYoy8uy3w3Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A65tjuPecDVaQJ06l9QmQqhOqhI6w2+q9/O+1N1XRbn/I9N7ADiWhAU3cV8NwUdRik+U/eoeJ/CKaHugUu7SaWPsSlwNPD6mtTA/pKh9USA3zl7hdGw0BkqkWp+URb3Ul+S3c1CBGv2/JVHhtHcRnZepL/8kWbjR2iNTnMEiox+ltVfi/LO4MAeS7rcAOwwmO+Eo84ud1itu6F3Rcb8v936/8CVOxHfL57q0waUFLBUNo17MhA/TrncAmqaiCmbIGWt+Rv38Bhcn83T4X27Ostf1SwfMD4uL0HQD1gcGebpjnUp36zeoh4M07y1LHXq53H1X01uWj2rqy1f7GO6nJcYsol2QTtYVCIdHCyk4kfUPKPLZ5ZvneZMlEdWk8Rm2mVlzLqGYRKRdcB9sYivnFUhIFYPvPypyyZmEt6SG+UU5AyZQ49RGkEEZpW310Dz2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:52.2459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5e9dbc-fab3-4c78-de62-08deb7981f6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
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

This makes the code flows cleaner and it's only supported on
the use_mmio path.

v2: fix typo
v3: fix typo

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 193 +----------------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 205 ++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 193 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d235e904b806b..bc282958fa372 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5211,69 +5211,6 @@ static void gfx_v12_ip_dump(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
-static bool gfx_v12_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
-static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t reset_pipe = 0, clean_pipe = 0;
-	int r;
-
-	if (!gfx_v12_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
-	gfx_v12_0_set_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	switch (ring->pipe) {
-	case 0:
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   PFP_PIPE0_RESET, 1);
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   ME_PIPE0_RESET, 1);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   PFP_PIPE0_RESET, 0);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   ME_PIPE0_RESET, 0);
-		break;
-	case 1:
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   PFP_PIPE1_RESET, 1);
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   ME_PIPE1_RESET, 1);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   PFP_PIPE1_RESET, 0);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   ME_PIPE1_RESET, 0);
-		break;
-	default:
-		break;
-	}
-
-	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
-	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
-
-	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
-					RS64_FW_UC_START_ADDR_LO;
-	soc24_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	gfx_v12_0_unset_safe_mode(adev, 0);
-
-	dev_info(adev->dev, "The ring %s pipe reset: %s\n", ring->name,
-			r == 0 ? "successfully" : "failed");
-	/* Sometimes the ME start pc counter can't cache correctly, so the
-	 * PC check only as a reference and pipe reset result rely on the
-	 * later ring test.
-	 */
-	return 0;
-}
-
 static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
@@ -5285,12 +5222,8 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r) {
-		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
-		r = gfx_v12_reset_gfx_pipe(ring);
-		if (r)
-			return r;
-	}
+	if (r)
+		return r;
 
 	if (use_mmio) {
 		r = gfx_v12_0_kgq_init_queue(ring, true);
@@ -5309,120 +5242,6 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-/*
- * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
- * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
- * asserted; only then clear the pipe reset bit.
- * Caller must hold adev->srbm_mutex.
- */
-static void gfx_v12_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
-					     u32 pipe)
-{
-	unsigned int q;
-	int j;
-
-	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
-		soc24_grbm_select(adev, me, pipe, q, 0);
-		/* Start from a clean HQD dequeue state before forcing HQD inactive. */
-		WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
-		if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
-			WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
-			for (j = 0; j < adev->usec_timeout; j++) {
-				if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-					break;
-				udelay(1);
-			}
-		}
-		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
-	}
-}
-
-static int gfx_v12_0_reset_compute_pipe(struct amdgpu_device *adev,
-					   u32 me, u32 pipe, u32 queue)
-{
-	uint32_t reset_val, clean_val;
-	int r = 0;
-
-	if (!gfx_v12_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
-	gfx_v12_0_set_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc24_grbm_select(adev, me, pipe, queue, 0);
-	if (adev->gfx.rs64_enable) {
-		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
-		clean_val = reset_val;
-
-		switch (pipe) {
-		case 0:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE0_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE0_RESET, 0);
-			break;
-		case 1:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE1_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE1_RESET, 0);
-			break;
-		case 2:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE2_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE2_RESET, 0);
-			break;
-		case 3:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE3_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE3_RESET, 0);
-			break;
-		default:
-			break;
-		}
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
-		gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
-		soc24_grbm_select(adev, me, pipe, queue, 0);
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
-		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
-				RS64_FW_UC_START_ADDR_LO;
-	} else {
-		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
-		clean_val = reset_val;
-
-		switch (pipe) {
-		case 0:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-						  MEC_ME1_PIPE0_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-						  MEC_ME1_PIPE0_RESET, 0);
-			break;
-		case 1:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-						  MEC_ME1_PIPE1_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-						  MEC_ME1_PIPE1_RESET, 0);
-			break;
-		default:
-			break;
-		}
-
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
-		gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
-		soc24_grbm_select(adev, me, pipe, queue, 0);
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
-	}
-
-	soc24_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	gfx_v12_0_unset_safe_mode(adev, 0);
-
-	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
-		me, pipe, queue, r == 0 ? "successfully" : "failed");
-	return 0;
-}
-
 static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
@@ -5434,12 +5253,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r) {
-		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
-		r = gfx_v12_0_reset_compute_pipe(adev, ring->me, ring->pipe, ring->queue);
-		if (r)
-			return r;
-	}
+	if (r)
+		return r;
 
 	if (use_mmio) {
 		r = gfx_v12_0_kcq_init_queue(ring, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 36886c2d5c5ce..ac75b7d65cb7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -413,6 +413,183 @@ int gfx_v12_0_request_gfx_index_mutex(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool mes_v12_0_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/* Disable the pipe reset until the CPFW fully support it.*/
+	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
+	return false;
+}
+
+static int mes_v12_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
+					 u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!mes_v12_0_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, me, pipe, queue, 0);
+
+	switch (pipe) {
+	case 0:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 0);
+		break;
+	case 1:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 0);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
+
+	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
+					RS64_FW_UC_START_ADDR_LO;
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_info(adev->dev, "The gfx pipe reset: %s\n",
+			r == 0 ? "successfully" : "failed");
+	/* Sometimes the ME start pc counter can't cache correctly, so the
+	 * PC check only as a reference and pipe reset result rely on the
+	 * later ring test.
+	 */
+	return 0;
+}
+
+/*
+ * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
+ * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
+ * asserted; only then clear the pipe reset bit.
+ * Caller must hold adev->srbm_mutex.
+ */
+static void mes_v12_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
+					     u32 pipe)
+{
+	unsigned int q;
+	int j;
+
+	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+		soc24_grbm_select(adev, me, pipe, q, 0);
+		/* Start from a clean HQD dequeue state before forcing HQD inactive. */
+		WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
+		if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+			WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+			for (j = 0; j < adev->usec_timeout; j++) {
+				if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+					break;
+				udelay(1);
+			}
+		}
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
+	}
+}
+
+static int mes_v12_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
+					     u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_val, clean_val;
+	int r = 0;
+
+	if (!mes_v12_0_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, me, pipe, queue, 0);
+	if (adev->gfx.rs64_enable) {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+		clean_val = reset_val;
+
+		switch (pipe) {
+		case 0:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE0_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE1_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE1_RESET, 0);
+			break;
+		case 2:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE2_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE2_RESET, 0);
+			break;
+		case 3:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE3_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE3_RESET, 0);
+			break;
+		default:
+			break;
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
+		mes_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc24_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
+		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
+				RS64_FW_UC_START_ADDR_LO;
+	} else {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+		clean_val = reset_val;
+
+		switch (pipe) {
+		case 0:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+						  MEC_ME1_PIPE0_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+						  MEC_ME1_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+						  MEC_ME1_PIPE1_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+						  MEC_ME1_PIPE1_RESET, 0);
+			break;
+		default:
+			break;
+		}
+
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
+		mes_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc24_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
+	}
+
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
+		me, pipe, queue, r == 0 ? "successfully" : "failed");
+	return 0;
+}
+
 static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				      uint32_t me_id, uint32_t pipe_id,
 				      uint32_t queue_id, uint32_t vmid)
@@ -507,6 +684,20 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 	return r;
 }
 
+static int mes_v12_0_reset_pipe_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				     uint32_t me_id, uint32_t pipe_id,
+				     uint32_t queue_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = mes->adev;
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX)
+		return mes_v12_0_reset_gfx_pipe_mmio(adev, me_id, pipe_id, queue_id);
+	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
+		return mes_v12_0_reset_compute_pipe_mmio(adev, me_id, pipe_id, queue_id);
+	else
+		return -EOPNOTSUPP;
+}
+
 static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
@@ -896,10 +1087,16 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 	union MESAPI__RESET mes_reset_queue_pkt;
 	int pipe;
 
-	if (input->use_mmio)
-		return mes_v12_0_reset_queue_mmio(mes, input->queue_type,
-						  input->me_id, input->pipe_id,
-						  input->queue_id, input->vmid);
+	if (input->use_mmio) {
+		int r = mes_v12_0_reset_queue_mmio(mes, input->queue_type,
+						   input->me_id, input->pipe_id,
+						   input->queue_id, input->vmid);
+		if (r)
+			return mes_v12_0_reset_pipe_mmio(mes, input->queue_type,
+							 input->me_id, input->pipe_id,
+							 input->queue_id, input->vmid);
+		return 0;
+	}
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
-- 
2.54.0

