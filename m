Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B7CC021B6
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 01:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E44010E0DE;
	Tue, 25 Feb 2025 01:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="Xh6Bt5aM";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8018110E522
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 01:55:45 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2230c74c8b6so3065365ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 17:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1740448545; x=1741053345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BVtEIXt2XiRQBgkQxldZbwoGe8FwTsoxgK9PR+Vko9E=;
 b=Xh6Bt5aMVLn8oO7ltnt8HBrnQ2axnHNN9mJw6trK8ynQVRulOanidonvmBgN8vmjqx
 kfrmydsoq6Xo3IR7CK20gMJsnz4bt6ArIuYF1tYqSgTYeLQVC6ITai6VdrgqZeDlAsyP
 /5pvfvW05WqjcfXkTP4OiwG/F+cMpkiT1bSy/wzZ3u5096uIM7Yh/z6TjT4+CXonRLEL
 rk4Xl775iuJDF8ctXMiPuyqv5HXHBHyn0tsfhqld94JJfwnqvFNJSGY1m9hmFObg1WoU
 XHxkB7O0jwMFqgzmfO8SjD59rlFi1crFmIchNrlHaF/06AHE68cyMAZ2Xi2LRbZiJwcg
 SrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740448545; x=1741053345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BVtEIXt2XiRQBgkQxldZbwoGe8FwTsoxgK9PR+Vko9E=;
 b=SE+ADp95ehioCeZB0Uuur0aocjXWcdLUMNNVv0AuZ+0PWMiV/aSxbpJ6Hbg2ozcg2t
 KEZvfCxEAoQNbLKK05g+Oc03rkF0kv5i2Y6a+ULRUOs68UKqJxjteaOrm5OobzE5zmwV
 cz4kzVlESq59Q7g09aVp7Q5T+VNo/0lN/osvo/OgtSg6SPfJT65lErbKIbKxkWDNjLtZ
 TXUUEdkpP2b8eQUwWmnkqRrHvwcJ3UuxbIU5poIhSMlcR9UUxSdVMgl4DvSts4V0g6hM
 fI2xHbW+pcFvITP2wf8CYWzk/8g0Zg6t+BiXHoep4vXY6unsPO5IDn78YjCfo7nUUOPe
 dviw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7CAagl93ibtV0myzv7WavTs3o0xkVJlhuaglDbfeObQzHy34hvCXM0MaVj/Msy43+UdMInmcG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT+jz9c/lh9aXtJY3swJbstCIrPAgPRql+99e5nf+fK7XIae64
 iPY0u2nN/W+ltUKOhxre9lBR92LPkSDm3NPyWC8JtTh66BRNm68ygDibiTwZmDc=
X-Gm-Gg: ASbGnctn4AQCMDKdlRdp8OMp1z2uNR28Xi/FXiIsD2KLzzJyrCfbe/7dA/njlnWal9r
 +frZghR/n/taonS+MybVC2Yfk+IG3FZzwO4j3UBpiXXNUXZZDGYHVJ5aWenGEsMwNTv3B0cJIiW
 zSfQZ/UhXPp3JJ0YWb86zd2trjK7butPbeI+R+BXeRgzTzNOZpeugXoekj2FzSFW1M0QSHJApfo
 43dM5jgJHM2ug4vw+56jwybtd522bl4McWXAVvkuypT2NOFMacBWeMQpx4vc28gasG3nJFIPQId
 oYZZR2F8/m+mWITudTiKQd0BKLN9f9/kBKLaYfY=
X-Google-Smtp-Source: AGHT+IHCTzTBB/ZhhkU2g6kfeagjQ0bA3rZM/GlWv3NXBKKV0UwS0ToM9TglMakPYb/d9rO5QV6OVQ==
X-Received: by 2002:a05:6a20:72a2:b0:1ee:cab3:4280 with SMTP id
 adf61e73a8af0-1f0fc13e262mr2575190637.14.1740448544914; 
 Mon, 24 Feb 2025 17:55:44 -0800 (PST)
