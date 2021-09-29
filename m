Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C10C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 23:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD71615E4
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 23:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAD71615E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4058B6EB08;
	Wed, 29 Sep 2021 23:35:36 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC1B6EB08
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 23:35:34 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id d8so4011734qtd.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 16:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SAkesPgB7NVfiBkuIf+rHBT8HAW5FdS3Z04qF1/MFFY=;
 b=kyw90Ogm24AQm7UoE8uVCKypuG5YR+Z/O/3PD7I5oYuMoICMk/QYk7grZ2lwjemmn5
 Fgqlp4mYPz5wwkIgLzpbHzPfk4Oh8CZyZfn5eyG1lvxjRM/z+xoecwOy18BJSin0mldI
 ofQYz/TDT9ojDwhdqJk/IXrm+KLJ8aUQgJ3gJp4/tTUltsb6KLlDNOKmTvBwVFUtC9WE
 uiXVL0390XrEcXMrjQZOhZ3Jeb1BeLL1zRMMFfxdAiQk/1+J0ot+K2BcRkCbBt1Uo3aC
 LBgfKONNDI6n182iLQ/LqICsxRDH/CnxgXvCV+61lrcd5s1tBOTHSlVUJtj79y6x4iuQ
 JUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SAkesPgB7NVfiBkuIf+rHBT8HAW5FdS3Z04qF1/MFFY=;
 b=gnkFRHF+GlL2X4sN5TmxBOB5h9H87nl5qBitHyzIcAEvAwZ2amdB634CEkZ2xifbCz
 BT1OG6KcobaXugu/qKZKLLae9ZsKatj6KidfhCboNRPByx93t2+rYjVKr7zhP2hNKwzT
 7xIQceaG4wjcZ/e3PWvlX1oeummQlIzj7W/GxCpOqKXtn1wUfyrMLSN2zdm8bArp9wD1
 Nd1MDaWAdtC/fOIBfuSttpPb5N56xdtRsrJPw+EBmLJDEwNfamUHGd6GPj1iFuaQ3Ixb
 AR4fExELcN8eD+h1pZrEG6WQknhjrK9ATfHLWE0AdR/kZePIzO+tbW1+nWH+D6hWQ5ha
 2aqA==
X-Gm-Message-State: AOAM531ltnTaqg00s+TYe8CS18bxZI9EBzd/agX9LuKxBzP6sAl2yQXT
 CRXpPBUuPWcQ+J9Q+qF6B2ql4q35qgLhwJfIRrqS3Q==
X-Google-Smtp-Source: ABdhPJwWZBNobidEB0uwvdU06aWDElqgdnyKsJ1xqUlfj9Io9Ccoo3su6Dodk/sGHH/trIC/JXr+fkcbzyqxbCljqiY=
X-Received: by 2002:ac8:4588:: with SMTP id l8mr2951536qtn.207.1632958533819; 
 Wed, 29 Sep 2021 16:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210719211857.29954-1-alex.sierra@amd.com>
In-Reply-To: <20210719211857.29954-1-alex.sierra@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 30 Sep 2021 00:35:22 +0100
Message-ID: <CAHbf0-Ew51w4U9b1Z9Jw1gCEz2gJKSZWOC47eb-XJYT2tgVSYg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: avoid conflicting address mappings
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

Hi

This patch is causing a compile failure for me

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:1254:25: error:
unused variable 'svms' [-Werror,-Wunused-variable]
       struct svm_range_list *svms = &p->svms;
                              ^
1 error generated.

I'll turn off Werror

