Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C18C433E5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2867120787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0r+4qzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2867120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09146EC78;
	Thu, 16 Jul 2020 21:23:15 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07276EC77
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:14 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id f18so8679082wrs.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L2NnGRoWqQTjjQhCOcfsXzUHXwdXw5F+XuvISGdeDxM=;
 b=F0r+4qzSxhM8mJSOj7TjP5wLGGysuN/QY7S+7rRR01VNgsOZ+v0gQ3M/+6LuFFJurD
 u7PI64mE84vJcEXwAzRABdjFHD65ofbWzCjtS+sUcXdLdH5c01KwE2g2ibnRhGp/d4da
 PnORqs79lZLU1BnwtwFCUjmIhA+MGNqs2oTTp7yIRUfBrE5h1IhZ8089prgzBhXaDmMp
 /60/XL3u38zTDscIgGRN30apnzmJ/5217CqpoF1sUywX0eMOs4cP8VYqk0UzzqtU7PhG
 AjEipO4uIsw1BSv7Vxt0UaKx4tqBzr7fi/QmyfW1ZHVQhUWUGWHRY9RRmSENyjCIdW2C
 5vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L2NnGRoWqQTjjQhCOcfsXzUHXwdXw5F+XuvISGdeDxM=;
 b=ikXcVPIie7T99bKU/HZ3rGuVdKiUhImrnq+M24FjirHrcNhVZB2C5lFDUUrv41Ds+b
 +JfKinXhokGdwt/nRI51CcMbTyWIIQP3Ar5E39qZBUoyfnqciFIkfM+WzG4z0wiQXVi/
 Mk8k01uz/et4cdzztq8sJhU3LljjjEpfmgaGGO/b53txuK+qvRikXbSH69pYuu0SB1pS
 OiJgZV+QjBaAIkhAUhqYW3JaeeU3/zRmMMHJDLauDczy1oDFFB+5wvyMnk1yuBncDceF
 2/ZNy5Ku2YJe6O/8qianrFVPfG4K/V2XD52DWXklCzvCJSZTxzsoD/iYjPUu1p8ihJCb
 r3ZQ==
X-Gm-Message-State: AOAM533u3mSKn4sfMRHfovrLWfvi1tc+drbeCYQd1oNmWsmOSEURuPdI
 0mDRlTNMtq9nHqLQLd0/YDWzwR4qnIo=
X-Google-Smtp-Source: ABdhPJxR9H5hcDZxnEvp2gkDLEq/tT8uXpHPESBhChqIy0v2OiCkKRk5CHzb5NodEljx1xjABRyJHQ==
X-Received: by 2002:adf:80c2:: with SMTP id 60mr6251575wrl.388.1594934592732; 
 Thu, 16 Jul 2020 14:23:12 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:12 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 05/27] drm/amd/display: dc/bios: add support for DCE6
Date: Thu, 16 Jul 2020 23:22:29 +0200
Message-Id: <20200716212251.1539094-6-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
command_table_helper.c requires changes for DCE6 support

[How]
DCE6 targets added replicating and adapting the existing DCE8 implementation.

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/bios/Makefile  |   9 +
 .../display/dc/bios/command_table_helper.c    |   8 +
 .../display/dc/bios/command_table_helper.h    |   3 +
 .../display/dc/bios/command_table_helper2.c   |   8 +
 .../display/dc/bios/command_table_helper2.h   |   3 +
 .../bios/dce60/command_table_helper_dce60.c   | 354 ++++++++++++++++++
 .../bios/dce60/command_table_helper_dce60.h   |  33 ++
 7 files changed, 418 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.h

diff --git a/drivers/gpu/drm/amd/display/dc/bios/Makefile b/drivers/gpu/drm/amd/display/dc/bios/Makefile
index 239e86bbec5a..ed6b5e9763f6 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/bios/Makefile
@@ -31,6 +31,15 @@ AMD_DAL_BIOS = $(addprefix $(AMDDALPATH)/dc/bios/,$(BIOS))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_BIOS)
 
