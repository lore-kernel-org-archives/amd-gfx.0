Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B00C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA5B10ECC5;
	Fri, 14 Feb 2025 15:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X5kfWNZl";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2B010ECC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcXBcFhdp4iDGSGLC15E7uYzVXjIsJEcgQnxy8G83BEBjTBrn1jrxNtIDcWWJw6T9RxyZsRzUtSABYwdgnLrB50A/Okkvq/XhNEWf2zT2ihQkyr0XOQIGFfeb0CJehpvYWlsig9sHj34UBR+OPD2zOTeSJKZbxhEmYVEHUFxy3iaYRZCiFgLlkNioaJ9V/GnbaJOpFSn/NjOAFWX0IzK6HPnxHK+JATdAI2MVCi/m71eENL8K7fEwduJMAK5ocnaeDdlA9dQ3Jw5bhQ7g6T5GBpnzyOl29vWjuRkztwsvFYAEVXeMKN5d7MxJ/nGSY54VyxFr8MZrha50vnaOQx6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/y3nB3PTOipdD+XLZHfRs3n7NPjtZfUvE1enhnllgc=;
 b=c70PhxJutAo9Gd4GkthdojGnM/ykd2kZcCPNlo/SuM21UhVK/HF7Ui1ClZoaqIHFEFCDRtETXnb6MHaxRMtraDqbtLqhTzcpLzYje6/vE0bkKF2t+UUdQXUsOOlGPDtFAyU9XbbW+JOKIwGj8ypssMx6rEgbO7ELG0XPSzugsLrtSIfhuFUFICvAnhfbGXAz0FOyYvij80SVAk28Mkafy8SAlp906FRQ2AGa23PzeJvaKhljh1leAJkZiJFvbzNIkL34lrllb6S0ohm76dDN/O4u2oLhfLx07Rqc5zMlc0Q3xi+anftaSQn0lCWHF2X3ToSqnyft2104+RAS0gwHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/y3nB3PTOipdD+XLZHfRs3n7NPjtZfUvE1enhnllgc=;
 b=X5kfWNZlVsZVLxHNKQboyqidSxh4WtciWZR9M554v0rLCeQxMzNWR2yloM5ha/oXYPuxC4cosei3EjnHlzNz1r0uE5FUbeL5bFTCxyzg6GYsLLMF9qOGbyAlLc3fqYxRl+SMlX6Myqt03lMCg9WkGVgFfSZIlRA1zllBwwXG7K8=
