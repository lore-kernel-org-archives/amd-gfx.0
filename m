Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A76AC71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7BB10EA5D;
	Fri, 13 Jun 2025 21:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UaxNrueZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C48010EA5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWgQawkiYlwlaVe91WMUnzVwsPfm4Zcs+4ziOZun7j9UDj+6rMRgf3l6i6ArLdMgP0OlC0Ix5q8AtItnvfCFpkDdyhiU2t/Srixl4AFGB4BQUNdmD9qt1du9QcL3/OLyPxBBkpu3RKp4u0nb/MC6GLFoD/HPqclWZLjFVA6V2GsFdJC8G9nvUlLqw4XwYSh1QGZjY/E79eDN3Pq6XJS6qm7UG16mnWJNSIc5LXE0gB37ePJlaiG8Tn1mp2fXXDsE9kZaqeScfD1d0azgv3e0dte/EC8eOPgMcMqNQQ8/z/6Uj2CAqJ2GKgaqhQZdFZQvmkHuZDBga4YTR+VdFLgsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQSGZAM+pSBUpEvt5KvFsY3YN/g2ypH8CNS4nFIOcEo=;
 b=Z49+DH0WlkCNHEOfsdUz5YqN3o1A7HlksqWXvUSKyyH64XAEQGFrdsATczfErKXUHSMM2AAkvrUi0kabgLRavhPLaMcc5Y1maAovNx1GXkLroTeUGQrrdKSlfkBJoeRtbaph49zf/hZp7Shv3WIOdTCt24Hbq4Vrr/R07aKtfrquGAlfwvXI4MwP18R2vI2n8ik2CVXuL46g8EoyJERIpT4sfmgWMzfLpwRYM7u7zA8G+16F0p/uOYiUFSwxw3QfWOVL3Hvm44Y0eQBSgCIfBc01mZ01B2KTOlCAYHSP3q0ESkU8ldZbCXZsyNlG7LNcsYedMD7KMhKoqDZiUC3dig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQSGZAM+pSBUpEvt5KvFsY3YN/g2ypH8CNS4nFIOcEo=;
 b=UaxNrueZhixU4OAoOgk/MX3e+Z34/os9DJtkg8BT029l7pVrYV+vsVknkTQRIVs42to3Wd/lBMuZkTtZkEDUvz10JzGMrQGqyrrcAlQhN4Lrqny+SV/vmQAIfw2KAqN4uzO2Erx5Hoa+zPJdeG1FyJIyRvLq//QuC567Tt+7O60=
Received: from CH5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:1f4::10)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 21:48:12 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::a0) by CH5PR04CA0004.outlook.office365.com
 (2603:10b6:610:1f4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/27] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:33 -0400
