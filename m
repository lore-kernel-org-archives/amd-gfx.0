Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A534C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B740310E5DD;
	Mon, 13 Jul 2026 13:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVFe6q6h";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8EF10E9C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEodXtrZlT3+a2AiBmm0SGwQ+JSbsm326/NJC2KGwMgrDRWyXf/Ph03czq7fCp6eG3/HL+k74MRgHo5OpsinVZGxdKxN+hNkG7WDo+kpHtkSPjpiWSZF+7KVid2QLmrMAmuoDSdeLkVsafTa/Zxsa/13kGEA53HmD9DD4OYRhK2xXWEp2Q8BEBMSmcRR8RJ0es8+ugejKWtsifPsrN9bU0JK2X4T5tPtNWjX+LS97ASme5e0kJ6PohxUqI3NS051KjnxyZpchQzLuDApVmD79eI5PMSAl3DgrY3kPtrWebZM6qIS+OTpbEcONqHjYyajaveF5LvEkyq1Gqi3FmV+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa9IVmLHAnIqEG3befFQ4ioJLX6Rs4ukWpqSeD5hYf0=;
 b=xv931/e1AF5Ri49efCyeEftnBC4pVbaMjPayDuF1QgXoDXqU5ON4uedcY5wZFSD7Gm8kVWeuCtYu+G29aL1SZ3o1ecihoBJsh+RBinnp1QbVCHecGakZ4wBLeJxQVSAQHCKw1jZZHCtrtji5Mz+huHMQ8FfBdsOgNoyTRoETgCAeMpXMBtPv+A5/c0MJlNnpUCMIj7LxOg2TA/A8WVStatfrfpNKCmzAGo/mQ1eG6zDOau3c7IUJoqHEipFer3uUlf1/B5pp5YseB3arY9933W8xYp6tyuEB6/qM6JCB2JCeDlUEI2e00FuG2c8jCpDL8m4Khd350Uz+U251rdAIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa9IVmLHAnIqEG3befFQ4ioJLX6Rs4ukWpqSeD5hYf0=;
 b=zVFe6q6h/NDgJk5oRIeEQAWiCI+nlTrMEn9EatfHkXa87bddIXpYjFoipbO4XlzlYujVU8I/WIQsH56EOzLJZB0dVyCaV4E95sNgo0pw95SRnJ8jW8mZCtcAzWOYr2xMEub1YQuqP95KQAk8OW3t102/p+TUL/Q0kflHMCcWCls=
