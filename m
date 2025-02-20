Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6ADC021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 08:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9B810E4A3;
	Thu, 20 Feb 2025 08:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mYr/eIG0";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDCA10E8E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 08:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gD7OJI6Vo+9IqKv2yOpyf4DyTJcEmrtMm1XaLFwR/wUPi3TUSFWdBNEtpjHpvTZMO/8p+hScdOX4wK4bhZlfwHjYTGbKQ9/WgdwVDL1wvTooF8vbHEpgZFfNlNI3OvcRiN5MBGbj27laSRqMh2PzkRm9y8rzYaNmgqws/Baw8i8UZfRp2aFBtKD1bv9BItxK47FOMgnbKU8PScHOqvKKd9GEr2ZRugt+gXBKUbxMHdRMnQ33KBL4PlQ96X2vS+1+04rwWCpIaioLMiZ2PykLLEs8ZIzffYAg/r05UVzkNqjQD7osSqBonaIS76aLltR6HycMIQR1vvDs/JNUucRwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1VRWMJ+syHXklDboee6BWjYAcQKy17h+EYrQorfVXI=;
 b=aQod8JuCy22mSqYQRnoCHjZ2DA8snaIP8cNjZmY1uf5VftcMhCUOxRvy0N5d4RC3CXQC7V68AXHs6NRKd8ovwF5RHN2pXJDexmzDQEzgXPG2PtllHRyW7x8Iw+XgocPMayu4jusChTjzXBgKDlduFzADeCpMHLZFnWtdATLxOkZh/FXVXvKtNKidIk/4UmcRPOHuk9SoeQaM7VtBU0wMTuyfn1wTHx+AZhDE9HM7oe6NdpDzddc8i/w8ifpzppq3f3Vehw9TPQNV1pauLqv55Jc9nLuI3DKJlswxKZMlFfDgqR1wII0Tf6lho826/8W5JuF0ZH6jvlTk7a0gdbijaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1VRWMJ+syHXklDboee6BWjYAcQKy17h+EYrQorfVXI=;
 b=mYr/eIG0Rm3ri8ulOhB/8ya/ywBn6Q4qRq5dciago0Nzdu65X66WHgwzTyz02Y/G7UiXxAS42wNofpQEbc36hbCVKJeikYUxvOrGwH7ddSbZOWNy24pTTS2mEQKHEkjggaNRzYqaSCe3t7zKgy0anKpbxT+rwjDKdHxPNEe0SOM=
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 20 Feb
 2025 08:31:02 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::b6) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Thu,
 20 Feb 2025 08:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 08:31:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:31:00 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Feb 2025 02:30:53 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Vitaly
 Prosyak" <vitaly.prosyak@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: add support for checking SDMA reset
 capability
