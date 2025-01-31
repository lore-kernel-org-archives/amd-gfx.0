Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF2DC02196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7047910E3D9;
	Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m52BR2oW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5239910E3D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBau7YD+fYIRZLw3s+DuJeIM8AcN6IJXblH4ObCE7kI40tbm4kAYdBXvyi1PXjNTQtKgVScxMlZndlUSrSxU8myhzWl6ofg18jj0zk0MJUy9EjAu/UjyAqOYEJiWHIeKqxe969OelJbYgAx/DQHGgpyhYRpkJE81y4L3KyeeYlOoQNTz/eqrfre6hkPVZS7awMbUx9vArrUCEiNQXrJeGY0fuK3sJA2HAdLZ5JriLIB4X3+vOwBAc2Tq3fC79LpVZov+SZMJIIikhMUKo+2AHpNoPJpEk5o+XzYVVPbJdbzropJMA56s3nZmNqeW1oqHh9bJqAiSfI6C6lP6IIJ7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q95A97lrGijai4S/xS1dbGE/YcWsqatol7VYALgDcC0=;
 b=gWYvWjC02wvc01TwH2Nsae+zZH3P2kIrsqwPOpMd4ZMDcuRL5ZxT3CDRv7c2/vKairTKdbSr2VKBa2uJ2lBazJ5PRv9v9huAUvo4l2qhhfL1xlJw3XVggpDffAw9ZRrNk3Yz4TN1QW6m6qi9edfeCXWhMssOSDVLaRfxgE8tmZ1bMD7xyd6dFT39N6YwWUO934Nk4ncu4z8KXhQTyD2fXhcqlOjamJ+DLe3W0ES5k538LsgcF+qv1QpAsEsthEn6T2KcTaxnmZkLLWwfd0o1E4X7i+UWGYBNADhGOW8TEvY+ydXSp6QwQYVVa6dYlXvV3xI4+VDdQWsmK2sT2wd/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q95A97lrGijai4S/xS1dbGE/YcWsqatol7VYALgDcC0=;
 b=m52BR2oWYYuBHfb3OgzSPk5X7Qx1+92lf2bL7gXPWZ/+/03zPLWQ+qCrv/lXW8qgSo8QePo/V4SDMyxBAoOKFWPh+k483uZMqI0ebSVFr+adXODEG+FWDnr8ZdQaDtbSlmljpqAwPWKPucFHztxrlut0+olakxWFEgPflnK/BXo=
Received: from CH5P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::15)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Fri, 31 Jan
 2025 16:58:17 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::f3) by CH5P220CA0014.outlook.office365.com
 (2603:10b6:610:1ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Fri,
 31 Jan 2025 16:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/44] drm/amdgpu/vcn: adjust pause_dpg_mode function signature