Received: from luan-B550M-AORUS-ELITE.. ([191.185.78.175])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a836c9bsm317816b3a.158.2025.02.24.17.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 17:55:44 -0800 (PST)
From: Luan Icaro Pinto Arcanjo <luanicaro@usp.br>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: Luan Arcanjo <luanicaro@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4] drm/amd/display/dc: Refactor remove duplications
Date: Mon, 24 Feb 2025 22:55:29 -0300
Message-ID: <20250225015532.303032-1-luanicaro@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Luan Arcanjo <luanicaro@usp.br>

All dce command_table_helper's shares a copy-pasted collection
of copy-pasted functions, which are: phy_id_to_atom,
clock_source_id_to_atom_phy_clk_src_id, and engine_bp_to_atom.

This patch removes the multiple copy-pasted by moving them to
the command_table_helper.c and make the command_table_helper's
calls the functions implemented by the command_table_helper.c
instead.

The changes were not tested on actual hardware. I am only able
to verify that the changes keep the code compileable and do my
best to to look repeatedly if I am not actually changing any code.

This is the version 4 of the PATCH, fixed comments about
licence in the new files and the matches From email to
Signed-off-by email. Fixed comments about using
command_table_helper instead of creating a dce_common

Signed-off-by: Luan Icaro Pinto Arcanjo <luanicaro@usp.br>
---
 .../display/dc/bios/command_table_helper.c    | 104 +++++++++++++++++
 .../display/dc/bios/command_table_helper.h    |   8 ++
 .../bios/dce110/command_table_helper_dce110.c | 104 -----------------
 .../dce112/command_table_helper2_dce112.c     | 106 +-----------------
 .../bios/dce112/command_table_helper_dce112.c | 104 -----------------
 .../bios/dce60/command_table_helper_dce60.c   | 104 -----------------
 .../bios/dce80/command_table_helper_dce80.c   | 104 -----------------
 7 files changed, 114 insertions(+), 520 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
index e317a3615147..91bc8a06e2cf 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
@@ -293,3 +293,107 @@ uint8_t dal_cmd_table_helper_encoder_id_to_atom(
 		return ENCODER_OBJECT_ID_NONE;
 	}
 }
