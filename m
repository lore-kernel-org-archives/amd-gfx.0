Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AD8C36002
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 20:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECC410E2A7;
	Thu, 20 Mar 2025 20:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="coZrYmuG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B03910E69D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 20:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRCY8WI9DprpWBGwELieXvajFQYqxjRysiR19pZfYhd2EaCharRhiEL+uESo27qELs84ym4gL1fF9SwftwmQyDEhXdR+nOY24MlO/KNRTHEWDHzP/kPwc1lpfVVxawlBJ3RGALlzL/Hxoez82FM2CbnyEceD4WZ0NrIMo7wyuhD11tFi6Kr62Nxv1JEHhBjVfVAyTHBdRQV95MaxPdUXWyx9MuSCFKCqDsFglyzl3nEGUNw9OyOMAaG391QeZ1fZQxe6D26a8s1F/nDXFCz9L1U1y5pSJbizulvCCLa7WwtMt+VidkGZQ8nyW2d2SCMVDEWj061UydT+jIxXSVeiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcwV/zzh/NgcX1RHGplGS7f7X64cxLfXsgvQ8K5GmXc=;
 b=O6Lzuc9Sx60PjrDE14C8TlIL8Qwd/cDrd2TaFflNRe5vzKYREnAZ4VKE1Z7btT2Ign2w+irN0zF50Ks03L6QgXIYAnQwSm+Q0xLssqTF3kkWg+GN6YkPfoXPXNLWcRgC33WNbycq67i62ROxmR05orTe36PcG4ibl2MvGK1PZZ4HKdtfjpIhNlLb0g6kdk8s9R80zLmFDVwgNz2t5seDWAsTnl8kPAx6Gg+qX8umC9MgKGdVa91e3J2LgRbcfvqQrBlBV924ijNNYH5y13a7JKmRQkCzq48vfXPcQiIjjy2CVtYRgILDfqyqPosFAa/92Kl4TJE60dZM2GoaNgS38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcwV/zzh/NgcX1RHGplGS7f7X64cxLfXsgvQ8K5GmXc=;
 b=coZrYmuGULOZJfkRazcmXHFMmzRBanmle7tPW26JR/91kyiPueLJj1FErTB9nSjIK0lRToxvhPRemgWI9kODjEb+mnmwbX2Y4JwBqhRnEsKg/0OyTPTkFAVKZooHZoT8by7kamPsLwPZf/jYXw64Sl3gBkH0ZJA3PXPPhjuPAII=
