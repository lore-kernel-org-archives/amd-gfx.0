Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BC0C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 07:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 420FE11347F;
	Wed,  8 May 2024 07:56:56 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD2711260F;
 Tue,  7 May 2024 20:10:59 +0000 (UTC)
Received: from fedori.lan (51b68e76.unconfigured.pool.telekom.hu
 [::ffff:81.182.142.118]) (AUTH: CRAM-MD5 soyer@irl.hu, )
 by irl.hu with ESMTPSA
 id 0000000000074965.00000000663A8ACE.001E3309; Tue, 07 May 2024 22:10:53 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [RFC PATCH] drm/amd/display: Disable panel_power_savings sysfs entry
 for OLED displays
Date: Tue,  7 May 2024 22:09:19 +0200
Message-ID: <04db7855665f9cc92a730dd7ad0b7c47c8fd0091.1715112078.git.soyer@irl.hu>
X-Mailer: git-send-email 2.45.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Mailman-Approved-At: Wed, 08 May 2024 07:56:50 +0000
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

The panel_power_savings sysfs entry sets the Adaptive Backlight
Management level (abm_level). OLED displays work without backlight, so
it is unnecessary for them.

Before creating the sysfs entry, make sure the display is not an OLED
display.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d6e71aa808d8..d54065a76f63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6535,9 +6535,11 @@ static const struct attribute_group amdgpu_group = {
 static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
+	union dpcd_sink_ext_caps *ext_caps =
+		&amdgpu_dm_connector->dc_link->dpcd_sink_ext_caps;
 
 	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0)
+	    amdgpu_dm_abm_level < 0 && !ext_caps->bits.oled)
 		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
 
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
@@ -6642,10 +6644,12 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
+	union dpcd_sink_ext_caps *ext_caps =
+		&amdgpu_dm_connector->dc_link->dpcd_sink_ext_caps;
 	int r;
 
 	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0) {
+	    amdgpu_dm_abm_level < 0 && !ext_caps->bits.oled) {
 		r = sysfs_create_group(&connector->kdev->kobj,
 				       &amdgpu_group);
 		if (r)

base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
-- 
2.45.0

