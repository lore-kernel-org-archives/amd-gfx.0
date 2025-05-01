Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90534C3ABA3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 20:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF7710E365;
	Thu,  1 May 2025 20:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4cvV+fv/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C054810E365
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 20:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg+T7VSzhecPSapnr3b3tZjqy3ghwmzRpcWBeB3N85FiXuShW9dhAekbcngjptHmjbaYjgTBKU1n+X9T6bb62Ms9Ba1UouraUBL/8FGyo2Wbw3wC5PO2Y7jmN4vVNGqW+BfulCyoHIdbrhv9U5kw2BYIwPYrGL9fZ8JCKHCcuDDfw44j7z+Fsp19loI4/GYWHJ+Wd/stAM9sS02wUPL+kgh2CwBbJQq9c5eJWH0OiZEn8GrPFTqS11eADFCVpHdSRDDqwghT3vfmRERngfeWeAn5WXztmHgxAfyNUvWzVDEU9lYicu3RLkvIe7nc8Ipjyi+36iN5mHwXls7+zUN1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJSgzu3h1mwaXqX5Z6akjxyTYWInyKlvI0BtkDoalUE=;
 b=oJc/FOAkhRf0n2Nu6s2Fxi+b9B7QT0d9IPwd2JKTh0Y1vkZoQKAarHKlnjr8lPSV/fkEe8NE7SGJneyQ7ubV1FGC5HXB6qHV/Yk7AVcX07K5JRSk18yQcQssX/CICIu3pOBXP8kxIaUuduqvTyI0/Oj0/ThEJQjgxAC3Levm5CHnDwHp4Xj9CUcuPXFR3JbE/LQXXSihk+20XeK3p8MyEv/jSJiC9boAUAQ4oUg4AvsiKeo9qkhc/bTItPtCLHVwgG/mdCM5r/5JGb9w7zptXIYEWpvhUlarbNOluhRzb4KBtDtDWfhyRM50Ua92EBdm/CD5S7l6TsiQK3HeaJYHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJSgzu3h1mwaXqX5Z6akjxyTYWInyKlvI0BtkDoalUE=;
 b=4cvV+fv/eXhM9ROF04ECakA0Jw9x578nBDTS++jPtnyJV8FJapM+H+WDy1Etvofi7mj2Ww8TshFX7MV47gkO27nrwb/9z/oqRxPzLsI3xcse7UimEsNWmm+XPc1UsW/42/56lYh0Mm5SbuYyl3TQj0GKJYhKlNFN5+bABCtHvi8=
