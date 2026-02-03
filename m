Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED7AE83EF6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F254710E548;
	Wed,  4 Feb 2026 08:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V238TKlR";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D498110E763
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:55 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b87266fdf56so78419766b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145014; x=1770749814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LljkZz4Ncf35oAxsgibHKbM5EMiP01agBwrYGt55o9U=;
 b=V238TKlRvd80lyix+mT//lqRiZG4IU9Jt4cxAdQTSs5yY/0tD2TN08nRVjGoU/jJsH
 oJkKSj6qTr6ttnfizU5x15uk+jzLLhBxxbrkQXFBIcu5+jehVp8WT/cl4oKrUVc4WGpv
 uuxM/ziVRdUHgfVxeYFf0TpRKxQEwtOK7TpXzKn6IBjYJ6EUircM8zxwm+c7bZZ6j+2W
 ER/32tR89Cc5tssgiANsrnphlWV/F1ddgkR7LQyTKQW1lYJ8SP9cJ5LWOes6CbqMEW+5
 hjv176CSsaGsWGXcCq0cp9jS4irNkpDMamsazeZ3lKZ8haZSy/YlZjpDLyKhmgKzqP3m
 qTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145014; x=1770749814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LljkZz4Ncf35oAxsgibHKbM5EMiP01agBwrYGt55o9U=;
 b=f3mAeAij9BCFNolQxA4mRSq7NKC4JNYJkS84jNY+6OLL95LVo+NSiD6fzvMhu9Nifo
 /ekgeKNlB5rzI0uUc1WWN9kKll7N8QHTxR6bPq0avtSOQP6Uw9/vk3tJ/hl7uN2hirad
 Fjop5DSAJZDqlTSpaMdfV1Cv/EDwAAzRN81BfaPgFh/FmpQBi3OBJM3+z2h5J8YI0xk7
 x65zCubjvEG8L+U+ZKmdRaPXX2OpuqmVwPCEcRwrq9p2XdCfFvWvyGUCYU5pcf7gYJZu
 jExOCvdvdMMomwNG9DNDjFfmsPMeK5q8fGttb3PVi+ZlrXubOl9py2aEULqyIXiIBOKR
 XtXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS6KY7eVEPqpMds6juzPke5fGoe2XhgldDGdk7WHd49U2Lyn5dd2gZ64Fp5Hx7a1yGKqV6gujg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxjy4Np3+BlD462Whl04tE/h+tNrcE6qk43D2MG1eIlfnhgsCEY
 srjl/9MHhrpZpryzZNvbdaWUwwBC5JsSlJsHiNRvrFJz5QgrLx2AliEl
X-Gm-Gg: AZuq6aKY6IUMA4/I8LF/YcCW/ZMINoFBR4vFuyXq/uopr6TB/KBPuJO8bpYnKi9OC7O
 9NA/Oc+EEOsgDtOlC9ljMa28FB057M8YEKENV95apf1oATRhaA9ZOCzh0v4Eo23lEruIXJrEeHU
 xkmqNiP1y096J2BVGg6DIRpo3agQzAw2RQ9vB62j8C55iwtZdFgtH/20pOTiY84aVdemQ19tWSt
 Khr7Aoaby5LDsFwu2eLROuylM4g7MPIjgY+9+TGzQQHqokLrkfk8wdbYodjCk6NHP1CPcBT3CHV
 qCXH00P3r1KmUdkNpeDXpcR9pynMwww7sOX5/izlMfS0MzELEfRGqDMG7CwheNn4xVIU5vXtMQa
 jMTHTcq5XK3z1fk9IK4KN49gRm/3iaWTvo+G5zqWSHMDOZfOMAqnfzbeBzyBhIho4Q3UkD2J/EO
 k0grlJ2SX12iqabLlAnQ9tn/dvIaLFZNPl5LNUto7bCkYfuS6wdkasNDKDoN7o7/4j
X-Received: by 2002:a17:907:d26:b0:b76:2667:7736 with SMTP id
 a640c23a62f3a-b8e9f1702c6mr21573566b.4.1770145014183; 
 Tue, 03 Feb 2026 10:56:54 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:53 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 17/19] drm/amd/display: Reintroduce VTEM info frame
Date: Tue,  3 Feb 2026 19:56:24 +0100
Message-ID: <20260203185626.55428-18-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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

Changes in v3:
- Use div_u64() instead of division operator

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../amd/display/modules/inc/mod_info_packet.h |   4 +
 .../display/modules/info_packet/info_packet.c | 176 ++++++++++++------
 2 files changed, 119 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 9ec123ecc7c4..07e86b16ef77 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -50,6 +50,10 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
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
index 829cce9455db..b08b52bba574 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -49,6 +49,7 @@ enum vsc_packet_revision {
 	vsc_packet_rev7 = 7,
 };
 
+#define HDMI_INFOFRAME_TYPE_EMP    0x7F
 #define HDMI_INFOFRAME_TYPE_VENDOR 0x81
 #define HDMI_INFOFRAME_LENGTH_MASK 0x1F
 #define HF_VSIF_VERSION  1
@@ -61,74 +62,52 @@ enum allm_trigger_mode {
 	ALLM_MODE_ENABLED_FORCED  = 2,
 };
 
-// VTEM Byte Offset
-#define VTEM_PB0		0
-#define VTEM_PB1		1
-#define VTEM_PB2		2
-#define VTEM_PB3		3
-#define VTEM_PB4		4
-#define VTEM_PB5		5
-#define VTEM_PB6		6
+#define VTEM_ORG_ID          1
+#define VTEM_DATA_SET_TAG    1
+#define VTEM_DATA_SET_LENGTH 4
 
-#define VTEM_MD0		7
-#define VTEM_MD1		8
-#define VTEM_MD2		9
-#define VTEM_MD3		10
+#define VTEM_M_CONST    0
+#define VTEM_FVA_FACTOR 0
 
+#define VTEM_BRR_MASK_UPPER 0x03
+#define VTEM_BRR_MASK_LOWER 0xFF
 
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
+/* VTEM Byte Offset */
+#define VTEM_PB0 0
+#define VTEM_PB1 1
+#define VTEM_PB2 2
+#define VTEM_PB3 3
+#define VTEM_PB4 4
+#define VTEM_PB5 5
+#define VTEM_PB6 6
 
-//PB1
-#define MASK_VTEM_PB1__RESERVED1 0xFF
+#define VTEM_MD0 7
+#define VTEM_MD1 8
+#define VTEM_MD2 9
+#define VTEM_MD3 10
 
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
 
 
-
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
@@ -644,6 +623,81 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
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
2.52.0

