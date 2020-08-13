Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3052C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8ABE20768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cuzGuNUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ABE20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069EC6E25A;
	Thu, 13 Aug 2020 21:35:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A236E142
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4uU2Ik/xvBGTUTg1EA/91KdSRb57HsrjeDgWwKAwu27qr1phZmv/7WiLLr9nDNzVZQi+GuIrZQa7OfJ4RgGdbzDn5G9gSiX3dkZl9fx2EIWox3JqlaIf0sMpaRknfg2V9VOrsngSKj96AONc1UXxBYwO168Ng9ZIinV9BYz4hDDnQpceOPho9+zRGsM7jqJFQiPD9Oyralou95jEJLLqKmolYcwLkredW1w9QdoxRos4yWZKX2BwqoboDIYDT9KkompS5QbdlUIkZnJVgbPqIsYc3hVfK2HSQqi+xomLwqKaOxWVlZcqTe0ByhOwX0S4BKM1FbNB4qfUMoIpSVANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQgDQt5vE5DjkGA8Cc4DGc6gmVNYRVw5iKOoZz9Apjc=;
 b=X750m7dHxGnvP0qL9oQjZP7b7LHFoIOongujFpkauWT0AqWZddySKEf0GO4cL+4EGAh9N78s7rw+cnXQ+pvHrnwRMLtoyhDpvEHK9NVVwdhbfy4JiSX0+5IRV/qZEvZjXeInFmG8ePMafkpv1ZBGvnPJj/Hgj0Q3N2V1uATzGI4fZR3Yitx4kuH+26/XPvIdHm8IAQ7TpzbO81vTTf5eTvdDpEjDcC7UpMA60PqsyHuYc6OpSbW/b4jxLAvV2tHd8FFeELra2D0uBry0uAss0Zh4zenjfLn/fAcWZGGAp9UL612vbm9hltRDF9lNNJv9swg23niR5aAN71o34066dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQgDQt5vE5DjkGA8Cc4DGc6gmVNYRVw5iKOoZz9Apjc=;
 b=cuzGuNUfyrhA9xN4izsKfmrs84XYjGiG/ya1Vn8TbmBlelPHNXX3EQGu5P0wHP7vapiq7Z0XpHtpnSIElEKoY/O0zEXXE+yk5DeM5c11o8rPjdUhWFuHpZTN+2AZYgoK/YoJ0OHLmLW3CrrmFOPBXKw12NQbQ5uW/ovOkvAX9Ns=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:27 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/17] drm/amd/display: Call DMUB for eDP power control
Date: Thu, 13 Aug 2020 17:33:42 -0400
Message-Id: <20200813213356.1606886-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:26 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6d54061-ae58-433d-a2e7-08d83fd0cb2b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355E0CFF905FF688EBEDFA998430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X26r21oKMa/0wrIXSKIiDIqPhd8F97FI3h0FxMTFlqEN2Jzua1pO9vMDs2QJdheMv1+NW/BJU9LnvTg9cDM+yfmk0mQeeV15liYtQMOHGaG8mpinOcodfbZW84JuQRG3BxcJqcipsscDfdNd1rMogAto0iVwYySgJVjtj/s4lTo21g9hl4qk/qk5K+meJ6Loan/qtYAiZmk3mrS0NxIgZ0LuWs22oozrAdvX9r4xC2e32pRWpF9FVkMDirkuES3lOp1YV6zqcGC5FuYafXrCDbJ4vL2Znlx7omFKLuDnsOgG/xv6YOmH/33RrhtZWu4Np81Np+qbWCZ7O6NTMuwSwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2nmhsc9+jcBcWvAONsD4qOQVIQdu/SPTxRr2NjipN531JMW+Cq0NTf+cNSuLETdgSTYYXeXtUKRk3tEWmte2tEV62xZz/d8rOxgDXgMoiCLe9KuU9/t/EQ/7BX60hE2Q8ocTRlIUNl7RSKooXAkD5jQCT4Vqm2Nx2f2x7lWv0HnnwDbQC2CfjOfqjEY0uSpnlj62fzTKSj5lufJsV9Po34+FbYuKvCd39ftAdb0cDy2uBFsBvIY7zyqHfx6MYggl2h/U6s3aZwjjeNPk/byZi7M+unHy5knYVbNMAigPgLzDuSX+/Dd6f95phNtUBgZUusviUH6g4OIr71KLnIPLVdgvG5ZdXlnBTsaQidDaSxugjiONyPIpJc/JQHwMg/IH3auiyg/faHgqKfAXFrEpPiRbLLsf4d/h8e2eVt3uKiXk/lbnQLNmouPP13rU5q75NIqNwm7HDUMN3z8verSyTijFRs3rGwGF1K+mVUDHjkKv2BYGA8ODkpA+MOyWJfAX56NHuH1ehdZHl2QEsK9c77e/Ky4Y0gPDu9oKNWcBNJ8nZVMRABt2nA+Fz2lU8CfpZHBlJrlSgQr5eTeDA2t1wPN6T9ub7bIFRzjD/pF+nsmGr1DJJCp6ItVtPetHAGIoc7jEBHQLK2jMCpEY26dPPxn+1grEviRt9VbCWX/5EbksSjTadRNn5mFL/Vqwt7kA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d54061-ae58-433d-a2e7-08d83fd0cb2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:26.9218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtVH65c0EVrC6ehcx+7tlEYYYKENpNwkUZh99br310Mb5XgWRmkKQnD5HVbsDIaF3bMp1Io7nQiHMN5NTMmgUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
If DMUB is used, LVTMA VBIOS call can be used to control eDP instead of
tranditional transmitter control.  Interface is agreed with VBIOS for
eDP to use this new path to program LVTMA registers.

