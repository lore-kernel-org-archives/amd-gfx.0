Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31860C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 17:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE68910E3B8;
	Thu,  8 May 2025 17:24:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZPGv7DEH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5ABE10E3B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 17:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlBeDxEThLIGUW3Yw04wM3WmGC99s8yN0jHeqaCOA2ahNafNOGoMGqRdg/q0rT0mpPiytOdOGgfYLKrmO6lt9P50ji07SEqXZUOp1IQY1uRJ/k1yrPkVE9OXVVwdY/xepfp5dDAyTU4coUwPq+qG+vDxMahodm8INwfFq2PBF4rv4iN9TlzdY2dqx5RTEiHlV8RsSDU7aZ6/aLDXO6TWtwoh7x5WOphBxkb7OxjhA3AUv3koROCXv1m3ukljgzbECNWYtTjlpIQbssQJqA7X3iFmIxn0xEGGsZlAavvXzZYJn4Tg9+sVC43LbB4ARCREaD81pZxKi6zowtGKcgwT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKK0fjDW6I4DrK5qkO8PhyUyv6YKL3BYSuiCQ2Y5qRI=;
 b=cDDUjV+/rgqAbxMn1WEImNKmaQVeABsko704LJRnKnLlwXAKeJLMyP3OSnMJhLcvdrceebsiAMGMbbIRM9aoef/K4SuFoA0hkLSuL16Soa43HsmcqCrU2PYVEoRyPt7KHa0VBK3Jyw/4Sp3uy1DZQodSgXINPtPTfuwDEhRJECbt7GgYtdwXqHc0BbPWEL0vDKawcNH15B4BR8B5TX/M9mws4a3dUFMaJEhLXOh4bchKmZ30PnreZtDGwJ193OCDO52QDV9rqb/fMyoFzchYOliiI8d0zAj5IEUdyzbdqUpZ97tF7IZxVQpvqdI2XhzOLXmXl+3qAPQYFYuEWY7/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKK0fjDW6I4DrK5qkO8PhyUyv6YKL3BYSuiCQ2Y5qRI=;
 b=ZPGv7DEHk8LSzLrbn9/6ze5WU16HVcgKrtdGsTYg73Xx710aD+qFL+TGtC4+eTBYVC9xU1heigkluTkOiQmLY3zrX6i/PGYRiChTX7pHSzDqo1jW4z5t7MGD2znYIjzyrRZ+8/c9SdeGrxIegnGSsvptLbr47TzqegLJ/4xjyqE=
