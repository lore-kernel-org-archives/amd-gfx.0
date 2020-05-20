Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792ECC433E3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 11:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2CA206F1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 11:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gCn4N7N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2CA206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2105B6E139;
	Wed, 20 May 2020 11:03:27 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74106E139
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 11:03:25 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id l11so2728520wru.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=ct4iwtkqSx7W80DKvDt8WvEkiq9KjVIacJ0yr7BAVII=;
 b=gCn4N7N304bnLXil/a63o+C7lXWE4O+dUD5kr4U/QwkYok3WIYIss7MpTiwkIvDJDu
 Yb14/i8NGGvtiwnPpTQWB1oc/MHjv9gyvs+HjkbrsA9GEiFTSWKwCkg07hWlb9e22xpX
 cG1iXAAYqHj6N5FDXXS8FFy8ELfjoCREHTKlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=ct4iwtkqSx7W80DKvDt8WvEkiq9KjVIacJ0yr7BAVII=;
 b=ZPBvI1LUCHX2d4fJkwiOPbTHAGKafsUl0H2bSqkfMfLWuuf1iUGqbwjdsFGpWi5weA
 HzkW9G9P3zbgJhqUPWQhlg1uZkho5+OXGJISU9VHJckH8rHt/Xp3vn1u0aLJD/9AK3ET
 zQdl1jCZKqDWDIWndXH8ah95FAFnb66VnKgoQtH1Ig/VtlagYG5OWQIYZ+l449+sykNE
 MkmevFYzcDKt57YhKY9uo60c7sLOtiPOa2/VDIQqLKHufTrLp7RMFDdNF5J8ltEGUIEm
 dOzuK1vwYvgurEcYBIKnLtmn47v4mBQrqe1wshbZnlOUcTwMLqdyms0VAfg6id55fSz3
 fafg==
X-Gm-Message-State: AOAM5326209P84i5AI5iR8Ds3CA5BwdIHbQvrqujOkmDx62fImjJ7KQu
 zuuGWCIF6Tf+Rkvw+qDE8FK6dw==
X-Google-Smtp-Source: ABdhPJzCd29Xl/wTekkJzbG2hFf7ELniw9c+535re3/QWPV7VzmtBOKv2TwjIms44WqcPc+fmic+SA==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr3672440wrr.222.1589972604221; 
 Wed, 20 May 2020 04:03:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id u65sm2743050wmg.8.2020.05.20.04.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 04:03:23 -0700 (PDT)
Date: Wed, 20 May 2020 13:03:20 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] dma-fence: add might_sleep annotation to _wait()
Message-ID: <20200520110320.GT206103@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, 
 DRI Development <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Oded Gabbay <oded.gabbay@gmail.com>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Daniel Vetter <daniel.vetter@intel.com>
References: <20200519132756.682888-1-daniel.vetter@ffwll.ch>
 <be86b73c-2fb3-a6c0-5a12-004af051210f@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be86b73c-2fb3-a6c0-5a12-004af051210f@amd.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, amd-gfx@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Chris Wilson <chris@chris-wilson.co.uk>, linaro-mm-sig@lists.linaro.org,
 Ben Skeggs <bskeggs@redhat.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@intel.com>, linux-media@vger.kernel.org,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 20, 2020 at 08:54:36AM +0200, Christian K=F6nig wrote:
> Am 19.05.20 um 15:27 schrieb Daniel Vetter:
> > Do it uncontionally, there's a separate peek function with
> > dma_fence_is_signalled() which can be called from atomic context.
> > =

> > v2: Consensus calls for an unconditional might_sleep (Chris,
> > Christian)
> > =

> > Full audit:
> > - dma-fence.h: Uses MAX_SCHEDULE_TIMOUT, good chance this sleeps
> > - dma-resv.c: Timeout always at least 1
> > - st-dma-fence.c: Save to sleep in testcases
> > - amdgpu_cs.c: Both callers are for variants of the wait ioctl
> > - amdgpu_device.c: Two callers in vram recover code, both right next
> >    to mutex_lock.
> > - amdgpu_vm.c: Use in the vm_wait ioctl, next to _reserve/unreserve
> > - remaining functions in amdgpu: All for test_ib implementations for
> >    various engines, caller for that looks all safe (debugfs, driver
> >    load, reset)
> > - etnaviv: another wait ioctl
> > - habanalabs: another wait ioctl
> > - nouveau_fence.c: hardcoded 15*HZ ... glorious
> > - nouveau_gem.c: hardcoded 2*HZ ... so not even super consistent, but
> >    this one does have a WARN_ON :-/ At least this one is only a
> >    fallback path for when kmalloc fails. Maybe this should be put onto
> >    some worker list instead, instead of a work per unamp ...
> > - i915/selftests: Hardecoded HZ / 4 or HZ / 8
> > - i915/gt/selftests: Going up the callchain looks safe looking at
> >    nearby callers
> > - i915/gt/intel_gt_requests.c. Wrapped in a mutex_lock
> > - i915/gem_i915_gem_wait.c: The i915-version which is called instead
> >    for i915 fences already has a might_sleep() annotation, so all good
> > =

> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: "VMware Graphics" <linux-graphics-maintainer@vmware.com>
> > Cc: Oded Gabbay <oded.gabbay@gmail.com>
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Christian K=F6nig <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> =

> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>

intel-gfx-ci approves too, thanks to both of you for reviews, patch merged
to drm-misc-next.
-Daniel

> =

> > ---
> >   drivers/dma-buf/dma-fence.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > =

> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 90edf2b281b0..656e9ac2d028 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -208,6 +208,8 @@ dma_fence_wait_timeout(struct dma_fence *fence, boo=
l intr, signed long timeout)
> >   	if (WARN_ON(timeout < 0))
> >   		return -EINVAL;
> > +	might_sleep();
> > +
> >   	trace_dma_fence_wait_start(fence);
> >   	if (fence->ops->wait)
> >   		ret =3D fence->ops->wait(fence, intr, timeout);
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
