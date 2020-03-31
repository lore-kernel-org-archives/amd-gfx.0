Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD9CC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7343420787
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8bcOvLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7343420787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B266E893;
	Tue, 31 Mar 2020 20:58:08 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0CB56E894
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 20:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585688285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9TxpyWj+Au+l7FDdZORjZAyVa0RQ8jLqCZnOYPH8wQ=;
 b=T8bcOvLoz4OI5VqhgG6W8VXWk7S9m4fGJ5TG/PqMY9zm5bS+YPqrhifrswW+iMyjf0r+q6
 KRFyg2lsfywZd5IEjO3+ktqbuj2fa3HRbJw7Kj/WEDxmu6yGM8E5v2hiRlEpi3cBB8XfzK
 o42Q3eHMnLu1aydl5Gn7K7zGVf0veFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-tCYDMqX-PZGPyEAzwuGBIg-1; Tue, 31 Mar 2020 16:58:02 -0400
X-MC-Unique: tCYDMqX-PZGPyEAzwuGBIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF82C1005509;
 Tue, 31 Mar 2020 20:57:59 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97BFB98A52;
 Tue, 31 Mar 2020 20:57:55 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/amdgpu_dm/mst: Stop printing extra messages in
 dm_dp_add_mst_connector()
Date: Tue, 31 Mar 2020 16:57:36 -0400
Message-Id: <20200331205740.135525-4-lyude@redhat.com>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 David Francis <David.Francis@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 linux-kernel@vger.kernel.org,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

You can already trace the creation and destruction of connectors using
DRM, and we definitely don't need to be printing info messages on
connector hotplugs as well. So, get rid of these.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 09025ccc68ca..d56b758bcce5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -433,13 +433,8 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	 */
 	amdgpu_dm_connector_funcs_reset(connector);
 
-	DRM_INFO("DM_MST: added connector: %p [id: %d] [master: %p]\n",
-		 aconnector, connector->base.id, aconnector->mst_port);
-
 	drm_dp_mst_get_port_malloc(port);
 
-	DRM_DEBUG_KMS(":%d\n", connector->base.id);
-
 	return connector;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
