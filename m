Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E724C83F04
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A794610E625;
	Tue,  1 Jul 2025 18:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cl4XycD9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FE710E625
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glDoKw3eqW+u+bzOlFeq7mY1R1xCtZxDhB+MuvyP1M9jA/nWeFO8RzebV7zrIdyCGkOSt2FUqPYkcVBHEOOV93upvGX21yVTmlDmNBS16yCxXKvE5z26BB8mDN4KkOYVEoVQMrmmM7LPvQiLQy1AuUnnY4T2zg2UD99Cf6N8Xs2st6gKK+Cu2pA2m4gIEFV9GFG5orLOgGHP3mJx4ioVhyDJN4ecje9vnwGAHOFAyxbAhlaOqko06aahi9Vwe9P7s/AXzeDfkWENqiN+ZUDsCf79H5eW/DDAJQbwMId7u57YfggjWmD3ALj+HDQ+r8pCNdcxyYIrBlCjAfzBcHiTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntTZGBXIUpav0emLwJwFaCOfyvkCgpMWZIkjwW+koJc=;
 b=wnkjSSn3ruDD0ujoVop1hu9ZCmhw5rOtUyEsMuQ2gJgAWH9Mg4qEy47ZR3nBqoM7WgtwWv2/xAqtO+L6XjXyJABYOcqs/PugTwNIZstWzuI9Ana/O/lApw+72Dzr0XRRNT0m8Gh7qoDWsyxROEnRQK76VnIoHRic+/UdqdDhdQYap1Od5xEnOeBtRtsWavWh2Qabq4Tp2EK18fOGgmXYPPOksgumbB3QLq6LqgX39kzMY0Hqa8pUMK3ErVUP0b9IkLnOJGqmmUIG0fkOkQVVKSbMkFu6q69hosrhPoRC8N5rslNU1xzODKd7UM+pZhuVbTwpi/xl3Pu4iNG7g2tUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntTZGBXIUpav0emLwJwFaCOfyvkCgpMWZIkjwW+koJc=;
 b=Cl4XycD9ZB5CuMPnu8JxciHPqkHkStUdy6gqG4HAytZujVU+Is03tfr/Gr5dxVy67i0wCZ7NjuirvA9h82KdjrgkY5J1YTWzkLTvdanVZyjx83yJHAT09vHNNYNX9+cNuhxrf3/sfEsUg4d17HY21fwf09Y+FngesAYpcjprd7E=
Received: from BL1PR13CA0408.namprd13.prod.outlook.com (2603:10b6:208:2c2::23)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 1 Jul
 2025 18:45:11 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::dd) by BL1PR13CA0408.outlook.office365.com
 (2603:10b6:208:2c2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 18:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/28] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:29 -0400
