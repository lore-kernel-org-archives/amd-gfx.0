Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD2DC63777
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 10:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818652063A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 10:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kRid7tQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818652063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC62D6E90A;
	Wed, 25 Nov 2020 10:40:26 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6F46E8A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 10:40:25 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id s8so1389323wrw.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 02:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=i6Y17vVc/gf6KXnRLS3WFnSkq4w90RYcnXRhY8nymBI=;
 b=kRid7tQ6u4qnk4pn8hr3KitT5787WaCvdHCOjB4MlnBmN3aHIcNLoOeTNSgqfwNRPq
 jWaJFg436ARGc7XirDsyCf4Cx9Hb54kBU06e1yqq3RH9KXBly18Bstmwjw8GF79uYBtg
 jnGF21VZdeGyUG8liN9cbov+Kmm+EzIJ6OPoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=i6Y17vVc/gf6KXnRLS3WFnSkq4w90RYcnXRhY8nymBI=;
 b=AZ3ay4qi/Ci4e/httWpHDLo/X3sPK3eWx+qxXxInmx371QIyohhZKJLbnNjXKbO3BV
 WCGQR/00nhjtjVXfXz3OgiZX32/pikOznFX54WEd/qrbiSFHS/AJXoZgyL7pCWT6vpOg
 X5KmmhUJhQTO+7bEC6sXYOZdLp2YlXIl47VELUZhkuUCZ2GwfTHXOjjcKS510vpUNyK/
 NuuRx5nmKmFmWSjOjtCafePZOE4FkybLrF6GbIuXPTm9pm7yXomkGCqx/OzZN0TG5YAH
 srCvcGvR8goNCQR42wmjpfQOpNShVD6qmzCcWbMmcsU6x4MTm2MK5ekfWQBW40z41cA/
 sRyw==
X-Gm-Message-State: AOAM5318yRnxQQWE3S+LXDQI7T62eoq+NNJ2GzkAGpPyKCMXTl/83Icm
 X6clqt8a20BvMEzDSyZEZCVcS4xOQff5cA==
X-Google-Smtp-Source: ABdhPJwwPHmW+A/fH7ShYMfDMrVf7bWppm95PLL10gt1yyuyv7547ICyWNJ3QC4AaHOzi6XPCVHmQg==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr3246454wrm.44.1606300824123; 
 Wed, 25 Nov 2020 02:40:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id q17sm4934772wro.36.2020.11.25.02.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 02:40:23 -0800 (PST)
Date: Wed, 25 Nov 2020 11:40:21 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: christian.koenig@amd.com
Subject: Re: [PATCH v3 05/12] drm/ttm: Expose ttm_tt_unpopulate for driver use
Message-ID: <20201125104021.GV401619@phenom.ffwll.local>
References: <1605936082-3099-6-git-send-email-andrey.grodzovsky@amd.com>
 <28332cf0-612c-10bd-c64e-fff6e1f18653@gmail.com>
 <320ff94c-78f4-b9a5-4c6f-40f7ce162bd3@amd.com>
 <41b35672-2dd6-13e2-8383-c65279fdb648@gmail.com>
 <e2f4f1dc-2a2a-face-87b2-6d61ed7d3305@amd.com>
 <01280cba-56b8-77c6-b40f-d7e69a5ad4c6@amd.com>
 <0ceca974-80f8-feb3-d5e9-5182f35bb2c4@amd.com>
 <20288c45-270c-3ed7-2ac4-eeb6e5c50776@amd.com>
 <2df98c1a-8ed4-fb87-f8f7-e3962e8d9c52@amd.com>
 <041210e5-e237-b72e-dcbc-17027d057c55@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <041210e5-e237-b72e-dcbc-17027d057c55@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: robh@kernel.org, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, eric@anholt.net,
 ppaalanen@gmail.com, amd-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
 Alexander.Deucher@amd.com, yuq825@gmail.com, Harry.Wentland@amd.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 24, 2020 at 05:44:07PM +0100, Christian K=F6nig wrote:
> Am 24.11.20 um 17:22 schrieb Andrey Grodzovsky:
> > =

> > On 11/24/20 2:41 AM, Christian K=F6nig wrote:
> > > Am 23.11.20 um 22:08 schrieb Andrey Grodzovsky:
> > > > =

> > > > On 11/23/20 3:41 PM, Christian K=F6nig wrote:
> > > > > Am 23.11.20 um 21:38 schrieb Andrey Grodzovsky:
> > > > > > =

> > > > > > On 11/23/20 3:20 PM, Christian K=F6nig wrote:
> > > > > > > Am 23.11.20 um 21:05 schrieb Andrey Grodzovsky:
> > > > > > > > =

