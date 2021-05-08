Return-Path: <SRS0=tImT=KE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC02C433B4
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 15:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2726960FE9
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 15:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2726960FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=czerwinskis.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54CE6E1F6;
	Sun,  9 May 2021 15:42:12 +0000 (UTC)
X-Greylist: delayed 594 seconds by postgrey-1.36 at gabe;
 Sat, 08 May 2021 18:30:05 UTC
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de
 [IPv6:2a01:4f8:c17:c88::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946856E0EE;
 Sat,  8 May 2021 18:30:05 +0000 (UTC)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
 id CD059125A81; Sat,  8 May 2021 20:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
 s=mail; t=1620498006;
 bh=eTcUQwqKOuKmD2QbJtpZOH7NjK31efH/FQy8a+iwiSA=;
 h=From:To:Cc:Subject:Date:From;
 b=Um36VnS5dntn186tQ7CL537Op6H+nn0a486NpOBL20Qw1ELKhyaRLKCuKaSmQyCZ8
 a7so3bIRuLguc6UieK7Y5AX1Ei/4TSw/AFgvlsXpbOh82Flx1BCNjWH6iIfPgkGp2V
 03GRuvsXFkRTJskMWiD84CodkgEy/MTToADnVqGI=
Received: from localhost (unknown [IPv6:2001:9e8:73:702:c0d3:dbff:fefe:ff70])
 by magratgarlick.emantor.de (Postfix) with ESMTPSA id 3BE5C125A80;
 Sat,  8 May 2021 20:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
 s=mail; t=1620498003;
 bh=eTcUQwqKOuKmD2QbJtpZOH7NjK31efH/FQy8a+iwiSA=;
 h=From:To:Cc:Subject:Date:From;
 b=bxD2sC729WZWz4PWcg8D6L/D+rFjOl1PK7xdH1Dnxx+IoPpMimiHpPeGSCz9o9Uge
 AJ+QdvQRXxbtUif+1DbkVyBubb8HmQDV/GimrSLtPqsV7nJD+T2usK4aj1yuIUYthX
 AjNSFqwqVBW1aoAqjedKmoOg75HBkThKKNQ8R+JI=
From: Rouven Czerwinski <rouven@czerwinskis.de>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amd/display: remove unused function
 dc_link_perform_link_training
Date: Sat,  8 May 2021 20:19:51 +0200
Message-Id: <20210508181951.129548-1-rouven@czerwinskis.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 09 May 2021 15:42:11 +0000
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
Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Rouven Czerwinski <rouven@czerwinskis.de>, amd-gfx@lists.freedesktop.org,
 kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This function is not used anywhere, remove it. It was added in
40dd6bd376a4 ("drm/amd/display: Linux Set/Read link rate and lane count
through debugfs") and moved in fe798de53a7a ("drm/amd/display: Move link
functions from dc to dc_link"), but a user is missing.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 13 -------------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 ---
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3fb0cebd6938..55c5cf2264b3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3553,19 +3553,6 @@ void dc_link_set_drive_settings(struct dc *dc,
 	dc_link_dp_set_drive_settings(dc->links[i], lt_settings);
 }
 
-void dc_link_perform_link_training(struct dc *dc,
-				   struct dc_link_settings *link_setting,
-				   bool skip_video_pattern)
-{
-	int i;
-
-	for (i = 0; i < dc->link_count; i++)
-		dc_link_dp_perform_link_training(
-			dc->links[i],
-			link_setting,
-			skip_video_pattern);
-}
-
 void dc_link_set_preferred_link_settings(struct dc *dc,
 					 struct dc_link_settings *link_setting,
 					 struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index fc5622ffec3d..45c927cd27ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -363,9 +363,6 @@ bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal);
 void dc_link_set_drive_settings(struct dc *dc,
 				struct link_training_settings *lt_settings,
 				const struct dc_link *link);
-void dc_link_perform_link_training(struct dc *dc,
-				   struct dc_link_settings *link_setting,
-				   bool skip_video_pattern);
 void dc_link_set_preferred_link_settings(struct dc *dc,
 					 struct dc_link_settings *link_setting,
 					 struct dc_link *link);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
