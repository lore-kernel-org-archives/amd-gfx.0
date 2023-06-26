Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEE1EB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D059810E217;
	Mon, 26 Jun 2023 15:04:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F420C10E217
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGxhmk9Jo4aQ3DgEYmRcxLNHX8sFpcEwzEtKj2cbZlxhN6wpjMk8WBN6ab740/3D8wEcLOlN42P0Hz0BTaxRqPYm0NR/ZRo73jQkF9mRF5z+2mUAQ2FMRGB5co4D4G9a9aEzauP/ExpdQSiq6WGILMijYzEQQDY7NSsbBPEKH/mEEQRGRUa9ZLImjaDLcI3T6EvSG/g7UAb4dVUoHrCAr8z+u6otZRd/PF5D/ChPIGkhjEJdVC6s0xX8pv+33jBgNt1LaBSOakKZpFqhQOCMsn6bU0h8TPMQk3nohNY/PsuvYCMm6qSpc6HG2mWs0w2Gw9P6JtvX6p0TrDZRj5BC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDx4lNOaw1jc8N0EChhnzn36miOFUxlR9Y2XPYzMDdM=;
 b=YoloiPzSrlnEJGIxwW/MZXO6oeXmtTyYaXGsGZcAk2YPQppLrpqyEochTBalu266ZDzg3Q4Z02MvdW7r8MtRzA7Cmz2goIess9tZIlvhItIpTJn+SV94UHq55/fmX8MMPv4JHLf7/Wu0VNJ3nBed9ExKy7toS+RarfWjqgmU4IDnUI0XAntzUqE5GdKXpF/fSkUTQCYHNfA5UaxNiz8zBwkHfZoipXhAUNo3L3dMa9ICBXrzX49BZA4ooJ6AZAAIoZY7lnF0QaHOD9V0xLNAi+zCF4Hv5nQElKpLy42s0kUopjY4qum8Li9H2S8bfLcCkkjrvdz4eurbRcexXOiT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDx4lNOaw1jc8N0EChhnzn36miOFUxlR9Y2XPYzMDdM=;
 b=EGqtyhLmvQ5IiOH0xhTtTG8+sEaCiSQDnShQ08PPel7XPGHpLI4eul2xe296+gVuUPeZSoiREfFGAwTEF5EZS4B4JMTGek49aBeMgYho0Bkt0xUU4nhtG2+LUIvBYuwpWaHC4H1KPQBQJnedsVZOjpwjXVyvRWYVRlpib4bvEus=
