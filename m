Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED44C001DE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9444510E23B;
	Tue, 15 Aug 2023 08:43:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0564C10E16A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbE30pVFmvs7p8Zuo95ZrbEtDav4+D7D28PW7tfL05UGvdHfcC3ZyLv3iMI5OfGQFTK3g6Xuf0SuwbiYtqCNK4xbNYXznzcoVHF3FiXGTnFhIuS3NldFer7usW5VR6rDmBRMHej6jO+9h65G8gP5kQ7Fz3Fx60BOOVtSBwOZrSbl8eo7tlLnmAeqUgyW1I/pajeADsf/w2yVp4qJ0G1/BiNepiPju63z1dlBStNpVinu4qR179LLZv3pAoWG90zMTxkEh+QkzTV8lg/K+ziZzQNX03Sv9a+H22TNvPM3UPOmnpN4whp4DdBpZ3nP1s2FtSLu14ECad8/Ze9eXdXCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzM2KWURPFDrQZV84+Y7eoEmmvOIv8ql1oKFNmDZaw8=;
 b=SS0g749AO0RH90aTU6TP1JSR3d1KhRHql3piodXPhAwOc2e39paKug9HayTyZjXOuJ1inNSw9vVb0gP5ucUaN4ZNA9BQ9SWFaElhm//jSe0aOwaCqWYSYkWlWSzmiCluQTdVkoMs/6w/TxbBhfNx16D2Mt4BGi1x5k4XDI6h9oeNGgnsXS0g7Qmzn5BbnbFUNDkpJI8GzeDq7MImhHwnN+1SrAOR8zINTEENYCIuEdV6bmaxEFNf4t9rEYc8PqibZ8ygEvjBbwn68r7+nJoDTCI/PPdHegYhcMqxKrLfxqcz5cZP0t+7daUpablsd8oRkJOq1arF8dueyd+A1ZD8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzM2KWURPFDrQZV84+Y7eoEmmvOIv8ql1oKFNmDZaw8=;
 b=Fi3M9ueHLB2jWgeMP+YNJXXztbSonRRA5AZ1dJRDHIDoH0tIbe6hiXLA9ZNX01RDNjrG7Kn1BSwn2nv2f3Fhfvi/BfE2fBn3pZV9XinCHDJHR1J6W00fY21O5YfvAf+zfVyy1OdaGvooYlK5N1WLwcj3t/QSVF4XgRQch2RHc0A=
Received: from SJ0PR03CA0167.namprd03.prod.outlook.com (2603:10b6:a03:338::22)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Tue, 15 Aug
 2023 08:43:39 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::82) by SJ0PR03CA0167.outlook.office365.com
 (2603:10b6:a03:338::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 08:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 08:43:38 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:43:33 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amd/pm: add fan acoustic limit OD setting support for
 SMU13
Date: Tue, 15 Aug 2023 16:42:28 +0800
Message-ID: <20230815084231.3229009-6-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ab8e2a-6a12-496e-fe45-08db9d6bb8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAL0apqllERYLjYT6lrp7ybH+w5JvYyOHbBOy4ER0Uh3eqdSa80WKUr50cE4uG4nuvTl4bJqG7Tt5gKckseEacndl4J4/ydlb1LlWMv9jW/wLLrrqtms8Kwup52drgJY+o99e+kmhctAkvznyvCKBlSyUVrEAZxNrf96mw1QiLMumLt83QFxrmOjxoruq5/hQFm4yKs55RmR/WdlthE+1xx7X7nkBtG6IvwZoeale731TB1CFubr97pbkR7GxtZqjCTh3quGNimmWrrOGYGJyJdqDjbaaPomS7HDR30p3nklI8eIZAFovxLdCBLIbozmfNxjfPUJNk5+iDdeXD9Cx/Xao5Bz9BcdNDjr4CLlZAq6E/B8tzhD/iUvkbwr0gzaAHNM+kr6NtpAmHCMNv3lOGOgd8qXpNQc33/NO04MCcIC0NTMqhOKIWRAJ1NRIBw0YDJR1MBLvJoaacBIuyuafe9svLXm/KH95wFkA7XyscIa2vp0omJkMod2nV1NRaS0xykH/tVrOEOsw7qtZGpgby82mc2XnzGIujn5+vlKjh5+0hahLpRAcovbgIjTLVx8qRKah1DgG6+FUmgYsYvolu5Rag7JQiHalotz119S83iO7r1ZAbZDK8dK307BGIzbq5c5DLhfy74jc7Rfs3H6rsnDRkt7MLYCAy1R/0gk1lCUtTWls9aBz4z7hEjfedgrs+VOxlYbHPrG8Y6VyZ7u5vRtIxoA/sjCueh1Jv9mCiRYzromD77nsDKKELp9gZ6JItnSgRcOUcYygWWuqxQlRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(186006)(82310400008)(451199021)(1800799006)(46966006)(40470700004)(36840700001)(81166007)(8936002)(1076003)(26005)(40460700003)(82740400003)(8676002)(36860700001)(47076005)(36756003)(2906002)(83380400001)(426003)(30864003)(41300700001)(2616005)(356005)(44832011)(86362001)(16526019)(336012)(4326008)(70586007)(70206006)(6916009)(40480700001)(54906003)(478600001)(7696005)(6666004)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:43:38.9194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ab8e2a-6a12-496e-fe45-08db9d6bb8cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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

Add SMU13 fan acoustic limit OD setting support.

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
index 3743777b45cb..aa07c5d0d3c9 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -115,6 +115,7 @@ enum pp_clock_type {
 	OD_CCLK,
 	OD_FAN_MODE,
 	OD_FAN_CURVE,
+	OD_ACOUSTIC_LIMIT,
 };
 
 enum amd_pp_sensors {
@@ -190,6 +191,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_VDDGFX_OFFSET,
 	PP_OD_EDIT_FAN_MODE,
 	PP_OD_EDIT_FAN_CURVE,
+	PP_OD_EDIT_ACOUSTIC_LIMIT,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 7baebe45b912..e09da037d605 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3721,6 +3721,43 @@ static umode_t fan_curve_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+static ssize_t acoustic_limit_threshold_show(struct kobject *kobj,
+					     struct kobj_attribute *attr,
+					     char *buf)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_ACOUSTIC_LIMIT, buf);
+}
+
+static ssize_t acoustic_limit_threshold_store(struct kobject *kobj,
+					      struct kobj_attribute *attr,
+					      const char *buf,
+					      size_t count)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
+							     PP_OD_EDIT_ACOUSTIC_LIMIT,
+							     buf,
+							     count);
+}
+
+static umode_t acoustic_limit_threshold_visible(struct amdgpu_device *adev)
+{
+	umode_t umode = 0000;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE)
+		umode |= S_IRUSR | S_IRGRP | S_IROTH;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET)
+		umode |= S_IWUSR;
+
+	return umode;
+}
+
 static struct od_feature_set amdgpu_od_set = {
 	.containers = {
 		[0] = {
@@ -3742,6 +3779,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = fan_curve_store,
 					},
 				},
+				[2] = {
+					.name = "acoustic_limit_rpm_threshold",
+					.ops = {
+						.is_visible = acoustic_limit_threshold_visible,
+						.show = acoustic_limit_threshold_show,
+						.store = acoustic_limit_threshold_store,
+					},
+				},
 			},
 		},
 	},
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 4463c60b710a..17ffcef34e61 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -318,6 +318,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_FAN_MODE_SET			BIT(1)
 #define OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE		BIT(2)
 #define OD_OPS_SUPPORT_FAN_CURVE_SET			BIT(3)
