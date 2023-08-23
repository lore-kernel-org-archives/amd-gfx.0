Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD14EE49AF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 06:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB88110E2EF;
	Wed, 23 Aug 2023 06:35:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF45510E2BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 06:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igqFcUENCVxfHGHODnaTxE5GYDr8xViwQEyd/TfCqKzpD4v3ReH5D4oS/3Eg62nDCOaZIhzMGYTyZ2Qvu/LEUc3oU4BusvIB7U6Z9enZYjWpcNnDR32Kovvu5FXvhL++VvWwPHKdBdcBng3+5So+/mBILFCDIEHMTqr1JngXxKkaa5YxXXDF1tNewQ7uSTbjnwzeM0h19xJSdXF2E/cHEkjhnVIezwAxbRkOnL+2H2F549n0DqgD6cgNI7uKc70bRYciYpUxha1D11ped2+oy0GUKqv6CiUAd1xr3rkpkWYJudBZyrZIISHdjCa7kUvyMUj9H+iPYyXaTlF0QsSUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcdNpShfnpvfEUkMTfF7EFRdqAyqXM9B9iZL6WLnA4E=;
 b=jj5sYjjpVIXhc9wwhCzCj5FObLMCCrtJAoYKmvu2/zlejG9qOnfhtvshT2H7AII5npDiJ+YzavJyU0S2uiT7MXMXhCMkKUZaZrd1ipWb8BmO5r23bkAwpd0Vo7OQCrxhXWkhgJ5C0HovbQpQdQWCURTHY2l4p/Yscc3QWLBV9taWSn73r2GyUNlYO4e4IyM3Xc15QXvZ3QmDghgVfqo9K0J1gMSGEqUDtrmGxIHtq9WGlDN0LPt77S/imJkgSdysjp9tD/SaWW97dKJfU25eNVW+rnbWLGGZhI4j+kdBVr8+ojfDcenv5mYE6HDb6M6tzoDgf+MeNd+0jnhox2x+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcdNpShfnpvfEUkMTfF7EFRdqAyqXM9B9iZL6WLnA4E=;
 b=IvxrdZZpK1aWflqOH80sS0WIvbbXhjfGLN3GlSBoOHy/o1UMOwjU3jCxpTw9ueh6S92+bMJEi1ZdhmiTvFB7v5a05il8fnO0w09XLxY+EnGdwYyw0JHk+peoggHPhULvlPIjbiIVKqy3W1uZMFDYav7KwhqYmrA8NfsfhPS0ltY=
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 06:35:39 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::99) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 06:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 06:35:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 01:35:37 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V2 6/8] drm/amd/pm: add fan acoustic target OD setting support for
 SMU13
