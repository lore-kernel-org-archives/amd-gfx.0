Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FEBC001B0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0C910E23F;
	Tue, 15 Aug 2023 08:43:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B993110E16A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpaEKMsGYB/39FYBABWckGYGRA3kMPoQrelNlQGROGh3EZa6uw3/h8Gbx3rBzksUBFknUEW1KbUaD26L5+W1x52SlBbBBgvDm/DVyEcyXICfpTHZ5LnpVpQ3TTQTSeHTF/fS/lp7gxKcNvEMwF/QPLRUP8WcSg7knTP9IAjF6QMzoINsCyDzQWOQ5eb7jW8soMdCEJbGLdjTWmxZMdsjnY3FXHw2GEFfP93yErrOq3n9qy6IBHldW32OSWXOlc4b0tqpBYCsnqAVB0tnkQwMCzTwyW87FfQ07Je0+YqdRQM+3Cod5bPQ9vvLamdQ9mrJHaJGybRTay50c1tgago4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBv9wXzrkiNtiOru0YaLaHRM2cvi2RjGErqkw2cSvnk=;
 b=jOzEpndE2x4b+rUZsHwstHnEfwLbVjA9rBsH/3FFvkU/msCHkpb9jeEZUWLY3xDATkQZ61hILNeTvtpHkM9XDpWDgmzyWfb7ObIycNIKDUBAzIBlp2UbByvS48MaeTF79tpnz+19x3fjwEVlC3fIYOXMJTWunv8FH6pnMmgE7C5Zuav20e+tYA3aLpRWYeIj7v3Rqnc+h+aHmH9bNQZhwpTQVEGxipTmFeUoUmkrjZzCWfsUPYCo081v+ynOC8WflCc/+ZrE39qzAF5cxyWLvSFd4jLhDZDuS/fzLjIq2BX74kAIj+ohbPyv2GdNwa9MufB2ZWVpebxGgMM/qS1Oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBv9wXzrkiNtiOru0YaLaHRM2cvi2RjGErqkw2cSvnk=;
 b=LpJ6SbHO2qt5hX1wyvBb623S2Vu05sljxbjLEijCZ2cZU65Nc6cWnEcxs1EOOCWOAjbnpDdqMzAp4w7d+ZbB6mvNuRukOliD7DoffFORNy6bNqgo56KPKeMGiOnrfZgCk1YxluOcPvSRwSKt0wOwvi/gCxJMWRm7SGJumQpUPq4=
