Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C25C001DF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 01:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 921A810E1BE;
	Thu,  3 Aug 2023 01:36:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 821A710E0A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 01:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mliedXpZR4kcIIu4twf1nUyAx6igj6YFUAycuxz+aRnSJRkc91VugHsmG0oRzjZvNt4sgF+O0DbH3FnIl+m0i30jbqaX5TAuCK6iBsNUbQwC2P93TsUCZFQbuc6kN43+Pg/TVPJNhk66uzt20dX6b/DdBdJNGdP3RX2CKkIqk3aQoz/ypZ+RrwUc8wichQyWLJ79p7ZxxQpf0802r0GqU06lfr7KAqc1AJV+CzH4h3te4Et1tUTdW21vRCJur/Z7jVLxqgMnVEckMm8G84x5g64gIzUy4X+rMolTxxH/q6Izopd1UrlPelqS1l8ftfBY+2rgN1+nrEuqvo+Y7ntvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQC2nkBWKsO2iMAUEuUE+hydUUfdLBauV45nVXoA7AU=;
 b=nreeiuZys79dqFlMEBZt+eo7oEyiYK21YTLv9AdHg9h1Ru24Ne6Z1e7FDahXshWNPfAcFN6idQKo/D8ju1KvngSQIQtGKrlz9yOD2DrVy6USvReesPzaAx4LH6zO09BF64sMWvlclOlW82rMOugPxCAiC1Fz+yXSORTak8L4Dnfb+AZD7FnmAw2xpOalASInJx7FSM6OFWCP8DS29mnJ4twrx32GRR3Md8s6iEBTVvNWgjHiI9ok5+MRPMtEGvhIDxkwTTN86ep0tXMAXRMd1Kso+V/xHoSjChnQhcqc5iWtctIpCUfG/QzKUbozz0FtGpguYqpAKiuegYxgPejSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQC2nkBWKsO2iMAUEuUE+hydUUfdLBauV45nVXoA7AU=;
 b=RP9O7bQGFKATbYu4w9qM5ZuHTwxwvoyNQvXCaW8YBDwyL4X33l5ecZVhOQLF3NayAJIgQ95lsai2eV+jTwPwowscQGfbhY6zQnqnUaWVI+wg/+iJMlnp/WWNH2zmSUeS6gbTY3HQqA5ONWQ6zUgkb5HTWXLbSF0VB/v+a0gf52U=
