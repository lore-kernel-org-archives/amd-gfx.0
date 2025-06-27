Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16445C7EE3A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB0310E949;
	Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CtPeNscR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38CF710E935
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yghpiYl4CKaMQoMZT2983eNIrJkUROwUjD9wgrMZzxzyJzMszwCyj9jlmcSWvEMwtgepsCbL6IYxxkabFywLCi+a/h0f8Nb2E8XZgZASMaYqBjIeY6Nbm3D5q2PfOXZomZx2gqlZ6WmzVFE/WxdnHLES1P5G8nTzzEhpQNiLV6r86wOFfvCechEB9tANs3WUx4Q7g99jd9BV0rFw6OGio84/cJONPptp+iMpb/FSzpsYMgEwjgo9m8NwyOEBCO31rrxzoEP03rwt76JwjlwdlHe4FtROXKRnm4wQMbWRdP+sl+U8e1ejbzym0SIDly55OIGnuWjPlNyFmEWdRrPKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR7EbpJz/UZJOLP1Lfz/FJo0bHrvLbcJpPFds4JMbg8=;
 b=Wi3Zs79dFx1pF6QdC/jdPkUiIkflmf/+PG+EFza3AW90TO/aRMBSNhVH9WwrAgx1seZTuioD4BEkCYWcMh166Trso6c0j0XkFHytcAV+knIAgEPsvRMxJDyxdlcBZpn1AB0P4XWiPoaig8DriNvSjVbLdVMacUuQ9L9RPo0rE4G5ARmQBZ1QChgNepRMrhH6OX6dKug/c/2mLAeiBveKd74+fJtTlR14CdmR7IyehqjWCJ/7S7h59+XXTPxeD9A2q4t+UQcW7z/MkShYkzDrnZN+T8mvpjkrFUFnZb2A/4gJbcttcnE1uT/CFPGpRrAXrKPBmWU/p+XELmLcT/ly2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR7EbpJz/UZJOLP1Lfz/FJo0bHrvLbcJpPFds4JMbg8=;
 b=CtPeNscRQAAh2WyzYAeeMyl24DDbhvgpc3Ay+aa06Ng/uVBo1Ls3FfcrpgHfY9lNWR5VkictJkIcNc3H7QK32+YEUzCkdioKfmmz8EhawVR/hj8QD4BJHowUJSRjYTQKz0F/vy6ZdQSAavTDdB7ZzUb1+eZTASAA2D5nSpqBQL8=
Received: from MN2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:208:239::7)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 27 Jun
 2025 03:40:31 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::48) by MN2PR08CA0002.outlook.office365.com
 (2603:10b6:208:239::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 03:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/33] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:42 -0400
Message-ID: <20250627034002.5590-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: e1efe0ce-7da5-4fe1-b525-08ddb52c5da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XunNQo7X+tZZMcVIKoMpzEoe2/wlpXu7Y7XpJ7EP90FkkUUoSLn6s0FAhcmu?=
 =?us-ascii?Q?+Wr+pF7STZADEbnfk+IAa5R4YcExQbj65+AxJeuIoLwYKftDHyCSqjwTVoCA?=
 =?us-ascii?Q?wGgkaP06kfp4WerXQ+JsXHPVVSg6QD/NUDGQE2WUH+jCOSn/lrmDmmA4oSSd?=
 =?us-ascii?Q?4RegqMaXk6pH+wOF3V/ULUYltlCYbE3NhRy3dKsENOC8YmR8kIIhWz2l1jHl?=
 =?us-ascii?Q?slndJTSu8By/wgNf3oI1ytscWGV2i8nEjLaXR35Zayhhc1MPJimiJj0SHRFV?=
 =?us-ascii?Q?23503aN/RVQqjIashGqORIGRqHBzNHYBKTJ4hmdGb0Hxb6jQGsrJ3a/eS+Xl?=
 =?us-ascii?Q?PzAJ0KV72VkIls+o1Ks/43d5LBbuZvHyXzl/7JcNAUYU+ei19TZDbg9SbyOz?=
 =?us-ascii?Q?r2rfiVIcp2KXMRmyBgoplOoqMH8/A1YtatmPDqxfQpDISfj3uBUv+SXdabsM?=
 =?us-ascii?Q?NeSFtZ96KIw3RFFQ6ZoklhSRm3OHcK2va38Q7gz5t6moM8Y8NUUU21J+Pvs9?=
 =?us-ascii?Q?OQT0MnBMlWkoOZEEJHZ+IBGzwc0lIQcW/LvnMyT2wAIitsKJe6NYi8s+5EUA?=
 =?us-ascii?Q?QTVSNmXT5pGO4TRb0QbeYtTYWAL5nDfmrexxmVkr6/ZS6wkzpGYG/VNr9eDF?=
 =?us-ascii?Q?a5WEIL5Q6I5+zn1J04K0C6Gc7D3bsSgiZx7KqYnM2TXisbotELkVXBPx3ptn?=
 =?us-ascii?Q?a610x/sicUpUGK+x5MqbJTqTboofil9CeFdUVwDjzxvdbXA4mtZws0A7H5Na?=
 =?us-ascii?Q?W0b+xX7TfbMc+IZYlL/56+zMqZFIsJhRtkyezVl9su8GvXnJhCRal0hUKbw2?=
 =?us-ascii?Q?8CYuyjFqNBJ+ICFBxYXvNxSGZtBSs7Sfz6SkPfa3f1fQhNJLcrKstDvf539+?=
 =?us-ascii?Q?P6Ku07DnQX0FvH/16MiNAzSDfWEJBvxfOY+68nJDNsM0z3F6WJ6MoV4HmSkP?=
 =?us-ascii?Q?fnQhWBcUq1D7zcVoPNrbyd0B6v/Oq9tbxpvIVF0TDRfAMlkXD8jcJ6cQ/o2T?=
 =?us-ascii?Q?enuFiSLcyNvI3HpcmbGxT5kuACoc9xfppwGrEtoXfIE9FvYWWRMm64ca9Fi7?=
 =?us-ascii?Q?EqzVbGeQwm6q3eL/4SSa0DLVPU4GNcxaSS2yGB9Z3MIj89SEOzRyydj+oBnY?=
 =?us-ascii?Q?PbvrQHsbjIhRCmI3SBbnu/hCeO5weHXUaWaXACJOWL2lVWgfmpJw2fXezm3H?=
 =?us-ascii?Q?2ZC2/ZUVxQD8Ar/NALSxKwV2Yq0seiBjtPa2huOnNlsVdwumuUe9esVs895T?=
 =?us-ascii?Q?44PZuG66xldgO85NSDCMjQPDsCEoAYNsf7KDAMHn5tdLcSomItWlWA8SKpap?=
 =?us-ascii?Q?DAkYKQi4AIQDQ0hSKFzvzidNB75VcggFG6GswVmLWaLpV018IWhD2VnvR/c9?=
 =?us-ascii?Q?8IfhhPEy7D4Fq/7OBaVuMuLt2amejgCjEeGrdJLi00q8O853KbRlZ3tQmF+T?=
 =?us-ascii?Q?YoRgW97vl7J9xneUiPQPkiZomvyUXgnoGMiSv1aRqYCcOxSwF84jT8gEwIMr?=
 =?us-ascii?Q?GR9KSBCzVKLPbne1Zriu/6xqgUnSjpDqt/2J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:31.0240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1efe0ce-7da5-4fe1-b525-08ddb52c5da3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188
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
2.50.0

