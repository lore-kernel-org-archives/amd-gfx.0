Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D29C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D2F2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLX1ovTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D2F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4886D6E9E7;
	Mon,  1 Jun 2020 18:30:13 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5916E9E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:12 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id q8so10011421qkm.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CRz0+Tz2rvh54kY1+3G4k72coSjHinvNu/BTHgT0OCg=;
 b=ZLX1ovTgHEVZcwLxe02ercsiGq3DQZue2qKi/8AvdBCW5tsJf4TSiiKfPu7JSEKBLE
 wqoWdcbAH9D+wcFI+Da6ySEz9HhEJUxwBJOCqSKm400k8B++Y3hfrvR0yU8RiysobCen
 ED0mXouMX6v9Xr8tUnGrruLHnzRVMhn8udSmo5sFOz19aSIhQF+RqHVuztf5rOzkktvc
 WzA9YSq1sjyzUPpq6iFaEc30syyq9FbQ1ls/M7YZZYQA7fRXgCFkGeH6qTVnh5bHIQ2P
 yEVcbWKfDXVzvZ6WN/TPsd2Whu0xI6aer2C2TYDxy0NBcP1QQOICGuxBKbDJfSVg0KGL
 wy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CRz0+Tz2rvh54kY1+3G4k72coSjHinvNu/BTHgT0OCg=;
 b=BJhUVUWxuQcq0OyKA9nuPpJUIzg38QKjxfld2RhC5ErwAwyIydKsAykFBoQWLARFAf
 aESNxGEAd19HSIDJ+SHJHR/GsID2TKUwLHLUGRTo58CWECffzwYA1qtKFdMY43Y9Coj6
 zbz4zaBzpnXJq3ba77DJ3GRjsA9SI9mOUVikdurrNEaskm6Si/gtVuEa1th3b0rUBIq7
 adFWTWHeOkzaNBhaLlA6TNQBrNNs3ZR05d72eZPBEAJcHxVzOwneauYuaeHUkyEkZjvH
 ANVuwANVlJYOrxMU9kyQoT/DECTrD3nmwiNzVNFAeC5TDT6XfuojxmA1fXt9JSu5nhPO
 3f6Q==
X-Gm-Message-State: AOAM531RZQd1Y/srtaeXy1icHfoaqwOJaoESWKNxtOIzeFjL5k1AWbWw
 svz8s5/rvVOra/N+IHijLfigRFyT
X-Google-Smtp-Source: ABdhPJyvZ4g38aaMezVR/DWxoYQPGXW7dbq5icfDXYR1pY+kjz1YioYSiahni/YIZ1qowovivwnmNg==
X-Received: by 2002:a37:ac14:: with SMTP id e20mr21530914qkm.20.1591036210933; 
 Mon, 01 Jun 2020 11:30:10 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:10 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 198/207] drm/amd/display: Add DCN3 Command Table Helpers
Date: Mon,  1 Jun 2020 14:29:17 -0400
Message-Id: <20200601182926.1267958-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182926.1267958-1-alexander.deucher@amd.com>
References: <20200601182926.1267958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

-Handle DCN3 cases for bios parser and command tables
-Add command function tables for DCN3

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    |  3 ++
 .../display/dc/bios/command_table_helper2.c   |  5 +++
 .../dce112/command_table_helper2_dce112.c     | 40 +++++++++++++++++++
 .../dce112/command_table_helper2_dce112.h     |  3 ++
 4 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 7fb62780e8cf..150cdbc02d44 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1154,6 +1154,9 @@ static enum bp_result bios_parser_get_firmware_info(
 				result = get_firmware_info_v3_2(bp, info);
 				break;
 			case 3:
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+			case 4:
+#endif
 				result = get_firmware_info_v3_2(bp, info);
 				break;
 			default:
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 204d7942a6e5..21ff6b686f5f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -65,6 +65,11 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case DCN_VERSION_3_0:
+		*h = dal_cmd_tbl_helper_dce112_get_table2();
+		return true;
+#endif
 
 	default:
 		/* Unsupported DCE */
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
index 755b6e33140a..bf0affef893f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
@@ -388,3 +388,43 @@ const struct command_table_helper *dal_cmd_tbl_helper_dce112_get_table2(void)
 {
 	return &command_table_helper_funcs;
 }
+
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+/* function table */
+static const struct command_table_helper command_table_helper_funcs_dcn2x = {
+	.controller_id_to_atom = dal_cmd_table_helper_controller_id_to_atom2,
+	.encoder_action_to_atom = encoder_action_to_atom,
+	.engine_bp_to_atom = engine_bp_to_atom,
+	.clock_source_id_to_atom = clock_source_id_to_atom,
+	.clock_source_id_to_atom_phy_clk_src_id =
+			clock_source_id_to_atom_phy_clk_src_id,
+	.signal_type_to_atom_dig_mode = signal_type_to_atom_dig_mode,
+	.hpd_sel_to_atom = hpd_sel_to_atom,
+	.dig_encoder_sel_to_atom = dig_encoder_sel_to_atom,
+	.phy_id_to_atom = phy_id_to_atom,
+	.disp_power_gating_action_to_atom = disp_power_gating_action_to_atom,
+	.clock_source_id_to_ref_clk_src = NULL,
+	.transmitter_bp_to_atom = NULL,
+	.encoder_id_to_atom = dal_cmd_table_helper_encoder_id_to_atom2,
+	.encoder_mode_bp_to_atom =
+			dal_cmd_table_helper_encoder_mode_bp_to_atom2,
+	.dc_clock_type_to_atom = dc_clock_type_to_atom,
+	.transmitter_color_depth_to_atom = transmitter_color_depth_to_atom,
+
+};
+
+/*
+ * dal_cmd_tbl_helper_dce110_get_table
+ *
+ * @brief
+ * Initialize command table helper functions
+ *
+ * @param
+ * const struct command_table_helper **h - [out] struct of functions
+ *
+ */
+const struct command_table_helper *dal_cmd_tbl_helper_dcn2_get_table2(void)
+{
+	return &command_table_helper_funcs_dcn2x;
+}
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.h b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.h
index abf28a06f5bc..2d9e9f3c579d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.h
@@ -30,5 +30,8 @@ struct command_table_helper;
 
 /* Initialize command table helper functions */
 const struct command_table_helper *dal_cmd_tbl_helper_dce112_get_table2(void);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+const struct command_table_helper *dal_cmd_tbl_helper_dcn2_get_table2(void);
+#endif
 
 #endif /* __DAL_COMMAND_TABLE_HELPER_DCE110_H__ */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
