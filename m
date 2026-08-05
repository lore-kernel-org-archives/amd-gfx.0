Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAEAC5620A
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 06:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6FB10F0EC;
	Thu,  6 Aug 2026 06:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="diEI7OXs";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D8B10EE06
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 11:53:23 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so13315075ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785930803; x=1786535603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hGrIHHFZc3O4BLh97JVYJjWKQ/RG7ekA4G5KzSuc8ek=;
 b=diEI7OXsBtmlVYxQ1PFO4RZ+5b1T/tK/0JeNB3jP4DUE+EpMixQWL4MQ3VbmbA8SUU
 lRvCvY0ZJbrM9ZFGq6MmhK4BclgxHv77B/tbDgJ9FiGt81C6BA3XbYjvYAXdhGV0JzbA
 SyQ/t5iVmbwSOiyVA4DG6uUv24qQd8kAQdpqK27BrOyaUDWruqutM2ugjpi0rAEyKsQ7
 cEg4KdB9BQAz7MAYvN4RVMdwr/vKJ7qKgHUcNNqVquMkK19idKGvCJRLetpSJoCXzMuK
 CAxsmGsSR+G8eX0dyVBBxqvCwsy39oee/dz2cCJ8GMAmNHOoGNchO6RMbYKqoAnPMQaZ
 plMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785930803; x=1786535603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hGrIHHFZc3O4BLh97JVYJjWKQ/RG7ekA4G5KzSuc8ek=;
 b=dPUbKRWw9OVvX7oUI1L2b/+BuugeoYOZCC2NoY+egdXF0p+X6hNjHFQq6EytGSjcSe
 KFWnlKG6nxmlKIAGWGF3AUkygSMdlWngH/RVo6zRIg/DipheEdoEWHwc+pew/Rg9wjOb
 i6l2QjM5bq6iYyNlRVgBwlGWD7/Bj+HEbpV6BEmteblD2MSJoCdxAIVO4WuofmpRtmoo
 wk+pRUs9Zz1f9PYFSqzZTq3jpTcABcmxkPAGXZ8lPcgFhv+dDbDoSkIQuq1BPGNA4HkC
 3fKITXVrKOUUJqgbU2YQK55HTVYDSvSNypJysTPBo89mK31duJHjbNToISYG2MiSAZkr
 QVfg==
X-Gm-Message-State: AOJu0Yzx9vvF6+72V3ERSd960fQcjTgAoXMfKEZ56hWZ12D2TGVuz7Hm
 X1hcTzm17hrOiDcxJYkl5cZGE+fjguBQg6eak4BM5xHxfsuYyxdWNFEgNYKIPQT1m5A=
X-Gm-Gg: AR+sD12DKXZZFtCBUw5O2P5Vx9chlGlZbLbdUdipRnhOqFsf+hSlGTIyHKBNbYW9oG5
 iPyQGlqp3PT5GD61Ao9yweWZWQBXG9k/whbn9Nef2sDwUBUvoEd6nuS8RfunOqlqayrVYbKLhT+
 Xqvy5L5ud0kVG4uRTjDubjxPjDz6+Dzi8ZOYcZSnuPOfuTYxrfrkt4QKyqhZQasvtc1fqcZZ24g
 S0HpfyZ5WlwV5m7DHzyYMAYoScQgogxPAavoxGFE1WDJQgUlb5SUnWyoMBBXhs8CAzucUSt7PCV
 LohacoYSWBQ4OJx4aJKoCRQD1xGbrZkgXQnDbm4dsrHw7DHTiQF3p45l4joXLD8XUIQVDwN40Vn
 bekGiyBirA+iXo0WAIcAQnkCrMXtGboBMiTIr3kCUFZXEO7+mCulwf9JsaC8kgc2+yfLKsR/TTq
 hCrFCAe5hul7l9gAYyqiKbnYiBUcMVOVNRXt1sc8yMdk4ngT1wgdRP8wzttHU3XT0KnFm8moDWu
 jzCtoy+NJggUSYzNv0oV7vB