Received: from SA9PR13CA0154.namprd13.prod.outlook.com (2603:10b6:806:28::9)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 17:24:28 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::bc) by SA9PR13CA0154.outlook.office365.com
 (2603:10b6:806:28::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 17:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 17:24:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 12:24:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Michael Chen
 <Michael.Chen@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: rework pipe selection for legacy queues
Date: Thu, 8 May 2025 13:24:09 -0400
Message-ID: <20250508172409.3183469-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 8348f957-2966-4aa9-07a0-08dd8e552f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c+qV2gyL23uiaKvdkUdfRaukglvopfkPFdKtQ3Kvlc8KHFQTl2pKRsCNY/0r?=
 =?us-ascii?Q?vpXPqpQnNwbZLNwSlFwzSPmFYLnF0Z7yANuqAJx/t5cHiyU+c3jD0jKJ+iLs?=
 =?us-ascii?Q?scx7UIsVzrt/+r6eAqI8XeC222IzztWPknv2j8yz+c3IC9KWmdQLv/PBCSh/?=
 =?us-ascii?Q?uSF0llW+H2ku0abIYIpT+tlryPTIRhucekRQMVHU4pjEll6PT/07NDIvbMNH?=
 =?us-ascii?Q?gPGSjRE2P9rJrUffXqJdH7E0dxOrc6sKjdANYgqj+JJL1usgb6inb72T3Ezv?=
 =?us-ascii?Q?4l3kHkSpiKLJ/6phWbRumLL5av0DtyDC5u2+CjQI5nlAlX6IK6m5VZNwnauD?=
 =?us-ascii?Q?4toS3/Iyc8wX5nWi04U+loYqjWaManyneaPUfCypNqqSk+iPtF6XuqaBgHc4?=
 =?us-ascii?Q?oo3q6Nd6LSYMyQuubi8rIa7K+MMSDm7GAamzj688oslnqB2HfUXBPRS5dvP4?=
 =?us-ascii?Q?aMmiMBoXFNx9Gv1WOQFN8H/PeAQ6NcDiGwHiAm5yILyXkAoz0WpTzefkShpL?=
 =?us-ascii?Q?hzHQta/QIRVTG6TSYeqLoj4y2YKK3IrLmwNVaBl1iteooyLQ8Bq/gC5Rt3nY?=
 =?us-ascii?Q?/EI7iB2myg3LxGpu7BSVqnULprISIUGCDg+NzyTO53nkZSgb6oDMcM3dEyGt?=
 =?us-ascii?Q?DLG5GWpYsZMZOywZ5GXN9IOgpd0ogXfSgSkt5AoJBYn1oJalqfjUDOz87E8V?=
 =?us-ascii?Q?V/Rj4PhZELENVVpRWraBbBbrNpL6VCjiMV8V+UVwvDdW4XwapKF5B0vb2mIz?=
 =?us-ascii?Q?pPfkb9gwhVdPdBERxrCaPY9cETRmcaG0BBhgJo8QmFwpfK3ubgBakrYgK9eW?=
 =?us-ascii?Q?TqTZE/EKrbJ8l5YlpXpSr2HPY1gjn2E3QJ2xU4aS+MyBtNwIemhqta7TITtQ?=
 =?us-ascii?Q?BBDZB2N9mcEhNkXdj1+pp9pJVipTnZYqF+vpILkOUQ1pI71jN158KZ/JNNV8?=
 =?us-ascii?Q?XFWCYMq549Lgtbrrw+qC23X2SMuBK7lk87SvYjjPBiCJRiXI8H1JUjcOOiPj?=
 =?us-ascii?Q?LTZA4ZmHhNHiBBDYCg9qNGuh09Zj5RpPljA8vw/dJj4Rmg4Vo4QUsNf3dsgJ?=
 =?us-ascii?Q?4fYPIkIXLWzQjpKyq7oex0OVKEYzfjj2DnOY5c6VwM4nyoJ89yzoulgrCDJh?=
 =?us-ascii?Q?0B371hnYOEt1PeDxI9rIp6jlR6Ttx0xVdhBHSjMZanmoRU4QWltrBbpYApIm?=
 =?us-ascii?Q?Z4eAYRQb9a2R9tzQYG3ciLM1EfHHBnYN3MoGLYrLND0Y8vF5JsX18H7M1xK/?=
 =?us-ascii?Q?3e5QtFZxTQoJGO0TLItyRy5JOWpPbyxeu1UKvN27GK/A6PkCRu2TW1rJaIHl?=
 =?us-ascii?Q?H9qxpsSKJJHga25GoFweNV0LRszxsXsnrmOZ34h9k/eYiYn3dooQCSHuNC7h?=
 =?us-ascii?Q?gSf8rpuHARvPf7Iidb0x6piZx7ozP8y5xXhSK0PcjkFhSNbdz1VYiPrsLoku?=
 =?us-ascii?Q?VQl1vFCXF0Lu7OTot0x+GXuuqBexpikmegM6Gtqgx7HWtnXJHRRkN2q3nPlP?=
 =?us-ascii?Q?OVmd4XqGCFs9406SfK9T00JkgfBxBI8cuTy9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:24:27.5809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8348f957-2966-4aa9-07a0-08dd8e552f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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

Only use the KIQ pipe for the scheduler queue.  For legacy
kernel queues, use the scheduler pipe.  This aligns with
mes11.

Cc: Michael Chen <Michael.Chen@amd.com>
Cc: Shaoyun Liu <Shaoyun.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 18 +++++++++---------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 2febb63ab2322..f665daf71780d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -299,6 +299,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 	queue_input.queue_id = ring->queue;
 	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
+	/* need to use KIQ pipe to map the scheduler queue */
+	if (ring == &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
+		queue_input.use_kiq = true;
 
 	r = adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
 	if (r)
@@ -323,6 +326,10 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	queue_input.trail_fence_addr = gpu_addr;
 	queue_input.trail_fence_data = seq;
 
+	/* need to use KIQ pipe to unmap the scheduler queue */
+	if (ring == &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
+		queue_input.use_kiq = true;
+
 	r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input);
 	if (r)
 		DRM_ERROR("failed to unmap legacy queue\n");
@@ -349,7 +356,9 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 	queue_input.vmid = vmid;
 	queue_input.use_mmio = use_mmio;
-	queue_input.is_kq = true;
+	/* need to use KIQ pipe to reset the scheduler queue */
+	if (ring == &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
+		queue_input.use_kiq = true;
 	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX)
 		queue_input.legacy_gfx = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a41f65b4f733a..d1836ad93ccfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -242,6 +242,7 @@ struct mes_map_legacy_queue_input {
 	uint32_t                           queue_id;
 	uint64_t                           mqd_addr;
 	uint64_t                           wptr_addr;
+	bool                               use_kiq;
 };
 
 struct mes_unmap_legacy_queue_input {
@@ -252,6 +253,7 @@ struct mes_unmap_legacy_queue_input {
 	uint32_t                           queue_id;
 	uint64_t                           trail_fence_addr;
 	uint64_t                           trail_fence_data;
+	bool                               use_kiq;
 };
 
 struct mes_suspend_gang_input {
@@ -277,7 +279,7 @@ struct mes_reset_queue_input {
 	uint64_t                           wptr_addr;
 	uint32_t                           vmid;
 	bool                               legacy_gfx;
-	bool                               is_kq;
+	bool                               use_kiq;
 };
 
 enum mes_misc_opcode {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index b4f17332d4664..8f2e24ecf747f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -515,7 +515,7 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes)
+	if (input->use_kiq)
 		pipe = AMDGPU_MES_KIQ_PIPE;
 	else
 		pipe = AMDGPU_MES_SCHED_PIPE;
@@ -554,7 +554,7 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes)
+	if (input->use_kiq)
 		pipe = AMDGPU_MES_KIQ_PIPE;
 	else
 		pipe = AMDGPU_MES_SCHED_PIPE;
@@ -869,7 +869,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	}
 
-	if (input->is_kq)
+	if (input->use_kiq)
 		pipe = AMDGPU_MES_KIQ_PIPE;
 	else
 		pipe = AMDGPU_MES_SCHED_PIPE;
@@ -1339,7 +1339,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_device *adev)
 		return r;
 	}
 
