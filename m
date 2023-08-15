Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE611C04A6A
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0398E10E173;
	Tue, 15 Aug 2023 08:43:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89A510E16A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFxy7hc1T3r/e/zdN16TMPxmf+jKc3moPDgS1hlH4Vm4pOMcGfWvZg9m1Ox2+qfXxmR1ppR8RINIAR4pa+Buq+rcXlpXFdibcGNyGoxcnb6yKGLoKtEy26mHtfycCqxhZLufqGjxp3iRQADrzNTXtmYrbjjiVu8R3lu3KUiMbbE1OUYOYTRrjxaJeGyJW4sJBa5K4UF7SXrGrw7HhrGlfH3IpxT4XdTYm3/U0mwXovIZHwyKP7u/xcRWlxLTr6LvCCkLFC1elisBhSsKfvdbH6jrcUTg92ia6E2R+JvD9W9z7X/f6yfl8kxUj4ILlJDYdYfEGNrTs9mbNEgt05OLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UUBUUDoOe9Rzrug85QhdV/DxQsTngwAqCoRb/s+IyI=;
 b=at0AIlloTSQ44drnrX36GuI1TDPBrjiOWylwMEuiOh2hi+Z7a5xRzI+wm0s5FMJAhKNErPP7Ol+l0umDLlVLGhyG/T5kgK+1Pwmfn5LpSRgYXT6+vt4lS5ab33Wf+3+qIqvIjt2BJx8TTShF/amb8f7qtA9p7RJJPlVmZvVSkd9HDcHU7I/wU1gF5imhiOQStXCIBmBoOQ7/EwghHjxM1EQ5aoJEEU5S32CpCLgXK8i0DYW7qatMJGoX/pfX3MpFoihQLkj2pVUGBC110CmZe1LZlG8U1k+P/z7nqGHFmsp96PuZejmxHBs17eHLDq05pF9naLaEdY6XsH/aiakq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UUBUUDoOe9Rzrug85QhdV/DxQsTngwAqCoRb/s+IyI=;
 b=FhCcgcXROFrFDumgDRXZLYyGYmQCArmuKVHfB0atG4tcxoQO/FrFGB1MEHWKGlY/h3OkXT1Xe9n5L0/gS8B57GZpPDocRrCnWHMXZ5ARn6TqLd5Jzdkd80lz4OuMOgVjvubS8dn7QfYsPAzJMTYXuxVI5UQq9EWvxT954EG5qaM=
