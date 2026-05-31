Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244B7CD6E56
	for <amd-gfx@archiver.kernel.org>; Sun, 31 May 2026 10:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F2510E615;
	Sun, 31 May 2026 10:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DadKndbS";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441F110E613
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 10:57:53 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so80499015e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780225072; x=1780829872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dy4fnQcj9NgWSo8EOuXiNqm7PMz6xPdp53DcXxo7wns=;
 b=DadKndbSF3tNEVV3oNPdgS+We4VrPkbR/K16QftcrJWgQNxLEcL35nyaPFNKr6eirc
 Wthno2pEbSAzklBqs73vu6htCQVpVyFA8fHTkg4gj8KEDjSC3BB+svB6TTFazlXhQasy
 bXkNFNovjDn8I0m8U4QXRPrUxHBg58aLCc+6/xcYiwHRE5yi3domyLUR5bH/N3mYexJp
 c0NIL7Fgp2dW44OShofK2AKqKcIZeSWSMyz9cAhOODJDsN0EHmfOtLwl7viSNJF72xf9
 bkzAzJrJczLRs9aftKHlpETHuyOEFFQ1tkEi8bmY4SnmwTPVWlDR688joga6gLGjYp5q
 QcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780225072; x=1780829872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dy4fnQcj9NgWSo8EOuXiNqm7PMz6xPdp53DcXxo7wns=;
 b=mcxj0EWo5xgqRrDc4hhIpEyz/D5uczyNwhYqKxv0wsT0CA2XOMrNnM0NKJSMx9fwWk
 V3gO0XPBfK9mh6vCkHBquhVHPa7JJDJWfyE3d5aaQD4vT2BmluKlPjCGm1v0p4MgCfqe
 BVmvkXJ6XXDxmRJphId+1UI7/ORcuCdoMU7vtThoQWtwc7fX2D8e9Ldas1g9cXc5Itto
 EpO8VQ0TWWQuc6Xu1I1UNrZDzbRMOW71jrOt0aDWKPz/Jb6ymhFTDhkwDtKXwwDTRFvc
 Ua94KXdmt/W0VP587J+fHhLXyIdhQf14zwg/uSv8VtfLyv7GZ8NJ8jQa7muFp3s2lgLU
 kDUg==
X-Gm-Message-State: AOJu0YxGU/byL0NH60PfQ6oiBIOrD9VPy85CAMlhWHabVF+KANotDLz+
 /G6iWygnFtshjJz+WKBiOtxwpPl1xgY77qlNDY8a2yN1I+9MtbYGuw5+DRiYQlNy
X-Gm-Gg: Acq92OGBArJ8lcN/eD8STSabDGUHilm1HLm5Xem2CsMK0CNuuGcUOJEJVcFxwTC/lHM
 cPqKsMbmcneqhHIVdq4PvG5uF8MD4EsImn4DjLg3JmMfN1+GiY13WziSs5fPap1khbekniWh2dZ
 tRd5U7SiipJ7zBsTSl82YIeH3q9Ql8HkYrlniNzZB0NJp7jgebiuXOJUPabSJhg51D6GL9kX2Z8
 xGo2hYqA+ZoUWJ8DrWyYKb7fmoXUO10LOApjlbp0tSpub7DAAfOl/HSD5QIrEFdjePi50CO2y8m
 B4m2cTV906Aw5lw2RJWJlHGh8ZJQcpKmA/pvCzI9SCu/FwYzwkzM8WDr2G3mHfe+GWTmsLrjxCA
 FtAKPXpKpWP1j4l9+0BZhlFx/ahaVTkI2sYMXRnvWvuheYI/7DN2P9t6UnODyRkEzr2EtJUhQ6/
 80E2JVPB2EnyDDf0P3fKYdgDkDJ5Iz0KzkKDsFgNB2SKiU+yjADwoJ4Ssm5YFOcqIWM+Cm6BGb0
 H/wX2uI9npx5wxsQLFkaflfVBM=
X-Received: by 2002:a05:600c:5254:b0:490:9e5b:9e31 with SMTP id
 5b1f17b1804b1-490a28c4156mr128189685e9.0.1780225071612; 
 Sun, 31 May 2026 03:57:51 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68980csm192904065e9.1.2026.05.31.03.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 03:57:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amd/display: Retry link detection on hotplug
