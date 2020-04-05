Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2CFC2BA1E
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB1C20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p8nlmn9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB1C20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF7689EB1;
	Sun,  5 Apr 2020 20:41:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0B689EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0rhByGMGCImnExAc9kMKc6CpzJdNx4MXq9o1ISt1DeGmM4/QSYgVdGhVFCvGpqHc1Wa21mZZNdZkPsorbCiQS8AjSu8QLtpdkvxIu+FmNjjQlaFuxB0QIx40QRJv6KhSX2HSpV84daFPYZXm8R0hQq0gxPN1o+Zn9kdBxHYg4xwV/Ooo5d5zfklirs45idoPMTX2GT8Lxo53jzEX/iaxvNYURZxBKCGqoE2Q5rZoqmfbGviFOXwl2Qdb1L090ZZLMel+J/kRlBCBMXRdV6GCVnyB3ONu7bFtuJJXoKTp1qznZ+4X52CakDH80awxZqQMzRUnwU4/EP9dSVi1Zx36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AHHBi+HYp0+n0+i0TT48VyRHNohSvKzSuAt78AU6XA=;
 b=Gp6z99rpGuUUexgnai08LafezFXRasu5WYNWHLcYvyMLyJnBlyzsiArkn7uUBfxPvhvqGdSpYskMFISMXJyB32hJolCHX0HUMqlufqa2M+l4v0hPQUV654gcX5a7Zm6BsxtZMY7aVVFIWoJ136PCAWfh4pPK4/jSsiP+46B6Cm3igjmbB4JXdA+fMiIz5HboVGg60x0G9fNE9nuZ/TFXMB4+YoSmaKlgllT7kJFjUU5E+zGgtaZj0GgIbVnNw7j4YgZU6U9cRbbkiG3yvSzScUwvTXVTfiSoGEi/4SD5T4UXYf2oEO7iAZihtX90qttoq4583LXe3KBeAqXjcrs5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AHHBi+HYp0+n0+i0TT48VyRHNohSvKzSuAt78AU6XA=;
 b=p8nlmn9N/FrkWHTxf455vVPnjVebzrKSQAx01kcvH6mrpdXutOhyPGF5nichkAY55Ce+ueqmgXmEyVvV9NUgPaiAUoq9Q8aoh23KSwFhJrfpPms/wF4NEysnvdYyKav2vcW4+OiefAzgA0Xqg5ydOXsW0eUc72Q0bSt51SQmfAc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:44 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:44 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/36] drm/amd/display: Power down hw blocks on boot
Date: Sun,  5 Apr 2020 16:40:45 -0400
Message-Id: <20200405204115.683559-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:43 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b1001bc-5052-4e7d-5bef-08d7d9a1c0c8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555922538760CD19AF5E20698C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGJ6qyW+2zcSWHAVy6IhuQ28vunT5o5vwm9EGyMGPDDUZm1ENLi4xEvCBt2jMbi+ZXGuVulOQ9ORcwUgxylAdUAL+KDoLI44RWkusqgWY4pbeVD1Bg7j2wWyh+5nJnVuCgfmLH81WveGbBuRZ8xVcO/1skyc22HUQOK2r+6ojfgg8SJ6LLat3A+R4xPrlDq2SybvhNbSJ9aKYv2BuOmNQmaBm1f/VtNV8LYLD7GBl5h2edgmwonzk3ycFg7pzpMPHU8BQxvNgxg6z6KlFzYU3bHjDZjGdwK9Lfv/qxyZCPixoLTR5Pg9UmmZa2Yy1eQ6lrpezo1XliMTmYGRws3A/I/5fzl9WpI4f7MLKP/v2mbwwFGP/CO9oL7qn8nTbTKBcIIBXNR0qVV6xabqQZCuyR02uBTI/YFFcJ7tkf2NofNpiOlrikO0URe2+eDgtEhl
X-MS-Exchange-AntiSpam-MessageData: VMszfwhOkBih91kIn+OS5fly/HZrqQPaXjkJBLFrBYp5QRclDkknkmwFna29rfbX14bRGJe86w874oFcVUl/VxbXa/ntAmV7NPFfBnSYs4aiVJvDKkkNhrWcZv2rPFy2m/YN0gaZg638EbNkX7sLAgQXwxXEuNJPtN9UL3x8xfM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1001bc-5052-4e7d-5bef-08d7d9a1c0c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:44.5251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3tBL+LA5FiU/xPQhEgeuyRkdjJbkxqe1D0H3aVNnswlHR0jlNHNLfRory+eQy5hSXyqbK3Q9zXV0jjmO0EvGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Sung Lee <sung.lee@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
On headless boot a DIG may be turned on by VBIOS on RN.  This leads to
display_count being non-zero in hybrid graphics cases leading to SMU
DISPLAY_OFF message not being sent.

[HOW]
Power down hardware on boot
if seamless boot is not occurring
(power_down_display_on_boot == 1)

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 29 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 +++
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 0be010085575..dad95f1a7041 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1361,6 +1361,35 @@ void dcn10_init_hw(struct dc *dc)
 					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 	}
 
+	/* In headless boot cases, DIG may be turned
+	 * on which causes HW/SW discrepancies.
+	 * To avoid this, power down hardware on boot
+	 * if DIG is turned on and seamless boot not enabled
+	 */
+	if (dc->config.power_down_display_on_boot) {
+		struct dc_link *edp_link = get_edp_link(dc);
+
+		if (edp_link &&
+			edp_link->link_enc->funcs->is_dig_enabled &&
+			edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc)) {
+			dc->hwss.edp_backlight_control(edp_link, false);
+			dc->hwss.power_down(dc);
+			dc->hwss.edp_power_control(edp_link, false);
+		} else {
+			for (i = 0; i < dc->link_count; i++) {
+				struct dc_link *link = dc->links[i];
+
+				if (link->link_enc->funcs->is_dig_enabled &&
+						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
+						dc->hwss.power_down) {
+					dc->hwss.power_down(dc);
+					break;
+				}
+
+			}
+		}
+	}
+
 	for (i = 0; i < res_pool->audio_count; i++) {
 		struct audio *audio = res_pool->audios[i];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index b9ff9767e08f..a6ed70fcbc19 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -90,6 +90,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
+	.power_down = dce110_power_down,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index d4c1fb242c63..9380721f28b8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -75,9 +75,13 @@ struct hw_sequencer_funcs {
 	void (*wait_for_mpcc_disconnect)(struct dc *dc,
 			struct resource_pool *res_pool,
 			struct pipe_ctx *pipe_ctx);
+	void (*edp_backlight_control)(
+			struct dc_link *link,
+			bool enable);
 	void (*program_triplebuffer)(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx, bool enableTripleBuffer);
 	void (*update_pending_status)(struct pipe_ctx *pipe_ctx);
+	void (*power_down)(struct dc *dc);
 
 	/* Pipe Lock Related */
 	void (*pipe_control_lock)(struct dc *dc,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
