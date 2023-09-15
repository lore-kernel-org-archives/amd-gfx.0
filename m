Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698B6EEAA7D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 00:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEAE10E070;
	Fri, 15 Sep 2023 00:06:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0974010E070
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 00:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9e3plIWY8JZwgo3fqEQksQJcl+haYAkzBBuOjCulVej0QPBz2BRK+qp1iiKQrC3ZjQ3Z8zUOW6mzaGS1xPZD8xYruTiVEDkDkVh9S83GEgeMdjJEgJkNMeG6hBTcb7WCJwYiWQdFRlaEJsgrBthUlFqgoIJfs0nyaz/IuGwaPaDHUKAINNjlpEoiixU71RAfvqRIoyO8BPYk4rjnCy7Qiz1Mi7FVDhvz7ToN/zfOPcdL6lIPQEh2mJQ81Rulf/vypLpvtf6gz4zetCrOeX6L6lrIHKFZSjGPAWVSC6TJURgbbivGnFYrkJS1wCYvbJI6qyYh2XDT9czdfg6SgTn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wy4hNk6GAa6woxDap38ZZHkB0jQWyXWFqi6tJIBmk+U=;
 b=edzCQzR09KiMDCgy+IFqnDLZ+m5pW72kh0/fZaibkqM4ANtf05x4z5l6WSs7rpmbmTBqwen3xPuIkw04Bds1zwlhfntERkGQeCleLWJD4QA3iIu9hr4WsxvWtwLg4UsJdMuaUHKUaEKIwtGPdQmhaiI6WdkHLDSIGQvK+7EycP7wwwIIn69YfICCpOkYzdm7blKf0J0g0S3BaANv+mnZxERD5d2UHoxTWCSSFaE4NK5xcaOLkw2GIdH+XhHZ836KKPDvlTNFj1tiZKYGekCiLvW6cV4pWtz43GB+Cuj+DEx9H1YpCQ2w60vGCaQNWH2TiOkWUfCMCKpnG8WVS4Pd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy4hNk6GAa6woxDap38ZZHkB0jQWyXWFqi6tJIBmk+U=;
 b=fnLgK7bhlc3Yms68f8nazCwArEPYIaM3xtr7y0Z52jqwu1PJGTWBUaezw0NIorQFmQFXtj7Xk999HVOksgpjI8lo9x7hkSbek54q4cRfGs1PGkbCFXEa6LzMuStVpY0d2Xuu/hJwBQDXadyKqpaDQQi2IhwQW57opvT8Fa4iSDM=
