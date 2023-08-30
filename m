Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6FBC83F01
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 05:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F13E10E4B6;
	Wed, 30 Aug 2023 05:57:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B9310E4B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 05:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn8lUqFHSskMQ7UMzaQRk0hJtBiqu91zPImRDlaHSfT477FiN1sFHxj8bdyMOpg+/FvsSSUHdw6MxR+8v5qm2sym3FPcvIj7nS2l38Pfua1kkdR0JajHVX4C6ec3PHOD8ANZK3KFM4Q5ltNkJmQW/3+zmUIg45F7tlr9gISbYKUCTPilz0gEa5u1OchHYRZeESGDKwXduQ9skWBerojv6c1h6n4DC0P0AI8LPwvKP/YoH/f74diQM6gtXjWi5zPWK5M+A9yuv5cR29KJySqRGK27ufdmeP8N1l2Z2pZRYx2F20ji22WwuX/Nk0aLNAWcQSg7mbYpCdLmpbEBrWFr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPgsfNMUqFrKVhD4igaOrK5NO3jXwhME3N3Q1rlSG3U=;
 b=nJZxOugoSgSMRakOC5wWH1IN6KxHXhSL0WjJnECmAyZmSVXXFjGSdQEH87D2sOkQ7IY03KEKlp327JGkYNygar9lcUHW6o/PPlKvhAZG0rRa2c2JTkqEIlnAnNUVHiWL+BK9RKVuygk4VpygdGU3VUOasNVdawjM3jk8pa3fzIexJJ7Kt5w2UHXu1bU79edaJBA75km1UMmTBogUcv1thgMIX6F5wd2gR4VqViyRFdN1fOSoNtG3zKGGcQYw+Ma3lcItRUjKyvojX4aDpH4AIWrZOdP7BpbyD2hCwde6VFjmNhR+IDz23r97dutc52ogma2qI9052bpjgGl82WtK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPgsfNMUqFrKVhD4igaOrK5NO3jXwhME3N3Q1rlSG3U=;
 b=NGZGhPYb4Lwg3rbVal7zHr75BWsUDRFr+0V/o9Yhor6RjTPXgm7hB3WKNcF06131kzfVBVeDe5OpdtCNQaigfry+EWL2b+olIxnNzVe27CMncFmDYyvqrbumwhszfcbF4gE1xcGK1z89l5OOH/kS+dbngyWzz2Riw6LoeRkTPxo=
Received: from MW4PR04CA0272.namprd04.prod.outlook.com (2603:10b6:303:89::7)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 05:57:40 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::1f) by MW4PR04CA0272.outlook.office365.com
 (2603:10b6:303:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 05:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 05:57:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 00:57:19 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V3 4/7] drm/amd/pm: add fan acoustic limit OD setting support for
 SMU13
Date: Wed, 30 Aug 2023 13:56:45 +0800
Message-ID: <20230830055648.477908-5-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 5554842c-e610-490b-8842-08dba91e04f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3slRilX6j9pZodHLjShb3+zwiAzRTIYEUwog1XrARStbw4A92XdAgI0rNAlK6Vybo0kOaLdp7R80OJgH4LZ7DmPakyoUy0LcpLWeE1l4+Fj/wxBd+AvHCxNl5QbwoCSkN5Cw5CxAhkmD1IWzEyOTXbLXY0XW1HwC8yXpMn66oESsD6OLM2yFCzFWk21KP5IrKK2fPUXRibZyxy4gXGK3+czM0BIcyEGobwHnOZDgIS5b4t0Rvbc+c08z3Co6sO5Ew2SQQc7LP7qhuAYRRM89wPYqKk4QNAyYa3lcGtgizgU7R2q2a+LSOq1LRrDwJNHJ9xf/UzXCI57joXZPxbEjWtOB7UZRwDxV98SopOmh/c2Z56VGZDPu8i1FDJgKIUM4nYog8llYPpfvn/iP1mlSTiZwZWh01sY9Y10JkeaN0iNT/IFxsAa0TivRSIco5dlQdJZ36guskzJbRr/6kHG683ex8TbHG4nftrw0KARXBOcn7NGqGr+QcafptTt8DbY23uKs5yS5Ni7LBEVudQPRBWQ9KeOgfCOB3cLpEgM+7NNoM2b/JUrPWSo+Fbnjqx1UfFaXFutOa2Q8Ri9chs0Bv9ObdwnfEYhh0/lQhieP1vv4LVD69zlI0jbMe0kIDQCunatrUT7LDHcf+XyQ6toU+qaTb9cAX9WV9LpyUvwWAN2YbXP57X5+ywtASgYL9j0RsxYG/1pBYLIcVx3VUgrqidP2bbShvyrU+dBA4bk5Rid5RLRYXrjeveR79ACRrz3W09C7rJOSxH9E82dvWusu5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(4326008)(7696005)(6666004)(478600001)(83380400001)(426003)(336012)(26005)(1076003)(16526019)(30864003)(54906003)(70206006)(6916009)(2616005)(316002)(8936002)(44832011)(70586007)(41300700001)(8676002)(5660300002)(86362001)(40460700003)(36756003)(40480700001)(47076005)(2906002)(36860700001)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 05:57:39.8323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5554842c-e610-490b-8842-08dba91e04f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
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
v2->v3:
  - rich the document for the new interface(Alex)
