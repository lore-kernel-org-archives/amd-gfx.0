Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33413CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE09110EAC1;
	Fri, 26 Sep 2025 18:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dOxaYs4q";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6499210EAC1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:13 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-27ee41e074dso18805345ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909793; x=1759514593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7McYtGB32d7/yfJQLa7IS29eaoIt2ZbxMy6/CtXhxE=;
 b=dOxaYs4qfUy9P4byznUmLQ+I1XNFsj2BTaCvqXb6Uu7excWFxEIg2owcSTx3sC3Pw8
 KN7JKW7bxtFxwgC4EVFf0pR/14xQrbc6YagEfk72SdmNNMNYNtLyebJEimQy1cYwmBzJ
 Dou6eWwsgSii0gUYDMUxoaCYDzC3yEhsOa8kxLzmGx00TzRZKbVUbGff4sk/54i4+yxo
 FzSCFBs/VVamdeRq87nV+DzClkKsjEEW0v34mVWYYMJSAKKFMvyREYz04y39XVmRajI2
 mFa7luQY4vS4sSukwPl1Q26yxsHqcLK5GOw4tdTaIcLzC9YYDPp3K32X55hkaAPcpnyr
 Tbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909793; x=1759514593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7McYtGB32d7/yfJQLa7IS29eaoIt2ZbxMy6/CtXhxE=;
 b=C80UXta+vTMWB7rJqmIvzHFqzH1o/CJbegox/ErRbYeztBUXiPd17qoEtBYwUQB/zJ
 EMM5gCesAddkMn8BoDHC2tx9PML337FburJt0NefTBRpZ48kHgQGYg0NZgr6BXdNW5eB
 JI92l7L8nNcJRsiVFN8w470usFS+sXlOh8Ssp4Is39odDDddn6qVOJsae2L7WM6YSCvO
 QUWq7ZzfAbfckQ0Jlm8SWWtMZDC6pmTMi9esPpE37Ujm52JU7H1TT0rSrJvBLzaVbXeT
 cBk9dm39Pjnvk7STO3tjiSzLrREg7qBgWthPwPtngasj2EHZcfp9WwTnaPv5ZkQGXBqY
 JoQw==
X-Gm-Message-State: AOJu0YwYNICw1fJRtE69lYRO+w+oXlCM7YLeq8VqnpSn50IzYuPgVJsP
 YnmZnCrWx4bmldzSPceyerNxtTM6xOfki7cyY9twkrlyX8zg8ley2L8pgR8fuQ==
X-Gm-Gg: ASbGncuCa8zMGtrifSX3ryhH0J2+CKLV2pu/NZJtxb/trYxgdqbJojsaOtHWws2DnXE
 CKCg8xbQOrHV9d2xOSkAdCWhlpZNjFyadSZPkq/nuF3MggpL8aWHv+vCiqsoV8beC2WqIaPtyNb
 gmX5/3GaUzibkiRi2HOEPnJeLXdcD1Vf6fF2M25oW8E8VaWAAiZz2RkuEnRu0qNO8JVorlMHdWz
 TrFtkjfcHbeTS7srAfTHnU9SO3H0bfvcfB4u2z/aPAp0YgjGcuFvqeio5Yv/CI/BZXj+UYYOQnZ
 giE9Dh7oPuATn234IbT9YFrveyH6Yi4ydhOSVMZtm41MeaCTx3TRrl5ykKimkZGXWxbbvWpuP3Z
 D4SbKr62jMb1ZStS5XEsFyrVhsfnU8PSSyPhcwwwGUhCDpLQq63Uk7mi31Uen4RVsiO92Oazb3S
 Zqam59oNFx8d91xDdFrKyf6WzcRhcFUg==
X-Google-Smtp-Source: AGHT+IHKGTxSR6f+73UzhSImt1dhvpsY/X/41I+dldWpmyVMeTvQzsFg0F2uPhtnkCmOkJIVJK75KA==
X-Received: by 2002:a17:903:384b:b0:260:df70:f753 with SMTP id
 d9443c01a7336-27ed4a7eadamr94524205ad.38.1758909792812; 
 Fri, 26 Sep 2025 11:03:12 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/23] drm/amd/display: Implement DCE analog stream encoders
Date: Fri, 26 Sep 2025 20:01:51 +0200
Message-ID: <20250926180203.16690-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
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

Add analog stream encoders for DCE which will be used when
connecting an analog display through VGA or DVI-I.

Considering that all stream encoder functions currently deal
with digital streams, there is nothing for an analog stream
encoder to do, making them basically a no-op.
That being said, we still need some kind of stream encoder to
represent an analog stream, and it is beneficial to split them
from digital stream encoders in the code to make sure they
don't accidentally write any DIG* registers.

On supported chips there is currently up to 1 analog encoder,
which is DACA. There are references to DACB in some code such
as VBIOS commands and register files but it seems to be
not present on DCE 6 and newer.

Set num_analog_stream_encoder = 1 so that we can support
the analog connectors on DCE 6-10, for now.

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
index fa3e5ab8ebb8..54803fb7da67 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -375,6 +375,7 @@ static const struct bios_registers bios_regs = {
 static const struct resource_caps res_cap = {
 	.num_timing_generator = 6,
 	.num_audio = 6,
+	.num_analog_stream_encoder = 1,
 	.num_stream_encoder = 6,
 	.num_pll = 3,
 	.num_ddc = 6,
@@ -484,6 +485,11 @@ static struct stream_encoder *dce100_stream_encoder_create(
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
index 53c67ebe779f..8862365d3082 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -373,6 +373,7 @@ static const struct bios_registers bios_regs = {
 static const struct resource_caps res_cap = {
 		.num_timing_generator = 6,
 		.num_audio = 6,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 6,
 		.num_pll = 3,
 		.num_ddc = 6,
@@ -382,6 +383,7 @@ static const struct resource_caps res_cap_61 = {
 		.num_timing_generator = 4,
 		.num_audio = 6,
 		.num_stream_encoder = 6,
+		.num_analog_stream_encoder = 1,
 		.num_pll = 3,
 		.num_ddc = 6,
 };
@@ -389,6 +391,7 @@ static const struct resource_caps res_cap_61 = {
 static const struct resource_caps res_cap_64 = {
 		.num_timing_generator = 2,
 		.num_audio = 2,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 2,
 		.num_pll = 3,
 		.num_ddc = 2,
@@ -599,6 +602,11 @@ static struct stream_encoder *dce60_stream_encoder_create(
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
index 5b7769745202..7091e69cbe98 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -375,6 +375,7 @@ static const struct bios_registers bios_regs = {
 static const struct resource_caps res_cap = {
 		.num_timing_generator = 6,
 		.num_audio = 6,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 6,
 		.num_pll = 3,
 		.num_ddc = 6,
@@ -383,6 +384,7 @@ static const struct resource_caps res_cap = {
 static const struct resource_caps res_cap_81 = {
 		.num_timing_generator = 4,
 		.num_audio = 7,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 7,
 		.num_pll = 3,
 		.num_ddc = 6,
@@ -391,6 +393,7 @@ static const struct resource_caps res_cap_81 = {
 static const struct resource_caps res_cap_83 = {
 		.num_timing_generator = 2,
 		.num_audio = 6,
+		.num_analog_stream_encoder = 1,
 		.num_stream_encoder = 6,
 		.num_pll = 2,
 		.num_ddc = 2,
@@ -605,6 +608,11 @@ static struct stream_encoder *dce80_stream_encoder_create(
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
2.51.0

