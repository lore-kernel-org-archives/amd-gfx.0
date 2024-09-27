Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AE8CEBF69
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A8010EC10;
	Fri, 27 Sep 2024 04:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k9DHBUHH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FACF10EC10
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3mnh5o0eL75vviVMStsHWZ894WBI2DZeCgkKU8k53Rr/hIq7yySbn78/cdTcLW9SuckfU6hyiRaRMFBSLtiaVFBIWGE7cT8kDjWWO5X7X5IzMALzGXgU46B25q8grYI33KlhGyyK6SDBnkVNB6FrWyLbKMvZuGAFB7mlevNOejeikbxYAVcgLjNkvVYAmN7en7gr3K+Uv6acHl/8dLyV5SQ/YgLcVVVK03Ogp7KU9NCxA89snnnj5cV+7N328bxvnWSO0e9jjTg4PVTb0cHmFb9n4StB3/IBhJEZvp53LvW98sI+x7noODQ7KxzH241EHrNRJ0/uaBeSRxfCoEt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCxthdU7cKPSWwy9hfhxT5PRQnZFxOrqwuCnOb5MMkg=;
 b=prE4EWEi5Cgm/Rxb7ibF9xDgcCwN25zFUVSjxtFkIjGiDq8mIo+n8lNfHWi84bll9MUHJ5+Jd0Vj5eO4pBcgGUPt9gXARCi6hHe+Gec2CXtxNhvcad9qJBdVZ4fJilqQRkleuWLsSOmoIHOdysCU6dyV4scbdX67QbHC5mQ+zWwSyKcDqCLR4xTM7OfWDKM9ucIevxQ4AjgHuPMR+GOLihHaAxTUWX5txYiWiKj+J7YHn/mgJNlacQaEMa0ZoGexZP9XmtVlk66Nrb8C/BAT/NTrbWOgmwYZMycpeP5K6ixx1f1MGLfi6VEivlJ2LSk7azVNeqWuZ01Fk0n3cVJSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCxthdU7cKPSWwy9hfhxT5PRQnZFxOrqwuCnOb5MMkg=;
 b=k9DHBUHHH/cYzsV9llMsOq0TVK6CXEbumYyUFRI6JioHIqTRa7kSbdcGMb+koW7fTglLSsgF+7pGDVh7thWquJE2TR13ycAVvGj52o34IRRREvkQBaUxevcLnLhT0XRZVqPiw1KEQr3gHn3LymSPpEnUQ/ayX8y2LDHtp6t5m8w=
Received: from BYAPR08CA0038.namprd08.prod.outlook.com (2603:10b6:a03:117::15)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 27 Sep
 2024 04:58:12 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::71) by BYAPR08CA0038.outlook.office365.com
 (2603:10b6:a03:117::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28 via Frontend
 Transport; Fri, 27 Sep 2024 04:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:58:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:58:09 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH v2 4/7] drm/amdgpu: Add sysfs interfaces for NPS mode
