Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E25C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 06:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AFB10E227;
	Fri, 21 Feb 2025 06:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2//AFZX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53D510E227
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 06:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6GFTyzKwO6s1yUmS1W3B5m1Gqi8DPleGLIjLc3ut6Rtw9oBdvprAwy6+1heji7rqNrHlWu0HzS73s8Ol6PikZwLta9GyZf1ey7s/6+bFLU1mqrpzABjDtqKLDi90yTMUyRWFmHxpm/PRffNKiksXRXFfzAnb7QkxErsnulFPaXKv/RUW/wgWri8fatls/siCvQ67C72AWsBJMwcmzrbLrSEUk967OB33TKA2/SUxQSyCqHZ5TNIKeO5qSvOUljP7sAu0gNK37yTUCYW+imtS5Bx2pyJsoad4EBrjHGsn5Tu2dtdkTG/8dW77nSlJo3InW+4bZOf9d1OLbxbRLy6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU0HIQO3c2HyqzJy2ANdg+mdwc3B3LRn+kQEhzw4gZ8=;
 b=BXI5LeVdeU74komhSv1RsMRRCvlHnjvQBz/vCsssbAoHMw8WeZ783PeDHX6bE/EqZNtHIVvBBvQmVxLu5aPX4CreplR3x/tOGMvNAVEjwolGyqwPFpSkWfG1NrLagF1r7KfR/ykVcwnd6mdLqUAXaNILeCPz45LdnfIsfK46TA7h0BdihUcOKWqSpOeL676LmZAN/445pwjc4RSm/zqtfKBQmiTxFWJ9/tuxtH+Q6ZZAb7jyB/nrblfo2L/gz/EsVgkhpj9GoRRqSdhHkeZmBPPIZA8UiQVelWNJrw58g/5vPuEt3x2svzBgbOlSXoYmo8sYOiaraqAOkboiXFlHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU0HIQO3c2HyqzJy2ANdg+mdwc3B3LRn+kQEhzw4gZ8=;
 b=I2//AFZXBDgpNHuVML6X4wI200ZO+mkDvz7xJ1637s6T1KiPKomAPoTAdsqMTwnyhTWtEp9OX0U6L0ZubGSBW6hanKPBZsdvmu0VQqjylMRoUJ0kYr7AjSsy4dnbk7rafBhIVAPUwIWe0kiW+4q/tUKAirQX1+UWR8pEHM9gWoU=
Received: from BN9PR03CA0397.namprd03.prod.outlook.com (2603:10b6:408:111::12)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 06:17:54 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::90) by BN9PR03CA0397.outlook.office365.com
 (2603:10b6:408:111::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 06:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 06:17:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 00:17:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 00:17:53 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 21 Feb 2025 00:17:51 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, "Jiadong
 Zhu" <Jiadong.Zhu@amd.com>, <tim.huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH v3 1/2] drm/amd/pm: add support for checking SDMA reset
 capability
Date: Fri, 21 Feb 2025 14:17:45 +0800
Message-ID: <20250221061746.3949672-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: f7729b81-e6a7-426b-f7b3-08dd523f7a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PvVaGjsW/win9+Ds6sa7Oj9yhZQ2GIoK+tPpSW9HBk0hBxWdzgLq8vkLSkcA?=
 =?us-ascii?Q?RCGfNvB+Qr8o37bqVNpaSiMGWU5sFZ4CSDkd5HdEYi60ghQdNacv53SpI3Hq?=
 =?us-ascii?Q?waEh745oWU1lqGvawqtwO8T17SCnRbtzFE0roBZp59Mb2isaHkydjMUWCiLH?=
 =?us-ascii?Q?l+6zpfmQOQPAp8P1vUyyFpb9pJlGWk9ea3KNnEMFp/4SRgISYbo6Wr29i2sd?=
 =?us-ascii?Q?8Z4WN/0VzvVg/LeU6GTRVQqdtNPCGCCVJYMvTGVgTI9fM9OpdiemgquJKDJh?=
 =?us-ascii?Q?KRtIPIPQ5NClozpl+rNCFG4urgDDgQqv6pXkj1ATREqGCA3IP96DbdCOST6r?=
 =?us-ascii?Q?j8A/UxVzYIGJDAZTEtsSv6F+OFAK9e+K/oKqzBCsjus7Owu8O65TtNdwEO1Q?=
 =?us-ascii?Q?iGx0KBHflUmMd6Gr7mxOoVpxYK6l9pAfdFnZXA2IvW8+bKDj0TJKJ0B4OnyY?=
 =?us-ascii?Q?g9mQe3EJh34sJflgrJcPMalpXn7YRG0uISOLk7+geS3FtCebU6kSHwcoXd1j?=
 =?us-ascii?Q?DEZuTw0a+NoZ4nY7g5Fr+CeVnQrYH/KYoKdgjQnw8DQlewcfh9pFGXvmaDId?=
 =?us-ascii?Q?+HEjJz7Ue2BLYbLuhGA8+JqI/7l0twdf1NDN89EVg6X75uFDaxEvl3atXkek?=
 =?us-ascii?Q?dujgfxgtwyQsvMPms8L9qNqVCv2qCCjp6nt2oH/pToPPAnU0u4H+9/McODOg?=
 =?us-ascii?Q?/UAcFELGT/l+HQ+XEx1qAaO/6AXugzpBfGySm4rKtJZ3niAjXIWSs97j3OFg?=
 =?us-ascii?Q?Uo88TVxjAUPbTJjwTSuUwD0LER4UKq7VpUe1YTYRh89DAmT9Y9V+syk9Uhl7?=
 =?us-ascii?Q?G0R9dlxusrfTuX78VuLOr5URR/7r0Dfr7l3O1Z8kINDui2DFrUSzDmmFuQHM?=
 =?us-ascii?Q?uhFIPQzoXMNtE7psvj/XhxTUtWBF6dqYX2oevg7LGSBad4TvXKM3Vz9NvJ2v?=
 =?us-ascii?Q?Xbo2FsVQG1UYhKgK4Vqi5footUe0uzObFu7sK+sRHXlBPmnyohvhHpGgFx2T?=
 =?us-ascii?Q?/ds2cnQUyyv6etieuV9McJF1tW8epswA2PC+UiJO7eL1vn/gO6G3Die6UM0g?=
 =?us-ascii?Q?LX1sb1CdouBGsswuNjiR+EmyEx9YjvVY5KVQUinOHYppVQg9+Lxl4nb8EH7T?=
 =?us-ascii?Q?FK/Y6PNvPIy4mkMx9JDocitWZyucvzXP/iB1oLyInWyWL5532yeEeOb9XECj?=
 =?us-ascii?Q?dAUpXwpw6qH+WY7pHA0B5iPDOP3j09bW7p7z4nbKriaMhhKm2w/lSMb9cu7e?=
 =?us-ascii?Q?AXDSRKOg0TXBlM7VqNfc5Hbk0g/ZYRncGasvOGkQa+dkCx0ypXMGmJkyA3vI?=
 =?us-ascii?Q?0nWKDhZXsNfDnCXTa/+j+lUGTjcQDld+DUT34VX7o2vXOFbJd2/oPD8n9YPf?=
 =?us-ascii?Q?jwMxXvWqUf6qrQT4ooAUp1M124J0jvZQ+hjmQlz7qvqwZhuirn0uLCIfx2uk?=
 =?us-ascii?Q?0Ghi0XivWarg3vTfuz342+v5kuazwqoWp9dV0884Ti7NC60PAYuw88HKmLvG?=
 =?us-ascii?Q?rERo9R56ua5g6AI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 06:17:54.2627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7729b81-e6a7-426b-f7b3-08dd523f7a35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

This patch introduces a new function to check if the SMU supports resetting the SDMA engine.
This capability check ensures that the driver does not attempt to reset the SDMA engine
on hardware that does not support it.

The following changes are included:
- New function `amdgpu_dpm_reset_sdma_is_supported` to check SDMA reset
  support at the AMDGPU driver level.
- New function `smu_reset_sdma_is_supported` to check SDMA reset support
  at the SMU level.
- Implementation of `smu_v13_0_6_reset_sdma_is_supported` for the specific
  SMU version v13.0.6.
- Updated `smu_v13_0_6_reset_sdma` to use the new capability check before
  attempting to reset the SDMA engine.

v3: change smu_reset_sdma_is_supported type to bool (Tim)

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 23 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 ++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++++++++++-
 5 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index faae9bf48aa4..7c4ff12269d9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -722,6 +722,29 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 	return ret;
 }
 