X-Received: by 2002:a17:90b:4ad1:b0:38e:101f:c867 with SMTP id
 98e67ed59e1d1-3903c5ca8cdmr6608781a91.18.1785930803352; 
 Wed, 05 Aug 2026 04:53:23 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38febfdae56sm4667245a91.2.2026.08.05.04.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:53:23 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 someguy@effective-light.com, David Weber <weber.aulendorf@gmail.com>
Subject: [RFC PATCH 2/5] drm/amd/display: retry unconfirmed PSR transitions
Date: Wed,  5 Aug 2026 13:52:45 +0200
Message-ID: <ef310c1c1caf010d5093f0ce9679013fdff9fa70.1785929873.git.weber.aulendorf@gmail.com>
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

The DMUB PSR backend can fail to complete a command or exhaust a
synchronous state transition wait.  Do not treat either outcome as a
successfully programmed allow-active request.

Return transition status through the eDP control layer and update the
cached request only after backend handling succeeds.  Track whether that
cache is usable for request deduplication; a command timeout may still
mean firmware consumed the command, but software cannot safely suppress
the next request.

Move request deduplication into the power module, where both the desired
event policy and the link cache are available.  This also covers direct
power-module callers such as the ABM backlight path.  Skip an unchanged
request only when the power-module state and the valid link request cache
agree.  Otherwise retry the transition and update the power-module cache
only after success.  Remove the now-unused mod_power_get_psr_event()
accessor after moving that decision into the module.

When a subordinate event is blocked by a forced-PSR policy, preserve the
existing result for actual event changes and return success for unchanged
events.  Reissue the dominant policy if the link cache is invalid or the
link and power-module caches disagree.  Dynamic-display-switch and
dynamic-link-rate-control reapply force-static mode, while OS override
hold preserves the currently applied enabled state.

Make the power-module polling loop honor failed state queries and fix its
final-iteration test.  Initialize the request cache conservatively after
setup.

Require a valid allow-active cache when reporting that PSR is allowed.
The idle-detection loop therefore stops instead of re-enabling idle
optimizations based on unknown firmware state.

The HPD RX recovery path now stops if PSR could not be disabled instead
of immediately issuing a re-enable.  If the previous request is unknown,
leave PSR disabled rather than restoring stale cached state.

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  14 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  21 ++-
 .../link/protocols/link_edp_panel_control.c   |  23 ++-
 .../drm/amd/display/modules/inc/mod_power.h   |   4 -
 .../drm/amd/display/modules/power/power_psr.c | 131 ++++++++++--------
 6 files changed, 114 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 0dadc0bb214f..f045612e8b10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -152,7 +152,9 @@ bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm)
 		if (!link)
 			continue;
 
-		if (link->psr_settings.psr_feature_enabled && link->psr_settings.psr_allow_active)
+		if (link->psr_settings.psr_feature_enabled &&
+		    link->psr_settings.psr_allow_active_valid &&
+		    link->psr_settings.psr_allow_active)
 			return true;
 	}
 	return false;
