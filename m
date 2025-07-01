Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9ADC83F03
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB8410E62D;
	Tue,  1 Jul 2025 18:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UugiL+iq";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B9D10E619
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+PkiSZIQ2GOtwrk8XBU40k+QQgej3Etp7HTiDZiUbvtUOjdB9vc2nB+f0yWn/2C3PwGia+6InjjuBgLS7EHqwVo1NJyCE7xzJ/6X3dgMFV6bGFcQ5FrXhVWe0uAvBdnHx64DEJ6dyjqiIrli/Dn4iSodGUkrRrQK3yzRjG6lQHH8XCEESwg8HF+HaKTDG8vZ/tPIBgYHKOAnXvvcsyuIb2amBWebskcI7Q//JzFxLTvWmGARNiWeXRmqM9l/+S+yxt5JOf25oMQ6bLscbYMkxo/iQ2YLNZN0fwfrUQuLgZ+5Ue+I4kXfbQJPTS0C9ubf9JQLKzLoVJcu8zv4PjS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdQwpZrLhMHE6OtkZTzdpCAaCuEIvTE05jEmifUF+oY=;
 b=FbtcvRcy6sD2+zapYk5xtuDYTHOKfDA8K7amOEUALVVnJd8cc3gQBfLg/NBXfPzTmZC7wXofjdUjEOBCzk6EGbP5RpivMYFgqke51q3rmAp3AqfggwdeBtawDntJCSihFW4OC228xCxJMcbFaYfok1y72yVkJRRqcGfMYbR7r6NaPpVmKDJa/PX7EX/S/t75dj51LBhcO+msiUbtiyyoCH1OX3QyJ4SHQLOtw6TdRnMSORIM3W2BKmOqxXHO7L+nlzXrWlY/p3zh4a0Os1jBn8+4fEk1Oeym8BV9bKEgq6mQuolLvGyxK9Bl1gL/fx4xIE6Wogey+iU1auOoiUs08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdQwpZrLhMHE6OtkZTzdpCAaCuEIvTE05jEmifUF+oY=;
 b=UugiL+iqHrU8s8JGG7Lo+pVcxMG0pKAZygCL7VDfICLzzFUfoXb6nDO7deSgiE9T1GlnOekT1y7ZR/haLmNKSrNYK48JDPc2vGgw5bpuzoXZ3k0NFkaPg0SXisU9LIT1mGwSaXU6Dudzg4G4nwGHZBk7Vcoky6naF3md7U8WC54=
Received: from BN9PR03CA0627.namprd03.prod.outlook.com (2603:10b6:408:106::32)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 18:45:12 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::78) by BN9PR03CA0627.outlook.office365.com
 (2603:10b6:408:106::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Tue,
 1 Jul 2025 18:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/28] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:30 -0400
