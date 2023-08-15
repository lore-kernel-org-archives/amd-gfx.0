Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57E7C04A6A
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B23310E16A;
	Tue, 15 Aug 2023 08:43:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0494F10E16E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAqS9vYKP/1+k1u2eLoxrsJsT8MFVcbBk0IJw4plPIcG+6ZfYJj0Jnqdb99I+a64ny/qT0rSGYBd5YlZSzowjraTqyFGNUCznzZEF3wFaD/448jtL/a2LM0OKo1/bKltaTG+3DV/KMfa3+OULS7nrKyMC29j8+7xCsdJDfVmLDBWd3oNHQGZKtI2QeRznaXOr9Mzo7gZf4YwYNCpUOeDx/9EdlA7kIW6A7OjKXJqsTIPFwgObbYZECnLHFW7yaCbfTWQAdl5jp/5+652pgbusajDKRPXA6GIpAqlxOgo9zr1PNMfYi1mFbV26JCfIEyTEEXGlf8gvxtQSIyBB4sRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd+9r7RTueK570NzjRhf+AJzbXA3qRvvw77AdaCHVk4=;
 b=YZ+ehXlNQT6VwnV2cm0nEOCjJGtVXwJl80taLhimNg0pYEZ+wx/97lgilvPu9ziZjjIni+o+Z/s8NY0g/wT1JVetBiOdRdCCwRlkAWW8ccz2mqzcYnhxbuKIJMoQWFFRieb1YV2wx67nBuRMzw1ZKNauKPQ5ZAM2wE5o2QafzuGV8BVPGtWiuPEiqEi4coJvmWBR97l5Vt13yzWp0hPhIH7PPLxtp+HFJZ+NCq8ADBubKzrfa41fjL0XRUtmKISZLtFOKwzQJgKefSXZ0B7dxd7qVMcj5EDuw5MHjbgUmR6X38wC0ajLK7Lkiljy6Ox7icH7XCQmSq54YN9x8qMU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd+9r7RTueK570NzjRhf+AJzbXA3qRvvw77AdaCHVk4=;
 b=FlehsdntGldMsFsM4fATKcLJlmipzEx8CqVEYjfkwg5+L8b2CwEsZB1p5qS3H8I06W6EQ168obYfditMKVU6BMMhndD/pVP1w96UaGMaWvhP/mnzYkQFwOwvXWQ/r2+G7GBn72qC/r1xn+evKxNT2yqhK66TwHMfpsZ81OWiMoo=
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 08:43:40 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::7a) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 08:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 08:43:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:43:36 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amd/pm: add fan target temperature OD setting support
 for SMU13
Date: Tue, 15 Aug 2023 16:42:30 +0800
Message-ID: <20230815084231.3229009-8-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 49489eed-74b8-4313-8390-08db9d6bb936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiIV4gmor1pz2PjnyUULRlAua+EBc3+fqEwh6m+x60t/qVY/HY8Ym7gIyu+iFYfFyc5AdGF+OgWhzdxOSG3BuV1FUbsHzQWzefWW5Kg3kioz7qzuGyLvYLPqjtLmagXgrhHW61dnEHHvr6SbHwwcbbk2EZfzZES9xpB4HUQHt/vvMkOQWMl7JpoWe282Hug2QOh3gl20ZM8kBM96aoM5JrrJdMeRctLKvDNO6JmkG0+NUepx63f1qcb7RrDi9WJ529t238ZAHulWvOSHzx2QJO7vEbc6NhCyvoUq3LuycWQa3HkrT2jdcCtsMYdKrfq75+VVZ/vfcxWz8sMetLnysmBjcTfDPX99Mh0BmQOdDhasvtb8vXDVbPR2Hcp++0P8uNcMT8CK/+2SWWHnSxFUkKo7mHjrWGgVk2CsXUWwV/Rmtx2IgMkzz/+n4SgF0sClGusqI7JKOxH0lE7Ho/tRLkx6F8QDptRvTeBk46IA1FofLx6wbgD9uaaegXiB1SUEh+evZHBzaPioDX/EaRb9gKRFdp+pd0QtS0RgieRnQsBQ1yWQ2qQlJo44PctuaStPpP4GyK8/F2jnMgyLFeFykxaHuBmOa5LrD4OSYPADPbFZTpXYfqnWIwMp8IGwkT+jGuBBX90RRvKa3u2xEHcOr6QOm9O1+U3EHzrZxVAKj/sYqppBFcoNEb9ESTvBYqLF13qV+r6C25eQYBGU6kAe9tOMrUP91TLz7csO7EaMVDIa7e5BnDsqQLyy2k0gGH2KJJz2VbRhMepD41eMwVGBdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(1800799006)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(7696005)(6666004)(478600001)(16526019)(2616005)(336012)(1076003)(426003)(2906002)(26005)(83380400001)(30864003)(54906003)(41300700001)(6916009)(316002)(70206006)(70586007)(44832011)(5660300002)(8936002)(8676002)(4326008)(36756003)(40460700003)(86362001)(36860700001)(40480700001)(47076005)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:43:39.5913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49489eed-74b8-4313-8390-08db9d6bb936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 45 ++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 51 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 51 ++++++++++++++++++-
 7 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 06ed73a6b5f3..e2eefc8d8edc 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -117,6 +117,7 @@ enum pp_clock_type {
 	OD_FAN_CURVE,
 	OD_ACOUSTIC_LIMIT,
 	OD_ACOUSTIC_TARGET,
+	OD_FAN_TARGET_TEMPERATURE,
 };
 
 enum amd_pp_sensors {
@@ -194,6 +195,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_FAN_CURVE,
 	PP_OD_EDIT_ACOUSTIC_LIMIT,
 	PP_OD_EDIT_ACOUSTIC_TARGET,
+	PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 6a75b53189b7..63edd45e224d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3795,6 +3795,43 @@ static umode_t acoustic_target_threshold_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
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
@@ -3832,6 +3869,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = acoustic_target_threshold_store,
 					},
 				},
+				[4] = {
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
index 6b2bbd13db09..80d2ac1ecb9f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -322,6 +322,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET		BIT(5)
 #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE	BIT(6)
 #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET		BIT(7)
+#define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE	BIT(8)
+#define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET	BIT(9)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3bfa9b9bb247..22a6527139a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2489,6 +2489,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_ACOUSTIC_LIMIT; break;
 	case OD_ACOUSTIC_TARGET:
 		clk_type = SMU_OD_ACOUSTIC_TARGET; break;
+	case OD_FAN_TARGET_TEMPERATURE:
+		clk_type = SMU_OD_FAN_TARGET_TEMPERATURE; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 1463a5d41647..7c405486ec52 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -282,6 +282,7 @@ enum smu_clk_type {
 	SMU_OD_FAN_CURVE,
 	SMU_OD_ACOUSTIC_LIMIT,
 	SMU_OD_ACOUSTIC_TARGET,
+	SMU_OD_FAN_TARGET_TEMPERATURE,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 78337380a6b3..54745791fa9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -106,6 +106,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
+#define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		10
 
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1108,6 +1109,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
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
@@ -1400,6 +1405,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
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
@@ -1695,6 +1718,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1954,7 +1999,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -2018,6 +2065,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
+		user_od_table->OverDriveTable.FanTargetTemperature =
+			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 8d4d0864aa73..68e42aad3370 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -82,6 +82,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
+#define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		10
 
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1095,6 +1096,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
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
@@ -1387,6 +1392,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
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
@@ -1682,6 +1705,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1936,7 +1981,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -2000,6 +2047,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
+		user_od_table->OverDriveTable.FanTargetTemperature =
+			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

