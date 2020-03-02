Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33589C3F2D7
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A7C21D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CJQnanuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A7C21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE18A6E5D1;
	Mon,  2 Mar 2020 16:48:04 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A4B6E5BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDPQo6QAqwHykOeXGFlhoYNOwjAlLOtK0aAKhhwsEXSc4GATkHQFsDbLaIMwgUkOWwsczEHppF5Rf6Rq8dtdQCubjYOUswA47zvEMIHCmC1XGicpAa5jZqmJPYZFAVcevH++7x2Gnm4j/slZChv5iP4iLA6M5cZD8M/CjO3kJiPuDGEMTsXcwX8poWWOdMkLhkI/ErNXia2ltARxE1l9TOH9SMuSVI73kQ6Mb0/pYfxm0Rlu0wzM81V5K5+EBmZ9s/bZT/5qHaE2eVsp96U+HCeMizYVzKtlrnnn9D3YiWQaMszpG5mfxo4atyEU68VjH4gB2v32o36FOLqt9lhPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfr4z+NdJPK3tLtKCN7E4VR7S7gHVbWimIz6yPJgYRw=;
 b=m312fvRgJ1X+fsVIGdJyBI6yzFbHTnnmMpezwFFDBCdXCUiJnOF/CjS3PR6px5GH6gXQwHwtlHC4vFhnUyqJWfAwXpHkSt9P1tPp2UgKR5oOJtN72RCTkD8y8jj17K4E/OrdlefkSFjgMEUx2KzB/W04K0Z1jtOaNkXz3Dd5DQlZlclxnJH0MQQM4pUYOD+a9I13VhG01J0miWfBG/6g419+BfU2mbIH4bUFYrrTH4gcqycvsDstz1rmJTbWCFLcHkyCSpVRAI+54FqugxVJqI4xw4xm33vOSrYyuOoMgRuhxZnFMK5aETxHkdi4KuYzq8v3lxtazABiRQDLWJy7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfr4z+NdJPK3tLtKCN7E4VR7S7gHVbWimIz6yPJgYRw=;
 b=CJQnanuLp8w/AIDGlDDHuhcDGcryI1CMk/8di/a3d0Ge6sCiU7YbMIgGcuIEK29G/vU3EQDBT6dtWHgRE9h9vcLaiiFEVEiezjgebHiVfb8eye4leWKmc/mi1RO8sl5HbVnD6KPNkTf9OOb1pJX1WGX7xwxzvM4rriJrkmU6kAY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:47:59 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/22] drm/amd/display: fix image corruption with ODM 2:1 DSC
 2 slice
Date: Mon,  2 Mar 2020 11:47:24 -0500
Message-Id: <20200302164736.89429-11-Rodrigo.Siqueira@amd.com>
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
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:58 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c8d69fa-ecd6-40c3-56b3-08d7bec976ea
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB241179EE981E52D955016EC998E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tn7Tzl97a3/xlY03y9SlnJ9We7WkX2dPMEN59SnJ5B8KJjwUjtXnENjgqZyLYHAZLu0E5hy5AeSC9jDgfKRKhZW+rA7sbUZSHdWtccXQSFPFZZio5tPkFUsSfQggmKvWaE6AtPcMBMwvoukSTT+qq02eyD0rQMudzFCDEb1/52QqEKf1hmB0F6oSFzTYxGI0QJak3Z279Q5/XJuSRTT1k21BD9iM7BpY/XvmuEVCE35Oz5grM08G4Lkg0aMjbMAgv9NXhB4O0DN4Xu+oxZ5SLxTYCzANefHSMGC2grV4mInePu/NapMVNQrgDFmRf/c8Olsd7UZq8wwGgdM3KxBRNW/p+o9nCU+814t4GcHn3X6RfNtCPHy+cqTL7j2nlfouESTDTYG+UNT4covyYHOl6GPYNUeD6MulSU+pCTIDSXAfR5SH7TlIWn7J9m/V8f3W
X-MS-Exchange-AntiSpam-MessageData: a5h+j0uZvvzNeBZE7f6ezLC9eNSBy1QmlHZ3dR+Ooe9TUAlN6wpphk2hCbo4SpiF9D5FzulLSjkHwXH7XyVZVePiLMmdvX6TdMVxiEKtCRTKWVeGJO7rMzPYIECEAWxp/6TGJUAPP7vc5lZfTxFBrA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8d69fa-ecd6-40c3-56b3-08d7bec976ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:59.3205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3urJvL6CYzzb9T+Z0+yRthxOK2IuX4RzJ/L5M6Vl3VThTdnEfumBnr0bqkiZijGA0rXxrvoosMqhg38/FVuA2A==
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
 Nikola Cornij <Nikola.Cornij@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
