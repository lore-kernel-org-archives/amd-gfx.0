Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF56C7115C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05FA710E48A;
	Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nLHoBhxf";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC29010E486
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIBVszIMTWo2NBr3Ni01QkLLEks+2DNikGCC1NYLv37Dw+D0ZdUz4Mqdd2k9ZlzjFZrWk6FiS8XeLXDfIwaaYsS7TvBW9mhbXKiv5XidFuf21TNOEQLK3F+R3LfXdgKg3kDHLD76iVzx+DBNnYZhRObXzKf7Uz0+CZqA/LbgwT9R3YmlHELl97v+W+M2JO0Gdcjl3YMG4YnuDMyfulf2GTFzALWOsvCKoYTpqlGZkFCh+vIwvjBtqhcthYH61Qu4k0LcBb0vwXTzM7Hc6I4USjXhJN82NJoc8Wk8FTSzER+pwMc0CdzaX60ewmg2hCDKFzzJmirVTCikpW5SxDCvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zb1Pal3VbEJWvCcYp9Ru+FHVI+94fbm0URZcI8hnOQ=;
 b=Oao7vqcnB+4I5Xeu54a88EGhA4vc4n3i5FagsqVmoUBlIeKr1RqsKoCLQ83FnXC30pNXZFpgm1/YsoNv7HuZIPArEG1AAvdE6zxiVKvbJVE6RAbKIKssXYVS7CRfEnWcOE/Ha15A8m/XyMGiEvZNjb+28tILJ1Ilk4/DpjUtPtF91M3jn7IUvFaQav3a5Zn81oUIgBlzpugW+4eMbGiEMtof62VznkPzmTCOU2FFfrYFHGMdetGfdCAkOA1NIDtX3ASmH+nNI0i9XDhz1RERQKEAc8lTn/EKi+J1AkX1J43M7PYlhLExST6xYZiP9kF7wn/uwOuiQvb6kgNBPS5+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zb1Pal3VbEJWvCcYp9Ru+FHVI+94fbm0URZcI8hnOQ=;
 b=nLHoBhxfFZdiRy7rSXbRhrXPHtz8Vrv84GgTYBabXnNirrA03TEozMzcMXzAx8tfaEjnHZBBRs6XR8DhjtSrK3yuNy83SIkh39JefQcivcBmMyvHuyaN9/j3rBAklP/jWrpMssXo/aAAcqFvj5uJmdM0t1YoX34f1pgS6ix9xCQ=
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 17 Jun
 2025 03:08:45 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::9f) by MW4PR03CA0002.outlook.office365.com
 (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 03:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/36] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:07:55 -0400
