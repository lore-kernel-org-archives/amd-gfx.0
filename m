Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F0CCCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 11:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF0910E8A4;
	Thu,  6 Nov 2025 11:44:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GE+7OK+7";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 506A810E8A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 11:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0hFb9pciZpVeK3hGOlFskl53721ayZd5uOsbenX0DJrDg13lXLfjI08BAZzpFPgiJX8Vh9TC1Mm9tGBsSzGd1HMipTV/o1r1CbyrmRTw4en2mc7oX+X6fJApBGyA6gQwYVMmrtopSaE2spGd56vIr8QnQRKZGVkP1volJRTUKVBIr7P10nIRE4jTV0aHpQOu1V4dqXUNQLBGDkDLLpjCnZL08GYh72nYHlTOQvug4V0YmRIBrNC8QHHRkVrVWxY8dOj++mDtQSJFLcPDkqJRHniBLcPiO/dt591tz2i1mkN3wfKvMuzHhR6YK05kDffKkohUmARca/N8jYRnm/cYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wamvpF1hxaPrGw6hYmFfwrA4KZe9jsL1QvD6kfNJWu0=;
 b=ok6Nz+h6Wh6sy5sQ7RsB5nHU3HqYrycM3RLbApQzZV9eqcPAStlMCTVbNnDubHubkIJU5MEGybbXDcdZakbOVyZQ/jtFvx/Cpw3ntkwJbDoOJ2P4fnhbH1XtC6RJLig6B0QseYxfsIj3hv0snQ9SVN6tsMEE5tWzNODQ26XPIA698FYs4bnOxrKDAUJNU/CpglVep59EnOwm418d7KGtJ6ds/FFNWp8kXvt5xlLcEqLQvPK8HOd40eYadphP6h5iSWK8VcIg3Cu55W1WyNRcmfJk87wthkuZBFFifMuWuGiSHDmL+B54gpxKkcgHaMfk7Pg7Mz+PMB7L1oV3XfI9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wamvpF1hxaPrGw6hYmFfwrA4KZe9jsL1QvD6kfNJWu0=;
 b=GE+7OK+7vDe8pNejlqsB0P8LEODP82dxVxyml8uHpmFHtsCiWK9XBhuS0MVR+hoMoesF2cd0Owp8UXS2y//NrGlmIXrlt15JdLyWmn4jgLCMcF1Ce7iLa/Hn+lqraniP7q2vMPQrZsjZP/8gEGdKBZ6Orc+DVgEQxDQHtDpDCe8=
Received: from MN2PR22CA0009.namprd22.prod.outlook.com (2603:10b6:208:238::14)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 11:44:40 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::ec) by MN2PR22CA0009.outlook.office365.com
 (2603:10b6:208:238::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Thu,
 6 Nov 2025 11:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 11:44:40 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 03:44:37 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v2 3/4] drm/amd/pm: Expose ppt1 limit for gc_v9_5_0
