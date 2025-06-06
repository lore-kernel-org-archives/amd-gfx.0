Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8471C5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DE110E8A3;
	Fri,  6 Jun 2025 06:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gm1UkbtD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C41910E8DD
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUy8PYoQXtqje8ACZbmJeZnQ1M8T68PfMr8HOxzrtFdajnXfY6LAWwf84kj8I363y1lFiycyXz1TIB+UjXBkciFBvbZ6KS08E6MMnPQw/8Zg8bwANLGZd9iJ9txcCX+N9hhrLn7R7GPsqWfQh88XgYNhRcSiA/Q3eD3EnQLUa0TuDlUJNk/TtmRB4AqTJ5B/eZeFSm7HA6c4iiTacTlmFxxBgTGdzXW6ce2Jl1Pz6hyrtG1gZXB2lQ7kpLt/Y4QcE+mD9p2pGG0ixeN4rn4FLq6gvg8Qapzx8LsX7JYEHm3V6ZCQ2NDFXy0vwouPQEfvJLz34MJ2hTwTYeYm3Wmk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TS5HOro6zLV1knhxUCtw2aTXe71+fnBOqIPdVMN+y+U=;
 b=QKH4TEcKVTlRk+E2+/bKI+U/FZJT5AYMUqUfL3EXxC3zHar1NPkDTDIyYNReJMXvI1Ik0uMn/BrhkhMR3kIrVZq3WP7fHr7TJdK3+TOwWzwL3m4UX7kiVmP4bS3tPORuq+Z/YRo0HniJ59phK9GYKMsEXZZOGMUhE40IU95qQZ7ggm0FZNPrZ9fhHQHLShHFirT7hxiaVRvPY812jbE0hCiHO5X3GclOXwSTx+5GR+IFISQ9HeIP4N1C+lIeagEmdoDzfSwle4WR3C2+NveHn2dGHMhKRRcB7gdYzL94Sl4RKKni6J7b7YC9vDS41f2j9w5k2hOKj0fioJOw06dmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS5HOro6zLV1knhxUCtw2aTXe71+fnBOqIPdVMN+y+U=;
 b=gm1UkbtDqZDRmsVzUWIkUkwvhegCINAA7V+C81jiB4c2VvooHXJyY6NrS9j8vJNI/zvx0ORO9BlTyM5kyqio32LgV/jMazDtLMvLRjqdSVg3/j4F9/H6CwaNV8hrcMxRblro0UkdOeWTrJH0f55qmVUd3XdoAtcOkpCnmHS0alI=
Received: from SJ0PR05CA0141.namprd05.prod.outlook.com (2603:10b6:a03:33d::26)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 6 Jun
 2025 06:44:19 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::f9) by SJ0PR05CA0141.outlook.office365.com
 (2603:10b6:a03:33d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/29] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:38 -0400
