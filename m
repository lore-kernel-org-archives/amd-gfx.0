Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE410C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 06:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121F210F565;
	Fri,  4 Mar 2022 06:50:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657CD10F565
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 06:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwbROUrPUXiVkw0PoWrAtu3J4lc2cy854dlED1MUYfqbxUp9uTMKB6oRG/6XJfgTl1mhl66Ypanp6pdRfYRQ2QRjI12xVSVduO357nXGZFvBT1nGapzPAUg/iqEUeCf2Y9cLpkIeAZtXu2wxeBKdX3PTlkQCB1if9gKdw4Knzr7V2k5yGIeI8RCGZaRqJfDVqUqyEW/wvNB3X++MfgWdIl4kvbFutEcmT0rBD+A3Cm8WJla+y2PE4TqOm3vyg3uMCV24RPZMQucBZ8MHaC+QCzwBgqyETnlVgvviZxEY4e0nckNfpPfZFq+LLEd15o2M/M/zjCUHjfHurOT51gbROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xBYEFsD+QJZvWYYVoCB8x2fx9N2vBe2sv/+wcUGuoU=;
 b=VoB+Df0qLCe2kemcXK1LByBly9yA6Tp+VtB+gedlCG0aod5Na7s8o51chsRnwabk2aEaDY40T9jUXIoqCJ9x0j2xF7XbyFsL4EQ7n3QcOcTGqeNtZLmBwmwbgGRheHz5IERPnCTIcHeglvY6zrIXToRakhe8i0TihaEuadRrHSn+AglEyydDxTU7J8iXbpSEa3PUS1Vmvo69RwLOt7qJBLhoX5TJ/VYf0/aP7zcge4fi2ZeYZYy6udgKCzSWaFfPyD2kRLS00fQhIZy1EXN7g/6Nfe1djv2llP4lSLha0JquF+UD2ocSUKWbepT14FTalVfVBkOZzpGYkOr1D02HJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xBYEFsD+QJZvWYYVoCB8x2fx9N2vBe2sv/+wcUGuoU=;
 b=IJphoLHpmwZXucTG+oU+Aq/7UM3upAbHwaNaCvyH0Wmi5aQyN/Ld3jyyfiBwFCpBtR8li+Q2s3iLB3VrN5aYYxr36ZbSam00j5Hw2uy3NcNB5LSTtECQCzFV+vlU5qKwJgg+s2GVnPYP8NnYucRAyCUILLORvZBB594Z9O/mCx4=
Received: from DM6PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:100::38)
 by MN2PR12MB3215.namprd12.prod.outlook.com (2603:10b6:208:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 06:50:42 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::90) by DM6PR03CA0061.outlook.office365.com
 (2603:10b6:5:100::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Fri, 4 Mar 2022 06:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 06:50:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 00:50:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 22:50:40 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 00:50:39 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Maria.Joo@amd.com>
Subject: [PATCH Review 1/2] drm/amd/pm: add send bad channel info function
Date: Fri, 4 Mar 2022 14:50:36 +0800
Message-ID: <20220304065037.1050-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fcb2ec1-d440-48a5-8bc4-08d9fdab4cd6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3215F4A3514588B84B6065189A059@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxvjHG23IOScGZ923+YFhCuveUkGEoj8w60hGKPirt4Cw/c6DOMQBQ3NB7RsiFSYMMRMxZ1ZBXrTjlIb3wala5BVAMDo5G80364mcuj9tzsqQrFeDsAa0Od5OWjCTvjiJ0L6UjqurIWFkIMstxkTfL4hUp6A+uUAm5DXUrEswnnqgsn6WO7k5suB7bY8lDDxrrnQYUnKI2G5SpxG5a8tku7Lge71RuljtouG+6UOPPCv0yFf3nyhoBa7wMMYuuZHEU3tkS4swZp2K4HRSgaKcEtdoi886WOR17vVD9C/BgCd18mHaVQFDiV2BnFbtYGoeDTfereplEXeCMfjjMm/NGD9AnTF+BOxOHCmXXUPxbyHxrZ0qFFZv2MRW4PEKD0jdIEptYKmK3h5sQrRvCKf/qGI/hZZP7ni8B2YkHyUryYWLO76XLb0CTMckzpXb6pjgdL+7U1G2OmjqioV6P/G7CSQ/orDUeIqvZTPXVbl62cgJ0qWdPtDkPfVgJEI/PbmdFHy2/LbiFChka/GAyXy8Ok+ppcR64Dd1pJ93EZv0un8fqjKjYqN3SjsNltDs0UUYkaJ/PdAfV0JHFAqtY1vXvkGrI366fn4xZr7M/m2D2pe5GRHtKUZSldkdo2VKVxmAydRuDftcHs+xaWMLTQKDPho2EVAG1CRbwoNsliwXo+S7gu5V3hYX0/tRNRuxNdJyqSxNMCERxt9XOfJqbBlMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(47076005)(70586007)(36860700001)(70206006)(2616005)(186003)(26005)(82310400004)(508600001)(426003)(336012)(1076003)(36756003)(2906002)(83380400001)(7696005)(8936002)(356005)(81166007)(86362001)(40460700003)(5660300002)(110136005)(316002)(6636002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:50:41.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcb2ec1-d440-48a5-8bc4-08d9fdab4cd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

support message SMU update bad channel info to update HBM bad channel
info in OOB table

Change-Id: I1e50ed8118f4c1aaefb04c040e59ae4918cdc295
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 12 ++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++
 .../pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 43 +++++++++++++++++++
 7 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1d63f1e8884c..9a892d6d1d7a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -507,6 +507,18 @@ int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
 	return ret;
 }
 
+int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t size)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_send_hbm_bad_channel_flag(smu, size);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ddfa55b59d02..3e78b3057277 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -412,6 +412,7 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version);
 int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool enable);
 int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size);
