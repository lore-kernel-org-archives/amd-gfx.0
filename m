Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F23DE936E8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A758D10E3C4;
	Wed,  4 Oct 2023 21:22:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E2910E3C5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za/5UIP7ar/PqBCvypMQApGKkdTFkbrMy49KROmjyU56xrnQNF3MaoLXD8BpbuQUf+/wejwIj1BaEjdl79QWOCumOgDc7X60vfqGJVKYPP31zvuGsRelqvozpZx2hl6m3vfxtFs8wVFxXuCX+to2jNmsSDyaEu3+MqKnOHycI5h6yuHmPllIpcqxue/LsHT4xTvS+apwC62yhWk5reL+s8/+3TWT+OPNSvVkrodHsbKczxNlMDGNVLdNGY+JhHhnkBD+lHclHloF8jrNH2iZEgu95D19SXX1gV43QWVTpmyoyLKDXGpXyRHHWfDfdizEexN9piHxMu3GcWC5+0XOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3VPGbFhk9lDbbp69idNSArC4mJfEnM1nGc02w6+p54=;
 b=JNkuZA55CG6zJ07knrMgMLe83sbunG/yhiBu8MPl/MfHscaiMP/ERIXmNr3igWKFAGnGUulSsCtYeYHezmLY9Ls+z/5IU+0bSHuiGnqfXhaXLG3mVOmJupg5YqC7P6CUmFzr6LIKPBBhgY0ZDyTu1vj2sMNldinphGyEBDYgxy3f55F/LNHDZ42qC2w0skoZLu3evP6C6KTUgHutPrbnUMUUUmQfFLrduqykvnZkwJnAOqyQZyCGpapr6Dt2ts5/teYJMzXKcLB7pkqh03vdyU1Rplrifbb3RKC2WKeppMgmZ+0fsNHqKVwM8IX/HfOTngpd2jFLsHMFqBmoLXDIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3VPGbFhk9lDbbp69idNSArC4mJfEnM1nGc02w6+p54=;
 b=QoE6yCNCbjcKxN9RWoU5M22ifstw+sB+M0E7tu75Ou/IJFBbuKlPz5MPjq/bb13my9cuHGj1KM9GTufYulybCZ9HunhBEyhDvOixYhf7HvOVLYPZneH/AKCG379tJwwyGWSuVhSWPcdCvFq2hN4BNysrZv9D+dWIRcuwnFGyM28=
Received: from BL1PR13CA0269.namprd13.prod.outlook.com (2603:10b6:208:2ba::34)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 21:22:10 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::21) by BL1PR13CA0269.outlook.office365.com
 (2603:10b6:208:2ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:22:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:22:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 15/16] drm/amd/display: Port replay vblank logic to DML2
Date: Wed, 4 Oct 2023 15:21:09 -0600
Message-ID: <20231004212110.3753955-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 43169aa0-9fd9-4737-2dba-08dbc51ff850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYjZE3GbADD/I/25KTT2wkkT8qEHPimMr8YbOm76m6PC/lI+i508oRSs/D9jm/u+9ZX9qxrCzcQUJ/P23FTQTbZoZzfGQNaP7WEfqBij1aJCnRUjiV2oeG1Zjo1i7LpgpWG7oxVDgU3UXsFn48z78FQ07Q7bVo5tQly+sTdfB2p0EKKs8UE1De1xMIxaU6s+Go+VlFqpQP+GJOLDfH6De+DMwwfxqi8AOmnefvSn2LTDZz2ecvYKqJrPD/83Tq9l12XVqYozNrDtquGePDkct0QRFhr0vOz8i6xZLWYmvTGH2lb2cWlLGCiDUZUsyAsJxR3eXya2gRShNfBy0Jo0ZOOlTDQ6+FxKa4JTatlocJjmm253kt6fUK3bkCPx5qlhxwZrt9atW4/KFuf9twYmU8VKaSwLHucp+dscnNmDtpV2pCVTqduApihC1D96gRBRfQr6olGYaRvFiGrvKC+lzm6tUxfX6mkH+PUY8j2W6xlrV/1dLFWnj0KNQbyVIfpwz5Wgp2rFKDMfgATb8O0MB10Khf7w98QwMudO8ZjUqXZyMab5MsrwA4BvkDe5H/yU1gMGILeylgk0cIexnZdKX5lYjV+5ermt+CDGhx5jxhKuZPtTVqBBVvY7q+yJb+tls0sw6ig9QPsh6i0lNFD2EyHORT3YXL867usTBS5C0LRVDlau3UuGg+Wam7BKuBBx1sjaWDZITQQhqRu0K0GB0G2LiOaAKKr1xwslUlpTKFRqBKppz7iNboYnBJ+Xvelriz+J4+HrSYN+FkBZEHQclA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(6916009)(478600001)(82740400003)(426003)(1076003)(81166007)(356005)(36756003)(26005)(70586007)(54906003)(41300700001)(316002)(70206006)(336012)(36860700001)(47076005)(16526019)(2616005)(83380400001)(86362001)(5660300002)(8676002)(8936002)(4326008)(40480700001)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:22:10.3250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43169aa0-9fd9-4737-2dba-08dbc51ff850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
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
Cc: Daniel Miess <daniel.miess@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, richard.gong@amd.com, Qingqing
 Zhuo <Qingqing.Zhuo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

