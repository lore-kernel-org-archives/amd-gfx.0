Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF23C5B555
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AB210E8BE;
	Fri,  6 Jun 2025 06:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N0GX88QZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8473710E8A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2scjKimSMBwDh6mVMZa4Jn1npZXnosMF+VSAS08QEvBiKWrsS4iadxEF8mzRWBEASm5RLWL52PTiFl5z2F4Bs096pjWHF9r3XqsT9rPQ6POqhgbl8r53OFg4JTBxCz17BbKnEAAJTEh49bF5dJjqYT4QHNSDjSNpHdD8JYD5plm6DZqOWbzCmBPU4vNA/YhLvQ9vZofVobhqV1Ye6Two+scLI0aIuknmmZeQi2uBuWdUxQ9zCPJDLg5ztuB+TI6PEH4y8/l38orWy5dzrx2lFEQmzJVoksqDEGJUlUczAlxYHWKqIBiPxpuYzniVjxBDuGEmWZ4Z4fHrCuYIrm9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Odn3UiGo5UgLujbeVyHFH7xvcJHjqg2tTEDpao/0ESQ=;
 b=FpEnm6sjkEA5/XyENCWPhlOqZW+r7h99BIzHbPh+y8QAxfa+dzwLOmFBwdX7Z6flcdVHJGOyyknhtY2gADFXWeX2OeOPyhu+dKrexfcX+JK+1T2Adq+mLPVoux73HAOKi+2o8hlhrNV6Rb4vHyWRPxUeqiCTf1hV2WyLC52WvLPLgYW/zssn+E5XfXWpuDACDzMKPYeheigjrDtobEwkbYrRJca0WUb30iyTB7E8+rXyD/8Zb8avqwLiEXdgG4q5eQaY5CxeT4mZ37hHvP2SRKj6tctzHeDhdK6b8V/9Byfo4QgAFsIU6FMdUscxHr9WhyrFHGEYno97ffIEvtUxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odn3UiGo5UgLujbeVyHFH7xvcJHjqg2tTEDpao/0ESQ=;
 b=N0GX88QZZJWqhFSCgjpVheP/4IfBgxK1zl5ef2I40+AB3Zce0kBzmQzMbtyU5G5q+4eBt6SsCygX3wLxe9ZuZK0Ib1LACzGhDJZ7JfsVfDfa+AkUDL0zF3Q+Xdfo6Z5WXb7ZpWJ8CBsjnefzRWrVbpCrOPbGKi5hTLS2Y8Lc3MU=
Received: from SJ0PR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:332::33)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Fri, 6 Jun
 2025 06:44:20 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::32) by SJ0PR05CA0088.outlook.office365.com
 (2603:10b6:a03:332::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/29] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:40 -0400
