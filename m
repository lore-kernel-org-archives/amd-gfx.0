Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410E6CFD65B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45A610E629;
	Wed,  7 Jan 2026 15:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IdhqD+jb";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C399E10E628
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgfWS2/qRYNR0It6xqYlTkkPmMq4eleOoha/vGmbp9GKg248mx2DcnWdRZUv2XQq5xOkdHwdRjNhrPpkq7jUDF1/3Or9zlBjQ/eDR3ssRjspkiiCKR5HDOJYfeS1R6YV3UZvpvIPHAg8QurTMlCyJCPwQDFiBIw1skzBOlGH74XyX9hzc7wWxRBUViqn9wHhhq4/GmbcrstRR5+ngdtT5iPMBBYe13lCk3JIUY9MGaYjJOgvRcFd2va8JVK5cH+/72pnXeY9bWeWs2PeUdHaJF5zkHQMMoCzkua9yPovJZ+TLq5LzzyB6svBNzdfv2ePmAueEIaVpDlFYso36fsTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVwaOHN81slMqNjH/0ZHJK28ku3sX0COmhps4qY1sh0=;
 b=mMoRQZT6h7PMb+mMVM20Fir3xa6yiGv3d93padvdeNMqQoomIhNuZ7xSUCkgmzVoDEmYpt0XAa8XuaIoQyICaWWyaoZI+abCutHPG2hqGLf/cOcMXXPqGMoFsmbM6e1AsTwiGsM/Q3N8gHiVzgaQ1Xf9EqGoJ6P6J0nybpI2C7wOnW13nNKkGl4nSeiRdspUZY7tcLCD0973y2i0thSCRxJijF5dYyhpqi5nWyOeHouyMHaUlyoepEPIs8Fveh24SEVcoVj7j058am6Y+nStdda3xwSqww7KHZ5v60bO49DFoR0gqF7+ZwUxRGZ2UXsLjnjoJgS8KN9Y0b0G5jbnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVwaOHN81slMqNjH/0ZHJK28ku3sX0COmhps4qY1sh0=;
 b=IdhqD+jbAZW09d4nYD2Ba//GQOYj0xIui94LXFyLmU+UCYBqvUj4tMdSmbsmS6JsvFt2f64G8BbdA6sMgkeyarFhwrIm1eutHRqo/0lZgIg14TgGBDMskpsqMXAXX3dWpfOjqlxeDI/dk3O1vHRsU8FQ7OMl9h2+7pQDJGRfDyw=
