Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F50C4167D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 08:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76EF10E1C5;
	Tue, 14 Nov 2023 08:18:03 +0000 (UTC)
Received: from 6.mo582.mail-out.ovh.net (6.mo582.mail-out.ovh.net
 [87.98.177.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E97510E1B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 06:42:46 +0000 (UTC)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.1.20])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 723482837D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 06:36:58 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-xkfk5 (unknown [10.110.208.213])
 by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 7942A1FDCE;
 Tue, 14 Nov 2023 06:36:55 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.99])
 by ghost-submission-6684bf9d7b-xkfk5 with ESMTPSA
 id ONtBGYcVU2XrtQYAFz0/+Q
 (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 14 Nov 2023 06:36:55 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00388b5308c-d874-4d8f-9cc7-23e6befe93bc,
 39B655737E19CE8DAD14488E69459E8CEBC9C448)
 smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 83.100.46.156
From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 skhan@linuxfoundation.org
Subject: [PATCH] drm/amd/display: fix NULL dereference
Date: Tue, 14 Nov 2023 08:36:46 +0200
Message-Id: <20231114063647.71929-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1552053025768449729
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeeftdelueetieetvdettdetueeivedujeefffdvteefkeelhefhleelfeetteejjeenucfkphepuddvjedrtddrtddruddpkeefrddutddtrdegiedrudehiedpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
X-Mailman-Approved-At: Tue, 14 Nov 2023 08:18:02 +0000
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
Cc: dri-devel@lists.freedesktop.org, qingqing.zhuo@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com,
 =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
 hamza.mahfooz@amd.com, daniel@ffwll.ch, Wayne.Lin@amd.com,
 srinivasan.shanmugam@amd.com, mikita.lipski@amd.com, airlied@gmail.com,
 linux-kernel-mentees@lists.linux.dev, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following patch will fix a minor issue where a debug message is
referencing an struct that has just being checked whether is null or
not. This has been noticed by using coccinelle, in the following output:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c:540:25-29: ERROR: aconnector is NULL but dereferenced.

Fixes: 5d72e247e58c9 ("drm/amd/display: switch DC over to the new DRM logging macros")
Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index ed784cf27d39..7048dab5e356 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -537,8 +537,7 @@ bool dm_helpers_dp_read_dpcd(
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
 	if (!aconnector) {
-		drm_dbg_dp(aconnector->base.dev,
-			   "Failed to find connector for link!\n");
+		DRM_ERROR("Failed to find connector for link!");
 		return false;
 	}
 
-- 
2.39.2

