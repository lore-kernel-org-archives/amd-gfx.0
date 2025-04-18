Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7CCC369D1
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0120010EBA9;
	Fri, 18 Apr 2025 14:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pRNEEN1L";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AF810EBA9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qs70QVYkdNlDuV97HDLVDppTOBEiZ8FBiwOU1M8e/wF5VTGEWGlIG6zH8F3E/MdJ5dfVqtQKAlHNgQAOJb3vv8BdW8EtxosfoPIYBFwUFI4JPpmzFHm4QCpRlSqg8bZBcVBMJCsS9RzveZPjWLFNvUxb4lqQ9UH0+Pg0vyv4yTOXt2WyFKKc5Hv/zAJX77EVpNkWoxHFM73uMRLEk+qnKD86ORZHPLmXeANdOF8PnxqKzMv/7FW0Cr4wexBXqATIn9s2RiTyxyNsPeO2QiPgJElie8gvEhoEwSFCofN+19xN4bMRAAokCFXP/pyxf87aC0ZEcOMo1HB0Vqbe3/yMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3o1ROZZqBX9eBHHhwJ51gurkrXy26e7GNIIUjJRam8=;
 b=UsbHU/lj4YBWBTu0r3QOAgSHnhPK3jbl/ISi/KJnNQEJwTY8tl+1eMC9P88ak32vqE+UwoLpr5BQhJCVCAbdYx5WiMV8PzWJr6rDC3P32HTkP4yBfL4J/0Gi8JIksVS5FAbdpTBmKWOQWfJr4gi+CpOG1ReJ+DU5yl71ui4PwOBHnY9Y40J8Myc2VfLo8SElN3hPA2NWbIf6EMVj+/61e3MFNH6jOya3eoQMCQsSoTb1pk8is262qsdF2JZVbIxJlkBcG5vuqq47t7swHVZL+QFjQ9tQ7EFlHtokVsyVHO9AtYa+LTPVZ5Nn6OrpLcp80v0bowiFD8FeqX5grZ/h9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3o1ROZZqBX9eBHHhwJ51gurkrXy26e7GNIIUjJRam8=;
 b=pRNEEN1L0f0F0iYvBAEP1VgFYCzxR/WIamFNMhsEtjKio+AYqVgf/whaoMn32Sz0H1Ig9xG2hDvnCkvfR7cJpcWmx+AhnyOqUAlwQcHf/lDoQpT7c+jmf6F5pXTGgIuglM28AXMUK9zLWBP07gPkOfk5cXZXSPX6x9OU3DO5GzY=
Received: from BYAPR11CA0102.namprd11.prod.outlook.com (2603:10b6:a03:f4::43)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Fri, 18 Apr
 2025 14:07:02 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::ee) by BYAPR11CA0102.outlook.office365.com
 (2603:10b6:a03:f4::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Fri,
 18 Apr 2025 14:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 14:07:01 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 09:06:58 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v3 7/7] drm/amd/pm: Add board voltage node to hwmon
