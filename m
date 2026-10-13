Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D2BCC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B813810E53A;
	Wed, 14 Oct 2026 12:47:39 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A759910F99C
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 20:20:38 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so1962124f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791922837; x=1792527637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rCBIvyrq3Cdx5wtp1x1m3Uqsp5/Gd4PThX1D5sZ44iE=;
 b=YI1ItafA0JiXkAfZKAB65rhPDcJn8VxAw0DU68qIUcVUu5YHkjXh+Jgl1hpCqzkpVO
 p3TM06aaEXo6oj2tAnLHSwKD7maNMAapkmc+WUgGvMa2Ml6FotFrDCgP4IjmD4A2usEE
 MAswQ3qN6sCsonEluJDt+Vsd+0NnvvI4pJ+APe9D13rIBjpVW2v4q7n6UQzsysp1CBt5
 zlMlfyoNqX5Kg9Zq68JSQjWG7JPYj9C972Czh0GwAH13BErrw3WPHhsqvWgqxEZlVO0x
 Nv4+yVnKY0gavY+Vwgs5yN4pLUeVNYLzdDschJNqfQQUPF2tk0C5S6q3hae2O40VT/HA
 9pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922837; x=1792527637;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rCBIvyrq3Cdx5wtp1x1m3Uqsp5/Gd4PThX1D5sZ44iE=;
 b=dblb+d78BARv/MYAlF0zFrY4xK9PuxAEdzqBYuUcxEQUfCaLIUWjc8aw7Y2JxSyzPZ
 Lgkk6CPJs0wwVlgoCpFDEnnZUcfpnmsrvDyFnWQrap+FQtk57x3L2nR5SakLb/fsExsW
 61IQHIok8djTyaBoi+xjgvuOLTTMryJrM9m4UcZ9VweoRFuiAQcIiPGW/IjW9SvI1UYG
 bOYiK7f/6jESSQ6y9O7ku4P0G4b/RPXkHplj+KSnGXBVbcjP77E/1Q/jvuR9RRPhzEVQ
 ohzhhDoNeVpoubcfpYk5EUOy7jlQNXecOH+2veKjzDw25Y/Bp0YGnx+CILuqPzNgnUE1
 SAkg==
X-Gm-Message-State: AFq9FYJy3K3DsxP1hJmmXtT+iHqtA6vauqAX7GSj1/uB5sdg+09FykYS
 25g8yERQn0TaUb52uMUQ+VKUqx/TzlUi9oq+idAZ2vxd/4jZgyw46YOb6zM7wA==
X-Gm-Gg: AYBFou2rMfSxJwJ6Xw94zzx4tR7WzbwukDm4BaHOeD9Ggby04i7Z5crQak5q9kDCsIU
 QAN9gdt0GrDnv9ge/Y/4DnYh4e55LDTELVA/lsfJonS1kGXRsv+MjTrOHAgtYM5cWJpe7PgkYLZ
 RntUdCGGhBI/GDPH1MdHBwCuFoj4m8XMM1yLhvyKvY1RgE2amm/hrCM7nhI3wWx+ndms0tovIDl
 laUFyjeHbYxiH72oESFjY8epsdNgdxidzfm2WxguUV5lCFLuNWDw7EEOasSoxlWZiMB3sR7mVjk
 Dyd+ZCXPHmyVwT+eUR2Iha4LNNvNzFy6AjkzewPBUSdNT289jeDznchUWu/h4R5bglxg8PkxFdq
 m8FjvWXN5wCgi9ZPpUMvGaiRzr16xyd31Z/fucfq27ntVw3vSjHcnDbihYjecKUt/Jo8fohCs/O
 4cfOWD7vncdBSif3dL6Js0kEHrUzZ1BUk6TybkD06+XEjP0d4VJ3pqeKk8Lgi/7pH3YhDU2qzUZ
 P5jUau702Sqm43PcuYjWelQVuwV1fWOicA6t+Xlltud2UI4UWVcm9Mvk+UZoTB8BsnD0SuyNjhU
 0CbobpLlKPYrHgT7LON/fePVND8X7sqE/aXkd2gQhHvVEGsh5QLIN6lEcysy3jb/TE7Ya+HAXpj
 Y/e+8vM7qbMVzvnzrTLJ/Cg6sFn+UfDifCwPujRkZowWP14xiOUoEgP8BxGCVhUl5QCMkiNY5jA
 7o4h0797bT
