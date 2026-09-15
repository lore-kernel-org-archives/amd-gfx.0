Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A3FC88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 12:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF42610F44B;
	Tue, 15 Sep 2026 12:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJhEI78c";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9564710F44B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 12:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmsGUUrAlt+/nWUoP8YTY1K6ZiBUm5FgBC0SB7J2PbBY2N1EPA09dTi9q96pyTcKXm61xsKhV+19mUL0Q2+SVtBjfQxAo0fknQ7wMTyCtbVrymBzdUmCbtoht/KnkIqa0P9C7WJqNLLqwTEGID/uqkm2LRQtFcmQTZjWiOD4X56KYKJuuYtx4Y+AYhtcm3YG7WwANg1kQ6Nh6PYJDjjG1F9P9VM4hT4lzDonyrZUQxnN/leDdo3zincq+ESeyTSCKjRuEsmsuhf06zu5OI0xElu7pbW8iqbX02sQALd9XbD2nq2PiEFPrqNK7we2akcxdfi4QUu+mTMfBhuPDpY+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHc8fCwNuUPsvDA2al0bKas9obvBdwCp6cVxHiFdRag=;
 b=eEfDVom7zccx5XwO/3wDRMAbr2JyJ5TYFHbLH3FG6EHmwiK0v2IXBwZtlvGYRqQiplyL0FQc4k0RwEp5KqtfMEW0hnxhPkcX22Kk4rkk9WgmYYCYDIRXS9fuG6WNQcOtAi0JYGLkJfQsMeZ3l3MiZRVk1tdmofL8lJWSL5pkjWE/sV2r9tXVg57uT7CLaufz8LrkWSvlHVxaLyFMYzW2MBrMbGqHAXA7DELY/rQHHYd4OlGcc0eG3kIgj9lKJsa5qy8Jlkxe7cc92JULtvVA5P1gJNedOlLdG1E5ySvncKf0YD7KH3A72g6afzCQDYAELaa9suWJ1NvN5hKbh9QvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHc8fCwNuUPsvDA2al0bKas9obvBdwCp6cVxHiFdRag=;
 b=vJhEI78cpXJEfH13P/AxKbw4suxf4tlX6XhUBgR2W+XXevVbaKgMzva3HbrZWsqcFPfb2cy/A7MD1WPBSwH2wQK2O2ft+4R4lfbFkB6w4eUyIs2nfsG090LCyJ5bExBDZ1h/2G/g1KWrEgdiHxT55JwftZdM24n4f35DjqM1EWo=
