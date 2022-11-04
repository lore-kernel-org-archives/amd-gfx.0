Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7861FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 23:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D9510E8DC;
	Fri,  4 Nov 2022 23:59:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE2F910E8D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 23:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667606380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffbO6hwMXfi6ia/mJYNAheXY/Bx4C/bAtN/BCx8MV7k=;
 b=fopL5Khi4ykYYA9s79CnaLpbmB3cR9RB1KuJ3+BFlcXt+nFMOAqN1X1DnMK7LJgOh31fPu
 eDHSow8TutQJeKO/YrGYoC9CeInNnZoywAFbQwKNUWzn134bIr+g68ih7Euq63dTYA/t9m
 EG+6Ja+fz5mxp8NIy4FiyHb6LFn1rd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-Ef2jqjQmOPuPMfiIymyr5Q-1; Fri, 04 Nov 2022 19:59:37 -0400
X-MC-Unique: Ef2jqjQmOPuPMfiIymyr5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39928833AEC;
 Fri,  4 Nov 2022 23:59:36 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.11.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88C2F112132C;
 Fri,  4 Nov 2022 23:59:35 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/display/dp_mst: Fix
 drm_dp_mst_add_affected_dsc_crtcs() return code
Date: Fri,  4 Nov 2022 19:59:26 -0400
Message-Id: <20221104235926.302883-3-lyude@redhat.com>
In-Reply-To: <20221104235926.302883-1-lyude@redhat.com>
References: <20221104235926.302883-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>,
 Imre Deak <imre.deak@intel.com>, open list <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, David Airlie <airlied@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like that we're accidentally dropping a pretty important return code
here. For some reason, we just return -EINVAL if we fail to get the MST
topology state. This is wrong: error codes are important and should never
be squashed without being handled, which here seems to have the potential
to cause a deadlock.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 8ec046716ca8 ("drm/dp_mst: Add helper to trigger modeset on affected DSC MST CRTCs")
Cc: <stable@vger.kernel.org> # v5.6+
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index ecd22c038c8c0..51a46689cda70 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5186,7 +5186,7 @@ int drm_dp_mst_add_affected_dsc_crtcs(struct drm_atomic_state *state, struct drm
 	mst_state = drm_atomic_get_mst_topology_state(state, mgr);
 
 	if (IS_ERR(mst_state))
-		return -EINVAL;
+		return PTR_ERR(mst_state);
 
 	list_for_each_entry(pos, &mst_state->payloads, next) {
 
-- 
2.37.3

