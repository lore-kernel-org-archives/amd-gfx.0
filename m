Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC858EE49AB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 06:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B22610E34C;
	Wed, 23 Aug 2023 06:35:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB04310E2EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 06:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaVMdOxUO10pPjdlUMydh36QCgYPnayDCQbOVp4nPFQnrQq8e6QMhSMkv37JC9qInK+kvaaOCK7UMlaGbQFFd1uVd3yuTg7fIdekdvzIYySBCX2K+Q8nw9aWnRe/RrhLX/m/3sLhyXZQFEzYVQLbnnQPUUfilkuAcjj+DoXZ3h+S8ORYfkNgrmzFz14kA1ReWV2E1MWfhjBN0J62Qkpc5l/H2arKf1tcIcm1V3bpKgXk53VAAFyE8AKcniJcN+ZfoHYi9an006i4yxDPP9F6Zi193vDcqaJh4zrlAW9W+UbPrxkHq4m4KEPuAEnWwTbtiyuB2/UbB4lW5I+hLM+tCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sb1STkMV6ATdg/UHoBGT4ixEPlr/rPXDeQhRV3fnTU=;
 b=SSWnUTR3YQT7IJxnEO7T3B+0u1aaENTQ4D9O/AcDtmzq7SqA/l0wvfpB/m1sXaiu7I6a3cKOTeW8JYrgwri1y3QDyiueM4IBu0yxp95krMEOh0ffCpnc6+v5SPm27QhszNTjRa9tMjZYT140URoUYduu+qJFfpwhY0O6BGVoyQjurD7M5a+JtpUx4F44TTNlDG7Byuaz8NDKmtGQ8GEydn9zBJg/tXFI9UZ/CUJSNunlj1Gsq2z+/mvVwEezOjAyFu+EqD1RIuiFw5s5f4/ALi7HE7rCMlOF+Kq5w7Od9WdILHbyyBpiB0ZnmpxvWJmdEuXeSK/usuOT3XaREDLgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sb1STkMV6ATdg/UHoBGT4ixEPlr/rPXDeQhRV3fnTU=;
 b=1RqKRP2nrisYS2XxF22aFWAS5DCfa2uHQXze8ZgV4XP8Skx2rjILwY8jdiLtcd9zZJq3qfqIwjag5p1LCkJQDqw46wZfBsRXuWEyJws1OeUlx6az/4eNRl1nuRMus1Tdj0wwTa41cYYsEuEzoNxyn0ETs1dgd2XHczhqk68YCeg=
Received: from MW4PR03CA0085.namprd03.prod.outlook.com (2603:10b6:303:b6::30)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 06:35:38 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::89) by MW4PR03CA0085.outlook.office365.com
 (2603:10b6:303:b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 06:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 06:35:38 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 01:35:35 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V2 5/8] drm/amd/pm: add fan acoustic limit OD setting support for
 SMU13
Date: Wed, 23 Aug 2023 14:34:03 +0800
Message-ID: <20230823063406.1195151-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823063406.1195151-1-evan.quan@amd.com>
References: <20230823063406.1195151-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: eddd89ed-ccfa-40a5-ac2c-08dba3a329fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6sxZx2Nq+WNDwxZcO3phDMYucCKeXcddqTArDAKB22WmdsF0h0R5kZUhx4OqL6Cvd/je3ilG5+3+FPMCH9Xur8oanXUEZorbHaqSV/PFY3C2nYMRKEtmlNkLdC1WE5TI0qd90RbY9zazJF8hHsaSX4nZVRKQsMpBPTzjkTvuSyZ/nTj6OXfGR/7ZD9NpvLW93qpi7pI930eAYlXv5KcV0pxgGJO31IYw5FsrON0blqTH3mtY3LMi9ofTY56EnnMNcAMVUHXpcWmiTh/+NtlLUVkscKTgsvWuZk7ktIfsqUfZv/edD6FtHmsOk3VdNLQHy43iNxtVPpjXsT5PnO1P3kdY/LQvhGKcjEBYR+R4lzW2tq9j/ucVOZyYCEzmjMBWhvU+FV5TEkxdoNuxsqlW/K5BTcVXyzQ7diOdBL1vmtMcsE+poIJP9Hrnax9fWF5MONxIlg1tptAl5ROfD36F5S6WhA3BL6jAKy1YKy7RT45C6lWaRtfpU0xql7lxzvm0P/rUVQ38mZ+ciCkY7cSQk8XLc3FxFdeXgP4Ykqte4ukwzHbEf+UJL/P+zGxaXbNBu3HOf3BVsl0xeGzit86Qgxo5PX4ExMAjABmSX+sGyFFlhnHNfDxVNCxc79pLhIg600V3HuusrY7gBKHpCxxqrRfnSxeyiJHRwhUtNpC8wcRMVhTpM1lAgLD3zSCki8DGX59AFzR7w3ZDNkFUmjckRpexp0uHdAWbguaZb8z3yHujCjm0PWk49yIFBGk9OV9+BiOwXlNnyoSygg1PuDxkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(36756003)(40480700001)(1076003)(44832011)(5660300002)(2616005)(16526019)(26005)(426003)(336012)(4326008)(8936002)(8676002)(47076005)(2906002)(83380400001)(30864003)(478600001)(7696005)(70206006)(70586007)(316002)(6916009)(54906003)(41300700001)(6666004)(356005)(82740400003)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:35:38.0942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddd89ed-ccfa-40a5-ac2c-08dba3a329fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
--
v1->v2:
  - add missing kerneldoc for the new interface(Alex)
