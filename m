Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFD2C48BCF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875866139A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875866139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0236EAE2;
	Wed,  9 Jun 2021 21:24:09 +0000 (UTC)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C079C6EB3C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 21:24:08 +0000 (UTC)
Date: Wed, 09 Jun 2021 21:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623273847;
 bh=D+ACLAmLPQ5dBv9UiHgwR4PZFqis8ssRuE9zja0/b20=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=hQBhLhVmqv1cyqvqr2JDFuq5p9TAS81wiRGwfJikG0bFfgXPU3906hromnuCmSj4Q
 F5sgltxwWTv8ROLXQnh7Q2UE3PcOziWxBP/bIRQ7EtmEdbGQobgieciRnD7o21/y+2
 9sW+pyDVe4MMVFsXDWwu1+cJqRGal6ac87Ri8UldQkPLkEaSyjjbAvU9cntZebnQe4
 geGAIgr2AIiN4WIymH9/GcKp1uWPCMaU8kCICDq2Hk93NNNy11vPyuu7OcwUtp2SFz
 /idqalXq5cUIihAZzl6bd8RAO+zrC8rMi7GB+ScOn9OSLVBybcKOkntBG6z8NKkWJ7
 9vGOpfXmBqdew==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v2 5/7] drm/probe-helper: use
 drm_kms_helper_connector_hotplug_event
Message-ID: <cSqLvJmgHix8R8X5lp2E2h6Z8zLOKxDkLfkm8mL3Zg@cp3-web-029.plabs.ch>
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
 daniel@ffwll.ch, alexander.deucher@amd.com, harry.wentland@amd.com,
 intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If an hotplug event only updates a single connector, use
drm_kms_helper_connector_hotplug_event instead of
drm_kms_helper_hotplug_event.

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/drm_probe_helper.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 8cc673267cba..f4130c1a90e2 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -843,7 +843,7 @@ EXPORT_SYMBOL(drm_kms_helper_poll_fini);
  */
 bool drm_helper_hpd_irq_event(struct drm_device *dev)
 {
-	struct drm_connector *connector;
+	struct drm_connector *connector, *changed_connector = NULL;
 	struct drm_connector_list_iter conn_iter;
 	enum drm_connector_status old_status;
 	bool changed = false;
@@ -883,16 +883,27 @@ bool drm_helper_hpd_irq_event(struct drm_device *dev)
 		 * Check if epoch counter had changed, meaning that we need
 		 * to send a uevent.
 		 */
-		if (old_epoch_counter != connector->epoch_counter)
+		if (old_epoch_counter != connector->epoch_counter) {
+			if (changed) {
+				if (changed_connector)
+					drm_connector_put(changed_connector);
+				changed_connector = NULL;
+			} else {
+				drm_connector_get(connector);
+				changed_connector = connector;
+			}
 			changed = true;
+		}
 
 	}
 	drm_connector_list_iter_end(&conn_iter);
 	mutex_unlock(&dev->mode_config.mutex);
 
-	if (changed) {
+	if (changed_connector) {
+		drm_kms_helper_connector_hotplug_event(changed_connector);
+		drm_connector_put(changed_connector);
+	} else if (changed) {
 		drm_kms_helper_hotplug_event(dev);
-		DRM_DEBUG_KMS("Sent hotplug event\n");
 	}
 
 	return changed;
-- 
2.31.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
