Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F58C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 06:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB2110E2CB;
	Thu,  6 Aug 2026 06:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y5wo6fhL";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51B510EE06
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 11:53:20 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2caea3f742bso13020305ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785930800; x=1786535600; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=32/MyCLxSPjHxN0a7cFyQtbQ+L/vDhhlT6dq9IMr3G8=;
 b=Y5wo6fhLZg7422D/GFSuYRGIGtLOiQE+7BtTWmOghaYu581e9K2kP0E29f3cYDtuzN
 CRGz/PGvWNUNNFkRLqm4EJXl4OOeDF+nLLzsfVMNz99AZfbcjzGmmlOYJDu4eYe2WTT2
 2e2MPn76hi7434G/g5VbwN5mnnkLvMX60Ra0omn7Y6ZzUkhtvj49pmtLmG5gxI6N3PeH
 1aT2wXVG+c154V9ROmdGiFMac89ZP3PxF5sewmOcFUX+TtQco5JflhZdCsxtHE8ttKfn
 85zR0UvX6kTet52FbBZnsucIvyH1SBcU6gM6j7SSAjFYpskGRZ7xmf4KgQDhx5K+UrdC
 0Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785930800; x=1786535600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=32/MyCLxSPjHxN0a7cFyQtbQ+L/vDhhlT6dq9IMr3G8=;
 b=FS/jkb3rItG441QXtyku6hQaU/MORPV+2yKays7i2cNYh5ND2wrCFMLdBm5kgv/xiX
 bV2JvjnwStV92VKXTC99ssdfFUpPsQpvTih23XfpX1Zs/hs0xpSAMS1S83Bk4Bkpz+zI
 msL8IFKtg2PzQ7tbpA+q62kUbiuBu8oXmdD5onBpe09KqTXzDig2GgF+eZuYY+y3cQzB
 3Jxf6HQH7eRR7Xlm2JZ2/OZVHC8Tlg2zGbFMQRJUvWwaYISsdaKs3XrvNbtlT80V8fnn
 HT5vIwauEYoKz7dsxbomAE7dj+W38rE3mooe7kS45U7TQz4oMkePJ8mu3jXFkQl++uva
 ekPw==
X-Gm-Message-State: AOJu0YzABH7dPVqwgvYX0fy9fmw6beeiH0Sww4H8RBjOQNaWKr5LTcBV
 8xcdCmEKKHWIUbsvl3uXMpFcepXO1F+U+0Eq+GMQcaMEwXdksIpCYKdqKFrgUAJtJn8=
X-Gm-Gg: AR+sD10qfwkrqcVl8Tz4tLi69dYsJVDDjpCFqV56z/2V6qn6yYTrg4X2iBlvf+7gJwG
 rUjF25SuahWedPpaatyk8I/PxHhsVs9W6zk4ijbmuxWXNTHNgjlQjE4UoxVFbFf7ex91kwES6KX
 zFf4xrgO1wxf+XyW6WXGV0GlSx5MqOtFqcQ9D4v3GiZsN/D54/1z+BpyMDxrgbhNMYDOr/mjEPF
 uCALGK+/aV+xem12tSBHft2lJ45F0U/jbBrQccumJQtJ8Ml1GHU1xzT/XgJC+UwabbgmCLolqyy
 hw14bqo2l3OSPo18U33hrqo8FrbpD9ArEsDbkDPpvyRVVENW3rOflZF+kNC9raR517041ND+pfF
 8rshwLNOe2e2pDMBO5SGUzMYWEHpdcc+z4JNv/mkT1sOZaBtMaSmnqXyx/wAGNMmPrxU4Fy1ODA
 VoWss9xVK0LenFHgZe/rkDJykvPKsHhT1hva0fu09NjyzsK9HEf70bHKtzF2rhNkxlktlkIQ9bf
 3JV9xPp2d0HEHVSIgVjDHb9
X-Received: by 2002:a17:90b:4b84:b0:38e:8021:2ea9 with SMTP id
 98e67ed59e1d1-3903c5f6482mr5663535a91.19.1785930800091; 
 Wed, 05 Aug 2026 04:53:20 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38febfdae56sm4667245a91.2.2026.08.05.04.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:53:19 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 someguy@effective-light.com, David Weber <weber.aulendorf@gmail.com>
Subject: [RFC PATCH 1/5] drm/amd/display: avoid nested retries when polling
 PSR state
Date: Wed,  5 Aug 2026 13:52:44 +0200
Message-ID: <e11c4306ee52489d3f8d4a70d7e35968163bf59d.1785929873.git.weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785929873.git.weber.aulendorf@gmail.com>
References: <cover.1785929873.git.weber.aulendorf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:55:47 +0000
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

