Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5426CC10F29
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 08:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AC620728
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 08:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AC620728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4096E357;
	Mon,  9 Mar 2020 08:14:15 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr
 [80.12.242.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E3C6E28E
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Mar 2020 09:26:46 +0000 (UTC)
Received: from localhost.localdomain ([90.126.162.40]) by mwinf5d18 with ME
 id BlSf220010scBcy03lSf0d; Sun, 08 Mar 2020 10:26:44 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Mar 2020 10:26:44 +0100
X-ME-IP: 90.126.162.40
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, nicholas.kazlauskas@amd.com, Bhawanpreet.Lakha@amd.com,
 mario.kleiner.de@gmail.com, David.Francis@amd.com
Subject: [PATCH] drm/amdgpu/display: Fix an error handling path in
 'dm_update_crtc_state()'
Date: Sun,  8 Mar 2020 10:26:37 +0100
Message-Id: <20200308092637.8194-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Mar 2020 08:14:14 +0000
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'dc_stream_release()' may be called twice. Once here, and once below in the
error handling path if we branch to the 'fail' label.

Set 'new_stream' to NULL, once released to avoid the duplicated release
function call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Maybe the 'goto fail' at line 7745 should be turned into a 'return ret'
instead. Could be clearer.

No Fixes tag provided because I've not been able to dig deep enough in the
git history.
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97c1b01c0fc1..9d7773a77c4f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7704,8 +7704,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 skip_modeset:
 	/* Release extra reference */
-	if (new_stream)
-		 dc_stream_release(new_stream);
+	if (new_stream) {
+		dc_stream_release(new_stream);
+		new_stream = NULL;
+	}
 
 	/*
 	 * We want to do dc stream updates that do not require a
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
