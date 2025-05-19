Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB28CC2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 18:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2B010E452;
	Mon, 19 May 2025 18:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fK54aVJg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C30210E43A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 18:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS9gpfVQrcXpWVAu9N+QJXA37I/wqr3coU8LuqcVUkpcHEdCaVqrdhTiNGvCNmzxNbqijp7aAI1ofbkWoeNRwh+tKiBTg8ragg3AvZ0+4wUbjLD/DDqRPnlvvvFYeZ/xd+Ng1TCdoG5inKiOJlNi4v5Cy7/JDxBd6jhIzpyA9sfotGJz2DY1oWFUVBYLbZR7Ijmb13Me0B0BFtVKzCrXzCdBnMhY2xOMr44VCWNMjFCbfzwILX5TPMH7i7cTc9wn7ZOf0J12OrkS/FkcEYe4gU47Nb1GDO8IDRYLJW6/cAE7OR4exq+gXQvb+4NeiGyhQL5LjG6RxmhMrcdrARNizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1EpdHwx/i4qM4cKiAIQR/d2Iz6TfTtlepvLU1VOI5o=;
 b=V70tJRZCgU9kMyjD2OnhBaXDCB8Bu1d1E77WzCD660h0/VQjDA9b30HL/Knr0fo33fcAX1pSWY6Rxn3PQo1NOuSG6AYMEhhxcb9RFPc1zJs0wL6hAnSNouDuapyXJYEBkbCg7zn4LF1mI0RuAI7PUmInphbo68YADvU1QF/PgOG9i4mshjgWs+cVXeY+BAtfPe/8wM0ip7+bchvGHrmbdWzujs26Bbdhk3wzNgkVIpkBXxBLxMU3376GJhXwHo2X9mUn+ka2i0hbLeMyO8LVtISqSYTHgIPujtcpvDN6RaAvNhuVLHovTTRyu8Xp43YQGGcVzsJzOCieJI9Ghb79IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1EpdHwx/i4qM4cKiAIQR/d2Iz6TfTtlepvLU1VOI5o=;
 b=fK54aVJgoCTkpODzsW7heyIYTOScFaJ8ZylpAvYdQPFRc5yTv31b8fzDJf6+IQr5P8DuZpqkhJqd9YUBLpz7ivUdoGHjjsYuFUCLOhAur63k3Hwz3Sh4AxOqMPU+fqjIpMuuoLDQzuPdSNAd0MiH9jZ5Gp4KZ8lSh/ovIFxeDGw=
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 18:22:28 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::cb) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Mon,
 19 May 2025 18:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 18:22:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 13:22:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: rework gfx8 queue reset
