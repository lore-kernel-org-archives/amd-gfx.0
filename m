Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77947C6FD19
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 22:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE0B10E72E;
	Wed,  8 Mar 2023 22:00:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E19D10E721
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 21:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678312724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdsQaTtbIaBYJTe0xm3ESZR5oOBLuJquJVykY1dYCmg=;
 b=PJr4wBjsLLTcMf/vYiW2O3g0bnoIl6PKcbjJ12F88HJL2iklMrGVac/tKWfCtqmvYuPUGN
 ZcbxwFGrABx1RXufysUFqOKT5a4HqiPb8a3g3jeXTB6OGO+2mFloJ67sldPp6k4zhKNJ2K
 Yf4HqmYvpTc7ZrJdJPsiB2dvWfvH7ag=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-wr8T4I91NDG9MYNqqBRqYw-1; Wed, 08 Mar 2023 16:58:43 -0500
X-MC-Unique: wr8T4I91NDG9MYNqqBRqYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B884E3811F28;
 Wed,  8 Mar 2023 21:58:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDEFF440D9;
 Wed,  8 Mar 2023 21:58:41 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC v2 2/6] drm/amd/display/amdgpu_dm: Refactor
 register_backlight_device()
Date: Wed,  8 Mar 2023 22:58:27 +0100
Message-Id: <20230308215831.782266-3-hdegoede@redhat.com>
In-Reply-To: <20230308215831.782266-1-hdegoede@redhat.com>
References: <20230308215831.782266-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 08 Mar 2023 21:59:56 +0000
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
Cc: Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Refactor register_backlight_device():

1) Turn the connector-type + signal check into an early exit
condition to avoid the indentation level of the rest of the code

2) Add an array bounds check for the arrays indexed by dm->num_of_edps

3) register_backlight_device() always increases dm->num_of_edps if
amdgpu_dm_register_backlight_device() has assigned a backlight_dev to
the current dm->backlight_link[dm->num_of_edps] slot.

So on its next call dm->backlight_dev[dm->num_of_edps] always point to
the next empty slot and the "if (!dm->backlight_dev[dm->num_of_edps])"
check will thus always succeed and can be removed.

4) Add a bl_idx local variable to use as array index, rather then
using dm->num_of_edps to improve the code readability.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 42b88ab5552d..1b5efa56ec15 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4231,21 +4231,23 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 static void register_backlight_device(struct amdgpu_display_manager *dm,
 				      struct dc_link *link)
 {
-	if ((link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) &&
-	    link->type != dc_connection_none) {
-		/*
-		 * Event if registration failed, we should continue with
-		 * DM initialization because not having a backlight control
-		 * is better then a black screen.
-		 */
-		if (!dm->backlight_dev[dm->num_of_edps])
-			amdgpu_dm_register_backlight_device(dm);
+	int bl_idx = dm->num_of_edps;
 
-		if (dm->backlight_dev[dm->num_of_edps]) {
-			dm->backlight_link[dm->num_of_edps] = link;
-			dm->num_of_edps++;
-		}
+	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
+	    link->type == dc_connection_none)
+		return;
+
+	if (dm->num_of_edps >= AMDGPU_DM_MAX_NUM_EDP) {
+		drm_warn(adev_to_drm(dm->adev), "Too much eDP connections, skipping backlight setup for additional eDPs\n");
+		return;
 	}
+
+	amdgpu_dm_register_backlight_device(dm);
+	if (!dm->backlight_dev[bl_idx])
+		return;
+
+	dm->backlight_link[bl_idx] = link;
+	dm->num_of_edps++;
 }
 
 static void amdgpu_set_panel_orientation(struct drm_connector *connector);
-- 
2.39.1

