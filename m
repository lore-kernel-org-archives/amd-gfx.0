Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58161C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 16:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D571C20848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 16:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5IZa4yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D571C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BAC6E15A;
	Fri, 16 Oct 2020 16:50:16 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379366E153
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 16:50:14 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id c15so2008234qtc.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zj9az6410AVaCk7GfH40Ya39UE7DKzBY+bMHITjNyHs=;
 b=G5IZa4yiiLXYirZ84yYS5ZcQ54mpVh8InHRF0XjZ8hevSeQqb8PTIJFg0KcfIuoMAK
 0Xd7D2xrsUeoVBYoMbtOH4YoR+KUfPtq7e/0r4WNNDIbvPngfOuj7X71J8BTS5GSsJW8
 FwK2KVc/hk08t+roq6iPLti3nHZxEkIrQO2NNFJOZG3ENyoM7VXlP54QJGereV+VuUN/
 mwJaEjub2H+HzLNZwGzUcC7kbHIdGKUUDx/7dlsp1nVUpNs4Ma66YBRGB519OPNfeiY9
 FHyO6JbkuGwd+8WGuNXqkygV5SsjcN1S15xwiCZ2QSM1C4AXzZ3c6txyakF2rnHMm/vk
 JyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zj9az6410AVaCk7GfH40Ya39UE7DKzBY+bMHITjNyHs=;
 b=PPmGr2sonWM/N6ueR4ReSxJDoAjlLrGGChvdifSCEUzFld9aQ+fIeKl41XmOrMaKEr
 OoHn9+NANo9B1VdLkrTcrWO8IERypfq7l10ZKotkN5BjK5whNo2Y0vec1+Ae1tzq9E9q
 gMsvcHAToJ5BQ6mW8CYB73jYIbWD96ddWTXqIfByhkUMWG3nn73XAGc9i/bEn5q+iLAp
 5nudWo982SsEAJqF+ahU8wVSZUusJ3FWpMg36dGLgVIS14iibWdoZhIWdMpeCQaPZNiq
 C+Owftv8Ngnf3TTa7XG+sa+3MDaFQqTMuTjZ4ERxXJLbxbf8PMX3IfxGsg+xkjLv8elX
 gcpw==
X-Gm-Message-State: AOAM533aNlK8jD5A9l7AM+bDqc+QPCUn+lOvJgPOWlfWn63n1/KP0f6W
 XdTANYlGu12gQD3Jtf4LH4Wlb85uPfY=
X-Google-Smtp-Source: ABdhPJxtK3eE5q8Wp4CVWAcEo7x+EXzpk/hz7uQ8YUnnZSrLmqR+rEoDJuKRwH4uDzSLaO+tLwqzKw==
X-Received: by 2002:ac8:44c3:: with SMTP id b3mr4292039qto.221.1602867013159; 
 Fri, 16 Oct 2020 09:50:13 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q9sm1193726qta.70.2020.10.16.09.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 09:50:12 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu/display: remove
 dal_cmd_tbl_helper_dcn2_get_table2
Date: Fri, 16 Oct 2020 12:50:02 -0400
Message-Id: <20201016165004.1218352-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201016165004.1218352-1-alexander.deucher@amd.com>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's unused and identical to dal_cmd_tbl_helper_dce112_get_table2.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../dce112/command_table_helper2_dce112.c     | 40 -------------------
 .../dce112/command_table_helper2_dce112.h     |  3 --
 2 files changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
index bf0affef893f..755b6e33140a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
@@ -388,43 +388,3 @@ const struct command_table_helper *dal_cmd_tbl_helper_dce112_get_table2(void)
 {
 	return &command_table_helper_funcs;
 }
-
-#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
-/* function table */
-static const struct command_table_helper command_table_helper_funcs_dcn2x = {
-	.controller_id_to_atom = dal_cmd_table_helper_controller_id_to_atom2,
-	.encoder_action_to_atom = encoder_action_to_atom,
-	.engine_bp_to_atom = engine_bp_to_atom,
-	.clock_source_id_to_atom = clock_source_id_to_atom,
-	.clock_source_id_to_atom_phy_clk_src_id =
-			clock_source_id_to_atom_phy_clk_src_id,
-	.signal_type_to_atom_dig_mode = signal_type_to_atom_dig_mode,
-	.hpd_sel_to_atom = hpd_sel_to_atom,
-	.dig_encoder_sel_to_atom = dig_encoder_sel_to_atom,
-	.phy_id_to_atom = phy_id_to_atom,
-	.disp_power_gating_action_to_atom = disp_power_gating_action_to_atom,
-	.clock_source_id_to_ref_clk_src = NULL,
-	.transmitter_bp_to_atom = NULL,
-	.encoder_id_to_atom = dal_cmd_table_helper_encoder_id_to_atom2,
-	.encoder_mode_bp_to_atom =
-			dal_cmd_table_helper_encoder_mode_bp_to_atom2,
-	.dc_clock_type_to_atom = dc_clock_type_to_atom,
-	.transmitter_color_depth_to_atom = transmitter_color_depth_to_atom,
-
-};
-
-/*
- * dal_cmd_tbl_helper_dce110_get_table
- *
- * @brief
- * Initialize command table helper functions
- *
- * @param
- * const struct command_table_helper **h - [out] struct of functions
- *
- */
-const struct command_table_helper *dal_cmd_tbl_helper_dcn2_get_table2(void)
-{
-	return &command_table_helper_funcs_dcn2x;
-}
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.h b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.h
index 2d9e9f3c579d..abf28a06f5bc 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.h
@@ -30,8 +30,5 @@ struct command_table_helper;
 
 /* Initialize command table helper functions */
 const struct command_table_helper *dal_cmd_tbl_helper_dce112_get_table2(void);
-#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
-const struct command_table_helper *dal_cmd_tbl_helper_dcn2_get_table2(void);
-#endif
 
 #endif /* __DAL_COMMAND_TABLE_HELPER_DCE110_H__ */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
