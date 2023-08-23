Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1D1EE49AE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 06:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CC510E2BF;
	Wed, 23 Aug 2023 06:35:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBFA10E34C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 06:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg9SIqU/KOaMATyMcmvJ+vSJajn8VjU61VqK1dBXPr6Jl/qkPlLakHZz8KpkOVn9EOVph09vgIL+nucdaiUWiOeV5Xou2AR0+AKtWOrHYzwOBk+qYzjx8hOP4i+PrGlmPGRIp8zEmK+kEzV2ztnkbWG+eylS2I9PClr8+6bENSbeOi0/nvi5Ol/e6T7ABXP7C7VJ2v01sJ12WEDRakpY6AXL8KDshvxIqeIQaUuGNwX5fvrjxXt81KpUS4F4gHTs6J7FKAMLngsmTs3c0juC850nhxmwlWvDQKvlWmAeTvc6uKM+ccAeASHwolcJSJ1yXB7e7EwWC3D0QlAbg+uZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCqHrh6luN/0itN8EQi9Tm2CqnJzRVV2bIdSSnwYiNI=;
 b=He5HTHyivar9qJOmyqXasgJkWsG4nVVhfXy75HuEhnQSs7rv3ZkRbJd/ShoPTrRZNx7/EllyzsRWKcVA4KBAQVKJV71hKeOw47yz7zcFPxAua9Ti+DNA1+618y+wVUUP+tddbJpVDnicpqKMpXqSrp7pa67n6v2RETmlVJdT/v7SGF9nI9jzL8gXKHJQY/S9FNEmRnq2on5sU3e2f+UERegVqaeOeyFx6BLM7BC6Xjwym+cLWlqDkX1boMuBtxp3ikKhvkcNox/e9qiEoNEFS4AF3EPGXnF4sTG2M+I9fNKLK+R8btOVA5fJl1tvwUz1UtHs6N1sFHFhe7dzGkDMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCqHrh6luN/0itN8EQi9Tm2CqnJzRVV2bIdSSnwYiNI=;
 b=mZMmHv2zu53N1cxsjaTKrAqKp67zhJ1anlzIu29d7DWyZYghYtgCof9op5fbj8JmAUhW4cdpgL+kkFKvP06IcczUFkJ0AAhrn08Z1zYDNxVTBnuuxukyL/Q1fQYxdgci7zcacXlwiFgn1iVYYzN79+dp8Knq9wMzbqsDRog+Gy0=
Received: from MW4PR04CA0235.namprd04.prod.outlook.com (2603:10b6:303:87::30)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 06:35:38 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::44) by MW4PR04CA0235.outlook.office365.com
 (2603:10b6:303:87::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 06:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 06:35:37 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 01:35:33 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V2 4/8] drm/amd/pm: add fan temperature/pwm curve OD setting support
 for SMU13
Date: Wed, 23 Aug 2023 14:34:02 +0800
Message-ID: <20230823063406.1195151-4-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 261d2350-2e6d-4a0e-dbe1-08dba3a329bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYyol//sIGGEIxq+RR7hpoU3UDN1amIO4QgYb6rODo9UsSzQscOyNt0ns0GvZXUjoOz8TRFUhQsJmko/IcmDjS4iiDk1W9FPJ3eImpprRBMx8XxxhPE18vvhsnFT5EpaRyvrVktctGKimqJhCJgMj8UEOtLmC3MrZ2xCbGkCjonxeB+D5rwJb+NWp/qyOUTafXoqp5fMKNX35DdOYHJKD+hvG1Z1NxvDnkmDtG7ZkmlZTSIEIJle0bR38QxA4jHQ/YhqRRueaQRNdXYeXO3gTkuZ2vy1p9TrcA6QekcuKdT7wyz6C1Np0CJ/jSHwYRTmeO76CaBIUF8V9ViLa4Zj4dqqeABXBudME6B/xkcygVdFzprzvMmoT91W02NGps/vQSSRwIhbAZ2U72Hb73qKVQdR+vRQokifRjIYCnCXooRykN9hl5Ise8phEeFIQ4Gj69MRC/2paMn70+WM+lkJG2iL9i+u8lhhQjuZwXn8wthL13J6br3gv6/htNhUpOX8KSG7H16qbLReEaiI+I9yt+ux27vVKoAtSkTVPMxRDISjQzjyTVSg/NJiARGQ+FystBZklBUod9h82BcqXsQu388sNxzWpDxEa1RsuH6dQhKZtitFdYz7x9Wzv3NA98bHafMS4khO78+QDSAdRL2Jcqvu7bg/3XnDcO53ew9loUGOPLSBoV9K9aIfz3XjmYRjTpAzu3b+/iPz1+4gVpdkVOFgpLEryiKQye5C0/9QfASI+tJJiGOC8NiE1SqiuBS/7VR32GNunwyCRK+VQ0SHeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(30864003)(40480700001)(83380400001)(5660300002)(44832011)(426003)(336012)(16526019)(26005)(36860700001)(86362001)(47076005)(7696005)(8676002)(2616005)(8936002)(4326008)(316002)(70586007)(6916009)(54906003)(70206006)(478600001)(81166007)(82740400003)(356005)(6666004)(40460700003)(36756003)(1076003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:35:37.6825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 261d2350-2e6d-4a0e-dbe1-08dba3a329bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
--
v1->v2:
  - add missing kerneldoc for the new interface(Alex)
