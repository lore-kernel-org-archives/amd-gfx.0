Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7C1CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 09:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CE510E746;
	Tue, 16 Sep 2025 09:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5fQ41qi";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9380010E742
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMPqd+eprngNYBgGSKLBQ/zUUKW2t+P38lEPgsLh2mqlDRjuNuxk3q7tQdZ0u2oEbkDXd+CIugbTK8+4ujyy6EErWxlJKWUoqGtONCuXl6gYAPMD5QlmCAWn4mZJYIKJ9KT/gncL3EiZluj9kynaaVZuIxFkfa9LtjFo0nAmf1CynYOpfjtS0W0Q8sZBsIXtG4RsNpnhDRNpsCB0FXJX1KCq22g/8el795MqwSkd3bagMEPSNzB2iLFIpUsImoQTI7agmDQkqIgVyijbXW987vdwKlsmLmr7XWqbeapYIYF5MI8lrB7GWFC/7wgy1wU7lUC2fp/YDHPeeizW9zMsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dAY32PQVMKqwbsR3fT3ZRqqhDAHQzOFVnpCCf9+UMw=;
 b=SPzzGIGDOZP5Q0yVQNQEAVyw7m3hmtYeyJ0P8w006DLACPf8wYIS1lp0O2X0Rf+XlqAfRQQnsK+BXfW3TiIsN248JkSDXiNuvqGA6sDxXNW+UFxaG4mfxjBP4aJpIPVApZuensSIS42FXXUhVYKvJdAHI5aXbBr/LGhOZuVr+WlB9mz5+1+n16u4M9OfRfplRxfvVbi59VIfVWNfRwdYwhjB4eUIKBKxSzop9R69nOSdoWuk0ZXYnKqM4dZuHhtuZKC3Zwxf+23wHuJkhJ69NsK8nR1JSYfsh3EYqJNaBs/S8JqbjA/E1CjNm9OzBURXP3A0ecZ8OrYvqpLmNSVDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dAY32PQVMKqwbsR3fT3ZRqqhDAHQzOFVnpCCf9+UMw=;
 b=m5fQ41qiDmtVjmdWDlemgcX9yMh5jPnkImufeUbptWA9esMi3/vYCAPL92HO7XsE9ZnIPQSt9kMUTeeagwDLigByxoAiWlEGFoMxkcZ1FR60DX60O6R3LEJ7EkhNkT8Q5XCA1AZ7zmDAJ/7YT6y7lv9ToqluKxj7uhAvglzQg0w=
Received: from CY5PR15CA0026.namprd15.prod.outlook.com (2603:10b6:930:14::17)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 09:05:53 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::7e) by CY5PR15CA0026.outlook.office365.com
 (2603:10b6:930:14::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 09:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 09:05:52 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 02:05:47 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 4/6] drm/amd/pm: Add sysfs node for node power
