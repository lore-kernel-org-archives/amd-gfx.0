Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CFBC48BD1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A99608FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A99608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458C26E517;
	Wed,  9 Jun 2021 10:39:32 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch
 [185.70.40.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2086E0C2;
 Wed,  9 Jun 2021 10:39:30 +0000 (UTC)
Date: Wed, 09 Jun 2021 10:39:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623235168;
 bh=hedE0JjbpZoNUwShmgNyyeuPFv8kbVONKT78BK3g7PU=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=EDzwYhDomx5qTPQJkMt//ArpOJQrxy+5RJBoRXzkBPXBNJfZRkogsz+eup7BB+HLm
 0N8P6jpPMFGTS8F822gNAbiYOmUJCRjRSaVvINPH/w/YPUy31DgvYrzpoSOF0rLnO7
 5rIPcds29gu7OPsTJYcyC8bYHi4KuPFIooZrBd4cA9Roqv8IEujFK/cfE7FbE0QLR8
 RLxuS1kI7SSfsAnmjQ8oxk0eUxKStrx+Q8TOujbzVlIt+gNebyZLhDT0gTZKRA54vh
 hLwZ/INUBYts5YVH5XdU12WQ0QGV1xnG/7lclHkuSvKNHfisF9jpDbQl9B397cEdzb
 5TKCFPgzM5kJA==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 2/4] drm/probe-helper: add
 drm_kms_helper_connector_hotplug_event
Message-ID: <XCqV2rWILN8kzAmXWxJoFie29MNLKiENn7TGa0MG1w@cp3-web-016.plabs.ch>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: pekka.paalanen@collabora.com, michel@daenzer.net, daniel@fooishbar.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This function is the same as drm_kms_helper_hotplug_event, but takes
a connector instead of a device.

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/drm_probe_helper.c | 20 ++++++++++++++++++++
 include/drm/drm_probe_helper.h     |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index e7e1ee2aa352..510807a4a492 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -616,6 +616,26 @@ void drm_kms_helper_hotplug_event(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_kms_helper_hotplug_event);
 
+/**
+ * drm_kms_helper_connector_hotplug_event - fire off a KMS connector hotplug event
+ * @connector: drm_connector which has changed
+ *
+ * This is the same as drm_kms_helper_hotplug_event(), except it fires a more
+ * fine-grained uevent for a single connector.
+ */
+void drm_kms_helper_connector_hotplug_event(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+
+	/* send a uevent + call fbdev */
+	drm_sysfs_connector_hotplug_event(connector);
+	if (dev->mode_config.funcs->output_poll_changed)
+		dev->mode_config.funcs->output_poll_changed(dev);
+
+	drm_client_dev_hotplug(dev);
+}
+EXPORT_SYMBOL(drm_kms_helper_connector_hotplug_event);
+
 static void output_poll_execute(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
diff --git a/include/drm/drm_probe_helper.h b/include/drm/drm_probe_helper.h
index 8d3ed2834d34..733147ea89be 100644
--- a/include/drm/drm_probe_helper.h
+++ b/include/drm/drm_probe_helper.h
@@ -19,6 +19,7 @@ void drm_kms_helper_poll_init(struct drm_device *dev);
 void drm_kms_helper_poll_fini(struct drm_device *dev);
 bool drm_helper_hpd_irq_event(struct drm_device *dev);
 void drm_kms_helper_hotplug_event(struct drm_device *dev);
+void drm_kms_helper_connector_hotplug_event(struct drm_connector *connector);
 
 void drm_kms_helper_poll_disable(struct drm_device *dev);
 void drm_kms_helper_poll_enable(struct drm_device *dev);
-- 
2.31.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
