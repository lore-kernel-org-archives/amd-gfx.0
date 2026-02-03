Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1116AE83EED
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC6410E4D3;
	Wed,  4 Feb 2026 08:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLJ5HHLf";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E15310E75F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:51 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b8de2b5a122so71331566b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145010; x=1770749810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95VCxPcm8UPz0sIpTAJnRyialODS1BosqnZDH20bJNE=;
 b=cLJ5HHLf+T4zNYMNOnmDalqSduioWQSsZpAerm2LDlVvX7h1ljsouUWgCZJzuHWoqk
 xFyXkEWn/9NYLiqSufTOmSCqX+7dQAvRzo4ZeOVYzNkKCJPazHrrZPPykhvbP2kQ6Uhm
 sQgtID2EBrUj5+khBwNqskTU++CiqR5IVFo8nndea4x6xwG/nadNda225+hpWEQrjWMU
 vFTLLxHNvrFYZS+sAg6pxHisFJ8rYyQixz1LsMEUbWcFabTHfPtk+toonnSdij/s3r9A
 DyBhSc2qOV8Tl8EJXBUjgTlf11NIXz9u0eAe5HWLNBHpYoLhXN+Hn6IXCY3yqDmN9kfq
 k6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145010; x=1770749810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=95VCxPcm8UPz0sIpTAJnRyialODS1BosqnZDH20bJNE=;
 b=OJ5DgMzrCHek1eH50gXt6PRYyAzzruWaTXSD1jFR/NFtgRXLDOc78KoayGFKDtGG3M
 D97hyKgHh9iTetxRcuuaJC472y571UtUM9WqffsP6nLgUArPsJmgVp5pLQ3noYxsFD40
 PaOSDgY57fC62SswtNRG941JYUwSYQFVz1TxYH6g3Xw40Yym/z/Fvc3w5teN7F+D86y4
 4A5xpKCjwqhOCThtem7j+kaOTrae8YoZ9Z9/JPea7eI37eW2wgjBsS3ByUh9gev7CcE6
 ht7BHLA+D05NUvNciuDp00anq0Lru7/WhJrQ0/ygmDt+Kc9x+BGJd7a22mB4SxBOsqBU
 ldoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+pzVWnqmcSX9fPinh6doqpQkWsDkWLfeiDWHvXT6CqRRbwntxQJ21zKLeMpNx87vAcEf+PcvK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRyhyGDtv3NZuJ3XYK9Ff7vbfdWTP7J5gRmckm10+Qjn6N2b9Y
 m2gwZ/505ow6KNIgCSRngDsFCR1YFPM/Sd9R9RQycEEd8nBvcTXg0tHA
X-Gm-Gg: AZuq6aKq6K6WgtOYEXu1IQGNVXhGOVI6AcniTHTvfRUW+s3l6ArU2qXfQxBrPmBC5oP
 6+Nu6GwbolJDrFXZjcEAytroa+uRHclOf5O57+ghbF7YaTNvk6VV0GeYxd4bslBca3mLhrnHtqP
 Id/gNjWpqkFYFAq9oY7F0UfgY4GHLfcumx/PhCFIzzPPQMXiINKIpNzrZVMETSsu0fFF4Eke6uO
 kRz4GpvPVQrCtkrWEP/oGOYyBTnYMnz7qiAlIbMZgzqvGNWzuhGOcZC6ls3yxHa5EehiEH76Ov8
 ue13lR/vcOgbSto092ohsMulnUULl9OdzH8C77CNN0c/wOrNzFHnGuE8VXSXAsII6ms6wGoAoIE
 pq+eU1v7y3rgeN2VxjgvUXizICt05vsEQ0JfO7iRAlywwdfjtXD361cxP0R5l2o2ir13LdcBdTV
 NKtGrWfCkjCEXc4oADgBL7Y/qL1zYRz1MU6gTaX0bHOAsk7S4VC++vqFcKfiFs+Hb4zSXjj3kes
 AQ=
