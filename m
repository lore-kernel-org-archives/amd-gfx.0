Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD974CCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 12:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AFE910E54D;
	Mon, 19 Oct 2026 12:56:25 +0000 (UTC)
Received: from proxy25212.mail.163.com (proxy25212.mail.163.com
 [103.129.252.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300C510E0B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8w
 BHesupO68D0giBCVsmqzzCieBBTYajRHnqr5mfSWI=; b=SW421hVv2v1/HXeM8K
 pYZiR8nJjCDnrldoSnL6W6r5boVP4tSvlbUn1XZGvq51IM+Acs8STjtLiQ1zp1Pt
 XRrVameRislG3EO7qge3vHho/yf8uF8Yh6qy/Wdun/eUjqKlkm+qW1HJtyB5ikMb
 YglvodBAOC2IrMaA8p4+wAYqg=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDnt9ng19VqcQOlAw--.9091S6; 
 Mon, 19 Oct 2026 16:42:17 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 4/6] drm/radeon: reject empty VRAM ranges
Date: Mon, 19 Oct 2026 16:41:36 +0800
Message-Id: <20261019084138.1821477-5-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019084138.1821477-1-yaojiale02@163.com>
References: <20261019084138.1821477-1-yaojiale02@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnt9ng19VqcQOlAw--.9091S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrykuF1kZry7CF4rJrW8Zwb_yoWDXrgEgr
 40va4xX34qg3WvqF1kua13ZrZIya1v9Fs5ZF1Iq34fKr9rXF1xZFy3Xr1kXrWUWw43AF98
 ArsYq3y3trZI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiveHPUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AlAemrV1+m3QgAA33
X-Mailman-Approved-At: Mon, 19 Oct 2026 12:56:23 +0000
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

A VRAM size smaller than a page becomes a zero-page TTM range and
causes drm_mm_init() to hit its zero-range BUG check. Reject such a
range before initializing the VRAM manager.

Fixes: 37205891d84f ("drm/ttm: make ttm_range_man_init/takedown take type + args")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index e7ab8162ac69..925593af1688 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -69,6 +69,9 @@ struct radeon_device *radeon_get_rdev(struct ttm_device *bdev)
 
 static int radeon_ttm_init_vram(struct radeon_device *rdev)
 {
+	if (rdev->mc.real_vram_size < PAGE_SIZE)
+		return -EINVAL;
+
 	return ttm_range_man_init(&rdev->mman.bdev, TTM_PL_VRAM,
 				  false, rdev->mc.real_vram_size >> PAGE_SHIFT);
 }
-- 
2.34.1

