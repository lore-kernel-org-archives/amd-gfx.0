Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728FFC56208
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 06:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F6510F0E5;
	Thu,  6 Aug 2026 06:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iCY6Sm5o";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D0610EE06
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 11:53:30 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so839027a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785930810; x=1786535610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y5Vu7gu3U9x4o4TBESLbrZXEZTBtqAY1VCcloTJLgIM=;
 b=iCY6Sm5oU1zJPmaiymh/UcHyWaVuIoBoENGrJpqWfEYqlDuC1tTU1ZhMX52SiIaewC
 o4z/xPiC/5ec/ijDOIOMGqg5a5jzMEpTtCgubPAeSRP+ySdjLLDDcbQJOufl/IfCbJ5M
 2MOiW8KOOodQ/6lQETvaS6Xca3XICXAqL2Jyin+2KYlZumjWeEu47xidETTcN1CSvxRr
 cjjGwsAtq7HxNyvzWyFoKGTY1x06A3kIcvDkboKukul1c3NuxaWZNHo+3j4Zcgg2kF/G
 Dm6/f4108CHsw35b/xMNjpe7S5sSmPnZeaSwN0PrnnumkX+GBXRCRa03wwl17qH7qv8J
 M8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785930810; x=1786535610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y5Vu7gu3U9x4o4TBESLbrZXEZTBtqAY1VCcloTJLgIM=;
 b=RBQ/7zhv6sX4MdYa7uhbzfEAk3vnMs8oT74Pl/9/ZOouD2WFyuVxuzaSNBQoTDc7j5
 Ix5EFTLqCPrs6T/S9vbyPX9PQ8nUr1Geg0mTjIqV6KY3hyMAvs1ArJrILM4aFYCUx31t
 QqqispLPPUgKCK6nEguHcMSzCrcn8e49jwH4UTTDqdlK97c3D7B3k+3UhFeCEC83Q5dv
 SG0v/ff6LfGuE8NPT92HeQVTO78y3ck2e8YVTqANEH0EIdJvAfQaWBK8B/ADbGchIy48
 r7oC8nKXIpMy9Z9EiBI/4DjQu1n7Uz9Nua6+f7BnyFDzSKl/KUC0phJkTaSH399ndTXT
 Sc7w==
X-Gm-Message-State: AOJu0YzRFnP7uT94fXM2leo3LVvthmuXDPiavhSjPlFW6Na779mepl5B
 /ADQGjjcRC1n22RXTh/O4noNj94K2TxgctpuXxZDP+WWUBqEWXAfJDsbitGEQSYqHos=
X-Gm-Gg: AR+sD10FVjMdWp+eNt+Y33jSPDQVwLZR1cWgAmQHvp6YxHoabwujJJ3DYSpRKYo9uLW
 L4NK4+5VnMiWSbV35CKPKHI9xlWFYv3eaMH0AGEJCgefRPB4j9ETFxc2w6d4dT28RlBOUbzTrIq
 hF7srbGDmXl8QXmX+jrMagNoq5iz9XMgeHzzoLg0pPV68vbH08vf51koRHNv8l2Mxl1aqf6i1dk
 ZtwxkwfbSW4p0GMhvyjCGpk1smSAK13G69yr9LCC5P/AfPD+CmDVAO3xqsZh3RcMAy5SqMFAebi
 7428KymTdG69goV75cC+UWOSdoZBqUM4OVGmigBPKUUb1dFoKq8k/lX4LuJEyIAmWnyhRtlQKm8
 AwPrV48wvOsIIgF9MV7h42hzZEDBKRWGNtKFbz6X1M++A6CE4VdwNy0vk+a/cRgVj1EvFGmPkF1
 PYNi1oIEu0M58HybDyeCmIPXfccq1lwJ0hacLujG9NM8N2L74MgJPVwG5JdH7baX52q2INGil11
 tjP3HxWsdt1K5+Yi5lxSUlHNUuFFGrPXE+Q
X-Received: by 2002:a17:90b:528c:b0:380:9f17:6df3 with SMTP id
 98e67ed59e1d1-3903c5448dcmr6687750a91.4.1785930809932; 
 Wed, 05 Aug 2026 04:53:29 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38febfdae56sm4667245a91.2.2026.08.05.04.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:53:29 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 someguy@effective-light.com, David Weber <weber.aulendorf@gmail.com>
Subject: [RFC PATCH 4/5] drm/amd/display: recover from fatal PSR-related
 display timeouts
Date: Wed,  5 Aug 2026 13:52:47 +0200
Message-ID: <bd02db8b1e355ca42ce82005e923b01f04cdc494.1785929873.git.weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785929873.git.weber.aulendorf@gmail.com>
References: <cover.1785929873.git.weber.aulendorf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:55:48 +0000
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

A PSR-related display stall can leave a page flip permanently submitted.
Later atomic commits then block on that flip, while the normal GPU hang
recovery does not start because no graphics ring timeout occurred.  On a
Phoenix (DCN 3.1.4) system, manual GPU recovery completed but did not
restore the graphical session.

Recover from two indications of this failure: a bounded synchronous PSR
disable which cannot be confirmed after PSR was previously confirmed
enabled, and an eDP flip timeout while PSR remains enabled as a feature
and the exact AMDGPU flip is still submitted.  The latter is a fail-safe
attribution heuristic because a flip timeout alone does not prove PSR was
the cause.

Keep PSR disabled for the rest of the driver instance and synchronize the
power-module cache.  Queue recovery through the AMDGPU reset domain,
honor the configured GPU recovery policy, and retain references to the
commits which were outstanding when recovery was requested.  Merge exact
flip evidence which arrives while recovery is already pending.

Acquire all modeset locks before irreversible recovery, wait for recorded
hardware programming with one total deadline, and perform a full GPU
reset.  After reset has quiesced and rebuilt scanout, retire only a
recorded stuck flip whose event still belongs to its retained commit.
Refresh the submitted-flip status of retained commits after reset because
a commit can arm its flip after the initial request snapshot but before
recovery acquires all modeset locks.  Bound late-evidence reconciliation
and fail recovery if recorded commit cleanup remains incomplete.

Reapply the persistent PSR disable to rebuilt link and power-module state
and to active eDP sinks.  Force a modeset from the live DRM state and
verify its flip completion.  Add AMDGPU_RESET_SRC_PSR in AMDGPU core so
reset logs and coredumps identify the recovery source.

