Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6E6E7B60F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 13:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE50510E369;
	Wed,  4 Oct 2023 13:21:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA72010E369
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 13:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4OAisEGB6+ii+ioZRN07ys7ETevbxo2+idpq1hxoiLmPeQFIih72d8KmrYzLH7QGdaC1ehEl8osFn1m96r4lKpvuFkPsfiO0psikFET3+W9vwBGPPWxlNPjeQKKuOh7h7VT+HD0qfDoADDuazOuGRw/2BdONCUkmGmXwkgz3Z5bjZtatqt3FPCIDhdk7DgeF0myoguW4pMAEv0g2aUKuJGZKZU+j4O8G+BbveEnP05I7NJwzsjA+WCE5mtlMAOVHlr51htMx7X2EplVnchL7dnl0qZkhXKU10Vy5PtLsdN+4Gb6LjRoCDSgqf6XJ1MiIIxD6aGGxim7pJqXfUHHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3HimiP6Tm9E2xGu9Ind4VB7h+j9KhVwsnhwytCrBNE=;
 b=e3dMiV54BTJyJv3B3r5O5/zt8uDJnwi12j4WSi5V27OhMRPjhvGG4Epf+fWKYkZmbvSP/kMOGVriBHiFHtXp6KFVF7zqlgfOGv9CqGdH/XTKJqynriqWRjWgRlx1+f/eJ5zENwJ3rELrP6VDfsojdhl7HisKGSTv/9+f6QZLqcDJf2hwXL8SFJTgMDNx7MacwNGYUDJg+Pg9bqvXrr2PLI5E0TvasagXqoNil6LpcSsH3/8seuGBimzeDjPc9DhzSIvcuntCvqqOhcR3wilwydypikHKWTTfyxnYytHPSs6CEEKGo3thoJ+fedGB0X4H8VbRDYOticNEZnHnqd75Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3HimiP6Tm9E2xGu9Ind4VB7h+j9KhVwsnhwytCrBNE=;
 b=Has6MYrB6T6/lcY+89gkhWiRAXMEuAgkFLRLrdNW2zUIquP1i3HNTuD94k8C5LahGjHFGx08CrBaCU5bdGAqd80IuW0jYfyycKUVe0M66yM5SCQsoZPeJytpkwnID218xVYR7Ti+Nd8CwmdQn8YBtiJjmS+eX2+d5bvTGLGlSig=
