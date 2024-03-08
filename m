Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5DFC54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 08:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E471136E8;
	Fri,  8 Mar 2024 08:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4wAvh0g";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C82010F8CC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 08:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekW0ECVn19uiieL1/RxNvqjV63MeLkZ33OfOKlWePJcmKIVvximqkqPTsbwPvrShMe7Z+orJO5D2N/p0FR+5TfqpCRwOaCQAnOuHewqq3UYp3Pd/en6uW8+GEXAueemm/HIV0jYU7NdL6intZaQccajMox4HwvHnpDwn1OWYMzYy77TKsZ0IX+f28Ke204L7TZaFT8haf3/HSbE0/3+R7S8NKAKLMiPYkjoXHm/1YJsuJq4DPtF739JPJSbSnT2ozBQMo/XHImOsHzfOV7RD1UdFP/9/TY+jNw+UsGYHUbUe0lOi+mKjosOEMYuR/08t1RXbHO/LwuYln9UhpmTdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiOMm1MsfnxH9Hcj3zRZh2a+7TOOQi9E3qI+vC8+Y4A=;
 b=jeGso62pg6dWRWbQHynvnZsZHHiGq7T6PfvKcsd9WVM/wssb7sLEL9fqh9T5SwIwmdVHaSjgq2CAWRBGndSF4S3P4mIaatkFC+EP2IyZUmcEe7tBm1YVLGFIFDG7BxQlOfYO95WTSLByN6vECCMZmBQNQAGd+cwMQntfgVMwNzVb8crT8I+Vvs9DDUsEYKHZBf0HugEXrK/ZzN3koqoXefAAXVnz9rAq/qlOKiWkonwbfPY1LfPYbzA5ZwExvBhszK2HTw5tdbcGPfroLOF7TPtipfRVBbh1poVYxkps3r2NB2TkQ0LcP+PCV2jijVxoFaq5YmId0bIWUoN011WIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiOMm1MsfnxH9Hcj3zRZh2a+7TOOQi9E3qI+vC8+Y4A=;
 b=V4wAvh0gBRZ5igaOlIW99m062M8lq/duBmVOFJan7s13ltSfaQWTvcA5MwbDTNwzVgW5QFZ7RTLnM1/CgPONCKfKLfEY20QB+lX1HviYxfNVO7GweHpANVTMaLUEMmrS4k+0ZQBiQiuoKXSOSKDVfbqUBwb+NYzduOjoX07ElI8=
Received: from BY5PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:1d0::22)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 08:54:19 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::e5) by BY5PR04CA0012.outlook.office365.com
 (2603:10b6:a03:1d0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28 via Frontend
 Transport; Fri, 8 Mar 2024 08:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 08:54:19 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 02:54:16 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH v2 1/7] drm/amdgpu: add the sensor value of VCN activity
Date: Fri, 8 Mar 2024 16:53:54 +0800
Message-ID: <20240308085400.385793-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: feec0cca-532f-4f2d-3745-08dc3f4d5776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSPYbKzWSt4Z7ZS1efqQYSX/I6VQBpDn2z00CCPj5SHdv3PjCa8YLZ7ASLqPgO42K00bDLd7I8oBpJjatC+CFhKYZZybJtJRLpyM/DpY8K6tgZpoVl7YCuYrSNLSHfGp3Di0y4QzEsQX7cDAKZYBqPlVwXStTbUvScXxwiueX5u4rfAGYhJIgUFpAUnJ7vEas8+g00ls00vknSMTIHaKULae90wKAfsatYpeedimjYP4dSNkz2fNlGr2QVR8NTQIREIYEmvIAMesgTZA4RoEjDObL0puPXM+ovFBBkXs5l8eTtj77FoUUtk8M8+Vee52uGuPA8NeH5Obx+Kr2uTr3iaPIK8XsVIRNjO13rBG9NeIx/l8irR29VLaVMbDQaUOgiqqwZn044WBgdjWyqEnqWw7e7nfDms7q5X1BySFGHHqzfBfRd2I9iL9ebuGCnxRTTGCJdZ9v1FuvjCp0LJ1MAxB0DSD2DXhnNpc24eyQW10Pzh/+fdNLKVXqZY627PiMjyMWeGV1qXcc7Qepj0wXYufR56LsiF3FqoSFCb7vop8Pzc9EyGFGyQuJS7LJWJCR3Mi3/Y87shDd992GKpqnJ1JLTRUPqH/YSiG7mpm/4p34syf6i9ymbmvHnB0m8i3vMJ7peEjXsW1jcBqQZHw7pEKznLd/67YOwkzWk/kgqCkNhbnDKbI4NCbrJBWUkI5HXI8HXcJYDu+4/uoQ7zsYcHDO+xekxUEtpwpaFOM4dRP0TvQwwpSN9qbCpBSEknu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:54:19.0758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feec0cca-532f-4f2d-3745-08dc3f4d5776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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

This will add the sensor value of VCN activity for some ASICs.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 36a5ad8c00c5..8a180592e123 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -150,6 +150,7 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_VCN_POWER_STATE,
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
+	AMDGPU_PP_SENSOR_VCN_LOAD,
 };
 
 enum amd_pp_task {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2cd995b0ceba..99cb2c6e8a4b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1581,6 +1581,30 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 	return sysfs_emit(buf, "%d\n", value);
 }
 
+/**
+ * DOC: vcn_busy_percent
+ *
+ * The amdgpu driver provides a sysfs API for reading how busy the VCN
+ * is as a percentage.  The file vcn_busy_percent is used for this.
+ * The SMU firmware computes a percentage of load based on the
+ * aggregate activity level in the IP cores.
+ */
+static ssize_t amdgpu_get_vcn_busy_percent(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	unsigned int value;
+	int r;
+
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VCN_LOAD, &value);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%d\n", value);
+}
+
 /**
  * DOC: pcie_bw
  *
@@ -2121,6 +2145,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(vcn_busy_percent,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2170,6 +2195,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
 		if (adev->flags & AMD_IS_APU || gc_ver == IP_VERSION(9, 0, 1))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(vcn_busy_percent)) {
+		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
+			  gc_ver == IP_VERSION(10, 3, 3) ||
+			  gc_ver == IP_VERSION(10, 3, 6) ||
+			  gc_ver == IP_VERSION(10, 3, 7) ||
+			  gc_ver == IP_VERSION(11, 0, 1) ||
+			  gc_ver == IP_VERSION(11, 0, 4) ||
+			  gc_ver == IP_VERSION(11, 5, 0)))
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pcie_bw)) {
 		/* PCIe Perf counters won't work on APU nodes */
 		if (adev->flags & AMD_IS_APU)
@@ -4365,6 +4399,9 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 	/* MEM Load */
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MEM_LOAD, (void *)&value, &size))
 		seq_printf(m, "MEM Load: %u %%\n", value);
+	/* VCN Load */
+	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VCN_LOAD, (void *)&value, &size))
+		seq_printf(m, "VCN Load: %u %%\n", value);
 
 	seq_printf(m, "\n");
 
-- 
2.34.1

