Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80DAC433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 07:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE80E20674
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 07:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Icl1ZFwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE80E20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA846E9BF;
	Thu,  9 Jul 2020 07:52:22 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4EF6E9B5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 07:52:20 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k6so1291382wrn.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=vXgT6RRirIs9vOBxNCexqhs644sbUqmDyiATQNLIZbg=;
 b=Icl1ZFwM/BdAnsf8QEusvKajGxL6WtxrEVa6WVdvI0tXEJu+yGu+Tl1+T+Lq9+Ltfx
 di7HE1NfD4T165TQhEz0gJRB8zahiuPoX1NT8Y3az+zqO2iQBJbIilY17qjFmJymrNXu
 Qv5/nR4nRnQ9Ht2scGKvCZAsXkwg4z4Ch2M5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vXgT6RRirIs9vOBxNCexqhs644sbUqmDyiATQNLIZbg=;
 b=NS7MpwGDe17pw65ZEQS2iudbbaxoFw75rXdFiRl6dmJU/8H8DEHKRxpslpKacle05t
 DU1yJfFj19vnCGwDfuSSjgrMK+lcgY1jOTldGej8xVmCGvUlQOFR2DhwC5HkFrOS7nL7
 Vcymjmjg7lZiPKesHnW/3UhCG1kVnfTwz3CZGeKPbxdSfHbYVJoiieTDKaJzUrH6OQk1
 VA1uwUg9JYSZEPnBCl/UPNK8hoQKJj/c83TcyWcFFubWwsXw/B5FOQknzKzMPRlBEHUS
 jMyou9Aa5RgsZtzLzOZhNe+CgKrCFS78A0tP7LuvDRYmNNg0/Fxy3dcOmfyIkXpoWj56
 8MXA==
X-Gm-Message-State: AOAM530wfAlKNDRaHjeaKgSbE8oWLD4ZkAE8TbH/aYZFaHAmTGEYA9s0
 6ng8tvPMmPW66LkvmC3z4e69YA==
X-Google-Smtp-Source: ABdhPJzMhhfOQP1SZlv1tfEvaf51xgSXmeFIfxfR93qhGPvCNOG/Wm/4jNQxGEgUdKBWYOlZaCggsw==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr59080956wrw.190.1594281139547; 
 Thu, 09 Jul 2020 00:52:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f16sm3433990wmf.17.2020.07.09.00.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 00:52:18 -0700 (PDT)
Date: Thu, 9 Jul 2020 09:52:16 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [Intel-gfx] [PATCH 01/25] dma-fence: basic lockdep annotations
Message-ID: <20200709075216.GM3278063@phenom.ffwll.local>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-2-daniel.vetter@ffwll.ch>
 <20c0a95b-8367-4f26-d058-1cb265255283@amd.com>
 <CAKMK7uFe7Pz4=UUkkunBms8vUrzwEpWJmScOMLO4KdADM43vnw@mail.gmail.com>
 <CAPj87rNXneE+Vry4aSV11=Qv2mbUsFjCLmNzRmx-Oeqj=u9dyw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPj87rNXneE+Vry4aSV11=Qv2mbUsFjCLmNzRmx-Oeqj=u9dyw@mail.gmail.com>
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 09, 2020 at 08:32:41AM +0100, Daniel Stone wrote:
> Hi,
> =

> On Wed, 8 Jul 2020 at 16:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > On Wed, Jul 8, 2020 at 4:57 PM Christian K=F6nig <christian.koenig@amd.=
com> wrote:
> > > Could we merge this controlled by a separate config option?
> > >
> > > This way we could have the checks upstream without having to fix all =
the
> > > stuff before we do this?
> >
> > Since it's fully opt-in annotations nothing blows up if we don't merge
> > any annotations. So we could start merging the first 3 patches. After
> > that the fun starts ...
> >
> > My rough idea was that first I'd try to tackle display, thus far
> > there's 2 actual issues in drivers:
> > - amdgpu has some dma_resv_lock in commit_tail, plus a kmalloc. I
> > think those should be fairly easy to fix (I'd try a stab at them even)
> > - vmwgfx has a full on locking inversion with dma_resv_lock in
> > commit_tail, and that one is functional. Not just reading something
> > which we can safely assume to be invariant anyway (like the tmz flag
> > for amdgpu, or whatever it was).
> >
> > I've done a pile more annotations patches for other atomic drivers
> > now, so hopefully that flushes out any remaining offenders here. Since
> > some of the annotations are in helper code worst case we might need a
> > dev->mode_config.broken_atomic_commit flag to disable them. At least
> > for now I have 0 plans to merge any of these while there's known
> > unsolved issues. Maybe if some drivers take forever to get fixed we
> > can then apply some duct-tape for the atomic helper annotation patch.
> > Instead of a flag we can also copypasta the atomic_commit_tail hook,
> > leaving the annotations out and adding a huge warning about that.
> =

> How about an opt-in drm_driver DRIVER_DEADLOCK_HAPPY flag? At first
> this could just disable the annotations and nothing else, but as we
> see the annotations gaining real-world testing and maturity, we could
> eventually make it taint the kernel.

You can do that pretty much per-driver, since the annotations are pretty
much per-driver. No annotations in your code, no lockdep splat. Only if
there's some dma_fence_begin/end_signalling() calls is there even the
chance of a problem.

E.g. this round has the i915 patch dropped and *traraaaa* intel-gfx-ci is
happy (or well at least a lot happier, there's some noise in there that's
probably not from my stuff).

So I guess if amd wants this, we could do an DRM_AMDGPU_MOAR_LOCKDEP
Kconfig or similar. I haven't tested, but I think as long as we don't
merge any of the amdgpu specific patches, there's no splat in amdgpu. So
with that I think that's plenty enough opt-in for each driver. The only
problem is a bit shared helper code like atomic helpers and drm scheduler.
There we might need some opt-out (I don't think merging makes sense when
most of the users are still broken).
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
