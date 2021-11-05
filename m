Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEDBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 14:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95ADD6120A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 14:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95ADD6120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1136E6E808;
	Fri,  5 Nov 2021 14:17:57 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BB86E808
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 14:17:55 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 m37-20020a4a9528000000b002b83955f771so3032256ooi.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Nov 2021 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0pQ1hWfESnU9D40k001TUzxjgZQM4TZznk0feQjVVn0=;
 b=LB+/bjtPyt7y2r4kIp5L/nFlL69rZYgmuKR+Y05hCg1NQcaUc0F9v/nFAjCYlnq6Zj
 2jiaBGFqvUIvAXE/UsGeao5WG2QRhuD2XRGHP+hI0/cagfLT/B2twdSbB/qfl2YY8MPz
 jJ4LxsSFoLnfW2m4U5wmx4NBItkfsv1X0mXwstwpsBCVUtu6SF/naSAQ/QdOaY4sL9Tw
 SGoVSrVQxv2oUfTPReMKYtO7TwBJNtj1tdEZS+r/PFkOMcekR9VXlepeZY39tLjgGdJK
 qX7QBt/hUCdcsrCD3LqeWqS/AbJoOokmoKooLqJ7chCcm3V64tlVatysnL5DlHRGi60y
 1SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0pQ1hWfESnU9D40k001TUzxjgZQM4TZznk0feQjVVn0=;
 b=KipjPVhTBaoNQXveVnwU3D6P1TIvsF+cxwKcB9rKNfeP5CKleN7D1wtQqsOrnfRHz3
 fVzKfwEqahjp7+DMdaYatuwfC5ao12EoID0+GI6KobmL2roQYsj5YDWpFuZs+uiPpMy0
 /B+zmQB+JnDhvYw51pvp4/0bMAktU59XszTZAtoz/bB3zFiAoZ+2XGvXu52pLt95WHVq
 9ksyRNMqzszbOUafGoYsSfWxTi9Ne+rzzW6pvMwP/AoG9B6hzj/oCuy560HvY7mxpgfA
 DyQ8fg8EQXJX77+x5cV2AuPj5nQGzKOvkjr7kl5o1kSw+xmrmgG0hzZyI+U2ikuuPsgc
 2CYg==
X-Gm-Message-State: AOAM530aOea9e1nxyjZk1R3EaGyqAW8JdSQ2EKOxaYzXwoeXqMGb4TzJ
 mbLOw9FX1f6wJDSF1jqen3Bg74YkZ2chwAO6yCTAHWLV
X-Google-Smtp-Source: ABdhPJziahJbjoozcaEkdMw/r7TcP44YP3/3YwgCfXwNm7SU4r5YGfBaNedlI36CJ4XGXRZo9rOPe/8g+ZUCtjVGf9U=
X-Received: by 2002:a4a:dd93:: with SMTP id h19mr8816157oov.73.1636121874878; 
 Fri, 05 Nov 2021 07:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211105140912.3638-1-nirmoy.das@amd.com>
 <20211105140912.3638-3-nirmoy.das@amd.com>
In-Reply-To: <20211105140912.3638-3-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Nov 2021 10:17:43 -0400
Message-ID: <CADnq5_Od6WAjaKp0i4kB3Z60qOHnRZ5J6sGX4REy0Tf_Lr8K5w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] drm/amdgpu: enable HIQ in amdgpu without kfd
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <pierre-eric.pelloux-prayer@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 5, 2021 at 10:09 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> There is a HW bug which prevents CP to read secure buffers
> with HIQ being configured and mapped using KIQ. KFD already
> does this for amdgpu but when kfd is not enabled amdgpu
> should that for itself.

Can we just move the HIQ init/fini into the KGD and then have KFD call
into the KGD when it needs to interact with it?  I'd rather not have
two code paths to maintain to handle the HIQ ring.

