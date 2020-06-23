Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F9C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 10:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB492072E
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 10:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dgjwJHK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB492072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D85789E19;
	Tue, 23 Jun 2020 10:25:56 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB54589E19
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 10:25:55 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f139so1219640wmf.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=SsR6FQwwmnq/+dS6MRnZY15bS0QmvZtf2wyw/uhcAdo=;
 b=dgjwJHK9bSbAejHh6PiOq0h7HA/rXIxo5Q/d6MWMYUb02YhujbOp/inHjQ/DOxSfYy
 VIMttLA1HaRjQctBYGFZgBLkJpJDqKwgdty7wh0pEG/wv5VR5zF58rdHaVBHrCKL7pRV
 yXEiPZ9nMN420aUrCUt3po38uBiTFFHaKh6d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SsR6FQwwmnq/+dS6MRnZY15bS0QmvZtf2wyw/uhcAdo=;
 b=b2WxNlNm2wVPpwrYAY6/xCA3kdHGlz0I63f0lUfvgw1DEK/LiSQvmRiZyARGHQaJHB
 zUAc/q9qp0YcMjne0/6y6xMUM9rTESRf+tniwi+duoZ0zlRAKTQu5bYluDBwLRV4purc
 RZXfi0GbsR0IB037PSw+y++DYOw0npeYcdi7gx/XiS4A6TMFUUoTUf+DDf+V5/01WCB7
 4EePZ1m7rnw/MN1BeSkMOEtWmjc/p9qOhAmMKnCsuFNrWcJxMX5oey64bqoVQVs/JfAe
 XRcaPlygUl2bnYNsMlEAioNzTRem9KcQmVcT3ZTc4O5kTc2Q3ryLdnuLVPWN7DRSvvNm
 Lrzg==
X-Gm-Message-State: AOAM5325xjgyXjHNFiuQac6x852La8QeZzFQJQablvS/+dK0hfH+/ljw
 QnOBsCmbqswgXWY33DleUhrnGQ==
X-Google-Smtp-Source: ABdhPJyGzUwlpF4bRX63iCyKM4T/+1QRpahJd4/6k5nsAuV68Qx55rSix7LcyRBjs2NEHBm3arqhJQ==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr22885737wmc.86.1592907954397; 
 Tue, 23 Jun 2020 03:25:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id r3sm1951129wrg.70.2020.06.23.03.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 03:25:53 -0700 (PDT)
Date: Tue, 23 Jun 2020 12:25:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH v2 3/8] drm/ttm: Add unampping of the entire device
 address space
Message-ID: <20200623102551.GL20149@phenom.ffwll.local>
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-4-git-send-email-andrey.grodzovsky@amd.com>
 <20200622094502.GB20149@phenom.ffwll.local>
 <3a365581-0f00-32de-6656-77348dcd0ea2@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a365581-0f00-32de-6656-77348dcd0ea2@amd.com>
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
Cc: daniel.vetter@ffwll.ch, michel@daenzer.net, dri-devel@lists.freedesktop.org,
 ppaalanen@gmail.com, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, ckoenig.leichtzumerken@gmail.com,
 alexdeucher@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 23, 2020 at 01:00:02AM -0400, Andrey Grodzovsky wrote:
> =

> On 6/22/20 5:45 AM, Daniel Vetter wrote:
> > On Sun, Jun 21, 2020 at 02:03:03AM -0400, Andrey Grodzovsky wrote:
> > > Helper function to be used to invalidate all BOs CPU mappings
> > > once device is removed.
> > > =

> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > This seems to be missing the code to invalidate all the dma-buf mmaps?
> > =

> > Probably needs more testcases if you're not yet catching this. Or am I
> > missing something, and we're exchanging the the address space also for
> > dma-buf?
> > -Daniel
> =

> =

> IMHO the device address space includes all user clients having a CPU view=
 of
> the BO either from direct mapping though drm file or by=A0 mapping through
> imported BO's FD.

Uh this is all very confusing and very much midlayer-y thanks to ttm.

I think a much better solution would be to have a core gem helper for
this (well not even gem really, this is core drm), which directly uses
drm_device->anon_inode->i_mapping.

Then
a) it clearly matches what drm_prime.c does on export
b) can be reused across all drivers, not just ttm

So much better.

What's more, we could then very easily make the generic
drm_dev_unplug_and_unmap helper I've talked about for the amdgpu patch,
which I think would be really neat&pretty.

Thoughts?
-Daniel

> =

> Andrey
> =

> =

> > =

> > > ---
> > >   drivers/gpu/drm/ttm/ttm_bo.c    | 8 ++++++--
> > >   include/drm/ttm/ttm_bo_driver.h | 7 +++++++
> > >   2 files changed, 13 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_b=
o.c
> > > index c5b516f..926a365 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > > @@ -1750,10 +1750,14 @@ void ttm_bo_unmap_virtual(struct ttm_buffer_o=
bject *bo)
> > >   	ttm_bo_unmap_virtual_locked(bo);
> > >   	ttm_mem_io_unlock(man);
> > >   }
> > > -
> > > -
> > >   EXPORT_SYMBOL(ttm_bo_unmap_virtual);
> > > +void ttm_bo_unmap_virtual_address_space(struct ttm_bo_device *bdev)
> > > +{
> > > +	unmap_mapping_range(bdev->dev_mapping, 0, 0, 1);
> > > +}
> > > +EXPORT_SYMBOL(ttm_bo_unmap_virtual_address_space);
> > > +
> > >   int ttm_bo_wait(struct ttm_buffer_object *bo,
> > >   		bool interruptible, bool no_wait)
> > >   {
> > > diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo=
_driver.h
> > > index c9e0fd0..39ea44f 100644
> > > --- a/include/drm/ttm/ttm_bo_driver.h
> > > +++ b/include/drm/ttm/ttm_bo_driver.h
> > > @@ -601,6 +601,13 @@ int ttm_bo_device_init(struct ttm_bo_device *bde=
v,
> > >   void ttm_bo_unmap_virtual(struct ttm_buffer_object *bo);
> > >   /**
> > > + * ttm_bo_unmap_virtual_address_space
> > > + *
> > > + * @bdev: tear down all the virtual mappings for this device
> > > + */
> > > +void ttm_bo_unmap_virtual_address_space(struct ttm_bo_device *bdev);
> > > +
> > > +/**
> > >    * ttm_bo_unmap_virtual
> > >    *
> > >    * @bo: tear down the virtual mappings for this BO
> > > -- =

> > > 2.7.4
> > > =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
