Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9B0C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87D610E4DA;
	Fri, 28 Aug 2026 11:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CW27+uyj";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF7B10E4DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:18 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso166224966b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917277; x=1788522077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PN/biFQi5QCpUku0Rgl7gX00ZA3KJn7OntzDUHczjYQ=;
 b=CW27+uyjPUXcmHzb4Fom0ArQuwLv3ql0q280EYabRgcZZpKE26/6j5xjlTXB2tfqwV
 OnhOonEcVagP0OAF2zaAk25ljg9QHNw/APsg3qO0EOY35swA4O76w4svZxy3tBB2UaLi
 T/4lnX99fGW9fgmY8YGDWRo42xZ8qY0b3HgctAwB+DFNobF/EakT/yjB7l+Cfi1yO4uE
 j+VX4RgZQHrc7wIJGZKFJYTvv5v5VdPJ3jKNhKFv4pFwIY1bWZ+hl8FzvgtVrauS58EQ
 5O1DqqINQoOgobNsURhsQk+7Qv/mi/PATXlHgzWtOamZi7f5mmiwScS/ChTwzi6x9Re3
 Wu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917277; x=1788522077;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PN/biFQi5QCpUku0Rgl7gX00ZA3KJn7OntzDUHczjYQ=;
 b=pbYp6wk1dWu1r5XIrN25i6GZnhBz9XEFeVGbq3qYaKABVyCVUbpZRiTEAcFco1tc1q
 cj9l5Vo+EVNTfCQAEvn71CeZwM2rPqwFsZqIFnFk2g2ZDbcCzLrraKXhEDtKZBPb5QOU
 xfjEZIcqL0N1VQ9mIFf/Yt17aRQYwFg15xBIbddbbRVqE2+x+THqYwaPm6sOo1h2b8EO
 qBSVIyLtqnmt+ADhznztuv3KDK+g6i5M/TrahXmPNQJhFaWTZMPoFY0ugn2faNS7Em6L
 wTRH06Um+27mylDicQDLP0lAHFaVmfbXA8IXl5cH6S279OEsj4Hs+npcwUEKH9POseDj
 hDdA==
X-Gm-Message-State: AFuF++lwx9RU31dPyI/l9DZ6rq4bT7WisNj0YiY4XLnf7TTN4pbHK99N
 4+UFBkuAMruR6y5L6cpHrnvoUNvkMQLEg0l2xH3RxBoVTMuyR0T6N1DadstY7S9X
X-Gm-Gg: AR+sD10Goa8DXtxJdhp1g2sGbRIziybW5xoU1cLlhQSgJzaAQqwefd0L8q/t3Jw/3Is
 K+8kuzBpe4YGHGojiFTCPcMGlrLSwC7tL13qiNhSBUinsF94hVSb/PjW5rgC36FtMH42UwLoPqa
 phAltDudTG1oQSwmnkmI8VA3zxg/DXPZFdDa88EKbKAQX5KheRRbN7yYN9tyDfOkHFLsnZJ+rHF
 oHumnWNmZL/BtSHUJK0tP9TRzeb84WwqxBOf4bOfx1O9u8YZ+ZIl31+ZPJw2vkU61a6UKjFRzpN
 ZJ370wItEKOiiUvc1VkOcy8GWfD8sOnbqFBmsew9i5MtFOYTOjx00VeJeL4fDESnfrBkiSkgWe3
 bPbpkbGIBVyPf5pPcYxjNeNBQMqQkg43n2/CluKmL9fTEEBPE8GKKnUjDDdm7ITAgiEpbnHDrQB
 QXL+LkxLxi7R37eItfW3wmndhuICcczUFQwWR4jnuAyYmW4z9fG0UxeJGN7fEbJcfQgkBaFXrbO
 koBq3GCJLAtjYSUFkuG6UtLcA==
X-Received: by 2002:a17:907:6d19:b0:c25:4ba1:594f with SMTP id
 a640c23a62f3a-c2552e5667bmr427623866b.0.1787917276726; 
 Fri, 28 Aug 2026 04:41:16 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:16 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/11] drm/amdgpu: Improve retry fault handling (v4)
Date: Fri, 28 Aug 2026 13:41:02 +0200
Message-ID: <20260828114113.13523-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

With this series, the kernel is able to mitigate
most page faults on Navi 3 and 4 without causing a
hang and without a need to reset the GPU, when the
amdgpu.noretry=0 module parameter is set.

Fix various issues with retry fault handling.

Enable filter CAM on Navi 3 and 4 which is a
HW block that filters the repeated page fault
interrupts that happen when retry faults are
enabled, making the handling more efficient.

Changes in v2:

* Reordered patches in the series to put bug fixes first
* Enable retry fault interrupt in init_system_aperture_regs()
  instead of in set_fault_enable_default()
* Added a patch to respect the noretry flag on GFX12.1 too

Changes in v3:

* This series now includes fixes for Navi 4 too which
  were previously submitted in a separate series.
* Dropped patch that improved handling of timestamps
  on the page fault interrupts. I'll come up with
  a different solution for that problem later.
* Dropped patches that solve race condition between
  retry fault handling and filter CAM ACK because
  they conflict with Christian's ongoing work.
  I'll revisit that later.
* Reworked the series into smaller patches for
  easier reviews.
* Addressed comments from Tvrtko's review.
  Thank you Tvrtko for taking the time to review!

Changes in v4:

* Program ENABLE_RETRY_FAULT_INTERRUPT bit to 1
  and not according to the gmc.noretry flag,
  as requested by Alex and Christian.
* Applied Mukul's suggestion to use the doorbell
  for the IH retry CAM instead of the MMIO ACK.
* Dropped patch that enabled the retry CAM MMIO ACK.
* Dropped NOALLOC PTE flag as requested by Christian.

Timur Kristóf (11):
  drm/amdgpu: Respect noretry flag for retry faults on GFX12.1
  drm/amdgpu/gfxhub: Enable retry fault interrupts in
    L2_PROTECTION_FAULT_CNTL2
  drm/amdgpu/ih: Don't perturb HW registers when accessing soft IH ring
  drm/amdgpu/ih6.1: Use IH_SW_RING_SIZE for soft IH ring instead of
    PAGE_SIZE
  drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH ring instead of
    PAGE_SIZE
  drm/amdgpu/gmc11: Pass cam_index to retry fault handler
  drm/amdgpu/gmc12: Pass cam_index to retry fault handler
  drm/amdgpu/gmc12: Use AMDGPU_PTE_IS_PTE flag for init_pte_flags on
    GFX12.0
  drm/amdgpu/vm: Use init PTE flags in amdgpu_vm_handle_fault()
  drm/amdgpu/ih6.0: Enable retry CAM on Navi 3 dGPUs
  drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  5 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c      |  7 ++++-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c        | 32 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c        |  9 +++++-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c        | 15 ++++++----
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c      |  4 +++
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c      |  2 +-
 18 files changed, 121 insertions(+), 28 deletions(-)

-- 
2.55.0

