Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6852CCFA06
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 15:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0B710E1F9;
	Mon,  3 Nov 2025 15:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BrRW/5+v";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF3310E1F9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 15:24:11 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7a4c202a30aso4488547b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 07:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762183451; x=1762788251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0amwiA8dhcqhJaPYlRUj/vE0nImYw2KsDQpNGew7uvc=;
 b=BrRW/5+vrSwAU2RqZHuqfFpXL0DuuYFSeGrheHZ6i4YiLpRJkeXUmNSoDrEz5ijHMt
 TfyeWl2RU8PvJMkp0/WFz+vrkeW0ZOAmZiRKaQk3iPiNj2bZXpqBuJyOc1Chq8RhNiFW
 N9V8YQ/+lgSUiHoh1TMDR/j7RlZDF4dXCmQwyZFK6Fba6NOMQIkh57703dpOFVeRtoJ6
 RnH5jAaOPlPyzt8bAfKyWF1WPfteEQcSGrmyrInvrGVQ5YzQQ3kE58/vBW659vWeIhfX
 u8mqmEO815lj4D0+GDepc0u5yK+RB+YqFHm0jhR5vED6TTaS5IVl8EFeCndkDWWZ0Udq
 pozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762183451; x=1762788251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0amwiA8dhcqhJaPYlRUj/vE0nImYw2KsDQpNGew7uvc=;
 b=ReTppD1qrhcLL/+aqZ/GLWT3lgpuezmjfOyYd9Nd33yfFLaYgpkSrmD192h3QsduHU
 56jqspFMPLIVmu2cSTK7frFj+VLUfNKuQCrMOvzODpR4JFt0BC1SVEVXvmQ+8tgvKX80
 IVDdGXMmFDED9F7bUw4J+nL7gNNZIjmMeb4il2/yQyu430/JeisxiIqCCFTulXMTcnTj
 O9o7z2Q2Y9Xvqu+a1B3OxcC8AwMzxVpFRAc1Hravru/jxZJDkm4AoU5Lv9QCZn6z4pFt
 hco2JTIFvHu2tmRyk/HFP5i/IdndEZFXGnJyVHXV6SfnefVwRjuYO2Sm9BTrbgueIyep
 0NJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF/dlptYgu84SIVvHxl6kwHHY6czoWfdDDrn05/QTsvUCq5XD70DJzPKT24pTxxDJGln+JPbTz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgI4qbSexeR8ZrRkN/kblgB/dXfnsJOYg7FRrZO0PJEKe/hz6Z
 eWLpkoSe50spznI/+W+cXE7Uq2O0/beK//pDImE2jwT5ZuxZEaZ3fbR5
X-Gm-Gg: ASbGncvOY8u6N0YbryU6rpbS+uoi9mU7bLjX9rU7HDp0JO6pgIxrxvAtBwgkqUHqh1Q
 jvC8oqOLuX6SdCHIe9RAwU+0AZDtIWl+KNSGq4DdmZM3sV2O6qHgqL0Ygu+s0Xg6cikEhV4ZqJR
 evVX58xy6PLNjg2CkTtpzOrg7Mx86Da5FKjJF07bisSpEBmq/We7vhj/AMjkCBqd/NK2LP2JTi6
 OJUAZphX4/1gMkYqETpJ2wm6wYW2fQuTUQkdGGyHhtpAnQd+0Bg05eqEwo2NtQAptMRMD0B9lH2
 IahloSzTWtKR7h8nDnwQZiKXhakhQoOWcBucnRlFvS8gmgVECpRKzIbs9yp9OWI/Az3xYFSluMf
 g5OqDpgZq1/sLFUpm2mdBwtV9Z2T9SH+BGKHIWiFlMOL9xfY58G9XCAfz8IoxleXLVDwskbmvLX
 zjMIflinAnC8aBi9/de/W7nWWyCBxrPZyBcY7ZeYvI2bk=
X-Google-Smtp-Source: AGHT+IFxtYAxMxme7JLXrTNvaBj9CveGFk067bI7xNNe3ZOOtSA4ln/mdOjImcgU8nxAtpkqNeL5kA==
X-Received: by 2002:a05:6a00:3bdb:b0:7aa:57f0:31c8 with SMTP id
 d2e1a72fcca58-7aa57f04bc3mr3927840b3a.30.1762183450714; 
 Mon, 03 Nov 2025 07:24:10 -0800 (PST)
Received: from sallu.. ([2402:e280:2130:b5:d3fa:5314:9350:76e0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7d8e6fa5bsm11759811b3a.27.2025.11.03.07.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:24:09 -0800 (PST)
From: Saleemkhan Jamadar <saleemkhan083@gmail.com>
To: Christian.Koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, saleemkhan083@gmail.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: do not use amdgpu_bo_gpu_offset_no_check
 individually
Date: Mon,  3 Nov 2025 20:54:01 +0530
Message-ID: <20251103152401.9304-1-saleemkhan083@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This should not be used indiviually, use amdgpu_bo_gpu_offset
with bo reserved.

Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c       | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 3040437d99c2..bc7858567321 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -129,7 +129,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
 {
 	int db_bo_offset;
 
-	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
+	db_bo_offset = amdgpu_bo_gpu_offset(db_bo);
 
 	/* doorbell index is 32 bit but doorbell's size can be 32 bit
 	 * or 64 bit, so *db_size(in byte)/4 for alignment.
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b1ee9473d628..0a244f80426c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -93,7 +93,15 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
 		return ret;
 	}
 
-	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
+	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
+	if (ret) {
+		DRM_ERROR("Failed to reserve wptr bo\n");
+		return ret;
+	}
+
+	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
+	amdgpu_bo_unreserve(wptr_obj->obj);
+
 	return 0;
 }
 
-- 
2.43.0

