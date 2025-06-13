Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540E2C71156
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9AD10EA6D;
	Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2lCbvIoI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C4A10EA60
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prduB0r+l6BL+HexpCKs4hGVX6TWHPcP3RYLrv3CIG8S1XXjqaJbPxFOMnI1M8xunEu6R1B5fxADlNgCBPCAWZ8H1WLXM3N9t+o/IxuC7HKie3yHm/Z2dRxhgqJ1SFw4WvXzfFFgEaIJvMHQ2ZNtOlY22ZPebOKpxEPQWRZ2loVmgKzPye44DZmFjP10GUnfT45sqVdLqJIuwmPCL620RNjb+cYw/uL/CX8eGAxeZxbJeCLdgCZSHC89RZEwJA1j8G6HTfoLhKxqLq2/x4b7CVRFQgnD4ECeZ2dAomO7X9VGuMX3EAyo47WSDoulv4/94JPPQyr8oIafvBaJjBcbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elz2BJ5cgWK9vEnd5uHUJFgaTKMtFjVU2M5MrX0ZFPY=;
 b=X4fFVzO2RMEikS90IbgxLPIn3V5o1uDy7cPC4imNt18F0LL9+MaOORqAENKka0W4dRkQfvWFdh6Tx/xx1MZkJgs94GOYGxP2PokpZc899zDCi/9jUOJqe6d5n8adtubJRc9G/Qywn8X77IN+S5g7AJAKoR0aQ8zysrAP4WFahktkulXThAV7DRDmpC1LpsUg/np7tyR86Iw2E0l66z1ZuY07lHeNTE1he8LOpwDuZ9zeon8I5VJCrmUQGdX83BY6exu3sTOYZI2e0AZtn6VaG6wzf4gUqqoTeeax+jj3YzVfbZZL54AQXvpyTfUyrm7eMLQFlLGdl0LhRalzNOzuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elz2BJ5cgWK9vEnd5uHUJFgaTKMtFjVU2M5MrX0ZFPY=;
 b=2lCbvIoIdlYf0AwDZsTF7zkRuJPMPU+n3sU32sjdBIuWEvMdgp3aWsWCCqkRsdIW742jn0v918TC+NSaT7yH1ld9tsp5TU9Wxz5vjpc9cd628ZFvAm0KMV07POVwcR4ceV6euxgNjbJpnNiIbTTb1JWTLJ4TXZH1IKh/DorQkuA=
Received: from CH5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:1f4::9)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 21:48:12 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::6b) by CH5PR04CA0024.outlook.office365.com
 (2603:10b6:610:1f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/27] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:34 -0400
