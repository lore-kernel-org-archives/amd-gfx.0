Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DBCC18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03F32051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l2CTi3zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03F32051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB046E47E;
	Mon, 16 Mar 2020 13:50:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD9E06E479
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1WtjH2zMFV3Lyt4ceXP0Opkcnque+n8zzcuKQ2qWJ6x3nnJ+5v9rEpgESYizCsrLQDZZISntJU/tNwhwlVzfiPOnnHx4Pps7P2odslAmmmHv81gCqrIUrFSB9vhvKlVcgUHMqszzit4CswsfLcurkGsMPp8Tc/GMbnV0MkOSeMiOaqiiU76/6tp+iNmqdbjsFGyOSt1+KIkuQrUbBoX0sKchJ4vDHoO4FByc5v1Q8h9zAs0H8E+seZk40KaTM/hTaXOklVyqekmh03dj8uaKdoHsPp59eGZX9EZRSPkNXfktrcYYVAXzYI0dz/en92CweUCP1nDci2zPYBdRpL1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4PNApsRkH2+7C4xKIuxM8Fjyxub+DSmtFQEJhC+Nvo=;
 b=H6iIWqLHYONeBNojH42lhOM8B2DfTfuEuAADdtac50OycjQH1esG3kKPoGkrEhxdFIEeJOYYAQWIqFMUQKzzjDHbN9p7R7kgobEF77tJiWEw9lagvqUNO7pB2AovQF3uEYga3O/dPspr55hRalfnDSOeVt0dEei8hWYXzMJaWg5rOLddGCvxoBJUMERIzcMRaBp1r5oAF92XQ50SiR+9UK9F1k6Y+CBfiGAnayZhl5yTVFEqqMAPBwMHsRr8v4U8habP95DpllUHBu1oJjj3EtAuia9d1cjBfr4wsdANRrEgXX8L5/5Kr3q9jeKM0rBwOUsWeoXTWgMPl4vDXbVShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4PNApsRkH2+7C4xKIuxM8Fjyxub+DSmtFQEJhC+Nvo=;
 b=l2CTi3zxvpJ3auu5P6cO2cL/S/VcNWwPvcyQDzJSYMoOBYnMRthR0UJSf4BkL3aYwzFajQM0BJ14PgNcCvyTWbni4aDjlrft+Nj3zfQ64AkQQmMRTUTfxbIr0cMQ72Bs5dlgs9FyX0RvMW+60zwGHhjNnSiiauOKiFYvvvdwNjM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:10 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:10 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/19] drm/amd/display: Remove connect DIG FE to its BE during
 timing programming
Date: Mon, 16 Mar 2020 09:49:17 -0400
Message-Id: <20200316134920.2526155-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:09 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 621f677d-c396-4d98-dc53-08d7c9b0f160
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23969783C095310697BE12D698F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeB+08hoijwFY5J4n7RCBptvZ5j3d0twdmDiCQCt/lW+3K/pzCi6zzVIlMBCkt+/pvr4m5bDx75obB6SdYn1WIPiNRV0URz3NnsJ6cJHzCcntUP9oVPNrG3zC0v0RWMVEKY4siyWmEUUUk8Wu8QveH4761Fmlxse0Y13/umG4C7dlXJlfCCmusUhRtV0M3BJRtO5qYioQufqlA+tXOjWu5imrizYm0cJdZSC0gURfzba2zfY2mkw1vyiywgx0iKhksBPpesCZURbKUUkTyP3sjRZ6xy2s+YxMZKWPnkhnl+ATEHJB1z32V59MUx+uLz+GtWhCbL2yhI3pe9M1bMhHe/fmZjKPTCto8V5eS4tc45m/mCTfZIHaXq8eKFeSGPxEPwyf7+69i9phuTREjrEomlMDydd3HeupK2+RN0rVOWGhjMcsg+qEIiqF8xIku8F
X-MS-Exchange-AntiSpam-MessageData: OYPhojAVpxrdcilMRUcF92OL895+nnGEZro1CaBQA93GLXDWjSefUFpuYcZrLU8STE+M6y0nguzDQWSVBStS8VDh0MaDmLRYzDLQyKOCM+ausj6wvX8pt4wPm+7Om/uPo6m+mfd8si+8wXLb5CoyyQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621f677d-c396-4d98-dc53-08d7c9b0f160
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:10.0686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2RlszVUClwJWo/mfy64gEzW8gsjkyt9lk5G8Mr69CYvwVgiyLBPgAlg1MyH2MqUhUID1LBN9MVDIDLhGmzzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Nikola Cornij <nikola.cornij@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
Causes regression with MST DSC displays not lighting up after DPMS

[how]
Revert commit 3ee07fdc908c40f570f8ce25f12b5ad6463b87ad
"dc: Program DSC during timing programming"

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 11 +++--------
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  7 -------
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |  1 -
 4 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fb603bd46fac..67cfff1586e9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3069,14 +3069,9 @@ void core_link_enable_stream(
 
 		if (pipe_ctx->stream->timing.flags.DSC) {
 			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-					dc_is_virtual_signal(pipe_ctx->stream->signal)) {
-				/* Here we only need to enable DSC on RX. DSC HW programming
-				 * was done earlier, as part of timing programming.
-				 */
-				dp_set_dsc_on_rx(pipe_ctx, true);
-			}
+					dc_is_virtual_signal(pipe_ctx->stream->signal))
+				dp_set_dsc_enable(pipe_ctx, true);
 		}
-
 		dc->hwss.enable_stream(pipe_ctx);
 
 		/* Set DPS PPS SDP (AKA "info frames") */
@@ -3103,7 +3098,7 @@ void core_link_enable_stream(
 	} else { // if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
 				dc_is_virtual_signal(pipe_ctx->stream->signal))
-			dp_set_dsc_on_rx(pipe_ctx, true);
+			dp_set_dsc_enable(pipe_ctx, true);
 
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index ac2103dec9e7..51e0ee6e7695 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -394,7 +394,7 @@ static void dsc_optc_config_log(struct display_stream_compressor *dsc,
 	DC_LOG_DSC("\tslice_width %d", config->slice_width);
 }
 
-bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
+static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 69eb7b3697d2..233318260da4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -623,13 +623,6 @@ enum dc_status dcn20_enable_stream_timing(
 
 	/* TODO check if timing_changed, disable stream if timing changed */
 
-	/* Have to setup DSC here to make sure the bandwidth sent to DIG BE won't be bigger than
-	 * what the link and/or DIG BE can handle. VBID[6]/CompressedStream_flag will be automatically
-	 * set at a later time when the video is enabled (DP_VID_STREAM_EN = 1).
-	 */
-	if (pipe_ctx->stream->timing.flags.DSC)
-		dp_set_dsc_on_stream(pipe_ctx, true);
-
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		opp_inst[opp_cnt] = odm_pipe->stream_res.opp->inst;
 		opp_cnt++;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 64f401e4db54..e94e5fbf2aa2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -85,7 +85,6 @@ void dp_set_fec_enable(struct dc_link *link, bool enable);
 bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable);
 void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
-bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx);
 
 #endif /* __DC_LINK_DP_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