Message-ID: <20250606064354.5858-14-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a4f837-b9c0-43f5-03cf-08dda4c59034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HGIsLPq1fp/uXsccu7R/R044+rSn7aHYUZcx9xa/JwzL0yU0iSYPhu5psYl/?=
 =?us-ascii?Q?QYOqwZbLbxjtWtuy2FjUssHR0eSdAKQ63v+NHLpf64jGyZ1skDpWXPy3lK8o?=
 =?us-ascii?Q?fiDMuwRS5Dzi+OPURQCKpQgCCgbEsCNfgKj+vTY+D9aLD1H707YK6wOH7IL8?=
 =?us-ascii?Q?6uzuuRDnUS5P13R1+rdWoZo1fF06RRyh/c48BDFq3DtszYgQiZm2KV3xuSdE?=
 =?us-ascii?Q?Cti7BmKutG3NZmSTMJ0tGa+17wAx4ksWojlLTiVFVeXqzMaMwyCQYHU1CBQ5?=
 =?us-ascii?Q?/kW6dBU7fiDFxYeYmaemM/Wr33WO8tydNZEwYBOKWe+ogo3QpueK8umcRWmF?=
 =?us-ascii?Q?N63MWB1LNT5M9kynpsq2/TH8JpqL0cor215G1Cr5QSXaH991fkKpZMtMVJkD?=
 =?us-ascii?Q?LTm5oxgBnabfwk9huUU8vc38Yg+/Yd2OaQG3gCHN5msm3jbw0nUd7HTaWzZx?=
 =?us-ascii?Q?Fn/UMZzvjtLRsEXX6vQLa8XLTB/fdPOn7h4B4WvYapKwWR067jPZkABtssPy?=
 =?us-ascii?Q?Ix9wAGOOUpzSdChsWJIN+iUSn+qYhW0sSF60c5uYzVX34hjneml/wNHcx3I9?=
 =?us-ascii?Q?rGB1sSnz2SN2ZueplJDuvIq1MBVpCqWC9aomBkuv2POky3KwzKOUsXEKIG1C?=
 =?us-ascii?Q?I0CyPR/HcNH0FYFAVlsJdSpU6K6iv6B9kcxC2SmB8C8WzKNfMjrFAF0EN5X7?=
 =?us-ascii?Q?fONUFRONYENDX19AFw5kkVKPh2CXM9v9wmdw3eo8cBYZCQQQz1nPJ5ZHpGky?=
 =?us-ascii?Q?r69Kv9ul9mJO5PtEUnD/OnykFlKyeMSnRbwlHHW7pLp4yWjVCKv8/mUhjBaR?=
 =?us-ascii?Q?VI/Y+uq/X3oEvNVVAMfUYGU9+pOj/+jfYbekklKYwbZhbqAUr8984X1CaV8c?=
 =?us-ascii?Q?B4Q3msgKh7yvw2UPD+rsRJdTWfycl9De2+jaU2+dUPd29StMLR+OGTy4w2+U?=
 =?us-ascii?Q?/XODekSCz/YuXTkfBeE29PvodY27DiMN3WOcy3fNHq1CkY//uhtC0/ncnVSN?=
 =?us-ascii?Q?wO1Fl9evn88FTi1avyQq1QZ1wxGNAt3rkKAT4Ggs1DKm884HQg/mx7fXOtX5?=
 =?us-ascii?Q?5B6XzK6t0Cl5VJEefMU3V8mQK9xUJyCTMnn/QNGDJGYD5Ntt8hTI0yroPega?=
 =?us-ascii?Q?cl/412HQKA+UhIH/Ee2uFfEdaGtJzmKcBPKNThU+rfYFTUvTADXCRwAe3BFT?=
 =?us-ascii?Q?nHiCHV/b/hPW+gl8tz+oIMUKAkATm1XrWLwWIh+B1xzoeJRhMNEpoudGt//o?=
 =?us-ascii?Q?NBlTopPuWob6ZbL1sXcBxh1QWRUMhFvQxlbUiI9eWXT/IKd7uCRx6vxQNVmr?=
 =?us-ascii?Q?YzaQo3tIDNXXGsUK80ZIYRvh8oxGeSI1kbBlYy4AmrmTlHUcwftGrQM6n8bc?=
 =?us-ascii?Q?Y3Hkmxhzf43b0WrC6HqeqQLA7z7ZHdFtzwfwkM/8OyM5hXrZyEXGfcccImah?=
 =?us-ascii?Q?1Gv5BGZ6Xz4NSb/M/zIknMqZFYxjuaNBEEl4gw5ZAeNeF5msma4v3Qiu6pNP?=
 =?us-ascii?Q?m3sbORo51bembo8HbOMVb6uTa4DA0Coibhvk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:19.0067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a4f837-b9c0-43f5-03cf-08dda4c59034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 49 ++++++++++++--------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b57a21c0874c8..1faa8c6a90d9d 100644
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
@@ -9539,6 +9524,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
@@ -9563,10 +9550,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9579,9 +9564,16 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
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
 
@@ -9600,6 +9592,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -9610,9 +9604,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9648,18 +9641,24 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
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
 
@@ -9895,7 +9894,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9936,7 +9934,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

