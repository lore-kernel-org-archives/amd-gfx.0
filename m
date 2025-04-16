Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA1EC369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 05:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D1810E82B;
	Wed, 16 Apr 2025 05:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yf8xjJfF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80B910E82B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pq5Gvr/kKKpBb17lTOKDs/0T5bJPsRoMi7mGYGgaLlUK3goyqi5ADwRK2mSNgpJascKLUNblGffUYnKa0gP2mOBXoplqGZ5UgtVY5/Sg1C5BLT36PybJnsDmCx+sESWYhIXM+pN8AOVA7F3BEhzvyK7Nez4rJxwgZKSHxoAjFvCBXelgsuDgUTs0Fo7aeDRQX8V0VoaELrnYsf1LYu7P7iHn4iQFh1dgQJHQ/TEHfrj1pYMB/z+GNqyBea5pFzYSoc10l7oBD3U6kD+PvXyB4xWR/nSqrKNN+4+GOQchNpp6a0RzWYyd/8zi9s/17lUHdjrVn6WbTCYgsI6lL0YPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPeZbnFqg1ru8Gxl9dALO+rk6K+L/8VaBiB8SGuJYzY=;
 b=hkW2d0rzLndLAR5zSiL6e0PQYxNdCk7Knjjp+Afb4n1DNO04wpPAkbek7q0/UO78RFZ+MPL6zHnFOzqA2+KIYITd2Y9OQwGtTXT8X/c4WLJyyQ1xBEL8HCrf8zdf/C+gIbWIL3bb5mfw6YqeiwfbaBsr8dwUooCQ9N5IZ+HuWMHGcY24ZmSxNm12OTCwQ+1+qeaoa99LPofXDkR9fKH+Aqh/qEJKkYG+fLsfV7kknXfIV8OKFxrjrYHUsOMxEH+EN3RcdWo7tEY2CsKnFu1dKLX38tA35mAWd18AZyC6L71w1PBthyRyTP1/ir617KYFfFN+gGfF3/H7ZOqtL/G+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPeZbnFqg1ru8Gxl9dALO+rk6K+L/8VaBiB8SGuJYzY=;
 b=yf8xjJfFoz7FdyNH8K3NhEfpcoCSybsGPKPkIoXdpZjk2F0ybcAO8u8Yr5Eot1KUgQ78uZiMuORunad5k5UqHqBVo/4qKBn4DfJrjC/c6ihQR/C81KZhV5/D0+Xm7oEeojqd+gUi+AkFnV8dXXKVnZunVh0cn3MXBUOlQ1GsDRA=
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 05:31:58 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::30) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.10 via Frontend Transport; Wed,
 16 Apr 2025 05:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 05:31:57 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 00:31:54 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 7/7] drm/amd/pm: Add board voltage node to hwmon