Date: Fri, 31 Jan 2025 11:57:17 -0500
Message-ID: <20250131165741.1798488-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: cd281ec5-08c9-40f8-6ad1-08dd42187529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N6u5hhG6GZ1gsGQkmOsZt59V+uQe4vqve0tEKblv7skgWloBrvELi0pqtgHK?=
 =?us-ascii?Q?NKw6HeO9x1gVzTA4P3AhxcVkXTs4iXwfqqV0NcRNN53uvegQl85x9m0OgmYL?=
 =?us-ascii?Q?JTXlOhEj/qLYMp5pH6iPrpPtQC71oxYmbhcgUbtxu65ZRHqHkQmWBCkEVg29?=
 =?us-ascii?Q?Bu3GLbCYVSLBF47gMMxpvHH48rr5rNd3Fsuo1FhZcUmJhXfobXLHOUAUXftl?=
 =?us-ascii?Q?DiqNBH6VFzlxaXrofLlL0ALX4vmVV+yjtJuXUGB/thr3rhQHbCA6LldHepZn?=
 =?us-ascii?Q?P6miK3LqrirXJzHRBAfCK3gFnNr7xCllq7KpgSDQqkqxRtelKrOVsVGueBf8?=
 =?us-ascii?Q?ukJ+DqQzO26u6fCApKPi+nD5gZDr8G0aslfs7Y95NdktkY2cY3GwJ8NgLQde?=
 =?us-ascii?Q?vdmKBZ1Ti6rdfo9At95zGIG+CGAew2lDVGdAUb6KkQigxYzbO0aZ9rnFgOl1?=
 =?us-ascii?Q?/+5SjFKlZS+HcjWM2xNBuWJxBm6PMbsWkSn0TFO19CEPoILS5n2FF0riBjdS?=
 =?us-ascii?Q?WBF7ArO/uGXwIo4Ogm8XQZt1qoa0uksxbB7ArGd8oRDOW6FkSphk1JjlT7XN?=
 =?us-ascii?Q?AaaLNVtphL0ssr5Hfeivn8b3lXPC4dt+phcLLook1d39ul5/OfD8QkNF+1MH?=
 =?us-ascii?Q?SnQhWhBOzbOXJV597I0CK4uIjc7TCKSySGNF5Hpb8LP6xDO5u2QOiSsLzZWB?=
 =?us-ascii?Q?6rLJdQ3lf6GR/dyCY9n5/XUNFUM51Y8EyfG08QcqX1a3JfIHVAh5CqbR2XA0?=
 =?us-ascii?Q?UZZZoLiTMAQXlc70Mg7OQr2TXslyHBX8APwf4tglHlpe49GnxW38l3DlCeJ3?=
 =?us-ascii?Q?pbBttDcBxiL9+LyCnFEFnFxUZmsv+5iL2S4CqMi1zLV8yeXiC2W3FU9jnXdP?=
 =?us-ascii?Q?uPUFLLlrlxu4F38qf4U+Hwe5IQCMqrO25EFKvK6kxZNi6dw+QjFv3770h9Bp?=
 =?us-ascii?Q?Pebjp4xWln/S4mJLMTZ74VLUxTbJy8y/5CSZdjxzEYTGx2CFJtt6g9V1myiL?=
 =?us-ascii?Q?MwwMsq9YtJjL84DDl77F7ExeBT6Beo7ACRiF5iMjVfAL0ccmz71120JO9kGo?=
 =?us-ascii?Q?tLjbZuGBIxfoTZGDLfugwlXm/ySnnPFpHbCkhEOSHGW9YGG67mfVvkDOL5gy?=
 =?us-ascii?Q?QTq4EkOY7iOD4oNAfuaD+Y9eZVT1j0bXYOyljSIWfWydkGND6CYAuWZwlgmO?=
 =?us-ascii?Q?5RliPJUjZ9j9vlKmM8NZPlhlrcstqgaJQEHJtGJF/dW9who9+t7kkwbhAE+i?=
 =?us-ascii?Q?SnqLTp8yjUaM0jFF5EPDhv/p9XF3DJPMAubTiRw7Cd1NDHtzFmKaK3RLa3BT?=
 =?us-ascii?Q?exdDLymhlFCTq38ON2mvbLCpWq/mzzCi8rRW6l5q53PyKxV+IrmWux7IpGrS?=
 =?us-ascii?Q?fbPoGUzVXaumP5b9h4ZCbrZ21g1aaRIz/eNcCk5iT6ME1BaeGRSR57SdrpVd?=
 =?us-ascii?Q?5r5vXbvWmi9H+dXLKdka8IKcmEx5QiKFdD1xqdJ677OSiZrAtiVQ0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:16.7681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd281ec5-08c9-40f8-6ad1-08dd42187529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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

Change it to take a vcn instance rather than adev to align
with the vcn instance changes.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev->vcn.inst[].

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 15 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 13 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 15 ++++++++-------
 10 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 010cc64a950a4..a2250747a7c81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -417,7 +417,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		adev->vcn.inst[i].pause_dpg_mode(adev, i, &new_state);
+		adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
 	}
 
 	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
@@ -474,7 +474,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 		}
 
-		adev->vcn.inst[ring->me].pause_dpg_mode(adev, ring->me, &new_state);
+		adev->vcn.inst[ring->me].pause_dpg_mode(&adev->vcn.inst[ring->me], &new_state);
 	}
 	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 5f92cf28cc752..8d34e3814ab19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -327,8 +327,7 @@ struct amdgpu_vcn_inst {
 	bool			indirect_sram;
 	struct amdgpu_vcn_reg	 internal;
 	struct mutex		vcn1_jpeg1_workaround;
-	int (*pause_dpg_mode)(struct amdgpu_device *adev,
-			      int inst_idx,
+	int (*pause_dpg_mode)(struct amdgpu_vcn_inst *vinst,
 			      struct dpg_pause_state *new_state);
 	bool using_unified_queue;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 613f17be9d829..3d56660fd90a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -87,8 +87,8 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
-static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 
 static void vcn_v1_0_idle_work_handler(struct work_struct *work);
 static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
@@ -1264,9 +1264,11 @@ static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst)
 	return r;
 }
 
