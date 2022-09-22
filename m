Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0482AC6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 13:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21E810EB1F;
	Thu, 22 Sep 2022 13:35:15 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9F210EB1F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 13:35:10 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-12b542cb1d3so13808032fac.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=6mkeYO7Ke/w8c22LFTpz5GPS9ufltXyBy9yN81Li49M=;
 b=VpB0HNcrU4fwTDvqSteHIBWmUVbl/5ArDNLMvs2VXV4TqFX04WA6GfS7PUUi1QnVE5
 0XhV1WOAjviIzzOjrXGWXoq8FNb3MUJYaQB+It5qzua9DKPy4/66gZu6jkRaCdThpQT2
 OG0rFzhq+GGb4wtvHj2u4NzIgNWJYDZ5Rir/BmH6dM2YHH8kuYSqHx+JZdE7pQaY5qny
 2SEghLhvEu3AIjPbH+DLzf3QiIqpW236j828dLONYP5YzgetiI4wjA4H1r8H35neWiDU
 7R1dJb4b7kVxpoZG6k1I2PleuKMujvdwtYWbuyRncsnorYxjbv7/rm1bAQUVzfSkrR6p
 aK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=6mkeYO7Ke/w8c22LFTpz5GPS9ufltXyBy9yN81Li49M=;
 b=Ua1geA8VVollaxnyrqsloJMzk7OCpz3+WyDeyuzKAhuzGsuRJEDnV4g9rTYQ2yW3wZ
 e4taHB+xG3HVKgA7+ayr+RqA3cbd4KCxAwSrhkO861kh7HcIuSJRlAIyIhhASbC7Bh+w
 ipa4/JIT/83YnJdlDdB81lH5fuuDPirPm4Vv/zoXIIOO/0fSMshzeEvoBMFOIT2pYfsN
 vu/TkUb+oDFcC3MIRNIJB3nH8LtMHGtqKOqcB0d8z3ihBi2AWPf5rvuylp7lg1gLeP76
 D8oX3fWoTWe6FywxRl/tb5k5KgXh1hNU7SQpIouJMpH5xwMScTYabWUXD6TWcbcDENcg
 LJqA==
X-Gm-Message-State: ACrzQf3mEgzN8VZL3vkECQSSnHfsbya3yP7/ibhc5ViA4TREz5IJB3SA
 kCgoumRvHg2QZzuPpmNseuCIzeLfRt7rWJhtQEg=
X-Google-Smtp-Source: AMsMyM7SYY7bHPzQE2Yt4xMK6PWhVSnNbDf1tfzvyhCezrg6ANGv/Qp2j0u5Mw4q8VPqxLKpExXte70UuNjRR4C1zeQ=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr2003984oam.96.1663853710123; Thu, 22
 Sep 2022 06:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220922131859.131544-1-Arunpravin.PaneerSelvam@amd.com>
In-Reply-To: <20220922131859.131544-1-Arunpravin.PaneerSelvam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Sep 2022 09:34:58 -0400
Message-ID: <CADnq5_PoB=3XO7wjcqcmewOnNajuhnWpVisSh1TR6eAQD+Z-5A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix VRAM BO swap issue
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 22, 2022 at 9:19 AM Arunpravin Paneer Selvam
<Arunpravin.PaneerSelvam@amd.com> wrote:
>
> DRM buddy manager allocates the contiguous memory requests in
> a single block or multiple blocks. So for the ttm move operation
> (incase of low vram memory) we should consider all the blocks to
> compute the total memory size which compared with the struct
> ttm_resource num_pages in order to verify that the blocks are
> contiguous for the eviction process.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Please add a Fixes line and any relevant bug report links.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b1c455329023..b1223c8e30c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -426,6 +426,7 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>  {
>         uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
>         struct amdgpu_res_cursor cursor;
> +       u64 start, size, total_size = 0;
>
>         if (mem->mem_type == TTM_PL_SYSTEM ||
>             mem->mem_type == TTM_PL_TT)
> @@ -435,8 +436,23 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>
>         amdgpu_res_first(mem, 0, mem_size, &cursor);
>
> -       /* ttm_resource_ioremap only supports contiguous memory */
> -       if (cursor.size != mem_size)
> +       do {
> +               start = cursor.start;
> +               size = cursor.size;
> +
> +               total_size += size;
> +
> +               amdgpu_res_next(&cursor, cursor.size);
> +
> +               if (!cursor.remaining)
> +                       break;
> +
> +               /* ttm_resource_ioremap only supports contiguous memory */
> +               if (start + size != cursor.start)
> +                       return false;
> +       } while (1);
> +
> +       if (total_size != mem_size)
>                 return false;
>
>         return cursor.start + cursor.size <= adev->gmc.visible_vram_size;
> --
> 2.25.1
>
