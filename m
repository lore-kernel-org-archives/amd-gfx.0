Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7676DCDE01A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77F310F4AE;
	Fri, 26 Jun 2026 07:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F6VnDwvP";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD31310F2C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 13:54:05 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-804e46366d7so23607997b3.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782395645; x=1783000445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9aAmr8/iGyamwXOE0x+7nRWzrQLtbEEZ6iUw+t3oT4=;
 b=F6VnDwvPLtkffmEFUTsKUCZA2oS4Mg0M8w8iCDsiJnRW/L9dQEG4DZoCQ2cv2CXZNU
 O0JQokZntyCNM948YsN9kQ+JxZPTe1FtavegXjcIkNctB1/OuBUz5VDFXoJwWzxQO+py
 xauVb4R8ZzARMG4XjARNx96nZVYW5X2ayC+AQa3BAiwXpWf6bxF6KieGrh35aeSIvNTZ
 7pxjHqVO181wqHxaGwB3aSMLL4kIt+fMGsuJHTqBbKxVXaPBab7+0h4F0hqCT+6z7ggz
 ZAL+6MF7BSgXBnZW6AyUEz0Rw2F6Kuqy3x096qp8THLBlLG5EYm4xBsEMn2DsLUm4CQw
 u/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782395645; x=1783000445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m9aAmr8/iGyamwXOE0x+7nRWzrQLtbEEZ6iUw+t3oT4=;
 b=jBtLm6ha+7bNt8TYRckU0xixChZDa2gk0LQvr5YM19w6ev6kcT2r10YtBOp/kyGasK
 jYad7RjoUDtRQ1pKX+dJKTQTxBbKL7t1wfUvy1Ia2LQ3srL5B60L8VYfgliVPUJTEg3Q
 RyhH/OZt3f/NI2DkF8OdDOzlt+OZ8V6C9YoKj3WiZLx0b6ErugoulQu8I9oJ6F/8hGO9
 btQh9vPQYBVmMki6DZtojDxyXYpi4vx6gKhoTrhi5EPVa0kwv4CzKhRJE4S0qT1Qsf8q
 7pI2QndSL+Ky+NwVq3fhxdwgIg9oe2/adAPR83aMiEwejh7Id+NGS8i2v7pTnFSK0Sjv
 ZfYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+vqvBiscMc1BDwvh0zaeKtn7rhMyTvF9pMtVqMg/vYKfehlAx7B4UuB2OEEdXIntxhFq6cWuA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwteS+OtyVcj9HFkRUjeh+7Dc57zJXSCMb9jdulz4vA6+Sa8iVP
 Ih9TfobQuqkCHRXcer72Y9Ew3/vJNc7vmHInzF5SJ9G9FWCrEuc0FJGV
X-Gm-Gg: AfdE7ckl11gPS6n/Gc245LknW95T1TvPRg6iNXuT/s5BmJlnebOPC3Cz715t8BuJRNK
 eoS9neZSU7tJ2NPtliVtZsEIaLnLEqMT03Xe7T2Pw/KhIsAB7y093s0iDwnZKN57VbHMmSOdfw5
 hhXLvteE4SXfhgpIgYvLmlyZgEhbTfflEIuucU0avO//kr/dO8kmnu3PDLQlde8OBMosjw9dKej
 ZeNZnNqDsZeVgy+rDzKBXKn+wYcUA9ZcIaps/ydwzUU8P9OL0Dn/S0xjM6D3eB3k6UsqKa4BeOa
 o3uMZAA8c7b88jagd0iVWGKuUefRrbS5GgvXK8hSXetT+6NQ3tSn+MC5CzqbvpCsKHNo1HgYnHs
 2Nx4p6HaKAv3BSXvNB2H14rtB+pKVdt5tPgbLUznJaVD0fJJVIY/WabT5W1+7SRbczhD1hxwctj
 h7i6mwJNuUjorjR/DcxVfD/fT0c2mGH3sGgp0g
X-Received: by 2002:a05:690c:6e02:b0:7f8:7e31:28ab with SMTP id
 00721157ae682-80a6b898733mr25315367b3.51.1782395644452; 
 Thu, 25 Jun 2026 06:54:04 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025f8da5fbsm72143407b3.30.2026.06.25.06.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:54:04 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2] drm/amdgpu: reject mapping info when BO VA is gone
Date: Thu, 25 Jun 2026 15:53:41 +0200
Message-ID: <20260625135341.1159-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624172029.2508-1-alhouseenyousef@gmail.com>
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:54:04 +0000
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

AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object from the file
handle and then locks the object and VM before resolving the BO-VA. The
GEM object reference keeps the BO alive, but it does not keep the
per-file handle open.

If a racing close drops the last handle reference in that window,
amdgpu_gem_object_close() can remove the BO-VA before
amdgpu_vm_bo_find() runs. The ioctl then walks the BO-VA mapping lists
unconditionally.

Return -EINVAL if the BO is no longer associated with this VM.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Describe the handle-close race instead of an initially unmapped BO.
- Return -EINVAL instead of -ENOENT.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 212c14d99..6f5b6f4c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		struct drm_amdgpu_gem_vm_entry *vm_entries;
 		struct amdgpu_bo_va_mapping *mapping;
 		int num_mappings = 0;
+
+		if (!bo_va) {
+			r = -EINVAL;
+			goto out_exec;
+		}
+
 		/*
 		 * num_entries is set as an input to the size of the user-allocated array of
 		 * drm_amdgpu_gem_vm_entry stored at args->value.
-- 
2.54.0
