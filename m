Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDE6C71159
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB2D10E489;
	Tue, 17 Jun 2025 03:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FVV3y0Ol";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80B410E485
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXSOUm14OEUjX5ELsGD+MBBllDg2dSNPF5pkyxsE99+KxyfEEfWoTQ4D0Pq6YiW/p1PXrWXSG2ll5r99dKjolSWe9llp5AYNejjhZEuOFnO22pbYSbGhsVxLIIIRdl0sU8VeM/7ct685F5J9C/HvCUxOgmf0twu/y4GHP8MkdcPogLL/jsnVWXdNfUWay2Md+3M9/X9QGEtG2rsvqyiSznzBgtgQLV4f3zubIcfkCpUVpLFYQSmf2sal93MYK/qCW6rytc02FQn0Q1N76jezCiATv3kixZPwGltTC71C/Nb6jZAKtS9/cNFXbsmW75z6G74sG1hSOCh6ShT8+Z698w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq5bhsp43mp/1CKreVKHn+V9BrxIiC40wvI/l0reH9k=;
 b=eRfKrjKUyCGE9dficANgIVD2ePSJkxgZEaC3/g/sLUT5EnKPWE8r3Y5OXgzmAK8sIgLW3e8m6rnWJUDOgFbdyRyo5SXtZowEys4AzJnsYey2bHx6egkYjxboX74izRAXYSUjRTOrMLB52PaVyqA6VYboEidhRg8CAh8M2Ry5BcckNIq51Jfjsvrj1+EPP1ldWDU7867hm5TtS9n42t2tK12ad+APLtLL/NZzu3ZCUpX09M/3k9beYkVIzz/tH6xFEKNwwHA5hmwumHLar3isgbP96/1clLDza8k0jp7VKqnDydydwsKzmV++ST5WGYkBFZCo1+uv2PGNG6dvuFLJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq5bhsp43mp/1CKreVKHn+V9BrxIiC40wvI/l0reH9k=;
 b=FVV3y0Ol9Jgo8U5uLtd+ufjvpqmVMKidbu25n4VdDBaeCEI0FmsRDXwErpib3XdFLBMVpLmBndZUvHNu//8q8kV7tg3zh405sqPsmy2Ia2+H7I1jIZwM3dMC3nnq+mmi4YnNS1/fp6jJnrv+0hw7VeYmZWT1gVtUy57fm/XGl/g=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 17 Jun
 2025 03:08:45 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::b9) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 03:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
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
Subject: [PATCH 18/36] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:07:57 -0400
Message-ID: <20250617030815.5785-19-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e4909d-c9f6-4c8a-4c6d-08ddad4c45bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t46qCgvczk9zaNgh3e4SeDzeq+WVvn5a6Sv5sSTI7lGN+CAnttN8k2Qjidg9?=
 =?us-ascii?Q?5FbfWkQrHDz9K0QgRKFZuHr2EY/xu1W+BuK4KtTliIFHZLBlnkDL48hwRc3K?=
 =?us-ascii?Q?+0YNCZvOz3FgdxfsgfCcbXlZcADjducNIn6oykk5O36Jxmjc67l6wXkCCA6m?=
 =?us-ascii?Q?0cQcT9gmXeGgEyAoYgC5qH7Fy1DztRYyIjIfb9yQKzYcaaIBiRyimSY3m0TA?=
 =?us-ascii?Q?3NhCVYdVoYFyby9nkCIiN1hLBxRAz+wEmC7VZg+IfgXxEzBkiVT1ZfE2NoQS?=
 =?us-ascii?Q?irkuiD3Q5HzhPDp2/qp6ZvSzDuMpHexBK3MWb2aYFTJXEW1L2jiZzaQJ5lcg?=
 =?us-ascii?Q?4lP6+XzTMLaf1vZmdI1D4rno7nAM8EjIWBNyPiC3ie2GMif3Vsoza5etwC8P?=
 =?us-ascii?Q?8GwLcvsnh5a4Y0GJQQn1Cp+o1qjXqpkENbNFxzybY0wQjrQJND7Zo6k+O6DP?=
 =?us-ascii?Q?1lEUb02VYzgiu5oR0pYQnG/iBEF4keiXH1LOghV/I3K/2RSWvoeOtAadm+4D?=
 =?us-ascii?Q?y1svCNNBb8D/e1s4pBJ6Ufj1ZlfxOh+Pa728daTCx3KSRUNjGiGrA8nl7+Zr?=
 =?us-ascii?Q?zBMMAJbGJO/dg0PBZOUT7vYsKEvnXZ3YSj54QV5PdzNlNtf7muPTUxAw/+A1?=
 =?us-ascii?Q?177IGzeO6s94qrwNDV/DO6ZHtqBVIPBA26umybNy3HhdGIJ57B4vSlrSuWS8?=
 =?us-ascii?Q?IeAEgC34LlfNQt0Kx/Kk8aRhFo6Nd7TZOMD+evM4ges6BCthc6BJAk6dpR/g?=
 =?us-ascii?Q?UmVIl/V8oSDA2l7JxWIOQn+7gdSU9LPrCxLCOY5BXmS2KceaHDagxX5SmoEm?=
 =?us-ascii?Q?Cn7jR0FPspxKWZ1XUiAVC1GfKLOOzkOcXw4JdN1SH4JIffP4+dgpyHrfzMi8?=
 =?us-ascii?Q?0JxSd6U73fkYhF+wRuMvav+7CBSjIgak7QZmIWO5zG6zekwBdzqwAjactDgi?=
 =?us-ascii?Q?74IrMHcu7obMAz3PDyLoWdr7uICoTtu8nvlxXsTRAphoice79Vz2xpnNNWne?=
 =?us-ascii?Q?zFOZyW/uZLS6fPuD8et+tkm11UBRdqB1Ea3WFa1PtffxWfv1xoB6rGTKX8rs?=
 =?us-ascii?Q?VLneBnu0ZpfuLFm8Pmn7NgDs/Xk3nxIfhACyuYsscMu2VZoodSiL/iGjI2DQ?=
 =?us-ascii?Q?PkpMJGobNItC8ZXHDE8XKsY+uQBc887eRtTpHr38mxlDrj2oGZT8YyviFf+o?=
 =?us-ascii?Q?S1ofmcK6LBTRs5GMSA3fmDAnAZUFc4KyX4idrg4SGksryOT1nYcvhjHUuaqI?=
 =?us-ascii?Q?BJV6B5kmy9pJyyFAaMfa1GWaoI51Q/EJmChtIvscp0gsR0U82VAxpTNFQnIJ?=
 =?us-ascii?Q?+kZ9lcm4wWBLB8gCjow6soWsu92rDYMa0/xWMs2QHVm/AWrk955mkfXKFuny?=
 =?us-ascii?Q?qe9Qs7WXSflp6OE1ICE9UNlNJMzWgD5dT9EwD9Ym07Wn4DNINcFFxqqEqVgC?=
 =?us-ascii?Q?0JPQbWEWZ0TWsy3+pOs+0ZCUqo4tobg1UUIoFHKxMT1vgW63d6GGyG536oYy?=
 =?us-ascii?Q?+8Q81wTNyW/KcYzTg5QPPErSac+sog8yuRZt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:45.4410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e4909d-c9f6-4c8a-4c6d-08ddad4c45bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 543429054bfcd..2f7968360bd39 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4690,21 +4690,6 @@ static void gfx_v12_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v12_0_ring_soft_recovery(struct amdgpu_ring *ring,
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
 gfx_v12_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -5317,7 +5302,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
@@ -5339,12 +5324,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
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
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5440,7 +5420,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
@@ -5461,12 +5441,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
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
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
@@ -5544,7 +5519,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
@@ -5583,7 +5557,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

