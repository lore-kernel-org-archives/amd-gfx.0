Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8D6C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 07:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3617920707
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 07:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A5HUcVec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3617920707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6ABB6EC1B;
	Fri, 19 Jun 2020 07:22:22 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54A26EC22
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 07:22:21 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id b8so7662050oic.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DqEsfHHZMDjVjBSRzofGz02dqQOVqzrxROmLfkgGgfU=;
 b=A5HUcVec8RYu1bZm00Qb0nJy7vZOa/JILGkLgAuTZ8La1+bbfcPUqNdntXVxb3kR5C
 Pun8MPh8/elm4LjPbSFd8pHjYzxyAljbGO8JxS8ebVDq1mtIlkNyW1F1f57hRQ1lpcHC
 J28+KzCYOCc4U1wxOh8Jq++Bii/KSrEjFghhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DqEsfHHZMDjVjBSRzofGz02dqQOVqzrxROmLfkgGgfU=;
 b=a8YLOENBC8yXTU6vs6St/7tYN+QvSYT9B0VYDKAVI4K0B5GcBeYVHp25fVFQJQP6UC
 eL3CE0EevZcjrRL6KdTnLZFzpdCzo25OW/TyuEJjksI0/9sdbhbhfYSNgk4Qp52hy7K2
 asXLAoXH74SVfohiWO9TR6PSbZtvuOGCoogtuLWX83SAVLyDYfvQDDCLVQyd0qWmJibT
 sTAAKXNcGiaNSjGVBwmB0XbSyNewU5GIL4p1e7m+16VKqRLifAyqerFBNx0YwRxjpk8z
 JraImntAS+jiiRTw0C9nk/ILI+Zib7TKxdDaCmRn1k3wwDLcIGAYYBxfjZqqOi3Nzre9
 tANA==
X-Gm-Message-State: AOAM533FWDct8nIMVV+CJOYCSfUyILhXxqWYA7TrlGzLTNMl0MA+q03B
 4q02X55R/1q8ByXEBsVbyzuQqVhINZIyCWuvoVG4YA==
X-Google-Smtp-Source: ABdhPJzUUv7A3YRtNgpCeUlEiMcyk3Jq4GEcOu2c5HObmsMsz8k+i9bAqj56TkqNTZ0MhscUp+R1cXMiit1pfYTZUok=
X-Received: by 2002:aca:ad97:: with SMTP id w145mr2091861oie.128.1592551341034; 
 Fri, 19 Jun 2020 00:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local> <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca> <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca>
In-Reply-To: <20200618172338.GM6578@ziepe.ca>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 19 Jun 2020 09:22:09 +0200
Message-ID: <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 19, 2020 at 8:58 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jun 18, 2020 at 05:00:51PM +0200, Daniel Vetter wrote:
> > On Wed, Jun 17, 2020 at 12:28:35PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 17, 2020 at 08:48:50AM +0200, Daniel Vetter wrote:
> > >
> > > > Now my understanding for rdma is that if you don't have hw page fault
> > > > support,
> > >
> > > The RDMA ODP feature is restartable HW page faulting just like nouveau
> > > has. The classical MR feature doesn't have this. Only mlx5 HW supports
> > > ODP today.
> > >
> > > > It's only gpus (I think) which are in this awkward in-between spot
> > > > where dynamic memory management really is much wanted, but the hw
> > > > kinda sucks. Aside, about 10+ years ago we had a similar problem with
> > > > gpu hw, but for security: Many gpu didn't have any kinds of page
> > > > tables to isolate different clients from each another. drivers/gpu
> > > > fixed this by parsing&validating what userspace submitted to make sure
> > > > it's only every accessing its own buffers. Most gpus have become
> > > > reasonable nowadays and do have proper per-process pagetables (gpu
> > > > process, not the pasid stuff), but even today there's still some of
> > > > the old model left in some of the smallest SoC.
> > >
> > > But I still don't understand why a dma fence is needed inside the GPU
> > > driver itself in the notifier.
> > >
> > > Surely the GPU driver can block and release the notifier directly from
> > > its own command processing channel?
> > >
> > > Why does this fence and all it entails need to leak out across
> > > drivers?
> >
> > So 10 years ago we had this world of every gpu driver is its own bucket,
> > nothing leaks out to the world. But the world had a different idea how
> > gpus where supposed to work, with stuff like:
>
> Sure, I understand DMA fence, but why does a *notifier* need it?
>
> The job of the notifier is to guarentee that the device it is
> connected to is not doing DMA before it returns.
>
> That just means you need to prove that device is done with the buffer.
>
> As I've understood GPU that means you need to show that the commands
> associated with the buffer have completed. This is all local stuff
> within the driver, right? Why use fence (other than it already exists)

Because that's the end-of-dma thing. And it's cross-driver for the
above reasons, e.g.
- device A renders some stuff. Userspace gets dma_fence A out of that
(well sync_file or one of the other uapi interfaces, but you get the
idea)
- userspace (across process or just different driver) issues more
rendering for device B, which depends upon the rendering done on
device A. So dma_fence A is an dependency and will block this dma
operation. Userspace (and the kernel) gets dma_fence B out of this
- because unfortunate reasons, the same rendering on device B also
needs a userptr buffer, which means that dma_fence B is also the one
that the mmu_range_notifier needs to wait on before it can tell core
mm that it can go ahead and release those pages
- unhappiness ensues, because now the mmu notifier from device B can
get hung up on the dma operation device A is doing

If you want to avoid this either a) have less shitty hw (not an
option, gpus are gpus, it is slowly getting better though) or b) force
userspace to stall before handing over to next device (about as
uncool) or c) just pin all the memory always, who cares (also rather
unpopular, gpus tend to use all the memory they can get).

I guess the thing with gpus is that dma operations aren't like
read/writes for pretty much everything else, but essentially compute
contexts (usually implemented as ringbuffers where you stream stuff
into) with cross everything dependencies. This even holds within a
single gpu, since pretty much all modern gpus have multiple different
engines special on different things. And yup that's directly exposed
to userspace, for vulkan and other low-level gpu apis even directly to
applications. So dma operation for gpu isn't just "done when the
read/write finishes", but pulls in an entire chain of dependencies and
ordering that needs to happen before it can even start.

-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
