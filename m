Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2A6C001B0
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 15:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381A310E177;
	Wed,  5 Jul 2023 15:48:15 +0000 (UTC)
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Wed, 05 Jul 2023 15:21:47 UTC
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75EB810E38D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 15:21:47 +0000 (UTC)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5979:7b6f:39a:b9cb])
 by xavier.telenet-ops.be with bizsmtp
 id HTGi2A00M45Xpxs01TGiAL; Wed, 05 Jul 2023 17:16:42 +0200
Received: from rox.of.borg ([192.168.97.57] helo=rox)
 by ramsan.of.borg with esmtp (Exim 4.95)
 (envelope-from <geert@linux-m68k.org>) id 1qH4FC-000ce1-Pe;
 Wed, 05 Jul 2023 17:16:42 +0200
Received: from geert by rox with local (Exim 4.95)
 (envelope-from <geert@linux-m68k.org>) id 1qH4FG-00AwRY-Bb;
 Wed, 05 Jul 2023 17:16:42 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>
Subject: [PATCH libdrm] amdgpu: Fix pointer/integer mismatch warning
Date: Wed,  5 Jul 2023 17:16:40 +0200
Message-Id: <f8b4dd272f5851241addd4db51ca34d731a7ab6a.1688570180.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jul 2023 15:48:12 +0000
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 32-bit:

    ../amdgpu/amdgpu_bo.c: In function ‘amdgpu_find_bo_by_cpu_mapping’:
    ../amdgpu/amdgpu_bo.c:554:13: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
           cpu < (void*)((uintptr_t)bo->cpu_ptr + bo->alloc_size))
                 ^

Indeed, as amdgpu_bo_info.alloc_size is "uint64_t", the sum is
always 64-bit, while "void *" can be 32-bit or 64-bit.

Fix this by casting bo->alloc_size to "size_t", which is either
32-bit or 64-bit, just like "void *".

Fixes: c6493f360e7529c2 ("amdgpu: Eliminate void* arithmetic in amdgpu_find_bo_by_cpu_mapping")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 amdgpu/amdgpu_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
index f4e0435254f6aa9f..672f000d64801012 100644
--- a/amdgpu/amdgpu_bo.c
+++ b/amdgpu/amdgpu_bo.c
@@ -551,7 +551,7 @@ drm_public int amdgpu_find_bo_by_cpu_mapping(amdgpu_device_handle dev,
 		if (!bo || !bo->cpu_ptr || size > bo->alloc_size)
 			continue;
 		if (cpu >= bo->cpu_ptr &&
-		    cpu < (void*)((uintptr_t)bo->cpu_ptr + bo->alloc_size))
+		    cpu < (void*)((uintptr_t)bo->cpu_ptr + (size_t)bo->alloc_size))
 			break;
 	}
 
-- 
2.34.1

