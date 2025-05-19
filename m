Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D452AC3ABDD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 18:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732F410E428;
	Mon, 19 May 2025 18:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYkQloEe";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA7910E3AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 18:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTjq6b9AHPsy6J5FklRjF+ku/K22m9lgh7OBj3tSH7q3sQ1ZNoJFv+c6N9FST2mcZl32wHIMtZTZd7sGuJoOJmQTEqpwlTCMJlU1kyyGEEsJmdkw2+C9myjp2LvckKNawIpo0WkRsFzs03iHQqz9hOT2R1urccWQxm7Ju07e18t2OiDaifa5rn8xY5G4dJMOI/kLpN9Hf09fDJ5e7FSWFnV0i1jtB9mhiahwiMx/Y/fxeGup/Sfu7r17Q/6kEYZrOarCcBseNMyZVa+pxryVLd/9PqfcweJ7O81hiGHtsJn14F+VC+zliBXPZQiwF6vZ4x3qbjgFPtAIoxdkWHorAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxC9Os34Yksx64OXbykF+VR+6gPtkpQwLXzARf1yO54=;
 b=yQimJ3u7q8Fs16XV9IP4OrO2Yx43e+tdgMINNUVxryHtve9Y7hpqnPTnilylfTjWyCtwSzOIf6zePmwTOmsA4jP+8nEroQgCLjeY+UG7SkG85U7jR4SirpCsKw9U0M1tzNUCmQ4foaVPgC2do3XILsbyjoOs+AJn8sCKTTuuQZgMrtMVz0pCyw1H2srx5vEv19vhkvW40cbZJI1W2+OJVlZc3wxXsctjn8S+cyxcfzhXHxc9VCpU60HbqNVMeqnppzOGC4LjGnZJV00mt3JOlOMq1VnbPSBbVV3PdRXqcPPHx0IH8RgJfxZ5+uOrctDvC+Fo8L7M3UxcG18iAAvTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxC9Os34Yksx64OXbykF+VR+6gPtkpQwLXzARf1yO54=;
 b=ZYkQloEeqkjg0MQq61LvaI3QLD/JgriG68RhUsrsOpUXMrfn726wblVuSDX3LoizYmSXQZ/q7k6UxSl7sbbMX4KXuz2eTRNs3xJiOLQt1J0V+X/dsB3QSDYBTi6++VNiciMUHWx72rOzRvgZjN1sFnrzU447M8UdN9ZpfTWLBm0=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 18:22:25 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::e7) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Mon,
 19 May 2025 18:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 18:22:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 13:22:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: rework gfx9 queue reset
