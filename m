Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26C1EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 06:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320FB10E1DD;
	Mon, 21 Aug 2023 06:31:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B595410E1DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 06:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGUSwfzvPINPcyLMDwRcWKajvUuVco/GpNyN6fUe6ykYuc57X+DyMsNG5Ks/4HruKIZCUoBIdzDSVHBjLju/w5HA33WunkHHtTOCmnwY5i5gwMuKFnO2sviwP4x42QcbVaYxqdpW/kLHWEebmidu9scluD3sQvNANjNhIbAncfJMZZrcy602NlF5hsIHUkK4FJ8Qa7XzBsXmQsq2Ic0KiEg8TmXr3ja5RBaRWH/vfI9hCM5rNtdYALQEWvYi4Vk6Bpix7wXT58T2kgdKS7qQoyhVoaporuNB5KQGjjPSQg4Vr+1ug5LNsWvhzxtIIfkZxEf+2UlzLfqF+XScw2aS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNtTh9npGktWdF5p8a3Fu6ZeyEU0Gc818GPRLDswwmA=;
 b=HBjDwRZc/lFWX3zomU33iNHcuj/o+yrEA5a1QL3MyBb7ZHfD0VbFNmKny8YaCk11aTuTA2gngchtdN6NiCyINYrP6dh06GjbDrDvQstEXBf3GC3rF47ok6goywq9Zz9fvuo4DBO170k+T9etLJaOWTMx1R0sw9Pl+HOe39wK95t4TSgoR21r5E+4fx9M0I5VQhRDFzRvKJhwrdAD1kEv8iZc4DLpRQWvTnpCIaQ5uwZBLtrufLm5+KujOvxeR+3JFueOe6M/v5cqcivmj7jBfFognuE/du3tLDP9c//cOi0b96KRmKM2aiQy0LD95YYYaECOSw9tuTknem5oTzMJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNtTh9npGktWdF5p8a3Fu6ZeyEU0Gc818GPRLDswwmA=;
 b=Jj8+PFhhyAMsFQZlJeUwwbZO7KThaJTDG0QQ89FTpfGRZ1K8vEYHIC+lRBTa76xVou4mXVD/mZq5JdtG8f8m/I2pSOW0Z+6AVk0j2/yp0szLTdmQUpmDzoT2X04n6EwJ9SqloLGfj8J5/4troHfYfDKoOFWL4leAXJCqHE3y//Q=