Date: Thu, 20 Feb 2025 16:30:52 +0800
Message-ID: <20250220083053.3834177-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: d97214b6-dfc9-4836-b211-08dd5188e8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yULWc6gqli61wknNcVCVp+j+6TA9es3VImGLkXOtYan+o1pbusWpfsvElXj9?=
 =?us-ascii?Q?UScJNEkNBgIke1oMdCTWUcJkhVKefdKjsZN0akhha7u7nkOQuFO2YMVafkyn?=
 =?us-ascii?Q?xgBlKXDvWTL5RVulHD9pBsvqHsp/zvy+wmOrmBX3HxafZib4NL9E1siyLPdC?=
 =?us-ascii?Q?5zIgH9kFbL/TKQSXkHI1xqPWjt4c7VF03YxfVFB8e8dmOYQZi6zaQN/aSaeC?=
 =?us-ascii?Q?hpNzZOgpqb8jDjIKee/ohoh3kOHYpYgPelMlmZfX8KWItbcypnCvmXUBlL6X?=
 =?us-ascii?Q?Edyatt9ZD+nf3qgyPkcptQ5jEPMohjp5HixJlwYXUXQVuirwI0YQzXCg++Ae?=
 =?us-ascii?Q?nIDlSUdp1WRoi3aMBtDuR6ffr3xRQEL/CZa3/xY7jbIv2TQvsoTio4dg0tI8?=
 =?us-ascii?Q?cctlg9eKdr2IRGk7ZM4jhfJ2EUuv/9Ey3TMI76g1XW7KWZxDEtKpH99tEMxT?=
 =?us-ascii?Q?b0ki81sAUP7E0RvzsKvzd0UW+L7vsoe9D1hF9zkXFGQzZ2qjwl/RThwTUnLZ?=
 =?us-ascii?Q?ESyN+NAMvzleN/elTS+Og1w7OuIXDcpFJMFBo4zHgEmJpV4Js5tLbGYspWRr?=
 =?us-ascii?Q?t8kvA9ALS6tcvAyrqUs9/vntFmsjAGuG8byJaB8ukZHFmz6d/8QHL/yQxKB5?=
 =?us-ascii?Q?3sbJmMauQfp250UWig6ekYRkaN8z7r5B6u4IeQg75O0GRxwtPnHw6dZAS1EP?=
 =?us-ascii?Q?UpJfdT0eWbqkptja9C0Ltpxk6VKd+/UdtGOgmG4ckkreNtEpJGO/T87ujh+L?=
 =?us-ascii?Q?p8RLTy64L6D4WF4OGpG6AKBCcnCu2wruq/9hsHGsZAIXp7k9IxbHUfGLC0Bx?=
 =?us-ascii?Q?ANy6/Gp/xfcKd+cA/Pfl68VORFSWba2uDxKzyCRLzf3Kp90INOY3jss7FoKe?=
 =?us-ascii?Q?S+mcL4+rkplOZI30L/yKUnhSE4eAWMVFiYNi+Oy9sbbx5NLUP9uv6WdESoOD?=
 =?us-ascii?Q?uMA42UEkAxqbmfeU8En+HB5Bk/VF1I25UhV4SFKwZ6zgt33sIvvFMPobYafI?=
 =?us-ascii?Q?YBO3h6PLF0gg5MHPOsq98mZ9lclnqtU2DIwu6SYTJuk9qh1R+NmOxu+LUCNX?=
 =?us-ascii?Q?e88w5gpys763lZP7nK9+QLDXLqcof7nHdATzT7jm9goOL6RBkK/rZS0DZn+M?=
 =?us-ascii?Q?WZhQWcrFumLuyM3JyR7GnsBhxKdzweHjTv/sFP5MCFLGVuXcKySgOs2tstXl?=
 =?us-ascii?Q?CW8lNq8Xxq/ozZs1wGTZF8JOSVUNLokvePxYnRskAvBkZ+N2z64PVRxQnewD?=
 =?us-ascii?Q?unhtl5ZanXOwVZx3yaqF6XI7njyr4jo6Xe2PN3iyL0u79RrUGIVTr3r6H/Z8?=
 =?us-ascii?Q?l/+DFKvUunkRrRot38N/QTS/e9q7A0a2C3G+HB/WHLFIZsSmD2ycD5XWxZOP?=
 =?us-ascii?Q?gOKdQrv+R4m9Y1MoO1Wck0iHOJSq33Q/n6pnM7cGZ++Snu9fPIcHyAjip4RE?=
 =?us-ascii?Q?mROuIFbIauFZJjmIhvW7mZmpyvORANpHTWFpX2sflPb3d1ztQKdXEApoiXQm?=
 =?us-ascii?Q?6OJ2cUsjrNtFTU0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:31:01.7653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d97214b6-dfc9-4836-b211-08dd5188e8c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

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
index faae9bf48aa4..26209d5ff787 100644
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
+ * It returns -EOPNOTSUPP if the hardware does not support software SMU or
+ * if the feature is not supported.
+ */
+int amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
+
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
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
index 1f5ac7e0230d..353a10119dc5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -603,5 +603,6 @@ int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
 ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 				      enum pp_pm_policy p_type, char *buf);
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
+int amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0b32c6cf6924..f860590ef893 100644
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
+ * It returns 0 if supported, -EOPNOTSUPP otherwise.
+ */
+int smu_reset_sdma_is_supported(struct smu_context *smu)
+{
+	int ret = 0;
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
index 3630593bce61..090a2b3b81a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1376,6 +1376,10 @@ struct pptable_funcs {
 	 * @reset_sdma: message SMU to soft reset sdma instance.
 	 */
 	int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
+	/**
+	 * @reset_sdma_is_supported: Check if support resets the SDMA engine.
+	 */
+	int (*reset_sdma_is_supported)(struct smu_context *smu);
 
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
@@ -1637,6 +1641,7 @@ int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 int smu_send_rma_reason(struct smu_context *smu);
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
+int smu_reset_sdma_is_supported(struct smu_context *smu);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9f2de69f53b2..a200ac7b15a8 100644
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
+ * It returns -EOPNOTSUPP if the capability is not supported.
+ */
+static int smu_v13_0_6_reset_sdma_is_supported(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET))) {
+		dev_info(smu->adev->dev,
+			"SDMA reset capability is not supported\n");
+		ret = EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
 static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
 
-	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
+	if (smu_v13_0_6_reset_sdma_is_supported(smu))
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

