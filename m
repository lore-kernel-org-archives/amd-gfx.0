Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA29BC6FA8F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 05:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D26C10E4B5;
	Wed, 30 Aug 2023 05:57:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE5D810E0DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 05:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcXGAsVuIf/k5vyXHYFTJfyBVGlefU4O3BH19p5AS2fW9MFkUBw9RjOUrM6YV1EudzSIRj8rWqCNrE7jaQOn4fc9sGXGjutdhIsM5/+1iHlo3faabBGfLTFXdvrHRavDOEoNdPQqsVrQKjU9Y2+XjoLQ1IO5UiiuYdZdKu6H5/XrqDvSJm1hyC0RhKft4vPuYJMYU3Q4UdlRJlN0cIWwFhmHtEF87F7C1O39mN1IkTV8vTdRrcdWoi4NRMpkid3sDJWIiX0r30IBIUT3BJEJkzpBvPDovrEaSQVL6zAbmpNLeFolqlCxY5Et1b3bv76bSuqPixVl67j/xPdu5YkQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JMzU5SF7A7Xiz1TsK/BSjHHHLqhMrJF51glgfKYLas=;
 b=Jwrm+UqB1VclKqfPl8PDQHNIySOuwFRd7oL1VNEsE2OnZmLKgvG+HFWUFGQN088RIK6rK0SziH6O8rCxXz8w76jGucnJEZwen2aGq4Qc9F/aH8YrWoDSehugrARoHKAfBQxkAPA80Dqb6hLuSPedqu5h9D1bvnR9d4rijuPeVsQ4QwoOLaXBvhJtiHIgM73cYhnAAtX8/KC0YlzDi+rtAnQHK+NQWFiTP179Qg9eJsxMbCpypdIpCdKO5ZHq55F10r/cuc3qs5eUVGYRoCijXRat/C9Q1iuGP13nUvG5cSyiJthmsy+PxdJHeBiIn65dZH3p7KeXwYs9VSp+AnZ7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JMzU5SF7A7Xiz1TsK/BSjHHHLqhMrJF51glgfKYLas=;
 b=VBZWeI5Q5Qodl/q24ONpT4gZs3T1uW4EuUEC+cI2MGRUIGGzIqSI6dmA0Ru0X4XE/07qkXF4bDwcsUJl5uAOHgnxPFiOC6UWHdewVE8VVcYYzCF5Rse0mHZnJKrIfcB06kge6edPDzvHg1Imy9Y4mhaddhxBVGrGmMPM2t8+65I=
Received: from CYXPR02CA0078.namprd02.prod.outlook.com (2603:10b6:930:ce::16)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 05:57:20 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::f9) by CYXPR02CA0078.outlook.office365.com
 (2603:10b6:930:ce::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 05:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 05:57:19 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 00:57:17 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V3 3/7] drm/amd/pm: add fan temperature/pwm curve OD setting support
 for SMU13