Date: Mon, 19 May 2025 14:22:06 -0400
Message-ID: <20250519182209.18273-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519182209.18273-1-alexander.deucher@amd.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 6175d4b7-b7ec-4af8-c520-08dd97021c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkRhcUEzcmtBcExFVzUvMFVIUzFkek8rVXZwYXphNFlQSWU2a0l0TUNpaTN5?=
 =?utf-8?B?VEVyTHRIVFRxWEcwYTI4RkxPTTBPdk1Ub2VCb3VvRHYzdWJsTVVQKzFsODBh?=
 =?utf-8?B?VTlOVDdxOFFEK0lHV09GU0VZT3pFWFBoWmNpcjFnaFQvOXI2bEIzQU96RUk0?=
 =?utf-8?B?WUtBUFdFY2FQVUFxd1RDMzRURDFVdXdJWkE0UlVPSXBTeGNsbTlteWxCci9T?=
 =?utf-8?B?cEZSbXpWWFNpdk1oVyswTXNoN1dCdTlBOXBWREJYTVlOU2pWNUlSVVUybFpt?=
 =?utf-8?B?eDk4R1JJNlZ4WmVOTTlqTnY1REFrc1ZFY2twMjZ1a09UNytHSmpQVXk2alFa?=
 =?utf-8?B?eDd4Q1htRnY5c2dCN0Y1TVZXNzl0eE1rQWE3L2ZMWHR2Ly9reGlMRUpGcHp0?=
 =?utf-8?B?RW94R2lqUWRsV1ZtK3U0L1Rvd1Urc3U5anhnTVZmeGtOUDZJRzB5dFYxR1RB?=
 =?utf-8?B?TFJST1lvbUxMUU1EU2k1Wm85SDhveGl1ZXpzdS9wbjNORElZYmJoN3BVZ3dZ?=
 =?utf-8?B?TVZIeGNObFlMZ0lGR1BTeUNTdXlob0RJR1lrL1RGb2JRdnNMSGhNQWhKcDd4?=
 =?utf-8?B?L3VRcUtFc0RkcndRb05Bdy8yUXhlYStTQUtVRGp0SFVxUWNud2R6UkRwV2lJ?=
 =?utf-8?B?cyt0blZrTjFGc3RsSk9wVC9DU21NdURtUWZTWVdEQmROcHZiQ05oVWIvRHNo?=
 =?utf-8?B?Q2dvQm83cHBYdFRpVzRwc3IzVjcyc0JndnpOQ2ttQTJCdG1HV2d1ZUk3d1dN?=
 =?utf-8?B?MEYyR0RsekJuR29rUkc5bUIxNVdFek9PNGdIdi9RczBVSUh1T3hQdGgweTlx?=
 =?utf-8?B?dGF6ZzB3TUdHZzZ5bkErQm1oYmQ4SzRIbzdjK2NxYkdsaC9DR0dXb0RTUGVk?=
 =?utf-8?B?a0V0ZkM3RHV5QUk5QmFKc0FtajZwRXdMajVUZVdHWVc5ZnhHb0gvWk8yZDND?=
 =?utf-8?B?YjdZSStzeEI4YzB6bHlIVzdNY0FoWXl5MTU2V2s2QVd5WnZOamlmYnFsdU5v?=
 =?utf-8?B?alFDVG9HVStKRFljb3pocEVsaVkyczYrYXRFMWxsVS81NG5DQ0MzeUM4Vkda?=
 =?utf-8?B?b1JDSDI1L214eDJEUUVQQ3Riczl0aHVCbXFKTWlYd0xaTWVmM0FtcTdCR2lS?=
 =?utf-8?B?WTErS2JuYUhSTW5pNzZIbFNOZzhUODZGeFJCbnlxV282OWtRSVBUaFliWUVJ?=
 =?utf-8?B?a2w0UXBMTGZ3cFMxTURZTzByelByblRwc3dtSitJdENoS0tSSjhBSmViTFBa?=
 =?utf-8?B?V3V2U0xRRXpva05Pc0VZSmx0bExJUGpEQ1NjVGZpamxWemtRdEEzWVBYY0Y3?=
 =?utf-8?B?c0MwbXFyOE1GNlB5QUVwZGlFRW5RVGhFRnNrQ0hhQmUrYjROcUZzZjBvWVEv?=
 =?utf-8?B?L0VYTlR0TktTNkRTdTRmQ2pJbVBUUDBQOHVJTDd1cnI5OHBlbml2OGtxaTBJ?=
 =?utf-8?B?d0crUWlFVXhGbGVhUThXZHdmZldQa011ZGdGejN3cC9DM21hUGg2SnZvcEFB?=
 =?utf-8?B?N2xERncvTGxNSHVBYzhHcy9KZmRtejM2Q1NMbGRJS01sbXNjSkliRXEyeHI3?=
 =?utf-8?B?WHBiZ1F4MjcyZ21iUG1pOWVoS1Ywc1Bkc3Z3TUJRV0xrc0RmTWVQcFgzOC92?=
 =?utf-8?B?dmh4OWo3LzhuRmx6K3VTNDJ1V1NtT2xaWkxuUkRSRnRwOFdzbXpoaTJYTGp3?=
 =?utf-8?B?U1JUcTlaVHlLMzI4VTFpNGtaTW8yOFZOdFd5bjA3bEZNOVVJa0xiNzJhVjV6?=
 =?utf-8?B?M3VKcU0zQlFaWVF1bXVSTHZDWncrb1NsY1dmcG5ieldCYTNxaE4rV0M0YXJm?=
 =?utf-8?B?S0pWcUtIbHowU29saUlnZThwc09NcXpJbzFwd2M1Wm8zb0ZLSEZPaFlTcHU3?=
 =?utf-8?B?bWNpeG05RlI4SXFtWXhEQnhIUEgyTGp0V3g0VkNqMkYwZ1F1SHRmVEFpeGJj?=
 =?utf-8?B?bE42VFkwWEpPRmhHVFFmTUNYRWVpRE5jaVk3MlVjL3dBekNValIvcXBqMml5?=
 =?utf-8?B?S0Z4c3NFN3hQdHg5NStSMnlYNTZELzZlMVU3bWs0WmdoWnJFaFJQak4zS0dm?=
 =?utf-8?Q?H2gjSc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:22:27.2029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6175d4b7-b7ec-4af8-c520-08dd97021c17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Apply the same changes to gfx8 as done to gfx9.

Untested and probably needs some more work.

v2: fix up pipeline_sync count, only emit vmid reset on gfx (Alex)

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 90 ++++++++++++---------------
 1 file changed, 41 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5ee2237d8ee8f..f09f029ecd9d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6140,12 +6140,47 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 
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
+	WARN_ON(mem_space && addr0 & 0x3); /* Dword align */
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
 static void gfx_v8_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
+		amdgpu_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
+		amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+				       ring->fence_drv.sync_seq,
+				       AMDGPU_FENCE_FLAG_EXEC);
+	}
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_MEM_SPACE(1) | /* memory */
 				 WAIT_REG_MEM_FUNCTION(3) | /* equal */
@@ -6339,46 +6374,6 @@ static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 	amdgpu_ring_write(ring, val);
 }
 
-static void gfx_v8_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
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
-static void gfx_v8_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-					uint32_t val, uint32_t mask)
-{
-	gfx_v8_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
-}
-
-static void gfx_v8_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	WREG32(mmSQ_CMD, value);
-}
-
 static void gfx_v8_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 						 enum amdgpu_interrupt_state state)
 {
@@ -6875,14 +6870,13 @@ static int gfx_v8_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
+	if (amdgpu_ring_alloc(ring, 7 + 12 + 5 + 7))
 		return -ENOMEM;
-	gfx_v8_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
-				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
-	gfx_v8_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
 
-	return amdgpu_ring_test_ring(ring);
+	gfx_v8_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v8_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
@@ -6916,7 +6910,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v8_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* maximum 215dw if count 16 IBs in */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		7 + 7 + 5 + 12 + /* PIPELINE_SYNC */
 		VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 9 + /* VM_FLUSH */
 		12 +  /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
@@ -6948,7 +6942,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v8_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v8_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
-	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync,
 	.reset = gfx_v8_0_reset_kgq,
 };
@@ -6983,7 +6976,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
-	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
 	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
 };
-- 
2.49.0