Received: from CY8PR10CA0002.namprd10.prod.outlook.com (2603:10b6:930:4f::7)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 06:31:35 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::82) by CY8PR10CA0002.outlook.office365.com
 (2603:10b6:930:4f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 06:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 06:31:35 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 01:31:30 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct SMU13 gfx voltage related OD settings
Date: Mon, 21 Aug 2023 14:31:11 +0800
Message-ID: <20230821063111.628622-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 85eed908-15b8-45e5-5405-08dba2104468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5+FSsHEsXRtEILa0PXgxVKz4y6DCm/HZ6J4yO8uj06XHybEh6G2x6WoTdGYJsXp6uHufJe0aDyphMDy0NKtut3wWDALMInB56yZ4jjRRq4hI3w6MzXyCQzKpMVmyYOsrdxe8Lpm3cHikeblZTE1O7mdScj31Cr5Ec6DUlOxiJfH6u32gZ+uqVt39m2yvktdDf54tdbYl/nuUurGo+5/wFCAb3uzMjvMaMJQlCyxE8au2nVY0/KJr0Wd6QXFBo65zxV2zqRTO6b1XgR9flKeBC1IYQ6eFl/qTctMVJHqusODSK8H0evr+DIIiGFVWerVnQ1pVVyRvZusLsFxXldUOM2l/J2cAydo/jUgsPuvfuhPi9Hyf9V7CxhpufOCym71N4ldAVP7FMWxubyJQ6xGsH709gwYZeqPY8ML4/v8DNugYaBVXEpxCzvzbWD+3rsCdKWdaLOEyGYnAMNNwFCjqshjwqgGeZfr1Gv52en7Svgqh7tXdTCYxduT78cjtfQdtxkYqtDG1I2T/gRMSuGn3kSfuV1dDqouFDMBFCJ2NrgoVhRswZEE/WrzAaNQnTvpIAsYm63XPYJ2cflq44Py+DeO5OHthwyeCjQLHZ27ad7jVoISy/3en5Jw37LkPQn6aP5GUjkDnq6WbgYBAT+3Ihacm1HvGxx+rA4ZSpiqmrC1aLOzgGzuABMKkScN9N/tQL1QFNBnb920ShqVaqfnmCfSygEgEnB2so/KctP0Y19MvXdJN5CsWsFUmSOH6NE90zxpaqIV7rdCzmrkilVyvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(6916009)(54906003)(70586007)(70206006)(316002)(8676002)(2616005)(8936002)(4326008)(1076003)(36756003)(40460700003)(41300700001)(82740400003)(356005)(81166007)(478600001)(6666004)(7696005)(40480700001)(2906002)(83380400001)(86362001)(36860700001)(47076005)(336012)(44832011)(426003)(5660300002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 06:31:35.2827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eed908-15b8-45e5-5405-08dba2104468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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

The voltage offset setting will be applied to the whole v/f curve line
instead of per anchor point base.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 45 +++++++------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 31 ++++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 31 ++++++-------
 3 files changed, 43 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f03647fa3df6..97d550ac6942 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -643,18 +643,14 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  *   They can be used to calibrate the sclk voltage curve. This is
  *   available for Vega20 and NV1X.
  *
- * - voltage offset for the six anchor points of the v/f curve labeled
- *   OD_VDDC_CURVE. They can be used to calibrate the v/f curve. This
- *   is only availabe for some SMU13 ASICs.
- *
  * - voltage offset(in mV) applied on target voltage calculation.
- *   This is available for Sienna Cichlid, Navy Flounder and Dimgrey
- *   Cavefish. For these ASICs, the target voltage calculation can be
- *   illustrated by "voltage = voltage calculated from v/f curve +
- *   overdrive vddgfx offset"
+ *   This is available for Sienna Cichlid, Navy Flounder, Dimgrey
+ *   Cavefish and some later SMU13 ASICs. For these ASICs, the target
+ *   voltage calculation can be illustrated by "voltage = voltage
+ *   calculated from v/f curve + overdrive vddgfx offset"
  *
- * - a list of valid ranges for sclk, mclk, and voltage curve points
- *   labeled OD_RANGE
+ * - a list of valid ranges for sclk, mclk, voltage curve points
+ *   or voltage offset labeled OD_RANGE
  *
  * < For APUs >
  *
@@ -686,24 +682,17 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  *   E.g., "p 2 0 800" would set the minimum core clock on core
  *   2 to 800Mhz.
  *
- *   For sclk voltage curve,
- *     - For NV1X, enter the new values by writing a string that
- *       contains "vc point clock voltage" to the file. The points
- *       are indexed by 0, 1 and 2. E.g., "vc 0 300 600" will update
- *       point1 with clock set as 300Mhz and voltage as 600mV. "vc 2
- *       1000 1000" will update point3 with clock set as 1000Mhz and
- *       voltage 1000mV.
- *     - For SMU13 ASICs, enter the new values by writing a string that
- *       contains "vc anchor_point_index voltage_offset" to the file.
- *       There are total six anchor points defined on the v/f curve with
- *       index as 0 - 5.
- *       - "vc 0 10" will update the voltage offset for point1 as 10mv.
- *       - "vc 5 -10" will update the voltage offset for point6 as -10mv.
- *
- *   To update the voltage offset applied for gfxclk/voltage calculation,
- *   enter the new value by writing a string that contains "vo offset".
- *   This is supported by Sienna Cichlid, Navy Flounder and Dimgrey Cavefish.
- *   And the offset can be a positive or negative value.
+ *   For sclk voltage curve supported by Vega20 and NV1X, enter the new
+ *   values by writing a string that contains "vc point clock voltage"
+ *   to the file. The points are indexed by 0, 1 and 2. E.g., "vc 0 300
+ *   600" will update point1 with clock set as 300Mhz and voltage as 600mV.
+ *   "vc 2 1000 1000" will update point3 with clock set as 1000Mhz and
+ *   voltage 1000mV.
+ *
+ *   For voltage offset supported by Sienna Cichlid, Navy Flounder, Dimgrey
+ *   Cavefish and some later SMU13 ASICs, enter the new value by writing a
+ *   string that contains "vo offset". E.g., "vo -10" will update the extra
+ *   voltage offset applied to the whole v/f curve line as -10mv.
  *
  * - When you have edited all of the states as needed, write "c" (commit)
  *   to the file to commit your changes
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3903a47669e4..bd0d5f027cac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1304,16 +1304,14 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 					od_table->OverDriveTable.UclkFmax);
 		break;
 
-	case SMU_OD_VDDC_CURVE:
+	case SMU_OD_VDDGFX_OFFSET:
 		if (!smu_v13_0_0_is_od_feature_supported(smu,
 							 PP_OD_FEATURE_GFX_VF_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_VDDC_CURVE:\n");
-		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
-			size += sysfs_emit_at(buf, size, "%d: %dmv\n",
-						i,
-						od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i]);
+		size += sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
+		size += sysfs_emit_at(buf, size, "%dmV\n",
+				      od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
 		break;
 
 	case SMU_OD_RANGE:
@@ -1355,7 +1353,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 							  PP_OD_FEATURE_GFX_VF_CURVE,
 							  &min_value,
 							  &max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE: %7dmv %10dmv\n",
+			size += sysfs_emit_at(buf, size, "VDDGFX_OFFSET: %7dmv %10dmv\n",
 					      min_value, max_value);
 		}
 		break;
@@ -1504,29 +1502,26 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		}
 		break;
 
-	case PP_OD_EDIT_VDDC_CURVE:
+	case PP_OD_EDIT_VDDGFX_OFFSET:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
-			dev_warn(adev->dev, "VF curve setting not supported!\n");
+			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
-		if (input[0] >= PP_NUM_OD_VF_CURVE_POINTS ||
-		    input[0] < 0)
-			return -EINVAL;
-
 		smu_v13_0_0_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_GFX_VF_CURVE,
 						  &minimum,
 						  &maximum);