Date: Fri, 18 Apr 2025 22:06:33 +0800
Message-ID: <20250418140633.420887-7-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250418140633.420887-1-asad.kamal@amd.com>
References: <20250418140633.420887-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b81031-986a-4189-77fa-08dd7e824a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kvwSIPMAdZ0TJ3zAz4aNdkVyax56HhzG6IvDlkGfEDjBrZZDJ6lW528aQ2kA?=
 =?us-ascii?Q?HHlnEYPQhQb5JhKBhdmQdyvf+eCfvOoN96SFloLnA02T9sq1bhN3jFei89WE?=
 =?us-ascii?Q?GSeCFM6eZB8mY8XsZ1N0CEjrABXMIjtAscFFivQJrGYCQpyECsjub5NTH7ug?=
 =?us-ascii?Q?5hxGP3G4w/nZftbfujqYbNeAF/Bs/6jU/nZ/zjXIVAbi/a2UAtQn9T0VtzgX?=
 =?us-ascii?Q?QBymKua+Yn47QCalJEdEkS6PYWKdva01qfojPECMcK4gHjWXXIxS1oPLxmNL?=
 =?us-ascii?Q?IoUCJO2Hva7EQ8WMJ46IupAa9fbYXCcU7SJHKDzuKXhZWgCEcfhHv4Qz9ilh?=
 =?us-ascii?Q?RauClB2wWGn1GhVu8IVGriXT4Tcm5ZnDHrqaJWihDLzM1cTfSsUL1pd04QJG?=
 =?us-ascii?Q?/pR7UB6pwrR+6ue55U5uOfadW/+MoU2e4qqLZYYnOCA7635nInXYFRCnoW/+?=
 =?us-ascii?Q?odCr1JtQM7dHAr/x3ijSRPRgJ66D/aF4uAHVLfgTRDWsdDxFSsHVep9CSS+u?=
 =?us-ascii?Q?7f4lfPUN8giwfNor96e81s/Laxrzx3FZe6ysEU2db2w7w7WfCpxhbSjIuo7T?=
 =?us-ascii?Q?X+EU420MhZkTPvdmFe0Dewcjf0EvKiQHt0+vRm8XXgJ/+QK2M7XIYv3ueNx4?=
 =?us-ascii?Q?JUlmyaomNifr+v2cPxZiQRfR7s7+8uvjQgH0RWYDAQnPvFhD0dJQ1aNAjFF9?=
 =?us-ascii?Q?/4x6rMDKZiPwUvhGkT1MaKo3cVpFfPgsy3vHFoZxbnohDIEnq9yTXGV4CL22?=
 =?us-ascii?Q?3JwTQXRUN3v4NNrrjunrTLeRnPVbXLOggOcqJZmTSz24hzSlJCijSReuUNIL?=
 =?us-ascii?Q?PO6BGYTc1pYGkL5zxvXe23offztNuxMqqBoovseVrKoNZ1fpUUdEtpCUorLR?=
 =?us-ascii?Q?TESwAP6TJPGTHyZID+xsNWIsw/NlI0NRZWTnVHBnkg0CaGX47eqa3+hxeAW8?=
 =?us-ascii?Q?8wf2Ta6/NOQy7Mxv6CASR0rqMGvEtU5DXz3jeLyCASDj/zmWtiK6JIVpJTYG?=
 =?us-ascii?Q?U3XtG0PgpkKGRFLX6EtCqsBrSVcN0ITKgaz+QbSh6lvhVXBvL8xCeVjO5p62?=
 =?us-ascii?Q?CAtu2okicuf0+NIxJIPsg9MZ2OBkXP+IdliPgrDZ1GXw2ii/f7VgRaxzbacX?=
 =?us-ascii?Q?GTT/gv3WRmszrFCXnpK23GFyHc1272qp6Hn6i4sZrBC0W0KW8NJ0G++1Cfdq?=
 =?us-ascii?Q?hfqL+jEWNenaY2C/c67wlE5iNumj4J0WAUS5bvLCC7oHmZHOCYcbMJsuhKoz?=
 =?us-ascii?Q?3CGgleVazwYW0qsMwzTy5a05znQhCQGJMrB4genStU012baX9GkJT111SPaL?=
 =?us-ascii?Q?49Q2VXC6ynHiOjuuMifSofNCAxsz3/+E4AQfhuSqZCq0paz9ZDfu1J/3CZmV?=
 =?us-ascii?Q?LQ48YetBMCoTTChI88Ja44/bIHv/gGtdNQC0ytDxuoAIx2FsPHH0kHb/CUpE?=
 =?us-ascii?Q?7CVhht3FVrKpCmmz/rZutaCGxENce7tmGrF4c18SNKwIRKvullxWWhPOB/tw?=
 =?us-ascii?Q?+peL86KKJO+QqbvGYz0fhS0htpyO84pnJLhQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:07:01.3191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b81031-986a-4189-77fa-08dd7e824a55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80
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
index 91b1c2af340b..c4635358cad2 100644
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

