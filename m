Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66701C677C4
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A899310E8F4;
	Thu,  5 Jun 2025 01:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WkeIe6mm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB0610E839
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnIr6Gu7dGRh3YmQQQoFgQnZy2LbgUxlGpJuYOcbpNyrPglOTW0POLvybzfydtcJRIzxXRlDQiAR7EEuJFqzNtVnjb0Bm6DZGZREM8jo215ajnnPQCi8RwBjSMb9mdKGFMrPuRHk9txjISYhGRl/gO9/YplWoBpqQtJLfacT7R+AoXXeMullHQOJMfdvtRR9dCNJZ7OS2iUeUQ/Pg7WI5+SUvZrc1V8F1ive2CNnKHgS5SpiBqB7xijdjR5fgzR1q/+MClTatI3e6IZwYFBFY8EuWCMPFIMMmjuD9fi80yZoo+qS9do2XUetl4A41Zf3udiiC/GIwIpReE5YRBwSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFaHR9B1KCOvLKfwPy1KOu88oK0wWMv/DaEP7tG4vuo=;
 b=jQX637TBk2YbI/ox/H7nMJzYZk+t1dn/KbgN7sxHwa6a5iTE/iNuSPl8sPeFUb9Vtcsn9/2Jd8EY0MqFYvrwdnlrizGyrVPKK+tDd0mU3ssV2zExWpIGaGT6JC62oy47B2dRWbrl0dJK2RGzE/w1TtBCoRcj8uMkuueLp7G8hmIVOXEt5uBRm/TQWmL0khCC+EM1x0Fibz1HSL1wRB0AKFQ+j8xhG4sKIXcyTxvdST3rkButypqWPyDiKvKLc8it6FTZ1gjUuGvPOeepxJmmcmRJmj4uky9IwyGl0rZIa52zkc5wIxNiVYdabH+/WLDjvRGYbRlwNfJMySD+Bptmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFaHR9B1KCOvLKfwPy1KOu88oK0wWMv/DaEP7tG4vuo=;
 b=WkeIe6mmqUke79h7MhJdWpuC+cbulStmdppYgy8eydnVVM0+Z/xkDngw/ycNU7FosoP/Y+tp9RqlaELb2A3L1U43eV50D0EVzyO6/ckGxSWpe7sZVtZ5d/1fXdecukJLq8ptIkNwD09kkECFiTKaHcvhsHvNEifjU95yiWTzSNY=
Received: from SJ0PR03CA0126.namprd03.prod.outlook.com (2603:10b6:a03:33c::11)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:28 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2d) by SJ0PR03CA0126.outlook.office365.com
 (2603:10b6:a03:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 5 Jun 2025 01:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/31] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:41 -0400