---
 Documentation/gpu/amdgpu/thermal.rst          |  6 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 63 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 51 ++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 51 ++++++++++++++-
 8 files changed, 176 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 08ee33b2acb6..8ed888f81d2c 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -70,6 +70,12 @@ fan_curve
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
index 7bdd2bdab970..e3dcef8c4ab7 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -114,6 +114,7 @@ enum pp_clock_type {
 	OD_VDDGFX_OFFSET,
 	OD_CCLK,
 	OD_FAN_CURVE,
+	OD_ACOUSTIC_LIMIT,
 };
 
 enum amd_pp_sensors {
@@ -189,6 +190,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_COMMIT_DPM_TABLE,
 	PP_OD_EDIT_VDDGFX_OFFSET,
 	PP_OD_EDIT_FAN_CURVE,
+	PP_OD_EDIT_ACOUSTIC_LIMIT,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 1008d43e9c3f..1ec8a8c4016a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3575,6 +3575,61 @@ static umode_t fan_curve_visible(struct amdgpu_device *adev)
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
+ * your changes.
+ *
+ * This setting works under auto fan control mode only. It adjusts the PMFW's
+ * behavior about the maximum speed in RPM the fan can spin. Setting via this
+ * interface will switch the fan control to auto mode implicitly.
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
@@ -3588,6 +3643,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = fan_curve_store,
 					},
 				},
+				[1] = {
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
index 90544a8f450c..984fda278f1a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -316,6 +316,8 @@ struct config_table_setting
 
 #define OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE		BIT(0)
 #define OD_OPS_SUPPORT_FAN_CURVE_SET			BIT(1)
+#define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE	BIT(2)
+#define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET		BIT(3)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2d73a63813de..ca41cfd57d89 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2483,6 +2483,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_CCLK; break;
 	case OD_FAN_CURVE:
 		clk_type = SMU_OD_FAN_CURVE; break;
+	case OD_ACOUSTIC_LIMIT:
+		clk_type = SMU_OD_ACOUSTIC_LIMIT; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 83e1d43efd2b..76bb1cba9b83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -281,6 +281,7 @@ enum smu_clk_type {
 	SMU_OD_RANGE,
 	SMU_OD_VDDGFX_OFFSET,
 	SMU_OD_FAN_CURVE,
+	SMU_OD_ACOUSTIC_LIMIT,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 468152710c7c..53636552508f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -103,6 +103,7 @@
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			5
 #define PP_OD_FEATURE_FAN_CURVE_PWM			6
+#define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		7
 
 #define LINK_SPEED_MAX					3
 
@@ -1120,6 +1121,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
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
@@ -1368,6 +1373,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 
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
@@ -1616,6 +1639,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1873,7 +1918,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 	if (smu_v13_0_0_is_od_feature_supported(smu,
 						PP_OD_FEATURE_FAN_CURVE_BIT))
 		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_CURVE_SET;
+					    OD_OPS_SUPPORT_FAN_CURVE_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -1931,6 +1978,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
 				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
 		}
+		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 8b81ee9e6cf8..26a6b7e73c94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -79,6 +79,7 @@
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			5
 #define PP_OD_FEATURE_FAN_CURVE_PWM			6
+#define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		7
 
 #define LINK_SPEED_MAX					3
 
@@ -1106,6 +1107,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
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
@@ -1354,6 +1359,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 
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
@@ -1602,6 +1625,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1854,7 +1899,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 	if (smu_v13_0_7_is_od_feature_supported(smu,
 						PP_OD_FEATURE_FAN_CURVE_BIT))
 		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_CURVE_SET;
+					    OD_OPS_SUPPORT_FAN_CURVE_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -1912,6 +1959,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
 				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
 		}
+		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

