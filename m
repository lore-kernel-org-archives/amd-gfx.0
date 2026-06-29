Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB84C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58E710EB3F;
	Tue, 30 Jun 2026 07:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bReqqF0/";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA0A10E6C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 15:28:49 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493ad116e05so7619665e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782746928; x=1783351728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HFhwRQO/XnDqnsNCNRMiUIQQuhF/q4kw4HCjqPfc1vw=;
 b=bReqqF0/CtTYtcKbjZyeVugl+OjTwLWqr+CVLT0pT2XsoQSXXXmPF5eKKYfF+/7xNZ
 4I0knfqB2hk4o1bVaPGs0HLe8GgflvhqkeR0P8qOKwpYdYIVY51m9h4lyCT093xhULj0
 h97TDH/yc97CtrwbbrGIN392jJS6cr/tK3Xx9qm3c8juJDQkw9n9VEcg2+q3Md8wvf78
 ADS7G5/i5OpriPPXZYqSFE4CJ7XT8G7cVbyvb1e6GT7N89C8EecgqzMGtVHqLmY70vVF
 metLevno1pQMO7Gt+5Up+8Jnmj5rlonCQTbGGsKJoO4KTGDe86cS6D11l5cdzAHFtlSr
 1hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782746928; x=1783351728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFhwRQO/XnDqnsNCNRMiUIQQuhF/q4kw4HCjqPfc1vw=;
 b=E7WIgrXj6rAdc12q7ls82EbEipJdE+9EvuKSCyPsBbXBTCZT3Gitwa1ZOXyKLTorVq
 neY40HWcwCKAzKL2AWwb1QJrVagmHJMRAYf91u4vsvLnTrSICZY+PkNpG4KssersADU/
 ddW8xQSk7XRulFPf9wWrXSoa8sv7iRQhmfABLR5A3AAxPF6q10u8BwR6BCRa4zmtoOBs
 Vl6kxEJM26biF9dKA0u2wk+Hh2CL0oNCB7Q616o/WLGCAHHBNEMey+QX7pq+sPMxm4PH
 0cEetgWj7mqbtoALaBO1FJQ88qsqwRonb+fY5tlAH+CsQqrvNd2gkMr3bIvM7Ge/hFU4
 aQzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BQ9aflGUgemCoCp2Zj3tcHZJQdDhEhBbyBkzby7L/ZKmoYdKR6XkGzLv70if4Hf2/KMylFEDK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFjgdM9dUBuY1t8OoekrnXtUyBsWNp5nhcP67v39APiYQul2h2
 b1VgNDIduVTIKHQ6eKG6XM3Nc3OHalRabhxPg1EiouPMAb5jrOHiK3b9
X-Gm-Gg: AfdE7ckwZiTGKmo2lloFk4tBlpGmjd2037JIorpbO8GOmK21MJkhA0KW7/D6xQviriz
 eYUXboTn04Xof3r1VfLV187LA5SjZlkteFkvfmMTd/v/FmtNBvyQocVDfVFg7LK6U0FRd3Wy7rT
 ayupTsBrl3giOctxfDCKm/zoAjyfra9J3isBS0SdmdXcxofeewKixT6wQ9e1CNML92FJgPEdv4B
 UpToPNARck3ddmXe4DhYcn1CJYxNeNTMUUQKJk5GYq2q9IzcOxcnnbVq1+VDcke+Wz1BA0GBAMI
 IVw5GhXIdc6OBscsnRFBsa2eMqcXQi7XzezTaVl2yT7mBqEhEKR+wON2ZvP+28ZzExi+53j/eDh
 S5y+geM7McRV70TzBenAfLmSKqvBjjadpSBJavTiCS5CXpCqhW2ZsKfDo7gg8N5NoxeZl517VXB
 vSn13Rv00zdbXDtwuvigmUPVfMcQ==
X-Received: by 2002:a7b:cd96:0:b0:490:6237:5200 with SMTP id
 5b1f17b1804b1-493b828c480mr1572865e9.10.1782746927577; 
 Mon, 29 Jun 2026 08:28:47 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268f700c0sm371321555e9.0.2026.06.29.08.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:28:46 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v3] drm/amdgpu: reject mapping info when BO VA is gone
Date: Mon, 29 Jun 2026 17:28:07 +0200
Message-ID: <20260629152807.13492-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:28 +0000
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

AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object before taking
the object and VM locks. The object reference keeps the BO alive, but a
concurrent handle close can remove the per-file BO VA before
amdgpu_vm_bo_find() runs.

The mapping-list walks then dereference the NULL BO VA. Return -EINVAL
when the BO is no longer associated with the VM.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v3:
- Generate a clean patch against drm-misc-next instead of stacking on v1.
- Keep only the intended !bo_va guard for the handle-close race.
- Clarify the v2 withdrawal confusion in thread replies.

Changes in v2:
- Describe the handle-close race instead of an initially unmapped BO.
- Return -EINVAL instead of -ENOENT.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 27be5083f2af..83ec994ad36b 100644
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
