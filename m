Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8524CD5BB1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5FC10F478;
	Fri, 22 May 2026 00:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="war3QpYB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A10E10E58C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er37h7n5QE7+RM85Mrfdso2DcIH7J4mikEoqegNqmC4YimPnz1rzO0bGQ1jzf86FBFAeVmkhbFHj/QSfajHk5p7ifsCZlH7Odb4+pePf5sWDAsBejpzthgUWPC7p5fVKIvFGu1uI8/Bk1yc3tza31flsMvlqEKKtFNq5frWz0HxLGaK2diwZBslKYlrIyZujAN32rvnTRyA0dLlk2xPhbgiWHw0yqBKk3eOs5vTM9n+tR5Y8KgrDoBOjIg+R0W4nz+GF9RZf90nH1LoWIJEuTGazzXdU6hAA21hr/ltuI1mzXm0n4UgMk5ZWRuTtvGbDuXW8DxedmoynNKZYGnKMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8LO2GOaPdsun6IyDB4GozOr3GawCquaN5CQlSBJ9XA=;
 b=CTqlbv+lq5vGS2FEmEsqGSsoCoO7C5UyoyEBquVvINB7sLEiTfrFRklTS6sYmxQc5QSZg2IQpDb5phBEJmCPrBsyTcRMMedEXWnuqHY0HsFcJ54krcO5z7spYM+w0R3LIxkj2Bg+afAiW6M7a/7tLSCTMqbOBLjUG4Jj7Owh7Vlva9AVilao3bkyU1gTcUkjmKPnM+CdM75MisXbb8eY+exhg2JVHlnrw/je4bvKXOUurs9++Ill5nKQTjiiXsN7qZCQS9HQz0cv/Eo3mTLMWtkLdqLW16+Gr73PBv0AGYuxTJ9PcvZRpLg9U9n3k8DgDhV0bkqZIkNDqAt2XM+2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8LO2GOaPdsun6IyDB4GozOr3GawCquaN5CQlSBJ9XA=;
 b=war3QpYBkVcy0jaYsYE/2rjzX/XzwJ7+MWkK2qnna4TVsxbsjpgiSBr6GGA4MAFhRiHILTG7N0UlBf/pjVhbHNWzMeOuuKSUsExoxZnHVf60b8QNKI2KdznwJQ2XVsraZX5zuzCZ9gMkJ8XeiW/TWe/Xkv/U0/RmQVQ/n1blhq8=
Received: from CH0P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::6)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:21:51 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::55) by CH0P221CA0026.outlook.office365.com
 (2603:10b6:610:11d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/42] drm/amdgpu/mes11: move pipe reset to mes use_mmio patch
