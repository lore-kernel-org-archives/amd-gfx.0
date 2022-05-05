Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F12C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B61C10E4E3;
	Thu,  5 May 2022 20:06:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7759B10E450
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8uXjZp1ZiU/B5FFW9Awg3/pQSazhAtBtTjCFi3N8MtFzRzH081Q892ffzyWQG3DK4pFhkFa+pcvpZIB3bwap8tsm6osgJh768jdYNNVkw6TzcekbEvvqjuYUail1/8E6ePC+hzzfqDgkSfzfL7PDVTcVN+E1i0Ip+dxmepbIoNmkHzlkBf9eEN5WItnJzqjbNZV6q3iBlrwjEmjq7LmFHPew5F+mpLH/znWJwm776Iq4WyNIusgGRba00K4hCYdhuTJHXB2IhOgPMfJk3rQrykZhAxEl4zuDq7npPJcvVJeXW/FNLwXaWpC5btzIyABsL6YrAZ/iUptZTREsDuf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKdWWtNoxTHyiz19Org9m6FdfMXrvT+dx2cLqR3KZ6E=;
 b=kLgLG3MylcQgV4YPstyPuI2gwo1Q4NC/7MDhKk/MvXEulmob8AbrApFFtMORtSPYg4QpVOsUL0Qc/4KT1zRLxuCKZRnIcQ5UxijHhH6mrO2mGRXzqiuEOw2wTklxB2H7xhJ/yPz1EvXHV1+0Jd6uHNGBe8HhRAulsxubXXnEAYTbI4RD/Qzs+KVZav64KvIXva4S0IlkzlVXrfMJoqoY3MCfwmPiXRPz4Xdc5VTuVa9hwvUiLZbXmLaWQyX3gIKQZLWDHdOblSH1mgVIoQgP+TKqVizWYOy+Jb7hOjG6yjVMfjM4b7Fha16Dwx8I9jrERR7usKu/ERM4bavfufx9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKdWWtNoxTHyiz19Org9m6FdfMXrvT+dx2cLqR3KZ6E=;
 b=SwH+FbBTm/gNAv2t5zFGKO7FwZc/NdJ/c0X4ldtQ8VlZY8j3IFPiu8Wk4rp1TjyjGd6cmIc/uvHKxul8/3eYg7/3jgoC9GcVq2XhNq5WiWeCe3qmGrM16O2PXTIgkMnlgqnZj+UxxJc8X6rsuoPM0KR4UtZbAENbJAc2hWIBkCA=
