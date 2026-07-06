Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F5FC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572C010E3F1;
	Mon,  6 Jul 2026 20:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OsqHT3cJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA3610E3F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WatfwMVj6hwKSD7zeunYHPlQWqqzWUY9TdJE2uouQnNMOzuQH1X/RcsT9rQWy5td8X+ICPzqaz4ojHmb+MAYSur0yK0NA/KT6BRB8j0LfJv8QT2OpNle++zTFq2AYWaD2chDHsWaGInPc5qfDWtWbilHfLY7R9EETxsI15K+w9U9GyDHEYYDFMXlBdG5qtOwVYy7m9zYmxuDgHZTmLSQpvER6z6hY3pLRhM8BTz+kz6nZJ7rEgOBT56GNSfEHogLkFSBS70I0fC5AY3GUBA99/rU65WcRDzwyiBHcvnmXTn5laZjyxM45uBj3zFRO4cZqKeiv3iW6DrZsoQ2Z5E/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKRH0i/13uLFyFtWlasciJyE8/mS2A7cUWriNHWkX5I=;
 b=YrcjeQSqHyO/RMJ2CApW9fSfWdgYh7oQPDhO8iDDvDtegZ/XRFRt+ABDJSGMGi47Uqzk7dsgd+lIi19ltDKKcp2LDlbeF5ez7iiH/Tqfipa0MarGgV2aKm0Q0s8S84z5sc/UKUI4weCLJuhD2U4p1KvNnWdjy3IXx5/EpNJDgOwfnHaUGFvvm7tvQk28bXifZK/M9QM3NTFPJ75Reg0iBCBSk4eQY9hnIsxT5HF7he/rdxVdNUhVyzTWfLczuu1acdjdYzflgIa0GXHMA6Ez8hPnscAfrJbc7GLaEx1cf1PtJE11IfFtz9BE52O+vN9VGBobg5WINiaM82mdzPGYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKRH0i/13uLFyFtWlasciJyE8/mS2A7cUWriNHWkX5I=;
 b=OsqHT3cJNGLBPSpeALDRA5s4PqXAMsX++EqBV3lqPOfH/wO4jOPitMCnnBiA40KSPVsEz3demGPoOq1KD8PBa9jeFxybEGueZxV2ql9am3vtghYP4ryISGKv4as9pCBQCnrbs0JVo0gyOjw1GFWeLlVkV2Aqxwjcv0bGumSWmqU=
