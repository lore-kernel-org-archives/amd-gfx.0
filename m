Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87091C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 03:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE9010E629;
	Fri, 11 Aug 2023 03:40:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CBC10E629
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPh04Rowhe6I+vxowzNAF0/hf29OWxgbkr0Efq4nxqcRTv8ofYWkuEEsKpBiA/oO87CIpvmtxngUnMVF04QBWK9Ax+wZ2xGBeBAzsPJ4vk3mBNQzjYSRX2AdV9IXbq25ztMhTA9Tt6kRvKTaDDyHcH/9C7l0jZmksP5VpxQF/17ymUqEHL4VzcEgwExU89st8T+WvcVfkdKmxKVN/EQLG+zkRYopB/lFYDwruyNVRsyoQBkOnOLoRLnlkCcRK5mXAxcAToJFHyKG48zDpKRHM9JFPUxnq1jVVG5lxpjtkt2tbqNnekFBlhY40MW/4bDfXFfxyViHVzZZfq7oUCGvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VSnYiFZjnieh5dolACg7VBSm6VhKfoXO6gRUm75azQ=;
 b=lC6yRhzL6vTOQpl+sdaY1/moTi8bCmAouYp3Inq6wbP9ZwSvAElkftqtE1ss8JgwhfspLo/lPFXdtgm2lLvY5bFT1mVGNpNDaDmkhEYQBrENvybr0e4I7bKdJ3MHHXnl3zJgG8VvPuLJwVtecfBTFiMyjY27JwywCld4ASoNpDtI0GP6hYcSai7hJt9UltG7tiAOSZT7NiP4iQFeBDx36hb77wyxM/nria9tKcBv4IdO2F8SiyvsTbTOATy6YOzT5IQpJ3rPbgxeiRmUo2SkVAY+eImsmQL7L8AkxGtgl3n03TUZI7DHEAXkyhzcH6GzdN/9Q/kiYnecpBrbARCrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VSnYiFZjnieh5dolACg7VBSm6VhKfoXO6gRUm75azQ=;
 b=RnLGqqldMBXHV9SarRF6kjLja0TyTyHfIOCinaoLLLz3jO+w77SOjVjdx9ynNrpq+YymLGajwnYkBffjjLHVi7sZjBsJs9342LOdRuoXA/JioHkTUQ8aBiKqIHTODk/qVxSVHhBzHugQTX0ybj5Rmz3TXWA4MILbOJfIzEOOMhI=
Received: from MW4PR03CA0267.namprd03.prod.outlook.com (2603:10b6:303:b4::32)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 03:40:12 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::e9) by MW4PR03CA0267.outlook.office365.com
 (2603:10b6:303:b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Fri, 11 Aug 2023 03:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 03:40:12 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:40:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/9] drm/amd: Add a new hwmon attribute for instantaneous power
Date: Thu, 10 Aug 2023 05:31:55 -0500
Message-ID: <20230810103202.141225-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103202.141225-1-mario.limonciello@amd.com>
References: <20230810103202.141225-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: f35ec2d9-a612-4adb-91f1-08db9a1cab3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4bj4aId6IQ9xNLHl9ZdV3MH9E6JgWSh2UKocXJOHKXI3f9jvF8uKMIruWZIHK+o4ZrleEJxaFC36Z9nXIV3v6PY6Va51ADZcfI0adzyVzgKjPbr2NbJczddEOcSg7Q1Ki6sCyYKnwR6PUEb3iHAY9SD/yg0qxlIckD39jqo/7Zx+Dstd01kyT72JZ5weOmx3rmCyXMoMWTacyxQXiOYsV9ApwtM0pynfwet+BgoIJTZ5RN9y+1yzksLJvHT5Ywn6odXe0iS0s5lLCwG8WHA6VcEpCUu1nDmdFt/0RMO+ZwHLEfoPNOQ2eVSPg+NKpZQ+ApgH7KWnuTB46AjuO9Sejh7EH96YsqaoGak1OPm19jOa0UNMLmeXTIoezFSgqDxdKECXxKgH7rbvDjW2L7wP+VmlNxgA/tBTUKUt+mDlYzy9zZuLABhc33Za2Enx6+xx4FLx/0gAUt6fid69U1rpqE2P/O+j/v8MkYYRHXE0/gRFyE5M79wU/9LpQMK/RHwKZ46Hd1GYC6lZzoRydaq20PupX8RhopTZM2A+5QJVp4QiN/cNN77Xk5uXxpCiRjJXDIPIMHVwlYa9YToa3NcJwPCiJUcpX899NmkTRrffIL2kfKs7zG4g44Nv7b1Rgxs0BHWe7VkkTPZkT5i1pOtaf0Kq2OKRhLNvZzehW6czMd/dXiUJqCq/LH3cflO+5hRqrL4l+hj7VhXFnaz91H0OwTcC03KPoWVZynAbcVNddpnUkzXfh0a+T/TTwIcHnCFgsVko/MulWWlQgeMJ77EcVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(82310400008)(186006)(1800799006)(451199021)(40470700004)(46966006)(36840700001)(7696005)(6666004)(70206006)(36756003)(86362001)(356005)(40480700001)(82740400003)(83380400001)(47076005)(81166007)(36860700001)(1076003)(16526019)(336012)(2906002)(26005)(44832011)(426003)(2616005)(40460700003)(478600001)(5660300002)(41300700001)(8676002)(8936002)(70586007)(6916009)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 03:40:12.4039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f35ec2d9-a612-4adb-91f1-08db9a1cab3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some GPUs provide support for current power, some average power,
and some both.  To be able to support all these combinations,
introduce a new attribute.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c0eda9bf09824..816f034cfe3f1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2803,6 +2803,19 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 	return sysfs_emit(buf, "%u\n", val);
 }
 
+static ssize_t amdgpu_hwmon_show_power_input(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	unsigned int val;
+
+	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_POWER);
+	if (val < 0)
+		return val;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
 static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -3023,6 +3036,8 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
  *
  * - power1_average: average power used by the SoC in microWatts.  On APUs this includes the CPU.
  *
+ * - power1_input: instantaneous power used by the SoC in microWatts.  On APUs this includes the CPU.
+ *
  * - power1_cap_min: minimum cap supported in microWatts
  *
  * - power1_cap_max: maximum cap supported in microWatts
@@ -3091,6 +3106,7 @@ static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, amdgpu_hwmon_show_vddgfx_label, NU
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, amdgpu_hwmon_show_vddnb, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, amdgpu_hwmon_show_vddnb_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 0);
+static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, amdgpu_hwmon_show_power_input, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
@@ -3137,6 +3153,7 @@ static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_label.dev_attr.attr,
 	&sensor_dev_attr_power1_average.dev_attr.attr,
+	&sensor_dev_attr_power1_input.dev_attr.attr,
 	&sensor_dev_attr_power1_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power1_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power1_cap.dev_attr.attr,
-- 
2.34.1

