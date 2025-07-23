Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3CFC83F34
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F290410E806;
	Wed, 23 Jul 2025 15:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c9znJODP";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5BA10E7FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:30 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so77453115e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286308; x=1753891108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pv1NFD8WlWHwqAVD6KpdIX45eCtayX3XmouwcEYGrGU=;
 b=c9znJODPsd9JfT0pNl4+5K8cQ9iUYCuyrswyQDG67PKyBmfmFIeWGQsakwf9haa5Lp
 w00R13TYXctBbL4esrXYbKlDtHBkCGS/JzlPDb5w1UyBQY9o0w7Hl3W5i9t3aSPU6OeP
 UPflAdbelcCFeUf4hIUbDZBDyQssn0hu1Ac0fnyBB4v2vOBSGTwCkyDETe25vXiwHEKQ
 YuJO71fqV/Qs5k223QVQFtDfMsatRGwhR9KTp9wZaIo1u5jkBG5TW+GgjLKk+YZwaebG
 9Y2MMomKx917SunrUDSuv3TjWI/iY3yWFjzXhNnTadNRpeAaZF5YItTZ9LdLfZtA5HGJ
 1tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286308; x=1753891108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pv1NFD8WlWHwqAVD6KpdIX45eCtayX3XmouwcEYGrGU=;
 b=Jj3PjDgtdRmdqOcwU6sXDEtgHqFeHggYX+eNAN6aQmtjuP3b7hywAPCcbnwRZhsS9u
 5TpulmRTqGuObtR2Eh5H8vDE6jP1pdepTn+5diLS6GlrRczRhD1mgQjwGIRIyAFu0cD/
 utpo/utGTjkY5HBT9feyOYuQXCB+W73lWSILxx92ZKOIMFEfCXt7+J1zrhHefSgZlzTm
 DKFl9k4Ozrf7tyh8uvxzTmZgCCB5+wGjFkn7SudrpueyRIMHOdZbsa3GQSwL5fxh7DEC
 OkOhee0zfpE3tes6CPSlbahK2pDz/Ejv6735NN3Z2TTRbAM/BXtLmeOWn2Xr9UXl6jGP
 30XQ==
X-Gm-Message-State: AOJu0YwWL2HPEc06miGazlQK+YKqy0BhamDdcrj4r9jHp9yy+su2fpDf
 PJs1hMsIj317nF0+M3yrEMvzhNZQHe1it9MWVL+FB5AGRj0keIjj8rslGCOgYQ==
X-Gm-Gg: ASbGnctfb2XfCcD8+/WC9/QVoZuTBwcqXVnJumjso/mRKHbMIP8kkKhh9G5qbW42Ze+
 FGAGIvhB768K4G2vmZozLAPdQzHIO8zKEuMIBFdmO82OALemUlspy7TwcDgRyxttfG6Yf0aXax+
 WLAm2ColLh8eQOyvAILmSpZ4w0bdc9R8vo3m4wslr43B5XrCwX/VCtiIGetDTu6gWivKehSiBQR
 N4EKlZCDXY0pLswBXnAsrIlgQRWnI/ihnBPqidhQnx/DYXYE3T02ItRWMmJnqYG60CkiBuFYWxI
 Cnvx8/xw8q0UcdgozSVFV31R9aITV1/B9LbzrQy4fcCBok8vNQR54K+iZVL4C9F6Cr8MIpGn8HX
 +cDjpSwcuDKKQ5iPTWks0SSzFuAgdLcJLw3jXCAfUcoQUZZqn+v0YSjgVRLnWQRsf+aBUWYZhTA
 TTcL19OxuGXVIZ0uKk3+tppcoI/Q==
X-Google-Smtp-Source: AGHT+IFOkVZsw2XDZCVBJe8j79aBf07fbBv5AgwrkXu34JXVLC3s5gC31GEUGvx7TKeg9BBZVESXQA==
X-Received: by 2002:a05:600c:6209:b0:456:1dd2:4e3a with SMTP id
 5b1f17b1804b1-45868c75be7mr37683725e9.3.1753286308187; 
 Wed, 23 Jul 2025 08:58:28 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:27 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/20] drm/amd/display: Implement DCE analog stream encoders
Date: Wed, 23 Jul 2025 17:58:03 +0200
Message-ID: <20250723155813.9101-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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

Add stream encoders for DCE6-10 only, because there are definitely
graphics cards with analog connectors out there with these DCE
versions. I am not aware of newer ones.

