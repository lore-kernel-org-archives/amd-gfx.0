Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E19C369D1
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 11:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666D310E7D7;
	Thu, 24 Apr 2025 11:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OHbaxEm0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25AA10E7D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 11:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYMpjMYh9fQCodOn3mO2aOWybU476QJAztxTAEDuCKgUrJTzE39A2wEmX7FuK0+76eMiCI/w+ozb5aOR2kgq8kkuJLsc7/JaKOVHJjiHWRpcW5ocwebH15J4fh7X6i1RpO+EhNaAFir+vV2Xtgt0c+moXDfok5++JA6W9qE+60y+Hnpl3NYJ9ITLwE66pyOJitBLwfANk1IVK38YD0S2ttawuHEfF0LpBjJIFbcWubsFNtRZ8IIYUZcKtEsynSNl2kTgDdvTexxdY3nTSKWo26z17ZU/Sa4AR0lPyGTrOvCKlDqRW+vNBsoGCjmT2hAV+uT40GE4jY7Vx8oEndJ9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zIGvBhZjqpu5nu71pkpigAddlmNq3HpuObMfFAR4Q4=;
 b=YdO+Ibr9IrHeR6V79Ptq9DBQHqh8h/RjsKarhD+HXqAWDzEE6uqeH7fNZJvT7ArnLT15HUEK4V6nV5lvMeM/qnpIRkWKs5NUeFIjypViWoYniHiVU5kFWEZXy0dkgh79PhL9Bu9X6QzioaS4UsjiCX9K+mkkzQb8CN0qO9/VzQhohYmEiJBYy1GgDIZMuqXOh0vYMvwaD7mVRQc5Ha20wPpc1Q+hF8vamm8ZbUN/v+AVnyOoVaZG4LCuagN+Y05YP3oluo9ecm0DZjOmVBClXXlmUkasyG9OzmIGQ5hgLlsznXv3Pp8xFXAedpookZDbLJ0hisNpJXg9Xfrl7tQpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zIGvBhZjqpu5nu71pkpigAddlmNq3HpuObMfFAR4Q4=;
 b=OHbaxEm0P+5nUbEG7dAfJS+WL0yJGil8LZbrwK5bY0An16mTKHd03jAn2eBFP8KONgo2PCd5xQT2yKI9LWm8oE26ROXH3aOHdi8TfZmnoJMVhn6M43FOKJfGLOrVEuISUIkvZ1ZwzNnr4oiCKe3R/QliiupNONhmN7H9jZDaef0=
