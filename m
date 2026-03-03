Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB0FEDEBF6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 21:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C66410E8D6;
	Tue,  3 Mar 2026 21:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="SZxGqM7h";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB3510E8D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-953a8a3ca9;
 t=1772572748; bh=GM63tZS+c0wDtASd7hc840gawQGk4+k8uLwUxPL2Cu8=;
 b=SZxGqM7hboFmQBtaBcFsGe1HX05w9XsbsQxv+B4kNltJ8vv+Y2b+J292Zror7skMBAr4trkGo
 z9Q0SKTXCJFpK5fJYob+s8Ojjglk/nSImO162S/zZ/qwUSaUmRHAddtEn7cdUSUApRDXRFsGTcY
 F9Iyyf+s/F8tGJNxGpkIc2NYS1sIlO8zy5TsWRWeMQ3Ajb8dtMFzIsnUzpOj1iXHztzPGI+56rb
 kV3JJQbDzCo+Yk3qiGtXOmTY7IF+7ayjjyEal9w/L7OF6BnstIsfsYS+WUJGDonadU81cXAMbuR
 vya6BmCXUI9cehEie7sa3aHdNRsQbfvUQU1iWfqZwfDA==
X-Forward-Email-ID: 69a7504bb5d0800e9c1f0cb1
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Joshua Peisach <jpeisach@ubuntu.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Peisach <jpeisach@ubuntu.com>
Subject: [PATCH RESEND 2/2] drm/amdgpu/amdgpu_connectors: remove
 amdgpu_connector_free_edid
Date: Tue,  3 Mar 2026 16:18:23 -0500
Message-ID: <20260303211823.76631-3-jpeisach@ubuntu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303211823.76631-1-jpeisach@ubuntu.com>
References: <20260303211823.76631-1-jpeisach@ubuntu.com>
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

Now that we are using struct drm_edid, we can just call drm_edid_free
directly. Remove the function and update calls to drm_edid_free.

Signed-off-by: Joshua Peisach <jpeisach@ubuntu.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 22 ++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 6336cadad..aabe9d58c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -297,14 +297,6 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 	}
 }
 
-static void amdgpu_connector_free_edid(struct drm_connector *connector)
-{
-	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
-
-	kfree(amdgpu_connector->edid);
-	amdgpu_connector->edid = NULL;
-}
-
 static int amdgpu_connector_ddc_get_modes(struct drm_connector *connector)
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
@@ -754,7 +746,7 @@ static void amdgpu_connector_destroy(struct drm_connector *connector)
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
-	amdgpu_connector_free_edid(connector);
+	drm_edid_free(amdgpu_connector->edid);
 	kfree(amdgpu_connector->con_priv);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
@@ -873,7 +865,7 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
 		dret = amdgpu_display_ddc_probe(amdgpu_connector, false);
 	if (dret) {
 		amdgpu_connector->detected_by_load = false;
-		amdgpu_connector_free_edid(connector);
+		drm_edid_free(amdgpu_connector->edid);
 		amdgpu_connector_get_edid(connector);
 
 		if (!amdgpu_connector->edid) {
@@ -889,7 +881,7 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
 			 * with a shared ddc line (often vga + hdmi)
 			 */
 			if (amdgpu_connector->use_digital && amdgpu_connector->shared_ddc) {
-				amdgpu_connector_free_edid(connector);
+				drm_edid_free(amdgpu_connector->edid);
 				ret = connector_status_disconnected;
 			} else {
 				ret = connector_status_connected;
@@ -984,7 +976,7 @@ static void amdgpu_connector_shared_ddc(enum drm_connector_status *status,
 					/* hpd is our only option in this case */
 					if (!amdgpu_display_hpd_sense(adev,
 								      amdgpu_connector->hpd.hpd)) {
-						amdgpu_connector_free_edid(connector);
+						drm_edid_free(amdgpu_connector->edid);
 						*status = connector_status_disconnected;
 					}
 				}
@@ -1053,7 +1045,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 	}
 	if (dret) {
 		amdgpu_connector->detected_by_load = false;
-		amdgpu_connector_free_edid(connector);
+		drm_edid_free(amdgpu_connector->edid);
 		amdgpu_connector_get_edid(connector);
 
 		if (!amdgpu_connector->edid) {
@@ -1069,7 +1061,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 			 * with a shared ddc line (often vga + hdmi)
 			 */
 			if ((!amdgpu_connector->use_digital) && amdgpu_connector->shared_ddc) {
-				amdgpu_connector_free_edid(connector);
+				drm_edid_free(amdgpu_connector->edid);
 				ret = connector_status_disconnected;
 			} else {
 				ret = connector_status_connected;
@@ -1417,7 +1409,7 @@ amdgpu_connector_dp_detect(struct drm_connector *connector, bool force)
 		goto out;
 	}
 
-	amdgpu_connector_free_edid(connector);
+	drm_edid_free(amdgpu_connector->edid);
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_eDP) ||
 	    (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)) {
-- 
2.51.0