The complete path recovered a natural submitted-flip stall on the test
system in 2.1 seconds.  The post-reset vblank wait expired, the exact flip
was retired, commit cleanup completed, and the forced modeset flip
finished.  The existing Plasma session remained usable.  This does not
yet prove that the forced modeset is required beyond recovered-flip
retirement and DM's normal reset restoration.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 119 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  19 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  10 +
 .../amdgpu_dm/amdgpu_dm_psr_recovery.c        | 754 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   1 +
 .../link/protocols/link_edp_panel_control.c   |  15 +
 .../drm/amd/display/modules/inc/mod_power.h   |   3 +
 .../drm/amd/display/modules/power/power_psr.c |  61 +-
 11 files changed, 981 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr_recovery.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 428c3cbc4a40..6342f16882ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -344,6 +344,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USERQ:
 		strscpy(buf, "user queue trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_PSR:
+		strscpy(buf, "PSR-related display failure", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index c9f23a8e8db8..4aebac5bb045 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -44,6 +44,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
 	AMDGPU_RESET_SRC_USERQ,
+	AMDGPU_RESET_SRC_PSR,
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 54a93e4255b3..66c3edaa8657 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -37,6 +37,7 @@ AMDGPUDM = \
 	amdgpu_dm_helpers.o \
 	amdgpu_dm_pp_smu.o \
 	amdgpu_dm_psr.o \
+	amdgpu_dm_psr_recovery.o \
 	amdgpu_dm_replay.o \
 	amdgpu_dm_quirks.o \
 	amdgpu_dm_wb.o \
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ee3d65226a69..dc312291b4d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2074,6 +2074,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->dm.audio_lock);
 
 	spin_lock_init(&adev->dm.dmub_lock);
+	amdgpu_dm_psr_recovery_init(&adev->dm);
 
 	if (amdgpu_dm_irq_init(adev)) {
 		drm_err(adev_to_drm(adev), "failed to initialize DM IRQ support.\n");
@@ -2436,6 +2437,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 {
 	int i;
 
+	amdgpu_dm_psr_recovery_fini(&adev->dm);
+
 	if (adev->dm.vblank_control_workqueue) {
 		destroy_workqueue(adev->dm.vblank_control_workqueue);
 		adev->dm.vblank_control_workqueue = NULL;
@@ -11458,6 +11461,115 @@ static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state)
 	return 0;
 }
 
+struct amdgpu_dm_psr_commit_info {
+	bool edp;
+	bool psr_feature_enabled;
+	bool request_valid;
+	bool request;
+	u8 link_index;
+};
+
+static void amdgpu_dm_snapshot_psr_commit_info(
+		struct drm_atomic_commit *state,
+		struct amdgpu_dm_psr_commit_info *info)
+{
+	struct amdgpu_display_manager *dm = &drm_to_adev(state->dev)->dm;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
+		struct dm_crtc_state *dm_state;
+		struct dc_link *link;
+		unsigned int index = drm_crtc_index(crtc);
+
+		if (index >= AMDGPU_DM_MAX_CRTC)
+			continue;
+
+		dm_state = to_dm_crtc_state(new_crtc_state);
+		if (!dm_state->stream || !dm_state->stream->link)
+			continue;
+
+		link = dm_state->stream->link;
+		if (link->connector_signal != SIGNAL_TYPE_EDP)
+			continue;
+
+		info[index].edp = true;
+		info[index].link_index = link->link_index;
+		info[index].psr_feature_enabled =
+			!READ_ONCE(dm->psr_disabled_by_recovery) &&
+			READ_ONCE(link->psr_settings.psr_feature_enabled);
+		info[index].request_valid =
+			READ_ONCE(link->psr_settings.psr_allow_active_valid);
+		info[index].request =
+			READ_ONCE(link->psr_settings.psr_allow_active);
+	}
+}
+
+static void amdgpu_dm_wait_for_flip_done(
+		struct drm_device *dev,
+		struct drm_atomic_commit *state,
+		const struct amdgpu_dm_psr_commit_info *psr_info)
+{
+	struct amdgpu_display_manager *dm = &drm_to_adev(dev)->dm;
+	bool recovery_requested = false;
+	struct drm_crtc *crtc;
+	int i;
+
+	for (i = 0; i < dev->mode_config.num_crtc; i++) {
+		struct drm_crtc_commit *commit = state->crtcs[i].commit;
+		struct amdgpu_crtc *acrtc;
+		const struct amdgpu_dm_psr_commit_info *info;
+		unsigned int index;
+		unsigned long flags;
+		bool flip_submitted;
+		unsigned long ret;
+
+		crtc = state->crtcs[i].ptr;
+		if (!crtc || !commit)
+			continue;
+		index = drm_crtc_index(crtc);
+		if (index >= AMDGPU_DM_MAX_CRTC)
+			continue;
+		info = &psr_info[index];
+
+		ret = wait_for_completion_timeout(&commit->flip_done, 10 * HZ);
+		if (ret)
+			continue;
+
+		drm_err(dev, "[CRTC:%d:%s] flip_done timed out\n",
+			crtc->base.id, crtc->name);
+
+		acrtc = to_amdgpu_crtc(crtc);
+		spin_lock_irqsave(&dev->event_lock, flags);
+		flip_submitted =
+			acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+			acrtc->event &&
+			acrtc->event->base.completion == &commit->flip_done;
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+
+		if (info->edp)
+			drm_err(dev,
+				"[CRTC:%d:%s] eDP flip timeout: link=%u psr=%d request_valid=%d request=%d submitted=%d\n",
+				crtc->base.id, crtc->name, info->link_index,
+				info->psr_feature_enabled, info->request_valid,
+				info->request, flip_submitted);
+
+		if (recovery_requested || !info->edp ||
+		    !info->psr_feature_enabled || !flip_submitted)
+			continue;
+
+		drm_err(dev,
+			"[CRTC:%d:%s] flip timeout on PSR link %u; scheduling recovery\n",
+			crtc->base.id, crtc->name, info->link_index);
+		if (amdgpu_dm_schedule_psr_recovery(dm, crtc, commit))
+			recovery_requested = true;
+	}
+
+	if (state->fake_commit)
+		complete_all(&state->fake_commit->flip_done);
+}
+
 /**
  * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
  * @state: The atomic state to commit
@@ -11471,6 +11583,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 	struct drm_device *dev = state->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
+	struct amdgpu_dm_psr_commit_info
+		psr_commit_info[AMDGPU_DM_MAX_CRTC] = {};
 	struct dm_atomic_state *dm_state;
 	struct dc_state *dc_state = NULL;
 	u32 i, j;
@@ -11737,11 +11851,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 	}
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 
+	/* Snapshot commit-specific link state before commit_hw_done(). */
+	amdgpu_dm_snapshot_psr_commit_info(state, psr_commit_info);
+
 	/* Signal HW programming completion */
 	drm_atomic_helper_commit_hw_done(state);
 
 	if (wait_for_vblank)
-		drm_atomic_helper_wait_for_flip_done(dev, state);
+		amdgpu_dm_wait_for_flip_done(dev, state, psr_commit_info);
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index dd199e0b7922..db114398ca81 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -583,6 +583,21 @@ struct amdgpu_display_manager {
 	 */
 	struct workqueue_struct *vblank_control_workqueue;
 
+	/** @psr_recovery_work: Deferred fatal PSR-related recovery. */
+	struct work_struct psr_recovery_work;
+	/** @psr_recovery_lock: Serializes scheduling with teardown. */
+	spinlock_t psr_recovery_lock;
+	/** @psr_recovery_pending: Prevents duplicate recovery requests. */
+	bool psr_recovery_pending;
+	/** @psr_recovery_stopping: Prevents new work during teardown. */
+	bool psr_recovery_stopping;
+	/** @psr_disabled_by_recovery: Keeps PSR disabled after recovery. */
+	bool psr_disabled_by_recovery;
+	/** @psr_recovery_commits: Exact commits retained by the request. */
+	struct drm_crtc_commit *psr_recovery_commits[AMDGPU_DM_MAX_CRTC];
+	/** @psr_recovery_flip_mask: CRTCs with a recorded stuck page flip. */
+	u32 psr_recovery_flip_mask;
+
 	/**
 	 * @idle_workqueue:
 	 *
@@ -1168,4 +1183,8 @@ int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
 void retrieve_dmi_info(struct amdgpu_display_manager *dm);
 
 void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm, int bl_idx);
+bool amdgpu_dm_schedule_psr_recovery(struct amdgpu_display_manager *dm,
+		struct drm_crtc *crtc, struct drm_crtc_commit *commit);
+void amdgpu_dm_psr_recovery_init(struct amdgpu_display_manager *dm);
+void amdgpu_dm_psr_recovery_fini(struct amdgpu_display_manager *dm);
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6be7f6edd0b2..eaa813b4bf15 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1302,6 +1302,13 @@ void dm_helpers_dmu_timeout(struct dc_context *ctx)
 	//amdgpu_device_gpu_recover(dc_context->driver-context, NULL);
 }
 
+void dm_helpers_psr_failure(struct dc_context *ctx)
+{
+	struct amdgpu_device *adev = ctx->driver_context;
+
+	amdgpu_dm_schedule_psr_recovery(&adev->dm, NULL, NULL);
+}
+
 void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us)
 {
 	// TODO:
@@ -1330,11 +1337,14 @@ void dm_helpers_override_panel_settings(
 	struct dc_context *ctx,
 	struct dc_link *link)
 {
+	struct amdgpu_device *adev = ctx->driver_context;
 	unsigned int panel_inst = 0;
 
 	// Feature DSC
 	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
 		link->panel_config.dsc.disable_dsc_edp = true;
+	if (READ_ONCE(adev->dm.psr_disabled_by_recovery))
+		link->panel_config.psr.disable_psr = true;
 
 	if (dc_get_edp_link_panel_inst(ctx->dc, link, &panel_inst) && panel_inst == 1) {
 		link->panel_config.psr.disable_psr = true;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr_recovery.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr_recovery.c
new file mode 100644
index 000000000000..72edbaac2403
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr_recovery.c
@@ -0,0 +1,754 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 David Weber
+ */
+
+#include <linux/jiffies.h>
+#include <linux/string.h>
+#include <linux/wait.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_modeset_lock.h>
+#include <drm/drm_vblank.h>
+
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
+#include "amdgpu_dm.h"
+#include "core_types.h"
+#include "dc.h"
+#include "dm_helpers.h"
+#include "dpcd_defs.h"
+#include "mod_power.h"
+
+#define PSR_RECOVERY_COMMIT_TIMEOUT_MS 2000
+#define PSR_RECOVERY_VBLANK_TIMEOUT_MS 1000
+#define PSR_RECOVERY_MAX_RECONCILE_PASSES 3
+
+static void amdgpu_dm_snapshot_current_commits(
+		struct amdgpu_display_manager *dm,
+		struct drm_crtc_commit **commits,
+		u32 *flip_mask)
+{
+	struct drm_crtc_commit *commit;
+	struct drm_crtc *crtc;
+	unsigned long flags;
+
+	drm_for_each_crtc(crtc, dm->ddev) {
+		unsigned int index = drm_crtc_index(crtc);
+
+		if (index >= AMDGPU_DM_MAX_CRTC)
+			continue;
+
+		spin_lock_irqsave(&crtc->commit_lock, flags);
+		commit = list_first_entry_or_null(&crtc->commit_list,
+				struct drm_crtc_commit, commit_entry);
+		if (commit)
+			commits[index] = drm_crtc_commit_get(commit);
+		spin_unlock_irqrestore(&crtc->commit_lock, flags);
+
+		if (!commit)
+			continue;
+
+		/* Retire only a flip tied to the exact retained commit. */
+		spin_lock_irqsave(&dm->ddev->event_lock, flags);
+		if (to_amdgpu_crtc(crtc)->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+		    to_amdgpu_crtc(crtc)->event &&
+		    to_amdgpu_crtc(crtc)->event->base.completion ==
+				&commit->flip_done)
+			*flip_mask |= BIT(index);
+		spin_unlock_irqrestore(&dm->ddev->event_lock, flags);
+	}
+}
+
+static void amdgpu_dm_put_recovery_commits(
+		struct drm_crtc_commit **commits)
+{
+	int i;
+
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		if (!commits[i])
+			continue;
+		drm_crtc_commit_put(commits[i]);
+		commits[i] = NULL;
+	}
+}
+
+bool amdgpu_dm_schedule_psr_recovery(struct amdgpu_display_manager *dm,
+		struct drm_crtc *crtc, struct drm_crtc_commit *commit)
+{
+	struct drm_crtc_commit *commits[AMDGPU_DM_MAX_CRTC] = {0};
+	unsigned long flags;
+	u32 flip_mask = 0;
+	bool queue_failed = false;
+	bool scheduled = false;
+	int i;
+
+	/*
+	 * A fatal PSR-related failure makes the cached and firmware state
+	 * untrustworthy.  Keep the fail-safe disable even if teardown rejects
+	 * this request or queueing recovery fails.
+	 */
+	WRITE_ONCE(dm->psr_disabled_by_recovery, true);
+
+	if (crtc && commit) {
+		unsigned int index = drm_crtc_index(crtc);
+
+		if (index >= AMDGPU_DM_MAX_CRTC)
+			return false;
+		commits[index] = drm_crtc_commit_get(commit);
+		flip_mask = BIT(index);
+	} else {
+		/*
+		 * A direct DC failure has no atomic state. Retain the newest
+		 * outstanding commit on each CRTC so reset cannot race hardware
+		 * programming which was already in flight.
+		 */
+		amdgpu_dm_snapshot_current_commits(dm, commits, &flip_mask);
+	}
+
+	spin_lock_irqsave(&dm->psr_recovery_lock, flags);
+	if (dm->psr_recovery_stopping)
+		goto unlock;
+	if (dm->psr_recovery_pending) {
+		/* Merge exact flip evidence without scheduling another reset. */
+		if (crtc && commit) {
+			unsigned int index = drm_crtc_index(crtc);
+			struct drm_crtc_commit *old_commit;
+
+			old_commit = dm->psr_recovery_commits[index];
+			dm->psr_recovery_commits[index] = commits[index];
+			commits[index] = old_commit;
+			dm->psr_recovery_flip_mask |= BIT(index);
+		}
+		scheduled = true;
+		goto unlock;
+	}
+
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		dm->psr_recovery_commits[i] = commits[i];
+		commits[i] = NULL;
+	}
+	dm->psr_recovery_flip_mask = flip_mask;
+	dm->psr_recovery_pending = true;
+
+	if (!dm->adev->reset_domain ||
+	    !amdgpu_reset_domain_schedule(dm->adev->reset_domain,
+					  &dm->psr_recovery_work)) {
+		for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+			commits[i] = dm->psr_recovery_commits[i];
+			dm->psr_recovery_commits[i] = NULL;
+		}
+		dm->psr_recovery_flip_mask = 0;
+		dm->psr_recovery_pending = false;
+		queue_failed = true;
+	} else {
+		scheduled = true;
+	}
+
+unlock:
+	spin_unlock_irqrestore(&dm->psr_recovery_lock, flags);
+	amdgpu_dm_put_recovery_commits(commits);
+
+	if (queue_failed)
+		drm_err(dm->ddev, "failed to queue fatal PSR recovery\n");
+
+	return scheduled;
+}
+
+static int amdgpu_dm_validate_modeset_flips(struct drm_device *dev,
+		struct drm_atomic_commit *state)
+{
+	struct drm_crtc_commit *commit;
+	struct drm_crtc *crtc;
+	int i;
+
+	for (i = 0; i < dev->mode_config.num_crtc; i++) {
+		crtc = state->crtcs[i].ptr;
+		commit = state->crtcs[i].commit;
+		if (!crtc || !commit || completion_done(&commit->flip_done))
+			continue;
+
+		drm_err(dev,
+			"[CRTC:%d:%s] PSR recovery modeset flip timed out\n",
+			crtc->base.id, crtc->name);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int amdgpu_dm_force_full_modeset_locked(
+		struct drm_device *dev,
+		struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_atomic_commit *state;
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector_state *connector_state;
+	struct drm_plane_state *plane_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	unsigned int active_crtcs = 0;
+	int ret;
+
+	state = drm_atomic_commit_alloc(dev);
+	if (!state)
+		return -ENOMEM;
+	state->acquire_ctx = ctx;
+
+	drm_for_each_crtc(crtc, dev) {
+		if (!crtc->state || !crtc->state->active)
+			continue;
+
+		crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(crtc_state)) {
+			ret = PTR_ERR(crtc_state);
+			goto out;
+		}
+		crtc_state->mode_changed = true;
+		active_crtcs++;
+	}
+
+	ret = 0;
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (!connector->state || !connector->state->crtc)
+			continue;
+
+		connector_state = drm_atomic_get_connector_state(state, connector);
+		if (IS_ERR(connector_state)) {
+			ret = PTR_ERR(connector_state);
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+	if (ret)
+		goto out;
+
+	drm_for_each_plane(plane, dev) {
+		if (!plane->state || !plane->state->crtc)
+			continue;
+
+		plane_state = drm_atomic_get_plane_state(state, plane);
+		if (IS_ERR(plane_state)) {
+			ret = PTR_ERR(plane_state);
+			goto out;
+		}
+	}
+
+	drm_info(dev, "PSR recovery: forcing modeset on %u active CRTCs\n",
+		 active_crtcs);
+	ret = drm_atomic_commit(state);
+	if (!ret)
+		ret = amdgpu_dm_validate_modeset_flips(dev, state);
+
+out:
+	drm_atomic_commit_put(state);
+	return ret;
+}
+
+static int amdgpu_dm_wait_for_recovery_commits(
+		struct drm_device *dev,
+		struct drm_crtc_commit **commits,
+		bool cleanup)
+{
+	unsigned long deadline = jiffies +
+		msecs_to_jiffies(PSR_RECOVERY_COMMIT_TIMEOUT_MS);
+	struct completion *completion;
+	unsigned long timeout;
+	bool timed_out = false;
+	int i;
+
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		if (!commits[i])
+			continue;
+
+		completion = cleanup ? &commits[i]->cleanup_done :
+			&commits[i]->hw_done;
+		if (completion_done(completion))
+			continue;
+
+		timeout = time_before(jiffies, deadline) ?
+			deadline - jiffies : 0;
+		if (!timeout || !wait_for_completion_timeout(completion, timeout)) {
+			drm_warn(dev,
+				 "[CRTC:%d:%s] PSR recovery %s wait timed out\n",
+				 commits[i]->crtc->base.id,
+				 commits[i]->crtc->name,
+				 cleanup ? "cleanup_done" : "hw_done");
+			timed_out = true;
+		}
+	}
+
+	return timed_out ? -ETIMEDOUT : 0;
+}
+
+static u32 amdgpu_dm_find_submitted_recovery_flips(
+		struct amdgpu_display_manager *dm,
+		struct drm_crtc_commit **commits)
+{
+	struct drm_device *dev = dm->ddev;
+	u32 flip_mask = 0;
+	int i;
+
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		struct drm_crtc_commit *commit = commits[i];
+		struct amdgpu_crtc *acrtc;
+		unsigned long flags;
+
+		if (!commit)
+			continue;
+
+		acrtc = to_amdgpu_crtc(commit->crtc);
+		spin_lock_irqsave(&dev->event_lock, flags);
+		if (acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+		    acrtc->event &&
+		    acrtc->event->base.completion == &commit->flip_done)
+			flip_mask |= BIT(i);
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+	}
+
+	return flip_mask;
+}
+
+static unsigned int amdgpu_dm_retire_recovered_flips(
+		struct amdgpu_display_manager *dm,
+		struct drm_crtc_commit **commits,
+		u32 flip_mask)
+{
+	struct drm_device *dev = dm->ddev;
+	unsigned int completed = 0;
+	int i;
+
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		struct drm_crtc_commit *commit = commits[i];
+		struct amdgpu_crtc *acrtc;
+		struct drm_crtc *crtc;
+		unsigned long flags;
+		u64 last_vblank;
+		long waited;
+		int ret;
+
+		if (!(flip_mask & BIT(i)) || !commit)
+			continue;
+
+		crtc = commit->crtc;
+		if (!crtc->state || !crtc->state->active) {
+			drm_warn(dev,
+				 "[CRTC:%d:%s] cannot retire recovered flip on inactive CRTC\n",
+				 crtc->base.id, crtc->name);
+			continue;
+		}
+
+		ret = drm_crtc_vblank_get(crtc);
+		if (ret) {
+			drm_warn(dev,
+				 "[CRTC:%d:%s] no vblank available after PSR recovery: %d\n",
+				 crtc->base.id, crtc->name, ret);
+		} else {
+			last_vblank = drm_crtc_vblank_count(crtc);
+			waited = wait_event_timeout(
+					*drm_crtc_vblank_waitqueue(crtc),
+					last_vblank !=
+						drm_crtc_vblank_count(crtc),
+					msecs_to_jiffies(
+						PSR_RECOVERY_VBLANK_TIMEOUT_MS));
+			drm_crtc_vblank_put(crtc);
+			if (!waited)
+				drm_warn(dev,
+					 "[CRTC:%d:%s] no vblank after PSR recovery; retiring flip without one\n",
+					 crtc->base.id, crtc->name);
+		}
+
+		acrtc = to_amdgpu_crtc(crtc);
+		spin_lock_irqsave(&dev->event_lock, flags);
+		if (acrtc->pflip_status != AMDGPU_FLIP_SUBMITTED ||
+		    !acrtc->event) {
+			spin_unlock_irqrestore(&dev->event_lock, flags);
+			continue;
+		}
+
+		if (acrtc->event->base.completion != &commit->flip_done) {
+			drm_warn(dev,
+				 "[CRTC:%d:%s] pending flip changed during PSR recovery\n",
+				 crtc->base.id, crtc->name);
+			spin_unlock_irqrestore(&dev->event_lock, flags);
+			continue;
+		}
+
+		drm_info(dev,
+			 "[CRTC:%d:%s] retiring flip after successful PSR recovery\n",
+			 crtc->base.id, crtc->name);
+		drm_crtc_send_vblank_event(crtc, acrtc->event);
+		acrtc->event = NULL;
+		drm_crtc_vblank_put(crtc);
+		acrtc->pflip_status = AMDGPU_FLIP_NONE;
+		completed++;
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+	}
+
+	return completed;
+}
+
+static void amdgpu_dm_mark_psr_disabled(struct amdgpu_display_manager *dm)
+{
+	struct dc *dc = dm->dc;
+	struct dc_link *link;
+	int i;
+
+	if (!dc)
+		return;
+
+	for (i = 0; i < dc->link_count; i++) {
+		link = dc->links[i];
+		if (!link)
+			continue;
+
+		if (dm->power_module)
+			mod_power_disable_psr_for_link(dm->power_module, link);
+		link->panel_config.psr.disable_psr = true;
+		link->psr_settings.psr_feature_enabled = false;
+		link->psr_settings.psr_allow_active = false;
+		link->psr_settings.psr_allow_active_valid = false;
+	}
+}
+
+static unsigned int amdgpu_dm_disable_psr_at_active_sinks(
+		struct amdgpu_display_manager *dm)
+{
+	union dpcd_psr_configuration psr_configuration = {0};
+	struct dc *dc = dm->dc;
+	struct dc_link *link;
+	unsigned int writes = 0;
+	int i;
+	int j;
+
+	if (!dc || !dc->current_state)
+		return 0;
+
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		struct dc_stream_state *stream = dc->current_state->streams[i];
+
+		if (!stream || !stream->link ||
+		    stream->link->connector_signal != SIGNAL_TYPE_EDP)
+			continue;
+
+		link = stream->link;
+		for (j = 0; j < i; j++)
+			if (dc->current_state->streams[j] &&
+			    dc->current_state->streams[j]->link == link)
+				break;
+		if (j != i)
+			continue;
+
+		if (!dm_helpers_dp_write_dpcd(link->ctx, link, DP_PSR_EN_CFG,
+					      &psr_configuration.raw,
+					      sizeof(psr_configuration.raw))) {
+			drm_warn(dm->ddev,
+				 "failed to disable PSR at sink on link %d\n",
+				 link->link_index);
+		} else {
+			writes++;
+		}
+	}
+
+	return writes;
+}
+
+static int amdgpu_dm_lock_all_modeset(struct drm_device *dev,
+		struct drm_modeset_acquire_ctx *ctx)
+{
+	int ret;
+
+	drm_modeset_acquire_init(ctx, 0);
+
+retry:
+	ret = drm_modeset_lock_all_ctx(dev, ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(ctx);
+		if (!ret)
+			goto retry;
+	}
+
+	return ret;
+}
+
+static unsigned int amdgpu_dm_collect_recovery_evidence(
+		struct amdgpu_display_manager *dm,
+		struct drm_crtc_commit **commits,
+		u32 *flip_mask)
+{
+	struct drm_crtc_commit *old_commits[AMDGPU_DM_MAX_CRTC] = {0};
+	unsigned long flags;
+	unsigned int collected = 0;
+	int i;
+
+	spin_lock_irqsave(&dm->psr_recovery_lock, flags);
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		if (!dm->psr_recovery_commits[i])
+			continue;
+
+		old_commits[i] = commits[i];
+		commits[i] = dm->psr_recovery_commits[i];
+		dm->psr_recovery_commits[i] = NULL;
+		collected++;
+	}
+	*flip_mask |= dm->psr_recovery_flip_mask;
+	dm->psr_recovery_flip_mask = 0;
+	spin_unlock_irqrestore(&dm->psr_recovery_lock, flags);
+
+	amdgpu_dm_put_recovery_commits(old_commits);
+
+	return collected;
+}
+
+static bool amdgpu_dm_finish_recovery_request(
+		struct amdgpu_display_manager *dm,
+		struct drm_crtc_commit **commits)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dm->psr_recovery_lock, flags);
+	if (dm->psr_recovery_flip_mask) {
+		spin_unlock_irqrestore(&dm->psr_recovery_lock, flags);
+		return false;
+	}
+	dm->psr_recovery_pending = false;
+	spin_unlock_irqrestore(&dm->psr_recovery_lock, flags);
+
+	amdgpu_dm_put_recovery_commits(commits);
+
+	return true;
+}
+
+static void amdgpu_dm_abort_recovery_request(
+		struct amdgpu_display_manager *dm,
+		struct drm_crtc_commit **commits)
+{
+	struct drm_crtc_commit *late_commits[AMDGPU_DM_MAX_CRTC] = {0};
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&dm->psr_recovery_lock, flags);
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		late_commits[i] = dm->psr_recovery_commits[i];
+		dm->psr_recovery_commits[i] = NULL;
+	}
+	dm->psr_recovery_flip_mask = 0;
+	dm->psr_recovery_pending = false;
+	spin_unlock_irqrestore(&dm->psr_recovery_lock, flags);
+
+	amdgpu_dm_put_recovery_commits(commits);
+	amdgpu_dm_put_recovery_commits(late_commits);
+}
+
+static void amdgpu_dm_psr_recovery_work(struct work_struct *work)
+{
+	struct amdgpu_display_manager *dm =
+		container_of(work, struct amdgpu_display_manager,
+			     psr_recovery_work);
+	struct amdgpu_device *adev = dm->adev;
+	struct drm_crtc_commit *commits[AMDGPU_DM_MAX_CRTC] = {0};
+	struct amdgpu_reset_context reset_context = {
+		.method = AMD_RESET_METHOD_NONE,
+		.reset_req_dev = adev,
+		.src = AMDGPU_RESET_SRC_PSR,
+	};
+	struct drm_modeset_acquire_ctx ctx;
+	unsigned int completed_flips;
+	unsigned int reconcile_passes = 0;
+	unsigned int recorded_commits = 0;
+	unsigned int sink_writes;
+	u32 flip_mask = 0;
+	u32 submitted_flip_mask;
+	bool request_finished = false;
+	int lock_ret;
+	int ret = 0;
+
+	recorded_commits = amdgpu_dm_collect_recovery_evidence(dm, commits,
+								&flip_mask);
+
+	drm_err(dm->ddev,
+		"fatal PSR-related display failure; disabling PSR and recovering GPU\n");
+	drm_info(dm->ddev,
+		 "PSR recovery: recorded %u commits and %u submitted flips\n",
+		 recorded_commits, hweight32(flip_mask));
+
+	/*
+	 * Stop atomic commits while reset and recovered-flip reconciliation run.
+	 * This relies on DM's amdgpu_in_reset() suspend path avoiding the normal
+	 * DRM atomic suspend, which would try to acquire these locks again.
+	 */
+	drm_info(dm->ddev, "PSR recovery: acquiring modeset locks\n");
+	lock_ret = amdgpu_dm_lock_all_modeset(dm->ddev, &ctx);
+	if (lock_ret) {
+		ret = lock_ret;
+		goto out_locks;
+	}
+	drm_info(dm->ddev, "PSR recovery: modeset locks acquired\n");
+
+	drm_info(dm->ddev,
+		 "PSR recovery: waiting for recorded hardware programming\n");
+	ret = amdgpu_dm_wait_for_recovery_commits(dm->ddev, commits, false);
+	if (ret) {
+		drm_warn(dm->ddev,
+			 "PSR recovery: proceeding with reset after hw_done timeout\n");
+		ret = 0;
+	}
+
+	mutex_lock(&dm->dc_lock);
+	amdgpu_dm_mark_psr_disabled(dm);
+	mutex_unlock(&dm->dc_lock);
+	drm_info(dm->ddev, "PSR recovery: PSR disabled in software\n");
+
+	if (!amdgpu_device_should_recover_gpu(adev)) {
+		drm_err(dm->ddev, "PSR recovery: GPU recovery policy is disabled\n");
+		ret = -EOPNOTSUPP;
+		goto out_locks;
+	}
+
+	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	drm_info(dm->ddev, "PSR recovery: starting full GPU reset\n");
+	ret = amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+	drm_info(dm->ddev, "PSR recovery: full GPU reset returned %d\n", ret);
+	if (ret)
+		goto out_locks;
+
+reconcile_after_reset:
+	if (++reconcile_passes > PSR_RECOVERY_MAX_RECONCILE_PASSES) {
+		drm_err(dm->ddev,
+			"PSR recovery: too many late evidence reconciliation passes\n");
+		ret = -EBUSY;
+		goto out_locks;
+	}
+
+	recorded_commits = amdgpu_dm_collect_recovery_evidence(dm, commits,
+								&flip_mask);
+	if (recorded_commits)
+		drm_info(dm->ddev,
+			 "PSR recovery: merged %u late commit records and %u submitted flips\n",
+			 recorded_commits, hweight32(flip_mask));
+
+	/*
+	 * A retained commit can arm its flip after the initial request snapshot
+	 * but before recovery acquires all modeset locks.  Refresh the exact
+	 * event-to-commit match after reset so that flip does not strand
+	 * cleanup_done.
+	 */
+	submitted_flip_mask =
+		amdgpu_dm_find_submitted_recovery_flips(dm, commits);
+	if (submitted_flip_mask & ~flip_mask)
+		drm_info(dm->ddev,
+			 "PSR recovery: found %u newly submitted retained flips after reset\n",
+			 hweight32(submitted_flip_mask & ~flip_mask));
+	flip_mask |= submitted_flip_mask;
+
+	completed_flips = amdgpu_dm_retire_recovered_flips(dm, commits,
+							    flip_mask);
+	flip_mask = 0;
+	drm_info(dm->ddev, "PSR recovery: retired %u recovered flips\n",
+		 completed_flips);
+	drm_info(dm->ddev, "PSR recovery: waiting for recorded commit cleanup\n");
+	ret = amdgpu_dm_wait_for_recovery_commits(dm->ddev, commits, true);
+	if (ret && amdgpu_dm_collect_recovery_evidence(dm, commits,
+							      &flip_mask)) {
+		drm_info(dm->ddev,
+			 "PSR recovery: retrying cleanup with late exact flip evidence\n");
+		ret = 0;
+		goto reconcile_after_reset;
+	}
+	if (ret)
+		goto out_locks;
+	drm_info(dm->ddev, "PSR recovery: recorded commits quiesced\n");
+
+	mutex_lock(&dm->dc_lock);
+	amdgpu_dm_mark_psr_disabled(dm);
+	sink_writes = amdgpu_dm_disable_psr_at_active_sinks(dm);
+	mutex_unlock(&dm->dc_lock);
+	drm_info(dm->ddev,
+		 "PSR recovery: PSR disabled after reset (sink writes=%u)\n",
+		 sink_writes);
+
+	drm_info(dm->ddev, "PSR recovery: starting forced modeset\n");
+	ret = amdgpu_dm_force_full_modeset_locked(dm->ddev, &ctx);
+	drm_info(dm->ddev,
+		 "PSR recovery: forced modeset and flip validation returned %d\n",
+		 ret);
+
+	/* The modeset PSR setup path must not undo the fatal fallback. */
+	mutex_lock(&dm->dc_lock);
+	amdgpu_dm_mark_psr_disabled(dm);
+	sink_writes = amdgpu_dm_disable_psr_at_active_sinks(dm);
+	mutex_unlock(&dm->dc_lock);
+	drm_info(dm->ddev,
+		 "PSR recovery: PSR disable reasserted after modeset (sink writes=%u)\n",
+		 sink_writes);
+	if (ret)
+		goto out_locks;
+
+	if (!amdgpu_dm_finish_recovery_request(dm, commits)) {
+		drm_info(dm->ddev,
+			 "PSR recovery: processing late exact flip evidence\n");
+		goto reconcile_after_reset;
+	}
+	request_finished = true;
+
+out_locks:
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	if (ret) {
+		drm_err(dm->ddev, "PSR display recovery failed: %d\n", ret);
+		drm_dev_wedged_event(dm->ddev,
+				     DRM_WEDGE_RECOVERY_REBIND |
+				     DRM_WEDGE_RECOVERY_BUS_RESET, NULL);
+	} else {
+		drm_info(dm->ddev, "PSR display recovery completed\n");
+	}
+
+	if (!request_finished)
+		amdgpu_dm_abort_recovery_request(dm, commits);
+}
+
+void amdgpu_dm_psr_recovery_init(struct amdgpu_display_manager *dm)
+{
+	spin_lock_init(&dm->psr_recovery_lock);
+	dm->psr_recovery_pending = false;
+	dm->psr_recovery_stopping = false;
+	dm->psr_disabled_by_recovery = false;
+	dm->psr_recovery_flip_mask = 0;
+	memset(dm->psr_recovery_commits, 0,
+	       sizeof(dm->psr_recovery_commits));
+	INIT_WORK(&dm->psr_recovery_work, amdgpu_dm_psr_recovery_work);
+}
+
+void amdgpu_dm_psr_recovery_fini(struct amdgpu_display_manager *dm)
+{
+	struct drm_crtc_commit *commits[AMDGPU_DM_MAX_CRTC] = {0};
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&dm->psr_recovery_lock, flags);
+	dm->psr_recovery_stopping = true;
+	spin_unlock_irqrestore(&dm->psr_recovery_lock, flags);
+
+	/*
+	 * Recovery runs on the reset-domain workqueue.  Device teardown must
+	 * not invoke this finalizer from that workqueue, or this synchronous
+	 * cancellation would wait for the current worker itself.
+	 */
+	cancel_work_sync(&dm->psr_recovery_work);
+
+	spin_lock_irqsave(&dm->psr_recovery_lock, flags);
+	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
+		commits[i] = dm->psr_recovery_commits[i];
+		dm->psr_recovery_commits[i] = NULL;
+	}
+	dm->psr_recovery_flip_mask = 0;
+	dm->psr_recovery_pending = false;
+	spin_unlock_irqrestore(&dm->psr_recovery_lock, flags);
+
+	amdgpu_dm_put_recovery_commits(commits);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 63704d21a0b5..122c21d684fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -209,6 +209,7 @@ void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz);
 bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enable);
 
 void dm_helpers_dmu_timeout(struct dc_context *ctx);
