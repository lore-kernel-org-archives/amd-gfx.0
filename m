Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331CDCAC598
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 09:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F2110E740;
	Tue, 16 Sep 2025 09:05:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gnus1ut8";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF3710E740
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYpi+Je7QE3xRSzGdL+HQI+bImYzy/ytgPGJhJy28S1kq5Yt3325nGNQz73G8I7Yazy05aAeHsJDmjJrKh8UbsI1oHVTeZMNK4a/aVHepZrs7UarqRhIOl3I2oaHDdhQ/qG+3ZSvmnf+PZ/ILDlZcgiYpIIROeY4GMX212PPIq5YdDMBwKkiZdPYajfm8BZrq/NmLIqevxA1paHSEnNIEaPiI/dSiE7ALI3a9YIawFwhmPA0QKiWoCXY0jVwFQh+vM/dr82RMVq1YOSud8VqZeqdg52dmsFBk5D0v0NpBp6LQClX7douaBbR435/VnUBVH331440abFKRiPKAFeAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJkjF3w7p7czxsvulzAky9vbPJfpYTWYcueL5htUlqY=;
 b=ujwSYKelHDIeCv7c0gsDLyPWo0oUHiHCaSmhYikrpF2x2pzHWQwVZr7kobi5FmBavhvrLt788CqWA99jZ5UB2Z9u8rACh/LthZGs2tmU0rv73judJXgdcygS14NoYVBZj+xvgA6O6FgBkfCKG++Z4Ny9welWecPpBYqnh++mdpkCFwDsMVqP7Zm9VhcXklnSIW5Jz+vfQyGLAdsYIy6xtn+4rGgOn5VFt/H7x2jX/ij+VXJDflcHAaZ06YZiit/yRRjfwvwblqYA3AM72r0O+dEFDj0rBX++Rv+6ww/KcerRMexot7x3u5QHAkHzQE/Z92w6Tst0cSK5dKUaH4rEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJkjF3w7p7czxsvulzAky9vbPJfpYTWYcueL5htUlqY=;
 b=Gnus1ut8KbGE9qSH4iKyz/R12j61ilMBMMv4Af6cAlP1kz0Ij8C0BJ8W1kUCzbuULHHGhtEhbgSpBFzy3n5ibbbhvpQ1+O/knlx8SdJ1JWIP32xSmU+/1cwBqKBSt/Tw1jC79l2G6A/uUzl1BD79NFsfxAd4SRMrdzy0sw0F3xs=
Received: from BY5PR20CA0022.namprd20.prod.outlook.com (2603:10b6:a03:1f4::35)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 09:05:44 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::e3) by BY5PR20CA0022.outlook.office365.com
 (2603:10b6:a03:1f4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 09:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 09:05:42 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 02:05:39 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 1/6] drm/amd/pm: Rename amdgpu_hwmon_get_sensor_generic
