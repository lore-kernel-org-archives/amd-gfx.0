Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7ED606A9FF
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Nov 2026 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qBCSTutG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027EB10E618;
	Sat,  7 Nov 2026 15:04:14 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8844410E4A0
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Nov 2026 00:24:33 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3adac5c10e3so692887a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2026 16:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794011073; x=1794615873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hUskwA/EcCcZDMSyv+dceRfuLZwL52trWfJZjAyLVHY=;
 b=qBCSTutGG83kAtZ6vmMZa1mCBWDh3nBR4b0a3777F101r9zHqN2csha4jvIIt+fFOQ
 bNYkOFGbwLJwPPf1InKhy0dcGhJLop7+vf702EZr/d/oiKnX5nh5gyqW+lfUYP2ueGRL
 XR9pmgHOvCjFacOF8ZORt7UXjfv8uW9S9rZ4C5hNf6ztFMizc4qk7WhavQkHY2fAuB+c
 drtogR8sFmW+LNaw3Gb9AI4iDzMlghE4IEkfoGajDPnZpAyvO4GaAen1iLcC3O6GObJm
 XBV4zOpGaF7go5byj//SvlGZqnUEcqJRhn9AFexCZiYQdoyFM3FqCa+8GfHZv9J0izHh
 KoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794011073; x=1794615873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hUskwA/EcCcZDMSyv+dceRfuLZwL52trWfJZjAyLVHY=;
 b=jAU0DS0Pb9s7N+es/UQ2XMho3BsmWr1BDonuBuyNDWyj+SHvYayeamByzIfrK5NXC6
 3RHYRHx35M1vKGdFIPbhCei/e5oFS7yttfnueelW9Hh4lCiGBlVfDc4ZFFeE9ntCrYLG
 wA/QtNXQSX7+z7FRtHciZUEQH58xe9MV6A8Nai6ZDKlXB+BRhHO2/2PH1neFOsF2zCXo
 lLG+FPF77K7kBpenA596+Vyyrrgwu4W7SlUxpCobM215l2pMf3Qz0aeTKfFJWGS/kjfN
 qaNA4+BNn60bm8gr1Pl18A/mfLahicq3AqKSJfPT2+DkxTj0gzG7H14E54PB1VamVrta
 3Y8w==
X-Gm-Message-State: APuU4Z/XVvkiG15t+7ci9keYIsBZj01Wz8HbUkuQ3Vw7hPCkkURxXpv3
 Ndouaq40NSHEcn9jGUdiFo7ByR262Q0+Y1k8PShOG4SpREBMdl2G17PzqUaxpZZ2hShkbQ==
X-Gm-Gg: AYBFou0/q0rk3FbWNxZHh0q8abXnFscCvwMTAfJ+hEKIKwUqxT4PBcYSeI7uQBJq187
 sBE5EkWfERWvkbkeEz6nt+l6zNTDqA2Ztch1bPs2Lx5S4bFoBW3GbECj/seLrXrSK/68rAf+rW9
 sT+sP39GnVNb1eh1AANx+yrO/OGjeE0aePEr059202XWhjp1IYC5B6SknMDRZqNarnJsa3RUYtM
 +e372yNl79lQ/E4V7wep/344buqemwSCZwMuKTeTUdh5Yzcf5Yqkzr03G2yAs/fAOfNZxMW+U3z
 3cZuJ5Pl9cSbgR3afZIzyyIzZVLMjB6FhRaNSH8kxtZaRV7aEvk01IdRnuTQkFQSBI9Qmb9dQca
 xma5tyCCT26j9SXANRyhW6t90LnpIQLiMAT1hlVjefXpUIvb9IuQyNhxjWwpumX8UAgJ3dwnlbu
 dCieYgC68DgXobijxRMBR6ODj+R0pn2q3fcgO0DPIrQKOQW1m9unfd6FRwsucTvSnxf9YQjmYHo
 Dmf+7MiFM9frT2MvEQj/AUBSK5oatQyXXWqXRUHq0B9lUcKzVNyce4S2QPE4iALQZ0r6j0UkHiR
 aJlFvJL5amJDYcF9acgU5xbIfu/nkmGayjqmRh83hPrQj2wRPC0ixGTR6uXQVg884FLhrBi2XXD
 Zh1Zy