Considering that all stream encoder functions currently have to do
with digital streams, there is nothing for an analog stream
encoder to do, making them basically a no-op.
That being said, we still need some kind of stream encoder to
represent an analog stream, and it is beneficial to split them from
digital stream encoders in the code to make sure they don't
accidentally write any DIG* registers.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    | 14 ++++++++++++++
 .../drm/amd/display/dc/dce/dce_stream_encoder.h    |  5 +++++
 .../display/dc/resource/dce100/dce100_resource.c   |  6 ++++++
 .../amd/display/dc/resource/dce60/dce60_resource.c |  8 ++++++++
 .../amd/display/dc/resource/dce80/dce80_resource.c |  8 ++++++++
 5 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 1130d7619b26..f8996ee2856b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -1567,3 +1567,17 @@ void dce110_stream_encoder_construct(
 	enc110->se_shift = se_shift;
 	enc110->se_mask = se_mask;
 }
+
+static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {0};
+
+void dce110_analog_stream_encoder_construct(
+	struct dce110_stream_encoder *enc110,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id)
+{
+	enc110->base.funcs = &dce110_an_str_enc_funcs;
+	enc110->base.ctx = ctx;
+	enc110->base.id = eng_id;
+	enc110->base.bp = bp;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
index cc5020a8e1e1..068de1392121 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
@@ -708,6 +708,11 @@ void dce110_stream_encoder_construct(
 	const struct dce_stream_encoder_shift *se_shift,
 	const struct dce_stream_encoder_mask *se_mask);
 
+void dce110_analog_stream_encoder_construct(
+	struct dce110_stream_encoder *enc110,
+	struct dc_context *ctx,
+	struct dc_bios *bp,
+	enum engine_id eng_id);
 
 void dce110_se_audio_mute_control(
 	struct stream_encoder *enc, bool mute);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 72efb13c9027..9e70e920eb69 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -374,6 +374,7 @@ static const struct bios_registers bios_regs = {
 static const struct resource_caps res_cap = {
 	.num_timing_generator = 6,
 	.num_audio = 6,
+	.num_analog_stream_encoder = 1,
 	.num_stream_encoder = 6,
 	.num_pll = 3,
 	.num_ddc = 6,
@@ -483,6 +484,11 @@ static struct stream_encoder *dce100_stream_encoder_create(
 	if (!enc110)
 		return NULL;
 
+	if (eng_id == ENGINE_ID_DACA || eng_id == ENGINE_ID_DACB) {
+		dce110_analog_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id);
+		return &enc110->base;
+	}
+
 	dce110_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id,
 					&stream_enc_regs[eng_id], &se_shift, &se_mask);
 	return &enc110->base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 58b59d52dc9d..29ccfbddb492 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -372,6 +372,7 @@ static const struct bios_registers bios_regs = {
 static const struct resource_caps res_cap = {
 		.num_timing_generator = 6,
 		.num_audio = 6,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 6,
 		.num_pll = 2,
 		.num_ddc = 6,
@@ -381,6 +382,7 @@ static const struct resource_caps res_cap_61 = {
 		.num_timing_generator = 4,
 		.num_audio = 6,
 		.num_stream_encoder = 6,
+		.num_analog_stream_encoder = 1,
 		.num_pll = 3,
 		.num_ddc = 6,
 };
@@ -388,6 +390,7 @@ static const struct resource_caps res_cap_61 = {
 static const struct resource_caps res_cap_64 = {
 		.num_timing_generator = 2,
 		.num_audio = 2,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 2,
 		.num_pll = 2,
 		.num_ddc = 2,
@@ -598,6 +601,11 @@ static struct stream_encoder *dce60_stream_encoder_create(
 	if (!enc110)
 		return NULL;
 
+	if (eng_id == ENGINE_ID_DACA || eng_id == ENGINE_ID_DACB) {
+		dce110_analog_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id);
+		return &enc110->base;
+	}
+
 	dce110_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id,
 					&stream_enc_regs[eng_id],
 					&se_shift, &se_mask);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 3e8b0ac11d90..f90e51696bda 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -374,6 +374,7 @@ static const struct bios_registers bios_regs = {
 static const struct resource_caps res_cap = {
 		.num_timing_generator = 6,
 		.num_audio = 6,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 6,
 		.num_pll = 3,
 		.num_ddc = 6,
@@ -382,6 +383,7 @@ static const struct resource_caps res_cap = {
 static const struct resource_caps res_cap_81 = {
 		.num_timing_generator = 4,
 		.num_audio = 7,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 7,
 		.num_pll = 3,
 		.num_ddc = 6,
@@ -390,6 +392,7 @@ static const struct resource_caps res_cap_81 = {
 static const struct resource_caps res_cap_83 = {
 		.num_timing_generator = 2,
 		.num_audio = 6,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 6,
 		.num_pll = 2,
 		.num_ddc = 2,
@@ -604,6 +607,11 @@ static struct stream_encoder *dce80_stream_encoder_create(
 	if (!enc110)
 		return NULL;
 
+	if (eng_id == ENGINE_ID_DACA || eng_id == ENGINE_ID_DACB) {
+		dce110_analog_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id);
+		return &enc110->base;
+	}
+
 	dce110_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id,
 					&stream_enc_regs[eng_id],
 					&se_shift, &se_mask);
-- 
2.50.1