+void dm_helpers_psr_failure(struct dc_context *ctx);
 void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us);
 
 // 0x1 = Result_OK, 0xFE = Result_UnkmownCmd, 0x0 = Status_Busy
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index f7001f01f960..160a658de727 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -584,6 +584,7 @@ bool edp_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dmub_psr *psr = dc->res_pool->psr;
 	unsigned int panel_inst;
+	bool recover_failed_exit = false;
 
 	if (psr == NULL && force_static)
 		return false;
@@ -614,6 +615,10 @@ bool edp_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
 	     link->psr_settings.psr_allow_active != *allow_active)) {
 		bool programmed = true;
 
+		recover_failed_exit = wait && !*allow_active &&
+			link->psr_settings.psr_allow_active_valid &&
+			link->psr_settings.psr_allow_active;
+
 		if (!*allow_active)
 			dc_z10_restore(dc);
 
@@ -629,6 +634,8 @@ bool edp_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
 		if (!programmed) {
 			/* The command may have succeeded, but its state is unknown. */
 			link->psr_settings.psr_allow_active_valid = false;
+			if (recover_failed_exit)
+				dm_helpers_psr_failure(link->ctx);
 			return false;
 		}
 
@@ -713,6 +720,14 @@ bool edp_setup_psr(struct dc_link *link,
 	if (!link)
 		return false;
 
+	/* PSR may have been disabled after a fatal runtime failure. */
+	if (link->panel_config.psr.disable_psr) {
+		link->psr_settings.psr_feature_enabled = false;
+		link->psr_settings.psr_allow_active = false;
+		link->psr_settings.psr_allow_active_valid = false;
+		return false;
+	}
+
 	/* This is a workaround: some vendors require the source to
 	 * read the PSR cap; otherwise, the vendor's PSR feature will
 	 * fall back to its default behavior, causing a misconfiguration
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
index 893fcd04a197..fdbf32ed9213 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
@@ -333,6 +333,9 @@ bool mod_power_set_psr_event(struct mod_power *mod_power,
 		struct dc_stream_state *stream, bool set_event,
 		enum psr_event event, bool wait);
 
+void mod_power_disable_psr_for_link(struct mod_power *mod_power,
+		const struct dc_link *link);
+
 bool mod_power_get_psr_state(struct mod_power *mod_power,
 		const struct dc_stream_state *stream,
 		enum dc_psr_state *state);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_psr.c b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
index 7ef53966c9e4..ab742597d744 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_psr.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
@@ -3,6 +3,7 @@
 // Copyright 2026 Advanced Micro Devices, Inc.
 
 #include "dm_services.h"
+#include "dm_helpers.h"
 #include "dc.h"
 #include "mod_power.h"
 #include "core_types.h"
@@ -16,6 +17,7 @@
 
 #define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
 #define DC_TRACE_LEVEL_MESSAGEP(...) /* do nothing */
+#define DC_LOGGER core_power->dc->ctx->logger
 #include "dc/inc/hw/dmcu.h"
 #include "dc/inc/hw/abm.h"
 #include "dmub_cmd.h"
@@ -54,6 +56,15 @@ bool mod_power_psr_notify_mode_change(struct mod_power *mod_power,
 	core_power = MOD_POWER_TO_CORE(mod_power);
 	dc = core_power->dc;
 
+	/* A fatal recovery can disable PSR after initial link setup. */
+	if (link->panel_config.psr.disable_psr) {
+		mod_power_disable_psr_for_link(mod_power, link);
+		link->psr_settings.psr_feature_enabled = false;
+		link->psr_settings.psr_allow_active = false;
+		link->psr_settings.psr_allow_active_valid = false;
+		return true;
+	}
+
 	// NO num_entities check here - already validated by caller
 	// stream_index is passed as validated parameter
 	active_psr_events = core_power->map[stream_index].psr_events;
@@ -147,10 +158,13 @@ static bool set_psr_enable(struct mod_power *mod_power,
 		bool force_static)
 {
 	struct core_power *core_power = NULL;
-	enum dc_psr_state state = PSR_STATE0;
+	enum dc_psr_state state = PSR_STATE_INVALID;
 	unsigned int retry_count;
+	unsigned int valid_query_count = 0;
 	const unsigned int max_retry = 1000;
 	struct dc_link *link = NULL;
+	bool programmed;
+	bool recover_failed_exit;
 	bool state_reached = false;
 
 	if (mod_power == NULL)
@@ -196,15 +210,21 @@ static bool set_psr_enable(struct mod_power *mod_power,
 	}
 
 	link = dc_stream_get_link(stream);
+	recover_failed_exit = wait && !psr_enable &&
+		link->psr_settings.psr_allow_active_valid &&
+		link->psr_settings.psr_allow_active;
 
-	if (!dc_link_set_psr_allow_active(link, &psr_enable, false, force_static, NULL)) {
+	programmed = dc_link_set_psr_allow_active(link, &psr_enable, false,
+					  force_static, NULL);
+	if (!programmed) {
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
 							WPP_BIT_FLAG_Firmware_PsrState,
 							"set psr enable: ERROR: stream=%p link=%p psr_enable=%d",
 							stream,
 							link,
 							psr_enable);
-		return false;
+		if (!wait)
+			return false;
 	}
 
 	if (wait == true) {
@@ -216,6 +236,7 @@ static bool set_psr_enable(struct mod_power *mod_power,
 
 		for (retry_count = 0; retry_count < max_retry; retry_count++) {
 			if (dc_link_get_psr_state(link, &state)) {
+				valid_query_count++;
 				if (psr_enable) {
 					if (state != PSR_STATE0 &&
 					    (!force_static || state == PSR_STATE3)) {
@@ -236,11 +257,21 @@ static bool set_psr_enable(struct mod_power *mod_power,
 							(int)psr_enable);
 
 		if (!state_reached) {
-			ASSERT(0);
+			DC_LOG_ERROR("PSR policy %s timeout: link=%u queries=%u state=%d\n",
+				     psr_enable ? "enable" : "disable",
+				     link->link_index, valid_query_count, state);
 			/* The command may have succeeded even though its state is unknown. */
 			link->psr_settings.psr_allow_active_valid = false;
+			if (recover_failed_exit)
+				dm_helpers_psr_failure(core_power->dc->ctx);
 			return false;
 		}
+
+		/* A state response confirms a command whose acknowledgment was lost. */
+		if (!programmed) {
+			link->psr_settings.psr_allow_active = psr_enable;
+			link->psr_settings.psr_allow_active_valid = true;
+		}
 	} else {
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
 							WPP_BIT_FLAG_Firmware_PsrState,
@@ -284,7 +315,7 @@ bool mod_power_set_psr_event(struct mod_power *mod_power,
 		return false;
 
 	link = dc_stream_get_link(stream);
-	if (!link)
+	if (!link || !link->psr_settings.psr_feature_enabled)
 		return false;
 
 	event_changed = (core_power->map[stream_index].psr_events & event) !=
@@ -396,6 +427,26 @@ bool mod_power_set_psr_event(struct mod_power *mod_power,
 	return true;
 }
 
+void mod_power_disable_psr_for_link(struct mod_power *mod_power,
+		const struct dc_link *link)
+{
+	struct core_power *core_power;
+	unsigned int i;
+
+	if (!mod_power || !link)
+		return;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	for (i = 0; i < core_power->num_entities; i++) {
+		if (!core_power->map[i].stream ||
+		    dc_stream_get_link(core_power->map[i].stream) != link)
+			continue;
+
+		core_power->map[i].psr_enabled = false;
+		core_power->map[i].psr_events |= psr_event_os_request_disable;
+	}
+}
+
 bool mod_power_get_psr_state(struct mod_power *mod_power,
 		const struct dc_stream_state *stream,
 		enum dc_psr_state *state)
-- 
2.54.0

