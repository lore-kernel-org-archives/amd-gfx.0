Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA86C83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C7E10E537;
	Mon,  7 Jul 2025 19:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LJIlz2XE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDE210E53B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiwPFWqS5jSwjTc6WPlrHguPw8QOuFw8XL11liEc1qX7ApzeHsTQv/jAz67hVZv7OAN83fzwCY3wpIfCGz3dRy/CWmjOajyoI5/7IY7k2uqwyA5f6GZhpilLEFwSbF7bMqocGJl3p3i+is7FeyA39lghff4sGfqtSUfjTeLklJUw2uQLMNl7vykbDUn+huWhfSJkcanKW8+kBb6CDEx968ZkE3bkkKACTKPOsFS/d3o/Gn4rlKrN4ycID7cq4yNWAYWufH9DTwFR6Xceg5U5tkYRR9li1aNlC356Bj58S+ScgP8nvr8v45OZNPBSRtgTSAfBs/Gr0gRtW1MqC2HGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI8Rnnd6dAIMa1jeDc6ljyxhmrvbCz4rUyXz95a4qYY=;
 b=PBYCc0abvukkE2nK2xrnkbN13HioVpn35Z+bjTQye93E9UV+MxZKo2NeHDRpUGdUYtJqyAD+P5BXaaidTTZfoXjO6YnWJyqgOOHnSkJW4Jm5zyZTiBMdwYybEax8enHeQYifFXUkEYtRF66ftTc6LjVHZP8u+RWs8syb8M5TYZq+Bk+1MD/1GeVk7Mtp7sqKM0DnStI/egG22KncZ4ocXN4LU0SIFTmCW9fl3rziph7f8J+e9BwonP1q1vGOQeLOp5ZTMtz0ywjWVF5xCaesXE2ooOaIUbvfEA5JHWYOcl+aZAkAvsCSKrn99OvpkbBfuRMgjpdgIkEPpOl5dqfZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI8Rnnd6dAIMa1jeDc6ljyxhmrvbCz4rUyXz95a4qYY=;
 b=LJIlz2XENKyWZPe5pemebVc1Cm4s7c0pePxPAIu8wrFdMzG4zWe94N+xXBhxQ0zlb9tIX8yu0FXdAOC1wArwseMrBTRkOsQnyxvR8aCuLkzqRzmAexEyQRfp7wSgwOCMFIYSifzc/ekfAb7B3WvRBJqxKQurZgM0ZWPYiBmuFB4=
Received: from DM6PR11CA0001.namprd11.prod.outlook.com (2603:10b6:5:190::14)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 19:04:23 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::45) by DM6PR11CA0001.outlook.office365.com
 (2603:10b6:5:190::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 15/36] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:34 -0400
Message-ID: <20250707190355.837891-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4c0529-0357-48a8-1d05-08ddbd89149e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XASLuv4ji1hc8opW9kqq71xhJjzGsWlSpUWnHdb1ydr2WU+pZtCbINDsKYKZ?=
 =?us-ascii?Q?4JDr76W6t1AqLkAcm7Wu5qvyVd2daZDtUb9jxvQVRfGFMVHeenXTQm1coH46?=
 =?us-ascii?Q?x9kFSx7Ag40eLoy6fs7OluGLeUYE7MBLqnHNi5/ULgxdKCeoy5nMUa8KM3Re?=
 =?us-ascii?Q?k7GRVb+X1l1CF0jMHQvWJRC9rCvXndvVRJX3+tElVu/4Chn3iatC966aiSSg?=
 =?us-ascii?Q?1tzegCgkHkj+pnd4MbsLJtL7xC8cNhwqbAKmw3qcNT1Xohd//yikcswYOB4O?=
 =?us-ascii?Q?TI1BwTU5E262MIs9jDr6wP2NMfzhMZmQEWEW21y0MtvlkHNX8YulhuBwiY9J?=
 =?us-ascii?Q?Z8tl+MwYkMQb5uSxr2x6CAIyE5DNr+922XT2mIBCAFChZJArjIutzehnpOsh?=
 =?us-ascii?Q?+c3t92UXNm5143GX1WjyCt0TXJL2QVgCa+VV3p7phdhOvYSMYfAQEB8qQ7Ze?=
 =?us-ascii?Q?k5dOs42hBsiLfYLcVbL2NI018vLllew0swOq1nQbwstiucRhHHNSB4lwJWAD?=
 =?us-ascii?Q?ODv41gacICSURY7/DeXUTNDbqIghSMmfxkxVjzMOQKx1FwdwROAJaz5/cAN0?=
 =?us-ascii?Q?STMo63Rs/IzFI2howCA98wc4rl10htsc3ThZ3Dy4TR6YgEs9MIJLeFl52z1z?=
 =?us-ascii?Q?XOQ+5Kq60pQ3jBQ9eDTh4WXc7GLMsXV2lkO8nzO9X3uejMokkiPYAunRj3E/?=
 =?us-ascii?Q?CFsdXkbaFmkLITXviW8oLJ0YiT2gYv459P4A3R0l2ZwdOLdr3/8BPlPOanqF?=
 =?us-ascii?Q?57fNHAcSBtKYM/KvDNOrn4gE1zrFQwmoE4vWD5qXJd7p5L7Du90KHxK9y+eq?=
 =?us-ascii?Q?n4RiS1GOzqp39rrxpomcqhcw31YNJNQsAWwpIpFJRxmGOURinG9Z3XraSVu2?=
 =?us-ascii?Q?N0GMLzRmOZJO8pqJ3RIvOsoS1HNu4WiC7Bp5OjWZ411HtL09J17L3Mnqu8ID?=
 =?us-ascii?Q?l9OAJqIvNADZKUgj8FR2KD7UIgiUqkHzDnhj8eaifDM4t2IoOXO2BNLPpCba?=
 =?us-ascii?Q?snf2lZwKOZWbwD3lyHHlT4Anf4a8hVKkhXsPlA17EEvuORVkieorvW+jPu4N?=
 =?us-ascii?Q?rfPczfb6KGEX5cTWIiiMN4FOwQWmEJJ9ZdGzNmRMmGInSuEGNR+bW0tGt5ON?=
 =?us-ascii?Q?s6f/I12OFBRht7TMWH3JNsTIViUJ+S9JQBXALE+vTgDvmecmy7vwkKrW8zow?=
 =?us-ascii?Q?DM+yvL9OYi8g7+cnfg+GjwfM1E7caQquPYtLtFpxcynQPjaSmDDdsp0G8bzb?=
 =?us-ascii?Q?f2JOcautI82EqWpQHPQEObGo5Qce3UyCHRbfM8sqxzM/O/G8QbRLzwtQ7Kmz?=
 =?us-ascii?Q?1d264UghEPBcNJmZTLqlmds1ZLDcfBQxXBlk/LJ1ijN5baydza/NFKU+xMD/?=
 =?us-ascii?Q?TWj2B6mNf6gzYI0YyLoskVtc1azoOnLcJJESvFF2j0EqB8ARKZHaXdH55KfW?=
 =?us-ascii?Q?XL71MJCSvVHe1RAE6Ju6BoQ9TJSv7U1ZD/SQqkHF03bdnGf1I6tIxo6N806K?=
 =?us-ascii?Q?t7oxw9TBvnEx+LfIwaqhPj7vVX3FO8pYMJTe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:20.9664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4c0529-0357-48a8-1d05-08ddbd89149e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116
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

