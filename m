Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63E5C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 17:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A772C6146D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 17:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A772C6146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DCBC6E45C;
	Mon, 22 Mar 2021 17:04:32 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F95B6E52D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 17:04:31 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 f73-20020a9d03cf0000b02901b4d889bce0so16630830otf.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2k1F2BDojY44nwXR7BotkkV76dpZ5awZARzDNI/4QfE=;
 b=dkHenydv5IiRl4N0Rdv45gD6ZBWxnfr7BXRtAPVWTdD9JjPgKZvjRevjtlwJhKLpaF
 FfrJDXY+VkTLIKNoR7SKtFhq9a1lXmnbiQPenbaWfeSe37u5LUfL62SV9ROCPEepJ2kt
 9QshPXH5URhle9D3jFCztID7jYixXFm1iT5DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2k1F2BDojY44nwXR7BotkkV76dpZ5awZARzDNI/4QfE=;
 b=hZKt5UfJpwoBZ5gdIbNJxbM9Q03YncKe2SW1wbiYIxd4h05rYgihavxjGrn3G86HLN
 Rzj1BoiwkaHFLkAguBaM1tKe81v48pjPYws5zqeYxLcMsJJX+YxYmvX9EJ8z/RYCY1Nh
 cvZ7vJhMNLU9dsMKqPkJBKS1ymxEgKNwRFHk/b8hyg30yg9jAKt69SRpMwNoWFGEJ6hB
 eQBxS9s6JPAECbshRBUjwitN+SE6gYUEY5GD4DRkc9ChdOf11z9UviP4dT4A4G3MQZY5
 AotBLEPTdiZ5DCmRVWL/vzzfiv5HebiIKu52LTvPGgfFJKwZnKh/jhK+tlYV0xC/xIoI
 vzyg==
X-Gm-Message-State: AOAM533XvCM79iqNPPfhxB1ot+VpMqoewqxp6XhhfoKFskXjPFUak54f
 7pAJ+MTCBvNhnnitUrssDBA/ZWfJEQ8lyonAiFZl6g==
X-Google-Smtp-Source: ABdhPJwVqe3ds/v1z/BSK2XKnMM+HERP6yLoqotTfPiZ8YGagCqO2zMR6fC9C5NCWQYW2/c7LhhzpJB2z8y+sO7kqkc=
X-Received: by 2002:a9d:6481:: with SMTP id g1mr682876otl.303.1616432670561;
 Mon, 22 Mar 2021 10:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210322105900.14068-1-Felix.Kuehling@amd.com>
 <YFimfx6CFAWIou2t@phenom.ffwll.local>
 <aead1e5f-987f-3d53-a457-5f78618e49ac@amd.com>
In-Reply-To: <aead1e5f-987f-3d53-a457-5f78618e49ac@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 22 Mar 2021 18:04:19 +0100
Message-ID: <CAKMK7uG7hxx3RApQSF8xN+k37CZHCra3Ek42wWHhrUctr6TkxA@mail.gmail.com>
Subject: Re: [PATCH 00/44] Add HMM-based SVM memory manager to KFD v2
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 22, 2021 at 5:07 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2021-03-22 um 10:15 a.m. schrieb Daniel Vetter:
> > On Mon, Mar 22, 2021 at 06:58:16AM -0400, Felix Kuehling wrote:
> >> Since the last patch series I sent on Jan 6 a lot has changed. Patches 1-33
> >> are the cleaned up, rebased on amd-staging-drm-next 5.11 version from about
> >> a week ago. The remaining 11 patches are current work-in-progress with
> >> further cleanup and fixes.
> >>
> >> MMU notifiers and CPU page faults now can split ranges and update our range
> >> data structures without taking heavy locks by doing some of the critical
> >> work in a deferred work handler. This includes updating MMU notifiers and
> >> the SVM range interval tree. In the mean time, new ranges can live as
> >> children of their parent ranges until the deferred work handler consolidates
> >> them in the main interval tree.
> > I'm totally swammped with intel stuff unfortunately, so not really time to
> > dig in. Can you give me the spoiler on how the (gfx10+ iirc) page fault
> > inversion is planned to be handled now? Or that still tbd?
>
> Navi is still TBD. This patch series focuses on GFXv9 because that's the
> IP our data center GPUs are on. The code here has two modes of
> operations, one that relies on page faults and one that relies on
> preemptions. The latter should work on Navi just fine. So that's our
> minimal fallback option.
>
>
> >
> > Other thing I noticed is that amdkfd still uses the mmu_notifier directly,
> > and not the mmu_interval_notifier. But you're talking a lot about managing
> > intervals here, and so I'm wondering whether we shouldn't do this in core
> > code? Everyone will have the same painful locking problems here (well atm
> > everyone = you&nouveau only I think), sharing this imo would make a ton of
> > sense.
>
> We use mmu_interval_notifiers in all the range-based code, including
> even our legacy userptr code. The only non-interval notifier that's
> still in use in KFD is the one we use for cleanup on process termination.