Date: Wed, 23 Aug 2023 14:34:04 +0800
Message-ID: <20230823063406.1195151-6-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: d68fc93e-2127-487b-aad2-08dba3a32a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7BRTtgD3t/bZ+1g4nBsCke2HBVCuYh3ACAZNJEdQbraoPu+Sy3RImBnfmLEd/wlcC9FxVj4UZayrQmt0VplWtkysQRLDEvKR0QxsOPhUyfeUTBF/HBtWjkSXGKIY7oixtBoNMmu/40WXAz2vwq0PMbS34TQ1zKd511LP4GJKHdov7T6beEqBtUHiwiXtYwNSnLbxNixvM56A+VyPtOVDWXtSdYAKAlY66WcsIOfIi6TCsbIZLY5KfI5ITH4+WVHyE88yQnusccJqt0P6gOobsm26nGkeQ0EuitDkCdbaJXzssm0aBt+FDRxfSutl2kc4WEgh1trVRu07MTqpeULi1ygBDDLH1BHh+Zj2KaSk5rGga+krd7wVf37EcEBjFFXMIbz7nwIXisr+efOftIJlB9qoYLvttB5l7JpCKfZpL5fYLmhiIuZJOsNQVVWwNJMQgjoWydCq58Mg8epD3n9krUX9Tu+zT20+HAxaFfV+Wtgu0hgT0y8Iw+0fDfgcs+/MhVn2KhaNMTcf+rikeITgRV4TZPV0GpEpSrPyIw+3ALgVawjIZZMxiumQeQsHTXkZhnZKWMm5VcDkrBAAwUyfdBjXlC+Xx8diXRyF/UjQzPXnbYNnxzv/wbPqwO8s8QWd56Z1DnMxINlWsCQfQm71OdJn8FHURl9n/73zm1qRKmn77Xj29VGfhnLcQb+Jca/YABWtfk/uIR8wE3Ku3KnS0kkFJtTAEgrd9Wvh5wf+3ukUdSr8Lmg4KmgHw5HrI8qSCkqrP6R1spB0NSWXOShxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(30864003)(40480700001)(83380400001)(5660300002)(44832011)(426003)(336012)(16526019)(26005)(36860700001)(86362001)(47076005)(7696005)(8676002)(2616005)(8936002)(4326008)(316002)(70586007)(6916009)(54906003)(70206006)(478600001)(81166007)(82740400003)(356005)(6666004)(40460700003)(36756003)(1076003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:35:39.0575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d68fc93e-2127-487b-aad2-08dba3a32a8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
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
index 4fa2971ec02a..25774032cc16 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -82,6 +82,12 @@ acoustic_limit_rpm_threshold
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: acoustic_limit_rpm_threshold
 
+acoustic_target_rpm_threshold
+-----------------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: acoustic_target_rpm_threshold
+
 GFXOFF
 ======
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index f657882974ee..ca44e5bea2e5 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -116,6 +116,7 @@ enum pp_clock_type {
 	OD_FAN_MODE,
 	OD_FAN_CURVE,
 	OD_ACOUSTIC_LIMIT,
+	OD_ACOUSTIC_TARGET,
 };
 
 enum amd_pp_sensors {
@@ -193,6 +194,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_FAN_MODE,
 	PP_OD_EDIT_FAN_CURVE,
 	PP_OD_EDIT_ACOUSTIC_LIMIT,
+	PP_OD_EDIT_ACOUSTIC_TARGET,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 16ab11684b11..6f5fea6394af 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3670,6 +3670,57 @@ static umode_t acoustic_limit_threshold_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+/**
+ * DOC: acoustic_target_rpm_threshold
+ *
+ * The amdgpu driver provides a sysfs API for checking and adjusting the
+ * acoustic target in RPM for fan control.
+ *
+ * Reading back the file shows you the current setting and the permitted
+ * ranges if changable.
+ *
+ * Writing an integer to the file, change the setting accordingly.
+ *
+ * When you have finished the editing, write "c" (commit) to the file to commit
+ * your changes. NOTE: this will switch the fan control to auto mode.
+ */
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
@@ -3699,6 +3750,14 @@ static struct od_feature_set amdgpu_od_set = {
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
index 1485dd42f078..8049c20c1e66 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -283,6 +283,7 @@ enum smu_clk_type {
 	SMU_OD_FAN_MODE,
 	SMU_OD_FAN_CURVE,
 	SMU_OD_ACOUSTIC_LIMIT,
+	SMU_OD_ACOUSTIC_TARGET,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4117a1b2a642..d483c06c2464 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -105,6 +105,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			6
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
+#define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
 
 #define LINK_SPEED_MAX					3
 
@@ -1130,6 +1131,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
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
@@ -1406,6 +1411,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
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
@@ -1676,6 +1699,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1936,7 +1981,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -1998,6 +2045,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 		}
 		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
+		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4a2864b001b0..61caa5d54e57 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -81,6 +81,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			6
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
+#define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
 
 #define LINK_SPEED_MAX					3
 
@@ -1116,6 +1117,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
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
@@ -1392,6 +1397,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
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
@@ -1662,6 +1685,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1917,7 +1962,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -1979,6 +2026,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 		}
 		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
+		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

