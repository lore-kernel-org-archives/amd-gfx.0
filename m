Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6893FEE49AB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 06:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F2910E332;
	Wed, 23 Aug 2023 06:35:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB64310E2BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 06:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaVEQgqlDdT/BbyYKrzlV7bFZykAkSgJ8r4bY3e++H1HLFXVRiGP334dLPACUtMbgNjCy6V+gm3DgQnq3ZKXbxaR9xMkbsTZKNB3mRlOQHo4q1GLz1QZt4d6O8l4t8WlrfXeepyrNaCEQU2Ui89bBBV6TNtQEzomarWmJ8Pvv1xumtVjLQbTLCf0itveYK0pt3VN7p+2jXCqzqhtXLfqgpUviQnog7gVRjsm+wpzTnCq0Mhxt4raQZpZTAnynY7ay9ppgzOmxw0Y9jVjNOs9Htpxwp3DY8xIVpzIEzWw1fMVcI475QjwoD4GMIHlYYDL1qxu+bAJZfNI/tAhZej8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phjoUp63wTKpjAa7i/Gpbbbt6ezSNjUjuG9fXn6HQGY=;
 b=a0U9CApudUT8/48XI+wiUNIGaPalNQdv1N0NbFEMz/RArCo0SGZsUDX6Im2umEH6DN6MRszCrRwyhDtgrWr1O7g8p6GSSJ9RPeZvOy5cE5FyAZYmIngaPudp/V07HxwjotW3DYTXYhoQQ4PiNqjve8xQxX8rFZzI5BmUyMrVrd6zdC85VD+cnXg8eV8scBCXSAySr0efbRbi/bYYAHwg63I00Bf/bzDUw19Cfoy9GoOnUBZfOtikZRn28CtjXAPqvh+5aBYhZTes+7qlLL+UQkpL8WLJN1kjoXFCINHcepz2F9oCe4/f1mQuj0si5TEjWsNmHAxA6yJrqlRYUZdc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phjoUp63wTKpjAa7i/Gpbbbt6ezSNjUjuG9fXn6HQGY=;
 b=3CSuHu61A4Dk1u5LKVMSMPYGiZVI0OzVQ/AACA4L+Md9GnZ2NjS1s8lA4DDDOD400MrkNKiW3y74O2ZhdejzuH9y0hhPJf5QvemimHzUgbhv91SiDQe2yeqAgP6xOJYHsIv2ZchKQEOUoanBaIeIjxdaklHsvJjShGpgk84Yk88=
Received: from MW4PR03CA0077.namprd03.prod.outlook.com (2603:10b6:303:b6::22)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 06:35:36 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::33) by MW4PR03CA0077.outlook.office365.com
 (2603:10b6:303:b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 06:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 06:35:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 01:35:32 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V2 3/8] drm/amd/pm: add fan mode OD setting support for SMU13