Received: from DS7PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:3bb::11)
 by DM6PR12MB4762.namprd12.prod.outlook.com (2603:10b6:5:7b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 20:06:04 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::e0) by DS7PR03CA0066.outlook.office365.com
 (2603:10b6:5:3bb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 5 May 2022 20:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:06:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:06:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu/psp: Add vbflash sysfs interface support
Date: Thu, 5 May 2022 16:05:37 -0400
Message-ID: <20220505200538.1293584-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200538.1293584-1-alexander.deucher@amd.com>
References: <20220505200538.1293584-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89010c44-7fbb-4a69-87d2-08da2ed2af59
X-MS-TrafficTypeDiagnostic: DM6PR12MB4762:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4762764DD6B1DFD32968303BF7C29@DM6PR12MB4762.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHtU80ixc29jV4m1Xs/NYdOKaNtaqoJ5lRmR821+kzXCw+CD3tosNlqNOAKCuOMuzc2XU+h9fjI8WBqUh/Xha3CeI5irQBvASp+kLvRqInzRXDgi6XTAw00IRsBO5V8EKYJk75StOzlihg05TLikTigw+1plx9EDAXLoCSBQx9DITK722D/kWGbv7kucyzkD3wS4rmthCs0YMRLw/EY+yJsOQaJna0gqWY/qe9/+/nMGVVBacwFwScShFS6vsJnENkYTe0fzcDHVvyvWLVzUgTWIMcIpwd6Olmbg/26eE6w+PHmA1a5aEqOvQRV1uSmh89ChlKGbTqQ3Vytg8rguylddHGrRxrwcWkYaVBo5JgQMhtelq4xhTjVzlakLkO/cscJqD7JSAjlXUYmKbkxowQ2fLlZp5B8rDU32AFaS49Rg/zGCg1EMVSLtm+mUOhj46t4riKYuWOMEa/kAgOz77W2g14T3ozYBxuUFY+sjkXxrE6Is1FXzHaTRVanWpGu9Yqw920xq4fs7nGzN1M2oo9TPMSV541Z/HfihtXKXl9ehjkgHNdpHMeFy6z9s1532YwX3Pz4PXFpvoFZ4/mGozWR/raiony9TPjUs8Amyyowto9dIXJMZcQpENPp67ALbKYrPG3ekcmmn7C3Z1GArH6BozcMvUHd+XkXzK/+M+nCKErKx7i4Bo7xg+cNaeoljvZjvuRuPrfUh4nI3Qo5d9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(54906003)(2906002)(316002)(26005)(6916009)(36860700001)(40460700003)(83380400001)(4326008)(86362001)(8676002)(6666004)(7696005)(70206006)(5660300002)(16526019)(186003)(8936002)(82310400005)(81166007)(70586007)(1076003)(336012)(426003)(47076005)(2616005)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:06:04.5299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89010c44-7fbb-4a69-87d2-08da2ed2af59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4762
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add sysfs interface to copy VBIOS.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 117 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   6 ++
 4 files changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 058f272e40ee..3c20c2eadf4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1013,6 +1013,7 @@ struct amdgpu_device {
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
+	bool                            psp_sysfs_en;
 
 	/* Chip product information */
 	char				product_number[16];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b07f295a449e..b583026dc893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3868,6 +3868,14 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	} else
 		adev->ucode_sysfs_en = true;
 
+	r = amdgpu_psp_sysfs_init(adev);
+	if (r) {
+		adev->psp_sysfs_en = false;
+		if (!amdgpu_sriov_vf(adev))
+			DRM_ERROR("Creating psp sysfs failed\n");
+	} else
+		adev->psp_sysfs_en = true;
+
 	/*
 	 * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost.
 	 * Otherwise the mgpu fan boost feature will be skipped due to the
@@ -4000,6 +4008,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
+	if (adev->psp_sysfs_en)
+		amdgpu_psp_sysfs_fini(adev);
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 
 	/* disable ras feature must before hw fini */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 25c90ad2c0b7..7d0a37a94ea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -42,6 +42,8 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
+#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*3)
+
 static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
 
@@ -3443,6 +3445,116 @@ int is_psp_fw_valid(struct psp_bin_desc bin)
 	return bin.size_bytes;
 }
 
