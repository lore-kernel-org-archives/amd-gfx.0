Return-Path: <SRS0=iabP=AP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789BFC433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA7B2075D
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sOkZB6w8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA7B2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 486B06EBE2;
	Sat,  4 Jul 2020 01:15:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5D06E3D6
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2020 01:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzLi5eZFNibiguxY2F+18n47SIQuAMHpxOdY0OWe8FaFA23cXHJBtEbDRPpieBBG7IJtbUrESDgdPtrZXEMeuRGp331JCyNXx9I6wPTnRKp5jLNuYWSTpnsFOacJxkLMFDWoRj0IC7S90/pkwOXWT8yxYPbZAW2clFCt22f5/i1QnVe5HcotrS1YC7HFspauNtp6rHW+nN757kRlkMwWCO7E/0wYxACz8kcPbwf7n7XsyiKIwJt0F78zKLAKeaIxdn9NnxXCZCSqfFfR0XWqiva2L5CMiLKH9Hk1h5GWbbxgGnL2VvBG6ygbPMC7tlPJQx884f8GhNIvOmPDQpxvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ubF97VqwLSmKzRHf+A6l9R4bbgzpZ3gJY5uyVYrOS4=;
 b=TjcIpIlsGSd4bsgfR9aqrQh65x1C5/pe69+gHYL0yOnTWL4BMDbmL4I4sBNkfyZElpvovmZjPt1dAfkf54aWdkGhw5gf4ckBO127yP4hG0JLc+9CkZSaeHG0Asyc9KVfxCalaHLeJBRNtzqB79DVkrHyVp0lhM4uyqRKyppy1KaGY3+cxpb8ScXPMRvEjiwwxb6k3vM/y82JrAfmajS1YytbaNT1atzPAb59Yw1R3To8td+JeEa9Xr8cEL8+ba20wq7IGyBVS5s+wmmjtSQhYMdSN4gtkxhcO6RK+XloNRFXpTxEMgWz5r1ig6GqVDX+/xku6GGobzinow/rRd0oRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ubF97VqwLSmKzRHf+A6l9R4bbgzpZ3gJY5uyVYrOS4=;
 b=sOkZB6w8p/h8taevrHctWbPfb4joqrVyx+ov/XjwNJGj/4c6ycrVIkvRFCwHGMJ7ORbLnq2VmJVzajEZGK/OJi1QNG6uJTMpHVipviBY/vepvZB+9vh6KeH98xZLpnju9D6jRPTUV0BbT6zUa4VXlY1Ph9W8hbF1Xvd4d2ruP/s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sat, 4 Jul
 2020 01:15:24 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.028; Sat, 4 Jul 2020
 01:15:24 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amd/display: Add diags scaling log by default
Date: Fri,  3 Jul 2020 21:14:50 -0400
Message-Id: <20200704011457.2368241-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
References: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Sat, 4 Jul 2020 01:15:24 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cfdb974-1698-4c5e-54b2-08d81fb7ba97
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37683C8B8778E3E5CBFF7C94986B0@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:233;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaL8x5N+FUbLVv8Bj/hGGmzaVr5tZo43hSILdqbaCFU0oLUWmJwLLwcLwt0fZfFN4Bz9HBw9BDfv56DQg5QnAmDuOQRJo1JKtflPUX+Mf86qpqzkXIPsHQGpPT4zgv6dn8AMJ/FanyXh78hcCOQ69fuwWiQrF4yG86eSC/ECjIergvvpz/Dz6y73OQlFG74i/gF8pQaxuLvTZ0R+baQ2FyyBk2TRq4Gc+O5d7GNHRuUZaYCpZ4U8kvYWiKin91KOOMvmCSzvZ63RsWYQac0syEi2p3gHw3ZD+AqcW+aBOvXyPwbVtdcbpI8XHkBcm+Y+ErnW0qYViAW8EtqiFOd+qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(478600001)(8936002)(8676002)(6916009)(52116002)(6506007)(6486002)(316002)(66946007)(66476007)(66556008)(6512007)(2906002)(1076003)(36756003)(4326008)(54906003)(86362001)(16526019)(5660300002)(83380400001)(186003)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BF7qpeezqqmQw62IPMeZ6rOFF4vE0jBzyYI3nHi2BJvb4K2Jy3oMcvL+TglY235jpRNFYyn2Mu1sOZilfzdx7vwcxFYmvqATkEpjwhPQ3+PinKPx48YvYJypYlIbFxWOTthqjUQFus8yicrNlr49WPaBj7rfmuLW7s+CckYETY5fdd2Gs8cMg0KHndBwZcMXu3Guc6NcGzBUFpl3ssxob0l0/oJ9o7csqOJtHfCri3sFEVgflNzNGHTQMFHyWi6ZZy7yjE45/iVKijG2Tl6xHTjnVIHN/ZP/KeINcS4YkTCXX5unTlIgSpvXjBgJE9AW/ys1wW4evk95fOMJdDPhIuJsF0JVY3pmzb+XQSYMdAtZay3yivaZ/yrixpdh4TTeLs7liRYidpywIbC3gVAizGpCgx6bmTfdbG2Fcm3UVNyZpYH17+2eTP6X/JeTnuRM3B2PyT15pF5P5mgEw0jUSbqpw9l0+KkXmubhoGBixzPRh+cB0vkVyQd4VZXeJp7mvh98AJ2JGtkwwIX2Ph+tRA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfdb974-1698-4c5e-54b2-08d81fb7ba97
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 01:15:24.5041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeDUgJdoZlGaI3zNNiqGCxYDOznXcl8X6zlMTQA9gwxAJSGI9anFn2GGoFseniKjESkudUcfbTx1H3ysqusZRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, eryk.brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 aurabindo.pillai@amd.com, Eric Bernstein <Eric.Bernstein@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Print scaling parameters as they are calculated in diags.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 39 ++++++++++++-------
 .../drm/amd/display/include/logger_types.h    |  2 +-
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1000dc6daf72..7b5f90ebb133 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1162,19 +1162,32 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 		/* May need to re-check lb size after this in some obscure scenario */
 		calculate_inits_and_adj_vp(pipe_ctx);
 
