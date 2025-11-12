Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B8CCD1297
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 15:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A67310E757;
	Wed, 12 Nov 2025 15:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xDSXgpny";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF9A10E757
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=looYlOr+bzOKL6zYw/Ct/MJY8Fy8gkv9AL+Uy91YdftHdktovWbkBrXiL06F+TmwdaY6GEqrNqCYsOSt1rXF7ZCsoe0TmyqcwBw7vB1W6GsF813SVhXmVVpzovkUk4kyPYPWVyQY1cdhJ8wSSwOITiaa2YVsueic7v5lddiBTxCBFa+UQKDKAnzPIXHE13YkPKaN12U8zlsTjPTHf7T8ByS/JI8sBFjBgJrbv72gft+CVbeZxJAO4f8bQ0zV67k1HsTTa6L/NbvgnmKX/k//Da1K07/ameM3rHHSONAlZ/So3kkGwPCL51HxTF/CBN8PXzE5NyR47YTgxVDMI4P6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlCQwzNkTLGb4WF5NzcIJxLmCH2kDT3iwrStsNJK4Mk=;
 b=ksVDhs/bzLAcev7dV8/Maz9MEiRq8RI9MpuVZSoN0l5m+ZwuYrUDvNGR5emG680NyCQ/THPvL/uaiQ/STEYBe0XIuV9qjaSaHGYg7dMMuypZ6rk8fZU49aWrJA2651AeM3aOr3CbmwS+3Ive3kpsBhJDnvecEN+Gy3aQSTTqCgnd+ZGXc4+unCc0xVVxdKg7nBe5bCGrU+CJv6W8N9+QMWTwPRMieEqzP5J7C+LiSrhmPJRS5ppxItxOVkIzQ1+Z/f2q69GLK0ea/2V9qXjCYCxRyg2h1lLDMzLk16mjrsZppJ7wqAh5TjYH+ePqIivXxUg4ElD+77dgqTc69V3Pzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlCQwzNkTLGb4WF5NzcIJxLmCH2kDT3iwrStsNJK4Mk=;
 b=xDSXgpnya1LJhAT2WSQTxldF/1jYSBZ10T4H+g3128n9wqWnllSBHaBbpk/gVfYOpju/DeJxmxuqAcfa2uTwTnpZ5rt8TsKY/4Os5w14Xp89SZdgsugHtqRzCJI7qFLc4Pk3janwD4g4PwcMu8+xm3H9g0SlSH6uBKl+mgoA6yM=
Received: from BYAPR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:74::37)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 15:28:44 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::e9) by BYAPR05CA0060.outlook.office365.com
 (2603:10b6:a03:74::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 15:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:28:43 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 07:28:30 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v2 2/4] drm/amd/pm: Add sysfs node for ubb power