X-Received: by 2002:a17:90b:568e:b0:3ac:9176:e837 with SMTP id
 98e67ed59e1d1-3b0db709142mr3731233a91.50.1794011072822; 
 Fri, 06 Nov 2026 16:24:32 -0800 (PST)
Received: from evo ([183.171.191.8]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b101bc56fbsm563024a91.2.2026.11.06.16.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 16:24:32 -0800 (PST)
From: Ambareesh Balaji <ambareeshbalaji@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Ambareesh Balaji <ambareeshbalaji@gmail.com>
Subject: [PATCH] drm/amd/display: Restart DP stream if the sink doesn't lock
 onto it
Date: Sat,  7 Nov 2026 00:24:15 +0000
Message-ID: <20261107002415.15241-1-ambareeshbalaji@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 15:04:12 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Link training succeeding does not mean that the sink has locked onto the
video stream that follows. Some sinks, e.g. the XREAL Air 2 Pro, are not
ready to do so for a while after HPD. If the stream starts too early they
stay black until the stream is restarted, even though link training
passes and lane status is fine. They report this through DPCD
SINK_STATUS (RECEIVE_PORT_0_STATUS stays clear). With the display
manager starting the modeset right after HPD, this happens on most
replugs.

After a modeset on a DP SST link, poll SINK_STATUS. If the sink doesn't
report being in sync within a second, restart the stream the same way as
on link loss, and keep polling. The number of restarts is limited per
connection (reset on HPD, not on HPD RX), so a sink that never reports
sync isn't restarted forever.

No fixed delay is added to the normal path: sinks that lock on in time
are never touched.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6101
Signed-off-by: Ambareesh Balaji <ambareeshbalaji@gmail.com>
---
Tested on Strix Halo with an XREAL Air 2 Pro, on 7.3.1 (the patch applies
unchanged there). Without it the glasses stay black after nearly every
replug. With it, all 30 test replugs recovered, none needed more than
one restart.

Captures (DPCD, ftrace, HPD/USB timing) are in the issue linked above.
In short: HPD, link training and lane/alignment status look the same on
good and bad attempts, and nothing in DPCD changes when the glasses become
able to lock. Only SINK_STATUS differs afterwards. Skipping detection-time
link training (DC_SKIP_DETECTION_LT) doesn't help.

Open questions:
- Are the 1 s timeout and the limit of 4 restarts acceptable, or would you
  prefer different values?
- Would you rather have this as a per-sink quirk than for all DP SST sinks?
- Is there a better place to hook this, e.g. in DMUB or the HPD path?

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 +++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 ++
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 71 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  6 ++
 .../drm/amd/display/dc/core/dc_link_exports.c |  5 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  7 ++
 .../gpu/drm/amd/display/dc/inc/link_service.h |  1 +
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../dc/link/protocols/link_dp_irq_handler.c   | 16 +++++
 .../dc/link/protocols/link_dp_irq_handler.h   |  1 +
 11 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 33c73ca9cff1..915399cf0a18 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4759,6 +4759,15 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 			break;
 		}
 	}
