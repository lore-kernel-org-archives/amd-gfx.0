Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7C5C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 05:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBEBA10E350;
	Wed, 29 Nov 2023 05:58:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC5410E068
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 05:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD17Y3k72EGkB81WblEq7a4fs/2twWih2AHF10LdOSgynoeg6zzVKVCg6a+MeHfHodQSotd+UqNT3HVjRtkRAJqjSaTCryfeaWrXvML7T8KkprSCJoU6IV8Pk4rO53uH2L5Nfoj9W8eU5p5QbGyT817JZaTkG8G5ERHwjFiQtNyHako4HYCZaCCT9ucXf9BUI7/XNOgwDPzb8Y3D0QT34Y45uZhESEloT3NDhfcIy88GWE1GLot2HdLAatjiLaZ/o9l2QeY2fBhbggKjaVmr1vN6GpzBOmWZodQVTmkEKtGcufcwCgwh+YIm5KU6wMJEtATC0nMbKGyGSDt1WV1uYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxHD9lvqd+FbKgUB93iaCDRaTHOUMNbKWlcXfI7+hcI=;
 b=FWrKYsznfih3SLQ064o6ccQBvEwMec7qD6YWn+2T2QXLuh7w34HJ3WaAwTylK5J2Yzkc53cqURrsuYHhEYbK/x4/8vtcQ9QjgxxGCrbZYhUa5GMxZ2BDCbLDf2Q3rgihAaPbEjCxs+Xm1pmRmmjP8YrFc9BOijC/AwoeoPzx9fWgBU2E+LMPV1MAIK6dHfB+osFuAhtXgwxU1aVOr00wB2h3uVBv4l/Clzw0/wfIIbTHZzAXWqWsz3WSQSujkvhryAFpw4oH9cWJDs/1uYI91dzrvU2cTCD1+NTI61jtH8tiEy7UN7IQTJyi5XKCOHyFqzIvibQZTJ81OLOL8JHusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxHD9lvqd+FbKgUB93iaCDRaTHOUMNbKWlcXfI7+hcI=;
 b=uR5G9OO+ZP0FniLZq9GpNpEBjpv0JV9bwOdVkvqwRIhypjPp+mjKsgb6Gx7SYMvnbs6syrFi0JDmuHAKXR6VldSX8+F2v4kUPIctWqoQbI/gHw/kqCZU9PZ2e66WcUgIqPLLmlWVAYfdCv43ci5hnezrDL2yYCWaJgekU/LYReo=
Received: from BL0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:2d::29)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 05:58:27 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2d:cafe::4c) by BL0PR03CA0016.outlook.office365.com
 (2603:10b6:208:2d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 05:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 05:58:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 23:58:26 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd: Drop calls for checking "support" for
 BACO/BOCO/PX
Date: Tue, 28 Nov 2023 12:52:38 -0600
Message-ID: <20231128185238.187381-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128185238.187381-1-mario.limonciello@amd.com>
References: <20231128185238.187381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd298ac-8c3b-487a-85f0-08dbf0a034ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZBNiGqTQKnMDVYY/oajnE+Jag7y5FZbOntElAEeCSzKxsCxE+1kKCO6nNyf1kRhhiArO5Z1JpFtd8TkQ2yNjz3RSMtkxz1MEMvb0IP1fInRQShHcKsfBt3tLmJoOUh2/1qbJSTf6+9i3WY1BZ33mquL3Mqtub85fCZI3oK7EvI09ezRToAuFKHfSc9dvp4d5xpS+DMbXZvHrUvy8NbXCNBHsYnw5MmsparK12ya7cjLpfz1A4a4reVNlptUXRFdbxz9wg0iSjiCVqgB1eoDcGreQDgRKBEAnO7gUT6lrdGlprBc9uyeVgmTzRW5Pf/BIiwv0Pl37jYX5UCkSqR784DFBYdf3uFE04/xDAfUmMN7/pSItj8vz27yRDLmPfsQWiC/ZcVyE4q39xElY4yamhNwSDBkUWRS70eN+HJrfub+oxteO9P4Ax6uUdFv8NSbT4HNzV0mqe5E/aRM/8GlHnvKXsp0ZquBR5JSk87S6RVH8+KPNI6g4qtFC5pRKDx044WUnoSoWzHYtGl97oP2p5HlJg2WSVP32qhmY1VSUNoMBE7k4mmEEdHmsfiOPoK5o41JO0oGPaXNoAV2/h3QJOFYewnqKrXbawioouzNQSqF0bI6GvChGnNacdoETHQsJZSr6+d5LD19O7d7hGeMdt6dMSQOWMUiqErlKuS+K9Xycjsv2/WB+Y+DaaXByvCtcF0reA3L9aSsbSvwm/bDgk+tGtSsEiqE0xfMtGc8090X1J5ZYQpKCCPMQK2Wmmzs6ZbevTqZcm02du+r9p2HQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(81166007)(356005)(47076005)(336012)(8936002)(82740400003)(7696005)(8676002)(426003)(70586007)(70206006)(36860700001)(54906003)(316002)(4326008)(86362001)(44832011)(6916009)(5660300002)(478600001)(40480700001)(36756003)(41300700001)(2906002)(16526019)(6666004)(2616005)(1076003)(26005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 05:58:27.5938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd298ac-8c3b-487a-85f0-08dbf0a034ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
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
Cc: Jun.Ma2@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the module parameter can be used to control behavior, all parts
of the driver should obey what has been programmed by user or
detected by auto mode rather than what "can" be supported.

Drop calls to all functions that check for BACO/BOCO/PX runpm modes
and instead use the variable that is programmed when device is probed.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 34 ++++++++++++----------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +-
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1181fe4baf0f..8f7377b37f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1822,9 +1822,10 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 					enum vga_switcheroo_state state)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r;
 
-	if (amdgpu_device_supports_px(dev) && state == VGA_SWITCHEROO_OFF)
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX && state == VGA_SWITCHEROO_OFF)
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
@@ -4244,7 +4245,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
-	px = amdgpu_device_supports_px(ddev);
+	px = (adev->pm.rpm_mode == AMDGPU_RUNPM_PX);
 
 	if (px || (!dev_is_removable(&adev->pdev->dev) &&
 				apple_gmux_detect(NULL, NULL)))