Received: from MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:57:57 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::39) by MN2PR07CA0029.outlook.office365.com
 (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:57:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:56 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Jan
 2026 09:57:56 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:55 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Dianne
 Skoll" <dianne@skoll.ca>, Chris Park <chris.park@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 05/21] drm/amd/display: Bump the HDMI clock to 340MHz
Date: Wed, 7 Jan 2026 10:47:57 -0500
Message-ID: <20260107155421.1999951-6-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: f38770b7-102f-46ea-dc46-08de4e058664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KYVCTRSRSJAKPFKAzLEpa3IkzCpRb/AOQT+sYibSbPAeq9rVf0zRBQfR8EG8?=
 =?us-ascii?Q?oN133j0R684ySCT81Cf6+AeYo7KLSzKa7zpkIk/JI9nv6fyH3ey31IES27zb?=
 =?us-ascii?Q?Fc6ktlxnz31Nqz/rGdpBzIDVGXeCiwPEl3/vkI0f0jSj3J6eJupsoD7E+q7k?=
 =?us-ascii?Q?opjKVgJQipEGlwtkzoY3JhwiUpmsAI1ffoX1vBymMhxOFU4v67WGTKTMAoyN?=
 =?us-ascii?Q?ATUgY1Zey9Cx7SgpZXKY7YBNNpYg7g/9aRrk/t74s1gM8xmMy0LtS97HvvTI?=
 =?us-ascii?Q?AuDyy0qfy0JJ5f9INhPWfl1DxGOZKvIkFIQk+ZDwXG5A1euiBI9bpM2kkJV0?=
 =?us-ascii?Q?wwmTgFX8/UvVlO5cY1GzL78JrY2rwM2WNEUBYsBYuasdJ+WjKRqPQTrxti5c?=
 =?us-ascii?Q?Q30YKjqb7B3sAi9hBPsptLggFZ8foMaIdK+Ci6yUF6YSR/DDyf8qrdEnS9yT?=
 =?us-ascii?Q?pEhZRpRxZRFCkeFenH5TtDH2oL8FIXc6N+j9w0ynZxKiqI3UKUAyNQtHsUbq?=
 =?us-ascii?Q?6DMfvOEKReOsyLAP8eDiPizFEikOkeCx5mLssJfJAWifcr0u8y2xA7FPkVDP?=
 =?us-ascii?Q?K/7GF2dhp+9aAC2ZxdCj7a41q8NoLZzkr/ugrXKeazzdL6Q699Cjo6B7hbGQ?=
 =?us-ascii?Q?yHdv/3nngKXb3Ev7YE9qSCLx+iDajBdZQfqyrn2Fl03g0kQT6+fPclK0T9p8?=
 =?us-ascii?Q?pNjiJ9/Y5EA5DXfufohYpzZdaRhDX7sVHNHGqSAGcaffxs3zSjMBsQ8mLXoO?=
 =?us-ascii?Q?fVm0SkWc4ET8T7Mx53NA45/6PQmZ8pw9HcxzOySUK0yS4kxqRad0K5Ui9yrL?=
 =?us-ascii?Q?wZeuSHvoFvnGBHcY4i9uMRMD086Qwr3sj50N78ZGQRSnxFFQORQoKFl/7HbM?=
 =?us-ascii?Q?TmnyJZySuGb0NiCnDA4oH4IbM3zJVmHsJ8fWJu+KygVPVkB4ZcpnB4zYr2Yv?=
 =?us-ascii?Q?cYvXVKGFQCiGxwixeFfPhssU//prQKqrGMETKyWMhAqA4Nh6umxZOw8ifOr2?=
 =?us-ascii?Q?rhx6BI0JzDTyKOrxaPkzuMDkY4h19n9pgUOLBS3/07PBVzkSDX7FXqvA1zmb?=
 =?us-ascii?Q?gEdxTIUbOMbCrA0oMghp49aeS51/mtHF++FYhqanqfY2l3KKipIFYXoU4Dmm?=
 =?us-ascii?Q?IBiFQgLvF5PJ3e5DpOajreqRzWOhYQ5H2T17SHVu9Adu2lHQAwto8FhR43pk?=
 =?us-ascii?Q?ulVTJhLQMiQwmM7CphaYCcXQ8RiEL331tS7LlURjnS6jKAZbnVQhesm5P8dd?=
 =?us-ascii?Q?uW8RdIsNZE2g+LtboGQjtjFRHZCGPTJ5zq8wZ3IynmNrRb7riIn5X3QLMCkd?=
 =?us-ascii?Q?cZZz4l990L2iT0TTepur51gCEli3G+dKwhvlLHjW1xGgnbNZCJ5Estl+y5W+?=
 =?us-ascii?Q?DH59jPRknRmf0QNpFNSvVwWsb4YOLw7E5TuKM2IrS1rmHzU/o4WbSyjZCHfN?=
 =?us-ascii?Q?bXpI/kya5lgQsV+fPNRGShx/C1vpPeZXVN1uOrBSQ+m/tiAF09GL7i++VQ7t?=
 =?us-ascii?Q?JS32Sr166FHDPjv3bG4qI8rI8gNNtvhVNAvu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:57:56.9302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38770b7-102f-46ea-dc46-08de4e058664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE
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
DP-HDMI dongles can execeed bandwidth requirements on high resolution
monitors. This can lead to pruning the high resolution modes.

HDMI 1.3 bumped the clock to 340MHz, but display code never matched it.

[How]
Set default to (DVI) 165MHz.  Once HDMI display is identified update
to 340MHz.

Reported-by: Dianne Skoll <dianne@skoll.ca>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4780

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h       | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
index b015e80672ec..fcd3ab4b0045 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
@@ -41,7 +41,7 @@
 /* kHZ*/
 #define DP_ADAPTOR_DVI_MAX_TMDS_CLK 165000
 /* kHZ*/
-#define DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK 165000
+#define DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK 340000
 
 struct dp_hdmi_dongle_signature_data {
 	int8_t id[15];/* "DP-HDMI ADAPTOR"*/
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index f24365395cd9..2c9d2b932482 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -335,7 +335,7 @@ static void query_dp_dual_mode_adaptor(
 
 	/* Assume we have no valid DP passive dongle connected */
 	*dongle = DISPLAY_DONGLE_NONE;
-	sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK;
+	sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_DVI_MAX_TMDS_CLK;
 
 	/* Read DP-HDMI dongle I2c (no response interpreted as DP-DVI dongle)*/
 	if (!i2c_read(
@@ -391,6 +391,8 @@ static void query_dp_dual_mode_adaptor(
 
 		}
 	}
+	if (is_valid_hdmi_signature)
+		sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_HDMI_SAFE_MAX_TMDS_CLK;
 
 	if (is_type2_dongle) {
 		uint32_t max_tmds_clk =
-- 
2.52.0

