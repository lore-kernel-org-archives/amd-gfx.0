Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E24C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 18:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5763510E534;
	Wed,  9 Feb 2022 18:40:43 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C86C10E52E;
 Wed,  9 Feb 2022 18:40:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E11FA61018;
 Wed,  9 Feb 2022 18:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37942C340E7;
 Wed,  9 Feb 2022 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644432040;
 bh=su5tWGjpZ4inHUxdAgviiH1QYt3xfVvRJgHlrKb+6GE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ayg5wjSSixFdVOAQtXdDLlfTnYordB/jILvAkJT5B7L3bZbKG2gbcmGwnGDTlREO3
 tJdMAwYMTw5tvQ9P/5aYDmEXPDx22b+0NyevMQDsboSIGYNRgUCA7XbsytoZmJc/nY
 x4wrlRD3ajRL0wn1rjNe5tQsDVNB932eCX+6OQUzw4vyxH/vNMKK/fBes7kl08EwFB
 Cm564FTQ2lfrzdNIOvyIYF+OyFG2CcL10d4AeIogY9VZ9uYTTnlfHNTtLLpRBqxvCm
 vhqp/oOAHJPDEEQ0MskEGVfBNtS8CClrq+H6xHgk8VYLZZh0T1vuRDhzfS9dAQdykF
 9hfkfEobWyS7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 32/36] drm/amdgpu: fix logic inversion in check
Date: Wed,  9 Feb 2022 13:37:55 -0500
Message-Id: <20220209183759.47134-32-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209183759.47134-1-sashal@kernel.org>
References: <20220209183759.47134-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Cc: Sasha Levin <sashal@kernel.org>, Philip.Yang@amd.com, Oak.Zeng@amd.com,
 tzimmermann@suse.de, kevin1.wang@amd.com, airlied@linux.ie,
 Felix Kuehling <Felix.Kuehling@amd.com>, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian König <christian.koenig@amd.com>

[ Upstream commit e8ae38720e1a685fd98cfa5ae118c9d07b45ca79 ]

We probably never trigger this, but the logic inside the check is
inverted.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 94126dc396888..8132f66177c27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1892,7 +1892,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	unsigned i;
 	int r;
 
-	if (direct_submit && !ring->sched.ready) {
+	if (!direct_submit && !ring->sched.ready) {
 		DRM_ERROR("Trying to move memory with ring turned off.\n");
 		return -EINVAL;
 	}
-- 
2.34.1

