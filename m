Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48DBC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818D310EA70;
	Thu,  6 Mar 2025 18:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fJnua/Ht";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA08C10E296
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcuVftbQooymQYjeJixAh+Mi9R+Pd4DmlSONq2KFHZilM/OQQN14AznqwetSLM4xt5fvVSakNjktmyA5Bg8DRT0NzUZVqVdaKet1L49/+E4CZtGVjg4NfJ1vPxvTCEDZ+B8/XuzGcmJ9Exv1HwJvq5p816LFW/f5klKgHROih/Xu/WmF98VIbAFtNGqiOM4uv62ujy+MDYUQYmdKc+MMgAcXtxgpv/bUrvk/x2bmkUJJ7o4icJsn8mD5g399i5Sl65SgmMbQ3WprG9ZwqjnKj8y4uv2ph5w1mbs+ZKr4+9lQEjIayEZnnenbjldoFKqNh2QYO4+fKF+Y93ZQs3cbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skzCSBsLBria4oVYhTGQD8Nw/X65w/9eChUmzNbNe0Q=;
 b=TbnWRbVRTUsq6uoqS+NaeYq7XVHKZ+rOqmZiS58httRVTLPJOQo5R7xRqiUpfcOX1wbgnxWPXVj74m8lc4OYEM/d/KzsCofCiMOKA3qb7J54nqfi9lOlzZHP+mJVv4oOOQRkp+Unl+jpbtZZWG/S1xZ1eTTQ6mLzqYGRjUTPWC1chkjUqAbg9/yz69bH3tYiVc6g9tjjrFvBfmLLT53XycQB7T58BvxS+gCHHhtTvNZzKLi6e2IlnfgF5K8SIt66TTi6J5NbppFiWjDDIH90eq1JX6R1X/mCY9GfLBHxpmhiqCjZAwRSvLdVhZV9s5ibUo2bvaF7TMN7E2JIIg6GjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skzCSBsLBria4oVYhTGQD8Nw/X65w/9eChUmzNbNe0Q=;
 b=fJnua/HtCT3dPGxWCiF5Wq0W9V4S8yufwaVimz1ZCUzvI9XbbS9PZRHjGHAVKc5gf8TNFAJbi4Re2ByPi9fqzKJ/CJ46E9tUE0jhLjK5QBRPf2wKxls5x83T2yQFXl41hUJjkQrxHM26GDgmspROg06fR5hJ7KWCUL4iwkDIPoM=
Received: from MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35) by
 SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 18:46:31 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::ee) by MN2PR01CA0066.outlook.office365.com
 (2603:10b6:208:23f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 18:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/11] drm/amdgpu/gfx11: add support for disable_kq
