Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD680C33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A8520663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JL4RA2EX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A8520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F3F6E25D;
	Thu, 16 Jan 2020 20:14:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C8C6E25A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/xQ2qM4QmKnWg2364WwI6wgz3er6x4ZsrlvAPiVXyddKD3oWsSqAH/rhDMEmaTNmLquKP6T0iCR9YhRJn0oe8dNBLkEW8tSB2jTTqFRzdmnm7PSmtg2Bptx7ZaTB5CBsJXkpmXDvByG3hJ29sVzH8vHxDfMAOrNsfanRzGnRbyj9HkQ2EX7IgrBbvzkeZOYhJ3qTcdhIRWrv/hDYb4YFncmgVWpFqmkRT4buWrPQUSEYl9A16E9kFi+LPLTFJeog7YYHZCU4Dg2KTHaYsr7uq2oaFs1ttKDyIrtiUqEWdQKfywac/QFzgHvermWKoqwZBin2TzHu7O0R6ZM9KGUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4iYQYu6/rJsMvFrLuJSiQDy8D+C2Jd9hkKsOSKXfhI=;
 b=oXWLJ79+Py+7a5ZtKRZN7eCfOEetZDxyL26WlLDXjtuokU31eXhELOlNeyGeaz9NENll1gEVo7WrOLTjpJkZPJBX1IzrPCuxhWZfEWRqEuvQAWzR/OKktgUlSs0sph28nV/mX9w3ZoeoLtD/y1TwReKg8cHaX+Vc22GoGkaNBJauFJSmK3VxMZPlwjpNvrvYmkiatfuhQthF8KlIutq8lbP4XIkFl4rLWXEs65Uv0F8Kxuv8flgnXVzW0nbhdPoEEIDJcWhHOustma5tB61f/BJEFkKwQ3zLQgf/JoTR1/9l/HTc+pMkUycTfGjyeEXWsgmdzCoQ92WPDQTYWmzX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4iYQYu6/rJsMvFrLuJSiQDy8D+C2Jd9hkKsOSKXfhI=;
 b=JL4RA2EXz9nL2xV/Yd8wRDW341Q2GMqQdhXnl9Ohsqgn5RIf6X8kbDnf6gm63j16rZ91Fj3SC1GBBpJGE0ocmx2H3doDG3by7h6xQ2nvIDWxn4P9cx5kZxNVM/VVf05vMWLj0EG4CiIM8KliY+WZJGvwz2OI9PdwYut2FvbFnoU=
Received: from DM5PR12CA0008.namprd12.prod.outlook.com (2603:10b6:4:1::18) by
 BN7PR12MB2628.namprd12.prod.outlook.com (2603:10b6:408:30::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Thu, 16 Jan 2020 20:14:23 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by DM5PR12CA0008.outlook.office365.com
 (2603:10b6:4:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:23 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:22 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:22 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/22] drm/amd/display: update MSA and VSC SDP on video test
 pattern request
Date: Thu, 16 Jan 2020 15:13:57 -0500
Message-ID: <20200116201418.2254-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(428003)(189003)(199004)(356004)(186003)(36756003)(316002)(54906003)(4326008)(7696005)(86362001)(336012)(15650500001)(70586007)(6916009)(8676002)(2616005)(1076003)(26005)(81156014)(81166006)(2906002)(5660300002)(8936002)(478600001)(70206006)(6666004)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2628; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a988453-da6e-49d3-833e-08d79ac0ad92
X-MS-TrafficTypeDiagnostic: BN7PR12MB2628:
X-Microsoft-Antispam-PRVS: <BN7PR12MB26284E5BED75703F23FA00AFF9360@BN7PR12MB2628.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HsxriHMF1FxkR4wX89aQ4uQbnVpuUPyoXupm9uKV//2lfOn6oZ8cct6JKBGKu2PpaDHxAMZFsibA3sVlzpUl7P5ym78tj9v+c7VBlqxFVKTD5YztHjXbEmGGsCYZSa5IwURgxKvnXxnZ5eZGZzKhdAzh875JfiZbCWW0dbFvvFf3EJRNpWPXC+E2U/eRVBqsxFEDHU+rIF3r0ZnPO7ufSh8XlZLltjd3v7X7iRI82ljUN3fi5QXP08evoRgET2TWGGoB7zS4AVDaDCCmd/ScOWinvAU8mVwu87BmtUDOgP/2Cs0cGtSDBZ8CCpVvXLmGJk5MaauA0n8yDouSk5kUbEFOKqC93eH1d5wQURdbXc6BB4tKSv07ommLPxqT089oJhxLZuNk3plRge1yV3YS0szBovkI3wXICDAKq3GCxcsox5Q0r5bUEPNZ65cQBZt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:23.1642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a988453-da6e-49d3-833e-08d79ac0ad92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2628
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

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
