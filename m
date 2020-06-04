Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81847C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 08:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571E4206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kyBPPaRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571E4206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C836E2B6;
	Thu,  4 Jun 2020 08:12:35 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4106E2B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 08:12:34 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id e1so5052450wrt.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wjYKgl1BXaEH8GQKLg8VxMrSCY/k0US00QhIRvYYPEA=;
 b=kyBPPaRamy/HmHh5JRj3lm6cSO9mrjCTe6nPVNXWZl7sLcwpFLZH03d7IXCaDQAbU9
 bWT+/fuJcxKCIvQeAz+7/CPD/m6BbEWAbJlfzQwnsSAN+AsbvA8QndXdYZFwQO0ucpeW
 +N5wby58BJfSZKsnQFztX13ktrN76Zl77KJZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wjYKgl1BXaEH8GQKLg8VxMrSCY/k0US00QhIRvYYPEA=;
 b=TOhjCxsLz7ku3cbwxoaDt38Vj1gyl0xmUmIJGZfELdIcpgLdkExcMu7ZWERZ9ISgNR
 MOZ/wtyjEGMusXEq4N3+Soy30lX8UTNKy9brycQ59zCTc9mg26Wa8gyzWbLWGBJBbzkg
 R66yrFdDXUwav2yaTLsCc98LNlQmfprKb77pGusI+qAVEZRbgtvsisI8L+NetJ4F4zNo
 X08PrGph1OGDbGmZBGZ9i2L9+kQu/omIpteW3vPw4Q1BtuhuMCRW3dY5HYzat5dtS1fu
 SOBf+dvihNFH8gcZmm5BBx+2LE71bBGe+nKvvRvtwROe/hMhn6LruhmmJePaOB5jqd9z
 ZvMA==
X-Gm-Message-State: AOAM530QEaF/CZkkxNhCGjTk9JQmAlA4SYt/UBneIm5oL6kCrkxgBes6
 vMEUSbiS75chL3S5+t9+Cn6qciYeQD0=
X-Google-Smtp-Source: ABdhPJwck51N31CTXP+8yfy3JqBTy0FFs7zaLP/6w37Ug1NNs626RcdqKC1IFsIertUA5A07+TX4Qw==
X-Received: by 2002:adf:aa97:: with SMTP id h23mr3419463wrc.251.1591258352295; 
 Thu, 04 Jun 2020 01:12:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 01:12:31 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 00/18] dma-fence lockdep annotations, round 2
Date: Thu,  4 Jun 2020 10:12:06 +0200
Message-Id: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

Still very much early stuff, still very much looking for initial thoughts
and maybe some ideas how this could all be rolled out across drivers.

Full intro probably best from the RFC cover letter:

https://lore.kernel.org/amd-gfx/20200512085944.222637-1-daniel.vetter@ffwll.ch/

Changes since last time around:

- might_sleep annotation has landed already, I split that out as a
  stand-alone

- now with an mm patch to improve direct reclaim annotations for mmu
  notifiers. This allows us to very easily catch issues in that area, no
  more need for exaustive testing and luck to make sure we're not leaving
  a GFP_NOFS or GPF_NOIO around which should be a GFP_ATOMIC

- kerneldoc that explains all the reasoning behind the annotations and
  priming, hopefully

Driver patches still largely just meant as examples to illustrate usage,
but from various irc chats I think discussing them is really useful to
gain clarity on the exact places the annotations should be put.

Cheers, Daniel

Daniel Vetter (18):
  mm: Track mmu notifiers in fs_reclaim_acquire/release
  dma-buf: minor doc touch-ups
  dma-fence: basic lockdep annotations
  dma-fence: prime lockdep annotations
  drm/vkms: Annotate vblank timer
  drm/vblank: Annotate with dma-fence signalling section
  drm/atomic-helper: Add dma-fence annotations
  drm/amdgpu: add dma-fence annotations to atomic commit path
  drm/scheduler: use dma-fence annotations in main thread
  drm/amdgpu: use dma-fence annotations in cs_submit()
  drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
  drm/amdgpu: DC also loves to allocate stuff where it shouldn't
  drm/amdgpu/dc: Stop dma_resv_lock inversion in commit_tail
  drm/scheduler: use dma-fence annotations in tdr work
  drm/amdgpu: use dma-fence annotations for gpu reset code
  Revert "drm/amdgpu: add fbdev suspend/resume on gpu reset"
  drm/amdgpu: gpu recovery does full modesets
  drm/i915: Annotate dma_fence_work

 Documentation/driver-api/dma-buf.rst          |  18 +-
 drivers/dma-buf/dma-buf.c                     |   6 +-
 drivers/dma-buf/dma-fence.c                   | 202 ++++++++++++++++++
 drivers/dma-buf/dma-resv.c                    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 drivers/gpu/drm/drm_atomic_helper.c           |  16 ++
 drivers/gpu/drm/drm_vblank.c                  |   8 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c     |   3 +
 drivers/gpu/drm/scheduler/sched_main.c        |  11 +
 drivers/gpu/drm/vkms/vkms_crtc.c              |   8 +-
 include/linux/dma-fence.h                     |  13 ++
 mm/mmu_notifier.c                             |   7 -
 mm/page_alloc.c                               |  23 +-
 20 files changed, 341 insertions(+), 35 deletions(-)

-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
