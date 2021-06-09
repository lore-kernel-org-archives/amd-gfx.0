Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B0BC48BCF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A55761059
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A55761059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490F56E56A;
	Wed,  9 Jun 2021 10:49:32 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933636E56A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 10:49:31 +0000 (UTC)
Received: from mail-03.mail-europe.com (mail-0301.mail-europe.com
 [188.165.51.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4G0NsJ12lMz4xMPn
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 10:39:48 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="Pi7iGYmS"
Date: Wed, 09 Jun 2021 10:39:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623235183;
 bh=+2TgIcQOpe6dmWJy4MxbUcLVMP5RuX6A82OSZZa8ORY=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=Pi7iGYmSfYfaYs1o5JNqp8FdwXs+yL+xd0OdSBJr4pvv6S574S9npdkIArENoX/Sg
 Fbdf45XLvDHgIzCfukGH3q7x5obj2BX6wwHjelIMdii7xfASQpZE4bHXhCvQDT+aK2
 ssHjM7A8EvHX75Ave7iocYcstYwJRzVaml95y8xsymoMgD2FTkOYtreKI5C0V5r/fc
 SZs3TWIt1bkZTJNh2fjgU1mDsKzY1y6xWfwxY6V8ES9WpJwwC7UfY/9N2hgq9bD4ng
 0Wlo1H1V+v4Pq7mudEzBHAhm+Tpp8t+0TvfsO/DDbbPf6BarjQMTjjRE3MktbdF2iz
 8qSbV4G06+W1A==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 4/4] amdgpu: use drm_kms_helper_connector_hotplug_event
Message-ID: <li38b1HfAYOhHkfxh32ZBS5r8Ounqzgw4wTOk2E@cp4-web-028.plabs.ch>
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

When updating a single connector, use
drm_kms_helper_connector_hotplug_event instead of
drm_kms_helper_hotplug_event.

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 8 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3267eb2e35dd..4b91534ff324 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2638,7 +2638,7 @@ static void handle_hpd_irq(void *param)
 		drm_modeset_unlock_all(dev);
 
 		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
-			drm_kms_helper_hotplug_event(dev);
+			drm_kms_helper_connector_hotplug_event(connector);
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
 		if (new_connection_type == dc_connection_none &&
@@ -2652,7 +2652,7 @@ static void handle_hpd_irq(void *param)
 		drm_modeset_unlock_all(dev);
 
 		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
-			drm_kms_helper_hotplug_event(dev);
+			drm_kms_helper_connector_hotplug_event(connector);
 	}
 	mutex_unlock(&aconnector->hpd_lock);
 
@@ -2805,7 +2805,7 @@ static void handle_hpd_rx_irq(void *param)
 			dm_restore_drm_connector_state(dev, connector);
 			drm_modeset_unlock_all(dev);
 
-			drm_kms_helper_hotplug_event(dev);
+			drm_kms_helper_connector_hotplug_event(connector);
 		} else if (dc_link_detect(dc_link, DETECT_REASON_HPDRX)) {
 
 			if (aconnector->fake_enable)
@@ -2818,7 +2818,7 @@ static void handle_hpd_rx_irq(void *param)
 			dm_restore_drm_connector_state(dev, connector);
 			drm_modeset_unlock_all(dev);
 
-			drm_kms_helper_hotplug_event(dev);
+			drm_kms_helper_connector_hotplug_event(connector);
 		}
 	}
 #ifdef CONFIG_DRM_AMD_DC_HDCP
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 9fbbd0159119..221242b6e528 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1200,7 +1200,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 		dm_restore_drm_connector_state(dev, connector);
 		drm_modeset_unlock_all(dev);
 
-		drm_kms_helper_hotplug_event(dev);
+		drm_kms_helper_connector_hotplug_event(connector);
 	} else if (param[0] == 0) {
 		if (!aconnector->dc_link)
 			goto unlock;
@@ -1222,7 +1222,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 		dm_restore_drm_connector_state(dev, connector);
 		drm_modeset_unlock_all(dev);
 
-		drm_kms_helper_hotplug_event(dev);
+		drm_kms_helper_connector_hotplug_event(connector);
 	}
 
 unlock:
-- 
2.31.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