Message-ID: <20250701184451.11868-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e7682e-8fbf-4d69-519c-08ddb8cf68a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mvYCkLKPJ28QLrnR1hZdVbKTwT08Tsw7MWdiWyrhGV7Dic6zQbp0Tb42638y?=
 =?us-ascii?Q?tc92Jkw6PHKfCyfoNszXOVlQANUIipppuOviVYlgiswQCScbm2wTAwSaa3Ya?=
 =?us-ascii?Q?9DbM38Y5HeuuXUMXjOsPqht9WtoZ+qs+NOrG5xBOjbBeZM9ls31leFmoGAc8?=
 =?us-ascii?Q?2j7nGIA8lyVpCwcZJts7zxFObtCTKwiAStmVOwJbcRu4WLPAP05mJQGeJ65C?=
 =?us-ascii?Q?jtIzllrVpCTxNvGgeZ2Nqx9VZFXwAjNFUm0+/rS3bYcNdTfkxh8Mtntyodku?=
 =?us-ascii?Q?QsGeg/sMAYZ0PrlV11+4j7kjKfQZep8x6DmG/on8KxJOoqolWoE9Kj4qgD1Z?=
 =?us-ascii?Q?LLCTGL2UeegsMa5BA9x6HUUC2JmjC6xSWTtV92nlD/vwTplQWz5k09QcMN36?=
 =?us-ascii?Q?gJpSGCGEkbmIWlLkj5ZmA0x2fomuFqE9ZKMMoob7rLtwDbf9IA90a8p8Edll?=
 =?us-ascii?Q?9SiiiSGwJ1RTs9DbbC/QrjwWEWONvYHqqD+X+Ufkw+qfZ4fWc0F8TfJXpXoY?=
 =?us-ascii?Q?QccbgvjbsZk45gKKWIjRJzAqXpUhID22QtEWzt+00ohUC4GtEQlXOkECmYsg?=
 =?us-ascii?Q?9mWoDsCtSuPBOAqqPooKeoh93j69KgSoqNkJPuzIt9uuY5OAlW5H0NyEcHx/?=
 =?us-ascii?Q?Wm0Y/Dd2BchmaIHdRhFRHa/VQF+WKuWXw1z/60++h41obm9UX9SRZ9fKPWEt?=
 =?us-ascii?Q?Uk0/aPrMPfj+n1OeGP/HAswwGHq+1uDMrGciB3LZXg6089Wg4VfmxZv1f00m?=
 =?us-ascii?Q?upA9IfnXcGCl+lRxqNiYFjjo8YwfEO2iyBuYesYcOphIq56twbMwQop9JayY?=
 =?us-ascii?Q?wO9orW631BoBAfZDcjK/yibM8nzVK1qk3wAqxq7uzIvOg4Y3TZrykZhgoya5?=
 =?us-ascii?Q?lLsdnc78SqK4uCXJspuaQR0AECb684mqAw87ng+FqKDocBOwyN06EK8HU1B/?=
 =?us-ascii?Q?g089w88IrO5qohDAQ/GxvTaQr28pDWuaOIkx1aCvL74y04fBx69sGWUoRFnz?=
 =?us-ascii?Q?DhcZoL4Rm97TchQx/b91raGtclq4Km/D8OtKeVAe8/VD8d8jdcXneTgJ1S0v?=
 =?us-ascii?Q?BZAD+iX716uxI2l9lojGOkSL3h5o8cYccUzt0S0ZNtzAPnwCy8Uypscfup13?=
 =?us-ascii?Q?49BxDxR8lLKV8uD/JtclQc9WS20hH0GDzdtAUbpc9KL+LM1kWSxSOJlrv5dZ?=
 =?us-ascii?Q?uIk0e6+x+hqcIxFecYatoYJi3sPScP+LrmhQbDjGVSXyV+Ul6bTYipeIsgc3?=
 =?us-ascii?Q?LRoM6yqxLqr8E+UBQ3zmrYccEdNxDD0wRKSLJ4MC4W+6o/TVEIdq5vucqD+V?=
 =?us-ascii?Q?t3fVaFjLrSYFFBafhCz23r9fpCPh0yl98U+vQBBpTMGli/8twvtcD1xSyxWE?=
 =?us-ascii?Q?sMdkV3MDj6k+x0KObg5YGiYf23kl9dJfASToUblLGO/Hc5qZqGeYNzCKmfyF?=
 =?us-ascii?Q?iMezrF6lNHHGKOkguEimmUUMROUf3zpYSWifFODuhCqolgbSGLf5Ymky6ZFn?=
 =?us-ascii?Q?LBWrCn9qteK1QfTW9ESfCejGAyLbYbZjRGeH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:10.9316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e7682e-8fbf-4d69-519c-08ddb8cf68a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 41 ++++----------------------
 1 file changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5e099b5dc9a3c..65429afb33ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9046,21 +9046,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9540,7 +9525,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9589,12 +9574,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9613,7 +9593,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9625,9 +9605,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9663,18 +9642,12 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -9909,7 +9882,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9950,7 +9922,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.50.0

