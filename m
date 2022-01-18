Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA614C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 21:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9BC10E148;
	Tue, 18 Jan 2022 21:49:33 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2D210E148
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 21:49:32 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 60-20020a9d0142000000b0059103eb18d4so358764otu.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 13:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eF5Jrz58uiqQGOJvL2bGtyVIQPvYGHlvJNEOaiQYrwE=;
 b=qLrlZdRtkGvmEKr0BVi7kbsRYzfbmByQapfP+2p+30neFDk9a+5WKLh0F5ZEX4IhoB
 /d/P+f6DPjQjhVZqbTG1Bxktd49ekRTDDOhwK2KykVp+ZtmSO8bkj8ERIPH7vwe9iRo4
 xyIZLfv5MBXb9IWqLT1llT8GbUTwLvwNkC4XMDtHh/iecJdg1lt6b6VzVx/z+FHqkoLy
 huDszGumtQbQgqwMHvedVqf80PhRHwPxLU8jsG84/5XeMl+PQ79ThBSCa7itqwApm0BF
 6irX9jzXBRC6dI4QqIP/Vet996fpe5/AjlSFQMCPaTE54X+fEDn45vI7oy3ylFC3c82w
 Shlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eF5Jrz58uiqQGOJvL2bGtyVIQPvYGHlvJNEOaiQYrwE=;
 b=fwnta7IT2rEb+r/CbIyfefmyuNp5g0BuXxKs2VBhUeSks6TrjcLO6EjM7B5G3BTKLW
 tNA5AdVnbwYs745/ZR2ou/2jC7X7VlTfcSajiH8GR++Qb9c7gQf7YfQMmFmmDu+Ghs0p
 Hwg1/YRZIqbUYtbN2kSgqdj3Do2xGZ9n5N+r/wxhatpH2wdq6x/8jRQcEVj+93Hl2ZCB
 cARJazcBwcrZ6uUWAMWg5xIWtp9jkj9wY9W0ETLMIPuSfOyBEiT1+Tjpj+jL+6xx+IJM
 Ftdxa+DoHKskznZc8VfzVwOYqubNj0boc4Xw9UxOxwiJTbQv0IYHwbwz2BS0ob38deKt
 EUGA==
X-Gm-Message-State: AOAM530NIaDB0/A4yVlhe7mkYdP+qtIfv/xBKeVaHqknyn/JbH4qyp0U
 qIesbyN1M0IzmZNtAKOMHrNMi7m9YyEi4tyidE0IhccO
X-Google-Smtp-Source: ABdhPJyD+KdeyUp/UUyr7/UF+arPTbyam4L1RVtIBjl/Q4E4LBTWUirbsSS3xpU6nzbXb6ijC/raLfx2QsK40Eu9nno=
X-Received: by 2002:a05:6830:1d90:: with SMTP id
 y16mr11007796oti.200.1642542571366; 
 Tue, 18 Jan 2022 13:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20220118212808.23392-1-jinhuieric.huang@amd.com>
In-Reply-To: <20220118212808.23392-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jan 2022 16:49:20 -0500
Message-ID: <CADnq5_PovkhBMC58_yuWxmY8nVc0Hv9QpY=FkZ=RV7XjgKSxfA@mail.gmail.com>
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

On Tue, Jan 18, 2022 at 4:28 PM Eric Huang <jinhuieric.huang@amd.com> wrote:
>
> SDMA FW fixes the hang issue for adding heavy-weight TLB
> flush on Arcturus, so we can enable it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 4 +++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a64cbbd943ba..f1fed0fc31d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1892,10 +1892,13 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
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
> +           (adev->asic_type != CHIP_ARCTURUS ||
> +            adev->sdma.instance[0].fw_version < 18))
>                 *table_freed = true;
>
>         goto out;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b570c0454ce9..0e4a76dca809 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1806,7 +1806,9 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>         }
>         mutex_unlock(&p->mutex);
>
> -       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
> +       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +           (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> +            dev->adev->sdma.instance[0].fw_version >= 18)) {
>                 err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>                                 (struct kgd_mem *) mem, true);
>                 if (err) {
> --
> 2.25.1
>
