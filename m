Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB306C00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 01:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB282B190A;
	Sat, 13 Aug 2022 01:28:16 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85221B1793
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 01:27:58 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id a89so3221000edf.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=vqaoY3jdhk4E9hdABek+hIB08E8Id7xqX9DJkxDHz/A=;
 b=aqL65AH55XgZ2fWwcRxB8HyQz2OHx4OTnPm/vJdY0wH7yVYVAee+lryt93n+Z0Eo7e
 /gmmGxkjerLXvspQ+9+OJsDEQ1hn4oS9N0UGvfWOruy8Y6zQEh6ZNC2BbiWj7QLTLqc7
 nAAw9mDjqI2xcM9B2V9zLvMoz3lkG6xHr+ioxgCuP8NbYe74XA+TbyyhQvNL7v5sefWx
 kBcHAbGWX4IzoDSWxGPhh43yQHRk6xN+64XDfaBQHNgp5oE4Eh8RpNw3oPG89yeZlXir
 5RbKm7yF7ZlEDk0bNhM4lVAuUCRE2uxdsP3cjSAq6oi87XL3Adl8A6bN8lOPoz4eDC45
 rJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=vqaoY3jdhk4E9hdABek+hIB08E8Id7xqX9DJkxDHz/A=;
 b=RzCgFqMsW2wR6ZW8+n14W+01XaV31wph480NS7YS3Kh9vZkGUjdMNGfa/Bu5mqjU/+
 GLpUGRjSTq5p5XuPTzZ+0vCTx2rfEYrjgA7ghfrpatUnMgGpFn8/+qF/28sm1r5TFlHs
 +8R93wFk2tSCOmatiDsacHB0BFcjuwGqYiBxfh/eMxYgMKHKtJTlNTGmFn8aRcGUr17X
 +YoTK5O0VFrfew04EgmJcCSFSj3TyZXd1dFN7cSjTQj0K/bpm4sWvs8DUP/8XWDAZpbk
 yHoIM6u9Rcfp3n1UsePS9nAshYcCC3addlL5FW02SC40GahLGravxWybYG3+dhbSdtOB
 G/IA==
X-Gm-Message-State: ACgBeo21EsHwyhtO3oI3dVGy2Rd4ZLxDv/Uz4QraLoZ5NDU9ptwRt/ed
 IH81jPWP5YHvHPe3XFZJF3luGA==
X-Google-Smtp-Source: AA6agR5iet6vetwJGW3i9SLxjJ8XMtov4gqjcgYrLUW58wjifAVoIsG5d+3B/1CKNKISdN09y1DnqQ==
X-Received: by 2002:aa7:ce88:0:b0:442:30f5:433f with SMTP id
 y8-20020aa7ce88000000b0044230f5433fmr5696166edv.317.1660354076357; 
 Fri, 12 Aug 2022 18:27:56 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id
 ot3-20020a170906ccc300b0072ab06bf296sm1342536ejb.23.2022.08.12.18.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Aug 2022 18:27:55 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/6] amdgpu: Allow explicitly synchronized submissions.
Date: Sat, 13 Aug 2022 03:27:55 +0200
Message-Id: <20220813012801.1115950-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
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
Cc: christian.koenig@amd.com, daniel@ffwll.ch,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds a context option to use DMA_RESV_USAGE_BOOKKEEP for userspace submissions,
based on Christians TTM work.

Disabling implicit sync is something we've wanted in radv for a while for resolving
some corner cases. A more immediate thing that would be solved here is avoiding a
bunch of implicit sync on GPU map/unmap operations as well, which helps with stutter
around sparse maps/unmaps.

This has seen a significant improvement in stutter in Forza Horizon 5 and Forza
Horizon 4. (As games that had significant issues in sparse binding related stutter).
I've been able to pass a full vulkan-cts run on navi21 with this.

Userspace code for this is available at
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/18032 and a branch
for the kernel code is available at
https://github.com/BNieuwenhuizen/linux/tree/no-implicit-sync-5.19

This is a follow-up on RFC series https://patchwork.freedesktop.org/series/104578/ .

The main changes were:

1) Instead of replacing num_shared with usage, I'm just adding usage, since
   num_shared was actually needed.
2) We now agree that DMA_RESV_USAGE_BOOKKEEP is reasonable for this purpose.

Please let me know if I missed anything, especially with the change to VM updates,
as we went back and forth a ton of times on that.


Bas Nieuwenhuizen (6):
  drm/ttm: Add usage to ttm_validate_buffer.
  drm/amdgpu: Add separate mode for syncing DMA_RESV_USAGE_BOOKKEEP.
  drm/amdgpu: Allow explicit sync for VM ops.
  drm/amdgpu: Refactor amdgpu_vm_get_pd_bo.
  drm/amdgpu: Add option to disable implicit sync for a context.
  drm/amdgpu: Bump amdgpu driver version.

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 16 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 20 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       | 32 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 12 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 11 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      | 11 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h      |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  1 +
 drivers/gpu/drm/qxl/qxl_release.c             |  1 +
 drivers/gpu/drm/radeon/radeon_cs.c            |  2 ++
 drivers/gpu/drm/radeon/radeon_gem.c           |  1 +
 drivers/gpu/drm/radeon/radeon_vm.c            |  2 ++
 drivers/gpu/drm/ttm/ttm_execbuf_util.c        |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c      |  7 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c    |  1 +
 include/drm/ttm/ttm_execbuf_util.h            |  2 ++
 include/uapi/drm/amdgpu_drm.h                 |  3 ++
 28 files changed, 122 insertions(+), 37 deletions(-)

-- 
2.37.1

