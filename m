Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23012C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C091E10E34E;
	Wed, 12 Mar 2025 18:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CK0rZpEu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF69310E7A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN9KvWjitzgJGPEzphSRDiHNKG3VJJAEoN97m8zFTul+dQ9nzzjVp1XGOiGMwb2/aRXmSkPZfWhPuby7vtrqE2uttiokbh5OaqQxv80TUsJYX4vPfK6X6z/tNwh6ZVTCOOrED0ZUFoURM+5M35T78G+/I2vHndnrzhxJjy7bN2S8bHzQkI7M/GKweDaE+TZkHmUJ0LAnjUpE+jryBt4Z0KaQBuiEG/Vx2QVL4rf42ByjV1xO97fKORHf3eLFLuzD/W+c6R0c1W4x0/ne5UND6GxKZO8/sdT3hRPVB3cBScTUKMjKsLua3yEkC1WcrPgxmUP9c674mvHwoNZ35wUFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ1RTd1Nfx+RwU2BZ66erPV/BDvPpytabjz9EXKa5OY=;
 b=y4ctV/rEQjTRKuLFzla3y6NnG3M5sNIU3uk7LnlutwF9LpX8MQBeHQTGfS1ZN+Kq2Q9DuCTMsa181/OXNj1oeCniuX0gi4/x+EwX0B64a++gOgZyli99UMvrZcKat+JUkQe35WA+XUy8UL2XdAd3J+Gb6/vHB3gYdN+uARlM1pkORlfvv0L6hQDH3L6BelzyhBmfUvuLCS8Q47yTSuHSRmqvvB8FRuFSW0qzAsG6PTlMJqIO0bo7Z9HPfmIA9sZuIkbwPqWhT/SHVH92CMJ/Jou9WjAP3llTcb+lbRj3oY+OB3dkulLrc+R+rcj2MIiAUCyejUgW9w3RWF9H+1YI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ1RTd1Nfx+RwU2BZ66erPV/BDvPpytabjz9EXKa5OY=;
 b=CK0rZpEu51Nly5PEyUFG9PNq4CK+6t1ZQLsHUwwhM1GYz3xBKS0HrIxQ77qOe0YcIi9kN+RNj7oxd2Jxc25lT1dHH2tqv3bUj5JEXbqrGwmFh5TNQ1PZwUPtwyaSka/ROL7rJJTARxdSn+GmTKiwn2lpJ6Pz1Yi00L1E3zvAP1Y=
Received: from DS7PR03CA0230.namprd03.prod.outlook.com (2603:10b6:5:3ba::25)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:57:52 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::71) by DS7PR03CA0230.outlook.office365.com
 (2603:10b6:5:3ba::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Wed,
 12 Mar 2025 18:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/11] drm/amdgpu/gfx12: add support for disable_kq
Date: Wed, 12 Mar 2025 14:57:28 -0400
Message-ID: <20250312185731.211350-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cea86e-ea34-4dd4-fb35-08dd6197caaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P/Td4xqAb5qH2CdTTCSzxFUqvTBUTjS/Q/aXcypX3A1+JSLJqDgPoWpM4/hX?=
 =?us-ascii?Q?im5mI5ULVMPjp42Ms6sDZT5SdXun7Phj/At5Jzc9Uck5f6o4B9mj2RmXBVqN?=
 =?us-ascii?Q?69XVceW/QWzPkqvUEtzF1YOWEVDF3vnQ/WAWyDkB4SAUE27SQGr74ZrdttJs?=
 =?us-ascii?Q?mNlrYw52FHsv6qOn5jiM0r7xCyElj3p3vbXWNBFm6wKJ6cfRPC/Ea73UooyF?=
 =?us-ascii?Q?nmGBb9Yo2e0DvVlGRWEvxC8vx9jmppWvUl4yiwiFILM6EYNAiM126YJGIEiC?=
 =?us-ascii?Q?9RniiN7w2NdDVfUpt/8hMqQ4Pg90Vqi9NcpKk8GsL+luX8FHSAD9vCxtlrQT?=
 =?us-ascii?Q?fzU/66LobbRG1f8ws1FkJYGcsw3junvS9bociz6RpsnWl1D2StwZayGXJw/P?=
 =?us-ascii?Q?Q9glFZUFHIimUzIRrw7FxL35s+dKr5cmVv1T56M5AE0xz5akrNXGTG20MSfg?=
 =?us-ascii?Q?XMAZ689Bu1j2pxeNvQNX0TZsz0sHPLukbYkufLxQbsmacCEuT6AalHxgpDRt?=
 =?us-ascii?Q?WVCxkq6yBsVbiwioTHnO2GcNLwyVlpjzOcI+E6cJOnIAx5xsMPXBkq693iQy?=
 =?us-ascii?Q?y52VldS55wuo0vOTUuMzZenQRgSWgTr7mto4t+RkmFJWpq8VJzaJWlz3dziU?=
 =?us-ascii?Q?hHM9hL/KoOaFCLa9ZRYLGeNjQoeduzvPTiOxDYZiUwXVQ4Kg4UKr0PCHpfMu?=
 =?us-ascii?Q?8Ku4glAIH7H11W/CKHY1MymyJigHhvr+cnRnVPWpvlUz61zZH8Yc3qbNBREV?=
 =?us-ascii?Q?kuHCSBVcn8bCms6FmjkrS6GGr+dvQu4a0EyvGCW/JHe25OK0DJWi2y8nrZGa?=
 =?us-ascii?Q?ewv9SygK21mBdYqVmqvdh4HmEUKXpOp5ZoSB/I8jsvURfuorH70KwwIa7z39?=
 =?us-ascii?Q?2vS4Xk/2C7KxO3SxUd9Gec/VANkH8ADuqDta3J3gLQBAAyN+sGiVFxmnQDBO?=
 =?us-ascii?Q?ZVh3UGIIyA8pEBSzQbBFU/XoLX8HB2yuLe9A3xWB/7yQX84uY2qwVMldK1u/?=
 =?us-ascii?Q?Dq7ujFGTK8ELEZ2N7l0G4NOknEmCxw5l4Bix+bWnpGgqOrqwmI4R0fjM9LXH?=
 =?us-ascii?Q?1GyulTVuSVsSSy6Gwcu9vqi1VCNTlkoIw84MHf7qF+a0/UNA5AktwVMEXzBv?=
 =?us-ascii?Q?47ag0W6sypXCsIZecWGO2wctw4KWR3AWytfsK+8qv1UVeihggUr7VkyYpF4O?=
 =?us-ascii?Q?OoNFMJ9RaTrXo+OdD0PmAEnhY1IJtKTQ5fnqF0V39Wp/0V0PQNVxJgwePJdM?=
 =?us-ascii?Q?baZyDHMDaDEQXavpUddxz4BKgxrywMhNnq0pnUJ7kC7+xi5sR6Adu9AZ3+s8?=
 =?us-ascii?Q?mHHUbIHG76NHxweOgmBPDIzUlnrgENi3o3onFRBZw17zlPs06PZx1hosxlBg?=
 =?us-ascii?Q?yBMECDnkmOoYNwCkYuFKdZvwKrQsjat4vlL4mDP6BDMjZV4hmfWn6pkInowu?=
 =?us-ascii?Q?obeZLvRdklRXHvWu5La7Z2vR6sdW+9l/pRytoutDbFmjZM8s/9OiTA+4Kwyw?=
 =?us-ascii?Q?YqHRc+U3nEiUYb4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:52.4012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cea86e-ea34-4dd4-fb35-08dd6197caaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

