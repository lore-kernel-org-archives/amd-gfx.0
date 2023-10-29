Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3AAC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 08:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F2910E23A;
	Mon, 30 Oct 2023 08:26:07 +0000 (UTC)
X-Greylist: delayed 12600 seconds by postgrey-1.36 at gabe;
 Sun, 29 Oct 2023 14:27:44 UTC
Received: from 2.mo582.mail-out.ovh.net (2.mo582.mail-out.ovh.net
 [46.105.76.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA28C10E160
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Oct 2023 14:27:44 +0000 (UTC)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.156.105])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id CB3BE256EE
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Oct 2023 09:38:31 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-x2g4z (unknown [10.111.208.154])
 by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9167A1FD2F;
 Sun, 29 Oct 2023 09:38:28 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.107])
 by ghost-submission-6684bf9d7b-x2g4z with ESMTPSA
 id 9QKQHBQoPmXpkwQAjDjF9w
 (envelope-from <jose.pekkarinen@foxhound.fi>); Sun, 29 Oct 2023 09:38:28 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001d53088e7-9f9b-4152-9236-a5a90e87501e,
 2D5A9C8C3C9544CFCEEB4DEE313913C815DB1A20)
 smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.110.144
From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 skhan@linuxfoundation.org
Subject: [PATCH] drm/amd/display: remove duplicated argument
Date: Sun, 29 Oct 2023 11:39:26 +0200
Message-Id: <20231029093926.137766-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2888777688825374374
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupdekjedrleegrdduuddtrddugeegpdefjedrheelrddugedvrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
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
Cc: dri-devel@lists.freedesktop.org, sunran001@208suo.com, alex.hung@amd.com,
 linux-kernel-mentees@lists.linuxfoundation.org, qingqing.zhuo@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Zhongwei.Zhang@amd.com, Yao.Wang1@amd.com,
 =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
 aurabindo.pillai@amd.com, daniel@ffwll.ch, Jun.Lei@amd.com, airlied@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Spotted by coccicheck, there is a redundant check for
v->SourcePixelFormat[k] != dm_444_16. This patch will
remove it. The corresponding output follows.

drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:5130:86-122: duplicated argument to && or ||

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index ad741a723c0e..3686f1e7de3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5128,7 +5128,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			ViewportExceedsSurface = true;
 
 		if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16
-				&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != dm_rgbe) {
+				&& v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != dm_rgbe) {
 			if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k] || v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
 				ViewportExceedsSurface = true;
 			}
-- 
2.39.2