Date: Wed, 23 Aug 2023 14:34:01 +0800
Message-ID: <20230823063406.1195151-3-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c7bcf1-fb80-4484-7dde-08dba3a328e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPHi9qOoyD3Btne1+JUI3IDGULex8a9ZM0J7uBvT1DL0VVecBGgG0Gsddkj0jPBUsCrDotDI7aMpi9s9GDs/MIoFlN089FMkmyGRfp4MF9caxy9axfGnEedNxjuimen1I3u1xils0zbmZcouWPb//akd3/tUDXPoWp7KAv3PKCMAHmXnpPIMbYZqd5OlGxepPacVDVXsNNca3mtFLFb9+AUKnw7OUx1KDVEOkTj/50Kv1IGrq16rbxQKygzZAqYQCUMYEj4YmL1MBgqJVTLuSd5/nI6nvIqcXdGWNVyobO7t8suKUBj98EES9BLBLqU+wFbVXe6t7i/82ii9vQX9WnFggZOtphhRF9SKYfiJCK4tG3wbETEtGQyvOry/R7lDKT1md8DCIogX3WOOyOnv1wPxs17dHSAiBAdQ2k9ROkqb8czkftlICxRnaZR2LfE0ay96X6VLPB+g5Mhd8P5rEqthgW1vDgt5Xt3jF1gF6FyyZtBVXBW2YnyUUahjQlqLfEgLEISnZzcFk2bn/owvWLpya14ZfRu3Gx4kvdKp8RNeAs1xfE8K4uajqHP+BWfF4JGGE7OpbhNB/gu+xrcGQ8C9wfCb9FqOBL/i9kfftTKzEROLRWuzrU6x3J1o+SsKRpDAIij+Nb4bQcOFxkzxLt9BaGQH5GK7KRKR97l0QoMXjBrqKynZBcQjL2iMy8sFx0XiFMZbbI5iWb1MaE/XYvgGJ2NLCWu3jWVV0sSrtUZCg+I3qkSejdt6Q9ahU67uy5OWhY8RZSrO2Varv8x+oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70586007)(6916009)(70206006)(316002)(8936002)(8676002)(2616005)(4326008)(1076003)(40460700003)(41300700001)(82740400003)(81166007)(356005)(478600001)(36756003)(6666004)(7696005)(40480700001)(30864003)(2906002)(83380400001)(47076005)(86362001)(36860700001)(336012)(426003)(44832011)(5660300002)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:35:36.2972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c7bcf1-fb80-4484-7dde-08dba3a328e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
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

Add SMU13 fan mode OD setting support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - add missing kerneldoc for the new interface(Alex)
---
 Documentation/gpu/amdgpu/thermal.rst          |   6 +
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 200 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  35 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  35 ++-
 8 files changed, 279 insertions(+), 8 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 5e27e4eb3959..8757ec7f0136 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -64,6 +64,12 @@ gpu_metrics
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: gpu_metrics
 
+fan_mode
+--------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: fan_mode
+
 GFXOFF
 ======
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 84c5224d994c..020c9ce1f735 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -113,6 +113,7 @@ enum pp_clock_type {
 	OD_RANGE,
 	OD_VDDGFX_OFFSET,
 	OD_CCLK,
+	OD_FAN_MODE,
 };
 
 enum amd_pp_sensors {
@@ -186,7 +187,8 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_VDDC_CURVE,
 	PP_OD_RESTORE_DEFAULT_TABLE,
 	PP_OD_COMMIT_DPM_TABLE,
-	PP_OD_EDIT_VDDGFX_OFFSET
+	PP_OD_EDIT_VDDGFX_OFFSET,
+	PP_OD_EDIT_FAN_MODE,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index beb3303fc832..d53d60903fe9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3383,7 +3383,205 @@ static const struct attribute_group *hwmon_groups[] = {
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
+ * DOC: fan_mode
+ *
+ * The amdgpu driver provides a sysfs API for checking and adjusting the fan
+ * control mode.
+ *
+ * Reading back the file shows you current fan control mode (e.g. '0' for auto
+ * mode and '1' for manual mode) and permitted settings if changable.
+ *
+ * Writing an integer to the file, sets the fan control mode correspondingly.
+ *
+ * When you have finished the editing, write "c" (commit) to the file to commit
+ * your changes.
+ */
+static ssize_t fan_mode_show(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     char *buf)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_MODE, buf);
+}
+
+static ssize_t fan_mode_store(struct kobject *kobj,
+			      struct kobj_attribute *attr,
+			      const char *buf,
+			      size_t count)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
+							     PP_OD_EDIT_FAN_MODE,
+							     buf,
+							     count);
+}
+
+static umode_t fan_mode_visible(struct amdgpu_device *adev)
+{
+	umode_t umode = 0000;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_MODE_RETRIEVE)
+		umode |= S_IRUSR | S_IRGRP | S_IROTH;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_MODE_SET)
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
+					.name = "fan_mode",
+					.ops = {
+						.is_visible = fan_mode_visible,
+						.show = fan_mode_show,
+						.store = fan_mode_store,
+					},
+				},
+			},
+		},
+	},
+};
 
 static void od_kobj_release(struct kobject *kobj)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 4cab6a2efb63..b54f84e2408a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -314,6 +314,9 @@ struct config_table_setting
 	uint16_t fclk_average_tau;
 };
 
