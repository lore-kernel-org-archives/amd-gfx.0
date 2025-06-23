Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EF8C7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE36C10E40F;
	Mon, 23 Jun 2025 16:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U7OeWLc4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8384E10E411
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2s7xYdqZ3M78xtNDCsxeflgAH2fk6oe2e1hCEclAQVNsVwDzP7eq0xwrYV5bS3xxwvtkr32orwCES+o7BPQwOKAzwo2OpluHLfAYeLzGzs520H5QEZz686igxE/5R/YuK3FQKT8OR8VHxoOy/pPpjFcg+3+vqqdSNCtQic58Rn00Lgk7GV+1Vkd4P2vBNfx8XOHoUH5r4stxZEN7+hIPk5D2b3qkdZtRkJwkpxWcOZHVbj/cosgwXdfuMSaYz70Z9i2Tz+QzokD1Qo7jVVEK2hUNuM8J6bjO4DOEnBF4Tgp7UvOnWXvKHNXQ/BwpAHyEmOlUzqBlQWfOdQJSguiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17MujQVqwYo0MLa/s3QEbm55MYkgqezVYmgL3rZCd4k=;
 b=JTpM1YsRmzZ8i9bAB+2rAjkKbJCTP1FAxRdAaSTnXd6FWSjKj2GRcvn7HTw5mSw23i2LQxxa8pRu+TGSjS8LUjlOwq+j4kE5i6iwQKbLAvLJN2zjz2qMjK9egIJ/8MadPhHL2jOTogMb/Qk6g0ld4J4d+levgqBtYKdqDl+tydwramNzwxexNZNk5XBHmJGeBmeI8CSFoHHL8fHt664TwFN0k7DPA5NqTJPBlqf973LRxYm5H/LDqN52h50d/hOD9GX7w8/NWqs68m7HwklhBIU24ssw892NokpdjkoBZnE1pI51nfqAnQpNc8rC0K0KXd5SVLMeWRNxdqjNAzTjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17MujQVqwYo0MLa/s3QEbm55MYkgqezVYmgL3rZCd4k=;
 b=U7OeWLc4B45tVLMcItqBi4yXWBsQc+myUac9W4axVjxfttPs3t3Y9Vdr+x2jEIX1AsShEParatGn0xLiE9AiOPLwvWCMPV2G6m4X6XL6MqlSoaFB3Fq6tY8fnC3CqQKl8o5Zr0cG/NQIECqWe3xzqtciwBIk5OxocZuK7kHZ3Ag=
Received: from BL1PR13CA0224.namprd13.prod.outlook.com (2603:10b6:208:2bf::19)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 16:15:02 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::c9) by BL1PR13CA0224.outlook.office365.com
 (2603:10b6:208:2bf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 16:15:02 +0000
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
 2025 11:14:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/31] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:17 -0400