Message-ID: <20250613214748.5889-13-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: f58fd534-a3e8-439f-ad1c-08ddaac3fe5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?09sJ2ElT+GH7m5Vt2/2c4cZMiMQ+C8nTVKxOjDZiFN2cGqBVXQX9BFk/lLs4?=
 =?us-ascii?Q?1ec1mQz3uk/DOJ0e5VkO+7yKxgysEnkFM73d6Opf8Or1B2WigweaxJ2y/6Ic?=
 =?us-ascii?Q?q2OYeVib2pBNz6S0/MfGN+0np2yb4NVxA1+3tKb3ZwJiYdn95ntLXYU5Igqn?=
 =?us-ascii?Q?UBw/Vlyl425dvDZSMBCJxi+AUL3nJ6fCqsTCGMLSw7iNLFAjcHcS1rO4TiN7?=
 =?us-ascii?Q?T2gzxlyopVX07h9E7KXYv5BmRtK6xz1nj/6uH0SDcY0Fi3h0CxwWQV+6mTJw?=
 =?us-ascii?Q?7N6/PPTM3jWI+LXn44VHXRZnjm0kEaRHzT9OXl4S7mVOXeYyNg3z53FH6MIt?=
 =?us-ascii?Q?gWbXFso5L8GGqEAFo9aHwuV8RUY5lILQ7EqUh16ThR57f+b515NU/flXwV/0?=
 =?us-ascii?Q?LbMsp7JUlhXXln38O+lnyMTZ+3Jr/Y2B/1xVykmbiPetXXgsQymo/nO7tsMm?=
 =?us-ascii?Q?Lrf8Zz/mrGRVTf9GclujYCObZfPM/BBKfjgC6KR5+uKuXTn/xhDTgUmi92p+?=
 =?us-ascii?Q?p/R02GpQgIYOZ0rNZn7LmtMuP6FKZ9zhvoxVvahJGpb4Y3jVmAAVjmymoyQQ?=
 =?us-ascii?Q?P/0++4L+fD42aP0nifOyp5I4+3ZSFpK5FTaAuQTtUCjd4keJbrwlUlLec7B9?=
 =?us-ascii?Q?Pun6DScZblfSslRdEACjy1BcUnaMPi0Te1l1AtZKp7JwFwcdEnC8E7rVMDRX?=
 =?us-ascii?Q?30g3kwsDOJcoE4Lb84fkFNKIB6sXcieAV427g2MMv4Mi/aWgN9ygNdR5R2HS?=
 =?us-ascii?Q?jtU4F844wpZBGP7kxwUp5wPj5P1mdHjxa0rs2dgfPUYuY1dw13vA0CUDkusS?=
 =?us-ascii?Q?ENi0mk+/ev50bFcwFrAQjneEESHibnQ0Z/8j/lKUPgda7on8n9Sd/107A+gG?=
 =?us-ascii?Q?tctBpG4TaG+2+Af51P0ayEFXUdjoe7itqVYKaMui2sSe9Vm7zQPeb1ClX7gy?=
 =?us-ascii?Q?ahmliRnTNSIvQdYiL5vRtCfpSjne7QTLFJpy+133bLw6vyxExzDEA/gLWtqH?=
 =?us-ascii?Q?JFF9EIiIvyfWtttN6v8i3+zv1a5U2gCXs/kFwSf3NzwHJz1xRRjnar3G/C3B?=
 =?us-ascii?Q?Dvt98jFhooOXcj3risd9xeKBw0TTZDOmcLOt7afMJAc1h0Nl7qsUq9uVMptD?=
 =?us-ascii?Q?+txGdVVgfEigw9mM/7gKw4e78FCD1a7v2zYDGRz93l2cJ6cP7EnYSUYbE/2W?=
 =?us-ascii?Q?vdbm7E22YWPkc4qzlj0dW5Irp1hbywG1P2HgK+JSaGHVPPd50mWm6LgmOAgK?=
 =?us-ascii?Q?8oST0tmtdXEZUkG6VzLHhhACga/ksz6tjiwLXFfnGVckkS1z2enhdcEQmk25?=
 =?us-ascii?Q?4ROkJ+H4md6hMA7f8D5O0VtT6S2R+6rvpmis95MwAOX1VozfgYDyk/OdvcQJ?=
 =?us-ascii?Q?xE2xG7n/T+enbx9vp3PWwqhKMEgCnlnghPhTmG7b8qO0nS1fp4ERUKRWy7l/?=
 =?us-ascii?Q?QeVmck47V4hSWMtc2y4kzCUfEqXEqz/wOhtwgqeeFa1pnt86dU2cxfMbBQvU?=
 =?us-ascii?Q?tZVmw73MtYlDrKBWy5T5suTaMpRuYuRqLCeD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:11.8753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58fd534-a3e8-439f-ad1c-08ddaac3fe5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 39 +++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3dd2e04830dc6..8deea355d4b5b 100644
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
@@ -6821,6 +6806,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
 
@@ -6845,8 +6832,15 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
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
 
@@ -6990,6 +6984,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
@@ -7012,8 +7008,15 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
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
 
@@ -7250,7 +7253,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7292,7 +7294,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