Received: from PH8PR02CA0022.namprd02.prod.outlook.com (2603:10b6:510:2d0::12)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 13:21:03 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::16) by PH8PR02CA0022.outlook.office365.com
 (2603:10b6:510:2d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 13:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 13:21:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 08:21:00 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Refactor FRU product information
Date: Wed, 4 Oct 2023 18:50:37 +0530
Message-ID: <20231004132039.1506172-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004132039.1506172-1-lijo.lazar@amd.com>
References: <20231004132039.1506172-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a037572-30ef-4a69-bf8a-08dbc4dcc218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8O+3WdE6SO35KK8Q+ufbrOW95boqbM7Y3TsflDjaPbZ1Sf/JakTA2itdZkaMdGGVuF6UNzLd6BkywclHvpryOlj2hvWA/4NlPW/5E3+DV/GCjM06kGMIIbQ7DvGaNKbpHy+twyhe483UN+VabxMf4vony5cNZIWHn3eMuqOUQaRA6D4BLgJpuCPf3Rmx7yJklqWcLQRQlVPs2IDPY7C8Ltzt9k9xJ8WkiQUesBT2JCcuktcYtI+Anzo19r1ryZiqcmj+cwzjEE1Zv+zHzE1XtoJbxsfr4zjA/uVf8u4l9vOXlqkKmQaqeiXxEoDD8SeRAk7fYNuaWLlNj/tvd1QojU4sfd3bdBqbxpb5AE2ZHN6TAppMyVV0fbuB6xe/Dcjk/oFqagc1bG/n9O7ne/dqiCeBHI0LUgy5lvEhX/uT5AW2VGPXgl/BCEPUPd9vyMOSy9PhKNHiyYvNWPrSaQJZXQXnkD63h7nQ0BxLBUl+4J3QEOtJ/OrzQGe7IG3juqXecbdRgDJ6Qx3wjplcji0m8sG2JXJrkRlNQ9mLrvoxQtB1FBtkbOKhk40dRDJ24wTHH+Z//mdDGxtwP+i6VfXS9Mu/xduRgbtZVEgaqQ8dE+TbSm4QbxgYgTaaxqrnbfsdX0BPqgGvjMT253DD+A4iTsR6JNgc3ReuKgkg5F8hRMTX87t3lvdUjse24Ie4MFrRpjXurfP+mL1icYNCus5qdEdrFd4qK+u2qpazz1WwW0X81KIP7FfzjKOnwJWgUyug5jWNEM2yfJx2hCHOhptHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(36840700001)(46966006)(40470700004)(8676002)(30864003)(54906003)(40480700001)(70586007)(6916009)(2906002)(316002)(44832011)(41300700001)(70206006)(5660300002)(4326008)(36756003)(40460700003)(86362001)(2616005)(1076003)(26005)(83380400001)(16526019)(336012)(8936002)(6666004)(426003)(81166007)(356005)(7696005)(82740400003)(47076005)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:21:03.0683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a037572-30ef-4a69-bf8a-08dbc4dcc218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

Keep FRU related information together in a separate structure.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  8 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 ++
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 46 +++++++++++--------
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h    |  9 ++++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  4 --
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 -
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 -
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 -
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  2 -
 9 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d23fb4b5ad95..6b5dd5f9964a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -771,8 +771,8 @@ struct amdgpu_mqd {
 
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
-#define AMDGPU_PRODUCT_NAME_LEN 64
 struct amdgpu_reset_domain;
+struct amdgpu_fru_info;
 
 /*
  * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
@@ -1056,11 +1056,7 @@ struct amdgpu_device {
 
 	bool                            ucode_sysfs_en;
 
-	/* Chip product information */
-	char				product_number[20];
-	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
-	char				serial[20];
-
+	struct amdgpu_fru_info		*fru_info;
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t                        ras_hw_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 27c95bb02411..0cb702c3046a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4274,6 +4274,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	kfree(adev->bios);
 	adev->bios = NULL;
 
+	kfree(adev->fru_info);
+	adev->fru_info = NULL;
+
 	px = amdgpu_device_supports_px(adev_to_drm(adev));
 
 	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index d0ae9cada110..79ba74dfc576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -109,6 +109,7 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
+	struct amdgpu_fru_info *fru_info;
 	unsigned char buf[8], *pia;
 	u32 addr, fru_addr;
 	int size, len;
@@ -117,6 +118,19 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	if (!is_fru_eeprom_supported(adev, &fru_addr))
 		return 0;
 
+	if (!adev->fru_info) {
+		adev->fru_info = kzalloc(sizeof(*adev->fru_info), GFP_KERNEL);
+		if (!adev->fru_info)
+			return -ENOMEM;
+	}
+
+	fru_info = adev->fru_info;
+	/* For Arcturus-and-later, default value of serial_number is unique_id
+	 * so convert it to a 16-digit HEX string for convenience and
+	 * backwards-compatibility.
+	 */
+	sprintf(fru_info->serial, "%llx", adev->unique_id);
+
 	/* If algo exists, it means that the i2c_adapter's initialized */
 	if (!adev->pm.fru_eeprom_i2c_bus || !adev->pm.fru_eeprom_i2c_bus->algo) {
 		DRM_WARN("Cannot access FRU, EEPROM accessor not initialized");
@@ -192,21 +206,18 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	addr = 3 + 1 + (pia[3] & 0x3F);
 	if (addr + 1 >= len)
 		goto Out;
-	memcpy(adev->product_name, pia + addr + 1,
-	       min_t(size_t,
-		     sizeof(adev->product_name),
-		     pia[addr] & 0x3F));
-	adev->product_name[sizeof(adev->product_name) - 1] = '\0';
+	memcpy(fru_info->product_name, pia + addr + 1,
+	       min_t(size_t, sizeof(fru_info->product_name), pia[addr] & 0x3F));
+	fru_info->product_name[sizeof(fru_info->product_name) - 1] = '\0';
 
 	/* Go to the Product Part/Model Number field. */
 	addr += 1 + (pia[addr] & 0x3F);
 	if (addr + 1 >= len)
 		goto Out;
-	memcpy(adev->product_number, pia + addr + 1,
-	       min_t(size_t,
-		     sizeof(adev->product_number),
+	memcpy(fru_info->product_number, pia + addr + 1,
+	       min_t(size_t, sizeof(fru_info->product_number),
 		     pia[addr] & 0x3F));
-	adev->product_number[sizeof(adev->product_number) - 1] = '\0';
+	fru_info->product_number[sizeof(fru_info->product_number) - 1] = '\0';
 
 	/* Go to the Product Version field. */
 	addr += 1 + (pia[addr] & 0x3F);
@@ -215,10 +226,9 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	addr += 1 + (pia[addr] & 0x3F);
 	if (addr + 1 >= len)
 		goto Out;
-	memcpy(adev->serial, pia + addr + 1, min_t(size_t,
-						   sizeof(adev->serial),
-						   pia[addr] & 0x3F));
-	adev->serial[sizeof(adev->serial) - 1] = '\0';
+	memcpy(fru_info->serial, pia + addr + 1,
+	       min_t(size_t, sizeof(fru_info->serial), pia[addr] & 0x3F));
+	fru_info->serial[sizeof(fru_info->serial) - 1] = '\0';
 Out:
 	kfree(pia);
 	return 0;
@@ -241,7 +251,7 @@ static ssize_t amdgpu_fru_product_name_show(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return sysfs_emit(buf, "%s\n", adev->product_name);
+	return sysfs_emit(buf, "%s\n", adev->fru_info->product_name);
 }
 
 static DEVICE_ATTR(product_name, 0444, amdgpu_fru_product_name_show, NULL);
@@ -263,7 +273,7 @@ static ssize_t amdgpu_fru_product_number_show(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return sysfs_emit(buf, "%s\n", adev->product_number);
+	return sysfs_emit(buf, "%s\n", adev->fru_info->product_number);
 }
 
 static DEVICE_ATTR(product_number, 0444, amdgpu_fru_product_number_show, NULL);
@@ -285,7 +295,7 @@ static ssize_t amdgpu_fru_serial_number_show(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return sysfs_emit(buf, "%s\n", adev->serial);
+	return sysfs_emit(buf, "%s\n", adev->fru_info->serial);
 }
 
 static DEVICE_ATTR(serial_number, 0444, amdgpu_fru_serial_number_show, NULL);
@@ -299,7 +309,7 @@ static const struct attribute *amdgpu_fru_attributes[] = {
 
 int amdgpu_fru_sysfs_init(struct amdgpu_device *adev)
 {
-	if (!is_fru_eeprom_supported(adev, NULL))
+	if (!is_fru_eeprom_supported(adev, NULL) || !adev->fru_info)
 		return 0;
 
 	return sysfs_create_files(&adev->dev->kobj, amdgpu_fru_attributes);
@@ -307,7 +317,7 @@ int amdgpu_fru_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_fru_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (!is_fru_eeprom_supported(adev, NULL))
+	if (!is_fru_eeprom_supported(adev, NULL) || !adev->fru_info)
 		return;
 
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_fru_attributes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
index c817db17cfa7..c99c74811c78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -24,6 +24,15 @@
 #ifndef __AMDGPU_FRU_EEPROM_H__
 #define __AMDGPU_FRU_EEPROM_H__
 
+#define AMDGPU_PRODUCT_NAME_LEN 64
+
+/* FRU product information */
+struct amdgpu_fru_info {
+	char				product_number[20];
+	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
+	char				serial[20];
+};
+
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
 int amdgpu_fru_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_fru_sysfs_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index a2bbc180b160..44e4289b95cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2192,10 +2192,6 @@ static void arcturus_get_unique_id(struct smu_context *smu)
 
 	id = ((uint64_t)bottom32 << 32) | top32;
 	adev->unique_id = id;
-	/* For Arcturus-and-later, unique_id == serial_number, so convert it to a
-	 * 16-digit HEX string for convenience and backwards-compatibility
-	 */
-	sprintf(adev->serial, "%llx", id);
 }
 
 static int arcturus_set_df_cstate(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index ad2884088e69..28868f64d134 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1996,8 +1996,6 @@ static void sienna_cichlid_get_unique_id(struct smu_context *smu)
 out:
 
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
-	if (adev->serial[0] == '\0')
-		sprintf(adev->serial, "%016llx", adev->unique_id);
 }
 
 static int sienna_cichlid_get_uclk_dpm_states(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index b57184a3e24f..2373a66c7efd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1578,8 +1578,6 @@ static void aldebaran_get_unique_id(struct smu_context *smu)
 
 out:
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
-	if (adev->serial[0] == '\0')
-		sprintf(adev->serial, "%016llx", adev->unique_id);
 }
 
 static bool aldebaran_is_baco_supported(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a52da7bc787b..5757cbce147c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2264,8 +2264,6 @@ static void smu_v13_0_0_get_unique_id(struct smu_context *smu)
 
 out:
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
-	if (adev->serial[0] == '\0')
-		sprintf(adev->serial, "%016llx", adev->unique_id);
 }
 
 static int smu_v13_0_0_get_fan_speed_pwm(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index e0d74668fb96..e3bedaaf82d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1934,8 +1934,6 @@ static void smu_v13_0_6_get_unique_id(struct smu_context *smu)
 		(struct PPTable_t *)smu_table->driver_pptable;
 
 	adev->unique_id = pptable->PublicSerialNumber_AID;
-	if (adev->serial[0] == '\0')
-		sprintf(adev->serial, "%016llx", adev->unique_id);
 }
 
 static bool smu_v13_0_6_is_baco_supported(struct smu_context *smu)
-- 
2.25.1

