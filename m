Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4485FC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 16:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAA010F21D;
	Thu, 11 Aug 2022 16:11:15 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E3418A6A7;
 Thu, 11 Aug 2022 16:10:55 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 772F761470;
 Thu, 11 Aug 2022 16:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE9C433B5;
 Thu, 11 Aug 2022 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660234255;
 bh=xwtCnK1qVdKBIvDhrnlhmpj2FjfF2cVUAB5V4KxWS+o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VcXJqUd/2H9kVpXNHgTZqb9lNmLvy+VWV62NP6oF7KRyBzIoHfJCNcK/kGuq5vBZ5
 3zrxVRGXBELLNShFnZA+PiYRNpcVulRj+oL0DVZm5kH3KSGbaND+hJGfmtpCQiSDVz
 fv/H/05s2mve4xw+FYqDsNLyC2UtzWFjKVEQec+nC2LjV+QUMD/WQj0oGccF35C+/Q
 RQRB+rNZaaBTqLNurE0Qoc6gUL4kQ/Yg0zpYIx4NUMOHZC5qepjlacWmvgW8nIF5Rb
 htvDWGrTkOoyrEMR5PGExaQQWdvO3daamylCf4gvC9AOT0Gs71MDoyzcQBINh0sxqS
 m8FzJ0zZbBQOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/14] drm/radeon: integer overflow in
 radeon_mode_dumb_create()
Date: Thu, 11 Aug 2022 12:10:31 -0400
Message-Id: <20220811161050.1543183-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811161050.1543183-1-sashal@kernel.org>
References: <20220811161050.1543183-1-sashal@kernel.org>
MIME-Version: 1.0
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
Cc: Sasha Levin <sashal@kernel.org>, airlied@linux.ie, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>

[ Upstream commit feb54650bae25f2a2adfc493e3e254e7c27a3fba ]

Similar to the handling of amdgpu_mode_dumb_create in commit 54ef0b5461c0
("drm/amdgpu: integer overflow in amdgpu_mode_dumb_create()"),
we thought a patch might be needed here as well.

args->size is a u64.  arg->pitch and args->height are u32.  The
multiplication will overflow instead of using the high 32 bits as
intended.

Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index ac467b80edc7..18a914752a32 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -749,7 +749,7 @@ int radeon_mode_dumb_create(struct drm_file *file_priv,
 
 	args->pitch = radeon_align_pitch(rdev, args->width,
 					 DIV_ROUND_UP(args->bpp, 8), 0);
-	args->size = args->pitch * args->height;
+	args->size = (u64)args->pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
 	r = radeon_gem_object_create(rdev, args->size, 0,
-- 
2.35.1