Date: Fri, 27 Sep 2024 10:27:40 +0530
Message-ID: <20240927045743.2718949-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927045743.2718949-1-lijo.lazar@amd.com>
References: <20240927045743.2718949-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bc7ec0-754b-438f-bacb-08dcdeb0fd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?42waxnUGa1WMJKeLI5vT4zqgsst/GmAqpOtTqyhk/GGJnCxIU7QtMFx6FANf?=
 =?us-ascii?Q?AjWs9E8IgfvFXWDmCesskbuRsVohrxtXByEDaOelwP1Tzb2Mn5dXUJ+inYwx?=
 =?us-ascii?Q?Ma1f6YxbzU8u/Gsf7oqHIGyCGt4aPxMziMdhGNYisqRu8sHYjR5yhpuVkuUM?=
 =?us-ascii?Q?z1tG16ieD1dNCd2xFOpuNUqINUJnEQ6IvJpQeOx+hRIvvNloDqJMKNlwxyBI?=
 =?us-ascii?Q?OqomFAJnhGzl6XcYQLElAj7CLVK6E2NHzPM11+/kP7fuRGn/zhGVBWkOG8Ct?=
 =?us-ascii?Q?Na784JUOaoh1eFd39v9Uap3esLa9cPmCKFc/l+9OTsG6Hihqf5Xs3v8lEQzB?=
 =?us-ascii?Q?R8NC1df9ssayH6uaN1NdUvrJPPkv7ECcjAuyKQhbnKJz58Xt/S+hqZ2/mXh+?=
 =?us-ascii?Q?EK20f6uuELbcnqzEvLTbhvUjLmuWxXni4dpjSMMIuZy4Jg2F2C2jwWtsohdB?=
 =?us-ascii?Q?CFCJm/9TOgpnZ/vmGLEU1oT36jy9QZXm0VCCA/X59C06A0PZQUU4d053xlH3?=
 =?us-ascii?Q?r3DfVynE+m2Ik5r7hKPLIsvJRfK99Jh9HdKdE5HuoBcVt9JABUU6jXIZLDWi?=
 =?us-ascii?Q?/xcPmXoQKfRc3fMqkCm/RZwiqgz6nErv7hyBJaT340hGP2sC5t5iKiWOUQVX?=
 =?us-ascii?Q?3R0DDubrNJ1Q6yC6YdURmF0tEcMVQQZFuTvc3KrU7Ye71nsbNfVHv+GYOdMZ?=
 =?us-ascii?Q?j9U9a3JjkrM8InVYLeZvnb+FvcIcKNgTA5M22WN6kGrmByoho9stvSYFm03d?=
 =?us-ascii?Q?8yHLhhUgtRdxKsWSoVzhDLEnmJwd5hh5Uzf9uFYeZ76YnElLWAcf9U8gTgbq?=
 =?us-ascii?Q?1+ktutcpvLWbMfXgL7LMvysHyjW3gQm9xoZcsOLKrJlVUZQLRLO0QQVWjzh5?=
 =?us-ascii?Q?BlIDoFvKjegrrMBGdkRSb4+NODAPgWhd7R58jhLNtoUAs37YqrRakuGCnhGK?=
 =?us-ascii?Q?hFUmyuME66xaTf7roP5+cDHYhqkM4Dn3d8ne7xyeLUkNBlL8fCeWqO5ZA7qr?=
 =?us-ascii?Q?9Oj9Pab36pAp9cjVCHw+GuO+0ZyXurPhoBm3K8Senrjb4ytyuUqKx7ADhlhM?=
 =?us-ascii?Q?ArddYVn8YOzNBOl9cUzRvSTaP8x5w4Gyd1Mk+kaO7kZ2qFZ8HftMWJg1s4+o?=
 =?us-ascii?Q?QXKhMoY6LZYVE5XWT4jXOw3jSZRe+RPFZPWnKYESQm0za7RmBpmKf9quep9Y?=
 =?us-ascii?Q?XRtx3lv+1jarDLpQLNmufMaWYsfX0LQVTeguhOCB4gZjtgF+WnUQbaOqcQvm?=
 =?us-ascii?Q?sIIc2r3fWdH2FwQZyka6nWP2ypJ0WBue1ZrcAgufNMx0fCZZgiuwNXYINslQ?=
 =?us-ascii?Q?6Fm7d4u/q0s7hjJL0aV4F82cortK+CErnquQxOi9QaE8CJgyc9FM/RKa8tYQ?=
 =?us-ascii?Q?pyKFwqM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:58:12.2390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bc7ec0-754b-438f-bacb-08dcdeb0fd39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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

Add a sysfs interface to see available NPS modes to switch to -

	cat /sys/bus/pci/devices/../available_memory_paritition

Make the current_memory_partition sysfs node read/write for requesting a
new NPS mode. The request is only cached and at a later point a driver
unload/reload is required to switch to the new NPS mode.

Ex:
	echo NPS1 > /sys/bus/pci/devices/../current_memory_paritition
	echo NPS4 > /sys/bus/pci/devices/../current_memory_paritition

The above interfaces will be available only if the SOC supports more than
one NPS mode.

Also modify the current memory partition sysfs logic to be more
generic.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 114 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   6 ++
 2 files changed, 104 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 758fda4e628f..24a1f931d9ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1130,6 +1130,79 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 	return ret;
 }
 
