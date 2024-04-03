Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CE5C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 02:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 641D410E8D3;
	Wed,  3 Apr 2024 02:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h2BLAWgv";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E63710E8D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 02:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9YwMzvJ8n5SxsCw3LCYOexgwHlGqs7+KeIg4fAcd0THe0nWexT289ZW/G8/tisFU13WTVcBh1nZ78bTgoE9JOITIoVc3DxATDmkZbu/6i3W+2mi3kaCkCH+MKtvun0dTn/P+rCdRVxNjtPOUIIe6koySfCt40rDyia4W7bOLPTFuj7zbeJ/iKLxTiG44r/YM6Fl762o6cpY+nBrVduVnSihrqcJhumy7v7OBeNAtRbC/WOUzzV8yuvvFqza2OXKeVaSUztvzxa9UGqCEQjk/Py+00P4hQfRwG8rUbGW6G84JbLxZ27OtFA6Wn6LDj0nJQeg+lKwS0sDdmQf68px6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7en3ZJKGiBehKsjgMYldaGBQPi60fLVDAvHj78r1XE=;
 b=lDKtKc+edwEXtXz/tjbQBuRI77is5eASyagaFlUVICBRZC0yZRXNsMke4w33f0SnMmuovAd1IOQNCDtu3lKsIUuQuiqxLYBHWTuDOdoNDCf0lQI6GFIWQ7k5GP89ktUd/0C16YpUus6NFbE/HXEJea3Gmh2G7RVGxVMjzk8645Rr5frFLJn+Ou8inPsrmKax+3AADOIJO/5DD1IxbkN+C1eJLEkdDcK288nUvgXmGHCiyEXANZD2Se6OXFEAu+ufjSbHEUHC9IuiJvZPd56uX+Ijk6BAxRZLV2QCggKyMk0Vvi0HJFL0PTlDU/ZI+ewKpasB1zjPU3HLIu1FtQuNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7en3ZJKGiBehKsjgMYldaGBQPi60fLVDAvHj78r1XE=;
 b=h2BLAWgvrudhFRe/mfdAkuuQFbE6Qs21SQVT6Hzb5+4WpHDwYezXLiqqLFWZluFlsZ73MgKOBKNPz22xCvyOIn3wZnbLRNCr3xtSfu8Mdles4/tNBZdOtd4yTUsnnSIC2jLa3th828x0RrfRFm3OFAkjAtdgWjenCZ13kzT1E1g=
Received: from BN0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:e7::28)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 02:57:45 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::af) by BN0PR03CA0053.outlook.office365.com
 (2603:10b6:408:e7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 02:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 02:57:44 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 21:57:42 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2] drm/amdgpu: refactoring the runtime pm mode detection code
Date: Wed, 3 Apr 2024 10:57:26 +0800
Message-ID: <20240403025726.3198006-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: b78513db-77b1-4c57-7bad-08dc5389d63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfz6NK51qfvRrB6rVQnY3neA0xXGCYgOVF+/ajG4Byti1dFwRs1bYODYGF2unmVWhYzVT9i0ANMaUQL9yVF2AxwTvkUDpbSLNya25B5n1ltS9agjeijLHSrt/V6GCACqRcDDIihErvqi2OBsACaDcz13SO5V9HP/2d24ps4fjg8YujK3WnIPpSMTB/0O98uUtWEFCcXBTTg41Z0Zglc8M27DhEJrjOVY/V3OikYY/jjJ8fI5loLO2fDp0Maz4yQEewu+jG6lJ4/4Vak+b1mou8XK5irOe6r7d/3xjhtGYVqjoVCccu7fqkz+/1MxNISUUypG8boy6hZcAzxl1h30Mcez/wa21D/5tSV21QG1b3PFOf+a5SKE7LpvJlKQZZGuxUqcIXxelexR2zhs4o9pagcmp+eLrYR/owljWiR9XB6RR4dq+fdUFKC8Pv4CHEj53SQJb38u/em0r/2V+Ht5JYRumwBuVAUgd51Vu5hvFcf+Tb8WKYznxyObu9H6T815TyjxkNq9htLFWwrBvCbNMcHxi+LWmyx68L9BJFC2BXbs2PasIpBoc6dDw5rcJXZD3hTroWwMscHlanIIhdXJWZvSIjb+CIDtOrUjHprAguQnneK+TQFsy67b4EpDhLgCYOao2z7NUSE4LB4KvxP8NObFo1FKnDy/gHe2vRTyd7iAQPZwKEBnHLhvrm25b6lXhBL3Y+LuG9OJpBKa3JAToS3xmyuozt1tntydbGcdAq44rJRM5olvIcHOOfRui8vK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 02:57:44.9081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78513db-77b1-4c57-7bad-08dc5389d63a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