Date: Wed, 12 Nov 2025 23:28:13 +0800
Message-ID: <20251112152815.203110-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251112152815.203110-1-asad.kamal@amd.com>
References: <20251112152815.203110-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 685d09ba-8695-4011-7f84-08de22002a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5x5FMF0r7XKrJxkJhQUjbA83xrwDRHiSjYybH71jXJhEf1VT1qqgWgNqUdGI?=
 =?us-ascii?Q?aNwMD0xN8wMFIxVTU0vhszOOdR2N0AkR4o3FcUx9vf6e92rsF2wBWhsSdVpj?=
 =?us-ascii?Q?IG0eNyJTq0bUGnu8tUuih7RaxIPD+TKfg15pcOEp0lkfEL10W++1xqDecVBh?=
 =?us-ascii?Q?NLNmSSoBCvA/+T0bPRiUx4CvGplmQN5MdTPPvqUmjqDQcnRJ6RgySWXhO/IA?=
 =?us-ascii?Q?IQZVCOUgoG/hHbz1vPm5oQAaXJZQt4ykiGyFoHNBao+QwyCtbXSJnY0eEgx3?=
 =?us-ascii?Q?YoY+raRzgFnoigHtCwVCnro3T1D0m23uaa4KJKoskpOt7IQplnSomux++hlA?=
 =?us-ascii?Q?V11DJsbWUzz8nyh98iAWfPNnYcTJge6EEUDRmkUrHCW+aBTi3NjvALg5ffpJ?=
 =?us-ascii?Q?XzuyRUYEZuw3V023TgDlOUIx6JHNj41jegPL4L6IZmcBhe/Lul5cmud/SIon?=
 =?us-ascii?Q?fZI8dg9b8hRx3DQ1mR+r+PJv1lZjdO+IEBzrx7Jdv9cB3UcuXbzjKTe5MmW1?=
 =?us-ascii?Q?7KqVLnL/yPLWU29a19JFtfNTlbGNnTNwovWW7xee9q8nFa5PHPWGY4t3wbx9?=
 =?us-ascii?Q?3cyN0gVlQwQeLGlhXbEuzv2ozLsDtYl7V53/dYBLrnSDd34driwfR1R3PYM+?=
 =?us-ascii?Q?dSgAVsmU6gG++Bhz0JVGKC9LqfKRKu0xNetJ9sT9A26mA5kCJOyDlv47EObH?=
 =?us-ascii?Q?DDf5izNhZiIYwU/739QZH+Ac+xVk4ABrNkvpCbJZLTfCCQPtn8hm7yKZV/b0?=
 =?us-ascii?Q?s0U4JlJgp1LrQ1uTJDi2tAhGavhajw0+1q2KVRdWwQGPQU616gkCV1Yb3DKi?=
 =?us-ascii?Q?V0WTwazDEuYHBR48t7ON7DNKWSmxYS+QFpnIZZUkz8dyk5MrVtVUNeATVokE?=
 =?us-ascii?Q?oDl8+QMKZVTL+8qHAJPlw9rgzvSdNI5ViagQT/vYFhUOP8A9HnvtfwNrUnCo?=
 =?us-ascii?Q?glYhagFWbwlArDpBredFSjCmQrSVfVLdpfGKRpx/w4uIaV6u4ay7loJ5CQDi?=
 =?us-ascii?Q?yR15fni+D3wgKfcpcUgXczk9iNY7p7QUunDDAuozXPPMBAi0c/zww6240pbo?=
 =?us-ascii?Q?mbyKrhIMGIve76sOfVPRfHi8cLfPBMnwlfSAzDAOGIco5I0Kb8WdjD684/s5?=
 =?us-ascii?Q?db6f5NbEJpDvtpKg8EnwpztTB0iAGEdqJounX7KEqtx0SBl3M8E+2EY+YX6B?=
 =?us-ascii?Q?FnBYjmcWUNUJbLkiHZ0xRYxYie3zXHUcHNg4+7BIWuUdRjv6sbi9W+yCkPw+?=
 =?us-ascii?Q?KXBrMsziRJu8A4TP9n/2WhMsCxKUWSsRJYK38SDzTbVltj5aM0AJNGffGxcD?=
 =?us-ascii?Q?bDxcSTKOgxCipGsL6rh6oNHK1YjzkpMdx9aul1kqzLEqOWEvUVzs3AVWZxlK?=
 =?us-ascii?Q?3akqaU/x5gW3QMHwcZiEZxSpUZp2dS1L1C0dB2XqDq7sPLBvX6uHLBHrTcpk?=
 =?us-ascii?Q?KlOuR5HoXVTUfpBroiXmc/lXDueljGUViRPwga3fa+plGMoJa1YqreAMhOUs?=
 =?us-ascii?Q?aVFjZMxY+VT+sY758acuDHS9ED2Os6/F8QNDl1jxB6ekiqKThf4rF7aFEyBU?=
 =?us-ascii?Q?p3XOop5B6ITY0zd+E80=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:28:43.6134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685d09ba-8695-4011-7f84-08de22002a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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

Add sysfs node to expose ubb power limit for smu_v13_0_12