I guess my git grep got wrong, I thought I've only found it in the
amdgpu userptr code, not on the amdkfd side of things. Sounds all
good.
-Daniel

>
>
> >
> > I think the other one is moving over more generic pasid code, but I think
> > that's going to be less useful here and maybe more a long term project.
>
> Yes, it's unrelated to this work.
>
> Regards,
>   Felix
>
>
> >
> > Cheers, Daniel
> >
> >> We also added proper DMA mapping of system memory pages.
> >>
> >> Current work in progress is cleaning up all the locking, simplifying our
> >> code and data structures and resolving a few known bugs.
> >>
> >> This series and the corresponding ROCm Thunk and KFDTest changes are also
> >> available on gitub:
> >>   https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/tree/fxkamd/hmm-wip
> >>   https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/tree/fxkamd/hmm-wip
> >>
> >> An updated Thunk
> >>
> >> Alex Sierra (10):
> >>   drm/amdgpu: replace per_device_list by array
> >>   drm/amdkfd: helper to convert gpu id and idx
> >>   drm/amdkfd: add xnack enabled flag to kfd_process
> >>   drm/amdkfd: add ioctl to configure and query xnack retries
> >>   drm/amdgpu: enable 48-bit IH timestamp counter
> >>   drm/amdkfd: SVM API call to restore page tables
> >>   drm/amdkfd: add svm_bo reference for eviction fence
> >>   drm/amdgpu: add param bit flag to create SVM BOs
> >>   drm/amdgpu: svm bo enable_signal call condition
> >>   drm/amdgpu: add svm_bo eviction to enable_signal cb
> >>
> >> Felix Kuehling (22):
> >>   drm/amdkfd: map svm range to GPUs
> >>   drm/amdkfd: svm range eviction and restore
> >>   drm/amdkfd: validate vram svm range from TTM
> >>   drm/amdkfd: HMM migrate ram to vram
> >>   drm/amdkfd: HMM migrate vram to ram
> >>   drm/amdkfd: invalidate tables on page retry fault
> >>   drm/amdkfd: page table restore through svm API
> >>   drm/amdkfd: add svm_bo eviction mechanism support
> >>   drm/amdkfd: refine migration policy with xnack on
> >>   drm/amdkfd: add svm range validate timestamp
> >>   drm/amdkfd: multiple gpu migrate vram to vram
> >>   drm/amdkfd: Fix dma unmapping
> >>   drm/amdkfd: Call mutex_destroy
> >>   drm/amdkfd: Fix spurious restore failures
> >>   drm/amdkfd: Fix svm_bo_list locking in eviction worker
> >>   drm/amdkfd: Simplify split_by_granularity
> >>   drm/amdkfd: Point out several race conditions
> >>   drm/amdkfd: Return pdd from kfd_process_device_from_gduid
> >>   drm/amdkfd: Remove broken deferred mapping
> >>   drm/amdkfd: Allow invalid pages in migration.src
> >>   drm/amdkfd: Correct locking during migration and mapping
> >>   drm/amdkfd: Nested locking and invalidation of child ranges
> >>
> >> Philip Yang (12):
> >>   drm/amdkfd: add svm ioctl API
> >>   drm/amdkfd: register svm range
> >>   drm/amdkfd: add svm ioctl GET_ATTR op
> >>   drm/amdgpu: add common HMM get pages function
> >>   drm/amdkfd: validate svm range system memory
> >>   drm/amdkfd: deregister svm range
> >>   drm/amdgpu: export vm update mapping interface
> >>   drm/amdkfd: register HMM device private zone
> >>   drm/amdkfd: support xgmi same hive mapping
> >>   drm/amdkfd: copy memory through gart table
> >>   drm/amdgpu: reserve fence slot to update page table
> >>   drm/amdkfd: Add SVM API support capability bits
> >>
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |    4 +
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |    4 +-
> >>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |   16 +-
> >>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   13 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        |   83 +
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |    7 +
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |    4 +
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   90 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   48 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   11 +
> >>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |    1 +
> >>  drivers/gpu/drm/amd/amdkfd/Kconfig            |    1 +
> >>  drivers/gpu/drm/amd/amdkfd/Makefile           |    4 +-
> >>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  173 +-
> >>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |    4 +
> >>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        |    8 +-
> >>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  922 ++++++
> >>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |   59 +
> >>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   54 +-
> >>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  191 +-
> >>  .../amd/amdkfd/kfd_process_queue_manager.c    |    6 +-
> >>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 2865 +++++++++++++++++
> >>  drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  175 +
> >>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |    6 +
> >>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |   10 +-
> >>  include/uapi/linux/kfd_ioctl.h                |  171 +-
> >>  26 files changed, 4681 insertions(+), 249 deletions(-)
> >>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> >>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> >>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> >>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> >>
> >> --
> >> 2.31.0
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
