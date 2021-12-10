Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DF1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C3D10E4D8;
	Fri, 10 Dec 2021 23:09:05 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3565B10E4D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:09:05 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 n17-20020a9d64d1000000b00579cf677301so11153146otl.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+Pb+wJE7CoVFzbzeodnXty4JJgB49/AI9Pxo+oz14xs=;
 b=YBNSDzRpap4y6CWiUOlvvpYv3szMqfSiV7oHFRurFybiUn7hqCZG2QIeE40bQ976+N
 hg6fRKINvguccPU5s1ilE0myjfPg1bhwfbFD9l59Yqejc4NajsPlzdLlol4nw6kaeDuC
 9w2hyn5RBcZK7MxsnDAVe2EEVvrXaRs0cXKQH52yO6cJ2BKqq6Is1NTHv6R96JUeuG6N
 MWSBQvykZEdDcuswYCfw5wain2dE4+SJmsl1BVouKVUGzL+HPN5B5d1oz4c9PXWNFtQc
 X674VQS4sHXvP+kIyI5Ht9gtReAuPM4lS7dBChr1+Wuy7R22k6tOk6CxEZ+b9UXvbgi7
 RCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Pb+wJE7CoVFzbzeodnXty4JJgB49/AI9Pxo+oz14xs=;
 b=2mUIk6YwyX9EOnp4Q8DVh4DdTg9BwsRzSb9Quo6nyceeNJn8CNgzgBkK6Ysi1KofJL
 Pi0drbPQMM+QUUcyFKLyhgPSdWNBcaq1DvaUxqBB65ZhCYNlfFwAlXEW1v9LKbqRkmdR
 Uor76CqlyJX7m4uCekq89iqzTMpu/g6x7mqlz7Il7z5VoP3OYPfBUwgmlc1eUkmbaJj4
 6AO/ukX3Z/9ETdbe4Dvc2OYSO/WlqlnbXIXKgQQXRxNJ/CpSX6VnLNW/eXVK7MYrSn1T
 MgMAA1ELQ9jFvfMM69sNttxulvuu5GCMu80MheXgWghiULQscVxJxhNqOofzaHkI8rpY
 ploA==
X-Gm-Message-State: AOAM533h13W00qAUaFFkXcgRmbwe4vOGyOWXCsAthyH/ZHFiXUtS/8+D
 ZtJ+Pj5fgmlNjORW3pq88kFSv39ES1dBUqYxrZQ=
X-Google-Smtp-Source: ABdhPJwJOS7M/dSMaWGBL0vFx0VwKrUyNGBT69b+D4Bmt7TGn5ZFLxdL+5fzYc+5M6jAf7XEsQpKfha98M+weOXwUFQ=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr13724595otn.299.1639177744408; 
 Fri, 10 Dec 2021 15:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20211209154722.4018279-1-isabbasso@riseup.net>
 <20211209154722.4018279-4-isabbasso@riseup.net>
 <c95e1e9f-ecea-ab74-b7d5-7a05f1b1c960@amd.com>
In-Reply-To: <c95e1e9f-ecea-ab74-b7d5-7a05f1b1c960@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Dec 2021 18:08:53 -0500
Message-ID: <CADnq5_P9Rns6Mjdh8KYBQV1unQ=BkmWasfh1U1p9ywLWNUBWBw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] drm/amdgpu: remove unnecessary variables
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Isabella Basso <isabbasso@riseup.net>,
 "Wentland, Harry" <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Dec 9, 2021 at 12:03 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2021-12-09 um 10:47 a.m. schrieb Isabella Basso:
> > This fixes the warnings below, and also drops the display_count
> > variable, as it's unused.
> >
> >  In function 'svm_range_map_to_gpu':
> >  warning: variable 'bo_va' set but not used [-Wunused-but-set-variable]
> >  1172 |         struct amdgpu_bo_va bo_va;
> >       |                             ^~~~~
> >  ...
> >  In function 'dcn201_update_clocks':
> >  warning: variable 'enter_display_off' set but not used [-Wunused-but-set-variable]
> >  132 |         bool enter_display_off = false;
> >      |              ^~~~~~~~~~~~~~~~~
> >
> > Changes since v1:
> > - As suggested by Rodrigo Siqueira:
> >   1. Drop display_count variable.
> > - As suggested by Felix Kuehling:
> >   1. Remove block surrounding amdgpu_xgmi_same_hive.
> >
> > Signed-off-by: Isabella Basso <isabbasso@riseup.net>
>
> The kfd_svm.c portion is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> Thank you!
>
>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_svm.c                       | 4 ----
> >  .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c | 7 +------
> >  2 files changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > index 82cb45e30197..835f202dc23d 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > @@ -1169,7 +1169,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> >                    unsigned long npages, bool readonly, dma_addr_t *dma_addr,
> >                    struct amdgpu_device *bo_adev, struct dma_fence **fence)
> >  {
> > -     struct amdgpu_bo_va bo_va;
> >       bool table_freed = false;
> >       uint64_t pte_flags;
> >       unsigned long last_start;
> > @@ -1182,9 +1181,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> >       pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n", prange->svms,
> >                last_start, last_start + npages - 1, readonly);
> >
> > -     if (prange->svm_bo && prange->ttm_res)
> > -             bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
> > -
> >       for (i = offset; i < offset + npages; i++) {
> >               last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
> >               dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> > index 8c20a0fb1e4f..fbdd0a92d146 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> > @@ -90,10 +90,8 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
> >       struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> >       struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
> >       struct dc *dc = clk_mgr_base->ctx->dc;
> > -     int display_count;
> >       bool update_dppclk = false;
> >       bool update_dispclk = false;
> > -     bool enter_display_off = false;
> >       bool dpp_clock_lowered = false;
> >       bool force_reset = false;
> >       bool p_state_change_support;
> > @@ -109,10 +107,7 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
> >               dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
> >       }
> >
> > -     display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
> > -
> > -     if (display_count == 0)
> > -             enter_display_off = true;
> > +     clk_mgr_helper_get_active_display_cnt(dc, context);
> >
> >       if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz))
> >               clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