Date: Thu, 6 Mar 2025 13:46:07 -0500
Message-ID: <20250306184612.8910-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c30dcb8-4802-4e08-b1ed-08dd5cdf3659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BLeMXToda8Cx40GjSm84XZ2VGu/WSr+/du19Ym4BWDrBCQbqHBM6IcOh6HuB?=
 =?us-ascii?Q?9ah/MFWrhJdGTHO0l8noE505aBfrI5P+MFFsbX+2dIRY1/BwbPaBBAR2LZ9y?=
 =?us-ascii?Q?e2EXVXDT1+PIultGcnRsFFAVu1dHodkF9nBr3IV43SS9n7KA1cqwG55vMD0I?=
 =?us-ascii?Q?2cWke1CHp+el4iuz+x8YkSr/0VXfQvqPe1ln881PWdSwCeoVwfJvJIiXHLoe?=
 =?us-ascii?Q?qLAVBo4z04Sv4CWyitCOYfT3gxB6c/F2nRr9GjCK9zkgo6VGGZ65MCsEH3mq?=
 =?us-ascii?Q?StMMurxc5CO5/dHTZgHM1bE04pWVdglwmZkIkQMDL7VkGA+4xeJ1A8dWfM5/?=
 =?us-ascii?Q?6Evb5O2quiTw8zdUppSchhDF701QR8h9d179cQTuVh29gNfzMVl3Wq7HrKy7?=
 =?us-ascii?Q?QBtJjtypgASloDie2mIj2My0p9jqdixgNvMrfOOi2/fCLPRkLuA7NTeU/Pcq?=
 =?us-ascii?Q?7qkOT0pHUU8A4J+Js7tCZnoFYGOp1smEl6OH0m8U4Dfd2pWUZD3JtGwpxwZH?=
 =?us-ascii?Q?5WXxgQR2a+NzbotF5w0/BYC0/pK8Xh9PqA4IQpGgbVmXEcsn6OuyVKZQmsvl?=
 =?us-ascii?Q?YRPJtE7GSOYokweWnMp7+1vs7K905ywYnSER9m7hyJF9asNKEreugr3kPDBR?=
 =?us-ascii?Q?dbE2CfM35bdfcCXBWcyZry2mdywhEMSlUCEKZVVGZq9Pbi9cJdx3iCB7Ahtb?=
 =?us-ascii?Q?K2T1WYvgLPkOcs4UywFh5Rm7qsPqsAGuKObP/pT6ONjyqsQNsazxQR+u+ya7?=
 =?us-ascii?Q?seK8U52pah6ZRPLgJX2hBLpCMWXbTZf3X/bmNP/Pt//Rx0C8NcuReAJtp+Y6?=
 =?us-ascii?Q?3GikDPYzplMtJLxcxza5zj+9NVeVQe6huigfWEYV/zk+dnsr6KzVFB5q15VS?=
 =?us-ascii?Q?KUPM4Lc+E0o1GJSd9Ra8C1fBRXpSbDPFDMuB2BH8UVDYrKw6adjQI4wfe+wL?=
 =?us-ascii?Q?5DRB7fHCYhf1hyMVq+lc/yeCTI9YfjFhmsf18JhueqLG5ucTPzEs4JiSvZ/z?=
 =?us-ascii?Q?0EvvmAZfh2AJvttJCVRXlDDN/NuOYK6J5aVSnWkmNwSjfX0LiMW4yt3uK2xZ?=
 =?us-ascii?Q?TtGZILGnReHsFtdqBNGqkDHJc1yqPhXQxanwVWn6EznFy45DIP4acF5bhCE6?=
 =?us-ascii?Q?5hwrK2qShfZoZyCsINtZn/jkgUOVsL0wV5xPdbmdnc0g/N8rIrcRQDxuQ3ym?=
 =?us-ascii?Q?FKupd/R7Mkk4mM4JTd0ju/ZJUhzKp2Nl3XqgRTraSfJFkyCJ3xncbStOhJCt?=
 =?us-ascii?Q?F0GUV0XVPkp7UUEIDSPObJ7Wp6ZP6/pyVTUZYwwTOwmRzjdwl6HFXSenzVze?=
 =?us-ascii?Q?1Y9dbrvcy07Xxl1AF1Nb/tPOQVVJR/ConAP7oGDJHGGaJpCGlXT4GVZcjmST?=
 =?us-ascii?Q?U3B0S0Y2cvCiVsKuEucc3FE7iqYvz6NYdpQPQg4rkZycLWBJwi9siRm6sAkT?=
 =?us-ascii?Q?Kqslp5GRaUbtRTR9AECMSNrXIRNxZp/jT8fj++AIuOUYUx696/lFWPtqqQm3?=
 =?us-ascii?Q?kwyeQZCd3uySaUw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:31.5319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c30dcb8-4802-4e08-b1ed-08dd5cdf3659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

Plumb in support for disabling kernel queues in
GFX11.  We have to bring up a GFX queue briefly in
order to initialize the clear state.  After that
we can disable it.

v2: use ring counts per Felix' suggestion

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 99 +++++++++++++++++---------
 1 file changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 95eefd9a40d28..b20624f8cbbbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1145,6 +1145,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
+	if (adev->gfx.disable_kq) {
+		ring->no_scheduler = true;
+		ring->no_user_submission = true;
+	}
 
 	if (!ring_id)
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
@@ -1577,7 +1581,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int i, j, k, r, ring_id = 0;
+	int i, j, k, r, ring_id;
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -1710,37 +1714,42 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	/* set up the gfx ring */
-	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
-				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
-					continue;
-
-				r = gfx_v11_0_gfx_ring_init(adev, ring_id,
-							    i, k, j);
-				if (r)
-					return r;
-				ring_id++;
+	if (adev->gfx.num_gfx_rings) {
+		ring_id = 0;
+		/* set up the gfx ring */
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
+					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
+						continue;
+
+					r = gfx_v11_0_gfx_ring_init(adev, ring_id,
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
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
-								     k, j))
-					continue;
+	if (adev->gfx.num_compute_rings) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+									     k, j))
+						continue;
 
-				r = gfx_v11_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
+					r = gfx_v11_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
 
-				ring_id++;
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -4578,11 +4587,22 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
 			return r;
 	}
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
+	if (adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			/* we don't want to set ring->ready */
+			r = amdgpu_ring_test_ring(ring);
+			if (r)
+				return r;
+		}
+		amdgpu_gfx_disable_kgq(adev, 0);
+	} else {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
@@ -5128,11 +5148,22 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
 
-	adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq) {
+		/* We need one GFX ring temporarily to set up
+		 * the clear state.
+		 */
+		adev->gfx.num_gfx_rings = 1;
+		adev->gfx.num_compute_rings = 0;
+	} else {
+		adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
+	}
 
 	gfx_v11_0_set_kiq_pm4_funcs(adev);
 	gfx_v11_0_set_ring_funcs(adev);
-- 
2.48.1

