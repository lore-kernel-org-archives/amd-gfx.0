Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6585C83F03
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 08:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8F210E13B;
	Wed,  9 Jul 2025 08:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IYNyPkJ+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD44610E13B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 08:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObUs+xa/SBOsSKxSiVTrzI1XrueBgZ2AU4b5TDhmD06h1AdW8fbSPEzeG4lLfjB1SivtO2letxLLMQTtfbRlw5r73Z1zE+nd/V6G6G6L0zU3icUqZ5keTJKxopxOYgxkS1Qzh4e35byYn22joj0l7+vSuAdJwa3kf2figr6haOwJY+kISIFfTc5rP+S34s1AdMwQGDFzRL1ef9ZW/g4fnyq1Klicv8ZcYMyuTEeYkDbnxUHVbm9TJKv6moe/IMBgceGlp/ZB5/WP4jeqxk2rDrCoCDlai+hqYVbyn52ls/MfjiFRnuAbulg1H5zkLDU1xmidC82nHMNJt0czibj1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGQH+RqEz5dLDtkQhg2oGLyyggfGsYtZZDTogrUEkww=;
 b=VKzr/fv5TnO2H1JF6t2Gsc28M9ccfczg28kJaB9Np4uTDo5M6U7XF/Ts3t4/kyiw6SqPXXVmvlWhUWMK1Q3LpZjevLh/mxfD4q4yk9ovfCZIaRq0LKEsiQSrjhw6hjCNcbabmsGTSSXXKzpVEQWoA6JXAA+k2Yhompp81KBMDRosGcD+uWzqmu6vry4JJ4/ODRCvqT7z90TYIwrpM8YBp5Gv0NnbDdS7Ybew7ZhS/P9WZbTnyC5jLzM4IboKZI3B/NOSDZ/a5qxb+OoML12/fiLGmwbeW9069F8ZOVbrssQYcRmgFGTapg34RAhaIXw9fidrh1Fdcl/7EidDMDW8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGQH+RqEz5dLDtkQhg2oGLyyggfGsYtZZDTogrUEkww=;
 b=IYNyPkJ+ei5Z/yUoYTyWN1qLvHEKHecVV/h0iM+K/xgoYlBMd/TOfZSVvnsOIxfvPMv7dwepoGonbwEHPH72USaa7R9+Y6zbFSIOQuNQqlFtzH/Phn9bPTtk1B+9XYyvFXpTgSpbMWPRKgqcU/uJv0qlQQEPbX82l5Rskkelaig=
