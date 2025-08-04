Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0319EC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB9010E35E;
	Mon,  4 Aug 2025 11:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ACAblSC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F10310E1C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGECJwhJAwvn44C6GFDwINdmXcHaURMy3zcScU/a0L/T0FbipWx+GOoF95Y8GCQXCPtKelJLT0D0H6iPCN1aWq8+4tfi5feQn3J5bIDey9d8Lxj+MB2CWVDkv4hR6pmgg4dHJ+AbO/s7uMb44fD8CeAVElsLL6hD226BWwyvo6PA09eLILuoK0u+HIJIv6B69okjhnCenw6UlNRK3FzY14hVHFmv0GyuL3XyN1In+gywb2ziNwE6OeTUGhRgcC+y5TLhndFDkljsnoa8BN6xwuddTQclSUk9sHevvp7TUAF/SvFuAbKuhml5rq9rhK/Z+ndxm6P8b1Q7g0xiQqDpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8oyqfoInoW48Q0T3uZ28rfZoMkwoW/YXsU9mCm8shw=;
 b=rHaJbwqF3q3Oc5pJBqu1CAkh3jhdYDv92uRCKYGEm/r9zAjz64hRc0Pka3zcPLJeqeXVPZrfObdge/9sY4Gkz2Qd2eX/D0C2BKC68AOewHeiiJKBUqzPWw6EnxWxaoyW4h3WlGKNPrzOn3FISebKk+3zGK6win3Bpffyh3yy4IGs8MANxcAx9TXT99VXFF2SJwePl5vaI5V44U4wXs35pXq9NPnYhPRSB8SjgK52xM/B87HMNz8pcQ+ntDQxG9a7vhemQ9kWtY3j350pQLVouvxikCZ3BecTLvzRqsDjzCnXPRiniGEVZ1YMh02yYdD5rm/v3sqdnaxcCtsaFr//+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8oyqfoInoW48Q0T3uZ28rfZoMkwoW/YXsU9mCm8shw=;
 b=5ACAblSCaRXHIdLGvvVnLLxUIasJty61K8Etp2Rxp8c64IPRgL307BtgGpCx+LYbGeRXV/6OeV82hfbpkbx7vMBR5TI+UpGHjrnnLstsBTAwP3M9A8PHowZeJm5uXSk5wYcpOgjH4PILy03cuGoCaNR8A4FtgQTNZhwqY4TozDU=
Received: from BN0PR04CA0193.namprd04.prod.outlook.com (2603:10b6:408:e9::18)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:05 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::35) by BN0PR04CA0193.outlook.office365.com
 (2603:10b6:408:e9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 11:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:05 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:06:01 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2 5/6] drm/amd/pm: Add temperature metrics sysfs entry
