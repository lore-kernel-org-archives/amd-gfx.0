Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D15CCCA479
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 21:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDD910F1BE;
	Wed,  1 Jun 2022 21:01:50 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E2110F0ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 21:01:49 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-d39f741ba0so4288864fac.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9kc9ttUhN7p1eMBG8DSz0nb/n21ZOm6dfmcn8qTq+VI=;
 b=oR/PqJBJGdkerOVNcbXisJJe2i2i9FRPG5108OxTI+e+sRSenm7zx5OQZFRyk7/733
 rDhBfpmxOzP6N6YCTg2PM3z8VKhFi1O3uW3p1Ba+7vZX62HQR+gY6dImQeLpQawLxDra
 dBeXTVn0VN9Z2Gj1PQcDF0EeI3wiai1Q6Trzj6hNRb3qWgN8fwUvU/IsFbg2ooxxBjsf
 A1bkjhhbk7o79FrqRdrEYKqJa4/sgHedNOk5WQ7PoISI0bWu331/peLYK+SMqfhtuIn9
 G/1UpQYQ5UnJ0CaXo7GKFxLja8Nft34zJXIEP+J54AHv7UwtoaiCG9HssjLOpnUwLRCF
 w9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9kc9ttUhN7p1eMBG8DSz0nb/n21ZOm6dfmcn8qTq+VI=;
 b=FPMWZD3JDtPIbN25/UVsF1mi5lPSR9eLfCl61QvC5WnWFMrCHR5UOl/88AgJq5Wz4S
 fMTNwHn2jMfnlsHBpif0nEa90WO3C5UaU1LDTwGDQLED+LeQ+7PunWOksR4WywqrGXXL
 6q7Jg+NhjGMVEFOnz12+hiOTIJasl2VNE8zw929OEKbgPEpC0gXX3xSxfaWWFWql/p0I
 J2EbibVV2/XhqycQu92hBeNf5HdvCJV5rrNq4n8TovPU43bi8Ur/L/T06W3mtHJs1gGi
 NHFD/PcPLN4sYzsJp6S3lOIsyYSxrOURJ3z50VaW0P5ZS6t2NvaL5akw7vnVHhFWQU5r
 PkjA==
X-Gm-Message-State: AOAM532dzuA1b6fVRgxGnPh7Y77OjHDRI/4QB6ewTr4Rdi1TKC+2V4PP
 G3LdlBuiwpHueX66Lso671dfOYj8hAtDhVwZjGFk14hS
X-Google-Smtp-Source: ABdhPJyQkVrrXvu5TJd+LbAjGTyoBU3hFVk1k1ILfZxSpaItr6PDPDxX+LueuK5R0WMBlJ/qgukNWTI4EKEQONUjVV0=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr851809oap.253.1654117307851; Wed, 01 Jun
 2022 14:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220601205319.2174378-1-david.yatsin@amd.com>
In-Reply-To: <20220601205319.2174378-1-david.yatsin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jun 2022 17:01:36 -0400
Message-ID: <CADnq5_MwZ7LGE0u4cSBUUEYFTi=1FdGrPnBsbzTJq9n1exL5qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Add available memory ioctl
To: David Yat Sin <david.yatsin@amd.com>
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
Cc: Daniel Phillips <Daniel.Phillips@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 1, 2022 at 4:53 PM David Yat Sin <david.yatsin@amd.com> wrote:
>
> From: Daniel Phillips <Daniel.Phillips@amd.com>
>
> Add a new KFD ioctl to return the largest possible memory size that
> can be allocated as a buffer object using
> kfd_ioctl_alloc_memory_of_gpu. It attempts to use exactly the same
> accept/reject criteria as that function so that allocating a new
> buffer object of the size returned by this new ioctl is guaranteed to
> succeed, barring races with other allocating tasks.
>
> Signed-off-by: Daniel Phillips <Daniel.Phillips@amd.com>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>