Date: Thu, 6 Nov 2025 19:44:20 +0800
Message-ID: <20251106114421.3770378-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106114421.3770378-1-asad.kamal@amd.com>
References: <20251106114421.3770378-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 31eb1c9f-1bc9-4b47-74f4-08de1d29dee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|30052699003|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JndGiUsJjn3wy1rvx3fFmFzjfwWFWlBDg3kWCxUv23KiI5TudUC8mBda2Lbz?=
 =?us-ascii?Q?oOJnD/pA6Ie/VElJpHktmYtJgePR4q3Qza+nDALLdhE7SDi7R/GFy6E6G+2+?=
 =?us-ascii?Q?HgLN23Ra2DBwdtnZAnpP10rv0dbdlAEj/NYAV6ZLn5Te1s8Uhub7H5bZQvVL?=
 =?us-ascii?Q?CE+DvQRUC+m+bo3eDAPNR8vdQqApqW/5PdtVF8I9SjwZH0AAlcd9JZNTGP+J?=
 =?us-ascii?Q?8dBIMZRngomm2gmZQDVKgbZaFAwjeH4gmd1oiVFbRPAGhm+4pwDD5xBYKtz5?=
 =?us-ascii?Q?YC+jUW6CY0xyr053YpMDV0ccin0uGvGQz0N/LYEZFdZrtFDUmKVR7TKSk3x2?=
 =?us-ascii?Q?kOB76Xxmp1T/SMjxPiLrzw2BaKBHbb6CTrrmy/7sHPy9MZOyPzHiEoLbTXaE?=
 =?us-ascii?Q?qUsKRWogl3sFBBQea+lVQ3qGsrhTuRNYyLWHvy4RB82TQOeZ+XDqLmfdig3G?=
 =?us-ascii?Q?ZhjczKKM2Rn/2NPZ8TJYWq1gexWl+yxCx1/SfCDktSf57+qmizbKJwmIeuCW?=
 =?us-ascii?Q?1FtqvAUGhWLLW1VfLJOl62e2ywU6thRcf7EYin9R3QH5E1jcpcc1854FyXvb?=
 =?us-ascii?Q?7JYndKeuqVNLKm69WfhrHoB4IFmCCeE73G67kPu3M8Z/Sa44CvYcBrubnBT4?=
 =?us-ascii?Q?p/DQyfI85ZIrF9/XNvwoPu7e9qpGdQh6UBNX8ES65uTcoZT+DgF0QsKJ2gEU?=
 =?us-ascii?Q?VujAm9l2/yXthN6hY3jyMbzPGDcX6KCEe4z0Gm3PD7zm6wkYp0nLTjdzJQ/c?=
 =?us-ascii?Q?shbj4adbzcJ3Ffx7ESv/wQtAY4bP4qOoqPkHRiFlWReTHAKyAIAbEnWm7ZgF?=
 =?us-ascii?Q?sQS1mrd+FASPL0ragoggWa2BS9yAsMLsHhFIFHrhcoZLNTZjP/3PpanQAuNp?=
 =?us-ascii?Q?gKVlfgotD4I2O4gAkyDoK/A64ZnP7mjlxWSIT+uIeVWc4dYb633nY8qK5+Mv?=
 =?us-ascii?Q?eREskI3zAd76fJiTPZJ9n+L7azAsZxdWNm99xsJuKJLZvinVouemq8zM0mV1?=
 =?us-ascii?Q?0FIdCEoAYICaTNGLEH5K3tbnGM8dPLrlaYB7xmKHl6Yv4gNAQ0CQq3SPcctw?=
 =?us-ascii?Q?6oqWx/XMXSG1oV5AF7bHIg2A18LP1sahSKcdIZVLRs1cPDxt/SzVH3U5HQju?=
 =?us-ascii?Q?tlQ5amQsouMlyt1FjfVYh36d1ZD+b8/MRE/Wex7fBU5qWFVwwqiGa7Ls5Op/?=
 =?us-ascii?Q?EbeL2duysgz4mMsyEbRfbfjy+JV37CW/2qfqzB2to8XcPCE5+l+8gOsluYBG?=
 =?us-ascii?Q?lf9htVY64FtBWVhkNEy5UdwAD5uUxzrUcTjIyu5aquPvi8wEisq65jWc+k/C?=
 =?us-ascii?Q?Bz1qN+PB/EtHKZ6xLrOUqJYgVqrOxFoyDj4A6jTjpPFzO3QBKsBUdpvb2Pka?=
 =?us-ascii?Q?4zfKmmGf0j9DQoPFnN/LPd8Yi4cRiJIwAE0/SorF5T/8gp+P1w+BH2egvBKZ?=
 =?us-ascii?Q?/LLSHh4RfeKZAaUd5s5/JL5fI2yUPsyq+t6yGqzMnqFOoTLJ7DKvmWGnrxIO?=
 =?us-ascii?Q?RLkrC97QVXEz06Yq86RYKYATThiMBvb8SjVCZIrd727ES0ekV2UvRfwOS9bJ?=
 =?us-ascii?Q?dVVKYukK8icEuXbZcno=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(30052699003)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:44:40.3195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31eb1c9f-1bc9-4b47-74f4-08de1d29dee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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

v2: Remove version check

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 12 +++++++++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 69aa8e22f103..49cc5aaa749c 100644
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
@@ -3737,7 +3739,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* not all products support both average and instantaneous */
-	if (attr == &sensor_dev_attr_power1_average.dev_attr.attr &&
+	if ((attr == &sensor_dev_attr_power1_average.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power2_average.dev_attr.attr) &&
 	    amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER,
 					 (void *)&tmp) == -EOPNOTSUPP)
 		return 0;
@@ -3832,7 +3835,10 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
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
index 4317da6f7c38..73a063748c86 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2921,6 +2921,8 @@ int smu_get_power_limit(void *handle,
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

