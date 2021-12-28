Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC1FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 14:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4525710E165;
	Wed, 29 Dec 2021 14:58:52 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 28 Dec 2021 07:36:50 UTC
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC21B89C08;
 Tue, 28 Dec 2021 07:36:50 +0000 (UTC)
X-UUID: c5eaab73c6814abc813d602ca3e67c2c-20211228
X-UUID: c5eaab73c6814abc813d602ca3e67c2c-20211228
X-User: wenzhiwei@kylinos.cn
Received: from localhost.localdomain.localdomain [(172.17.127.26)] by
 nksmu.kylinos.cn (envelope-from <wenzhiwei@kylinos.cn>) (Generic MTA)
 with ESMTP id 1341986671; Tue, 28 Dec 2021 15:44:06 +0800
From: Wen Zhiwei <wenzhiwei@kylinos.cn>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH] gpu/drm/radeon:Fix null pointer risk
Date: Tue, 28 Dec 2021 15:31:26 +0800
Message-Id: <20211228073126.48906-1-wenzhiwei@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Dec 2021 14:58:50 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wenzhiwei@kylinos.cn, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the null pointer is not judged in advance,
there is a risk that the pointer will cross
the boundary

Signed-off-by: Wen Zhiwei <wenzhiwei@kylinos.cn>
---
 drivers/gpu/drm/radeon/radeon_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index bb53016f3138..d3d342041adf 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -951,7 +951,7 @@ int radeon_vm_bo_update(struct radeon_device *rdev,
 
 		if (mem->mem_type == TTM_PL_TT) {
 			bo_va->flags |= RADEON_VM_PAGE_SYSTEM;
-			if (!(bo_va->bo->flags & (RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC)))
+			if (bo_va->bo && !(bo_va->bo->flags & (RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC)))
 				bo_va->flags |= RADEON_VM_PAGE_SNOOPED;
 
 		} else {
-- 
2.30.0

