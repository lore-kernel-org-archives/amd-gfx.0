Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D646C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D43710E65B;
	Wed, 28 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OL2X8xnA";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9441710E65B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wn+xahhwzVOjPBetEWGWDPN+gfvn4VjLLaWfz/EOXsnbjHPOjE2UvDgVvaafoqABmLQS1tS1Dylfc9R2o2muVN1nkJQklvQdqv/Dk/Y2Wnu+svXHM2vQzDBe+9+p4uvlRlG8dlhhx0agSou7e9E1jGtr6gIddb5EoBm1bJuYZzfqJihL3Lv03/XnqTWreiMNLGUpR/Wuhoz8g4pdovf8myPcM9mFYlfsCBDr9lS7ojTV9vkcKEMv2uwyaL8UcR8atqOghJ/XkAKImRtZPLpFrzlL7gxAtbY0ZP4mMj37cxIP/HM0M15V36+Q7InbwMY6P5i51PU06kFDpmArgXxCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vrf+CjdxgNEdJOvSzhkyKwQayri3sHf9mL6/8AX4Vo=;
 b=N3ek/2h6rXMnu0tYlNl3iizykwHBnonDgJGLZDo9nBgQsV8VTKTMnNTbsFHvxS6FkdIU0J/O7yV3xq0wQ5Gei8LMi55BotSor6Ply9E/loOMBqnANOa2QlVi1oRcqsyZgJ+3L52JRE2yldcXb42cx1HC51+AE89iDmQvq3IksE7EREeT6y8d1U8az/vHNLrLC1jBjvGM6uAVVo6Atvfx+Q+SwAzTH2OReYR7FMUCG4n8Ydr7V4Y0AcCHRCr/dRD0NIIp7qfyF2FcRaUx4bRLAzEN00IEZbi4XQkz3YfQII6PUfojxC4A5Jnmeu3aOat+Ab2vmh3DhE5zVXGxKBUsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Vrf+CjdxgNEdJOvSzhkyKwQayri3sHf9mL6/8AX4Vo=;
 b=OL2X8xnAz2f7WZIzIzMlg2sN1nN7SFSwXKJUfqB64oTmUyUPSdvCIdzMw88ShyrVWxszbPfy44KhJi5tsG69Jhcj/cD166BS39pLoE6c1AGWOXO6Wxa2T0hywuTNjyeVry/ZuYteIcG4FvCPqYf9lSIDN06WlZ3QVjVnxqlVxQk=
Received: from BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::23)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 17:28:26 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a0) by BL1P222CA0018.outlook.office365.com
 (2603:10b6:208:2c7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Wed,
 28 May 2025 17:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/16] drm/amdgpu/gfx11: re-emit unprocessed state on kcq reset
