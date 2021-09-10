Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0BAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 15:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FEE61074
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 15:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88FEE61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BCA76EA1D;
	Fri, 10 Sep 2021 15:37:51 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD856EA1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 15:37:49 +0000 (UTC)
Date: Fri, 10 Sep 2021 15:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1631288266;
 bh=1W03KrN84wvlD709OjZ81oTeXDvvkvfqhqjqrkCSCk8=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=ZY7cJDrUWxIJFyHZeqZ0mcx7Mo+cZ0WD7qy86kxmdpemFGFRuvPCLYxyrzLZQK4yG
 tl33cfOKnf1Ydqod0Snn4kBIBcAXmMBGHNBHbVr/IWVMvn2MQRr9Sg4BZwMzNQ6hnX
 jN2rOqCwm5DZ8Le5jspAqDWxpnimaf4tnsntbpHZFG3BcNBN1llfMcmu/Mocih2gJB
 riCYLPh4Io4LB2bdHYNY2ieiNiOg9pXkU6yvzXnXry6n9evy2KPX39AoIQDxQ4DwIk
 XI4WfMz8cDJSctxSB+5pL8l/ckzyfw8c32GLn/3An4yU/kqvwFwxNK1yrrH0RopeB+
 B+tmUPL1UU7+w==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH] amd/display: enable panel orientation quirks
Message-ID: <20210910153728.250947-1-contact@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch allows panel orientation quirks from DRM core to be
used. They attach a DRM connector property "panel orientation"
which indicates in which direction the panel has been mounted.
Some machines have the internal screen mounted with a rotation.

Since the panel orientation quirks need the native mode from the
EDID, check for it in amdgpu_dm_connector_ddc_get_modes.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 53363728dbbd..a420602f1794 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7680,6 +7680,32 @@ static void amdgpu_dm_connector_add_common_modes(str=
uct drm_encoder *encoder,
 =09}
 }
=20
+static void amdgpu_set_panel_orientation(struct drm_connector *connector)
+{
+=09struct drm_encoder *encoder;
+=09struct amdgpu_encoder *amdgpu_encoder;
+=09const struct drm_display_mode *native_mode;
+
+=09if (connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP &&
+=09    connector->connector_type !=3D DRM_MODE_CONNECTOR_LVDS)
+=09=09return;
+
+=09encoder =3D amdgpu_dm_connector_to_encoder(connector);
+=09if (!encoder)
+=09=09return;
+
+=09amdgpu_encoder =3D to_amdgpu_encoder(encoder);
+
+=09native_mode =3D &amdgpu_encoder->native_mode;
+=09if (native_mode->hdisplay =3D=3D 0 || native_mode->vdisplay =3D=3D 0)
+=09=09return;
+
+=09drm_connector_set_panel_orientation_with_quirk(connector,
+=09=09=09=09=09=09       DRM_MODE_PANEL_ORIENTATION_UNKNOWN,
+=09=09=09=09=09=09       native_mode->hdisplay,
+=09=09=09=09=09=09       native_mode->vdisplay);
+}
+
 static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connec=
tor,
 =09=09=09=09=09      struct edid *edid)
 {
@@ -7708,6 +7734,8 @@ static void amdgpu_dm_connector_ddc_get_modes(struct =
drm_connector *connector,
 =09=09 * restored here.
 =09=09 */
 =09=09amdgpu_dm_update_freesync_caps(connector, edid);
+
+=09=09amdgpu_set_panel_orientation(connector);
 =09} else {
 =09=09amdgpu_dm_connector->num_modes =3D 0;
 =09}
--=20
2.33.0


