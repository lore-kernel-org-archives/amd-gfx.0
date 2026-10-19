Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A29CCCF2E3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5A910E569;
	Mon, 19 Oct 2026 13:02:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF8F10E569
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=UC5qdnnHzsg+ad2APRnxf2e/Ct/MEAwdvByC3ZIlrQ0=; b=fqytV8XrS9N11T30PNKP6ncs1u
 QFXjrMPle0FxG1S/+A838vMH0N3BK4NDQcLXb0Pwmg84dSfrnHW9SSdZ7JK1Vb+pZet/tXVXRoulx
 YOdysZMpVjNTL35ohbh+y0eLE2CyfYMk625i3nIO7OzCTH/aEfeuQkGrQvjJQR2AXHEo8Sd5mQ3ii
 SEcf+ZpPmXzVDSnVwRv09H4irmFK90vseOq7ZIgdgS5tem+xTK6e9/TtQBQ2tjOlGgEwnNpNwn22U
 eshH5gREjHoeDZ9+CmwhYFaW7VBPQnUBER39zNyisy4uWfSe2owydHyjGMUgJR6seXwdxV2nlEzCf
 wyph3/xw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xIn0H-003UKJ-Ji; Mon, 19 Oct 2026 15:02:13 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 1/7] drm/amdgpu: Check correct field in
 amdgpu_ttm_tt_is_userptr()
Date: Mon, 19 Oct 2026 14:01:53 +0100
Message-ID: <20261019130159.11739-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Presence of a task is a better indicator whether something is a userptr
than the address of an userspace VMA.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8f0720a77520..8acb12da6e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1416,7 +1416,7 @@ bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
 {
 	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
-	if (gtt == NULL || !gtt->userptr)
+	if (gtt == NULL || !gtt->usertask)
 		return false;
 
 	return true;
-- 
2.56.0

