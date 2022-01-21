Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72F2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9C410E3FE;
	Fri, 21 Jan 2022 20:22:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC7810E123
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mftpIjxKHlFXM1jtmvdX8tN/jweekc5SCLsM8SrOwg7/zOZs6DxaXLPYJmDmRzlbii7/E0BKISNzWQO/kgc0/QMtr48g11DRtAr1W66ApgU1OM2D9rlqDIw0O45hweaCfgwJdN7vltdWNLHKp+GjLFpUV3Mt41CPF79p3PvW6L4ZvT/IsOP85ZodrTkJR+U+eeufR3OOz08YAag5wtSW3Az7m1g8oR2N8UI/clTB8zDgih39P0TiRPVxuz5jlGc3UWX5CQqBFxD/sNEp+CkHTHCFVF14ISJ93upYx96gqeF6GNbbvgITFVTI0qYzkGgn17T+SuPKNL5URgd63Tr09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foovPKbP3Za1mQKHyp/fbOtMJVMtmv67gfDu/G0hg3s=;
 b=G3utISS68DKptxng0of2stw4hmLrqYUhKwjc/YrJQ8GsD4mR+W5VnZ7dccY/0rSpX26a/ftnAoDRWvGPdD1O1r79UEgjE7RMnymViFUWavAQCDimkIXHSR9fDk3oglX51l/IzF8Ose9R5sXV0fJybN46WYpOvyqCYTD6ly6l9Of0b04KVd1sjufQfnqWZGzsDgkFJkrk0h7FMkqDk8tPhMv/oi7mXpDxdwh+ejZtuIXyi4SoUx4fxXtvYrsXs5dOMdUPXuzgrw6d74kk9SuCi1VxTrlQKUORranEGDVGbbWO2lW6tcAa82usZ7rDJ4Ee6uNV/N96P/S1VsconLnHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foovPKbP3Za1mQKHyp/fbOtMJVMtmv67gfDu/G0hg3s=;
 b=4skyKMLJ00LHY4z7C0ra00xcg4B9xHqnns3EB8Zq8jgV70wY1RbVepDSbHKh0uJBB3c1ZXhWqz33Zenk4IbPBICckeZ88PxPzPPIeXd1mz9nEJ8W9lD48v7P3/RtDkZrzx69BrIO3gkPOZXv8wMW/Z2o8KKT97muAEolFeSp1Hc=
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 20:22:37 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::a8) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Fri, 21 Jan 2022 20:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 20:22:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:22:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: move runtime pm init after drm and fbdev init
Date: Fri, 21 Jan 2022 15:22:18 -0500
Message-ID: <20220121202220.5557-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121202220.5557-1-alexander.deucher@amd.com>
References: <20220121202220.5557-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76047f33-cf0c-49a3-0469-08d9dd1bc39d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4289803673ED81BC29B7D07CF75B9@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mpa1Gt0t4z5DmVxXZNs4PAzFCnmQ6BI/4itLSGN1LMdjdtmu3liWzvtDkjCuflwuLr5djXoWb8+gDrK18YVs9bbqhNDL3NfMw6YBcbZ4GE0f+sBsB7O0q7UU6rbB44YyjAZ+gW6ZCbpYycBNrTdXnJenKEpRmOMUKTpyB+wegytbY5KwAW+WO9pK1RGfGKyWuC3ce7VnU6mjk9t4hrF9GMTbQu632WUS+rPfa/uCWY9U+uiABYSF+21Q6T40ZJrGIQr0hme8V/2Q/m61Bm7tFG6m3cp0jE5U2XAAnhVapbpYlGeKLCu/WHl1pQKrX8bFoVyu/7CI01R7FHFVfhcf/VMgQkcACYRFqP08Xp/xeuS0l0Qcpzd8UDerWTJ4j6zTyvSDXreSRuTRbkkSIUr231sp1rt3IPK5WJq6UFjU/PpJy9kdBBOjisjKHkqWB9hKPIlMji6D03iA/c+xd4COQvYpAZhu3OC1gzv2hUUhoyr2rxvF7zjPyLy8WAtUtNQdeRtHwQDUeE2BNrjFmKiWcCbh4c4ACnZ//yPI2kp52QiJSK/bosYqIhZQ9SiYKS5yQH2+C4Jf/SqyBvMbEalBCYi6oPO2sPVsVxxhwc0o8RP5HQnrRHeXKu0+ntxOPObkBAHHWyWBF9FtGhltN1ifb+dBcCrDDIIIhvTRwkxj+esb84UBQKpW9ZiFgRBEoCS9mE/ltKdnK5eD8a7yaBTrt5RS5A4GCjDg3+Cdfx+g0GwWT68NFogkgmn6RhSbfVEp/ueO0q9Upoz6hBZfBY6tafCz2rJZAGv3YHCMLF7SFy4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(70206006)(36860700001)(186003)(83380400001)(86362001)(356005)(26005)(426003)(6666004)(70586007)(5660300002)(36756003)(47076005)(8676002)(6916009)(316002)(7696005)(4326008)(2616005)(82310400004)(2906002)(508600001)(40460700001)(1076003)(8936002)(16526019)(336012)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:22:36.4870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76047f33-cf0c-49a3-0469-08d9dd1bc39d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Seems more logical to enable runtime pm at the end of
the init sequence so we don't end up entering runtime
suspend before init is finished.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 65 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 69 +------------------------
 2 files changed, 66 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 75ceb43392b1..89c3578bc818 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1968,6 +1968,22 @@ static bool amdgpu_is_fw_framebuffer(resource_size_t base,
 	return found;
 }
 
