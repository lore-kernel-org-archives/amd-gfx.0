Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6C6C369B4
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63BE10E7AE;
	Tue, 15 Apr 2025 14:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GoLO98vn";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE0B110E7AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+AFgLoPhsZe8JXezGhB1JH3SrHdNmkJ0jjXK72UBY7dyGLzFZntjjZNbi0dmqkcQsVJtoyhQ4ibKS0ZCrLVpx4oyCLBABxPHaAXkS9rlAQnVCi3DJPbttcX/m3S7FHsy22YEBRhrQ717bg+Ga2220ll9tokIcHAdIFrSrbXInKJbKIb5q86elOwicDzVrsB9Q2N0BAbAsrZT2Ta440wARmX7L26i+jZzkrvpfTuqXGxWO0FvYEN9K62vK4YX0LXCwIAO6TRLyAzqHiqsSU6W09nwMKF//EoQphdsQJCxkeFxEW1i4KlqlUcjf8uvlUPeCplKBSRqMx04WyeAwjSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jeEg490FOKZR4J65vROAlc7f71b6NRv8I8qo4s4q+0=;
 b=jIKzKRZxyRYa7vdHkFClKDvNBI4iQ8pc5Vd326ud3qX9SjGEcMqQZ8TxorOWbvaBWNhNOo0CajC7qO59fKXjoetuZPkV50hzAYTfv3gD0NJh+AHCi9ap6NHXpsbSJ4JhA4Bh4ICAu4GLMwHHzcTVpk1w6iILUR0ZzQGqPkh3J2piHE6ruHtkfVA7ZKTi1/JrecxhJfv3Ocbbe9PxHusSB7Vx140vmIxT6M6dsHVGnSseFNMuewGlmYhbBDzw5f4w3/S1UxySxm423yUTgjpSftVQ8Wf0wG9wQk8EndEHdye40L2WS1BGmdy5igawERhlZsKd4eUjx9ZBLVqXgL2xtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jeEg490FOKZR4J65vROAlc7f71b6NRv8I8qo4s4q+0=;
 b=GoLO98vnNgONFQU/xMa2dqGBXUzK7SooSqQQz1gycA6S0mVPRPZYmYmiJ02TNacAxbuJf0T7fID3NpWtodQo2JmRdNiGr3TJPp5DpINSN2UWsUvUe6eUbLcAfsvO/nEeM/qPRZ4AQ33LEsY7xEzkLMhQl1vAl0x0gO/b0cEAc8M=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Tue, 15 Apr
 2025 14:35:56 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::e6) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:35:56 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:35:53 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amd/pm: Add board voltage node to hwmon
