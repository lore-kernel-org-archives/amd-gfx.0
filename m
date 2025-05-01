Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFBFC369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 18:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9051310E26C;
	Thu,  1 May 2025 18:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2CNX3U0M";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2E710E26C
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 18:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQDj06nqv+O3Et7CUulxQGiCYuKTkSJgcFOPN49y0SZECHY7JIa8U91UGH4EfZc4hAFsL44J1YPJSz2t6rlCXEQg8x8NBz5ylYxuEJayV08QG0OV9mhjhmgBwGKSEAJwPJcKjbZLWA2BQ+fDj2QuJ85IaPs989iylJNvY9+iDoQsErVcO2dhGhZW7sqI4ySGOJiVvqbZ1m6ARdUOwzsNST3GFf5YZ6Bryk7tTpCC48AkYsz08n0l+P9IOLJLrwX73aAC3a0j+V3hIXyE5iJ9iKSIbHU2L2jiOM3SnRttrAomGJSykRqczIlm2ngDEFGdq+WrVQRkPPsFavkmzfFgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDvc5EvJGK4J10WUJMr3FYMFJiro06zZPH6B3YSNs9s=;
 b=GnyoAX/VLVoVtBh0q6jEJiR2Q3hzZnTKPua1ujcDCjjIqpq1tdDlTfNHOf8aVBxTlPob3V295GxYzRHQHRMonUCFiLPzMyPVc/gMu8LsRS3BUPnuUj1zZQYvKM9xMLTHI1XeCx3Q2G7xUJ1AUdpjD24LnAVU7j0Aw3b8D9uM9WsDb1oTkgHTnbNqVomrwltI+eNr5bSHO7oSciHcTc5tu/PFnEvn9FDcCtaCe+wh5s/IfIWZz40yGemUQ2NIvElMJdSI4MYMQpDfCuTWnnJm3q+EGzF3VdNPWVTa7Ztj2Jcds1jOVEjPlvFrxT04bnAlFr5WByls/2S221JZ0wVxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDvc5EvJGK4J10WUJMr3FYMFJiro06zZPH6B3YSNs9s=;
 b=2CNX3U0MJmK3goUKbM9gIkoQJmPLUP9puP4EgTa0Y9MeC1/r6jfaMrOfdo2T5y/tgZ+P8AjAB3PuPlxxyccwohHuQWLYyI67kyIhLvXcLqtcWUZWf1ZhjsUBtwVzeOKAZ0KjcSSXjKqoksmta6RjBB/oD6x+rNFkLjDdW2YBNCU=