Message-ID: <20250617030815.5785-17-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: d998478f-2667-4c31-d9e2-08ddad4c454c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s6qOxzttWGnn/S4UfvGaYrVIzToGC85Q6iIXF/NWFkqu0lPiTEa77XJBzEBA?=
 =?us-ascii?Q?b2ukLUTC8wmGS9J3TRLR7T5Ld64OJkhHWbLs/dUtYYHPqD0xTqah+XE4zSW1?=
 =?us-ascii?Q?HlQ5GZXeN8vgolYFFlmNMdz5bGWixj77W2BV7GbvVm2B/W2qdiEdTr7xDEi/?=
 =?us-ascii?Q?6qr1O4S4cXmrUP+CXy+JaSgsocWTc4GKAdjFOHHwoELEEKpKhlLl8t4TzhgW?=
 =?us-ascii?Q?/TJRLoaQq16IXmqBcZ+ScYFIINhSXABiHhq4uenOIqcNPotZXxGWE1rbkVbw?=
 =?us-ascii?Q?Wh1OlfcD6seAMVQVaVfs4kCTCv6H9XowD89C0Cy1NZAiuX51lJ6Qay7WHqg/?=
 =?us-ascii?Q?t8RyBQDUZ350aWFXS015PqkNmVz5gUjbaUPBIkiirmo2Y+aaRv0cul3RUcwt?=
 =?us-ascii?Q?b5626i+mS3G414gZNHOlPByMyRqvFvhBRfE8Fa8m/pbikadl9xZusMwJAYUr?=
 =?us-ascii?Q?QloqWVJ8q4qrmFgl8djj2n6MSNDTCdrzr2/faN0xDH0TMGz4SgN1nteWBwAb?=
 =?us-ascii?Q?hYwyYPy+SUe6zjuqxGpGIUG/1YMzJ8SmnpJGbKJCm38/yTlpRnJVw6WNT1nF?=
 =?us-ascii?Q?nSX+tmY34tr7eRkFAK6iiYmgoneLDyEmiwBatlIPjb+/r112gB4/9S+njz+n?=
 =?us-ascii?Q?WquZ2vs+G3jDzHAIMy3p2isGis90tMpgTl7P3oYNmDaHYwSNgg1bFFgzZhBo?=
 =?us-ascii?Q?+PAW/mDSnRRlKNWRgWcWxbo1dcGwq4RQ9j1On9LM4DPfflN3TT/iFV79+x7K?=
 =?us-ascii?Q?YZ7UoyEAKoNOmukQS6RmzaNSGbTbSCwVAg+Db7XAhTCGtcwDHvVDKCfu9Zje?=
 =?us-ascii?Q?GJV9RCjVSSHUxZBvkqUVgs/oOoUuBXKcOgUvXtnKJ/pWHEUw2inZyYHlacuO?=
 =?us-ascii?Q?7L2fKQGKF1/M7GjQ4sPlWg07OSq8MoATjenKhlKekWahKiY1urAhHQQN8i96?=
 =?us-ascii?Q?88HbGkgjbEOdoMKFBXg0imdt+MJDkeqprtVgtsESLmRq123IAQsRSg+pwpaV?=
 =?us-ascii?Q?edWGxIW6VkEbkbUMf5b7tTEk4mKnZSUdh4O75VFmGhTqEuBG+7QHh3e+QrC2?=
 =?us-ascii?Q?WB2EihOBVmomV0xItgDgLd70VfdyhoXdQvhc2mcwOg1fpj7Cr7WfZxUuRyqE?=
 =?us-ascii?Q?jI3JunpxZtOKBgtD47MJD06XERcILue+PtA43V0/bjbiv2xSXPSfpdKeGAZS?=
 =?us-ascii?Q?MF4gk3Xpbdxyhzw1hM8kpamExJ6I0axVsrVLwjESWfWfjHvu7Fp0zjwGuVnk?=
 =?us-ascii?Q?l6UiUIEQjgxh2X/jPmjl+1XmWP4KzIeNpMi37qSwNcMIUraiWzCJdPowF9vu?=
 =?us-ascii?Q?bhvwX0KfUWRmCZKEf4cMUgiNXmv/5H7jcLHJ/qoA0mBp+QnC4wdfhWqubnJV?=
 =?us-ascii?Q?MM1AfF7vKdvE2GSqbuRPn7TeqXicKDVBkA3e2OndCiVWBgrgOb1uWoJ9znJO?=
 =?us-ascii?Q?LLtIPPhHzA3JiV1GX+DK9kQPf8Y+lhy/7gBQHJ8Jj4iz7qTpW1LIcFPxKvCV?=
 =?us-ascii?Q?JnXPtJC1nmRrrhKRJBLZ4LSqzmhC1L3CYWja?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:44.6913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d998478f-2667-4c31-d9e2-08ddad4c454c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 45 ++++----------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 120d0d4f03a56..7a203d8cee12e 100644
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
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9566,10 +9551,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
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
 
@@ -9579,12 +9562,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
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
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9603,7 +9581,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9615,9 +9593,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9653,18 +9630,12 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
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
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -9899,7 +9870,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9940,7 +9910,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