Date: Mon, 19 May 2025 14:22:04 -0400
Message-ID: <20250519182209.18273-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519182209.18273-1-alexander.deucher@amd.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b3ce8e-5282-437f-5aa5-08dd97021ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2ZZUzdZanhSSFB0SUVQSXM5WVpKZ3RTRDV5cW9LdWd3dDR4aFozWDJ5YTdr?=
 =?utf-8?B?d3JHZ1ZTYlZlOGxNZFRvMXFSRXgvMDVHVFI5WkFUaEwzYkFnTXpIYWM1OTQz?=
 =?utf-8?B?bDRqYXVsSHd2NGgwMHQvNy9KbnBaSWl3SWFOTW1HVkk2N29qMDNFNnlTQytt?=
 =?utf-8?B?WEk4dzdUTGRUM3kzV3lNVmZVRFhPWVdPZ3V1a1k3T0VYdVBJQVVJYk5GcnJk?=
 =?utf-8?B?VjJRS0I3Zzg2NE9KK0h4ekVWOFk1UXl3OVBBVEE2Q1VwOUtPZmpBTVB5TWxH?=
 =?utf-8?B?a1VQTWdoQzVxdStwMnFCNEJrZXJPb1dEZjF2QU5BQ1JWV3pVSU5tTS9YTUhp?=
 =?utf-8?B?VzViSHh2SXZQUHBZb291WlJZS1hmNmZZT3B4MjVVSWVwNzdUdlFCYU1ja2pH?=
 =?utf-8?B?MmRWL2tTeGtRMVdrcGJmZzUzdXl3MUhRVE5ldUFkd0xqalBOb1JYREZ0UFk3?=
 =?utf-8?B?MTBGZnZ3UElTcFRHdklyeUoxMm1BR1lJWnJMdkJHbXhqTlpWbldHOTZVMmtD?=
 =?utf-8?B?Nll3ck1CWVp5TFdzV0Z5ZE9XNXNqby84L2ZnMnBOMlRUMTNGa0RKMTBkTnFu?=
 =?utf-8?B?a2dYQ0JFcFJGTHRiLzZmSk5qT1hOZzI4NTRFZGtqbEFWaytUdzRrVnM1eWJR?=
 =?utf-8?B?QWFkQ3lRcWFEQXB0cWVLZ2o1V0t2Snk5UTdWZlN0eWd0dzMzbmdZSFIrNEpT?=
 =?utf-8?B?WWZST1U2Y1J5a0tBRFdSNTVaaHRKTTFlcjV0VHJIeHhydHBlVTFONnNpb2tL?=
 =?utf-8?B?LzJ1Zy95QVJqRmhxei9maGE1N05QZ3VyUGYrODQ3T0IralF4eVlRVWFITDJr?=
 =?utf-8?B?R1IrcFRueUZWWExjekthbE1QeVZQVndWZFJCZ01uWldRNlAzcml2dG0zT2pI?=
 =?utf-8?B?S001UGxwbGpKbWNlZTk5dURTV3FrUHJOWmtGTFpYNEQ1YlRsVTVKcGQ5UEV2?=
 =?utf-8?B?Wmt3NVU3VG9VdzZ6WVhFV3pmQ1NXallXZXE2b3hjaWRZN1kwSCtUcjBBam9r?=
 =?utf-8?B?Uk1Fb25ZdldITXhqU0ZCTEhQMWZvNzUwa0VlQTh3NjlrSUwvQnVHdTlTTm5R?=
 =?utf-8?B?ZE1xWGo3N0k0Y0lVanIxZ0FRTXVZMkVQZGZsaS9nZTJrTysvVlMwQ0lXZTFC?=
 =?utf-8?B?MEhua3R4TTlNUUxkazlPL0FTSjVHbENNRXZ2Tm9YRXJvWHVCVjJZTVVjUk5v?=
 =?utf-8?B?QUNvWStYUzBXYWw2R2NObjRBeUcwVEpWcitncnVrRXU3c2NHcG5zanlvYzM1?=
 =?utf-8?B?YTV2QW9sZE5wSVlFMThBTUhPZ01HZ3htY0tNQzRiYXlvUldsL0pIK3JZUkN4?=
 =?utf-8?B?TXFGWWVKS1JTeVNuUUtIT2IxRU5weHdmamEvZURkWThxUUhSbkVkR2dyZldD?=
 =?utf-8?B?dTZJRU8vNjNmNE9OTTVWd0U2SzhMME5CVDVWN2JidDJkQ1cwakZkTXBpZjFj?=
 =?utf-8?B?UG9IR0UxYTRBR2xMMi9BQWhuNExBOUtISzdkcGlLZ0o1QkhBN2ZCbmN1S1Fq?=
 =?utf-8?B?VzlJbmtWZW5YbzJHcHNFVUVuaFRrYTdIdkdkRmZpUFEvY1VqM3RVdlU4SXJ6?=
 =?utf-8?B?N3RDZmN0TlVoZThEMjdVKzQyS0t0R2hzdVhaNXNQMEloeWwvWHhLTm94TFZj?=
 =?utf-8?B?bjhrR2RsYmE3Y2VpUnJmeVViK05YTzMwK0VnNTRwWHZEdFpsM05JTFlNSzgz?=
 =?utf-8?B?V2crZkk4aXorUUt5MnpwQ0xaanorU2VLbjdzdHhZNWIrVy91SXVRaVo5T0dT?=
 =?utf-8?B?MWsxdG8razA5bVhqc0crTTRzdGRNNE0vV1Nld2puRlFHcFJ0QTdBVkdTQ1ly?=
 =?utf-8?B?WE5iUDBUVVROQ1BSU2ZQWmNMQ1ExUjZ1dzVScGdCN1ZybFphYWdCeklzSWc1?=
 =?utf-8?B?TzM5NGJ2a1pPS0ptS1Zkc1pORWQvTUlyZG9Jb1I3VjZpaVZURHRVRE9TY2pF?=
 =?utf-8?B?NEZqV1JLNzlLcm1yd0ZKMjR5ck5STGt3OVU4eE9qc0k4WEFhQlNDRGRVcEoy?=
 =?utf-8?B?R0t0bXpyTXEwR0hkVXBvdG9relB2QzNMRHFsNGt3UmY2cG9CNE1sSzNIUmgz?=
 =?utf-8?Q?PNl1Oc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:22:25.1074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b3ce8e-5282-437f-5aa5-08dd97021ad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Testing this feature turned out that it was a bit unstable. The
