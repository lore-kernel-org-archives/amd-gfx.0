Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFF4C8300F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FDC10E80F;
	Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lmpVqqHU";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2D910E805
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjlBJopT0MlVORAfGmObp6s91C1b93M1sqCeBpQmfi+k4LPg2ThpamivhSyommNG6e9Myp+Q5OMwo58iq7wrOV2jBuW5vwBzFtD9dnjdcPBcj6kgr5rVEDW2vFscT6RNeU3a9h4cnVdrPohvWqeWhIWRetlsfdxbyJzuAUNRRR4ORyoGUULoyjMNF7exOYvtMT2NNl9euefb4CjxHyE2LtugWR4TBC9tgRo9Jfyw+Zs5CUiTLUtYqnW9KYM8N6Bf4/YuxmV5tnU6OWMl0hw47eq3EiA4egrzl1KAI4mdPnHLnj3sgfLBdsRdda7hXY+UwqUH6aQHbMx9+dlVpsTteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdQwpZrLhMHE6OtkZTzdpCAaCuEIvTE05jEmifUF+oY=;
 b=ULsazmxo2e0B3Zd9+UtnIpcg+uekWMiYu76Xqy2V5lklveK8aCXOR5dLPgUPeQkaS8AHiG5hEhGJMnhVk5L8h7AYYvsx2Tb1ucasLmFG39wU6iwDzYh8IpfOrHQVwGvKGNMf1qhhuo+5JqPb9zym76GWPT4iD6u2YGGnkdwbqBUgu7tAa/WFetgLwI8q63kY6M1M+LREkoEaxJkpoVCk1nxdasWOiz3Ry7e70/XM01+UXk30lKB7mnwX+7cdeL6IDZCJ6n81tSAIHM3NUUiM4CueaIYKQ/MaM+5pB0zHoDmA7sywkN34egq/BkWdNHVZDOm5BieWubfasoe639QCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdQwpZrLhMHE6OtkZTzdpCAaCuEIvTE05jEmifUF+oY=;
 b=lmpVqqHUvGCOTw+x2xszKH4mPDRX9fI/0DoP6MUU7/Kt0B1U86Nwrg9VDIDpyknEGVqGiLqT7O34IjloNUfbBWSWVAzV5ab38kSbMcBh1pKQRpcsis+sffRrCMXKaPJiIgFASqztOjdzpQdrUHff2CsFKeoNqCwhXnEd1q38u24=
Received: from BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47) by
 CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.20; Wed, 25 Jun 2025 21:07:02 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::4) by BYAPR01CA0034.outlook.office365.com
 (2603:10b6:a02:80::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/30] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:19 -0400