Received: from SJ0PR03CA0179.namprd03.prod.outlook.com (2603:10b6:a03:338::34)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 08:43:38 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::d) by SJ0PR03CA0179.outlook.office365.com
 (2603:10b6:a03:338::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 08:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 08:43:37 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:42:59 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd/pm: add fan temperature/pwm curve OD setting
 support for SMU13
Date: Tue, 15 Aug 2023 16:42:27 +0800
Message-ID: <20230815084231.3229009-5-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|PH0PR12MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: d88e7fa2-f8e1-4f08-8ebd-08db9d6bb83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJnms2tgwNwzL5HnM1Cgiluv/6rEx45uy9ObSI3HYu/kBcI4vCtTYj5/Z4W4ULkzxonPmL3K7vCu4ClvgPNISdnz8uvMtjX+SSSH+EKJvd6a9kqeyRUvYuEK+UIZMdUNn05eYjIhArdptO5LZYqeEKji6KQfc2zXvaN1RSzByMdwE2JPCtlHHkid+TBfA7ncQtvk0qcj+q25dmZNOmyTEiYF1IzMa+GJAMaIPR75sY0J23cPD6PAx+WyIJXHEmSewd7d36CkxXaCF26ISKespj/im7RRsu6zTBttwwM8rT+MfxG5G2djjdO5qvK1NCKFztrHNl7aEiR1oaq+Wx5Mz4A8ohucXM4w4W70D5ztQ5cw8GFmZ9iLSHhDbW/FtoFQj/X/ARncOylCaQCKCs3C0X+zGem9Aww6ycwwTIowxhiikcnllPPFTNlrHxOtSjbcD34aFNZLcFk0lsdY5qD6Bcsm0ievqVLajQWlxwEY6gD80E5nbf8vHDcIbRjqEaMf7HVC7nrkG/3Z4r3XbsjUAVfYU/+Q1Wc7MElKdtjYVOZyNH8jBqNEQHVY3CuTm59aM5NS+i46nihidzfMnUDNiOYsFJhwujJzrTXgc/bQubaCf/h2TvFp8S+KkK+fmBzdTVth7+B6CRHnklXSNmf0dP2NfTTOnO0NwiznAYL/RUqwRNLANB/gjPN4IzzHCUQM9+JCFA5MolezwUyC2JYXe73+WmmZcy26ZaaEyqb0wZfikFjYv0RTLHNT7w83NnQCu5Yy9bFpPmEYSvO32+iN6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(82310400008)(186006)(1800799006)(451199021)(46966006)(36840700001)(40470700004)(36756003)(83380400001)(82740400003)(40460700003)(40480700001)(356005)(81166007)(54906003)(478600001)(6666004)(7696005)(41300700001)(44832011)(5660300002)(8936002)(8676002)(2906002)(30864003)(6916009)(4326008)(316002)(70206006)(70586007)(47076005)(2616005)(426003)(36860700001)(16526019)(26005)(336012)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:43:37.9663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88e7fa2-f8e1-4f08-8ebd-08db9d6bb83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
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

Add SMU13 fan temperature/pwm curve OD setting support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 45 ++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 87 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 87 ++++++++++++++++++-
 7 files changed, 224 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index d51c639a3f31..3743777b45cb 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -114,6 +114,7 @@ enum pp_clock_type {
 	OD_VDDGFX_OFFSET,
 	OD_CCLK,
 	OD_FAN_MODE,
+	OD_FAN_CURVE,
 };
 
 enum amd_pp_sensors {
@@ -188,6 +189,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_COMMIT_DPM_TABLE,
 	PP_OD_EDIT_VDDGFX_OFFSET,
 	PP_OD_EDIT_FAN_MODE,
+	PP_OD_EDIT_FAN_CURVE,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 90c5f3c95307..7baebe45b912 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3684,6 +3684,43 @@ static umode_t fan_mode_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+static ssize_t fan_curve_show(struct kobject *kobj,
+			      struct kobj_attribute *attr,
+			      char *buf)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_CURVE, buf);
+}
+
+static ssize_t fan_curve_store(struct kobject *kobj,
+			       struct kobj_attribute *attr,
+			       const char *buf,
+			       size_t count)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
+							     PP_OD_EDIT_FAN_CURVE,
+							     buf,
+							     count);
+}
+
+static umode_t fan_curve_visible(struct amdgpu_device *adev)
+{
+	umode_t umode = 0000;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE)
+		umode |= S_IRUSR | S_IRGRP | S_IROTH;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_CURVE_SET)
+		umode |= S_IWUSR;
+
+	return umode;
+}
+
 static struct od_feature_set amdgpu_od_set = {
 	.containers = {
 		[0] = {
@@ -3697,6 +3734,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = fan_mode_store,
 					},
 				},
+				[1] = {
+					.name = "fan_curve",
+					.ops = {
+						.is_visible = fan_curve_visible,
+						.show = fan_curve_show,
+						.store = fan_curve_store,
+					},
+				},
 			},
 		},
 	},
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index b54f84e2408a..4463c60b710a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -316,6 +316,8 @@ struct config_table_setting
 
 #define OD_OPS_SUPPORT_FAN_MODE_RETRIEVE		BIT(0)
 #define OD_OPS_SUPPORT_FAN_MODE_SET			BIT(1)
+#define OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE		BIT(2)
+#define OD_OPS_SUPPORT_FAN_CURVE_SET			BIT(3)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 01ccfd219d6b..fe998df9dca2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2483,6 +2483,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_CCLK; break;
 	case OD_FAN_MODE:
 		clk_type = SMU_OD_FAN_MODE; break;
