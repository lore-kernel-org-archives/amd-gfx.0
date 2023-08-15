Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EE4C001B0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B473510E16B;
	Tue, 15 Aug 2023 08:43:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40DA10E16A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jiua4JsiSS4ENJ2T8mG7h3XJku7JTNES2OUsed6nvM7Jp5pcH5G5CE96AW2MIGspUuSupyzlzeCRlcGV5xtCiaP4LytNkXQBqk1ee1JZPeitmHX4gpCygHLhRKdFefpLg0wT3HXdMTYgC4t/fxm2ROiJb5LiHqEh9GP/4i0wAyNPQwr7u/9b9gCsZvKudoz6L+n8Id2eE8pfR02+RBUOJGZjbTQ3f6/Pty/OcsLq0LnCGYoQmXCiLsR16I2RLCnNl4A6cnUDKjMmyjOG3tAJW8ci+WUJjWbghSVs3vTyce1jEr4xTwPGtVnDisLJmC4MqGlWudG64EPcvJcWyOEd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JqaZIUSUPjqcVQ8t/qCFD9/7EuPWJw57knMmJQEZaU=;
 b=irC3tbBaeuerv0QAXml76xmPZyTXpehOmgj199X98itSEIvmMCv+Y0q/B/f62yF6ymkU3Sc9fKdIi7Ul0mc6Ec9Yf/TvEmSek3nHEcUlD5GKGgbwCggSUg4BRKE4BJ0RxaPs1IMEw+o6DecHlybZYtTATjlK1cDT5R+tVWQNjc5xor1LRRTB5SZPZ0XgV9UI7iNZsPzkIaMfUnCvri2ed20XMF45PGKP2npIVndsQxukpk5AtOA0Tl7Oo7ZL9GTMvlhuTD66cOKV9IsdwpCh+oYK1OLHWKVH3rifLZ7e2uP5BBOcqCum7jrppp5/h6Ax0h0OTr5M4ldZ+YnHwXzfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JqaZIUSUPjqcVQ8t/qCFD9/7EuPWJw57knMmJQEZaU=;
 b=rOqU4ykEOKGHk/wDDw+zq2oBV/xL6udL/WUAxeF4G7lfI2lZ01G0wEvZ9zG3Fhs1c+1Hbr2oMWbghUFJ2yjD3UcgRpIZZHawZYugilx6XgXRtbY5R+UWa1odM7Ji7mo5hAZq5Jtt6AF7IbH0cpP8W2Cx2STDNvoJirlHZiWUhz4=
Received: from SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 08:43:00 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::53) by SJ0PR03CA0183.outlook.office365.com
 (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 08:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 08:42:59 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:42:57 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amd/pm: add fan mode OD setting support for SMU13
Date: Tue, 15 Aug 2023 16:42:26 +0800
Message-ID: <20230815084231.3229009-4-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb033b0-53d6-4803-798d-08db9d6ba179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utFeuBEDDr5XCZCjE5KUF+FwQUa1Rt9dlT8XwXY0xFN5U90PDmBLJM9TWRlpu2Yn4OMZLmWDIUXM9yv1GyF1Lk8IA3VGhnYwkTu1upKE6v2hGysn2n1UnnzCZ3qGSPGG6R9zfFpCsJFbAuGk7DLk5aJXuOukilwmG3/wqWTtMerfg77pYXmDPPlKhtNA43/uu6byGjDKhXL1WchCeq6OpqzO2/FXGkUu7pLnBmbiD4/ZjVtAsOTOX5hCLC1kUW0pJsTX32cMx2+ltmEWH+indqX/Zqnr3gCaaSkTmNXRcady2s2UhECYSg6zTIhvB2fj3lGEdhUDznVskO5o0aO+VV6jPj7KZL5t4AIKszccjD1RKT7rc1jSOVOGoh2MFBd7z1LvqVdidodM9/LIqhsQuFCXb6lIUCUHa4AssYBFVD646S3Zr4D+vtMRHzjaQlZBDnKeU9PCbuzWCps+qxPESecixqdw5Z2otYrBvL1eQf79yBii80c51rc71NSeJwKQCaKEktfxb8mvlKCHLF075lKvqmaW4sKL/ziBmNB46q0RBekM3NpzrfVHrLlrW/FKK35VeXqeTgWlMaBu3DOlpWZsXtnSqEcNJmdCEDqUxVKTbh3inLsIiw19h+7Qr5FGrqJDqqX2JeMOk6kQBSS4Y500CHol2r6ovhcirw9RvMc8eI03X5p/uzRHaVCUCYNOdeSouWPEAxnzJ4vyr1MsYxPBmJYp7LgZg1POrlwnIU3K0zge9o7GMXFp8nZOvPpAIWRxStiDMSJayShYbnUPVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(82310400008)(186006)(1800799006)(36840700001)(46966006)(40470700004)(40460700003)(336012)(426003)(16526019)(1076003)(26005)(2616005)(83380400001)(36860700001)(47076005)(7696005)(30864003)(41300700001)(54906003)(70206006)(70586007)(6916009)(2906002)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(6666004)(40480700001)(81166007)(356005)(82740400003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:42:59.7648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb033b0-53d6-4803-798d-08db9d6ba179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
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
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 189 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  35 +++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  35 +++-
 7 files changed, 262 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 90989405eddc..d51c639a3f31 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -113,6 +113,7 @@ enum pp_clock_type {
 	OD_RANGE,
 	OD_VDDGFX_OFFSET,
 	OD_CCLK,
+	OD_FAN_MODE,
 };
 
 enum amd_pp_sensors {
@@ -185,7 +186,8 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_VDDC_CURVE,
 	PP_OD_RESTORE_DEFAULT_TABLE,
 	PP_OD_COMMIT_DPM_TABLE,
-	PP_OD_EDIT_VDDGFX_OFFSET
+	PP_OD_EDIT_VDDGFX_OFFSET,
+	PP_OD_EDIT_FAN_MODE,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9352c0fbb09f..90c5f3c95307 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3513,7 +3513,194 @@ static const struct attribute_group *hwmon_groups[] = {
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
+	case 'r':
+		*type = PP_OD_RESTORE_DEFAULT_TABLE;
+		return 0;
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
index 297b70b9388f..f37de1df8291 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -278,6 +278,7 @@ enum smu_clk_type {
 	SMU_OD_VDDC_CURVE,
 	SMU_OD_RANGE,
 	SMU_OD_VDDGFX_OFFSET,
+	SMU_OD_FAN_MODE,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 30d9320e4b8c..19406fa001d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -101,6 +101,7 @@
 #define PP_OD_FEATURE_UCLK_FMIN				2
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
+#define PP_OD_FEATURE_FAN_MODE				5
 
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1083,6 +1084,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
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
@@ -1300,6 +1305,16 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 						od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i]);
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
@@ -1760,6 +1775,15 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
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
@@ -1809,8 +1833,12 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
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
 
@@ -1821,9 +1849,10 @@ static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
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
index 6b68822b8209..7db8a1e2c640 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -77,6 +77,7 @@
 #define PP_OD_FEATURE_UCLK_FMIN				2
 #define PP_OD_FEATURE_UCLK_FMAX				3
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
+#define PP_OD_FEATURE_FAN_MODE				5
 
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1070,6 +1071,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
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
@@ -1287,6 +1292,16 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 						od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i]);
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
@@ -1742,6 +1757,15 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
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
@@ -1791,8 +1815,12 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
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
 
@@ -1803,9 +1831,10 @@ static int smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
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

