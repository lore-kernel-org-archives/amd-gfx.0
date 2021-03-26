Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4424CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 20:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6EE61A13
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 20:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6EE61A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D28F6F486;
	Fri, 26 Mar 2021 20:39:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AECCB6F496
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 20:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616791149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBwcu+4SZ0MiVhXsRC+eFR75OwHmxyKtpUAh+axYYMA=;
 b=Dxx7MkZvj1vJNUdD3cevDzr+6m5VMj5lExMKW8Qbq4ojF/v3FD445CMhTPIrlCbo23U6iJ
 jgbmlXJ91uCbGog6+Ecjci/4EUxIYPvu9zjqO1VthQEYq96fCi5o12Tx48Y3UMud63/e1r
 LrgrHwKIAUvJuoEEWazNECHSivvv6qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-CpFTDH7GO2-LB5Kc0vJj7g-1; Fri, 26 Mar 2021 16:39:07 -0400
X-MC-Unique: CpFTDH7GO2-LB5Kc0vJj7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8B6A1853026;
 Fri, 26 Mar 2021 20:39:05 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-114-133.rdu2.redhat.com
 [10.10.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 096345DEAD;
 Fri, 26 Mar 2021 20:39:02 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 06/20] drm/dp: Clarify DP AUX registration time
Date: Fri, 26 Mar 2021 16:37:53 -0400
Message-Id: <20210326203807.105754-7-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-1-lyude@redhat.com>
References: <20210326203807.105754-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The docs we had for drm_dp_aux_init() and drm_dp_aux_register() were mostly
correct, except for the fact that they made the assumption that all AUX
devices were grandchildren of their respective DRM devices. This is the
case for most normal GPUs, but is almost never the case with SoCs and
display bridges. So, let's fix this documentation to clarify when the right
time to use drm_dp_aux_init() or drm_dp_aux_register() is.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 44 +++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index eedbb48815b7..3fa858b9691c 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1728,10 +1728,17 @@ EXPORT_SYMBOL(drm_dp_remote_aux_init);
  * drm_dp_aux_init() - minimally initialise an aux channel
  * @aux: DisplayPort AUX channel
  *
- * If you need to use the drm_dp_aux's i2c adapter prior to registering it
- * with the outside world, call drm_dp_aux_init() first. You must still
- * call drm_dp_aux_register() once the connector has been registered to
- * allow userspace access to the auxiliary DP channel.
+ * If you need to use the drm_dp_aux's i2c adapter prior to registering it with
+ * the outside world, call drm_dp_aux_init() first. For drivers which are
+ * grandparents to their AUX adapters (e.g. the AUX adapter is parented by a
+ * &drm_connector), you must still call drm_dp_aux_register() once the connector
+ * has been registered to allow userspace access to the auxiliary DP channel.
+ * Likewise, for such drivers you should also assign &drm_dp_aux.drm_dev as
+ * early as possible so that the &drm_device that corresponds to the AUX adapter
+ * may be mentioned in debugging output from the DRM DP helpers.
+ *
+ * For devices which use a separate platform device for their AUX adapters, this
+ * may be called as early as required by the driver.
  */
 void drm_dp_aux_init(struct drm_dp_aux *aux)
 {
@@ -1751,15 +1758,26 @@ EXPORT_SYMBOL(drm_dp_aux_init);
  * drm_dp_aux_register() - initialise and register aux channel
  * @aux: DisplayPort AUX channel
  *
- * Automatically calls drm_dp_aux_init() if this hasn't been done yet.
- * This should only be called when the underlying &struct drm_connector is
- * initialiazed already. Therefore the best place to call this is from
- * &drm_connector_funcs.late_register. Not that drivers which don't follow this
- * will Oops when CONFIG_DRM_DP_AUX_CHARDEV is enabled.
- *
- * Drivers which need to use the aux channel before that point (e.g. at driver
- * load time, before drm_dev_register() has been called) need to call
- * drm_dp_aux_init().
+ * Automatically calls drm_dp_aux_init() if this hasn't been done yet. This
+ * should only be called once the parent of @aux, &drm_dp_aux.dev, is
+ * initialized. For devices which are grandparents of their AUX channels,
+ * &drm_dp_aux.dev will typically be the &drm_connector &device which
+ * corresponds to @aux. For these devices, it's advised to call
+ * drm_dp_aux_register() in &drm_connector_funcs.late_register, and likewise to
+ * call drm_dp_aux_unregister() in &drm_connector_funcs.early_unregister.
+ * Functions which don't follow this will likely Oops when
+ * %CONFIG_DRM_DP_AUX_CHARDEV is enabled.
+ *
+ * For devices where the AUX channel is a device that exists independently of
+ * the &drm_device that uses it, such as SoCs and bridge devices, it is
+ * recommended to call drm_dp_aux_register() after a &drm_device has been
+ * assigned to &drm_dp_aux.drm_dev, and likewise to call drm_dp_aux_unregister()
+ * once the &drm_device should no longer be associated with the AUX channel
+ * (e.g. on bridge detach).
+ *
+ * Drivers which need to use the aux channel before either of the two points
+ * mentioned above need to call drm_dp_aux_init() in order to use the AUX
+ * channel before registration.
  *
  * Returns 0 on success or a negative error code on failure.
  */
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