+###############################################################################
+# DCE 6x
+###############################################################################
+# All DCE6.x are derived from DCE6.0, so 6.0 MUST be defined if ANY of
+# DCE6.x is compiled.
+ifdef CONFIG_DRM_AMD_DC_SI
+AMD_DISPLAY_FILES += $(AMDDALPATH)/dc/bios/dce60/command_table_helper_dce60.o
+endif
+
 ###############################################################################
 # DCE 8x
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
index 253bbb1eea60..48b4ef03fc8f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
@@ -36,6 +36,14 @@ bool dal_bios_parser_init_cmd_tbl_helper(
 	enum dce_version dce)
 {
 	switch (dce) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case DCE_VERSION_6_0:
+	case DCE_VERSION_6_1:
+	case DCE_VERSION_6_4:
+		*h = dal_cmd_tbl_helper_dce60_get_table();
+		return true;
+#endif
+
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
index 4c3789df253d..dfd30aaf4032 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
@@ -26,6 +26,9 @@
 #ifndef __DAL_COMMAND_TABLE_HELPER_H__
 #define __DAL_COMMAND_TABLE_HELPER_H__
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#include "dce60/command_table_helper_dce60.h"
+#endif
 #include "dce80/command_table_helper_dce80.h"
 #include "dce110/command_table_helper_dce110.h"
 #include "dce112/command_table_helper_dce112.h"
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 21ff6b686f5f..74c498b6774d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -37,6 +37,14 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	enum dce_version dce)
 {
 	switch (dce) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case DCE_VERSION_6_0:
+	case DCE_VERSION_6_1:
+	case DCE_VERSION_6_4:
+		*h = dal_cmd_tbl_helper_dce60_get_table();
+		return true;
+#endif
+
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
index 785fcb20a1b9..66e0a3e73768 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
@@ -26,6 +26,9 @@
 #ifndef __DAL_COMMAND_TABLE_HELPER2_H__
 #define __DAL_COMMAND_TABLE_HELPER2_H__
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#include "dce60/command_table_helper_dce60.h"
+#endif
 #include "dce80/command_table_helper_dce80.h"
 #include "dce110/command_table_helper_dce110.h"
 #include "dce112/command_table_helper2_dce112.h"
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.c b/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.c
new file mode 100644
index 000000000000..710221b4f5c5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.c
@@ -0,0 +1,354 @@
+/*
+ * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dm_services.h"
+
+#include "atom.h"
+
+#include "include/grph_object_id.h"
+#include "include/grph_object_defs.h"
+#include "include/bios_parser_types.h"
+
+#include "../command_table_helper.h"
+
+static uint8_t encoder_action_to_atom(enum bp_encoder_control_action action)
+{
+	uint8_t atom_action = 0;
+
+	switch (action) {
+	case ENCODER_CONTROL_ENABLE:
+		atom_action = ATOM_ENABLE;
+		break;
+	case ENCODER_CONTROL_DISABLE:
+		atom_action = ATOM_DISABLE;
+		break;
+	case ENCODER_CONTROL_SETUP:
+		atom_action = ATOM_ENCODER_CMD_SETUP;
+		break;
+	case ENCODER_CONTROL_INIT:
+		atom_action = ATOM_ENCODER_INIT;
+		break;
+	default:
+		BREAK_TO_DEBUGGER(); /* Unhandle action in driver.!! */
+		break;
+	}
+
+	return atom_action;
+}
+
+static bool engine_bp_to_atom(enum engine_id id, uint32_t *atom_engine_id)
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
+
+static bool clock_source_id_to_atom(
+	enum clock_source_id id,
+	uint32_t *atom_pll_id)
+{
+	bool result = true;
+
+	if (atom_pll_id != NULL)
+		switch (id) {
+		case CLOCK_SOURCE_ID_PLL0:
+			*atom_pll_id = ATOM_PPLL0;
+			break;
+		case CLOCK_SOURCE_ID_PLL1:
+			*atom_pll_id = ATOM_PPLL1;
+			break;
+		case CLOCK_SOURCE_ID_PLL2:
+			*atom_pll_id = ATOM_PPLL2;
+			break;
+		case CLOCK_SOURCE_ID_EXTERNAL:
+			*atom_pll_id = ATOM_PPLL_INVALID;
+			break;
+		case CLOCK_SOURCE_ID_DFS:
+			*atom_pll_id = ATOM_EXT_PLL1;
+			break;
+		case CLOCK_SOURCE_ID_VCE:
+			/* for VCE encoding,
+			 * we need to pass in ATOM_PPLL_INVALID
+			 */
+			*atom_pll_id = ATOM_PPLL_INVALID;
+			break;
+		case CLOCK_SOURCE_ID_DP_DTO:
+			/* When programming DP DTO PLL ID should be invalid */
+			*atom_pll_id = ATOM_PPLL_INVALID;
+			break;
+		case CLOCK_SOURCE_ID_UNDEFINED:
+			BREAK_TO_DEBUGGER(); /* check when this will happen! */
+			*atom_pll_id = ATOM_PPLL_INVALID;
+			result = false;
+			break;
+		default:
+			result = false;
+			break;
+		}
+
+	return result;
+}
+
+static uint8_t clock_source_id_to_atom_phy_clk_src_id(
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
+static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
+{
+	uint8_t atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_DP;
+
+	switch (s) {
+	case SIGNAL_TYPE_DISPLAY_PORT:
+	case SIGNAL_TYPE_EDP:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_DP;
+		break;
+	case SIGNAL_TYPE_LVDS:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_LVDS;
+		break;
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_DVI;
+		break;
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_HDMI;
+		break;
+	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_DP_MST;
+		break;
+	default:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V5_DVI;
+		break;
+	}
+
+	return atom_dig_mode;
+}
+
+static uint8_t hpd_sel_to_atom(enum hpd_source_id id)
+{
+	uint8_t atom_hpd_sel = 0;
+
+	switch (id) {
+	case HPD_SOURCEID1:
+		atom_hpd_sel = ATOM_TRANSMITTER_CONFIG_V5_HPD1_SEL;
+		break;
+	case HPD_SOURCEID2:
+		atom_hpd_sel = ATOM_TRANSMITTER_CONFIG_V5_HPD2_SEL;
+		break;
+	case HPD_SOURCEID3:
+		atom_hpd_sel = ATOM_TRANSMITTER_CONFIG_V5_HPD3_SEL;
+		break;
+	case HPD_SOURCEID4:
+		atom_hpd_sel = ATOM_TRANSMITTER_CONFIG_V5_HPD4_SEL;
+		break;
+	case HPD_SOURCEID5:
+		atom_hpd_sel = ATOM_TRANSMITTER_CONFIG_V5_HPD5_SEL;
+		break;
+	case HPD_SOURCEID6:
+		atom_hpd_sel = ATOM_TRANSMITTER_CONFIG_V5_HPD6_SEL;
+		break;
+	case HPD_SOURCEID_UNKNOWN:
+	default:
+		atom_hpd_sel = 0;
+		break;
+	}
+	return atom_hpd_sel >> 4;
+}
+
+static uint8_t dig_encoder_sel_to_atom(enum engine_id id)
+{
+	uint8_t atom_dig_encoder_sel = 0;
+
+	switch (id) {
+	case ENGINE_ID_DIGA:
+		atom_dig_encoder_sel = ATOM_TRANMSITTER_V5__DIGA_SEL;
+		break;
+	case ENGINE_ID_DIGB:
+		atom_dig_encoder_sel = ATOM_TRANMSITTER_V5__DIGB_SEL;
+		break;
+	case ENGINE_ID_DIGC:
+		atom_dig_encoder_sel = ATOM_TRANMSITTER_V5__DIGC_SEL;
+		break;
+	case ENGINE_ID_DIGD:
+		atom_dig_encoder_sel = ATOM_TRANMSITTER_V5__DIGD_SEL;
+		break;
+	case ENGINE_ID_DIGE:
+		atom_dig_encoder_sel = ATOM_TRANMSITTER_V5__DIGE_SEL;
+		break;
+	case ENGINE_ID_DIGF:
+		atom_dig_encoder_sel = ATOM_TRANMSITTER_V5__DIGF_SEL;
+		break;
+	case ENGINE_ID_DIGG:
+		atom_dig_encoder_sel = ATOM_TRANMSITTER_V5__DIGG_SEL;
+		break;
+	default:
+		atom_dig_encoder_sel = ATOM_TRANMSITTER_V5__DIGA_SEL;
+		break;
+	}
+
+	return atom_dig_encoder_sel;
+}
+
+static uint8_t phy_id_to_atom(enum transmitter t)
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
+static uint8_t disp_power_gating_action_to_atom(
+	enum bp_pipe_control_action action)
+{
+	uint8_t atom_pipe_action = 0;
+
+	switch (action) {
+	case ASIC_PIPE_DISABLE:
+		atom_pipe_action = ATOM_DISABLE;
+		break;
+	case ASIC_PIPE_ENABLE:
+		atom_pipe_action = ATOM_ENABLE;
+		break;
+	case ASIC_PIPE_INIT:
+		atom_pipe_action = ATOM_INIT;
+		break;
+	default:
+		BREAK_TO_DEBUGGER(); /* Unhandle action in driver! */
+		break;
+	}
+
+	return atom_pipe_action;
+}
+
+static const struct command_table_helper command_table_helper_funcs = {
+	.controller_id_to_atom = dal_cmd_table_helper_controller_id_to_atom,
+	.encoder_action_to_atom = encoder_action_to_atom,
+	.engine_bp_to_atom = engine_bp_to_atom,
+	.clock_source_id_to_atom = clock_source_id_to_atom,
+	.clock_source_id_to_atom_phy_clk_src_id =
+		clock_source_id_to_atom_phy_clk_src_id,
+	.signal_type_to_atom_dig_mode = signal_type_to_atom_dig_mode,
+	.hpd_sel_to_atom = hpd_sel_to_atom,
+	.dig_encoder_sel_to_atom = dig_encoder_sel_to_atom,
+	.phy_id_to_atom = phy_id_to_atom,
+	.disp_power_gating_action_to_atom = disp_power_gating_action_to_atom,
+	.assign_control_parameter =
+		dal_cmd_table_helper_assign_control_parameter,
+	.clock_source_id_to_ref_clk_src =
+		dal_cmd_table_helper_clock_source_id_to_ref_clk_src,
+	.transmitter_bp_to_atom = dal_cmd_table_helper_transmitter_bp_to_atom,
+	.encoder_id_to_atom = dal_cmd_table_helper_encoder_id_to_atom,
+	.encoder_mode_bp_to_atom =
+		dal_cmd_table_helper_encoder_mode_bp_to_atom,
+};
+
+const struct command_table_helper *dal_cmd_tbl_helper_dce60_get_table(void)
+{
+	return &command_table_helper_funcs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.h b/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.h
new file mode 100644
index 000000000000..f733be553d5a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce60/command_table_helper_dce60.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DAL_COMMAND_TABLE_HELPER_DCE60_H__
+#define __DAL_COMMAND_TABLE_HELPER_DCE60_H__
+
+struct command_table_helper;
+
+const struct command_table_helper *dal_cmd_tbl_helper_dce60_get_table(void);
+
+#endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