Date: Tue, 16 Sep 2025 17:05:25 +0800
Message-ID: <20250916090527.2727930-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250916090527.2727930-1-asad.kamal@amd.com>
References: <20250916090527.2727930-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d20a66-e684-42fc-5df0-08ddf5003d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dYowAW/xNWHRRnwg5Yxwok+hdCk2FG1OTZc57joGC7h/3rn3+Z+70tUk/q7A?=
 =?us-ascii?Q?hoglr1sg/hJGPY6JEKMHEOx6Beyxa3TsPCS1BXsHzHLTnRBsqf68jvuoUCw3?=
 =?us-ascii?Q?C+iNM4nyugwK+gyP6ZhiHqTBagveFCAteD2FuXPXA9o5Y90QM/JIM1P5goZ+?=
 =?us-ascii?Q?ob8OK5RBvvGmVtbjIL827ewd/FAItb7sEUiFOd6O/hNls4pOrxqexYDv18Z0?=
 =?us-ascii?Q?bd5XxUBkgoHN7U67da3Wn46js1sIyX1cLTTCk8zeWB5bpSXk2owOX6ubFm7K?=
 =?us-ascii?Q?AL4P642kDTTA3D2/cwZv8R//iQYKuYpkPr8ED08gxowyaWGI8E8yKFerJjdX?=
 =?us-ascii?Q?MoEwPrl0iKObL5hO2N8vX/9UH5nnPztD/hDS9OTCUBraq1pJ3wlDAPh2q7y2?=
 =?us-ascii?Q?wqsfkrz9UzkP5mAQ0KcC9CZQ4hox8YaNIjbRLzicSukN+vY14T0baaO/cHfH?=
 =?us-ascii?Q?rkVH2yGKXJVm1+EpvVPcyi6q4UIcn9nn5ZJy82sxETjeoHs7AvofRhkufZ30?=
 =?us-ascii?Q?SrZleQ/wspD2oPYVORHWq7IrU7fFxYCccIeNjSYV48hMAuPbxOISf2UK1EM7?=
 =?us-ascii?Q?q4s8Py5tJ2aRpaE/9F4BTulzNV7cRa4MZINQvu8wnpGjW2fn2BAuI7Ldgqqv?=
 =?us-ascii?Q?Bu+ewMScEI+mg5L/tXnKB0lf4OA9IuA1qoWeY0S6k5CkydJRELjURRbjzSGj?=
 =?us-ascii?Q?mmxaWeCsTs9ZiDYdNVacPfO/2dpi2obQHTzdQhV5pMcH9bM1K4Ivwfve4ycT?=
 =?us-ascii?Q?9Ign4z4RTsdV11nJO0Zx4uDxPqEPgOvMpqm/xSpP141VyiJsY+TJFr/EkR1z?=
 =?us-ascii?Q?5UgK9uAMkNDaCgkwsXN3vnGN3zsWdyLQYVgXW0Fe/skDxkxQ5ma1yxP+yWeC?=
 =?us-ascii?Q?GIuDpN0uW/SU/QfpcULqINsfjLQZ85pMfi99M6otc2zf9PDuoJ2aik6F59yE?=
 =?us-ascii?Q?BZ3mpsIlG9mpoEy0dnEFDKKdN2McvLSarp7InSkn3IsfCCHh5SMq+hu7cUhF?=
 =?us-ascii?Q?0oTQ7LPhAZRFmW+X6C7CH3TFxDHPaXKl3TuES6Gw9rDdZaifPvTFklVySuRN?=
 =?us-ascii?Q?H+c6dIF6MaNgOzFbSSjM5ea+WUCS1NXERMZEmu7JEYzdBKICJncsypDidteT?=
 =?us-ascii?Q?Iq2URyl+VXUp9ygFLoVXv8OBtMbaozKGiMixjAi7HFhnrxB6Repx8k5YMnRy?=
 =?us-ascii?Q?KKoqHTNh7AyHe2aS1vp4VrUiVK/POy/Ah5COSK352j/geZWeTaQVoUP/Dou4?=
 =?us-ascii?Q?s6Y8TFdVonIpAKSo52JjHjf1ZEVJT4i8VVgQ79Ecs4UHdzx3f8zGOVtv47ZA?=
 =?us-ascii?Q?SUPMBiiBQaMiyx4AuNo0d8QGErqg6w9Oewp60PxCX7gKbOq5LXs4Vx8WGs4Z?=
 =?us-ascii?Q?/3rAqRtwmyCbFW0/dlHXLo2I1xKj20CEUyUPWs9ruZv2ieaIzRjbGE0zrl4X?=
 =?us-ascii?Q?0Y5IP6g9qUL06XlT9j0aCKGD27Lt3liiPPUy0TbHhIwroX0AmXpaW5QKz4Oi?=
 =?us-ascii?Q?wp9FIfbTnUGjT7r2KQJ+4rBhlbsaKGJy+54f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:05:52.9416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d20a66-e684-42fc-5df0-08ddf5003d18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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

Add sysfs node to expose node power limit for smu_v13_0_12

v2: Remove support check from visible function (Kevin)