Date: Wed, 28 May 2025 13:28:00 -0400
Message-ID: <20250528172801.34424-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DS0PR12MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c48fb8-d706-4710-55f1-08dd9e0d0dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nrpcOWp9sPsneEVDynEryI2YgO++Gp/rP09LE+B9Q3/BLt7whmBHEVas7vhW?=
 =?us-ascii?Q?8tnGit3/uUCUK8jBT9sOBv4PMALbEVaUw0/qKC+lTSIkVTcHOyRfhBIVq962?=
 =?us-ascii?Q?yWQO6+mgZJmEuwFf2pu24/MvPySL/K5ocsIQjNB5o63DAUBHsMrWa6UVGG23?=
 =?us-ascii?Q?MTGEVRbFFVal5UC2IphdvmO/fgBm1oGvz+CCIFRlXm0SUpFMftFC69iHIL8r?=
 =?us-ascii?Q?djCAsqMGwITAdfrO2w48FmnuWwqRsS/xcTbe/fy7HndXmzNvuMvatIsvPjbr?=
 =?us-ascii?Q?Pld9dEeaibAPmMjqSKlDocr+sFjwfaOcVBB0CDge7IYI7Tj05L+8w0U+NGW9?=
 =?us-ascii?Q?B2VCQ8baR7sG9Z5vjYXXm91XTRYZ/JRwpOSN5zsL9yfgxGAomajP5HheKuHA?=
 =?us-ascii?Q?yESpqUoKxEQ/FraQbdF36tgffoW2NC1L+AEuB44ZDyNcVR2PRTqINiF26rpB?=
 =?us-ascii?Q?NRN8zBrM+bCA6qkVx0amgdLLFsO5I7u0u1ZmeFuf062SLLfaI1oY4dVIVIDZ?=
 =?us-ascii?Q?G1nu7WUL9MqVi3JdU0spiIlOfKjNvcNsGLBzVLkiA6UkfoaXOfW/M/aPKeVO?=
 =?us-ascii?Q?lxblZuKm6/o7FxmMsItEJw5QY8oDX6JQxUfo0t666Wv3/7M/NOWx6aPRYi8E?=
 =?us-ascii?Q?7eyAaxhQ1Zvwa+QfbIQCvQ8mueEESuLqTRCIXYOfg5z40H8dIhf4rr2fGcxc?=
 =?us-ascii?Q?oFQyv5VjFQrTsLxtr3HSUPw+/wPyuSOeU9fiB9/sn3bRcnfSRwoFHNUtzeyN?=
 =?us-ascii?Q?iAEJ7QNyPaBbtw9CPj5LDwqS47rbfWOmM4xCRFmlLcD4DTHUbEwyFOwoGaDk?=
 =?us-ascii?Q?oBaTJcWs89l46DNzLqkAMNRuq03T6PpjoQQm/BgiaMzDdvTiz5IVLlfVFwE8?=
 =?us-ascii?Q?jOD/GsMNLnmDizCeDBdx/A6pdXzY6xKz2hrIivZzCRViA9NI8uEbjB+8mX8Z?=
 =?us-ascii?Q?awmfQLbgok0JBSgA6Q15VuOg7yBjeFWWUOVULy+w0ezcg6S7FPNcYt6iWfMv?=
 =?us-ascii?Q?53IV1yGDc7/ddwjbQGoVGZAThvOCKdouZFio5HoeZQxCy7m1NEuhY0+JVcwu?=
 =?us-ascii?Q?r5bb6oAPLrBj/VWvP39NMKUB0LKSa4lrTL8XZmhDcBefCTSbdq1YhlqV6aRe?=
 =?us-ascii?Q?ZlbetOFdVSH+U0ps4275dpNewG4osaf19leZnMm7LS25CAd8jJDKgGi8bBl+?=
 =?us-ascii?Q?SdcShaEU6j/n9vdvRxoIjZVMQ+j8qStybZRo7m6krtVX/la7JyX9KEeKH/Sf?=
 =?us-ascii?Q?T5WCyWk/gJx9wt7bHpN8NXD8hYnAtMMG/b/wT5nQhszjxSnxAwwPaejYVHuW?=
 =?us-ascii?Q?hBBWPxGTUmnKww+oOBf0Dqgq9Hyt2PegCHzr0jTaZ3+5WutJF2EYP/DPKm+E?=
 =?us-ascii?Q?iK7MFXiWYImriyEOwbTBiPS+S2HAp82D5YhwqJVVKiQVyhGeSiSkAsWvRQGq?=
 =?us-ascii?Q?N+GsLkWZFqchDoPVnEKTzhY5lkuc4J6UK4ePPGifztAndbfx1oE5I5/xjwlw?=
 =?us-ascii?Q?GYKt+juzzdqBdD2H3RBcWSOLpvOazSwHXijZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:26.0161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c48fb8-d706-4710-55f1-08dd9e0d0dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 33 +++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 218bd4d77e859..1989aaceb38d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6287,21 +6287,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
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
@@ -6995,6 +6980,7 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int i;
 	int r = 0;
 
 	if (amdgpu_sriov_vf(adev))
@@ -7019,7 +7005,21 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	amdgpu_ring_commit(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return r;
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -7296,7 +7296,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

