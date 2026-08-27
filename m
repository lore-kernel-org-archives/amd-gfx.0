Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57F8C61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 16:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6C510F106;
	Thu, 27 Aug 2026 16:37:55 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C4810F106
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 16:37:52 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 67RGbmf61085521; Thu, 27 Aug 2026 22:07:48 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 67RGbmNA1085520;
 Thu, 27 Aug 2026 22:07:48 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Prosyak Vitaly <Vitaly.Prosyak@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1] drm/amdgpu: fix byte/dword unit mismatch in coredump IB
 dump
Date: Thu, 27 Aug 2026 22:07:46 +0530
Message-Id: <20260827163746.1085495-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In amdgpu_devcoredump_print_ibs(), the NO_CPU_ACCESS VRAM path passed
cursor.start/4 and cursor.size/4 to amdgpu_device_mm_access(), but that
function's pos/size parameters are byte offsets/lengths (confirmed by
amdgpu_ttm_vram_mm_access() and leading to wrong size calculation.

Similarly with that change the off index needs to be calculated
based on dword since that is a u32 type.

Fixes: 7b15fc2d1f1a ("drm/amdgpu: dump job ibs in the devcoredump")
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 76771ad30c41..2d3fb87af00a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -297,10 +297,10 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
 			amdgpu_res_first(abo->tbo.resource, offset,
 					 coredump->ibs[i].ib_size_dw * 4, &cursor);
 			while (cursor.remaining) {
-				amdgpu_device_mm_access(adev, cursor.start / 4,
-							&ib_content[off], cursor.size / 4,
+				amdgpu_device_mm_access(adev, cursor.start,
+							&ib_content[off], cursor.size,
 							false);
-				off += cursor.size;
+				off += cursor.size / 4;
 				amdgpu_res_next(&cursor, cursor.size);
 			}
 			emit_content = true;
-- 
2.34.1