Date: Mon, 4 Aug 2025 19:05:38 +0800
Message-ID: <20250804110539.637463-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804110539.637463-1-asad.kamal@amd.com>
References: <20250804110539.637463-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 41850bcb-f275-492c-1d78-08ddd346e82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dSryDPFFHJg7jMXLGBo7N8HWIVWtSJXzOudwLR/U4z4Ef+RbrvY4hZSFcNxu?=
 =?us-ascii?Q?UWDKrnrPVH+xXtZ2xgxcfV+dL6Nffg4WoU25w8McY5DuXc98McVGRacLqhSb?=
 =?us-ascii?Q?9QVc0lnwfGq0+tvR6DFhx6k1hh4xPcgVFFBiOqs8/bc+yf2mNhf6qnc6Tu3i?=
 =?us-ascii?Q?hGPYVWmDV/Xtun6UrFLiEaQ1g4dqjeQFNsCF4+MN2UAXkf08KhVEituNddAY?=
 =?us-ascii?Q?gIcQCeRH0wVgQWYt5IpupH7lQCOZmFebajh/EMvZNyeWPtj5n9UoLVThr8BH?=
 =?us-ascii?Q?KpUvaSH55ie018xH9m9QU8iJ6sGNL5LkUnQV/fIG1XgAWTTHB/krWBnYSkzd?=
 =?us-ascii?Q?lN6W5w1KL4TvxzCIPof70Z1pujWXJsKvFuenzPSEXh+dft7DXvwzLMlXFjcx?=
 =?us-ascii?Q?COw8UOP9YrG5RGjH+9Fw5Hpeazj6Cxa0q9qpwONvz1DsCNW3u/egRDdXTipx?=
 =?us-ascii?Q?6+9pDRmUEnJYim8JNqem6voenOWXjbp8/MGQw/LYgJWFf9fmD0AjetHgrO8c?=
 =?us-ascii?Q?qx5F8s7rOcBPiCy6sVnpB6MiU2zkc4OECPSVlsSwujoGX5/xHzRIpEm+oU8a?=
 =?us-ascii?Q?XHcaz4V9fTb472qHs5ETD2dnSrc/5uCVboreyz98P7vTWvRhvEvP4H1o5AnU?=
 =?us-ascii?Q?CbLV64lf8lLU855EgfwbUPr8tzHUmQga91E9/fw2yFck9lB2uN5s/+yNaTVB?=
 =?us-ascii?Q?TWCSo0zMI1vak5eqa/DX96RK48OZkINXVzk+JnEvE6pG6Zj3Ehah7oeL7yA8?=
 =?us-ascii?Q?H1zGIt5OKmg4X4Rn8R4c1EXzXTH1Y+SNKEtjKS9xPAWCAgSpdKgwKlbonpa/?=
 =?us-ascii?Q?yilcw0T7WrbpeOd7JNi8HPIi1UkQQWLPYujSzyMpkkjeY6duoYWB5EuOolR+?=
 =?us-ascii?Q?vUc3ZrvuLVyWbb9AO4mwwYydgk8e0USJ0DmKu4sizAYD71oZRwDMxl/w7NBD?=
 =?us-ascii?Q?kYROuTD21RQ96slyDFm3P0mG8ull4PxvVVUJU/XRONbRw42c8cCwqjXX2Vgr?=
 =?us-ascii?Q?5SGkqXQT4rcjHO7D3dz20NIsqRlDSyIWAZwNT63NmygHd6rh8iB+fkZrdE7L?=
 =?us-ascii?Q?FvmXvCTd9XvuBqwI2Jjs0Zj1ygvoRdLYMW1eWAVAfpVxvSF6CfVnY+5RZRPS?=
 =?us-ascii?Q?uvUkEoOE3tWpiX4E16UDlFLaWkDed1L2QNSL7bFhfPI4SZ6OnbEku89KUB5j?=
 =?us-ascii?Q?sza5si42T5pzfex6FVjCkJYhaQQmY2UNB2JJA5IdPrlxd1oI4t06NFFFVeKp?=
 =?us-ascii?Q?/iwrp3QFB23Tqi5U6pIwT8ZqjQE5hFgT+jDACCp/5PVit+oyCD9q7ceFeQjY?=
 =?us-ascii?Q?nQG8BbPc1tGKgxe06+BTcrbN3bJFDpdU9HBL9SFlcyB2GOqSybiSv47XEEI5?=
 =?us-ascii?Q?u4qMSsgAlZn0Ozxi5gr8GX/2Q/hWXAmCKYIYsInG/xdytGLJ8GBkGyZSByrd?=
 =?us-ascii?Q?clnQYaq9VWP0Uz/UAqSKF/vU6Upev8xCr1DTidq6rIMVhooDVTl+JF6Hvn6q?=
 =?us-ascii?Q?ZUS9DB2/JtwrTMaZShE0egeKt6Gm30JubHHA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:05.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41850bcb-f275-492c-1d78-08ddd346e82b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
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

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 135 +++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8d934a365c3b..75b06ca7f20a 100644
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
+	ssize_t size = 0;
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
+	ssize_t size = 0;
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

