Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BD1C43462
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 22:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B91560FF1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 22:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B91560FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74356E45D;
	Mon, 19 Apr 2021 22:56:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2BD6E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618872990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qNrOwAYHuDRQm2XF7UqOlIRXB71biF83Wt2YTi7FWw8=;
 b=Z2+WQrQXMsCRN8SFYzm50pZFRRe3/hojITS3/bYFcACO5UtSlpmGX/RKSY7xeSP0iDkTRm
 edKdRj9ZBx4EpGFqw6g1TbjtUnZ59WKbpbKdsbOO2Ft/cvB42K19dSGDKwB7utC8zmMmaq
 NvHhkZYJO845Tg7gPX3pgJLTuWDx8Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-PSlAEljGPdahTTS4T4gSGg-1; Mon, 19 Apr 2021 18:56:27 -0400
X-MC-Unique: PSlAEljGPdahTTS4T4gSGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B450D81744F;
 Mon, 19 Apr 2021 22:56:25 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-119-153.rdu2.redhat.com [10.10.119.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 695085C1C4;
 Mon, 19 Apr 2021 22:56:21 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 05/20] drm/nouveau/kms/nv50-: Move AUX adapter reg to
 connector late register/early unregister
Date: Mon, 19 Apr 2021 18:55:07 -0400
Message-Id: <20210419225523.184856-6-lyude@redhat.com>
In-Reply-To: <20210419225523.184856-1-lyude@redhat.com>
References: <20210419225523.184856-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: David Airlie <airlied@linux.ie>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since AUX adapters on nouveau have their respective DRM connectors as
parents, we need to make sure that we register then after their connectors.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 25 ++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index e5a93fab856e..56eaa29b34d6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -401,7 +401,6 @@ nouveau_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 	if (nv_connector->aux.transfer) {
 		drm_dp_cec_unregister_connector(&nv_connector->aux);
-		drm_dp_aux_unregister(&nv_connector->aux);
 		drm_dp_aux_fini(&nv_connector->aux);
 		kfree(nv_connector->aux.name);
 	}
@@ -906,13 +905,29 @@ nouveau_connector_late_register(struct drm_connector *connector)
 	int ret;
 
 	ret = nouveau_backlight_init(connector);
+	if (ret)
+		return ret;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
+		ret = drm_dp_aux_register(&nouveau_connector(connector)->aux);
+		if (ret)
+			goto backlight_fini;
+	}
+
+	return 0;
+backlight_fini:
+	nouveau_backlight_fini(connector);
 	return ret;
 }
 
 static void
 nouveau_connector_early_unregister(struct drm_connector *connector)
 {
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
+		drm_dp_aux_unregister(&nouveau_connector(connector)->aux);
+
 	nouveau_backlight_fini(connector);
 }
 
@@ -1344,14 +1359,14 @@ nouveau_connector_create(struct drm_device *dev,
 		snprintf(aux_name, sizeof(aux_name), "sor-%04x-%04x",
 			 dcbe->hasht, dcbe->hashm);
 		nv_connector->aux.name = kstrdup(aux_name, GFP_KERNEL);
-		ret = drm_dp_aux_register(&nv_connector->aux);
+		ret = drm_dp_aux_init(&nv_connector->aux);
 		if (ret) {
-			NV_ERROR(drm, "failed to register aux channel\n");
+			NV_ERROR(drm, "Failed to init AUX adapter for sor-%04x-%04x: %d\n",
+				 dcbe->hasht, dcbe->hashm, ret);
 			kfree(nv_connector);
 			return ERR_PTR(ret);
 		}
-		funcs = &nouveau_connector_funcs;
-		break;
+		fallthrough;
 	default:
 		funcs = &nouveau_connector_funcs;
 		break;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
