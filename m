Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED6EC83F16
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 05:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74B110E4BA;
	Wed, 30 Aug 2023 05:57:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A0610E4B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 05:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7+xOSxfhWF/oUYihP8fL8kJ6EAfs4X2okVZyTd6GNdaiivb+UpPKlzfAs6fxepAkcSfhjEQ0SX4oi6dzzX6U/hzBxu+7Z3u5fFlX8rOKYE69ffArN/aiafHaE/FY4zL9EH4YelT9b5CTxiNvcimm+TgUQhU7nixnqfq7Zo6XD9v1yeMPuRhoVUBh71YbTIGeBUNo0K4PexQtIqUOTtbbt7mEQGW8EIKmNmgD0Iv5xSGff9IYiNMEB9jocrdkOatwf8MRGw6xpERTBT6hX7Zn+jdzgh3RsWqSZxMkw3S/HOBHQYaoC03yA9KHPZ/tLe6OcAYnJ07bG6GqgluHLPxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dr/CqVqH15if4F6eXQEQ6qJA9+1PF0mDXqvNVG/lK4=;
 b=IyUwFpcYeMVuB+S4oRq30HyBwbGOiwblSXu8xTj9q2GCJh7w3ltjlArxkA2otQxXGQoSz2phBPLLs0AF5erwK/6be7yovubfYrP69OKMhwhzqcTKLZWodRhOMTtZ60c6OK+Kt9Zny7ImrkF9pcgn5JSVYDeh/48uTy2aGImvBMUYzlU+luOa9l+0Zr+RJU+g8TtLlequ0j/HCb+6F1r68+o+/1cqNAOFTIPqAr8Ns2YrjCMo9nKTITqowuhJNCn4O5blx+WffhwPded+47/vnHN6MNuDjoQYCNH+JZ+e03uOVuCZSuqMnwPh+Gwek0qGaTD9k2ivlR9FhomK27cAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dr/CqVqH15if4F6eXQEQ6qJA9+1PF0mDXqvNVG/lK4=;
 b=kqwoPDVX+9S3obQ2dsIJaw7frbIww9/zqkhswsAo16zkV+Ir1gPFMi2DqjLYmTnOPnbQ2onTM2nGBf7Ce0f+pf6Qf2Mb/PbZSQzFVXZk/rcVFv4uh08gceuDwEGVV9GAVxkd62nCVTIIlWZ1pVU4VtjQ6skOfd1sVC8xcMTBxSg=
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 05:57:42 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::cd) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Wed, 30 Aug 2023 05:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 05:57:42 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 00:57:40 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V3 6/7] drm/amd/pm: add fan target temperature OD setting support
 for SMU13
Date: Wed, 30 Aug 2023 13:56:47 +0800
Message-ID: <20230830055648.477908-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830055648.477908-1-evan.quan@amd.com>
References: <20230830055648.477908-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bdfd6a-f74e-4e9d-13eb-08dba91e0662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5N+olXGIHp2VhIsOOBjYJXRWc49h0f+XB/a4QKBq4tWxaEZY5xfiaFo4X237yHd6pZhdMFQcOfllgQw84ID9tPMbHtQ2m7ERLW2WqSkKVUNdNOXsq8cRPTnG2CxpNLy1QxvXyqqMhXq/GRtxgfrbu9ElVShWqREzIQILkwfdTc+EzbqQFLaRRnTrX/cQgiK6/umn/IhxzC4MF5A6yql7n8viye1sQplp04S2sSZhrRJMJpq23gTLsGrVWbcGxay/3e+GWjt39X+Rt/OQJyODqGmt3K9ucy30klH1s8OvR/0GyWO4rxIyJb9s0hR4Hm1kqVqjb/Z5McTE0k7pd4rcW/qoz8jckIQC1wjbNMfrQGh3zlzt2kwOhQP+DCvpFAGyrvh0pjPv+jUsUep5XDEjD41ISA35/xJeNK5jz/twCrrCG8WDdFR5UKmyENnx2Ys+elQebesg1nihwawMxwDi2ol2KB58yQUshWCAxcjzz4j/S+qzud31GMdE3zwQtHgpihdtubfxKkEnSTt3CLytlTUcXRn8fZ/L1qwhCe++RU+wN8LwAvW0agsQ+jnOhcrTAK80XAa8N08IX9QJj4ZCWAK9BOKodpgUu6ImWC+z0or4PjIit0BR+qc7MqI5fy5h3XuppY4ZbhI1rir1fe3p4uoqRaym7j7dT1pVW3lb61YugFwHsDtnl/AIWCpqXMGyIGbGEnYp8AqXoa3hGrv+i8iKxkOLGgGDBd8puH6mbipo/1rpK/tdh/FEFDGeq6RsGwffbflZ3HmqWBIRw9nwjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(426003)(40460700003)(316002)(41300700001)(336012)(4326008)(2906002)(6916009)(83380400001)(47076005)(86362001)(30864003)(2616005)(44832011)(5660300002)(8676002)(1076003)(36756003)(26005)(40480700001)(36860700001)(16526019)(8936002)(356005)(81166007)(82740400003)(7696005)(54906003)(70206006)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 05:57:42.2542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bdfd6a-f74e-4e9d-13eb-08dba91e0662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

Add SMU13 fan target temperature OD setting support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - add missing kerneldoc for the new interface(Alex)
v2->v3:
  - rich the document for the new interface(Alex)
