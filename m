Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75A8C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 07:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D24510E35F;
	Wed, 29 Jul 2026 07:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4VIzVbmN";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A679110E35F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 07:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtSNomC/IXmJiqTHhD/6pWPWe6cJNkP+7nq2LJMiWCjsk7FK6l/RqaDfF9UmeSm4Ch2hkcYIyxXvItUVsALDTTxzhZSDOqMoG4FqE7vphq4h2i3cg5QlVKn6mRvu5E5c4yxRghBVK7fkZXIjsrTuZHFSO0zj8cQ6VBPKJb95TH5B9E5LgNrydM4YFwxjGMS3XCU9oRhkXIHm5COB0RCdpJUucQa90zJ37vfLpw0LfwjE9r4VyOPXCxke5QaYajHyJQPeRcnTANMcPkL2IP7gA5loWSQ7Gi4TAD/xOZuCQK2mpNvYZNLx7yU5c1ueOO6vctjlD6FA0WoHPNy8gBw6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKveDCJbhfwgE98QBxQuVUayWQobh8doy05qYqw/C0Q=;
 b=RGjte9pHo6EmnHF1e5Ly6vn1V0ZK1PonuBL5J6m4V460y+SUpkGf1eqSMXqbQyFN6+R2Pr9Rf/WPvt+Nb4nd0LWwzGupjz0Gd6d0WvcBishvoVmzsFAd6VY6Klaim4AEXRNe/b5zKcF1AIQGpheYfknC6yRiAdT9TE7oztanNNptSa1vm8LvL/e1zOh10h6gzpnU0r/yaGX4jCnZ8LBdKxiTz37ccNbuTtfLBLX3t2Z2cva+h1rVl1/aOoQiNTQ8hHw5KOuFW3nffdjFpDFKx2zhszKmFPyAMl0079kadKbvFusN6dwYi75EiAijp389KOHjSyz9bqNdo87Xw1lCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKveDCJbhfwgE98QBxQuVUayWQobh8doy05qYqw/C0Q=;
 b=4VIzVbmNtqU+Bu+ByM9ZH9gUiZvDb++d0hsQGmIJGoyC1imMvH9wQLroxQMsy1u7eGpJM/ynpG7QJ1qj8WcQNoqA2oeSvo9JxEEIJkHszCK4Lnj2YSUs/desQ2xAy05lWvnKr2QCW5MrYj7QhdG7QBhLc7Qa4T0YQ0Cf9K4XtGI=
Received: from DS0PR17CA0021.namprd17.prod.outlook.com (2603:10b6:8:191::16)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 07:29:28 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::6f) by DS0PR17CA0021.outlook.office365.com
 (2603:10b6:8:191::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 07:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 07:29:26 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 29 Jul 2026 02:29:25 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, Ce Sun
 <cesun102@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: remove obsolete gmc ras helpers
Date: Wed, 29 Jul 2026 15:29:06 +0800
Message-ID: <20260729072906.14285-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 079cf76b-14a0-4d24-6ddd-08deed431ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 3SGVba6wZNYsZTMqXRKfY21wED98LhcdzmUQByaLHdqQQZkYgJ+PCLmpaRulbjn6wYBrwvwm8l+PiaNyVCC3FOPxiOlwi4crAfJXPsuloEC/CuL7ryZYp/+lTqTgX+1YtNsurUV80RCa+rMInugx+T+WRuQNyk+DugIZkrhlLcUaBhpLuvZpWMiFE70kDq6dplH3+C+rL6+tJ+M6jQzQVeHvy3MGJuxShw/ud4Li9rhFbdy420y5Ldg+Whdkb/T1qD0mBqQKiubNkF+Nsqd5PAyA601wyqVDVlPTj1ikfIVTyWbQpMM6CwGR8qHlva6yAKryN/UhigXrpFVh/sfmbxyyEZmbFEFLY1cy1bSM+0CUOhHRH7rkzbaGC25/Z9ZWjncQqyXuu8DYNG2BEyUgKHyqSPUuwgFU2aDWa6gvGqrBX9iWH9P5fYZYEMB/JjLk9L4gr/2WGcputyh7t4Nuys56NO2Let2sMgRhuEJ0TyElTZJeTAMxtpEMpJIIGbcjuungLE2TQa0xzKxYx8YjkkS6jojrxfIom5Cc0mqKQPz6pBGpjXbW5uKD10FH7kgXrTO4U85b7G8grExxUI+YLrK66csP9fmhXl2gnnVA4+NMiue6ZE9CVGy8zCQhSdSGhSiPl2LybSqRUeh1f6NTlhxb8hcDbvAcJDuEZIA898rK/ImrAIohcLYAxE/33k98
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UQpWmuOmAUTcX07orjLZNG1A0hVKK3L+AyKYpXtqlQ39rDA0CUMcwZPBZhz//4hEMmtNF69/0BqBRSk+xKhTZ8SkEgQoM5PVJNz9M27HJvYipMpnlgEiJ5nvr2whyPP3VzR/tQATEPg9X9EC5vbm2qgY4rNmwrtifRknSd1XbwB0g5yrzu/qlOHgnA6VTVQiVOUUN2CTN5Spzz3ztWCIC6Chx7RdfHMBZFxvCB1UGvj+xgnh1rcN4Ps5KF89XDZk5oPuINnH4hcCZ1RsQ4kA//MHDuWUvjAvZJIL0FrO0Rv3cpJsP53pDBuiLKP2bmqOhXAMOZrwkxlf6rM2kGu8CuiMxxtJ3B+dnoJ77A7vKriYZk4p3x8K0nNGYIldWM9GX8x/YTyv353d6DNFEx9o8GvWQUzzsXZrPbb47xZYKzo7YtfShA3OM1rviXlCl0yd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 07:29:26.8721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079cf76b-14a0-4d24-6ddd-08deed431ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
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

Remove the obsolete gmc ras helpers including
amdgpu_gmc_ras_late_init and amdgpu_gmc_ras_fini
and their declarations, and call sites.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 ----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  4 ----
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  4 ----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  5 -----
 6 files changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3da50132c5d0..3dc8faa091d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -628,16 +628,6 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 		return r;
 
 	return 0;
-}
-
-int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
-{
-	return 0;
-}
-
-void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
-{
-
 }
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 3ca187f5ade8..c0884797dd54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -438,8 +438,6 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 				  u32 node_id,
 				  bool write_fault);
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
-int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
-void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
 void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			      uint32_t vmhub, uint32_t flush_type);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6be2000c8261..c70657bc089b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -640,10 +640,6 @@ static int gmc_v10_0_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_gmc_ras_late_init(adev);
-	if (r)
-		return r;
-
 	return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c40d9c467204..7e612f947349 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -646,10 +646,6 @@ static int gmc_v11_0_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_gmc_ras_late_init(adev);
-	if (r)
-		return r;
-
 	return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 84c93364d220..b05465dc30b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -682,10 +682,6 @@ static int gmc_v12_0_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_gmc_ras_late_init(adev);
-	if (r)
-		return r;
-
 	return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1fcc0594fd0a..119268273530 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1640,10 +1640,6 @@ static int gmc_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__HDP);
 	}
 
-	r = amdgpu_gmc_ras_late_init(adev);
-	if (r)
-		return r;
-
 	return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 }
 
@@ -2063,7 +2059,6 @@ static int gmc_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_is_multi_aid(adev))
 		amdgpu_gmc_sysfs_fini(adev);
 
-	amdgpu_gmc_ras_fini(adev);
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
 	if (!adev->gmc.real_vram_size) {
-- 
2.17.1