+
+uint8_t phy_id_to_atom(enum transmitter t)
+{
+	uint8_t atom_phy_id;
+
+	switch (t) {
+	case TRANSMITTER_UNIPHY_A:
+		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
+		break;
+	case TRANSMITTER_UNIPHY_B:
+		atom_phy_id = ATOM_PHY_ID_UNIPHYB;
+		break;
+	case TRANSMITTER_UNIPHY_C:
+		atom_phy_id = ATOM_PHY_ID_UNIPHYC;
+		break;
+	case TRANSMITTER_UNIPHY_D:
+		atom_phy_id = ATOM_PHY_ID_UNIPHYD;
+		break;
+	case TRANSMITTER_UNIPHY_E:
+		atom_phy_id = ATOM_PHY_ID_UNIPHYE;
+		break;
+	case TRANSMITTER_UNIPHY_F:
+		atom_phy_id = ATOM_PHY_ID_UNIPHYF;
+		break;
+	case TRANSMITTER_UNIPHY_G:
+		atom_phy_id = ATOM_PHY_ID_UNIPHYG;
+		break;
+	default:
+		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
+		break;
+	}
+	return atom_phy_id;
+}
+
+uint8_t clock_source_id_to_atom_phy_clk_src_id(
+		enum clock_source_id id)
+{
+	uint8_t atom_phy_clk_src_id = 0;
+
+	switch (id) {
+	case CLOCK_SOURCE_ID_PLL0:
+		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P0PLL;
+		break;
+	case CLOCK_SOURCE_ID_PLL1:
+		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
+		break;
+	case CLOCK_SOURCE_ID_PLL2:
+		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P2PLL;
+		break;
+	case CLOCK_SOURCE_ID_EXTERNAL:
+		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_REFCLK_SRC_EXT;
+		break;
+	default:
+		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
+		break;
+	}
+
+	return atom_phy_clk_src_id >> 2;
+}
+
+bool engine_bp_to_atom(enum engine_id id, uint32_t *atom_engine_id)
+{
+	bool result = false;
+
+	if (atom_engine_id != NULL)
+		switch (id) {
+		case ENGINE_ID_DIGA:
+			*atom_engine_id = ASIC_INT_DIG1_ENCODER_ID;
+			result = true;
+			break;
+		case ENGINE_ID_DIGB:
+			*atom_engine_id = ASIC_INT_DIG2_ENCODER_ID;
+			result = true;
+			break;
+		case ENGINE_ID_DIGC:
+			*atom_engine_id = ASIC_INT_DIG3_ENCODER_ID;
+			result = true;
+			break;
+		case ENGINE_ID_DIGD:
+			*atom_engine_id = ASIC_INT_DIG4_ENCODER_ID;
+			result = true;
+			break;
+		case ENGINE_ID_DIGE:
+			*atom_engine_id = ASIC_INT_DIG5_ENCODER_ID;
+			result = true;
+			break;
+		case ENGINE_ID_DIGF:
+			*atom_engine_id = ASIC_INT_DIG6_ENCODER_ID;
+			result = true;
+			break;
+		case ENGINE_ID_DIGG:
+			*atom_engine_id = ASIC_INT_DIG7_ENCODER_ID;
+			result = true;
+			break;
+		case ENGINE_ID_DACA:
+			*atom_engine_id = ASIC_INT_DAC1_ENCODER_ID;
+			result = true;
+			break;
+		default:
+			break;
+		}
+
+	return result;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
index dfd30aaf4032..547700e119a6 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
@@ -59,4 +59,12 @@ uint8_t dal_cmd_table_helper_transmitter_bp_to_atom(
 
 uint8_t dal_cmd_table_helper_encoder_id_to_atom(
 	enum encoder_id id);
+
+uint8_t phy_id_to_atom(enum transmitter t);
+
+uint8_t clock_source_id_to_atom_phy_clk_src_id(
+		enum clock_source_id id);
+
+bool engine_bp_to_atom(enum engine_id id, uint32_t *atom_engine_id);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce110/command_table_helper_dce110.c b/drivers/gpu/drm/amd/display/dc/bios/dce110/command_table_helper_dce110.c
index 11bf247bb180..3099128223df 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce110/command_table_helper_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce110/command_table_helper_dce110.c
@@ -31,39 +31,6 @@
 
 #include "../command_table_helper.h"
 
-static uint8_t phy_id_to_atom(enum transmitter t)
-{
-	uint8_t atom_phy_id;
-
-	switch (t) {
-	case TRANSMITTER_UNIPHY_A:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	case TRANSMITTER_UNIPHY_B:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYB;
-		break;
-	case TRANSMITTER_UNIPHY_C:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYC;
-		break;
-	case TRANSMITTER_UNIPHY_D:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYD;
-		break;
-	case TRANSMITTER_UNIPHY_E:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYE;
-		break;
-	case TRANSMITTER_UNIPHY_F:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYF;
-		break;
-	case TRANSMITTER_UNIPHY_G:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYG;
-		break;
-	default:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	}
-	return atom_phy_id;
-}
-
 static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 {
 	uint8_t atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_DP;
@@ -94,32 +61,6 @@ static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 	return atom_dig_mode;
 }
 
-static uint8_t clock_source_id_to_atom_phy_clk_src_id(
-		enum clock_source_id id)
-{
-	uint8_t atom_phy_clk_src_id = 0;
-
-	switch (id) {
-	case CLOCK_SOURCE_ID_PLL0:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P0PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL1:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL2:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P2PLL;
-		break;
-	case CLOCK_SOURCE_ID_EXTERNAL:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_REFCLK_SRC_EXT;
-		break;
-	default:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	}
-
-	return atom_phy_clk_src_id >> 2;
-}
-
 static uint8_t hpd_sel_to_atom(enum hpd_source_id id)
 {
 	uint8_t atom_hpd_sel = 0;
@@ -207,51 +148,6 @@ static bool clock_source_id_to_atom(
 	return result;
 }
 
-static bool engine_bp_to_atom(enum engine_id id, uint32_t *atom_engine_id)
-{
-	bool result = false;
-
-	if (atom_engine_id != NULL)
-		switch (id) {
-		case ENGINE_ID_DIGA:
-			*atom_engine_id = ASIC_INT_DIG1_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGB:
-			*atom_engine_id = ASIC_INT_DIG2_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGC:
-			*atom_engine_id = ASIC_INT_DIG3_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGD:
-			*atom_engine_id = ASIC_INT_DIG4_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGE:
-			*atom_engine_id = ASIC_INT_DIG5_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGF:
-			*atom_engine_id = ASIC_INT_DIG6_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGG:
-			*atom_engine_id = ASIC_INT_DIG7_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DACA:
-			*atom_engine_id = ASIC_INT_DAC1_ENCODER_ID;
-			result = true;
-			break;
-		default:
-			break;
-		}
-
-	return result;
-}
-
 static uint8_t encoder_action_to_atom(enum bp_encoder_control_action action)
 {
 	uint8_t atom_action = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
index 755b6e33140a..349f0e5d5856 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
@@ -29,40 +29,9 @@
 
 #include "include/bios_parser_types.h"
 
-#include "../command_table_helper2.h"
-
-static uint8_t phy_id_to_atom(enum transmitter t)
-{
-	uint8_t atom_phy_id;
+#include "../command_table_helper.h"
 
-	switch (t) {
-	case TRANSMITTER_UNIPHY_A:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	case TRANSMITTER_UNIPHY_B:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYB;
-		break;
-	case TRANSMITTER_UNIPHY_C:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYC;
-		break;
-	case TRANSMITTER_UNIPHY_D:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYD;
-		break;
-	case TRANSMITTER_UNIPHY_E:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYE;
-		break;
-	case TRANSMITTER_UNIPHY_F:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYF;
-		break;
-	case TRANSMITTER_UNIPHY_G:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYG;
-		break;
-	default:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	}
-	return atom_phy_id;
-}
+#include "../command_table_helper2.h"
 
 static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 {
@@ -91,32 +60,6 @@ static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 	return atom_dig_mode;
 }
 
-static uint8_t clock_source_id_to_atom_phy_clk_src_id(
-		enum clock_source_id id)
-{
-	uint8_t atom_phy_clk_src_id = 0;
-
-	switch (id) {
-	case CLOCK_SOURCE_ID_PLL0:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P0PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL1:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL2:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P2PLL;
-		break;
-	case CLOCK_SOURCE_ID_EXTERNAL:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_REFCLK_SRC_EXT;
-		break;
-	default:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	}
-
-	return atom_phy_clk_src_id >> 2;
-}
-
 static uint8_t hpd_sel_to_atom(enum hpd_source_id id)
 {
 	uint8_t atom_hpd_sel = 0;
@@ -209,51 +152,6 @@ static bool clock_source_id_to_atom(
 	return result;
 }
 
-static bool engine_bp_to_atom(enum engine_id id, uint32_t *atom_engine_id)
-{
-	bool result = false;
-
-	if (atom_engine_id != NULL)
-		switch (id) {
-		case ENGINE_ID_DIGA:
-			*atom_engine_id = ASIC_INT_DIG1_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGB:
-			*atom_engine_id = ASIC_INT_DIG2_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGC:
-			*atom_engine_id = ASIC_INT_DIG3_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGD:
-			*atom_engine_id = ASIC_INT_DIG4_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGE:
-			*atom_engine_id = ASIC_INT_DIG5_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGF:
-			*atom_engine_id = ASIC_INT_DIG6_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGG:
-			*atom_engine_id = ASIC_INT_DIG7_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DACA:
-			*atom_engine_id = ASIC_INT_DAC1_ENCODER_ID;
-			result = true;
-			break;
-		default:
-			break;
-		}
-
-	return result;
-}
-
 static uint8_t encoder_action_to_atom(enum bp_encoder_control_action action)
 {
 	uint8_t atom_action = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
index 06b4f7fa4a50..1a5fefcde8af 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
@@ -31,39 +31,6 @@
 
 #include "../command_table_helper.h"
 
-static uint8_t phy_id_to_atom(enum transmitter t)
-{
-	uint8_t atom_phy_id;
-
-	switch (t) {
-	case TRANSMITTER_UNIPHY_A:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	case TRANSMITTER_UNIPHY_B:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYB;
-		break;
-	case TRANSMITTER_UNIPHY_C:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYC;
-		break;
-	case TRANSMITTER_UNIPHY_D:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYD;
-		break;
-	case TRANSMITTER_UNIPHY_E:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYE;
-		break;
-	case TRANSMITTER_UNIPHY_F:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYF;
-		break;
-	case TRANSMITTER_UNIPHY_G:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYG;
-		break;
-	default:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	}
-	return atom_phy_id;
-}
-
 static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 {
 	uint8_t atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_DP;
@@ -91,32 +58,6 @@ static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 	return atom_dig_mode;
 }
 
-static uint8_t clock_source_id_to_atom_phy_clk_src_id(
-		enum clock_source_id id)
-{
-	uint8_t atom_phy_clk_src_id = 0;
-
-	switch (id) {
-	case CLOCK_SOURCE_ID_PLL0:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P0PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL1:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL2:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P2PLL;
-		break;
-	case CLOCK_SOURCE_ID_EXTERNAL:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_REFCLK_SRC_EXT;
-		break;
-	default:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	}
-
-	return atom_phy_clk_src_id >> 2;
-}
-
 static uint8_t hpd_sel_to_atom(enum hpd_source_id id)
 {
 	uint8_t atom_hpd_sel = 0;
@@ -209,51 +150,6 @@ static bool clock_source_id_to_atom(
 	return result;
 }
 
-static bool engine_bp_to_atom(enum engine_id id, uint32_t *atom_engine_id)
-{
-	bool result = false;
-
-	if (atom_engine_id != NULL)
-		switch (id) {
-		case ENGINE_ID_DIGA:
-			*atom_engine_id = ASIC_INT_DIG1_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGB:
-			*atom_engine_id = ASIC_INT_DIG2_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGC:
-			*atom_engine_id = ASIC_INT_DIG3_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGD:
-			*atom_engine_id = ASIC_INT_DIG4_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGE:
-			*atom_engine_id = ASIC_INT_DIG5_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGF:
-			*atom_engine_id = ASIC_INT_DIG6_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGG:
-			*atom_engine_id = ASIC_INT_DIG7_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DACA:
-			*atom_engine_id = ASIC_INT_DAC1_ENCODER_ID;
-			result = true;
-			break;
-		default:
-			break;
-		}
-
-	return result;
-}
-
 static uint8_t encoder_action_to_atom(enum bp_encoder_control_action action)
 {
 	uint8_t atom_action = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.c b/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.c
index 710221b4f5c5..01ccc803040c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.c
@@ -58,51 +58,6 @@ static uint8_t encoder_action_to_atom(enum bp_encoder_control_action action)
 	return atom_action;
 }
 
-static bool engine_bp_to_atom(enum engine_id id, uint32_t *atom_engine_id)
-{
-	bool result = false;
-
-	if (atom_engine_id != NULL)
-		switch (id) {
-		case ENGINE_ID_DIGA:
-			*atom_engine_id = ASIC_INT_DIG1_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGB:
-			*atom_engine_id = ASIC_INT_DIG2_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGC:
-			*atom_engine_id = ASIC_INT_DIG3_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGD:
-			*atom_engine_id = ASIC_INT_DIG4_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGE:
-			*atom_engine_id = ASIC_INT_DIG5_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGF:
-			*atom_engine_id = ASIC_INT_DIG6_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGG:
-			*atom_engine_id = ASIC_INT_DIG7_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DACA:
-			*atom_engine_id = ASIC_INT_DAC1_ENCODER_ID;
-			result = true;
-			break;
-		default:
-			break;
-		}
-
-	return result;
-}
-
 static bool clock_source_id_to_atom(
 	enum clock_source_id id,
 	uint32_t *atom_pll_id)
@@ -149,32 +104,6 @@ static bool clock_source_id_to_atom(
 	return result;
 }
 
-static uint8_t clock_source_id_to_atom_phy_clk_src_id(
-		enum clock_source_id id)
-{
-	uint8_t atom_phy_clk_src_id = 0;
-
-	switch (id) {
-	case CLOCK_SOURCE_ID_PLL0:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P0PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL1:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL2:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P2PLL;
-		break;
-	case CLOCK_SOURCE_ID_EXTERNAL:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_REFCLK_SRC_EXT;
-		break;
-	default:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	}
-
-	return atom_phy_clk_src_id >> 2;
-}
-
 static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 {
 	uint8_t atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_DP;
@@ -270,39 +199,6 @@ static uint8_t dig_encoder_sel_to_atom(enum engine_id id)
 	return atom_dig_encoder_sel;
 }
 
-static uint8_t phy_id_to_atom(enum transmitter t)
-{
-	uint8_t atom_phy_id;
-
-	switch (t) {
-	case TRANSMITTER_UNIPHY_A:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	case TRANSMITTER_UNIPHY_B:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYB;
-		break;
-	case TRANSMITTER_UNIPHY_C:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYC;
-		break;
-	case TRANSMITTER_UNIPHY_D:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYD;
-		break;
-	case TRANSMITTER_UNIPHY_E:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYE;
-		break;
-	case TRANSMITTER_UNIPHY_F:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYF;
-		break;
-	case TRANSMITTER_UNIPHY_G:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYG;
-		break;
-	default:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	}
-	return atom_phy_id;
-}
-
 static uint8_t disp_power_gating_action_to_atom(
 	enum bp_pipe_control_action action)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce80/command_table_helper_dce80.c b/drivers/gpu/drm/amd/display/dc/bios/dce80/command_table_helper_dce80.c
index 8b30b558cf1f..2ec5264536c7 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce80/command_table_helper_dce80.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce80/command_table_helper_dce80.c
@@ -58,51 +58,6 @@ static uint8_t encoder_action_to_atom(enum bp_encoder_control_action action)
 	return atom_action;
 }
 
-static bool engine_bp_to_atom(enum engine_id id, uint32_t *atom_engine_id)
-{
-	bool result = false;
-
-	if (atom_engine_id != NULL)
-		switch (id) {
-		case ENGINE_ID_DIGA:
-			*atom_engine_id = ASIC_INT_DIG1_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGB:
-			*atom_engine_id = ASIC_INT_DIG2_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGC:
-			*atom_engine_id = ASIC_INT_DIG3_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGD:
-			*atom_engine_id = ASIC_INT_DIG4_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGE:
-			*atom_engine_id = ASIC_INT_DIG5_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGF:
-			*atom_engine_id = ASIC_INT_DIG6_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DIGG:
-			*atom_engine_id = ASIC_INT_DIG7_ENCODER_ID;
-			result = true;
-			break;
-		case ENGINE_ID_DACA:
-			*atom_engine_id = ASIC_INT_DAC1_ENCODER_ID;
-			result = true;
-			break;
-		default:
-			break;
-		}
-
-	return result;
-}
-
 static bool clock_source_id_to_atom(
 	enum clock_source_id id,
 	uint32_t *atom_pll_id)
@@ -149,32 +104,6 @@ static bool clock_source_id_to_atom(
 	return result;
 }
 
-static uint8_t clock_source_id_to_atom_phy_clk_src_id(
-		enum clock_source_id id)
-{
-	uint8_t atom_phy_clk_src_id = 0;
-
-	switch (id) {
-	case CLOCK_SOURCE_ID_PLL0:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P0PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL1:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	case CLOCK_SOURCE_ID_PLL2:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P2PLL;
-		break;
-	case CLOCK_SOURCE_ID_EXTERNAL:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_REFCLK_SRC_EXT;
-		break;
-	default:
-		atom_phy_clk_src_id = ATOM_TRANSMITTER_CONFIG_V5_P1PLL;
-		break;
-	}
-
-	return atom_phy_clk_src_id >> 2;
-}
-
 static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
 {
 	uint8_t atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_DP;
@@ -270,39 +199,6 @@ static uint8_t dig_encoder_sel_to_atom(enum engine_id id)
 	return atom_dig_encoder_sel;
 }
 
-static uint8_t phy_id_to_atom(enum transmitter t)
-{
-	uint8_t atom_phy_id;
-
-	switch (t) {
-	case TRANSMITTER_UNIPHY_A:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	case TRANSMITTER_UNIPHY_B:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYB;
-		break;
-	case TRANSMITTER_UNIPHY_C:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYC;
-		break;
-	case TRANSMITTER_UNIPHY_D:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYD;
-		break;
-	case TRANSMITTER_UNIPHY_E:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYE;
-		break;
-	case TRANSMITTER_UNIPHY_F:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYF;
-		break;
-	case TRANSMITTER_UNIPHY_G:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYG;
-		break;
-	default:
-		atom_phy_id = ATOM_PHY_ID_UNIPHYA;
-		break;
-	}
-	return atom_phy_id;
-}
-
 static uint8_t disp_power_gating_action_to_atom(
 	enum bp_pipe_control_action action)
 {
-- 
2.43.0

