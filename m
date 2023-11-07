Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484D8C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 12:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A914710E564;
	Tue,  7 Nov 2023 12:25:15 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31AB10E562;
 Tue,  7 Nov 2023 12:25:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 383A5CE0F15;
 Tue,  7 Nov 2023 12:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7BBC433C7;
 Tue,  7 Nov 2023 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699359908;
 bh=Lj88U1SPOqCViOGx6/79GRnr+Zs7V2e0o7KdzccDOqA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X9ornXobvTP9N3kMPQoJO4PYABVfFXUW2IND1zLdI7aT0mgWWq1YSl1nTXWnQt8Ww
 t+SbaxfTykSXhurf+SZir/NxQWWnE3IM40G8Yh51TeuVQk+O4RT7xuc65j204fFZf4
 MZNn0BBn+NhN9QaQ8KVzuiuatvttQfzZ9TN3GxC34DP2FSD6f0BN+rI5NXhHBJbNr0
 JUboxh3qTmkqV77CK1xG7G2+G+O7nmcx41Gynxw0DeXQFDFCZeNl80LtogUbKNisFo
 cw26UZ6zu0UmYjJBnqeLtenrqNvIzd5Lc+rgTT5U4YJYziE9YnaT0myKJg0KHNmG9x
 Eu+Wla7iZukTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 10/37] drm/amdkfd: Fix a race condition of vram
 buffer unref in svm code
Date: Tue,  7 Nov 2023 07:21:21 -0500
Message-ID: <20231107122407.3760584-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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
Cc: Sasha Levin <sashal@kernel.org>, Philip Yang <Philip.Yang@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

[ Upstream commit 709c348261618da7ed89d6c303e2ceb9e453ba74 ]

prange->svm_bo unref can happen in both mmu callback and a callback after
migrate to system ram. Both are async call in different tasks. Sync svm_bo
unref operation to avoid random "use-after-free".

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Tested-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5ff1a5a89d968..ed365f8ebf53f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -617,8 +617,15 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 
 void svm_range_vram_node_free(struct svm_range *prange)
 {
-	svm_range_bo_unref(prange->svm_bo);
-	prange->ttm_res = NULL;
+	/* serialize prange->svm_bo unref */
+	mutex_lock(&prange->lock);
+	/* prange->svm_bo has not been unref */
+	if (prange->ttm_res) {
+		prange->ttm_res = NULL;
+		mutex_unlock(&prange->lock);
+		svm_range_bo_unref(prange->svm_bo);
+	} else
+		mutex_unlock(&prange->lock);
 }
 
 struct kfd_node *
-- 
2.42.0

