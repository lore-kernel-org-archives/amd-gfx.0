Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15DFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 19:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F083619F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 19:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F083619F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB62E6E44E;
	Thu, 30 Sep 2021 19:13:42 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3721B6E44E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 19:13:41 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 77-20020a9d0ed3000000b00546e10e6699so8649615otj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oBAY0BHZTZwbqCfg6/qEpnRw/2QBKjyloVsD+ZlSPVA=;
 b=o84aFC/ah07fzjgIrqXPWqj5iYcYaPHnv86LIds6ueRPtIrHOidd+ahVQ5UeoMWICW
 9+gJ434uRT0nmPYIdITJ0H/+Rh/71ocPOCqGuQNNik6TdLsQBNJ4ztrjPTb/Y+izt5t9
 uzRVEjWgxlQCCUkqgf6VY1gZ0sIuQ6itjYExN1miziPkj+lvGJasDJ8RWspFZY8ncYpH
 kgry8szXkV6GEQBALs0wN6UbOm2hgnaY64jIFhzR2nATjzz9hjWSU3xtP7fDBLocqQED
 fnvQ06C2fs7gZAxrLC3BdCgWdDV2xL25PfntJgGx/n49sbHeNlOQUshk0xAOvAoPxkjI
 +krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oBAY0BHZTZwbqCfg6/qEpnRw/2QBKjyloVsD+ZlSPVA=;
 b=bds64XqBQ7CwNybMEJIXC+oXVRU5AjAXr2h/UXcphV3BUUVc8EQVmefkKJpoWnLXna
 w3CAv3UHGD+SYEBMFBoBqO2lqHnXZpgPSdTgsMIt6KXWX1XHgIFLH8YUjiQLjua6W08+
 QCDI3bqxoJCzDjm/mB0mp+gtmgJCZxwiZ+cXnUjuMIXw++x+gVETIqukvESBiA1TkY2F
 bs8C3tnPcwP3eKHNRIkrd67J7fJzcwwk5qaaiNqaSgqSwBIW2Mbk0UvuKpUjMeGBv8oz
 vVGv+4yDzlwO+NOPLoTcvZcokp3UlHd0f15p7KxrVl3lfLiJ4H8tfdlMts5sbNlaNmBh
 R00Q==
X-Gm-Message-State: AOAM530HqVtphQ0QDyiaMBoR7FgaJpEZ2f6B7Xmyr+DdN5I5F3jPY9OO
 1NHGWMa+0XP5M8Tz1s1GRUdnbH08Elmbz4lNffm9+qnC
X-Google-Smtp-Source: ABdhPJx1gOtO0FraIXWJXDm4JvR/60J4AR8Y5UeKOihjB6hoFl+1o/2OjtxKg3YMTtFqYDXCtvSHIBOKRBNlyBNd/Cs=
X-Received: by 2002:a05:6830:1bc6:: with SMTP id
 v6mr6605709ota.299.1633029220463; 
 Thu, 30 Sep 2021 12:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210930155309.4707-1-alex.sierra@amd.com>
In-Reply-To: <20210930155309.4707-1-alex.sierra@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Sep 2021 15:13:29 -0400
Message-ID: <CADnq5_OBznKSX+PYPuJ68KqW91mcfXios_uAyROo7k3X-BHx_A@mail.gmail.com>
Subject: Re: [PATCH] amd/amdkfd: remove svms declaration to avoid werror
To: Alex Sierra <alex.sierra@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 30, 2021 at 11:53 AM Alex Sierra <alex.sierra@amd.com> wrote:
>
> svm_range_list svms declaration removed to avoid werror when
> CONFIG_HSA_AMD_SVM is not enabled.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 4de907f3e66a..f1e7edeb4e6b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1251,7 +1251,6 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>         struct kfd_process_device *pdd;
>         void *mem;
>         struct kfd_dev *dev;
> -       struct svm_range_list *svms = &p->svms;
>         int idr_handle;
>         long err;
>         uint64_t offset = args->mmap_offset;
> @@ -1264,18 +1263,18 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>         /* Flush pending deferred work to avoid racing with deferred actions
>          * from previous memory map changes (e.g. munmap).
>          */
> -       svm_range_list_lock_and_flush_work(svms, current->mm);
> -       mutex_lock(&svms->lock);
> +       svm_range_list_lock_and_flush_work(&p->svms, current->mm);
> +       mutex_lock(&p->svms.lock);
>         mmap_write_unlock(current->mm);
> -       if (interval_tree_iter_first(&svms->objects,
> +       if (interval_tree_iter_first(&p->svms.objects,
>                                      args->va_addr >> PAGE_SHIFT,
>                                      (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
>                 pr_err("Address: 0x%llx already allocated by SVM\n",
>                         args->va_addr);
> -               mutex_unlock(&svms->lock);
> +               mutex_unlock(&p->svms.lock);
>                 return -EADDRINUSE;
>         }
> -       mutex_unlock(&svms->lock);
> +       mutex_unlock(&p->svms.lock);
>  #endif
>         dev = kfd_device_by_id(args->gpu_id);
>         if (!dev)
> --
> 2.32.0
>