Received: from MN2PR15CA0050.namprd15.prod.outlook.com (2603:10b6:208:237::19)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 20:36:12 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::c1) by MN2PR15CA0050.outlook.office365.com
 (2603:10b6:208:237::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 20:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 20:36:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 15:36:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx: decouple the number of kgqs from the hw
Date: Thu, 20 Mar 2025 16:35:48 -0400
Message-ID: <20250320203549.1345822-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320203549.1345822-1-alexander.deucher@amd.com>
References: <20250320203549.1345822-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 11438a61-fbfc-4f1c-0ae7-08dd67eeda69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y34IZB1mAutytZFuxA55OotVg3rqPg2KV3k90vR1mGPFKgryZMAuDc+L9mI4?=
 =?us-ascii?Q?vrTqa8UNMCM+FbawSNeBvnkOyQcZ6oXTBtC7Pth5rABL52cPz18FRfal5q0n?=
 =?us-ascii?Q?wxu+IwsTQH8PVPnXG9g0vKSDhmYcVVtFFkMFbHf8hK2GOpxykbiA1XFgHUw5?=
 =?us-ascii?Q?9/5In4lvbyq3GziJgsuU63p0YzWUOZFaKWVeaji4K6YUFXaIBMDcXOK9vxhm?=
 =?us-ascii?Q?tWsaQFQo+HRx5ETaivzQ2dS4VjfM7H9POPiLSMU1WGOXZc7nkD+v+ALtYtdp?=
 =?us-ascii?Q?1bp9/qWspFElWAKIVpYTlV04VoMDerZRB1sLf6tPwxjHnmT3el34TqmyWUHv?=
 =?us-ascii?Q?PVbTefzlnoElg24b7VFRHxhNvWUwNGMpqAQBdSVNazq2lh5Dw9MunuFUpRAG?=
 =?us-ascii?Q?oTHzkg1vA1gX7YqCdOpBw+aVU7sFU3aCKpajtjX3P+VZKu022ucDMzETEmVu?=
 =?us-ascii?Q?xf1WFKy1+MS8a0+sSILn4v70mecYxnivaWzkNgCkM/aDwyt+VOJk5WZgYclX?=
 =?us-ascii?Q?TRVfwMlMzQ9O4fncsw4g2XYMLJ/9AdV1kFTSPdiCx9ljzFfMiv0ErKfZ2GPH?=
 =?us-ascii?Q?O396H/THLkcamukfpny1iFGqduSs0FGA+MIfl7Zjt43WGK3zx1LaA9bD8hoz?=
 =?us-ascii?Q?eC8SfdTMt/6+osTvjXKvYrUueArmewB+tX3KasTOg04lN+/y0VOcFALEFCfO?=
 =?us-ascii?Q?SPlDbYDx++wgz5nJE2Gu+isoKXntpu9FYOVIpNh0VWX4YCLqI6fan6aNTGgU?=
 =?us-ascii?Q?DsPiqMy6Eiiw+f7ag9ExJMy53UDmzvvZxgklgjnu8HOsv72s1w1llWYzXoA7?=
 =?us-ascii?Q?ZpEx40nHjOpQMPv5ZhGQjSjTb/vWakahSOpmDViJEK2RZbumaFfoC+jjcE5R?=
 =?us-ascii?Q?6xVfxUONd9tA3kLHWM8TDtwCEbur7BJxAjXD/JCE6ywsH+3cqT5LrGDPWutB?=
 =?us-ascii?Q?MWHU1VSG378yET5+YM9Umxp22bPcH4BM+v+64krxn8dYcYqug1ufPWebd1TF?=
 =?us-ascii?Q?Rcc9KfOxtUz3Ykuf3WwJvFGvQi95wzkHAbrGh+GYU/y8kgiMb+eQ+4SPPs+k?=
 =?us-ascii?Q?7htmrwuck4nMJ52Ls5de/rrHOgLA4j+85NjThZHZwZeW/KtszGsYj0Uk0Y5b?=
 =?us-ascii?Q?GsYUe1gbzGwvFQ+xEYtaNKf/7frC3ZcP74tEHjbgOV+5dDpiLi6UM1KXQPA2?=
 =?us-ascii?Q?rHDg7hwIGq5w8f2Ue6KZvX3bSUE/dUjEIW71mFRkPrbrCncKDlwFTFswn5PF?=
 =?us-ascii?Q?W96HU0XALSI3BNVJ7JB93kxDiTd2VK2R/DHO5qFi3zAnyPbC3bCJzkObACGM?=
 =?us-ascii?Q?ER8xAdpj/3HhfOPUsmE1MxvmsD3K5Oxh529dHBZGttKA7QWs5MZLODrBaKcX?=
 =?us-ascii?Q?AwpSxc6ZvsGPxNNPqg0D/z4kjRZg18sF+I3O2AbdQLiizC2D1G/5F6cyjrYJ?=
 =?us-ascii?Q?ETyjwlQkVTNn1nWzzT3786kORdHgE4LrQDgNKMD1ylnyyQWCIJxYW2DClSgn?=
 =?us-ascii?Q?39SOBCFM39lro5w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:36:12.0360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11438a61-fbfc-4f1c-0ae7-08dd67eeda69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

The driver currently sets up one kgq per pipe.  As such
adev->gfx.me.num_queue_per_pipe is hardcoded to 1 everywhere.
This is fine for kernel queues, but when we enable user queues
we need to know that actual number of queues per pipe.  Decouple
the kgq setup from the actual hardware count.  For dev core
dumps and user queues, we want to to know the actual number
of queues per pipe.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 +++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  3 ++-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 04982b7f33a8a..f64675b2ab752 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -77,11 +77,12 @@ bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev,
 static int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev,
 				      int me, int pipe, int queue)
 {
+	int num_queue_per_pipe = 1; /* we only enable 1 KGQ per pipe */
 	int bit = 0;
 
 	bit += me * adev->gfx.me.num_pipe_per_me
-		* adev->gfx.me.num_queue_per_pipe;
-	bit += pipe * adev->gfx.me.num_queue_per_pipe;
+		* num_queue_per_pipe;
+	bit += pipe * num_queue_per_pipe;
 	bit += queue;
 
 	return bit;
@@ -238,8 +239,8 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
 {
 	int i, queue, pipe;
 	bool multipipe_policy = amdgpu_gfx_is_graphics_multipipe_capable(adev);
-	int max_queues_per_me = adev->gfx.me.num_pipe_per_me *
-					adev->gfx.me.num_queue_per_pipe;
+	int num_queue_per_pipe = 1; /* we only enable 1 KGQ per pipe */
+	int max_queues_per_me = adev->gfx.me.num_pipe_per_me * num_queue_per_pipe;
 
 	if (multipipe_policy) {
 		/* policy: amdgpu owns the first queue per pipe at this stage
@@ -247,9 +248,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
 		for (i = 0; i < max_queues_per_me; i++) {
 			pipe = i % adev->gfx.me.num_pipe_per_me;
 			queue = (i / adev->gfx.me.num_pipe_per_me) %
-				adev->gfx.me.num_queue_per_pipe;
+				num_queue_per_pipe;
 
-			set_bit(pipe * adev->gfx.me.num_queue_per_pipe + queue,
+			set_bit(pipe * num_queue_per_pipe + queue,
 				adev->gfx.me.queue_bitmap);
 		}
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0a817403ceaa2..dd7bcf87dd1ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4781,6 +4781,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, j, k, r, ring_id = 0;
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	int num_queue_per_pipe = 1; /* we only enable 1 KGQ per pipe */
 
 	INIT_DELAYED_WORK(&adev->gfx.idle_work, amdgpu_gfx_profile_idle_work_handler);
 
@@ -4918,7 +4919,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	/* set up the gfx ring */
 	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+		for (j = 0; j < num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
 				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
 					continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 182f0122998a0..4ae85d769957b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1593,6 +1593,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, j, k, r, ring_id = 0;
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	int num_queue_per_pipe = 1; /* we only enable 1 KGQ per pipe */
 
 	INIT_DELAYED_WORK(&adev->gfx.idle_work, amdgpu_gfx_profile_idle_work_handler);
 
@@ -1725,7 +1726,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	/* set up the gfx ring */
 	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+		for (j = 0; j < num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
 				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
 					continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ae41c91c9f6a2..4e0327f7be180 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1389,6 +1389,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	unsigned num_compute_rings;
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	int num_queue_per_pipe = 1; /* we only enable 1 KGQ per pipe */
 
 	INIT_DELAYED_WORK(&adev->gfx.idle_work, amdgpu_gfx_profile_idle_work_handler);
 
@@ -1485,7 +1486,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	/* set up the gfx ring */
 	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+		for (j = 0; j < num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
 				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
 					continue;
-- 
2.49.0

