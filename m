Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA13CC25B08
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 20:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E523E92624;
	Sat, 13 Aug 2022 20:10:45 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1589CA9B74;
 Sat, 13 Aug 2022 15:11:24 +0000 (UTC)
X-QQ-mid: bizesmtp73t1660403473tx7cheir
Received: from localhost.localdomain ( [110.188.55.240])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 13 Aug 2022 23:10:59 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: 0XQDeqdIgBaOwRluupUQcEYfA+apZ/yhPClKm7HGHLDEetNR0Mtdw40P9KGXQ
 bDNW4J1XxMmbrpDJSDVZJ7b5DZzYFKgfQ7yHk3rUXe/IOUjqydg56Yxb+KzVut7DJWjjhUl
 QFx7r834CylE06jDO0Hh2dYXSJ6CD36oDkJfZd+ZTRVjBKu6PCXRswQjlL0F4ZImRW6UCB2
 vPPq/JZxcXN98yWRheSpsTc8mRJ4+a96NsHaz8buvYWRk/k8pNT8kaK+0W2CVTkqZbxCBb1
 7e6bv2Z0QzS0mxdcXqCMl1zopv8YfLZVrcmQe1J84AEFwj+JfV3tC0YgtgTcmJtI5DzmyXJ
 SUd3DGkAQ4ReJZKWrwT7OIDGo752/gLDbYrYfCl
X-QQ-GoodBg: 0
From: min tang <tangmin@cdjrlc.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd/display: Fix comment typo
Date: Sat, 13 Aug 2022 23:10:46 +0800
Message-Id: <20220813151046.4041-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Mailman-Approved-At: Sat, 13 Aug 2022 20:10:15 +0000
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
Cc: Charlene.Liu@amd.com, min tang <tangmin@cdjrlc.com>, Xinhui.Pan@amd.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 isabbasso@riseup.net, Jun.Lei@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The double `aligned' is duplicated in line 1070, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index b1671b00ce40..0844b3eeb291 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1066,7 +1066,7 @@ static void optc1_set_test_pattern(
 				src_color[index] >> (src_bpc - dst_bpc);
 		/* CRTC_TEST_PATTERN_DATA has 16 bits,
 		 * lowest 6 are hardwired to ZERO
-		 * color bits should be left aligned aligned to MSB
+		 * color bits should be left aligned to MSB
 		 * XXXXXXXXXX000000 for 10 bit,
 		 * XXXXXXXX00000000 for 8 bit and XXXXXX0000000000 for 6
 		 */
-- 
2.17.1