Message-ID: <20250613214748.5889-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: ea20f3ad-f5b8-4429-e4fa-08ddaac3fe81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NuN9UpmxjZ0SBLHBgKUFAlTJTzjtQAQvaeQ8CcB3zzZ4s/iZDjDOfaNOLAjY?=
 =?us-ascii?Q?1LFuxH4+J4OkpB8afAG3k1WKbvIrv/s/v7FH/vaL8c5cMzsOM6UWNPIRKLVW?=
 =?us-ascii?Q?/KLXRHTlZDkY/eUChq4TI38GGqX7aL1DPHO7/3A2aNvFRhzOv9TbZ8tPmw1X?=
 =?us-ascii?Q?fir059A+UKbZoush9gj6GH6DdJb92BqJ/Z8se9MRHg7SzFNVqP9Z+fQPeZJd?=
 =?us-ascii?Q?9VnKu5D0bCIGchKj6UHIVUsouila+/KZrrXbbOyaCIsA/3j5iHsQjIQZ0o7Q?=
 =?us-ascii?Q?VHAtxwFHr4G5IvbTYxzSYIjwcmsiNW5BPoVNe4XTODAEXNFE7aaUYtV2vL20?=
 =?us-ascii?Q?TMqTAwkX1U43uYg92SVwS2kvgKHbhHSgttD5657sMbaGeNdo9B8tgk90nIGF?=
 =?us-ascii?Q?X+KBVZm85T/EvDRVHPwtrbEvmXF4sAfqazCf+jslGZC/K8r5dsrCkrTDgYAG?=
 =?us-ascii?Q?48IhExGH0OPYCEnk6MSrKdtg1ulmM/ZbUU/DlQaR/0l/KpeU9vFd8l12O5AC?=
 =?us-ascii?Q?BULHWYx6BpzIyqFHGjwxMA1ZOz4uZWPeZ2IPY78HqQZsPVvpfOJdQY+OfnjS?=
 =?us-ascii?Q?cnFrouFRNu28HeK9q1gykjN4Xk5Ftaef9xtrKu7DKRm8pgdNC5EbWL2ImsbK?=
 =?us-ascii?Q?Db5azAvnVo3HvHsdJ4lrJCJklCoa6YB1M5dfbrUa9WkjsGirOx5Of0I53UX/?=
 =?us-ascii?Q?70A0HKUFR0dbCDaR0p/AwNsKzGaEtQ+SIfaY3ft4RT+VPbF1U4at0WjHbKuw?=
 =?us-ascii?Q?3twjxyKFwe5NBS0NsID25Py/LlBX4utRiAEUioZfp0P7NAaGaieQhV0+d9YY?=
 =?us-ascii?Q?/R09QJP5TcfjqUcpp5O6KWy6pF9jd92cUtB+tp98CTk9ivpNMz4vg7FbE5+W?=
 =?us-ascii?Q?zth96ZLWydHuJ8BJWSc6aCYUd71LuboOgP1IU+WTFXLsDiIlT7531stZWxrg?=
 =?us-ascii?Q?PWfyOtWtXCucV8250Ll3MGO4oU6dHCvv1kdpyc4FuGefHnRq+wkKLoOUoGtN?=
 =?us-ascii?Q?S5S708AgNBAG5Jua+LcjUwMq0D8t4suJpqV9MY8NSq2e5QKr08j3TX0XK162?=
 =?us-ascii?Q?8ofedBZIJE/fbEsyCSpfO5/vFvQsBVFuu/psI5bAWAtShYceeWysXj+eG4FQ?=
 =?us-ascii?Q?1A/rt+daQJECq/29WA8jy1TQYrizP+qFLZMIEg/2kGdI46O/SwRio7O3sJub?=
 =?us-ascii?Q?u0YxSh1lR56BJW3oouG3AG5Cz8g43ViAiJvfOv8ibkIlVWQg5jM7SjzWO1FD?=
 =?us-ascii?Q?l0WLeXwci0ndvBjJFmZ2ij8IEmPeymaHX5uUgi0AZsyYaqKbLdA2co2ePZp9?=
 =?us-ascii?Q?YkSNwegcxQbmJlAi6ArqHpDa8rO8A65m8if7UUGqtABR72mCR6illvKH1lKq?=
 =?us-ascii?Q?3RdYhJYK1VA8b1BYydb15UGOsT6zBlOtYSXp2p7lTA5N8YCnhk1M4rADe/ZN?=
 =?us-ascii?Q?eHoeFj8h86glJ7L77coNhnd737HZJ2/yFIxxzqrZiWhVPWqoTc+ncKkVVPSI?=
 =?us-ascii?Q?dPQOQ22Yh90pqYlqrYxvBCCN+t6E/PJZ8z0J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:12.1213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea20f3ad-f5b8-4429-e4fa-08ddaac3fe81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 39 +++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d2ee4543ce222..693a3f0aa58b1 100644
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
@@ -5317,6 +5302,8 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
@@ -5340,8 +5327,15 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
@@ -5438,6 +5432,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
@@ -5460,8 +5456,15 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
@@ -5540,7 +5543,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
@@ -5579,7 +5581,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