Date: Sun, 31 May 2026 12:57:43 +0200
Message-ID: <20260531105744.28717-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531105744.28717-1-timur.kristof@gmail.com>
References: <20260531105744.28717-1-timur.kristof@gmail.com>
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

When dc_link_detect_connection_type thinks that a display is
connected, but dc_link_detect failed, enqueue delayed work to
retry the link detection again.

Useful when eg. HPD pin is high but the display isn't ready and
didn't respond to DDC.

- The display is "slow to wake up", ie. DDC isn't ready,
  for example we couldn't read EDID. Can happen with any
  connector type with certain "slow" displays.
  Some displays may take up to 15~20 sec or more to wake up.

- On hotplug, the HPD pin may make contact before the DDC pins,
  so we couldn't read the EDID. This most often happens with
  DVI connectors, rarely with HDMI. It is not impossible but
  extremely rare with other connector types.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137 ++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  16 ++
 2 files changed, 153 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 255903d000c2..8bda79c26288 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -158,6 +158,16 @@ MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
 #define FIRMWARE_DCN_42_DMUB "amdgpu/dcn_4_2_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
 
+/**
+ * define AMDGPU_DM_HPD_MAX_NUM_RETRIES - maximum amount of retries for hotplug detection
+ */
+#define AMDGPU_DM_HPD_MAX_NUM_RETRIES 5
+
+/**
+ * define AMDGPU_DM_HPD_RETRY_DELAY_MSEC - millisecond delay between hotplug detection retries
+ */
+#define AMDGPU_DM_HPD_RETRY_DELAY_MSEC 1500
+
 /**
  * DOC: overview
  *
@@ -956,6 +966,125 @@ static void dm_handle_hpd_work(struct work_struct *work)
 
 }
 
+/**
+ * dm_handle_delayed_hpd_work() - Handle delayed HPD (hotplug detection)
+ *
+ * @w: Base work item structure
+ *
+ * Used for retrying HPD after a delay. Just calls the normal HPD helper.
+ */
+static void dm_handle_delayed_hpd_work(struct work_struct *work)
+{
+	struct delayed_work *dw = container_of(work, struct delayed_work, work);
+	struct delayed_hpd_work *w = container_of(dw, struct delayed_hpd_work, work);
+	struct amdgpu_dm_connector *aconn = w->aconn;
+	enum dc_detect_reason reason = w->reason;
+
+	kfree(w);
+	handle_hpd_irq_helper(aconn, reason);
+}
+
+/**
+ * dm_cancel_delayed_hpd_work() - Cancel pending hotplug detection work for a connector
+ *
+ * @aconnector: Connector on which the HPD event occurred
+ */
+static void dm_cancel_delayed_hpd_work(struct amdgpu_dm_connector *aconnector)
+{
+	if (!aconnector || !aconnector->delayed_hpd_work)
+		return;
+
+	cancel_delayed_work(&aconnector->delayed_hpd_work->work);
+	aconnector->delayed_hpd_work = NULL;
+}
+
+/**
+ * dm_cancel_all_delayed_hpd_work() - Cancel all pending hotplug detection work on the device
+ *
+ * @dev: DRM device pointer
+ */
+static void dm_cancel_all_delayed_hpd_work(struct drm_device *dev)
+{
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		dm_cancel_delayed_hpd_work(to_amdgpu_dm_connector(connector));
+	}
+	drm_connector_list_iter_end(&iter);
+}
+
+/**
+ * dm_queue_delayed_hpd_work() - Enqueue delayed work to handle hotplug detection
+ *
+ * @aconnector: Connector on which the HPD event occurred
+ * @reason: Reason why we are attempting the HPD
+ * @msecs: Millisecond delay after which the delayed work is going to happen
+ *
+ * When dc_link_detect_connection_type thinks that a display is connected,
+ * but dc_link_detect failed, enqueue delayed work to retry the link
+ * detection again.
+ *
+ * Useful when eg. HPD pin is high but the display isn't ready and
+ * didn't respond to DDC.
+ *
+ * - On boot or suspend/resume, the display is "slow to wake up",
+ *   ie. DDC isn't ready, for example we couldn't read DP link caps or EDID.
+ *   Can happen to any connector with certain "slow" displays.
+ *
+ * - On hotplug, the HPD pin may make contact before the DDC pins,
+ *   so we couldn't read the EDID. Can happen to any connector but
+ *   most often to DVI and sometimes to HDMI (rarely to DP).
+ *
+ */
+static void dm_queue_delayed_hpd_work(struct amdgpu_dm_connector *aconnector,
+				      const enum dc_detect_reason reason,
+				      const unsigned int msecs)
+{
+	struct drm_device *dev = aconnector->base.dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct delayed_hpd_work *w;
+
+	if (!aconnector || !aconnector->dc_link ||
+	    aconnector->dc_link->type == dc_connection_none)
+		return;
+
+	/* Don't retry polled connectors, the polling is going to detect it. */
+	if (aconnector->base.polled != DRM_CONNECTOR_POLL_HPD)
+		return;
+
+	++aconnector->num_hpd_retries;
+
+	drm_dbg(dev, "Can't detect link on %s on try %d\n",
+		aconnector->base.name, aconnector->num_hpd_retries);
+
+	if (aconnector->num_hpd_retries > AMDGPU_DM_HPD_MAX_NUM_RETRIES) {
+		drm_warn(dev, "Too many retries on %s: %d, giving up\n",
+			 aconnector->base.name, aconnector->num_hpd_retries);
+		aconnector->num_hpd_retries = 0;
+		return;
+	}
+
+	w = kzalloc(sizeof(*w), GFP_ATOMIC);
+
+	if (!w)
+		return;
+
+	INIT_DELAYED_WORK(&w->work, dm_handle_delayed_hpd_work);
+	w->aconn = aconnector;
+	w->reason = reason;
+	aconnector->delayed_hpd_work = w;
+
+	drm_warn(dev, "Enqueueing next retry on %s\n",
+		 aconnector->base.name);
+	queue_delayed_work(adev->dm.delayed_hpd_wq, &w->work,
+			   msecs_to_jiffies(msecs));
+}
+
 static const char *dmub_notification_type_str(enum dmub_notification_type e)
 {
 	switch (e) {
@@ -3194,6 +3323,7 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	dm_cancel_all_delayed_hpd_work(&adev->ddev);
 	amdgpu_dm_hpd_fini(adev);
 
 	amdgpu_dm_irq_fini(adev);
@@ -3367,6 +3497,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
 
+	dm_cancel_all_delayed_hpd_work(&adev->ddev);
+
 	if (amdgpu_in_reset(adev)) {
 		enum dc_status res;
 
@@ -4396,6 +4528,9 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 			if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
 			    reason == DETECT_REASON_HPDRX)
 				drm_kms_helper_connector_hotplug_event(connector);
+		} else {
+			dm_queue_delayed_hpd_work(aconnector, reason,
+						  AMDGPU_DM_HPD_RETRY_DELAY_MSEC);
 		}
 	}
 }