Date: Tue, 16 Sep 2025 17:05:22 +0800
Message-ID: <20250916090527.2727930-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d2bf92-8ce4-40ba-7304-08ddf5003724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WDMbx1IUydbJDYrpqtGgZ/ie8F9VRrc3/7p4YdtVR1O7Nr+hwSEqowrLwZnn?=
 =?us-ascii?Q?sbhzI7EoQOPDBBDXTCTmGWBys8sGhmWDjzOaqjzkW5xBrF3lenOSA5qVs/I/?=
 =?us-ascii?Q?l+8nhnVtCP45ptu6YkLyI4cYN6JIi2aR9GzyQztXwTgyoa0IMBFXfPTLTxJN?=
 =?us-ascii?Q?eV21RK1yfxoT8O5S4KpiJVE0NuXG2jJugwc3gIDPJUTx3pV80K8HwSo0+X+P?=
 =?us-ascii?Q?1TFBp9ULSw2nds0jrYhMh6gUwcNJEzALrvGvsSRTAa/Oyl95XPNSJ3S52NiR?=
 =?us-ascii?Q?BRsumkWUB4RHYBS8IxQEpXjP0TstMiu0H5tvZNLZBJe4MmoY0UZT8EMY4444?=
 =?us-ascii?Q?+RlVdou1jYxrYnRCae2veGtWkYSVEDiF6Q3VJAFab7C7oNXovwcwx46soJ4k?=
 =?us-ascii?Q?onWeGXzy/woNfxTmOSu0xbBHqdAlUkfqGTiwoLx2z3fbEYai90GWijv8IyXD?=
 =?us-ascii?Q?TQKbl6c2TWN7X+PQKnEslaX8NlAAUw0/eiY9i4D1il1vh/zpjuZbx2BdZTae?=
 =?us-ascii?Q?ilEpJnBTiAXJopzifMVD+VI+nS/0z3wOS96Hk2V8ocP6R4aEZFCcHPP72Ti6?=
 =?us-ascii?Q?VhtBOh3Y3nJI/gVHeYAswNaCw9nsgMGubAFksIwZiHNaByw5FyHCqDJxGyo9?=
 =?us-ascii?Q?KQF0g+udpNnW/4mLsECCrbSHmAkWUq2ouyqth/0wghkaFUrG6vBozRPAT4qR?=
 =?us-ascii?Q?KM6hsjsP+XE1g5JsUVpRH4/BH6ngSIrKtTTcHtjqaWwms69tcSW6DS0ijYXp?=
 =?us-ascii?Q?9XkNBbnz8nafP4YzjrqlKB304mY/MjiYY229/8Ig6eMEbT97+g+f8IscUP9S?=
 =?us-ascii?Q?NLiMnjUHfOX2bixv1N3uLnqO3MUvuKAHw3HeO/UOLYghWQDVxjGLDQd3l/mg?=
 =?us-ascii?Q?CKbNVl48Ss18yy64ppMwQBJ1f0MBVF5Ak8RVwJEEic0f8ffaI9FBhnACWzmB?=
 =?us-ascii?Q?gO+r34jLEhq5Q5cYOTjL89W/4lSL+k1VFM3A7gdfu7pMH03Uln2cmrobv+hr?=
 =?us-ascii?Q?gJKTd14G2Jyr3Bum/5A+z8yyks+stFDqFHutFg6JLe4rbpurNYZu8pWxnTKU?=
 =?us-ascii?Q?JrZ0Te56G4qm0MbFwPJpeqYCQG47zhHTihEUH8BL381TBmMb41q6uHK4YH90?=
 =?us-ascii?Q?ZnXHm5irqZxHKYRRkBcBirIUFiN5jr2YYzG5Fd0X2EDJ/1nCSFxrgdx2DaTp?=
 =?us-ascii?Q?q4wGdmOLq0ltvaBzP7gW3MKbMkIat14ejzqwktLrPYYMd8xQGPZ10m8Zilbm?=
 =?us-ascii?Q?3CaDucSzwRP9jBLoJuHtF7RWdmnT6Dm+ylF5KngE1ADY30wjAE3Od6Bwadw2?=
 =?us-ascii?Q?EOM8uMHBtGC1vx/oqwoOrv4pJbu7Sv+MPE6YlTZHv2COrOtuOqpmWBLYqFky?=
 =?us-ascii?Q?ZlXG+Yj09PB04BKsPsdeW6QWRmqAOxNeSBemULRiUV51W7mKbkL5kvmVEweQ?=
 =?us-ascii?Q?zMia2SMY90vS/u4IMYXwBndEFOGnw4SFBNxZvZN0cwchIlMaEKSTdn3olFpG?=
 =?us-ascii?Q?e0OuV1+3F/hrlyHvZRwdLJhv9FrZNdRB5hUe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:05:42.9077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d2bf92-8ce4-40ba-7304-08ddf5003724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
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

Rename amdgpu_hwmon_get_sensor_generic to use for generic pm
interfaces

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 76 +++++++++++++++---------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 3e935a89d279..57821e59d3cc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1421,9 +1421,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	return -EINVAL;
 }
 
-static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
-					   enum amd_pp_sensors sensor,
-					   void *query)
+static int amdgpu_pm_get_sensor_generic(struct amdgpu_device *adev,
+					enum amd_pp_sensors sensor,
+					void *query)
 {
 	int r, size = sizeof(uint32_t);
 
@@ -1456,7 +1456,7 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 	unsigned int value;
 	int r;
 
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_LOAD, &value);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_LOAD, &value);
 	if (r)
 		return r;
 
@@ -1480,7 +1480,7 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 	unsigned int value;
 	int r;
 
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MEM_LOAD, &value);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MEM_LOAD, &value);
 	if (r)
 		return r;
 
@@ -1504,7 +1504,7 @@ static ssize_t amdgpu_get_vcn_busy_percent(struct device *dev,
 	unsigned int value;
 	int r;
 
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VCN_LOAD, &value);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VCN_LOAD, &value);
 	if (r)
 		return r;
 
@@ -1783,7 +1783,7 @@ static int amdgpu_show_powershift_percent(struct device *dev,
 	uint32_t ss_power;
 	int r = 0, i;
 
-	r = amdgpu_hwmon_get_sensor_generic(adev, sensor, (void *)&ss_power);
+	r = amdgpu_pm_get_sensor_generic(adev, sensor, (void *)&ss_power);
 	if (r == -EOPNOTSUPP) {
 		/* sensor not available on dGPU, try to read from APU */
 		adev = NULL;
@@ -1796,7 +1796,7 @@ static int amdgpu_show_powershift_percent(struct device *dev,
 		}
 		mutex_unlock(&mgpu_info.mutex);
 		if (adev)
-			r = amdgpu_hwmon_get_sensor_generic(adev, sensor, (void *)&ss_power);
+			r = amdgpu_pm_get_sensor_generic(adev, sensor, (void *)&ss_power);
 	}
 
 	if (r)
@@ -1906,11 +1906,11 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 
 	if (!amdgpu_device_supports_smart_shift(adev))
 		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
-		 (void *)&ss_power))
+	else if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
+					      (void *)&ss_power))
 		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-		 (void *)&ss_power))