-		if (input[1] < minimum ||
-		    input[1] > maximum) {
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
 			dev_info(adev->dev, "Voltage offset (%ld) must be within [%d, %d]!\n",
-				 input[1], minimum, maximum);
+				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
 
-		od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[input[0]] = input[1];
-		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFX_VF_CURVE_BIT;
+		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
+			od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT);
 		break;
 
 	case PP_OD_RESTORE_DEFAULT_TABLE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 94ef5b4d116d..e54a6efc4fb5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1284,16 +1284,14 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 					od_table->OverDriveTable.UclkFmax);
 		break;
 
-	case SMU_OD_VDDC_CURVE:
+	case SMU_OD_VDDGFX_OFFSET:
 		if (!smu_v13_0_7_is_od_feature_supported(smu,
 							 PP_OD_FEATURE_GFX_VF_CURVE_BIT))
 			break;
 
-		size += sysfs_emit_at(buf, size, "OD_VDDC_CURVE:\n");
-		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
-			size += sysfs_emit_at(buf, size, "%d: %dmv\n",
-						i,
-						od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i]);
+		size += sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
+		size += sysfs_emit_at(buf, size, "%dmV\n",
+				      od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
 		break;
 
 	case SMU_OD_RANGE:
@@ -1335,7 +1333,7 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 							  PP_OD_FEATURE_GFX_VF_CURVE,
 							  &min_value,
 							  &max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE: %7dmv %10dmv\n",
+			size += sysfs_emit_at(buf, size, "VDDGFX_OFFSET: %7dmv %10dmv\n",
 					      min_value, max_value);
 		}
 		break;
@@ -1484,29 +1482,26 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		}
 		break;
 
-	case PP_OD_EDIT_VDDC_CURVE:
+	case PP_OD_EDIT_VDDGFX_OFFSET:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
-			dev_warn(adev->dev, "VF curve setting not supported!\n");
+			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
-		if (input[0] >= PP_NUM_OD_VF_CURVE_POINTS ||
-		    input[0] < 0)
-			return -EINVAL;
-
 		smu_v13_0_7_get_od_setting_limits(smu,
 						  PP_OD_FEATURE_GFX_VF_CURVE,
 						  &minimum,
 						  &maximum);
-		if (input[1] < minimum ||
-		    input[1] > maximum) {
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
 			dev_info(adev->dev, "Voltage offset (%ld) must be within [%d, %d]!\n",
-				 input[1], minimum, maximum);
+				 input[0],minimum, maximum);
 			return -EINVAL;
 		}
 
-		od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[input[0]] = input[1];
-		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFX_VF_CURVE_BIT;
+		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
+			od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT);
 		break;
 
 	case PP_OD_RESTORE_DEFAULT_TABLE:
-- 
2.34.1

