Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10987CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E74910E4E2;
	Thu, 19 Oct 2023 13:33:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EC410E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEzo+m3d7HaqxsZjd9Xl+NLagQrzS5L0wnjMJBlZGgMKXqQQJ2d6ijtS190BykKWOOSTXL6QPg3KZdtQvTHJXuUFAdHoay5PkKH7DGR8x6IAG58RMCWAylMfhYOl0/ZXTfBGNaJn5hjJRneJAJ1uiveCCd6f/aq0eaFdQWYObWXLR8rWsN4R6CalbpaggpgLLA9+D2x5vANYLC0G+hBmDRwIGtvWQSTW3AMyDDfp2fz0MG50u08w/nbskQoSgnkBWMl7AJyBvuyUSJ2odD0x9jf8L5tPJSNxFPNiTPHxYmz/QqS3QZ3Tyy+6RP3XOMMN0oJ7sPWbpijTlG+phngKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohlRxjDjiv4yVC/hLmmze7jmOUxZsfbEF0qljsyYHQ4=;
 b=S+j52gVABwUnECfJQcb2ZcAJOGE2EdWyMSGDipuWT8+JXkpEO/vIEF1QZmfP+/5zGBv2hGhcFzBUns1f+zelh+fHLLvAQhUzgrDYRK0rW5ruK08oWlAW8HRinqniZ8x26Si+L3Zg3ynJzIk1hMon333m9Vp2hkSFnFuyoshEd4SrAL84nhygGzItZJa2rGvpnqRxDyx4UNWxNWX9dwNKh62IJ0o0j5cIM6TyykiDV1jIZGSLhTDQ8UuA7KKpoJJb+KhxHeFxi+OmDQy6I/zWdtx27p0Q1HikBP89ezWz+GemQQ4OrM0PxAKcrj1m7g7Z5E4gj8bBA2Y1JTg1hr6BUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohlRxjDjiv4yVC/hLmmze7jmOUxZsfbEF0qljsyYHQ4=;
 b=mcacntLkXnGRErb1dAAHoJzK2nODF9KuGVMWQSQAYHmaaQ45VDflR5fmsOPKSWpCUB/3a+5XxMwr/5fgVUM3TTtnv75Hn1BlnsiVNZvXHKg/yeLUsAD8u5VBbl/0GeUZw5vfO0r1ZY8m9+Sp3Z+whMB/OxWPhBRoB+6WWfmdYaE=
Received: from BL0PR1501CA0005.namprd15.prod.outlook.com
 (2603:10b6:207:17::18) by CH3PR12MB9396.namprd12.prod.outlook.com
 (2603:10b6:610:1d0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 13:33:09 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::28) by BL0PR1501CA0005.outlook.office365.com
 (2603:10b6:207:17::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 13:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:33:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:09 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:33:08 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 11/24] drm/amd/display: Fix HDMI framepack 3D test issue
Date: Thu, 19 Oct 2023 09:32:09 -0400
Message-ID: <20231019133222.1633077-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d08009-761d-4a66-3687-08dbd0a7ef59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Etk5kMMd2jvwriqHQ9Wh+iFctB76pE+7CvKpep0rmMjYUh20wWsBgCpGH79UkvGfcG4veba+Bm8IuL8kgEKK3SgYr5bZv41l7xQ4LUfrZDqrszooDjXfygNtFld0pVbtW86/aPlCq5rirI0oyLiguw5DyYfFHFSWS0bAEgGfNgFEiQgeWFU5Zi5DZVVHTe+PmjNQBrqU19AcSwCcSWLTBajNZTnuDDapjCyZjpO2TGoaNk9V/1PU0WbJqHF+pAfpuliRcMx56pVhfJQmIT3QfN9SvQqzJe9jtzKzyrranOnVDU+UTIw6VbxJpTdVmMlMw+abZAHyRCjMTnZHxfKuoUC+M3d7WZtzqbMLztW8PLYBHx1SXrdDZsnyKe2iIQw66PU8rqVWmxgTmP+Zwzm0H3vgU1i/PATY9ZgR8ZFu3GnBQvlfTx2Spqh6fUr8KpyDBa9ykX0a6MgBvyQTsBGtH/kLKK1PyaJl8GsWcCDK57BXbQf+gmlzGat5a2S9fCT+97u2ONpIphzzNDbXFcaa5yT2WEJUPeS0V+3xkBPMXpY7Zb8+xw3NFtFb80rJcCadyzzUMl3DU/Kq0hV5LQvjFbVZl/bvkXqcX1+1kK6rbDBBvHIMKWyxJL7/HzbsIwKIOM4H9rQwe3vIDcstPSuX1XUK5A2p+Jj3wkArayQzNq0jpNvUmo/MSEIP7henVINGzjzk62o2zBoUWnjdNAvwPp71azUMUEAK4ptqjLVxmr+kSG2ba1u9dWiuH8DyJf3RapBCADGsvDHWeq4TQzJojg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(40460700003)(70206006)(54906003)(86362001)(81166007)(26005)(356005)(82740400003)(2906002)(83380400001)(336012)(1076003)(2616005)(426003)(7696005)(8936002)(478600001)(70586007)(36860700001)(6916009)(5660300002)(2876002)(47076005)(41300700001)(316002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:33:09.6305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d08009-761d-4a66-3687-08dbd0a7ef59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Sung Joon Kim <sungkim@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Bandwidth validation failure on framepack tests.
Need to double pixel clock when 3D format is
framepack. Also for HDMI displays, we need to
keep the ITC flag to 1 by default.

[how]
Double the pixel clock when using framepack 3D format.
Set hdmi ITC bit to 1.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c             | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 97f402123fbb..f0e437f8ea3f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4228,7 +4228,7 @@ static void set_avi_info_frame(
 	switch (stream->content_type) {
 	case DISPLAY_CONTENT_TYPE_NO_DATA:
 		hdmi_info.bits.CN0_CN1 = 0;
-		hdmi_info.bits.ITC = 0;
+		hdmi_info.bits.ITC = 1;
 		break;
 	case DISPLAY_CONTENT_TYPE_GRAPHICS:
 		hdmi_info.bits.CN0_CN1 = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index e5ccd2887c94..adf835279d6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -569,6 +569,8 @@ static void populate_dml_timing_cfg_from_stream_state(struct dml_timing_cfg_st *
 	out->RefreshRate[location] = ((in->timing.pix_clk_100hz * 100) / in->timing.h_total) / in->timing.v_total;
 	out->VFrontPorch[location] = in->timing.v_front_porch;
 	out->PixelClock[location] = in->timing.pix_clk_100hz / 10000.00;
+	if (in->timing.timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
+		out->PixelClock[location] *= 2;
 	out->HTotal[location] = in->timing.h_total;
 	out->VTotal[location] = in->timing.v_total;
 	out->Interlace[location] = in->timing.flags.INTERLACE;
-- 
2.34.1

