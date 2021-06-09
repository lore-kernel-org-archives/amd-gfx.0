Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A652AC48BCF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7609F608FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7609F608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DAFB6E15A;
	Wed,  9 Jun 2021 10:39:31 +0000 (UTC)
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F9D06E15A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 10:39:30 +0000 (UTC)
Received: from mail-03.mail-europe.com (mail-0301.mail-europe.com
 [188.165.51.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-41104.protonmail.ch (Postfix) with ESMTPS id 4G0Nrw41Rqz4xHJ8;
 Wed,  9 Jun 2021 10:39:28 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="eaBTVDmh"
Date: Wed, 09 Jun 2021 10:39:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623235164;
 bh=h0rozdH40IzsogPIhwMBG0dTerXtw+4mOOIyo/7gKbs=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=eaBTVDmhlubb8Tu5vnQ1cANI3GKE0cRN1lgPDu4+zG6ZYQ8AJXCKc8dSjAQg620t4
 rvFkIqLf7a21QovVU/V418kQ8Ezi9AiH/GOjqBj+/6sfQRzRv7bl1ZQlMzThp2DEzK
 limxsx+/oHLCsrAbE7uheBluHG+P0/VY6JvfhZeG7DEvWaFlSzXsFSA9Dxd1zPEmzI
 rx9vtp2PjIKzVk9n0b9yPoUsKx1zAHpq3lNzVsy3wpr2cv1qb/0TO5suvFvniwvCWv
 LSxJnIU+nxXIAC94LPrCZuQuvp3Hq9B1gpm3O0E2H6bpJgKVhJO2q6zkIFb8cyhzHM
 dDLZJImPq+jkA==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 1/4] drm/sysfs: introduce drm_sysfs_connector_hotplug_event
Message-ID: <mpYHCnsBfIaxJEM7yrUVKKcVHXnFDEUtoK5NbmwA@cp4-web-034.plabs.ch>
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

This function sends a hotplug uevent with a CONNECTOR property.

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/drm_sysfs.c | 25 +++++++++++++++++++++++++
 include/drm/drm_sysfs.h     |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 968a9560b4aa..6b52a53c0c3e 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -343,6 +343,31 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_sysfs_hotplug_event);
 
+/**
+ * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any connector
+ * change
+ * @connector: connector which has changed
+ *
+ * Send a uevent for the DRM connector specified by @connector. This will send
+ * a uevent with the properties HOTPLUG=1 and CONNECTOR.
+ */
+void drm_sysfs_connector_hotplug_event(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	char hotplug_str[] = "HOTPLUG=1", conn_id[21];
+	char *envp[] = { hotplug_str, conn_id, NULL };
+
+	snprintf(conn_id, ARRAY_SIZE(conn_id),
+		 "CONNECTOR=%u", connector->base.id);
+
+	drm_dbg(connector->dev,
+		"generating hotplug event for [CONNECTOR:%d:%s]\n",
+		connector->base.id, connector->name);
+
+	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
+}
+EXPORT_SYMBOL(drm_sysfs_connector_hotplug_event);
+
 /**
  * drm_sysfs_connector_status_event - generate a DRM uevent for connector
  * property status change
diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
index d454ef617b2c..6273cac44e47 100644
--- a/include/drm/drm_sysfs.h
+++ b/include/drm/drm_sysfs.h
@@ -11,6 +11,7 @@ int drm_class_device_register(struct device *dev);
 void drm_class_device_unregister(struct device *dev);
 
 void drm_sysfs_hotplug_event(struct drm_device *dev);
+void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
 void drm_sysfs_connector_status_event(struct drm_connector *connector,
 				      struct drm_property *property);
 #endif
-- 
2.31.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
