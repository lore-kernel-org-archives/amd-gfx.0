Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A299BC83027
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91AC910E935;
	Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDsupZzZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E2A10E93E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkuolkuQAZllM/oN5ZenmaOwPoH4gf8Lfs6ctQ15kwwt67dAFKEI3DiuRL7WhZcJG3UecxGnBOqqnQOb3fLHiceXaEw0t5nfwiUPMhS/vKEISTSHKeh7vw7YJhLGSdG4HkQvLL8Xw8RL3aqmINdKSZ+3SOOzTeZwInt7RwAYVb72QigcOfOadQ8TiImdYqIIBicL83TXtWypVfCLyigmIXMfATcnjSBHxPzV3apdBMrDoLgcubt3S4eWzIeMk+Wh3zuJ5r1cpmHf+qKImYD/o1UmdyGlhVxWmMUvfC6pXMUe+zyDH+Q0iVDgsPvjhLApPqi7tbyReWKBdbXHWXZdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntTZGBXIUpav0emLwJwFaCOfyvkCgpMWZIkjwW+koJc=;
 b=YbfePpxpV+qrw2enM0wuotck+GTFNSNEU3XKpJxwmT5ctFr4qySbF0oiEHqwUN5isGz/m2pknuykek2t6f7x+L7w0cFP4cK9x4Soa8tU3ZcEyXweYtJgTDR9SDyo7I3P8bjftoTVtx5WApI2DVRaBuYXfGJk5aoJ3SGB9zfQDYxoKZG/NeCwrb5Lrt48l46uspc+LA4p/UXwZoXMtd2b2/uks09rg8qaz8fFWFuqJPxKvmxy7IkvE3c6QhWGEfOHWivJhy5+KjaWxyQJifRrcnsQLI+n443BlCGSN6pCtYTxHaYLLhXDIgBqygrc6+la4Q3J/qpgqxSLO4Tqzv+IwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntTZGBXIUpav0emLwJwFaCOfyvkCgpMWZIkjwW+koJc=;
 b=UDsupZzZt47kELzQEpmhlq5f+79/4jD6Yd+VGBJr9to2MCARKja6aW4dcRsvUg/8eCSlRrrdD+6REOG6ASnyqJFL4rUwjpuvBV8P51ZHEAsWfSOXVHmVPhnrtQj+LMKP3KSwVaKMT/xuDU3U6ZWabTC453SL8qbjr87WTJaYL4k=
Received: from MN2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:208:239::11)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 27 Jun
 2025 03:40:30 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::e2) by MN2PR08CA0006.outlook.office365.com
 (2603:10b6:208:239::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 03:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/33] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:40 -0400
