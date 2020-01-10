Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99093C33CA7
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6332080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zzhklM57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6332080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B7C6EA52;
	Fri, 10 Jan 2020 14:48:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770049.outbound.protection.outlook.com [40.107.77.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8F66EA52
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTV62o4+/FEAOURZX1wPN723bX6Vs+VuQqLaaeVigqEhXff06Bvfb+ApRiafhTR0cRdW4HDvkQPjoVAE59tG67I2PufPSnVbnrPAbdAlhq9q0hbuYTsSrENUf1XM9/4cSwHAJNb2RfrntdIiJspsaab+5rodHh/IGKobZR3NEkEDTAtmGDOZ8ZxMl4GyPxujvOw1ElvnCem/uloSgO4dmNUYSriC0CkdOnWnYNg/hjddCZX12tgh2g7fwWZvsx4bF6+sO/kc8AWMypYkO9MnyHOkKiY55YHblBW5fTQc68BLx/kMUf3K81fCzvuQOCuYD5apWDdPhluEKSQhOFudNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA+o5cn6QMTNd+4WcZFANFk7xVnDIh+OMiNsVzjdD4M=;
 b=ZTl6y1jFgQfbNfRTIcUms2uzZ57C1TlnaNnyunsGmR4AigwaEoIKhKJT0wVRW+DJwSX889tTC0CSnReboXiXrNOITGo51FjBqemhtdMFWcKwBXYTMkZLV8S2DMC4f43VZ3CSkUNR4/6fNUrP7yzgsYD+tB8exIpfPFX3RFXp1wljBjOVufAqRWj9Igkk/zO9eiTk8wf26JQxshWkVA26GO21vMlAHlN4kZFQbXrpqOA3YXs+mv0l6ClEPwmpHtBA4o216ol2Ypb0JkiSTmq7b54t6eKmufsW8FtTmMFJ8zv90ps+nj6+ppUG799sb70/wOobo6x02fVF8NW1dTu0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA+o5cn6QMTNd+4WcZFANFk7xVnDIh+OMiNsVzjdD4M=;
 b=zzhklM57ngMuLqWVcITOvwF8Cn/kH/3gBCLSLPpMKEid0NnKVkrfAByKqoO0zuAUvg2giQISFKC99pcF8zxddzYhi4As0MgysV00xDSOXc9LBiP36vMVRU6mMhUz+F6P2vvpmm+d5JkgfQ7jmxhygMdL+Vcx1FXBP+u1YmETg/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:22 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:22 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 41/43] drm/amd/display: reallocate MST payload when link loss
Date: Fri, 10 Jan 2020 09:46:53 -0500
Message-Id: <20200110144655.55845-42-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:56 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d25c132-6c3d-40f8-560e-08d795dc14db
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB237877980868C54CFE66FB1A98380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4B6/c5SGrEu/3svLi3H0EdeuuQFIV8OoUctpRTAa5rHOSIh7UNQ2haxvt2tH30fesktdBsOYBn/pcxkO7YYi1dAqq3mBqCAe4J6+wNGUCEiCIqv+kQCptP4/g2vrmm3H+Fy1Lk+KNRac5KSuWG6YeNLw4FUeGhaP+oZSfBIKs6EvN5awD8sp3AJ832TF8/VmCjBMoL88+ZvRMBMfyTDp1otTCG1BPGF5uGVJeBoiqy/gv1Cbh4qXAckw7J625IfOtAswjFPCnyokYbbaJGW7QQ8GOoA4EEzWOdK5zZB5X4Uja8HbZFiRIVkmixIw6SbJpMk3Huh5GzHIl6069pADeq7L5wo8SRCwpHL+ACkYn55QWA/kMZYFkPnrCkM/QfFFzNJXPYrF8s5IHWu3ZK1LJvjNyCfN3exh81turxKoMZDkk/2PkPQeIyYziJzND2qi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d25c132-6c3d-40f8-560e-08d795dc14db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:57.3345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEShG/7xq1T5VxopFfb9Cw1luMmaKA5VdJBP1gfRz6BksXkPfERhf/J6/Ccku2/aFHFSssWBKG5iZm/01lrcCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Paul Hsieh <paul.hsieh@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
Try to allocate MST payload but receive HPD short pulse with link loss
casue driver allocate payload twice. It cause monitor can't light up
successfully.

[How]
When driver receive HPD short pulse with link loss, we need to
deallocate payload then allocate payload.
Then we will not allocate payload twice with same sink.

Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 33 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  7 ++--
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a397b6a28633..1f2331684967 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2873,6 +2873,39 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 
 	return DC_OK;
 }
+
+enum dc_status dc_link_reallocate_mst_payload(struct dc_link *link)
+{
+	int i;
+	struct pipe_ctx *pipe_ctx;
+
+	// Clear all of MST payload then reallocate
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link &&
+				pipe_ctx->stream->dpms_off == false &&
+				pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+			deallocate_mst_payload(pipe_ctx);
+		}
+	}
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link &&
+				pipe_ctx->stream->dpms_off == false &&
+				pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+			/* enable/disable PHY will clear connection between BE and FE
+			 * need to restore it.
+			 */
+			link->link_enc->funcs->connect_dig_be_to_fe(link->link_enc,
+									pipe_ctx->stream_res.stream_enc->id, true);
+			dc_link_allocate_mst_payload(pipe_ctx);
+		}
+	}
+
+	return DC_OK;
+}
+
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8206bb3f74ec..daeee64eb899 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2902,11 +2902,8 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 			pipe_ctx,
 			pipe_ctx->stream->signal);
 
-		if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link &&
-				pipe_ctx->stream->dpms_off == false &&
-				pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-			dc_link_allocate_mst_payload(pipe_ctx);
-		}
+		if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+			dc_link_reallocate_mst_payload(link);
 
 		status = false;
 		if (out_link_loss)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index f9aae35aec92..d25603128394 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -205,6 +205,7 @@ enum dc_detect_reason {
 bool dc_link_detect(struct dc_link *dc_link, enum dc_detect_reason reason);
 bool dc_link_get_hpd_state(struct dc_link *dc_link);
 enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx);
+enum dc_status dc_link_reallocate_mst_payload(struct dc_link *link);
 
 /* Notify DC about DP RX Interrupt (aka Short Pulse Interrupt).
  * Return:
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