On Mon, 19 Jul 2021 at 22:19, Alex Sierra <alex.sierra@amd.com> wrote:
>
> [Why]
> Avoid conflict with address ranges mapped by SVM
> mechanism that try to be allocated again through
> ioctl_alloc in the same process. And viceversa.
>
> [How]
> For ioctl_alloc_memory_of_gpu allocations
> Check if the address range passed into ioctl memory
> alloc does not exist already in the kfd_process
> svms->objects interval tree.
>
> For SVM allocations
> Look for the address range into the interval tree VA from
> the VM inside of each pdds used in a kfd_process.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 ++++
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 79 +++++++++++++++++++-----
>  2 files changed, 75 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 67541c30327a..f39baaa22a62 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1251,6 +1251,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>         struct kfd_process_device *pdd;
>         void *mem;
>         struct kfd_dev *dev;
> +       struct svm_range_list *svms = &p->svms;
>         int idr_handle;
>         long err;
>         uint64_t offset = args->mmap_offset;
> @@ -1259,6 +1260,18 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>         if (args->size == 0)
>                 return -EINVAL;
>
> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +       mutex_lock(&svms->lock);
> +       if (interval_tree_iter_first(&svms->objects,
> +                                    args->va_addr >> PAGE_SHIFT,
> +                                    (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
> +               pr_err("Address: 0x%llx already allocated by SVM\n",
> +                       args->va_addr);
> +               mutex_unlock(&svms->lock);
> +               return -EADDRINUSE;
> +       }
> +       mutex_unlock(&svms->lock);
> +#endif
>         dev = kfd_device_by_id(args->gpu_id);
>         if (!dev)
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 31f3f24cef6a..043ee0467916 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2581,9 +2581,54 @@ int svm_range_list_init(struct kfd_process *p)
>         return 0;
>  }
>
> +/**
> + * svm_range_is_vm_bo_mapped - check if virtual address range mapped already
> + * @p: current kfd_process
> + * @start: range start address, in pages
> + * @last: range last address, in pages
> + *
> + * The purpose is to avoid virtual address ranges already allocated by
> + * kfd_ioctl_alloc_memory_of_gpu ioctl.
> + * It looks for each pdd in the kfd_process.
> + *
> + * Context: Process context
> + *
> + * Return 0 - OK, if the range is not mapped.
> + * Otherwise error code:
> + * -EADDRINUSE - if address is mapped already by kfd_ioctl_alloc_memory_of_gpu
> + * -ERESTARTSYS - A wait for the buffer to become unreserved was interrupted by
> + * a signal. Release all buffer reservations and return to user-space.
> + */
> +static int
> +svm_range_is_vm_bo_mapped(struct kfd_process *p, uint64_t start, uint64_t last)
> +{
> +       uint32_t i;
> +       int r;
> +
> +       for (i = 0; i < p->n_pdds; i++) {
> +               struct amdgpu_vm *vm;
> +
> +               if (!p->pdds[i]->drm_priv)
> +                       continue;
> +
> +               vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
> +               r = amdgpu_bo_reserve(vm->root.bo, false);
> +               if (r)
> +                       return r;
> +               if (interval_tree_iter_first(&vm->va, start, last)) {
> +                       pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
> +                       amdgpu_bo_unreserve(vm->root.bo);
> +                       return -EADDRINUSE;
> +               }
> +               amdgpu_bo_unreserve(vm->root.bo);
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * svm_range_is_valid - check if virtual address range is valid
> - * @mm: current process mm_struct
> + * @mm: current kfd_process
>   * @start: range start address, in pages
>   * @size: range size, in pages
>   *
> @@ -2592,28 +2637,27 @@ int svm_range_list_init(struct kfd_process *p)
>   * Context: Process context
>   *
>   * Return:
> - *  true - valid svm range
> - *  false - invalid svm range
> + *  0 - OK, otherwise error code
>   */
> -static bool
> -svm_range_is_valid(struct mm_struct *mm, uint64_t start, uint64_t size)
> +static int
> +svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>  {
>         const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
>         struct vm_area_struct *vma;
>         unsigned long end;
> +       unsigned long start_unchg = start;
>
>         start <<= PAGE_SHIFT;
>         end = start + (size << PAGE_SHIFT);
> -
>         do {
> -               vma = find_vma(mm, start);
> +               vma = find_vma(p->mm, start);
>                 if (!vma || start < vma->vm_start ||
>                     (vma->vm_flags & device_vma))
> -                       return false;
> +                       return -EFAULT;
>                 start = min(end, vma->vm_end);
>         } while (start < end);
>
> -       return true;
> +       return svm_range_is_vm_bo_mapped(p, start_unchg, (end - 1) >> PAGE_SHIFT);
>  }
>
>  /**
> @@ -2913,9 +2957,9 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
>
>         svm_range_list_lock_and_flush_work(svms, mm);
>
> -       if (!svm_range_is_valid(mm, start, size)) {
> -               pr_debug("invalid range\n");
> -               r = -EFAULT;
> +       r = svm_range_is_valid(p, start, size);
> +       if (r) {
> +               pr_debug("invalid range r=%d\n", r);
>                 mmap_write_unlock(mm);
>                 goto out;
>         }
> @@ -3016,17 +3060,18 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
>         uint32_t flags = 0xffffffff;
>         int gpuidx;
>         uint32_t i;
> +       int r = 0;
>
>         pr_debug("svms 0x%p [0x%llx 0x%llx] nattr 0x%x\n", &p->svms, start,
>                  start + size - 1, nattr);
>
>         mmap_read_lock(mm);
> -       if (!svm_range_is_valid(mm, start, size)) {
> -               pr_debug("invalid range\n");
> -               mmap_read_unlock(mm);
> -               return -EINVAL;
> -       }
> +       r = svm_range_is_valid(p, start, size);
>         mmap_read_unlock(mm);
> +       if (r) {
> +               pr_debug("invalid range r=%d\n", r);
> +               return r;
> +       }
>
>         for (i = 0; i < nattr; i++) {
>                 switch (attrs[i].type) {
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
