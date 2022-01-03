Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042D0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jan 2022 17:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB9089E38;
	Mon,  3 Jan 2022 17:29:38 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96CC89E2A;
 Mon,  3 Jan 2022 17:29:36 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9859CB8107B;
 Mon,  3 Jan 2022 17:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B925C36AFC;
 Mon,  3 Jan 2022 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641230973;
 bh=cFOi+Lx49Jz2qSKIj75Qq6OD+sG4BvgvBkB5H0Skzcg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fNgQzBKtNOYCgcmiKVbjQ7Sx+SBabWOrDxm2Tx48AT6SgfRdKBDpKDfLVZQP2uusq
 9pEJEcyVfnlddu16oc57ILQoYhTYU8LtfxXBkJEDg//NReCcbfmX7sZzAWZOSff0tO
 Htx0Gf6fJc9Fyg0R+AicyFo6sl9J6WJ1ZL5JKyjc5TN5hnpVmvOZ+VB8VodT/ULCcI
 Y5o1t80oZEIBTQSpOzcNqM76JPraqh4p/u0AFTerfHenRaAnbXHBzIH/iozEJUyQKM
 +qD1f303P9O1pSYIY4V6/lY5XU9wp1S0Slu1dZcK/yX4ineaCnRW2keUvFMBgp4B/T
 7K7tAX7eLuDiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/16] drm/amdgpu: always reset the asic in
 suspend (v2)
Date: Mon,  3 Jan 2022 12:28:43 -0500
Message-Id: <20220103172849.1612731-10-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103172849.1612731-1-sashal@kernel.org>
References: <20220103172849.1612731-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, andrey.grodzovsky@amd.com,
 tzimmermann@suse.de, airlied@linux.ie, dri-devel@lists.freedesktop.org,
 Xinhui.Pan@amd.com, ray.huang@amd.com, amd-gfx@lists.freedesktop.org,
 shaoyun.liu@amd.com, Luben Tuikov <luben.tuikov@amd.com>,
 aurabindo.pillai@amd.com, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 christian.koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit daf8de0874ab5b74b38a38726fdd3d07ef98a7ee ]

If the platform suspend happens to fail and the power rail
is not turned off, the GPU will be in an unknown state on
resume, so reset the asic so that it will be in a known
good state on resume even if the platform suspend failed.

v2: handle s0ix

Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f18240f873878..ada083fbc052b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1498,7 +1498,10 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	adev->in_s3 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
 	adev->in_s3 = false;
-
+	if (r)
+		return r;
+	if (!adev->in_s0ix)
+		r = amdgpu_asic_reset(adev);
 	return r;
 }
 
-- 
2.34.1