[How]
Create DAL interface to send DMUB command for LVTMA as currently
implemented in VBIOS.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 16 ++++++++++-
 .../drm/amd/display/dc/bios/command_table2.c  | 28 +++++++++++++++++++
 .../drm/amd/display/dc/bios/command_table2.h  |  3 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  4 +++
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++++++++++++++++
 .../amd/display/include/bios_parser_types.h   |  7 +++++
 6 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 078b7e344185..2d5c7daaee23 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1108,6 +1108,18 @@ static enum bp_result bios_parser_enable_disp_power_gating(
 		action);
 }
 
+static enum bp_result bios_parser_enable_lvtma_control(
+	struct dc_bios *dcb,
+	uint8_t uc_pwr_on)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+
+	if (!bp->cmd_tbl.enable_lvtma_control)
+		return BP_RESULT_FAILURE;
+
+	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on);
+}
+
 static bool bios_parser_is_accelerated_mode(
 	struct dc_bios *dcb)
 {
@@ -2208,7 +2220,9 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.get_board_layout_info = bios_get_board_layout_info,
 	.pack_data_tables = bios_parser_pack_data_tables,
 
-	.get_atom_dc_golden_table = bios_get_atom_dc_golden_table
+	.get_atom_dc_golden_table = bios_get_atom_dc_golden_table,
+
+	.enable_lvtma_control = bios_parser_enable_lvtma_control
 };
 
 static bool bios_parser2_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index bed91572f82a..eb3ae5c3677c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -904,6 +904,33 @@ static unsigned int get_smu_clock_info_v3_1(struct bios_parser *bp, uint8_t id)
 	return 0;
 }
 
+/******************************************************************************
+ ******************************************************************************
+ **
+ **                  LVTMA CONTROL
+ **
+ ******************************************************************************
+ *****************************************************************************/
+
+static enum bp_result enable_lvtma_control(
+	struct bios_parser *bp,
+	uint8_t uc_pwr_on);
+
+static void init_enable_lvtma_control(struct bios_parser *bp)
+{
+	/* TODO add switch for table vrsion */
+	bp->cmd_tbl.enable_lvtma_control = enable_lvtma_control;
+
+}
+
+static enum bp_result enable_lvtma_control(
+	struct bios_parser *bp,
+	uint8_t uc_pwr_on)
+{
+	enum bp_result result = BP_RESULT_FAILURE;
+	return result;
+}
+
 void dal_firmware_parser_init_cmd_tbl(struct bios_parser *bp)
 {
 	init_dig_encoder_control(bp);
@@ -919,4 +946,5 @@ void dal_firmware_parser_init_cmd_tbl(struct bios_parser *bp)
 	init_set_dce_clock(bp);
 	init_get_smu_clock_info(bp);
 
+	init_enable_lvtma_control(bp);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
index 7a2af24dfe60..7bdce013cde5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
@@ -94,7 +94,8 @@ struct cmd_tbl {
 		struct bp_set_dce_clock_parameters *bp_params);
 	unsigned int (*get_smu_clock_info)(
 			struct bios_parser *bp, uint8_t id);
-
+	enum bp_result (*enable_lvtma_control)(struct bios_parser *bp,
+			uint8_t uc_pwr_on);
 };
 
 void dal_firmware_parser_init_cmd_tbl(struct bios_parser *bp);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index d06d07042a12..0811f941f430 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -136,6 +136,10 @@ struct dc_vbios_funcs {
 
 	enum bp_result (*get_atom_dc_golden_table)(
 			struct dc_bios *dcb);
+
+	enum bp_result (*enable_lvtma_control)(
+		struct dc_bios *bios,
+		uint8_t uc_pwr_on);
 };
 
 struct bios_registers {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 49380ed3aeae..45c9e9027886 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -842,6 +842,17 @@ void dce110_edp_power_control(
 		cntl.coherent = false;
 		cntl.lanes_number = LANE_COUNT_FOUR;
 		cntl.hpd_sel = link->link_enc->hpd_source;
+
+		if (ctx->dc->ctx->dmub_srv &&
+				ctx->dc->debug.dmub_command_table) {
+			if (cntl.action == TRANSMITTER_CONTROL_POWER_ON)
+				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+						LVTMA_CONTROL_POWER_ON);
+			else
+				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+						LVTMA_CONTROL_POWER_OFF);
+		}
+
 		bp_result = link_transmitter_control(ctx->dc_bios, &cntl);
 
 		if (!power_up)
@@ -919,8 +930,21 @@ void dce110_edp_backlight_control(
 		/*edp 1.2*/
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 		edp_receiver_ready_T7(link);
+
+	if (ctx->dc->ctx->dmub_srv &&
+			ctx->dc->debug.dmub_command_table) {
+		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
+			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+					LVTMA_CONTROL_LCD_BLON);
+		else
+			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+					LVTMA_CONTROL_LCD_BLOFF);
+	}
+
 	link_transmitter_control(ctx->dc_bios, &cntl);
 
+
+
 	if (enable && link->dpcd_sink_ext_caps.bits.oled)
 		msleep(OLED_POST_T7_DELAY);
 
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index c30437ae8395..21011edea337 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -101,6 +101,13 @@ enum bp_pipe_control_action {
 	ASIC_PIPE_INIT
 };
 
+enum bp_lvtma_control_action {
+	LVTMA_CONTROL_LCD_BLOFF = 2,
+	LVTMA_CONTROL_LCD_BLON = 3,
+	LVTMA_CONTROL_POWER_ON = 12,
+	LVTMA_CONTROL_POWER_OFF = 13
+};
+
 struct bp_encoder_control {
 	enum bp_encoder_control_action action;
 	enum engine_id engine_id;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