> > > > > > > > On 11/25/20 5:42 AM, Christian K=F6nig wrote:
> > > > > > > > > Am 21.11.20 um 06:21 schrieb Andrey Grodzovsky:
> > > > > > > > > > It's needed to drop iommu backed pages on device unplug
> > > > > > > > > > before device's IOMMU group is released.
> > > > > > > > > =

> > > > > > > > > It would be cleaner if we could do the whole
> > > > > > > > > handling in TTM. I also need to double check
> > > > > > > > > what you are doing with this function.
> > > > > > > > > =

> > > > > > > > > Christian.
> > > > > > > > =

> > > > > > > > =

> > > > > > > > Check patch "drm/amdgpu: Register IOMMU topology
> > > > > > > > notifier per device." to see
> > > > > > > > how i use it. I don't see why this should go
> > > > > > > > into TTM mid-layer - the stuff I do inside
> > > > > > > > is vendor specific and also I don't think TTM is
> > > > > > > > explicitly aware of IOMMU ?
> > > > > > > > Do you mean you prefer the IOMMU notifier to be
> > > > > > > > registered from within TTM
> > > > > > > > and then use a hook to call into vendor specific handler ?
> > > > > > > =

> > > > > > > No, that is really vendor specific.
> > > > > > > =

> > > > > > > What I meant is to have a function like
> > > > > > > ttm_resource_manager_evict_all() which you only need
> > > > > > > to call and all tt objects are unpopulated.
> > > > > > =

> > > > > > =

> > > > > > So instead of this BO list i create and later iterate in
> > > > > > amdgpu from the IOMMU patch you just want to do it
> > > > > > within
> > > > > > TTM with a single function ? Makes much more sense.
> > > > > =

> > > > > Yes, exactly.
> > > > > =

> > > > > The list_empty() checks we have in TTM for the LRU are
> > > > > actually not the best idea, we should now check the
> > > > > pin_count instead. This way we could also have a list of the
> > > > > pinned BOs in TTM.
> > > > =

> > > > =

> > > > So from my IOMMU topology handler I will iterate the TTM LRU for
> > > > the unpinned BOs and this new function for the pinned ones=A0 ?
> > > > It's probably a good idea to combine both iterations into this
> > > > new function to cover all the BOs allocated on the device.
> > > =

> > > Yes, that's what I had in my mind as well.
> > > =

> > > > =

> > > > =

> > > > > =

> > > > > BTW: Have you thought about what happens when we unpopulate
> > > > > a BO while we still try to use a kernel mapping for it? That
> > > > > could have unforeseen consequences.
> > > > =

> > > > =

> > > > Are you asking what happens to kmap or vmap style mapped CPU
> > > > accesses once we drop all the DMA backing pages for a particular
> > > > BO ? Because for user mappings
> > > > (mmap) we took care of this with dummy page reroute but indeed
> > > > nothing was done for in kernel CPU mappings.
> > > =

> > > Yes exactly that.
> > > =

> > > In other words what happens if we free the ring buffer while the
> > > kernel still writes to it?
> > > =

> > > Christian.
> > =

> > =

> > While we can't control user application accesses to the mapped buffers
> > explicitly and hence we use page fault rerouting
> > I am thinking that in this=A0 case we may be able to sprinkle
> > drm_dev_enter/exit in any such sensitive place were we might
> > CPU access a DMA buffer from the kernel ?
> =

> Yes, I fear we are going to need that.

Uh ... problem is that dma_buf_vmap are usually permanent things. Maybe we
could stuff this into begin/end_cpu_access (but only for the kernel, so a
bit tricky)?

btw the other issue with dma-buf (and even worse with dma_fence) is
refcounting of the underlying drm_device. I'd expect that all your
callbacks go boom if the dma_buf outlives your drm_device. That part isn't
yet solved in your series here.
-Daniel

> =

> > Things like CPU page table updates, ring buffer accesses and FW memcpy ?
> > Is there other places ?
> =

> Puh, good question. I have no idea.
> =

> > Another point is that at this point the driver shouldn't access any such
> > buffers as we are at the process finishing the device.
> > AFAIK there is no page fault mechanism for kernel mappings so I don't
> > think there is anything else to do ?
> =

> Well there is a page fault handler for kernel mappings, but that one just
> prints the stack trace into the system log and calls BUG(); :)
> =

> Long story short we need to avoid any access to released pages after unpl=
ug.
> No matter if it's from the kernel or userspace.
> =

> Regards,
> Christian.
> =

> > =

> > Andrey
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
