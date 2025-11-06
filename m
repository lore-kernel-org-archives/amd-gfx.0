Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF178CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C6510E965;
	Thu,  6 Nov 2025 16:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U4m6syZy";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2973810E965
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZlLK51S8NaDjpMFa/4eKUc3LVZXWoNI+yoU8DXHFYqhpbKV5BrDn/cgjCQp4jvhLGxmZkTLAX5VSubCNzSVSciZfJhMC90TG1VP9MMpuyBakwG6prZ0TM1ZVcfislQGJY2nZJCvxGB1jT1wBKpMoSTuVszxr4hETq+xZW3Me+VTmAXztBMl7SkxjJjjPVHpgmRfReGgzG1rnhSV5M6kefT/FnrBNChgAEc4/a33I1YXkyTYVnXsHN4chqLIB1LAmEgvqEeehCzcJDjA5VFfi/TN53b/T7zf4Ia7qEDU74V/hJdkhMUNOpVvVXOWoEp/N/l4UvprKfB5CwzJAr24iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/355h534hFTxrUKXgFkpZc03Sm90vHsg5MaSLgdTZGY=;
 b=uRXLFjV00dr8N18de6aX096gxFwDpXYwPzGne2GK3gSOweywK/IdFoCRNi7Czj9lPoYpcS937hDVXXK7j3OYD4PprNCDanRX059WaX5bdtcnu2RInR/6gSKbdOOIwSrh+5fTiYwq4BD3wuUkRwOoyLyO9Rc/1aY4v8WYMzGgvj5TLUHqmuQ373F2XLWbCmGvU1mNadjzYHtDVnwZV7MVqf/VoRstfteEDPu/tVyv6v+u+TZT2QDdSzz0za9dQvOEbg66qi0pMypMZSAoBuYTKY7ibPBYI5YTv7k9OiIa9Dxa91USv4dVar1y24nsaOQXWXRXdPzQTFz9FK/+84OPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/355h534hFTxrUKXgFkpZc03Sm90vHsg5MaSLgdTZGY=;
 b=U4m6syZykq/K868oAJyOHJVFLo+CtngNb/+05XHsGKJOOZkWzucD+kb1QdhvK/yuN4Gql6o4bQDErlONu4OteaeVVTBbkzFbx03OCUNcZOjaF6wpolbxrCDFLCL1j2yQ6Bc6B4ypJY7ap8VLrnfsoRHGTc+qztQis38X254Pw70=
