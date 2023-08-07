Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B36BC001B0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 08:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10AC10E05C;
	Mon,  7 Aug 2023 08:32:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D0310E05C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 08:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqRdfz6RHvie+yWkMOi4H0X8kCgYYMu+CVk9dncxFq9mBmofkf1FWLuwmX5vty55PUGBjbWaoxQQHTc+LsGOL7sc18+edOjuIKnpZ3aPVWN4TLP6R5iTtRljGMipj1fUHERSH+BA4Y5PZXJXVjeeVnkhqQl69C+zh9R6flgm53VsAwqEOJsa2ki+u3UmVCYAgQhVbMUklqbEghqmviq0CWgUEcbQe6DtfsQp80y8hLI22KAwQwfqKAoZKl2wgQhstEqSzvghcLiN9rlCUOWFYGwdM8boKMa4VkscQMJ1GrPzpj2yELeb+MD5Ylpih68hRwPHFtgY0IitJExVivfXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWtI8EoVqtiLRmp4J0OqaeQv9gkftlbN3VU8+PfojbQ=;
 b=MUBDB3scF75JLEVHa6ONQZ+iHY2O5XBv80eeGWfdYDhBfVOu0ODeuTPldaOhoRkDTMyO++PNl5LainldTDn8Tf3Jb4RRzzHwSd4fj0W5BsZ7ysOLoFdKo6W54ecXmnGRLEgQGHS8r1Wy6oFYZxp26HeCOORmWZ1sHcmNc/qMUeSpijivVbAdvWqJZlvm2C9ew2E+7MD1X5Ipd0ce0Y1fqevo05Rinz7Tupw3kWhTQBWVdeSrrddAon3pT3EyIT4FKKB8qEhv6TpO7725sWXsFxGIL4Bkw+IdvzHjhSqkStwtUCUJx9SXlie40LTBdohSnnRz1w/LPkCc5+iCSfxV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWtI8EoVqtiLRmp4J0OqaeQv9gkftlbN3VU8+PfojbQ=;
 b=qsO06KLIDOL0CGGxQx3t8YUTIVJh0hg5YhqJ0mzTOHTemz7mHj8XRT+2oHwQ7IPmlXCzMavKwOIw2+HuoaPb2ZLvpN9Fa4fmwHTu/08X0VgFKuLmIU0DzKThrHDBgwTxfsV6o7gnzlISkAIALWiEIVLovSfKSt+yl/SswgC3CIQ=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 08:32:14 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::e6) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 08:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Mon, 7 Aug 2023 08:32:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 03:32:13 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Add FRU sysfs nodes only if needed