X-Received: by 2002:a17:907:d78b:b0:b8d:e858:dee5 with SMTP id
 a640c23a62f3a-b8e9f2b2cfbmr22358766b.5.1770145009710; 
 Tue, 03 Feb 2026 10:56:49 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:49 -0800 (PST)
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
Subject: [PATCH v3 14/19] drm/amd/display: Restore ALLM support in HDMI vsif
Date: Tue,  3 Feb 2026 19:56:21 +0100
Message-ID: <20260203185626.55428-15-tomasz.pakula.oficjalny@gmail.com>
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
Support for triggering ALLM in modern TVs is missing.

When HDMI vsif was added in 2019:
commit 3c2381b92cba ("drm/amd/display: add support for VSIP info packet")
it was improperly handeled as HDMI actually has two separate vsifs. The
implementation was based on H14b-vsif and ALLM bit was messing it up
because H14b-vsif doesn't support ALLM. It was later removed in:
commit 75f77aafe281 ("drm/amd/display: Send H14b-VSIF specified in HDMI")

ALLM is supported by hf-vsif (HDMI Forum) instead.

[How]
Add proper logic to construct either h14b-vsif or hf-vsif based on
required capabilities. Currently, only ALLM from hf-vsif is supported.

Turns out, hf-vsif is almost identical to h14b-vsif, BUT has additional
two bytes of data after OUI. First byte is static and seems like
a version supported by leftover define. Second byte consists of 3D and
ALLM bits.

Implement logic to offset 3D data if building hf-vsif.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../display/modules/info_packet/info_packet.c | 113 ++++++++++++------
 1 file changed, 74 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 294f56d20062..8e110c86bdd4 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -49,7 +49,10 @@ enum vsc_packet_revision {
 };
 
 #define HDMI_INFOFRAME_TYPE_VENDOR 0x81
-#define HF_VSIF_VERSION 1
+#define HDMI_INFOFRAME_LENGTH_MASK 0x1F
+#define HF_VSIF_VERSION  1
+#define HF_VSIF_3D_BIT   0
+#define HF_VSIF_ALLM_BIT 1
 
 // VTEM Byte Offset
 #define VTEM_PB0		0
@@ -496,9 +499,29 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 }
 
