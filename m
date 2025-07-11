Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC25C83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A9A10EAF2;
	Fri, 11 Jul 2025 22:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chAwyGSR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A756D10EAE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3b4XLefkwBJxTvKgNF9EivsTlYJK/EJpa+NXYuEQ+ACypldN0WwEdeGTTJpSr3PSBa7GSjMx16myIG02zi2vQisNWs4apzpQYof5pgKJCYj/DPbdti8psxvU3RB1QgE7joln8dDyB9912e7ZD0qNQw4TZqIhItkJMXyOYoOATigMYBOERv+dck9L9zKQCmVwYlJqRK/BB9L9XlFm1dRWYUYHAuPkSNFQYpaX4maxBJypkGk5QQIs+Hcolezfsu+ighYo+ThPH+CJXZ/5OEVIfkkMHyKfQT7yNwPURlczA91G+D7IPVItMTB2QlHGSiXzLXn/634F4cZg/v5EZ+2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suOTN01bhboHF156ek/ta+q7oW3rZlhf4wgc9iIwlgY=;
 b=u33H00XrOhyLx54jplt5Cr2pbcWphuO44X3GZ4BK1c480UtrJDItTz4c+Jd2/1DqWDnrDwTgLhHN7+qOy2ZkKvycOnPH0CwbnDYb2kDpNkO7xyLpSP2MiHFocaf8hzmpaST4wwAwXdu4d4O+NzssGUC0yzoCUhg7imIsYfJxRDryBH7kqdXG3vaJGtnKN7ytmwMQSEkZsBiKvGiuGthzB4CSUEDD/a6tXXTsZS0peBI83Hy9J/LdPG6EmoJYbgqCZ0qKt/JxCFlkpYyZrHPb0RUZvXIM32FjW7WixqWIqILbd6efaj0q30xqXDhyeTFhu+iuwqgvWrP1pUpjS5I4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suOTN01bhboHF156ek/ta+q7oW3rZlhf4wgc9iIwlgY=;
 b=chAwyGSRBTi9id09Mujr+QETZe6hk8zNSPtkSsTRIqhCuFh6J4tVbFT06mTgqtpx2YMQeyl1Ukk3f/v+btctZJHJcwESxpGPeV3yGXiafvlNwzP/3SS6khn5WYd1fiOuHcqbql8Kwew24f9Nwkt0hVPSWbsOjaFPhTSw2TeWekY=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 22:40:46 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1a) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 22:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 11/33] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:02 -0400
Message-ID: <20250711224024.410506-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c775e62-d7ed-4298-06dc-08ddc0cbf9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3uhzEPXyasHO82cl+CEr2ZHwLQVjZ0XvTTz4IbzMqdNGjVcA6V2jNnI69AL0?=
 =?us-ascii?Q?dF3av+2FR1nluYmf5PsUXip84HRRbsK33r2kcToDkrXhiJiHNNXBs0RNPBTn?=
 =?us-ascii?Q?xvhVSUisxSG09PQbX99gZEY/rdfeswBjMBFDZGcqId7bjWNCdkCRqg0GWtw6?=
 =?us-ascii?Q?k0Ej1la8t7MLnure7X6bk6BTy2ZgZVdjBOonqKAbrXuSUjmR1fljrnDalPF2?=
 =?us-ascii?Q?XbS9i8J0F6iXlSTaWu1NjsVlqjkLxNuM+rWk26YxkO8pd3XgiUqAc3oCFW0l?=
 =?us-ascii?Q?ig6sSwxlSolnkqeyF1hjaSnt3RZSTZN+nCEdgunex/sDbVatwXdmZTLApzNN?=
 =?us-ascii?Q?z3sgVT/ms+N9SQKCzcoe/+bYf+uNIlov9uKSJejJV+IBLdGjUruWBBkw7Um1?=
 =?us-ascii?Q?ikqRpTQhkCTE0Ke5YPWDz6AQwRaHXFBrm72U01m/7JA7ZDOD53h2XgsP0zgI?=
 =?us-ascii?Q?vH82bEw1QuxIpuMR7Z2b5Grm5sHyY7UUOz5kq/SvGfk+7O/WE0zzoAvTqpVE?=
 =?us-ascii?Q?paT63HLc+k/YOjl+0VxulWUIkhSvuOu/O5HC0Tc1N0uK5aVqaxX7Zjw0TkTp?=
 =?us-ascii?Q?HsVWWV9UFhwjX7dTLrw+aoXrb/6iIcWQkQ9vA2ZjDxEA1r7xo8UG1dz0z4GQ?=
 =?us-ascii?Q?C7bERIyj1pvJW5bq4PLJBXTPovMBhLsyXKLOqLhW/t4AJKD2kBOr3X4y00kP?=
 =?us-ascii?Q?gyvw+FNlGbchIRRNTNBH5GJ1AkcqXHgXlMvZU0k+N5yOm1hn/ML0vZF4mrwQ?=
 =?us-ascii?Q?0HyGjvgc2H/rnCl+ssn+6JptxH9UzU52CZSwz03uGUTOvD/0OSfO/2OBW2xK?=
 =?us-ascii?Q?Fd7lVq1ipSHFkk85te632vCSMbCAKGDzPK4krSRkSq2nj9Nv2D63Q0+9QZ2P?=
 =?us-ascii?Q?1RdKwxn+3swr0nBJZIlIRuLGDTfdvZpmI9hROVNsNNTyTRxA2rn07GSOwHDs?=
 =?us-ascii?Q?wtPE0HKEZkNACCe2/zil/dkCeD3HDo7FOOx85pyOAidPd2BUFdX1IQAOunTj?=
 =?us-ascii?Q?cj7cLhLbTGqclc0HnEY4BHlaN3b60JVFBPXaXQG5VQwCD/bs/oBvs2ABQHU4?=
 =?us-ascii?Q?iH8fx05pNbWQsTcEagqdmbNmzQ44sTUXAqkVe628hskTbXQJdSknd5mGnQxy?=
 =?us-ascii?Q?TnrkICOrdIAslMeDORegr82OV+nnSOv/ms30KlIkWMlhFeItYsI8YHWooX1W?=
 =?us-ascii?Q?m0ZeeBWP7/OEsirKtU7N0mmfDKKz5IEACrt+tau6vpkfmWjkloihCpbd6SU1?=
 =?us-ascii?Q?q/fpi9fEWuB4GV1Wp+PwHDFvZdv6dTr1vyW7zqkCLfKAm0u2HAaQns5Qc1YH?=
 =?us-ascii?Q?ZNg0mJ5/LtyLXLDzS8in6ErbPkOfm2zoDTaE/4Y6EC5mOl0hfv+l7UCoBZ9e?=
 =?us-ascii?Q?iMX3qqsKYXN210djDOX+/whBDPLzjSo/5CR5XtsMek/WAbiLCnismT26p8Iv?=
 =?us-ascii?Q?s01VKBoNMhUCGU/OauqcwnMykOIfo6cpVPAiWGgHUH6N66Rk5sws+Zpa/iqa?=
 =?us-ascii?Q?RMC3YTd2KeGXkh5Frrex5xdmvqTKfQIZVA8m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:45.7072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c775e62-d7ed-4298-06dc-08ddc0cbf9c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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
Drop the soft_recovery callbacks as the queue reset replaces
it.

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 506454ed27bde..744f51a6f522d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9050,21 +9050,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
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
@@ -9544,7 +9529,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9593,12 +9578,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
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
@@ -9617,7 +9597,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9671,12 +9651,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
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
@@ -9911,7 +9886,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9952,7 +9926,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.50.0

