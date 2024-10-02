Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4FBCF3196
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36FE10E6A4;
	Wed,  2 Oct 2024 04:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PETPmXIL";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A0E10E6AA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI7P4cLfny7vLGq51UgzozjhIdsTsW6n3ycj5dXoYA1zy+8opsVss1RbHDHUZfB+zOm+BeViZGLTuc31z6BNJtXQ494uVnOdDYBtKS9qz7/KqJtkmi0C5CQBLqroz84wJFjCJD5r0qFL1SWRgWGjFcPClmxp4K3KSefEpCoUDOre6m+TURR1rO+cb61AJdnvRh0XtLiCvJZ7ANslWsvi2DWYPAAAcS9W0AOqj8tLjNyD9lx3m9MoCH5W8sQ0BEgMQcn3fVgZFhObKg39MCZUG9sytxb+QjmiJzCcREocEB0dYBnVYX/7YeeMzUoztx5Whr0FzgavzcNCD18yL/mowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maMudvlBvmU/Ta3X7gw8Hu9OTh/TB1xZSmlLdG9P/9Y=;
 b=nYt9h8ZL/ZVeTEI4MjFR78bKBd2x2sWSe+vYLmzK59YGIXhoNQ9Z9jiaqXRFzZTgV7wqtl1/15fTYtRp2whzBpL9BPG0nZIibFdr78UuqmoO76Le5XiGUh4Fcooye2t89Gf6OjIQ6kFd7p5dQ38AQgYDjfyygosV/S0OnDNtxFcdvoUOdgKChZFs+VqZuHPVVUZsVlED989a6CzdcddkqRc7DNcSawiJfg+HKGoByEzLmqGYLcxRTkdEEeXfj3JVAhXkHf2TT4PAbNxxTf1Cl8O+A/xiFhqeXqXmABasz01A1nFzUFry015tvhI+vf325ONN2oiMJUHObgpcwKzz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maMudvlBvmU/Ta3X7gw8Hu9OTh/TB1xZSmlLdG9P/9Y=;
 b=PETPmXILVhfYU169GhJcIEzQCLgw7+4J4kywEcCNXw89all4lza+gCqenVCpcU4boWIbDWyIfMyidGdLL5DqR+0abntMkMujvhSGNp2dpjennrx2ASuIXQxLmiGx/MWWjG04udjSSP8uFHP/h8f6hs6Qrb710NG9cfcvaKOFRGU=
