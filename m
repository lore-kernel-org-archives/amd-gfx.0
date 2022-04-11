Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CD2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 16:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D7F10E5B3;
	Mon, 11 Apr 2022 16:43:46 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB98610E5B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 16:43:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3AC4B6171B;
 Mon, 11 Apr 2022 16:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E101C385AB;
 Mon, 11 Apr 2022 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649695423;
 bh=Hd9RIiV9sj4XsiYmPzJvoULwJHhbWbl+m0vIsIQTM28=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iUFXWr6UK+Y78LvUBr67l+mPoY3/ZX1OUkaqn4LfKMyctVMQzICrlm/JXAZKQiUvo
 MTUNTnWCz8zO5jVAuudmR/BBJ6wvJqph25dyQdfqVq7Dxq9bq7sHuzb7nFxbqXb36F
 2+i3h4O+VS5HwlcK1NMVrzRjIirvf4L29RpuOjnJ6t3PQ5OwvGt/hT+kRYNxPN1mBJ
 OrXb+5j5i69vBouR8ityz4gf9xKHp6KWMrfBBZfXfiwHbtFgQ+cOE5+T+ajDJC9sz0
 e+a5Hs9iszgLlJ7HKHmq9kvJDWVUrNyjI9AZqxFC62K5urGKa0UhEKlGN6svvHpoVr
 MlxZZrOYz811g==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 2/2] drm/amdkfd: Fix -Wstrict-prototypes from
 amdgpu_amdkfd_gfx_10_0_get_functions()
Date: Mon, 11 Apr 2022 09:43:08 -0700
Message-Id: <20220411164308.2491139-3-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411164308.2491139-1-nathan@kernel.org>
References: <20220411164308.2491139-1-nathan@kernel.org>
MIME-Version: 1.0
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is for linux-5.4.y only, it has no equivalent change
upstream.

When building x86_64 allmodconfig with tip of tree clang, there is an
instance of -Wstrict-prototypes:

  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c:168:59: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
  struct kfd2kgd_calls *amdgpu_amdkfd_gfx_10_0_get_functions()
                                                            ^
                                                             void
  1 error generated.

amdgpu_amdkfd_gfx_10_0_get_functions() is prototyped properly in
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h but its definition in
amdgpu_amdkfd_gfx_v10.c does not have the argument types specified,
which causes the warning. GCC does not warn because it permits an
old-style definition if the prototype has the argument types.

This code was eliminated by commit e392c887df97 ("drm/amdkfd: Use array
to probe kfd2kgd_calls"), which was a part of a larger series that does
not look very suitable for stable. Just fix this one location, as it was
the only instance of this new warning across a variety of builds.

Fixes: 6bdadb207224 ("drm/amdgpu: Add navi10 kfd support for amdgpu (v3)")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index ce30d4e8bf25..f7c4337c1ffe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -165,7 +165,7 @@ static const struct kfd2kgd_calls kfd2kgd = {
 	.get_tile_config = amdgpu_amdkfd_get_tile_config,
 };
 
-struct kfd2kgd_calls *amdgpu_amdkfd_gfx_10_0_get_functions()
+struct kfd2kgd_calls *amdgpu_amdkfd_gfx_10_0_get_functions(void)
 {
 	return (struct kfd2kgd_calls *)&kfd2kgd;
 }
-- 
2.35.1

