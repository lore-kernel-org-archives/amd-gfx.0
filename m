Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF882C6FA8F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 14:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445BE10E534;
	Wed, 30 Aug 2023 14:24:40 +0000 (UTC)
X-Greylist: delayed 358 seconds by postgrey-1.36 at gabe;
 Wed, 30 Aug 2023 14:08:22 UTC
Received: from forward204c.mail.yandex.net (forward204c.mail.yandex.net
 [178.154.239.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469C810E52B;
 Wed, 30 Aug 2023 14:08:22 +0000 (UTC)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
 by forward204c.mail.yandex.net (Yandex) with ESMTP id D9B9063DBA;
 Wed, 30 Aug 2023 17:02:24 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:332f:0:640:4ab4:0])
 by forward102b.mail.yandex.net (Yandex) with ESMTP id E46DD60058;
 Wed, 30 Aug 2023 17:02:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id G2SS5ILDSOs0-K05UNMia; 
 Wed, 30 Aug 2023 17:02:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail;
 t=1693404137; bh=4UuCYf2z5ERazgVTAra1HLGpzXEpox1UP/x9Vsz8zxY=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=qEiA2dnxfjTOmXj1MmyZwpY7734vhltXUdpITsPx4rEhCe7hqAVGl1NEvXOE14Y7D
 6GEi4E0oTDexaCQv7HAB5GsalD798LJnUL4sq7BWgkrzpFWO0+feO1XvoOTjHXbJAY
 mq3pVuXQ3yesVGiumsFbtoqtKoisQqnqj3qSYDFQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net;
 dkim=pass header.i=@itb.spb.ru
From: Dembskiy Igor <dii@itb.spb.ru>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: remove useless check in should_enable_fbc()
Date: Wed, 30 Aug 2023 17:01:03 +0300
Message-Id: <20230830140103.311752-1-dii@itb.spb.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Aug 2023 14:24:37 +0000
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
Cc: Dembskiy Igor <dii@itb.spb.ru>, lvc-project@linuxtesting.org,
 Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, hersen wu <hersenxs.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It does not make sense to compare a pointer to array element with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 65d38262b3e8 ("drm/amd/display: fbc state could not reach while enable fbc")
Signed-off-by: Dembskiy Igor <dii@itb.spb.ru>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 6966420dfbac..e87cf54ec658 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1992,9 +1992,6 @@ static bool should_enable_fbc(struct dc *dc,
 
 			pipe_ctx = &res_ctx->pipe_ctx[i];
 
-			if (!pipe_ctx)
-				continue;
-
 			/* fbc not applicable on underlay pipe */
 			if (pipe_ctx->pipe_idx != underlay_idx) {
 				*pipe_idx = i;
-- 
2.34.1

