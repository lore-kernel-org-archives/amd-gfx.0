Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0EFD61014
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 12:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC82710E868;
	Thu, 29 Jan 2026 12:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="VUzNK6Lc";
	dkim-atps=neutral
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B7C610E83B;
 Thu, 29 Jan 2026 09:05:49 +0000 (UTC)
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
 by smtp.qiye.163.com (Hmail) with ESMTP id 32699cf23;
 Thu, 29 Jan 2026 17:05:45 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, Prike.Liang@amd.com,
 le.ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] drm/amdgpu: Use kvfree instead of kfree in
 amdgpu_gmc_get_nps_memranges()
Date: Thu, 29 Jan 2026 09:05:42 +0000
Message-Id: <20260129090542.907623-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0900613803a1kunm465c995a10b97f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQhkdVhkZQ0tJQxoYTE0dS1YeHw5VEwETFhoSFy
 QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
 ++
DKIM-Signature: a=rsa-sha256;
 b=VUzNK6LcXpSolDCnOVEOm2cgMJ7l996ghpbKUuBVBA1gPAxZGrV5wNnJ7CmqI8w52KDanfuBnqpt9wYlkJQhgfq4QGpAKMrnyQfPlEtyh3aLfmEJxZtKizDALqWcp2LcULayLgDclOv2TCj2/WeXHuwyaiMH+aV8msZLrUPanvk=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=ZmXJ3O1Z7fCSx2JYjXY/DoaySeq3pCLYnyjozwche5c=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Thu, 29 Jan 2026 12:55:40 +0000
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

amdgpu_discovery_get_nps_info() internally allocates memory for ranges
using kvcalloc(), which may use vmalloc() for large allocation. Using
kfree() to release vmalloc memory will lead to a memory corruption.

Use kvfree() to safely handle both kmalloc and vmalloc allocations.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: b194d21b9bcc ("drm/amdgpu: Use NPS ranges from discovery table")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7e623f91f2d7..cb0d1ac148e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1382,7 +1382,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 	if (!*exp_ranges)
 		*exp_ranges = range_cnt;
 err:
-	kfree(ranges);
+	kvfree(ranges);
 
 	return ret;
 }
-- 
2.34.1