v2: Update sysfs node name to baseboard_power & baseboard_power_limit to
make it consistent with other node names (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 65 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2366e68262e6..92477120c28d 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -166,6 +166,8 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_NODEPOWER,
 	AMDGPU_PP_SENSOR_GPPTRESIDENCY,
 	AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
+	AMDGPU_PP_SENSOR_UBB_POWER,
+	AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
 };
 
 enum amd_pp_task {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d9e37fd6e186..1efa08771361 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2082,9 +2082,10 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
  * for user application to monitor various board reated attributes.
  *
  * The amdgpu driver provides a sysfs API for reporting board attributes. Presently,
- * seven types of attributes are reported. Baseboard temperature and
+ * nine types of attributes are reported. Baseboard temperature and
  * gpu board temperature are reported as binary files. Npm status, current node power limit,
- * max node power limit, node power and global ppt residency is reported as ASCII text file.
+ * max node power limit, node power, global ppt residency, baseboard_power, baseboard_power_limit
+ * is reported as ASCII text file.
  *
  * * .. code-block:: console
  *
@@ -2101,6 +2102,10 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
  *      hexdump /sys/bus/pci/devices/.../board/node_power
  *
  *      hexdump /sys/bus/pci/devices/.../board/global_ppt_resid
+ *
+ *      hexdump /sys/bus/pci/devices/.../board/baseboard_power
+ *
+ *      hexdump /sys/bus/pci/devices/.../board/baseboard_power_limit
  */
 
 /**
@@ -2295,6 +2300,52 @@ static ssize_t amdgpu_show_max_node_power_limit(struct device *dev,
 	return sysfs_emit(buf, "%u\n", max_nplimit);
 }
 
+/**
+ * DOC: baseboard_power
+ *
+ * The amdgpu driver provides a sysfs API for retrieving current ubb power.
+ * The file baseboard_power is used for this.
+ */
+static ssize_t amdgpu_show_baseboard_power(struct device *dev,
+					   struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	u32 ubbpower;
+	int r;
+
+	/* get the node power */
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB_POWER,
+					 (void *)&ubbpower);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%u\n", ubbpower);
+}
+
+/**
+ * DOC: baseboard_power_limit
+ *
+ * The amdgpu driver provides a sysfs API for retrieving threshold ubb power.
+ * The file baseboard_power_limit is used for this.
+ */
+static ssize_t amdgpu_show_baseboard_power_limit(struct device *dev,
+						 struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	u32 ubbpowerlimit;
+	int r;
+
+	/* get the node power */
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
+					 (void *)&ubbpowerlimit);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%u\n", ubbpowerlimit);
+}
+
 static DEVICE_ATTR(baseboard_temp, 0444, amdgpu_get_baseboard_temp_metrics, NULL);
 static DEVICE_ATTR(gpuboard_temp, 0444, amdgpu_get_gpuboard_temp_metrics, NULL);
 static DEVICE_ATTR(cur_node_power_limit, 0444, amdgpu_show_cur_node_power_limit, NULL);
@@ -2302,6 +2353,8 @@ static DEVICE_ATTR(node_power, 0444, amdgpu_show_node_power, NULL);
 static DEVICE_ATTR(global_ppt_resid, 0444, amdgpu_show_global_ppt_resid, NULL);
 static DEVICE_ATTR(max_node_power_limit, 0444, amdgpu_show_max_node_power_limit, NULL);
 static DEVICE_ATTR(npm_status, 0444, amdgpu_show_npm_status, NULL);
+static DEVICE_ATTR(baseboard_power, 0444, amdgpu_show_baseboard_power, NULL);
+static DEVICE_ATTR(baseboard_power_limit, 0444, amdgpu_show_baseboard_power_limit, NULL);
 
 static struct attribute *board_attrs[] = {
 	&dev_attr_baseboard_temp.attr,
@@ -4748,6 +4801,14 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_npm_status.attr,
 						amdgpu_board_attr_group.name);
 		}
+		if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
+						 (void *)&tmp) != -EOPNOTSUPP) {
+			sysfs_add_file_to_group(&adev->dev->kobj,
+						&dev_attr_baseboard_power_limit.attr,
+						amdgpu_board_attr_group.name);
+			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_baseboard_power.attr,
+						amdgpu_board_attr_group.name);
+		}
 	}
 
 	adev->pm.sysfs_initialized = true;
-- 
2.46.0

