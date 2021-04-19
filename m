Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D7AC43461
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 22:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EB061177
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 22:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EB061177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2D96E444;
	Mon, 19 Apr 2021 22:56:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC196E454
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 22:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618872985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YT1fh9K2NL+l15ttMbG26Q+AYdw8647SY7qUirtEs3k=;
 b=ARdgo22lS/97hMSAh07DnF0HeqhxJys7orMXZfOfFKp2ySU9taoEtssPhmh6wM7KVRj9H+
 irbcLRRau/ECrZf+c99cv9ySlAf14Hm3NpyB7/S59wt9kV8+9aPZCRdaZjrChOS3QVK2XA
 nuwOAaiaRyMiFT6WS2zqzBfgZdALUvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-evR6FvvnPgu75Bgib6db6g-1; Mon, 19 Apr 2021 18:56:23 -0400
X-MC-Unique: evR6FvvnPgu75Bgib6db6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05F4F1006C80;
 Mon, 19 Apr 2021 22:56:21 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-119-153.rdu2.redhat.com [10.10.119.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CC105C1C4;
 Mon, 19 Apr 2021 22:56:18 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 04/20] drm/bridge/cdns-mhdp8546: Register DP aux channel
 with userspace
Date: Mon, 19 Apr 2021 18:55:06 -0400
Message-Id: <20210419225523.184856-5-lyude@redhat.com>
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Jonas Karlman <jonas@kwiboo.se>,
 David Airlie <airlied@linux.ie>, Neil Armstrong <narmstrong@baylibre.com>,
 open list <linux-kernel@vger.kernel.org>, Robert Foss <robert.foss@linaro.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Andrzej Hajda <a.hajda@samsung.com>,
 Parshuram Thombare <pthombar@cadence.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Swapnil Jakhade <sjakhade@cadence.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just adds some missing calls to
drm_dp_aux_register()/drm_dp_aux_unregister() for when we attach/detach the
bridge.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index c5e2bc75b226..518e9a441c21 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1719,10 +1719,14 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 
 	dev_dbg(mhdp->dev, "%s\n", __func__);
 
+	ret = drm_dp_aux_register(&mhdp->aux);
+	if (ret < 0)
+		return ret;
+
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
 		ret = cdns_mhdp_connector_init(mhdp);
 		if (ret)
-			return ret;
+			goto aux_unregister;
 	}
 
 	spin_lock(&mhdp->start_lock);
@@ -1738,6 +1742,9 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 		       mhdp->regs + CDNS_APB_INT_MASK);
 
 	return 0;
+aux_unregister:
+	drm_dp_aux_unregister(&mhdp->aux);
+	return ret;
 }
 
 static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
@@ -2082,6 +2089,8 @@ static void cdns_mhdp_detach(struct drm_bridge *bridge)
 
 	dev_dbg(mhdp->dev, "%s\n", __func__);
 
+	drm_dp_aux_unregister(&mhdp->aux);
+
 	spin_lock(&mhdp->start_lock);
 
 	mhdp->bridge_attached = false;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
