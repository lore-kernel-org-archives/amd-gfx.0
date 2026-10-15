Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD463CC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF7B112466;
	Thu, 15 Oct 2026 19:30:47 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F78112469
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:40 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so50572115e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092639; x=1792697439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cJmV+0u7KoUgOcr4W1/BsR9YXNQ+ansu/DyonKAYPF4=;
 b=mvCdLp8QwPTHcfQYGxCI5N8LAw8uNplNz4uXstLc4bhjvwDzVRunZDD11MbydJtFcO
 blUkjgmiZ/N9hMG+3vPJhVBi/JikwL4Dv3aAnBPGFCguh7zNYsXclt2EACeeCG2Q7Ipl
 0Hgl02Szb+0rrMk028fZ9p0gEFCcWC8V7zxqsNL//Tsr8jOnaumq0LXk+ykcVnN1zz7A
 scm7KFVGVX2zu4Og/lPxeNACGOsujxCG1JuIyBF/rEhO1N5dfwipOr9kA6SecuNSP7hn
 NYs7+V/1jALQnfPLGk+qOy+cYPFrQScbDBPnwWigAaLZuEOjhDK2SqS+CgNIDUQNWzPZ
 UJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092639; x=1792697439;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cJmV+0u7KoUgOcr4W1/BsR9YXNQ+ansu/DyonKAYPF4=;
 b=zcm7CFMZ25e2QZHC1O6KW9tdCRfJtaUrD4OAzqEq1la56hak2vMkzRRfLRClrneh61
 IKeCI/qjrObjMI+bk4dwcjkwmaKoCjcQYVvMEOV74hiJSNgf54eOdUO8oN34yY0kVAj0
 tFONSDSh8QjDmKwymejPkYomn/jX6s4kMNm7VLP0i5FrC7vJ01XFutG/OlW0CUlmh3pz
 rF5wqjM9TOznGwmSGW2w6ZSEWCEiOeK5kjnz2VrPYm6uQSlm1U6eHoIlcQ5MGnmukovz
 C36tWpgujeHTYJII514S3K8j+st3N0bc/7gSbhCWdYWvWgw4E3gFTJIVMe+H63EdNz/g
 w0uQ==
X-Gm-Message-State: AFq9FYJeKPZ67sJOBGi4CiiLMkns0svEIjkBF7ENfqs1XEj34Z6RE4MS
 I4WodAIyNwebGWOjgNxct1jo7hgf8qmNP1+Ny/WzSX+QFTwMTYoAynoFVHKPqu5l
X-Gm-Gg: AYBFou2QCAkzSgYOCE6jpO8APChekoIxRA3MrV2rj46tx2s+PoiZYZpDur9WkxWAOIf
 pDxlSCD7YmP2aE9eivZmXAriEeL4mIIQ0gqASoUx/AFoMZFnkYjfpFQ07PajnSF91UXKwLZEAKy
 wugmWI7IEwNueBsIX+OpuDGlzpLupIuJ85Rl2Ebl2aaKXafjYKi/F27XgrRgYcwHOzKvQV0VWIc
 Z1NLWA4yuV1JSLvSfZPqVuNekxQEJS2wVD5JuKw8KoVeJXxoacGYq5SOFd/uu78s3XEjpLb9CmG
 3rh4Ew1nbuE3Q4NQ8bKnjUtNH0CAA8F1SsjFKgC0jKW/09G/gPZq6Tod/ZEJv1O2YJusb6f9AHX
 O0oZzlwttLxZ4L/fM/OLqdOpwC7P1efn6UelIXPdIn9aDRgLdoRuj9HU6iXJYjbWQC4lX/r4fWB
 Id3d0Tl+x2Dx0OzaMqImp3gWI0N8y5bbdg6Hxplh7mZ3xlNjBPmb4Futio7ApycXcSw8X6It22v
 xfOXjMaCqhebeFkoQgOzlm9xORvPgrqQy/VlxEmUfqOtgZTO5FldtvYdh4flLlwluNFtXJsPKb4
 Tm3qu7hWXEtedMaKXKgi2paXnWGWmmOTvQP8ovmI6pg7x2KXHBE6JwbvnTa4KPbZbRDp4+A4K7S
 Fjyw9qaTXSYib6dngtqODo/ZF4Zm45Alzvby0tMI/WEQ/y9WlGqotCcvkCCBbuM7yL1+niJd5b+
 qg3Lha8JGW1t/KYUPP
X-Received: by 2002:a05:600c:8b65:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-4a18e3ef1bdmr383030835e9.0.1792092638633; 
 Thu, 15 Oct 2026 12:30:38 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ac1db6sm480425e9.2.2026.10.15.12.30.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:38 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, phasta@kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v2] drm/amdgpu: guard VCE/UVD sched entity teardown on failed
 probe
Date: Thu, 15 Oct 2026 21:30:37 +0200
Message-ID: <20261015193037.86472-1-olivier.kaloudoff@gmail.com>
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

The hole was latent-but-safe until commit 2df5efb45425 ("drm/sched:
Remove redundant entity->rq initialization and checks") removed the
if (!entity->rq) early return that commit 1decbf6bb0b4 ("drm/sched:
Fix entities with 0 rqs.") had put in drm_sched_entity_flush(), on the
grounds that entity->rq can never be NULL. That holds only for
entities that completed drm_sched_entity_init() — not for the
never-initialized entity this teardown path reaches.

Observed on real hardware: MI50 (Vega20, VCE 4.0 / UVD 7.2) behind a
Thunderbolt link — a pciehp presence/link-change event re-probes the
device; when the re-probe fails (-EINVAL here), the cleanup path
NULL-derefs inside drm_sched_entity_flush() in the pciehp IRQ thread
and takes the whole machine down (panic_on_oops, EFI pstore capture).
Reproduced twice on 7.3-rc5, 2026-10-06 and 2026-10-09, identical
signature; the faulting instruction is `mov (%rax),%r15` on rax =
entity->rq == NULL, i.e. `sched = entity->rq->sched`:

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

v2: retarget Fixes: at commit 2df5efb45425 ("drm/sched: Remove
redundant entity->rq initialization and checks") — the !entity->rq
check from commit 1decbf6bb0b4 ("drm/sched: Fix entities with 0
rqs.") that Alex pointed to was removed by it in the 7.3 window,
so this is a regression there, not a pre-existing hole.

Fixes: 2df5efb45425 ("drm/sched: Remove redundant entity->rq initialization and checks")
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Philipp Stanner <phasta@kernel.org>
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