Date: Wed, 30 Aug 2023 13:56:44 +0800
Message-ID: <20230830055648.477908-4-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c44823-bcc3-4b01-c79a-08dba91df8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UO0bYfujUMxZA7Jo5weW61BO9i/ZrQdAtg4TLfnQf7Y9570bdDjJuxB2L0tIy6Z5OOS0k0FrkuTCHOt/U1QYTS8CRBIurvBwr9z4GuwsxZMY0p0CPejFiACX2zrSTZ8LnvoTHJ1VIYAD6uiwXP/7bdr1KgumKDt19HOx4Z2kc95XEaErKhIzEm85+p4ueFgRAvbWcmzUmlA+DGVOGpztdQx6cTveTnSCyCf3oIJJAvVjpza+KJj1/1xiwfFzYy7kqQtBjDkgvdpYNEQ4o6iZCvZAyUYxc1q/ecj8y5HOoybMqUNsE9MQy7za0qzYY/hgh1xjVxZ0mhSmXgUH5XxeUNNTcpa6U9aSmq+gPKzGq8d604ICdoeUGVovF05akoM35vbGUzzfpzHTD77AtHGaleg+kApB+Ksn7VcISz+GEV1syWLO7d/XTeNu9MOMxlNQ+gsDezggkZneqHvxA49Z3x/JI9dfWHx4aBpTARmnQQGDxUlK9yZrIIQm7tWBnuvZYKDnsKeLdwu8HLI80oHxiqDSRFIKdO7EeWbdlK5voJVV572Hk7P1dYExZF3huQxh2aExd+mxlzQuUYGCb7LWsi2K7HxtXedzBr8c9JqrDnku/MhQiVVvvcllpMbte9E+dmsU9tJrEg1sD4/Ew0SgiG1IVtlHVd2Ik5u09GX2BMRgZljRNHVF4U8HMhxLJWz1N+9N5BANR4uVmQf1Nc3hnlYCaCqmZcu8ruKYd/TEalQhjHUWFX0Y0Ygm6VBRQA6c7sGu0xyRLSJOUW714yh0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(40460700003)(316002)(41300700001)(6916009)(4326008)(336012)(426003)(83380400001)(2906002)(47076005)(30864003)(86362001)(2616005)(44832011)(16526019)(26005)(1076003)(8676002)(5660300002)(36756003)(40480700001)(36860700001)(8936002)(6666004)(82740400003)(81166007)(356005)(7696005)(54906003)(70206006)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 05:57:19.8359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c44823-bcc3-4b01-c79a-08dba91df8fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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
v2->v3:
  - rich the document for the new interface(Alex)
---
 Documentation/gpu/amdgpu/thermal.rst          |   6 +
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 210 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 102 ++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 102 ++++++++-
 8 files changed, 423 insertions(+), 8 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 5e27e4eb3959..08ee33b2acb6 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -64,6 +64,12 @@ gpu_metrics
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: gpu_metrics
 
