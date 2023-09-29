Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA2E784AF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 07:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B77110E21A;
	Mon,  2 Oct 2023 07:39:56 +0000 (UTC)
X-Greylist: delayed 496 seconds by postgrey-1.36 at gabe;
 Fri, 29 Sep 2023 15:43:51 UTC
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435A910E09A;
 Fri, 29 Sep 2023 15:43:51 +0000 (UTC)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
 by tretyak2.mcst.ru (Postfix) with ESMTP id 61545101769;
 Fri, 29 Sep 2023 18:35:31 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
 by tretyak2.mcst.ru (Postfix) with ESMTP id 5A3E5102391;
 Fri, 29 Sep 2023 18:34:31 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
 by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 38TFYUoc028052;
 Fri, 29 Sep 2023 18:34:30 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Harry Wentland <harry.wentland@amd.com>
Subject: [lvc-project] [PATCH] drm/amd/display: Fix potential null dereference
Date: Fri, 29 Sep 2023 18:33:45 +0300
Message-Id: <20230929153345.34112-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
 bases: 20111107 #2745587, check: 20230929 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Mailman-Approved-At: Mon, 02 Oct 2023 07:39:51 +0000
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
Cc: lvc-project@linuxtesting.org, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The 'top_pipe_to_program pointer' can be NULL and it is checked 
at the first dereference, but not at the second. 

Add a check before using it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3a9077b60029..154ad23ff931 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3824,7 +3824,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
-		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
+		if (top_pipe_to_program &&
+				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
 				top_pipe_to_program->stream_res.tg,
 				CRTC_STATE_VACTIVE);
-- 
2.30.2

