Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DE2C47DD9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 15:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E7410F384;
	Mon, 22 Jan 2024 15:12:52 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A8910F3A6;
 Mon, 22 Jan 2024 15:12:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 56E5DB80E68;
 Mon, 22 Jan 2024 15:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A615C43390;
 Mon, 22 Jan 2024 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705936340;
 bh=sd7iwprj+8LybP1sstXYWOpMSALRS7T7tigyJk1aFXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y+kQpyf87QuFc6rxIITMUfUiRx5tBggF5b5H3+fSm2mepEqekKdW/KyFLOLDUwM2Z
 yrANlBhv8del0y4PaW5oug04+KjYwAo4KoNc36uMsilfON6BB5rrWgqGGqd3z3vm+2
 DILan3J1DvEhOWU64XJeRxhJ1klq7DCuLDq8SGfRAMeOjAjUzvL/1l8qQzld1UnUm8
 Xfrx44ep3rf3RwC1nzN4kg8EHLmFWHDIZKUdiBJNXV0z15bMfG2Yh3pXr91aD4Ffq8
 9A8PmVJ/IXslHiIjL3qxomTkN8+SQW4+S+1Fvn0i6OiHsZaA9Yu7xJFd7N4Y0/QTHo
 cAxE5DYYY2J/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 47/53] drm/amdgpu: Fix '*fw' from
 request_firmware() not released in 'amdgpu_ucode_request()'
Date: Mon, 22 Jan 2024 10:08:48 -0500
Message-ID: <20240122150949.994249-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
Cc: Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Ori.Messinger@amd.com,
 amd-gfx@lists.freedesktop.org, Lang.Yu@amd.com,
 dri-devel@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 lee@kernel.org, le.ma@amd.com, Stanley.Yang@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 13a1851f923d9a7a78a477497295c2dfd16ad4a4 ]

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:1404 amdgpu_ucode_request() warn: '*fw' from request_firmware() not released on lines: 1404.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 6e7058a2d1c8..779707f19c88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1110,9 +1110,13 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 
 	if (err)
 		return -ENODEV;
+
 	err = amdgpu_ucode_validate(*fw);
-	if (err)
+	if (err) {
 		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
+		release_firmware(*fw);
+		*fw = NULL;
+	}
 
 	return err;
 }
-- 
2.43.0

