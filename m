Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71217E73158
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 11:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084C410E451;
	Mon,  2 Feb 2026 11:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g1Dat1NA";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F3910E441
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 11:25:17 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43596062728so3294463f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770031516; x=1770636316; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYBTq4ygNvgyVHqV1UgNayEsHeq1QO9pismKPYwRips=;
 b=g1Dat1NAIqfqJS01Yb0phxDgnplcXZIy1bzAeYMs08so/j9AacfvFP2axf5LXbDQ/Y
 KP8v9hM/czGrqpc/EbOCWNbgV9arXZjw7H4uXbi9EAZ1wJ4AxXoxkMWqbh2YAB6mHU11
 LEfn+jPOYIHXq0tTiSYpff7eUGQuR2/147Kf53daCQVHwPT05LRCRK/k2l4yuBYONpzd
 QWYzjz4Vp137aERJD173TFvXmpzxguGwIf+vKfn0H9bbhcuqCOJ/j2VCRLSKjRVjAxF4
 igZ6pdiRNIq/pY6Wh6OguSZqJzf4ykUDew23JNSKig4Ql190Wv6icpAST/8YijZnxvrQ
 5zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031516; x=1770636316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oYBTq4ygNvgyVHqV1UgNayEsHeq1QO9pismKPYwRips=;
 b=BsBtNxw+9pkdihgXhd4jylVj+frS/Rv7VfXDSMOepMC5jnjsA5qBAXfq7OWk3jy7qk
 IebQYaQPvCIQBfQNEOftmPcf40FTGOtafRKNIQUixN6proNirz2EjeUBeJWcOVxn9s3g
 bwJ8+0bFdRF8A3FDNu5sdzioliZevc4bsVLtx4ZEw/Gg0nuk1uYjXNtpSOVeuzVI8Qgi
 luQFvxlPhk7OHmtNeaJBm7GdmxRjG9SxaH0kiFBh+bRWa4Secqh/8IaG1bA0w4u8V1he
 M2V/0OodKXDlSVnWYze4eqFh8bNGl158sl+6BuD2cODJ9dDtQal2LN9BntHTGItmCrSM
 rTnA==
X-Gm-Message-State: AOJu0YyAd5zWIHT7WpPAZSPF20KbgyWrDg0mybeJoPPDpJfmS4eCr953
 mpETlJ1UXzw/XElp3tvVGSTl0unqI5bpqHhUZ2OGUq7JjDIyvjqrijunJ0os2t0l
X-Gm-Gg: AZuq6aIpfHPkZh83r41xQ9Hmuuz+583IEGJp2P59y0fyT/oYAhh+CSuTHFNc/8Av7oN
 ERDitKmtLmdnq3iyJ1wLxwXGw/PKi86V55G0kpZGxtfGuCFX1I9UAahClekAqL7SDqLCm6r7p+6
 SZZ1E2D6p/wNsJg4fi1qcyJKy6bfz6XAO029Z4BB9eOpme86w55pe6HHsuZC/NfpLirdxEmxU0m
 nKh4AmLi2QrYJ2ka3ZLdyhr2xYBp3Lqi15NHBP16JkNX86BFD4Tx5NhxoZBFoaRqwfmRGMMJNdo
 +xJ0h+1ViqvdD3cZ09Emrbe4mWT6pI7ZeXW9zJAN6K6LdbtXzp5APYikYwlp7DpKaD4QnJ+f2nz
 fH7CsuCQJavtaajQcbVyjNZOnUg2CnG9ZCjMLFXH11BPjLqakEe6EOlPnTcmx5+l8xMq/+pkyCV
 jTzVbNs2k0YqxW
X-Received: by 2002:a05:6000:2910:b0:435:dbbb:4516 with SMTP id
 ffacd0b85a97d-435f42fdccfmr17046865f8f.29.1770031515681; 
 Mon, 02 Feb 2026 03:25:15 -0800 (PST)
Received: from Timur-Max ([109.137.72.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm43306225f8f.7.2026.02.02.03.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:25:15 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 siqueira@igalia.com, Mauro Rossi <issor.oruam@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/8] drm/amd/display: Initialize DAC in DCE link encoder using
 VBIOS
Date: Mon,  2 Feb 2026 12:25:05 +0100
Message-ID: <20260202112508.43000-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202112508.43000-1-timur.kristof@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
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

The VBIOS DAC1EncoderControl() function can initialize the DAC,
by writing board-specific values to certain registers.
Call this at link encoder hardware initialization time similarly
to how the equivalent UNIPHYTransmitterControl initialization
is done.

This fixes DAC output on the Radeon HD 7790.

Also remove the ENCODER_CONTROL_SETUP enum from the
dac_encoder_control_prepare_params function which is actually
not a supported operation for DAC encoders.

Fixes: 0fbe321a93ce ("drm/amd/display: Implement DCE analog link encoders (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Mauro Rossi <issor.oruam@gmail.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c   |  3 +--
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 76a3559f0ddc..b692fa37402d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1874,8 +1874,7 @@ static void dac_encoder_control_prepare_params(
 	uint8_t dac_standard)
 {
 	params->ucDacStandard = dac_standard;
-	if (action == ENCODER_CONTROL_SETUP ||
-	    action == ENCODER_CONTROL_INIT)
+	if (action == ENCODER_CONTROL_INIT)
 		params->ucAction = ATOM_ENCODER_INIT;
 	else if (action == ENCODER_CONTROL_ENABLE)
 		params->ucAction = ATOM_ENABLE;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index f8fcf8d1a4dd..8903bdb89c66 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1036,6 +1036,16 @@ void dce110_link_encoder_hw_init(
 	cntl.coherent = false;
 	cntl.hpd_sel = enc110->base.hpd_source;
 
+	if (enc110->base.analog_engine != ENGINE_ID_UNKNOWN) {
+		result = link_dac_encoder_control(enc110, ENCODER_CONTROL_INIT, 0);
+		if (result != BP_RESULT_OK) {
+			DC_LOG_ERROR("%s: Failed to execute VBIOS command table for DAC!\n",
+				__func__);
+			BREAK_TO_DEBUGGER();
+			return;
+		}
+	}
+
 	/* The code below is only applicable to encoders with a digital transmitter. */
 	if (enc110->base.transmitter == TRANSMITTER_UNKNOWN)
 		return;
-- 
2.52.0

