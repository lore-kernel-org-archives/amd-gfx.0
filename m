Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6549C47DD9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 15:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 688BF10F3C8;
	Mon, 22 Jan 2024 15:14:57 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1BB10F3C8;
 Mon, 22 Jan 2024 15:14:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 57B6BCE2B2D;
 Mon, 22 Jan 2024 15:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7A4C43390;
 Mon, 22 Jan 2024 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705936490;
 bh=mzi5NHP8bCYjNBU9rs2CUmq+0f5UYRsaFPEx5gp8MLk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XEsC+y3RG9tL5IErV1zXHWvZmgo3XD43k2oLu18sBLTCxekoTS7Kl2XeXir3SApD4
 kY4j4C6QcFOP8ohK30ZTM4/3eu4hDgZygkwDnpv5Ni5fkR5UWmMuaKU2LilP898pDW
 6+lCZIyvbNkKyPb2hzKYsCO27Nlr1grprAXZTS9sZCRaZ48CYRlHRpae2f9wVbX0Fu
 Nlksk5t5hRntdxS3gA/FTNDjiOsFPRkgzFjhyKJCoYixLhvT68Xw+X+zBQ5FzsoB54
 f9CQKNVLEWwUBTDYVY5o+4p4daMGgR6fIYu2Xlig6XkfD9yCa4jbzGhtHl3gd3o7o0
 82LAuRcLnCVLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 34/35] drm/amdgpu: Drop 'fence' check in
 'to_amdgpu_amdkfd_fence()'
Date: Mon, 22 Jan 2024 10:12:31 -0500
Message-ID: <20240122151302.995456-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
Cc: Sasha Levin <sashal@kernel.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit bf2ad4fb8adca89374b54b225d494e0b1956dbea ]

Return value of container_of(...) can't be null, so null check is not
required for 'fence'. Hence drop its NULL check.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:93 to_amdgpu_amdkfd_fence() warn: can 'fence' even be NULL?

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1d0dbff87d3f..fb66e888ab3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -90,7 +90,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
 		return NULL;
 
 	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
-	if (fence && f->ops == &amdkfd_fence_ops)
+	if (f->ops == &amdkfd_fence_ops)
 		return fence;
 
 	return NULL;
-- 
2.43.0