+#define OD_OPS_SUPPORT_FAN_MODE_RETRIEVE		BIT(0)
+#define OD_OPS_SUPPORT_FAN_MODE_SET			BIT(1)
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
index f005a90c35af..01ccfd219d6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2481,6 +2481,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_VDDGFX_OFFSET; break;
 	case OD_CCLK:
 		clk_type = SMU_OD_CCLK; break;
+	case OD_FAN_MODE:
+		clk_type = SMU_OD_FAN_MODE; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index e57265cf637c..498000850212 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -280,6 +280,7 @@ enum smu_clk_type {
 	SMU_OD_VDDC_CURVE,
 	SMU_OD_RANGE,
 	SMU_OD_VDDGFX_OFFSET,
+	SMU_OD_FAN_MODE,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1041ba22f8f8..45b42e43f9a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -101,6 +101,7 @@
 #define PP_OD_FEATURE_UCLK_FMIN				2
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
+#define PP_OD_FEATURE_FAN_MODE				5
 
 #define LINK_SPEED_MAX					3
 
@@ -1110,6 +1111,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->VoltageOffsetPerZoneBoundary;
 		od_max_setting = overdrive_upperlimits->VoltageOffsetPerZoneBoundary;
 		break;
+	case PP_OD_FEATURE_FAN_MODE:
+		od_min_setting = overdrive_lowerlimits->FanMode;
+		od_max_setting = overdrive_upperlimits->FanMode;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1329,6 +1334,16 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 				      od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
 		break;
 
+	case SMU_OD_FAN_MODE:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_FAN_MODE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanMode);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1789,6 +1804,15 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (smu_v13_0_0_is_od_feature_supported(smu,
+						PP_OD_FEATURE_FAN_CURVE_BIT))
+		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE;
+}
+
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 {
 	OverDriveTableExternal_t *od_table =
@@ -1838,8 +1862,12 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
 			user_od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] =
 				user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
+		user_od_table->OverDriveTable.FanMode =
+			user_od_table_bak.OverDriveTable.FanMode;
 	}
 
+	smu_v13_0_0_set_supported_od_feature_mask(smu);
+
 	return 0;
 }
 
@@ -1850,9 +1878,10 @@ static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
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
index 328765f89c94..28c2e4b0e55d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -77,6 +77,7 @@
 #define PP_OD_FEATURE_UCLK_FMIN				2
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
+#define PP_OD_FEATURE_FAN_MODE				5
 
 #define LINK_SPEED_MAX					3
 
@@ -1096,6 +1097,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->VoltageOffsetPerZoneBoundary;
 		od_max_setting = overdrive_upperlimits->VoltageOffsetPerZoneBoundary;
 		break;
+	case PP_OD_FEATURE_FAN_MODE:
+		od_min_setting = overdrive_lowerlimits->FanMode;
+		od_max_setting = overdrive_upperlimits->FanMode;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1315,6 +1320,16 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 				      od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
 		break;
 
+	case SMU_OD_FAN_MODE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_FAN_MODE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanMode);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1770,6 +1785,15 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (smu_v13_0_7_is_od_feature_supported(smu,
+						PP_OD_FEATURE_FAN_CURVE_BIT))
+		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_MODE_RETRIEVE;
+}
+
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 {
 	OverDriveTableExternal_t *od_table =
@@ -1819,8 +1843,12 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
 			user_od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] =
 				user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
+		user_od_table->OverDriveTable.FanMode =
+			user_od_table_bak.OverDriveTable.FanMode;
 	}
 
+	smu_v13_0_7_set_supported_od_feature_mask(smu);
+
 	return 0;
 }
 
@@ -1831,9 +1859,10 @@ static int smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
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