Date: Mon, 7 Aug 2023 14:01:53 +0530
Message-ID: <20230807083153.509539-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa6b65a-8171-409f-1768-08db9720cf08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Z8E3UQN0jtsKCRfj4FO4waabCA9xHG9+V/Xr5G4NlfRqw8m5iZQX6VqFmzLqOjIvPORCZvcUVYSGtwgVxBrzFkrVGykV9L2jdvlY09KvUk7WpF1s9r1girkCL/Pvex2cAyXDs9A1e7KoQ1H2g8qNuQdDpazFjgSJubAfmAgiCirxXJCujNG9raD3K2szjRXChqVZ0lIUH6ZvldX8Z2NO0J5l94XrtrEghvAUdZPYzRtSi6MkRixo5g8dSHMkfTM3GeEonGsgM/Zoe2zR7C5lwi5BmMX4vDq0rm10nkLAxH/DLdKhkPtwbrpLPZcOg1vTO8ZPO8Yfvp5quzmjgwsbKOBqHZ7NYq1HD1T3cZHDCxp/r2kOn7LrSGA69sfWE5zcA8txR1u9B3AnKbAVxRXKCQVKPEo6qWIIG+V1K0/7NnKBIPgr7w6sTUqOpb2l92ToQQRw/iIRKirLiIWjds53cjWR78BGQslG8mj5CL73ao0Ifw5IyHlLj3M8DoRqjIklukRZNvfEmNbr9TWU36mamY+rNftCtnkSbVBPvxzPzbPH3Wxyr1IXEfSXoIJykZJLS0y/GvJeIc0xkFhWc71lHNh+YwAPol1wOWC2bef7y4/VjHNDc4mGx/mVXbYt+QLUJX3S9woF/Htz6361MDqlWOLyAWjq5ZLOlS+hgdgUc8zj6NHOX2NwsMJFhiLCmNsBtlaGpQaL3lcknqWIxpkCr0Sln8wszqdXl74TbWIqZUKHPgTDCMPkfaAhyd9/hcUUFn1PpN6N69LljP1DN+tLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(1800799003)(186006)(82310400008)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(2906002)(36756003)(5660300002)(426003)(2616005)(36860700001)(54906003)(6666004)(7696005)(70206006)(6916009)(70586007)(356005)(4326008)(82740400003)(81166007)(316002)(40480700001)(41300700001)(86362001)(44832011)(40460700003)(8936002)(8676002)(26005)(1076003)(16526019)(336012)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 08:32:16.9812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa6b65a-8171-409f-1768-08db9720cf08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Create sysfs nodes for FRU data only if FRU data is available. Move the
logic to FRU specific file.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2: Add fru sysfs fini to take care of removing files (Hawking)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 71 +--------------
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 89 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h    |  2 +
 3 files changed, 94 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0d602abd32ba..4f818f13dc9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -164,71 +164,6 @@ static DEVICE_ATTR(pcie_replay_count, 0444,
 
 static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
 
-/**
- * DOC: product_name
- *
- * The amdgpu driver provides a sysfs API for reporting the product name
- * for the device
- * The file product_name is used for this and returns the product name
- * as returned from the FRU.
- * NOTE: This is only available for certain server cards
- */
-
-static ssize_t amdgpu_device_get_product_name(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-
-	return sysfs_emit(buf, "%s\n", adev->product_name);
-}
-
-static DEVICE_ATTR(product_name, 0444,
-		amdgpu_device_get_product_name, NULL);
-
-/**
- * DOC: product_number
- *
- * The amdgpu driver provides a sysfs API for reporting the part number
- * for the device
- * The file product_number is used for this and returns the part number
- * as returned from the FRU.
- * NOTE: This is only available for certain server cards
- */
-
-static ssize_t amdgpu_device_get_product_number(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-
-	return sysfs_emit(buf, "%s\n", adev->product_number);
-}
-
-static DEVICE_ATTR(product_number, 0444,
-		amdgpu_device_get_product_number, NULL);
-
-/**
- * DOC: serial_number
- *
- * The amdgpu driver provides a sysfs API for reporting the serial number
- * for the device
- * The file serial_number is used for this and returns the serial number
- * as returned from the FRU.
- * NOTE: This is only available for certain server cards
- */
-
-static ssize_t amdgpu_device_get_serial_number(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-
-	return sysfs_emit(buf, "%s\n", adev->serial);
-}
-
-static DEVICE_ATTR(serial_number, 0444,
-		amdgpu_device_get_serial_number, NULL);
 
 /**
  * amdgpu_device_supports_px - Is the device a dGPU with ATPX power control
@@ -3550,9 +3485,6 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
 }
 
 static const struct attribute *amdgpu_dev_attributes[] = {
-	&dev_attr_product_name.attr,
-	&dev_attr_product_number.attr,
-	&dev_attr_serial_number.attr,
 	&dev_attr_pcie_replay_count.attr,
 	NULL
 };
@@ -3967,6 +3899,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
 
+	amdgpu_fru_sysfs_init(adev);
+
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
 	if (r)
@@ -4086,6 +4020,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
+	amdgpu_fru_sysfs_fini(adev);
 
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 8c3ee042556a..9c66d98af6d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -212,3 +212,92 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	kfree(pia);
 	return 0;
 }
+
+/**
+ * DOC: product_name
+ *
+ * The amdgpu driver provides a sysfs API for reporting the product name
+ * for the device
+ * The file product_name is used for this and returns the product name
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards
+ */
+
+static ssize_t amdgpu_fru_product_name_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%s\n", adev->product_name);
+}
+
+static DEVICE_ATTR(product_name, 0444, amdgpu_fru_product_name_show, NULL);
+
+/**
+ * DOC: product_number
+ *
+ * The amdgpu driver provides a sysfs API for reporting the part number
+ * for the device
+ * The file product_number is used for this and returns the part number
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards
+ */
+
+static ssize_t amdgpu_fru_product_number_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%s\n", adev->product_number);
+}
+
+static DEVICE_ATTR(product_number, 0444, amdgpu_fru_product_number_show, NULL);
+
+/**
+ * DOC: serial_number
+ *
+ * The amdgpu driver provides a sysfs API for reporting the serial number
+ * for the device
+ * The file serial_number is used for this and returns the serial number
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards
+ */
+
+static ssize_t amdgpu_fru_serial_number_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%s\n", adev->serial);
+}
+
+static DEVICE_ATTR(serial_number, 0444, amdgpu_fru_serial_number_show, NULL);
+
+static const struct attribute *amdgpu_fru_attributes[] = {
+	&dev_attr_product_name.attr,
+	&dev_attr_product_number.attr,
+	&dev_attr_serial_number.attr,
+	NULL
+};
+
+int amdgpu_fru_sysfs_init(struct amdgpu_device *adev)
+{
+	if (!is_fru_eeprom_supported(adev, NULL))
+		return 0;
+
+	return sysfs_create_files(&adev->dev->kobj, amdgpu_fru_attributes);
+}
+
+void amdgpu_fru_sysfs_fini(struct amdgpu_device *adev)
+{
+	if (!is_fru_eeprom_supported(adev, NULL))
+		return;
+
+	sysfs_remove_files(&adev->dev->kobj, amdgpu_fru_attributes);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
index 1308d976d60e..c817db17cfa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -25,5 +25,7 @@
 #define __AMDGPU_FRU_EEPROM_H__
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
+int amdgpu_fru_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_fru_sysfs_fini(struct amdgpu_device *adev);
 
 #endif  // __AMDGPU_FRU_EEPROM_H__
-- 
2.25.1

