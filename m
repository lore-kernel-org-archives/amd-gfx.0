Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E84DC6FA8F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 05:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E1010E4B9;
	Wed, 30 Aug 2023 05:57:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397AC10E4B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 05:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H99NoW2ZX+fGn3QTNeoO/JVzz8IYhzV6tRN19SmPRY4qkAw6FYCrgM4QWp4sz1Ba5d2OxXWBmPcgFaHdWEm4YuUOU/kSGhWfxL3jWdLySVMssSpQkD/gHBaZRKtO0Ut3nbphtNaZnuSTUIcpfNqpG4t7hFwyLr1TNDAlzfVm/5zNyiy7yh2EHRu6MnjltXsyOSskQX3iR9zs59Yz+VXXZEYvtwSuqcjfCoY2o/mMyqSyMglz6bVH00RvjFX/8UwfCbDRQ48r9IajqWTPCFptMwaFmCYmAeIBPKBfT5DVhk7iT36BmJn8jq5LHYLd11CVh7N+0L/tQM9KpxKPPhCb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXB+ya6q4fnh0IDOiRRlSmoydiEuZkzv96DUXca0Bi8=;
 b=IhHqvNJ3UTyY3AwX6hOYoe49bOkT8qOErWSi2CPkP+ARMv75sdq0O3LleMLR6bXnj/uM++2AB/LYiTmOnB4GmZryBttwzZQrGA+Fh3oI5/YEHvoS70HSylcS7K0eMCpyiaqusse2jgIgvNtlJY9mtpuMsKGkmBQAeQO5uBex3TrCKrrdn9YT95/eFuJbn6hBPGyNwFuTTDWxifEYlNMPos04VbrcWSYdrinq0f5islc/oALrEbHINiHnTvAaJ9yrQLMNVJGwc2ySwQ0gNIU4FOkOPi3C0L78506IIf5OB3e+GbW3+i99CaxUcFI0v3qTJWB0lVktzDsHduNzawY0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXB+ya6q4fnh0IDOiRRlSmoydiEuZkzv96DUXca0Bi8=;
 b=SUkmTeFj12TaxxqqbP2ug4EGuXu/Q8zLy7JLMYYGt1bXJFas1VVbSRoY43OQ1Tu5jx3m4ZiBD8y+BAvakjD9UbWT1WDVnv6XkHQCztbSz+zjzwD46H/QO5wayH7lilYFRrcqiq4ifxIhB6evX2ussiCaJGNOeVFqeTXZ4D7BC7E=
Received: from MW4PR04CA0286.namprd04.prod.outlook.com (2603:10b6:303:89::21)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Wed, 30 Aug 2023 05:57:41 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::72) by MW4PR04CA0286.outlook.office365.com
 (2603:10b6:303:89::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Wed, 30 Aug 2023 05:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 05:57:41 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 00:57:38 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V3 5/7] drm/amd/pm: add fan acoustic target OD setting support for
 SMU13
Date: Wed, 30 Aug 2023 13:56:46 +0800
Message-ID: <20230830055648.477908-6-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM8PR12MB5431:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f30be8-801d-4d81-2e4a-08dba91e05da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ev0ELW6tqARHSJ6/Rv54r9otu/D9SkSJQYk6bbKGfkPfgQaK8zhJkVUgxWZGJ61BwX+yxkenHYig6E6ZXSKh/NrApMS9FEZ0nkHKTW0QKwENQxcGKzZUyNwHsLdqNQ2A7ewVthnI95o2lNNCrZ9bi2ZLhpKuhEgNGd55nL8msDlqrwEzfJWfKRZqig10hzdqGZRna2khk8QOqkogj+qETUhS706FsBaxnr1UJc9GoARd1kPSKYtIu66Ftd4/UceZCD9BCfJH/SrgXSo4mt2JVPfYhBxt3a+oqVnZZiDFk+QuAwzInKWWhh0IrpDpvWyfM70awj3PtrTwkLyala8vXhQyLs47nLOOpswPeJDC+muaLdX9Khib/fBO2mCGZlXUZRzY3kVGc4w0PTz+70D8uoKTHqO5iUI1eV4xMKMUlaIO0f1lOikSXSQs9xIECTLD9H8AbyoJFHH+Zg0NWeDT0mpx8kC+vevJg7VYfIff9Y3i/eSxn71JJO7pf/w/KUA56hVojPmA2+9gcOT008X4CNC8Wj1TRiRbk7OUDWyjsxpyQZ1hiKmHFNoixEvBB92thHJ71U9J7u+rPXcDRyDfrMhWditCymItl/RmiPO3dzMXL3Q+R8CZypDVeRzCXDqGzJpRSZ2x7f9Eya5PidvFdt0o8rjwqaQxkgNtxLOcHF3LrJt7DyRCDHBHDFJ5xUoNDqiyitOj4GhZlBPAyl2XrMkNQKSXJUX9VwwwsL1ClA49ysUnMf2SaD3x3CfjHoSJvAShXw2HKP8iyL6PafeICw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(40460700003)(316002)(41300700001)(6916009)(4326008)(336012)(426003)(83380400001)(2906002)(47076005)(30864003)(86362001)(2616005)(44832011)(16526019)(26005)(1076003)(8676002)(5660300002)(36756003)(40480700001)(36860700001)(8936002)(6666004)(82740400003)(81166007)(356005)(7696005)(54906003)(70206006)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 05:57:41.3792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f30be8-801d-4d81-2e4a-08dba91e05da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
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
v2->v3:
  - rich the document for the new interface(Alex)
