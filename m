Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7487EC36014
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 09:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA1E10E71E;
	Wed,  2 Apr 2025 09:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eWEYvEnE";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F8B10E71E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 09:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgxzsOAdUzX4NDyKU4T0dHUU+BbNfd0dqYqdqRPuPT86sbw7o/vWDVUox4TOFIBNa8rY7iBTflMYSPlw4npE3GzMgZT0RqIJAvwTE//Bblre3nq8Jyv1HuWA41gxZmVqwVbkOO3GTGFXzwHG0h/6ZgK0ojEkbVfXCihWNTTVEaKbo8QFnNKRkxvAdEs+HW7JbRFFSzl9W9NR5oq/KY+1O2+xe+2Y9HTNHiJuFMtLETRV0nuaglXbF9z3HD1ojszMUh12w0gzBKxpBt7jdIQeCpfyCXTKZ0j6KwKKouT3tGI6R3HAnFwZnyGWIO+A7BnSWRtEj/UAVkJ2NAKAdvMO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkCr4M77j8WRZ+NuCm3c6OHAR1f9IWoFccQkxO9Nimk=;
 b=SWswSq4dQRviY5ELPTUlHhh6tTFzIl4d9TEe5j6heTktvQ8AUsv4FtDiAg5Ny9SSoahMoku/Uek6k/S/9X5gZFDZhDuu3VEYsz4N+gnnzaVi51kZiDcOV7UY65wqMlr7a56AS3jLkUNlza2QSexy0VxVEF0imFKUnRGCgxQM+M/xqOue+rHHOoC3H7XerUYl4zG/u5Z+i09mmlxhAmoN1+iF9lEzNVgxihfmJ94ostJJ7OSOpHVGDQ9Q2fGNid4jVQbVTqsDIDPmIk7lBZjBMMj7kCLBBHruFXKd7HrQAM9xu0SmkwsOjaTZiJc43YPcqCkPeQHPleLbCC6GRVA78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkCr4M77j8WRZ+NuCm3c6OHAR1f9IWoFccQkxO9Nimk=;
 b=eWEYvEnEIv/Cyp0+RTVin/ZpO0oUPBlYynXrehN6gvGCX7lSSvB9clqodKdeAT0fhYWQTS+LLPM9uboNty1McAtjBufzJGkJc7puvDhP8EW5bn+4sjHpKs68vKHeMbGWDXMWtPDFUaSOjken5532Q1sovehtuiHssuqg6+DREfw=
