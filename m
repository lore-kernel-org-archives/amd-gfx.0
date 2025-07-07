Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20D3C8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5955910E52C;
	Mon,  7 Jul 2025 19:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3u10lVtE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBB710E52C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKyw2lOh5wtP/WFQglocPVmLpFvGJKDomoHNUv5fwE18tsMq18ydSFSQ1zbsWcCLC3Bv0AEdh44Wld+WddkGU4aWNd9bIW4s0lW9SEiFwhmDwkAooOW+ba/qyLri9HcL4zO43ZqSbe+A3pGLgPA9rCAwpck6ionEw1X+Qmens77SH0QeKdnRs7wYOgHVbcPTFBy7uJ+HcipSEq44eQCx7gxVTsrGFkYxntDJ+zlWFHrBjEszLmXBvOp5LW8jDP8AfwgH3uVHGg65/1pfOChqBwI7PudWgrBxc6OneNaoPSCyCjCZZtiQM4vSH3PjDB4F91GWMKJfVvAA2Y+PpvLuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWz3C3Aa61ieclk9aNKs35izUGCGqNAeyzVa3tHAhcE=;
 b=P6yBTIwLZlRXFOp3tV/G3aUOWSOIxwo+GmhGhPkxDSwikEo1Tw+qUDEuvSpLE9Evz6x5bElqxLBoGaXxrx/uFUsGV/PKRbzVJEj4R9W/RodtO85kic3Vf+7LDJDntVvmYX6nIcAXPF0KDi8h3FPxmeEBOIMl5b/O6GY1zKQhqlBVeq8sJyTmQSib7aL1Mtz0wAdLXQ3/jA8FuGn1V0vLT7zlPtz6LLeo6jZna396ReUxFvdqGuG0FJTS7VIcWQnLYTgWqakUsgEkkCEckZf0lbfB9qDGwhUgm7Gdiyt5rkqDreMldGbc5mN0TA/wsbIu+hnhX39dFkdNVN+ZCKp+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWz3C3Aa61ieclk9aNKs35izUGCGqNAeyzVa3tHAhcE=;
 b=3u10lVtEu3f10BPtc7KOYemRfuAl+H4TS7N/zRYct426awmiOLUyZZqniVyxUyG4kt3neGJZ/FS3Y/1NBw8PHNO33vfDJxggWF2a0QM43Qd4WnKQ2w3F4fA2Q3f68D0v+1hfit1dAPP8mCH/ve9IwS+kC4vhEQy7klPFod1rjo8=
Received: from PH7P221CA0070.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::22)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:04:22 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::5a) by PH7P221CA0070.outlook.office365.com
 (2603:10b6:510:328::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 16/36] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:35 -0400
Message-ID: <20250707190355.837891-17-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: e590b029-4e23-464b-bfdf-08ddbd891530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HAVKChhXS181Oc2OQMF5aFH1aSmUZy1AOHYrN1LYqHyl6xxD4JfVqiyKMMy2?=
 =?us-ascii?Q?H7/pA/xlPMWqkeAGFtKSPWY8L51twzfRgaTVWizBuTurb+Us1j/wxcfL3wY2?=
 =?us-ascii?Q?BmAgK2SKt38Jwmu0b2T3McYE3Q4WAf8Abh+ktSK+UJGR8o6QcnkDdw9HO44g?=
 =?us-ascii?Q?OalAHYNspoWh9zdmJMqE/j7LGKtJ4bfeU3unHvo6/fBp10C7zH8z23vduFez?=
 =?us-ascii?Q?zDdnE1VAdDLdzaCiSrwXAbI/vhbWBa2WBFt9mf56KPmcvJeC4TDPs543RZ1K?=
 =?us-ascii?Q?FmXzZDW9fD6OOVy1eKJKmd+CFDBwsi6FSJJLu2e/s25+wgux8R19ZWCXB/9v?=
 =?us-ascii?Q?BGypavQz9e6U0R2H/9QVqDghxKL0gRzOdxr+qGYa6Ka/15eynUtZHtAd28Uh?=
 =?us-ascii?Q?CIXUG/phjiubnnu0X7uMR9/tzgiItbWpkiCx89wL4VPJ4pvi3HwND0W3R4eR?=
 =?us-ascii?Q?IAtI4XcAQSnIOfxR4v8Q9MYiw2/6rZ+KLAhvFWPP/TbQIZ6F5XyJi087oGm6?=
 =?us-ascii?Q?8mmIZmpEpLKcFoGqzUJzpICn76CFVxCO3A4mc01TKCVcQZsmyNDwaX3iEU4b?=
 =?us-ascii?Q?N1gzsEU7/m77j4UpedtCr23Caa4V/1gmOooAoO1/s8FwhJmHL/KMWXevzZWW?=
 =?us-ascii?Q?NL/zA1m9Q2JSz3ezAQZ6/hlzaEkvdoNr3j3TTYoRJt8lf3VZ9UJD7NHAY+9w?=
 =?us-ascii?Q?0oREvvMm/yUwePu15erUvFWaRjENNu3a5sgckYtEUdJmSkjXMy1VQoVlbBKv?=
 =?us-ascii?Q?j6vQF7KCKgLH/SOlXM0c9DSavg69G8gLifmdQ3hBjVmwlawOj8OAp0enbWNP?=
 =?us-ascii?Q?0jspuuD1K+mlT9VRyxeXfF1zaYVJ+4xpadmVWlw1Q3PHUJ4kZ01obj0tIHP2?=
 =?us-ascii?Q?+/9ngVrrz5qbF08lqGXnQzSjI+9IsrtElW5FZHAN9UHSZAQDb4vFSqVakZiJ?=
 =?us-ascii?Q?L6AJcpKHDBcJA7kncGmdwkOKuRJcJXlivQB8i2mwQbxgzakOUdsXBhIrqWrY?=
 =?us-ascii?Q?syaaS9Cs/HjFfESkwKQSI04bN1upqUdnIpiIui+1t1VS5G2BOejXK92JTtI7?=
 =?us-ascii?Q?xLTQaMaTW0lnOEaocxmsloDnj/unz4p1ZElnJDDiDilKqbclT7v4swhuo6sK?=
 =?us-ascii?Q?SBAG6kg447JD/PN4RY/13f5v0OIDB2cWMEAAuVLgYLxB2W6C3h7RwvKdMMmd?=
 =?us-ascii?Q?hRLmR2YywMpD9XwbPKxKRXQ3GQTHzWzoklX+iLJ2dvDgwJc3Wt0AH/NK7o4D?=
 =?us-ascii?Q?S9OqSLYK/RR+b2Vu7jhFzia3A8Ix4NGc6G9vquAECiN23ZmjVoFT/RpSH9SI?=
 =?us-ascii?Q?5Cs/1Ciyy+vo97e1jDbE0iDdrqSn4b6V+RiJg5beEL6XAxMR4oiUaL22F/cy?=
 =?us-ascii?Q?Vq07fXrnH3AlBHjxBU2T4Kjd9rLRnKLGIaW1TbYeTOR0YBnxk3yKGZSay8jr?=
 =?us-ascii?Q?E1QeWEZRgCOXoaeU6Zp2C8Rfct/U9z9RbbLz6ZzDacHDr2JZ3ho6zB25udYF?=
 =?us-ascii?Q?0UJyGB1LGZf6Aog9OI9o1jRrrt8kMSyTL9Lv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:21.9265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e590b029-4e23-464b-bfdf-08ddbd891530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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