CP_VMID_RESET register takes the VMID which all submissions from should
be canceled.

Unlike Windows Linux uses per process VMIDs instead of per engine VMIDs
for the simple reason that we don't have enough. So resetting one VMID
only killed the submissions of one specific process.

Fortunately that turned out to be exactly what we want to have.

So clear the CP_VMID_RESET register between every context switch between
applications when we do the pipeline sync to avoid trouble if multiple
VMIDs are used on the ring right behind each other.

Use the same pipeline sync function in the reset handler and issue an IB
test instead of a ring test after the queue reset to provide a longer
timeout and additional fence value should there be additional work on
the ring after the one aborted.

Also drop the soft recovery since that pretty much does the same thing as
CP_VMID_RESET, just on a lower level and with less chance of succeeding.

This now survives a stress test running over night sending a broken
submission ever 45 seconds and recovering fine from each of them.

v2: fix up pipeline_sync count, only emit vmid reset on gfx (Alex)

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 50 +++++++++++----------------
 2 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 836ea081088af..af79a03abc110 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -278,6 +278,7 @@ extern int amdgpu_user_queue;
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
 #define AMDGPU_FENCE_JIFFIES_TIMEOUT		(HZ / 2)
+#define AMDGPU_QUEUE_RESET_TIMEOUT		(HZ / 10)
 #define AMDGPU_DEBUGFS_MAX_COMPONENTS		32
 #define AMDGPUFB_CONN_LIMIT			4
 #define AMDGPU_BIOS_NUM_SCRATCH			16
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d377a7c57d5e1..cfcedfc8aa6e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5565,6 +5565,19 @@ static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		amdgpu_ring_emit_reg_wait(ring,
+					  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
+					  0, 0xffff);
+		amdgpu_ring_emit_wreg(ring,
+				      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
+				      0);
+		amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+				       ring->fence_drv.sync_seq,
+				       AMDGPU_FENCE_FLAG_EXEC);
+	}
 
 	gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
 			      lower_32_bits(addr), upper_32_bits(addr),
@@ -5896,20 +5909,6 @@ static void gfx_v9_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
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
 static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 						 enum amdgpu_interrupt_state state)
 {
@@ -7185,16 +7184,12 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
+	if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
 		return -ENOMEM;
-	gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
-				 ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v9_0_ring_emit_reg_wait(ring,
-				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
-	gfx_v9_0_ring_emit_wreg(ring,
-				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
+	gfx_v9_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
@@ -7437,7 +7432,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v9_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		7 + 7 + 5 + 8 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7475,7 +7470,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.reset = gfx_v9_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
@@ -7494,7 +7488,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		7 + 7 + 5 + 8 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7533,7 +7527,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.patch_cntl = gfx_v9_0_ring_patch_cntl,
 	.patch_de = gfx_v9_0_ring_patch_de_meta,
@@ -7555,7 +7548,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
+		7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
@@ -7577,7 +7570,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
@@ -7598,7 +7590,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
+		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
-- 
2.49.0

