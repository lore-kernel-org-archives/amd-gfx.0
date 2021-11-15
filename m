Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07EEC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 14:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB2761BE1
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 14:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBB2761BE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4F06E056;
	Mon, 15 Nov 2021 14:43:34 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A68906E056
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 14:43:32 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 a23-20020a9d4717000000b0056c15d6d0caso20716193otf.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 06:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nc56XFkM0O1Qcwe9XSQJS+ByPSVDOEr1hRiKSyIPnXA=;
 b=OgqtYCkcGz98ie7qdoAUAZCsJxDZCytQIX5frsteuJ5y4zERY+SpEnfM55It382LSi
 vCelpbZZjEPxF2ZbssFSwBhJ41AVY6ZhEG7EWKPpCBbXFZHJfBeM+5wGbfrv1YrdFCxb
 ksyOqGweNoYqb5+YC1TlRR/O1qEP5kT9NCVvHfAjim9by1nhkrEXXVmsfiT2DHG+yeoU
 knAN7ktiyp1RwAdADs0F9bHrxWRmxu1AR5bbrI9Ef59pCok6J+NK8dD2CyUEStOq8oBM
 /H6ufq4RdR5hhR8NyYMJ+HgmVN8ZUTXrwytcIMYiwxgX7VLkNJ2b87+8+5slbJBrHU8s
 vO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nc56XFkM0O1Qcwe9XSQJS+ByPSVDOEr1hRiKSyIPnXA=;
 b=1O+kzuYLhxUxVE62O+iCrJeoJfUXIEvtHapJoBnG3lLE4xqOOafLMJho6XwDqEp7zL
 g4RVWA8LIyjwvBktVZ0UBaPsfGLC7YSw46Hc+uVg2GGf/7bZ3dU6OhTfn12yhIrs7vEi
 nX0CFm7zZb+ogaIU/9IX9+dFZjNPr/2uJfJCtN+wjY+tKk4+907A/h3CLd9FAoo6viGt
 HhbExzgxMa4l7S2K4bBRDW2PLpNcYVrMf9nevHIvfLQiuI73g13zdZeIOFkWNa4EUJQ9
 l2Q+1I2Nqe91iyarIW5ITocJlc+21IjxmggBVFbr7dnd/qiSGLdwdexNBcnh6yXnwAdh
 b/wQ==
X-Gm-Message-State: AOAM533eQ7rpYmCzUkI6iw3v4X4ca/GbrxXayAZoapYOPdoYgcM+N0ml
 Dv6WXGtwB11nclh/d4LHopMLmqcCyL2M8/QZwk8=
X-Google-Smtp-Source: ABdhPJyYRj5OQlafX/AWp9kgr4k/kLZP8V1N7CWexBegvlauBMO5jawHc3hn/O7XqYubI3vdGCcydRtMb7bysWB8y7g=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr32391256ota.200.1636987411908; 
 Mon, 15 Nov 2021 06:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20211112162530.149709-1-alexander.deucher@amd.com>
 <a3c306e5-2672-dd33-fb18-ff86619d617c@amd.com>
In-Reply-To: <a3c306e5-2672-dd33-fb18-ff86619d617c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Nov 2021 09:43:20 -0500
Message-ID: <CADnq5_N4v1NSUpu1i_HVq3PB4spM6Bjv6ubWGFJW5i5SRf2o4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset the asic in suspend (v2)
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 15, 2021 at 2:50 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 11/12/2021 9:55 PM, Alex Deucher wrote:
> > If the platform suspend happens to fail and the power rail
> > is not turned off, the GPU will be in an unknown state on
> > resume, so reset the asic so that it will be in a known
> > good state on resume even if the platform suspend failed.
> >
>
> Any more background info on the issue? Is there a need to trigger BACO
> or D3cold entry similar to how it's done for runtime suspend?

Basically something like the following, user requests S3, drivers
start to do their suspend thing, but then something interrupts it
(e.g., user plugs/unplugs a usb device or S3 gets interrupted for
something).  At that point, the power rail has not been turned off.
The kernel then starts calling the resume functions for each device
because the suspend was aborted.  However, since the power rail was
not turned off, the GPU is still initialized so the driver can't
properly re-init it without a reset.

Alex


>
> Thanks,
> Lijo
>
> > v2: handle s0ix
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 1db76429a673..b4591f6e82dd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2165,7 +2165,10 @@ static int amdgpu_pmops_suspend(struct device *dev)
> >       adev->in_s3 = true;
> >       r = amdgpu_device_suspend(drm_dev, true);
> >       adev->in_s3 = false;
> > -
> > +     if (r)
> > +             return r;
> > +     if (!adev->in_s0ix)
> > +             r = amdgpu_asic_reset(adev);
> >       return r;
> >   }
> >
> >
