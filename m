Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC04CC74A44
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 21:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E511E10E72D;
	Wed,  8 Mar 2023 21:59:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D161D10E722
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 21:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678312728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBHlRGqKqStl7wJEMB26UFxHbhMjTB1lpYzoyWatFxE=;
 b=EZwTS4m3XdZhijNx7JJIcZfYtIRau8Qk7ZeTkd6PrRLMTt48UAhxwYf8dU0SUIJFhk/qI6
 biUsgmJxf19dErnaBgG40fLbaponD0CWbTBdkDVh1IOcvq1gdWsxf/8CJoyS5tSqqVZUHl
 wnhGbh4TKmXBDaho9ezStID3WFM/1OI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-YD_t2cqhPNqQiLqWDCriSw-1; Wed, 08 Mar 2023 16:58:45 -0500
X-MC-Unique: YD_t2cqhPNqQiLqWDCriSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF8C785A588;
 Wed,  8 Mar 2023 21:58:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5A6C440E0;
 Wed,  8 Mar 2023 21:58:43 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC v2 4/6] drm/amd/display/amdgpu_dm: Move most backlight setup
 into setup_backlight_device()
Date: Wed,  8 Mar 2023 22:58:29 +0100
Message-Id: <20230308215831.782266-5-hdegoede@redhat.com>
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

Rename register_backlight_device() to setup_backlight_device()
and move all backlight setup related calls from
amdgpu_dm_register_backlight_device() and from
amdgpu_dm_initialize_drm_device() there.

This leaves amdgpu_dm_register_backlight_device() dealing purely
with registering the actual backlight class device.

This is a preparation patch for moving the actual backlight class device
registering to drm_connector_funcs.late_register.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eb1f2073b0cf..757202af2eec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4145,9 +4145,6 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
 	char bl_name[16];
 	struct backlight_properties props = { 0 };
 
-	amdgpu_dm_update_backlight_caps(dm, dm->num_of_edps);
-	dm->brightness[dm->num_of_edps] = AMDGPU_MAX_BL_LEVEL;
-
 	if (!acpi_video_backlight_use_native()) {
 		drm_info(adev_to_drm(dm->adev), "Skipping amdgpu DM backlight registration\n");
 		/* Try registering an ACPI video backlight device instead. */
@@ -4216,8 +4213,8 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 }
 
 
-static void register_backlight_device(struct amdgpu_display_manager *dm,
-				      struct amdgpu_dm_connector *aconnector)
+static void setup_backlight_device(struct amdgpu_display_manager *dm,
+				   struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_link *link = aconnector->dc_link;
 	int bl_idx = dm->num_of_edps;
@@ -4233,6 +4230,9 @@ static void register_backlight_device(struct amdgpu_display_manager *dm,
 
 	aconnector->bl_idx = bl_idx;
 
+	amdgpu_dm_update_backlight_caps(dm, bl_idx);
+	dm->brightness[bl_idx] = AMDGPU_MAX_BL_LEVEL;
+
 	amdgpu_dm_register_backlight_device(dm);
 	if (!dm->backlight_dev[bl_idx]) {
 		aconnector->bl_idx = -1;
@@ -4241,6 +4241,8 @@ static void register_backlight_device(struct amdgpu_display_manager *dm,
 
 	dm->backlight_link[bl_idx] = link;
 	dm->num_of_edps++;
+
+	update_connector_ext_caps(aconnector);
 }
 
 static void amdgpu_set_panel_orientation(struct drm_connector *connector);
@@ -4423,10 +4425,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 			if (ret) {
 				amdgpu_dm_update_connector_after_detect(aconnector);
-				register_backlight_device(dm, aconnector);
-
-				if (dm->num_of_edps)
-					update_connector_ext_caps(aconnector);
+				setup_backlight_device(dm, aconnector);
 
 				if (psr_feature_enabled)
 					amdgpu_dm_set_psr_caps(link);
-- 
2.39.1

