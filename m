Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB3BC001B0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB4D10E16E;
	Tue, 15 Aug 2023 08:43:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3341610E16A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGX02Gb6bYn5E0eGEwfQoYuPJosTXHuPkTrdryQS7SXzEM8VaBt3d/ySc0aeT0z73kXagS9OKBinbVIlqlIRpez59qZfFqco5OXe+JuVegw/c7g1czyKIMocboa41sHcDVw2BRrglilMm39Phwp+OSp8fyPtyJE5Sjt4rfxulo31AIrWN/kayfTn7gCQ1Rr0YjCoW2q3RAAs4C+5M0exYV9qqVgV8fO6TaV9WMcDaNW1OcQsO2faGhFQpHxMxJmKZZJBEj7NRoDuAkhv3xvGBto1u0fTs4p3NL3BatHseKtSsizNHuBX7LiAZLmjG/0KrlKoL4jtTqsBtt+5eCu8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z55dvs48JJQeMDqYyMPA8zU78sexfbajewh9q7WUmbs=;
 b=P1V4u+Up++Rh2SAxF21lAIzpGtxRZioHOfxFCT7LEdm0fmM3DP5p6eYzrGS1Dv67OPiQeHDYpkIzoah0/IlAY/2Y97ohTLcf+d/DLRcfYOSt4CodMefKmsmY6idwb2uHn3CF5oVlByP43nXy4g5g1T5YipOMzypvmWrSTVQXeFaVGGUoLHfYImh9C0qdfZ/LpmWBV3cPqFpOyACkdmaN1Yi9PXOr5CqtbC6bp0oaWGd/+VD+6RVfjGIsxBWVnO0jCzr0FBiSI5H3IReGC0JSMxCTTnc6N/KQC06c5b3UZIeiktgBjcj13Xzik9+rdil+J0IZKnOO+eKJpc5VsCI3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z55dvs48JJQeMDqYyMPA8zU78sexfbajewh9q7WUmbs=;
 b=PacBMc/FKhgNR2otbsdpeoUl/isB94xN69UcPF7fcFV457GkTKdT3nBcEiFmVCoE4m1Hnkm/61C2vrdjwUDdqFpkoko0HSnhJBZ4vqViHEnOXmnIfwvMf5ubM/+5dGI3KuRccraA0WjzuX5FRTZDRdgQ/lUC0etyexvtGWC7WGU=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 08:43:39 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::23) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 08:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 08:43:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:43:35 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amd/pm: add fan acoustic target OD setting support
 for SMU13
Date: Tue, 15 Aug 2023 16:42:29 +0800
Message-ID: <20230815084231.3229009-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815084231.3229009-1-evan.quan@amd.com>
References: <20230815084231.3229009-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BN9PR12MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 903425de-e3aa-4ae3-9a56-08db9d6bb8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UBY/Fb8vo0g7waTxMZU5DjJ7UZCjtOAA3Sh0P3iGzyVKvLCHa0VsS7V7dYQg6CyRtqj4iWwhdAQ4aFxIurlP44BQf8DYyR/Ajxnd6qG0kTiA5+1A+svP6m0qi5ArwAOH66Wx0PVO7ui5zvBTm8aPrvfTvfusp/qarXIkmcyjTa4lkz2gkpEnaeBt3+AzuGG31dR1U/PJc+oO8F631GB2zIcotTGv77HiPpqi4Phx84P7mF05vt0OygaAXg/DT0ux5XS6jACxH+D0Jb9rDlYE8DqJIbDy9uLYF8ycTVpmhwvJK0BH7oUveua1wABopgJykRCsOSbhNKHCFpxIJ4S4qzdZRCJ1RdPl9fxrdsN9DuAqskvkcriMRAjvAy3mDKtm45wnluPTnDqt5gLKOj2FdgyUKTlqFzkr8VCvxFE0oXXxxmsGosRLoTGpSgAsO0OLQ1dbjQQ4zmU80M6GAUk6XnY9msYheole6C2ffuPdFwk6YHCPAgQxDoqFZEuRXVTC608Fu/zkD6suCC/W1Hqy+KYjJd57mRUtGQ5XBfAqqzB7l1qckpm3Ntieo9gnkDHxmXC9ju+Vc+VoOpcAhlVfm7HxmCTGT2o9p6kybjlMXAaY/kEISvG5VGbcRe9cWtGW8sKka+qvIHCPGgR69aMu4IB3y0yaH6h8WfZ8lfyCd6xGhmIpApqCzxBZsg0kQVGZlFLqqcxmA/Wlp+40iT4PtDtqqfLpoSqQXpYyvJaALzB6OK6wqHx+cLxnfD/Fks2gCEfiBCHv934lzoF31eepA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(82310400008)(451199021)(1800799006)(186006)(36840700001)(40470700004)(46966006)(40480700001)(54906003)(7696005)(6666004)(478600001)(40460700003)(81166007)(356005)(82740400003)(44832011)(2906002)(5660300002)(30864003)(36756003)(86362001)(4326008)(6916009)(70586007)(70206006)(41300700001)(336012)(8936002)(8676002)(316002)(16526019)(1076003)(26005)(36860700001)(83380400001)(47076005)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:43:39.0585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903425de-e3aa-4ae3-9a56-08db9d6bb8e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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

