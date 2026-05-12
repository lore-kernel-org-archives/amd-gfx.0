Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E71CD4F24
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 16:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC89310EB8F;
	Tue, 12 May 2026 16:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qvThW4Jd";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9576D10EB75
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 16:27:15 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so3227008f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778603234; x=1779208034; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YMLJ1gTjA62LWviHxV7PL2Nz8um3DTf82faBoBXi0PA=;
 b=qvThW4JdDYORW2YriCIf/Vy74g/Akjo6w0IXDJCDlaWV9IecJastnQ7mbVROX1qjUG
 UoMuJ5/YvlzXS0B3lOUj7vgHfPcdfJEQz+IiI46TCIOnQyWD5J1mgYBx8LqHxUt/sE7c
 Mi/kdaCbLpxhL/5598cn9is4EnEgrKjBAycdR1hJ/j61/z/QwnxB8FgYB/1Y2fgTMmQ4
 cC1onE6SsuUpmH9LTHSjH8dprEg3jHF9cnICuFkZNGFDPn6VwKUkFfs817YmhdtroTfb
 XQjLidem7uISq0gLT4pBUV00s7Pwo2p51mlSJ0nDGzDhK1EFRHLsg7AoWJrhlL2N1qrl
 q2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778603234; x=1779208034;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YMLJ1gTjA62LWviHxV7PL2Nz8um3DTf82faBoBXi0PA=;
 b=rvZ0rw/ZVqEqrDFPtFXXyuVg5MrnP3DaCpP+IK/6b7AFvvZ+W36NVgixEJ/Nu1lEuh
 SO9gHSAR89taoyvGyxGSgm7jWFYZfcTKrU8zT/OUFlBu1FqSXax98MH9K3a/4pnbqQyb
 snVd4g9P5FycMzyKIsiBonf3Hsd330DkjuoJQAkDeP7FSNPGpBuTJs3efVhY7DZJuQz6
 EqV/gbZGsOxJVr/nR1b6ZgERA15rWaipjVdkvVlsW9VdHjdqGBySfPpiy8fsLb69yJ/h
 SXhuxZJjv27d+yq53++6UpTr25ujXepUmMSf/e69T7/7cis5leXkmMY6TLNpoYLmO1y5
 EIKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GnjP5HS6+zCT3w10iQfIhfyVf9bmBazhMqHNYWQDoTMbF+bGECPdn3FktZcRjyxyp1ENv0IGS@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxmo+j7rmj3SB1V1a2u8KtqNKNbKYFOjJQVjoj8ZB1CRfDJY15n
 YY1WpY/fLi9KbafBCPqzU/Vmlaxq+Bq1eFw5i3kdyTemvEsZzXp5Hb/Q
X-Gm-Gg: Acq92OGFh9PgA8QZMpPfmHNB+6RfbzpqXEncjgRCdeSFv/yK3Rg82bY8RCO2Nqiu2dE
 URR4btvpv8Id8yCzhj6ntSnBWuSNNCcYz8rcN2iyxuUyLUTa3mXhMewCG6TDHLUmPoZPtFzAv6E
 v3R92SBGzlxjESLF/x1nkObhBGT/uRpfySmfoSCOjSVKq2t2tr6B+JBA1UAN4lHrBCAljpxaQ+K
 SPqy2hHYZ2g6/WEgenKe4CCwRObYXTHPHI24FxVib/0Z/jjw0T7U6un1IoEJGr31buy/+m7L/n2
 yAdSyL3KVNOrdG0HeGah9zuaNH8hC+XrCDzMUw69Wf028xVLKkqDw1Ig91ua1bZrMjzvh0/99Tl
 immGOzXgrwtKJugt/F1xxpobRvwSyh2g+dHJWGPjFTJKO2t3ZZr6iMrDBCuthN3y3BvKrvWaSE6
 yI437TJTGGMLzILTB9uthAffQrkYOKAm9B/mKUiKU2IGrhvRY=
X-Received: by 2002:a05:6000:310a:b0:43b:4f86:e985 with SMTP id
 ffacd0b85a97d-4515d3dcac9mr46727694f8f.33.1778603233975; 
 Tue, 12 May 2026 09:27:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b9:5900:3e99:f03a:ee63:3e8e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120ec0asm33019349f8f.17.2026.05.12.09.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 09:27:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: vprosyak@amd.com
Subject: [PATCH 3/4] drm/amdgpu: fix waiting for all submissions for userptrs
Date: Tue, 12 May 2026 18:27:10 +0200
Message-ID: <20260512162711.51118-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512162711.51118-1-christian.koenig@amd.com>
References: <20260512162711.51118-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wait for all submissions when userptrs need to be invalidated by the MMU
notifier, not just the one the userptr was involved into.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 5d72878c8fe9..642ce358950c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -67,6 +67,7 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
 {
 	struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_bo *vm_root = bo->vm_bo->vm->root.bo;
 	long r;
 
 	if (!mmu_notifier_range_blockable(range))
@@ -77,8 +78,9 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
 	mmu_interval_set_seq(mni, cur_seq);
 
 	amdgpu_vm_bo_invalidate(bo, false);
-	r = dma_resv_wait_timeout(bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEEP,
-				  false, MAX_SCHEDULE_TIMEOUT);
+	r = dma_resv_wait_timeout(vm_root->tbo.base.resv,
+				  DMA_RESV_USAGE_BOOKKEEP, false,
+				  MAX_SCHEDULE_TIMEOUT);
 	mutex_unlock(&adev->notifier_lock);
 	if (r <= 0)
 		DRM_ERROR("(%ld) failed to wait for user bo\n", r);
-- 
2.43.0