@@ -4404,6 +4539,8 @@ static void handle_hpd_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 
+	/* Cancel any pending work */
+	dm_cancel_delayed_hpd_work(aconnector);
 	handle_hpd_irq_helper(aconnector, DETECT_REASON_HPD);
 
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 43056392a1f0..c11633dbd792 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -136,6 +136,18 @@ struct dmub_hpd_work {
 	struct amdgpu_device *adev;
 };
 
+/**
+ * struct delayed_hpd_work - Handle delayed HPD (hot plug detection) work
+ *
+ * @work: Base structure, kernel work data for the work event
+ * @aconn: Pointer to connector where the HPD event happened
+ */
+struct delayed_hpd_work {
+	struct delayed_work work;
+	struct amdgpu_dm_connector *aconn;
+	enum dc_detect_reason reason;
+};
+
 /**
  * struct vblank_control_work - Work data for vblank control
  * @work: Kernel work data for the work event
@@ -793,6 +805,10 @@ struct amdgpu_dm_connector {
 	/* number of modes generated from EDID at 'dc_sink' */
 	int num_modes;
 
+	/* number of retries on hot plug detection */
+	int num_hpd_retries;
+	struct delayed_hpd_work *delayed_hpd_work;
+
 	/* The 'old' sink - before an HPD.
 	 * The 'current' sink is in dc_link->sink. */
 	struct dc_sink *dc_sink;
-- 
2.54.0