+fan_curve
+---------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: fan_curve
+
 GFXOFF
 ======
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 84c5224d994c..7bdd2bdab970 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -113,6 +113,7 @@ enum pp_clock_type {
 	OD_RANGE,
 	OD_VDDGFX_OFFSET,
 	OD_CCLK,
+	OD_FAN_CURVE,
 };
 
 enum amd_pp_sensors {
@@ -186,7 +187,8 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_VDDC_CURVE,
 	PP_OD_RESTORE_DEFAULT_TABLE,
 	PP_OD_COMMIT_DPM_TABLE,
-	PP_OD_EDIT_VDDGFX_OFFSET
+	PP_OD_EDIT_VDDGFX_OFFSET,
+	PP_OD_EDIT_FAN_CURVE,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index edb52697c489..1008d43e9c3f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3383,7 +3383,215 @@ static const struct attribute_group *hwmon_groups[] = {
 	NULL
 };
 
-static struct od_feature_set amdgpu_od_set;
+static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
+				       enum pp_clock_type od_type,
+				       char *buf)
+{
+	int size = 0;
+	int ret;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	ret = pm_runtime_get_sync(adev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(adev->dev);
+		return ret;
+	}
+
+	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
+	if (size == 0)
+		size = sysfs_emit(buf, "\n");
+
+	pm_runtime_mark_last_busy(adev->dev);
+	pm_runtime_put_autosuspend(adev->dev);
+
+	return size;
+}
+
+static int parse_input_od_command_lines(const char *buf,
+					size_t count,
+					u32 *type,
+					long *params,
+					uint32_t *num_of_params)
+{
+	const char delimiter[3] = {' ', '\n', '\0'};
+	uint32_t parameter_size = 0;
+	char buf_cpy[128] = {0};
+	char *tmp_str, *sub_str;
+	int ret;
+
+	if (count > sizeof(buf_cpy) - 1)
+		return -EINVAL;
+
+	memcpy(buf_cpy, buf, count);
+	tmp_str = buf_cpy;
+
+	/* skip heading spaces */
+	while (isspace(*tmp_str))
+		tmp_str++;
+
+	switch (*tmp_str) {
+	case 'c':
+		*type = PP_OD_COMMIT_DPM_TABLE;
+		return 0;
+	default:
+		break;
+	}
+
+	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
+		if (strlen(sub_str) == 0)
+			continue;
+
+		ret = kstrtol(sub_str, 0, &params[parameter_size]);
+		if (ret)
+			return -EINVAL;
+		parameter_size++;
+
+		while (isspace(*tmp_str))
+			tmp_str++;
+	}
+
+	*num_of_params = parameter_size;
+
+	return 0;
+}
+
+static int
+amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
+				     enum PP_OD_DPM_TABLE_COMMAND cmd_type,
+				     const char *in_buf,
+				     size_t count)
+{
+	uint32_t parameter_size = 0;
+	long parameter[64];
+	int ret;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	ret = parse_input_od_command_lines(in_buf,
+					   count,
+					   &cmd_type,
+					   parameter,
+					   &parameter_size);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_get_sync(adev->dev);
+	if (ret < 0)
+		goto err_out0;
+
+	ret = amdgpu_dpm_odn_edit_dpm_table(adev,
+					    cmd_type,
+					    parameter,
+					    parameter_size);
+	if (ret)
+		goto err_out1;
+
+	if (cmd_type == PP_OD_COMMIT_DPM_TABLE) {
+		ret = amdgpu_dpm_dispatch_task(adev,
+					       AMD_PP_TASK_READJUST_POWER_STATE,
+					       NULL);
+		if (ret)
+			goto err_out1;
+	}
+
+	pm_runtime_mark_last_busy(adev->dev);
+	pm_runtime_put_autosuspend(adev->dev);
+
+	return count;
+
+err_out1:
+	pm_runtime_mark_last_busy(adev->dev);
+err_out0:
+	pm_runtime_put_autosuspend(adev->dev);
+
+	return ret;
+}
+
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
+ * your changes.
+ *
+ * There are two fan control modes supported: auto and manual. With auto mode,
+ * PMFW handles the fan speed control(how fan speed reacts to ASIC temperature).
+ * While with manual mode, users can set their own fan curve line as what
+ * described here. Normally the ASIC is booted up with auto mode. Any
+ * settings via this interface will switch the fan control to manual mode
+ * implicitly.
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
+static struct od_feature_set amdgpu_od_set = {
+	.containers = {
+		[0] = {
+			.name = "fan_ctrl",
+			.sub_feature = {
+				[0] = {
+					.name = "fan_curve",
+					.ops = {
+						.is_visible = fan_curve_visible,
+						.show = fan_curve_show,
+						.store = fan_curve_store,
+					},
+				},
+			},
+		},
+	},
+};
 
 static void od_kobj_release(struct kobject *kobj)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 4cab6a2efb63..90544a8f450c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -314,6 +314,9 @@ struct config_table_setting
 	uint16_t fclk_average_tau;
 };
 
