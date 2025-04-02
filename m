Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380FEC3601C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C28110E82A;
	Wed,  2 Apr 2025 16:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZ+oNrxx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332BD10E827
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDeT+KvZD5oEGLFwWcxlOujSS7f9NJ+iwn44j4DHO1ggd1/nV+y6OQVC7f4LO4wcIRQeAXqsCwRB1aYfxclUeormcRezu44XG7J7Tr3cXs6+ta4nM0cKQs7OEeWt2vwcQvIjO7/N7n4IfcvAzyVaDPVLhufziITqU4BSNmJEdg7pcVs056KF0b33oYq+hcGuPkOm2FsKhuVeYOduGRFiqRvkQvEu6ZLI9/eEX0Wt0uHHP/nET+6V6kKwu/Qm1EDxFbT0JCRSSx5Hphwfem4YS9M2SAuvXeOUSSbix/cPoTyhMR3Vp/tETi5McQGFxFaIFsC+JSMEYCeqCYykVaR2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71NgiQt1VBT7O8QFjbXCGXVwSNVGFqmk2h3INJ/Mh5U=;
 b=A7PFYOSbPMUauD/hmVFmafR899QSHHOySCZlkoIpyBVL2I6ffKutFUmVAeSxwleFp4AuChLknlt47dTgmYnchBYhDXBfUuzlPHDo0QcPQm4rg0pqOECpsaDZa2B8Utu6LVvQfRvNNhPjEkCtn7UuinyccsGDCVlJEkugO7KhChcApKpcJBwWaJPGpMhuexgFhwSSOHdnrQN3NybiFAEVoYgfeMZvLfKXt26XGxxQlOEMZBYFAMce81/BcGiwp0dh97jfrjNnBeu/xrasL58xv9O1rq7n65Uk9CoD7NN1kJ19K/+cm4G/u6J3dOg2UcwQ+Q8t6yZRsh1oX02n1LsBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71NgiQt1VBT7O8QFjbXCGXVwSNVGFqmk2h3INJ/Mh5U=;
 b=hZ+oNrxxYhYBheMFNI2Z8cOCyPI4qT8XKDTtcT81WT2su/DtjT0njhDUbXyorNYPXUsMC/vdiVa0tWLGJITz83fJ8/Km1dfQpBPYmO7B2g2QEuKmJNkQVTmiL/C7uZMLw/V/X329xYPNSemDVMsLd4Vb4qjmz5yI9Ph0e5bG/4I=