+#define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE	BIT(4)
+#define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET		BIT(5)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fe998df9dca2..3db6bd49b73c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2485,6 +2485,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_FAN_MODE; break;
 	case OD_FAN_CURVE:
 		clk_type = SMU_OD_FAN_CURVE; break;
+	case OD_ACOUSTIC_LIMIT:
+		clk_type = SMU_OD_ACOUSTIC_LIMIT; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index dc5f6e166907..63fe6f2882cf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -280,6 +280,7 @@ enum smu_clk_type {
 	SMU_OD_VDDGFX_OFFSET,
 	SMU_OD_FAN_MODE,
 	SMU_OD_FAN_CURVE,
+	SMU_OD_ACOUSTIC_LIMIT,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 426652af4fc5..25c1a11e2d8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -104,6 +104,7 @@
 #define PP_OD_FEATURE_FAN_MODE				5
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			6
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
+#define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1098,6 +1099,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanLinearPwmPoints;
 		od_max_setting = overdrive_upperlimits->FanLinearPwmPoints;
 		break;
+	case PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT:
+		od_min_setting = overdrive_lowerlimits->AcousticLimitRpmThreshold;
+		od_max_setting = overdrive_upperlimits->AcousticLimitRpmThreshold;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1354,6 +1359,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 
 		break;
 
+	case SMU_OD_ACOUSTIC_LIMIT:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_LIMIT:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.AcousticLimitRpmThreshold);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ACOUSTIC_LIMIT: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1605,6 +1628,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_ACOUSTIC_LIMIT:
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_0_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1860,7 +1905,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 						PP_OD_FEATURE_FAN_CURVE_BIT))
 		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_CURVE_SET;
+					    OD_OPS_SUPPORT_FAN_CURVE_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -1920,6 +1967,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
 				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
 		}
+		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 72bbbd2569e9..55f0f8b32fab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -80,6 +80,7 @@
 #define PP_OD_FEATURE_FAN_MODE				5
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			6
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
+#define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1085,6 +1086,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanLinearPwmPoints;
 		od_max_setting = overdrive_upperlimits->FanLinearPwmPoints;
 		break;
+	case PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT:
+		od_min_setting = overdrive_lowerlimits->AcousticLimitRpmThreshold;
+		od_max_setting = overdrive_upperlimits->AcousticLimitRpmThreshold;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1341,6 +1346,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 
 		break;
 
+	case SMU_OD_ACOUSTIC_LIMIT:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_ACOUSTIC_LIMIT:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.AcousticLimitRpmThreshold);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ACOUSTIC_LIMIT: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1592,6 +1615,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_ACOUSTIC_LIMIT:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_7_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1842,7 +1887,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 						PP_OD_FEATURE_FAN_CURVE_BIT))
 		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_CURVE_SET;
+					    OD_OPS_SUPPORT_FAN_CURVE_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -1902,6 +1949,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
 				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
 		}
+		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

