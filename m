Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85664C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 20:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F85D22795
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 20:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F85D22795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF876EC46;
	Wed, 13 Jan 2021 20:31:24 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5938C6EC49
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 20:31:23 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id d8so3169841otq.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 12:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tIsMFN7MCr4VGDfCyHGUybIAT0I8JVPh44VCIgcVMZE=;
 b=dRqPF7lgAwV9QYrEN9EdsCRFitGqIqiqgraq5idLuQsXYcKjjhpMB1gR+jX2iKPCon
 LPlyoERUanzORR1tbPMIE9JzNyX0b8idcUeT3TSAS98LVMR/M5QfBQCca80DDZbtwrZx
 IQlrPfa+Ek+1oTt8y6d/1GhbvRBS5WGS/mzdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tIsMFN7MCr4VGDfCyHGUybIAT0I8JVPh44VCIgcVMZE=;
 b=mkpHCy8ajQOAt6xHNVAPHCPCpErZ1DjjRuzmw+0Z8bIT3nrBLK42BQkENEmkCSCioa
 hHCqgnGpMLt6zhkgg+qZ5d0+q4QjSIMqlZcfi9ToMl0N+6xQLp7FQ9mgXGfWiXEsJhbT
 QzOOGSHvq/9cJT2nmtq67FjUo97fM3W+bFtcuI5CDb70b3hoK77Fv7oNndHhuFGyk9+7
 bYiFOwtDCwNvCN+6yP1tfEbDbYJegZIQc4XlDgRYXUgT6LONM//SCGLJDgL00A9M6Ylw
 6wYg/pCn/bLB6rJzIko4zSJbLRKs0MmMNvqLWHoGRbtyyY108dW3T6oHtBIBrh4/84tC
 z+Hg==
X-Gm-Message-State: AOAM531wQg9zGsZ3a30Nz5Jtb3GYCb4+IRg2DWO6mxNfKYF62+7UF8L/
 Og+KyG6qXBkoXxVFlXbhELCLUaJCEohRDqpPvmN3AA==
X-Google-Smtp-Source: ABdhPJwEPJznspIjbx89aenwU4mYdS2KpjPGht0zVfxnqLQXk3+0hpnQN+v2Y9p0JpfXROzPyTuJlw1/lhsv/9rRRJs=
X-Received: by 2002:a9d:ea6:: with SMTP id 35mr2396936otj.188.1610569882541;
 Wed, 13 Jan 2021 12:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20210107030127.20393-1-Felix.Kuehling@amd.com>
 <X/bTFWL3HYVc8LEF@phenom.ffwll.local>
 <6daf9ebc-507e-6e83-04dd-d7c5fc6998d6@amd.com>
 <X/hux3eX8Ywf61h7@phenom.ffwll.local> <20210113165646.GB521755@redhat.com>