Received: from SA0PR11CA0038.namprd11.prod.outlook.com (2603:10b6:806:d0::13)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 04:41:03 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::f9) by SA0PR11CA0038.outlook.office365.com
 (2603:10b6:806:d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Wed, 2 Oct 2024 04:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:41:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 23:41:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/gfx11: Implement cleaner shader support for
 GFX11 hardware
Date: Wed, 2 Oct 2024 10:09:33 +0530
Message-ID: <20241002043936.2960921-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da89d93-bda1-4d73-ce68-08dce29c6c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzBkd3doRHFqU2xTZ1p0d3RHRWVaR1RhR2VPUmZPYVBjbXVGamJpOHFFNDUw?=
 =?utf-8?B?ZnIyNXkrejEyUHh3VGM0VUJHNEpmc2VGT3lXcm13Q0NSalhkWHJLRTBHVEdZ?=
 =?utf-8?B?emk4VEdnc0liMzMwaGQvYW8yNG1BWWh5dFJicTlKRU9qcUw5SmZiazRXN2hK?=
 =?utf-8?B?Nk82ZTF3STA4YW5Pd3dLbFFKQUlBN1gxaEFaRytwYWVOWTRweHlacm1xRmNM?=
 =?utf-8?B?RWxvWkJxMnFwSlVvdGRKVisvMklLbU9TN0FFMVF0ZTBUZE4rUlF4V0FVd0I4?=
 =?utf-8?B?Y1VxNXRNb0tTa2xiOUhPMWRrTHNKVmRxcHRWZjdzQUEwVWxVdFBnMFhrTmtR?=
 =?utf-8?B?ZVlIelpRTnd1Yjc0YjRRQWFmNlNnRnp3eldjRWI0ZTllQTdod1IwdGVCeW1Z?=
 =?utf-8?B?U2dkM29FSldUREFTRGlkK3p5d2JVcXd2ejluUWFJZFN2bkdqOGFWTXllbDBm?=
 =?utf-8?B?ZCtQTTRKaHViWlBNNVJwYTVYL0plUEFjVUdvaStVNG5WbGRJMk81dkhrdmVF?=
 =?utf-8?B?dFNCOFA0WGF4aGZsZFJTTDlBd0U2RjF4Ymh0RnQ4V0YwM3ArbDQ0eXVSb1B2?=
 =?utf-8?B?UzVTbDVjT2xpM2k1Yy91WEV5SDdrNlBiRGFxMDd6aFpzalBBcUVHZW9vM29t?=
 =?utf-8?B?cmVlS0NkWitDZnREaHpGeGtUcW80MmJyOVRUR2J2TElKM29scmdlOHYvd2JK?=
 =?utf-8?B?T1VFQ0FhT0wwVFVxUjkvVkttb0V6M0tKN1FCYk90YzFUWUtoUUpLNUdrMFJW?=
 =?utf-8?B?ZjR0WGo1b2ZvSXpIRGQzWnYvOUsyZjVkR1NSSm11aCtKYXV3eHoxaWREbks5?=
 =?utf-8?B?Sm5GbHQxczU2SHZEMVczZExpaUlNM2tLYmRwcUVSMmNpZE0yWSt3M2lIZW0w?=
 =?utf-8?B?OXpZY1RGcWhuNk9MZzBGOXE3MVJxNzRSYkcrOGhmbVUydkp0L3JvTjUrbGtR?=
 =?utf-8?B?VFExK2VYTG10SFRrWndlZ1c2WW9XbFFvS0k2S09pYWUrTlRqdGhKbTNBQWRK?=
 =?utf-8?B?T2FIc1NadGxUaTQwTmJPdHZFaEIyd1lSZi9FMkRoeWNSaFhvNFVzUi9zSFBv?=
 =?utf-8?B?VEVtdkt3Q2czRjFqWHJMNGoxR09FRDhtb1FpaE1jVkZob05yRWtIaEtMVktt?=
 =?utf-8?B?RlZwK1QycmJndjBybmt1U1hQWHppSFRpS3kzckhkWlI4cjlOR3lPdzBRVHJT?=
 =?utf-8?B?Qi9JR0ZsRW1ROHBFWksyTzNSMzhIV3FXTVQ1WnJxUDFvR2xMWEZvU3JVTXFS?=
 =?utf-8?B?UGxua2J2NHZvUmtyL3o3SmM1eC9kSjV1SUszTWxPSjB6UElSaWkzcXNXRUhQ?=
 =?utf-8?B?d2xPQXVIYStHMVJOYjZEaHc3WHloRWFkMTRRYnY3SEpRanBmTHczd0N4bDhx?=
 =?utf-8?B?Wld6Y3Nudm1DWldVa3JUR2gyR09ySEc5TnI2L1hMVWRqbkJCZ2YzZm4yOEJJ?=
 =?utf-8?B?ZEdRMVMzUFdMbmdmdmRxVjUyZEx2RXJMVFhQSmRBQnk2WjBkM2d1Vmpjd2t2?=
 =?utf-8?B?Z2JQY211QVQ4NkJBYWpLZWt2TnNGSFNlVGE4ODlTOTJXZWhHMVJDNlRkOUlN?=
 =?utf-8?B?TzB2SklCSWVGMDJHQTdNUno3aFNpVS9heVdEMnFYdkRHTlozN05oMjk2enFB?=
 =?utf-8?B?b0ZyM1ZpdzNnRCtXL0JyMm9NeWlVcGJFVStaZFdtbGhPV2RiTTFZbG51ZGp6?=
 =?utf-8?B?cUlMcy9VTW13OERWb2dNV1Fpc3JEeUNiS3lrTFptSTVKQjFJMHN6S3FSbnNa?=
 =?utf-8?B?UTVKelRIQUpsL2kyQUxQQUkwWWpkbWF0MDVZeWJFV1NmTjYwbzZROC9hOWdl?=
 =?utf-8?Q?Vp9vboiDg1PCDeMMo5itY0bzHCpSPgosUVQ48=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:41:03.8079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da89d93-bda1-4d73-ce68-08dce29c6c42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
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

The patch modifies the gfx_v11_0_kiq_set_resources function to write
the cleaner shader's memory controller address to the ring buffer. It
also adds a new function, gfx_v11_0_ring_emit_cleaner_shader, which
emits the PACKET3_RUN_CLEANER_SHADER packet to the ring buffer.

This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
gfx_v11_0 module. This packet is used to emit the cleaner shader, which
is used to clear GPU memory before it's reused, helping to prevent data
leakage between different processes.

Finally, the patch updates the ring function structures to include the
new gfx_v11_0_ring_emit_cleaner_shader function. This allows the
cleaner shader to be emitted as part of the ring's operations.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 40 +++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a0f80cc993cf..745996ed2380 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -293,14 +293,20 @@ static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 
 static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
+	struct amdgpu_device *adev = kiq_ring->adev;
+	u64 shader_mc_addr;
+
+	/* Cleaner shader MC address */
+	shader_mc_addr = adev->gfx.cleaner_shader_gpu_addr >> 8;
+
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
 	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
 			  PACKET3_SET_RESOURCES_UNMAP_LATENTY(0xa) | /* unmap_latency: 0xa (~ 1s) */
 			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
 	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
 	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
+	amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cleaner shader addr lo */
+	amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cleaner shader addr hi */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
 }
