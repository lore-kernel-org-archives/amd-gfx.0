Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB16CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B5F10E4BB;
	Mon,  3 Nov 2025 22:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jF2gJIXo";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23C210E4BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:01 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6409e985505so3689641a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208640; x=1762813440; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yKPs+Fi183RytCnUD6pLSDlK7mLpoxS1DT9lAX7aBe8=;
 b=jF2gJIXo/GViyIabzclRCSNyi8XzbKHtY1A0XY/ifGNSzKD0jHabjEuH+6AjfrhcsQ
 mxH9XWVsXUYoswhbGoCIwUfUuqcWnJhwiUYSdkyA65+lyqg1jiZ+B36qxbdcmR5499Ei
 uZaWdJOAIrB+1Y2YouIxJWLCWG5xKXcjmff1lC4659GHvL1wbg3CM8btgMPW4SXKWBZp
 qiPGte3wORnmOi/DPm0Wmoqr7CRpHDztivEzL7bfzrFTHv1fa//m+OcQNCY3VTgXgxj/
 B3sEiCusz5ZNtWrXhDGB8FI/SUz+KJEyWsXOxWhUichKJu8EkfQDsyJwzo+6q8ZVitxp
 sS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208640; x=1762813440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKPs+Fi183RytCnUD6pLSDlK7mLpoxS1DT9lAX7aBe8=;
 b=UQG5U7jX8kz0tMHbYmdT89wNJjc6RcyYKwFJUL7LuafNGQ4Td+M9GjJ/V0Ohfqj+Or
 X3Fmn/MK9fys0G3JnvMAj70IsG39FFrj7oE4gLPN3ZqLMkwm11ZWisK+CeDiD+KbyM+r
 svU5njx/0xjHPK71p0qI+BdnG68D20Zetv6Wa1c07LZTf5HgkwuatP3rKhSB4MCXs7t8
 9tDdS1ssCiqTheUlLFIwEJA5fMR3Agc2C8pc5JIlUOvoX9bUGZJtSwYLD6dtWfxMPDDv
 YzEroMtLpBAj3BK539BRs4acA5ppTf7m+Hmp5ANktSbeWwxlqiboZ73Ab8/L9ZRtAGkc
 YGng==
X-Gm-Message-State: AOJu0YyYUjLbUDA1gQ2Lclq2L0rHScMUdQEC+rsAU3fAhrtKz0xA/tDT
 Mb1EUMqosVmZRR8a7/PzYuu6VCA8Vw8pVpc+gOhXLUXMonCC6QPErcL9KXI8luGX
X-Gm-Gg: ASbGncvSDjO0DQL00QEJVnXcdZno5qhAONkWHdHb/DR6Gs/vaQScoZ0uugoZpLNO9Ux
 GW8/b3W4y1tgOU/upUQlL/sLbyHHNBHHKLknGt0a7+oAETNHtJ/9tadx3vQ24ZB0pXDErIwixKF
 D9LKVc4FbpZAhDa28ff2DLIQMmycCLiOD7LPe3BEyiaIBK4hMV7uIcw+nyre4pVLosgPsYEf7Pu
 6KE2BI8SC1DZSf2vyBOYRoKDEGVUjuCXhBXzewi4eFG/IHE+ePTW9iWOQQX07jLUprS4ViOdLzK
 tCdP+Hs+vFVHjTD1Vyi8KYNXrZ/jdOUbvPAFPUwRpgz8qB7yi8uyNQGdSs8rSpP9SL6/QOe/0bN
 cmCUEjh4CfyCBbKK5EWRH8XRC3l3nTjzHrc4kfzL031SQ7Og/L2B8tRoRvA6Tzz/9qV1l7OP7hJ
 dPTI0wZRImADL8AGCgQ+WHtJqwiHwtEw==
X-Google-Smtp-Source: AGHT+IHDDm+Y7qGyuYY7RKcpe/T7FWWC5VhhdIN2KKIj1+SX8/pMoKIZYc3NpD89mAGgxpdn8jHzxw==
X-Received: by 2002:a05:6402:460d:20b0:640:af04:d71d with SMTP id
 4fb4d7f45d1cf-640af04d8a7mr5584778a12.22.1762208640093; 
 Mon, 03 Nov 2025 14:24:00 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:23:59 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 05/16] drm/amdgpu/ttm: Use GART helper to map VRAM pages (v2)
Date: Mon,  3 Nov 2025 23:23:22 +0100
Message-ID: <20251103222333.37817-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use the GART helper function introduced in the previous commit
to map the VRAM pages of the transfer window to GART.
No functional changes, just code cleanup.

Split this into a separate commit to make it easier to bisect,
in case there are problems in the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e226c3aff7d7..84f9d5a57d03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -188,7 +188,6 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	struct amdgpu_job *job;
 	void *cpu_addr;
 	uint64_t flags;
-	unsigned int i;
 	int r;
 
 	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
@@ -254,16 +253,9 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 		dma_addr = &bo->ttm->dma_address[mm_cur->start >> PAGE_SHIFT];
 		amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags, cpu_addr);
 	} else {
-		dma_addr_t dma_address;
-
-		dma_address = mm_cur->start;
-		dma_address += adev->vm_manager.vram_base_offset;
+		u64 pa = mm_cur->start + adev->vm_manager.vram_base_offset;
 
-		for (i = 0; i < num_pages; ++i) {
-			amdgpu_gart_map(adev, i << PAGE_SHIFT, 1, &dma_address,
-					flags, cpu_addr);
-			dma_address += PAGE_SIZE;
-		}
+		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages, flags, cpu_addr);
 	}
 
 	dma_fence_put(amdgpu_job_submit(job));
-- 
2.51.0