In-Reply-To: <20210113165646.GB521755@redhat.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 13 Jan 2021 21:31:11 +0100
Message-ID: <CAKMK7uEiYXHp99mUkmMcQVJTdWgHQWOZpDJ1vfNYacKghbtYtw@mail.gmail.com>
Subject: Re: [PATCH 00/35] Add HMM-based SVM memory manager to KFD
To: Jerome Glisse <jglisse@redhat.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>, "Yang, Philip" <philip.yang@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 13, 2021 at 5:56 PM Jerome Glisse <jglisse@redhat.com> wrote:
> On Fri, Jan 08, 2021 at 03:40:07PM +0100, Daniel Vetter wrote:
> > On Thu, Jan 07, 2021 at 11:25:41AM -0500, Felix Kuehling wrote:
> > > Am 2021-01-07 um 4:23 a.m. schrieb Daniel Vetter:
> > > > On Wed, Jan 06, 2021 at 10:00:52PM -0500, Felix Kuehling wrote:
> > > >> This is the first version of our HMM based shared virtual memory manager
> > > >> for KFD. There are still a number of known issues that we're working through
> > > >> (see below). This will likely lead to some pretty significant changes in
> > > >> MMU notifier handling and locking on the migration code paths. So don't
> > > >> get hung up on those details yet.
> > > >>
> > > >> But I think this is a good time to start getting feedback. We're pretty
> > > >> confident about the ioctl API, which is both simple and extensible for the
> > > >> future. (see patches 4,16) The user mode side of the API can be found here:
> > > >> https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/blob/fxkamd/hmm-wip/src/svm.c
> > > >>
> > > >> I'd also like another pair of eyes on how we're interfacing with the GPU VM
> > > >> code in amdgpu_vm.c (see patches 12,13), retry page fault handling (24,25),
> > > >> and some retry IRQ handling changes (32).
> > > >>
> > > >>
> > > >> Known issues:
> > > >> * won't work with IOMMU enabled, we need to dma_map all pages properly
> > > >> * still working on some race conditions and random bugs
> > > >> * performance is not great yet
> > > > Still catching up, but I think there's another one for your list:
> > > >
> > > >  * hmm gpu context preempt vs page fault handling. I've had a short
> > > >    discussion about this one with Christian before the holidays, and also
> > > >    some private chats with Jerome. It's nasty since no easy fix, much less
> > > >    a good idea what's the best approach here.
> > >
> > > Do you have a pointer to that discussion or any more details?
> >
> > Essentially if you're handling an hmm page fault from the gpu, you can
> > deadlock by calling dma_fence_wait on a (chain of, possibly) other command
> > submissions or compute contexts with dma_fence_wait. Which deadlocks if
> > you can't preempt while you have that page fault pending. Two solutions:
> >
> > - your hw can (at least for compute ctx) preempt even when a page fault is
> >   pending
> >
> > - lots of screaming in trying to come up with an alternate solution. They
> >   all suck.
> >
> > Note that the dma_fence_wait is hard requirement, because we need that for
> > mmu notifiers and shrinkers, disallowing that would disable dynamic memory
> > management. Which is the current "ttm is self-limited to 50% of system
> > memory" limitation Christian is trying to lift. So that's really not
> > a restriction we can lift, at least not in upstream where we need to also
> > support old style hardware which doesn't have page fault support and
> > really has no other option to handle memory management than
> > dma_fence_wait.
> >
> > Thread was here:
> >
> > https://lore.kernel.org/dri-devel/CAKMK7uGgoeF8LmFBwWh5mW1k4xWjuUh3hdSFpVH1NBM7K0=edA@mail.gmail.com/
> >
> > There's a few ways to resolve this (without having preempt-capable
> > hardware), but they're all supremely nasty.
> > -Daniel
> >
>
> I had a new idea, i wanted to think more about it but have not yet,
> anyway here it is. Adding a new callback to dma fence which ask the
> question can it dead lock ? Any time a GPU driver has pending page
> fault (ie something calling into the mm) it answer yes, otherwise
> no. The GPU shrinker would ask the question before waiting on any
> dma-fence and back of if it gets yes. Shrinker can still try many
> dma buf object for which it does not get a yes on associated fence.

Having that answer on a given fence isn't enough, you still need to
forward that information through the entire dependency graph, across
drivers. That's the hard part, since that dependency graph is very
implicit in the code, and we'd need to first roll it out across all
drivers.

> This does not solve the mmu notifier case, for this you would just
> invalidate the gem userptr object (with a flag but not releasing the
> page refcount) but you would not wait for the GPU (ie no dma fence
> wait in that code path anymore). The userptr API never really made
> the contract that it will always be in sync with the mm view of the
> world so if different page get remapped to same virtual address
> while GPU is still working with the old pages it should not be an
> issue (it would not be in our usage of userptr for compositor and
> what not).
>
> Maybe i overlook something there.

tbh I'm never really clear on how much exactly we need, and whether
maybe the new pin/unpin api should fix it all.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
