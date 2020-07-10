Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C60CC433EB
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D101820748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e800xKc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D101820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E4116ED13;
	Fri, 10 Jul 2020 20:34:11 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291EB6ED09
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihTgH4uk70pOiAwbvbKfcBTuZfysA/QDhUUJtwTANjTTbkmbIi/mQZad9vUCX9EdCo5ApttblyrHS/wyzREMuEmjd6wuP7L0cVtNUlPObyQ2qHzqMY/y9wTgfa/oNFTQhQMaZuI4rbWcJ4LGmLTQhTDofHJmKULNxUnHlwPCG7HOIYJic/3Ku7R5Y4b4vWZdJB49g+r8/fqaVlBNBh0VA5drcnAZsATN1LfGwVGy2gaAKRrBB/D+Elnx/dcvMqQjW20Ldca0Q+4HX8C7ifUaMFjD/3rvaDMSxEepPqO6ZAyQBMDSMOdj8xAaAbeYSm7zfCdMytnpf0BnwUidd6YQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOwzTWXxsbkciuYDLWKVBJ1NiwQnhg3NSaM3m4KMoT0=;
 b=llVWUelmWd0wdy/S9iyUc1nFeVoOWNm5W21zWu/8QWcol300QzvheYtZ7U/5gYnz4KeLkN/xvZWSTZ2/S7b8n704KyZIvVB9rNfAM70C1YP1b8fAUcSnJic2C6btSs028xCPUCA4k/qT6uXc47Xl1blobS99daSaija7cmoMcJGBq8qOk4ggiczzzKIPYYpqM4hfgPlUFpPKXoUwhkGA96PCUf8BcI6R6aNQ5AVK7Yel2GFc8E5G13jifsrcbLmWOW3i8OHGysR8gCTBN62iyLg6st9E8I7ZPoIVcCGq0wSdK4yIpf8FU8Elz7o0BtqKOlsvN7HgWtgvWevSa9fCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOwzTWXxsbkciuYDLWKVBJ1NiwQnhg3NSaM3m4KMoT0=;
 b=e800xKc1NWirmDlZaotS2ZQYLAko725LNeQoakD/D8ETaaji+Daa2qCJdam+frZ7FtA6tiIsY+/+UzfZsrqHurlBKAyuA974rdRW6zPCFHfoRIwEyaj51KOQKOedTyAJlHKCagpGb5n0Rqpggu8yGkJEDRtPpo+HKBFTS2Q3vAM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:34:00 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:34:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/10] drm/amd/display: Power down hardware if set mode is not
 called before timeout
Date: Fri, 10 Jul 2020 16:33:17 -0400
Message-Id: <20200710203325.1097188-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:34:00 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0479e894-c61f-48f5-cbc0-08d8251093f2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4231C11DD58064BD500BFF3C98650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:71;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfcQ9eECzwxx0+8x39YisVJw8Q+3dBivNlefe5h4iPPS1fMqwtRmRkUmZwkQfj962bRbv/K67MBS9XubSyG1r+ZItnVSIIRaGUpoQN8DSoKQhhOKpnpEq0AlhsD6P6hdWoICYq0DBLhzVua0/Buo3eB5x0wEreTH6grz5qj0SmiziP5T0Wx55FYKSVPmyPV1OmCY6UgmAcKT3bwPBZo60NCGQs9XyR5BlOBKWe+vX2D7kAt17YJRgBw9mzXlQZeyZ6Wln6PC7VkqOyWuMuD8g0iLe0up9PHGt6ZvFgzXVRbdjzM9FjknHkmy8nMlandPCT4MZhpcd7s/IvWh2BAQhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(54906003)(2616005)(8936002)(8676002)(6512007)(478600001)(316002)(16526019)(5660300002)(186003)(4326008)(86362001)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: euoAvGYoCMEzoZ/204Pf6u2gp9hTdR4y1P6ThQEu5sTpJvYdbErBMRRa3nhGdFy14DNDRlfWCKvs7FGESglS44ZFcEjY0cDXek3oiLoD4URmtSGgKBoovBoaBrla9Q04c84vFV5xmvcVVFHNIrx80eEQuAJZAoZ5s7FeA4Ew5ZDNtYIpMkCAdDoVwlto6rKgP3OJc/Lkdye0SYGAdq1c3ZtbWDz+tUTF/ghz7OlBetR0EDF+IQzNKmYLEmxD+9cvJALqpFN+OifdhtksY9n5so7Ioo9oAUVYiwOrq314EjKa6DWgXn1HXaGN34lCAG5zvsSzxK5Fj0jQXBJaFlNsC2kb8+Hbm0vz2GKKiiF2hG5NFujaSBF9/cNLVxl8hBYgBZBlUrkgr3KBngyEQwo5SjbSKcFreYB/Xb8ICy4RRBB8pBNWT4J0EsSq833dZwcnY/FRyBCtFBUGwsqaqD2dXO67vPFR/pgdcVXADy5VDVp1iCSlQ/I5eDYM6Ii3St3GurXyBu0+3AweQN7ZV+2nKA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0479e894-c61f-48f5-cbc0-08d8251093f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:34:00.6455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6RjLeGdjsLqlb3jo8IIJq7+Xp9zYh95TSQS11S3QlQw3OAhiEFetnkot+rsCljSCYg53E4QMn9tJGr5i5JSkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
In headless systems, if set mode is not called, hardware will not be
powered down on boot, causing HW/SW discrepancies.  Powering down
hardware on boot will ensure SW state is accurate.

