Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09ECC433E1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 12:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68112065C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 12:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y0FSL3jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68112065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFCE6E8D2;
	Fri,  5 Jun 2020 12:41:47 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AFF6E8DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 12:41:46 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id a21so8065509oic.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2020 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b8lHa3VSsS3EH4GstrmtufuSPQnby9wIaLbKSXX2gR4=;
 b=Y0FSL3jop1Ktvp+81IKa884hHcJEOFCxyltl1k0MHEops3eSwWVVNdvKPpCE7Zx9WU
 //QeTiDmbXPc/dqdkmu7fHeWYxTzH103/85ltphoFY/gEm8OQl2oqXW4w61a7KN1Jhgb
 CSloh85q5YYyHCGG2UV5knxi5s6dBfhtE6irk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b8lHa3VSsS3EH4GstrmtufuSPQnby9wIaLbKSXX2gR4=;
 b=sdzujgphbd0bnenXyh8IxhAyss3rN9j6MURMpxkCYFnAxStmFAzJLSnsr/fR7z+hAP
 3PVB1J9WfA5LUNq3/q8dchBAML/WoTw+/lNcuBCV0tvEk6Ln4zO2XThnRNcBvFX2e0W+
 9kkqwfYD8oeBTfuvf1Yx4KLtlPOJVoYfzAumkJ+J/GeLA3hLEIHIiV8YjcSrwg3GiOsJ
 ThOx9c2Wi7B/Z2R02C/jDCq75r116vX2W5bXBUeWFd/5i0CB7rzCgHdhRXhblEXvHC/Z
 SdAueDCcp2d/OBPbza4Gy4wZikFN0d07sTT5AjARNG+9av2MsKFDb1yhoHiyt49ip4Sf
 /FgA==
X-Gm-Message-State: AOAM530KxubBpIz+lLzv6SLYJwNqy6vAg3zjIyz963QHYtWLiu4bjTFT
 WzuTjXTvFPGEIRPw1vv5ioZ9O1gOsA/2IThI7dh8DQ==
X-Google-Smtp-Source: ABdhPJxDBFuxj/jT06KYKDwsSDsZtaJk7DJpn+CTYVJxr0/W+a1EfH/HPafid8DVkUdwYip+bwgoQY+h1NITtsGMh7k=
X-Received: by 2002:aca:ed42:: with SMTP id l63mr1645633oih.101.1591360905783; 
 Fri, 05 Jun 2020 05:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-14-daniel.vetter@ffwll.ch>
 <e0bfd872-5d38-6718-a23d-6b14b3c14f25@amd.com>
In-Reply-To: <e0bfd872-5d38-6718-a23d-6b14b3c14f25@amd.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 5 Jun 2020 14:41:34 +0200
Message-ID: <CAKMK7uG6VN93ZS3Rbi6edvDAMefXJ6CotMx5j916VcUy2nuvqQ@mail.gmail.com>
Subject: Re: [PATCH 13/18] drm/amdgpu/dc: Stop dma_resv_lock inversion in
 commit_tail
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
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
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 5, 2020 at 10:30 AM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Hi Daniel,
>
> On 04/06/2020 10:12, Daniel Vetter wrote:
> [...]
> > @@ -6910,7 +6910,11 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
> >                * explicitly on fences instead
> >                * and in general should be called for
> >                * blocking commit to as per framework helpers
> > +              *
> > +              * Yes, this deadlocks, since you're calling dma_resv_lock in a
> > +              * path that leads to a dma_fence_signal(). Don't do that.
> >                */
> > +#if 0
> >               r = amdgpu_bo_reserve(abo, true);
> >               if (unlikely(r != 0))
> >                       DRM_ERROR("failed to reserve buffer before flip\n");
> > @@ -6920,6 +6924,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
> >               tmz_surface = amdgpu_bo_encrypted(abo);
> >
> >               amdgpu_bo_unreserve(abo);
> > +#endif
> > +             /*
> > +              * this races anyway, so READ_ONCE isn't any better or worse
> > +              * than the stuff above. Except the stuff above can deadlock.
> > +              */
> > +             tiling_flags = READ_ONCE(abo->tiling_flags);
>
> With this change "tmz_surface" won't be initialized properly.
> Adding the following line should fix it:
>
>   tmz_surface = READ_ONCE(abo->flags) & AMDGPU_GEM_CREATE_ENCRYPTED;

So to make this clear, I'm not really proposing to fix up all the
drivers in detail. There's a lot more bugs in all the other drivers,
I'm pretty sure. The driver fixups really are just quick hacks to
illustrate the problem, and at least in some cases, maybe illustrate a
possible solution.

For the real fixes I think this needs driver teams working on this,
and make sure it's all solid. I can help a bit with review (especially
for placing the annotations, e.g. the one I put in cs_submit()
annotates a bit too much), but that's it.

Also I think the patch is from before tmz landed, and I just blindly
rebased over it :-)
-Daniel

>
>
> Pierre-Eric
>
>
> >
> >               fill_dc_plane_info_and_addr(
> >                       dm->adev, new_plane_state, tiling_flags,
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
