Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C637C4725A
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5B72072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wxiEcezr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5B72072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210726E172;
	Sat,  2 May 2020 21:35:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC206E169
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6JBnKszNmp2sGM2HazZr2cSCkOITjHXLmO4ShSmsqr5nlrfLBHhwNDw9gOgJEKsC0y14NnpH3hjgkSGtZYNJLk7R4Ady8LQ6Mq1m7+7eYo/kwXYv7ZjnKukl6xNA7oFXUMh2x1j1Ar7hw/iZ86nSUkfkjXQebEZLeOUrhackqdtNaNjjOfePLDksA3Llqry0Kgl0WlRuLmUu1cjyF9rfMAbKl5vmzXRGc1PGUIZCVVkm1vaWbGdcEe2hvqnKhijbRp/iGpGq7ClV9R4mPz9eBSR0YNbw3tz1zdpHdevNsQNX94oKAyNxyFm+IN6S/KF1rcICMG770WvXwhrDJkldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFiRqcVVv9mtYwtf7JzpYyawlLovvvpxmkmy1KHGKkE=;
 b=lFcFCg+B0Z7Q/Q649oxgH020Y41PUIYDA3iigZd+GRNUgjIwDZxl4uHHUWK9l59kk7PrI+MaoZyytfvdhLCWsH873BA8h+QVSNtuYil+yPoJ6t6tR14LMQip3jI6VYKdOLMRMuBU1RndqCkEDfocV/uAvy65/3eE28yoB3lrsd+JANe071hEpvOprxvy+Nbw6jXMhYyS2LY85Xl9izb+sU1dN0MT+bkMaDk1Ma1DPRoEHWXvVAUjBGhMjSs0JQUd5ga5J4kFYXdLezEtFjDOewbRI3DzQb9eeVGGN/D+beLUBX1cLk/eKgAFHVaZLhX6iSmn3eElCuE0z2xjVTvtMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFiRqcVVv9mtYwtf7JzpYyawlLovvvpxmkmy1KHGKkE=;
 b=wxiEcezr9sZtjB6VUAO1pj7raJvMWWwOz42VjrvlfEmAm/0xrZCMpL3R04vpHKBc+HZBsVNIO7MV9APYA4qN7snCI9fluYCkMEkJ/9jveE78bAZI4dhE/kL1YOodzX4aA95pGWzW9/AcN2al183iYjq/Dk9oO22ZWFJYjmiAV0M=
Received: from BN6PR04CA0085.namprd04.prod.outlook.com (2603:10b6:404:c9::11)
 by SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 2 May
 2020 21:34:56 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::56) by BN6PR04CA0085.outlook.office365.com
 (2603:10b6:404:c9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:34:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:55 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:54 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:54 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: The external monitor will show gray
 screen during SUT reboot
Date: Sat, 2 May 2020 17:34:36 -0400
Message-ID: <20200502213443.39232-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966005)(4326008)(478600001)(426003)(47076004)(336012)(82740400003)(6916009)(86362001)(2906002)(82310400002)(8676002)(8936002)(356005)(54906003)(81166007)(2616005)(6666004)(70586007)(1076003)(316002)(70206006)(7696005)(26005)(36756003)(44832011)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91580661-0761-4120-6ab7-08d7eee0a805
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:
X-Microsoft-Antispam-PRVS: <SN1PR12MB257417FC87B45D32FE3841D38BA80@SN1PR12MB2574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWL1AI0fDOZzJ7zV8+FUpQWKJnSgpYJWNehTV3mZt3tfvRreOFCkGARaerJzIIoFAAQHCXVV9OFzdIVFPh6eeW9vlNwOSZUJLUqlC66hMQhQlolpd6oLij793fEFbpSI48YLpUymoTfvxULGYsJTohcetM3WPQhveXXrrxiQlfVijDAVh1tk6rdBYPLy9+6IQdLyDvKOEtxf6wH9vFnSDNRfT09gkLzHpNvVPSkP8Llqw/SPDL8qPjQDYK5Pq8tfcQyvnTzaFeKv08MXdUTu1nrCp3RR0bZaZRCLTR//f3dRzzwe9JKjr0MGDtq65dDHPHS1brTUoptG8k6qJX04wHCBLcN7ovlLH2DFbVOyQ7QHf8y738LQeyzEGYxtXgKaWV6wkKerOz4ZUwhR8D6Hwfwp2s2He1DAyA52dWAvp+heqYWkQoxIAxxfRzaxXRAnXkM9SeTB5d+FBMFoCyb7uzqyTK5BydbUNoukNhTnQbsyql1guhPvLVbpbiuGyvWe+DBrPUySedngAaFJO30ZKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:55.4807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91580661-0761-4120-6ab7-08d7eee0a805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
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
Cc: Eric Yang <eric.yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, yanyan kang <Yanyan.Kang@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: yanyan kang <Yanyan.Kang@amd.com>

[Why]
same with CL#1711022(correcting yuv420 black color in function dcn10_blank_pixel_data,program_scaler),
yuv420 black color also needs to be correct when enabling HDMI stream at the resume procedure.

[How]
correcting the yuv420 black color according to the way how 420 is packed :2 channels carry Y component,
1 channel alternate between Cb and Cr.

Signed-off-by: yanyan kang <Yanyan.Kang@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index b33eafe45f76..f36d1f57b846 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -826,6 +826,14 @@ enum dc_status dcn10_enable_stream_timing(
 	color_space = stream->output_color_space;
 	color_space_to_black_color(dc, color_space, &black_color);
 
+	/*
+	 * The way 420 is packed, 2 channels carry Y component, 1 channel
+	 * alternate between Cb and Cr, so both channels need the pixel
+	 * value for Y
+	 */
+	if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+		black_color.color_r_cr = black_color.color_g_y;
+
 	if (pipe_ctx->stream_res.tg->funcs->set_blank_color)
 		pipe_ctx->stream_res.tg->funcs->set_blank_color(
 				pipe_ctx->stream_res.tg,
@@ -2254,6 +2262,14 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 				&blnd_cfg.black_color);
 	}
 
+	/*
+	 * The way 420 is packed, 2 channels carry Y component, 1 channel
+	 * alternate between Cb and Cr, so both channels need the pixel
+	 * value for Y
+	 */
+	if (pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+		blnd_cfg.black_color.color_r_cr = blnd_cfg.black_color.color_g_y;
+
 	if (per_pixel_alpha)
 		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
 	else
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
