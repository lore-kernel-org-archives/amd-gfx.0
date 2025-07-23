Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C959C83F34
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9FB89196;
	Wed, 23 Jul 2025 15:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRQKK0F6";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE4910E80B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:29 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3a528243636so4168148f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286308; x=1753891108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaOjeO/VWAyELTACsW5k0RSkF1IRXRbWIG8hHbwMSBg=;
 b=gRQKK0F6oNPP+uTWSBUofml2tLrUc4BoRzLRsHc/SalSVxy9M3L2JcJhXGzFSVQQoq
 Khkv/mkG552kfJVmat+JqU6GRIhoqnQQPB46zDaXf3qMBGGaI4a5WMuixWIE4j9/3/e6
 6t3Av65NaWG3ctV/+TPBeW+WxksAgZw5joUxRXHoP3MSORyoCPFnQU9GpaJkbo0DeaOl
 2GCgWIrPLGPseb0l7SqbBtrnNaDqRPmMqQLTYXD4PB4gGVHV/rgcZZZwnJnvb9oX/s2y
 WecI30J2wHg+EFqhBIKCsZ9S3OrMFTEbO/sLrW/cpxyzjCpK/l24VeQLmGCDDLAoXxR+
 GMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286308; x=1753891108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaOjeO/VWAyELTACsW5k0RSkF1IRXRbWIG8hHbwMSBg=;
 b=EDQKiNnQBzagXypXXJos4tqzLB7oz5KQztn52yDev8I8rmJoIygbdiz/spUXoh/zj7
 vwoI2QGUC7LumkcWTWxf823njbmUeqJ2ugER3JLVdoFYvhjarkXth55RCKeVYjeYtyGu
 RXsITSx+GThWVVWKvGi1jG6+A2n1jVte3ZTHH2lFFB0wKYEzbWOAdX6sPecgy2uw6/Nr
 2/kwSfb0/jCCzIzmmx9UUqKP5TIvQH8a5TFDZbHN1LSsKoH76HEcU2xjOj3Be9Y4ev3R
 b2dZ0vTZuIE5NyLXqMGoWSWClpjEtuTel+ZdXWEJmKFxAr3Iaxez8gLYVdlWido4YAp6
 EWHw==
X-Gm-Message-State: AOJu0YyeTyt3j2R2J+gLEEsNWUUbE5qSPm2zk7rHEWUMM794VKccGZv0
 rYL1g3lG29Im0kqaudLg+/ebjighHe7kGFTAN8dn0zEnCYFXS1B+UDfe6/RgtA==
X-Gm-Gg: ASbGnctCSblQSoOpfUl1wCvENcXq775eDsWVOuc/EaspMLuGvNzoQZ79L2Zo+LgLwn4
 uqCE4VPBpoKEAFfV+QEOVj6qljeCBy7Y9y4mrDcJ4YzgfOjCb7MyptYAt3vYg4guogDWabESO6a
 vwJ4Xx9JjpIcQxc8RhisPnzgq08+njg/1QoeLfFuNZa10OGgu4UNtdajYD8hZcqKKzyKlVnDHcK
 cG0Tx9LHQ8+MjxtLpKw+kh76StBCxUdK/wMFIvDjhk4Yh9CdSpWspc5C93BZ0OjKz8cNxAockX/
 N56JpWmpH3s6vwh9HxElRED/mUtuOFPedDpx9rdsr/8GpQQTxZh8R+FUlMnWsRLjNT/7vmvZp4F
 l6kDRK60B2tnVks2xos4MKzoB7wSqWNuqqWgcUD+t/hw1lGGonWyT0F+DDQlID9Hav1EJ9HAZlb
 CWQBw76BfEv+ZefyGSTXBHUJQcjA==
X-Google-Smtp-Source: AGHT+IHWFKGfV76eDSnrF9TKUMY57fRVvKikjFfNLEMfFX8fY8Xeh3r78B8mJ57GhGEw9z/XYoy4Zg==
X-Received: by 2002:a05:6000:4285:b0:3a8:38b3:1aa1 with SMTP id
 ffacd0b85a97d-3b768f1ab44mr3019505f8f.27.1753286307455; 
 Wed, 23 Jul 2025 08:58:27 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:27 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/20] drm/amd/display: Add concept of analog encoders
Date: Wed, 23 Jul 2025 17:58:02 +0200
Message-ID: <20250723155813.9101-10-timur.kristof@gmail.com>
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

Add a num_analog_stream_encoders field to indicate how many
analog stream encoders are present. When analog stream encoders
are present, create them.

Additionally, add an analog_engine field to link encoders and
search for supported analog encoders in the BIOS for each link.
When connecting an RGB signal, search for analog stream encoders.

The actual DCE analog stream encoder support is going to be
added in a subsequent commit.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 ++++++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  1 +
 .../drm/amd/display/dc/link/link_factory.c    | 28 +++++++++++++++++++
 .../dc/resource/dce100/dce100_resource.c      |  7 +++--
 5 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 4d6181e7c612..9561d0bd255a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -441,6 +441,14 @@ bool resource_construct(
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
index a890f581f4e8..9a10fbc93e5f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -48,6 +48,7 @@ struct resource_caps {
 	int num_video_plane;
 	int num_audio;
 	int num_stream_encoder;
+	int num_analog_stream_encoder;
 	int num_pll;
 	int num_dwb;
 	int num_ddc;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index de1143dbbd25..71c10a1261b9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -449,6 +449,32 @@ static enum channel_id get_ddc_line(struct dc_link *link)
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
 static bool construct_phy(struct dc_link *link,
 			      const struct link_init_data *init_params)
 {
@@ -461,6 +487,7 @@ static bool construct_phy(struct dc_link *link,
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
 	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
 
+
 	DC_LOGGER_INIT(dc_ctx->logger);
 
 	link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
@@ -614,6 +641,7 @@ static bool construct_phy(struct dc_link *link,
 	enc_init_data.connector = link->link_id;
 	enc_init_data.channel = get_ddc_line(link);
 	enc_init_data.hpd_source = get_hpd_line(link);
+	enc_init_data.analog_engine = find_analog_engine(link);
 
 	link->hpd_src = enc_init_data.hpd_source;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 3a51be63f020..72efb13c9027 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -935,6 +935,10 @@ struct stream_encoder *dce100_find_first_free_match_stream_enc_for_link(
 	int i;
 	int j = -1;
 	struct dc_link *link = stream->link;
+	enum engine_id preferred_engine = link->link_enc->preferred_engine;
+
+	if (dc_is_rgb_signal(stream->signal))
+		preferred_engine = link->link_enc->analog_engine;
 
 	for (i = 0; i < pool->stream_enc_count; i++) {
 		if (!res_ctx->is_stream_enc_acquired[i] &&
@@ -943,8 +947,7 @@ struct stream_encoder *dce100_find_first_free_match_stream_enc_for_link(
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
2.50.1