---
 Documentation/gpu/amdgpu/thermal.rst          |  6 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 62 +++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 87 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 87 ++++++++++++++++++-
 8 files changed, 247 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 8757ec7f0136..48b4b89f2ffb 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -70,6 +70,12 @@ fan_mode
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: fan_mode
 
+fan_cuve
+--------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: fan_curve
+
 GFXOFF
 ======
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 020c9ce1f735..6d0d37dfb28b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -114,6 +114,7 @@ enum pp_clock_type {
 	OD_VDDGFX_OFFSET,
 	OD_CCLK,
 	OD_FAN_MODE,
+	OD_FAN_CURVE,
 };
 
 enum amd_pp_sensors {
@@ -189,6 +190,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_COMMIT_DPM_TABLE,
 	PP_OD_EDIT_VDDGFX_OFFSET,
 	PP_OD_EDIT_FAN_MODE,
+	PP_OD_EDIT_FAN_CURVE,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d53d60903fe9..7d477864f77f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3565,6 +3565,60 @@ static umode_t fan_mode_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+/**
+ * DOC: fan_curve
+ *
+ * The amdgpu driver provides a sysfs API for checking and adjusting the fan
+ * control curve line.
+ *
+ * Reading back the file shows you the current settings(temperature in Celsius
+ * degree and fan speed in pwm) applied to every anchor point of the curve line
+ * and their permitted ranges if changable.
+ *
+ * Writing a desired string(with the format like "anchor_point_index temperature
+ * fan_speed_in_pwm") to the file, change the settings for the specific anchor
+ * point accordingly.
+ *
+ * When you have finished the editing, write "c" (commit) to the file to commit
+ * your changes. NOTE: this will switch the fan control to manual mode.
+ */
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
@@ -3578,6 +3632,14 @@ static struct od_feature_set amdgpu_od_set = {
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
index 498000850212..f17127c50238 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -281,6 +281,7 @@ enum smu_clk_type {
 	SMU_OD_RANGE,
 	SMU_OD_VDDGFX_OFFSET,
 	SMU_OD_FAN_MODE,
+	SMU_OD_FAN_CURVE,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 45b42e43f9a3..b52b862e887c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -102,6 +102,8 @@
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
 #define PP_OD_FEATURE_FAN_MODE				5
+#define PP_OD_FEATURE_FAN_CURVE_TEMP			6
+#define PP_OD_FEATURE_FAN_CURVE_PWM			7
 
 #define LINK_SPEED_MAX					3
 
@@ -1115,6 +1117,14 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
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
@@ -1344,6 +1354,35 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
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
@@ -1554,6 +1593,44 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT);
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
@@ -1810,7 +1887,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 
 	if (smu_v13_0_0_is_od_feature_supported(smu,
 						PP_OD_FEATURE_FAN_CURVE_BIT))
-		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE;
+		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -1864,6 +1943,12 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
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
index 28c2e4b0e55d..3ce2dc6bb4af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -78,6 +78,8 @@
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
 #define PP_OD_FEATURE_FAN_MODE				5
+#define PP_OD_FEATURE_FAN_CURVE_TEMP			6
+#define PP_OD_FEATURE_FAN_CURVE_PWM			7
 
 #define LINK_SPEED_MAX					3
 
@@ -1101,6 +1103,14 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
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
@@ -1330,6 +1340,35 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
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
@@ -1540,6 +1579,44 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT);
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
@@ -1791,7 +1868,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 
 	if (smu_v13_0_7_is_od_feature_supported(smu,
 						PP_OD_FEATURE_FAN_CURVE_BIT))
-		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE;
+		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -1845,6 +1924,12 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
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

