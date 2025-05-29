Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5F2C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D0310E769;
	Thu, 29 May 2025 20:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ypgnv1nS";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A80410E755
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJamUyARewt+EdZhT+W1BewmT8PTlA5pprF09taaymJbyZ2S0Yg6SVT3IMt26yJuii4mmGNf8LwMuUeJgHWyco4c6Ixkd9dwwjG7M+ZcqD2cAVY7gWMRWs2MopWOsLTGtBRD8jwkEegX65CIIPNW/dQdZqXXMWdcyYBlmaKhFtaKIaKw1RyEmX912Z3cteFgfXq/YBRGuht4BoyQxM3tINxwetERZwWBDy11ompCpQ/pzUoNlVsdMsna3XDcuEdDhStti8rLkDD3Oq0rXZHlpUzrdQIH5cB+8hUSX+6iMLahwMf6bYNCIZpE9vgBdYeeNV4UjpddcaUIgmA9d+gqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFaHR9B1KCOvLKfwPy1KOu88oK0wWMv/DaEP7tG4vuo=;
 b=tDvoN3xTczqPhuzZV58ybJkl7o+1SPyEKOIMCdvpm5Fd7XwuHjHq37GcjBOII6GrERSSByvwI9Efn1YEzkjUozmFWOO87FfRdfSkXZ2S4bgbLDmT0AfIpnanere+KJQA5lxPBfr2uHwB54xSV8peRTUFNKwnV5YoGXsVnXMI3ZIquOkXUbTCe2Bth7oatKOpCUEAjaSKY8K0oOa8ryFbM9vrv++clMM568RpTtSCydlnDnt2e/vPrfKCFm9pAuvsx/cWvMf7acCKoof2tdVJaUBp5AiCE7m+ajZGv/jAhhaVW2yR483uhBPrcuYjOcGKedho1/AP6TTW5cfh96IZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFaHR9B1KCOvLKfwPy1KOu88oK0wWMv/DaEP7tG4vuo=;
 b=ypgnv1nSurX7p4DO3VFnDJXFYmp+SDfl55/HGl8qbKTs0KzPtJW+wqVYvwQnHW+ACNbflCek1Y+dZKZjAI8WBoGkOES00UlaeoRRJ1UGxgBr0xEVFwx0ZOTD9vIwzmzPJCnNNEzdYYnE4A5lDKFhQ4OFRP1UyBaI2Au02m920FU=
Received: from MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::23)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 20:08:25 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::69) by MW4P220CA0018.outlook.office365.com
 (2603:10b6:303:115::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 29 May 2025 20:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/28] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:39 -0400
Message-ID: <20250529200758.6326-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7c98f7-e7c0-4bcb-96e4-08dd9eec91c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?igkneA2LVqvL6xN2wr3crvIYgrGrOuGAAH/5Zgy0lxZ6VhGLFDJH1JJct4gk?=
 =?us-ascii?Q?PBbPNKLZMEnaFrROaBmSk+PqmhPz3ADrlTP8J3ZLAAKUU0bE2/dHlrckJ4w0?=
 =?us-ascii?Q?Hw/JCtLQIyXJJhJC2qBAukE3k4MWhHMLNFwUbYiNWRIxqDYuJdfsRFuTTzAR?=
 =?us-ascii?Q?Lw731BpJzlV/Mu5ejGgaaVdn/IbyqGCWk25fVE4um2egP4NrbmLX34+MNuC9?=
 =?us-ascii?Q?YHROFddtAdaxF/Pg346JAfB7gab24Eq5nPB+12ZmtygXdScpgR/p32IeH8Mq?=
 =?us-ascii?Q?dfGniLmTPoV2Cs313fIgR9XQPaA2ctNboHwjTgj0woj8BjzJxeShuPYkwTyo?=
 =?us-ascii?Q?xcSjoc7hl7JQETHxU7eoAawgscxmbkuVyKGGR4SqiF53H3RMp3/aGj4GjySy?=
 =?us-ascii?Q?sVK9sOBe47Jmqm5TNDm7YF/XcqvFKBHEPEnHNPF0WvqGGs7ATX5Pxr8F9t9g?=
 =?us-ascii?Q?+ENBtIgH60TrtOfJbptWwjZymLQeygUfGH3stHyIj8Hntbl9AR6M70Hkej1I?=
 =?us-ascii?Q?oW1o0rIVvjZYbUZ82nPZrabKpyNlpDdEzmHMCNgOgRlReLWeeUy3h3K6YCnO?=
 =?us-ascii?Q?Zjy13GzvmUnWGy2jnxunpII+oMICkHrYWXzyB/lHLuhBAD6AAAt8LonqCNsm?=
 =?us-ascii?Q?tUITt0JoxXwr/++0hrt4oCbcOVU/AOOmSipM7qwIx7Sw9BAtbi0gmvIckdem?=
 =?us-ascii?Q?2DwyF3InlAZHW4PG+5MwjkMYYW9XJxtueu3T5ue4qZHTJyV+ELnol36oiM59?=
 =?us-ascii?Q?uHWHecGlXyLjvfo5JdVtPkMMulkMkrNYB6FmhRlxIfZKTahU7ClvOClDNvxc?=
 =?us-ascii?Q?tPXqLT8EsztkklOmTNBnz0msvBTcEQaOQpHxd4Sor1S7Y99gitjsK5jzd6oA?=
 =?us-ascii?Q?EzqBBAO6m882veVNNM3O67nV7J3BNbLr+rj1cQR/JYo14DMohBkFGlfIzdCx?=
 =?us-ascii?Q?h0rcb2E6Tp09Y+UFGJBzNo7Phl1QyTOGjv5xeeoBaaaAG7JckJZW98NKOZBW?=
 =?us-ascii?Q?n+MKgAD/ggq+xT9CrZ9Gp/8FpqPh4UzzV2CEEmt6eRNCyzN9V/PAjs05vQYT?=
 =?us-ascii?Q?B6aOSkS8DtwZe0J2BZYOTHsO++9C4GcAO+g5NPe/CS1mEb+KPFldFFsr4d95?=
 =?us-ascii?Q?YkXf5yJWfw+LgaFf2Hg/Q68cUebT4orOpPcPK/+2ou2+UYdydyA3En29kGvN?=
 =?us-ascii?Q?tBsCo19NHoLMTaY8rq855injFEVk8b3XFxDqKcq0mDieCa0qFQxg4dub3uoK?=
 =?us-ascii?Q?oN4NF3aMxoAQ1GmRaF/amSvagkOS7Hf6hjFFF/lhRkULqtq7EyrSGEQzXP2N?=
 =?us-ascii?Q?TslJGf7JSYPJA8wNnc0iUwZNuSeFkuFZwjXC6d4wmnopZ5sEzPPO4NlKL9kq?=
 =?us-ascii?Q?T8Sx1DiUwOd00sA8z4p4S3Ux8gsTKcpS+6A/EjgD/S8izpP+/Bvaojpfm4LY?=
 =?us-ascii?Q?qylEluTU1AyLIvqWsVCu04OfSdZIVYOiHfl0Zyt9lOUWG9MCWm4ESEoejQxN?=
 =?us-ascii?Q?7Ox22ETI7Y9WcfBeJ9XOa2J72G6ZUMr8LK2O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:25.0530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7c98f7-e7c0-4bcb-96e4-08dd9eec91c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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