Received: from PH7PR17CA0018.namprd17.prod.outlook.com (2603:10b6:510:324::9)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 09:14:41 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::6b) by PH7PR17CA0018.outlook.office365.com
 (2603:10b6:510:324::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 09:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 09:14:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:14:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:14:39 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 2 Apr 2025 04:14:32 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [v3 4/7] drm/amd/amdgpu: Refactor SDMA v5.0 reset logic into
 stop_queue and restore_queue functions
Date: Wed, 2 Apr 2025 17:14:03 +0800
Message-ID: <20250402091406.1641643-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402091406.1641643-1-jesse.zhang@amd.com>
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 99747ac8-51dc-4290-6545-08dd71c6ccdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yicAId8kQ0sBPzQOvGBH//iKHDnH+Q0rPj67W/oUfIII14ZVk3ABjaEKJRKB?=
 =?us-ascii?Q?Pnts/Q13UJyT9neehzN3jqxt6FTYRuDK4hFDVb5KEOxpR8HUtHQyL4rhr5YZ?=
 =?us-ascii?Q?GhcwMCf6Ivf5+WpWfDJdDPqQ1XSg551vgNiFD+zoWzsuy6Ae1o3HxDEBrvYH?=
 =?us-ascii?Q?6bmc2uiiZLrQVBGFdF4MFDNq719rQb+ZHyJAt5UM1SnO01yjBGw+929gGyAU?=
 =?us-ascii?Q?RkOP7O+xUUHGbT7YagSDg5dqOsyZc6Ky/tkFxN9Q5ySaATTAHcmOP7nVNkey?=
 =?us-ascii?Q?5q3ulQ6zKGdEp9t5C13NeQJKosd+9oXkygMj/y2K4oXXPgK50Ig2SipKcfIb?=
 =?us-ascii?Q?PqCY0xWll2m6U60TTl6vf2Qf6Se4xC9C0+GhyA9yIz2MTa/Ms2gSwUGQVGgG?=
 =?us-ascii?Q?J/KSLShdI9nG6mqrW5XmjF2elp/QOsBosAwc64hw+co7HzJ2UGhGJTwgJRlb?=
 =?us-ascii?Q?jlAqNO7VrbMg3TOcdR1sU+42E/BbYGp9MANfdrNZUzlFZKYpgKwPZM9zUNu4?=
 =?us-ascii?Q?ombTCmL2qurcs2j0KwNdWIebbD0hPLWWeyEoCIu6SFiC6h1rUq9bz7FVeCvy?=
 =?us-ascii?Q?xOBnLPDTyqcD6/wwHZwiVrMOC+3wwWka/6WqfGgEZQim39we4606B4o4H89b?=
 =?us-ascii?Q?5AV4PY7VnokF6XwVezuk+KX8RJBz6pyPqa3RReB1xdQD7H0A6p5VGUtKvHy0?=
 =?us-ascii?Q?QXrKAy9H5VleI4MR2WBZ4eW5JixW1oYt5OfAUWYFqA4+bUNBl2xLuIJrqPMH?=
 =?us-ascii?Q?DOhx86WHur0SbuJVleuimSUAsBi9u9tBSJtQ2rJ/3Dq7IUX5xT39FWJwlL14?=
 =?us-ascii?Q?YUzSNYTNJtEI7v41bijTSW5ZF0rCsCTU2tS33mOp6Cuf+7UhjfYrYGH7kBYN?=
 =?us-ascii?Q?zuUbVmfeAPjC4+0fm9yxKZDByx5XdycE/23Opx15WnVEAIS7G1ZVpOjvvh7F?=
 =?us-ascii?Q?iONs7mik9eN4A3FrEja+jfkBtdWfRy9un2jx/NSSdscX/zm30+zbWQWpTzbt?=
 =?us-ascii?Q?S3cqNCdjNgUcc7WDSMEYQk8xt41h1EWYSaGiMirltuFhUn02IMG7WnWKa4r8?=
 =?us-ascii?Q?7Dt3gL6lXjzBev32BMV71xwcOLj0kHnI338oYWub4NfJm1TdDS+WTb/tVSn7?=
 =?us-ascii?Q?hMca49yVcP4jN7R7Em85aGDIEk1RYqol/bp+6sf4rxeP3hFCCBD7GS/Csov4?=
 =?us-ascii?Q?1jOEdxP8j+ZB0RML+/cV11Q/YOIJEpeQscoMJ9bOJ8rE3liuYWvhOWtGEWCu?=
 =?us-ascii?Q?i2jtuuWsotaq4q9X4OC/gqWAKozf/dKrDTQmdEgFXGClGWle1BEmtZ0LwAht?=
 =?us-ascii?Q?/hjTprv861nZpd3AUNpl4lvDWWIIE2FLyQjG917FoY4sFLNSLvs2aSZGOnhV?=
 =?us-ascii?Q?ItzvVq+y6hozQKwPPVQpvjswdcNMR3QCotCU5LRNZfeuu77mmLivPdOZ3ic7?=
 =?us-ascii?Q?luBwKPxf7VE7Lq9U66+WbFwNlQ8rgx9W42OTwoDihMxQeiU0hKxJzX62r0r7?=
 =?us-ascii?Q?bgZ77zNMd3izTXU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:14:40.9531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99747ac8-51dc-4290-6545-08dd71c6ccdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the SDMA v5.0 reset logic by splitting the `sdma_v5_0_reset_queue` function into two separate functions: `sdma_v5_0_stop_queue` and `sdma_v5_0_restore_queue`.
 This change aligns with the new SDMA reset mechanism, where the reset process is divided into stopping the queue, performing the reset, and restoring the queue.

    1. **Split `sdma_v5_0_reset_queue`**:
       - Extracted the queue stopping logic into `sdma_v5_0_stop_queue`.
       - Extracted the queue restoration logic into `sdma_v5_0_restore_queue`.
       - The soft reset step is now handled by the caller (`amdgpu_sdma_reset_engine`).

    2. **Update Ring Functions**:
       - Added `stop_queue` and `start_queue` to the `sdma_v5_0_ring_funcs` structure to support the new reset mechanism.

v2: remove the suspend_user_queues param when calling amdgpu_sdma_reset_engine()
v3: Update stop_queue/start_queue function paramters to use ring pointer instead of device/instance(Christian)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 41 ++++++++++++++++----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9501652f903d..cd2d4c2af77e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1508,17 +1508,25 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int j, r;
-	u32 f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
-	u32 inst_id;
+	u32 inst_id = ring->me;
+
+	return amdgpu_sdma_reset_engine(adev, inst_id);
+}
+
+static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
+{
+	int j, r = 0;
+	u32 f32_cntl, freeze, cntl, preempt, stat1_reg;
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
-	inst_id = ring->me;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* stop queue */
-	sdma_v5_0_gfx_stop(adev, 1 << ring->me);
+	sdma_v5_0_gfx_stop(adev, inst_id);
 
 	/* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
 	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
@@ -1554,17 +1562,19 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT));
 	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
 	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT), preempt);
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
 
-	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id;
-
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
-
-	udelay(50);
-
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id);
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
+{
+	int r;
+	u32 freeze;
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* unfreeze*/
 	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
@@ -1572,7 +1582,6 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 
-err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
@@ -1919,6 +1928,8 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
 	.reset = sdma_v5_0_reset_queue,
+	.stop_queue = sdma_v5_0_stop_queue,
+	.start_queue = sdma_v5_0_restore_queue,
 };
 
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

