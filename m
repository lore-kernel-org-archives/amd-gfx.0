Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804FBC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500E620663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PO6Cj8v0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500E620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759736E25C;
	Thu, 16 Jan 2020 20:11:31 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD0216E250
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUGSUV9yQ0aM4ljaWs1UD2Olq4hfqiyBdd7kZwL4dfyoC02kKevGxLV/bd1mgi+1KKUTZ2XkXcUyDGQJ+V9nzQoGofP9zxo9RkB/bvxecEaeyD8ckTL0yrgfGqThbDwUu7g8PwiAcH5LSV1VQ9qgtJAF4VIxwTozJtwAUr0rIXyomz/vNBXLN0fHaZdVj1qsPbJInNv9U+UrfgOAyTQutfcViOmcm+vcbAjSmsOO7rjcP5rhv5RopGpnCX0Fp/OrnEuJla9D3EZ0kH7R5TN+1nOb9R4wmsxXu+H9222TiB/5uxNep78ibYkRxFrtdGj3Yv/tWCb7vHlkqWI1l8YlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15rsGOLHKWwR4shom7wE0UTJlsNbZYWui2rgPM2oUig=;
 b=DcU/OFKa/3hmZpweB5pP7tE2U71nLOtxT79oT1OZ8NH4ylhF0fZVynl3+v/NCbA/m9EmnvfF3vFsN5HN9CyWxse1YqJn6+x/8c9pgcopnHpcsadiG7eHHm9iRL/RE22c3CKnn4Nhh0Mr9bW+zdOs6IIjXOjiuDV4WfuDekdCzzztEoErMOHNCLitM9mDYGe4R12GRH4zO1jEGRjNj3I5/T8o3Yg+pH0Lg2fmt6fF0KxGm5WOTVfuWRVQattEEC0eUBGc1AA5ZZo/i25NAKbAYBm3h3a+AAS2rbX5w7kW6oCLpHCkNkZ8IBbxae9Pb2RQjzhjyrao6yefspPZZ/NUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15rsGOLHKWwR4shom7wE0UTJlsNbZYWui2rgPM2oUig=;
 b=PO6Cj8v0Wx2S98yoVgIfA0o30JaFOT6T4JZ1HTAQUhfzu4iLdXUtFxe/NmmNwu67MlxL2616VrlESlHQiyYTwQgMwH3jCyapPXsMKKRpppwXmLcTO5muGnB7KINhWsBrrjcKLP8PZEtk0G3Pq89IxhxW4qnL7mAaTiItjCmEOfA=
Received: from BN8PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:60::19)
 by DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Thu, 16 Jan
 2020 20:11:26 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::204) by BN8PR12CA0006.outlook.office365.com
 (2603:10b6:408:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:11:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:11:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:25 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:25 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:11:24 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/22] drm/amd/display: update MSA and VSC SDP on video test
 pattern request
Date: Thu, 16 Jan 2020 15:10:37 -0500
Message-ID: <20200116201058.29200-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201058.29200-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201058.29200-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(428003)(189003)(199004)(86362001)(8676002)(54906003)(356004)(316002)(6666004)(2906002)(6916009)(36756003)(81166006)(7696005)(2616005)(1076003)(81156014)(426003)(336012)(478600001)(26005)(5660300002)(70206006)(15650500001)(70586007)(186003)(4326008)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1131; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c12605eb-ae0d-40cc-d81c-08d79ac043df
X-MS-TrafficTypeDiagnostic: DM5PR12MB1131:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11310CB442B73B70899D7865F9360@DM5PR12MB1131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVVib+DO3YUDSfGQMm+QxgK7Kg4qh6zyAMTkvc1VVFMShlYhNXKmlZHs5djTYeqtdlfnvgh9s0gA/JdK78QWulOar1p8Ue8NX75/KEwpkLwEk9C4QhHYiDFv/WzfJirAGdRQowknAmDyWVLsPY0xFSmJGQzoLSzqsWWEFfb9aPO+TFmeiAuLN2yVoVlykJIawMNmZG4hi4dY+2bYRz94ag7Qb5fJSE7ReqV9BNdLTokQhNhn2ph+xO8m3Ld2UB8OcDsqFjJ+7pcYwtgNr0YmKL7GdmqH4J5C9W1VFuyc9UQJSHNLkKkkKCRyq9DBDA11o03IjT4QzQv1gH4eJSPOsnzxqfqIfSjtItHv8C2XO+h1iRIGEi7Ii3elojAHHUHTyQvkV0gQgUY/bz4XiSmR6Y78wv8BoXrTButvJzRNFUa02TdzDRCQyFGOjT3XkDgK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:11:25.8385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12605eb-ae0d-40cc-d81c-08d79ac043df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
On video test pattern request we need to update MSA and VSC so
it will match the requested test pattern dynamic range field.

[how]
Update dynamic range field in MSA and disable VSC as updating VSC
info packet is complicated and not required for test pattern purpose.

Change-Id: Ie49c1d3b1c219aaff88f8185371a252e492e1697
Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
IP-reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6ab298c65247..1bd0946829e3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3925,8 +3925,43 @@ bool dc_link_dp_set_test_pattern(
 					     sizeof(training_pattern));
 		}
 	} else {
-	/* CRTC Patterns */
+		enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
+		struct encoder_info_frame info_frame = pipe_ctx->stream_res.encoder_info_frame;
+
+		switch (test_pattern_color_space) {
+		case DP_TEST_PATTERN_COLOR_SPACE_RGB:
+			color_space = COLOR_SPACE_SRGB;
+			if (test_pattern == DP_TEST_PATTERN_COLOR_SQUARES_CEA)
+				color_space = COLOR_SPACE_SRGB_LIMITED;
+			break;
+
+		case DP_TEST_PATTERN_COLOR_SPACE_YCBCR601:
+			color_space = COLOR_SPACE_YCBCR601;
+			if (test_pattern == DP_TEST_PATTERN_COLOR_SQUARES_CEA)
+				color_space = COLOR_SPACE_YCBCR601_LIMITED;
+			break;
+		case DP_TEST_PATTERN_COLOR_SPACE_YCBCR709:
+			color_space = COLOR_SPACE_YCBCR709;
+			if (test_pattern == DP_TEST_PATTERN_COLOR_SQUARES_CEA)
+				color_space = COLOR_SPACE_YCBCR709_LIMITED;
+			break;
+		default:
+			break;
+		}
+		/* update MSA to requested color space */
+		pipe_ctx->stream_res.stream_enc->funcs->dp_set_stream_attribute(pipe_ctx->stream_res.stream_enc,
+				&pipe_ctx->stream->timing,
+				color_space, false, link->dpcd_caps.dprx_feature.bits.SST_SPLIT_SDP_CAP);
+
+		/* disable vsc so no need to update it based on request */
+		info_frame.vsc.valid = false;
+		pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets(
+				pipe_ctx->stream_res.stream_enc,
+				&info_frame);
+
+		/* CRTC Patterns */
 		set_crtc_test_pattern(link, pipe_ctx, test_pattern, test_pattern_color_space);
+
 		/* Set Test Pattern state */
 		link->test_pattern_enabled = true;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
