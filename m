Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042D9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 16:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A48C10E4E8;
	Tue, 18 Jan 2022 16:36:11 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2529710E4E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 16:36:10 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id s9so29254972oib.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TMfk/4s/Nsrf3zOZBzJARnxGorL/g7IkChakciD0GiQ=;
 b=Fp7n5HNtkbvg1hdVITGX062paeKWNGaVfpxCU1hq3Qka5qLeZ4FZFwM0udlph+wCcg
 pzYx5xxwiYPe8+7z43pCRZiUMPTFOYLhh8PFURZ64g3HhjnTW6nXywya2iB6abH3MkEQ
 +O9mIt7CV0rduNns4Z4t603RSzy4vp+yMEDc4xkcqLDtpMgXUqaVRW4oBc0dG0pwTN6P
 5aMeTTpZLDQ+kt8yF+zjn3E5FsJFBKj0+HPjuMnSK/OwVD3nE7rVGwW8gIsz+sEEGc4J
 lms1d2WzY7ygUFKQ2/H8ZEO/oU1LtKJYC53yXbDaZKY+6ahp/IZP5J59iu/3RNcXIw4u
 XlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TMfk/4s/Nsrf3zOZBzJARnxGorL/g7IkChakciD0GiQ=;
 b=rE0juSgxBfap70o9+dnP2nXxErpcCeajhhkZZJR/jCkBoT+/zlQ4m621WM5CvxG8Ox
 qD8x8ZTwrl8ZboGt7V2v3ifG4b3urVX0hN6T98bnYcsTXC88BmVcSwxmioJn/sG1URjB
 d6sC7cjhtaKDTLSi1a8AsPYMKfPHSxCOJJDMluws8EmPDz5hlIU/u9Iav814Zr/5Ixyv
 iRG8AlXZaPj4ML4E805zziRnH4IkL89jgOLeXEPeNtxhvfmNzssig0sOqSiRcDrkFMSD
 OfgW6Vimrmbqf4oXy68vpw9D6jYbYfvyLzfAg0V96Nf92e3NsKsqS063KCPrqcRFzUHK
 vO9Q==
X-Gm-Message-State: AOAM530rm9xxIHVrNMyWU3vU0u/AfiwNaZUNW+EoQ5jEk/YZavHkd+vY
 y6wloVOKNi6IbbxzPa6plKG0TP217riNlo+Dc6k=
X-Google-Smtp-Source: ABdhPJzGxXpoaojUrz73cVcgqGZPMg25Mgkt5aCNY7YXatDk6oJ1414vDBux21YwRdf+oHxnPpMCIEs6nUT4eTIbP2U=
X-Received: by 2002:a05:6808:68f:: with SMTP id
 k15mr27220197oig.5.1642523769431; 
 Tue, 18 Jan 2022 08:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20220118161552.11122-1-jinhuieric.huang@amd.com>
In-Reply-To: <20220118161552.11122-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jan 2022 11:35:58 -0500
Message-ID: <CADnq5_OVpDd7O+q=9N8j14dwa-+2PqKjmDvKv6JkQGiiuQDYSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
To: Eric Huang <jinhuieric.huang@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 18, 2022 at 11:16 AM Eric Huang <jinhuieric.huang@amd.com> wrote:
>
> SDMA FW fixes the hang issue for adding heavy-weight TLB
> flush on Arcturus, so we can enable it.

Do we need to check for a specific fw version?

Alex

>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a64cbbd943ba..7b24a920c12e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1892,10 +1892,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>                                 true);
>         ret = unreserve_bo_and_vms(&ctx, false, false);
>
> -       /* Only apply no TLB flush on Aldebaran to
> -        * workaround regressions on other Asics.
> +       /* Only apply no TLB flush on Aldebaran and Arcturus
> +        * to workaround regressions on other Asics.
>          */
> -       if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
> +       if (table_freed &&
> +           (adev->asic_type != CHIP_ALDEBARAN) &&
> +           (adev->asic_type != CHIP_ARCTURUS))
>                 *table_freed = true;
>
>         goto out;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b570c0454ce9..ef4d676cc71c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1806,7 +1806,8 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>         }
>         mutex_unlock(&p->mutex);
>
> -       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
> +       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +           KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)) {
>                 err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>                                 (struct kgd_mem *) mem, true);
>                 if (err) {
> --
> 2.25.1
>