@@ -4392,7 +4393,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	kfree(adev->fru_info);
 	adev->fru_info = NULL;
 
-	px = amdgpu_device_supports_px(adev_to_drm(adev));
+	px = (adev->pm.rpm_mode == AMDGPU_RUNPM_PX);
 
 	if (px || (!dev_is_removable(&adev->pdev->dev) &&
 				apple_gmux_detect(NULL, NULL)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e39f3a334c9d..12fb8398fb45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2248,10 +2248,10 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		/* only need to skip on ATPX */
-		if (amdgpu_device_supports_px(ddev))
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		/* we want direct complete for BOCO */
-		if (amdgpu_device_supports_boco(ddev))
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
@@ -2284,7 +2284,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		 * into D0 state. Then there will be a PMFW-aware D-state
 		 * transition(D0->D3) on runpm suspend.
 		 */
-		if (amdgpu_device_supports_baco(ddev) &&
+		if ((adev->pm.rpm_mode == AMDGPU_RUNPM_BACO ||
+		     adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) &&
 		    !(adev->flags & AMD_IS_APU) &&
 		    (adev->asic_type >= CHIP_NAVI10))
 			amdgpu_get_secondary_funcs(adev);
@@ -2466,7 +2467,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(drm_dev) &&
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO &&
 	    pm_runtime_suspended(dev))
 		return 1;
 
@@ -2664,7 +2665,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
-	if (amdgpu_device_supports_px(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 	/*
@@ -2674,7 +2675,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	 * platforms.
 	 * TODO: this may be also needed for PX capable platform.
 	 */
-	if (amdgpu_device_supports_boco(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 
 	ret = amdgpu_device_prepare(drm_dev);
@@ -2683,15 +2684,15 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
-		if (amdgpu_device_supports_boco(drm_dev))
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
 			adev->mp1_state = PP_MP1_STATE_NONE;
 		return ret;
 	}
 
-	if (amdgpu_device_supports_boco(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
 		adev->mp1_state = PP_MP1_STATE_NONE;
 
-	if (amdgpu_device_supports_px(drm_dev)) {
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
@@ -2700,9 +2701,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		pci_ignore_hotplug(pdev);
 		pci_set_power_state(pdev, PCI_D3cold);
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
-	} else if (amdgpu_device_supports_boco(drm_dev)) {
+	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
 		/* nothing to do */
-	} else if (amdgpu_device_supports_baco(drm_dev)) {
+	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO ||
+		   adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) {
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
@@ -2725,7 +2727,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
 
-	if (amdgpu_device_supports_px(drm_dev)) {
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		/* Only need to handle PCI state in the driver for ATPX
@@ -2737,22 +2739,22 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		if (ret)
 			return ret;
 		pci_set_master(pdev);
-	} else if (amdgpu_device_supports_boco(drm_dev)) {
+	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
 		pci_set_master(pdev);
-	} else if (amdgpu_device_supports_baco(drm_dev)) {
+	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
 	if (ret) {
-		if (amdgpu_device_supports_px(drm_dev))
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 			pci_disable_device(pdev);
 		return ret;
 	}
 
-	if (amdgpu_device_supports_px(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f464610a959f..d7977185f4e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1618,7 +1618,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 	bool use_baco = !smu->is_apu &&
 		((amdgpu_in_reset(adev) &&
 		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
+		 ((adev->in_runpm || adev->in_s4) &&
+		 (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO || adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)));
 
 	/*
 	 * For SMU 13.0.0 and 13.0.7, PMFW will handle the DPM features(disablement or others)
-- 
2.34.1