Received: from MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::19)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Tue, 15 Aug
 2023 08:43:40 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::32) by MW4P221CA0014.outlook.office365.com
 (2603:10b6:303:8b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 08:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 08:43:40 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:43:38 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amd/pm: add fan minimum pwm OD setting support for
 SMU13
Date: Tue, 15 Aug 2023 16:42:31 +0800
Message-ID: <20230815084231.3229009-9-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bcba90-c988-40b9-6ab2-08db9d6bb99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+CtO/Zq/NgHF0s2gb2VAGFpht8f3GHt1C1QkyHWa2d+P7//oJk7pnsQWEB5oATZ5p3m1ti6q9pBG8c02jJhKdazzrfIvvVs8PgnVERgSXAw3vaYyfWqK58xjnLuveJVgXNw2+i1MSKx8pEQfDPxRdSV4vxcc400H/eV+tEHSAB04fNYNo9KSVlxjLqlafgxpoF8CMKKPoq0rKz4d7NaM0c6g//6kS6dye7mPsES94NYoZI8jRs/xRp0X6QNda57DaOipBZMytzb9bws5+gBO2HF7cTFh2i6XzgIWZSBgPu67L9oScaAA+PbAByRVK6+Zxb2A9ETd5p4TkQms6kO572QPxE02dWt3Rd8DaBoSYDVILD9kEvDClMt8DdztqsB5K4eBKAz7EbAeRa5GdnJd2jX/oAfaoTpMli9spG2AzP8gVxd6tZsxT9rF9+KgYACr8ohe8AF54RnjXi90dofcJQzQVqoNbooSdWh+jiZ3cNTECpYOmogI6av/IONLHdcv0q5nki9J/4s29tIkWnFGRl9EH08AkMnNsIoWoQ0T0naFJ7pU9DeU3M8rYxyTJzG6ZHy4lovG3YwrySeQTNGFEv2xMMcVODdiR4xBjJllm6NihFnnAw9hdBSA6k0QjEjB4LXPmC25qmwDZ1dYSDYX787lS72KdolDcRX36YjirCHCtd3h+retUnz7tenZN46k3He3ySg4rsHKxm15BdZv/82d8xftPqAQbxeDOD649UurEWeDEI0mnnCNrh5YWkMgGf8+h9yMugRcVq/+6zDyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(82310400008)(186006)(1800799006)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(336012)(426003)(26005)(2616005)(83380400001)(16526019)(8676002)(36860700001)(5660300002)(70206006)(1076003)(41300700001)(316002)(54906003)(6916009)(70586007)(2906002)(8936002)(4326008)(7696005)(478600001)(6666004)(30864003)(47076005)(44832011)(40480700001)(81166007)(82740400003)(356005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:43:40.2304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bcba90-c988-40b9-6ab2-08db9d6bb99a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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

Add SMU13 fan minimum pwm OD setting support.

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
index e2eefc8d8edc..cac972cedce1 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -118,6 +118,7 @@ enum pp_clock_type {
 	OD_ACOUSTIC_LIMIT,
 	OD_ACOUSTIC_TARGET,
 	OD_FAN_TARGET_TEMPERATURE,
+	OD_FAN_MINIMUM_PWM,
 };
 
 enum amd_pp_sensors {
@@ -196,6 +197,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_ACOUSTIC_LIMIT,
 	PP_OD_EDIT_ACOUSTIC_TARGET,
 	PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
+	PP_OD_EDIT_FAN_MINIMUM_PWM,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 63edd45e224d..47a6ff398f7a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3832,6 +3832,43 @@ static umode_t fan_target_temperature_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+static ssize_t fan_minimum_pwm_show(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    char *buf)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_MINIMUM_PWM, buf);
+}
+
+static ssize_t fan_minimum_pwm_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf,
+				     size_t count)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
+							     PP_OD_EDIT_FAN_MINIMUM_PWM,
+							     buf,
+							     count);
+}
+
+static umode_t fan_minimum_pwm_visible(struct amdgpu_device *adev)
+{
+	umode_t umode = 0000;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE)
+		umode |= S_IRUSR | S_IRGRP | S_IROTH;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET)
+		umode |= S_IWUSR;
+
+	return umode;
+}
+
 static struct od_feature_set amdgpu_od_set = {
 	.containers = {
 		[0] = {
@@ -3877,6 +3914,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = fan_target_temperature_store,
 					},
 				},
+				[5] = {
+					.name = "fan_minimum_pwm",
+					.ops = {
+						.is_visible = fan_minimum_pwm_visible,
+						.show = fan_minimum_pwm_show,
+						.store = fan_minimum_pwm_store,
+					},
+				},
 			},
 		},
 	},
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 80d2ac1ecb9f..342c4d8318dc 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -324,6 +324,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET		BIT(7)
 #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE	BIT(8)
 #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET	BIT(9)
+#define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE		BIT(10)
+#define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET		BIT(11)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 22a6527139a6..d22ed5a272ce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2491,6 +2491,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_ACOUSTIC_TARGET; break;
 	case OD_FAN_TARGET_TEMPERATURE:
 		clk_type = SMU_OD_FAN_TARGET_TEMPERATURE; break;
+	case OD_FAN_MINIMUM_PWM:
+		clk_type = SMU_OD_FAN_MINIMUM_PWM; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 7c405486ec52..3a56ebcc2b6a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -283,6 +283,7 @@ enum smu_clk_type {
 	SMU_OD_ACOUSTIC_LIMIT,
 	SMU_OD_ACOUSTIC_TARGET,
 	SMU_OD_FAN_TARGET_TEMPERATURE,
+	SMU_OD_FAN_MINIMUM_PWM,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 54745791fa9e..584b69a6da5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -107,6 +107,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		10
+#define PP_OD_FEATURE_FAN_MINIMUM_PWM			11
 
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1113,6 +1114,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanTargetTemperature;
 		od_max_setting = overdrive_upperlimits->FanTargetTemperature;
 		break;
+	case PP_OD_FEATURE_FAN_MINIMUM_PWM:
+		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
+		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1423,6 +1428,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_MINIMUM_PWM:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanMinimumPwm);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1740,6 +1763,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_0_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -2001,7 +2046,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -2067,6 +2114,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 		user_od_table->OverDriveTable.FanTargetTemperature =
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
+		user_od_table->OverDriveTable.FanMinimumPwm =
+			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 68e42aad3370..a1f45378e7eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -83,6 +83,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		10
+#define PP_OD_FEATURE_FAN_MINIMUM_PWM			11
 
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1100,6 +1101,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanTargetTemperature;
 		od_max_setting = overdrive_upperlimits->FanTargetTemperature;
 		break;
+	case PP_OD_FEATURE_FAN_MINIMUM_PWM:
+		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
+		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1410,6 +1415,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_MINIMUM_PWM:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanMinimumPwm);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1727,6 +1750,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_7_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1983,7 +2028,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -2049,6 +2096,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 		user_od_table->OverDriveTable.FanTargetTemperature =
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
+		user_od_table->OverDriveTable.FanMinimumPwm =
+			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

