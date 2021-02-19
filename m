Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783E5C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 21:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424EA64EB8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 21:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424EA64EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68506EC4F;
	Fri, 19 Feb 2021 21:54:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8ADA6EC4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613771673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bymRqRbME6VABEdXsJV9xC/upK3fsxTE0vbmEppqKhk=;
 b=PiK5q/JnfJaat0tlddKZOjLA/yUQCd/Fq9Hgy7A9JLn16vQEM0GzkwB6UcMiXJk6LWBens
 eGKgrKkWSwN/wf1LMqvH1CI3OzAgfr63hdZUsmykoOg+R+lGD5MdyO06rFUlkwq4TU2ljy
 zywzIyp176bP4+aFtF85Fg4lQ4sXtZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-zPlLAN53MXuvIIyDoS2FrQ-1; Fri, 19 Feb 2021 16:54:32 -0500
X-MC-Unique: zPlLAN53MXuvIIyDoS2FrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50598107ACE3;
 Fri, 19 Feb 2021 21:54:30 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC69A6A03C;
 Fri, 19 Feb 2021 21:54:28 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 14/30] drm/nouveau/kms/nv50-: Move AUX adapter reg to
 connector late register/early unregister
Date: Fri, 19 Feb 2021 16:53:10 -0500
Message-Id: <20210219215326.2227596-15-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 drivers/gpu/drm/nouveau/nouveau_connector.c | 26 ++++++++++++++-------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 61e6d7412505..bfce762adcf0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -905,13 +905,29 @@ nouveau_connector_late_register(struct drm_connector *connector)
 	int ret;
 
 	ret = nouveau_backlight_init(connector);
+	if (ret)
+		return ret;
+
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
+		ret = drm_dp_aux_register(&nouveau_connector(connector)->aux);
+		if (ret)
+			goto backlight_fini;
+	}
 
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
 
@@ -1343,14 +1359,8 @@ nouveau_connector_create(struct drm_device *dev,
 		snprintf(aux_name, sizeof(aux_name), "sor-%04x-%04x",
 			 dcbe->hasht, dcbe->hashm);
 		nv_connector->aux.name = kstrdup(aux_name, GFP_KERNEL);
-		ret = drm_dp_aux_register(&nv_connector->aux);
-		if (ret) {
-			NV_ERROR(drm, "failed to register aux channel\n");
-			kfree(nv_connector);
-			return ERR_PTR(ret);
-		}
-		funcs = &nouveau_connector_funcs;
-		break;
+		drm_dp_aux_init(&nv_connector->aux);
+		fallthrough;
 	default:
 		funcs = &nouveau_connector_funcs;
 		break;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
