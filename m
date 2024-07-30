Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F191C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 01:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB0210E3F2;
	Tue, 30 Jul 2024 01:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1vpRtwi7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959D610E38A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 01:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR469ezaV/WDSl6FuN+91b8tnISSQHYqXJWcUw9dXYTFwmruTY5Lm6PdMmDhc6s1p0QnN0Cfxc9+woOZ5kxQU8WlnMfbma66aoio5fGY+cciWxf13ou5h/GXxGiDXIx3aPEDzdoLu+Xv2MnIzg8EacXw4B1UI2aDaegd/brk4gm5gA6EeN51QfaKc+LkIL6nV3iv8wKcfiOKzL6NR7Fs+aZQPpNfSSkLK6mKCWyKzI83xYyz1cg4te/gduhnJdC89WMgZfZKw190csLrmNeVcXcS6gnbAFuwuGF+54SrLT2cWjEQ/hzftogE74guLx9pKFcgdHIYiXHEMPvbhv0ImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbDqpAU1icgMrq4PbcnWlIYmw15xLk+1nCtKIkQEHSs=;
 b=jynNkHbcPy6uhov1ugUa0x35LOG91AuoOSUJ/ulctbCjHG5IIVBh6QP2ZaBOdle1zDWRyXLVMA84Gh37/XDfkDOnh2ttwA+0QQY7AoieZdFb9kGqI8/54UIyUN7mzMcFSIDzWZ9W/uLV831dSQeO25uCC+ZzXumzQw2fem5Y1fTVKM5utGNdYML4PcR25fzcPlaEPL55JKWZhPv8GHfvXjVlV69sH+MQcG49XEESgjthX1UpT5AjqWlM32mmG0G4JZghxMp21Nk66Zsk+Rgx7dK0gSJopnZg7U+iC4i2UErAKf125wNxyA4bE5wxuzYAFPziv8zPIUJ9iFAkiuEf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbDqpAU1icgMrq4PbcnWlIYmw15xLk+1nCtKIkQEHSs=;
 b=1vpRtwi7PbVxnGR7Rz3tU5YDZwI1Lugpg89zdG8cdLKEuV4GRnwWPDdZQmvienWojk2NBlbR+JhARhmAXA0eviDoHPHDtLH3p8IJwf2k9HcbL064+55DL4exFc6fwLCPuxZLxR174Ng7q3LUvlh+cGCCZGVRTDQG/lkJWYFa6NI=