+static bool is_hdmi_vic_mode(const struct dc_stream_state *stream)
+{
+	if (stream->timing.hdmi_vic == 0)
+		return false;
+
+	if (stream->timing.h_total < 3840 ||
+	    stream->timing.v_total < 2160)
+		return false;
+
+	/* 3D/ALLM forces HDMI VIC -> CTA VIC translation */
+	if (stream->view_format != VIEW_3D_FORMAT_NONE)
+		return false;
+
+	if (stream->link->local_sink->edid_caps.allm)
+		return false;
+
+	return true;
+}
+
 /**
  *  mod_build_hf_vsif_infopacket - Prepare HDMI Vendor Specific info frame.
  *                                 Follows HDMI Spec to build up Vendor Specific info frame
+ *                                 Conforms to h14b-vsif or hf-vsif based on the capabilities
  *
  *  @stream:      contains data we may need to construct VSIF (i.e. timing_3d_format, etc.)
  *  @info_packet: output structure where to store VSIF
@@ -506,63 +529,75 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet)
 {
-		unsigned int length = 5;
 		bool hdmi_vic_mode = false;
+		bool allm = false;
+		bool stereo = false;
 		uint8_t checksum = 0;
-		uint32_t i = 0;
+		uint8_t offset = 0;
+		uint8_t i = 0;
+		uint8_t length = 5;
+		uint32_t oui = HDMI_IEEE_OUI;
 		enum dc_timing_3d_format format;
 
 		info_packet->valid = false;
+
 		format = stream->timing.timing_3d_format;
 		if (stream->view_format == VIEW_3D_FORMAT_NONE)
 			format = TIMING_3D_FORMAT_NONE;
+		stereo = format != TIMING_3D_FORMAT_NONE;
+		hdmi_vic_mode = is_hdmi_vic_mode(stream);
 
-		if (stream->timing.hdmi_vic != 0
-				&& stream->timing.h_total >= 3840
-				&& stream->timing.v_total >= 2160
-				&& format == TIMING_3D_FORMAT_NONE)
-			hdmi_vic_mode = true;
-
-		if ((format == TIMING_3D_FORMAT_NONE) && !hdmi_vic_mode)
+		if (!stereo && !hdmi_vic_mode && !allm)
 			return;
 
-		info_packet->sb[1] = 0x03;
-		info_packet->sb[2] = 0x0C;
-		info_packet->sb[3] = 0x00;
+		if (allm)
+			oui = HDMI_FORUM_IEEE_OUI;
 
-		if (format != TIMING_3D_FORMAT_NONE)
-			info_packet->sb[4] = (2 << 5);
+		info_packet->sb[1] = oui & 0xFF;
+		info_packet->sb[2] = (oui >> 8) & 0xFF;
+		info_packet->sb[3] = (oui >> 16) & 0xFF;
 
-		else if (hdmi_vic_mode)
-			info_packet->sb[4] = (1 << 5);
-
-		switch (format) {
-		case TIMING_3D_FORMAT_HW_FRAME_PACKING:
-		case TIMING_3D_FORMAT_SW_FRAME_PACKING:
-			info_packet->sb[5] = (0x0 << 4);
-			break;
-
-		case TIMING_3D_FORMAT_SIDE_BY_SIDE:
-		case TIMING_3D_FORMAT_SBS_SW_PACKED:
-			info_packet->sb[5] = (0x8 << 4);
-			length = 6;
-			break;
-
-		case TIMING_3D_FORMAT_TOP_AND_BOTTOM:
-		case TIMING_3D_FORMAT_TB_SW_PACKED:
-			info_packet->sb[5] = (0x6 << 4);
-			break;
-
-		default:
-			break;
+		if (oui == HDMI_FORUM_IEEE_OUI) {
+			offset = 2;
+			length += 2;
+			info_packet->sb[4] = HF_VSIF_VERSION;
+			info_packet->sb[5] = stereo << HF_VSIF_3D_BIT;
+			info_packet->sb[5] |= allm << HF_VSIF_ALLM_BIT;
 		}
 
-		if (hdmi_vic_mode)
+		if (stereo) {
+			info_packet->sb[4 + offset] = (2 << 5);
+
+			switch (format) {
+			case TIMING_3D_FORMAT_HW_FRAME_PACKING:
+			case TIMING_3D_FORMAT_SW_FRAME_PACKING:
+				info_packet->sb[5 + offset] = (0x0 << 4);
+				break;
+
+			case TIMING_3D_FORMAT_SIDE_BY_SIDE:
+			case TIMING_3D_FORMAT_SBS_SW_PACKED:
+				info_packet->sb[5 + offset] = (0x8 << 4);
+				++length;
+				break;
+
+			case TIMING_3D_FORMAT_TOP_AND_BOTTOM:
+			case TIMING_3D_FORMAT_TB_SW_PACKED:
+				info_packet->sb[5 + offset] = (0x6 << 4);
+				break;
+
+			default:
+				break;
+			}
+
+		/* Doesn't need the offset as it can't be used with hf-vsif */
+		} else if (hdmi_vic_mode) {
+			info_packet->sb[4] = (1 << 5);
 			info_packet->sb[5] = stream->timing.hdmi_vic;
+		}
 
 		info_packet->hb0 = HDMI_INFOFRAME_TYPE_VENDOR;
 		info_packet->hb1 = 0x01;
-		info_packet->hb2 = (uint8_t) (length);
+		info_packet->hb2 = length & HDMI_INFOFRAME_LENGTH_MASK;
 
 		checksum += info_packet->hb0;
 		checksum += info_packet->hb1;
-- 
2.52.0