+static void amdgpu_get_audio_func(struct amdgpu_device *adev)
+{
+	struct pci_dev *p = NULL;
+
+	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+			adev->pdev->bus->number, 1);
+	if (p) {
+		pm_runtime_get_sync(&p->dev);
+
+		pm_runtime_mark_last_busy(&p->dev);
+		pm_runtime_put_autosuspend(&p->dev);
+
+		pci_dev_put(p);
+	}
+}
+
 static int amdgpu_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -2100,6 +2116,48 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
 
+	if (adev->runpm) {
+		/* only need to skip on ATPX */
+		if (amdgpu_device_supports_px(ddev))
+			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+		/* we want direct complete for BOCO */
+		if (amdgpu_device_supports_boco(ddev))
+			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
+						DPM_FLAG_SMART_SUSPEND |
+						DPM_FLAG_MAY_SKIP_RESUME);
+		pm_runtime_use_autosuspend(ddev->dev);
+		pm_runtime_set_autosuspend_delay(ddev->dev, 5000);
+
+		pm_runtime_allow(ddev->dev);
+
+		pm_runtime_mark_last_busy(ddev->dev);
+		pm_runtime_put_autosuspend(ddev->dev);
+
+		/*
+		 * For runpm implemented via BACO, PMFW will handle the
+		 * timing for BACO in and out:
+		 *   - put ASIC into BACO state only when both video and
+		 *     audio functions are in D3 state.
+		 *   - pull ASIC out of BACO state when either video or
+		 *     audio function is in D0 state.
+		 * Also, at startup, PMFW assumes both functions are in
+		 * D0 state.
+		 *
+		 * So if snd driver was loaded prior to amdgpu driver
+		 * and audio function was put into D3 state, there will
+		 * be no PMFW-aware D-state transition(D0->D3) on runpm
+		 * suspend. Thus the BACO will be not correctly kicked in.
+		 *
+		 * Via amdgpu_get_audio_func(), the audio dev is put
+		 * into D0 state. Then there will be a PMFW-aware D-state
+		 * transition(D0->D3) on runpm suspend.
+		 */
+		if (amdgpu_device_supports_baco(ddev) &&
+		    !(adev->flags & AMD_IS_APU) &&
+		    (adev->asic_type >= CHIP_NAVI10))
+			amdgpu_get_audio_func(adev);
+	}
+
 	return 0;
 
 err_pci:
@@ -2111,8 +2169,15 @@ static void
 amdgpu_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
 
 	drm_dev_unplug(dev);
+
+	if (adev->runpm) {
+		pm_runtime_get_sync(dev->dev);
+		pm_runtime_forbid(dev->dev);
+	}
+
 	amdgpu_driver_unload_kms(dev);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 16a6da09c924..4c437ad2dd9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -87,11 +87,6 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 	if (adev->rmmio == NULL)
 		return;
 
-	if (adev->runpm) {
-		pm_runtime_get_sync(dev->dev);
-		pm_runtime_forbid(dev->dev);
-	}
-
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_UNLOAD))
 		DRM_WARN("smart shift update failed\n");
 
@@ -124,22 +119,6 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 	mutex_unlock(&mgpu_info.mutex);
 }
 
-static void amdgpu_get_audio_func(struct amdgpu_device *adev)
-{
-	struct pci_dev *p = NULL;
-
-	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
-			adev->pdev->bus->number, 1);
-	if (p) {
-		pm_runtime_get_sync(&p->dev);
-
-		pm_runtime_mark_last_busy(&p->dev);
-		pm_runtime_put_autosuspend(&p->dev);
-
-		pci_dev_put(p);
-	}
-}
-
 /**
  * amdgpu_driver_load_kms - Main load function for KMS.
  *
@@ -213,58 +192,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	if (acpi_status)
 		dev_dbg(dev->dev, "Error during ACPI methods call\n");
 
-	if (adev->runpm) {
-		/* only need to skip on ATPX */
-		if (amdgpu_device_supports_px(dev))
-			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
-		/* we want direct complete for BOCO */
-		if (amdgpu_device_supports_boco(dev))
-			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_PREPARE |
-						DPM_FLAG_SMART_SUSPEND |
-						DPM_FLAG_MAY_SKIP_RESUME);
-		pm_runtime_use_autosuspend(dev->dev);
-		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
-
-		pm_runtime_allow(dev->dev);
-
-		pm_runtime_mark_last_busy(dev->dev);
-		pm_runtime_put_autosuspend(dev->dev);
-
-		/*
-		 * For runpm implemented via BACO, PMFW will handle the
-		 * timing for BACO in and out:
-		 *   - put ASIC into BACO state only when both video and
-		 *     audio functions are in D3 state.
-		 *   - pull ASIC out of BACO state when either video or
-		 *     audio function is in D0 state.
-		 * Also, at startup, PMFW assumes both functions are in
-		 * D0 state.
-		 *
-		 * So if snd driver was loaded prior to amdgpu driver
-		 * and audio function was put into D3 state, there will
-		 * be no PMFW-aware D-state transition(D0->D3) on runpm
-		 * suspend. Thus the BACO will be not correctly kicked in.
-		 *
-		 * Via amdgpu_get_audio_func(), the audio dev is put
-		 * into D0 state. Then there will be a PMFW-aware D-state
-		 * transition(D0->D3) on runpm suspend.
-		 */
-		if (amdgpu_device_supports_baco(dev) &&
-		    !(adev->flags & AMD_IS_APU) &&
-		    (adev->asic_type >= CHIP_NAVI10))
-			amdgpu_get_audio_func(adev);
-	}
-
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_LOAD))
 		DRM_WARN("smart shift update failed\n");
 
 out:
-	if (r) {
-		/* balance pm_runtime_get_sync in amdgpu_driver_unload_kms */
-		if (adev->rmmio && adev->runpm)
-			pm_runtime_put_noidle(dev->dev);
+	if (r)
 		amdgpu_driver_unload_kms(dev);
-	}
 
 	return r;
 }
-- 
2.34.1