Received: from CH2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:610:38::39)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 01:44:56 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::97) by CH2PR05CA0062.outlook.office365.com
 (2603:10b6:610:38::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 01:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 01:44:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 20:44:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 20:44:54 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 29 Jul 2024 20:44:53 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: add overdrive support on smu v14.0.2/3
Date: Tue, 30 Jul 2024 09:44:51 +0800
Message-ID: <20240730014451.195377-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 08923a8b-d59c-488c-a652-08dcb039369f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QnrL5hXKR6C7gzXJFbWUVOvHK8kopAJdcFlkMvYyhAdxl/x3KZ+MLRxxhF6d?=
 =?us-ascii?Q?O6YbXQ410Ujfo0rQQ5n0xAgIB/wjKXtKauNUt19CvLDW6mPFM02r2yYUJtZO?=
 =?us-ascii?Q?30beprld2MqrlITZ/KEmGOECYpd9oj9Fo4LJ2+ymhZeG1ijvLXWOfvU80CiA?=
 =?us-ascii?Q?n3nOW9Rnu6g5IvdQycRzSKYko8UfPQ/xF2Bv4vrso7o7LtbvKGgPk3mYUCYU?=
 =?us-ascii?Q?OdpmQ10lAHjatrcegxHEQu/rWKE9Lp3suTFEKQMC2l857x5j/RcQ6aFUAAxg?=
 =?us-ascii?Q?LdbPYar+xpqU191pG6zXPZ7yrGbx4vRusrAk3GlozUnj3BszedCxBKxyWu8a?=
 =?us-ascii?Q?gaGN0Xb42HvEs2l1LE/6sxTqcmNIDPiUgdrteU5vW6RFfHnEUDYURQMu8tqX?=
 =?us-ascii?Q?mBEE1w+SwzCh9AeNX/dYyCI5qxcweHchsfLLOgHQg6kD06/b5KYb9vKcmeOK?=
 =?us-ascii?Q?qB1tWZoyy6VzVGSQCr6eMzGlIGw0IGLEl4QUqJxvdO9/rowQzIlKnN5l7k9I?=
 =?us-ascii?Q?NkJ36RMEx41KXZpesBNPrXWk1mK9IdgKcn8a3YFsswP36lJamnE/wBX0Plfp?=
 =?us-ascii?Q?DRwX9I2dPDGO+pZi8nM4tlHWY2zSw8KAZzrb2KB06aPXlqu3jgQJpXji0kHJ?=
 =?us-ascii?Q?6gn4fHgn/bwwLm8FJRgye4tI+vbrQNBtfYESMc+Cc9O4f+7JCck9ygpsnKhE?=
 =?us-ascii?Q?fJiWb8ib5w0BhG2tDJcNxh15vpuDawfxv7TPEggtCa9dQTkx1X0q3pOLh9hF?=
 =?us-ascii?Q?xyAmmbC178zfDmbK/nlBv0aEne1MHaNl8szbrFy5NYzqtQEkPQnJ+Vm9Qk3k?=
 =?us-ascii?Q?WYwduCdSdi1nXF5kpsgjgPwPEJrSsSRK2YnX4RIC3Y3rimxdLExhcfV7X4qp?=
 =?us-ascii?Q?UT6EFnxkw5Oc/EUfMYLQZhXk1O1V2npTQArn79Y8jO888F9jiWeaj9RZDSMk?=
 =?us-ascii?Q?h9ateLOPWWrTzCmnNHY3mzRODisKrheTlGLLArJ409iifcbbo8mTeWE5JMrr?=
 =?us-ascii?Q?4L+Mb5Xfrra1bTd2tw1IF015L8UggqMA9y8NlYMJXnj9Hw/w8xl9LianqYyY?=
 =?us-ascii?Q?q8chZARtM61s+6Dbo0DtxaVf6giRyEBeMUd9nSr/NURojnrx2puBmVHQUmiW?=
 =?us-ascii?Q?SiHGL25yzuMXZ6CtIbrqG14R/zp3tvkW6jI7WZJwPSqQEqCnqJ37bz6JI565?=
 =?us-ascii?Q?SDLarozqCYk6qOsjxTrzoF/4cIkpmvdZl88kwbbeG8YRSlA4ZLxRr/oiQHSI?=
 =?us-ascii?Q?MAutC0yiH1dtTC3eRKuFvEP+g0CXweuBdZIrWMJ0ndTaGbzLJiPe4frkVCfQ?=
 =?us-ascii?Q?vCSG84/BVyyHdarQ7GjFO3jPG8724WYw8FMQ+S4kkSfltVWlNF5MQPw3Iqwi?=
 =?us-ascii?Q?qnBA5sCDlv8gd7bh4F+O5VhBBcvGufa8Uc1GthzyrqjnUncGghcAAjzSGWzQ?=
 =?us-ascii?Q?m8fo1ACwDoGdEG35HU5fTcEOvE9KUPPv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 01:44:55.5043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08923a8b-d59c-488c-a652-08dcb039369f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

add overdrive support on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  11 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 888 +++++++++++++++++-
 2 files changed, 896 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 09973615f210..865e916fc425 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -452,17 +452,26 @@ int smu_v14_0_init_smc_tables(struct smu_context *smu)
 			ret = -ENOMEM;
 			goto err3_out;
 		}
+
+		smu_table->user_overdrive_table =
+			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
+		if (!smu_table->user_overdrive_table) {
+			ret = -ENOMEM;
+			goto err4_out;
+		}
 	}
 
 	smu_table->combo_pptable =
 		kzalloc(tables[SMU_TABLE_COMBO_PPTABLE].size, GFP_KERNEL);
 	if (!smu_table->combo_pptable) {
 		ret = -ENOMEM;
-		goto err4_out;
+		goto err5_out;
 	}
 
 	return 0;
 