Date: Wed, 16 Apr 2025 13:31:27 +0800
Message-ID: <20250416053127.377955-7-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250416053127.377955-1-asad.kamal@amd.com>
References: <20250416053127.377955-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 215a65a1-051a-4eb9-cc81-08dd7ca8016f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T8Hdwr8FLQiVcStTUUlm23ITIl3pK/lKWD69wth6q/5MvXgsjpPKUCOSS2z8?=
 =?us-ascii?Q?OTPT8ej0BfVlK71qPEmcEY/h74BIdVTPncBVPb8avFPjf2HHtNmbf/WX/yUD?=
 =?us-ascii?Q?s+QfoBf727Legwio4C1bA5scsbH8/IKeame7RtQNAQaLfax4DodupSIlzeaE?=
 =?us-ascii?Q?mjZi8DvQsR54JPRYIgqkgnIUBBoCa6EetHJ//nsX7lm9sKhnGPZeGVmkP5KV?=
 =?us-ascii?Q?4b3lCYtF9/F/3UWSzboDYW7uXLuC0vMJB+YUxAZl70VFpU17h8JlFQrPXkWK?=
 =?us-ascii?Q?y4ppmmUate2mhxRmKQIvnwl7RjMH3BPHVJ0JbdH8FTcTWRYCDAgY4yHLUos6?=
 =?us-ascii?Q?/1z0gLgzwnU+3leuK54x75LLWpd3FclrEOW1GrQpJAuXCgaUBNe3qMo2V8Ms?=
 =?us-ascii?Q?mzCbRRhG32K3ifXSnq8l7kizaTQPcD6UcoYi84TqL2C2/5CSvj5r6g+d6Df+?=
 =?us-ascii?Q?ZsfTFZ+DAOAzU1lIUqFbbC8L8zhXJqwwrZiBaQy2qKzY+dds4wNaa/LpovCs?=
 =?us-ascii?Q?zY93Y4HnpU58GD0MXBJm1MTtiyphDQXNw/DfSQRcZsQw4C48rLLixmFRWfzz?=
 =?us-ascii?Q?5P+UJP3wnc6P0RPPClHT+Ce1AJQuPXONqkhpZpnZ2g2ji1eegF+3hXPVaDfk?=
 =?us-ascii?Q?eZreKS3D4sdbNjkH9vKJEUsRXXVL1KIo6pN4vW86TFlPUS446NFmiqFn28Mx?=
 =?us-ascii?Q?ttBfaLZhyp+mFFsdLAYpGhIolsL+eIaWUnZVHirsLUAnasyXsed2I2y/8AkE?=
 =?us-ascii?Q?RFXh9LT1Y2vnnUlqxgpP34Y+PicmseWDFv1wDvXN73KEwLn+AmoFKHZOmyoB?=
 =?us-ascii?Q?T5Bu0FtlxzoVO/oUjiuvhPUxTctQ6uaUa/ws/k46ps0D2nSbdmaYySnduZlg?=
 =?us-ascii?Q?xURhuk/YB0qPQGRoEkl2PpwgAgVsBpRhRtASo+WCLgPKBIGhCYGJKPUp9Y/N?=
 =?us-ascii?Q?VPcMlaEKmxVBNiu4RGRBfZ1U8Bc8H5Ur00/s7DsSfgXDvEcEEMW29dxxc1JG?=
 =?us-ascii?Q?MsIGnMExJ1ZqWyKi+/oNDlfbwTjzpBxem0iuVeNORovLzw5oJjvzmegUPX8Q?=
 =?us-ascii?Q?bh1bT/ZUW8kvTaSIxoxIl1orkAcOnS2t5r1Er1EBhzpseMPYDT3U4J13gvDg?=
 =?us-ascii?Q?oZAWXqBPLgc9MyVmFywRVYFknhT+LTT/+ZNscvV5HwyE4aT9dh9tQ6Y8iO1j?=
 =?us-ascii?Q?QbNGxhcsTYkAu2Qc81KhcjqBw9uXBU8H/VIefKeVpyWYIf+FvMg40u2wxMo/?=
 =?us-ascii?Q?V0Et/7gA/fwt+0YR9ADbmg1r3ZPS0RG67xvwySImsEzveXyCw0g9nsoVquQ7?=
 =?us-ascii?Q?iNFRbgcPWNc7nPKTz0rRDQgnq7O+Aoqdabhg1RMrRHJ9+YB10WSF+Onzk3gI?=
 =?us-ascii?Q?EdGVr1hqABcRB0BVgMTNgIX/1OHtxz4OE+GJ81OpXmN6NnEaESemyBqiie0K?=
 =?us-ascii?Q?wR7J2L53bzYOR0e67+DKrtdy97OzUcT0tb2+szci7DAO2jt63+ntR9GsuAqF?=
 =?us-ascii?Q?8K8CgkR+9JEMAwIUb1NQtXRiGNl68834VOWt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 05:31:57.5526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 215a65a1-051a-4eb9-cc81-08dd7ca8016f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
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
index 4df35bc1a902..9d993338752d 100644
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