Message-ID: <20250625210638.422479-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ec1cfc-9ba4-4469-97a8-08ddb42c3b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xx5vSvix0yqioSNFhaDbFTDo5Saqv48ccKHsIbB8e6yPu2mG/GCH9JV09GgH?=
 =?us-ascii?Q?hCDnGXLk1CJRgnK4C3s1/g6DnH0T20ZKk+DxWmc1kVKYFRHBf+z8JmzJwAOW?=
 =?us-ascii?Q?aIuBTterZTtULs0G/riFAfiT+UuHuqmOb1m1YWCI2K6apTLm6UuC5z0ka4j8?=
 =?us-ascii?Q?xoYjfmWhmrmrwFgeSRY90hAiAmpc09pOD0fo0etO+wDCOmEVr1ipZvRbwvDy?=
 =?us-ascii?Q?vh4JPey48ErjduK+Al1C+XHJiNl7Nyc9W7shraDwMNdF2AiCz+V/7Q1s9YFG?=
 =?us-ascii?Q?OOD6RQ4CkpZ9ar2XWR2tT/B3KUFicFT7I+udgb4r6PQrYrhuNOHp8w0EfXN3?=
 =?us-ascii?Q?8pg2aT2/r7dFDOoQp7vYTkRjotLxQ1BCwJZuqRXWqr8qtJj2/pz0OkGHnQM2?=
 =?us-ascii?Q?TNkbjaHrjdC0HuYwZaDHq35J6sKJixwqh5UwxTXhahfZlz5dNTwTQTOPHI1l?=
 =?us-ascii?Q?CYCLGMsOMDSiJEODWZSiwN+FGuGxH+KeNDWHKXG8QQe/Asydl462jiQZWMWb?=
 =?us-ascii?Q?KUrtdncO/EO84rN7KpcQ8rEfyOlYx3nde/N4h6+JW+JV0Fm+b/vfIRdjdFir?=
 =?us-ascii?Q?MJfvXFvF85QzLpHTvtBK/J1P34JhV9oeCZU6Yv777qalS1hrY2lVoW/RD1Fh?=
 =?us-ascii?Q?LL70hiCweCJqBAKX8g+4HrOqUiOSnHToJDZtAkahtqxw+0RHrKi/9NIij8Cq?=
 =?us-ascii?Q?RZGND3rOGKL3SMLXDmJCl1xoUDYjrwFjc30Dd7pCTlVefV/xW1DTh4L+eymO?=
 =?us-ascii?Q?IJL0QfejQ9pe3HCZeEb6uIpRdUAdeIla8dZIQ/tN08kB3lRp192KNKG9tPmO?=
 =?us-ascii?Q?Sse6DhnGPmu1C1UsllGHqjhwEwccEPmLFqvv5X4E9fF6nyT7AhC2BQfCzPqC?=
 =?us-ascii?Q?FhXIsmqrIqbW2oHnDZGxNTVI5ehvYXPqPuoy5PiGeWSTLK2ZfpyavKHj/QLh?=
 =?us-ascii?Q?A1p+c8s3ZGmD32a7fUWJpDKHnCQLLkrinSPi/qFP2V8KYt9ytMKkGxL0EPbC?=
 =?us-ascii?Q?MdzpcPZf3bcgPKTQXDzBX3mghX3liPu0UdltQCrpa6jM4lWqo9oAEwVQ+hGe?=
 =?us-ascii?Q?KqomViEL7/lPD+3H+hBpFn2AS3+hy5JHLmadjJ/t8g+n5La7HuJXJGdxPXnD?=
 =?us-ascii?Q?U0v69rFr+QtQZj7/XpokrvsaJml0EJ++W0uaj+EIodHqvBxL+FKfcc+E7MTC?=
 =?us-ascii?Q?4PJGq/4QozxyrYE8Khag+RhXdYHR3iP054zIGQxgEcHT+HxRuX51uf6su+V4?=
 =?us-ascii?Q?0FHUvm3RbRydnhwKeesSuAZVTRjYEgABwJTGDP45ZkAXmZs4ZYP2laV3eGMG?=
 =?us-ascii?Q?Dn14Tvwf6TCZ164/MsJ1pcUWs10EVfWpwvabVSGtDBjnwREzKtJ8O/g85qIe?=
 =?us-ascii?Q?cuQ51+P2ecf2t4iCSxFQ5LSc8pO9Y/cWDGfguKDIr6FOrO5BC7s93XRiZmB1?=
 =?us-ascii?Q?Rnb9Z6P2bPK34AepV1Wh86KzciVUJOgMHm4dl9YpIENLFyxjPdkaPcZ04SKn?=
 =?us-ascii?Q?U7HZo2xEJtWvjeWOV8rHmGYCBTHKXLkGoX5g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:01.8044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ec1cfc-9ba4-4469-97a8-08ddb42c3b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 37dcec2d07841..04b2e3def5098 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6283,21 +6283,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
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
@@ -6821,7 +6806,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
@@ -6844,12 +6829,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
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
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -6992,7 +6972,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
@@ -7013,12 +6993,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
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
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -7254,7 +7229,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7296,7 +7270,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.50.0

