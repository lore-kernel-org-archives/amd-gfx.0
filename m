Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74A4CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860D110EABF;
	Fri, 26 Sep 2025 18:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQyO2p37";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4E110EABF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:08 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-27d3540a43fso27888125ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909788; x=1759514588; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hv6pEEXVDEjMS4vphx734aQxg2cKQP++hW1VLet8z+s=;
 b=cQyO2p37ycxprKiZydDJlAe1nhmuMM9Fu08ji19PjFDIlDCChfPGj2Ko8UM0bfANXt
 t5403L6sCg2LoVpidpTpYYHBfsPDj1QTkxhJpk3T+qXQcT/78P+3uVsuWaiCAizYSe5z
 wfM39off+b1qQPnT8mBrFF329YMohUrFP4rXV+YTqFLIDxU83U2bvFKk9so5pYYcY5Mv
 VdhjIWtLieN7Jqxok24ofzyuLpQYnr76QnzVKCogxbVfDKN5/XlBY0JTBxxwhQToYS7E
 hYcfX0FHGq7yOcjCTZKgJeIoin3R6/3Fgy+eQDaQoQCNAtDpzEJz8gKpGtulnhuUeClW
 W9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909788; x=1759514588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hv6pEEXVDEjMS4vphx734aQxg2cKQP++hW1VLet8z+s=;
 b=ZclH/flebu2oBmHx119UhYoComLNQ3iumJG66+Gq5FkhJ6lB981a9wNP2Lr2me1a3+
 JlUhDWAHrzlSIpBm7XXbRpqaH/Aq8132YKfkL5m0kNFAs3z7pI02GnnwNSnw2NEZzqQm
 2xR9ZfGoQyS9uLzZ7Z2NnuQmnIidZ1BFfbTxDUj86KEivwHinm07Fs6yG3EzrcH9gRBe
 6OOqwm0jgiFhyYZXD4IEP/a0Gp8KnWuvKndapAjC4HqGugHXX4zTZHqBsifkWcynSPT+
 F2MsxAIQMLnYUX51DSH8uKny2cactZAiKCQ4hXpCt1gKhKSA5ivAG9L/nn7SLyuFqeMt
 G6+Q==
X-Gm-Message-State: AOJu0YxeYvrcr3dcf1YSGzvKppXVZyZ77FJrTDWNdJkt9Sno6HfY6Wak
 D3iprorZSi4wCkbfzhz1ABQhkzHqqPHUgx9kZG1gS2OuX9wStLPR2Enr9yIugA==
X-Gm-Gg: ASbGnct+bFkDCfjGK2plESvMNjP0lHDimdX79Xybr2KxviDSr/6Nrl+s2ADP8vlHIdI
 tSpPOW6VBRvHI+wCt1jEDvshXKWurUl5R5k9sDemBV0quhR0bEr/ldU4pjOBhtbuxyq8XpNEtZX
 WkoBDu0lqhCk0oZdLH31tJ/Dhsi6xbJhIFKMEh2KzI7OALw9bbXFaVSWMdRXm9d07CZDjy8S6oA
 iwHzAtFekRFkznzvhU3Tl71blYDF03vCSlKSYiVTvxzSc9KOsjXRqjDQD5t+IPAo7hgcFCuqTwr
 ldVFXu2xFMkzOiTnBni0bn+b9qMHD4rLEQ9XJZWDGHiufNeuo+1A7m8TQAWL53NVXfZ9cVeDpN6
 9yfeCKGEeqyWbSc6Nr/1SZ0/vx4+QcWsoPWH6OOceUqi39KpDo78CuyihbfPludLTkpl6IbpBks
 Rj9Sopap22NZV5EuNFG1U=
X-Google-Smtp-Source: AGHT+IFJ6sTNYR70At1qz+1tv6HGQ2kyO8ritx1OqIfROC05XIQ+Ha/X1fT94v2uNeT/Af6fyFfSQg==
X-Received: by 2002:a17:903:b47:b0:267:bd8d:1b1 with SMTP id
 d9443c01a7336-27ed4a934b8mr75276315ad.50.1758909787987; 
 Fri, 26 Sep 2025 11:03:07 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:07 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/23] drm/amd/display: Add concept of analog encoders (v2)
Date: Fri, 26 Sep 2025 20:01:50 +0200
Message-ID: <20250926180203.16690-11-timur.kristof@gmail.com>
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

Add a num_analog_stream_encoders field to indicate how many
analog stream encoders are present. When analog stream encoders
are present, create them.

Additionally, add an analog_engine field to link encoders and
search for supported analog encoders in the BIOS for each link.
When connecting an RGB signal, search for analog stream encoders.

The actual DCE analog link and stream encoder is going to be
added in a subsequent commit.

v2:
Add check to see if an analog engine is really supported.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 +++++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  1 +
 .../drm/amd/display/dc/link/link_factory.c    | 36 ++++++++++++++++++-
 .../dc/resource/dce100/dce100_resource.c      |  7 ++--
 5 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index bc5dedf5f60c..92eed44064f3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -446,6 +446,14 @@ bool resource_construct(
 				DC_ERR("DC: failed to create stream_encoder!\n");
 			pool->stream_enc_count++;
 		}
