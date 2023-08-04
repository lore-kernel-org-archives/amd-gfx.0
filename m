Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723B9C00528
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 13:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 395EC10E07F;
	Fri,  4 Aug 2023 13:05:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F0110E07F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 13:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b03KjXn3SLJM0Zki+vDbhT+RPZbPllqiQUbTqPqCNE3qPd5gt8RgOu5XjQRF6/pp8PTVW+uaPu4v1vxwFHO+pIrjpGQps98HWJV3tTa263+LOgN8clcPb/JMOuz365rj0M2f4ha7gYzMzes1O8SsOmyxtgkF8BxnW91tb2KCeqop+wbkZc0nM3EQeuIScK5T/Smonwv0QkQSt10Sl2hbA7Ne5J6xqs7JqhFyXXujh3eBWcPv3/eiBZ7AJOWA7Y/0vKa6rAG4ebh2cL8dhYqUaygYYEOImi+QB6r0aZf//qcpkmMlFS+FvMtpyodcMCiG1BvnvCJs6xqwPIOoMmFkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyXfCYBdMXKg2uu9TS1rhqJFQjY5rMtF/Ic6YeIAbeY=;
 b=cF7HGdnBRne1+EYy4p3wfW/ivZMQCjtUIX9HYABvnPW1wFDWTJLyNRIF+5V7r+DqxnIcXmSIb7PsIdLX8nDx36dPjD+d1gTeH5TdKcgtGWzyYedaaS62PzYOmnCGyMFc0LbkAaNzPbFNf/zlUPS4LSAyh6RTiAMeRa7exS7WiwohTwaZ3b1gaAoTeZRes5yE8xH/xjgmkyB/MAGgZbP0WZww1Abi02piChvTfdfuxqPWLq/cPMIAYXpLT5FPDlj2FptulMRnNIfmNGm02tzmjv7AJA3dSfiGHb+iLV0y83YPZzVheaOPv7atI5AzOVGzPlehj8DhpSw7NzxWj5pJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyXfCYBdMXKg2uu9TS1rhqJFQjY5rMtF/Ic6YeIAbeY=;
 b=KbaafHwIvmwbuEa/TyWOi85WtUn0uav4rhAeK4+FVrpz2U0j2fCQzRh8oZPT09/XnjC1Yn1d9iN9vsIkMCZayPFi6Mo2qirtoJwDB+hXgixeBa4YvtyH9jC4LZOg618x/2nvuATmY6a1O0RwozUS3wPT39MIgScO2LhkjobxkH8=
Received: from MW4PR03CA0267.namprd03.prod.outlook.com (2603:10b6:303:b4::32)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 13:05:37 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::40) by MW4PR03CA0267.outlook.office365.com
 (2603:10b6:303:b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Fri, 4 Aug 2023 13:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.21 via Frontend Transport; Fri, 4 Aug 2023 13:05:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 08:05:34 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add FRU sysfs nodes only if needed
Date: Fri, 4 Aug 2023 18:35:16 +0530
Message-ID: <20230804130516.351861-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be040a4-0ee8-4251-e2bb-08db94eb7f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nwk+KG1czB304bF74cyIaUKQkkGOzdG1Syeh7KnDVrVmnBSfnVV14OTsZGk/RKakgQMNi8Xe2sGq0iQlNry22dLPBxZ1woGsFXMdUUymY2x/DQGYGvkcFdwf4IVverUjPye8A4h41Yyc+XOcF1S7N30Ld/5uWr0piI7iRYPIb3xmConAupCPyR9hFSFUCW4n4o+Fp8+7yz/jZqNLVmm/HYvH5jDaLF3lxBzyt1ajkQsyOOssGYJNE0fqSXjNTM6q7sqLd+F0hj4MAwxHRzxQwNk1qd3eW4NM/b/hxyZEm7sA04/alvyXWkGK4qRAAAxy+rbLUnW8z+CfCyp/mJM1a7EmZt/MJZUbawsX5H4yCBoI8NsbvRXqkeo4dKJcA+5agPB/iyi/77K0yhKpTGh4qYozJ9iCMgZz5QA87EcAeRbUgOQdRmhy6C9MfdP3JKt1EnaS3j4+BDSnR1yDmqBKxQQXxWg5SmNleEeiciaKFcpupHg9+lIOVIsDDo01FEj7uWG6VUACyJTGpC5sr91dt4qET/0oTcqZf+PQj7+9x2Egz+eG37470hV3sqZzhyQpIzBl5mRwB79dqiBcnLBfyxUvOS/+w3EtMPtbg7CcpWd6Zy/yCha2CEJek8Ls+n2bpMLMYcrZW9JG1S0wvO8IpVwKQoZDMjhsPFya1iFVxb7Co15EGLeHnthR2jHAWuuDjn+IkOCIq/CUf8qabyVrNQ6nuV26Q1G5yeQWujAvlEI0TKAAgGRLNR4vZPcrdAukzN1a/mVdk5DZcJTew0ohzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(186006)(82310400008)(1800799003)(40470700004)(36840700001)(46966006)(7696005)(6666004)(40460700003)(86362001)(40480700001)(1076003)(36860700001)(26005)(426003)(16526019)(336012)(36756003)(2616005)(83380400001)(47076005)(81166007)(82740400003)(356005)(5660300002)(41300700001)(8936002)(8676002)(4326008)(6916009)(2906002)(70586007)(70206006)(316002)(478600001)(44832011)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 13:05:37.2440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be040a4-0ee8-4251-e2bb-08db94eb7f25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 70 +---------------
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 81 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h    |  1 +
 3 files changed, 84 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0d602abd32ba..37bc6ebb7fad 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 8c3ee042556a..bb1cc6830a12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -212,3 +212,84 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
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
+static ssize_t amdgpu_fru_get_product_name(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%s\n", adev->product_name);
+}
+
+static DEVICE_ATTR(product_name, 0444, amdgpu_fru_get_product_name, NULL);
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
+static ssize_t amdgpu_fru_get_product_number(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%s\n", adev->product_number);
+}
+
+static DEVICE_ATTR(product_number, 0444, amdgpu_fru_get_product_number,
+		   NULL);
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
+static ssize_t amdgpu_fru_get_serial_number(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%s\n", adev->serial);
+}
+
+static DEVICE_ATTR(serial_number, 0444, amdgpu_fru_get_serial_number, NULL);
+
+static const struct attribute *amdgpu_fru_attributes[] = {
+	&dev_attr_product_name.attr,
+	&dev_attr_product_number.attr,
+	&dev_attr_serial_number.attr, NULL
+};
+
+int amdgpu_fru_sysfs_init(struct amdgpu_device *adev)
+{
+	if (!is_fru_eeprom_supported(adev, NULL))
+		return 0;
+
+	return sysfs_create_files(&adev->dev->kobj, amdgpu_fru_attributes);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
index 1308d976d60e..1bfac9300ed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -25,5 +25,6 @@
 #define __AMDGPU_FRU_EEPROM_H__
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
+int amdgpu_fru_sysfs_init(struct amdgpu_device *adev);
 
 #endif  // __AMDGPU_FRU_EEPROM_H__
-- 
2.25.1