+err5_out:
+	kfree(smu_table->user_overdrive_table);
 err4_out:
 	kfree(smu_table->boot_overdrive_table);
 err3_out:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e1a27903c80a..85cf450d4df1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -68,6 +68,18 @@
 #define DEBUGSMC_MSG_Mode1Reset        2
 #define LINK_SPEED_MAX					3
 
+#define PP_OD_FEATURE_GFXCLK_FMIN			0
+#define PP_OD_FEATURE_GFXCLK_FMAX			1
+#define PP_OD_FEATURE_UCLK_FMIN				2
+#define PP_OD_FEATURE_UCLK_FMAX				3
+#define PP_OD_FEATURE_GFX_VF_CURVE			4
+#define PP_OD_FEATURE_FAN_CURVE_TEMP			5
+#define PP_OD_FEATURE_FAN_CURVE_PWM			6
+#define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		7
+#define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
+#define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
+#define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
+
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -204,6 +216,7 @@ static struct cmn2asic_mapping smu_v14_0_2_table_map[SMU_TABLE_COUNT] = {
 	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
 	TAB_MAP(I2C_COMMANDS),
 	TAB_MAP(ECCINFO),
+	TAB_MAP(OVERDRIVE),
 };
 
 static struct cmn2asic_mapping smu_v14_0_2_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -1029,16 +1042,97 @@ static int smu_v14_0_2_get_current_clk_freq_by_table(struct smu_context *smu,
 						value);
 }
 
+static bool smu_v14_0_2_is_od_feature_supported(struct smu_context *smu,
+						int od_feature_bit)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	const OverDriveLimits_t * const overdrive_upperlimits =
+				&pptable->SkuTable.OverDriveLimitsBasicMax;
+
+	return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit);
+}
+
+static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min,
+					      int32_t *max)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	const OverDriveLimits_t * const overdrive_upperlimits =
+				&pptable->SkuTable.OverDriveLimitsBasicMax;
+	const OverDriveLimits_t * const overdrive_lowerlimits =
+				&pptable->SkuTable.OverDriveLimitsBasicMin;
+	int32_t od_min_setting, od_max_setting;
+
+	switch (od_feature_bit) {
+	case PP_OD_FEATURE_GFXCLK_FMIN:
+		od_min_setting = overdrive_lowerlimits->GfxclkFmin;
+		od_max_setting = overdrive_upperlimits->GfxclkFmin;
+		break;
+	case PP_OD_FEATURE_GFXCLK_FMAX:
+		od_min_setting = overdrive_lowerlimits->GfxclkFmax;
+		od_max_setting = overdrive_upperlimits->GfxclkFmax;
+		break;
+	case PP_OD_FEATURE_UCLK_FMIN:
+		od_min_setting = overdrive_lowerlimits->UclkFmin;
+		od_max_setting = overdrive_upperlimits->UclkFmin;
+		break;
+	case PP_OD_FEATURE_UCLK_FMAX:
+		od_min_setting = overdrive_lowerlimits->UclkFmax;
+		od_max_setting = overdrive_upperlimits->UclkFmax;
+		break;
+	case PP_OD_FEATURE_GFX_VF_CURVE:
+		od_min_setting = overdrive_lowerlimits->VoltageOffsetPerZoneBoundary[0];
+		od_max_setting = overdrive_upperlimits->VoltageOffsetPerZoneBoundary[0];
+		break;
+	case PP_OD_FEATURE_FAN_CURVE_TEMP:
+		od_min_setting = overdrive_lowerlimits->FanLinearTempPoints[0];
+		od_max_setting = overdrive_upperlimits->FanLinearTempPoints[0];
+		break;
+	case PP_OD_FEATURE_FAN_CURVE_PWM:
+		od_min_setting = overdrive_lowerlimits->FanLinearPwmPoints[0];
+		od_max_setting = overdrive_upperlimits->FanLinearPwmPoints[0];
+		break;
+	case PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT:
+		od_min_setting = overdrive_lowerlimits->AcousticLimitRpmThreshold;
+		od_max_setting = overdrive_upperlimits->AcousticLimitRpmThreshold;
+		break;
+	case PP_OD_FEATURE_FAN_ACOUSTIC_TARGET:
+		od_min_setting = overdrive_lowerlimits->AcousticTargetRpmThreshold;
+		od_max_setting = overdrive_upperlimits->AcousticTargetRpmThreshold;
+		break;
+	case PP_OD_FEATURE_FAN_TARGET_TEMPERATURE:
+		od_min_setting = overdrive_lowerlimits->FanTargetTemperature;
+		od_max_setting = overdrive_upperlimits->FanTargetTemperature;
+		break;
+	case PP_OD_FEATURE_FAN_MINIMUM_PWM:
+		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
+		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
+		break;
+	default:
+		od_min_setting = od_max_setting = INT_MAX;
+		break;
+	}
+
+	if (min)
+		*min = od_min_setting;
+	if (max)
+		*max = od_max_setting;
+}
+
 static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type,
 					char *buf)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_14_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	struct smu_14_0_dpm_table *single_dpm_table;
 	struct smu_14_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
 	int i, curr_freq, size = 0;
