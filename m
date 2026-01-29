Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCE8D358E7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 08:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6BC810E82E;
	Thu, 29 Jan 2026 08:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="JYCIQQEe";
	dkim-atps=neutral
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Thu, 29 Jan 2026 08:40:24 UTC
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0F510E33C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 08:40:23 +0000 (UTC)
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
 by smtp.qiye.163.com (Hmail) with ESMTP id 32682fc73;
 Thu, 29 Jan 2026 16:35:16 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 tao.zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng.Chai@amd.com,
 ganglxie@amd.com, Stanley.Yang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_ras_init()
Date: Thu, 29 Jan 2026 08:35:15 +0000
Message-Id: <20260129083515.886112-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c08e477e003a1kunm92e525c1109cdc
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUxNVkNLS0weTh0YSk8eQ1YeHw5VEwETFhoSFy
 QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
 tZBg++
DKIM-Signature: a=rsa-sha256;
 b=JYCIQQEeT13b0SzJAaVxu3/IOZNblgiFjNemjUkzGXSaHvOTvzGIqedotLFk7VPrGrBT3/tovOhpPIHnUuVp8SFZWr6UDzZiVtibggMP738+D01du7y8VYXozNew4aO4e1cPMBMdIDBhs9dQ7Y5IA5P+EPMQ+D4tANr1XLKdO/M=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=nuTqOxVNmE8t2k0UNGPm5EmQmSMZzZtlqyG00Pd8Dfc=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Thu, 29 Jan 2026 08:56:55 +0000
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

When amdgpu_nbio_ras_sw_init() fails in amdgpu_ras_init(), the function
returns directly without freeing the allocated con structure, leading
to a memory leak.

Fix this by jumping to the release_con label to properly clean up the
allocated memory before returning the error code.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: fdc94d3a8c88 ("drm/amdgpu: Rework pcie_bif ras sw_init")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2a6cf7963dde..8de9f68f7bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4343,7 +4343,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	 * to handle fatal error */
 	r = amdgpu_nbio_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto release_con;
 
 	if (adev->nbio.ras &&
 	    adev->nbio.ras->init_ras_controller_interrupt) {
-- 
2.34.1

