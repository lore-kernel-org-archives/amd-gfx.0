Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DA9E68159
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635BF10E49C;
	Tue, 17 Feb 2026 08:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nnb/lfy+";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0CD10E3CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:47 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b8de2b5a122so59443966b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260346; x=1771865146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6BfGiUOVQc89YPAV055hurM0Ll6ocTXT/P7sPP0SvQ=;
 b=nnb/lfy+WteVYLAHreqrB5sx20h/bTBUpJvNqrEgo0rihV75OwZJBv6eH4qVF404W1
 LHyRrYMC3DbBHEHwYp5Bf9F6bQW2RoiagtXJrmTddKkv6a88h/IxGoHTWdOBogj5QZNd
 p/nBDr4navmFvY/VTskDCLTC9xHz5OUM4KtRlz1LUG0HUOdWodsCJ5iRD9rtj6S28hfu
 Cwu0JCHlq8lH6e29RjsLf4GBPBGuuV8Ea/iZlDloerL53c/2XPh9ZLPW1cvtKYIboiKs
 iN/h1E4V159YP7P+mXhcsD4pbwiXHQ2m2w6LK4or4jdSHKSV3sikb36GimIvgUjYS7ah
 WQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260346; x=1771865146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a6BfGiUOVQc89YPAV055hurM0Ll6ocTXT/P7sPP0SvQ=;
 b=JXBZv6U6Usu6DxieP64lOHAAOg0iZ11bKSTZEeAMKGtd/isAuAlWIspbxvE855XwpX
 cec0KShJScPnuKhsmwDMA9MjqNpsRmLFnwgBAN6pGsFNvAnuEr/9dmV0XwyiQmhZiFf4
 //9JHKbGSGLaota0NXC5tYfV7A8xNaBucBIH2kU0YBYRkHp1wQAoUPqMx6HiG4J0pAfW
 VZBgN3JfWLtLBN07cQWlK7DSP2/NPgOivzTO71R5w/Zl9oSDzybM+WmDAYKZM/XAYGgg
 8K4jwi0EIRKw3TX5Nud9IBQosxA8eO9yMIEnP4eWInYMZXk1755LxocCl7lXeuVsBz7q
 SjHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2TNNLbxNxGOxidDoH9cZRC3rXDQ6qekkowO3UQIKfjahA+175bxysuDUkMH5RLVnR8yN171EF@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyvj9AXh99MvEcfuoSabwEhIrSoAeWoLa6KsAAzo7WiUsOmEGsF
 NM8hfmADUlyxKLO8RnLU9HJ9c9YRX6IomuBil1qH/eh5vDyf+NpmwCSN
X-Gm-Gg: AZuq6aIaEyvVovybLKslL5YN4WfYRFpO4kvTI3S/t3U4X2YJXfJDaKooydg5SuURCNU
 yjY4hod89JCCFx70QckBqOAX/djXMJWLABJHQByyvmPGIO74ufVnz1dpXYbd/5Y5aBYehaHXAHu
 6pJC88u0DmDO3f2nXRxwVsS4LmnNvGHJaGASVccVZWxubwYt8QSSQdDf0DiWPuQ4LcEOVGF3R3B
 Xka8Xf5uKRoIiNypN5YpuMo0Yw9W+BMPB7hRHncX8WsdLuyPYWMMycWUp7k752y7mv5WxRFgGpi
 K3yJgb94XRK5ukWoVguaZh1zAPF0TauxgIRSznuoIPj2z1NoHwDpwQboSXdMUID4SXQaLmfBypd
 WvOJrsuIIr66N0suh17eMBjaqPVjxi19Ttn3d+Ja7phCWZeVtsrb0BrcnEM/uKAqAnYxi2yH3Ki
 KAr6X7GQbnxa2VMYnQP/zpSy///Y7Msenop0pysqeFkakPuWBd7JfL0r7zB1KKNpmdeqGehW28Z
 5dB
X-Received: by 2002:a17:907:7b91:b0:b76:2667:7736 with SMTP id
 a640c23a62f3a-b8face24653mr356210866b.4.1771260345811; 
 Mon, 16 Feb 2026 08:45:45 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:45 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 20/27] drm/amd/display: Reintroduce VTEM info frame
Date: Mon, 16 Feb 2026 17:45:09 +0100
Message-ID: <20260216164516.36803-21-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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

[Why]
VTEM info fram building was removed back in: commit a9f54ce3c603
("drm/amd/display: Refactoring VTEM"), but it's needed to support
HDMI VRR signalling.

[How]
Build completely new and more robust functions to build out the VTEM
infopacket. Many values are defined but could have added logic in the
future, that's shy they are not static values but already value + bit
position in it's byte.

