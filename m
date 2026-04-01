Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1377B10FCACE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5714910EDBF;
	Wed,  1 Apr 2026 18:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GuZGx1Ct";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCC010EBB0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:47 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso6814948eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003986; x=1775608786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eei37i3TX+igH2enzLXynCDfuH92qYv7D/N1mhYCK9U=;
 b=GuZGx1CtSTyCA2spB68HG8iYP9XojBtvhrpLJd5JSGciYpF4FMaQ9vHvYzyml2IdJv
 sWieRiLMRm+r5LzFxTYjJ4sZPvVnkCbQMlt4uGmyHUV4ypd6xaQvvMQesQK+b05hsmM5
 K4BsCVaI/lovhOQjRy5sC16b3th1zAK42Lz4duxsgd8Z6pORXPV1E3K0VwMKKQGAOyQ7
 dKeIh9xp7/xlIEcmTgvvzWjmwqeQ51Bdb+GYFWVpWcZKDMh4TUwfvlEATFPeXr+BBmXe
 m//Z60EsjUvBX7kkcTPaqOJfk1oDoMpSYQ6BHRGBJ0LcRdTtoms1AZ1R9/5qSBSXWYPv
 oQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003986; x=1775608786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eei37i3TX+igH2enzLXynCDfuH92qYv7D/N1mhYCK9U=;
 b=XTbA9ELt09K7OLDCK2VGxjdUC/yvpvT22WH2XaR36AU2amBVO2zB/n860c/oVLO1cQ
 JyCWGhrmYg8zOZzxMW4hLz2nxLy+Gov4x+mFY5Zxuz2qntTV6cQIAgjnB8Oi+35jw66Q
 bMMUYnoKGl+MqtE/cJL6CNe+nw7ETgMUn9x2bi+LAQdw4GrVnB6Rv1JiW0T/lCJ/oM+Z
 9I3q15BaoyosJwPG5M0BiYh/H/3YDBbteU3owQqMWCutOufZrfOYixZKfeKLhVXqlWLw
 GEOoDfJ8KPjNIQWrCEzkDgLitOPjpmz01DVjzGFqrW1iTykF9nYr3cC6QzVCfVKw/eB/
 sYwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn1OsBRqyTta493WvlivQibYTT926LlUFlsFMf8Rv0AcgthLAPiRtNfEsDVxo8wZ3YyixGgW/V@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/EzwyKNDdiHIew6FydnPy3qvoYdsWTGpgLkTUlXU6E0Vcdjqv
 shLDlbKpW2gKEcBLAiW18KCx6okSnRKEnmmmNAw4EUwZG2E6NC/EBHnk
X-Gm-Gg: ATEYQzzc1+l5Hgfc0p28kiXqkSLmSzO/H1fgfknZ5aJjehijV3S/iPaXBYRsOPJIaUV
 ZG38XY/uuuz692GVD/s330RDsf/nXaahJ7BWs0jqFk2ezXg2YA4CKj8qe8GjEsI6vtEM8lDZ+EV
 ldvD1VKU6mo3RMHSqqVmxDyAgyRnpOMnhKpJM1lPtH+Rl2O532qpP4JXB9uapBlh+pXyxvJtHVX
 5VegB9ihyA5SA4U+mYeY1v5Zj2qhv6pz4O86lCNFnsEH9T/0tt5csExEUxgEgglGeaMoSRjUYuB
 8TcqeY0Xnc8/yhXtH8vbBYIuclc7lQyMP2qdBDu1eOabKrc/Tm0iitptee4zFnemJZr9vc2tARB
 3PujTv8pLp7qvSQ8yKGtV6a8Y04QatVlfhbu0NHZtGSulcCF9j+0JT4cY9o7MbotBzHJVUCeu/8
 PZyQ9w2V4uyYsUWeJBYquutGgJG8lDB1bwc9uZNw8qhM/4QzI6lQyFmYLjTMZoaOR1jQ==
X-Received: by 2002:a05:7300:2391:b0:2c1:27c:75cd with SMTP id
 5a478bee46e88-2c9311779d8mr930291eec.13.1775003986357; 
 Tue, 31 Mar 2026 17:39:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 10/10] drm/amd/display: Correct logic check error
 for fastboot
Date: Tue, 31 Mar 2026 17:39:08 -0700
Message-ID: <20260401003908.3438-11-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit b6a65009e7ce3f0cc72da18f186adb60717b51a0 ]

[Why]
Fix fastboot broken in driver.
This is caused by an open source backport change 7495962c.

from the comment, the intended check is to disable fastboot
for pre-DCN10. but the logic check is reversed, and causes
fastboot to be disabled on all DCN10 and after.

fastboot is for driver trying to pick up bios used hw setting
and bypass reprogramming the hw if dc_validate_boot_timing()
condition meets.

Fixes: 7495962cbceb ("drm/amd/display: Disable fastboot on DCE 6 too")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 7dc99c85b8ea..551638d9ff61 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1910,8 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
-	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
+	/* Check fastboot support, disable on DCE 6-8-10 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version > DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.53.0