Date: Tue, 15 Apr 2025 22:35:21 +0800
Message-ID: <20250415143521.367895-7-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250415143521.367895-1-asad.kamal@amd.com>
References: <20250415143521.367895-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 3185816d-d1c8-4e04-b9af-08dd7c2ad540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+HjyD4Ke4Pi/1kvWaZCX8Z0K6q/FlhKyKcmudhNgQb/nunGrqj+olrD3WTu/?=
 =?us-ascii?Q?nHwsa6y+Nn5UYsMSp/zct38tV310hJSYqnUK+y3PQb0UUWGkSeVDzZoCDP+P?=
 =?us-ascii?Q?IpE/n5n5z3Y8IIHjGxm2Qm6bIa1ZLLTQ7mZ7QO4EXkA4CUujOIz9KpZ+3UBl?=
 =?us-ascii?Q?nqg7FrromHX3RBMr0MHVlG1rdI9ITM+Q76hNSqw7P56NZKV6EN7PfMXVqJ5c?=
 =?us-ascii?Q?Nehdb82g3UxkRfI1MtCI1l0FifSkCt30c0deibhp/uZCPZDuXOctBXSESU45?=
 =?us-ascii?Q?icUsOrlI4nmixx3l6e/B93pmmee6+6XzBwvq2SSZYDds5DNZyNUkx/nj+1ZT?=
 =?us-ascii?Q?46Ffpl4U3xkOZAjaR+KbnIl9XnpO4HfUrWNCZM2/7H0gYBUnFNXOnk32PQ7F?=
 =?us-ascii?Q?kSz3GRhf9z01mvOaf6QUNfK3bM8rk5MByp9gvRZho777QIAliFyxN9/n8mlo?=
 =?us-ascii?Q?dCB5mzR9Bcx4C9uE5ilvRj9X/Gyfa6MbGyNn6M0l+7dc+7v3ywYMhadgcACX?=
 =?us-ascii?Q?K1xLH+lJhIoKsMqP4GDyNB3Rn2ITVaoLqYkqsrCPms8QfEgJOhrMhdFx3wSO?=
 =?us-ascii?Q?yE/VzNbT340lc3ohJ5ZvVtBKQ/9qVvHkqdaTw5Ope2eNbFuFseWDUKb3tTOo?=
 =?us-ascii?Q?ty29idyQSmcTSs9a7a7XhV2yGy+1sx8qWrRRV2ancJJAb/6Ta/s1oqmya8mX?=
 =?us-ascii?Q?M5Y+9v3xZWZ4JtQAkLEuOI9zbdHt+u4QlkFZZHg3mvXg4lQZfeJKqv9gJUcV?=
 =?us-ascii?Q?JqG0C8gYULscZEAYEafqgT3F2p45DGIVYRmZ9NPrjZDzkz44IkZ/jqfqVJRA?=
 =?us-ascii?Q?mauhwrYsaFowFtDOs0I1Dw1uU110Z1+6ZmCrZJhVDx2rjpA+dFsh96Ze5REs?=
 =?us-ascii?Q?AnQynGVEhlc7J+vIitNXHf8AIMZ1su1Wk2tovmUDeqU3l2Um30+7msgxCisP?=
 =?us-ascii?Q?agWfM7EHhCHY43+riDIq3mMtDMDo/RWM0vUgbhErioOPuYQfgH/uAiYqNzqr?=
 =?us-ascii?Q?qRbGUHOWgKSpwf5YQYCfV8zpibF/q6xTDb787u+AqrMnnI8HVxdHvVaK6jGy?=
 =?us-ascii?Q?y3MFR4ibjZjuivkcCIx2kWOtOpQALP0cfEz0ZZg345e0kUQc6BCbDDm+HdgZ?=
 =?us-ascii?Q?P86aTTwTi4fwbAr958vdgeQw/s2fD3Auyw20NHwOMWTh2gmbQ9mSQhgRfsHS?=
 =?us-ascii?Q?aBbn2zoi/2UU0m/6DHoukPUHu35kwF3fhnt0h/j66sce6uNZx39J954cqMTO?=
 =?us-ascii?Q?RA5Wbn01diOfWBQE1IIOr9HltVfwTK8+AeZEX61/NHhXBzSW3Zmf3e9EGiCX?=
 =?us-ascii?Q?NfNEAhwR1SxLSuDrNDFZ6vBHFDewJU9M3moi5WYpjVafwyvkM592e0w7A7R+?=
 =?us-ascii?Q?BnJzXX8tnO84CYbOYGrGYsTlmhLGCRzAd8+l9XsgtPP133sPGOHV8aLpAa7J?=
 =?us-ascii?Q?e9GA5ExtONe+zBSYTpg4OnsnkojUNEDzxAyZDg0Zvm+GJcCLMQ5F4vPkVBGd?=
 =?us-ascii?Q?wywg9FPy3wmpBTGD1tuFzxmEci5HfHhWDetv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:35:56.3331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3185816d-d1c8-4e04-b9af-08dd7c2ad540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
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
index 8c4672c3a028..4ff90cd46824 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1656,6 +1656,7 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor, void *data,
 				   uint32_t *size)
 {
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	int ret = 0;
 
 	if (amdgpu_ras_intr_triggered())
@@ -1700,6 +1701,15 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
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