@@ -1087,6 +1093,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 		BUG();
 		break;
 	}
+	adev->gfx.xcc_mask = 1;
 
 	return 0;
 }
@@ -1574,6 +1581,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_queue_per_pipe = 8;
 		break;
 	}
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	default:
+		adev->gfx.enable_cleaner_shader = false;
+	}
+
 
 	/* Enable CG flag in one VF mode for enabling RLC safe mode enter/exit */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3) &&
@@ -1700,6 +1712,9 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_alloc_ip_dump(adev);
 
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -1749,6 +1764,8 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		amdgpu_gfx_kiq_fini(adev, 0);
 	}
 
+	amdgpu_gfx_cleaner_shader_sw_fini(adev);
+
 	gfx_v11_0_pfp_fini(adev);
 	gfx_v11_0_me_fini(adev);
 	gfx_v11_0_rlc_fini(adev);
@@ -1758,6 +1775,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		gfx_v11_0_rlc_autoload_buffer_fini(adev);
 
 	gfx_v11_0_free_microcode(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
@@ -4575,6 +4593,9 @@ static int gfx_v11_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
+				       adev->gfx.cleaner_shader_ptr);
+
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
 		if (adev->gfx.imu.funcs) {
 			/* RLC autoload sequence 1: Program rlc ram */
@@ -6772,6 +6793,13 @@ static void gfx_v11_ip_dump(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static void gfx_v11_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
+{
+	/* Emit the cleaner shader */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
+}
+
 static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.name = "gfx_v11_0",
 	.early_init = gfx_v11_0_early_init,
@@ -6821,7 +6849,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 		5 + /* HDP_INVL */
 		22 + /* SET_Q_PREEMPTION_MODE */
 		8 + 8 + /* FENCE x2 */
-		8, /* gfx_v11_0_emit_mem_sync */
+		8 + /* gfx_v11_0_emit_mem_sync */
+		2, /* gfx_v11_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	4, /* gfx_v11_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v11_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v11_0_ring_emit_fence,
@@ -6844,6 +6873,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
+	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
@@ -6864,7 +6894,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v11_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v11_0_ring_emit_fence x3 for user fence, vm fence */
-		8, /* gfx_v11_0_emit_mem_sync */
+		8 + /* gfx_v11_0_emit_mem_sync */
+		2, /* gfx_v11_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	7, /* gfx_v11_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v11_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v11_0_ring_emit_fence,
@@ -6882,6 +6913,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
+	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
-- 
2.34.1

