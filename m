Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37535C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 22:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C95E20870
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 22:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5T3UJa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C95E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363E86EB75;
	Wed,  4 Mar 2020 22:36:34 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4326EB75
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 22:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583361392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8DblgkFPwgVS5YcckxNN+AnxhZVfLTqdm5lJfepqis=;
 b=M5T3UJa8BKjhYt3rfflMcDxj8tuCb44s2Kmy+uuAaDnjZamd0vg06SJpT5GljZXU/8PJLV
 OzMqVoGvfJDuZL89NiNMyI8+nuUR/Gb9Sbj5XFwbp3XdAQ8/ZYTTnB0dKP9ppf9zMEmHhm
 5HvcXP/ZjB8tApY4Iy/qd7CmOjnybQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-zsiOIcNjO42kDeKW6oqcBg-1; Wed, 04 Mar 2020 17:36:28 -0500
X-MC-Unique: zsiOIcNjO42kDeKW6oqcBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FFE5800D54;
 Wed,  4 Mar 2020 22:36:26 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com
 [10.20.1.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 657C060BE0;
 Wed,  4 Mar 2020 22:36:25 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: [PATCH 2/3] drm/dp_mst: Don't show connectors as connected before
 probing available PBN
Date: Wed,  4 Mar 2020 17:36:12 -0500
Message-Id: <20200304223614.312023-3-lyude@redhat.com>
In-Reply-To: <20200304223614.312023-1-lyude@redhat.com>
References: <20200304223614.312023-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@google.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's next to impossible for us to do connector probing on topologies
without occasionally racing with userspace, since creating a connector
itself causes a hotplug event which we have to send before probing the
available PBN of a connector. Even if we didn't have this hotplug event
sent, there's still always a chance that userspace started probing
connectors before we finished probing the topology.

This can be a problem when validating a new MST state since the
connector will be shown as connected briefly, but without any available
PBN - causing any atomic state which would enable said connector to fail
with -ENOSPC. So, let's simply workaround this by telling userspace new
MST connectors are disconnected until we've finished probing their PBN.
Since we always send a hotplug event at the end of the link address
probing process, userspace will still know to reprobe the connector when
we're ready.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to MST atomic check")
Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Sean Paul <seanpaul@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 207eef08d12c..7b0ff0cff954 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4033,6 +4033,19 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
 			ret = connector_status_connected;
 		break;
 	}
+
+	/* We don't want to tell userspace the port is actually plugged into
+	 * anything until we've finished probing it's available_pbn, otherwise
+	 * userspace will see racy atomic check failures
+	 *
+	 * Since we always send a hotplug at the end of probing topology
+	 * state, we can just let userspace reprobe this connector later.
+	 */
+	if (ret == connector_status_connected && !port->available_pbn) {
+		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] not ready yet (PBN not probed)\n",
+			      connector->base.id, connector->name);
+		ret = connector_status_disconnected;
+	}
 out:
 	drm_dp_mst_topology_put_port(port);
 	return ret;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
