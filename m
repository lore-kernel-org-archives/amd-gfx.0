Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49DDCD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3CF10E5C3;
	Tue, 26 May 2026 07:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TnizGh9q";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0576610E2FF
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 May 2026 14:27:19 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c80227c9572so3844866a12.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 May 2026 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779546438; x=1780151238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mzFTxVPO2bV5wPss4Z0njUQ82fwBRkchQ0evEohJCFc=;
 b=TnizGh9qSUupuiq/OrfRcThb61tLXPUKJl47v9sWOajpEmNKq8in3Wy3ZKPFQN2uFB
 BRLY79+5jFGZk76WUH64oGL7rm2S8Ay1JKcCW2ArEMFwjPgzpeuJASGN3gk2syvU5E05
 5YW33p61NA55xQGzfrZWBTZOoelRFZoZwXBQy2NH4QJJPGek2MHJp7fXaMXwyiA1DlQ4
 MYaFb6Y+R90mQnA8YjDc5F9AsKxRWkdht+ZYm+g+71bQTc+7x2VeBXNNAtn6km5S4Yv2
 B+GVC1wGZ52C3n+IAnokyPni97Cexn0Tf89bKauto8gD9Va7XPlqiGoguQi786BzpMif
 H4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779546438; x=1780151238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzFTxVPO2bV5wPss4Z0njUQ82fwBRkchQ0evEohJCFc=;
 b=djkwwXn1FqNvGpriGq6f++53dzhziaVDSLVlszj0WJIocgkgVE+UhG4b5gvvMYLIpu
 jxykUSQVrvpkp31YJ1W6FTOWvYTkLS2EIL8ovI1uLd5tqvz9MpN6vRSMpyFAdBTdTpwB
 aXAuXCXTKjAc5rrqFEyyZHPmdVsCwxrEi8L+6UC1aIP3hn8Vr5RyPbxVcDdIqkq/FsPM
 pwj+YvqfQ9evSGiXQmsAskckTxB806XwI1ORJdnbzaT3V+MaA2FSJvhfNqRM/3/CC6MS
 9VncYJD9nWbX3DyHeI6TK4gW95DIbaCinIlW+108hc6/+2I++qen4SrvtMTddNsxgMYZ
 S69A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/S6o8OaO+OZHu24vxECJOMOiEZGeSDDixdsFGIHvCVp2/HwkGXsm2HjO3CMMUStonA0hAV4Vla@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxf+lcrBFTltTHG12g3weGOtwI9uQb4I54EriE8VOD9y4y4cEgW
 Z2Td0xLJJUrAiEjUPGiMh3dPZkhOHcsaeNMOkExOp+PRmtVg2tXy/Orj
X-Gm-Gg: Acq92OHdK8A1Xki3sx59FlCWu8zQk2s1WNW53x3cB3Y0tGdUdkHXrUVLHuQ1xNcx5g+
 7C/lbfO0xxtAOQywC+BEfZJqIK0oX4WJEZyduucsRdpmjZi8QMhplpK0NpziR3zRT5yzrHWWmsh
 4wl1nlA1WYaLRBoThrH6EptxsFZmEt0mXsIEFaT4sbbJEkPvi2nBrvECgQcc9FEKvKhrPnxky53
 gSad2YprrT7LXEaWlA8VdApNuadmFJ6bbuYj2qk73Po9wV1SZbBj+Mi9ZAyPevi+uP1hQDN4AwC
 J2cE/M6VD76Ri/qc+9xqJTcnBIbEUTw6SRUsDFaQw22zBfjYKzJvXEoDBB0FwSqjcHwWxcwTIgY
 aE2x61duhVcXMcEKMTy+5FJJYc1bcuxv4eCGvrLj9X7mVgFnc1xagO5SQ0kn9UrRmCCyQ+nk5aJ
 VoE/FEnU+7IctRR2MTh6WKfPIh6tYYCs4okcLAwXGLj7MwyGRiUJnFTH8Xnm0BhvdL/m2lQCTgp
 PFJ3YjuYMP+WEbYuDgMjADw5gCdh645/6Crbio31cmFj288HKD0Dda2Ra9jdN3RKlDV/XuqlzO3
 LrtErLio2xTfPAMUwjWWViKf4Q==
X-Received: by 2002:a05:6a21:32a0:b0:3b3:216b:274c with SMTP id
 adf61e73a8af0-3b328cc44f3mr8711006637.22.1779546438447; 
 Sat, 23 May 2026 07:27:18 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.192]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe2dasm4875597b3a.19.2026.05.23.07.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 07:27:18 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Felix.Kuehling@amd.com
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] drm/amdkfd: fix integer overflow in get_queue_ids()
Date: Sat, 23 May 2026 14:26:45 +0000
Message-ID: <20260523142645.39102-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 07:53:08 +0000
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

get_queue_ids() computes the allocation size as:

    size_t array_size = num_queues * sizeof(uint32_t);

num_queues is a user-controlled u32 copied directly from the ioctl
argument (args.suspend_queues.num_queues or args.resume_queues.num_queues)
via kfd_ioctl_set_debug_trap() with no prior validation or clamping.

On 32-bit kernels, size_t is 32 bits wide.  A caller supplying
num_queues = 0x40000001 causes the multiplication to silently wrap:

    0x40000001 * 4 = 0x100000004  ->  truncated to 0x4

memdup_user() then allocates only 4 bytes.  q_array_invalidate() is
called immediately after with the original num_queues value and
iterates 0x40000001 times writing KFD_DBG_QUEUE_INVALID_MASK into the
4-byte buffer, producing an unbounded heap buffer overflow.
q_array_get_index() in both callers walks the same buffer using the
same unchecked count.

Both call sites are affected:
- suspend_queues() calls get_queue_ids() unconditionally
- resume_queues() calls it only when usr_queue_id_array is non-NULL

Both callers already propagate IS_ERR() returns to userspace, so
returning ERR_PTR(-EINVAL) on overflow requires no new error handling.

The copy_to_user() calls at the tail of both functions also compute
num_queues * sizeof(uint32_t), but are only reachable after a
successful get_queue_ids() return, so they are safe once the
allocation is correctly bounded.

Fix by replacing the unchecked multiplication with check_mul_overflow().
Cast num_queues to size_t so all three arguments match the destination
type, avoiding implicit type mismatch on compilers that implement the
macro with typeof() rather than __builtin_mul_overflow() directly.
Add an explicit #include <linux/overflow.h> rather than relying on the
transitive pull through linux/slab.h.

Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process queues operation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e0a31e11f0ff..c08ad718dbd7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -25,6 +25,7 @@
 #include <linux/ratelimit.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
@@ -3308,11 +3309,14 @@ static void copy_context_work_handler(struct work_struct *work)
 
 static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
 {
-	size_t array_size = num_queues * sizeof(uint32_t);
+	size_t array_size;
 
 	if (!usr_queue_id_array)
 		return NULL;
 
+	if (check_mul_overflow((size_t)num_queues, sizeof(uint32_t), &array_size))
+		return ERR_PTR(-EINVAL);
+
 	return memdup_user(usr_queue_id_array, array_size);
 }
 
-- 
2.53.0