Date: Thu, 21 May 2026 20:20:21 -0400
Message-ID: <20260522002048.98506-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: b5eb3fb9-4b35-417e-252d-08deb7981ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5Lc/xsIq1MsLAVNPEE6Q2SiOBZlJfUa0houhBgo2Ms5WC/TypSE+VHIdyT/Cq3CdqrHMVG4dn5n6yEr+gVr66Nkr1Pk9LNVJp/NyN4pguVWg7n4z/aCy+KLnIZ4LcCP8/I+XKGwV62NayuIE5bq0wBSkVl2N75pQVrC4F6Z1uE9HcfJwZf50MZQxGIpT27fCrZSjs7+kPrAAc+Fz8FPZENOljQMi4rVGARfLJ3MwdLYtZdpul6PCkXg9JaXED0GbNsjWxXnKPGIio20uB9wsbExyhnU/xjpakRcQoKZe+ZswmSPvaWYkc9kyl69YwF6otGnB8VA272+pB8/YwTmPh/DOMJJf3a6yUsc/xbcFhZNFk6hqaWPh2dwtXMPvZBLlSd665lEN7KuUXcbg7TWferdnzTCzKste1W/QnE/V+bUBxj7v7M19dspfeuhVDgMMMfC0sGL9BsGTdkjCUH0MlhOnbkpdOI6eNT4gJWyt4F2+yT50cOmw0YBgiDz6p4wtn20ojiFIAu0GW8yNLakqDDQU0SoGDNn9Y9s5Wj4n64fD1KfpHPj7h0t+k1MnLzlVKvu7SpXRGxf1cb3rNPHlKokdk42JJ71fvRjnbbywFGZALXLyhB4FwB7KBVtcOQ9qO9/883ENj4GFrw0v5xSTAAHYU3MzHOimcnSmfStiKoQCU59EbkwwdkjC1g6Q1W1qziSK4COi+RxHe/qieeUcxs5qRLnPNp1wRkXbpFIMQrk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 87eKvQjp+s8CS4HIovz/QznYlEFMhiLWhAlYdb5apst3DRIrS60RCJhTfbGXsf/wXV6jm2jqa5Jh9WCGD5rQrZcTTvSVi7YL1gjptp/imFNok/FoTmUZ1OddgtJZuAhu2+H+TRB7VldEI9Tu8hTI5S4tWCWczuM2y2Iq/hnh8Q5d+CMz5Ug1j09Och6tBpsS+JgMKqnRkFqTL9nq06SE5nqZWeuNrOCUagc/8qG17WiozynUF49oIvMQb5X8X4wykRbaPNpUZ4vxtRl4zI+DNPPkaSdQjwK5vkrLEuwScZzAvPg9F1HeHyM3i/sRf2IJuejzpFqlXrAXvv92PbGTP38ksWCYH0T3rkPk/rqDpXHM8YKyh2PzZswvYVqZ8fJqVXBQBLWElikyCN+6vXhu4eAjXgw3p7Kz5MpLwsBzR+qMvv9LeSAo4zhvJtEyy6Ei
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:51.4140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5eb3fb9-4b35-417e-252d-08deb7981ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 244 +-----------------------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 253 ++++++++++++++++++++++++-
 2 files changed, 253 insertions(+), 244 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1995de5e69991..f268d46e07598 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6775,69 +6775,6 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
