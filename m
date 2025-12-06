Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEECFD3ABE4
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Dec 2025 02:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248E610EBE0;
	Sat,  6 Dec 2025 02:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FNXlNiWD";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE1910EBDF
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Dec 2025 02:31:17 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-42e2e40582eso1560558f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Dec 2025 18:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764988276; x=1765593076; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqLTIlXdywNXAKzSGHXdyDUNjhXETH+lDYWOOzlWqB8=;
 b=FNXlNiWDBZCLRealew6Ze0HnfrAuxuuTMyAtFBMDhEqhofxWWGY85i8KkanLAH/oXW
 uRTBPcC9BEGhL3J8igxsq/FK7RwHGE8MQRfKWGZ54qPVGWu5SFEkFvWABBK+vHh6oddT
 vqc30aKgcHr3LG23r5HSOCPRaCQmeztu8yd5+Hg6q8u+39U7kAH6NhH6QBeFVkINNZ0W
 OsM19JwLe5MPCnomYw4tDeZa9XHm3Yutd7x4FPEUN6eK0R+IILuwX0QGazXyFEoK3g7A
 nHATJF+YVHDz78znY9Y7ntaivCzr3jLf18bQHRDc12Vb7z9CPzo2IPfQToITpaA3gI2K
 snbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764988276; x=1765593076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YqLTIlXdywNXAKzSGHXdyDUNjhXETH+lDYWOOzlWqB8=;
 b=fq+qDqu1nVsL0uqDSviQQ2ir2gVtpD8bvl6d3vuVe8a+RxyjfiV032aS1+tz67NcmA
 Di9rHgxGCYATcLmy+oEls+FMnKhQYRSiidtZ+FruDDwbyl2JC8fWooStocRP8uhP3POS
 hC25HrsP4YwTr1wX32o+k35k44wBHuC0SPnHbSfo7pZqbjXcX3lvV0cvt1hajddBlkMZ
 vXqz7b+TUHu4Y8lwHE+l2sCdR8js98l//7eZ/WWbNsLmDInhItCaPBt/krPb68jdkDUu
 U3ACWPcFnkrca2NAOxD+te2IiHTt3qcR63KEbzJr8+JwQ/hlaL5eOwBFkKX0OJigvlZq
 O+1g==
X-Gm-Message-State: AOJu0Yww4EWGqSc/N7dxs5+ThV5FeT9JKcsQMyoJ8NnBPegSF3JG9SRh
 g+jXhaIUtyzzl/T+GResuPeW+ap6dGXLQ4pOa2l+PR+7IVmHTPNfy8bAnq05wQ==
X-Gm-Gg: ASbGncsYdMh+0KuwGcfbdofhsD8Rjy6P8aVw8odMkd0avw0saX8AWPRuBDKGVfou6DA
 iRjTciCmaYsP8eFRqINtc9c4p7Xh410WjWBGD0e4YvpAkxUth9J9i7PkMXe0R3qOHMXIoV+I89v
 pdBQb+RfHJiVNdd75qdKHAUjZ/tVocEGEWmt7cnsdKNHSnW5RZRqM0YjX4YPcjW+VxXzP5TvqGD
 ghfrbmunc0sloTtfL2exjg2rCIn5jdalUXjMNey830g5NZu+6Ma8lksYxKnHEAjD1dzXXFz46Dn
 XL44g3yWrE5VGp8hm6d911zg32AKv3EX5nm+eIFamSv9fJZflF9YGaBQ6oSivmDoKe2AfWAdGiE
 B0zC4AL9RiqcuX+Ba0gnVxbM1Mc6VvWGZQlRL5Kf0AwJWAfzFm2MgrUSDvzLdHU9mdU87AKVXgp
 yebtw/7LZm1e75x3UYh8lNuEasBQCpkjtU/MH+sGyI7YZ42wLKet7F7fT1hWR+khwxjbPa9SgXW
 mtZt9SuZyJ4HcHoMSM=
