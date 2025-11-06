Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BCFCCFA1A
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 15:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A7D10E933;
	Thu,  6 Nov 2025 15:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Er9typwq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3AA10E92E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 15:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr0ybN+cXasczlwrtZc/wSv1of3igWQsPagbd+KMODetJcSzBzwKe3eqbWUn335EYO8DC/DmmgrbTTsyvemcAOolmnNcgvWyURJHFpxOOhI25lrQmQD2Be7BqYelIO1r7Yulp49bOHtuX4UroDT23w6oaG1hStUXb0JeMpZu4YOuRvgdZ0IMuGHdOJ37GxmIFHN4du2le3ChSTsJ0e0q8TWxnGic3Bx68ZzWGFNXaCkxqcQViVCatRhTPc7rl+e9WhcbK4SmK/3AkeRQ1PPZBTkuA82EDXZn3RHRKEh9qsJMV1cLRS17LqNKAxuotsb6uBXzAY0VxEtKtmYH3tiU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91necv9M5aBegm0JNNxjkfJId25I8fEY7ZGTUDFcaaA=;
 b=MH+zbqDQlxhLBsj5y8x8HLQFlPxDl8fH0Tcx/h7Kbs3MP5xw3eVJltdmw1mzveWOzwb8hRLLpI4q9v9xsK08SSGbN80uQDr7JNIAy2dAdb8XD9cEo0PQeZVlNcsAsgRcW14FBIq+ClBXsgfUkF5ICtxpWz9jctvVfuxplJU/Lun66YAUqcn+UEr2yXEjrs+gT/thu5gBGn6HP/nJMP7OJuZej9WYgzJa9okCpkjRYvblSE6WeEazaKOx4uUcJ+KlUnFRBBfOv+vz05o+SG7O2w4Gl5udZGE3zVXCox3S8xwVy3la72K6L8Xks46m+hcox6cFDgxNddRofNEVVRzuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91necv9M5aBegm0JNNxjkfJId25I8fEY7ZGTUDFcaaA=;
 b=Er9typwqbe0hn4frPxgL/s1vH+rcTmKAoJvXr3Ve3AZObZ/Q5F+YGfblJluCcH8NZ0LIgXy3ZJgiG0oPzdKuRPQbmE2UdAZhyVyzGXIDR+qrxasITqsjh1qL0tHU6RuIb0B8QXSh9PdEdkppbgjNUIexTKe9jUsmN+0lkdGgr1U=
Received: from PH7PR17CA0036.namprd17.prod.outlook.com (2603:10b6:510:323::20)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 15:34:08 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::50) by PH7PR17CA0036.outlook.office365.com
 (2603:10b6:510:323::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 15:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 15:34:08 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 07:34:05 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v3 3/4] drm/amd/pm: Expose ppt1 limit for gc_v9_5_0