-static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state)
+static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	int ret_code;
 	uint32_t reg_data = 0;
 	uint32_t reg_data2 = 0;
@@ -1866,7 +1868,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 		else
 			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
 
-		adev->vcn.inst[0].pause_dpg_mode(adev, 0, &new_state);
+		adev->vcn.inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
 
 	fences += amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec);
@@ -1933,7 +1935,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
 			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 
-		adev->vcn.inst[0].pause_dpg_mode(adev, 0, &new_state);
+		adev->vcn.inst->pause_dpg_mode(adev->vcn.inst, &new_state);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index aa61d3b54f8c2..e4305687749a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -94,8 +94,8 @@ static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
-static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
 /**
  * vcn_v2_0_early_init - set function pointers and load microcode
@@ -1158,7 +1158,7 @@ static int vcn_v2_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
-	vcn_v2_0_pause_dpg_mode(adev, 0, &state);
+	vcn_v2_0_pause_dpg_mode(vinst, &state);
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
@@ -1252,9 +1252,11 @@ static int vcn_v2_0_stop(struct amdgpu_vcn_inst *vinst)
 	return 0;
 }
 
-static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state)
+static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
 	int ret_code;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 69cf42a4a3f18..d5921a954948e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -100,8 +100,8 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
-static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
 static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
 
@@ -1506,9 +1506,11 @@ static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
 	return 0;
 }
 
-static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state)
+static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
 	int ret_code = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index f6f4f04d74339..2a17a7e108001 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -110,8 +110,8 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
-static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
-			int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
@@ -1581,7 +1581,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
-	vcn_v3_0_pause_dpg_mode(adev, inst_idx, &state);
+	vcn_v3_0_pause_dpg_mode(vinst, &state);
 
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
@@ -1680,9 +1680,11 @@ static int vcn_v3_0_stop(struct amdgpu_vcn_inst *vinst)
 	return 0;
 }
 
-static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
-		   int inst_idx, struct dpg_pause_state *new_state)
+static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 3d70e2cc81982..2ad217470c8c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -101,8 +101,8 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
-static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
-        int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v4_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 
@@ -1565,7 +1565,7 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
-	vcn_v4_0_pause_dpg_mode(adev, inst_idx, &state);
+	vcn_v4_0_pause_dpg_mode(vinst, &state);
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
@@ -1671,15 +1671,16 @@ static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v4_0_pause_dpg_mode - VCN pause with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @new_state: pause state
  *
  * Pause dpg mode for VCN block
  */
-static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
-      struct dpg_pause_state *new_state)
+static int vcn_v4_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 	int ret_code;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index a3fbfaac76603..ae7733c0d032e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -92,8 +92,8 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
-static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
-		int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
@@ -1449,14 +1449,13 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v4_0_3_pause_dpg_mode - VCN pause with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @new_state: pause state
  *
  * Pause dpg mode for VCN block
  */
-static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
-				struct dpg_pause_state *new_state)
+static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state)
 {
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 295f39b2222d5..a00c74d287a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -100,8 +100,8 @@ static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
-static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
-		int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state);
 static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -1321,15 +1321,16 @@ static int vcn_v4_0_5_stop(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v4_0_5_pause_dpg_mode - VCN pause with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @new_state: pause state
  *
  * Pause dpg mode for VCN block
  */
-static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
-		struct dpg_pause_state *new_state)
+static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 	int ret_code;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a71960d899e38..91b57b86dc58a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -83,8 +83,8 @@ static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
-static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
-		int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state);
 static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -961,7 +961,7 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
-	vcn_v5_0_0_pause_dpg_mode(adev, inst_idx, &state);
+	vcn_v5_0_0_pause_dpg_mode(vinst, &state);
 
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
@@ -1064,15 +1064,16 @@ static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v5_0_0_pause_dpg_mode - VCN pause with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @new_state: pause state
  *
  * Pause dpg mode for VCN block
  */
-static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
-	struct dpg_pause_state *new_state)
+static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 	int ret_code;
 
-- 
2.48.1