+	case OD_FAN_CURVE:
+		clk_type = SMU_OD_FAN_CURVE; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index f37de1df8291..dc5f6e166907 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -279,6 +279,7 @@ enum smu_clk_type {
 	SMU_OD_RANGE,
 	SMU_OD_VDDGFX_OFFSET,
 	SMU_OD_FAN_MODE,
+	SMU_OD_FAN_CURVE,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 19406fa001d5..426652af4fc5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -102,6 +102,8 @@
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
 #define PP_OD_FEATURE_FAN_MODE				5
+#define PP_OD_FEATURE_FAN_CURVE_TEMP			6
+#define PP_OD_FEATURE_FAN_CURVE_PWM			7
 
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1088,6 +1090,14 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanMode;
 		od_max_setting = overdrive_upperlimits->FanMode;
 		break;
+	case PP_OD_FEATURE_FAN_CURVE_TEMP:
+		od_min_setting = overdrive_lowerlimits->FanLinearTempPoints;
+		od_max_setting = overdrive_upperlimits->FanLinearTempPoints;
+		break;
+	case PP_OD_FEATURE_FAN_CURVE_PWM:
+		od_min_setting = overdrive_lowerlimits->FanLinearPwmPoints;
+		od_max_setting = overdrive_upperlimits->FanLinearPwmPoints;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1315,6 +1325,35 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 					(int)od_table->OverDriveTable.FanMode);
 		break;
 
+	case SMU_OD_FAN_CURVE:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
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
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_CURVE_TEMP,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "FAN_CURVE(hotspot temp): %uC %uC\n",
+				      min_value, max_value);
+
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_CURVE_PWM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "FAN_CURVE(fan speed): %u%% %u%%\n",
+				      min_value, max_value);
+
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1528,6 +1567,44 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFX_VF_CURVE_BIT;
 		break;
 
+	case PP_OD_EDIT_FAN_CURVE:
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		if (input[0] >= NUM_OD_FAN_MAX_POINTS - 1 ||
+		    input[0] < 0)
+			return -EINVAL;
+
+		smu_v13_0_0_get_od_setting_limits(smu,
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
+		smu_v13_0_0_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1781,7 +1858,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 
 	if (smu_v13_0_0_is_od_feature_supported(smu,
 						PP_OD_FEATURE_FAN_CURVE_BIT))
-		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE;
+		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -1835,6 +1914,12 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 				user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
 		user_od_table->OverDriveTable.FanMode =
 			user_od_table_bak.OverDriveTable.FanMode;
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++) {
+			user_od_table->OverDriveTable.FanLinearTempPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearTempPoints[i];
+			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
+		}
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 7db8a1e2c640..72bbbd2569e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -78,6 +78,8 @@
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
 #define PP_OD_FEATURE_FAN_MODE				5
+#define PP_OD_FEATURE_FAN_CURVE_TEMP			6
+#define PP_OD_FEATURE_FAN_CURVE_PWM			7
 
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1075,6 +1077,14 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanMode;
 		od_max_setting = overdrive_upperlimits->FanMode;
 		break;
+	case PP_OD_FEATURE_FAN_CURVE_TEMP:
+		od_min_setting = overdrive_lowerlimits->FanLinearTempPoints;
+		od_max_setting = overdrive_upperlimits->FanLinearTempPoints;
+		break;
+	case PP_OD_FEATURE_FAN_CURVE_PWM:
+		od_min_setting = overdrive_lowerlimits->FanLinearPwmPoints;
+		od_max_setting = overdrive_upperlimits->FanLinearPwmPoints;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1302,6 +1312,35 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 					(int)od_table->OverDriveTable.FanMode);
 		break;
 
+	case SMU_OD_FAN_CURVE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
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
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_CURVE_TEMP,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "FAN_CURVE(hotspot temp): %uC %uC\n",
+				      min_value, max_value);
+
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_CURVE_PWM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "FAN_CURVE(fan speed): %u%% %u%%\n",
+				      min_value, max_value);
+
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1515,6 +1554,44 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFX_VF_CURVE_BIT;
 		break;
 
+	case PP_OD_EDIT_FAN_CURVE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		if (input[0] >= NUM_OD_FAN_MAX_POINTS - 1 ||
+		    input[0] < 0)
+			return -EINVAL;
+
+		smu_v13_0_7_get_od_setting_limits(smu,
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
+		smu_v13_0_7_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1763,7 +1840,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 
 	if (smu_v13_0_7_is_od_feature_supported(smu,
 						PP_OD_FEATURE_FAN_CURVE_BIT))
-		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE;
+		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -1817,6 +1896,12 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 				user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
 		user_od_table->OverDriveTable.FanMode =
 			user_od_table_bak.OverDriveTable.FanMode;
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++) {
+			user_od_table->OverDriveTable.FanLinearTempPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearTempPoints[i];
+			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
+		}
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

