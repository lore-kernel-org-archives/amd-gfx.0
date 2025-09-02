Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A489CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E71F810E6F8;
	Tue,  2 Sep 2025 13:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PTpjg+a6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F1810E6F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQziaUwHTztlLHiomumiFFWz1IBuRNpmM31iXg2NLvRAZY0k6UUWFh7l8x6EAUnp3L4sEyA3m3MXiwl4a8KW3qEwx+EUTYOkvcsccyXegbYR7SnerKZymFOyL3dSkfetjYlmpRUE12/SQtUZoFAHOSAkyOEYEcWqBjiQJLVYvPnQGau0nxYZPuY5f5e6yiPLtdWX4mmSaZWaShriinS5DOPpC4MVCCvIdtG/s2HI1TRq+kJVUaGAUK0nojWpfOuZBZn9uJ6PXmmFETeM6XRoYfbc/I7WcQSjQ0thXDpMn+Tce9qu81kXS1eIH90wnTYcKRdCCMZ49JWBm9qWi+W5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcR7a2/LArVQD9FCalgYI2FTwpT6p0ZKmS+ORkcy0/k=;
 b=HQPnXbRmrLDywvvqIzeLjFRq0BfDZw3hSI9M8j6ja0O2lptnFYqeUJAtmPOZej4gBvj5TwfEu0+Em/tQS0pKtTXQ8My3U0fb+nJrVgFPbUV5lfA2SyiCDyxmzTXyABsadwpd+OQp0KNxnqdwp9HDLWOpz1pxYr6Eizqu3p7T8yc306jk/+llbnOe7JN8Scn6XXJsD+qCqGTSDqQjReQ02duYh44itHppQTDjdL60mkq41LKVLc83lYhAXGvpMaLI9vVQsEiitv51wSgUMKGivl7l+FbEre4uBsyqGudQoCA8cQKyVs0bDMH9Aeozjucp6FoP/0aSBiTuNhAQDScqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcR7a2/LArVQD9FCalgYI2FTwpT6p0ZKmS+ORkcy0/k=;
 b=PTpjg+a6HVTn/vn57qBX84e5ZAk/S9+eMwYMpvAKKJF/5NXzU9qEUeqqI1/MSNvKycA6Kk+Oe4cKPaasmBAf+73Qq4OQB16zaU8+jYIi4ENmMGi5y59mGyHPtjjWxMhPinkY86ZgvCo8J2btSMAQXHmXq9Zw61knWY8kHSkP2DM=
Received: from CH2PR14CA0058.namprd14.prod.outlook.com (2603:10b6:610:56::38)
 by IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:35:53 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::fb) by CH2PR14CA0058.outlook.office365.com
 (2603:10b6:610:56::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 13:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 13:35:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:35:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:35:52 -0500
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 08:35:52 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/8] drm/amd/display: Optimize custom brightness curve
 interpolation
Date: Tue, 2 Sep 2025 09:33:31 -0400
Message-ID: <20250902133529.4144-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902133529.4144-1-Jerry.Zuo@amd.com>
References: <20250902133529.4144-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: b8939adc-e532-49a2-bc98-08ddea25a383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lfgey3fh03T1kKWv1VWeRPj5oRkZGEGAq5/HrJYNEB6zTlmHw9cgTyvwbJtd?=
 =?us-ascii?Q?xmr+poLKHm7o2/e3A/lxEus7ojjKd8Fuos34WMOk+c0TsCjD1BTF89vfi5n0?=
 =?us-ascii?Q?IBCHpXuPplI82yYycKIvj+9YZjQn7OHjizBjFWVLtrbiS9zg44J+ErTS8E67?=
 =?us-ascii?Q?rxBTB2pruhWfeZH5+Onpcw/9LEMRuuAZJ4uxaxbm6q+IXoW/53kyBfvChQ7a?=
 =?us-ascii?Q?/PIdCCAy2Z2/5XRxkodpxtbGfRzBkbQbDaO0sY0mMajcgnUd1XgS5G5XyEXO?=
 =?us-ascii?Q?qsmxtblQZOHnlilUEaa+oEAdfltpGVpzMffWM4P7C0OzB1N+gQNMgIkEdRcn?=
 =?us-ascii?Q?z01+DMqrg4S7eF7tKuX2okHu6V/chaa2J99G/1ZZcOHewB1k60molui9ruwv?=
 =?us-ascii?Q?7DdJnBaVyMZFW0GuJBydL6uR7S3Q7LKPGJVnwbj1M2dkva1huDc81iibszb3?=
 =?us-ascii?Q?93R98vWMbDVsQbLJ1eFCxPmJRT2pLAqN48In3NeRvFJpD2c5430Y2Bu+vX9k?=
 =?us-ascii?Q?bp2BW8MH8IsJfms4T4jiT7m9fmWm6MecbUQMsPbirs7t5DEwJOlWBEGKsqCa?=
 =?us-ascii?Q?kre/YghlZlD3AxLTK9CkVoSViBp1mQfUtsUTcfqwqqVHdMDF3iHAEo6oCDUc?=
 =?us-ascii?Q?DXz7FjAT53adBV+8IeVx1+KGQVYCF6s/EkzYEUUJSZoGZEeMYGwY6X3L9zEV?=
 =?us-ascii?Q?jr8E40+UlpOFYHyBrsSCyvQx0KLDRy/8Axti6dumOXasD07iiMVGeCn5FqBn?=
 =?us-ascii?Q?RWpg7oB+XbWlNkElDdDiKdEEvBy7j6UD9WIs9mNdPMx1SPgprVfPlQBTGU7a?=
 =?us-ascii?Q?peCaQk/nGHAEIRuOivDGu/XkvmUKhrkJbrdMIUZWn+GGoRUhAyDC7x3I4BtY?=
 =?us-ascii?Q?M3hTwwMTMoDM1AdZOUCmYCeZ2IhGqJjFnxQuRB2kQTLqZ7ownVx5TTb3X4BE?=
 =?us-ascii?Q?Db2etTRlhsO6aC4eN2wwBLiHLR6cG3lEUyagjcRfMSpPMPk3oYWuj0pZm1hC?=
 =?us-ascii?Q?Aeo8wGcQp8G9xIW/jBy9qnNeHJcWq+EPhEKfR3dWTdi47T/hWLcVNKJicUSm?=
 =?us-ascii?Q?D6FxwYrNkTL1t91zV15ExT26qL4wHD1DiErbIs/kK9UH/rL5MN8fOzkDxYfW?=
 =?us-ascii?Q?ub7oWQOXofMUbkBYKppMu6DBUwb4/2aTDRY+dstUabCk3ER4v/5MMVkZK1Rw?=
 =?us-ascii?Q?a5wI02QwjxLIdPth6DXA305FiWh17jmjRNwB0ekruWz8ICbV8TWtnSpw+aaW?=
 =?us-ascii?Q?GPmDPTyX3/e7HFdGT3++S1E0FiCT8HKiAVP7tl5IZm6gTFJdFw3a+wUQ8GRX?=
 =?us-ascii?Q?9Cz/urz7/SwoiToJoL4rPFLeXjT0fcmP5FCjKqbY7oTDsSZCRpba5LCzgQbX?=
 =?us-ascii?Q?3qpcqQxvBY0k/3MzFfsmvKB/cWzyC9AP0GhopeY6q0Smrt7Dx41XCMr0U9+q?=
 =?us-ascii?Q?pGozy1TqnYLJLK5GB8cHzrQN9w2apkWptwhH6cOB/8+gkIEBZTsSYYa0cuod?=
 =?us-ascii?Q?+/J4koT0JfPqDMPbYXxucb9UeFXEDulGwaMO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:35:53.3929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8939adc-e532-49a2-bc98-08ddea25a383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