Received: from BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::30)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 16:59:27 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::97) by BL1P223CA0025.outlook.office365.com
 (2603:10b6:208:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 16:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 16:59:27 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 08:59:23 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Remove power2_average node
Date: Fri, 7 Nov 2025 00:59:11 +0800
Message-ID: <20251106165911.3786289-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ef8ce5-8cc5-4d95-5512-08de1d55d85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6+aD2O8RIk1YxSMxPl/ASXKfje2NMtGJvNCkNNn17iTN3xyJ1ByM/dt/JW03?=
 =?us-ascii?Q?719HsxW5Cj4pDoQ95c05RTlK9Ilc6FIuN3VaMXoSILyWCBgtfXEVNxAYcwwD?=
 =?us-ascii?Q?TAVbOfi2XxN4BpN8P9G99n+um4nOG5TtbfM5lgr5zauzjQN+/NLxI2BNBUqS?=
 =?us-ascii?Q?me8Zcdtoe2C4ftmTKH0P4ceJB3yNwlccfyeqZMkd9c7GVmEvWZPYPM3vS97w?=
 =?us-ascii?Q?X4NVWNeM6otOcuToGS99SHeTZdQ6f9435TV+9vq/rsDLZhoTbUWhtMJbVXDX?=
 =?us-ascii?Q?vlb0o/690fp6Bwd7XtEJZcJut2Cq/ZhcUrZX/v/L1DURUwCPIm9hTJoxD1DR?=
 =?us-ascii?Q?iSKyk5eXc67FJ1qWCK4+0Ik6w1VnIhAIJb8pb/JDxF5M7Wmbc715uxkj5+x4?=
 =?us-ascii?Q?qI9HzVwBjrub2GT5i62eQqQNwU4JUSyiV562bl5PiV9SFBCKg/vVYcTIsxR9?=
 =?us-ascii?Q?x3Zst7Yj7MSE4FA5PuPvSsfvZH9CB1kBeZhETJaLPUbhrK9VnAn0+wS93e2q?=
 =?us-ascii?Q?PzcebMYtncUigFrm6QSiVaz8ezgSZE+WLnqEOpfr0BUAxpglwotLhxfOks2p?=
 =?us-ascii?Q?p5SUtZ6fHlVGWlbZDBRIHFgnkev3QMQwQ72BuJMwfA+UzD5lKzzkzai4toXM?=
 =?us-ascii?Q?aED78i3rnrFCxN26ZdSePlSnWGAuyOX3E1d9ZCfDlAU9VKg84/8XxmWW7BKQ?=
 =?us-ascii?Q?51xZWk1jy6cacoqY/BEPqRAWZ24LytKEgPl9R/5bW7uRbCThDf2kQZn0NLyl?=
 =?us-ascii?Q?jKKQeBVtFtsHNaCSvD/7VnxIWP8TZjF+kAlI2TNIrQgwJZrSsLu/lMYO3rBH?=
 =?us-ascii?Q?KHi0a1ua/Xl1KMfCV6v3uf54ce6H/rdcqqCaVWgn4zHWEpBzoFdj0sSQyoRl?=
 =?us-ascii?Q?ZaZUy9/q2zZXgUEa6JiJ44+3Mm+X9N7koR40bif7thxbgZx7MZ5efqLb0i9X?=
 =?us-ascii?Q?9cF7rxjn/9tRlzJL/CdF3SPrz/S2uHYVk7iB57Yx9RjjZc4EfGXutsD/Bs4G?=
 =?us-ascii?Q?YnGfkzo809Cw7RxaLah18rIukQgErND68539qeUAG12SNFQbFJ2LuU9NwfT7?=
 =?us-ascii?Q?chmTAK3vGKJ97asF1I+wVLl10QCSE99FY2+30IP4dO0sdAL8tUrzCy1Rz5kN?=
 =?us-ascii?Q?nC40gY2auqP1ipB7aY3HTlOlChsTzTGbExcxoCeqQfih7Yan46eJOAv4SDUt?=
 =?us-ascii?Q?t32PYA2mtvJyXcknc47GbECxTr0MnEL0ssXbYR0nGERP4gbDeWyrUhzucEs+?=
 =?us-ascii?Q?QE604/YIV1qSeCUTdIMXjXueQalmMbA8hSJxgw4DyAMUG8J/z3OO9I+MwUId?=
 =?us-ascii?Q?6HqT/jFL51feBjzhBics1Iq47j8XyvykQ+7yQgd0+61q6NYJSI86GMhvVEg2?=
 =?us-ascii?Q?78JQBnBsArJrsZ6rM+1D53BqCIcl+Gv6hsgMmQazneWTbYEeLcaAZeLj8Qrw?=
 =?us-ascii?Q?VAKqKUwoPfusjuPMhkISqhUKp0T9qtWiTbrhTycmnKArs3P4/heKTeOaEHKj?=
 =?us-ascii?Q?9GUcTqir4tyN8TCeQD1TKiVqNVIZr5q2P/Rht1lz7AQqCAwnfdd8SUDSYNPf?=
 =?us-ascii?Q?hacsNNjCqFdpGwmShEE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:59:27.2237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ef8ce5-8cc5-4d95-5512-08de1d55d85e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
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

Remove power2_average sysfs node

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index fe7a2f09e021..d9e37fd6e186 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3580,7 +3580,6 @@ static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_m
 static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
 static SENSOR_DEVICE_ATTR(power1_cap_default, S_IRUGO, amdgpu_hwmon_show_power_cap_default, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 0);
-static SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1);
@@ -3629,7 +3628,6 @@ static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_power1_cap.dev_attr.attr,
 	&sensor_dev_attr_power1_cap_default.dev_attr.attr,
 	&sensor_dev_attr_power1_label.dev_attr.attr,
-	&sensor_dev_attr_power2_average.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power2_cap.dev_attr.attr,
@@ -3828,8 +3826,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* only Vangogh has fast PPT limit and power labels */
-	if ((attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
+	if ((attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
-- 
2.46.0