-	DC_LOG_SCALER(
-				"%s: Viewport:\nheight:%d width:%d x:%d "
-				"y:%d\n dst_rect:\nheight:%d width:%d x:%d "
-				"y:%d\n",
-				__func__,
-				pipe_ctx->plane_res.scl_data.viewport.height,
-				pipe_ctx->plane_res.scl_data.viewport.width,
-				pipe_ctx->plane_res.scl_data.viewport.x,
-				pipe_ctx->plane_res.scl_data.viewport.y,
-				plane_state->dst_rect.height,
-				plane_state->dst_rect.width,
-				plane_state->dst_rect.x,
-				plane_state->dst_rect.y);
+	DC_LOG_SCALER("%s pipe %d:\nViewport: height:%d width:%d x:%d y:%d  Recout: height:%d width:%d x:%d y:%d  HACTIVE:%d VACTIVE:%d\n"
+			"src_rect: height:%d width:%d x:%d y:%d  dst_rect: height:%d width:%d x:%d y:%d  clip_rect: height:%d width:%d x:%d y:%d\n",
+			__func__,
+			pipe_ctx->pipe_idx,
+			pipe_ctx->plane_res.scl_data.viewport.height,
+			pipe_ctx->plane_res.scl_data.viewport.width,
+			pipe_ctx->plane_res.scl_data.viewport.x,
+			pipe_ctx->plane_res.scl_data.viewport.y,
+			pipe_ctx->plane_res.scl_data.recout.height,
+			pipe_ctx->plane_res.scl_data.recout.width,
+			pipe_ctx->plane_res.scl_data.recout.x,
+			pipe_ctx->plane_res.scl_data.recout.y,
+			pipe_ctx->plane_res.scl_data.h_active,
+			pipe_ctx->plane_res.scl_data.v_active,
+			plane_state->src_rect.height,
+			plane_state->src_rect.width,
+			plane_state->src_rect.x,
+			plane_state->src_rect.y,
+			plane_state->dst_rect.height,
+			plane_state->dst_rect.width,
+			plane_state->dst_rect.x,
+			plane_state->dst_rect.y,
+			plane_state->clip_rect.height,
+			plane_state->clip_rect.width,
+			plane_state->clip_rect.x,
+			plane_state->clip_rect.y);
 
 	if (store_h_border_left)
 		restore_border_left_from_dst(pipe_ctx, store_h_border_left);
diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index d66f9d8eefb4..5dea27fc5198 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -147,11 +147,11 @@ enum dc_log_type {
 		(1ULL << LOG_I2C_AUX) | \
 		(1ULL << LOG_IF_TRACE) | \
 		(1ULL << LOG_HDMI_FRL) | \
+		(1ULL << LOG_SCALER) | \
 		(1ULL << LOG_DTN) /* | \
 		(1ULL << LOG_DEBUG) | \
 		(1ULL << LOG_BIOS) | \
 		(1ULL << LOG_SURFACE) | \
-		(1ULL << LOG_SCALER) | \
 		(1ULL << LOG_DML) | \
 		(1ULL << LOG_HW_LINK_TRAINING) | \
 		(1ULL << LOG_HW_AUDIO)| \
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