Received: from CH2PR15CA0007.namprd15.prod.outlook.com (2603:10b6:610:51::17)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Tue, 15 Sep
 2026 12:40:42 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::5b) by CH2PR15CA0007.outlook.office365.com
 (2603:10b6:610:51::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 12:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 12:40:42 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 07:40:40 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Horatio
 Zhang" <hongkun.zhang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/gfx_v12_0: Remove legacy CP programming
Date: Tue, 15 Sep 2026 20:40:24 +0800
Message-ID: <20260915124024.14573-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b704384-6ba3-43d9-6c40-08df13268deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: DXHBYVJlFBKNF2nkbJ6IELaZ3/+Xvzs8GiIVJovBzl1RmdupX24YjVYMO4wuB+BAeJ1PR4BXqsW5vpQa/NH6zMAKUqDFXe6AJodEnjSRqloTUJjuTb1P/3zoBtIe6Q96MFOqbp63iDE4YSj0WHs4a4M+lM8dZRMk95HXe0V62vNpX9uFL34n9NNIjW0jtc3tzXebWqf3o1Rhp6/vyxqAFe8R7NzgDbSVLMe+MiRReAMheSVfiPbvBD//RXq51WYVcgG9g9PlXLi09hI0uAsQ20GtenA2dB8HXQLFK4VS+Ga9k4xyicStOOM12FzAh8Ae7LZYDfPHuv9JXAVKYQuv5oAVeXiSOR0KVKkFVjAdEDYepasZ4F1Mw9g01B5lpZMi6Vqh4HBWDeFMZe8nXjNMQMdX6nlntmUG3p/mYIIek6qE+lrmgqYr5Sr1YlWrY3TvYVsl2baxNcMvUqzSFcK4zdHu0lvMTlQJDgQ9F3qABWsFnBhmzgPZZfiaw2luxzoYWYwxDjlLrpRbasKuX8vs/CxIwrVcTZJzIytJuTBZPL+ILyusctesNEfBfKAOBAL2Ge2RcxioKqoTI/1plxKzPqAbOY3aYEz6mZZELWiE6IInEtgW4WRgydgpiwNypb5wE2T2R4qj1eganQooLg/m7WFA+rbeNxn6cDc+sf5ntdLelynbKgZWRiBlFXg/Mha8gWCjDVl7YHEEnhCLlmAvfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hrq4R1O4cn9vr6bcrVCc1hcm1rhFLAEpjA+I6iYYsxod0uZQkcna6VV6TBxouhnkMucE4fuRy7obQrU9g7Ks+cMxXlsA5p0S1Jp6vQkWCAJHIxUDBJAyKtCVI3mvEZfS2kuDOWGgw3Ixt4EklLCaARpvCVGgYB+C6NqrkOr3xFr/Mx6XMeJoXpHiMLS1qTDgjomMo5hVdek9LIlathIBFwyGw47l5QCcOlAVK/uNe3slWD3NAojPv3DiFCzPJGPPn3JX8jiuHVgovRGE1Ah3LeLVWWXdo8eJrl8TvTp/ZYBOitNWKj8sONCFbUiLCzb8G2qZeMWusxpigwXItEqK7qc95kqEF0OBlkWW8UGkOiFaRnZS0+uQuAyhyP9X2Qlm6w8vROXltY6xUv0i/kobAn42rKM0E2c9xqYrByQnszqg8XEs22ARFPP1o1NQtH2s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:40:42.0003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b704384-6ba3-43d9-6c40-08df13268deb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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

CP resume through MMIO programming is no longer
supported on GFX 12.0 and later generations. Remove
this obsolete code to prevent it from being carried
forward into future GFX generations.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 129 ++-----------------------
 1 file changed, 7 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ec1e142549c5..a9bd0c9f83b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2707,108 +2707,6 @@ static int gfx_v12_0_cp_gfx_start(struct amdgpu_device *adev)
 		     adev->gfx.config.max_hw_contexts - 1);
 	WREG32_SOC15(GC, 0, regCP_DEVICE_ID, 1);
 