---
 Documentation/gpu/amdgpu/thermal.rst          |  6 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 59 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 51 +++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 51 +++++++++++++++-
 8 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 48b4b89f2ffb..4fa2971ec02a 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -76,6 +76,12 @@ fan_cuve
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: fan_curve
 
+acoustic_limit_rpm_threshold
+----------------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: acoustic_limit_rpm_threshold
+
 GFXOFF
 ======
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 6d0d37dfb28b..f657882974ee 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -115,6 +115,7 @@ enum pp_clock_type {
 	OD_CCLK,
 	OD_FAN_MODE,
 	OD_FAN_CURVE,
+	OD_ACOUSTIC_LIMIT,
 };
 
 enum amd_pp_sensors {
@@ -191,6 +192,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_VDDGFX_OFFSET,
 	PP_OD_EDIT_FAN_MODE,
 	PP_OD_EDIT_FAN_CURVE,
+	PP_OD_EDIT_ACOUSTIC_LIMIT,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 7d477864f77f..16ab11684b11 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3619,6 +3619,57 @@ static umode_t fan_curve_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+/**
+ * DOC: acoustic_limit_rpm_threshold
+ *
+ * The amdgpu driver provides a sysfs API for checking and adjusting the
+ * acoustic limit in RPM for fan control.
+ *
+ * Reading back the file shows you the current setting and the permitted
+ * ranges if changable.
+ *
+ * Writing an integer to the file, change the setting accordingly.
+ *
+ * When you have finished the editing, write "c" (commit) to the file to commit
+ * your changes. NOTE: this will switch the fan control to auto mode.
+ */
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
@@ -3640,6 +3691,14 @@ static struct od_feature_set amdgpu_od_set = {
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
index f17127c50238..1485dd42f078 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -282,6 +282,7 @@ enum smu_clk_type {
 	SMU_OD_VDDGFX_OFFSET,
 	SMU_OD_FAN_MODE,
 	SMU_OD_FAN_CURVE,
+	SMU_OD_ACOUSTIC_LIMIT,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b52b862e887c..4117a1b2a642 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -104,6 +104,7 @@
 #define PP_OD_FEATURE_FAN_MODE				5
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			6
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
+#define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 
 #define LINK_SPEED_MAX					3
 
@@ -1125,6 +1126,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
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
@@ -1383,6 +1388,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 
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
@@ -1631,6 +1654,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1889,7 +1934,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 						PP_OD_FEATURE_FAN_CURVE_BIT))
 		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_CURVE_SET;
+					    OD_OPS_SUPPORT_FAN_CURVE_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -1949,6 +1996,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
 				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
 		}
+		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3ce2dc6bb4af..4a2864b001b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -80,6 +80,7 @@
 #define PP_OD_FEATURE_FAN_MODE				5
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			6
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
+#define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 
 #define LINK_SPEED_MAX					3
 
@@ -1111,6 +1112,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
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
@@ -1369,6 +1374,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 
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
@@ -1617,6 +1640,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1870,7 +1915,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 						PP_OD_FEATURE_FAN_CURVE_BIT))
 		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_CURVE_SET;
+					    OD_OPS_SUPPORT_FAN_CURVE_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -1930,6 +1977,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
 				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
 		}
+		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

