Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15260C83F22
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A011210EAEA;
	Fri, 11 Jul 2025 22:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gHs0/jUS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE8410EAEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+qHm0z5AXBojmueWmhVDG1nt3a57LFm5mVVxU5nqMdl39PDDrniJ/TLYtiPrsKc5wrp7WupGElokSLdMDaLPcQmepVGWegXI17OJzoq3ob4FKUZrM9t2oEUvq5qDQtiX4LouAib0w90k6dVF5K59WjSMjcVw6Xyt+BRzAW80lmZl27Wf3DGrMPtk5LKE8FgNx9/lv0vqwS5oCtehoaEu4/gNJwvLbC8DtG1pTnMg9s2DJ9wQLLiMrDL6t+R4z0Y+NeyIfHCBKlclNL2z7fkOPpwc/Tk2WH2hzblS8A2KrRjG6usKn9hMtx/Qy2VXNpzil7zAz2FoMMs1v1e6EaNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZZso3tEWETOJishJ7ykustZ2g7ZGZIdk9hQMPcZ8lQ=;
 b=L4gw39ti/GX3cjmWfpFgy19vFvZG8vkXn9uD4kue4/FWi6sjdLg8rGKchZCecxEcP5682qjKDHFwW8keYPPUwVdq8E3E1lYDvtsr6lXMlOHqVr/4E4O4iXM5W+te4eKUl1xZJ3D7nkt7h3jdD8dt3LLfEkS82B2YZux3lKHy+iBdJ4HQsDKUS0XXzMcG96G96VqnlT1g4HL5/k7TCCDR72rqYW0iC8LkqJ+9v1YnJ8YETyxLv2Blr8mSPmo8yTAnX8mJMjvfeGJ/0TFzDUncIRamKZoBBnxd4UGXuV49fFuZeY7BN8vG9D+fnyBxbHQjLhe79TRrnc3Gfwj1g+pSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZZso3tEWETOJishJ7ykustZ2g7ZGZIdk9hQMPcZ8lQ=;
 b=gHs0/jUS8qwhDXRAsyHhydxvYAx/3dQzKUqZFY36uHsKdhp4s7bb69JktyzkCoePlDyqjlqh3XGn/Zk4DDcwzp7+jj8QBUchDbWuvv/KEZimGhdR7ArFrbP78zaaC+A3pZt9w8e+vX+3KDSM3+Egpz+8aDqEPHy+kksSrx1Pf9o=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 22:40:47 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::41) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 12/33] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:03 -0400
Message-ID: <20250711224024.410506-13-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: e87b0be6-7d99-4800-94f0-08ddc0cbfa3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ula+csVJJG/pnsNOzCUWdqqjbQjzBB6HDvR146f7f0S9LASdqz1QOgeNbc0b?=
 =?us-ascii?Q?6F+YTig1aZEzW4bDe6hSfSvtHbGSWXJBdb3kYWcGsXh7uDjagqkKlq+/QzNf?=
 =?us-ascii?Q?e+uJOAgaaoGNGLrldKUMuB//piS4xGTneoOce9kl2cG3rvFtjK+4h9oAMkA2?=
 =?us-ascii?Q?z1aoZTqOJnBr25+uyHkkF9iP22lVcL/Vnma4UYu87A6zfxyBF4bLcOTFK1OC?=
 =?us-ascii?Q?NVS2bTX+SItH5740lRwPV9NUhj+3I1MXCKMdioPm9b1Gm5gioeZuQ6ki5ukZ?=
 =?us-ascii?Q?io7zE3xg1RBvyRs5mWKIGcKUv/pO1P1p1XBBqG7mjpkzWkfOIicr+o9/1rel?=
 =?us-ascii?Q?Z56B+yv4yvx1nF/CC+Ned6vhIFgpKZ4fGoKA+4QFTKYwnkTWn8I6YAEX1iu9?=
 =?us-ascii?Q?U/O0yEo5fLti7zs/TcRSxx97sUN09PBIeKtKWDKnRmC0chMlnpwNjDHxo3b1?=
 =?us-ascii?Q?Ev4l2uDNEPrISC4eYO9jdxhk4Zf5BnS/oAbj050QJYhCRY/VMf5AZTxpap+E?=
 =?us-ascii?Q?PczK5AgK+p5iJ/dH8rAcN7rwF8tUhLP3PTXXb+HkpnHJvL8iTzaVssu5hhOw?=
 =?us-ascii?Q?YtbjM1N9jZ8mmdwv8jTWL3l25BNYXtVReuv+qyFZi92xn19lXHFh/TSx1ncf?=
 =?us-ascii?Q?/EhC1zEjDhQJ3n6mhCqd4HFAdU+2qx3tKImj38mGHzWkJkeLaP3NhPRGHOf+?=
 =?us-ascii?Q?Feb76wn9D+I8q66HsTdv4V6OBHfaxA/goXtW9W1vKlp/8ffaBzkiVx/a1j9o?=
 =?us-ascii?Q?VHzOLbjsOceMHWgdIuovcz+mjnL/IhD4QP2azgzNblhYmX45itY5MCijGzQl?=
 =?us-ascii?Q?tYDUWH2WfcWN354wVjshu2iAaAdWT+Pgpfr9sVO6k8rR8eNGrvL6EkKE8wag?=
 =?us-ascii?Q?Un8fEJzAAFGatQg2VhQjuunsUqoL8VS28Im3b3RggRJjUwHL5u7Z+tXmCiZl?=
 =?us-ascii?Q?e4nrYks0lKWHOQzmnLNKgxQIIlSUebPziFcq43g9KO2X3y5zrXhUsvrf5Amp?=
 =?us-ascii?Q?61W9HgSlCGg7L6co1h9cifod1I4G2XFjn/e8g0HUGG8nnX6Uk/vU+sDvgKWF?=
 =?us-ascii?Q?PiGf3fqPNhEUDOyfjM5hEJJQLXqrhYLd7OCX8N+yijr+WBm7zdU8KmLYody/?=
 =?us-ascii?Q?kyh8eDPhAs640Q/yBn4o6eIYQP3eyI443EkLxn8uNxFVmvUG9uRO8EtZ++Rf?=
 =?us-ascii?Q?g+7+lWuHH/S4ONbI9vUNlpFpk3s96gvvzky0e+7EQ2m54wbTd4qKu9ZkeqJq?=
 =?us-ascii?Q?z8cB3OeVP1+pB610zH4ZTStaCilvzhxrHctxkwJxvewHUB2Y2owvpbin0Pos?=
 =?us-ascii?Q?l5gNRgqQwcBM1sMMD8P+lP20utUznOznnBMuPB+bW939Go5YRNqFiVh+w86B?=
 =?us-ascii?Q?2TsDYKNBpuNOsxU35GLphRfjVRzUmr170NKKvk6hJVLL+dwM/xWLk7uWEgMJ?=
 =?us-ascii?Q?J2NOOEsOZWiX9PvLWymEGGxCs8LgZ6IUS7PDHBLCOvY5Outart3aRegxGqNe?=
 =?us-ascii?Q?lNpAd7NJFdZwqr8F4T6TGLFovI6vwrF6+5E6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:46.4966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87b0be6-7d99-4800-94f0-08ddc0cbfa3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 372dceceff359..465fcd6503735 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6288,21 +6288,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
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
@@ -6826,7 +6811,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
@@ -6849,12 +6834,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
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
@@ -6997,7 +6977,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
@@ -7018,12 +6998,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
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
@@ -7259,7 +7234,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7301,7 +7275,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.50.0