X-Received: by 2002:a05:6000:40e0:b0:48c:6a4d:3b67 with SMTP id
 ffacd0b85a97d-48dbaceb433mr26001069f8f.19.1791922836813; 
 Tue, 13 Oct 2026 13:20:36 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967bf5sm6868460f8f.5.2026.10.13.13.20.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 13:20:36 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: guard VCE/UVD sched entity teardown on failed
 probe
Date: Tue, 13 Oct 2026 22:20:34 +0200
Message-ID: <20261013202034.76226-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

Since commit 037b98a2312e ("drm/amdgpu: move UVD and VCE sched entity
init after sched init"), drm_sched_entity_init() for the VCE and UVD
kernel entities runs in the scheduler-init phase, well after the
IP-block sw_init phase has allocated the vcpu_bos.

If probe fails between the two phases, amdgpu_device_fini_sw() still
runs the per-IP sw_fini callbacks for blocks that did complete
sw_init. Both amdgpu_vce_sw_fini() and amdgpu_uvd_sw_fini() then call
drm_sched_entity_destroy() on an entity that was never initialized:
entity->rq is NULL and drm_sched_entity_flush() dereferences it,
oopsing in whatever context drove the failed probe.

Observed on real hardware: MI50 (Vega20, VCE 4.0 / UVD 7.2) behind a
Thunderbolt link — a pciehp presence/link-change event re-probes the
device; when the re-probe fails (-EINVAL here), the cleanup path
NULL-derefs inside drm_sched_entity_flush() in the pciehp IRQ thread
and takes the whole machine down (panic_on_oops, EFI pstore capture).
Reproduced twice on 7.3-rc5, 2026-10-06 and 2026-10-09, identical
signature:

  BUG: kernel NULL pointer dereference
  RIP: drm_sched_entity_flush+0x34/0x2d0 [gpu_sched]
  drm_sched_entity_destroy
  amdgpu_vce_sw_fini
  vce_v4_0_sw_fini
  amdgpu_device_fini_sw
  ...
  pciehp_configure_device
  pciehp_handle_presence_or_link_change

Guard the entity teardown on entity->rq, which is set only by
drm_sched_entity_init(). amdgpu_ring_fini() already self-guards via
the rings[] registration, and the vcpu_bo/firmware cleanup still runs
as before.

Fixes: 037b98a2312e ("drm/amdgpu: move UVD and VCE sched entity init after sched init")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index ecd7caa95..cd35ff7ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -377,7 +377,8 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 	void *addr = amdgpu_bo_kptr(adev->uvd.ib_bo);
 	int i, j;
 
-	drm_sched_entity_destroy(&adev->uvd.entity);
+	if (adev->uvd.entity.rq)
+		drm_sched_entity_destroy(&adev->uvd.entity);
 
 	for (j = 0; j < adev->uvd.num_uvd_inst; ++j) {
 		if (adev->uvd.harvest_config & (1 << j))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1f7a98cdc..3952af9ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -253,7 +253,8 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
 	if (adev->vce.vcpu_bo == NULL)
 		return 0;
 
-	drm_sched_entity_destroy(&adev->vce.entity);
+	if (adev->vce.entity.rq)
+		drm_sched_entity_destroy(&adev->vce.entity);
 
 	for (i = 0; i < adev->vce.num_rings; i++)
 		amdgpu_ring_fini(&adev->vce.ring[i]);
-- 
2.39.5