-	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[0]);
+	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[AMDGPU_MES_SCHED_PIPE]);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
 	if (r) {
@@ -1608,7 +1608,7 @@ static void mes_v12_0_kiq_dequeue_sched(struct amdgpu_device *adev)
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 
-	adev->mes.ring[0].sched.ready = false;
+	adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready = false;
 }
 
 static void mes_v12_0_kiq_setting(struct amdgpu_ring *ring)
@@ -1687,7 +1687,7 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 
 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
-	if (adev->mes.ring[0].sched.ready) {
+	if (adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready) {
 		if (adev->enable_uni_mes)
 			amdgpu_mes_unmap_legacy_queue(adev,
 				      &adev->mes.ring[AMDGPU_MES_SCHED_PIPE],
@@ -1695,7 +1695,7 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)
 		else
 			mes_v12_0_kiq_dequeue_sched(adev);
 
-		adev->mes.ring[0].sched.ready = false;
+		adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready = false;
 	}
 
 	mes_v12_0_enable(adev, false);
@@ -1708,7 +1708,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (adev->mes.ring[0].sched.ready)
+	if (adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready)
 		goto out;
 
 	if (!adev->enable_mes_kiq) {
@@ -1763,7 +1763,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	 * with MES enabled.
 	 */
 	adev->gfx.kiq[0].ring.sched.ready = false;
-	adev->mes.ring[0].sched.ready = true;
+	adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready = true;
 
 	return 0;
 
-- 
2.49.0

