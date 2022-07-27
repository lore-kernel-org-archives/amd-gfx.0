Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06636C19F28
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 17:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD00E18B2BB;
	Wed, 27 Jul 2022 17:50:46 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1153BBAD89
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 17:50:45 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LtLsw27PrzDrcR;
 Wed, 27 Jul 2022 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1658944244; bh=zbwgeQ5hriDb14EBkFwdfcA3AJe/6WClqClywvs3M3U=;
 h=From:To:Cc:Subject:Date:From;
 b=l3kGSShaffShsr1Yw1c/ftEYNYmfsVM/reNxGYtLgMvDMvZ2BxFmqewdidZUZ6UgK
 cI5Y4+uoOYECLH8pVOSdQCuGq9ELRPTGpOpXZq1ZTdNaPEECK9J1toqXgQzNIFbXlg
 aoS68REqPsdA4+Eif4g2doQNuzge1LWpJGcfemOM=
X-Riseup-User-ID: 969055C4E704636E320363B262450B830023C93B5222C48DCD5FBFCAD5BF868F
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4LtLsq1t7nz1yQc;
 Wed, 27 Jul 2022 17:50:38 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amd/display: Remove unused struct freesync_context
Date: Wed, 27 Jul 2022 14:50:33 -0300
Message-Id: <20220727175033.453620-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: magalilemes00@gmail.com, tales.aparecida@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All references to struct freesync_context were removed, so remove the
struct freesync_context itself and its entry on struct dc_stream_state.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index c3d97206ed89..f87f852d4829 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -48,11 +48,6 @@ struct dc_stream_status {
 	bool is_abm_supported;
 };
 
-// TODO: References to this needs to be removed..
-struct freesync_context {
-	bool dummy;
-};
-
 enum hubp_dmdata_mode {
 	DMDATA_SW_MODE,
 	DMDATA_HW_MODE
@@ -184,9 +179,6 @@ struct dc_stream_state {
 	struct rect src; /* composition area */
 	struct rect dst; /* stream addressable area */
 
-	// TODO: References to this needs to be removed..
-	struct freesync_context freesync_ctx;
-
 	struct audio_info audio_info;
 
 	struct dc_info_packet hdr_static_metadata;
-- 
2.37.1

