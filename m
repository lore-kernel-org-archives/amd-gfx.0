Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6003AC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 08:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD39810E238;
	Mon, 30 Oct 2023 08:26:05 +0000 (UTC)
Received: from 4.mo550.mail-out.ovh.net (4.mo550.mail-out.ovh.net
 [46.105.76.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4434010E0D1
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Oct 2023 16:24:07 +0000 (UTC)
Received: from director2.ghost.mail-out.ovh.net (unknown [10.109.146.211])
 by mo550.mail-out.ovh.net (Postfix) with ESMTP id 6F02724B4B
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Oct 2023 12:44:26 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-9glgx (unknown [10.110.103.93])
 by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 222291FE51;
 Sun, 29 Oct 2023 12:44:23 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.107])
 by ghost-submission-6684bf9d7b-9glgx with ESMTPSA
 id TGu9AadTPmX5kQMAW1D1+g
 (envelope-from <jose.pekkarinen@foxhound.fi>); Sun, 29 Oct 2023 12:44:23 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S0013dc59c63-7237-4b8e-b1f2-ef5aba89673c,
 2D5A9C8C3C9544CFCEEB4DEE313913C815DB1A20)
 smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.110.144
From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 skhan@linuxfoundation.org
Subject: [PATCH] drm/amd/display: remove redundant check
Date: Sun, 29 Oct 2023 14:44:04 +0200
Message-Id: <20231029124404.16159-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6028631051890370214
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupdekjedrleegrdduuddtrddugeegpdefjedrheelrddugedvrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht
X-Mailman-Approved-At: Mon, 30 Oct 2023 08:26:05 +0000
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
Cc: dillon.varone@amd.com, linux-kernel-mentees@lists.linuxfoundation.org,
 dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, samson.tam@amd.com, SyedSaaem.Rizvi@amd.com,
 aurabindo.pillai@amd.com,
 =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, george.shen@amd.com,
 alexander.deucher@amd.com, Jun.Lei@amd.com, airlied@gmail.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch addresses the following warning spotted by
using coccinelle where the case checked does the same
than the else case.

drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10: WARNING: possible condition with no effect (if == else)

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index ecea008f19d3..d940dfa5ae43 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4661,10 +4661,6 @@ void dml32_CalculateMinAndMaxPrefetchMode(
 	} else if (AllowForPStateChangeOrStutterInVBlankFinal == dm_prefetch_support_uclk_fclk_and_stutter) {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 0;
-	} else if (AllowForPStateChangeOrStutterInVBlankFinal ==
-			dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
-		*MinPrefetchMode = 0;
-		*MaxPrefetchMode = 3;
 	} else {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 3;
-- 
2.39.2