Date: Thu, 6 Nov 2025 23:33:27 +0800
Message-ID: <20251106153328.3783505-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106153328.3783505-1-asad.kamal@amd.com>
References: <20251106153328.3783505-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: d73afd62-93ef-4795-6f5e-08de1d49ed24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lwbjZdfyTBeF5ZNDbBP5JsZQzLr5+AzGVy1eyx+48lVYRfP0L82cJBvAak5/?=
 =?us-ascii?Q?0iYEwtGYx9TgEQxlKImuzhNntvk4+zbpMQjEuERfQcACUvTQ+ifQfibvgvbc?=
 =?us-ascii?Q?8qlkJuHiN0Pk2+mxM32kCxHSMC9CUv7CFEvLSf52H7Ch7D9L3dFkFiIetc1B?=
 =?us-ascii?Q?42kmDzHhsZktCndGgLmiTfNajaQTwUaWkn4WYrBqeDId5jP8g0CPp32TrU30?=
 =?us-ascii?Q?CRD0ubb4ZxR6x0C4pGFogWmIHOXcMJwcvwQW2I2ytEDfq/zuKDtGqncddTvP?=
 =?us-ascii?Q?hexhtK/TM16vBIXTMSVTgdEfTqoAdgSj0ouY0OHtLyTyWtBov9JX7crcibuo?=
 =?us-ascii?Q?e0znMfU6bKHgkjp61lSvsqwGkdeZBjfiC78zNI39levkQknOpVTaait+bvNb?=
 =?us-ascii?Q?sj+4gZd5IUdlWTyovdSpe+5ox+oo8kTM4eXCaR5Orepokdq7EDFML7aAw5d9?=
 =?us-ascii?Q?h6QsrpEd5OyrKa0psgsr7bCbYmEB8ALUAsPjb1ZDyN7p6x11/4ZSrMwnHM6P?=
 =?us-ascii?Q?clNTEd0Gd07woaj5UVyzCCd1r76Swi5R4iUyf+xzdy5tKVchoVk1vYYkDkxS?=
 =?us-ascii?Q?fAJlVN7VeJz4h4mofGoZrLP/ow/SrY9/lGqhWehZ5zaW86j2Nyxk4PV+/V6v?=
 =?us-ascii?Q?2K2K3GqwiDDu/YZlSwBUhR9+jNqewzqWEDewLVK73CBbj58zMvniz5ueelBz?=
 =?us-ascii?Q?OR2sXXl4XNqQnWSpnFyhU6ilfr9KyRPMowJndAAw0EWa/bMJoZpJFyU0eCXu?=
 =?us-ascii?Q?HZ8dsWXE1vkAK05wt+w41E8N8gmN3hO89u3hIv8aPgkus6jo0JtQJ+54A4GJ?=
 =?us-ascii?Q?yMyfIYboR5K1wUIFuTYzob4HZtWeUYKb4hpkA39HunFX+04Bx/1BlMiFnZWZ?=
 =?us-ascii?Q?gh/DMA1q8Spw/xWegM2mPjK9vj8uw6dM1QeQYYJ59CN5860v55rPKGNSlDf+?=
 =?us-ascii?Q?9KHQuBgnNpmGrEXya/y9QLAeBX38BrxDyGrGwA+7izRF6PjITNuWadCqPkTs?=
 =?us-ascii?Q?yW1cwImu9BzJBWqS7VGTBsy+tuLuiiDaMtefWwZA2aPl3o6g7HUs80zJOnR8?=
 =?us-ascii?Q?ncZs/Xf55SCBPd4QH9KbGfKcnh+wIujAzLUFkg0en0uL6g7+s7tTV44wLKFb?=
 =?us-ascii?Q?Ow39THEIO788zTUkuv/eTvFp/Do1omGzDhIszy+o3F+1FT9InmMkS4eEJkC4?=
 =?us-ascii?Q?EWE7zxpageB20AToc9wLwHnf3AeTilrFioXW6rZ0pCxeK2uFR12rvDOtVMri?=
 =?us-ascii?Q?gy3rLoZhhXdZOzh/dMGDZkoAAc7LmTMHjSXductgR5i6JAmccLmjeDdRFVHm?=
 =?us-ascii?Q?z7vvWJmlbCIYhYT4GhAlRIp11ljULpn3CMU1EtNTDPRd1coViSRg5FsCc87f?=
 =?us-ascii?Q?mxkN8DETpqBMLURPnQ2k4vQiwFUS2SSC8+zOUXQkP2NCye5SE23ayiNUYpob?=
 =?us-ascii?Q?Fiwen/3vFvc11XcDawVzF5wOSi/YnWZFd1/dEScukzr+ETDe2570MTs7ox/f?=
 =?us-ascii?Q?P0KUonKkq+Fvx9AX1ny3GMrerJ/CvdEOWNQ16satWEJp5QLT7xJ3ovgRUouP?=
 =?us-ascii?Q?s/5HLI1PtWS/7zBPyvw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:34:08.0976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d73afd62-93ef-4795-6f5e-08de1d49ed24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708
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

Expose power2_cap hwmon node for retrieving and configuring ppt1
limit on supported boards for gc_v9_5_0

v2: Remove version check (Lijo)

v3: Remove power2_average (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 15 ++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  2 ++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 69aa8e22f103..d9e37fd6e186 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3373,7 +3373,9 @@ static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
 				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
 				  "fastPPT" : "slowPPT");
 	else
-		return sysfs_emit(buf, "PPT\n");
+		return sysfs_emit(buf, "%s\n",
+				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
+				  "PPT1" : "PPT");
 }
 
 static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
@@ -3578,7 +3580,6 @@ static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_m
 static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
 static SENSOR_DEVICE_ATTR(power1_cap_default, S_IRUGO, amdgpu_hwmon_show_power_cap_default, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 0);
-static SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1);
@@ -3627,7 +3628,6 @@ static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_power1_cap.dev_attr.attr,
 	&sensor_dev_attr_power1_cap_default.dev_attr.attr,
 	&sensor_dev_attr_power1_label.dev_attr.attr,
-	&sensor_dev_attr_power2_average.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power2_cap.dev_attr.attr,
@@ -3826,13 +3826,14 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* only Vangogh has fast PPT limit and power labels */
-	if (!(gc_ver == IP_VERSION(10, 3, 1)) &&
-	    (attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
+	if ((attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power2_label.dev_attr.attr))
+	     attr == &sensor_dev_attr_power2_label.dev_attr.attr) &&
+	     (amdgpu_dpm_get_power_limit(adev, &tmp,
+					 PP_PWR_LIMIT_MAX,
+					 PP_PWR_TYPE_FAST) == -EOPNOTSUPP))
 		return 0;
 
 	return effective_mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c0e7c45ac0e6..8b49fb86c77b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2938,6 +2938,8 @@ int smu_get_power_limit(void *handle,
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
 		if (smu->ppt_funcs->get_ppt_limit)
 			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
+		else
+			return -EOPNOTSUPP;
 	} else {
 		switch (limit_level) {
 		case SMU_PPT_LIMIT_CURRENT:
-- 
2.46.0