Received: from SA0PR11CA0184.namprd11.prod.outlook.com (2603:10b6:806:1bc::9)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 01:36:21 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::b8) by SA0PR11CA0184.outlook.office365.com
 (2603:10b6:806:1bc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 01:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 01:36:20 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 20:36:19 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: correct the logics for retreiving SMU13 OD
 setting limits
Date: Thu, 3 Aug 2023 09:35:59 +0800
Message-ID: <20230803013559.506617-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803013559.506617-1-evan.quan@amd.com>
References: <20230803013559.506617-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6698e8-b052-4d36-14c6-08db93c20a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4gg8B4rUDFyXMaicAQwp+pfcQxe7EZG9mbGuyC9vP8jMwKAPxa3Mtb5qzfCHUQ9TWIoaP2mCKNrbKGFMDaPR72JL1y6f9umnOyeJYxJJqhPHoSt7qVf2gxgvfzIXBXfR1/KhZHYosH1zedQc+ullEbIDrLu6WFQW+lbzuAd2qROl0KzhF8pABb6OEqW/Az8IVQu0ckj6hF6lZPRJxZUSHSanAPP3wLtngYRgscW/3wt9ugZvw5FL7aIuTSXXKQ3SeqyU3Zc6eg3C4zDm3DQwHM6w3sLvUppSKJlgopCZU79VnN62H5PjHXRXCAELz/A3wdTRFGmZiTV5SG63yz2NKgLu9Uik0jFGuIytUZiCFYiyprFWxVSCGg2ZaKEP9OQ7uiGh25aHM5re1tjym8Ww3a0Uy2IY7m6qijb9C39j8xKpWIScnMPD1CZGLNYCP/ZuK5FLSn5NbTW8AfZq6C6wS3/MpmYxWLfKuvRKL9e8+y40DBxLSWvYfw/UclDgdjEHzsjjj1SF67LmpQOZng0QLKlV7TBpC8D3kdz4zxUCjpLrWkp+KDlZ0NuNhIdlwMp4gPGlWh+u7N1upoAJFyRbm7ODWs6PFqAlJ1mvpM3hnfucM5JqPwmfAn5OIkwgFgw2B7MqMQ7B4onBsVpvbgvFnXmW8pNmv3AsizE9HsXuY+MsUho5hAHobeGuZ1CmVLJU6zU4eaxVBw+NWxrDTEeoy9OhUSEFaDzgYP539Ti34I5EG/HOhqy0m1YYrmN6qg5YvBLL+8GlXtrevTE6j+z5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(426003)(2616005)(336012)(1076003)(83380400001)(26005)(186003)(47076005)(36860700001)(316002)(30864003)(70206006)(70586007)(2906002)(4326008)(6916009)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(7696005)(478600001)(54906003)(40480700001)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:36:20.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6698e8-b052-4d36-14c6-08db93c20a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To better meet the growing demainds for more OD features.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 70 +++++++++----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 70 +++++++++----------
 2 files changed, 64 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2570e03e0fa7..f636a127983a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -97,6 +97,12 @@
  */
 #define SUPPORT_ECCTABLE_SMU_13_0_10_VERSION 0x00502200
 
+#define PP_OD_FEATURE_GFXCLK_FMIN			0
+#define PP_OD_FEATURE_GFXCLK_FMAX			1
+#define PP_OD_FEATURE_UCLK_FMIN				2
+#define PP_OD_FEATURE_UCLK_FMAX				3
+#define PP_OD_FEATURE_GFX_VF_CURVE			4
+
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -1044,7 +1050,6 @@ static bool smu_v13_0_0_is_od_feature_supported(struct smu_context *smu,
 
 static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 					      int od_feature_bit,
-					      bool lower_boundary,
 					      int32_t *min,
 					      int32_t *max)
 {
@@ -1056,29 +1061,28 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 	int32_t od_min_setting, od_max_setting;
 
 	switch (od_feature_bit) {
-	case PP_OD_FEATURE_GFXCLK_BIT:
-		if (lower_boundary) {
-			od_min_setting = overdrive_lowerlimits->GfxclkFmin;
-			od_max_setting = overdrive_upperlimits->GfxclkFmin;
-		} else {
-			od_min_setting = overdrive_lowerlimits->GfxclkFmax;
-			od_max_setting = overdrive_upperlimits->GfxclkFmax;
-		}
+	case PP_OD_FEATURE_GFXCLK_FMIN:
+		od_min_setting = overdrive_lowerlimits->GfxclkFmin;
+		od_max_setting = overdrive_upperlimits->GfxclkFmin;
 		break;
-	case PP_OD_FEATURE_UCLK_BIT:
-		if (lower_boundary) {
-			od_min_setting = overdrive_lowerlimits->UclkFmin;
-			od_max_setting = overdrive_upperlimits->UclkFmin;
-		} else {
-			od_min_setting = overdrive_lowerlimits->UclkFmax;
-			od_max_setting = overdrive_upperlimits->UclkFmax;
-		}
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
 		break;
-	case PP_OD_FEATURE_GFX_VF_CURVE_BIT:
+	case PP_OD_FEATURE_GFX_VF_CURVE:
 		od_min_setting = overdrive_lowerlimits->VoltageOffsetPerZoneBoundary;
 		od_max_setting = overdrive_upperlimits->VoltageOffsetPerZoneBoundary;
 		break;
 	default:
+		od_min_setting = od_max_setting = INT_MAX;
 		break;
 	}
 
@@ -1305,13 +1309,11 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 
 		if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
 			smu_v13_0_0_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_GFXCLK_BIT,
-							  true,
+							  PP_OD_FEATURE_GFXCLK_FMIN,
 							  &min_value,
 							  NULL);
 			smu_v13_0_0_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_GFXCLK_BIT,
-							  false,
+							  PP_OD_FEATURE_GFXCLK_FMAX,
 							  NULL,
 							  &max_value);
 			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