-	if (!amdgpu_async_gfx_ring)
-		gfx_v12_0_cp_gfx_enable(adev, true);
-
-	return 0;
-}
-
-static void gfx_v12_0_cp_gfx_switch_pipe(struct amdgpu_device *adev,
-					 CP_PIPE_ID pipe)
-{
-	u32 tmp;
-
-	tmp = RREG32_SOC15(GC, 0, regGRBM_GFX_CNTL);
-	tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, pipe);
-
-	WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, tmp);
-}
-
-static void gfx_v12_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
-					  struct amdgpu_ring *ring)
-{
-	u32 tmp;
-
-	tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
-	if (ring->use_doorbell) {
-		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_OFFSET, ring->doorbell_index);
-		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_EN, 1);
-	} else {
-		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_EN, 0);
-	}
-	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL, tmp);
-
-	tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
-			    DOORBELL_RANGE_LOWER, ring->doorbell_index);
-	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_LOWER, tmp);
-
-	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_UPPER,
-		     CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_MASK);
-}
-
-static int gfx_v12_0_cp_gfx_resume(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring;
-	u32 tmp;
-	u32 rb_bufsz;
-	u64 rb_addr, rptr_addr, wptr_gpu_addr;
-
-	/* Set the write pointer delay */
-	WREG32_SOC15(GC, 0, regCP_RB_WPTR_DELAY, 0);
-
-	/* set the RB to use vmid 0 */
-	WREG32_SOC15(GC, 0, regCP_RB_VMID, 0);
-
-	/* Init gfx ring 0 for pipe 0 */
-	mutex_lock(&adev->srbm_mutex);
-	gfx_v12_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
-
-	/* Set ring buffer size */
-	ring = &adev->gfx.gfx_ring[0];
-	rb_bufsz = order_base_2(ring->ring_size / 8);
-	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
-	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
-	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
-
-	/* Initialize the ring buffer's write pointers */
-	ring->wptr = 0;
-	WREG32_SOC15(GC, 0, regCP_RB0_WPTR, lower_32_bits(ring->wptr));
-	WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI, upper_32_bits(ring->wptr));
-
-	/* set the wb address whether it's enabled or not */
-	rptr_addr = ring->rptr_gpu_addr;
-	WREG32_SOC15(GC, 0, regCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
-	WREG32_SOC15(GC, 0, regCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
-		     CP_RB_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
-
-	wptr_gpu_addr = ring->wptr_gpu_addr;
-	WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO,
-		     lower_32_bits(wptr_gpu_addr));
-	WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI,
-		     upper_32_bits(wptr_gpu_addr));
-
-	mdelay(1);
-	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
-
-	rb_addr = ring->gpu_addr >> 8;
-	WREG32_SOC15(GC, 0, regCP_RB0_BASE, rb_addr);
-	WREG32_SOC15(GC, 0, regCP_RB0_BASE_HI, upper_32_bits(rb_addr));
-
-	WREG32_SOC15(GC, 0, regCP_RB_ACTIVE, 1);
-
-	gfx_v12_0_cp_gfx_set_doorbell(adev, ring);
-	mutex_unlock(&adev->srbm_mutex);
-
-	/* Switch to pipe 0 */
-	mutex_lock(&adev->srbm_mutex);
-	gfx_v12_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
-	mutex_unlock(&adev->srbm_mutex);
-
-	/* start the ring */
-	gfx_v12_0_cp_gfx_start(adev);
 	return 0;
 }
 
@@ -3511,9 +3409,6 @@ static int gfx_v12_0_kcq_resume(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (!amdgpu_async_gfx_ring)
-		gfx_v12_0_cp_compute_enable(adev, true);
-
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		r = gfx_v12_0_kcq_init_queue(&adev->gfx.compute_ring[i]);
 		if (r)
@@ -3544,10 +3439,8 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
 
 	gfx_v12_0_cp_set_doorbell_range(adev);
 
-	if (amdgpu_async_gfx_ring) {
-		gfx_v12_0_cp_compute_enable(adev, true);
-		gfx_v12_0_cp_gfx_enable(adev, true);
-	}
+	gfx_v12_0_cp_compute_enable(adev, true);
+	gfx_v12_0_cp_gfx_enable(adev, true);
 
 	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init) {
 		r = amdgpu_mes_kiq_hw_init(adev, 0);
@@ -3569,15 +3462,9 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (!amdgpu_async_gfx_ring) {
-		r = gfx_v12_0_cp_gfx_resume(adev);
-		if (r)
-			return r;
-	} else {
-		r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
-		if (r)
-			return r;
-	}
+	r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+	if (r)
+		return r;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 		ring = &adev->gfx.gfx_ring[i];
@@ -3893,10 +3780,8 @@ static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 
 	if (!adev->no_hw_access) {
-		if (amdgpu_async_gfx_ring) {
-			if (amdgpu_gfx_disable_kgq(adev, 0))
-				DRM_ERROR("KGQ disable failed\n");
-		}
+		if (amdgpu_gfx_disable_kgq(adev, 0))
+			DRM_ERROR("KGQ disable failed\n");
 
 		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
-- 
2.17.1