+	if (mode_set_reset_required) {
+		for (i = 0; i < params.stream_count; i++) {
+			struct dc_stream_state *stream = params.streams[i];
+
+			if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT && stream->dm_stream_context)
+				amdgpu_dm_dp_sink_sync_start(stream->dm_stream_context);
+		}
+	}
+
 	if (frl_stream_found) {
 		if (queue_delayed_work(dm->hdmi_frl_status_polling_wq,
 				       &dm->hdmi_frl_status_polling_work,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f8503ebf28f4..112c2781aacf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -931,6 +931,11 @@ struct amdgpu_dm_connector {
 
 	/* HDMI compliance automation */
 	bool hdmi_comp_auto;
+
+	/* DP sink sync watchdog, see amdgpu_dm_dp_sink_sync_work() */
+	struct delayed_work sink_sync_work;
+	unsigned int sink_sync_waited_ms;
+	unsigned int sink_sync_retrains;
 };
 
 static inline void amdgpu_dm_set_mst_status(uint8_t *status,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index e8f050feb6e3..f56261978038 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2011,6 +2011,8 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
 	if (aconnector->mst_mgr.dev)
 		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
 
+	cancel_delayed_work_sync(&aconnector->sink_sync_work);
+
 	/* Cancel and flush any pending HDMI HPD debounce work */
 	if (aconnector->hdmi_hpd_debounce_delay_ms) {
 		cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
@@ -3283,6 +3285,73 @@ void hdmi_frl_status_polling_work(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(hdmi_frl_status_polling_work);
 
+/*
+ * DOC: DP sink sync watchdog
+ *
+ * Link training succeeding does not mean that the sink has locked onto the
+ * video stream that follows. Some sinks (e.g. XREAL Air 2 Pro) are not ready
+ * to do so right after HPD and then stay blank, reporting through DPCD
+ * SINK_STATUS that they are not in sync, until the stream is restarted.
+ *
+ * After a modeset on a DP SST link, poll that status. If the sink doesn't
+ * report sync within AMDGPU_DM_DP_SINK_SYNC_TIMEOUT_MS, restart the stream the
+ * same way as on link loss. The number of restarts is limited per connection,
+ * so sinks that never report sync are not restarted forever.
+ */
+#define AMDGPU_DM_DP_SINK_SYNC_POLL_MS		100
+#define AMDGPU_DM_DP_SINK_SYNC_TIMEOUT_MS	1000
+#define AMDGPU_DM_DP_SINK_SYNC_MAX_RETRAINS	4
+
+void amdgpu_dm_dp_sink_sync_work(struct work_struct *work)
+{
+	struct amdgpu_dm_connector *aconnector =
+		container_of(to_delayed_work(work), struct amdgpu_dm_connector,
+			     sink_sync_work);
+	struct amdgpu_display_manager *dm = &drm_to_adev(aconnector->base.dev)->dm;
+	struct dc_link *link = aconnector->dc_link;
+	bool keep_polling = false;
+
+	scoped_guard(mutex, &dm->dc_lock) {
+		dc_exit_ips_for_hw_access(dm->dc);
+
+		if (!dc_link_dp_is_sink_out_of_sync(link))
+			return;
+
+		aconnector->sink_sync_waited_ms += AMDGPU_DM_DP_SINK_SYNC_POLL_MS;
+		keep_polling = true;
+
+		if (aconnector->sink_sync_waited_ms >= AMDGPU_DM_DP_SINK_SYNC_TIMEOUT_MS) {
+			aconnector->sink_sync_waited_ms = 0;
+
+			if (aconnector->sink_sync_retrains >= AMDGPU_DM_DP_SINK_SYNC_MAX_RETRAINS) {
+				drm_dbg_kms(aconnector->base.dev,
+					    "[CONNECTOR:%d:%s] sink not in sync, giving up\n",
+					    aconnector->base.base.id, aconnector->base.name);
+				return;
+			}
+
+			aconnector->sink_sync_retrains++;
+			drm_dbg_kms(aconnector->base.dev,
+				    "[CONNECTOR:%d:%s] sink not in sync, restarting stream (%u)\n",
+				    aconnector->base.base.id, aconnector->base.name,
+				    aconnector->sink_sync_retrains);
+			dc_link_dp_handle_link_loss(link);
+		}
+	}
+
+	if (keep_polling)
+		queue_delayed_work(system_percpu_wq, &aconnector->sink_sync_work,
+				   msecs_to_jiffies(AMDGPU_DM_DP_SINK_SYNC_POLL_MS));
+}
+EXPORT_IF_KUNIT(amdgpu_dm_dp_sink_sync_work);
+
+void amdgpu_dm_dp_sink_sync_start(struct amdgpu_dm_connector *aconnector)
+{
+	aconnector->sink_sync_waited_ms = 0;
+	mod_delayed_work(system_percpu_wq, &aconnector->sink_sync_work,
+			 msecs_to_jiffies(AMDGPU_DM_DP_SINK_SYNC_POLL_MS));
+}
+
 void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				     struct amdgpu_dm_connector *aconnector,
 				     int connector_type,
@@ -3327,6 +3396,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		aconnector->hdmi_hpd_debounce_delay_ms = 0;
 	}
 
+	INIT_DELAYED_WORK(&aconnector->sink_sync_work, amdgpu_dm_dp_sink_sync_work);
+
 	dm->hdmi_frl_status_polling_delay_ms = 200;
 	INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
 	/*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 7bfbb6853833..6f5d60c0eb98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -72,6 +72,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				     int link_index);
 
 void hdmi_frl_status_polling_work(struct work_struct *work);
+void amdgpu_dm_dp_sink_sync_work(struct work_struct *work);
+void amdgpu_dm_dp_sink_sync_start(struct amdgpu_dm_connector *aconnector);
 
 enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
 						    const struct drm_display_mode *mode);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 5b4ff079cd55..6b7ac030c6cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1395,6 +1395,12 @@ STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnect
 
 	aconnector->timing_changed = false;
 
+	if (reason != DETECT_REASON_HPDRX) {
+		/* New connection, or a replug: start over with a fresh retrain budget */
+		cancel_delayed_work(&aconnector->sink_sync_work);
+		aconnector->sink_sync_retrains = 0;
+	}
+
 	if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
 		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 5926e8a4f95a..f9f065b66757 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -424,6 +424,11 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 	link->dc->link_srv->dp_handle_link_loss(link);
 }
 
+bool dc_link_dp_is_sink_out_of_sync(struct dc_link *link)
+{
+	return link->dc->link_srv->dp_is_sink_out_of_sync(link);
+}
+
 enum dc_status dc_link_dp_read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 916fa87d0dbc..05e90ba60e85 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2641,6 +2641,13 @@ void dc_link_dp_handle_automated_test(struct dc_link *link);
  */
 void dc_link_dp_handle_link_loss(struct dc_link *link);
 
+/* Check whether a DP SST stream is being sent on the link but the sink does
+ * not report (DPCD SINK_STATUS) being synchronized with it. Some sinks need
+ * more time than link training takes to lock onto the video stream and then
+ * stay blank until the stream is restarted.
+ */
+bool dc_link_dp_is_sink_out_of_sync(struct dc_link *link);
+
 /* Determine if hpd rx irq should be handled or ignored
  * return true - hpd rx irq should be handled.
  * return false - it is safe to ignore hpd rx irq event
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index b2f86c51d470..03faca2fa3d7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -242,6 +242,7 @@ struct link_service {
 		union hpd_irq_data *hpd_irq_dpcd_data);
 	bool (*dp_should_allow_hpd_rx_irq)(const struct dc_link *link);
 	void (*dp_handle_link_loss)(struct dc_link *link);
+	bool (*dp_is_sink_out_of_sync)(struct dc_link *link);
 	enum dc_status (*dp_read_hpd_rx_irq_data)(
 		struct dc_link *link,
 		union hpd_irq_data *irq_data);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 3b192c539f8b..829c0b07634b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -195,6 +195,7 @@ static void construct_link_service_dp_irq_handler(struct link_service *link_srv)
 	link_srv->dp_parse_link_loss_status = dp_parse_link_loss_status;
 	link_srv->dp_should_allow_hpd_rx_irq = dp_should_allow_hpd_rx_irq;
 	link_srv->dp_handle_link_loss = dp_handle_link_loss;
+	link_srv->dp_is_sink_out_of_sync = dp_is_sink_out_of_sync;
 	link_srv->dp_read_hpd_rx_irq_data = dp_read_hpd_rx_irq_data;
 	link_srv->dp_handle_hpd_rx_irq = dp_handle_hpd_rx_irq;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index da679fb7d89c..d26b519fe6c6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -348,6 +348,22 @@ void dp_handle_link_loss(struct dc_link *link)
 	}
 }
 
+bool dp_is_sink_out_of_sync(struct dc_link *link)
+{
+	struct pipe_ctx *pipes[MAX_PIPES];
+	uint8_t count;
+	uint8_t sink_status = 0;
+
+	link_get_master_pipes_with_dpms_on(link, link->dc->current_state, &count, pipes);
+	if (!count || pipes[0]->stream->signal != SIGNAL_TYPE_DISPLAY_PORT)
+		return false;
+
+	if (core_link_read_dpcd(link, DP_SINK_STATUS, &sink_status, 1) != DC_OK)
+		return false;
+
+	return !(sink_status & DP_RECEIVE_PORT_0_STATUS);
+}
+
 static void dp_handle_tunneling_irq(struct dc_link *link)
 {
 	enum dc_status retval;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h
index 87516fb3b45a..e4aabf679863 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h
@@ -32,6 +32,7 @@ bool dp_parse_link_loss_status(
 	union hpd_irq_data *hpd_irq_dpcd_data);
 bool dp_should_allow_hpd_rx_irq(const struct dc_link *link);
 void dp_handle_link_loss(struct dc_link *link);
+bool dp_is_sink_out_of_sync(struct dc_link *link);
 enum dc_status dp_read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data);

base-commit: 178d00b16ddbb5962adbbe2c486204b0b6a4b9f0
-- 
2.56.0