v3: Update comments (Kevin)
    Remove sysfs remove file, change format specifier
    for sysfs_emit, use attribute_group.name (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 151 +++++++++++++++++-
 2 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2f7e4b5bebf3..2b0cdb2a2775 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -162,6 +162,10 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
 	AMDGPU_PP_SENSOR_VCN_LOAD,
+	AMDGPU_PP_SENSOR_NODEPOWERLIMIT,
+	AMDGPU_PP_SENSOR_NODEPOWER,
+	AMDGPU_PP_SENSOR_GPPTRESIDENCY,
+	AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
 };
 
 enum amd_pp_task {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 57821e59d3cc..b5fbb0fd1dc0 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2081,8 +2081,9 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
  * for user application to monitor various board reated attributes.
  *
  * The amdgpu driver provides a sysfs API for reporting board attributes. Presently,
- * only two types of attributes are reported, baseboard temperature and
- * gpu board temperature. Both of them are reported as binary files.
+ * seven types of attributes are reported. Baseboard temperature and
+ * gpu board temperature are reported as binary files. Npm status, current node power limit,
+ * max node power limit, node power and global ppt residency is reported as ASCII text file.
  *
  * * .. code-block:: console
  *
@@ -2090,6 +2091,15 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
  *
  *      hexdump /sys/bus/pci/devices/.../board/gpuboard_temp
  *
+ *      hexdump /sys/bus/pci/devices/.../board/npm_status
+ *
+ *      hexdump /sys/bus/pci/devices/.../board/cur_node_power_limit
+ *
+ *      hexdump /sys/bus/pci/devices/.../board/max_node_power_limit
+ *
+ *      hexdump /sys/bus/pci/devices/.../board/node_power
+ *
+ *      hexdump /sys/bus/pci/devices/.../board/global_ppt_resid
  */
 
 /**
@@ -2168,8 +2178,129 @@ static ssize_t amdgpu_get_gpuboard_temp_metrics(struct device *dev,
 	return size;
 }
 
+/**
+ * DOC: cur_node_power_limit
+ *
+ * The amdgpu driver provides a sysfs API for retrieving current node power limit.
+ * The file cur_node_power_limit is used for this.
+ */
+static ssize_t amdgpu_show_cur_node_power_limit(struct device *dev,
+						struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	u32 nplimit;
+	int r;
+
+	/* get the current node power limit */
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_NODEPOWERLIMIT,
+					 (void *)&nplimit);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%u\n", nplimit);
+}
+
+/**
+ * DOC: node_power
+ *
+ * The amdgpu driver provides a sysfs API for retrieving current node power.
+ * The file node_power is used for this.
+ */
+static ssize_t amdgpu_show_node_power(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	u32 npower;
+	int r;
+
+	/* get the node power */
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_NODEPOWER,
+					 (void *)&npower);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%u\n", npower);
+}
+
+/**
+ * DOC: npm_status
+ *
+ * The amdgpu driver provides a sysfs API for retrieving current node power management status.
+ * The file npm_status is used for this. It shows the status as enabled or disabled based on
+ * current node power value. If node power is zero, status is disabled else enabled.
+ */
+static ssize_t amdgpu_show_npm_status(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	u32 npower;
+	int r;
+
+	/* get the node power */
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_NODEPOWER,
+					 (void *)&npower);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%s\n", npower ? "enabled" : "disabled");
+}
+
+/**
+ * DOC: global_ppt_resid
+ *
+ * The amdgpu driver provides a sysfs API for retrieving global ppt residency.
+ * The file global_ppt_resid is used for this.
+ */
+static ssize_t amdgpu_show_global_ppt_resid(struct device *dev,
+					    struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	u32 gpptresid;
+	int r;
+
+	/* get the global ppt residency */
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPPTRESIDENCY,
+					 (void *)&gpptresid);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%u\n", gpptresid);
+}
+
+/**
+ * DOC: max_node_power_limit
+ *
+ * The amdgpu driver provides a sysfs API for retrieving maximum node power limit.
+ * The file max_node_power_limit is used for this.
+ */
+static ssize_t amdgpu_show_max_node_power_limit(struct device *dev,
+						struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	u32 max_nplimit;
+	int r;
+
+	/* get the max node power limit */
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
+					 (void *)&max_nplimit);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%u\n", max_nplimit);
+}
+
 static DEVICE_ATTR(baseboard_temp, 0444, amdgpu_get_baseboard_temp_metrics, NULL);
 static DEVICE_ATTR(gpuboard_temp, 0444, amdgpu_get_gpuboard_temp_metrics, NULL);
+static DEVICE_ATTR(cur_node_power_limit, 0444, amdgpu_show_cur_node_power_limit, NULL);
+static DEVICE_ATTR(node_power, 0444, amdgpu_show_node_power, NULL);
+static DEVICE_ATTR(global_ppt_resid, 0444, amdgpu_show_global_ppt_resid, NULL);
+static DEVICE_ATTR(max_node_power_limit, 0444, amdgpu_show_max_node_power_limit, NULL);
+static DEVICE_ATTR(npm_status, 0444, amdgpu_show_npm_status, NULL);
 
 static struct attribute *board_attrs[] = {
 	&dev_attr_baseboard_temp.attr,
@@ -4534,6 +4665,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 {
 	enum amdgpu_sriov_vf_mode mode;
 	uint32_t mask = 0;
+	uint32_t tmp;
 	int ret;
 
 	if (adev->pm.sysfs_initialized)
@@ -4600,6 +4732,21 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 					    &amdgpu_board_attr_group);
 		if (ret)
 			goto err_out0;
+		if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
+						 (void *)&tmp) != -EOPNOTSUPP) {
+			sysfs_add_file_to_group(&adev->dev->kobj,
+						&dev_attr_cur_node_power_limit.attr,
+						amdgpu_board_attr_group.name);
+			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_node_power.attr,
+						amdgpu_board_attr_group.name);
+			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_global_ppt_resid.attr,
+						amdgpu_board_attr_group.name);
+			sysfs_add_file_to_group(&adev->dev->kobj,
+						&dev_attr_max_node_power_limit.attr,
+						amdgpu_board_attr_group.name);
+			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_npm_status.attr,
+						amdgpu_board_attr_group.name);
+		}
 	}
 
 	adev->pm.sysfs_initialized = true;
-- 
2.46.0