Message-ID: <20250605014602.5915-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ac4de6-6c1e-4ce8-65aa-08dda3d2c9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gTV33bb2LPIMi1jLahrf933FU3trqvM0h7mZ9A+0EUJLmQ51ET9xGk8u5e0v?=
 =?us-ascii?Q?UlGQdv6bWeEk8g3Ejn6NT5fGQFFNuM13dqWJQCP/OcDVs85nK3CdC7dRKIbJ?=
 =?us-ascii?Q?UCz5k9gffgiXbG1sNSrHKvjoxbK7ForUOvY1SRDTD5G86GYkVwLryDijg9gf?=
 =?us-ascii?Q?+UHEr46V9fPe1EBOdxnhXGgbv1wkXKuJhmT48r9A51S17xeT5EQRkUnb3QcS?=
 =?us-ascii?Q?VQE0WYcHJRz6WJkLRD2Oj7d9MeNJ4G3Tc4P09YdjP0wWVbqwCr4yrIvV+v6a?=
 =?us-ascii?Q?4WAk7c5gJqNV7gnhC4fy1tYTajwwf7oz0Be8eVovxC6BgHLy7hALokqjm8tm?=
 =?us-ascii?Q?27xmY++dmMkFR5P+LJGgruBgoc6hVXXz3tspsYT7ucb3GEW3VLMSHOviHJLy?=
 =?us-ascii?Q?ppDpIiYFRJPE6ZSG66QQTrdKkADS0BJElb3bFFyrC6e/SLo0Xx1izK5frQOY?=
 =?us-ascii?Q?UMTRVVazquPKcKtf2HDN+QxDlX2cV8guxBelIPl+VOeabvr25MMcO72RdCHJ?=
 =?us-ascii?Q?520gA9RKGvpdHjFjliPKwYql9rwZsxX9ugWTtqqIrGuzjKH9M4qeoVCboEw5?=
 =?us-ascii?Q?2oW7P4JrfY4/gzHDIsY/ITwaynuT+bHGFNrm2zz7Bi7apfqAUM1bMGY4J/bc?=
 =?us-ascii?Q?xn2Z/ABLXlF+qb2Dbm7DujZ5Ii+0gh0w61in4eKYopRlca9pYqyyDwnGma+V?=
 =?us-ascii?Q?pOBf0q9U3T6ukTq5iX4EYtjlRFx6H7hfjRU0G68DT8M2s6ilg/CAepBJTn/4?=
 =?us-ascii?Q?2BuIFb0J4Mre4iTpYRMoOQJH/XyzgZ7rvZLU+oWXjZKOKB542wpvWSEb+CJJ?=
 =?us-ascii?Q?JKwUV9+sjw3zabe8HL9p5yHOrdVslWTC7rjKi8OfogJFvC9Ae73xSGrbSqQs?=
 =?us-ascii?Q?pyNyxsMBUVGsZqsACwxXp7hWX7zJzkWpjvOApAKFY6RJUhhwSaDO7y2ls/gH?=
 =?us-ascii?Q?U6NuKHIKhfdRk6KZmYh5Rfwa/fz+F1Ca9+1X8Crspl8zEbzWzNvUrvHHvUsC?=
 =?us-ascii?Q?L8crIL2qyTmVRXDZCEdjo0FCtw/2NIG6Cki0RLy/MHdY4bk4dFx+8tKm1k8R?=
 =?us-ascii?Q?VdR4fcJxlkF+zqpBjbGqVxcCAMiDipQo/95o15ck/u5HYbl9rLj4VXeNgX+R?=
 =?us-ascii?Q?ukYOou/a2sxFDCwALawaDiBY9bUJBNxkSkQdAebVDiU9Vu1SYIUSTLxVf/Mu?=
 =?us-ascii?Q?XhPYlg0Us5rlPPXN5PyLHMiCv4d5cb68soB6Jg+/We8pgN/qs1G91jB3enTY?=
 =?us-ascii?Q?lm2Fq31CUvvtco/ckB66KAheDI54bLPkC3S7dQAeze2pABVRulRFeHngNo7o?=
 =?us-ascii?Q?Fn7dKohl5dLhMyKpRMSRLceMuBiAy18cpduDke0t1XWP09S9LQT82G0MswT5?=
 =?us-ascii?Q?Rbh/FB0dbBmwDKgfbJdG1f/r3RuzeEcDAJ06p0F+nvtNTB0Q0XN2yhw2/PMI?=
 =?us-ascii?Q?11abDMDg+eZBdMmqZfLtf9sIUTfsZHD655QcePglc3RVIPrMyazQW0Ax8rUB?=
 =?us-ascii?Q?lhpu2BG6Xf5hS/TziOVTRW6JfEGLmsQiyx2d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:27.7713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ac4de6-6c1e-4ce8-65aa-08dda3d2c9ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index afd6d59164bfa..4e0a6dcce91fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6278,21 +6278,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
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
@@ -6835,7 +6820,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -6995,7 +6980,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -7231,7 +7216,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7273,7 +7257,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