+	int32_t min_value, max_value;
 	int ret = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
@@ -1159,6 +1253,183 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 					"*" : "");
 		break;
 
+	case SMU_OD_SCLK:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_GFXCLK_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_SCLK:\n");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+					od_table->OverDriveTable.GfxclkFmin,
+					od_table->OverDriveTable.GfxclkFmax);
+		break;
+
+	case SMU_OD_MCLK:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_UCLK_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_MCLK:\n");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMHz\n",
+					od_table->OverDriveTable.UclkFmin,
+					od_table->OverDriveTable.UclkFmax);
+		break;
+
+	case SMU_OD_VDDGFX_OFFSET:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_GFX_VF_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
+		size += sysfs_emit_at(buf, size, "%dmV\n",
+				      od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
+		break;
+
+	case SMU_OD_FAN_CURVE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_FAN_CURVE:\n");
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++)
+			size += sysfs_emit_at(buf, size, "%d: %dC %d%%\n",
+						i,
+						(int)od_table->OverDriveTable.FanLinearTempPoints[i],
+						(int)od_table->OverDriveTable.FanLinearPwmPoints[i]);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_CURVE_TEMP,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "FAN_CURVE(hotspot temp): %uC %uC\n",
+				      min_value, max_value);
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_CURVE_PWM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "FAN_CURVE(fan speed): %u%% %u%%\n",
+				      min_value, max_value);
+
+		break;
+
+	case SMU_OD_ACOUSTIC_LIMIT:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_LIMIT:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.AcousticLimitRpmThreshold);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ACOUSTIC_LIMIT: %u %u\n",
+				      min_value, max_value);
+		break;
+
+	case SMU_OD_ACOUSTIC_TARGET:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_TARGET:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.AcousticTargetRpmThreshold);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ACOUSTIC_TARGET,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ACOUSTIC_TARGET: %u %u\n",
+				      min_value, max_value);
+		break;
+
+	case SMU_OD_FAN_TARGET_TEMPERATURE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanTargetTemperature);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u %u\n",
+				      min_value, max_value);
+		break;
+
+	case SMU_OD_FAN_MINIMUM_PWM:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanMinimumPwm);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
+				      min_value, max_value);
+		break;
+
+	case SMU_OD_RANGE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
+		    !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
+		    !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+
+		if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
+			smu_v14_0_2_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_GFXCLK_FMIN,
+							  &min_value,
+							  NULL);
+			smu_v14_0_2_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_GFXCLK_FMAX,
+							  NULL,
+							  &max_value);
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+		}
+
+		if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
+			smu_v14_0_2_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_UCLK_FMIN,
+							  &min_value,
+							  NULL);
+			smu_v14_0_2_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_UCLK_FMAX,
+							  NULL,
+							  &max_value);
+			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+		}
+
+		if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
+			smu_v14_0_2_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_GFX_VF_CURVE,
+							  &min_value,
+							  &max_value);
+			size += sysfs_emit_at(buf, size, "VDDGFX_OFFSET: %7dmv %10dmv\n",
+					      min_value, max_value);
+		}
+		break;
+
 	default:
 		break;
 	}