Message-ID: <20250623161438.124020-12-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e662587-360a-4e6b-60af-08ddb2711bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6b7+aKua5/3VT+9sCOtN1yc0r28zb2836MEgAZOjpzNytf6N9no8jT6kchRr?=
 =?us-ascii?Q?+rjyFL9bg1ck2/wrdgFiXRcPC+jsfKQJLcyIPbl/4KHZH8mCSMujx4FYVoPK?=
 =?us-ascii?Q?ZIznhMeUVSRnHM6H2Q6+vtnieUXXUgrOeVnRWCe7lYOfNc+urBsj7XRIRFk5?=
 =?us-ascii?Q?nca4XOMPcyX5QC3BW9DsdF2x3dpIPxnhz4YS899WEks3Om/Q8I6Ndgr3oMZI?=
 =?us-ascii?Q?NePVouO8N03CYJ2cqzDDN7Eg1oUJBbDdcaTUd8tTMqarUNirft9Z4OI7dMDS?=
 =?us-ascii?Q?DM5W2oo9EbS9yWbo2R2qANeFNsrpK/hbEdFQ6u50ffPsN2xT6IINRFpkdhbH?=
 =?us-ascii?Q?D2X3jKTDRXbj6bhg+qOYorMSUIxti5RF1Y2eKEc8fPI4j31BBGtC8kL/ATSX?=
 =?us-ascii?Q?dV3sAhIdhk9X9zqaWTvZxrE7dFPILqIbZoI6OkT+Yq3xzgKyOOQeokT98Z8T?=
 =?us-ascii?Q?KieYQf0+DdVaX7abqGRhrr43NAYwGtPokFCUUyiBU+gT+1r65+bUYL6cgPlv?=
 =?us-ascii?Q?eEY/xuIUuFGYx066fUOGJX2GvOQ8+pCOOw8QTM4dvBqalGOSAq6qMk5mA4I2?=
 =?us-ascii?Q?ds2aGA5FaPnBKLvwmrJmnsmbSSn0rZ89IyjAAl+eFS1GMvgdjmUvRGiEC4OK?=
 =?us-ascii?Q?6N2ywkzK6LuzH9m9plbAiyzw+VLguq7Je42d9tEMuKK8yBzBeuSXaEyYwkZm?=
 =?us-ascii?Q?XN5mT3yqwAuhXCB+VyIpRvusn6oBSX1rG+/a/9tdrYV6+3Yn4YegeUVXnf9R?=
 =?us-ascii?Q?Rd8qngHRb6Ebt+V11SMCyoxODulfCz7Nju8oIkisnM8UD5ti28XQQyuxcxU0?=
 =?us-ascii?Q?4kB9hWN7T5e89+RW+HCfVYNFoXCJrL3IlQnLPADcCSpWKcgH6FxJ4SUzumt2?=
 =?us-ascii?Q?jlW2bbn5gZ/ep2Dq+YT5smteuiaYfGv6WHit7s16jzjn9o57X+rVFTRM0F2j?=
 =?us-ascii?Q?p1iqrgzEhbb2fzGyYhnEgmih2YG1AbrHVxXJs5v0pWRrIdsT/JWg/2Pp4QJ3?=
 =?us-ascii?Q?Trm7Kfp+avGWJj+AaQ4uE4EUo+2JRULQcA4WGQxEk0COqmmrEsHlyNtzeUOR?=
 =?us-ascii?Q?ZgYkWTWGSMC4MP6OqULUyu9wTtnhuRdKjLv5WnhxtLdD0rh7gT+DFAUzEVHs?=
 =?us-ascii?Q?V+LmpNFNCmCazb072zX37B0OAsyhhFQ8/UWgjUV6ExjGMRxF8+fU0lpyjQE1?=
 =?us-ascii?Q?AJaH+sFDnG2bcikWICCbApWFdiYCKl0jFxwQGp6D3FK/qRqNAbkza+aTppAv?=
 =?us-ascii?Q?3PdsChvmWh1IBlhaRSxpKA3RT0axb1iaIgQKJpLQi8u4r3x4mh+GfT1mwnOz?=
 =?us-ascii?Q?17atQiuPDOrl6XARisi/VMdip9WDQYNPxUqDW4yiXsWyRWyNbcOMasLTsTRN?=
 =?us-ascii?Q?U75vCPAzUPJth5ue7IuiSkd/NsKlpoqCi6QqRCg1lpc9AEeGRC5bvFYw395n?=
 =?us-ascii?Q?m4ZCVEMtO9Xq9aH1poiOjBSAFSR/XPjaeOxpIzHfAAetuojuTmvbStgU9NlV?=
 =?us-ascii?Q?hifWTbfQXiPyax1UPJWqbYGqycxHK24ES7V5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:02.5552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e662587-360a-4e6b-60af-08ddb2711bec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
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
index 8c377ecbb8a75..89010d9c9d5ee 100644
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
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
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
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9603,7 +9581,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
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
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
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

