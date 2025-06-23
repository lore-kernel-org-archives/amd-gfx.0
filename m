Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1D4C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BACF8984C;
	Mon, 23 Jun 2025 16:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rWx29yiF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C54F10E406
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiDevl9VNRrJcNjDYDbs5S9mPbLZOuSwxcQ985UrYSifxCStEjSCGTTfOmaMenqc3FTuC1vBVmUg48ySns6l5pW9gnvGzCsBd1pRI+qHS0kEUbwaGfPKw+b1YljLwxwcauB2b6VNQN5RDPI9jM805K7rzGm9XxXjsCto+sv0DMgW4utRTGp+mMHGSorUBbw2fkaeNc36u+1mGonNZqs/mbLqnQLh4WSJzAfbTa/o567ZR6ss1yP9/Ls1ulWsB7usCuZdRD8yQIg7W9/5cNHIetjfWN7xZMdbVO4It5ZIjhMcvH5lA6uuTgGlt66ElZC8Z1MBb1xz6Zyb0ZppSmDsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL1Q0ISrbamlNijBzBIUhiYMVczALHGkkQ6RGxw++VA=;
 b=Tm5oIfv6JhAQ8+fo7INIJlT7ErbzvLi6Q9DfLsdw6PnwuY/V+4kH8HhQTiHZnyjAbxnBfvgWZ64QA3Jhyj85QJEQerr4JJCAlFpVrJU1qNgYC8xyy5x2+ndqSmweeqgJyaOtMMhcqs7QsA7jZWgoPOXzQ9RI82wWHdRDpBNRNkmY0ZlY07ew0zBpq+GnuW4wnG4z5dCAJKbvk28cBa1Cfu/69XXY+FeUIoaJ6GALRUOturXIiJZdRJeGryZuTD00qQOetqMGHhJHh5DTSPXoHhcxzntL171NpjHuVKj+9KTH6hi9vXSHKLhOQ35ttioL8/twt0XSrHDmaSswgsF3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL1Q0ISrbamlNijBzBIUhiYMVczALHGkkQ6RGxw++VA=;
 b=rWx29yiFl0mNytjw0evGceLDe2UbniKnYnEnnGQGjUhF5WfZaNtCW6oqSlp10+Z4qsSaedg3GYrERvnSUEi9fw5PkZsE2Nxweb6ey9V7/yzalmeLknWFAE/7+iBuixCn17K42uUW9BYmYsdJWPK/jb6dNqMcdIh4L+hww7Hcfmo=
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 16:15:03 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::97) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 16:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/31] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:19 -0400
Message-ID: <20250623161438.124020-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: a32006af-8728-40d5-6a53-08ddb2711c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HeptMzfuQWCKseHIjH/t2fVierAouUEmkWvKDrdfPMw3WjiQmsn4wElrWKz7?=
 =?us-ascii?Q?mol4EuT/8pf4UcAIrxcEX2QGDGV5wWbTWuUmtu+R2TOjy2SiFb/aJmywy45e?=
 =?us-ascii?Q?/3HAXuItOjsTUrxsa0qyEmCoqDdOMJ/UtMXZfGw+C5dM8d+723BN0g9WNrzO?=
 =?us-ascii?Q?/yN3O9bto7Ow9zUZd9xpogsz5e0Ts+91D8ubG2zZJuBFkpBRaQejqLhmpyJs?=
 =?us-ascii?Q?2Y44YJoMO1PuMjh9MvKRLOo7RdyKmrB0pp3jTh+PMLt9ypb7/23+GcQZ09Mu?=
 =?us-ascii?Q?yNQwkcTfk13kjeDJxEAa3IULaNCEmhSzn8nUAKKdroZdMYQv70L0ifijoH74?=
 =?us-ascii?Q?+g1pqXpeL3or0y0essI/Tt8n3iS+b7Im0vxMCZv53inn4Z4PLIJMNNzRVPmt?=
 =?us-ascii?Q?fOtI4qOXb38oZ6XMPIae5LazC4FFVAw2ebClz6RjHqTpLY+tOhDJGhzF13VZ?=
 =?us-ascii?Q?djkSw6QV1rJ5viqjQ0B8aptmNoPDKfClRGDbO2rI6IR7BO9hqe4seSJ/Shdu?=
 =?us-ascii?Q?BaPp8tDqpSS5sxK4rNYn49bWDNoqXz5xp+aiCrk0JqET1XWwneXU7N9FH2WH?=
 =?us-ascii?Q?zLZzwRDw7Tac+hM7hlom4lAqZry68m/wezM+Qyc2tlQ2MRAfr74VCFmKA5Uu?=
 =?us-ascii?Q?h+L/q2/TbclFPxphpAtTaqwO/w4WRLBqU1Yqv4TNatIJXRK5msnI+s2bvXGX?=
 =?us-ascii?Q?yBcg4U1jiujFucH4lVfXWszRkcIQ8Dwa7235AjWBW1U0LHMQctHud6mqrFkP?=
 =?us-ascii?Q?FL4Ah7yfZPStvbxxJEODu5Vob5lYznZunjiVPsBpdwb9VMHcLzpxJOXgB9OQ?=
 =?us-ascii?Q?MNhfx0/+MVkjuZtfsThXztBmnKElPTAvsN1/Z6EAT5DYNv82JHDX9xHMM27y?=
 =?us-ascii?Q?N23yYeUVIbovcAjAT4aH88dsjrPtyejF4MWcQ5mBkWuaJj+nQn8QnzhvNfel?=
 =?us-ascii?Q?0TmZ2SlZcX1RZrxIqwo+z85aO6ks788OXvC2bTy/CALTvIRLzgsZASqpWPMx?=
 =?us-ascii?Q?ZFzR7H2UY/K4iMFYAuGndUilUFwpyBn0XdLMQbyd87fpGyYJP0PZ3yCJCs7B?=
 =?us-ascii?Q?Xs7FmTroUnT3j+SpKkvWaf1YCzcKmIk2zS2hvkCckMYVdH26h+IWMc7flvg0?=
 =?us-ascii?Q?0xOzvvHAm125jxl6zIJljlXWlNG82yNm+9EHN9/acJlRFrIbryZGTCrg2NEG?=
 =?us-ascii?Q?eO0IpRo/NcDJSQS4NsUX+6I56IQylCkieODZLuYmmXCo/M+nR0qApVOuv72y?=
 =?us-ascii?Q?dgfZgMsViD922+/4DeWQlqXL6r8p8pO5si7xmJMA5EMmOt3i5ZkbDtY1usRQ?=
 =?us-ascii?Q?8ULaMsAMQmYE4ZJZlJqpXXG1/+89cY4REh1szaMxWhDZwy+YK+qo5N0Rf7tz?=
 =?us-ascii?Q?RJbhBJCNC94YkEGmQwkloq02NIYDhoKZoPS3rmfKT+ZkGLSmfxu06Rvs3Mer?=
 =?us-ascii?Q?RBsA5/XnY28Q00idaGrKJMpI69OQ9quckkWgDKNrMBn/lRAdqv8YkE+ChPU9?=
 =?us-ascii?Q?tZCbOmwioL0nGu6I0M+MF8V3olttYLKQjUkl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:02.9458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a32006af-8728-40d5-6a53-08ddb2711c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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
index e4fc42470cf3e..a3be2b46177c3 100644
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
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
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
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5440,7 +5420,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
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
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
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