-static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
-
-static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t reset_pipe = 0, clean_pipe = 0;
-	int r;
-
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
-	gfx_v11_0_set_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
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
-						RS64_FW_UC_START_ADDR_LO;
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	gfx_v11_0_unset_safe_mode(adev, 0);
-
-	dev_info(adev->dev, "The ring %s pipe reset to the ME firmware start PC: %s\n", ring->name,
-			r == 0 ? "successfully" : "failed");
-	/* FIXME: Sometimes driver can't cache the ME firmware start PC correctly,
-	 * so the pipe reset status relies on the later gfx ring test result.
-	 */
-	return 0;
-}
-
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
@@ -6849,13 +6786,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r) {
-
-		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
-		r = gfx_v11_reset_gfx_pipe(ring);
-		if (r)
-			return r;
-	}
+	if (r)
+		return r;
 
 	if (use_mmio) {
 		r = gfx_v11_0_kgq_init_queue(ring, true);
@@ -6874,170 +6806,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-/*
- * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
- * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
- * asserted; only then clear the pipe reset bit.
- * Caller must hold adev->srbm_mutex.
- */
-static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
-					     u32 pipe)
-{
-	unsigned int q;
-	int j;
-
-	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
-		soc21_grbm_select(adev, me, pipe, q, 0);
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
-
-		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
-	}
-}
-
-static int gfx_v11_0_reset_compute_pipe(struct amdgpu_device *adev,
-					   u32 me, u32 pipe, u32 queue)
-{
-	uint32_t reset_val, clean_val;
-	int r;
-
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
-	gfx_v11_0_set_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, me, pipe, queue, 0);
-
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
-		gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
-		soc21_grbm_select(adev, me, pipe, queue, 0);
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
-		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
-					RS64_FW_UC_START_ADDR_LO;
-	} else {
-		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
-		clean_val = reset_val;
-
-		if (me == 1) {
-			switch (pipe) {
-			case 0:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE0_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE0_RESET, 0);
-				break;
-			case 1:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE1_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE1_RESET, 0);
-				break;
-			case 2:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE2_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE2_RESET, 0);
-				break;
-			case 3:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE3_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE3_RESET, 0);
-				break;
-			default:
-				break;
-			}
-			/* mec1 fw pc: CP_MEC1_INSTR_PNTR */
-		} else {
-			switch (pipe) {
-			case 0:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE0_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE0_RESET, 0);
-				break;
-			case 1:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE1_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE1_RESET, 0);
-				break;
-			case 2:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE2_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE2_RESET, 0);
-				break;
-			case 3:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE3_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE3_RESET, 0);
-				break;
-			default:
-				break;
-			}
-			/* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
-		}
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
-		gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
-		soc21_grbm_select(adev, me, pipe, queue, 0);
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
-		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
-	}
-
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	gfx_v11_0_unset_safe_mode(adev, 0);
-
-	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
-		me, pipe, queue, r == 0 ? "successfully" : "failed");
-	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
-	 * reset status relies on the compute ring test result.
-	 */
-	return 0;
-}
-
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
@@ -7049,12 +6817,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r) {
-		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
-		r = gfx_v11_0_reset_compute_pipe(adev, ring->me, ring->pipe, ring->queue);
-		if (r)
-			return r;
-	}
+	if (r)
+		return r;
 
 	if (use_mmio) {
 		r = gfx_v11_0_kcq_init_queue(ring, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a926a330700e9..385dbb1680b3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -390,6 +390,245 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static bool mes_v11_0_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/* Disable the pipe reset until the CPFW fully support it.*/
+	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
+	return false;
+}
+static int mes_v11_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
+					 u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!mes_v11_0_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, me, pipe, queue, 0);
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
+						RS64_FW_UC_START_ADDR_LO;
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_info(adev->dev, "The gfx pipe reset to the ME firmware start PC: %s\n",
+			r == 0 ? "successfully" : "failed");
+	/* FIXME: Sometimes driver can't cache the ME firmware start PC correctly,
+	 * so the pipe reset status relies on the later gfx ring test result.
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
+static void mes_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
+					     u32 pipe)
+{
+	unsigned int q;
+	int j;
+
+	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+		soc21_grbm_select(adev, me, pipe, q, 0);
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
+
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
+	}
+}
+
+static int mes_v11_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
+					     u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_val, clean_val;
+	int r;
+
+	if (!mes_v11_0_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, me, pipe, queue, 0);
+
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
+		mes_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc21_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
+		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
+					RS64_FW_UC_START_ADDR_LO;
+	} else {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+		clean_val = reset_val;
+
+		if (me == 1) {
+			switch (pipe) {
+			case 0:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE0_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE1_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE2_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE3_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec1 fw pc: CP_MEC1_INSTR_PNTR */
+		} else {
+			switch (pipe) {
+			case 0:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE0_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE1_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE2_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE3_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
+		mes_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc21_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
+		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
+	}
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
+		me, pipe, queue, r == 0 ? "successfully" : "failed");
+	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
+	 * reset status relies on the compute ring test result.
+	 */
+	return 0;
+}
+
+static int mes_v11_0_reset_pipe_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				     uint32_t me_id, uint32_t pipe_id,
+				     uint32_t queue_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = mes->adev;
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX)
+		return mes_v11_0_reset_gfx_pipe_mmio(adev, me_id, pipe_id, queue_id);
+	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
+		return mes_v11_0_reset_compute_pipe_mmio(adev, me_id, pipe_id, queue_id);
+	else
+		return -EOPNOTSUPP;
+}
+
 static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				      uint32_t me_id, uint32_t pipe_id,
 				      uint32_t queue_id, uint32_t vmid)
@@ -762,10 +1001,16 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
 
-	if (input->use_mmio)
-		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
-						  input->me_id, input->pipe_id,
-						  input->queue_id, input->vmid);
+	if (input->use_mmio) {
+		int r = mes_v11_0_reset_queue_mmio(mes, input->queue_type,
+						   input->me_id, input->pipe_id,
+						   input->queue_id, input->vmid);
+		if (r)
+			return mes_v11_0_reset_pipe_mmio(mes, input->queue_type,
+							 input->me_id, input->pipe_id,
+							 input->queue_id, input->vmid);
+		return 0;
+	}
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
-- 
2.54.0

