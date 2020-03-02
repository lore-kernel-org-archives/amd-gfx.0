Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C20C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9920021D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="stY7iHIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9920021D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03C56E5B6;
	Mon,  2 Mar 2020 16:48:00 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03D16E5BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIKHLEyJt4RfYUTbx8m1diqLpqM38lvnyyoQEXMDnW7ITLuGgv9YxCHO0RU9/blU2iTnPMtTUGZC4z6SgCnP3mm+F0I+9NbR8PQq4ePFKvqrbmnZjTN3vm2ltb3LdtOLrcGLjNOyzQUBQtqlcoR4RSlc4PyUW7NHipP4/+xhtPYrs9efUtVdINkN0Fpm8y/J1yJTD1mNrrCsDPkapaiLwue1NkLvQ1nxeJVbCG4bEkKZaeqmqYiaHj2dzm6sITtU/BksPhBbMlr+LeVwT4nflsOw/SVzAiZ7DaxDBeFaAkE63k6wz/GKoHJBHLSzA4MprjVS7q0N745OE+ITC3MHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLh0t2ensJABcJICTHwfYmqB2+bvVsLRar0hLhvGWeM=;
 b=LDADbyXE+wag12FNSn1dmNKQbCRCYeEGCek9dAnc7anlIKsVFpVHjcjKWMbCPdGmFCYNldo4+GwM/95NKNr3AL1QMBwpJg/0OBwvilt6iZDQRRJjo/6R4DxvfhRiqEgwkOWvumdwFTb5jzA/+keGmpiGk7VaaC46jJIGmMxnYGx0n/IvvAPYZ5E8ZMeIefK8oEUP4hfUl3Ec+P9+BNZBaKTjaxFqnlOWj/jYNyEYYb84Y76BXsrqTS2KR5KvTltWEFXZ6R9FY3o+5u3bZX6xnU15twgrVCdWmogt755Coq/0Hj9RmXw/+wqzRJRjKYqV4SHvf9kM7QoTtASd2RQglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLh0t2ensJABcJICTHwfYmqB2+bvVsLRar0hLhvGWeM=;
 b=stY7iHIXTlZ7kUB+PUFbHt3RzUEtupXpmRbhVdaaY/YnwpRMPwD1ubVfgtO07Pc2GyouzaWIUEwHEP/nmVdyVqSu0/qmBkXo/yOldUQ6DqV74p/qDSAaFARk20ThgZoLzn7WGRndfhadKTf/KCxSotMdqhA/7nKc7rxxkjQ6DE0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:47:57 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:57 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/22] drm/amd/display: add vsc update support for test
 pattern request
