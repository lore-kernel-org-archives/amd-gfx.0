Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A704CD61013
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 12:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2021C10E85F;
	Thu, 29 Jan 2026 12:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BLIfnR/l";
	dkim-atps=neutral
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE4F10E73E;
 Thu, 29 Jan 2026 09:25:38 +0000 (UTC)
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
 by smtp.qiye.163.com (Hmail) with ESMTP id 326a2d473;
 Thu, 29 Jan 2026 17:25:35 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 mario.limonciello@amd.com, pratap.nirujogi@amd.com, alex.hung@amd.com,
 sakari.ailus@linux.intel.com, lijo.lazar@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jianhao.xu@seu.edu.cn, Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_acpi_enumerate_xcc()
Date: Thu, 29 Jan 2026 09:25:32 +0000
Message-Id: <20260129092532.921809-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0912888703a1kunmfecbb79410cc7f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEJIVkNDQktDH04aSR4fH1YeHw5VEwETFhoSFy
 QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
 ++
DKIM-Signature: a=rsa-sha256;
 b=BLIfnR/lBXjlW/j9BG7yESi1l6jZ8+lND0IcGx318XgpljYJVYLprh9Yg6tSWxxoH4JArxjP35xuFV17HGfR/r6+xUGQ2SRXg7exRYDfJBWsl90KkONilnZcVta/p14MqzNfG4+u3lyHZDpfdJCkvxorXdenxqHz/sACfnXWwrg=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=CXMwENmzKP+RWsE+LIKSDf98HXtSoCzOeMJnBvytx4w=;
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

In amdgpu_acpi_enumerate_xcc(), if amdgpu_acpi_dev_init() returns -ENOMEM,
the function returns directly without releasing the allocated xcc_info,
resulting in a memory leak.

Fix this by ensuring that xcc_info is properly freed in the error paths.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 4d5275ab0b18 ("drm/amdgpu: Add parsing of acpi xcc objects")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index d31460a9e958..7c9d8a6d0bfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1135,8 +1135,10 @@ static int amdgpu_acpi_enumerate_xcc(void)
 		if (!dev_info)
 			ret = amdgpu_acpi_dev_init(&dev_info, xcc_info, sbdf);
 
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM) {
+			kfree(xcc_info);
 			return ret;
+		}
 
 		if (!dev_info) {
 			kfree(xcc_info);
-- 
2.34.1

