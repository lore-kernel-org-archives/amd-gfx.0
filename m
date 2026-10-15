Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2EACC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38AB112457;
	Thu, 15 Oct 2026 19:30:38 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AC5112457
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:32 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso20422885e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092631; x=1792697431; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rCBIvyrq3Cdx5wtp1x1m3Uqsp5/Gd4PThX1D5sZ44iE=;
 b=FawTN4XIetgyWsXCYrzjd4rS0/lEvqGq7kzaS7wIyxMKxdrivr0EW708UPe2/qc65/
 pBJUaayGz3d/WyC583jdCHa7AEjXJ/eGhvmaFZXrcnTO2FC938VdThOeFsvGfTJA7NSv
 PkFiyE2Z34Wu9rGD7tHbzOy2y3YC1HeRqEJyGI2Q+XwI/ULkA4pLZQjLktB1GLpN67Eu
 F/YlzTX0pzvKmQhyZZwtZKG8nVJ+DZYB92s/hD6d75CiSdRSd48s+StQE1KFOq1E59P/
 nKqqOaDhfnm/FKIp5uR4Ce39qZJ4wBW6zFisK7PUf9sLsUK8NxX8nj53XLP1vMbMIa6B
 eLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092631; x=1792697431;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rCBIvyrq3Cdx5wtp1x1m3Uqsp5/Gd4PThX1D5sZ44iE=;
 b=ytiKpRP/IM5Od5AHl9wHNjN951Y9Om0xTh1QW6ABEzbiQ2/eUMulOFCUnfn6yjPra3
 yStjslXmG4qUfoT3AtMGqasPp8N7L+0MdA8iA0JVMErVcEjMk7MFr0erb1E//mQbjEyk
 hLoko0xK28ThEW6bp2quqJbmu5HvYrEpJ9uyVxPbvvwajA1LaH6mWNFrsDp0m/VNr/YP
 iulWNsQYTQRRCtkfb2kKCKxWX0kah91AyIktPVtjVLCJ4hZJalYCmeps3Vq5tQCxN7+y
 QMvGt6YDLb3we8TXTZM5ZWF+h9z+W0CqxwkcQp2RGsoyNCZ/kn4chm7uWSasGSb6AjSu
 TWnQ==
X-Gm-Message-State: AFq9FYKAig2V2mbY/wr4k1Ez2EipL0wWSLZG4NVIvxCxpbrL++E2cjHT
 8CROv5Pyk+scqrtugcjHMJ37c40iJjGZPz8//xX3D7pxiQiyMh8/Cab9z80PvA==
X-Gm-Gg: AYBFou0dOFhKTba42ESbkyadmn+AOQ0JxEQwJ1BBz5b0fsL/vo5YspyPIDkUZwqS1ue
 WIYKTQF5O//J7BqYmt0KzS/p0a2nqhS3jqCMpqtIYqvE5IwpYxQ0K+aUGKO7yPTUE+Yl+UoV7fM
 17aNoEAFtnj1dG1L4Pxoe09Ce+wDE9GEK8liGVrvGWE/ciZEHOyWD6FoQkLrP/g4dRdEm7razVS
 j0otW4bWC1r+27Ya4p22rXTcYhJSlPZLCCX2XWH+DkaiGyQe7grEe8QXJUtbG5jvLhkDJvefyji
 YqeUna9wr3Vj4iv4WjJLaqer5UCaFE4B2PlcG7fvuKR2qbaOAelhjTuealul6Q8OHn4UO7XQZ6H
 CGCy9mUPV+0JPRkDyQYWvhKgIxqi/BkitQyTGNB/crIvR90QP60YXcAkIzcse4OzqmQXpeVMhN9
 6cIB7wPGa4cVX0xIPPHRWdOkpmdp033IwTebuabUJp89TgF6tib7D5S01wVCgMAeKiiP5ds0D+W
 J7khdBl6dF5+N40mGl3NMJkADTdxKgfzAZg64UfRYVU8e5unPD17KPDtSeA0C3BxgtRgHvkFi4w
 CZkS1sFji+B95I7jfgDg3gc71sd/J3foyXw6HtSPDSR0qFf+o+JrDsqI3UvF0Bary2+7s7AwgqP
 ivZ8I84u4VV284mxqRnfnOtJxQQJ1G3PS7reAmjLZDSPD+aEbtSMFwOgpLuXmWDlBb3xQAA4tiT
 o4tH0ZS0ZtfWEwM94=
X-Received: by 2002:a05:600c:3111:b0:4a0:159b:d2a2 with SMTP id
 5b1f17b1804b1-4a18e4e14e8mr386664395e9.29.1792092630871; 
 Thu, 15 Oct 2026 12:30:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd96fed4sm95895665e9.2.2026.10.15.12.30.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:30 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: guard VCE/UVD sched entity teardown on failed
 probe
Date: Thu, 15 Oct 2026 21:30:29 +0200
Message-ID: <20261015193029.86405-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
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
