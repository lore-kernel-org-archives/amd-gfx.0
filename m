Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB03C35246
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40E92082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="edlYGSwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40E92082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D2B6FC43;
	Fri, 31 Jan 2020 22:17:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0356FC3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLEhz5oRHQa9eVaIWiznTDusrBmwAM6OzS+5uiMtcTqPdSkHr4v1uLGp8liTlDJZ3CVYcBkhPehMvljFE2lLmLEBT9s+UbFfYtVz5rtOmAjI6QKntjALwkwg7kvsZaIFuYNRcAJbNmRb8x2YZFzP0QPbVSeOtOSVL+zCYuWSeFEvv3/YuFoaSZSsF9r6IPF/7Lc97AFYxz68w3UUBwJUFxgHGH+zLxgY8mk4lWViFV6iVmPKBP43U9O9W92k4Pu+CHiQ0BeiJMVwSZgu6KyPesKWQXhzYkfx5iKOfTlmPNGRh5f3B85nNGJgp70wFAVcbOn6OUDgEp5VKdG0w2GGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef0ss84leJZJ5Idx3pr7elxnafK3sSwgNLXm5iBZdzQ=;
 b=IRy2pl8eiTukjSNjizK/HP9xEWmU+yUtZICI52iddQSaeSXBpbQbcXznUlR4Q4PyxFZj+R+tD4ceR+V0ip67rKusQW9MRCD6VSyFn2JmKbc/FmE64/4kbqAYCtLvlMKbxpXtjKFCpwjEvVV6mLZda69lw+kRtOLMAwwwiyHu/e3uPC+7PTapCj1s0j9ujzHaHP7Ft0iugjF2n90oBxYNO8c7e+JFqVj729t/FgCVRTldfZBaNDYJlUL17xKRLYKriXIIMRtcyxb627Yw2Bq6ibyc48w3pj9QYIgBXQTFmGxteqQMRCYPeDg3jbLCYZLbCMP+IrxXQsvbS21rAMTqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef0ss84leJZJ5Idx3pr7elxnafK3sSwgNLXm5iBZdzQ=;
 b=edlYGSwrQkp8FvblIxME0QFoUY7+ZUFtdGDi6zVBbO3Xr+tYV4SZY4gGKGeapNaH0WEmqzbWLGPdlW7CSyekEnIR3yeRG/umEHV2lVA1+fK6FVF8e1oJf7KOccGUGqzFEsLoag1mMTYGQlf/PkSwHLlIp/JqblE+yX+H2BnGflQ=
Received: from SN1PR12CA0095.namprd12.prod.outlook.com (2603:10b6:802:21::30)
 by MN2PR12MB3295.namprd12.prod.outlook.com (2603:10b6:208:ae::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.28; Fri, 31 Jan
 2020 22:17:18 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by SN1PR12CA0095.outlook.office365.com
 (2603:10b6:802:21::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:18 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:17 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:08 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:08 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/33] drm/amd/display: add stream_enc_inst for PSP HDCP inst
 use
Date: Fri, 31 Jan 2020 17:16:28 -0500
Message-ID: <20200131221643.10035-19-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(428003)(189003)(199004)(6916009)(54906003)(36756003)(316002)(478600001)(7696005)(5660300002)(70206006)(70586007)(2906002)(26005)(4326008)(6666004)(8936002)(1076003)(81166006)(186003)(81156014)(8676002)(2616005)(336012)(426003)(356004)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3295; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfcced4f-fded-4425-7fd3-08d7a69b553b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3295:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3295A32D60454726151DC6CCF9070@MN2PR12MB3295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rqXR8KCZEvSvgfVM/5Pt51oYabn9T0CwotvOZeyA2BrcPFULHJTniARB/wf8X7hMYS0NZZSIw9erYWk5n9qDa05aRruBJ4zg+aUaw4N9USruD67Wph3/Qr90zTzZBurP85tWMMo8jr0DxY06byuDRn2YdUDiyKaI6vPetv5AzDSVYuC61sXV7bAXi30DLS2fzzvVC911/70BiIUfJ0wY1YochkoYG4SQKNnUBepyhaXQTSpOLToBZefUYiCLv/38pA+aYJm8wz6JKJeTcuRL0bGR7cvK7o2Q1EkN9idiwEsW1wtUaKVGW4qXk5Bxrs2uxwJ9h6kv6U4s5VpK2G0pK0pPEn6McrnsxwItf4nH5ZqMDPg6q76Er9hwkX/ALEErTTaZUOq75j6OnMGf1WYNwzvbMX7cj/cBUo5c6xH06b2VzxXw0uib6194fuWgoHw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:17.4693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcced4f-fded-4425-7fd3-08d7a69b553b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3295
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
 Charlene Liu <Charlene.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
new HW engine mapping requirment use in PSP
[how]
report stream_enc_inst

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c               | 3 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c | 1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h      | 1 +
 5 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 41184e593f85..fe50747692ec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2922,7 +2922,8 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 		memset(&config, 0, sizeof(config));
 
 		config.otg_inst = (uint8_t) pipe_ctx->stream_res.tg->inst;
-		config.stream_enc_inst = (uint8_t) pipe_ctx->stream_res.stream_enc->id;
+		/*stream_enc_inst*/
+		config.stream_enc_inst = (uint8_t) pipe_ctx->stream_res.stream_enc->stream_enc_inst;
 		config.link_enc_inst = pipe_ctx->stream->link->link_enc_hw_inst;
 		config.dpms_off = dpms_off;
 		config.dm_stream_ctx = pipe_ctx->stream->dm_stream_context;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a0eb9e533a61..cd80d8249d14 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2034,7 +2034,7 @@ enum dc_status resource_map_pool_resources(
 	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i] == stream) {
 			context->stream_status[i].primary_otg_inst = pipe_ctx->stream_res.tg->inst;
-			context->stream_status[i].stream_enc_inst = pipe_ctx->stream_res.stream_enc->id;
+			context->stream_status[i].stream_enc_inst = pipe_ctx->stream_res.stream_enc->stream_enc_inst;
 			context->stream_status[i].audio_inst =
 				pipe_ctx->stream_res.audio ? pipe_ctx->stream_res.audio->inst : -1;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 376c4264d295..7eba9333c328 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -1667,5 +1667,6 @@ void dcn10_stream_encoder_construct(
 	enc1->regs = regs;
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
+	enc1->base.stream_enc_inst = eng_id - ENGINE_ID_DIGA;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index 9b70a1e7b962..99a7ef6ab878 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -616,5 +616,6 @@ void dcn20_stream_encoder_construct(
 	enc1->regs = regs;
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
+	enc1->base.stream_enc_inst = eng_id - ENGINE_ID_DIGA;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 351b387ad606..ac6523c0828e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -103,6 +103,7 @@ struct stream_encoder {
 	struct dc_context *ctx;
 	struct dc_bios *bp;
 	enum engine_id id;
+	uint32_t stream_enc_inst;
 };
 
 struct enc_state {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
