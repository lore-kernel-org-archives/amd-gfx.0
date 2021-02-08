Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C93C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 17:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F54664ECE
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 17:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F54664ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D256E98E;
	Mon,  8 Feb 2021 17:58:43 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6665E6E986;
 Mon,  8 Feb 2021 17:58:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EF3164EC5;
 Mon,  8 Feb 2021 17:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612807120;
 bh=rHQ6/fju4rAK1V6lDyHGd/JHhheat/zTN2GPtGP4UDU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wuh401ucr71x4g5XGvSHT3IadFc1s1cealmoEV28VKxW8thbB8dI0vCWLEV4Bj+mJ
 3g06i1r9G0c1zaLPo/g3fuHacvE/6DF7NL3EQdVu2Jh1RInYQW3Eq98kJoVVDYwEot
 HyfcvKboqGhRizT2LMmY5A5H6SV6rpmoGJMldsx34Juc8DghM4a4BrEFgJlT9BbH8G
 xBVM10maqMtMyMW/LZ20sgQYhmDZcqhAvNUp3fbJvumI2W27tksWVAotaN+4T0vuqp
 s6tFpu2bXQKz2jPt6oCTI3ngRVk4ja1Zw10nJZno0MCA6Im6VkHAeJ8e7ZGE6OmReA
 bN20bT02E7OtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 24/36] drm/amd/display: Free atomic state after
 drm_atomic_commit
Date: Mon,  8 Feb 2021 12:57:54 -0500
Message-Id: <20210208175806.2091668-24-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210208175806.2091668-1-sashal@kernel.org>
References: <20210208175806.2091668-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Anson Jacob <Anson.Jacob@amd.com>,
 Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Victor Lu <victorchengchi.lu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[ Upstream commit 2abaa323d744011982b20b8f3886184d56d23946 ]

[why]
drm_atomic_commit was changed so that the caller must free their
drm_atomic_state reference on successes.

[how]
Add drm_atomic_commit_put after drm_atomic_commit call in
dm_force_atomic_commit.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f1fea71a7073c..695a5b83c00f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7872,14 +7872,14 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 
 	ret = PTR_ERR_OR_ZERO(conn_state);
 	if (ret)
-		goto err;
+		goto out;
 
 	/* Attach crtc to drm_atomic_state*/
 	crtc_state = drm_atomic_get_crtc_state(state, &disconnected_acrtc->base);
 
 	ret = PTR_ERR_OR_ZERO(crtc_state);
 	if (ret)
-		goto err;
+		goto out;
 
 	/* force a restore */
 	crtc_state->mode_changed = true;
@@ -7889,17 +7889,15 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 
 	ret = PTR_ERR_OR_ZERO(plane_state);
 	if (ret)
-		goto err;
-
+		goto out;
 
 	/* Call commit internally with the state we just constructed */
 	ret = drm_atomic_commit(state);
-	if (!ret)
-		return 0;
 
-err:
-	DRM_ERROR("Restoring old state failed with %i\n", ret);
+out:
 	drm_atomic_state_put(state);
+	if (ret)
+		DRM_ERROR("Restoring old state failed with %i\n", ret);
 
 	return ret;
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