@@ -171,21 +173,11 @@ bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm)
 bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm, struct dc_stream_state *stream,
 		bool set_event, enum psr_event event, bool wait_for_disable)
 {
-	unsigned int psr_events;
-
 	/* Validate all required parameters */
 	if (!stream || !stream->link ||
 		!stream->link->psr_settings.psr_feature_enabled)
 		return false;
 
-	/* Get current psr events */
-	if (!mod_power_get_psr_event(dm->power_module, stream, &psr_events))
-		return false;
-
-	/* If all events already in desired state, return true. */
-	if ((psr_events & event) == (set_event ? event : 0))
-		return true;
-
 	return mod_power_set_psr_event(dm->power_module, stream,
 				       set_event, event, wait_for_disable);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 4ed1efa17270..cd61ff160b93 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1114,7 +1114,8 @@ struct link_mst_stream_allocation_table {
 /* PSR feature flags */
 struct psr_settings {
 	bool psr_feature_enabled;		// PSR is supported by sink
-	bool psr_allow_active;			// PSR is currently active
+	bool psr_allow_active;			// Cached allow-active request
+	bool psr_allow_active_valid;		// Cache is usable for request deduplication
 	enum dc_psr_version psr_version;		// Internal PSR version, determined based on DPCD
 	bool psr_vtotal_control_support;	// Vtotal control is supported by sink
 	unsigned long long psr_dirty_rects_change_timestamp_ns;	// for delay of enabling PSR-SU
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 54ce768ae6ad..bcf9e0ded92c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -156,6 +156,7 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 				psr_error_status.bits.RFB_STORAGE_ERROR ||
 				psr_error_status.bits.VSC_SDP_ERROR) {
 			bool allow_active;
+			bool restore_psr;
 
 			/* Acknowledge and clear error bits */
 			dm_helpers_dp_write_dpcd(
@@ -165,12 +166,24 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 				&psr_error_status.raw,
 				sizeof(psr_error_status.raw));
 
-			/* PSR error, disable and re-enable PSR */
-			if (link->psr_settings.psr_allow_active) {
+			/* Restore PSR only when the enabled request is known. */
+			restore_psr = link->psr_settings.psr_allow_active_valid &&
+				link->psr_settings.psr_allow_active;
+			if (!link->psr_settings.psr_allow_active_valid ||
+			    link->psr_settings.psr_allow_active) {
 				allow_active = false;
-				edp_set_psr_allow_active(link, &allow_active, true, false, NULL);
+				if (!edp_set_psr_allow_active(link, &allow_active,
+							      true, false, NULL)) {
+					DC_LOG_ERROR("Failed to disable PSR after sink error\n");
+					return true;
+				}
+				if (!restore_psr)
+					return true;
+
 				allow_active = true;
-				edp_set_psr_allow_active(link, &allow_active, true, false, NULL);
+				if (!edp_set_psr_allow_active(link, &allow_active,
+							      true, false, NULL))
+					DC_LOG_ERROR("Failed to restore PSR after sink error\n");
 			}
 
 			return true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 4e19ccd836ae..f7001f01f960 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -609,19 +609,31 @@ bool edp_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
 		psr->funcs->psr_force_static(psr, (uint8_t)panel_inst);
 
 	/* Enable or Disable PSR */
-	if (allow_active && link->psr_settings.psr_allow_active != *allow_active) {
-		link->psr_settings.psr_allow_active = *allow_active;
+	if (allow_active &&
+	    (!link->psr_settings.psr_allow_active_valid ||
+	     link->psr_settings.psr_allow_active != *allow_active)) {
+		bool programmed = true;
 
-		if (!link->psr_settings.psr_allow_active)
+		if (!*allow_active)
 			dc_z10_restore(dc);
 
 		if (psr != NULL && link->psr_settings.psr_feature_enabled)
-			psr->funcs->psr_enable(psr, link->psr_settings.psr_allow_active, wait, (uint8_t)panel_inst);
+			programmed = psr->funcs->psr_enable(psr, *allow_active,
+							 wait, (uint8_t)panel_inst);
 		else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) &&
 			link->psr_settings.psr_feature_enabled)
-			dmcu->funcs->set_psr_enable(dmcu, link->psr_settings.psr_allow_active, wait);
+			dmcu->funcs->set_psr_enable(dmcu, *allow_active, wait);
 		else
 			return false;
+
+		if (!programmed) {
+			/* The command may have succeeded, but its state is unknown. */
+			link->psr_settings.psr_allow_active_valid = false;
+			return false;
+		}
+
+		link->psr_settings.psr_allow_active = *allow_active;
+		link->psr_settings.psr_allow_active_valid = true;
 	}
 	return true;
 }
@@ -896,6 +908,7 @@ bool edp_setup_psr(struct dc_link *link,
 	} else {
 		link->psr_settings.psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
 	}
+	link->psr_settings.psr_allow_active_valid = false;
 
 	/* psr_enabled == 0 indicates setup_psr did not succeed, but this
 	 * should not happen since firmware should be running at this point
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
index f9814cf7bbdb..893fcd04a197 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
@@ -333,10 +333,6 @@ bool mod_power_set_psr_event(struct mod_power *mod_power,
 		struct dc_stream_state *stream, bool set_event,
 		enum psr_event event, bool wait);
 
-bool mod_power_get_psr_event(struct mod_power *mod_power,
-			struct dc_stream_state *stream,
-			unsigned int *active_psr_events);
-
 bool mod_power_get_psr_state(struct mod_power *mod_power,
 		const struct dc_stream_state *stream,
 		enum dc_psr_state *state);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_psr.c b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
index 5ecb570c204e..7ef53966c9e4 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_psr.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
@@ -151,6 +151,7 @@ static bool set_psr_enable(struct mod_power *mod_power,
 	unsigned int retry_count;
 	const unsigned int max_retry = 1000;
 	struct dc_link *link = NULL;
+	bool state_reached = false;
 
 	if (mod_power == NULL)
 		return false;
@@ -213,15 +214,18 @@ static bool set_psr_enable(struct mod_power *mod_power,
 							"set psr enable: BEGIN WAIT: psr_enable=%d",
 							(int)psr_enable);
 
-		for (retry_count = 0; retry_count <= max_retry; retry_count++) {
-			dc_link_get_psr_state(link, &state);
-			if (psr_enable) {
-				if (state != PSR_STATE0 &&
-						(!force_static || state == PSR_STATE3))
-					break;
-			} else {
-				if (state == PSR_STATE0)
+		for (retry_count = 0; retry_count < max_retry; retry_count++) {
+			if (dc_link_get_psr_state(link, &state)) {
+				if (psr_enable) {
+					if (state != PSR_STATE0 &&
+					    (!force_static || state == PSR_STATE3)) {
+						state_reached = true;
+						break;
+					}
+				} else if (state == PSR_STATE0) {
+					state_reached = true;
 					break;
+				}
 			}
 			udelay(500);
 		}
@@ -231,13 +235,11 @@ static bool set_psr_enable(struct mod_power *mod_power,
 							"set psr enable: END WAIT: psr_enable=%d",
 							(int)psr_enable);
 
-		/* assert if max retry hit */
-		if (retry_count >= max_retry) {
+		if (!state_reached) {
 			ASSERT(0);
-			DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
-								WPP_BIT_FLAG_Firmware_PsrState,
-								"set psr enable: ERROR: retry_count=%u: Unexpectedly long wait for PSR state change.",
-								retry_count);
+			/* The command may have succeeded even though its state is unknown. */
+			link->psr_settings.psr_allow_active_valid = false;
+			return false;
 		}
 	} else {
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
@@ -249,38 +251,16 @@ static bool set_psr_enable(struct mod_power *mod_power,
 	return true;
 }
 
-bool mod_power_get_psr_event(struct mod_power *mod_power,
-			struct dc_stream_state *stream,
-			unsigned int *active_psr_events)
-{
-	struct core_power *core_power = NULL;
-	unsigned int stream_index = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power->num_entities == 0)
-		return false;
-
-	stream_index = map_index_from_stream(core_power, stream);
-
-	if (!core_power->map[stream_index].caps->psr_version)
-		return false;
-
-	*active_psr_events = core_power->map[stream_index].psr_events;
-
-	return true;
-}
-
 bool mod_power_set_psr_event(struct mod_power *mod_power,
 		struct dc_stream_state *stream, bool set_event,
 		enum psr_event event, bool wait)
 {
 	struct core_power *core_power = NULL;
+	struct dc_link *link = NULL;
 	unsigned int stream_index = 0;
 	unsigned int active_psr_events = 0;
+	bool event_changed;
+	bool forced_subordinate_event;
 	bool psr_enable_request = false;
 	bool force_static = false;
 
@@ -303,6 +283,12 @@ bool mod_power_set_psr_event(struct mod_power *mod_power,
 	if (!core_power->map[stream_index].caps->psr_version)
 		return false;
 
+	link = dc_stream_get_link(stream);
+	if (!link)
+		return false;
+
+	event_changed = (core_power->map[stream_index].psr_events & event) !=
+		(set_event ? event : 0);
 	if (set_event)
 		core_power->map[stream_index].psr_events |= event;
 	else
@@ -310,23 +296,44 @@ bool mod_power_set_psr_event(struct mod_power *mod_power,
 
 	active_psr_events = core_power->map[stream_index].psr_events;
 
-	// ignore other events when we're in forced psr enabled state
-	if (active_psr_events & psr_event_dynamic_display_switch &&
-			event != psr_event_dynamic_display_switch)
-		return false;
+	forced_subordinate_event = false;
 
-	// ignore other events when we're in forced psr enabled state
-	if (active_psr_events & psr_event_os_override_hold &&
-			event != psr_event_os_override_hold)
-		return false;
+	/* OS override hold preserves the currently applied enabled state. */
+	if ((active_psr_events & psr_event_os_override_hold) &&
+	    (event != psr_event_os_override_hold || !event_changed)) {
+		forced_subordinate_event = true;
+		psr_enable_request = core_power->map[stream_index].psr_enabled;
+	} else if ((active_psr_events & psr_event_dynamic_display_switch) &&
+		   event != psr_event_dynamic_display_switch) {
+		forced_subordinate_event = true;
+		psr_enable_request = true;
+		force_static = true;
+	} else if ((active_psr_events & psr_event_dynamic_link_rate_control) &&
+		   event != psr_event_dynamic_link_rate_control &&
+		   event != psr_event_dds_defer_stream_enable &&
+		   event != psr_event_dynamic_display_switch) {
+		forced_subordinate_event = true;
+		psr_enable_request = true;
+		force_static = true;
+	}
 
-	// ignore other events when we're in forced psr enabled state
-	// dds events need to be processed while in dynamic_link_rate_control
-	if (active_psr_events & psr_event_dynamic_link_rate_control &&
-			event != psr_event_dynamic_link_rate_control &&
-			event != psr_event_dds_defer_stream_enable &&
-			event != psr_event_dynamic_display_switch)
-		return false;
+	if (forced_subordinate_event) {
+		if (!link->psr_settings.psr_allow_active_valid ||
+		    core_power->map[stream_index].psr_enabled != psr_enable_request ||
+		    link->psr_settings.psr_allow_active != psr_enable_request) {
+			mod_power_psr_set_power_opt(mod_power, stream,
+						    active_psr_events,
+						    psr_enable_request);
+			if (!set_psr_enable(mod_power, stream, psr_enable_request,
+					    wait, force_static))
+				return false;
+
+			core_power->map[stream_index].psr_enabled =
+				psr_enable_request;
+		}
+
+		return !event_changed;
+	}
 
 	if (active_psr_events & (psr_event_test_harness_disable_psr | psr_event_os_request_disable))
 		psr_enable_request = false;
@@ -361,6 +368,11 @@ bool mod_power_set_psr_event(struct mod_power *mod_power,
 	else
 		psr_enable_request = true;
 
+	if (!event_changed && link->psr_settings.psr_allow_active_valid &&
+	    core_power->map[stream_index].psr_enabled == psr_enable_request &&
+	    link->psr_settings.psr_allow_active == psr_enable_request)
+		return true;
+
 	DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
 						WPP_BIT_FLAG_Firmware_PsrState,
 						"mod_power set_psr_event: before: psr_enabled=%d -> request: set_event=%d event=0x%04x -> result: psr_events=0x%04x psr_enable_request=%d",
@@ -371,9 +383,14 @@ bool mod_power_set_psr_event(struct mod_power *mod_power,
 						(int)psr_enable_request);
 	mod_power_psr_set_power_opt(mod_power, stream, active_psr_events, psr_enable_request);
 
-	if (core_power->map[stream_index].psr_enabled != psr_enable_request || force_static) {
-		if (set_psr_enable(mod_power, stream, psr_enable_request, wait, force_static))
-			core_power->map[stream_index].psr_enabled = psr_enable_request;
+	if (!link->psr_settings.psr_allow_active_valid ||
+	    core_power->map[stream_index].psr_enabled != psr_enable_request ||
+	    link->psr_settings.psr_allow_active != psr_enable_request ||
+	    force_static) {
+		if (!set_psr_enable(mod_power, stream, psr_enable_request, wait, force_static))
+			return false;
+
+		core_power->map[stream_index].psr_enabled = psr_enable_request;
 	}
 
 	return true;
-- 
2.54.0