Update DML2 with replay vblank logic found in DML1.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 .../amd/display/dc/dml2/display_mode_core.c   | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 0d446d850313..fddd52f3f601 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6153,6 +6153,13 @@ static void CalculateImmediateFlipBandwithSupport(
 #endif
 }
 
+static dml_uint_t MicroSecToVertLines(dml_uint_t num_us, dml_uint_t h_total, dml_float_t pixel_clock)
+{
+	dml_uint_t lines_time_in_ns = 1000.0 * (h_total * 1000.0) / (pixel_clock * 1000.0);
+
+	return dml_ceil(1000.0 * num_us / lines_time_in_ns, 1.0);
+}
+
 /// @brief Calculate the maximum vstartup for mode support and mode programming consideration
 ///         Bounded by min of actual vblank and input vblank_nom, dont want vstartup/ready to start too early if actual vbllank is huge
 static dml_uint_t CalculateMaxVStartup(
@@ -6164,12 +6171,24 @@ static dml_uint_t CalculateMaxVStartup(
 {
 	dml_uint_t vblank_size = 0;
 	dml_uint_t max_vstartup_lines = 0;
+	const dml_uint_t max_allowed_vblank_nom = 1023;
 
 	dml_float_t line_time_us = (dml_float_t) timing->HTotal[plane_idx] / timing->PixelClock[plane_idx];
 	dml_uint_t vblank_actual = timing->VTotal[plane_idx] - timing->VActive[plane_idx];
-	dml_uint_t vblank_nom_default_in_line = (dml_uint_t) dml_floor((dml_float_t) vblank_nom_default_us/line_time_us, 1.0);
-	dml_uint_t vblank_nom_input = (dml_uint_t) dml_min(timing->VBlankNom[plane_idx], vblank_nom_default_in_line);
-	dml_uint_t vblank_avail = (vblank_nom_input == 0) ? vblank_nom_default_in_line : vblank_nom_input;
+
+	dml_uint_t vblank_nom_default_in_line = MicroSecToVertLines(vblank_nom_default_us, timing->HTotal[plane_idx],
+			timing->PixelClock[plane_idx]);
+	dml_uint_t vblank_nom_input = (dml_uint_t)dml_min(vblank_actual, vblank_nom_default_in_line);
+
+	// vblank_nom should not be smaller than (VSync (VTotal - VActive - VFrontPorch) + 2)
+	// + 2 is because
+	// 1 -> VStartup_start should be 1 line before VSync
+	// 1 -> always reserve 1 line between start of VBlank to VStartup signal
+	dml_uint_t vblank_nom_vsync_capped = dml_max(vblank_nom_input,
+			timing->VTotal[plane_idx] - timing->VActive[plane_idx] - timing->VFrontPorch[plane_idx] + 2);
+	dml_uint_t vblank_nom_max_allowed_capped = dml_min(vblank_nom_vsync_capped, max_allowed_vblank_nom);
+	dml_uint_t vblank_avail = (vblank_nom_max_allowed_capped == 0) ?
+			vblank_nom_default_in_line : vblank_nom_max_allowed_capped;
 
 	vblank_size = (dml_uint_t) dml_min(vblank_actual, vblank_avail);
 
-- 
2.40.1

