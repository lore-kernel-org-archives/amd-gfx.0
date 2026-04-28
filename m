Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5025FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62CFF10EB24;
	Tue, 28 Apr 2026 11:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VvZbsSO4";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D1A10EB24
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:40:56 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-483487335c2so109946715e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777376455; x=1777981255; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Obo47vWzK513jTqhVyHxfM4FTDmAMMJkHC1WqmEqkA=;
 b=VvZbsSO4YAWLu+2P6ntN5aooRKTNO8QlhY9HiyGm7eGYf05Y0OgN791Goijq9dMSmE
 FA9oU0sSlLBYoX0Nn2G3GfxsIFUW0YHe5P0QwIFXkxq1k6tjU2WBBOuSmeRzBWL+Ddhi
 PQIu1of4R8F8JXFbM8Fec2ToP7lrWHJdlAiwDAhOYara9DherXC0D+Im1+NpE0I1pD34
 cWSCSU2rPqUZKSgOYDS4JgBGTT7M7AsmU3HRbx9RHLrZUVaSU8osaJeylnk3r7IYsrkm
 s+w9stblFP5F6q5iNH+9mSFYOwE6r9dsj+/dAzEh2l9k8CqA653JdAeVdL2LbJOEfC6P
 xe2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376455; x=1777981255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Obo47vWzK513jTqhVyHxfM4FTDmAMMJkHC1WqmEqkA=;
 b=V90JWdui9AuX/KYTX/EYwlV0MLFnhBDzjeE5BT2DiYk2zqpxLNPZZlby647vNFPGxu
 CqJJ/XqO6Bmvy6Gw6cztKGUlqnKtiURB+lU5h5a1/WMUYKXshc3hYHZ54YaKncfyJvK6
 g2URRzBbLYzvuc2eowTe2Z/5Mk+Zl5CH9XMBcMf1C3qmyez+dSl+vfpC5XJPzykNNaZ8
 IcP1e3nAWI5ECuLmBfYjUuNgl9n8RUDZ8FiJIaCgrKZcVYYLFRvXvjXtWrDy6XXGRCpB
 ZgRj4SlTFH8sdLpXSud0bisRNYTHLNoZoSmSjHxBIHudq5qds8I5fgLbQ3/dhwGQ/iWQ
 lQKQ==
X-Gm-Message-State: AOJu0YxEgijQiUISb2Zb6cLTYdofkm6VB2aldIpqF5I2dbeudObLe4JJ
 Z9c53DMZ8xkKAiG6+ubTgWYHAK3+DjhQB6duYdohXkML86+GAqeIHZWuJXuOUY4b
X-Gm-Gg: AeBDievCBYscgiIO+eVM8vJXfeIXAWyEKOS21VTnBEhEL0SEA12x6VvxgCcKZ8ZyN3N
 biMcg6HCsgg9CPs0mo0/i05ztFRiyNqIDphdy/YG0aodt2C/5RZSZLuutdaGI593S0aC6Tu1oRz
 cI0O1RSoqRYrUo0rNvhpQAgGQgA7KAxDAamRFl/oljUSAFrgDCqIsV3C6otY31XKiotGhlkLpNC
 WEo3G+VzJQmIgzGGhNFP6YjL0PCzmAkPECUKSTmjO0CG8mNk6Ody7nNVKmFG2mYmo1JSLAe3VRJ
 pQ61ZFjIeJMQlYzFTR3cNNtEZ1XCtEBeZYo2BRB9BKCUkq7Gwxs1LX+5m3BT3hlwSRtMrELhTMH
 RU5uXTrp34h2Cfxe9VfcSYv/Ch5Gf5UFUjZWHyKnF8VRum5d0UOZ8gLqoRu5Pmwfy/6HvaaP8An
 qxMZsrpFUz/jpqSR4tbCPGPOC+/izuvepYRCt4k4Hx9X0JHn4PaxJv/W7khvsi74ppSX/cG92cY
 Cpj
X-Received: by 2002:a05:600c:c048:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48a77b22dedmr31925835e9.25.1777376454670; 
 Tue, 28 Apr 2026 04:40:54 -0700 (PDT)
Received: from Timur-Hyperion.home (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775e4bd0sm25048275e9.8.2026.04.28.04.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:40:54 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/6] drm/amd/display: Read EDID from VBIOS embedded panel info
Date: Tue, 28 Apr 2026 13:40:44 +0200
Message-ID: <20260428114045.40710-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428114045.40710-1-timur.kristof@gmail.com>
References: <20260428114045.40710-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Some board manufacturers hardcode the EDID for the embedded
panel in the VBIOS. This EDID should be used when the panel
doesn't have a DDC.