Received: from MW4PR04CA0351.namprd04.prod.outlook.com (2603:10b6:303:8a::26)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 15:04:25 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::40) by MW4PR04CA0351.outlook.office365.com
 (2603:10b6:303:8a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 15:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 15:04:25 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 10:04:24 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amd: Use attribute groups for PSP flashing attributes
Date: Mon, 26 Jun 2023 10:04:04 -0500
Message-ID: <20230626150407.1447-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626150407.1447-1-mario.limonciello@amd.com>
References: <20230626150407.1447-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 502877ba-fa05-4771-7ec9-08db7656a1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTDD+nO+DNvVqMThplGYKb1QBWwSv63Ao3F1zyB9rfhugpgPVxh9kfDiokM09wj/IlAgQbeYT8HgUkOX1n7mtB+cttMssn9Z+SZFyIB67ee+lmqNb6UPdHjy2r63VU6mvVgsfR2mFiNUgXRvvHvjCmPdbAybB3gyZKbArpE3uNO87vQzAobggmU9Z3OvNfEJ0rlfZWHMilOB2/Rpx8EkxPbO3h258cHsimpxVn8Id3d4AFwbT+34XYfyHPX/UF9BUwrtdsIN406VzYqxeUt9GYvckBUYw5SlyPkZYMxrVDqS9TVSPKr15cUFEuNzLkWZX6L0ulJx2pqSIDGEC9ctwsC577MQ2iowzCbww/zGOLC7UgekjdPvszDbvmFxmYqhQLwgCmPo4bDJlitKJw+Iejjjn6980CalSmGIeI0DhfHUFroE0gMKmBb60wfspaTUwbbFG75gRbeLoIiZb3OUUvLdkGIVFmrlQBSGYhGnHhCo159YHWwgjfeF43u19wa5DPzoZMu8o3YmqoO2UfnLqtw8MdlaWNj5snwYwwqjaUG7/pJkFduMVIJHG8iAEDnhJjP9b4y5DtRayJergVWiGsonrmXe26NttWiZ8itO8TIDoPLAP5OJx7BY9nkIhOkXvcIAMfLDETpZKMZ5KetpIWyNYogWgzz/j+ZS/nyRXS4VFSb2TtbsKu3Ljwys43hrvFHJAB2BKzHI7wBXLa6ZpB4dUzUrPKAD1fmtS9+xkojSrTgvAi6WoRbVMHCppix0/b4vL7C4K/QqEXvO+WIU6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(47076005)(2906002)(36860700001)(86362001)(82740400003)(82310400005)(336012)(41300700001)(81166007)(36756003)(8676002)(8936002)(7696005)(1076003)(426003)(83380400001)(356005)(6916009)(70206006)(478600001)(26005)(186003)(16526019)(6666004)(2616005)(316002)(4326008)(44832011)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:04:25.6866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 502877ba-fa05-4771-7ec9-08db7656a1e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Individually creating attributes can be racy, instead make attributes
using attribute groups and control their visibility with an is_visible
callback to only show when using appropriate products.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 49 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 -
 5 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 02b827785e399..a7ef43e25c758 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1004,7 +1004,6 @@ struct amdgpu_device {
 	bool                            has_pr3;
 
 	bool                            ucode_sysfs_en;
-	bool                            psp_sysfs_en;
 
 	/* Chip product information */
 	char				product_number[20];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c7d40873ee20..65fe0f3488679 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3907,14 +3907,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	} else
 		adev->ucode_sysfs_en = true;
 
-	r = amdgpu_psp_sysfs_init(adev);
-	if (r) {
-		adev->psp_sysfs_en = false;
-		if (!amdgpu_sriov_vf(adev))
-			DRM_ERROR("Creating psp sysfs failed\n");
-	} else
-		adev->psp_sysfs_en = true;
-
 	/*
 	 * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost.
 	 * Otherwise the mgpu fan boost feature will be skipped due to the
@@ -4064,8 +4056,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
-	if (adev->psp_sysfs_en)
-		amdgpu_psp_sysfs_fini(adev);
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 
 	/* disable ras feature must before hw fini */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 393b6fb7a71d3..99b8d3113d6af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2827,11 +2827,13 @@ static struct pci_error_handlers amdgpu_pci_err_handler = {
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
 extern const struct attribute_group amdgpu_vbios_version_attr_group;
+extern const struct attribute_group amdgpu_flash_attr_group;
 
 static const struct attribute_group *amdgpu_sysfs_groups[] = {
 	&amdgpu_vram_mgr_attr_group,
 	&amdgpu_gtt_mgr_attr_group,
 	&amdgpu_vbios_version_attr_group,
+	&amdgpu_flash_attr_group,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index eb687a338a1bd..4286c0b4beb90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3584,6 +3584,13 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	return 0;
 }
 
+static struct bin_attribute psp_vbflash_bin_attr = {
+	.attr = {.name = "psp_vbflash", .mode = 0660},
+	.size = 0,
+	.write = amdgpu_psp_vbflash_write,
+	.read = amdgpu_psp_vbflash_read,
+};
+
 static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -3600,39 +3607,39 @@ static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
 
 	return sysfs_emit(buf, "0x%x\n", vbflash_status);
 }
+static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
 
-static const struct bin_attribute psp_vbflash_bin_attr = {
-	.attr = {.name = "psp_vbflash", .mode = 0660},
-	.size = 0,
-	.write = amdgpu_psp_vbflash_write,
-	.read = amdgpu_psp_vbflash_read,
+static struct attribute *flash_attrs[] = {
+	&dev_attr_psp_vbflash_status.attr,
+	&psp_vbflash_bin_attr.attr,
+	NULL
 };
 
-static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
-
-int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
+static umode_t amdgpu_flash_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
 {
-	int ret = 0;
-	struct psp_context *psp = &adev->psp;
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
 
 	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+		return 0;
 
 	switch (adev->ip_versions[MP0_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
-		ret = sysfs_create_bin_file(&adev->dev->kobj, &psp_vbflash_bin_attr);
-		if (ret)
-			dev_err(adev->dev, "Failed to create device file psp_vbflash");
-		ret = device_create_file(adev->dev, &dev_attr_psp_vbflash_status);
-		if (ret)
-			dev_err(adev->dev, "Failed to create device file psp_vbflash_status");
-		return ret;
+		if (attr == &psp_vbflash_bin_attr.attr)
+			return 0660;
+		return 0440;
 	default:
 		return 0;
 	}
 }
 
+const struct attribute_group amdgpu_flash_attr_group = {
+	.attrs = flash_attrs,
+	.is_visible = amdgpu_flash_attr_is_visible,
+};
+
 const struct amd_ip_funcs psp_ip_funcs = {
 	.name = "psp",
 	.early_init = psp_early_init,
@@ -3661,12 +3668,6 @@ static int psp_sysfs_init(struct amdgpu_device *adev)
 	return ret;
 }
 
-void amdgpu_psp_sysfs_fini(struct amdgpu_device *adev)
-{
-	sysfs_remove_bin_file(&adev->dev->kobj, &psp_vbflash_bin_attr);
-	device_remove_file(adev->dev, &dev_attr_psp_vbflash_status);
-}
-
 static void psp_sysfs_fini(struct amdgpu_device *adev)
 {
 	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index cf4f60c661223..b441c07e5a16f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -522,5 +522,4 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_sysfs_init(struct amdgpu_device *adev);
-void amdgpu_psp_sysfs_fini(struct amdgpu_device *adev);
 #endif
-- 
2.34.1