Custom brightness curve works by walking through all data points one
by one.  When the brightness value is at either extreme this is a lot
of data points to walk.  This is especially noticeable when moving a
brightness slider around how it can lag.

[How]
Bisect the data points to find the closest for interpolation.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 +++++++++++--------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 12eb1a91a4e9..242f98564261 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4817,8 +4817,8 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 				      uint32_t *user_brightness)
 {
 	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
-	u8 prev_signal = 0, prev_lum = 0;
-	int i = 0;
+	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
+	int left, right;
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
 		return;
@@ -4826,32 +4826,44 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 	if (!caps->data_points)
 		return;
 
-	/* choose start to run less interpolation steps */
-	if (caps->luminance_data[caps->data_points/2].input_signal > brightness)
-		i = caps->data_points/2;
-	do {
-		u8 signal = caps->luminance_data[i].input_signal;
-		u8 lum = caps->luminance_data[i].luminance;
+	left = 0;
+	right = caps->data_points - 1;
+	while (left <= right) {
+		int mid = left + (right - left) / 2;
+		u8 signal = caps->luminance_data[mid].input_signal;
 
-		/*
-		 * brightness == signal: luminance is percent numerator
-		 * brightness < signal: interpolate between previous and current luminance numerator
-		 * brightness > signal: find next data point
-		 */
-		if (brightness > signal) {
-			prev_signal = signal;
-			prev_lum = lum;
-			i++;
-			continue;
+		/* Exact match found */
+		if (signal == brightness) {
+			lum = caps->luminance_data[mid].luminance;
+			goto scale;
 		}
-		if (brightness < signal)
-			lum = prev_lum + DIV_ROUND_CLOSEST((lum - prev_lum) *
-							   (brightness - prev_signal),
-							   signal - prev_signal);
-		*user_brightness = scale_fw_to_input(min, max,
-						     DIV_ROUND_CLOSEST(lum * brightness, 101));
-		return;
-	} while (i < caps->data_points);
+
+		if (signal < brightness)
+			left = mid + 1;
+		else
+			right = mid - 1;
+	}
+
+	/* verify bound */
+	if (left >= caps->data_points)
+		left = caps->data_points - 1;
+
+	/* At this point, left > right */
+	lower_signal = caps->luminance_data[right].input_signal;
+	upper_signal = caps->luminance_data[left].input_signal;
+	lower_lum = caps->luminance_data[right].luminance;
+	upper_lum = caps->luminance_data[left].luminance;
+
+	/* interpolate */
+	if (right == left || !lower_lum)
+		lum = upper_lum;
+	else
+		lum = lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
+						    (brightness - lower_signal),
+						    upper_signal - lower_signal);
+scale:
+	*user_brightness = scale_fw_to_input(min, max,
+					     DIV_ROUND_CLOSEST(lum * brightness, 101));
 }
 
 static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
-- 
2.43.0