dmub_psr_get_state() retries a PSR state query up to 1001 times when a
GPINT command times out.  Each GPINT transaction busy-waits for up to
30 us.

The retry is nested under transition polling in two live paths.
dmub_psr_enable(wait=true) polls the state directly, including from the
HPD RX recovery path.  The Linux power module has a separate transition
loop after issuing the enable command without waiting for the final PSR
state.

In the worst case, each of the 1001 outer iterations performs 1001
state-query attempts.  This turns a nominal 500 ms transition timeout
into roughly 30 seconds of CPU busy-wait.  PSR error recovery can perform
the wait twice, first while disabling and then while enabling PSR.

Make dmub_psr_get_state() perform one GPINT transaction and return
whether a valid state was obtained.  Leave retry policy to the callers,
including a local retry in dmub_psr_set_level().  The explicit 500 us
delays and up-to-30 us GPINT reply waits total about 530 ms; DMUB wake
and command-processing overhead is additional.

Return the DMUB command status for callers that do not wait for the
final PSR state, and continue to use the observed firmware state as the
final authority for synchronous transitions.  Use a
'< PSR_STATE_MAX_RETRIES' loop and a separate success flag so a
successful final attempt cannot still be reported as a timeout.  Log
command completion, valid state-query counts, and the last observed PSR
state when bounded transition polling expires.

Make edp_get_psr_state() return false when neither the DMUB nor DMCU
backend handles the query.  This prevents callers from treating an
untouched output state as a valid firmware reply.

On a Phoenix (DCN 3.1.4) system, I observed the inner retry exhaust its
limit after DMCUB errors, followed by flip_done and commit-wait timeouts.

Fixes: 04f3c88f0955 ("drm/amd/display: Retry getting PSR state if command times out")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 115 ++++++++++--------
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   8 +-
 .../link/protocols/link_edp_panel_control.c   |   4 +-
 3 files changed, 74 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 45630c3effe1..d16bfd328cbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -29,9 +29,12 @@
 #include "dmub/dmub_srv.h"
 #include "core_types.h"
 
+#define DC_LOGGER dmub->ctx->logger
 #define DC_TRACE_LEVEL_MESSAGE(...)	do {} while (0) /* do nothing */
 
 #define MAX_PIPES 6
+#define PSR_STATE_MAX_RETRIES 1000
+#define PSR_STATE_RETRY_DELAY_US 500
 
 static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
 static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
@@ -105,33 +108,26 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
 /*
  * Get PSR state from firmware.
  */
-static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state, uint8_t panel_inst)
+static bool dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state, uint8_t panel_inst)
 {
 	uint32_t raw_state = 0;
-	uint32_t retry_count = 0;
-
-	do {
-		// Send gpint command and wait for ack
-		if (dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__GET_PSR_STATE, panel_inst, &raw_state,
-					      DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
-			*state = convert_psr_state(raw_state);
-		} else {
-			// Return invalid state when GPINT times out
-			*state = PSR_STATE_INVALID;
-		}
-	} while (++retry_count <= 1000 && *state == PSR_STATE_INVALID);
 
-	// Assert if max retry hit
-	if (retry_count >= 1000 && *state == PSR_STATE_INVALID) {
-		ASSERT(0);
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
-				WPP_BIT_FLAG_Firmware_PsrState,
-				"Unable to get PSR state from FW.");
-	} else
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
-				WPP_BIT_FLAG_Firmware_PsrState,
-				"Got PSR state from FW. PSR state: %d, Retry count: %d",
-				*state, retry_count);
+	/* The caller owns any retry policy and its total timeout. */
+	if (!dc_wake_and_execute_gpint(dmub->ctx,
+				       DMUB_GPINT__GET_PSR_STATE, panel_inst,
+				       &raw_state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
+		*state = PSR_STATE_INVALID;
+		return false;
+	}
+
+	*state = convert_psr_state(raw_state);
+
+	DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
+			       WPP_BIT_FLAG_Firmware_PsrState,
+			       "Got PSR state from FW. PSR state: %d",
+			       *state);
+
+	return *state != PSR_STATE_INVALID;
 }
 
 /*
@@ -176,12 +172,15 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 /*
  * Enable/Disable PSR.
  */
-static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait, uint8_t panel_inst)
+static bool dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait, uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 	uint32_t retry_count;
-	enum dc_psr_state state = PSR_STATE0;
+	u32 valid_query_count = 0;
+	enum dc_psr_state state = PSR_STATE_INVALID;
+	bool command_ok;
+	bool state_reached = false;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.psr_enable.header.type = DMUB_CMD__PSR;
@@ -196,32 +195,41 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait, uint8
 
 	cmd.psr_enable.header.payload_bytes = 0; // Send header only
 