[HOW]
Set a timer callback on boot for 10 seconds. If set mode is not called
within that time, power down hardware. Otherwise, do not power down.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 69 ++++++++++---------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  1 +
 8 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 942ceb0f6383..8d935020068f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2683,6 +2683,12 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 	dal_irq_service_ack(dc->res_pool->irqs, src);
 }
 
+void dc_power_down_on_boot(struct dc *dc)
+{
+	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
+			dc->hwss.power_down_on_boot)
+		dc->hwss.power_down_on_boot(dc);
+}
 
 void dc_set_power_state(
 	struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 389edcf3f6ce..c2336ca3a9e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1029,6 +1029,7 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
  */
 bool dc_commit_state(struct dc *dc, struct dc_state *context);
 
+void dc_power_down_on_boot(struct dc *dc);
 
 struct dc_state *dc_create_state(struct dc *dc);
 struct dc_state *dc_copy_state(struct dc_state *src_ctx);
@@ -1229,6 +1230,8 @@ void dc_set_power_state(
 		enum dc_acpi_cm_power_state power_state);
 void dc_resume(struct dc *dc);
 
+void dc_power_down_on_boot(struct dc *dc);
+
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 /*
  * HDCP Interfaces
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 6711ff908bcf..20466cad6ade 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1393,38 +1393,6 @@ void dcn10_init_hw(struct dc *dc)
 		}
 	}
 
-	/* In headless boot cases, DIG may be turned
-	 * on which causes HW/SW discrepancies.
-	 * To avoid this, power down hardware on boot
-	 * if DIG is turned on and seamless boot not enabled
-	 */
-	if (dc->config.power_down_display_on_boot) {
-		struct dc_link *edp_link = get_edp_link(dc);
-
-		if (edp_link &&
-				edp_link->link_enc->funcs->is_dig_enabled &&
-				edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
-				dc->hwseq->funcs.edp_backlight_control &&
-				dc->hwss.power_down &&
-				dc->hwss.edp_power_control) {
-			dc->hwseq->funcs.edp_backlight_control(edp_link, false);
-			dc->hwss.power_down(dc);
-			dc->hwss.edp_power_control(edp_link, false);
-		} else {
-			for (i = 0; i < dc->link_count; i++) {
-				struct dc_link *link = dc->links[i];
-
-				if (link->link_enc->funcs->is_dig_enabled &&
-						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-						dc->hwss.power_down) {
-					dc->hwss.power_down(dc);
-					break;
-				}
-
-			}
-		}
-	}
-
 	if (!is_optimized_init_done) {
 
 		for (i = 0; i < res_pool->audio_count; i++) {
@@ -1475,6 +1443,43 @@ void dcn10_init_hw(struct dc *dc)
 
 }
 
+/* In headless boot cases, DIG may be turned
+ * on which causes HW/SW discrepancies.
+ * To avoid this, power down hardware on boot
+ * if DIG is turned on and seamless boot not enabled
+ */
+void dcn10_power_down_on_boot(struct dc *dc)
+{
+	int i = 0;
+
+	if (dc->config.power_down_display_on_boot) {
+		struct dc_link *edp_link = get_edp_link(dc);
+
+		if (edp_link &&
+				edp_link->link_enc->funcs->is_dig_enabled &&
+				edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
+				dc->hwseq->funcs.edp_backlight_control &&
+				dc->hwss.power_down &&
+				dc->hwss.edp_power_control) {
+			dc->hwseq->funcs.edp_backlight_control(edp_link, false);
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
+}
+
 void dcn10_reset_hw_ctx_wrap(
 		struct dc *dc,
 		struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 42b6e016d71e..6d891166da8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -109,6 +109,7 @@ void dcn10_program_pipe(
 void dcn10_program_gamut_remap(struct pipe_ctx *pipe_ctx);
 void dcn10_init_hw(struct dc *dc);
 void dcn10_init_pipes(struct dc *dc, struct dc_state *context);
+void dcn10_power_down_on_boot(struct dc *dc);
 enum dc_status dce110_apply_ctx_to_hw(
 		struct dc *dc,
 		struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index f6a790c49321..5c98b71c1d47 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -30,6 +30,7 @@
 static const struct hw_sequencer_funcs dcn10_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
+	.power_down_on_boot = dcn10_power_down_on_boot,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = dcn10_apply_ctx_for_surface,
 	.post_unlock_program_front_end = dcn10_post_unlock_program_front_end,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index bb9e9bec2f28..2380392b916e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -30,6 +30,7 @@
 static const struct hw_sequencer_funcs dcn20_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
+	.power_down_on_boot =  dcn10_power_down_on_boot,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 8575de1a8ad2..177d0dc8927a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -31,6 +31,7 @@
 static const struct hw_sequencer_funcs dcn21_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
+	.power_down_on_boot = dcn10_power_down_on_boot,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 066a2a723c12..720ce5e458d8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -56,6 +56,7 @@ struct hw_sequencer_funcs {
 
 	/* Pipe Programming Related */
 	void (*init_hw)(struct dc *dc);
+	void (*power_down_on_boot)(struct dc *dc);
 	void (*enable_accelerated_mode)(struct dc *dc,
 			struct dc_state *context);
 	enum dc_status (*apply_ctx_to_hw)(struct dc *dc,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