+
+		for (i = 0; i < caps->num_analog_stream_encoder; i++) {
+			pool->stream_enc[caps->num_stream_encoder + i] =
+				create_funcs->create_stream_encoder(ENGINE_ID_DACA + i, ctx);
+			if (pool->stream_enc[caps->num_stream_encoder + i] == NULL)
+				DC_ERR("DC: failed to create analog stream_encoder %d!\n", i);
+			pool->stream_enc_count++;
+		}
 	}
 
 	pool->hpo_dp_stream_enc_count = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 08c16ba52a51..df512920a9fa 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -47,6 +47,7 @@ struct encoder_init_data {
 	enum hpd_source_id hpd_source;
 	/* TODO: in DAL2, here was pointer to EventManagerInterface */
 	struct graphics_object_id encoder;
+	enum engine_id analog_engine;
 	struct dc_context *ctx;
 	enum transmitter transmitter;
 };
@@ -83,6 +84,7 @@ struct link_encoder {
 	struct graphics_object_id connector;
 	uint32_t output_signals;
 	enum engine_id preferred_engine;
+	enum engine_id analog_engine;
 	struct encoder_feature_support features;
 	enum transmitter transmitter;
 	enum hpd_source_id hpd_source;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 4e26a16a8743..79746d931471 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -49,6 +49,7 @@ struct resource_caps {
 	int num_video_plane;
 	int num_audio;
 	int num_stream_encoder;
+	int num_analog_stream_encoder;
 	int num_pll;
 	int num_dwb;
 	int num_ddc;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index dd636a994bd6..4dbe88d17a11 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -451,6 +451,32 @@ static enum channel_id get_ddc_line(struct dc_link *link)
 	return channel;
 }
 
+static enum engine_id find_analog_engine(struct dc_link *link)
+{
+	struct dc_bios *bp = link->ctx->dc_bios;
+	struct graphics_object_id encoder = {0};
+	enum bp_result bp_result = BP_RESULT_OK;
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		bp_result = bp->funcs->get_src_obj(bp, link->link_id, i, &encoder);
+
+		if (bp_result != BP_RESULT_OK)
+			return ENGINE_ID_UNKNOWN;
+
+		switch (encoder.id) {
+		case ENCODER_ID_INTERNAL_DAC1:
+		case ENCODER_ID_INTERNAL_KLDSCP_DAC1:
+			return ENGINE_ID_DACA;
+		case ENCODER_ID_INTERNAL_DAC2:
+		case ENCODER_ID_INTERNAL_KLDSCP_DAC2:
+			return ENGINE_ID_DACB;
+		}
+	}
+
+	return ENGINE_ID_UNKNOWN;
+}
+
 static bool transmitter_supported(const enum transmitter transmitter)
 {
 	return transmitter != TRANSMITTER_UNKNOWN &&
@@ -459,6 +485,12 @@ static bool transmitter_supported(const enum transmitter transmitter)
 		transmitter != TRANSMITTER_TRAVIS_LCD;
 }
 
+static bool analog_engine_supported(const enum engine_id engine_id)
+{
+	return engine_id == ENGINE_ID_DACA ||
+		engine_id == ENGINE_ID_DACB;
+}
+
 static bool construct_phy(struct dc_link *link,
 			      const struct link_init_data *init_params)
 {
@@ -495,8 +527,10 @@ static bool construct_phy(struct dc_link *link,
 	 */
 	bp_funcs->get_src_obj(bios, link->link_id, 0, &enc_init_data.encoder);
 	enc_init_data.transmitter = translate_encoder_to_transmitter(enc_init_data.encoder);
+	enc_init_data.analog_engine = find_analog_engine(link);
 
-	if (!transmitter_supported(enc_init_data.transmitter)) {
+	if (!transmitter_supported(enc_init_data.transmitter) &&
+		!analog_engine_supported(enc_init_data.analog_engine)) {
 		DC_LOG_WARNING("link_id %d has unsupported encoder\n", link->link_id.id);
 		return false;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index c4b4dc3ad8c9..fa3e5ab8ebb8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -952,6 +952,10 @@ struct stream_encoder *dce100_find_first_free_match_stream_enc_for_link(
 	int i;
 	int j = -1;
 	struct dc_link *link = stream->link;
+	enum engine_id preferred_engine = link->link_enc->preferred_engine;
+
+	if (dc_is_rgb_signal(stream->signal))
+		preferred_engine = link->link_enc->analog_engine;
 
 	for (i = 0; i < pool->stream_enc_count; i++) {
 		if (!res_ctx->is_stream_enc_acquired[i] &&
@@ -960,8 +964,7 @@ struct stream_encoder *dce100_find_first_free_match_stream_enc_for_link(
 			 * in daisy chain use case
 			 */
 			j = i;
-			if (pool->stream_enc[i]->id ==
-					link->link_enc->preferred_engine)
+			if (pool->stream_enc[i]->id == preferred_engine)
 				return pool->stream_enc[i];
 		}
 	}
-- 
2.51.0

