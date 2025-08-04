Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6EFC87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAD110E21A;
	Mon,  4 Aug 2025 14:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="25vwKVeA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1528B10E523
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKEVvopLDlqXs5BPyo4Joj8zfg6XvMLVImre/fEAxDm9IpmCF2bKJzlpxvikXm4Epyf0VUYRMXdyo1ij9abxM8j4lGps6ajIkfMjoeWJm9FmJD07orL7Z8PL+KnRfUS9ODodHIiMN6h+Yphuv3sMk5zAYgiKzThG2yN27QMhtnyk6lPrhRXh/RGX/xZ0Z/zPJUhMey4NpVplOrXhy0CBbH02+Djn1bboMo5v/b3vdwUrRgBeUZ2ZfkeNgJJhdYGfEJHBpkZsEX8/3fvfEdR+M7Hk/XR2BTpummzGeQK5nhkF4Jard4c7/mvnt8T4h9CuEwOfA57vOGr+/7nmWUSyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5aDwgFYYZjP2v1ALjKe/WR6ijD+xHWkdba3touuhOE=;
 b=uVXNXlSoKLqfVf4IXlLawUy/yq1LdR2GBZdj7TeybydRhPMDZ8ZqvdBXYI/YhSXfNe2L7UZckC/f3aSQcPjA1Eqh6I7TcuMbUOy3Z9/voCKXzps6uYuG7DXRSiOV1WL0l34uGBVabI5De7EON4nvnoWNvgEUe1KMvSKJFTl58qjowSqiTKdl9G33TIuIWtbHzBS/SGbXO7OKz/H3jMrl0NWyr30WaNllRY2x8b0y/b7oem0tpg1GEVOM3VwCodqpzgJdGsTOLqlvEjCzABYDHZILmOBQ70SlG3I+4OpcuGW6pGf3D+V8XvdCzvttq/UBsXBOzi0EkXk7g94WY6MOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5aDwgFYYZjP2v1ALjKe/WR6ijD+xHWkdba3touuhOE=;
 b=25vwKVeAxZVmeKksCyqTz6O5/b1i/s64/5TbEusGw8jkcubB8D7HxyN8CDx606090LCMiFXe2LlHfelZZB1u/5PHVEJ8mg2AwFym7PoNAE9MQP+lkOuoSSrV5MDa4ZfUp7JEyCASHLTIZA/3nEjz5BmcePuAaoA0BuigLAG7x6Q=
Received: from BN8PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:94::35)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 14:18:21 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::c9) by BN8PR03CA0022.outlook.office365.com
 (2603:10b6:408:94::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 14:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 14:18:21 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 09:18:18 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v3 5/6] drm/amd/pm: Add temperature metrics sysfs entry
Date: Mon, 4 Aug 2025 22:17:56 +0800
Message-ID: <20250804141757.643501-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804141757.643501-1-asad.kamal@amd.com>
References: <20250804141757.643501-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcb80cd-9d43-4b38-6c7a-08ddd361c444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?45Z9sKOhI/0d8dZ0Q8JP37TybxNAyv4E6MYK4/5j4D55AxhKkfZo57J+XVrQ?=
 =?us-ascii?Q?RSZTxSrsFYA26hVuTOwRydsQqDRZoX5FmqC4UjKbbTguOkYJYKzC3zOZp4uF?=
 =?us-ascii?Q?oi1M3ZDpOUQK3fpeTZKW34LMrET/591RZF+ki4yAbg/33WwCiJu71dBrt2dM?=
 =?us-ascii?Q?tVznfKp8nJ0/XK60Txo4TW52kOQQAMYuGsfP+/KkEeRO5GKde88tsQtXanEr?=
 =?us-ascii?Q?E14S/LB6/w5DaRRuR0yOyko32t0XkQm2v0QUjoAu0oHWs8quVgReUE3UiV1K?=
 =?us-ascii?Q?7ALRoNs2Q3pNaJchtanbXFlRVj0a0JNECKgsbnDs409SBaKdNuBh/Oi21qDv?=
 =?us-ascii?Q?y58M97QwpXu+62T3zRPbxKFReutwXTrpnQJ/vfMWlUW6y2qSPEDNvuXISGYp?=
 =?us-ascii?Q?u+YNPrQd+MLwDrZ/a6jDd9JJ2WJXwB/qSGrt/p6LuX3TC1OmWhCDICZlNEy2?=
 =?us-ascii?Q?uMrdgptEPzrk1yJYjJArSoc1ysot9hIPQcUZTbsvhCEgKJp4N8O8vFE+lORb?=
 =?us-ascii?Q?5jOpqmiwvx4WARbyieq4JSo/BrWCk41Hl5RRqdQ585xD4FzEnSC/DDVusJlG?=
 =?us-ascii?Q?mITJqGjWKxt4Fpci1Ow8Bh4M1HsDAJ07iihySlqFhlmEsk3Gg7bVI05bo55G?=
 =?us-ascii?Q?c6LZHClhFD/dCU9e/j/4/OeHw88arWvQtftfAXhaZsaLQO2DmUFA8pykgnf4?=
 =?us-ascii?Q?XReiz74V2OwRcP4MFtdSbGdKmcIJkHg0Cuw8VwtoHaJZTZdaEva3aW/cyVXn?=
 =?us-ascii?Q?QqcJSBHTdT9jLKNGinMwJ31fWJ0sgdUGKdhR28wY6uEdCpZTCzrg3ORGMsYl?=
 =?us-ascii?Q?O8XSEO1/mrl0dWQOf+0PGvY+qSAjrClqYLKUXgybwLG9aZ/e/I0nIKbes/hs?=
 =?us-ascii?Q?qDvYrS/mY7cnYCZcWa6CDzV8CnVhGc6dVG2Ftiw/C4yUgktD5zHvkrVBC3ln?=
 =?us-ascii?Q?Ws48BcPo0CZvF23YUxdn/bMFfwOq+befggLxnBLPa60RnGVerBoL/GWPbwKm?=
 =?us-ascii?Q?LW4aB+2e/WvP/oSXtIEepR+UnXu9An+JqTvSHmKX7k/3XKXk1DCK0e0ih57z?=
 =?us-ascii?Q?p+YsfQEISjdeg1GO0Ea0nom4mNSHpFSdB/YcBONL5S+3WyDpUnxt3MwJe2Vj?=
 =?us-ascii?Q?4/YEP4VdlS4AqbBuhEXIuJsjc3XletbFg+aDv1KYOrsZmINLLc2wc5AFalY2?=
 =?us-ascii?Q?N7aa8GjOXxKRgq639gumI7c3C5Zqy1fI5TD6aOvnM8fAxW0pc+4KxgfhbRXm?=
 =?us-ascii?Q?72i2v5369WOof+N/RqledO/Ns4JtgaiP8D+talY4UpDpDukfHSzAWFYLbFmN?=
 =?us-ascii?Q?F1Ey5jC8lTiCKCVdHu9OXQlMUekhDHcYYKC7rtX73BCChez7+tD9+yuvdymF?=
 =?us-ascii?Q?4wpDQx6Pm0/eCWq9v8wtUDC0DTydMH98xwcmh2azgXPqcgV+Q0fvK/l2OBx8?=
 =?us-ascii?Q?QCCHwDl9Pg69AdLubfl8F1V0oMb4x9BcBpK7L6ia3x9T1wmfWPuePnoyNi7/?=
 =?us-ascii?Q?X94sLNivxlp6d6dYKlRMChXzzhRZWScU/dvu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:18:21.4120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcb80cd-9d43-4b38-6c7a-08ddd361c444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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

