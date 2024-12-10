Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95796E77183
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266D210EA02;
	Tue, 10 Dec 2024 22:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LJNB3V7H";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D945710E9FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAh7J14/kYwl6vRnQII8YoEbkfnBg263a0Lh69r9vWxq2fnRoizUXY0/qxkIDECcguscHZy5gCRX4oEL0CwtrWN9oBIbyAkzgrb0orec8s9kSE0VZ9auQhQcgpAif2cU3Uu9q9kjVNnkpVRz1SUeXl2tH5TJNQHR+Vof/UvVqffKKAahNarD3JBfe8m3YGM6UbbfMV4sSyZ4E73fyTdGiSN1XBs2Jws6ALT5mQPZ4jWRP36oEwkqdJefHUXSHTOxGEQKmN+sXsbSyC1c5sWXbfKDgYhNhbrVaNzgcDet6gijKRiKNvmgJ77B9MODSAIQbUu+4fWk0wifQkDoo2343w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4qp1YlbWqBGKJ7nFriKaaQVxkoTxi/fiktwvbUVI5w=;
 b=Y+zpZMNDmxTVqGpZavaLG5P0Gumi3amHlUrmoV5ucGX4aNCmIbP1oHWdtkqCT2NY3IohkmSTJxd51qRSaXd8N5m/2ue7y6rsBx3zRtg09iguMvawIKstwCIpdw1SQoRVuwTNbk/MNkmbktJF9mZy+6J79yleF7RZ8s7iBSU1tWhqQL5PCAsVwoLoseNu9rgdLO63okZ5XGa+orK/r59zlhHzMbdZddyY8tMwwgGhMaexfbl1t1MBVYdpXX/dGesZ9QKUaTYwIYFIOw9tBwAo5CVIoDbCj0J2K1pQwX7x1vkkux9Ql6MNDO+o5YB8IHpJfQhxXLUwnTnNUEK6ACyt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4qp1YlbWqBGKJ7nFriKaaQVxkoTxi/fiktwvbUVI5w=;
 b=LJNB3V7HEwHq+zMuR1qkKRbwOMTM2YOkDC596rX6gaQooOOkFZNZoiU2KHOjH3LPlaRdmcyOP+mM3i9BH4O0Ohty1ZlSgxhZNxSw07686GWDIWDupk3AyLe3MP4QRSXMxmh+TKgeSP3b8WpQ8qTvo0XUvlhApHORWVrcc8Qp4fA=
Received: from MN2PR01CA0036.prod.exchangelabs.com (2603:10b6:208:10c::49) by
 PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:54:09 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::be) by MN2PR01CA0036.outlook.office365.com
 (2603:10b6:208:10c::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 22:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/48] drm/amdgpu/vcn: adjust pause_dpg_mode function signature