Message-ID: <20250606064354.5858-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f5b6b0-b444-4141-3ecd-08dda4c590a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?81cUr2UpOI7wOiAQyt1DR7gYUKCMBCwCwx1AIkVRp70qQ/sfVahnny8dSD0h?=
 =?us-ascii?Q?lvhwmfG4SP2nppCycQ2T5xkIa+OKTTPgd/fbayxB7Q527GzYQ2D9pQ6lu+u1?=
 =?us-ascii?Q?H129+Ebds4qjMNqxVt/0fUfJsRSCTwCOJuQfz8gjIJTfTrUbBY6iXRHKY/CU?=
 =?us-ascii?Q?QXBaez9VU/GmuDQog58lJR+gIBhFCMqZTYG0LWHyM5A09clvKqkTTxIK6NW0?=
 =?us-ascii?Q?YtySDGra9pkrrcoX+2Hf+CXTLchnNkDUvMeNMRCQXapIVsKkZFRPSjljyyrm?=
 =?us-ascii?Q?qOtpRi17eY67ABddgd0GUXbvomzJWy1D5VIC1OgS8N7Y0Y9wHBJdswAYc3xj?=
 =?us-ascii?Q?/ypa3SNUBcNc81f8UWFrVZRGZOUtnk1ZFIc1F70DvZHN4D6R2tHTKSBIV4rX?=
 =?us-ascii?Q?EYmWctPDxN89KcNFCWLw+Z3n+5qsL5txgDmEPGCARNOWYbPtwzLN+OYYDVSX?=
 =?us-ascii?Q?WDRLkYM+H49xo4OVCHffpeSVX1db70kUwxCMUAb19TBi+og6u7bYF0DWMIgV?=
 =?us-ascii?Q?0EN7uejTXPsZEU0CbCf3VriWi65oW8ZzUhClfl1AZssm2kia8DQuwM/mQPRr?=
 =?us-ascii?Q?w10g13lk7b70KFrY8RtCLXAS/IzOOdzNCJugXodPdAmt8DE/b/hVHtfcoC8D?=
 =?us-ascii?Q?5G7cyxw1I0AvF5EzRqfu1q3diU6PNc41spTloPn98EXWDUqb8GYmoQ9Bh2lV?=
 =?us-ascii?Q?bGwZxxZetwhcJ0/ssYAvuUOKSPxyi6UWO+QHXMmyaAUkNQ5Kugx3lQqBHxxt?=
 =?us-ascii?Q?oX6SD+x/T81JWaNN+TYL3ITOGb4pe5TGTqmjKaPgip4tsvzxkQaRbEONXGif?=
 =?us-ascii?Q?/hSGpHDgROpmbnxiv5gqONTbTUtMoxeUe5bN/zCsm25P8+7pugYOL2/rOeWN?=
 =?us-ascii?Q?NPofVinT3tu+pcK0rLmDavpgseuX8QYExxUzvwBTn6HF47R2UeFHYGHkAOrE?=
 =?us-ascii?Q?8Y1wVNh9Cw3bj5aZ0MxhNmtHu3ZwO/P3jrPbU7JuBoWJqtKPnA4ol7eA4pBr?=
 =?us-ascii?Q?w0rpicC8AJ3/g7Dy+k9iAUSgObdLX67vHPYep1AhOHds+glRiN2ZXfucGuwA?=
 =?us-ascii?Q?/TGCfNQA3VI8N03pCix7nITo7ofn7IKI+92Ln+y2OktmAf5Fpe3G1gD6HCRc?=
 =?us-ascii?Q?G05c8ZtiOb+myoz69s2C5SwGksO8PlJo6uSZVmU4HFyS/kJAJgpHgqklU54C?=
 =?us-ascii?Q?2v5zYEOd8rvd1TIgbnffCQSOct6u/k/9bLWAmUjr9TF9tTpl6xuWbr60ppeJ?=
 =?us-ascii?Q?evbFUD76vpAg3KHsEhzXEZQGIN/cvuFVSRNAqsV32hH9SLDPva8t4BwLk1sU?=
 =?us-ascii?Q?zS6oqfCFr0RRI4Tn/xQbonjZDWFhynWFd7RRkwZmZrudm5ObGwVrIw+iVWA4?=
 =?us-ascii?Q?KgaWtM3HeqXjXeUVJAv0UH4zjgAoW2+s5h2a8q80UCeyzCT+0nX/sFxfTGzJ?=
 =?us-ascii?Q?OXZ8sp+38XaJdnpV7cTKB0Vewe7UtQtri+3NambnIpkkbKQWBlTVq4jKswMA?=
 =?us-ascii?Q?Qj5UdQ3dAs/lIy8Zm4Vqchc/Qj8bWmIVvGtx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:19.7344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f5b6b0-b444-4141-3ecd-08dda4c590a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 39 +++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a4e3ce81bc671..10afde96491e6 100644
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
@@ -5316,6 +5301,8 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
@@ -5339,9 +5326,16 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
@@ -5437,6 +5431,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
@@ -5459,9 +5455,16 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
@@ -5540,7 +5543,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
@@ -5579,7 +5581,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