Received: from CH3P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::27)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 16:13:39 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::a4) by CH3P221CA0026.outlook.office365.com
 (2603:10b6:610:1e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:38 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:37 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Optimize custom brightness curve
Date: Wed, 2 Apr 2025 12:13:05 -0400
Message-ID: <20250402161320.983072-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4b9f8d-48a3-421f-27e4-08dd7201544b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wbXXDvYEa7krOmHid+f1i0ruRufOt1rnRmhBl3+3MP8W3kKX2bc0dTucSmjQ?=
 =?us-ascii?Q?YwGx+OF4Q0nM7BKBj4fP4AQ+qIjMbEwUiO0mW9EaesqsBXjcLstfcXKlWp7B?=
 =?us-ascii?Q?v+LR6BMFMBbeQCDILaKKwhRK7fSIfNrqGlCMTl08QpDqXx7Efafp0Zpvi1o0?=
 =?us-ascii?Q?4b9t6eXNbpK4p9FxKn07RWUUjw9RKYlnhKzadD2x7zN/PR8twkDEdw8SXg/B?=
 =?us-ascii?Q?Xm2zUZVixBUZqN07K58P7RBALind0vB5V8VgPXSk8z0rqz1d9imiyY3RFoQJ?=
 =?us-ascii?Q?ycN7cq66fdMFiAdg3GwErnn+94jOLnv+QXCedW6LhYoiVL8QYwqPSTl59/rx?=
 =?us-ascii?Q?lIdXk7gZiGTzWUHtl/uuzuQomxI69i6zVwVGElmvsZAIXlQn+u+7ROA25YhY?=
 =?us-ascii?Q?EqJIViulfDxag7lIIuakxWwl67qkQTz0UUlS6mPTKU2ZWDnrmLX371KEH/el?=
 =?us-ascii?Q?uK7kcf6XKwSYXVucXPWxLT2d/Vj94E+yyzkJ8aCrq76B46jELn60jGqLFv6n?=
 =?us-ascii?Q?0QVyUeeB2NIVZeZdqzH+Qr9eMQyyX4NXIh9yl6UdL7TgcA3MwNiUF4l34zxo?=
 =?us-ascii?Q?6+0EsGKcSr5UbZFdzY7ySrPPV8yojM9ImhktjidELfN9vyCAnjbgg2DtnVFQ?=
 =?us-ascii?Q?v0aHGWlQwvcu8QjmywKl3kCSwimwc0JxfiQrsCkOF6SBJCDVBCdKatco5SY4?=
 =?us-ascii?Q?eUCsQQSXp5+67bfJo7hsHSYjh5zUzkY5box13F6Zh55NeLajyGRrj7651ed9?=
 =?us-ascii?Q?0TCfNcxN3mm8GNCmp5wLIAoD7itUA1FTdFh3ejImdUELowcuY+nHz6e3xElF?=
 =?us-ascii?Q?hB2WZMKwEInz4KyaIGKBM126fVI30nB+GDnIngWvDYAOnYHKqf3gQjHaKQhD?=
 =?us-ascii?Q?QgEu/9MJcDnKePi5ZQwO+BG7cpXz3nqKmhZCCW+j2NWk/pNznV4XZYtwo66E?=
 =?us-ascii?Q?Fy660APKl+jNwm+lHIMrP0OCRJL/qDfqnYKy7HzwuPiSgXPX9FHnC5BM83ll?=
 =?us-ascii?Q?WRrH93D0u3Wa80GN3GTXa1MBlSBejynsI/fyu80hbPFb+4iU3MXygUWCJsaD?=
 =?us-ascii?Q?9Etzl+yY0NubZ4Qkp9GQIsRcOTwSQoB8yhHvDDvTt88aYU6A5UwlSBJm0NBD?=
 =?us-ascii?Q?4vlHBMBPl2Kf8Vvq4o6bmH/WMBSnkLurnryT9qa5Pp94pI2c/h8bAyInLVrf?=
 =?us-ascii?Q?8hQQQ1chjOfOCLH4Zwr5WqN2u/E4+GvFcX1LMwm5NFsXQzNc7YLcrJMC8MEx?=
 =?us-ascii?Q?E+ChoxfkRIWlv0IrfWQJJ5y9f7S39iRYmDNmz9s3spqpWxxvXCOmBqlPr++h?=
 =?us-ascii?Q?D+uRceKw56wrWvdf+8r2JrMay1oleM8xbCmVuZmrQQz5WZhCF722GmHv1HuQ?=
 =?us-ascii?Q?cJg+fP0vF7leEhTym09T2q8UuQQLAEuksAnxZEDjKf72qgHwBe5nlkIE42ee?=
 =?us-ascii?Q?6IL/bmN9eCfGDxQ8JJFnu6dpLDv+cu1NRgKWHsc9nqClL5Bkm8QP++EWjN1D?=
 =?us-ascii?Q?HjbXZbBtky/5xeg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:39.0598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4b9f8d-48a3-421f-27e4-08dd7201544b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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
When BIOS includes a lot of custom brightness data points, walking
the entire list can be time consuming.  This is most noticed when
dragging a power slider.  The "higher" values are "slower" to drag
around.

[How]
Move custom brightness calculation loop into a static function. Before
starting the loop check the "half way" data point to see how it compares
to the input.  If greater than the half way data point use that as the
starting point instead.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 53 ++++++++++++-------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 867999cf49e5..5105d4b5e972 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4797,41 +4797,54 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
-					uint32_t brightness)
+static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
+				      uint32_t *brightness)
 {
-	unsigned int min, max;
 	u8 prev_signal = 0, prev_lum = 0;
+	int i = 0;
 
-	if (!get_brightness_range(caps, &min, &max))
-		return brightness;
-
-	for (int i = 0; i < caps->data_points; i++) {
-		u8 signal, lum;
+	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
+		return;
 
-		if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
-			break;
+	if (!caps->data_points)
+		return;
 
-		signal = caps->luminance_data[i].input_signal;
-		lum = caps->luminance_data[i].luminance;
+	/* choose start to run less interpolation steps */
+	if (caps->luminance_data[caps->data_points/2].input_signal > *brightness)
+		i = caps->data_points/2;
+	do {
+		u8 signal = caps->luminance_data[i].input_signal;
+		u8 lum = caps->luminance_data[i].luminance;
 
 		/*
 		 * brightness == signal: luminance is percent numerator
 		 * brightness < signal: interpolate between previous and current luminance numerator
 		 * brightness > signal: find next data point
 		 */
-		if (brightness < signal)
-			lum = prev_lum + DIV_ROUND_CLOSEST((lum - prev_lum) *
-							   (brightness - prev_signal),
-							   signal - prev_signal);
-		else if (brightness > signal) {
+		if (*brightness > signal) {
 			prev_signal = signal;
 			prev_lum = lum;
+			i++;
 			continue;
 		}
-		brightness = DIV_ROUND_CLOSEST(lum * brightness, 101);
-		break;
-	}
+		if (*brightness < signal)
+			lum = prev_lum + DIV_ROUND_CLOSEST((lum - prev_lum) *
+							   (*brightness - prev_signal),
+							   signal - prev_signal);
+		*brightness = DIV_ROUND_CLOSEST(lum * *brightness, 101);
+		return;
+	} while (i < caps->data_points);
+}
+
+static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
+					uint32_t brightness)
+{
+	unsigned int min, max;
+
+	if (!get_brightness_range(caps, &min, &max))
+		return brightness;
+
+	convert_custom_brightness(caps, &brightness);
 
 	// Rescale 0..255 to min..max
 	return min + DIV_ROUND_CLOSEST((max - min) * brightness,
-- 
2.34.1

