Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 16:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D27E23383
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 16:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D27E23383
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0BF86E140;
	Wed, 13 Jan 2021 16:56:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574B86E140
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610557013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLGz5IVI1SD0+lSB7KNOJpOQb7GCJmQ5heQVxAmRIrA=;
 b=MeleF3r9TZ6DqSG2atOtzwM/fdo0P+v7wtEx4E/3ylLrf/O1FW7DA628GpWOIBCu8bY96/
 PwEOuvGE+XKgei+5zKPM4ZnRPLgofoOXb9ZoH4+wZrA56yjnarj61lwkJKgUct0hBgAjXq
 HEKSDVZGMWgr6FtonOcCZR0I6lShPUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-a3FY6HrvNRa8Jsi1IlujjQ-1; Wed, 13 Jan 2021 11:56:50 -0500
X-MC-Unique: a3FY6HrvNRa8Jsi1IlujjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 333F2806660;
 Wed, 13 Jan 2021 16:56:49 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.rdu2.redhat.com [10.10.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 756A45D9DD;
 Wed, 13 Jan 2021 16:56:47 +0000 (UTC)
Date: Wed, 13 Jan 2021 11:56:46 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 00/35] Add HMM-based SVM memory manager to KFD
Message-ID: <20210113165646.GB521755@redhat.com>
References: <20210107030127.20393-1-Felix.Kuehling@amd.com>
 <X/bTFWL3HYVc8LEF@phenom.ffwll.local>
 <6daf9ebc-507e-6e83-04dd-d7c5fc6998d6@amd.com>
 <X/hux3eX8Ywf61h7@phenom.ffwll.local>
MIME-Version: 1.0
In-Reply-To: <X/hux3eX8Ywf61h7@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jglisse@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Cc: alex.sierra@amd.com, philip.yang@amd.com,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 08, 2021 at 03:40:07PM +0100, Daniel Vetter wrote:
> On Thu, Jan 07, 2021 at 11:25:41AM -0500, Felix Kuehling wrote:
> > Am 2021-01-07 um 4:23 a.m. schrieb Daniel Vetter:
> > > On Wed, Jan 06, 2021 at 10:00:52PM -0500, Felix Kuehling wrote:
> > >> This is the first version of our HMM based shared virtual memory man=
ager
> > >> for KFD. There are still a number of known issues that we're working=
 through
> > >> (see below). This will likely lead to some pretty significant change=
s in
> > >> MMU notifier handling and locking on the migration code paths. So do=
n't
> > >> get hung up on those details yet.
> > >>
> > >> But I think this is a good time to start getting feedback. We're pre=
tty
> > >> confident about the ioctl API, which is both simple and extensible f=
or the
> > >> future. (see patches 4,16) The user mode side of the API can be foun=
d here:
> > >> https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/blob/fxkam=
d/hmm-wip/src/svm.c
> > >>
> > >> I'd also like another pair of eyes on how we're interfacing with the=
 GPU VM
> > >> code in amdgpu_vm.c (see patches 12,13), retry page fault handling (=
24,25),
> > >> and some retry IRQ handling changes (32).
> > >>
> > >>
> > >> Known issues:
> > >> * won't work with IOMMU enabled, we need to dma_map all pages proper=
ly
> > >> * still working on some race conditions and random bugs
> > >> * performance is not great yet
> > > Still catching up, but I think there's another one for your list:
> > >
> > >  * hmm gpu context preempt vs page fault handling. I've had a short
> > >    discussion about this one with Christian before the holidays, and =
also
> > >    some private chats with Jerome. It's nasty since no easy fix, much=
 less
> > >    a good idea what's the best approach here.
> > =

> > Do you have a pointer to that discussion or any more details?
> =

> Essentially if you're handling an hmm page fault from the gpu, you can
> deadlock by calling dma_fence_wait on a (chain of, possibly) other command
> submissions or compute contexts with dma_fence_wait. Which deadlocks if
> you can't preempt while you have that page fault pending. Two solutions:
> =

> - your hw can (at least for compute ctx) preempt even when a page fault is
>   pending
> =

> - lots of screaming in trying to come up with an alternate solution. They
>   all suck.
> =

> Note that the dma_fence_wait is hard requirement, because we need that for
> mmu notifiers and shrinkers, disallowing that would disable dynamic memory
> management. Which is the current "ttm is self-limited to 50% of system
> memory" limitation Christian is trying to lift. So that's really not
> a restriction we can lift, at least not in upstream where we need to also
> support old style hardware which doesn't have page fault support and
> really has no other option to handle memory management than
> dma_fence_wait.
> =

> Thread was here:
> =

> https://lore.kernel.org/dri-devel/CAKMK7uGgoeF8LmFBwWh5mW1k4xWjuUh3hdSFpV=
H1NBM7K0=3DedA@mail.gmail.com/
> =

> There's a few ways to resolve this (without having preempt-capable
> hardware), but they're all supremely nasty.
> -Daniel
> =


I had a new idea, i wanted to think more about it but have not yet,
anyway here it is. Adding a new callback to dma fence which ask the
question can it dead lock ? Any time a GPU driver has pending page
fault (ie something calling into the mm) it answer yes, otherwise
no. The GPU shrinker would ask the question before waiting on any
dma-fence and back of if it gets yes. Shrinker can still try many
dma buf object for which it does not get a yes on associated fence.

This does not solve the mmu notifier case, for this you would just
invalidate the gem userptr object (with a flag but not releasing the
page refcount) but you would not wait for the GPU (ie no dma fence
wait in that code path anymore). The userptr API never really made
the contract that it will always be in sync with the mm view of the
world so if different page get remapped to same virtual address
while GPU is still working with the old pages it should not be an
issue (it would not be in our usage of userptr for compositor and
what not).

Maybe i overlook something there.

Cheers,
J=C3=A9r=C3=B4me

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