Received: from BLAPR05CA0040.namprd05.prod.outlook.com (2603:10b6:208:335::21)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:26:33 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:335:cafe::7c) by BLAPR05CA0040.outlook.office365.com
 (2603:10b6:208:335::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 13:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 13:26:33 +0000
Received: from vivian-PowerEdge-R740.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 08:26:32 -0500
From: Fares Soliman <Fares.Soliman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Richardqi.Liang@amd.com>, Fares Soliman <Fares.Soliman@amd.com>
Subject: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly gather
 GFXOFF residency logs
Date: Mon, 13 Jul 2026 09:26:24 -0400
Message-ID: <20260713132624.1173426-1-Fares.Soliman@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 422df4f1-8571-4878-6544-08dee0e25b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: Tqeh1IxYm6JVitqjmrSOcUGwjQhI9NDsfu0MHqKcMI1xq7crvfGh9MN1Feto1P4w2jgfY0YB+1nNYMzGpUOwUB0YmWu8a/Ksa0UfvxTjEsa0PW1l3z0M936QrVXKPYLEGvwR+i2r3fhfGxUlip7tkVLL1s35EqetEzlLW7JMjvYotLRc3FsuZqJreDAqV3sVyfxR8Me1PpyIOKQdKeTSCm7zfB2262/Mb1i8/MtiuO8mJH8wd0iedmkcFdoi3YQz1Fd4lf+S2bN7RifyKYWJMJfFhgnGJl9gmZdDRqMngxAa+Q7xB5p11FMKTQlf6JaAPj3SAt4Sjl8llFQ8xA+BZd4h7dmsP0YxDErda1aXMtk8I6K0PkiayUJc1rotXBBdJLS2UrEiYybL4NATiJ/5LmhVG/ujtxzdasTNNSypk7Jp5AJSz0R3+Nk8/bYJRTMW/pWCFoxf7taRrXbXJkWNTECr4RNEm8VnMyy8EsUdgz+5sm8nUudZhXlMib1jSAps0SLGpI/dheN+cMGvJxxBHb6t8a5lUcClQBZGx5/ssAC3WTZ8uT8jJZIbXq+m4g4eYutP28eKLY7YyGPQpDhUC57l2B1Tfr/Ons9h2UgAAjxdJCEyyeNjtn5wbFQyD5uEsT4lLi8NxbnXwSkZhgAxnj8kTP8CbmTpkro2bBKhpT3vLZ/Y3+2/Qz0lR9F5tzB7/q/P2pg1Zu0oBBTdAM5KOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DAi5DLqvSNJP3MgEPnPWZPd/Hx4GVEVRNSPUvB9nTPz3tJ88WUgpgo2a4ZvPWRZI1f8XvKixJyqagS8nOoL94VlA+KPXIvFxJLsiAlN0lrtQUmcVQwbunIU/FWHFJecDX5hTCraajj47TwZFhh5XLOW42Hk56FgzGETyTkJfEnVlNJfHvwpXCgoMGGu1sJfyp0at5C7dmXv1i2j1isM5fEpPEhSoap++eAeeae9p5pvrdfhkHnA0zXjxGkjuHMpKmERdVdHuyD1LSG/Opu63Iqyb+bTl8Tgc3K03JXTZv0kunqKxgdZka1TKNCd3vXiyNrjrSAWBmFN0qwXPKpiL6dOiBA1WVVVuhLGuinmZBj0K0zZk37XRhC/4QQbzQlhSYi+DHTBPgBh7RTQq2C3JBoywWotYTHFPqt3cJjXQFFCvPXrAem3vHC+0CDmBPnHo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:26:33.1587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 422df4f1-8571-4878-6544-08dee0e25b4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572
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

In regards to messageID 0x52, the old interface uses a start/stop
parameter, and the new one doesn't. The firmware is checked to
determine which method to use.

v2: added firmware guard to new interface, old interface kept as
fallback

Signed-off-by: Fares Soliman <Fares.Soliman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  6 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 50 +++++++++++++++----
 5 files changed, 50 insertions(+), 16 deletions(-)

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
index 717ba46c8933..1104f8b05b29 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -72,6 +72,12 @@ static const struct smu_feature_bits vangogh_dpm_features = {
 	}
 };
 
+/*
+ * SMU support new GFXOFF residency log interface since version 4.63.62.00,
+ * use this to get live readings of GFXOFF residency
+ */
+#define SUPPORT_LIVE_RESIDENCY_MSG_VERSION 0x043f3e00
+
 static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		0),
@@ -142,7 +148,9 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(GetSlowPPTLimit,                    PPSMC_MSG_GetSlowPPTLimit,						0),
 	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
 	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
-	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
+	MSG_MAP(StartGfxOffResidencyLogging,  PPSMC_MSG_StartGfxOffResidencyLogging,	0),
+	MSG_MAP(GfxOffResidencyLogReadSample, PPSMC_MSG_GfxOffResidencyLogReadSample,	0),
+	MSG_MAP(StopGfxOffResidencyLogging,   PPSMC_MSG_StopGfxOffResidencyLogging,		0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -2450,19 +2458,32 @@ static int vangogh_set_power_limit(struct smu_context *smu,
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
+	if (smu->smc_fw_version < SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
+		u32 residency;
+
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxOffResidencyLogReadSample,
+							start, &residency);
+		if (ret)
+			return ret;
 
-	if (!start)
-		adev->gfx.gfx_off_residency = residency;
+		if (!start)
+			adev->gfx.gfx_off_residency = residency;
+	} else {
+		if (start) {
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_StartGfxOffResidencyLogging, NULL);
+			if (ret)
+				return ret;
+		} else {
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_StopGfxOffResidencyLogging, NULL);
+			if (ret)
+				return ret;
+		}
+	}
 
 	return ret;
 }
@@ -2479,11 +2500,20 @@ static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool start)
  */
 static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_t *residency)
 {
+	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 
-	*residency = adev->gfx.gfx_off_residency;
+	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+		return 0;
+
+	if (smu->smc_fw_version < SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
+		*residency = adev->gfx.gfx_off_residency;
+	} else {
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GfxOffResidencyLogReadSample,
+								residency);
+	}
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.43.0