+static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
+					struct bin_attribute *bin_attr,
+					char *buffer, loff_t pos, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	/* Safeguard against memory drain */
+	if (adev->psp.vbflash_image_size > AMD_VBIOS_FILE_MAX_SIZE_B) {
+		dev_err(adev->dev, "File size cannot exceed %u", AMD_VBIOS_FILE_MAX_SIZE_B);
+		vfree(adev->psp.vbflash_tmp_buf);
+		adev->psp.vbflash_tmp_buf = NULL;
+		adev->psp.vbflash_image_size = 0;
+		return -ENOMEM;
+	}
+
+	/* TODO Just allocate max for now and optimize to realloc later if needed */
+	if (!adev->psp.vbflash_tmp_buf) {
+		adev->psp.vbflash_tmp_buf = vmalloc(AMD_VBIOS_FILE_MAX_SIZE_B);
+		if (!adev->psp.vbflash_tmp_buf)
+			return -ENOMEM;
+	}
+
+	mutex_lock(&adev->psp.mutex);
+	memcpy(adev->psp.vbflash_tmp_buf + pos, buffer, count);
+	adev->psp.vbflash_image_size += count;
+	mutex_unlock(&adev->psp.mutex);
+
+	dev_info(adev->dev, "VBIOS flash write PSP done");
+
+	return count;
+}
+
+static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
+				       struct bin_attribute *bin_attr, char *buffer,
+				       loff_t pos, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_bo *fw_buf_bo = NULL;
+	uint64_t fw_pri_mc_addr;
+	void *fw_pri_cpu_addr;
+	int ret;
+
+	dev_info(adev->dev, "VBIOS flash to PSP started");
+
+	ret = amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,
+					AMDGPU_GPU_PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_VRAM,
+					&fw_buf_bo,
+					&fw_pri_mc_addr,
+					&fw_pri_cpu_addr);
+	if (ret)
+		goto rel_buf;
+
+	memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.vbflash_image_size);
+
+	mutex_lock(&adev->psp.mutex);
+	ret = psp_update_spirom(&adev->psp, fw_pri_mc_addr);
+	mutex_unlock(&adev->psp.mutex);
+
+	amdgpu_bo_free_kernel(&fw_buf_bo, &fw_pri_mc_addr, &fw_pri_cpu_addr);
+
+rel_buf:
+	vfree(adev->psp.vbflash_tmp_buf);
+	adev->psp.vbflash_tmp_buf = NULL;
+	adev->psp.vbflash_image_size = 0;
+
+	if (ret) {
+		dev_err(adev->dev, "Failed to load VBIOS FW, err = %d", ret);
+		return ret;
+	}
+
+	dev_info(adev->dev, "VBIOS flash to PSP done");
+	return 0;
+}
+
+static const struct bin_attribute psp_vbflash_bin_attr = {
+	.attr = {.name = "psp_vbflash", .mode = 0664},
+	.size = 0,
+	.write = amdgpu_psp_vbflash_write,
+	.read = amdgpu_psp_vbflash_read,
+};
+
+int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
+{
+	int ret = 0;
+	struct psp_context *psp = &adev->psp;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	switch (adev->ip_versions[MP0_HWIP][0]) {
+	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 7):
+		if (!psp->adev) {
+			psp->adev = adev;
+			psp_v13_0_set_psp_funcs(psp);
+		}
+		ret = sysfs_create_bin_file(&adev->dev->kobj, &psp_vbflash_bin_attr);
+		if (ret)
+			dev_err(adev->dev, "Failed to create device file psp_vbflash");
+		return ret;
+	default:
+		return 0;
+	}
+}
+
 const struct amd_ip_funcs psp_ip_funcs = {
 	.name = "psp",
 	.early_init = psp_early_init,
@@ -3471,6 +3583,11 @@ static int psp_sysfs_init(struct amdgpu_device *adev)
 	return ret;
 }
 
+void amdgpu_psp_sysfs_fini(struct amdgpu_device *adev)
+{
+	sysfs_remove_bin_file(&adev->dev->kobj, &psp_vbflash_bin_attr);
+}
+
 static void psp_sysfs_fini(struct amdgpu_device *adev)
 {
 	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 81ecbdeb1ddb..db7b7dbb9c93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -372,6 +372,9 @@ struct psp_context
 	struct psp_memory_training_context mem_train_ctx;
 
 	uint32_t			boot_cfg_bitmask;
+
+	char *vbflash_tmp_buf;
+	size_t vbflash_image_size;
 };
 
 struct amdgpu_psp_funcs {
@@ -501,4 +504,7 @@ int psp_load_fw_list(struct psp_context *psp,
 void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size);
 
 int is_psp_fw_valid(struct psp_bin_desc bin);
+
+int amdgpu_psp_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_psp_sysfs_fini(struct amdgpu_device *adev);
 #endif
-- 
2.35.1