Plumb in support for disabling kernel queues.

v2: use ring counts per Felix' suggestion
v3: fix stream fault handler, enable EOP interrupts

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 183 +++++++++++++++++--------
 1 file changed, 125 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 34cf187e72d9f..e8039291de308 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1421,11 +1421,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
-	/* recalculate compute rings to use based on hardware configuration */
-	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
-			     adev->gfx.mec.num_queue_per_pipe) / 2;
-	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
-					  num_compute_rings);
+	if (adev->gfx.num_compute_rings) {
+		/* recalculate compute rings to use based on hardware configuration */
+		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
+				     adev->gfx.mec.num_queue_per_pipe) / 2;
+		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
+						  num_compute_rings);
+	}
 
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
@@ -1471,37 +1473,41 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	/* set up the gfx ring */
-	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
-				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
-					continue;
-
-				r = gfx_v12_0_gfx_ring_init(adev, ring_id,
-							    i, k, j);
-				if (r)
-					return r;
-				ring_id++;
+	if (adev->gfx.num_gfx_rings) {
+		/* set up the gfx ring */
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
+					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
+						continue;
+
+					r = gfx_v12_0_gfx_ring_init(adev, ring_id,
+								    i, k, j);
+					if (r)
+						return r;
+					ring_id++;
+				}
 			}
 		}
 	}
 
-	ring_id = 0;
-	/* set up the compute queues - allocate horizontally across pipes */
-	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev,
-								0, i, k, j))
-					continue;
+	if (adev->gfx.num_compute_rings) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev,
+									     0, i, k, j))
+						continue;
 
-				r = gfx_v12_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
+					r = gfx_v12_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
 
-				ring_id++;
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -3495,12 +3501,18 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (!amdgpu_async_gfx_ring) {
-		r = gfx_v12_0_cp_gfx_resume(adev);
-		if (r)
-			return r;
+	if (adev->gfx.num_gfx_rings) {
+		if (!amdgpu_async_gfx_ring) {
+			r = gfx_v12_0_cp_gfx_resume(adev);
+			if (r)
+				return r;
+		} else {
+			r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+			if (r)
+				return r;
+		}
 	} else {
-		r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+		r = gfx_v12_0_cp_gfx_start(adev);
 		if (r)
 			return r;
 	}
@@ -3711,6 +3723,46 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
+static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	if (adev->gfx.disable_kq) {
+		unsigned int irq_type;
+		int m, p, r;
+
+		for (m = 0; m < adev->gfx.me.num_me; m++) {
+			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
+				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				if (r)
+					return r;
+			}
+		}
+
+		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+					+ ((m - 1) * adev->gfx.mec.num_pipe_per_mec)
+					+ p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				if (r)
+					return r;
+			}
+		}
+	}
+	return 0;
+}
+
 static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3721,6 +3773,7 @@ static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	gfx_v12_0_set_userq_eop_interrupts(adev, false);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
@@ -3809,11 +3862,19 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
 
-	adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq) {
+		adev->gfx.num_gfx_rings = 0;
+		adev->gfx.num_compute_rings = 0;
+	} else {
+		adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
+	}
 
 	gfx_v12_0_set_kiq_pm4_funcs(adev);
 	gfx_v12_0_set_ring_funcs(adev);
@@ -3844,6 +3905,10 @@ static int gfx_v12_0_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = gfx_v12_0_set_userq_eop_interrupts(adev, true);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -5043,27 +5108,29 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	switch (me_id) {
-	case 0:
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-			ring = &adev->gfx.gfx_ring[i];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
-		}
-		break;
-	case 1:
-	case 2:
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring[i];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
+	if (!adev->gfx.disable_kq) {
+		switch (me_id) {
+		case 0:
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		default:
+			BUG();
+			break;
 		}
-		break;
-	default:
-		BUG();
-		break;
 	}
 }
 
-- 
2.48.1