---
 Documentation/gpu/amdgpu/thermal.rst          |  6 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 66 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 51 +++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 51 +++++++++++++-
 8 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 26ca4812b9f6..aa2d15706cda 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -82,6 +82,12 @@ acoustic_target_rpm_threshold
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: acoustic_target_rpm_threshold
 
+fan_target_temperature
+----------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: fan_target_temperature
+
 GFXOFF
 ======
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a7bc81a0a36e..0501d174dbd8 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -116,6 +116,7 @@ enum pp_clock_type {
 	OD_FAN_CURVE,
 	OD_ACOUSTIC_LIMIT,
 	OD_ACOUSTIC_TARGET,
+	OD_FAN_TARGET_TEMPERATURE,
 };
 
 enum amd_pp_sensors {
@@ -193,6 +194,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_FAN_CURVE,
 	PP_OD_EDIT_ACOUSTIC_LIMIT,
 	PP_OD_EDIT_ACOUSTIC_TARGET,
+	PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0d63d31b05d3..060a38e30878 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3687,6 +3687,64 @@ static umode_t acoustic_target_threshold_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+/**
+ * DOC: fan_target_temperature
+ *
+ * The amdgpu driver provides a sysfs API for checking and adjusting the
+ * target tempeature in Celsius degree for fan control.
+ *
+ * Reading back the file shows you the current setting and the permitted
+ * ranges if changable.
+ *
+ * Writing an integer to the file, change the setting accordingly.
+ *
+ * When you have finished the editing, write "c" (commit) to the file to commit
+ * your changes.
+ *
+ * This setting works under auto fan control mode only. It can co-exist with
+ * other settings which can work also under auto mode. Paring with the
+ * acoustic_target_rpm_threshold setting, they define the maximum speed in
+ * RPM the fan can spin when ASIC temperature is not greater than target
+ * temperature. Setting via this interface will switch the fan control to
+ * auto mode implicitly.
+ */
+static ssize_t fan_target_temperature_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_TARGET_TEMPERATURE, buf);
+}
+
+static ssize_t fan_target_temperature_store(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    const char *buf,
+					    size_t count)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
+							     PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
+							     buf,
+							     count);
+}
+
+static umode_t fan_target_temperature_visible(struct amdgpu_device *adev)
+{
+	umode_t umode = 0000;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE)
+		umode |= S_IRUSR | S_IRGRP | S_IROTH;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET)
+		umode |= S_IWUSR;
+
+	return umode;
+}
+
 static struct od_feature_set amdgpu_od_set = {
 	.containers = {
 		[0] = {
@@ -3716,6 +3774,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = acoustic_target_threshold_store,
 					},
 				},
+				[3] = {
+					.name = "fan_target_temperature",
+					.ops = {
+						.is_visible = fan_target_temperature_visible,
+						.show = fan_target_temperature_show,
+						.store = fan_target_temperature_store,
+					},
+				},
 			},
 		},
 	},
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index bcb37ba8db58..486036632ab7 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -320,6 +320,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET		BIT(3)
 #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE	BIT(4)
 #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET		BIT(5)
+#define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE		BIT(6)
+#define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET		BIT(7)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0f1e805e166c..60feffd8b221 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2487,6 +2487,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_ACOUSTIC_LIMIT; break;
 	case OD_ACOUSTIC_TARGET:
 		clk_type = SMU_OD_ACOUSTIC_TARGET; break;
+	case OD_FAN_TARGET_TEMPERATURE:
+		clk_type = SMU_OD_FAN_TARGET_TEMPERATURE; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index b2e9874f4a0e..5a129e7162a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -283,6 +283,7 @@ enum smu_clk_type {
 	SMU_OD_FAN_CURVE,
 	SMU_OD_ACOUSTIC_LIMIT,
 	SMU_OD_ACOUSTIC_TARGET,
+	SMU_OD_FAN_TARGET_TEMPERATURE,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a718b530b0d5..328d377dde79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -105,6 +105,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_PWM			6
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
+#define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 
 #define LINK_SPEED_MAX					3
 
@@ -1130,6 +1131,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->AcousticTargetRpmThreshold;
 		od_max_setting = overdrive_upperlimits->AcousticTargetRpmThreshold;
 		break;
+	case PP_OD_FEATURE_FAN_TARGET_TEMPERATURE:
+		od_min_setting = overdrive_lowerlimits->FanTargetTemperature;
+		od_max_setting = overdrive_upperlimits->FanTargetTemperature;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1414,6 +1419,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_TARGET_TEMPERATURE:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanTargetTemperature);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1706,6 +1729,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_0_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1967,7 +2012,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -2029,6 +2076,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
+		user_od_table->OverDriveTable.FanTargetTemperature =
+			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 17302f235fc2..0f945a86b475 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -81,6 +81,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_PWM			6
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
+#define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 
 #define LINK_SPEED_MAX					3
 
@@ -1116,6 +1117,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->AcousticTargetRpmThreshold;
 		od_max_setting = overdrive_upperlimits->AcousticTargetRpmThreshold;
 		break;
+	case PP_OD_FEATURE_FAN_TARGET_TEMPERATURE:
+		od_min_setting = overdrive_lowerlimits->FanTargetTemperature;
+		od_max_setting = overdrive_upperlimits->FanTargetTemperature;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1400,6 +1405,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_TARGET_TEMPERATURE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanTargetTemperature);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1692,6 +1715,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_7_get_od_setting_limits(smu,
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
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1948,7 +1993,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -2010,6 +2057,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
+		user_od_table->OverDriveTable.FanTargetTemperature =
+			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