Received: from BL1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:256::8)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 1 May
 2025 20:10:00 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::7d) by BL1PR13CA0003.outlook.office365.com
 (2603:10b6:208:256::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.23 via Frontend Transport; Thu,
 1 May 2025 20:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 20:10:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 15:09:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
Date: Thu, 1 May 2025 16:09:31 -0400
Message-ID: <20250501200931.358989-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501200931.358989-1-alexander.deucher@amd.com>
References: <20250501200931.358989-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fb3fc1-74df-40f3-fe6b-08dd88ec2732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yONA/avxLGnOnAs9tKFIIXwF1+it4xQnjdOxUBrp8hohJ3UmTLkw0Em+DJDG?=
 =?us-ascii?Q?34zzhlmmeNSEMqaeNdXu9IIi08vg73gAZiYTkr0hTHd0PhKW9H0OftmQVlHb?=
 =?us-ascii?Q?4UZLWOerCJSWL2GS5JhbBq8PWvFIwd2KR+O1AlkPSvsvfuMUlnVlHRzB+vsu?=
 =?us-ascii?Q?vJ9ZqXomWEkzWJp8HqvdKDehy6yByXvd/+5ERA4gzTvx0A/jJNc4Cov7qQtJ?=
 =?us-ascii?Q?ylZs/de7Z1MRaNIZvePCrwTnhAWlAxQCoJAUdwDfmCXdtMPLSu5/jIR6TwgD?=
 =?us-ascii?Q?3TTj/B2Q8gc8D0RoOv5NvP+JUY3pSQ3oQA/MDG0UlMio49uOi56outIiTcBf?=
 =?us-ascii?Q?ZRyNcte2VrFW8roAredfi6fr3RBh1e6X/CrgSycz9GkpEPZ92NzAzYIRTbLj?=
 =?us-ascii?Q?Vxh368FaxQfRxN5+/EK+MMLN0KlsGp1FZfS1TbmeTeIxHWHydu5Oj0iDVy/s?=
 =?us-ascii?Q?YpiD9qxklBqlz7aLwjgjb7b5UIBpK2Ox1GSXiKHoBRLMR6BD8a4amppENIVT?=
 =?us-ascii?Q?qYwPp0G5v4WPQCygM2xFg9OcFvKwQKG3bRKMlpk6JqdpY7l4cH50fcuTGCxl?=
 =?us-ascii?Q?GkAdkwr/xy94/bS4S+oirlGQFiPhKd6BrVRdWwWq77zCJ6ClKMF+XKN9Zq4e?=
 =?us-ascii?Q?g37UW1flebDRy6CQP0aGP7ofI/s4YqGx57BRh8PQxW/J2CdIK5KeY2qHfo7G?=
 =?us-ascii?Q?f6+JcXFbzjMYn8OuEsHubTkCbyGStfc49vDuYj/9QHWt6FpU3F7Wy5a15bBt?=
 =?us-ascii?Q?rCiQB6s18C6pTxBtDekf28GIU4Qw+Cazcwo6f9TAD/jP5zeg6G8xEIpCRje8?=
 =?us-ascii?Q?LgpUudrUGwZv7swQ2fs+ao6XjfbsaAPeT9yc9cHRtXTKThZIfdwXeiFO4PIl?=
 =?us-ascii?Q?/IkWm5A5mQbMXAW0uuHIiamupcG+s6kqjQ7rb1TxF8Wp9YFQYF6udfCoKjhh?=
 =?us-ascii?Q?7tUFr5Bqa7hoTtXi99yO2pVqKiyVKf2n43u+PWvwJ6wZNmugl78W3bN/PVga?=
 =?us-ascii?Q?fZOgPgYu2Y0iA5Cx0wGl6ENxCemFGP0MtHVWS+5SC5+btvxGATBk8cPuryIV?=
 =?us-ascii?Q?b/didPi8ZKvSt34fD+TsQDFbvWA/mTa8wXA0kP9UDpgb0vjCXZUQeUSmR3br?=
 =?us-ascii?Q?t6wTc+1XPB8+bFka+yRDtBI+nxflrpv0Te11wkR2x98jxUoYmPieJza3md7k?=
 =?us-ascii?Q?q3WxflWuKE2d9Y0G2dKm3+bY/bDswYed7o5fvGiL7vohI54BCz2qwGMDvutS?=
 =?us-ascii?Q?l1DbOAx9RxcmYy+YLyHSdlcY8qCSRybDc+D8UKdowK3ua4zOp2X65lL5WPyc?=
 =?us-ascii?Q?s+HQQu7/oFDNFESR9icdrD2fMfDiGfEWULCtJmTTV4rl6UicNs8edyPtg1RC?=
 =?us-ascii?Q?D91r2OcJpM6pE5sAKx1BO01Y3Ut4+AcoYXZj2KBCf23xT5ZjMBGWmcTVkIeH?=
 =?us-ascii?Q?SvsYfjdKDfuHExcUpp4rv30ftNTy89FZDMawQgbRaF5h1EybN9GLFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 20:10:00.7347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fb3fc1-74df-40f3-fe6b-08dd88ec2732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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

Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
the resource evictions properly in pm prepare based on whether
we are suspending or hibernating.  Drop the eviction as processes
are not frozen at this time, we we can end up getting stuck trying
to evict VRAM while applications continue to submit work which
causes the buffers to get pulled back into VRAM.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 22 ++-----------------
 2 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71d95f16067a4..d232e4a26d7bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4974,28 +4974,29 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
  * @data: data
  *
  * This function is called when the system is about to suspend or hibernate.
- * It is used to evict resources from the device before the system goes to
- * sleep while there is still access to swap.
+ * It is used to set the appropriate flags so that eviction can be optimized
+ * in the pm prepare callback.
  */
 static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
 				     void *data)
 {
 	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
-	int r;
 
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 		adev->in_s4 = true;
-		fallthrough;
+		break;
+	case PM_POST_HIBERNATION:
+		adev->in_s4 = false;
+		break;
 	case PM_SUSPEND_PREPARE:
-		r = amdgpu_device_evict_resources(adev);
-		/*
-		 * This is considered non-fatal at this time because
-		 * amdgpu_device_prepare() will also fatally evict resources.
-		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
-		 */
-		if (r)
-			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
+		if (amdgpu_acpi_is_s0ix_active(adev))
+			adev->in_s0ix = true;
+		else if (amdgpu_acpi_is_s3_active(adev))
+			adev->in_s3 = true;
+		break;
+	case PM_POST_SUSPEND:
+		adev->in_s0ix = adev->in_s3 = false;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cec041a556013..6599fb6313220 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2572,10 +2572,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = true;
-	else if (amdgpu_acpi_is_s3_active(adev))
-		adev->in_s3 = true;
 	if (!adev->in_s0ix && !adev->in_s3) {
 		/* don't allow going deep first time followed by s2idle the next time */
 		if (adev->last_suspend_state != PM_SUSPEND_ON &&
@@ -2608,7 +2604,6 @@ static int amdgpu_pmops_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int r;
 
 	if (!adev->in_s0ix && !adev->in_s3)
 		return 0;
@@ -2617,12 +2612,7 @@ static int amdgpu_pmops_resume(struct device *dev)
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
 
-	r = amdgpu_device_resume(drm_dev, true);
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = false;
-	else
-		adev->in_s3 = false;
-	return r;
+	return amdgpu_device_resume(drm_dev, true);
 }
 
 static int amdgpu_pmops_freeze(struct device *dev)
@@ -2643,13 +2633,8 @@ static int amdgpu_pmops_freeze(struct device *dev)
 static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int r;
 
-	r = amdgpu_device_resume(drm_dev, true);
-	adev->in_s4 = false;
-
-	return r;
+	return amdgpu_device_resume(drm_dev, true);
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
@@ -2662,9 +2647,6 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-
-	adev->in_s4 = false;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
-- 
2.49.0

