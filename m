Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1B2CF256B
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 09:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCC110E086;
	Wed, 19 Nov 2025 09:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i4ol5EvP";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B7210E086
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 09:25:54 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso10424859a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 01:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763544353; x=1764149153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J6LFWuOI5uN2sui3FXL4uKsno0S567FUZVaCueY5hSs=;
 b=i4ol5EvPPpht0IaQpOjFNLXQ06RDmIelIWw4uoi+Wzv+PS9Sg+dbysLQ08i2KgNVD7
 ufcoThpMj5Y7QlmkYOim1kun6+RoEsLzMPpL40D6NZgxSJb+b6spDAaf0UPwgKNrysYh
 3w5HkbHqkhIeDUrKHViGNpkc0PJLYhIvHV3YHoM5RtJEi3bdlAaQi6raOqpG2sGeAkPy
 LgEU4arDopQkagb+tSX+ileEn7ccZvJBJcZbDRzCsOd/KlJ7fktJS1ev9v56wkFuqdC9
 MDJrSd3vUPYG63KArd1y5xycOV/33pm6++4NQFftCVpy4PYuhdzOx5axQOc2L4LhSwFI
 GYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763544353; x=1764149153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6LFWuOI5uN2sui3FXL4uKsno0S567FUZVaCueY5hSs=;
 b=hxXXUBKk9HtGJklq7Xah8jniDZlybVkjcWNuF9/sdpwfMYdp6eC+wseHAfzHSX6mg6
 oaPfmUvrwHzCMpt7QFyFJXQMmmwHS3xa0/ufruAln6Kk+TXNDVJm/E/OwzxR+irpm7C1
 c4yME6snaNii6BgdhpV3KVU0R2n468UDGvHxZPm670/yonubXhNakzFLPMJaWWqp2dfq
 6L2rOsLJdLgBTIin7TIq9O3H08IOie2TBtHgPjrhxpekF5XzukBgUEZSjhU3UabjKCf8
 e52FTGz72XfezUpH/saaaDvH9DYcx5WGk7rCB10tr5nx6VJRR4EUiGRpvJk/m9aiox+t
 4bqw==
X-Gm-Message-State: AOJu0Yy/CFcjLRiIPSdpdswPoaZXt8hki3pYvcAwDL39m+/r5f1M83tt
 UgTQ7ErsBdgE8gm5jAVaTiFvig4Po3cxcKXnIGah4A9laWat+a7U83Bs5c9//ZE+
X-Gm-Gg: ASbGncvpxoMJWpiG9CN2jKEdOQifzow19ByDZkimOJtSrVQVACgC02z8F4UWyn4T2Vo
 YF4c9soDvq7Cd+LbIozsAZmc73ZVuh+V+dd140jpudNlZAVb0a2lNXsWLDQAznobxkz6L2n3RgS
 5Fw/C4ojjHoXpdxJ8Q0zUgRj+M1a7fieYT7CVj0NL4iNguQVIYGIsCHthEw7pC5mPcbmvIY51Ua
 XKf40QUVkM5YYgmTyfwQFfpkdoOncydg/6qTZLYdCPfb3jIOOrG8ZCkJ4rtO3wNWIvQRuPJi4Nj
 S9QvGdTOkakvwX6z5Nf+vF7UxAPbhZitG+4RxF2v0iM+mMHNJQsIlY2l8EXI+ZZxPG5EmOBVjxp
 dS9VdJ9RfxDZ6/ZRy9pJz0Ukb6+29W6xapm05A7meUrP5f6UCWE/ESZ8NJuDNRUuXIEs5h4jLe2
 FyP7AdY5QKAtknD/+11s+bgvps5Y9ra7A3bCOG
X-Google-Smtp-Source: AGHT+IH59T6qkjoPsWc+8heZ+jbJYu0mwZcn4VkLKdJ1wTn0yY+oHREdQ4pW274l++1O6XiaEkX0Nw==
X-Received: by 2002:a05:6402:3508:b0:640:c849:cee3 with SMTP id
 4fb4d7f45d1cf-64350ec18a5mr16325606a12.34.1763544352551; 
 Wed, 19 Nov 2025 01:25:52 -0800 (PST)
Received: from Timur-Max (82-198-214-3.briteline.de. [82.198.214.3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a497fc5sm14698634a12.22.2025.11.19.01.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 01:25:51 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu/vm: Check PRT uAPI flag instead of PTE flag
Date: Wed, 19 Nov 2025 10:25:42 +0100
Message-ID: <20251119092544.222670-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
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

This fixes sparse mappings (aka. partially resident textures).

Check the correct flags.
Since a recent refactor, the code works with uAPI flags (for
mapping buffer objects), and not PTE (page table entry) flags.

Fixes: 0fdf257286d7 ("drm/amdgpu: rework how PTE flags are generated v3")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e803d173e25b..1a8155bdce5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2091,7 +2091,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		struct amdgpu_bo *bo = before->bo_va->base.bo;
 
 		amdgpu_vm_it_insert(before, &vm->va);
-		if (before->flags & AMDGPU_PTE_PRT_FLAG(adev))
+		if (before->flags & AMDGPU_VM_PAGE_PRT)
 			amdgpu_vm_prt_get(adev);
 
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
@@ -2106,7 +2106,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		struct amdgpu_bo *bo = after->bo_va->base.bo;
 
 		amdgpu_vm_it_insert(after, &vm->va);
-		if (after->flags & AMDGPU_PTE_PRT_FLAG(adev))
+		if (after->flags & AMDGPU_VM_PAGE_PRT)
 			amdgpu_vm_prt_get(adev);
 
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
-- 
2.51.1

