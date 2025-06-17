Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1774BC73C66
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E80010E488;
	Tue, 17 Jun 2025 03:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XGLEflbK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B9510E485
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rkm0ybwcomIOD4joKglcOaTl1puST4+v5PNv4j1FHM4qAgJuRpMcc8mCAUAqiog47SIfFYrqRTmaUwSgLDoxKVw2t8xTgoyyd6v7phFWd7wSHJAfoLbixmTLEPUPtM6UNnwRHAh53rQaJu2lNrjogs0wr0lNooed1usM0QJnpAIpaI395wkzGbY5AO3nvG/bgOW6XAfMb+xFH+LCoZOOC9VRyBP/G4PLCkZ6ysgwJ0dgSbUSka5JoS24cnLTT+JjgonD07BzsZh+RctQxgkjWuvBc99u8p0pF5fA5n9tvFel2ONGd3/UOEKytpc3buJW4YP88QkYFHOwfIaeJ4EFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS7GBDQ3NMMAqPQ4GRwRsW9oWoWMk2f6BlZIJkXCM8k=;
 b=DiiEXWoYd3cPzRiA0xmrS6uRJ8XT8fcXaZfbV/QPkJt5DPwyilE9NEg3g838en0gcIpYM6EtXMS+5YqfDN1HliV6jrorewNVP7CAAg8pPhZfCT6t9Iz5LWJxykpo7QBQREa+ooDOEcidHZbs58rXFvt1dqz5cudNuKYmsG/sAOAsi/gO3pAAZq7KuOZaRccgEOxrOujg8jdWFV4uGDD8EDYxSWcKdQBZACkDzyIrCSWnzfMahY7JdQJyWYAWT5BR8796Db6NlomV7BcPA7BoAXzrhXGdtBzmBhBl/zBxK8GU8UZvVquxMT+Yj5AgRUJL+uyNb/wncIAP2F2FlLZS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS7GBDQ3NMMAqPQ4GRwRsW9oWoWMk2f6BlZIJkXCM8k=;
 b=XGLEflbKfoqh6uIvAEfso1jV8UYLToYvsSUz7rARvMS/GJv2Tn9YYY7Hp3SBxV+95nFoWSCWMAyFAHWwwfO+iKE/A+zLBgxmzQQU2Qv2ccswN6y39x+yrlQ/LS0T6d6NFqY7oJ5k9S2NZKMj66j+aFcGHdYaO/z/voc5kXjddb0=
Received: from MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 03:08:45 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::10) by MW4PR03CA0180.outlook.office365.com
 (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Tue,
 17 Jun 2025 03:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/36] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:07:56 -0400
Message-ID: <20250617030815.5785-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d85d94b-151b-4771-3481-08ddad4c4588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PH3PdAs+E+0e1H1fb4kJViCKjtkFR3RpSaGdX/ZUFoDXZ1VHLSb0d0LmvLTh?=
 =?us-ascii?Q?D3SSLM8d9ER45583twISshGvRaTcOLJqboJoSw2RmhP3F1K9NtJhsDrY3+GQ?=
 =?us-ascii?Q?b9UuMCfwEYX7m13aW/RuiqpzXx/LM6vomcjouEiQ0SDrWHB3FgORgbD49upV?=
 =?us-ascii?Q?8ZusQkn5SiOj3F7HXz1aiolZO+Kfwkgutre88NRmmhhT/RH9SNwpjaPnP2Rx?=
 =?us-ascii?Q?ioxddBVOETRf4waY9U+/WZfg+F9qMAM60H7LoJQSGyDIRCsYbFdANFs8zml+?=
 =?us-ascii?Q?rNuUTI0LUYXkfhvbGFTj+lcbaSxyRmrywOsLruwXOejQe0Gd6QOUrFv6j9NG?=
 =?us-ascii?Q?HDRHzSDnJUtaRMwra0VVuUid3X5Ddt2CZ3pcOOc0Iq7Ya0iS08d4yVURVKHu?=
 =?us-ascii?Q?FxVyjmpLnKUoKPFP77sySlr0/fZO2Ym0hIhYezZ0kyu6AWCk+gDql1BCk6XR?=
 =?us-ascii?Q?Br6ir8FpS/daRk/0RZawA7r51v1eMOPCnXIKQXVAc5PWB/Mmh907FZn7ZOQa?=
 =?us-ascii?Q?CTdFA539Pnv9UJN9uB70CBGse+NejeElNlMoabgw/hz++YtaXWuV97GNy4/l?=
 =?us-ascii?Q?yORuZ8zCmCxzBeG21Q/NWvGaC3ZP6Vll3UDvZUl4yqzGcNe2oB8rvCouAXyc?=
 =?us-ascii?Q?pYTu4DuL0ub36n7KK/tNx3Oqta6lmb0y07opeX5wSbknqBXwZjxCqYWFiV1G?=
 =?us-ascii?Q?JyhnF1yOFdvJDEzdVcYqYj2Ez+NCnWZ8ztFyEXvkjW380YgD1Rpn+ZK6gEIk?=
 =?us-ascii?Q?6wopoWRNQJuqN1YO3DZZYv/QJPGQyCYD6X6tI34FEHHylqi7ld30E7JeLEb6?=
 =?us-ascii?Q?7am7jSMC2xMzz2i1fjECzyEImUsfy6B4R87I8mrCn5bc/0/60hEo8lkwfA97?=
 =?us-ascii?Q?sV0z5Ey4prb4IUncYsKORaEipYNQdTB59Fkqe+5uBb8dXl3heplX3yZRsBkA?=
 =?us-ascii?Q?XNg0t7HwD0eaaDEs9eiKoHeX6ruSBBdL8TKtFyeNXznPLcWXHkEYTEu722i/?=
 =?us-ascii?Q?o3D5kf/TiuB5ztN4s/5UpHlRK9PZhMZDBmh1YXprxqePxqRu+1/OwOOMmA4/?=
 =?us-ascii?Q?Wuz7pMacD3ApHWTCypQF9q6tfix2rwKHN09+kByE1EJOtFQ/AfOyu6g921QW?=
 =?us-ascii?Q?KTMSEJ/4d9FWaJCDQpDGPzLKNqu3fz8LML8MntABdWJKGMLxN3xSqooN85eW?=
 =?us-ascii?Q?FMUmZFMN4B+U5ItImIxPZLDh84c5XXNo+0GWBnOtFC4GTmYEmiew+VbMTw5M?=
 =?us-ascii?Q?aSBIs1wK+95bbFgRYCT7QduFcuIzcUPg4Rk1He1IgcItbZiJpr5Of2oEcrmE?=
 =?us-ascii?Q?0YxTCZXZYMqHPpam3hrVJosd+S2bfYPPx5ZNkB4r/rv0ErBYKU3rQkAT6Qsl?=
 =?us-ascii?Q?0/8RLHMx1jMtEh9V+g4yidR8pjFBDV8isIABDjx8jR9CgkbYkN/p1IfS1TSd?=
 =?us-ascii?Q?1C86JUHUFomuewhfOyq/GLrxfl/b6EAEWoH42UScO+O5PLwKDpH7LXb3XlO1?=
 =?us-ascii?Q?w39iWCDEVG6mbiQ4V5mxBvBW1/cv2V0cgxvZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:45.0800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d85d94b-151b-4771-3481-08ddad4c4588
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 75196c0ba84b9..98253eeaa07a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6283,21 +6283,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v11_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -6821,7 +6806,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
@@ -6844,12 +6829,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -6992,7 +6972,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
@@ -7013,12 +6993,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -7254,7 +7229,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7296,7 +7270,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