Add temperature metrics sysfs entry to expose gpuboard/baseboard
temperature metrics

v2: Removed unused function, rename functions(Lijo)

v3: Remove unnecessary initialization

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 135 +++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8d934a365c3b..b94cdfd9e6ae 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2080,6 +2080,134 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 	return 0;
 }
 
+/**
+ * DOC: board
+ *
+ * Certain SOCs can support various board attributes reporting. This is useful
+ * for user application to monitor various bard reated attributes.
+ *
+ * The amdgpu driver provides a sysfs API for reporting board attributes. Presently,
+ * only two types of attributes are reported, baseboard temperature and
+ * gpu board temperature. Both of them are reported as binary files.
+ *
+ * * .. code-block:: console
+ *
+ *      hexdump /sys/bus/pci/devices/.../board/baseboard_temp
+ *
+ *      hexdump /sys/bus/pci/devices/.../board/gpuboard_temp
+ *
+ */
+
+/**
+ * DOC: baseboard_temp
+ *
+ * The amdgpu driver provides a sysfs API for retrieving current baseboard
+ * temperature metrics data. The file baseboard_temp is used for this.
+ * Reading the file will dump all the current baseboard tempertature  metrics data.
+ */
+static ssize_t amdgpu_get_baseboard_temp_metrics(struct device *dev,
+						 struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size;
+	int ret;
+
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
+
+	size = amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_BASEBOARD, NULL);
+	if (size <= 0)
+		goto out;
+	if (size >= PAGE_SIZE) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_BASEBOARD, buf);
+
+out:
+	amdgpu_pm_put_access(adev);
+
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+/**
+ * DOC: gpuboard_temp
+ *
+ * The amdgpu driver provides a sysfs API for retrieving current gpuboard
+ * temperature metrics data. The file gpuboard_temp is used for this.
+ * Reading the file will dump all the current gpuboard tempertature  metrics data.
+ */
+static ssize_t amdgpu_get_gpuboard_temp_metrics(struct device *dev,
+						struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size;
+	int ret;
+
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
+
+	size = amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_GPUBOARD, NULL);
+	if (size <= 0)
+		goto out;
+	if (size >= PAGE_SIZE) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_GPUBOARD, buf);
+
+out:
+	amdgpu_pm_put_access(adev);
+
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR(baseboard_temp, 0444, amdgpu_get_baseboard_temp_metrics, NULL);
+static DEVICE_ATTR(gpuboard_temp, 0444, amdgpu_get_gpuboard_temp_metrics, NULL);
+
+static struct attribute *board_attrs[] = {
+	&dev_attr_baseboard_temp.attr,
+	&dev_attr_gpuboard_temp.attr,
+	NULL
+};
+
+static umode_t amdgpu_board_attr_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (attr == &dev_attr_baseboard_temp.attr) {
+		if (!amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_BASEBOARD))
+			return 0;
+	}
+
+	if (attr == &dev_attr_gpuboard_temp.attr) {
+		if (!amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD))
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+const struct attribute_group amdgpu_board_attr_group = {
+	.name = "board",
+	.attrs = board_attrs,
+	.is_visible = amdgpu_board_attr_visible,
+};
+
 /* pm policy attributes */
 struct amdgpu_pm_policy_attr {
 	struct device_attribute dev_attr;
@@ -4468,6 +4596,13 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 			goto err_out0;
 	}
 
+	if (amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD)) {
+		ret = devm_device_add_group(adev->dev,
+					    &amdgpu_board_attr_group);
+		if (ret)
+			goto err_out0;
+	}
+
 	adev->pm.sysfs_initialized = true;
 
 	return 0;
-- 
2.46.0