When combining two or more pipes in DSC mode, there will always be more
than 1 slice per line.  In this case, as per DSC rules, the sink device
is expecting that the ICH is reset at the end of each slice line (i.e.
ICH_RESET_AT_END_OF_LINE must be configured based on the number of
slices at the output of ODM).  It is recommended that software set
ICH_RESET_AT_END_OF_LINE = 0xF for each DSC in the ODM combine.  However
the current code only set ICH_RESET_AT_END_OF_LINE = 0xF when number of
slice per DSC engine is greater than 1 instead of number of slice per
output after ODM combine.

[how]
Add is_odm in dsc config. Set ICH_RESET_AT_END_OF_LINE = 0xF if either
is_odm or number of slice per DSC engine is greater than 1.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c    | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h           | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 58634f191a55..51e0ee6e7695 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -431,6 +431,7 @@ void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
 		dsc_cfg.color_depth = stream->timing.display_color_depth;
+		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
@@ -535,6 +536,7 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
 		dsc_cfg.color_depth = stream->timing.display_color_depth;
+		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 
 		DC_LOG_DSC(" ");
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index 6bdfee20b6a7..1b1ae9ce2799 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -369,6 +369,7 @@ static bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_
 	dsc_reg_vals->pps.block_pred_enable = dsc_cfg->dc_dsc_cfg.block_pred_enable;
 	dsc_reg_vals->pps.line_buf_depth = dsc_cfg->dc_dsc_cfg.linebuf_depth;
 	dsc_reg_vals->alternate_ich_encoding_en = dsc_reg_vals->pps.dsc_version_minor == 1 ? 0 : 1;
+	dsc_reg_vals->ich_reset_at_eol = (dsc_cfg->is_odm || dsc_reg_vals->num_slices_h > 1) ? 0xF : 0;
 
 	// TODO: in addition to validating slice height (pic height must be divisible by slice height),
 	// see what happens when the same condition doesn't apply for slice_width/pic_width.
@@ -531,7 +532,6 @@ static void dsc_update_from_dsc_parameters(struct dsc_reg_values *reg_vals, cons
 		reg_vals->pps.rc_buf_thresh[i] = reg_vals->pps.rc_buf_thresh[i] >> 6;
 
 	reg_vals->rc_buffer_model_size = dsc_params->rc_buffer_model_size;
-	reg_vals->ich_reset_at_eol = reg_vals->num_slices_h == 1 ? 0 : 0xf;
 }
 
 static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 8a81ae562f6e..4ce701877ffa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2299,6 +2299,7 @@ bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx)
 				+ stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
 		dsc_cfg.color_depth = stream->timing.display_color_depth;
+		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
index c59740084ebc..7c2a3328b208 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
@@ -39,6 +39,7 @@ struct dsc_config {
 	uint32_t pic_height;
 	enum dc_pixel_encoding pixel_encoding;
 	enum dc_color_depth color_depth;  /* Bits per component */
+	bool is_odm;
 	struct dc_dsc_config dc_dsc_cfg;
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