+#define OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE		BIT(0)
+#define OD_OPS_SUPPORT_FAN_CURVE_SET			BIT(1)
+
 struct amdgpu_pm {
 	struct mutex		mutex;
 	u32                     current_sclk;
@@ -368,6 +371,7 @@ struct amdgpu_pm {
 	enum amdgpu_runpm_mode rpm_mode;
 
 	struct list_head	od_kobj_list;
+	uint32_t		od_feature_mask;
 };
 
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f005a90c35af..2d73a63813de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2481,6 +2481,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_VDDGFX_OFFSET; break;
 	case OD_CCLK:
 		clk_type = SMU_OD_CCLK; break;
+	case OD_FAN_CURVE:
+		clk_type = SMU_OD_FAN_CURVE; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index e57265cf637c..83e1d43efd2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -280,6 +280,7 @@ enum smu_clk_type {
 	SMU_OD_VDDC_CURVE,
 	SMU_OD_RANGE,
 	SMU_OD_VDDGFX_OFFSET,
+	SMU_OD_FAN_CURVE,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fcb1906385e5..468152710c7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -101,6 +101,8 @@
 #define PP_OD_FEATURE_UCLK_FMIN				2
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
+#define PP_OD_FEATURE_FAN_CURVE_TEMP			5
+#define PP_OD_FEATURE_FAN_CURVE_PWM			6
 
 #define LINK_SPEED_MAX					3
 
@@ -1110,6 +1112,14 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->VoltageOffsetPerZoneBoundary;
 		od_max_setting = overdrive_upperlimits->VoltageOffsetPerZoneBoundary;
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
@@ -1329,6 +1339,35 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 				      od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
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
@@ -1539,6 +1578,44 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1789,6 +1866,16 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (smu_v13_0_0_is_od_feature_supported(smu,
+						PP_OD_FEATURE_FAN_CURVE_BIT))
+		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_SET;
+}
+
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 {
 	OverDriveTableExternal_t *od_table =
@@ -1838,8 +1925,16 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
 			user_od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] =
 				user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++) {
+			user_od_table->OverDriveTable.FanLinearTempPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearTempPoints[i];
+			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
+		}
 	}
 
+	smu_v13_0_0_set_supported_od_feature_mask(smu);
+
 	return 0;
 }
 
@@ -1850,9 +1945,10 @@ static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
 	int res;
 
-	user_od_table->OverDriveTable.FeatureCtrlMask = 1U << PP_OD_FEATURE_GFXCLK_BIT |
-							1U << PP_OD_FEATURE_UCLK_BIT |
-							1U << PP_OD_FEATURE_GFX_VF_CURVE_BIT;
+	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
+							BIT(PP_OD_FEATURE_UCLK_BIT) |
+							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
+							BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 	res = smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 328765f89c94..8b81ee9e6cf8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -77,6 +77,8 @@
 #define PP_OD_FEATURE_UCLK_FMIN				2
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
+#define PP_OD_FEATURE_FAN_CURVE_TEMP			5
+#define PP_OD_FEATURE_FAN_CURVE_PWM			6
 
 #define LINK_SPEED_MAX					3
 
@@ -1096,6 +1098,14 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->VoltageOffsetPerZoneBoundary;
 		od_max_setting = overdrive_upperlimits->VoltageOffsetPerZoneBoundary;
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
@@ -1315,6 +1325,35 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 				      od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
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
@@ -1525,6 +1564,44 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1770,6 +1847,16 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (smu_v13_0_7_is_od_feature_supported(smu,
+						PP_OD_FEATURE_FAN_CURVE_BIT))
+		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_CURVE_SET;
+}
+
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 {
 	OverDriveTableExternal_t *od_table =
@@ -1819,8 +1906,16 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
 			user_od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] =
 				user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++) {
+			user_od_table->OverDriveTable.FanLinearTempPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearTempPoints[i];
+			user_od_table->OverDriveTable.FanLinearPwmPoints[i] =
+				user_od_table_bak.OverDriveTable.FanLinearPwmPoints[i];
+		}
 	}
 
+	smu_v13_0_7_set_supported_od_feature_mask(smu);
+
 	return 0;
 }
 
@@ -1831,9 +1926,10 @@ static int smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
 	int res;
 
-	user_od_table->OverDriveTable.FeatureCtrlMask = 1U << PP_OD_FEATURE_GFXCLK_BIT |
-							1U << PP_OD_FEATURE_UCLK_BIT |
-							1U << PP_OD_FEATURE_GFX_VF_CURVE_BIT;
+	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
+							BIT(PP_OD_FEATURE_UCLK_BIT) |
+							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
+							BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 	res = smu_v13_0_7_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
-- 
2.34.1