Add SMU13 fan acoustic target OD setting support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 45 ++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 51 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 51 ++++++++++++++++++-
 7 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index aa07c5d0d3c9..06ed73a6b5f3 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -116,6 +116,7 @@ enum pp_clock_type {
 	OD_FAN_MODE,
 	OD_FAN_CURVE,
 	OD_ACOUSTIC_LIMIT,
+	OD_ACOUSTIC_TARGET,
 };
 
 enum amd_pp_sensors {
@@ -192,6 +193,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_FAN_MODE,
 	PP_OD_EDIT_FAN_CURVE,
 	PP_OD_EDIT_ACOUSTIC_LIMIT,
+	PP_OD_EDIT_ACOUSTIC_TARGET,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e09da037d605..6a75b53189b7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3758,6 +3758,43 @@ static umode_t acoustic_limit_threshold_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+static ssize_t acoustic_target_threshold_show(struct kobject *kobj,
+					      struct kobj_attribute *attr,
+					      char *buf)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_ACOUSTIC_TARGET, buf);
+}
+
+static ssize_t acoustic_target_threshold_store(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       const char *buf,
+					       size_t count)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
+							     PP_OD_EDIT_ACOUSTIC_TARGET,
+							     buf,
+							     count);
+}
+
+static umode_t acoustic_target_threshold_visible(struct amdgpu_device *adev)
+{
+	umode_t umode = 0000;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE)
+		umode |= S_IRUSR | S_IRGRP | S_IROTH;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET)
+		umode |= S_IWUSR;
+
+	return umode;
+}
+
 static struct od_feature_set amdgpu_od_set = {
 	.containers = {
 		[0] = {
@@ -3787,6 +3824,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = acoustic_limit_threshold_store,
 					},
 				},
+				[3] = {
+					.name = "acoustic_target_rpm_threshold",
+					.ops = {
+						.is_visible = acoustic_target_threshold_visible,
+						.show = acoustic_target_threshold_show,
+						.store = acoustic_target_threshold_store,
+					},
+				},
 			},
 		},
 	},
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 17ffcef34e61..6b2bbd13db09 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -320,6 +320,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_FAN_CURVE_SET			BIT(3)
 #define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE	BIT(4)
 #define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET		BIT(5)
+#define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE	BIT(6)
+#define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET		BIT(7)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3db6bd49b73c..3bfa9b9bb247 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2487,6 +2487,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_FAN_CURVE; break;
 	case OD_ACOUSTIC_LIMIT:
 		clk_type = SMU_OD_ACOUSTIC_LIMIT; break;
+	case OD_ACOUSTIC_TARGET:
+		clk_type = SMU_OD_ACOUSTIC_TARGET; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 63fe6f2882cf..1463a5d41647 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -281,6 +281,7 @@ enum smu_clk_type {
 	SMU_OD_FAN_MODE,
 	SMU_OD_FAN_CURVE,
 	SMU_OD_ACOUSTIC_LIMIT,
+	SMU_OD_ACOUSTIC_TARGET,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 25c1a11e2d8a..78337380a6b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -105,6 +105,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			6
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
+#define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
 
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1103,6 +1104,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->AcousticLimitRpmThreshold;
 		od_max_setting = overdrive_upperlimits->AcousticLimitRpmThreshold;
 		break;
+	case PP_OD_FEATURE_FAN_ACOUSTIC_TARGET:
+		od_min_setting = overdrive_lowerlimits->AcousticTargetRpmThreshold;
+		od_max_setting = overdrive_upperlimits->AcousticTargetRpmThreshold;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1377,6 +1382,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_ACOUSTIC_TARGET:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_TARGET:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.AcousticTargetRpmThreshold);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ACOUSTIC_TARGET,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ACOUSTIC_TARGET: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1650,6 +1673,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_ACOUSTIC_TARGET:
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_0_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1907,7 +1952,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -1969,6 +2016,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 		}
 		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
+		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 55f0f8b32fab..8d4d0864aa73 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -81,6 +81,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			6
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
+#define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
 
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1090,6 +1091,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->AcousticLimitRpmThreshold;
 		od_max_setting = overdrive_upperlimits->AcousticLimitRpmThreshold;
 		break;
+	case PP_OD_FEATURE_FAN_ACOUSTIC_TARGET:
+		od_min_setting = overdrive_lowerlimits->AcousticTargetRpmThreshold;
+		od_max_setting = overdrive_upperlimits->AcousticTargetRpmThreshold;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1364,6 +1369,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_ACOUSTIC_TARGET:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_TARGET:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.AcousticTargetRpmThreshold);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ACOUSTIC_TARGET,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ACOUSTIC_TARGET: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1637,6 +1660,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_ACOUSTIC_TARGET:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_7_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1889,7 +1934,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -1951,6 +1998,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 		}
 		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
+		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