+/**
+ * amdgpu_dpm_reset_sdma_is_supported - Check if SDMA reset is supported
+ * @adev: amdgpu_device pointer
+ *
+ * This function checks if the SMU supports resetting the SDMA engine.
+ * It returns false if the hardware does not support software SMU or
+ * if the feature is not supported.
+ */
+bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	bool ret;
+
+	if (!is_support_sw_smu(adev))
+		return false;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_reset_sdma_is_supported(smu);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 1f5ac7e0230d..9fb26b5c8ae7 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -603,5 +603,6 @@ int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
 ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 				      enum pp_pm_policy p_type, char *buf);
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
+bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0b32c6cf6924..d71c8c58caa4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3907,6 +3907,23 @@ int smu_send_rma_reason(struct smu_context *smu)
 	return ret;
 }
 
+/**
+ * smu_reset_sdma_is_supported - Check if SDMA reset is supported by SMU
+ * @smu: smu_context pointer
+ *
+ * This function checks if the SMU supports resetting the SDMA engine.
+ * It returns true if supported, false otherwise.
+ */
+bool smu_reset_sdma_is_supported(struct smu_context *smu)
+{
+	bool ret = false;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->reset_sdma_is_supported)
+		ret = smu->ppt_funcs->reset_sdma_is_supported(smu);
+
+	return ret;
+}
+
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3630593bce61..3ba169639f54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1376,6 +1376,10 @@ struct pptable_funcs {
 	 * @reset_sdma: message SMU to soft reset sdma instance.
 	 */
 	int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
+	/**
+	 * @reset_sdma_is_supported: Check if support resets the SDMA engine.
+	 */
+	bool (*reset_sdma_is_supported)(struct smu_context *smu);
 
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
@@ -1637,6 +1641,7 @@ int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 int smu_send_rma_reason(struct smu_context *smu);
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
+bool smu_reset_sdma_is_supported(struct smu_context *smu);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9f2de69f53b2..9f276f393b81 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2902,11 +2902,31 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	return ret;
 }
 
+/**
+ * smu_v13_0_6_reset_sdma_is_supported - Check if SDMA reset is supported
+ * @smu: smu_context pointer
+ *
+ * This function checks if the SMU supports resetting the SDMA engine.
+ * It returns false if the capability is not supported.
+ */
+static bool smu_v13_0_6_reset_sdma_is_supported(struct smu_context *smu)
+{
+	bool ret = true;
+
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET))) {
+		dev_info(smu->adev->dev,
+			"SDMA reset capability is not supported\n");
+		ret = false;
+	}
+
+	return ret;
+}
+
 static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
 
-	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
+	if (!smu_v13_0_6_reset_sdma_is_supported(smu))
 		return -EOPNOTSUPP;
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
@@ -3590,6 +3610,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
 	.reset_sdma = smu_v13_0_6_reset_sdma,
+	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