X-Google-Smtp-Source: AGHT+IExs//kxcLsa1Qd1z1Yt5PFf0ArYz7D8PyZq6COA+XeFpM/gpWKGcgvPPJtbbDgdvLeiH2PDA==
X-Received: by 2002:a05:6000:2502:b0:42b:3220:93e8 with SMTP id
 ffacd0b85a97d-42f89f58c88mr1073736f8f.57.1764988275930; 
 Fri, 05 Dec 2025 18:31:15 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E095001DEDB2C8B6514266.dsl.pool.telekom.hu.
 [2001:4c4e:24e0:9500:1ded:b2c8:b651:4266])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbff320sm12133689f8f.18.2025.12.05.18.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 18:31:14 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amd/display: Setup DAC encoder before using it
Date: Sat,  6 Dec 2025 03:31:05 +0100
Message-ID: <20251206023106.8875-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206023106.8875-1-timur.kristof@gmail.com>
References: <20251206023106.8875-1-timur.kristof@gmail.com>
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

Just like for other signal types, call the encoder control
command in the VBIOS to setup the DAC encoder.
The DAC doesn't work well without this on some GPUs,
for example the Radeon HD 7790 needs this.

Fixes: 7d63519cd9ca ("drm/amd/display: Add concept of analog encoders (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/display/dc/dce/dce_stream_encoder.c   | 25 ++++++++++++++++++-
 .../amd/display/dc/inc/hw/stream_encoder.h    |  4 +++
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  4 +++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 574618d5d4a4..1fbf6263c235 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -693,6 +693,24 @@ static void dce110_stream_encoder_lvds_set_stream_attribute(
 	ASSERT(crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB);
 }
 
+static void dce110_stream_encoder_analog_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing)
+{
+	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
+	struct bp_encoder_control cntl = {0};
+
+	cntl.action = ENCODER_CONTROL_SETUP;
+	cntl.engine_id = enc110->base.id;
+	cntl.pixel_clock = crtc_timing->pix_clk_100hz / 10;
+
+	if (enc110->base.bp->funcs->encoder_control(
+			enc110->base.bp, &cntl) != BP_RESULT_OK)
+		return;
+
+	ASSERT(crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB);
+}
+
 static void dce110_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
 	struct fixed31_32 avg_time_slots_per_mtp)
@@ -1521,6 +1539,8 @@ static const struct stream_encoder_funcs dce110_str_enc_funcs = {
 		dce110_stream_encoder_dvi_set_stream_attribute,
 	.lvds_set_stream_attribute =
 		dce110_stream_encoder_lvds_set_stream_attribute,
+	.analog_set_stream_attribute =
+		dce110_stream_encoder_analog_set_stream_attribute,
 	.set_throttled_vcp_size =
 		dce110_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
@@ -1568,7 +1588,10 @@ void dce110_stream_encoder_construct(
 	enc110->se_mask = se_mask;
 }
 
-static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {};
+static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {
+	.analog_set_stream_attribute =
+		dce110_stream_encoder_analog_set_stream_attribute,
+};
 
 void dce110_analog_stream_encoder_construct(
 	struct dce110_stream_encoder *enc110,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 27f950ae45ee..9658b06f32f7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -153,6 +153,10 @@ struct stream_encoder_funcs {
 		struct stream_encoder *enc,
 		struct dc_crtc_timing *crtc_timing);
 
+	void (*analog_set_stream_attribute)(
+		struct stream_encoder *enc,
+		struct dc_crtc_timing *crtc_timing);
+
 	void (*set_throttled_vcp_size)(
 		struct stream_encoder *enc,
 		struct fixed31_32 avg_time_slots_per_mtp);
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index befa67b2b2ae..90ff4fdd79b7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -148,6 +148,10 @@ void setup_dio_stream_attribute(struct pipe_ctx *pipe_ctx)
 		stream_encoder->funcs->lvds_set_stream_attribute(
 				stream_encoder,
 				&stream->timing);
+	else if (dc_is_rgb_signal(stream->signal))
+		stream_encoder->funcs->analog_set_stream_attribute(
+				stream_encoder,
+				&stream->timing);
 
 	if (dc_is_dp_signal(stream->signal))
 		link->dc->link_srv->dp_trace_source_sequence(link,
-- 
2.52.0