+	else if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
+					      (void *)&ss_power))
 		*states = ATTR_STATE_UNSUPPORTED;
 
 	return 0;
@@ -2636,18 +2636,18 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 	switch (channel) {
 	case PP_TEMP_JUNCTION:
 		/* get current junction temperature */
-		r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
-					   (void *)&temp);
+		r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+						 (void *)&temp);
 		break;
 	case PP_TEMP_EDGE:
 		/* get current edge temperature */
-		r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_EDGE_TEMP,
-					   (void *)&temp);
+		r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_EDGE_TEMP,
+						 (void *)&temp);
 		break;
 	case PP_TEMP_MEM:
 		/* get current memory temperature */
-		r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MEM_TEMP,
-					   (void *)&temp);
+		r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MEM_TEMP,
+						 (void *)&temp);
 		break;
 	default:
 		r = -EINVAL;
@@ -2909,8 +2909,8 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 	u32 min_rpm = 0;
 	int r;
 
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MIN_FAN_RPM,
-				   (void *)&min_rpm);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MIN_FAN_RPM,
+					 (void *)&min_rpm);
 
 	if (r)
 		return r;
@@ -2926,8 +2926,8 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 	u32 max_rpm = 0;
 	int r;
 
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MAX_FAN_RPM,
-				   (void *)&max_rpm);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MAX_FAN_RPM,
+					 (void *)&max_rpm);
 
 	if (r)
 		return r;
@@ -3060,8 +3060,8 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 	int r;
 
 	/* get the voltage */
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDGFX,
-				   (void *)&vddgfx);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDGFX,
+					 (void *)&vddgfx);
 	if (r)
 		return r;
 
@@ -3077,8 +3077,8 @@ static ssize_t amdgpu_hwmon_show_vddboard(struct device *dev,
 	int r;
 
 	/* get the voltage */
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDBOARD,
-					    (void *)&vddboard);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDBOARD,
+					 (void *)&vddboard);
 	if (r)
 		return r;
 
@@ -3111,8 +3111,8 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 		return -EINVAL;
 
 	/* get the voltage */
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDNB,
-				   (void *)&vddnb);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDNB,
+					 (void *)&vddnb);
 	if (r)
 		return r;
 
@@ -3134,7 +3134,7 @@ static int amdgpu_hwmon_get_power(struct device *dev,
 	u32 query = 0;
 	int r;
 
-	r = amdgpu_hwmon_get_sensor_generic(adev, sensor, (void *)&query);
+	r = amdgpu_pm_get_sensor_generic(adev, sensor, (void *)&query);
 	if (r)
 		return r;
 
@@ -3284,8 +3284,8 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 	int r;
 
 	/* get the sclk */
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GFX_SCLK,
-				   (void *)&sclk);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GFX_SCLK,
+					 (void *)&sclk);
 	if (r)
 		return r;
 
@@ -3308,8 +3308,8 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 	int r;
 
 	/* get the sclk */
-	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GFX_MCLK,
-				   (void *)&mclk);
+	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GFX_MCLK,
+					 (void *)&mclk);
 	if (r)
 		return r;
 
@@ -3607,10 +3607,12 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 
 	/* not all products support both average and instantaneous */
 	if (attr == &sensor_dev_attr_power1_average.dev_attr.attr &&
-	    amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&tmp) == -EOPNOTSUPP)
+	    amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER,
+					 (void *)&tmp) == -EOPNOTSUPP)
 		return 0;
 	if (attr == &sensor_dev_attr_power1_input.dev_attr.attr &&
-	    amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&tmp) == -EOPNOTSUPP)
+	    amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
+					 (void *)&tmp) == -EOPNOTSUPP)
 		return 0;
 
 	/* hide max/min values if we can't both query and manage the fan */
@@ -3649,8 +3651,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	/* only few boards support vddboard */
 	if ((attr == &sensor_dev_attr_in2_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_in2_label.dev_attr.attr) &&
-	     amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDBOARD,
-					     (void *)&tmp) == -EOPNOTSUPP)
+	     amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDBOARD,
+					  (void *)&tmp) == -EOPNOTSUPP)
 		return 0;
 
 	/* no mclk on APUs other than gc 9,4,3*/
-- 
2.46.0

