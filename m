Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212ADC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 16:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE55723B31
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 16:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE55723B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3286E027;
	Thu, 14 Jan 2021 16:51:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF746E027
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610643094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81k+ap4vU/W71Kd/MpXEpnFZ0rgYeGS0U7BvC24vboE=;
 b=VXdWkrNpAVYJ0yNMktMHyopS3uiciynB/toCd/mQG4zAnLcWYJPoXCZ9Frk2xu5ZmesGYM
 Aejq9sv8v9D6Vv+2gPYULt/Cz7MXI+wD54E900aDb8Hwvy5TE0k4FCWubx7se30v5nFh0z
 Qf728k1A0KBMZPiXglkfLm83OLvJQOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-yszHMnM9O6aqdP4Dphqf-Q-1; Thu, 14 Jan 2021 11:51:32 -0500
X-MC-Unique: yszHMnM9O6aqdP4Dphqf-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AD2457247;
 Thu, 14 Jan 2021 16:51:30 +0000 (UTC)
Received: from redhat.com (ovpn-115-63.rdu2.redhat.com [10.10.115.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAEE35C67A;
 Thu, 14 Jan 2021 16:51:29 +0000 (UTC)
Date: Thu, 14 Jan 2021 11:51:28 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: HMM fence (was Re: [PATCH 00/35] Add HMM-based SVM memory
 manager to KFD)
Message-ID: <20210114165128.GB10147@redhat.com>
References: <20210107030127.20393-1-Felix.Kuehling@amd.com>
 <X/bTFWL3HYVc8LEF@phenom.ffwll.local>
 <6daf9ebc-507e-6e83-04dd-d7c5fc6998d6@amd.com>
 <X/hux3eX8Ywf61h7@phenom.ffwll.local>
 <20210113165646.GB521755@redhat.com>
 <c1ecb381-20cc-850b-4491-99c6b413f7df@gmail.com>
 <CAKMK7uHXRwE7tgHM0K921pEyrpZWz7G5q_OcrS4tBPAN-f3k-g@mail.gmail.com>
 <5267b98d-05f4-9e8a-e424-b226f72ce066@amd.com>
MIME-Version: 1.0
In-Reply-To: <5267b98d-05f4-9e8a-e424-b226f72ce066@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Alex Sierra <alex.sierra@amd.com>, "Yang, Philip" <philip.yang@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 14, 2021 at 02:37:36PM +0100, Christian K=C3=B6nig wrote:
> Am 14.01.21 um 12:52 schrieb Daniel Vetter:
> > [SNIP]
> > > > I had a new idea, i wanted to think more about it but have not yet,
> > > > anyway here it is. Adding a new callback to dma fence which ask the
> > > > question can it dead lock ? Any time a GPU driver has pending page
> > > > fault (ie something calling into the mm) it answer yes, otherwise
> > > > no. The GPU shrinker would ask the question before waiting on any
> > > > dma-fence and back of if it gets yes. Shrinker can still try many
> > > > dma buf object for which it does not get a yes on associated fence.
> > > > =

> > > > This does not solve the mmu notifier case, for this you would just
> > > > invalidate the gem userptr object (with a flag but not releasing the
> > > > page refcount) but you would not wait for the GPU (ie no dma fence
> > > > wait in that code path anymore). The userptr API never really made
> > > > the contract that it will always be in sync with the mm view of the
> > > > world so if different page get remapped to same virtual address
> > > > while GPU is still working with the old pages it should not be an
> > > > issue (it would not be in our usage of userptr for compositor and
> > > > what not).
> > > The current working idea in my mind goes into a similar direction.
> > > =

> > > But instead of a callback I'm adding a complete new class of HMM fenc=
es.
> > > =

> > > Waiting in the MMU notfier, scheduler, TTM etc etc is only allowed for
> > > the dma_fences and HMM fences are ignored in container objects.
> > > =

> > > When you handle an implicit or explicit synchronization request from
> > > userspace you need to block for HMM fences to complete before taking =
any
> > > resource locks.
> > Isnt' that what I call gang scheduling? I.e. you either run in HMM
> > mode, or in legacy fencing mode (whether implicit or explicit doesn't
> > really matter I think). By forcing that split we avoid the problem,
> > but it means occasionally full stalls on mixed workloads.
> > =

> > But that's not what Jerome wants (afaiui at least), I think his idea
> > is to track the reverse dependencies of all the fences floating
> > around, and then skip evicting an object if you have to wait for any
> > fence that is problematic for the current calling context. And I don't
> > think that's very feasible in practice.
> > =

> > So what kind of hmm fences do you have in mind here?
> =

> It's a bit more relaxed than your gang schedule.
> =

> See the requirements are as follow:
> =

> 1. dma_fences never depend on hmm_fences.
> 2. hmm_fences can never preempt dma_fences.
> 3. dma_fences must be able to preempt hmm_fences or we always reserve eno=
ugh
> hardware resources (CUs) to guarantee forward progress of dma_fences.
> =

> Critical sections are MMU notifiers, page faults, GPU schedulers and
> dma_reservation object locks.
> =

> 4. It is valid to wait for a dma_fences in critical sections.
> 5. It is not valid to wait for hmm_fences in critical sections.
> =

> Fence creation either happens during command submission or by adding
> something like a barrier or signal command to your userspace queue.
> =

> 6. If we have an hmm_fence as implicit or explicit dependency for creatin=
g a
> dma_fence we must wait for that before taking any locks or reserving
> resources.
> 7. If we have a dma_fence as implicit or explicit dependency for creating=
 an
> hmm_fence we can wait later on. So busy waiting or special WAIT hardware
> commands are valid.
> =

> This prevents hard cuts, e.g. can mix hmm_fences and dma_fences at the sa=
me
> time on the hardware.
> =

> In other words we can have a high priority gfx queue running jobs based on
> dma_fences and a low priority compute queue running jobs based on
> hmm_fences.
> =

> Only when we switch from hmm_fence to dma_fence we need to block the
> submission until all the necessary resources (both memory as well as CUs)
> are available.
> =

> This is somewhat an extension to your gang submit idea.

What is hmm_fence ? You should not have fence with hmm at all.
So i am kind of scare now.

Cheers,
J=C3=A9r=C3=B4me

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