Message-ID: <20250627034002.5590-12-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9df44a-21e3-4486-1c5a-08ddb52c5d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eMLcXjcU0HBx80l8lK46/dQIXbnU8rYW0qxcrl+gL6IRZpvFYxgeWX6LQJYx?=
 =?us-ascii?Q?DcESXKi0wAklsL9FjncabjKEQnRM9dSin+9Kq0fP2OCQJpSbTJfG+s5BZSSD?=
 =?us-ascii?Q?16tKBGtyl4rvGgOgFKsqNjl2TYT9INlhljC4uGz5iwBCEv8Aiysoq6XUget7?=
 =?us-ascii?Q?D57LReHd0ftBbTx/jkzP0m2+2m8C2F1A+3Frk4S/jY6osd5bA8pCRKP2Tfs9?=
 =?us-ascii?Q?PUePu+uYmhCfJPNahG/uuaQZ3L9r+/ePs8PjBltdK0jN5/+xMhQ/KbbWgglX?=
 =?us-ascii?Q?IAc/5yhW3XmWy0nRhKK1lWrx4Rys/H6mBoValVNZLdo+kT0f91WmdQBdmIcv?=
 =?us-ascii?Q?R1RhBGFUEtWYEi0MLPGOhjhdYfGWltnv5LQe7T57lF4t/8jPD/2RJ7B/AoEY?=
 =?us-ascii?Q?GuZHpefAmUTGzQXd3LAQo1X3SirMB+ADuqXpPL5/5kXL5lneKah6V98NiCWK?=
 =?us-ascii?Q?Qbm6/5BPYJWu9N1S3M30enzS8e3qW6WBtbFogGNPZzy4+moklbUKMu0ZprNi?=
 =?us-ascii?Q?2x8pFFyOdXjvPsR9eVi8retsXcbXqrADCHl1DBPMRVechZdr8D//7wcxgMYE?=
 =?us-ascii?Q?dUEJIcNJegLOTiYPm/3FwQp5rt+cfEXOaUziW/8lacCUzU7er3ThYUf+rhR8?=
 =?us-ascii?Q?Vhu8mk5GAi5mE6ket7Hqz4KZ58EQbZxpQwyHBbT75MGE8oeEtAhWcLxHHnYC?=
 =?us-ascii?Q?myy/T1FZ5lMcueUHn8ptCziehZEy4S9z6Z6buy+GzvJECO+9VQ+P1cQRLRpt?=
 =?us-ascii?Q?ScnhGt5YVH9LtGUCiAwGo4fOwkhJk1nqv/6wqGIaMHpsW5tgGT6awvbLfZ38?=
 =?us-ascii?Q?yWSt0iNOIONLhTTnq83TMRf0RvEv9nxMySdC/WwqwETrdoV0WdQRafGBXupL?=
 =?us-ascii?Q?YyOtb2SZXno4eHvhiuJOoET1u8Wwho5FCW+JuVS3MWnVc7Snz5Uy90HdMQuE?=
 =?us-ascii?Q?H9+gaDWP5GTI7R8HhSN1fX49mzVXmnhzXxJLUjqd9/dC4vFSKmoGRJXjmm9b?=
 =?us-ascii?Q?nDHU/BiTN71iHUvCq9BmrIE5kYgW6IJ/9pPpgpYb222uTu7Lg5AD7rOJAQ3z?=
 =?us-ascii?Q?xIROEGhNc+g31S8u8tSQu1i1GPZZ88NsEoeavdCfUJSsE1ZUpOZJN3FkTwWp?=
 =?us-ascii?Q?GFvdzMdDNJk7uc+zzbaI1xSjz+lDVHK+hv3u3HBpepgxGPTz/1VdfKmZDRWy?=
 =?us-ascii?Q?dVAb9sFFwZ0LAc3D5nxNGgfKcBu9inT7C7nk3RrlUFf5QYoHZxttIGWDd+CB?=
 =?us-ascii?Q?egmINka/2euuhyJlzwoBJlPcSAxrLAAtKcE1qmbJOvN4P9MmHHhFoPVgYucD?=
 =?us-ascii?Q?H79j0IBqxPt8YuiVP4hrn9a/DGPFmqGIDMSDyr6r4ZSEKTUnimRuzWoiZHZo?=
 =?us-ascii?Q?FrR12BAbzGT2V+9chFXxgyBPeoXQEIsp0m0YLlEmBYWrnfghbgP92vyKSTfr?=
 =?us-ascii?Q?SiMUUTujOMNrj11O65O5aStIVUIY9pMc1UYdhtot0RoqbhCQFGkW0lla1DEV?=
 =?us-ascii?Q?kVKBfFsQ1TEyMcPxPJoKkQoJNdIuqfyIyzPM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:30.1880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9df44a-21e3-4486-1c5a-08ddb52c5d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 41 ++++----------------------
 1 file changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5e099b5dc9a3c..65429afb33ec3 100644
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
 
@@ -9589,12 +9574,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
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
@@ -9613,7 +9593,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9625,9 +9605,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9663,18 +9642,12 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
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
@@ -9909,7 +9882,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9950,7 +9922,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.50.0

