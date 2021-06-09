Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921ADC48BD1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5860A613EE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5860A613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51936EB2A;
	Wed,  9 Jun 2021 21:24:01 +0000 (UTC)
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch
 [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABB46E409;
 Wed,  9 Jun 2021 21:24:00 +0000 (UTC)
Date: Wed, 09 Jun 2021 21:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623273837;
 bh=+2TgIcQOpe6dmWJy4MxbUcLVMP5RuX6A82OSZZa8ORY=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=dZWWIo10Q2abgozgfk99fXufl469DDRbzNJg21EOrlRZCLDw+t1jaUbAKoE+8kPp7
 txwEtG60zIFryW9X5/tqOoiuNSjglmRKyGpkMDFQIKyRpKhQSzWx1qOTZzZcWmNZAo
 +xcvNQbS1ZujELOScfMpnlX3e1QGLoNg5tuLPuEb92+iW8MUKjYHJy3Xv2OUZG/5jR
 RMlIxuNLc8y1W5vQ702bTI/cLSoPzLJ09IEsn4AW90gs+XMKq6k4mpWn4mVZGobv3J
 OpDBkTia2zs1KGEQ9bW2ijtgRwyxZh2fzlKcrvCGZ3kgR7Zjl8Pg2csDBpVzihbU3k
 I9OggJHNMjvMg==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v2 4/7] amdgpu: use drm_kms_helper_connector_hotplug_event
Message-ID: <9EHiZemzDlTsVgq94MyyJvPwfH6OOcK7UR8RsDCr2GE@cp3-web-033.plabs.ch>
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
