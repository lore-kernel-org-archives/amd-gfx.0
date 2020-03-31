Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD9DC2D0EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2300920787
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+OEVQmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2300920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF38C6E895;
	Tue, 31 Mar 2020 20:58:13 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8506E896
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585688291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpM1XxT0yKaKGYgf2gGKRTmepGnz6nJa59IN7BPPkTY=;
 b=f+OEVQmhuu6eWUitWHhzZWqCAQOjC1OMS7D4bYVQWvSEhlngDS1PJltKp77zH7L4rfz4CM
 85gkgBol9YEPRCnVhDW8U9U8rk7Ez/ht846+omo0T9+nufHvN8f+NGTMoMt4T33KqL1fsG
 d5FynTSne/C4+tj3i07upJwryaY1u2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-_8ieoBgKMOu3PpoyXoV6Rw-1; Tue, 31 Mar 2020 16:58:04 -0400
X-MC-Unique: _8ieoBgKMOu3PpoyXoV6Rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B89E6192296B;
 Tue, 31 Mar 2020 20:58:02 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CCE199DE2;
 Tue, 31 Mar 2020 20:58:00 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] drm/dp_mst: Remove
 drm_dp_mst_topology_cbs.destroy_connector
Date: Tue, 31 Mar 2020 16:57:37 -0400
Message-Id: <20200331205740.135525-5-lyude@redhat.com>
In-Reply-To: <20200331205740.135525-1-lyude@redhat.com>
References: <20200331205740.135525-1-lyude@redhat.com>
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that we've removed the last user of this callback, get rid of it and
drm_dp_destroy_connector().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 16 +++-------------
 include/drm/drm_dp_mst_helper.h       |  2 --
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 31b7a8f5309d..e235b2b29f59 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4692,23 +4692,13 @@ static void drm_dp_tx_work(struct work_struct *work)
 	mutex_unlock(&mgr->qlock);
 }
 
-static inline void drm_dp_destroy_connector(struct drm_dp_mst_port *port)
+static inline void
+drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
 {
-	if (!port->connector)
-		return;
-
-	if (port->mgr->cbs->destroy_connector) {
-		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
-	} else {
+	if (port->connector) {
 		drm_connector_unregister(port->connector);
 		drm_connector_put(port->connector);
 	}
-}
-
-static inline void
-drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
-{
-	drm_dp_destroy_connector(port);
 
 	drm_dp_port_set_pdt(port, DP_PEER_DEVICE_NONE, port->mcs);
 	drm_dp_mst_put_port_malloc(port);
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 13461db1444a..7af51c947b81 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -488,8 +488,6 @@ struct drm_dp_mst_topology_mgr;
 struct drm_dp_mst_topology_cbs {
 	/* create a connector for a port */
 	struct drm_connector *(*add_connector)(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port, const char *path);
-	void (*destroy_connector)(struct drm_dp_mst_topology_mgr *mgr,
-				  struct drm_connector *connector);
 };
 
 #define DP_MAX_PAYLOAD (sizeof(unsigned long) * 8)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
