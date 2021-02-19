Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F4CC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 21:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0021064E92
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 21:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0021064E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86FB6EC23;
	Fri, 19 Feb 2021 21:54:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E956EC1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 21:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613771645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wY9mEXFe2P3a0UdkWqTDHpIbQAWcFhFpSw+CZuX2ZC4=;
 b=eG1dCADCCoFhC7s1Bh3r0GlfC0zlqFemQ9d+TW+m2s5lF+In8Zgy6RMOKYRLVhVNpj6FIm
 m7uvUb5YB78zNyFpW/BN4O/SozCWZK+g/Ek/TdTUK6NvkqqpnjlTLWhqTR/WkTC7OSWBgs
 kIxEs9X2qFTmIljOn/zD4MvinDL9BIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-8bqZ_ET2Ouy6p7BA7OKfog-1; Fri, 19 Feb 2021 16:53:57 -0500
X-MC-Unique: 8bqZ_ET2Ouy6p7BA7OKfog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73A13192FDB0;
 Fri, 19 Feb 2021 21:53:47 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9C0C6A03C;
 Fri, 19 Feb 2021 21:53:45 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/30] drm/dp: Fixup kernel docs for struct drm_dp_aux
Date: Fri, 19 Feb 2021 16:52:58 -0500
Message-Id: <20210219215326.2227596-3-lyude@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

* Make sure that struct members are referred to using @, otherwise they
  won't be formatted as such
* Make sure to refer to other struct types using & so they link back to
  each struct's definition
* Make sure to precede constant values with % so they're formatted
  correctly

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/drm/drm_dp_helper.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 2891a98eebc8..b35a1c1339e8 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1839,28 +1839,28 @@ struct drm_dp_aux_cec {
  * @crc_count: counter of captured frame CRCs
  * @transfer: transfers a message representing a single AUX transaction
  *
- * The .dev field should be set to a pointer to the device that implements the AUX channel.
+ * The @dev field should be set to a pointer to the device that implements the AUX channel.
  *
- * The .name field may be used to specify the name of the I2C adapter. If set to NULL, dev_name() of
- * .dev will be used.
+ * The @name field may be used to specify the name of the I2C adapter. If set to %NULL, dev_name()
+ * of @dev will be used.
  *
  * Drivers provide a hardware-specific implementation of how transactions are executed via the
- * .transfer() function. A pointer to a drm_dp_aux_msg structure describing the transaction is
+ * @transfer() function. A pointer to a &drm_dp_aux_msg structure describing the transaction is
  * passed into this function. Upon success, the implementation should return the number of payload
  * bytes that were transferred, or a negative error-code on failure. Helpers propagate errors from
- * the .transfer() function, with the exception of the -EBUSY error, which causes a transaction to
- * be retried. On a short, helpers will return -EPROTO to make it simpler to check for failure.
+ * the @transfer() function, with the exception of the %-EBUSY error, which causes a transaction to
+ * be retried. On a short, helpers will return %-EPROTO to make it simpler to check for failure.
  *
  * An AUX channel can also be used to transport I2C messages to a sink. A typical application of
- * that is to access an EDID that's present in the sink device. The .transfer() function can also be
+ * that is to access an EDID that's present in the sink device. The @transfer() function can also be
  * used to execute such transactions. The drm_dp_aux_register() function registers an I2C adapter
  * that can be passed to drm_probe_ddc(). Upon removal, drivers should call drm_dp_aux_unregister()
  * to remove the I2C adapter. The I2C adapter uses long transfers by default; if a partial response
  * is received, the adapter will drop down to the size given by the partial response for this
  * transaction only.
  *
- * Note that the aux helper code assumes that the .transfer() function only modifies the reply field
- * of the drm_dp_aux_msg structure. The retry logic and i2c helpers assume this is the case.
+ * Note that the aux helper code assumes that the @transfer() function only modifies the reply field
+ * of the &drm_dp_aux_msg structure. The retry logic and i2c helpers assume this is the case.
  */
 struct drm_dp_aux {
 	const char *name;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
