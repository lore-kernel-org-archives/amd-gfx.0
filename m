Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16515F9B5F3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 22:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A2610EAB0;
	Wed, 22 Apr 2026 22:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w+301imh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF9610EAB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 22:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBMkmIkfUFsgcGezngbicECqT31QPocN7Z0U9iG/xrPI67uaZLffBQUXJdyM5Sie50sdgDNCSVKlXSdpl+ZTasRxaYGdGh7by2MITfrmnbDfqwjZFdbE3pgi9X0/xAZsggRuUP5NQdR5ZO1fbkQ9pCF6HhFuhRDpnoQG4YcKTQkMmgDLBsIHYD90f5oT8jyIEj/qBRANfhlGmM7lfehntyRzcm/q+yaT14fcw5soDQvclfr3+tlDFoI3EWHHIwLmiCtC8G2DQ3PByL7ED7Fbz2mHN6nYeSMM0P9rXFe1ZRAd6SqPuiERQQrE7JBK4XKJZE2vj1CuDY2xtqKBdC6LTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EI1HaUSmqfoNrykDIWZoEEzHo4A52EaITVa7jkRugUc=;
 b=bc2mKTdolfq+4N7vFxUl4zxvreH8tGetPrrxx7ztIQpuWStPNIBk9RWqblJN4YJCelzcDehAujaWUe6AvO/h2RvH707E+aDsuVX5aELOWHbZQsO8nIbNswcBh7YhF9Y2OwE4onyNt2036eddhjvM/SD+Q5pzFG8WVy35nmoOY1V0C4Z+Beu3fmrk5q2fi8NLjZVcf7nqmOvSx2bF1i1+sCut70S2yf+ltgSEU0eFI6zS9NCQhakTPo4B9aWgPsiZiXBNCnNQDeWr81H0125IizoGTeJh1f0lnB86v+g2DcZGtGzozLZijgEzMgJ7Jos5uMW5hlfYsyDD6HYCegBthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI1HaUSmqfoNrykDIWZoEEzHo4A52EaITVa7jkRugUc=;
 b=w+301imhHQdlP8Wz6lcNatRNUhU3DADlnz/CINSrrnIOcsS1qUvB1ogg5rbPH6r7abxvUcb6l6QKcTrjIYax6KAcp/jYmF/m7CKfZsCbIDaCC5fonHCS1TKs7mZrcjgBu0o/JKR4LRrBNM3mXhQ/+z5HoxvnbeNgih7wqJqIPy4=
Received: from SJ0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:a03:331::19)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 22:06:24 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::f1) by SJ0PR03CA0074.outlook.office365.com
 (2603:10b6:a03:331::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 22:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 22:06:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 17:06:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 17:06:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Init mcm_addr look up table"
Date: Wed, 22 Apr 2026 18:06:11 -0400
Message-ID: <20260422220614.2259600-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 461d75e5-33b5-4c56-46e5-08dea0bb6435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: KXxiwVuS1bCrjYd9FKoNutdU2lyIq1JAytqp7U23v6xF4hXnrqGnvUR6wwqE86qTiibdXcinHvh00GdEbDMCr6cB357JqRQ8myk1quVHYqhjYUVGbW4EWQKgXU9/SZZ2jwHhvoI2iE/KrFX0/StFIrWESkBsd14CAsiZBsNJ77KqLzTOKm3DYanwNTp6D7DVnU7cHPNZ+ElmTFCepG3OZgchPKevr7+7aVUgVXjGK4yCDPh3tQY+wnlV8IHxc0C4TAknbgXIFif3CYWWdYVdrphrsT+spM03y0+nV19rib5zEUaItzdt7vSDcvIuobSykkg3IU2wNz0tVTtHTsMrWM+oT0DLaNyp08F0ViAD5OhpafvAXONBLMIvy/c6EmZB/R/PxSWw0drxvT3V9VattqjJt1rKjBeB2V7MAi4pz2Z3pn+oLmjHHnBo1k1/erkd0QaAi1suKgkNnphqdITK4W2sN6vWG3chlcGTtIBFhMWNFzDfcnarKjeOHQmnVc2AGYSyp0bI7u92eDoRI9bdpWfmBjmv2x/7+71YE9fEHlrb/tSwq48yD55nSPXdQVHb+eJ69T/0RWtBHjJnFqSoUADN19b0bz/qL+YbiAbWkz5Xi1RhgjVQ/T16OvfW3kY827uDMYE0Y2LX6TBULcdeDsYr/wklTPcWIpcu3rew4iG85NjOF1+hH2dCltSjPi7Tmgvj/l51GvstjBmq3uhP7elxsa+bMr2VNIjD9z2d8kCJIIaxDesa0ZkVXHZfaCeKtimr9FXvKmsoyEPZH+YWEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bhO5/tms10C4YLaBIRk8/BmBWUCv6GSOl5xkwtrj6oJ1ZdEb90WSeaDWiM5mv4KHOIswZm50ToE2qbcRpKu4hgE7cwUb97xnXCfqWNL7g6w/QYXtvYCq+FeEuQBN+BSf8k/AZMubw6vDYj5PkIPWq36X2DhUkaChbmhg7LEtlBrIpGK1d7FJaBYjOyivLO4LfKpcxpPRiulcOWJ8L+45kxFswOwFGnpBMDG8bLqAGKFwoNGcB8aj+tIc+O3E20VJHasnot9KhSajTxk3QWtmX+HkwwgXAhutWpIsb4GH4PFxyYY9jCtXf6mhD+F1raRbV1q/hbP7vVM9dN27zNJvwvybMMQAwSSqCeC+YGpTHUROHxBnvaCigp3V/x4L+9dLMTnehWJNPqB1BvEcPpfeiLIcUHbIvchSoSMTorvwBTiNCb8sJ1DloKds7UzF8yoe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 22:06:23.2990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461d75e5-33b5-4c56-46e5-08dea0bb6435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

This reverts commit e7820045fde15d25b5b2706f03499e0cb9ae778e.
As vBIOS add the support for partition switch programming.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h | 1 -
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c  | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
index 9c56be725ff3d..eb8537558f5fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -39,7 +39,6 @@ struct amdgpu_imu_funcs {
     int (*switch_compute_partition)(struct amdgpu_device *adev,
 				    int num_xccs_per_xcp,
 				    int compute_partition_mode);
-    void (*init_mcm_addr_lut)(struct amdgpu_device *adev);
 };
 
 struct imu_rlc_ram_golden {
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index 539785a51f69f..8e33ffcdfa4cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -153,14 +153,8 @@ static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void imu_v12_1_init_mcm_addr_lut(struct amdgpu_device *adev)
-{
-	/* todo: fill in when interface is ready */
-}
-
 const struct amdgpu_imu_funcs gfx_v12_1_imu_funcs = {
 	.init_microcode = imu_v12_1_init_microcode,
 	.load_microcode = imu_v12_1_load_microcode,
 	.switch_compute_partition = imu_v12_1_switch_compute_partition,
-	.init_mcm_addr_lut = imu_v12_1_init_mcm_addr_lut,
 };
-- 
2.53.0