Date: Mon,  2 Mar 2020 11:47:22 -0500
Message-Id: <20200302164736.89429-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:56 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ebe68fd-a50f-46b4-ba2a-08d7bec975b8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2411E93CA72E1ADCEAEA7D1C98E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(15650500001)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67ghfS0Z43LCRQu3h5tZ0LNVQWIE40Slcnmvu5X/JVIjuE41CRl04imVCgWIYCkQqXl2pSQph41BFAXR6YWD1O5PzI544P1oMQnmIjYAuEivd5RZJVwff6GTs5Ip/gocXttyz+Xrgdx7dO2tfAONdA76dI7TVKxE6eSDiX0IKEx0HzXiXbkSNm9BKYa+53eUKyV//vmZleLXPnNVNryNGdxqjyWwmpTK0RQynAw0yHl1dj3h+TaNtgLCtRD82+O3S7p6nt9nhpjIwEwGLyXTm2FBB0caxTxL06NBXY+0ifYQdvYlOUvWBYOfxEYw+uhzf/h2QPwvVvXmVObVCvy+kS34I0NB7clIJXbqhfS2yj7IuOm+Ch5ekyfGt64tOF1KQZJOou54MoI50yiKDqGDQxOOIQ65vW/evNgGECeCsnRSU2206A5HslV09z6N0vsr
X-MS-Exchange-AntiSpam-MessageData: tTEwkAzpUGXwhRZWQpNoS7o9DmRY5ySCoLEkch/EhP++6fT/MFASTYTUoUW69+l+pi/EnPdR/vlXx9I9jqhh+FCdAcv1T7P6cctzCdkirzt+XbuaVXHCJZBaonyherIBvShR6p6JZIjJJAFCgLf4UQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebe68fd-a50f-46b4-ba2a-08d7bec975b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:57.1557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otE6DquUXGkfhj6Ly7e1xWlwZSFKydAL3d+PLYzVJzU3GGeRrgrg4GXd6hdixweyDGneqdzz68ey64dB+BDOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[how]
Allow vsc info packet if vsc is supported.  Update vsc based on test
pattern request.  Remove dpg_is_blanked polling, apply hardware global
lock instead to ensure double buffered dpg is updated with vsc in one
frame

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 32 ++++++++++++++-----
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c805bec18044..c81f55b28497 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3720,7 +3720,6 @@ static void set_crtc_test_pattern(struct dc_link *link,
 			struct pipe_ctx *odm_pipe;
 			enum controller_dp_color_space controller_color_space;
 			int opp_cnt = 1;
-			uint16_t count = 0;
 
 			switch (test_pattern_color_space) {
 			case DP_TEST_PATTERN_COLOR_SPACE_RGB:
@@ -3764,12 +3763,6 @@ static void set_crtc_test_pattern(struct dc_link *link,
 				NULL,
 				width,
 				height);
-			/* wait for dpg to blank pixel data with test pattern */
-			for (count = 0; count < 1000; count++) {
-				if (opp->funcs->dpg_is_blanked(opp))
-					break;
-				udelay(100);
-			}
 		}
 	}
 	break;
@@ -3987,6 +3980,11 @@ bool dc_link_dp_set_test_pattern(
 		default:
 			break;
 		}
+
+		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable)
+			pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable(
+					pipe_ctx->stream_res.tg);
+		pipe_ctx->stream_res.tg->funcs->lock(pipe_ctx->stream_res.tg);
 		/* update MSA to requested color space */
 		pipe_ctx->stream_res.stream_enc->funcs->dp_set_stream_attribute(pipe_ctx->stream_res.stream_enc,
 				&pipe_ctx->stream->timing,
@@ -3994,9 +3992,27 @@ bool dc_link_dp_set_test_pattern(
 				pipe_ctx->stream->use_vsc_sdp_for_colorimetry,
 				link->dpcd_caps.dprx_feature.bits.SST_SPLIT_SDP_CAP);
 
+		if (pipe_ctx->stream->use_vsc_sdp_for_colorimetry) {
+			if (test_pattern == DP_TEST_PATTERN_COLOR_SQUARES_CEA)
+				pipe_ctx->stream->vsc_infopacket.sb[17] |= (1 << 7); // sb17 bit 7 Dynamic Range: 0 = VESA range, 1 = CTA range
+			else
+				pipe_ctx->stream->vsc_infopacket.sb[17] &= ~(1 << 7);
+			resource_build_info_frame(pipe_ctx);
+			link->dc->hwss.update_info_frame(pipe_ctx);
+		}
+
 		/* CRTC Patterns */
 		set_crtc_test_pattern(link, pipe_ctx, test_pattern, test_pattern_color_space);
-
+		pipe_ctx->stream_res.tg->funcs->unlock(pipe_ctx->stream_res.tg);
+		pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg,
+				CRTC_STATE_VACTIVE);
+		pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg,
+				CRTC_STATE_VBLANK);
+		pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg,
+				CRTC_STATE_VACTIVE);
+		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable)
+			pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable(
+					pipe_ctx->stream_res.tg);
 		/* Set Test Pattern state */
 		link->test_pattern_enabled = true;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