Alex

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 77 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 80 +++++++++++++++++++++++++
>  3 files changed, 170 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 053a1119ebfe..837f76550242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -519,7 +519,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>                                             AMDGPU_GEM_DOMAIN_VRAM, &ring->mqd_obj,
>                                             &ring->mqd_gpu_addr, &ring->mqd_ptr);
>                 if (r) {
> -                       dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
> +                       dev_warn(adev->dev, "failed to create KIQ ring mqd ob (%d)", r);
>                         return r;
>                 }
>
> @@ -569,6 +569,18 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>                 }
>         }
>
> +       /* create MQD for HIQ */
> +       ring = &adev->gfx.hiq.ring;
> +       if (!ring->mqd_obj) {
> +               r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +                                           AMDGPU_GEM_DOMAIN_VRAM, &ring->mqd_obj,
> +                                           &ring->mqd_gpu_addr, &ring->mqd_ptr);
> +               if (r) {
> +                       dev_warn(adev->dev, "failed to create HIQ ring mqd ob (%d)", r);
> +                       return r;
> +               }
> +       }
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 538130c453a6..9532f013128f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4794,6 +4794,7 @@ static int gfx_v10_0_sw_init(void *handle)
>  {
>         int i, j, k, r, ring_id = 0;
>         struct amdgpu_kiq *kiq;
> +       struct amdgpu_hiq *hiq;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         switch (adev->ip_versions[GC_HWIP][0]) {
> @@ -4923,6 +4924,18 @@ static int gfx_v10_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> +       if (!adev->kfd.dev) {
> +               r = amdgpu_gfx_hiq_init(adev, GFX10_MEC_HPD_SIZE);
> +               if (r) {
> +                       DRM_ERROR("Failed to init HIQ BOs!\n");
> +                       return r;
> +               }
> +
> +               hiq = &adev->gfx.hiq;
> +               r = amdgpu_gfx_hiq_init_ring(adev, &hiq->ring, &hiq->irq);
> +               if (r)
> +                       return r;
> +       }
>         r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v10_compute_mqd));
>         if (r)
>                 return r;
> @@ -7215,6 +7228,54 @@ static int gfx_v10_0_kcq_resume(struct amdgpu_device *adev)
>         return r;
>  }
>
> +static int gfx_v10_0_hiq_init_queue(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +       struct v10_compute_mqd *mqd = ring->mqd_ptr;
> +
> +
> +       if (amdgpu_in_reset(adev)) {
> +               /* reset ring buffer */
> +               ring->wptr = 0;
> +               amdgpu_ring_clear_ring(ring);
> +
> +       } else {
> +               memset((void *)mqd, 0, sizeof(*mqd));
> +               mutex_lock(&adev->srbm_mutex);
> +               nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +               gfx_v10_0_compute_mqd_init(ring);
> +               nv_grbm_select(adev, 0, 0, 0, 0);
> +               mutex_unlock(&adev->srbm_mutex);
> +       }
> +
> +       return 0;
> +}
> +
> +static int gfx_v10_0_hiq_resume(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_ring *ring;
> +       int r;
> +
> +       ring = &adev->gfx.hiq.ring;
> +
> +       r = amdgpu_bo_reserve(ring->mqd_obj, false);
> +       if (unlikely(r != 0))
> +               return r;
> +
> +       r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> +       if (unlikely(r != 0))
> +               return r;
> +
> +       gfx_v10_0_hiq_init_queue(ring);
> +       amdgpu_bo_kunmap(ring->mqd_obj);
> +       ring->mqd_ptr = NULL;
> +       amdgpu_bo_unreserve(ring->mqd_obj);
> +       ring->sched.ready = true;
> +
> +       amdgpu_gfx_enable_hiq(adev);
> +       return 0;
> +}
> +
>  static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
>  {
>         int r, i;
> @@ -7252,6 +7313,12 @@ static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
>                         return r;
>         }
>
> +       if (!adev->kfd.dev) {
> +               r = gfx_v10_0_hiq_resume(adev);
> +               if (r)
> +                       return r;
> +       }
> +
>         for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>                 ring = &adev->gfx.gfx_ring[i];
>                 r = amdgpu_ring_test_helper(ring);
> @@ -7557,6 +7624,11 @@ static int gfx_v10_0_hw_fini(void *handle)
>  #endif
>                 if (amdgpu_gfx_disable_kcq(adev))
>                         DRM_ERROR("KCQ disable failed\n");
> +
> +               if (!adev->kfd.dev) {
> +                       if (amdgpu_gfx_disable_hiq(adev))
> +                               DRM_ERROR("HIQ disable failed\n");
> +               }
>         }
>
>         if (amdgpu_sriov_vf(adev)) {
> @@ -9470,11 +9542,16 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>         .emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
>  };
>
> +static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_hiq = {
> +       .type = AMDGPU_RING_TYPE_HIQ,
> +};
> +
>  static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
>  {
>         int i;
>
>         adev->gfx.kiq.ring.funcs = &gfx_v10_0_ring_funcs_kiq;
> +       adev->gfx.hiq.ring.funcs = &gfx_v10_0_ring_funcs_hiq;
>
>         for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>                 adev->gfx.gfx_ring[i].funcs = &gfx_v10_0_ring_funcs_gfx;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2b29e42bde62..9653ea8743d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2309,6 +2309,7 @@ static int gfx_v9_0_sw_init(void *handle)
>         int i, j, k, r, ring_id;
>         struct amdgpu_ring *ring;
>         struct amdgpu_kiq *kiq;
> +       struct amdgpu_hiq *hiq;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         switch (adev->ip_versions[GC_HWIP][0]) {
> @@ -2428,6 +2429,19 @@ static int gfx_v9_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> +       if (!adev->kfd.dev) {
> +               r = amdgpu_gfx_hiq_init(adev, GFX9_MEC_HPD_SIZE);
> +               if (r) {
> +                       DRM_ERROR("Failed to init HIQ BOs!\n");
> +                       return r;
> +               }
> +
> +               hiq = &adev->gfx.hiq;
> +               r = amdgpu_gfx_hiq_init_ring(adev, &hiq->ring, &hiq->irq);
> +               if (r)
> +                       return r;
> +       }
> +
>         /* create MQD for all compute queues as wel as KIQ for SRIOV case */
>         r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v9_mqd_allocation));
>         if (r)
> @@ -3911,6 +3925,56 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
>         return r;
>  }
>
> +static int gfx_v9_0_hiq_init_queue(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +       struct v9_mqd *mqd = ring->mqd_ptr;
> +
> +
> +       if (amdgpu_in_reset(adev)) {
> +               /* reset ring buffer */
> +               ring->wptr = 0;
> +               amdgpu_ring_clear_ring(ring);
> +
> +       } else {
> +               memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
> +               ((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
> +               ((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
> +               mutex_lock(&adev->srbm_mutex);
> +               soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +               gfx_v9_0_mqd_init(ring);
> +               soc15_grbm_select(adev, 0, 0, 0, 0);
> +               mutex_unlock(&adev->srbm_mutex);
> +       }
> +
> +       return 0;
> +}
> +
> +static int gfx_v9_0_hiq_resume(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_ring *ring;
> +       int r;
> +
> +       ring = &adev->gfx.hiq.ring;
> +
> +       r = amdgpu_bo_reserve(ring->mqd_obj, false);
> +       if (unlikely(r != 0))
> +               return r;
> +
> +       r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> +       if (unlikely(r != 0))
> +               return r;
> +
> +       gfx_v9_0_hiq_init_queue(ring);
> +       amdgpu_bo_kunmap(ring->mqd_obj);
> +       ring->mqd_ptr = NULL;
> +       amdgpu_bo_unreserve(ring->mqd_obj);
> +       ring->sched.ready = true;
> +
> +       amdgpu_gfx_enable_hiq(adev);
> +       return 0;
> +}
> +
>  static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>  {
>         int r, i;
> @@ -3946,6 +4010,12 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>         if (r)
>                 return r;
>
> +       if (!adev->kfd.dev) {
> +               r = gfx_v9_0_hiq_resume(adev);
> +               if (r)
> +                       return r;
> +       }
> +
>         if (adev->gfx.num_gfx_rings) {
>                 ring = &adev->gfx.gfx_ring[0];
>                 r = amdgpu_ring_test_helper(ring);
> @@ -4027,6 +4097,11 @@ static int gfx_v9_0_hw_fini(void *handle)
>                 /* disable KCQ to avoid CPC touch memory not valid anymore */
>                 amdgpu_gfx_disable_kcq(adev);
>
> +       if (!adev->kfd.dev) {
> +               if (amdgpu_gfx_disable_hiq(adev))
> +                       DRM_ERROR("HIQ disable failed");
> +       }
> +
>         if (amdgpu_sriov_vf(adev)) {
>                 gfx_v9_0_cp_gfx_enable(adev, false);
>                 /* must disable polling for SRIOV when hw finished, otherwise
> @@ -6986,11 +7061,16 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
>         .emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>  };
>
> +static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_hiq = {
> +       .type = AMDGPU_RING_TYPE_HIQ,
> +};
> +
>  static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
>  {
>         int i;
>
>         adev->gfx.kiq.ring.funcs = &gfx_v9_0_ring_funcs_kiq;
> +       adev->gfx.hiq.ring.funcs = &gfx_v9_0_ring_funcs_hiq;
>
>         for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>                 adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
> --
> 2.31.1
>