Received: from BN9PR03CA0162.namprd03.prod.outlook.com (2603:10b6:408:f4::17)
 by CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 08:29:46 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::6e) by BN9PR03CA0162.outlook.office365.com
 (2603:10b6:408:f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 08:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 9 Jul 2025 08:29:45 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Jul 2025 03:29:43 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Date: Wed, 9 Jul 2025 16:29:14 +0800
Message-ID: <20250709082915.18904-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CY1PR12MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: ebed4b3a-b55a-4430-4649-08ddbec2c29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dTXJMKw7j5pmoWFU9Q+Jqg+ms9gREqi03vH2T9/yNrqqJS+9aWbOIOUsmCEA?=
 =?us-ascii?Q?U0YLmUTy0zfugz4pEvEQF5zH4J//B19G9KP+xq/x4e8a0BZuOy29vuY04rkS?=
 =?us-ascii?Q?AdCYoFM0zsmh3xvR4L0oNnUPTA+7xm3iG0X2UzwqwDucVIojMaYXhlBqeawf?=
 =?us-ascii?Q?eVbVqDloI195EIG6VdX4R6XMQ/8j13xzQq05O0xwlEMqgOhWRGQvyB7K7niV?=
 =?us-ascii?Q?PN0k+hCqhcAKHoWsIybe4CPdTIbHyW2j7ojPPNEPRhVfelL4qv5GWGhXzK2v?=
 =?us-ascii?Q?Gj9ddwkt9Z2wgJJk2KF3cXpmn+v7A6NJXfdrcSNDlj7J9Jpj+lPbmD9b8SdM?=
 =?us-ascii?Q?Y8u75UwxePYYaWJotiWY4o+RYigRkH6u6P22yyCRw5rmxxtBaIiEn1I1C1RF?=
 =?us-ascii?Q?Z0yH8xhhrJz7JnD+MSLYrirpW+yjDvqUqBTC5DJpldDSHsUr/h1XuFYcz3oH?=
 =?us-ascii?Q?7SQvYqG/eAnr2R+LuMqjRM+Nh5HS3gjsR0EX9kzBgk0XKX2GXO0/s/bwn/oi?=
 =?us-ascii?Q?x9z+L5Dmd+vmJFcdwR13Kl9lm1nm8sy0etp7xjZa9mdW32PfkYKVPfLPtWgv?=
 =?us-ascii?Q?oc3RGpdedb9V/a5G9J3+FZ+TkhLEMSQpE2m42NIWWybk/qXpfLrmIiD6mJnh?=
 =?us-ascii?Q?rxUlAk1tkVpW6BmBdiKvK8Q3BmDqRmGl3WpmP5lUHM++f77Kp0wjQhq3md9J?=
 =?us-ascii?Q?/d0mZtpxs5zOKBCIv39SDsQfBVEeMBrpt4GCLasF9K8d/pa+fObcO8ZUnfIH?=
 =?us-ascii?Q?SJOKu9b45xkG4MRqbcZ48WcG10sL6aymqIchkVsfj7ZwrpD0wuQo6FJ5P/2x?=
 =?us-ascii?Q?ocTDy2jURocrm5xg4Rilp0m9q4gp5gchkrGzEYwSmCGqxlvxXj9BRk1i9J3X?=
 =?us-ascii?Q?RwlUUbnQ1vY1BVLTkhVNl0hQlWjyfWim26ZX76cSTg2B+VZJ9CP1piOdnTsO?=
 =?us-ascii?Q?pDo+cyN4Gw1PEBIkfH71UrHyuLZYglCY36uDGfsNtPW6/e1rGu+9NtpVMS0u?=
 =?us-ascii?Q?4cyySZnlZrXh1XVwuBW6eH62ADCzsP8QUCDgveWOtCBUocEAZrqUs4rBR4R+?=
 =?us-ascii?Q?Vu7nrfZtjF0QRUpXBxTzcBIiDf7BEe1B3XpuTw6jYsI9YqyaHZ96izRZ52xr?=
 =?us-ascii?Q?8ZAPG5xce/U6WpLJVQpoFi+uYf6My3AJyPVH2lcV3euDa+Rtu57DHKS6rYlv?=
 =?us-ascii?Q?WHNA3my4VjPoF8h02KJ/kHDHWfZTKcNtEKHgBpLsFTfnwzbSV8Kt2P4cWCZj?=
 =?us-ascii?Q?hMC/9RCc87l2M6dQiOB1vP42Yngj+mhl3f+znzldhF4t8BiauKfwdspMeprb?=
 =?us-ascii?Q?iqqIbrMN6rtxBEb7vQxM3V8UHBWYsHZ1lecxOF1TQmPENQJv9hVMGVTjPoEb?=
 =?us-ascii?Q?KfDY+d93xG4DC9UHaZJjRD+T2wEZyaj3TIFrEH34vaELHAzqPxl4dUgz8pzc?=
 =?us-ascii?Q?VYrC58mCnNSWrYc6WjJuWoGfWM0kMlZUoJ31eE9kQg262vFUwxKQDdg8Fy+I?=
 =?us-ascii?Q?v04S5Z4WKKihbOl7q/L56rlunkW4AKnTXl9p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 08:29:45.4123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebed4b3a-b55a-4430-4649-08ddbec2c29e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9559
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

add eeprom data checksum check after data writing, after gpu
reset, and before driver unload. reset eeprom and save correct
data to eeprom when check failed

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 13 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  1 +
 6 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 84fcaf84fead..2503f2300472 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6410,6 +6410,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 	int r = 0;
 	bool need_emergency_restart = false;
+	enum amd_reset_method tmp_reset_method;
 
 	if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
 		return 0;
@@ -6506,6 +6507,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (!r)
 		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
 
+	if (reset_context->method == AMD_RESET_METHOD_MODE1 ||
+	    reset_context->method == AMD_RESET_METHOD_MODE2) {
+		amdgpu_ras_eeprom_check_and_recover(adev);
+	} else {
+		if (reset_context->method == AMD_RESET_METHOD_NONE) {
+			tmp_reset_method = adev->asic_funcs->reset_method(adev);
+			if (tmp_reset_method == AMD_RESET_METHOD_MODE1 ||
+			    tmp_reset_method == AMD_RESET_METHOD_MODE2)
+				amdgpu_ras_eeprom_check_and_recover(adev);
+		}
+	}
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 571b70da4562..1009b60f6ae4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_ras_eeprom_check_and_recover(adev);
 	amdgpu_xcp_dev_unplug(adev);
 	amdgpu_gmc_prepare_nps_mode_change(adev);
 	drm_dev_unplug(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f8a8c8502013..e03550be45b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -196,6 +196,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
 					 err_data.err_addr_cnt, false);
 		amdgpu_ras_save_bad_pages(adev, NULL);
+		amdgpu_ras_eeprom_check_and_recover(adev);
 	}
 
 	amdgpu_ras_error_data_fini(&err_data);
@@ -3539,9 +3540,13 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 		/* The format action is only applied to new ASICs */
 		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >= 12 &&
 		    control->tbl_hdr.version < RAS_TABLE_VER_V3)
-			if (!amdgpu_ras_eeprom_reset_table(control))
+			if (!amdgpu_ras_eeprom_reset_table(control)) {
 				if (amdgpu_ras_save_bad_pages(adev, NULL))
 					dev_warn(adev->dev, "Failed to format RAS EEPROM data in V3 version!\n");
+				else
+					amdgpu_ras_eeprom_check_and_recover(adev);
+			}
+
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2af14c369bb9..2458c67526c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1522,3 +1522,28 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 	return res < 0 ? res : 0;
 }
+
+void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
+	int res = 0;
+
+	if (!control->is_eeprom_valid)
+		return;
+	res = __verify_ras_table_checksum(control);
+	if (res) {
+		dev_warn(adev->dev,
+			"RAS table incorrect checksum or error:%d, try to recover\n",
+			res);
+		if (!amdgpu_ras_eeprom_reset_table(control))
+			if (!amdgpu_ras_save_bad_pages(adev, NULL))
+				if (!__verify_ras_table_checksum(control)) {
+					dev_info(adev->dev, "RAS table recovery succeed\n");
+					return;
+				}
+		dev_err(adev->dev, "RAS table recovery failed\n");
+		control->is_eeprom_valid = false;
+	}
+	return;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 35c69ac3dbeb..ebfca4cb5688 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
 
+void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index bfc86f1e84e5..081f7fd29394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -80,6 +80,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
 						err_data.err_addr_cnt, false);
 		amdgpu_ras_save_bad_pages(adev, NULL);
+		amdgpu_ras_eeprom_check_and_recover(adev);
 	}
 
 out_free_err_addr:
-- 
2.34.1