Received: from BN9PR03CA0645.namprd03.prod.outlook.com (2603:10b6:408:13b::20)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 11:40:06 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::1) by BN9PR03CA0645.outlook.office365.com
 (2603:10b6:408:13b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 11:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 11:40:05 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 06:40:01 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.co>
Subject: [PATCH v3 7/7] drm/amd/pm: Add board voltage node to hwmon
Date: Thu, 24 Apr 2025 19:39:30 +0800
Message-ID: <20250424113930.464303-7-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250424113930.464303-1-asad.kamal@amd.com>
References: <20250424113930.464303-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: fa462504-1acf-466c-1545-08dd8324c23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BjTv8SVHAkzBW23/dQ9pwGO+uFFXQSQF/KTGDhBGhtNlwCOPQkTYQdrNZICq?=
 =?us-ascii?Q?AOiDoPy6MNh6Nxo34sUFRzddoIVmqNrx7WE22V6U+gipnXMnqZcIFSfe6bln?=
 =?us-ascii?Q?Q1hLAIrBK+DPTxpi/O7Z+awdT8XzBXHU45t/9sHZPRA2KvEK5l3MBvDpFRdc?=
 =?us-ascii?Q?hsceUW/0T0Id26DiENA12a2MVXRR2ZI3/wJzc217DL1fUhOJ/w74sNLHnJOY?=
 =?us-ascii?Q?HlPD8ZI5ESqWNKZo3fPTdYCSbDX/mfYOd0EfKVX/Ki9cAl4kUiJ5JnwGZHj5?=
 =?us-ascii?Q?t5BLp+y38Q5DlIuKgbgndnQLZXMZqXvQiE1fQd8Hd007Mbi1YiswCPr9KZ3d?=
 =?us-ascii?Q?mYABbG2WxA8Vlfagv5yxvSM/INTzwW6Mq++NnGDJo6WxfJjCpGFLaa9gfLEh?=
 =?us-ascii?Q?1JuJG9nJdiID6k13eK8A3zXXGzCkFXWPanLsa4zYheigMajODD4PsNln+GiA?=
 =?us-ascii?Q?OBTVYEg1DXbPfCJnA4WYjdNI7sXyj5E4DKuBsGpl1SoDSIHYeABAK6kKb5X5?=
 =?us-ascii?Q?XjqCkKQJIf58E+qwK8TWtApCk3GyjdjiV36LTtk2W7jl7ApAQcU4q69WEs4o?=
 =?us-ascii?Q?ij66HJ8RdBnhkvXUftNFCWRma3bJn+Oczz7Z+syqO8GBtKXrTLFQyFYuFveE?=
 =?us-ascii?Q?LtTbqGDv8j4Ne+1A48dqVp98/425Ra1zsS1P4Vc/saBiPsln7BYrhCJeBKoU?=
 =?us-ascii?Q?khQazZwc4CAOvPElLtZvyqOQ/52fWs11I8tFIe2aVaxmnCBGUqhBJyvlUnSu?=
 =?us-ascii?Q?qHknykPMMMnob71/PyqOL+uUwUP5y+Ogp4zPFUYQgUagQcPiRtPNv+bi7B7k?=
 =?us-ascii?Q?NW2yvJd0JnyLNH2+/namQi2tbTN5sPQawvt8plGsny5H4WsfkIuYpJPed0ha?=
 =?us-ascii?Q?cbSaAbHLvsz7kl+4PlOPvMEoWvRTWNngLKkwgi0qskzd72BmpuNKUkwyNQUJ?=
 =?us-ascii?Q?lJxIYMpJkz48eRWe3J/g2B8iK2uWdog7+/hjsiTTMWqTxNLxPs852oBsY4QQ?=
 =?us-ascii?Q?rhW2TwfcTdqMorCMLsmefOqu2JZOxvqvbhWyeRpL7IXMW+mDuuimYuhZcVN2?=
 =?us-ascii?Q?wuXzeEuOJWzmFenNZ5viXMrVU0FB7T1mRGhX4U4dSWiEPlJrF69yP/BG4LrC?=
 =?us-ascii?Q?evjziTRr4nCXCmDxnCIpsRJk72sxnqw1lydsbCxOYD+eLEwtOZkv5gT2oa9b?=
 =?us-ascii?Q?vSBGcXgdIME2U/pR9oin5XXA0Hh/FZIH24hr9umZnVZEWNgBQITVsU7NfQJT?=
 =?us-ascii?Q?HpJ34LT3kiGbQND6ZPQKItJBbcM7xnaEtMxScPug9SO5tw4+pWcyf05WYTT9?=
 =?us-ascii?Q?K99gxzH8gKoDJFMYO3lI252Xd32EJQjelclt8sp2IB2CYsPja/Wo+1ZlZPbJ?=
 =?us-ascii?Q?mGInWU4fUESKHaNQxMMsuK51pRmbP4WDxKPieuBVxpkV9VJLGTyHVWcC7+CO?=
 =?us-ascii?Q?wChn4lCbfPpiE9r13UepHfif+unAvoldP0vIqcpOor9BpTV4w82GTS5jPugn?=
 =?us-ascii?Q?74uOchQB8C8Eox82bM9LGfXnxBO88YBprj0b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:40:05.6752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa462504-1acf-466c-1545-08dd8324c23b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add and expose board voltage node as vddboard to hwmon for smu_v13_0_6

v2: Replace ip check with supported sensor attribute(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 34 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 10 ++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 21dc956b5f35..0f7542d7074b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -128,6 +128,7 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_CPU_CLK,
 	AMDGPU_PP_SENSOR_VDDNB,
 	AMDGPU_PP_SENSOR_VDDGFX,
+	AMDGPU_PP_SENSOR_VDDBOARD,
 	AMDGPU_PP_SENSOR_UVD_VCLK,
 	AMDGPU_PP_SENSOR_UVD_DCLK,
 	AMDGPU_PP_SENSOR_VCE_ECCLK,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 922def51685b..5537dcf23b5c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2944,6 +2944,23 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 	return sysfs_emit(buf, "%d\n", vddgfx);
 }
 
+static ssize_t amdgpu_hwmon_show_vddboard(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	u32 vddboard;
+	int r;
+
+	/* get the voltage */
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDBOARD,
+					    (void *)&vddboard);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%d\n", vddboard);
+}
+
 static ssize_t amdgpu_hwmon_show_vddgfx_label(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
@@ -2951,6 +2968,12 @@ static ssize_t amdgpu_hwmon_show_vddgfx_label(struct device *dev,
 	return sysfs_emit(buf, "vddgfx\n");
 }
 
+static ssize_t amdgpu_hwmon_show_vddboard_label(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	return sysfs_emit(buf, "vddboard\n");
+}
 static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -3294,6 +3317,8 @@ static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, amdgpu_hwmon_show_vddgfx, NULL, 0)
 static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, amdgpu_hwmon_show_vddgfx_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, amdgpu_hwmon_show_vddnb, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, amdgpu_hwmon_show_vddnb_label, NULL, 0);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, amdgpu_hwmon_show_vddboard, NULL, 0);
+static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, amdgpu_hwmon_show_vddboard_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, amdgpu_hwmon_show_power_input, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 0);
@@ -3341,6 +3366,8 @@ static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_in0_label.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_label.dev_attr.attr,
 	&sensor_dev_attr_power1_average.dev_attr.attr,
 	&sensor_dev_attr_power1_input.dev_attr.attr,
 	&sensor_dev_attr_power1_cap_max.dev_attr.attr,
@@ -3492,6 +3519,13 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	     attr == &sensor_dev_attr_in1_label.dev_attr.attr))
 		return 0;
 
+	/* only few boards support vddboard */
+	if ((attr == &sensor_dev_attr_in2_input.dev_attr.attr ||
+	     attr == &sensor_dev_attr_in2_label.dev_attr.attr) &&
+	     amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDBOARD,
+					     (void *)&tmp) == -EOPNOTSUPP)
+		return 0;
+
 	/* no mclk on APUs other than gc 9,4,3*/
 	if (((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(9, 4, 3))) &&
 	    (attr == &sensor_dev_attr_freq2_input.dev_attr.attr ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f8e06913cd72..b6e5da7b06ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1652,6 +1652,7 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor, void *data,
 				   uint32_t *size)
 {
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	int ret = 0;
 
 	if (amdgpu_ras_intr_triggered())
@@ -1696,6 +1697,15 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 		ret = smu_v13_0_get_gfx_vdd(smu, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VDDBOARD:
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(BOARD_VOLTAGE))) {
+			*(uint32_t *)data = dpm_context->board_volt;
+			*size = 4;
+			break;
+		} else {
+			ret = -EOPNOTSUPP;
+			break;
+		}
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 	default:
 		ret = -EOPNOTSUPP;
-- 
2.46.0

