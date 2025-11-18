Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059B3CEDDA4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 16:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A271B10E4FD;
	Tue, 18 Nov 2025 16:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YKxB2U8T";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4F310E4FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 16:56:30 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-640b06fa959so10202760a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 08:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763484988; x=1764089788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m+Z5CyMhKQPXlsItEyudFf7/QoMgZJzaF8p6O4ei5vQ=;
 b=YKxB2U8T3O6t1xNkKT9fnw9L445twd9obRODaAxr5XQQwc/uu/33Hxr92TTYkXLKhV
 PttgRPBls2/hiWBu62C+ZkjLyS3XwsJR79piCMDNbmb07o/G7vgXaw307yZ/XawqZlRn
 c3x2qh6ZHhcdE3s6sFe3LIGIjLl/CDFRpWMEZG/YQgGuTd5lWOra8lHxOclmzlU13PRd
 xNY6InWgcZh+nNiU8Q+zTmzmtTU8wdWe+vS0l4mfL7oToDbvjTUs4bBhNqWga1SxERIe
 dyCukruDD1yseBqCakq8QQllcsVY3QvMAZBYlIq2VCj2yYMr5p4j5YkAtgMSg2MaGPVv
 /v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763484988; x=1764089788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+Z5CyMhKQPXlsItEyudFf7/QoMgZJzaF8p6O4ei5vQ=;
 b=FyuZSPlG1WCEHoZJuZLMPR7jld+Co1FNwaki9pIK0P5rHtiAb95oDA+Urb779vTIMM
 7utkP/UGp3ttrd/nw6ZgMRMkOlfiQcafnsdFX7AVmOxpMFNsy9F6qUsDIteT+0lOnv1M
 tutxPKYn4+egisSFpmLEXLtey11MZwIcsaVtRaXTqBmCQbjWgxJLqM0ktvTawwhiytCu
 pyX6oVgC/eUMAN7nngmoD4pLRpiW0QIFrL3ITqrHS0Y0niPb/eFtNnHbvzx4cpXWEOjf
 2WjPHByhdSEKIKajIyd5QIXkVLxUOx2LqTCIJqhk82TKiXllWIl1yblaovm4VC/3QHlm
 F8Ng==
X-Gm-Message-State: AOJu0Yzk6Gb+m1mcbYYAVCE8xOUHX7eiKAIX9+5zDHCypz72xKSSAuU1
 bu7YDwumD62045sfi6in8nJhQxYPWKlljqXyGoZvKht80+0IUjFPk0f+XT4FFBLH
X-Gm-Gg: ASbGncsxwr5z6bKmwCLBgQTzw5obHeOr9Nb/dgLKo6pHCf9Crtsd5yRvaQ7kyDTFEYL
 nw/+9NgisGfht7muOKyvM+0EjNLXz4CUh42XfcYiGZy+Wb1CIyYBUsZIw52QJP+nzyka/1oI8vg
 YHMq8Ej1tqfMq88YmYI2jN/eYWAiLafPbSUNBAMy3RlaoHiZq78zD0wlszppER2+rb+uKPXpxM5
 Q3n/7xdxu7aJ1hmWxwfA/qDrGcrMx0Bd5muetPXgowT2aInw46Ki2nDYWOjgVl6/YAKTpt77M6R
 3stkregV4BwCFo35nvzAMnDoXXJ9cNnRQUrFxk7AoZ04qzD2Rf6kVJFj/vW2ezL9q1P2qGg+BwJ
 MPBkJtmJNrole/Nr7JtGEkpV43tZ2le1qidK63X5QSGsd0PIw6qxA6PggXIzunWHrcnlrlrJTEn
 Y7LZzlrK432pVfC+aHPi6KmczZazIr+lyyyjyQbSlv9+TwfFw=
X-Google-Smtp-Source: AGHT+IElctE7Fh3YPg7LcTSEsPQK75lpFVfZp/bKIZHnRm/bBKF6EMO496gepetD6+gHef1QjCXj9w==
X-Received: by 2002:a17:906:2542:b0:b71:51b:bd4c with SMTP id
 a640c23a62f3a-b736794a6ccmr1280883566b.50.1763484988102; 
 Tue, 18 Nov 2025 08:56:28 -0800 (PST)
Received: from Timur-Max (82-198-214-3.briteline.de. [82.198.214.3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fad44b4sm1408197766b.28.2025.11.18.08.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 08:56:27 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu/vm: Check PRT uAPI flag instead of PTE flag
Date: Tue, 18 Nov 2025 17:56:18 +0100
Message-ID: <20251118165620.216753-1-timur.kristof@gmail.com>
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

