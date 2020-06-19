Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40BCC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9021208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CB3X8LPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9021208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B20089354;
	Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA9F6EA38
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGO8ltyvoxpk+Uubd037/OmDN+4Uqvg6mdQrAE3UsEw9kzazmxQUB7SDy3/ORTaSzUvCMFgjBW/6Q/JoUINFIGdrNKAJ6Z4oyMHr5HYYcfeosIqbfCbfysWufFU4P6/8i/GDv2nLhKDVUvldm+7PddA0RuNU4Jywy7oGAYaNHW4bPD94BL1/0WL/E7bU4i2OOVDC9Dr4MOYtAcxz3aEUkEXF2GRp5QvWBtMDwoEsAwIl5LGPjJHpOQ94jnkcehiSqkasDKhPbrOxa/k1PbNzDCzmjLZXtb+MrJyOQ+PExrtYtRRtQcJq6LXuGXIuu18QFowW0r8GmAjawagcP0uFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbKG3b/T8613ia8mvdRcBycj/LL4cxcTiCgy4IMP29c=;
 b=AG31AOBaX9cFA/C9t5mk+wd6oPDb8SssxpXAxu++/H+7BpiKJQ689BWpD/9jR8rZ0uhl24q/iEBmYy5am+Ut7oH42M+s0HuhKR3zH6S/UXKq3OEu1gjGONkXROy/345k/9QaKomtp8uFCiBOOkGjCx96LjK1l2HtqK73E9Bkq2b1/cBU/zcJVHL2Y5bsdY4W9QmowL708kbfkCH4o0IKFSWSFSMTkihV+/r9pjWWea8GStnP7uBqj3Im0RAG0TYJcWojXHttvF5aPiJ5wH112DIbW9mgm8hsmQ2130fxRfd+uR92N2iaUUzCrvw4DkGZn7Ue0NmAftZXo1hcjTxlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbKG3b/T8613ia8mvdRcBycj/LL4cxcTiCgy4IMP29c=;
 b=CB3X8LPDw1jrnQ/sXq3ljC+XHkT9TvLRyvp14+G+OMyH1PsDTYMFKL0nACZlHbOGKpLDK7SJKDCY766X1Qe3wMGL5zbf9vnkj9Fm07V9mKeQVXSiL1BK9ZljiLSjyICpNMm1ixuhk5WyxQqeSw9iL8UFp/F/9QlwjAxOVOg7lxE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:52 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/30] drm/amd/display: implement edid max TMDS clock check in
 DC
Date: Fri, 19 Jun 2020 16:11:58 -0400
Message-Id: <20200619201222.2916504-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:51 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68c60a43-5612-44aa-7955-08d8148d24fd
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37172A6A46402B90870CE0C398980@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bejGN3DdSKYG04I7CQixHqgqB2Q1bICSqQCkxzIfE75LUDtseYEDRADG8p6I0LMbubgF7wFBgwoMZQ324Ro3/29B1UbFw+Z+kQSilDhH97M42mpgwmSBwUbPl8/fmeVkapT8/Eb92lk9o1N1FSXodq0o91HiV3U2Ao0AQm0JSeHHnwpHVmj+HQH+JOjU94XMCl6L8qnoef57Ae7MedUuoZGUy+Ma7eS4GfmNAcRuXucQJTTYa2kOF87CzRSZKEZwWBKjEJ4trqRW/6bjqU82CZuCeuURNc6r5sjfTdpdVMAf91plDmD2IglvKHH89qYo6i2P5nzf7nlbiUdMcide8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(5660300002)(66476007)(16526019)(86362001)(6916009)(83380400001)(478600001)(66556008)(66946007)(8676002)(6512007)(1076003)(6506007)(4326008)(52116002)(8936002)(2906002)(316002)(6486002)(36756003)(186003)(2616005)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: u2PV7dbat1HvGR/+yzvhiy8/PmggwrkkTVADYJaFtnUcPAvNU9ieFI9GEhp8TlAzzZM7zSofhtATmxVzrUvsIJfgF3YpxusqEerJT/Dfa4vD8JIPBvq2YuDDrIBsTz3Zh1bD6DMpVPdcMQjWWBzhYdlp6rQlSnJvtmgHCf4MxDTpq6DMHtutfPX7YfO2bImjfnGQdt15/wPBCOoQPMxhB4QMkEbD51dPTS8Hjl2bzOytkbFqJMGHLbnfGspH5aWNaiAr9PSgIFfcxtfa5KpjzeTY2GNkfNfNJ7lt2rtl9E+OVBAdEU1Yy7TZ8qyX6sUUFUKauvIGDINo0xUIwFj0nnKPwPOqiCkm3ZWGxIygzhGmZwuUNYzr/9oa2CM3aSjxCtEW/kheGDcvcHc69gXbTYGKPfJWjICJkJx35/3XfdRR++1AF4WaYF6VUJ+UYBeCSx+NIUHN41/jcn8zjuJ5iImbxIBz/f0LelekwcxghLGFFPw16l1f1J1pOEBUf5dc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c60a43-5612-44aa-7955-08d8148d24fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:51.8860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn6tuxQL5JZ2akWAHsCHnAeU/LvSulNit76/t7Ap8ZuL515royY/EYsFG9lAiobrYQbf4Rd5U0R9l9orhk45QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Eric Yang <eric.yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Currently DC doesn't check requested pixel clock against an EDID
specified TMDS max clock if it exists, passing modes that should fail

[HOW]
Add max TMDS clk to edid caps and perform check during validation

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h              |  3 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c  | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d7b9d311d9e0..f51e5766d8f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -261,6 +261,9 @@ struct dc_edid_caps {
 	bool edid_hdmi;
 	bool hdr_supported;
 
+	uint32_t max_tmds_clk_mhz;
+	uint32_t max_forum_tmds_clk_mhz;
+
 	struct dc_panel_patch panel_patch;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 7fd385be3f3d..a9af3f6fd8ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -619,11 +619,20 @@ bool dcn10_link_encoder_validate_dvi_output(
 static bool dcn10_link_encoder_validate_hdmi_output(
 	const struct dcn10_link_encoder *enc10,
 	const struct dc_crtc_timing *crtc_timing,
+	const struct dc_edid_caps *edid_caps,
 	int adjusted_pix_clk_100hz)
 {
 	enum dc_color_depth max_deep_color =
 			enc10->base.features.max_hdmi_deep_color;
 
+	// check pixel clock against edid specified max TMDS clk
+	if (edid_caps->max_tmds_clk_mhz != 0 &&
+			adjusted_pix_clk_100hz > edid_caps->max_tmds_clk_mhz * 10000)
+		return false;
+	if (edid_caps->max_forum_tmds_clk_mhz != 0 &&
+			adjusted_pix_clk_100hz > edid_caps->max_forum_tmds_clk_mhz * 10000)
+		return false;
+
 	if (max_deep_color < crtc_timing->display_color_depth)
 		return false;
 
@@ -801,6 +810,7 @@ bool dcn10_link_encoder_validate_output_with_stream(
 		is_valid = dcn10_link_encoder_validate_hdmi_output(
 				enc10,
 				&stream->timing,
+				&stream->sink->edid_caps,
 				stream->phy_pix_clk * 10);
 	break;
 	case SIGNAL_TYPE_DISPLAY_PORT:
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