@@ -1320,13 +1322,11 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 
 		if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
 			smu_v13_0_0_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_UCLK_BIT,
-							  true,
+							  PP_OD_FEATURE_UCLK_FMIN,
 							  &min_value,
 							  NULL);
 			smu_v13_0_0_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_UCLK_BIT,
-							  false,
+							  PP_OD_FEATURE_UCLK_FMAX,
 							  NULL,
 							  &max_value);
 			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
@@ -1335,8 +1335,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 
 		if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
 			smu_v13_0_0_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_GFX_VF_CURVE_BIT,
-							  true,
+							  PP_OD_FEATURE_GFX_VF_CURVE,
 							  &min_value,
 							  &max_value);
 			size += sysfs_emit_at(buf, size, "VDDC_CURVE: %7dmv %10dmv\n",
@@ -1381,8 +1380,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 			switch (input[i]) {
 			case 0:
 				smu_v13_0_0_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_GFXCLK_BIT,
-								  true,
+								  PP_OD_FEATURE_GFXCLK_FMIN,
 								  &minimum,
 								  &maximum);
 				if (input[i + 1] < minimum ||
@@ -1398,8 +1396,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 			case 1:
 				smu_v13_0_0_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_GFXCLK_BIT,
-								  false,
+								  PP_OD_FEATURE_GFXCLK_FMAX,
 								  &minimum,
 								  &maximum);
 				if (input[i + 1] < minimum ||
@@ -1444,8 +1441,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 			switch (input[i]) {
 			case 0:
 				smu_v13_0_0_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_UCLK_BIT,
-								  true,
+								  PP_OD_FEATURE_UCLK_FMIN,
 								  &minimum,
 								  &maximum);
 				if (input[i + 1] < minimum ||
@@ -1461,8 +1457,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 			case 1:
 				smu_v13_0_0_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_UCLK_BIT,
-								  false,
+								  PP_OD_FEATURE_UCLK_FMAX,
 								  &minimum,
 								  &maximum);
 				if (input[i + 1] < minimum ||
@@ -1503,8 +1498,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 
 		smu_v13_0_0_get_od_setting_limits(smu,
-						  PP_OD_FEATURE_GFX_VF_CURVE_BIT,
-						  true,
+						  PP_OD_FEATURE_GFX_VF_CURVE,
 						  &minimum,
 						  &maximum);
 		if (input[1] < minimum ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index aa381991dede..708d977103ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -72,6 +72,12 @@
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 
+#define PP_OD_FEATURE_GFXCLK_FMIN			0
+#define PP_OD_FEATURE_GFXCLK_FMAX			1
+#define PP_OD_FEATURE_UCLK_FMIN				2
+#define PP_OD_FEATURE_UCLK_FMAX				3
+#define PP_OD_FEATURE_GFX_VF_CURVE			4
+
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -1034,7 +1040,6 @@ static bool smu_v13_0_7_is_od_feature_supported(struct smu_context *smu,
 
 static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 					      int od_feature_bit,
-					      bool lower_boundary,
 					      int32_t *min,
 					      int32_t *max)
 {
@@ -1046,29 +1051,28 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 	int32_t od_min_setting, od_max_setting;
 
 	switch (od_feature_bit) {
-	case PP_OD_FEATURE_GFXCLK_BIT:
-		if (lower_boundary) {
-			od_min_setting = overdrive_lowerlimits->GfxclkFmin;
-			od_max_setting = overdrive_upperlimits->GfxclkFmin;
-		} else {
-			od_min_setting = overdrive_lowerlimits->GfxclkFmax;
-			od_max_setting = overdrive_upperlimits->GfxclkFmax;
-		}
+	case PP_OD_FEATURE_GFXCLK_FMIN:
+		od_min_setting = overdrive_lowerlimits->GfxclkFmin;
+		od_max_setting = overdrive_upperlimits->GfxclkFmin;
 		break;
-	case PP_OD_FEATURE_UCLK_BIT:
-		if (lower_boundary) {
-			od_min_setting = overdrive_lowerlimits->UclkFmin;
-			od_max_setting = overdrive_upperlimits->UclkFmin;
-		} else {
-			od_min_setting = overdrive_lowerlimits->UclkFmax;
-			od_max_setting = overdrive_upperlimits->UclkFmax;
-		}
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
 		break;
-	case PP_OD_FEATURE_GFX_VF_CURVE_BIT:
+	case PP_OD_FEATURE_GFX_VF_CURVE:
 		od_min_setting = overdrive_lowerlimits->VoltageOffsetPerZoneBoundary;
 		od_max_setting = overdrive_upperlimits->VoltageOffsetPerZoneBoundary;
 		break;
 	default:
+		od_min_setting = od_max_setting = INT_MAX;
 		break;
 	}
 
@@ -1294,13 +1298,11 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 
 		if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
 			smu_v13_0_7_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_GFXCLK_BIT,
-							  true,
+							  PP_OD_FEATURE_GFXCLK_FMIN,
 							  &min_value,
 							  NULL);
 			smu_v13_0_7_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_GFXCLK_BIT,
-							  false,
+							  PP_OD_FEATURE_GFXCLK_FMAX,
 							  NULL,
 							  &max_value);
 			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
@@ -1309,13 +1311,11 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 
 		if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
 			smu_v13_0_7_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_UCLK_BIT,
-							  true,
+							  PP_OD_FEATURE_UCLK_FMIN,
 							  &min_value,
 							  NULL);
 			smu_v13_0_7_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_UCLK_BIT,
-							  false,
+							  PP_OD_FEATURE_UCLK_FMAX,
 							  NULL,
 							  &max_value);
 			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
@@ -1324,8 +1324,7 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 
 		if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
 			smu_v13_0_7_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_GFX_VF_CURVE_BIT,
-							  true,
+							  PP_OD_FEATURE_GFX_VF_CURVE,
 							  &min_value,
 							  &max_value);
 			size += sysfs_emit_at(buf, size, "VDDC_CURVE: %7dmv %10dmv\n",
@@ -1370,8 +1369,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 			switch (input[i]) {
 			case 0:
 				smu_v13_0_7_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_GFXCLK_BIT,
-								  true,
+								  PP_OD_FEATURE_GFXCLK_FMIN,
 								  &minimum,
 								  &maximum);
 				if (input[i + 1] < minimum ||
@@ -1387,8 +1385,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 			case 1:
 				smu_v13_0_7_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_GFXCLK_BIT,
-								  false,
+								  PP_OD_FEATURE_GFXCLK_FMAX,
 								  &minimum,
 								  &maximum);
 				if (input[i + 1] < minimum ||
@@ -1433,8 +1430,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 			switch (input[i]) {
 			case 0:
 				smu_v13_0_7_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_UCLK_BIT,
-								  true,
+								  PP_OD_FEATURE_UCLK_FMIN,
 								  &minimum,
 								  &maximum);
 				if (input[i + 1] < minimum ||
@@ -1450,8 +1446,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 			case 1:
 				smu_v13_0_7_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_UCLK_BIT,
-								  false,
+								  PP_OD_FEATURE_UCLK_FMAX,
 								  &minimum,
 								  &maximum);
 				if (input[i + 1] < minimum ||
@@ -1492,8 +1487,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 
 		smu_v13_0_7_get_od_setting_limits(smu,
-						  PP_OD_FEATURE_GFX_VF_CURVE_BIT,
-						  true,
+						  PP_OD_FEATURE_GFX_VF_CURVE,
 						  &minimum,
 						  &maximum);
 		if (input[1] < minimum ||
-- 
2.34.1

