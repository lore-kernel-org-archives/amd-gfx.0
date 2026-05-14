Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC64CD4F25
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 07:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38BD710E26E;
	Thu, 14 May 2026 07:27:14 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BB310E26E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 07:27:12 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64E7R2Yd2299116; Thu, 14 May 2026 12:57:02 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64E7R2kr2299115;
 Thu, 14 May 2026 12:57:02 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1] drm/amdgpu: Use atomic operation to achieve lockless
 serialization
Date: Thu, 14 May 2026 12:57:01 +0530
Message-Id: <20260514072701.2299075-1-sunil.khatri@amd.com>
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

In amdgpu_seq64_alloc there is a possibility that two difference cores
from two separate NODES can try to and could get the same free slot.
So this fixes that race here using atomic test_and_set clear operations.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index a0b479d5fff1..f4be19223588 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -175,11 +175,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
 {
 	unsigned long bit_pos;
 
-	bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
-	if (bit_pos >= adev->seq64.num_sem)
-		return -ENOSPC;
+	for (;;) {
+		bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
+		if (bit_pos >= adev->seq64.num_sem)
+			return -ENOSPC;
 
-	__set_bit(bit_pos, adev->seq64.used);
+		if (!test_and_set_bit(bit_pos, adev->seq64.used))
+			break;
+	}
 
 	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
 
@@ -205,7 +208,7 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
 
 	bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
 	if (bit_pos < adev->seq64.num_sem)
-		__clear_bit(bit_pos, adev->seq64.used);
+		clear_bit(bit_pos, adev->seq64.used);
 }
 
 /**
-- 
2.34.1