Got a link to the new UMD code which uses this?  Please include that
in the commit message.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 37 +++++++++++++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 34 +++++++++++++++++
>  include/uapi/linux/kfd_ioctl.h                | 14 ++++++-
>  4 files changed, 80 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f8b9f27adcf5..0b0ab1de76ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -266,6 +266,7 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
>                                         void *drm_priv);
>  uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
> +size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev);
>  int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>                 struct amdgpu_device *adev, uint64_t va, uint64_t size,
>                 void *drm_priv, struct kgd_mem **mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 34ba9e776521..105af82d41a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -38,6 +38,12 @@
>   */
>  #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
>
> +/*
> + * Align VRAM allocations to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
> + * BO chunk
> + */
> +#define VRAM_ALLOCATION_ALIGN (1 << 21)
> +
>  /* Impose limit on how much memory KFD can use */
>  static struct {
>         uint64_t max_system_mem_limit;
> @@ -108,7 +114,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>   * compromise that should work in most cases without reserving too
>   * much memory for page tables unnecessarily (factor 16K, >> 14).
>   */
> -#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
> +#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
>
>  static size_t amdgpu_amdkfd_acc_size(uint64_t size)
>  {
> @@ -148,7 +154,12 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>         } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>                 system_mem_needed = acc_size;
>                 ttm_mem_needed = acc_size;
> -               vram_needed = size;
> +
> +               /*
> +                * Conservatively round up the allocation requirement to 2 MB to avoid fragmentation
> +                * caused by 4K allocations in the tail 2M BO chunk
> +                */
> +               vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
>         } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>                 system_mem_needed = acc_size + size;
>                 ttm_mem_needed = acc_size;
> @@ -173,7 +184,9 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>             (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>              kfd_mem_limit.max_ttm_mem_limit) ||
>             (adev->kfd.vram_used + vram_needed >
> -            adev->gmc.real_vram_size - reserved_for_pt)) {
> +            adev->gmc.real_vram_size -
> +            atomic64_read(&adev->vram_pin_size) -
> +            reserved_for_pt)) {
>                 ret = -ENOMEM;
>                 goto release;
>         }
> @@ -205,7 +218,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>         } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>                 kfd_mem_limit.system_mem_used -= acc_size;
>                 kfd_mem_limit.ttm_mem_used -= acc_size;
> -               adev->kfd.vram_used -= size;
> +               adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
>         } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>                 kfd_mem_limit.system_mem_used -= (acc_size + size);
>                 kfd_mem_limit.ttm_mem_used -= acc_size;
> @@ -1492,6 +1505,22 @@ int amdgpu_amdkfd_criu_resume(void *p)
>         return ret;
>  }
>
> +size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
> +{
> +       uint64_t reserved_for_pt =
> +               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +       size_t available;
> +
> +       spin_lock(&kfd_mem_limit.mem_limit_lock);
> +       available = adev->gmc.real_vram_size
> +               - adev->kfd.vram_used
> +               - atomic64_read(&adev->vram_pin_size)
> +               - reserved_for_pt;
> +       spin_unlock(&kfd_mem_limit.mem_limit_lock);
> +
> +       return ALIGN_DOWN(available, VRAM_ALLOCATION_ALIGN);
> +}
> +
>  int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>                 struct amdgpu_device *adev, uint64_t va, uint64_t size,
>                 void *drm_priv, struct kgd_mem **mem,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 95fa7a9718bb..625e837f0119 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -65,6 +65,25 @@ static int kfd_char_dev_major = -1;
>  static struct class *kfd_class;
>  struct device *kfd_device;
>
> +static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
> +{
> +       struct kfd_process_device *pdd;
> +
> +       mutex_lock(&p->mutex);
> +       pdd = kfd_process_device_data_by_id(p, gpu_id);
> +
> +       if (pdd)
> +               return pdd;
> +
> +       mutex_unlock(&p->mutex);
> +       return NULL;
> +}
> +
> +static inline void kfd_unlock_pdd(struct kfd_process_device *pdd)
> +{
> +       mutex_unlock(&pdd->process->mutex);
> +}
> +
>  int kfd_chardev_init(void)
>  {
>         int err = 0;
> @@ -958,6 +977,19 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>         return false;
>  }
>
> +static int kfd_ioctl_get_available_memory(struct file *filep,
> +                                         struct kfd_process *p, void *data)
> +{
> +       struct kfd_ioctl_get_available_memory_args *args = data;
> +       struct kfd_process_device *pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +
> +       if (!pdd)
> +               return -EINVAL;
> +       args->available = amdgpu_amdkfd_get_available_memory(pdd->dev->adev);
> +       kfd_unlock_pdd(pdd);
> +       return 0;
> +}
> +
>  static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>                                         struct kfd_process *p, void *data)
>  {
> @@ -2642,6 +2674,8 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>         AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_OP,
>                         kfd_ioctl_criu, KFD_IOC_FLAG_CHECKPOINT_RESTORE),
>
> +       AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE_MEMORY,
> +                       kfd_ioctl_get_available_memory, 0),
>  };
>
>  #define AMDKFD_CORE_IOCTL_COUNT        ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index eb9ff85f8556..c648ed7c5ff1 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -34,9 +34,10 @@
>   * - 1.6 - Query clear flags in SVM get_attr API
>   * - 1.7 - Checkpoint Restore (CRIU) API
>   * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
> + * - 1.9 - Add available memory ioctl
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 8
> +#define KFD_IOCTL_MINOR_VERSION 9
>
>  struct kfd_ioctl_get_version_args {
>         __u32 major_version;    /* from KFD */
> @@ -100,6 +101,12 @@ struct kfd_ioctl_get_queue_wave_state_args {
>         __u32 pad;
>  };
>
> +struct kfd_ioctl_get_available_memory_args {
> +       __u64 available;        /* from KFD */
> +       __u32 gpu_id;           /* to KFD */
> +       __u32 pad;
> +};
> +
>  /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
>  #define KFD_IOC_CACHE_POLICY_COHERENT 0
>  #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
> @@ -824,7 +831,10 @@ struct kfd_ioctl_set_xnack_mode_args {
>  #define AMDKFD_IOC_CRIU_OP                     \
>                 AMDKFD_IOWR(0x22, struct kfd_ioctl_criu_args)
>
> +#define AMDKFD_IOC_AVAILABLE_MEMORY            \
> +               AMDKFD_IOWR(0x23, struct kfd_ioctl_get_available_memory_args)
> +
>  #define AMDKFD_COMMAND_START           0x01
> -#define AMDKFD_COMMAND_END             0x23
> +#define AMDKFD_COMMAND_END             0x24
>
>  #endif
> --
> 2.30.2
>