Received: from BYAPR21CA0006.namprd21.prod.outlook.com (2603:10b6:a03:114::16)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 20:47:30 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::52) by BYAPR21CA0006.outlook.office365.com
 (2603:10b6:a03:114::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.2 via Frontend Transport; Mon, 6
 Jul 2026 20:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 20:47:29 +0000
Received: from vivian-PowerEdge-R740.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 6 Jul 2026 15:47:29 -0500
From: Fares Soliman <Fares.Soliman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <fsoliman@amd.com>, <Richardqi.Liang@amd.com>, Fares Soliman
 <Fares.Soliman@amd.com>
Subject: [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly gather
 GFXOFF residency logs
Date: Mon, 6 Jul 2026 16:47:06 -0400
Message-ID: <20260706204711.4022513-1-Fares.Soliman@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 702944ca-9247-4933-be01-08dedb9fcbe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: uubkSCAuBPvKNeUKlzjAyLcF4+EBP3DVXBF2lVHMNjFlSyGoQMMSUqcFTa2h57N8AbewJXaIfIMWHQIoq0+QTkOpdQAgf1ectQB4BZU2EKzIuIXHU5OxRi/R4ivazwE0eg1oYtYTEdIlVRYqbNgkD8/BsFokRYuzve/om+3EC2x0nuCHs55pFQ+2ZUgiSc4ZyYR0wmLZ83qSnFtK0Duo0WDxbZIVEHpjxMiAl0WYlMAUT7WFBDKJEHd8gWbhXJWro8xcMrGOIN/ly5N6zPwdb0hd8tFhimA6jbg8268ujiBn/CcaGzf2DFHcCOiuiukhq9UaF9uN7s21LegQu9URoRgguM1i877q0XEmcAmkCZvCkyi3kJses5oOWzt4VxvH6e1sZGj2m2L+tHuhAl7vDs7evHpEdxwkggII4HUG6p1Zz4d1w0wcnGVzxNqr6EvlAvpjzyiX/9/ylJwOj09nI1wixJ6QaAMgw97GfitbgTW69LsMmwndoXN4rwbDh1PW8qtv/774Yy7w2iQGJvDZPqKdOHvHiBCEZImZNeEJghQaPY/MhnzlbcsruTuDgjFPujl/HXnUnQow9W3Lglwju2hERIB6M2uorY2pDiSLTAmdOptyK4PKODMY1hifgq6rxzHMueqgmlJHDL+Fl8JcfPPP5k4qEso2vsGrb4nnfFB3Gw6Ox38ikMyI8+dFJ74bPWyHzJHdAe4vjOo3bNToaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lcak0n2pjWuJAM8jp2VSVuk5XYUauI199Pz1Jb4/II+CYWAjIU5QG1GE8O71VHVCvtfQfKjgFqHpNZ5loYBErfagGEZnubNduIqPb+7c4YJqZQexZNXK/VAOKxWAkCdVNDJPWJSHMxwsWol7eWG/JljFfCm9Uc4Qcq60iimIvuDULk/Eg1pqCbLJTsuz23x6wMwqlnS16UNJ0V6ngGN3TPYKFkej3q3udd3nfb6kAB0/l9Ot+ifOF8gP99WnXYSh6FDJp06J2u8OqfYHItOUfal9pwAgUIplviO7GwUq4rYOW5LxKaeLmpQF8pH0txqOJhMnHptLNlM7KQTCVLWG5XD3530Jzcf59W+dx3fkbMzeEnKngYO6s6zQp7zaAdS+2uCXDN3PT0AHOHN3vJA0vB8vmgHYOZ18Ho3lO4bLZ/NLZhtTjbFYeFBYWYdPsF87
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 20:47:29.9128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702944ca-9247-4933-be01-08dedb9fcbe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
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

Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs
on Van Gogh. Logs are now gathered live rather than starting then
stopping logging and reading an average value afterwards. This is
in accordance to changes made in PMFW.

Signed-off-by: Fares Soliman <Fares.Soliman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  6 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 30 ++++++++++++-------
 7 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5c4d4ff001ea..46514a1faf1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
  * @size: Number of bytes to read
  * @pos:  Offset to seek to
  *
- * Read the last residency value logged. It doesn't auto update, one needs to
- * stop logging before getting the current value.
+ * Read a live GFXOFF residency sample from firmware. One needs to start logging
+ * before getting the current value.
  */
 static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, char __user *buf,
 						    size_t size, loff_t *pos)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62b5ad4d10b0..1bde0645c6f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3725,7 +3725,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	amdgpu_coredump_init(adev);
 
 	adev->gfx.gfx_off_req_count = 1;
-	adev->gfx.gfx_off_residency = 0;
 	adev->gfx.gfx_off_entrycount = 0;
 	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index aefd4f03b443..4c1f8504ee1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -493,7 +493,6 @@ struct amdgpu_gfx {
 	struct mutex                    gfx_off_mutex;      /* mutex to change gfxoff state */
 	uint32_t                        gfx_off_req_count;  /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
 	struct delayed_work             gfx_off_delay_work; /* async work to set gfx block off */
-	uint32_t                        gfx_off_residency;  /* last logged residency */
 	uint64_t                        gfx_off_entrycount; /* count of times GPU has get into GFXOFF state */
 
 	/* pipe reservation */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f8fd93999617..d94e3dcf7f9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1333,7 +1333,7 @@ struct pptable_funcs {
 	u32 (*set_gfx_off_residency)(struct smu_context *smu, bool start);
 
 	/**
-	 * @get_gfx_off_residency: Average GFXOFF residency % during the logging interval
+	 * @get_gfx_off_residency: Live GFXOFF residency percentage
 	 */
 	u32 (*get_gfx_off_residency)(struct smu_context *smu, uint32_t *residency);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..4206514765cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -110,8 +110,10 @@
 #define PPSMC_MSG_GetSlowPPTLimit                      0x4C
 #define PPSMC_MSG_GetGfxOffStatus		       0x50
 #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
-#define PPSMC_MSG_LogGfxOffResidency		       0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_GfxOffResidencyLogReadSample	       0x52
+#define PPSMC_MSG_StopGfxOffResidencyLogging	         0x53
+#define PPSMC_MSG_StartGfxOffResidencyLogging	         0x56
+#define PPSMC_Message_Count                            0x57
 
 //Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 636ff90923d9..acf03838d49d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -252,7 +252,9 @@
 	__SMU_DUMMY_MAP(DriverMode2Reset), \
 	__SMU_DUMMY_MAP(GetGfxOffStatus),		 \
 	__SMU_DUMMY_MAP(GetGfxOffEntryCount),		 \
-	__SMU_DUMMY_MAP(LogGfxOffResidency),			\
+	__SMU_DUMMY_MAP(StartGfxOffResidencyLogging),		\
+	__SMU_DUMMY_MAP(GfxOffResidencyLogReadSample),		\
+	__SMU_DUMMY_MAP(StopGfxOffResidencyLogging),		\
 	__SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),		\
 	__SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel), \
 	__SMU_DUMMY_MAP(AllowGpo),	\
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 717ba46c8933..4212abfdbe53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -142,7 +142,9 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(GetSlowPPTLimit,                    PPSMC_MSG_GetSlowPPTLimit,						0),
 	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
 	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
-	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
+	MSG_MAP(StartGfxOffResidencyLogging,  PPSMC_MSG_StartGfxOffResidencyLogging,	0),
+	MSG_MAP(GfxOffResidencyLogReadSample, PPSMC_MSG_GfxOffResidencyLogReadSample,	0),
+	MSG_MAP(StopGfxOffResidencyLogging,   PPSMC_MSG_StopGfxOffResidencyLogging,		0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -2450,19 +2452,20 @@ static int vangogh_set_power_limit(struct smu_context *smu,
 static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool start)
 {
 	int ret = 0;
-	u32 residency;
 	struct amdgpu_device *adev = smu->adev;
 
 	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 		return 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LogGfxOffResidency,
-					      start, &residency);
-	if (ret)
-		return ret;
-
-	if (!start)
-		adev->gfx.gfx_off_residency = residency;
+	if (start) {
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_StartGfxOffResidencyLogging, NULL);
+		if (ret)
+			return ret;
+	} else {
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_StopGfxOffResidencyLogging, NULL);
+		if (ret)
+			return ret;
+	}
 
 	return ret;
 }
@@ -2479,11 +2482,16 @@ static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool start)
  */
 static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_t *residency)
 {
+	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 
-	*residency = adev->gfx.gfx_off_residency;
+	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+		return 0;
 
-	return 0;
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GfxOffResidencyLogReadSample,
+				    residency);
+
+	return ret;
 }
 
 /**
-- 
2.43.0