Received: from DS7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:5:3b8::19)
 by CH3PR12MB9729.namprd12.prod.outlook.com (2603:10b6:610:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 18:04:13 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::1a) by DS7PR03CA0014.outlook.office365.com
 (2603:10b6:5:3b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 1 May 2025 18:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 18:04:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 13:04:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: stop evicting resources on APUs on suspend
Date: Thu, 1 May 2025 14:03:57 -0400
Message-ID: <20250501180357.4103402-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501180357.4103402-1-alexander.deucher@amd.com>
References: <20250501180357.4103402-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH3PR12MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6234c0-e134-4d55-b5c0-08dd88da9495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HWFg7hsN7F06mrHx7IIbQItieuCcNV4pJS7eDC3fIDOhixhp/ZLzYaqnCt3O?=
 =?us-ascii?Q?kQJprHLivwuq/6EMumvsnvIGB4WVRclAFMg+iFAblBExDQOyzgflKPuQiFRz?=
 =?us-ascii?Q?M30+vfo7twcaN77WlMpsdKkBiOWfqG4BvtFiAI5iG98S4qYVvXtpRUN8pNV9?=
 =?us-ascii?Q?78x97VYPGgHXr1swVgSaubGdiJQV0Y/U9YF+c/x13GNIv4GBrGqW7cXq0lOu?=
 =?us-ascii?Q?tSM5F4BdKkw4V/Z8tAKL/2ln/BoiHBYY27w01Rug3u7ZhghgdHVR/2hBnuZi?=
 =?us-ascii?Q?YzLpL0XWhe7FRn59nvkHGwKE7Kq3R695e7csmMyhTFWPYxiFePko4ClvT7+E?=
 =?us-ascii?Q?z31eRK3vP3+wUENbnb8os8aJgt66zY4Lz/quhRVz+e6WDogSsWWA3E8ZUOu6?=
 =?us-ascii?Q?4NwLSHOzNuYh+8RU/8YOI979zqkqgRb/7tut6QHK/DFpVQBrObLcR8eI9ao8?=
 =?us-ascii?Q?EKTBFvZN3E+QmnDWDawj7abgiBnrRC+uQx+ApEMu7S3x7n5gACrlGgNGn+m5?=
 =?us-ascii?Q?BOkXH8tVXdVnSSMWd6pQss5IZ/0foYkxf/U3AjAkY3z4AFSX0Zs1kfU/PRAd?=
 =?us-ascii?Q?925aiQ5KKfTfHsWrZWEYaqueIw22Jh8DDKw9EoR6HL6ifDktJDcuEYx/Pbyo?=
 =?us-ascii?Q?5hfgCLXu2XX2vijVIbSyc8Zf4U2eEXQ7vJYWQyDWnXIB3ckPzky5Gaf6TgOT?=
 =?us-ascii?Q?4jgrbBp7UAwp9q441W/YNd7DDpBLv0+bAZFfwYt91mkG2J+xJolsPYuy0IBf?=
 =?us-ascii?Q?w/FQWeDBTO7xFGecaF29oz9A8SWFsTjTeLIHis5ubRc6psG5bKkac7jq7oBR?=
 =?us-ascii?Q?necU9NCQNyvGhTD4T+8Rd0u+/hND2bhS7FpZeTHrn751z2sck5r9yjtc6CuQ?=
 =?us-ascii?Q?IUSE/NzZl9SSA1oHrPr8MwMYuDnh6zQmt9Wwfm6Ea+Tt7j/ynUYSjZr4uDoV?=
 =?us-ascii?Q?7qjvx9vEBcaAVZHXjew12ZLaam9PfU8vYBY5aUZdrlgeCviywBkAw1Wuxuc5?=
 =?us-ascii?Q?VQViwHXmETH3+UlPhv8fBrRrR1OIzUjmXOkth6mWs9pjK75S2dUCzlOEIjg+?=
 =?us-ascii?Q?cm8EfR0DRBPfC0zKSpoxUiyGf1H7MvSb71S4G+RY16hZNgYCIpLhyTHlBPBX?=
 =?us-ascii?Q?ikaaBSjU51sYGGqtbUW+S14XndRsd2wThWsVrBfCAVV6LYQ+aQLVulXeeXwx?=
 =?us-ascii?Q?WKUvrVrYGYhw4wJzfGRHcvyMrKi6EK6rPZG91clIsK46A68srxn11iqqG0A8?=
 =?us-ascii?Q?mkKtdbywhyObY47uMZ5vBuMizqXbVIlBr+T7B7kTHXY+dYs1XNQyTRYZWzsT?=
 =?us-ascii?Q?5y0fjEm31ZSumVDXwUaey4Zb9DxotveAG6sxY/P3tKPJmM1xp8C3Oot9ZgEg?=
 =?us-ascii?Q?prmZwbRfR4i+jbhffXwLnvsqhv18upCzPgsW6ya2VMM03zy1Q20fRxoUG3bQ?=
 =?us-ascii?Q?hjCdNOMCtok03wuUWugmOeTMVWIbOZSqAc2aUIOup2AtgS4/veI8sw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 18:04:13.2097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6234c0-e134-4d55-b5c0-08dd88da9495
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729
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

Set the s3/s0ix and s4 in the pm notifier so that we can skip
the resource evictions in the pm notifier and pm prepare
functions, then reset them in pm prepare so that they
can be set properly in the suspend and freeze callbacks.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 15 ++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ac7bd5942d01..a3e9f289e37c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4919,8 +4919,20 @@ static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mo
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 		adev->in_s4 = true;
-		fallthrough;
+		r = amdgpu_device_evict_resources(adev);
+		/*
+		 * This is considered non-fatal at this time because
+		 * amdgpu_device_prepare() will also fatally evict resources.
+		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
+		 */
+		if (r)
+			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
+		break;
 	case PM_SUSPEND_PREPARE:
+		if (amdgpu_acpi_is_s0ix_active(adev))
+			adev->in_s0ix = true;
+		else if (amdgpu_acpi_is_s3_active(adev))
+			adev->in_s3 = true;
 		r = amdgpu_device_evict_resources(adev);
 		/*
 		 * This is considered non-fatal at this time because
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 24ee4710f807f..7814ee7eca221 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2516,22 +2516,30 @@ static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
 	if (amdgpu_device_supports_boco(drm_dev) &&
-	    pm_runtime_suspended(dev))
+	    pm_runtime_suspended(dev)) {
+		adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
 		return 1;
+	}
 
 	/* if we will not support s3 or s2i for the device
 	 *  then skip suspend
 	 */
 	if (!amdgpu_acpi_is_s0ix_active(adev) &&
-	    !amdgpu_acpi_is_s3_active(adev))
+	    !amdgpu_acpi_is_s3_active(adev)) {
+		adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
 		return 1;
+	}
 
-	return amdgpu_device_prepare(drm_dev);
+	r = amdgpu_device_prepare(drm_dev);
+	if (r)
+		adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
+	return r;
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
@@ -2603,6 +2611,7 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
 	if (r)
 		return r;
-- 
2.49.0

