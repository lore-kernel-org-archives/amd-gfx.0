Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47458CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7F510EE2F;
	Tue, 19 May 2026 18:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ih4cDtWa";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011004.outbound.protection.outlook.com
 [40.93.194.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A6F410EE2F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfgvQqPRARXIw8hPzaV9EbqJYIZ3NTdzzS089DJxgHMB3de9ejiZrFg+GEGeLHn/bNyqxIH8A1iGj/dBy20Eagz5tncoJaZVYs4lqaeBfMpMQfBjSdnO6VvuFxNT93G/uuB8BHiiUG7ExKKrVdj1Dk3v8MuTpfMD56Gf164teNIRl3KxQ/bUtNItvz92PUWdh64Lq5Z7BhvaLu2X/BF6Z6xEXMng58kG6oTwCQmjPzzI8VWjjFPl7HFN/Ra9tsLm90AKMNvY2izm+VBj77QuR4QuAKWcQ8wUyImH4u2aaGwHkgFU9jVkoxf7VaRCBZrVKasij0sozdAAo9Mpy4MQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgLXHuzcU2Rg3/+r4svIfg254PUQ3Lyv47oMvn3I790=;
 b=Xxo1LT7AWCYsQwr/A+iUNnj86iONaYeqmqprb5E7Tne3rT3CLif20tb/pQY+2y/UAtZyF/HqGvIWcZzvDmdWh5nAMgTCyW+L3sJoL2EFdxkmzHRNloEfW6klUNtA5WozEoPAK3InsMUzq14jYwb50swM3ARyGkQmk8yKPAoGJxZYp1jjuYdVXUSlRErRorn/XYGKF+/U9F7tTx2pSQ39A4Kmcp+q5wiX6lPgBrKfn1UlxKiY5NoaAlmFsL6+5UOoM54vp5oMr+OAUwoooCuwu0kVTWY6sOlJ8dglys34uoc2pxpVjon8kT3gfzjlCjznO+G1MTy7Kv/mTbJc1YWaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgLXHuzcU2Rg3/+r4svIfg254PUQ3Lyv47oMvn3I790=;
 b=ih4cDtWas+0/c60gjOKKKF9w1UmrhOgfstw6qNNU99Ab5fsuU3iEFmqhIFTbh44DWSCtvCgJyMHxTbOZd9yjv/3cSkdatsTrDDxeygS9M9syf2iMuMPXXKJD3BQEGeDrESGATANOvSdkv8mvySgLxNQbbzP5nn5OknpLmCFuGt8=
Received: from SN7PR04CA0211.namprd04.prod.outlook.com (2603:10b6:806:127::6)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 18:32:11 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::a5) by SN7PR04CA0211.outlook.office365.com
 (2603:10b6:806:127::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:32:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 13:32:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 13:32:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:32:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/mes12: move pipe reset to mes use_mmio patch
Date: Tue, 19 May 2026 14:30:55 -0400
Message-ID: <20260519183055.22275-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183055.22275-1-alexander.deucher@amd.com>
References: <20260519183055.22275-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 6789b061-021d-408f-0ea9-08deb5d4f12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: FUEmYuE7sB+2/04gD/d4S2k6xpKlDDIRlo1oG/hsITMon/bPphqlIw9fCaiyKD0CoR0c3yRsJPHAlhuHUPF5JUhu3fjNc04hw4WoqF/N7qG7AOQmlKXq0E5POsbnvhvHp/CbUazcG5OyyBsnE9DSkAvCCUTFTgpEuZVLz+UfSaXfp87wpDlkwXYfM/fbusK3rmyvzjrDSEg3nGLMi6NygVcBNlVK6JvUrLB0F6aGKS4dgYubqVn3wUm0xNNZp5b/dY34O2e5+k2pSmE/B1bai8LoGFoZpIoCid9iSocenK8loWNHokfFQMW3NoarCCtcmY3TA5TZ5zdioTMJ5AJ167Emi9N1UfwwXqoZZqtNrSzusP4J+Fs8eqCpw98D7bx5ZQfqfuFkQadclWR8W2T1lszJx06hAXR6h9fDn/WM5GtfBD72rdzZ/wTgRv389TkxR8dZcC05WCVNGCDEEa1M6LC5vZ/nihHOwvQ6aVfHcEZzq429yWjF4Lyf35ADjkqvPJbDAbGkWMZ3QM2tGbmrEbmODhiBSfS5D12CcQKQfAbh0EcNcbNq8iidLvAxlyX+AP7/j1qKfGz3f27pCF4+Urv6u+xSb0tIAGIg+75kcSywMk3pF96YoH+AU16rr3Yuq9jfXrc2nw7Z2IlW3KyBRlIC/0mmE5H9+16P0pSk6v45sw9/q+krgzjnmjf43LzOVX1g/9vuOW8U4B/c2eI5NbnYj3yNY4L8TMBUoSdv3Ws=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XeRUHjeI4AXS4u8ytyy31L41bG9nzvXj4Z9YVskOHcA0RHf9QLb9Ae3+vfBNrY/osQfI9FBuON2ungn8bST88mWkyeQawqTLgcP48enw6rZ4EuooGWoEsQ3dc0DqU4AOXjx4wXA3iuc9iHKJgoVTpUahwHRUuY0YJy2+sRkLI108XW0NfWn7I097GCquP7r+KFGPInDnpvBPVhvOog7UiBw0psQi+Y4z3xPH1f3whzTkFtHcuh6xbSRngE2IUz16KLi+XcyqrBU97fkTIic6d6IeydqRk2CHSh8tzOfaFxrC18NlO3OkLvm5aBXlAQMAR5OYVOe3yLHEzgxt/Yrdow3drRCqwJx0EZkSZUOLr4GxQ3StmMsktuaoN+vf1ul5cf4hrwYKvG24M9ejuFvEW+4SD3GmEAxEUBSDbNlFhgROa0ZDAz3XolDXP7dwnkhr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:32:11.6599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6789b061-021d-408f-0ea9-08deb5d4f12e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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