For reference, see the legacy non-DC display code:
amdgpu_atombios_encoder_get_lcd_info()

This is necessary to support embedded connectors without DDC.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5192
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 62 +++++++++++++++++++
 .../display/include/grph_object_ctrl_defs.h   |  4 ++
 2 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index ec75882ac4777..05f299ec5463d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -1313,6 +1313,60 @@ static enum bp_result bios_parser_get_embedded_panel_info(
 	return BP_RESULT_FAILURE;
 }
 
+static enum bp_result get_embedded_panel_extra_info(
+	struct bios_parser *bp,
+	struct embedded_panel_info *info,
+	const uint32_t table_offset)
+{
+	uint8_t *record = bios_get_image(&bp->base, table_offset, 1);
+	ATOM_PANEL_RESOLUTION_PATCH_RECORD *panel_res_record;
+	ATOM_FAKE_EDID_PATCH_RECORD *fake_edid_record;
+
+	while (*record != ATOM_RECORD_END_TYPE) {
+		switch (*record) {
+		case LCD_MODE_PATCH_RECORD_MODE_TYPE:
+			record += sizeof(ATOM_PATCH_RECORD_MODE);
+			break;
+		case LCD_RTS_RECORD_TYPE:
+			record += sizeof(ATOM_LCD_RTS_RECORD);
+			break;
+		case LCD_CAP_RECORD_TYPE:
+			record += sizeof(ATOM_LCD_MODE_CONTROL_CAP);
+			break;
+		case LCD_FAKE_EDID_PATCH_RECORD_TYPE:
+			fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
+			if (fake_edid_record->ucFakeEDIDLength) {
+				if (fake_edid_record->ucFakeEDIDLength == 128)
+					info->fake_edid_size =
+						fake_edid_record->ucFakeEDIDLength;
+				else
+					info->fake_edid_size =
+						fake_edid_record->ucFakeEDIDLength * 128;
+
+				info->fake_edid = fake_edid_record->ucFakeEDIDString;
+
+				record += struct_size(fake_edid_record,
+						      ucFakeEDIDString,
+						      info->fake_edid_size);
+			} else {
+				/* empty fake edid record must be 3 bytes long */
+				record += sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
+			}
+			break;
+		case LCD_PANEL_RESOLUTION_RECORD_TYPE:
+			panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
+			info->panel_width_mm = panel_res_record->usHSize;
+			info->panel_height_mm = panel_res_record->usVSize;
+			record += sizeof(ATOM_PANEL_RESOLUTION_PATCH_RECORD);
+			break;
+		default:
+			return BP_RESULT_BADBIOSTABLE;
+		}
+	}
+
+	return BP_RESULT_OK;
+}
+
 static enum bp_result get_embedded_panel_info_v1_2(
 	struct bios_parser *bp,
 	struct embedded_panel_info *info)
@@ -1429,6 +1483,10 @@ static enum bp_result get_embedded_panel_info_v1_2(
 	if (ATOM_PANEL_MISC_API_ENABLED & lvds->ucLVDS_Misc)
 		info->lcd_timing.misc_info.API_ENABLED = true;
 
+	if (lvds->usExtInfoTableOffset)
+		return get_embedded_panel_extra_info(bp, info,
+			le16_to_cpu(lvds->usExtInfoTableOffset) + DATA_TABLES(LCD_Info));
+
 	return BP_RESULT_OK;
 }
 
@@ -1554,6 +1612,10 @@ static enum bp_result get_embedded_panel_info_v1_3(
 			(uint32_t) (ATOM_PANEL_MISC_V13_GREY_LEVEL &
 				lvds->ucLCD_Misc) >> ATOM_PANEL_MISC_V13_GREY_LEVEL_SHIFT;
 
+	if (lvds->usExtInfoTableOffset)
+		return get_embedded_panel_extra_info(bp, info,
+			le16_to_cpu(lvds->usExtInfoTableOffset) + DATA_TABLES(LCD_Info));
+
 	return BP_RESULT_OK;
 }
 
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index 38a77fa9b4afd..a0f03fb67605e 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -153,6 +153,10 @@ struct embedded_panel_info {
 	uint32_t drr_enabled;
 	uint32_t min_drr_refresh_rate;
 	bool realtek_eDPToLVDS;
+	uint16_t panel_width_mm;
+	uint16_t panel_height_mm;
+	uint16_t fake_edid_size;
+	const uint8_t *fake_edid;
 };
 
 struct dc_firmware_info {
-- 
2.53.0