Message-ID: <20250701184451.11868-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 031df2fe-4252-4e47-8161-08ddb8cf68b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n6jhKFR9IW/GP1KGN9hj2WDXHPmY2Nm2QTgINId8BBSNY5KzHQfDPOidjiR+?=
 =?us-ascii?Q?EXGoUJgWj7X+0g0zRxQKeyjdQ8lGgCeBdpShJRQLR8uhKsLQySy8mF1enqlW?=
 =?us-ascii?Q?g/sznN44RFwK/WLE5nUgLnz1DoayfVW7DE4q5TS0UTRaCWfbqcLvbnTCJddp?=
 =?us-ascii?Q?+AJDqKPF4YlKx1Zi4x/jhYa1vwtd5cjG9B0S6OM5W+E0OiuyJmQjIPjQpdVj?=
 =?us-ascii?Q?qc4AsaVfCt1wzV7+lBtXfvdWZ6E8ojEVcAimbYtmjbbwrCB9Irbk0G0w92zm?=
 =?us-ascii?Q?Ph1PgXc9QLqORQ23Duq+PiMJQJewbzsReM63pmTw3yl1yEcmtyCQ/LrQHEkI?=
 =?us-ascii?Q?+wyXkIqQWmPm5DRSdWdsB7VBJPrUL1Px+Vpcv5D7GkeInwjg0S1msSTB+Q9p?=
 =?us-ascii?Q?GtvO/zX+3K6PwHYmHPRHNSizR9+SJa5WdUL38hjHhaGpL67pVNe7XpPVapJF?=
 =?us-ascii?Q?EjmPAvuMma50L+v1hHZyet47EBFYiqltcH0UIOQRIXMJfXOuKDEg0MN1bfax?=
 =?us-ascii?Q?JtthFRBzmH/0rBEt46Ca+8awjTvwNnKYGBgZ0+uIcemTkxXgCMwrj5Tyf1O3?=
 =?us-ascii?Q?X3e5KJsL4C7ukIgTytzgojDr/rVC3tD69YYNhwVN1hGhGgu92YW33OyBxk1I?=
 =?us-ascii?Q?M74+IcVqWSoskqyG/3eZrckKfGng5FFY784vQsWgol1FZiaImNXYbeXzGYmJ?=
 =?us-ascii?Q?XkiwP56/hWphoEszLCZC0WzMU8X9brC26ZqzP7v9HoAKg18CZiKoNxE0EQjn?=
 =?us-ascii?Q?eysBrCJ/BgQlacmtA1jrU69bn2iJZLQ+IT1U5VIYr/w13O44UEKe0EAW/7x0?=
 =?us-ascii?Q?Y4avrYJZVssv30FeTBFHX9HZX65c3Sv3X+P+W83kN+OA660j/j+2IiwOC3M3?=
 =?us-ascii?Q?6ZRgbJAIqS8Mu4CnNZ+q5ZUMXUCmOafYqOmRBI5aCi9Yt9Gsl4fTUZb9MQRa?=
 =?us-ascii?Q?F9LqtwzGzosEkLfQ3flNUMcZELvzFbzBOaqNBKkZIVO8ZWATL0fInd75MDBo?=
 =?us-ascii?Q?g5xzuaL2lz4XIPbPXsSXasoMWAt6BVHhyXc7hmuhPS35Z40QPCPm3Ps4aUyK?=
 =?us-ascii?Q?MnF61eZV/KvOeSngrKlOVeWKFFp2m4GGmeOepaY8WwLUPKn7Bus1kRgpcFe9?=
 =?us-ascii?Q?xFPiFbUEW4mft6Cts8gsJn5TUTaJaAtXb1fR13vDq9WQ6DcBX6JJNa4kKVAP?=
 =?us-ascii?Q?Z0X9Tx3oTAsZ4NVddsPmJxuXpfixVm0aecvErdKlWYIHqrYHu9mAQHQCM1LC?=
 =?us-ascii?Q?VAfijnTafJMHTaOffphm8eQRRF8hIHzUgIo3Uw5KwwOJaVtZlSdEzT1aHIgA?=
 =?us-ascii?Q?Tr4Elo3OKIC8p4kQqM1v1moLRPjew0QJzV+jv4QVjpQRJ6oPuv9vZqWd2jEE?=
 =?us-ascii?Q?fUD1tI+Ikg8dnHO9heDs/sgPt8ukxjIXVGDbT4drAlWV7paouS2kmVBuFDxo?=
 =?us-ascii?Q?a/VvczFlMBo1TGShQ7ddZvTscbaYGnA/vXAWMOsLMeCpwIRmV2C1UKtauInC?=
 =?us-ascii?Q?mrp3UahvhfcSYQujTZTakuwYXqi256VZFyZc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:11.0690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031df2fe-4252-4e47-8161-08ddb8cf68b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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
index 37dcec2d07841..04b2e3def5098 100644
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
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
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
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -6992,7 +6972,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
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
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
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
2.50.0