Received: from SJ0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:a03:39c::7)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 15:01:39 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::26) by SJ0PR03CA0332.outlook.office365.com
 (2603:10b6:a03:39c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:37 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:37 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Oleh
 Kuzhylnyi" <okuzhyln@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 10/16] drm/amd/display: Add total_num_dpps_required field to
 informative structure
Date: Fri, 14 Feb 2025 10:00:27 -0500
Message-ID: <20250214150033.767978-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b522a82-9813-4601-73d9-08dd4d087c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g1D5eikVhpCRzPI3FKjlAnQLcDO8OYvudyL2zaLqarX7Z0vtHdGA12bqAZIW?=
 =?us-ascii?Q?fhhJ3662v4vQIQERCqi7HMKanFUnXXv11y8ICv7lGsEayiQuY8qytuoVfxQ5?=
 =?us-ascii?Q?UFcU0o4Naedfv6dofHfw7Bt5OftkLJKwGtWv+itfMBsKCdg3Sfjn5BaymYrt?=
 =?us-ascii?Q?TAcFOwoypdNMd8hf5jxnOehqSiSN5DwInCyQeZEVI62fhVeVBNs8S2P1KIeO?=
 =?us-ascii?Q?3uQY7fkaXITtHsbrtnbvha9dSuC/h9V9Kstrig6WJ+KkWObCuhe9GxD3dK9E?=
 =?us-ascii?Q?N+tbvuHRA2oKI7aIVsGENHmb62mFZJx3WXAGDVtkJU62E1f216PWcmGkGYJA?=
 =?us-ascii?Q?khP11e69DgvRJ8G+KVdwgbJeAql4M65ZAWar1WP6b/vYjV9pBldDj8wHFigW?=
 =?us-ascii?Q?18P8JljPvYsrY7X3HSdxBEVESWmW0GS9jG2757bFP94NVPlCPyorZaDVcL5Q?=
 =?us-ascii?Q?dX5oNra83Xvzlj//ansxO14OdtwE+PmLzLCPxOG3qttvxpVPrndUce96vPI8?=
 =?us-ascii?Q?YpuP8skdgduCHPcRXrHXzrIjA/XlR6fQwYZvbZEip0YkYv+OGOHldmqxV3Lm?=
 =?us-ascii?Q?mqx3d0UpYo02Jr2xIvHM30T6Tb/HHkxk22+cYBj2AszcdfDx4S/fdNiAE1B5?=
 =?us-ascii?Q?rTlMJH2/f1k8M1oTcSEd+QLHEpLJpockRXnx6W3kHUtfVUn/cfWdztTox0th?=
 =?us-ascii?Q?OFwZyGcTZSbAuUCsRZ51rH8oRSBPhsfDiuUAjBbbrbx4HBpCUuNn80dMkf5P?=
 =?us-ascii?Q?U2zQQ5VVxlUaGXSSDOPj0w5k+b41pxMVQEycBUICO9zmdfL/jwEe5reQUTiF?=
 =?us-ascii?Q?XS/TQjxXLIpwSPiIjx9mDNUEn4Z4PgyY1cE7eKOpvCIlp7ihAnai+JeqXS7h?=
 =?us-ascii?Q?drUaIqf+gq46CzrvL0z0zMufpooiOukwfw9yYoqHCuc9x1ezpjuwH/a34GNA?=
 =?us-ascii?Q?P11iI2F53fN2+FFB/fkDZPZwIm+ZEbfpHB6qHQIUgNQz95fWHjfspEYzF6Ig?=
 =?us-ascii?Q?9A0NpXMLYM58IYk38jFedzKBaEmyo1jNViAApv7aPYPJuJCywOPvwS8BIZKJ?=
 =?us-ascii?Q?243E/oVWgz42lsairEgEtSZKE0zArxy6pi97Bl0MCD/FTdUOzxdqsf5eUK6r?=
 =?us-ascii?Q?v8jtWp4li3n1JUK1XO+UA0DGiGhUAbjuIFyXz/P7PuRW+mxvAhzEZeL+ZXMv?=
 =?us-ascii?Q?EyOhHNZjMnLtaMnNzUorhsDGbEavjB6uxs7Dmyq1ZoEO/a68fd4Q4EyYQHEj?=
 =?us-ascii?Q?eT3VKw/hHn9wil1U20YkWBdNgNDr3xk1WSuKqUdrc+DTj8eA+vSUfR9OjgPr?=
 =?us-ascii?Q?ylF/2oOduDmm7x+coBnjZAryIPLf8mE/3+bHsVPkJhUh4+Ow06V8+bxaavG2?=
 =?us-ascii?Q?JgsqVJURS+pR5Xb6gZ0kl+NS1w7ys7OS3uJ6cLSO86TrtZXLJ7tfMdpJOuZG?=
 =?us-ascii?Q?T7y8orawMRmr24ua56YAQ/tfKRYsPlx2g7m0uDV7ixJKqCbRHltWjH3ob6Hz?=
 =?us-ascii?Q?lBCiqxpCBHBmBbA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:39.4979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b522a82-9813-4601-73d9-08dd4d087c3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
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

From: Oleh Kuzhylnyi <okuzhyln@amd.com>

[Why]
The informative structure needs to be extended by the total number of DPPs
required per each active plane.
The new informative field is going to be used as a statistical indicator.

[How]
The dml2_core_calcs_get_informative() routine must count a total number of DPPs.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Oleh Kuzhylnyi <okuzhyln@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h    | 4 ++++
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c       | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index 19bce4084382..0dbf886d8926 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -453,6 +453,10 @@ struct dml2_display_cfg_programming {
 			unsigned int meta_row_height_plane1;
 		} plane_info[DML2_MAX_PLANES];
 
+		struct {
+			unsigned int total_num_dpps_required;
+		} dpp;
+
 		struct {
 			unsigned long long total_surface_size_in_mall_bytes;
 			unsigned int subviewport_lines_needed_in_mall[DML2_MAX_PLANES];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 87e53f59cb9f..78c93a502518 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -13147,8 +13147,11 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 	out->informative.watermarks.temp_read_or_ppt_watermark_us = dml_get_wm_temp_read_or_ppt(mode_lib);
 
 	out->informative.mall.total_surface_size_in_mall_bytes = 0;
-	for (k = 0; k < out->display_config.num_planes; ++k)
+	out->informative.dpp.total_num_dpps_required = 0;
+	for (k = 0; k < out->display_config.num_planes; ++k) {
 		out->informative.mall.total_surface_size_in_mall_bytes += mode_lib->mp.SurfaceSizeInTheMALL[k];
+		out->informative.dpp.total_num_dpps_required += mode_lib->mp.NoOfDPP[k];
+	}
 
 	out->informative.qos.min_return_latency_in_dcfclk = mode_lib->mp.min_return_latency_in_dcfclk;
 	out->informative.qos.urgent_latency_us = dml_get_urgent_latency(mode_lib);
-- 
2.34.1