Reduced blanking detection was previously missing. Use possible hblank
periods defined for RB1 (from CVT 1.2), RB2 and RB3 (from CVT 2.1).

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../amd/display/modules/inc/mod_info_packet.h |   4 +
 .../display/modules/info_packet/info_packet.c | 167 ++++++++++++------
 2 files changed, 119 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 306eb7355c25..027113ec147d 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -49,6 +49,10 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet);
 
+void mod_build_vtem_infopacket(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr,
+		struct dc_info_packet *infopacket);
+
 enum adaptive_sync_type {
 	ADAPTIVE_SYNC_TYPE_NONE             = 0,
 	ADAPTIVE_SYNC_TYPE_DP               = 1,
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 53e488fdb4ea..96c84f70ed44 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -48,6 +48,7 @@ enum vsc_packet_revision {
 	vsc_packet_rev7 = 7,
 };
 
+#define HDMI_INFOFRAME_TYPE_EMP    0x7F
 #define HDMI_INFOFRAME_TYPE_VENDOR 0x81
 #define HDMI_INFOFRAME_LENGTH_MASK 0x1F
 #define HF_VSIF_VERSION  1
@@ -63,65 +64,52 @@ enum vsc_packet_revision {
 #define VTEM_PB5		5
 #define VTEM_PB6		6
 
-#define VTEM_MD0		7
-#define VTEM_MD1		8
-#define VTEM_MD2		9
-#define VTEM_MD3		10
+#define VTEM_ORG_ID          1
+#define VTEM_DATA_SET_TAG    1
+#define VTEM_DATA_SET_LENGTH 4
 
+#define VTEM_M_CONST    0
+#define VTEM_FVA_FACTOR 0
 
-// VTEM Byte Masks
-//PB0
-#define MASK_VTEM_PB0__RESERVED0  0x01
-#define MASK_VTEM_PB0__SYNC       0x02
-#define MASK_VTEM_PB0__VFR        0x04
-#define MASK_VTEM_PB0__AFR        0x08
-#define MASK_VTEM_PB0__DS_TYPE    0x30
-	//0: Periodic pseudo-static EM Data Set
-	//1: Periodic dynamic EM Data Set
-	//2: Unique EM Data Set
-	//3: Reserved
-#define MASK_VTEM_PB0__END        0x40
-#define MASK_VTEM_PB0__NEW        0x80
+#define VTEM_BRR_MASK_UPPER 0x03
+#define VTEM_BRR_MASK_LOWER 0xFF
 
-//PB1
-#define MASK_VTEM_PB1__RESERVED1 0xFF
+/* VTEM Byte Offset */
+#define VTEM_PB0 0
+#define VTEM_PB1 1
+#define VTEM_PB2 2
+#define VTEM_PB3 3
+#define VTEM_PB4 4
+#define VTEM_PB5 5
+#define VTEM_PB6 6
 
-//PB2
-#define MASK_VTEM_PB2__ORGANIZATION_ID 0xFF
-	//0: This is a Vendor Specific EM Data Set
-	//1: This EM Data Set is defined by This Specification (HDMI 2.1 r102.clean)
-	//2: This EM Data Set is defined by CTA-861-G
-	//3: This EM Data Set is defined by VESA
-//PB3
-#define MASK_VTEM_PB3__DATA_SET_TAG_MSB    0xFF
-//PB4
-#define MASK_VTEM_PB4__DATA_SET_TAG_LSB    0xFF
-//PB5
-#define MASK_VTEM_PB5__DATA_SET_LENGTH_MSB 0xFF
-//PB6
-#define MASK_VTEM_PB6__DATA_SET_LENGTH_LSB 0xFF
+#define VTEM_MD0 7
+#define VTEM_MD1 8
+#define VTEM_MD2 9
+#define VTEM_MD3 10
 
+/* Extended Metadata Packet */
+/* Header */
+#define EMP_LAST_BIT  6
+#define EMP_FIRST_BIT 7
+/* PB0 */
+#define EMP_SNC_BIT 1
+#define EMP_VFR_BIT 2
+#define EMP_AFR_BIT 3
+#define EMP_DST_BIT 4
+#define EMP_END_BIT 6
+#define EMP_NEW_BIT 7
+/* PB7 = MD0 */
+#define VTEM_VRR_BIT     0
+#define VTEM_M_CONST_BIT 1
+#define VTEM_FVA_BIT     4
+/* MD1 Base_Vfront */
+/* MD2 */
+#define VTEM_BRR_UPPER_BIT 0
+#define VTEM_RB_BIT        2
+/* MD3 BRR Lower */
 
 
-//PB7-27 (20 bytes):
-//PB7 = MD0
-#define MASK_VTEM_MD0__VRR_EN         0x01
-#define MASK_VTEM_MD0__M_CONST        0x02
-#define MASK_VTEM_MD0__QMS_EN         0x04
-#define MASK_VTEM_MD0__RESERVED2      0x08
-#define MASK_VTEM_MD0__FVA_FACTOR_M1  0xF0
-
-//MD1
-#define MASK_VTEM_MD1__BASE_VFRONT    0xFF
-
-//MD2
-#define MASK_VTEM_MD2__BASE_REFRESH_RATE_98  0x03
-#define MASK_VTEM_MD2__RB                    0x04
-#define MASK_VTEM_MD2__NEXT_TFR              0xF8
-
-//MD3
-#define MASK_VTEM_MD3__BASE_REFRESH_RATE_07  0xFF
-
 enum ColorimetryRGBDP {
 	ColorimetryRGB_DP_sRGB               = 0,
 	ColorimetryRGB_DP_AdobeRGB           = 3,
@@ -612,6 +600,81 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		info_packet->valid = true;
 }
 
+static void build_vtem_infopacket_header(struct dc_info_packet *infopacket)
+{
+	uint8_t pb0 = 0;
+
+	/* might need logic in the future */
+	pb0 |= 0 << EMP_SNC_BIT;
+	pb0 |= 1 << EMP_VFR_BIT;
+	pb0 |= 0 << EMP_AFR_BIT;
+	pb0 |= 0 << EMP_DST_BIT;
+	pb0 |= 0 << EMP_END_BIT;
+	pb0 |= 1 << EMP_NEW_BIT;
+
+	infopacket->hb0 = HDMI_INFOFRAME_TYPE_EMP;
+	infopacket->hb1 = (1 << EMP_FIRST_BIT) | (1 << EMP_LAST_BIT);
+	infopacket->hb2 = 0; // sequence
+
+	infopacket->sb[VTEM_PB0] = pb0;
+	infopacket->sb[VTEM_PB2] = VTEM_ORG_ID;
+	infopacket->sb[VTEM_PB4] = VTEM_DATA_SET_TAG;
+	infopacket->sb[VTEM_PB6] = VTEM_DATA_SET_LENGTH;
+}
+
+static void build_vtem_infopacket_data(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr,
+		struct dc_info_packet *infopacket)
+{
+	unsigned int hblank = 0;
+	unsigned int brr = 0;
+	bool vrr_active = false;
+	bool rb = false;
+
+	vrr_active = vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
+		     vrr->state == VRR_STATE_ACTIVE_FIXED;
+
+	infopacket->sb[VTEM_MD0] = VTEM_M_CONST << VTEM_M_CONST_BIT;
+	infopacket->sb[VTEM_MD0] |= VTEM_FVA_FACTOR << VTEM_FVA_BIT;
+	infopacket->sb[VTEM_MD0] |= vrr_active << VTEM_VRR_BIT;
+
+	infopacket->sb[VTEM_MD1] = 0;
+	infopacket->sb[VTEM_MD2] = 0;
+	infopacket->sb[VTEM_MD3] = 0;
+
+	if (!vrr_active || is_hdmi_vic_mode(stream))
+		return;
+	/*
+	 * In accordance with CVT 1.2 and CVT 2.1:
+	 * Reduced Blanking standard defines a fixed value of
+	 * 160 for hblank, further reduced to 80 in RB2. RB3 uses
+	 * fixed hblank of 80 pixels + up to 120 additional pixels
+	 * in 8-pixel steps.
+	 */
+	hblank = stream->timing.h_total - stream->timing.h_addressable;
+	rb = (hblank >= 80 && hblank <= 200 && hblank % 8 == 0);
+	brr = div_u64(mod_freesync_calc_nominal_field_rate(stream), 1000000);
+
+	if (brr > VTEM_BRR_MAX) {
+		infopacket->valid = false;
+		return;
+	}
+
+	infopacket->sb[VTEM_MD1] = (uint8_t) stream->timing.v_front_porch;
+	infopacket->sb[VTEM_MD2] = rb << VTEM_RB_BIT;
+	infopacket->sb[VTEM_MD2] |= (brr >> 8) & VTEM_BRR_MASK_UPPER;
+	infopacket->sb[VTEM_MD3] = brr & VTEM_BRR_MASK_LOWER;
+}
+
+void mod_build_vtem_infopacket(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr,
+		struct dc_info_packet *infopacket)
+{
+	infopacket->valid = true;
+	build_vtem_infopacket_header(infopacket);
+	build_vtem_infopacket_data(stream, vrr, infopacket);
+}
+
 void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		enum adaptive_sync_type asType,
 		const struct AS_Df_params *param,
-- 
2.53.0