---
 Documentation/gpu/amdgpu/thermal.rst          |  6 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 65 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 51 ++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 51 ++++++++++++++-
 8 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 8ed888f81d2c..26ca4812b9f6 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -76,6 +76,12 @@ acoustic_limit_rpm_threshold
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
index e3dcef8c4ab7..a7bc81a0a36e 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -115,6 +115,7 @@ enum pp_clock_type {
 	OD_CCLK,
 	OD_FAN_CURVE,
 	OD_ACOUSTIC_LIMIT,
+	OD_ACOUSTIC_TARGET,
 };
 
 enum amd_pp_sensors {
@@ -191,6 +192,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_VDDGFX_OFFSET,
 	PP_OD_EDIT_FAN_CURVE,
 	PP_OD_EDIT_ACOUSTIC_LIMIT,
+	PP_OD_EDIT_ACOUSTIC_TARGET,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 1ec8a8c4016a..0d63d31b05d3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3630,6 +3630,63 @@ static umode_t acoustic_limit_threshold_visible(struct amdgpu_device *adev)
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
+ * your changes.
+ *
+ * This setting works under auto fan control mode only. It can co-exist with
+ * other settings which can work also under auto mode. It adjusts the PMFW's
+ * behavior about the maximum speed in RPM the fan can spin when ASIC
+ * temperature is not greater than target temperature. Setting via this
+ * interface will switch the fan control to auto mode implicitly.
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
@@ -3651,6 +3708,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = acoustic_limit_threshold_store,
 					},
 				},
+				[2] = {
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
index 984fda278f1a..bcb37ba8db58 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -318,6 +318,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_FAN_CURVE_SET			BIT(1)
 #define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE	BIT(2)
 #define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET		BIT(3)
+#define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE	BIT(4)
+#define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET		BIT(5)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ca41cfd57d89..0f1e805e166c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2485,6 +2485,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_FAN_CURVE; break;
 	case OD_ACOUSTIC_LIMIT:
 		clk_type = SMU_OD_ACOUSTIC_LIMIT; break;
+	case OD_ACOUSTIC_TARGET:
+		clk_type = SMU_OD_ACOUSTIC_TARGET; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 76bb1cba9b83..b2e9874f4a0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -282,6 +282,7 @@ enum smu_clk_type {
 	SMU_OD_VDDGFX_OFFSET,
 	SMU_OD_FAN_CURVE,
 	SMU_OD_ACOUSTIC_LIMIT,
+	SMU_OD_ACOUSTIC_TARGET,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 53636552508f..a718b530b0d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -104,6 +104,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			5
 #define PP_OD_FEATURE_FAN_CURVE_PWM			6
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		7
+#define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
 
 #define LINK_SPEED_MAX					3
 
@@ -1125,6 +1126,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
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
@@ -1391,6 +1396,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
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
@@ -1661,6 +1684,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1920,7 +1965,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -1980,6 +2027,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 		}
 		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
+		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 26a6b7e73c94..17302f235fc2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -80,6 +80,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			5
 #define PP_OD_FEATURE_FAN_CURVE_PWM			6
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		7
+#define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
 
 #define LINK_SPEED_MAX					3
 
@@ -1111,6 +1112,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
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
@@ -1377,6 +1382,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
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
@@ -1647,6 +1670,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1901,7 +1946,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 		adev->pm.od_feature_mask |= OD_OPS_SUPPORT_FAN_CURVE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_CURVE_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -1961,6 +2008,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 		}
 		user_od_table->OverDriveTable.AcousticLimitRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
+		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
+			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

