Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13334C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BB223A5E
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BB223A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833648989E;
	Thu, 14 Jan 2021 17:25:24 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A978989E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 17:25:24 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id x13so6683540oic.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rm3jpBstCGMpbLC43K8W+P5zcBUqR4REX7i8OSCoW5o=;
 b=c95LC5bTRbMj0OfRVn1o3pg6D7DtEWWMaxtQLiqVlP+uD+g1JUSSbjD2Ow6l6Pv+0T
 qf682B7ACy0ebP9bu+POaaU3mFMzkJUCIJs14F5yl62d8/rDvwccDe3uNz8/RxdHoL21
 eU1JKhFBLR8lwxRLYQaOaS2yu95lkSH/3l3cD5ZWjWWqQRw49F3Ja/jdW4m4D015frH+
 Z14v88MauAw6RgOCGwZHO71LnUrrSqO1zrBpmh4U2F1KEX8fRhZbXwHTos3p9Nfox+os
 riyXxRvmkBH5Xc8jJ0FrHTAHco5InXojkB4SlNdWpIl9cpILgdCK5Ri2gaCOuj8h9JXh
 gVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rm3jpBstCGMpbLC43K8W+P5zcBUqR4REX7i8OSCoW5o=;
 b=DyqGvRDcZgjZRlbYCDpPAilCgoRSmMzDNtIeHVVSaYYize10dgXU20HKgpR28gc5Uo
 ybOs5H3swu00/IrZ5f+d9riBSi1AAuuTcgb7D4usRDZtjSIYSAQf+Nf/oG9T9VSDhEpn
 tN1Pj/QDivUJAfJnfWwFxQ1R5poKIF6ZWelZiA7L9/GbVqqLAmx6brl5NcZGZc51YyWS
 6mHOy5T9sfjTjr4bW9VYA/2603V1DXryKcpzCUqjO9xnnfW1L10HIHC7ypFcEXv1LZ35
 yVTAXcafpywYm5vJOOh1c8h64U0GBPpowGPYWpSjhy7RBByqu5uQyT8lJFnlgFGg5Pf6
 5vQQ==
X-Gm-Message-State: AOAM532b0Ne76XELZsTtnnZlD7wUeRpDVaaNE7tPfm+vOBGlm59EynXz
 1CsKMA+1wn31tlHIKs98co/aRWBYw3O4DOs4wHo=
X-Google-Smtp-Source: ABdhPJzyOEkTDp7aL2Pevvrl5elUNQzwH6XOYEkFUpw/Jjxk7TkQv5GD3mqvSPeEF9sVkvvWwx4Ekbqsjstjc+Lxjv0=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3157839oii.120.1610645123529; 
 Thu, 14 Jan 2021 09:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20210114133729.24169-1-horace.chen@amd.com>
 <20210114133729.24169-2-horace.chen@amd.com>
 <c078b4be-c0ae-9baf-2565-ec6552611461@amd.com>
In-Reply-To: <c078b4be-c0ae-9baf-2565-ec6552611461@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jan 2021 12:25:12 -0500
Message-ID: <CADnq5_PeyQf5jz2W2Rgrp2jfpRSc+_LjHNtNL_YtyOVjJxYGww@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: set job guilty if reset skipped
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Horace Chen <horace.chen@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 14, 2021 at 9:48 AM Andrey Grodzovsky
<Andrey.Grodzovsky@amd.com> wrote:
>
> Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>
> Andrey
>
> On 1/14/21 8:37 AM, Horace Chen wrote:
> > If 2 jobs on 2 different ring timed out the at a very
> > short period, the reset for second job will be skipped
> > because the reset is already in progress.
> >
> > But it doesn't mean the second job is not guilty since it also
> > timed out and can be a bad job. So before skipped out from the
> > reset, we need to increase karma for this job too.
> >
> > Signed-off-by: Horace Chen <horace.chen@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index a28e138ac72c..d1112e29c8b4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4572,6 +4572,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> >               if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
> >                       DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
> >                               job ? job->base.id : -1, hive->hive_id);
> > +                     if(job)

space between the if and (.  E.g.,

if (job)

> > +                             drm_sched_increase_karma(&job->base);
> >                       amdgpu_put_xgmi_hive(hive);
> >                       return 0;
> >               }
> > @@ -4596,6 +4598,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> >                       dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> >                                       job ? job->base.id : -1);
> >                       r = 0;
> > +                     if(job)

Same here.

Alex

> > +                             drm_sched_increase_karma(&job->base);
> >                       goto skip_recovery;
> >               }
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
