Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92BAC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 19:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B54411B370;
	Tue, 19 Jul 2022 19:49:43 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61CB11B7CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 19:49:41 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id oy13so29110089ejb.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 12:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kGaYb8GJ+5uBruxZ07JZRxMtKvYjxNNMUtRhRScm2e4=;
 b=DnakFoXBnTy6Hwo/jWH6+xw0mCPX4Bv89A8fsu+1f+k2TszwnONZxmmwkthYfo4Wiw
 0pGaMMc5XURJ59DgAmyiHOLh57eclZXV0P7aMolV2O+4V8/zPzyw79zYn3L+0q2lYUx7
 0RV5LDulDZJfi+/Sg+jGEDbLL9kpDDK2NbTSi++P7OAOmxu8Yq3khHTXvnpizLTe9SYg
 NZGpXgFfzqMjABF9o0wf+oRL1mTy3IMxR8c3ItHOITw5p6TjfjLNDxrllaotUtiTA/aB
 3piHf/iqlJLdpx8RmFlzTjqO0lKLCd5/wzwVoy1xyzhk78iVpu9Pdku11lUWOA0hw1mn
 ZWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kGaYb8GJ+5uBruxZ07JZRxMtKvYjxNNMUtRhRScm2e4=;
 b=UAUKu4BpkUgrjDJY8n3jmNhcLCgX1mHDQUaPoixybP2PrtVVkY0iCmN20YeU2yd4Cv
 hsrStAf1Yc/X6qhmvQ8WvAND3VvKkyyDfnYHX8g+ovyT9FJjE6eKJXKXIhrTs9wJKi6b
 ii3u7VnnmrQ8K+h98t2zRHA6flBAT8sXmLQXKrk15gcbtCq5dS265kLH1ATnMTs4Sly+
 qPdZB58nZ/V0EF+JJtH1Qq/jobKFg0my6MfXJd0xpXmmZyoiKl3ePT0Vvvmc3FWM3OOt
 S5olwESQyrUVl0OuIewmJDQBlEm0emk2sjd0CtCcxmjmjhNMrxwRuATJHbY9bP+ZqY+9
 OuWw==
X-Gm-Message-State: AJIora85nBBv5233aKRB3K19kn3mfXFZpLHIfjmnxV9i3XS9ii3dIJ5P
 8n+Lg1fB4r8cwOl/Ib6Y+t4GbHKwrsjZRqCs3As=
X-Google-Smtp-Source: AGRyM1sDpf7TAw4N91inZAWsr9O6PuZsaEN3MobPbWzK6tAkzqOxS25zCxiAFZBTGMYSkpWbgabTVJZtRuxgDxsvy+c=
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id
 w2-20020a170907270200b0072b307b98e6mr32616184ejk.658.1658260180358; Tue, 19
 Jul 2022 12:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220708015346.3027-1-xinhui.pan@amd.com>
 <CAHbf0-Fo4qE1RCaH2uHHW1YTkHb-yFCMnix0rjsq+K1RCMQxSg@mail.gmail.com>
In-Reply-To: <CAHbf0-Fo4qE1RCaH2uHHW1YTkHb-yFCMnix0rjsq+K1RCMQxSg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Jul 2022 15:49:28 -0400
Message-ID: <CADnq5_P2sX4imt2buEF6GDP9qvRWF4cjKQ7060nMHLdhC1bxVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove one duplicated ef removal
To: Mike Lothian <mike@fireburn.co.uk>
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 19, 2022 at 4:32 AM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> With this patch applied on Linus's tree 5.18-rc7 I get the following warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:1367:20: warning:
> unused variable 'pd' [-Wunused-variable]
>        struct amdgpu_bo *pd = vm->root.bo;
>                          ^
> 1 warning generated.
>
> It does fix the nullpointer though :D

I fixed that up when I pulled the patch in.

Alex

>
>
> On Fri, 8 Jul 2022 at 02:55, xinhui pan <xinhui.pan@amd.com> wrote:
> >
> > That has been done in BO release notify.
> >
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 0f9811d02f61..49536fa8d269 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -1583,11 +1583,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
> >         if (!process_info)
> >                 return;
> >
> > -       /* Release eviction fence from PD */
> > -       amdgpu_bo_reserve(pd, false);
> > -       amdgpu_bo_fence(pd, NULL, false);
> > -       amdgpu_bo_unreserve(pd);
> > -
> >         /* Update process info */
> >         mutex_lock(&process_info->lock);
> >         process_info->n_vms--;
> > --
> > 2.34.1
> >
