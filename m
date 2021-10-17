Return-Path: <SRS0=QO8y=PF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DFBC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Oct 2021 11:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354FB60F46
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Oct 2021 11:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 354FB60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net-c.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7339A6E7D7;
	Sun, 17 Oct 2021 11:35:10 +0000 (UTC)
Received: from msg-6.mailo.com (ip-16.mailobj.net [213.182.54.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DA56E5CE
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Oct 2021 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1634470504; bh=EtfTag/lzGZNGrVyTX4S3mF4ua7TstPpVcjEL9nAkcg=;
 h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=qCs8WdlGIUqC1O13tZCnsZ/M4lM5qAvBby+C2dZCL/Kqez8Y0yjFqMPNj8oKphvmZ
 I6bB+8sdg0pudHSy15gTK9H+7ErDT1wXjGKRh/kGWTKEJgTzTxKEB2+9YBNNhvyZS0
 Ln/GjG3skRdxXixhXKnFwER3MZrFfEI8JXge8Sos=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sun, 17 Oct 2021 13:35:04 +0200 (CEST)
X-EA-Auth: zyApk6WpY+DjJf1Ui2SmnmBx82MWelFRPuFCWb6snAVYOM6hMpDuctrtBem2WR1aXhsoYqPue3D0AC4d7JtChyxdPVC2qxzI
From: Claudio Suarez <cssk@net-c.es>
To: amd-gfx@lists.freedesktop.org
Cc: Claudio Suarez <cssk@net-c.es>
Subject: [PATCH 1/3] drm/amdgpu: update drm_display_info correctly when the
 edid is read
Date: Sun, 17 Oct 2021 13:34:58 +0200
Message-Id: <20211017113500.7033-2-cssk@net-c.es>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017113500.7033-1-cssk@net-c.es>
References: <20211017113500.7033-1-cssk@net-c.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm_display_info is updated by drm_get_edid() or
drm_connector_update_edid_property(). In the amdgpu driver it is almost
always updated when the edid is read in amdgpu_connector_get_edid(),
but not always.  Change amdgpu_connector_get_edid() and
amdgpu_connector_free_edid() to keep drm_display_info updated.

Signed-off-by: Claudio Suarez <cssk@net-c.es>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 5 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index b9c11c2b2885..647aecee1185 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -315,8 +315,10 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 	if (!amdgpu_connector->edid) {
 		/* some laptops provide a hardcoded edid in rom for LCDs */
 		if (((connector->connector_type == DRM_MODE_CONNECTOR_LVDS) ||
-		     (connector->connector_type == DRM_MODE_CONNECTOR_eDP)))
+		     (connector->connector_type == DRM_MODE_CONNECTOR_eDP))) {
 			amdgpu_connector->edid = amdgpu_connector_get_hardcoded_edid(adev);
+			drm_connector_update_edid_property(connector, amdgpu_connector->edid);
+		}
 	}
 }
 
@@ -326,6 +328,7 @@ static void amdgpu_connector_free_edid(struct drm_connector *connector)
 
 	kfree(amdgpu_connector->edid);
 	amdgpu_connector->edid = NULL;
+	drm_connector_update_edid_property(connector, NULL);
 }
 
 static int amdgpu_connector_ddc_get_modes(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1ea31dcc7a8b..02ecd216a556 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2583,13 +2583,12 @@ void amdgpu_dm_update_connector_after_detect(
 			aconnector->edid =
 				(struct edid *)sink->dc_edid.raw_edid;
 
-			drm_connector_update_edid_property(connector,
-							   aconnector->edid);
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
 						    aconnector->edid);
 		}
 
+		drm_connector_update_edid_property(connector, aconnector->edid);
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
 		update_connector_ext_caps(aconnector);
 	} else {
-- 
2.33.0