+static const char *nps_desc[] = {
+	[AMDGPU_NPS1_PARTITION_MODE] = "NPS1",
+	[AMDGPU_NPS2_PARTITION_MODE] = "NPS2",
+	[AMDGPU_NPS3_PARTITION_MODE] = "NPS3",
+	[AMDGPU_NPS4_PARTITION_MODE] = "NPS4",
+	[AMDGPU_NPS6_PARTITION_MODE] = "NPS6",
+	[AMDGPU_NPS8_PARTITION_MODE] = "NPS8",
+};
+
+static ssize_t available_memory_partition_show(struct device *dev,
+					       struct device_attribute *addr,
+					       char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int size = 0, mode;
+	char *sep = "";
+
+	for_each_inst(mode, adev->gmc.supported_nps_modes) {
+		size += sysfs_emit_at(buf, size, "%s%s", sep, nps_desc[mode]);
+		sep = ", ";
+	}
+	size += sysfs_emit_at(buf, size, "\n");
+
+	return size;
+}
+
+static ssize_t current_memory_partition_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_memory_partition mode;
+	struct amdgpu_hive_info *hive;
+	int i;
+
+	mode = UNKNOWN_MEMORY_PARTITION_MODE;
+	for_each_inst(i, adev->gmc.supported_nps_modes) {
+		if (!strncasecmp(nps_desc[i], buf, strlen(nps_desc[i]))) {
+			mode = i;
+			break;
+		}
+	}
+
+	if (mode == UNKNOWN_MEMORY_PARTITION_MODE)
+		return -EINVAL;
+
+	if (mode == adev->gmc.gmc_funcs->query_mem_partition_mode(adev)) {
+		dev_info(
+			adev->dev,
+			"requested NPS mode is same as current NPS mode, skipping\n");
+		return count;
+	}
+
+	/* If device is part of hive, all devices in the hive should request the
+	 * same mode. Hence store the requested mode in hive.
+	 */
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		atomic_set(&hive->requested_nps_mode, mode);
+		amdgpu_put_xgmi_hive(hive);
+	} else {
+		adev->gmc.requested_nps_mode = mode;
+	}
+
+	dev_info(
+		adev->dev,
+		"NPS mode change requested, please remove and reload the driver\n");
+
+	return count;
+}
+
 static ssize_t current_memory_partition_show(
 	struct device *dev, struct device_attribute *addr, char *buf)
 {
@@ -1138,38 +1211,47 @@ static ssize_t current_memory_partition_show(
 	enum amdgpu_memory_partition mode;
 
 	mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-	switch (mode) {
-	case AMDGPU_NPS1_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS1\n");
-	case AMDGPU_NPS2_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS2\n");
-	case AMDGPU_NPS3_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS3\n");
-	case AMDGPU_NPS4_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS4\n");
-	case AMDGPU_NPS6_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS6\n");
-	case AMDGPU_NPS8_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS8\n");
-	default:
+	if ((mode > ARRAY_SIZE(nps_desc)) ||
+	    (BIT(mode) & AMDGPU_ALL_NPS_MASK) != BIT(mode))
 		return sysfs_emit(buf, "UNKNOWN\n");
-	}
+
+	return sysfs_emit(buf, "%s\n", nps_desc[mode]);
 }
 
-static DEVICE_ATTR_RO(current_memory_partition);
+static DEVICE_ATTR_RW(current_memory_partition);
+static DEVICE_ATTR_RO(available_memory_partition);
 
 int amdgpu_gmc_sysfs_init(struct amdgpu_device *adev)
 {
+	bool nps_switch_support;
+	int r = 0;
+
 	if (!adev->gmc.gmc_funcs->query_mem_partition_mode)
 		return 0;
 
+	nps_switch_support = (hweight32(adev->gmc.supported_nps_modes &
+					AMDGPU_ALL_NPS_MASK) > 1);
+	if (!nps_switch_support)
+		dev_attr_current_memory_partition.attr.mode &=
+			~(S_IWUSR | S_IWGRP | S_IWOTH);
+	else
+		r = device_create_file(adev->dev,
+				       &dev_attr_available_memory_partition);
+
+	if (r)
+		return r;
+
 	return device_create_file(adev->dev,
 				  &dev_attr_current_memory_partition);
 }
 
 void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev)
 {
+	if (!adev->gmc.gmc_funcs->query_mem_partition_mode)
+		return;
+
 	device_remove_file(adev->dev, &dev_attr_current_memory_partition);
+	device_remove_file(adev->dev, &dev_attr_available_memory_partition);
 }
 
 int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index f5be5112b742..1a50639a003a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -73,6 +73,11 @@ enum amdgpu_memory_partition {
 	AMDGPU_NPS8_PARTITION_MODE = 8,
 };
 
+#define AMDGPU_ALL_NPS_MASK                                                  \
+	(BIT(AMDGPU_NPS1_PARTITION_MODE) | BIT(AMDGPU_NPS2_PARTITION_MODE) | \
+	 BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
+	 BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))
+
 /*
  * GMC page fault information
  */
@@ -308,6 +313,7 @@ struct amdgpu_gmc {
 	uint8_t num_mem_partitions;
 	const struct amdgpu_gmc_funcs	*gmc_funcs;
 	enum amdgpu_memory_partition	requested_nps_mode;
+	uint32_t supported_nps_modes;
 
 	struct amdgpu_xgmi xgmi;
 	struct amdgpu_irq_src	ecc_irq;
-- 
2.25.1