refactor the code of runtime pm mode detection to support
amdgpu_runtime_pm =2 and 1 two cases

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
v1->v2:
- Fix logic and output info (Lijo)
- Fix code style (Kevin)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 75 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 48 +-------------
 3 files changed, 77 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 65c17c59c152..e0d7f4ee7e16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1409,6 +1409,7 @@ bool amdgpu_device_supports_px(struct drm_device *dev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);
 bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
 int amdgpu_device_supports_baco(struct drm_device *dev);
+void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev);
 int amdgpu_device_baco_enter(struct drm_device *dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f830024cffca..2ea1f47df79c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -350,6 +350,81 @@ int amdgpu_device_supports_baco(struct drm_device *dev)
 	return amdgpu_asic_supports_baco(adev);
 }
 
+void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
+{
+	struct drm_device *dev;
+	int bamaco_support;
+
+	dev = adev_to_drm(adev);
+
+	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
+	bamaco_support = amdgpu_device_supports_baco(dev);
+
+	switch (amdgpu_runtime_pm) {
+	case 2:
+		if (bamaco_support & MACO_SUPPORT) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
+			dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
+		} else if (bamaco_support == BACO_SUPPORT) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+			dev_info(adev->dev, "Requested mode BAMACO not available,fallback to use BACO\n");
+		}
+		break;
+	case 1:
+		if (bamaco_support & BACO_SUPPORT) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+			dev_info(adev->dev, "Forcing BACO for runtime pm\n");
+		}
+		break;
+	case -1:
+	case -2:
+		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
+			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
+			dev_info(adev->dev, "Using ATPX for runtime pm\n");
+		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
+			dev_info(adev->dev, "Using BOCO for runtime pm\n");
+		} else {
+			if (!bamaco_support)
+				goto no_runtime_pm;
+
+			switch (adev->asic_type) {
+			case CHIP_VEGA20:
+			case CHIP_ARCTURUS:
+				/* BACO are not supported on vega20 and arctrus */
+				break;
+			case CHIP_VEGA10:
+				/* enable BACO as runpm mode if noretry=0 */
+				if (!adev->gmc.noretry)
+					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+				break;
+			default:
+				/* enable BACO as runpm mode on CI+ */
+				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+				break;
+			}
+
+			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
+				if (bamaco_support & MACO_SUPPORT) {
+					adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
+					dev_info(adev->dev, "Using BAMACO for runtime pm\n");
+				} else {
+					dev_info(adev->dev, "Using BACO for runtime pm\n");
+				}
+			}
+		}
+		break;
+	case 0:
+		dev_info(adev->dev, "runtime pm is manually disabled\n");
+		break;
+	default:
+		break;
+	}
+
+no_runtime_pm:
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
+		dev_info(adev->dev, "Runtime PM not available\n");
+}
 /**
  * amdgpu_device_supports_smart_shift - Is the device dGPU with
  * smart shift support
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 5d1b084eb631..924baf58e322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -133,7 +133,6 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 {
 	struct drm_device *dev;
-	int bamaco_support = 0;
 	int r, acpi_status;
 
 	dev = adev_to_drm(adev);
@@ -150,52 +149,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		goto out;
 	}
 
-	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
-	if (amdgpu_device_supports_px(dev) &&
-	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
-		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
-		dev_info(adev->dev, "Using ATPX for runtime pm\n");
-	} else if (amdgpu_device_supports_boco(dev) &&
-		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
-		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
-		dev_info(adev->dev, "Using BOCO for runtime pm\n");
-	} else if (amdgpu_runtime_pm != 0) {
-		bamaco_support = amdgpu_device_supports_baco(dev);
-
-		if (!bamaco_support)
-			goto no_runtime_pm;
-
-		switch (adev->asic_type) {
-		case CHIP_VEGA20:
-		case CHIP_ARCTURUS:
-			/* enable BACO as runpm mode if runpm=1 */
-			if (amdgpu_runtime_pm > 0)
-				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		case CHIP_VEGA10:
-			/* enable BACO as runpm mode if noretry=0 */
-			if (!adev->gmc.noretry)
-				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		default:
-			/* enable BACO as runpm mode on CI+ */
-			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		}
-
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
-			if (bamaco_support & MACO_SUPPORT) {
-				adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
-				dev_info(adev->dev, "Using BAMACO for runtime pm\n");
-			} else {
-				dev_info(adev->dev, "Using BACO for runtime pm\n");
-			}
-		}
-	}
-
-no_runtime_pm:
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
-		dev_info(adev->dev, "NO pm mode for runtime pm\n");
+	amdgpu_device_detect_runtime_pm_mode(adev);
 
 	/* Call ACPI methods: require modeset init
 	 * but failure is not fatal
-- 
2.34.1