-	dc_wake_and_execute_dmub_cmd(dc->dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	command_ok = dc_wake_and_execute_dmub_cmd(dc->dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	if (!wait)
+		return command_ok;
 
-	/* Below loops 1000 x 500us = 500 ms.
-	 *  Exit PSR may need to wait 1-2 frames to power up. Timeout after at
-	 *  least a few frames. Should never hit the max retry assert below.
+	/*
+	 * Must not use fsleep() because this can be called from high IRQ levels.
+	 * Each query may take 30 us, followed by the existing 500 us delay.
+	 * Exit PSR may need 1-2 frames to power up.
 	 */
-	if (wait) {
-		for (retry_count = 0; retry_count <= 1000; retry_count++) {
-			dmub_psr_get_state(dmub, &state, panel_inst);
-
-			if (enable) {
-				if (state != PSR_STATE0)
-					break;
-			} else {
-				if (state == PSR_STATE0)
-					break;
+	for (retry_count = 0; retry_count < PSR_STATE_MAX_RETRIES; retry_count++) {
+		if (!dmub_psr_get_state(dmub, &state, panel_inst)) {
+			udelay(PSR_STATE_RETRY_DELAY_US);
+			continue;
+		}
+		valid_query_count++;
+		if (enable) {
+			if (state != PSR_STATE0) {
+				state_reached = true;
+				break;
 			}
-
-			/* must *not* be fsleep - this can be called from high irq levels */
-			udelay(500);
+		} else if (state == PSR_STATE0) {
+			state_reached = true;
+			break;
 		}
 
-		/* assert if max retry hit */
-		if (retry_count >= 1000)
-			ASSERT(0);
+		udelay(PSR_STATE_RETRY_DELAY_US);
 	}
+
+	if (!state_reached)
+		DC_LOG_ERROR("PSR %s timeout: panel=%u cmd=%d queries=%u state=%d\n",
+			     enable ? "enable" : "disable", panel_inst,
+			     command_ok, valid_query_count, state);
+
+	return state_reached;
 }
 
 /*
@@ -230,10 +238,21 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait, uint8
 static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level, uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
-	enum dc_psr_state state = PSR_STATE0;
+	enum dc_psr_state state = PSR_STATE_INVALID;
 	struct dc_context *dc = dmub->ctx;
+	unsigned int retry_count;
+
+	/* Keep this operation's retry policy local so it cannot be nested by
+	 * transition callers of dmub_psr_get_state().
+	 */
+	for (retry_count = 0; retry_count < PSR_STATE_MAX_RETRIES; retry_count++)
+		if (dmub_psr_get_state(dmub, &state, panel_inst))
+			break;
 
-	dmub_psr_get_state(dmub, &state, panel_inst);
+	if (retry_count == PSR_STATE_MAX_RETRIES) {
+		ASSERT(0);
+		return;
+	}
 
 	if (state == PSR_STATE0)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index a6e282d950c3..e534822fb4d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -39,10 +39,10 @@ struct dmub_psr {
 struct dmub_psr_funcs {
 	bool (*psr_copy_settings)(struct dmub_psr *dmub, struct dc_link *link,
 	struct psr_context *psr_context, uint8_t panel_inst);
-	void (*psr_enable)(struct dmub_psr *dmub, bool enable, bool wait,
-	uint8_t panel_inst);
-	void (*psr_get_state)(struct dmub_psr *dmub, enum dc_psr_state *dc_psr_state,
-	uint8_t panel_inst);
+	bool (*psr_enable)(struct dmub_psr *dmub, bool enable, bool wait,
+			   uint8_t panel_inst);
+	bool (*psr_get_state)(struct dmub_psr *dmub, enum dc_psr_state *dc_psr_state,
+			      uint8_t panel_inst);
 	void (*psr_set_level)(struct dmub_psr *dmub, uint16_t psr_level,
 	uint8_t panel_inst);
 	void (*psr_force_static)(struct dmub_psr *dmub, uint8_t panel_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 80a372ceaa51..4e19ccd836ae 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -637,9 +637,11 @@ bool edp_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
 		return false;
 
 	if (psr != NULL && link->psr_settings.psr_feature_enabled)
-		psr->funcs->psr_get_state(psr, state, (uint8_t)panel_inst);
+		return psr->funcs->psr_get_state(psr, state, (uint8_t)panel_inst);
 	else if (dmcu != NULL && link->psr_settings.psr_feature_enabled)
 		dmcu->funcs->get_psr_state(dmcu, state);
+	else
+		return false;
 
 	return true;
 }
-- 
2.54.0