Date: Tue, 10 Dec 2024 17:53:10 -0500
Message-ID: <20241210225337.75394-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 21334213-a8e0-4174-70d8-08dd196d8e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WjcZuCaezT2+7/8AtVgpM75tN6XOWBMmWxMF7b+ZkaZkxjtqshvPnulZ6oUd?=
 =?us-ascii?Q?IQf3LYMeTCcgj2e0nS7Tmm25LK6dum+3+3c9hy0eDNXEpfJ5TfJ84P0N23h3?=
 =?us-ascii?Q?Cj3gyA9Hl+f8LSeatr4MHJtrcMieREIzNd/6KtsgTpXqO7CYpyvHOyYJoG31?=
 =?us-ascii?Q?ByrXL/+KBOI7pEEDGdYm6Cu1oNjQO04Ak5ku3Pf6Wfk7douyJJtaF7hrWm8b?=
 =?us-ascii?Q?QNt8X33ynD7alJbRQM7lH7ZFV3s9AZ3XFwL+eYnescU3i0y2KeUuKpvV4PSA?=
 =?us-ascii?Q?DsCghc74kTVUUObySPyTUkaWt/EXgEnwxQ5trMyW9DqGWOQh55Ybu7CxpuBH?=
 =?us-ascii?Q?nyi5KqV5DJRTIupV/bbszjPA7w6rqZ9bD68uYld9NiLkVWwxZf6aLZoCHJ6y?=
 =?us-ascii?Q?7odPhrLwbp5CBYLdt1gD3Nc7USwSdG26EA36Mk6Si3RTVI4tdI8WgtRETzCH?=
 =?us-ascii?Q?VbAkaWmEJxZ8eycGEDeRFxL7esRfZA4Dx/RbbaTWz7nqQhNssEDXJeWJK4qT?=
 =?us-ascii?Q?lMYnMydNtupqBBxUhpnWoBe0O7QgaXeGabT8PJERiYnkDq33WPtzxOic1aJY?=
 =?us-ascii?Q?CSnRZz0wdOGOHx54cE7Ua+PpbWyW7qpxtg8PH7Zt2/n+Y0UWFHiaTMxCYxUy?=
 =?us-ascii?Q?PVGGqNkYoxtgCnx9GN7HS4CaBSU/IqgnOteD2kiOYAsjbCEa4MB3JxQYMLwM?=
 =?us-ascii?Q?glny0VhVzZQp3Ti1RN4PhccwMA6HPDaTJekZSDC6rcUyUjY4uWzaqLUZr8EI?=
 =?us-ascii?Q?aCOdpLeiYd4dE2Xb7x+Ju06idPGNT5X9MSFtnDC3Yoync05Zn/SJoykpgFqI?=
 =?us-ascii?Q?4jeu0C6D3CZyXnFnbCKumQV8cCOEhZFsNkwTvEL27eemVID6VrE+KbWZV3Dz?=
 =?us-ascii?Q?uyKkEpf6fMOE8rEwJNKNPN3IUagO8jKOnv4NIlKhDN2QZDaCiGaQC8poZrpw?=
 =?us-ascii?Q?8xS0hWivgXi0IKKyxZgXZQkeHk5YtwBD2amsw2HdOdxohQfZXBkT8XixNLrV?=
 =?us-ascii?Q?Qv5CDoZsAyYv5tLceqFX3qhmV/VYu1rhYMdVEwAT+EoYWwMWZGVyu2kIS1+K?=
 =?us-ascii?Q?xpBu8+4LqiaubdsHl6ECEaOeRqYaXlcXt0Sc3AwVWnpnzDYr4mz7JLxAjC+J?=
 =?us-ascii?Q?f1NNVCFdawakWxjWMKAy7ofWrvQ3yRe67RNt2Z+iem5aNcbDCuzlulPM+GmM?=
 =?us-ascii?Q?hN2mcR7xOL1d8sZSWVwyd1XlyC54xuNN+5CVWkTdSiiD/J0bP9+QnKWeHor7?=
 =?us-ascii?Q?9Bk0MtfryzRhqDMuC2EOLjoA4GKGTf14/Lwe/u7m+QwjjlRIzQzlujQMnfQn?=
 =?us-ascii?Q?UJOQH55NxooFKpXAgS3pUTU26LyPXdVmFIIQgJseNJ4Rg4j2+FzDvroc8kyN?=
 =?us-ascii?Q?K0T8yC/M+bowYYBhSX06hF2eRYfTdluOFDWSk1/C8Ta0qmUnuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:08.4702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21334213-a8e0-4174-70d8-08dd196d8e42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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
index cfa46e2e0b8f8..750cee0a8f184 100644
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
index a54031aae013a..fc35895be5c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -321,8 +321,7 @@ struct amdgpu_vcn_inst {
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
index c01563441ea76..95e370b28e1f3 100644
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
 
-		adev->vcn.inst->pause_dpg_mode(adev, 0, &new_state);
+		adev->vcn.inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
 
 	fences += amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec);
@@ -1933,7 +1935,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
 			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 
-		adev->vcn.inst->pause_dpg_mode(adev, 0, &new_state);
+		adev->vcn.inst->pause_dpg_mode(adev->vcn.inst, &new_state);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index b42b369a386da..3207909c0d55d 100644
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
index 2562b25710b5f..b823114cdf552 100644
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
@@ -1443,14 +1443,13 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
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
2.47.1