@@ -1400,7 +1671,27 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 				       uint32_t *max_power_limit,
 				       uint32_t *min_power_limit)
 {
-	// TODO
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	CustomSkuTable_t *skutable = &pptable->CustomSkuTable;
+	uint32_t power_limit;
+	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+
+	if (smu_v14_0_get_current_power_limit(smu, &power_limit))
+		power_limit = smu->adev->pm.ac_power ?
+			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
+			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
+
+	if (max_power_limit)
+		*max_power_limit = msg_limit;
+
+	if (min_power_limit)
+		*min_power_limit = 0;
 
 	return 0;
 }
@@ -1950,6 +2241,596 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static void smu_v14_0_2_dump_od_table(struct smu_context *smu,
+				      OverDriveTableExternal_t *od_table)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTable.GfxclkFmin,
+						     od_table->OverDriveTable.GfxclkFmax);
+	dev_dbg(adev->dev, "OD: Uclk: (%d, %d)\n", od_table->OverDriveTable.UclkFmin,
+						   od_table->OverDriveTable.UclkFmax);
+}
+
+static int smu_v14_0_2_upload_overdrive_table(struct smu_context *smu,
+					      OverDriveTableExternal_t *od_table)
+{
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_OVERDRIVE,
+				   0,
+				   (void *)od_table,
+				   true);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+
+	return ret;
+}
+
+static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (smu_v14_0_2_is_od_feature_supported(smu,
+						PP_OD_FEATURE_FAN_CURVE_BIT))
+		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
+}
+
+static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
+					   OverDriveTableExternal_t *od_table)
+{
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_OVERDRIVE,
+				   0,
+				   (void *)od_table,
+				   false);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
+
+	return ret;
+}
+
+static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
+{
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
+	OverDriveTableExternal_t *boot_od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.boot_overdrive_table;
+	OverDriveTableExternal_t *user_od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.user_overdrive_table;
+	OverDriveTableExternal_t user_od_table_bak;
+	int ret = 0;
+	int i;
+
+	ret = smu_v14_0_2_get_overdrive_table(smu, boot_od_table);
+	if (ret)
+		return ret;
+
+	smu_v14_0_2_dump_od_table(smu, boot_od_table);
+
+	memcpy(od_table,
+	       boot_od_table,
+	       sizeof(OverDriveTableExternal_t));
+
+	/*
+	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
+	 * but we have to preserve user defined values in "user_od_table".
+	 */
+	if (!smu->adev->in_suspend) {
+		memcpy(user_od_table,
+		       boot_od_table,
+		       sizeof(OverDriveTableExternal_t));
+		smu->user_dpm_profile.user_od = false;
+	} else if (smu->user_dpm_profile.user_od) {
+		memcpy(&user_od_table_bak,
+		       user_od_table,
+		       sizeof(OverDriveTableExternal_t));
+		memcpy(user_od_table,
+		       boot_od_table,
+		       sizeof(OverDriveTableExternal_t));
+		user_od_table->OverDriveTable.GfxclkFmin =
+				user_od_table_bak.OverDriveTable.GfxclkFmin;
+		user_od_table->OverDriveTable.GfxclkFmax =
+				user_od_table_bak.OverDriveTable.GfxclkFmax;
+		user_od_table->OverDriveTable.UclkFmin =
+				user_od_table_bak.OverDriveTable.UclkFmin;
+		user_od_table->OverDriveTable.UclkFmax =
+				user_od_table_bak.OverDriveTable.UclkFmax;
+		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
+			user_od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] =
+				user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++) {
+			user_od_table->OverDriveTable.FanLinearTempPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearTempPoints[i];
+			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
+		}
+		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
+		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
+		user_od_table->OverDriveTable.FanTargetTemperature =
+			user_od_table_bak.OverDriveTable.FanTargetTemperature;
+		user_od_table->OverDriveTable.FanMinimumPwm =
+			user_od_table_bak.OverDriveTable.FanMinimumPwm;
+	}
+
+	smu_v14_0_2_set_supported_od_feature_mask(smu);
+
+	return 0;
+}
+
+static int smu_v14_0_2_restore_user_od_settings(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
+	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	int res;
+
+	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
+							BIT(PP_OD_FEATURE_UCLK_BIT) |
+							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
+							BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+	res = smu_v14_0_2_upload_overdrive_table(smu, user_od_table);
+	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
+	if (res == 0)
+		memcpy(od_table, user_od_table, sizeof(OverDriveTableExternal_t));
+
+	return res;
+}
+
+static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long input)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *boot_overdrive_table =
+		(OverDriveTableExternal_t *)table_context->boot_overdrive_table;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	switch (input) {
+	case PP_OD_EDIT_FAN_CURVE:
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS; i++) {
+			od_table->OverDriveTable.FanLinearTempPoints[i] =
+					boot_overdrive_table->OverDriveTable.FanLinearTempPoints[i];
+			od_table->OverDriveTable.FanLinearPwmPoints[i] =
+					boot_overdrive_table->OverDriveTable.FanLinearPwmPoints[i];
+		}
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_ACOUSTIC_LIMIT:
+		od_table->OverDriveTable.AcousticLimitRpmThreshold =
+					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_ACOUSTIC_TARGET:
+		od_table->OverDriveTable.AcousticTargetRpmThreshold =
+					boot_overdrive_table->OverDriveTable.AcousticTargetRpmThreshold;
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+		od_table->OverDriveTable.FanTargetTemperature =
+					boot_overdrive_table->OverDriveTable.FanTargetTemperature;
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		od_table->OverDriveTable.FanMinimumPwm =
+					boot_overdrive_table->OverDriveTable.FanMinimumPwm;
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	default:
+		dev_info(adev->dev, "Invalid table index: %ld\n", input);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
+					 enum PP_OD_DPM_TABLE_COMMAND type,
+					 long input[],
+					 uint32_t size)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t offset_of_voltageoffset;
+	int32_t minimum, maximum;
+	uint32_t feature_ctrlmask;
+	int i, ret = 0;
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
+			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		for (i = 0; i < size; i += 2) {
+			if (i + 2 > size) {
+				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+				return -EINVAL;
+			}
+
+			switch (input[i]) {
+			case 0:
+				smu_v14_0_2_get_od_setting_limits(smu,
+								  PP_OD_FEATURE_GFXCLK_FMIN,
+								  &minimum,
+								  &maximum);
+				if (input[i + 1] < minimum ||
+				    input[i + 1] > maximum) {
+					dev_info(adev->dev, "GfxclkFmin (%ld) must be within [%u, %u]!\n",
+						input[i + 1], minimum, maximum);
+					return -EINVAL;
+				}
+
+				od_table->OverDriveTable.GfxclkFmin = input[i + 1];
+				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
+				break;
+
+			case 1:
+				smu_v14_0_2_get_od_setting_limits(smu,
+								  PP_OD_FEATURE_GFXCLK_FMAX,
+								  &minimum,
+								  &maximum);
+				if (input[i + 1] < minimum ||
+				    input[i + 1] > maximum) {
+					dev_info(adev->dev, "GfxclkFmax (%ld) must be within [%u, %u]!\n",
+						input[i + 1], minimum, maximum);
+					return -EINVAL;
+				}
+
+				od_table->OverDriveTable.GfxclkFmax = input[i + 1];
+				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
+				break;
+
+			default:
+				dev_info(adev->dev, "Invalid SCLK_VDDC_TABLE index: %ld\n", input[i]);
+				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
+				return -EINVAL;
+			}
+		}
+
+		if (od_table->OverDriveTable.GfxclkFmin > od_table->OverDriveTable.GfxclkFmax) {
+			dev_err(adev->dev,
+				"Invalid setting: GfxclkFmin(%u) is bigger than GfxclkFmax(%u)\n",
+				(uint32_t)od_table->OverDriveTable.GfxclkFmin,
+				(uint32_t)od_table->OverDriveTable.GfxclkFmax);
+			return -EINVAL;
+		}
+		break;
+
+	case PP_OD_EDIT_MCLK_VDDC_TABLE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
+			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		for (i = 0; i < size; i += 2) {
+			if (i + 2 > size) {
+				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+				return -EINVAL;
+			}
+
+			switch (input[i]) {
+			case 0:
+				smu_v14_0_2_get_od_setting_limits(smu,
+								  PP_OD_FEATURE_UCLK_FMIN,
+								  &minimum,
+								  &maximum);
+				if (input[i + 1] < minimum ||
+				    input[i + 1] > maximum) {
+					dev_info(adev->dev, "UclkFmin (%ld) must be within [%u, %u]!\n",
+						input[i + 1], minimum, maximum);
+					return -EINVAL;
+				}
+
+				od_table->OverDriveTable.UclkFmin = input[i + 1];
+				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_UCLK_BIT;
+				break;
+
+			case 1:
+				smu_v14_0_2_get_od_setting_limits(smu,
+								  PP_OD_FEATURE_UCLK_FMAX,
+								  &minimum,
+								  &maximum);
+				if (input[i + 1] < minimum ||
+				    input[i + 1] > maximum) {
+					dev_info(adev->dev, "UclkFmax (%ld) must be within [%u, %u]!\n",
+						input[i + 1], minimum, maximum);
+					return -EINVAL;
+				}
+
+				od_table->OverDriveTable.UclkFmax = input[i + 1];
+				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_UCLK_BIT;
+				break;
+
+			default:
+				dev_info(adev->dev, "Invalid MCLK_VDDC_TABLE index: %ld\n", input[i]);
+				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
+				return -EINVAL;
+			}
+		}
+
+		if (od_table->OverDriveTable.UclkFmin > od_table->OverDriveTable.UclkFmax) {
+			dev_err(adev->dev,
+				"Invalid setting: UclkFmin(%u) is bigger than UclkFmax(%u)\n",
+				(uint32_t)od_table->OverDriveTable.UclkFmin,
+				(uint32_t)od_table->OverDriveTable.UclkFmax);
+			return -EINVAL;
+		}
+		break;
+
+	case PP_OD_EDIT_VDDGFX_OFFSET:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
+			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_GFX_VF_CURVE,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "Voltage offset (%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
+			od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT);
+		break;
+
+	case PP_OD_EDIT_FAN_CURVE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		if (input[0] >= NUM_OD_FAN_MAX_POINTS - 1 ||
+		    input[0] < 0)
+			return -EINVAL;
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_CURVE_TEMP,
+						  &minimum,
+						  &maximum);
+		if (input[1] < minimum ||
+		    input[1] > maximum) {
+			dev_info(adev->dev, "Fan curve temp setting(%ld) must be within [%d, %d]!\n",
+				 input[1], minimum, maximum);
+			return -EINVAL;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_CURVE_PWM,
+						  &minimum,
+						  &maximum);
+		if (input[2] < minimum ||
+		    input[2] > maximum) {
+			dev_info(adev->dev, "Fan curve pwm setting(%ld) must be within [%d, %d]!\n",
+				 input[2], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanLinearTempPoints[input[0]] = input[1];
+		od_table->OverDriveTable.FanLinearPwmPoints[input[0]] = input[2];
+		od_table->OverDriveTable.FanMode = FAN_MODE_MANUAL_LINEAR;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+
+	case PP_OD_EDIT_ACOUSTIC_LIMIT:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "acoustic limit threshold setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.AcousticLimitRpmThreshold = input[0];
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+
+	case PP_OD_EDIT_ACOUSTIC_TARGET:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ACOUSTIC_TARGET,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "acoustic target threshold setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.AcousticTargetRpmThreshold = input[0];
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "fan target temperature setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanTargetTemperature = input[0];
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "fan minimum pwm setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanMinimumPwm = input[0];
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		if (size == 1) {
+			ret = smu_v14_0_2_od_restore_table_single(smu, input[0]);
+			if (ret)
+				return ret;
+		} else {
+			feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
+			memcpy(od_table,
+		       table_context->boot_overdrive_table,
+		       sizeof(OverDriveTableExternal_t));
+			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+		}
+		fallthrough;
+	case PP_OD_COMMIT_DPM_TABLE:
+		/*
+		 * The member below instructs PMFW the settings focused in
+		 * this single operation.
+		 * `uint32_t FeatureCtrlMask;`
+		 * It does not contain actual informations about user's custom
+		 * settings. Thus we do not cache it.
+		 */
+		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
+		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
+			   table_context->user_overdrive_table + offset_of_voltageoffset,
+			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset)) {
+			smu_v14_0_2_dump_od_table(smu, od_table);
+
+			ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
+			if (ret) {
+				dev_err(adev->dev, "Failed to upload overdrive table!\n");
+				return ret;
+			}
+
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
+			       (u8 *)od_table + offset_of_voltageoffset,
+			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
+
+			if (!memcmp(table_context->user_overdrive_table,
+				    table_context->boot_overdrive_table,
+				    sizeof(OverDriveTableExternal_t)))
+				smu->user_dpm_profile.user_od = false;
+			else
+				smu->user_dpm_profile.user_od = true;
+		}
+		break;
+
+	default:
+		return -ENOSYS;
+	}
+
+	return ret;
+}
+
+static int smu_v14_0_2_set_power_limit(struct smu_context *smu,
+				       enum smu_ppt_limit_type limit_type,
+				       uint32_t limit)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	int ret = 0;
+
+	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
+		return -EINVAL;
+
+	if (limit <= msg_limit) {
+		if (smu->current_power_limit > msg_limit) {
+			od_table->OverDriveTable.Ppt = 0;
+			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+
+			ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
+			if (ret) {
+				dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+				return ret;
+			}
+		}
+		return smu_v14_0_set_power_limit(smu, limit_type, limit);
+	} else if (smu->od_enabled) {
+		ret = smu_v14_0_set_power_limit(smu, limit_type, msg_limit);
+		if (ret)
+			return ret;
+
+		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
+		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+
+		ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
+		if (ret) {
+		  dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+		  return ret;
+		}
+
+		smu->current_power_limit = limit;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v14_0_2_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v14_0_2_set_default_dpm_table,
@@ -1988,13 +2869,16 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.notify_memory_pool_location = smu_v14_0_notify_memory_pool_location,
 	.get_gpu_metrics = smu_v14_0_2_get_gpu_metrics,
 	.set_soft_freq_limited_range = smu_v14_0_set_soft_freq_limited_range,
+	.set_default_od_settings = smu_v14_0_2_set_default_od_settings,
+	.restore_user_od_settings = smu_v14_0_2_restore_user_od_settings,
+	.od_edit_dpm_table = smu_v14_0_2_od_edit_dpm_table,
 	.init_pptable_microcode = smu_v14_0_init_pptable_microcode,
 	.populate_umd_state_clk = smu_v14_0_2_populate_umd_state_clk,
 	.set_performance_level = smu_v14_0_set_performance_level,
 	.gfx_off_control = smu_v14_0_gfx_off_control,
 	.get_unique_id = smu_v14_0_2_get_unique_id,
 	.get_power_limit = smu_v14_0_2_get_power_limit,
-	.set_power_limit = smu_v14_0_set_power_limit,
+	.set_power_limit = smu_v14_0_2_set_power_limit,
 	.set_power_source = smu_v14_0_set_power_source,
 	.get_power_profile_mode = smu_v14_0_2_get_power_profile_mode,
 	.set_power_profile_mode = smu_v14_0_2_set_power_profile_mode,
-- 
2.34.1