Received: from MN2PR22CA0026.namprd22.prod.outlook.com (2603:10b6:208:238::31)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 00:06:26 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::7b) by MN2PR22CA0026.outlook.office365.com
 (2603:10b6:208:238::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 00:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 00:06:26 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 19:06:24 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use error code EOPNOTSUPP instead of ENOTSUPPT
Date: Fri, 15 Sep 2023 08:06:05 +0800
Message-ID: <20230915000605.1597561-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 9576b70b-54a6-4e7b-6721-08dbb57f9abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zkbt1Cuec93QaVG/0KhI9IQNIU2QifDD7mka40Zk4YOXXFEH/NyQjhLzPkJNjo0umIGoABV9K9Y/Y7qaziznqKoJY7ArGcJwM3vm+R03QhSLtUzdWFXmpTkFGBpnBKBgRWcWFS1WNL38EgVtZnXD7a/1Y1XSd0F6AQx8Z/6CUPTzPIXNS4h6gqoaYBq60bPdsoiUybjtVz7EbmjHR0Vprh/nJ+UM2Amf0ftaVBh8iSYJ/IL5KeAsxuWuI6LLk1ed6zLnELjUVDwVuOQLCjDh1Pd7C5pkr7VdEV6DbYYu/NQG0xLT8EvyUeRTrB+cOlquMZTtbb5/6Fz+zVS9uwIo1YKso5XYQp3Riu6508U5zqmjmukG4ePCJ+dE7gil4T2FGdwYra/R1mk5ytYeH7hgJ+AIp0ZwfPQlgw/Txit4DJlJKq/O617RjLsW+NnLw5D/a92eYZ5c28nA0zQXHUUWNEzJisF34dnnQpAW85o5P56CtDWNmv2fiFEBq80rM/JBbZ5esivMQLKyxOH5U9v+Pf8Ly3CL2iIOuu9g6i/XaUWE8fV6G8Zmayqg3dCRx1ufJa7xRWdtpR0b/53bUS7OfW8xEDX9lJsDZi+DMGe9lc6IOEGUSY4yPeHKGZjR9J/5O/lcvkD0kFunTwGD5GtukgeKH8hp620VfgQFDeK5eJnj5bJ2ZB6ZymYltNul0yUiJ9YpI7MRw8BJs407AdOXL65hZKbYTRZ4E08nIdLiXHalYUhrprLmgNQ5s5o7cF9Y5XKEUnsnCjHVFZBdAHOQDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(86362001)(36756003)(26005)(2616005)(426003)(336012)(16526019)(1076003)(478600001)(6666004)(7696005)(82740400003)(83380400001)(47076005)(81166007)(356005)(40480700001)(36860700001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(70586007)(70206006)(6916009)(30864003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 00:06:26.4297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9576b70b-54a6-4e7b-6721-08dbb57f9abf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP

$ find drivers/gpu/drm/amd -type f \
  -exec sed -i 's/\-ENOTSUPP/\-EOPNOTSUPP/g' {} \;

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  6 +++---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  4 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 18 +++++++++---------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 18 +++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         |  4 ++--
 10 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e055e06d020c..a7f0b6ccd137 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1268,7 +1268,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	r = pci_resize_resource(adev->pdev, 0, rbar_size);
 	if (r == -ENOSPC)
 		DRM_INFO("Not enough PCI address space for a large BAR.");
-	else if (r && r != -ENOTSUPP)
+	else if (r && r != -EOPNOTSUPP)
 		DRM_ERROR("Problem resizing BAR0 (%d).", r);
 
 	pci_assign_unassigned_bus_resources(adev->pdev->bus);
@@ -5747,7 +5747,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	if (!amdgpu_device_supports_baco(dev))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (ras && adev->ras_enabled &&
 	    adev->nbio.funcs->enable_doorbell_interrupt)
@@ -5763,7 +5763,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	int ret = 0;
 
 	if (!amdgpu_device_supports_baco(dev))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	ret = amdgpu_dpm_baco_exit(adev);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e3471293846f..ffd7035603cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2126,7 +2126,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	    ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
 		dev_info(&pdev->dev,
 			 "SME is not compatible with RAVEN\n");
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 #ifdef CONFIG_DRM_AMDGPU_SI
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 42fc0cc13fdd..e31b7f9fcddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -867,7 +867,7 @@ static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
 		return 0;
 	} else {
 		memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 65d2b9ae16bb..120b815a3f27 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -262,7 +262,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_XGMI)
 		q_properties->type = KFD_QUEUE_TYPE_SDMA_XGMI;
 	else
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE_AQL)
 		q_properties->format = KFD_QUEUE_FORMAT_AQL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e6f1620acdd4..2c88dbe2d718 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -147,7 +147,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 			   uint32_t *min,
 			   uint32_t *max)
 {
-	int ret = -ENOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	if (!min && !max)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 650482cedd1f..f48ec6c62307 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2591,7 +2591,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
 			dev_warn(smu->adev->dev, "GFXCLK_LIMITS not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 		if (!table_context->overdrive_table) {
 			dev_err(smu->adev->dev, "Overdrive is not initialized\n");
@@ -2637,7 +2637,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX)) {
 			dev_warn(smu->adev->dev, "UCLK_MAX not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 		if (size < 2) {
 			dev_info(smu->adev->dev, "invalid number of parameters: %d\n", size);
@@ -2680,7 +2680,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 	case PP_OD_EDIT_VDDC_CURVE:
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
 			dev_warn(smu->adev->dev, "GFXCLK_CURVE not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 		if (size < 3) {
 			dev_info(smu->adev->dev, "invalid number of parameters: %d\n", size);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 164c2264027d..828e6676e713 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2256,7 +2256,7 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 		if (!sienna_cichlid_is_od_feature_supported(od_settings,
 							    SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
 			dev_warn(smu->adev->dev, "GFXCLK_LIMITS not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
@@ -2306,7 +2306,7 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
 		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_UCLK_LIMITS)) {
 			dev_warn(smu->adev->dev, "UCLK_LIMITS not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a3cbe15c3123..a928ed20884c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1529,7 +1529,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
 			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
@@ -1590,7 +1590,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
 			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
@@ -1651,7 +1651,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_VDDGFX_OFFSET:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
 			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_0_get_od_setting_limits(smu,
@@ -1673,7 +1673,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_FAN_CURVE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		if (input[0] >= NUM_OD_FAN_MAX_POINTS - 1 ||
@@ -1711,7 +1711,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_0_get_od_setting_limits(smu,
@@ -1733,7 +1733,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_0_get_od_setting_limits(smu,
@@ -1755,7 +1755,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_0_get_od_setting_limits(smu,
@@ -1777,7 +1777,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_0_get_od_setting_limits(smu,
@@ -2356,7 +2356,7 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       i);
-		if (workload_type == -ENOTSUPP)
+		if (workload_type == -EOPNOTSUPP)
 			continue;
 		else if (workload_type < 0)
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 430ad1b05ba3..f85e0ef60fea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1515,7 +1515,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
 			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
@@ -1576,7 +1576,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
 			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
@@ -1637,7 +1637,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_VDDGFX_OFFSET:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
 			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_7_get_od_setting_limits(smu,
@@ -1659,7 +1659,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_FAN_CURVE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		if (input[0] >= NUM_OD_FAN_MAX_POINTS - 1 ||
@@ -1697,7 +1697,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_7_get_od_setting_limits(smu,
@@ -1719,7 +1719,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_7_get_od_setting_limits(smu,
@@ -1741,7 +1741,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_7_get_od_setting_limits(smu,
@@ -1763,7 +1763,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 		}
 
 		smu_v13_0_7_get_od_setting_limits(smu,
@@ -2310,7 +2310,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       i);
-		if (workload_type == -ENOTSUPP)
+		if (workload_type == -EOPNOTSUPP)
 			continue;
 		else if (workload_type < 0) {
 			result = -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b3682807cec2..f81ffe7ce7bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -50,7 +50,7 @@ static const char * const __smu_message_names[] = {
 #define smu_cmn_call_asic_func(intf, smu, args...)                             \
 	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ?                          \
 				     (smu)->ppt_funcs->intf(smu, ##args) :     \
-				     -ENOTSUPP) :                              \
+				     -EOPNOTSUPP) :                              \
 			    -EINVAL)
 
 static const char *smu_get_message_name(struct smu_context *smu,
@@ -492,7 +492,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 
 		mapping = smu->workload_map[index];
 		if (!mapping.valid_mapping)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		return mapping.map_to;
 
-- 
2.34.1