+int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t size);
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				       enum pp_clock_type type,
 				       uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7e79a67bb8ef..f1544755d8b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3052,3 +3052,13 @@ int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size)
 
 	return ret;
 }
+
+int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->send_hbm_bad_channel_flag)
+		ret = smu->ppt_funcs->send_hbm_bad_channel_flag(smu, size);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fbef3ab8d487..ef57b6089c69 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1292,6 +1292,12 @@ struct pptable_funcs {
 	 * @set_config_table: Apply the input DriverSmuConfig table settings.
 	 */
 	int (*set_config_table)(struct smu_context *smu, struct config_table_setting *table);
+
+	/**
+	 * @sned_hbm_bad_channel_flag:  message SMU to update bad channel info
+	 *										of SMUBUS table.
+	 */
+	int (*send_hbm_bad_channel_flag)(struct smu_context *smu, uint32_t size);
 };
 
 typedef enum {
@@ -1428,5 +1434,6 @@ int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
 int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
 void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
+int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
index ab66a4b9e438..0f498baf6838 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
@@ -103,7 +103,8 @@
 #define PPSMC_MSG_GfxDriverResetRecovery	0x42
 #define PPSMC_MSG_BoardPowerCalibration 	0x43
 #define PPSMC_MSG_HeavySBR                      0x45
-#define PPSMC_Message_Count			0x46
+#define PPSMC_MSG_SetBadHBMPagesRetiredFlagsPerChannel	0x46
+#define PPSMC_Message_Count			0x47
 
 
 //PPSMC Reset Types
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index d787c3b9fc52..9f6f306eeca0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -232,7 +232,8 @@
 	__SMU_DUMMY_MAP(ForceGfxVid),             \
 	__SMU_DUMMY_MAP(Spare0),                  \
 	__SMU_DUMMY_MAP(UnforceGfxVid),           \
-	__SMU_DUMMY_MAP(HeavySBR),
+	__SMU_DUMMY_MAP(HeavySBR),			\
+	__SMU_DUMMY_MAP(SetBadHBMPagesRetiredFlagsPerChannel),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 890acc4e2cb8..cd81f848d45a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -82,6 +82,12 @@
  */
 #define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
 
+/*
+ * SMU support BAD CHENNEL info MSG since version 68.51.00,
+ * use this to check ECCTALE feature whether support
+ */
+#define SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION 0x00443300
+
 static const struct smu_temperature_range smu13_thermal_policy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
@@ -140,6 +146,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
 	MSG_MAP(BoardPowerCalibration,		     PPSMC_MSG_BoardPowerCalibration,		0),
 	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,                        0),
+	MSG_MAP(SetBadHBMPagesRetiredFlagsPerChannel,	PPSMC_MSG_SetBadHBMPagesRetiredFlagsPerChannel,	0),
 };
 
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] = {
@@ -1997,6 +2004,41 @@ static int aldebaran_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	return ret;
 }
 
+static int aldebaran_check_bad_channel_info_support(struct smu_context *smu)
+{
+	uint32_t if_version = 0xff, smu_version = 0xff;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret) {
+		/* return not support if failed get smu_version */
+		ret = -EOPNOTSUPP;
+	}
+
+	if (smu_version < SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION)
+		ret = -EOPNOTSUPP;
+
+	return ret;
+}
+
+static int aldebaran_send_hbm_bad_channel_flag(struct smu_context *smu,
+		uint32_t size)
+{
+	int ret = 0;
+
+	ret = aldebaran_check_bad_channel_info_support(smu);
+	if (ret)
+		return ret;
+
+	/* message SMU to update the bad channel info on SMUBUS */
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetBadHBMPagesRetiredFlagsPerChannel, size, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "[%s] failed to message SMU to update HBM bad channel info\n",
+				__func__);
+
+	return ret;
+}
+
 static const struct pptable_funcs aldebaran_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = aldebaran_get_allowed_feature_mask,
@@ -2062,6 +2104,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.i2c_fini = aldebaran_i2c_control_fini,
 	.send_hbm_bad_pages_num = aldebaran_smu_send_hbm_bad_page_num,
 	.get_ecc_info = aldebaran_get_ecc_info,
+	.send_hbm_bad_channel_flag = aldebaran_send_hbm_bad_channel_flag,
 };
 
 void aldebaran_set_ppt_funcs(struct smu_context *smu)
-- 
2.17.1

