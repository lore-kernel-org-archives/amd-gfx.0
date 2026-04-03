Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6F7E8536F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 15:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A20710E2E7;
	Fri,  3 Apr 2026 15:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i3+2qyKq";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1884610E2E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 15:09:13 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2c6f5574d07so91394eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 08:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775228952; cv=none;
 d=google.com; s=arc-20240605;
 b=eQBBcJkBXQIkJXM0wHc9VIc/u+VhuWunop+A8Ip1aTHjum1MIcy1qC8/ac8jtI5I4U
 EC+SNoxYV1t8xdJ+9gdYF6Liu162/o9jAaymDrRowyqcIgnt+449QCnt3apJTpN15/22
 4ufynvdT4R49ihZWDpzZEimWe5oi7o6idH7a0iT8H3SXPxHRocdTfLvCSAZ7RgXFZnsP
 xBfa8zufV8f2eBzrHS5Y1CChTi+FNADBt2PiGVgrDmwl03UFNaeiw6oDYyF6ehPqrgqJ
 13T7phq26e014neHlgy1GG12acSIPyhML4tCDMHYr3RMGHMn9uPoDS8EtDN3dhJMEJu+
 FAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ySm18I50w2Osh/s30iO8ArkEhEYO2UbR9UJNMHtUsKs=;
 fh=KjJfJ4Iy4rwBkFmL/F7JSq4PGjjxLaK6J8s/7j3+QbI=;
 b=RKhJAazgQCPwjRACZYUaB6nTgHev5o0IMCgVqghdN+2lsCNs/jKvQrnZDsb8HIrx08
 eKLuG5hOjjxxQBWifMthAQRmJ70ioBKQkssy29NEEVAsvKsnUeVyRcClSQYRXsH733cY
 fXWIyIZ3urL23DJeRfqwD28vQO5hE6bbrxNFw+33gonY5pgRBd/+1hXLT+/R0WZENVYx
 1EOC659L5vxrihDdZujoqW24bIc9jq5goNgmTgRNMK5Ilg7QCX9juubXxSL8gGH81E3/
 U1/eUs8A/qe2HCpsPaH7yo6lcdedQtevcoCmrvfTqNLa0pGiHIBl9RfxtxqefodDqrHA
 EndQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775228952; x=1775833752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySm18I50w2Osh/s30iO8ArkEhEYO2UbR9UJNMHtUsKs=;
 b=i3+2qyKqU059Qic2P74M9cZ7Gbm54F+rdrQ4kPIM/kNmKQxTcD+xee/MqKopVCn4Bj
 3LkUSw/CRKIWmYsNU61vWpSEiDmcGfRA7cc8pn/SEg1YXzjsER9u+8T4ZwLuSNH7oO85
 22E17kwBN2WDWj0fgNEF6i3AKdT70vxgfuLHDb0h3nf7fE6Qkyg5vkDAns4POkGbMcVC
 8U7oHP+DKC/+zDt+4w7w6KTHUb2n5V1gAG709an32yRXbEucf7dRDkTIti/QjnXTvHUY
 3t3Vtzt2HSCRStM6iAgR1lsHiktr6XdIv5gsQTuz2ozx2f/WSF/9crNWGZ09FenzfNZ6
 TjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775228952; x=1775833752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ySm18I50w2Osh/s30iO8ArkEhEYO2UbR9UJNMHtUsKs=;
 b=qI1a2OP7mFBgc8G39reJimwkqksiNBtzHl4+xYwuOAvKxGjEKaOxOMKvbKJJnXS7rx
 PD/D+N6bswLkqsq+hNvlWdMHFbcQh1IfOqV08TKlzXYssr7xWjQ5iOXW+zYmtWzty11V
 W1akt27C5A+JopIfYyj+B1jNSHcA7XIZfmJDoF8kTJOxrYudaPYe6qVIIsE0sXyzpebr
 5e3rbjk1SSuynObsC49obnKBz2jAuNc9lmf3WRObnk3fRULIfJHSMMLcooW9hg2nykIq
 OBf25XLWwIqMHJr8xjjLQDXWpI/zMtYO4SPnmp6oSK/nLYZXXeD2lY0yNsWf1IfVmBDW
 sv1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1RI2vfzfwleYhThWFCtKkMK9R8yaBFBhxmdWdJsKQ5ZdhZf+tmfPmt26HdlhTGf1mOIvN6zog@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzfqm7q3/tBArdieze7+03/9FMN5RoT3MfEnIPvOe2/E+DPXuzC
 fNs+gttujsYmNBGRwiVgTm0E1ckz0mMIfepkCDw822KVckNpntfjFhFy1DLZl+xAWRihxOa/Nzk
 0BZwAGjd1gOldlMYuWw/UAT11/B2x+Cqs90AU
X-Gm-Gg: ATEYQzwmLxdcQqdGfOAOMqq+dQ3M4ygy9YO/akQ/sMvMLBNEPx5RaEzCHbPSVEZiQH0
 XJb4Ig15tAmzlLpRLrG6iJsyaSuL9j1g05qn9bSO7UvHMS7Tsiyq5p/t2eU04UrITK+EPoIo1ne
 wUVS3NSUnBVwf1iUu0I/3ZLI5AtcJ/fFTLUrLbfE6Al+Sm1g150L0szkqPpJQ/ZBgJUwpuXTI9A
 Z6YRgYs3vZDGDQTobEVeo+RJL8T9QPuS0U1vz6gdPagmQg86Y0t+tQB0qJ288p9Ugadhg4Tu0yY
 aqS8lLdckAWzyqBFvBR8j9NXEkFyr/iMARftrQtdHO+tgCfKYkjU4xPee8ox6Vd8FxLkoA==
X-Received: by 2002:a05:7022:10d:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-12bfb746108mr656424c88.4.1775228952106; Fri, 03 Apr 2026
 08:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 11:08:59 -0400
X-Gm-Features: AQROBzBGBXByArJ4RUe0EpVzhmg-ymbhRpDXLjB7tPhu00FmtjEUwVtgxwVYEak
Message-ID: <CADnq5_NwbqrJAmrBKsG_BgGGtYCpM=MGc+Bpyvwr0hdVbmMYHA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] drm/amdgpu: pass all the sdma scheds to amdgpu_mman
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 3, 2026 at 4:36=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> This will allow the use of all of them for clear/fill buffer
> operations.
> Since drm_sched_entity_init requires a scheduler array, we
> store schedulers rather than rings. For the few places that need
> access to a ring, we can get it from the sched using container_of.
>
> Since the code is the same for all sdma versions, add a new
> helper amdgpu_sdma_set_buffer_funcs_scheds to set buffer_funcs_scheds
> based on the number of sdma instances.
>
> Note: the new sched array is identical to the amdgpu_vm_manager one.
> These 2 could be merged.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 32 ++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 +-
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  8 ++----
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  6 +---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  5 +---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  5 +---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/si_dma.c        |  3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  3 +-
>  17 files changed, 48 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 49e7881750fa..e3a8701f0b27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1467,6 +1467,8 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amdg=
pu_ring *ring);
>  ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
>  void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_device *adev,
>                                    const struct amdgpu_vm_pte_funcs *vm_p=
te_funcs);
> +void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
> +                                        const struct amdgpu_buffer_funcs=
 *buffer_funcs);
>
>  /* atpx handler */
>  #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0c0489395edf..4da8de34be3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3700,7 +3700,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         adev->num_rings =3D 0;
>         RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>         adev->mman.buffer_funcs =3D NULL;
> -       adev->mman.buffer_funcs_ring =3D NULL;
> +       adev->mman.num_buffer_funcs_scheds =3D 0;
>         adev->vm_manager.vm_pte_funcs =3D NULL;
>         adev->vm_manager.vm_pte_num_scheds =3D 0;
>         adev->gmc.gmc_funcs =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index e9e53c7c37d0..1a253e4257ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -708,12 +708,14 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_de=
vice *adev)
>  void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>                               uint32_t vmhub, uint32_t flush_type)
>  {
> -       struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
> +       struct amdgpu_ring *ring;
>         struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
>         struct dma_fence *fence;
>         struct amdgpu_job *job;
>         int r;
>
> +       ring =3D to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
> +
>         if (!hub->sdma_invalidation_workaround || vmid ||
>             !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
>             !ring->sched.ready) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 3c63f87832e4..4ba7321b75e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -168,7 +168,7 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, str=
uct amdgpu_ttm_buffer_entit
>  {
>         struct amdgpu_ring *ring;
>
> -       ring =3D adev->mman.buffer_funcs_ring;
> +       ring =3D to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>         amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>         WARN_ON(job->ibs[0].length_dw > num_dw);
>
> @@ -2349,18 +2349,17 @@ void amdgpu_ttm_set_buffer_funcs_status(struct am=
dgpu_device *adev, bool enable)
>                 return;
>
>         if (enable) {
> -               struct amdgpu_ring *ring;
>                 struct drm_gpu_scheduler *sched;
>
> -               if (!adev->mman.buffer_funcs_ring || !adev->mman.buffer_f=
uncs_ring->sched.ready) {
> +               if (!adev->mman.num_buffer_funcs_scheds ||
> +                   !adev->mman.buffer_funcs_scheds[0]->ready) {
>                         dev_warn(adev->dev, "Not enabling DMA transfers f=
or in kernel use");
>                         return;
>                 }
>
>                 num_clear_entities =3D 1;
>                 num_move_entities =3D 1;
> -               ring =3D adev->mman.buffer_funcs_ring;
> -               sched =3D &ring->sched;
> +               sched =3D adev->mman.buffer_funcs_scheds[0];
>                 r =3D amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
>                                                   &adev->mman.default_ent=
ity,
>                                                   DRM_SCHED_PRIORITY_KERN=
EL,
> @@ -2497,7 +2496,7 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>         unsigned int i;
>         int r;
>
> -       ring =3D adev->mman.buffer_funcs_ring;
> +       ring =3D to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>
>         if (!ring->sched.ready) {
>                 dev_err(adev->dev,
> @@ -2730,6 +2729,27 @@ int amdgpu_ttm_evict_resources(struct amdgpu_devic=
e *adev, int mem_type)
>         return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>  }
>
> +void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
> +                                        const struct amdgpu_buffer_funcs=
 *buffer_funcs)
> +{
> +       struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];

Only gfx9 and newer have multiple hubs.  Additionally, sdma 4.x is
attached to mmhub.  sdma 5.x is attached to gfxhub.  Might be worth a
comment here that this is just for the sdma_invalidation_workaround
check so it's only relevant for specific chips that have that set in
case someone attempts to do something else here in the future.

Alex

> +       struct drm_gpu_scheduler *sched;
> +       int i;
> +
> +       adev->mman.buffer_funcs =3D buffer_funcs;
> +
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               if (adev->sdma.has_page_queue)
> +                       sched =3D &adev->sdma.instance[i].page.sched;
> +               else
> +                       sched =3D &adev->sdma.instance[i].ring.sched;
> +               adev->mman.buffer_funcs_scheds[i] =3D sched;
> +       }
> +
> +       adev->mman.num_buffer_funcs_scheds =3D hub->sdma_invalidation_wor=
karound ?
> +               1 : adev->sdma.num_instances;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
>  static int amdgpu_ttm_page_pool_show(struct seq_file *m, void *unused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index 3b1973611446..a6249252948b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -67,7 +67,8 @@ struct amdgpu_mman {
>
>         /* buffer handling */
>         const struct amdgpu_buffer_funcs        *buffer_funcs;
> -       struct amdgpu_ring                      *buffer_funcs_ring;
> +       struct drm_gpu_scheduler                *buffer_funcs_scheds[AMDG=
PU_MAX_RINGS];
> +       u32                                     num_buffer_funcs_scheds;
>         bool                                    buffer_funcs_enabled;
>
>         /* @default_entity: for workarounds, has no gart windows */
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/=
amdgpu/cik_sdma.c
> index 22780c09177d..26276dcfd458 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -1340,8 +1340,7 @@ static const struct amdgpu_buffer_funcs cik_sdma_bu=
ffer_funcs =3D {
>
>  static void cik_sdma_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       adev->mman.buffer_funcs =3D &cik_sdma_buffer_funcs;
> -       adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].ring;
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &cik_sdma_buffer_funcs)=
;
>  }
>
>  const struct amdgpu_ip_block_version cik_sdma_ip_block =3D
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v2_4.c
> index 0090ace49024..c6a059ca59e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -1235,8 +1235,7 @@ static const struct amdgpu_buffer_funcs sdma_v2_4_b=
uffer_funcs =3D {
>
>  static void sdma_v2_4_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       adev->mman.buffer_funcs =3D &sdma_v2_4_buffer_funcs;
> -       adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].ring;
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v2_4_buffer_funcs=
);
>  }
>
>  const struct amdgpu_ip_block_version sdma_v2_4_ip_block =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v3_0.c
> index 2526d393162a..cb516a25210d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1677,8 +1677,7 @@ static const struct amdgpu_buffer_funcs sdma_v3_0_b=
uffer_funcs =3D {
>
>  static void sdma_v3_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       adev->mman.buffer_funcs =3D &sdma_v3_0_buffer_funcs;
> -       adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].ring;
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v3_0_buffer_funcs=
);
>  }
>
>  const struct amdgpu_ip_block_version sdma_v3_0_ip_block =3D
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index 44f0f23e1148..d56be26f216b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2626,13 +2626,9 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_=
buffer_funcs =3D {
>  static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
>         if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >=3D IP_VERSION(4, 4, =
0))
> -               adev->mman.buffer_funcs =3D &sdma_v4_4_buffer_funcs;
> +               amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_buff=
er_funcs);
>         else
> -               adev->mman.buffer_funcs =3D &sdma_v4_0_buffer_funcs;
> -       if (adev->sdma.has_page_queue)
> -               adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].=
page;
> -       else
> -               adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].=
ring;
> +               amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_0_buff=
er_funcs);
>  }
>
>  static void sdma_v4_0_get_ras_error_count(uint32_t value,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 78bdfed0a7fd..67e9697301b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2316,11 +2316,7 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_=
2_buffer_funcs =3D {
>
>  static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       adev->mman.buffer_funcs =3D &sdma_v4_4_2_buffer_funcs;
> -       if (adev->sdma.has_page_queue)
> -               adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].=
page;
> -       else
> -               adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].=
ring;
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_2_buffer_fun=
cs);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index 52f4e9e099cb..86f5eb784d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -2052,10 +2052,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_0_=
buffer_funcs =3D {
>
>  static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       if (adev->mman.buffer_funcs =3D=3D NULL) {
> -               adev->mman.buffer_funcs =3D &sdma_v5_0_buffer_funcs;
> -               adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].=
ring;
> -       }
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_0_buffer_funcs=
);
>  }
>
>  const struct amdgpu_ip_block_version sdma_v5_0_ip_block =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index b4fb90cc8f7d..3fec838374b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -2056,10 +2056,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_2_=
buffer_funcs =3D {
>
>  static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       if (adev->mman.buffer_funcs =3D=3D NULL) {
> -               adev->mman.buffer_funcs =3D &sdma_v5_2_buffer_funcs;
> -               adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].=
ring;
> -       }
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_2_buffer_funcs=
);
>  }
>
>  const struct amdgpu_ip_block_version sdma_v5_2_ip_block =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index b005672f2f96..064508cecd11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1895,8 +1895,7 @@ static const struct amdgpu_buffer_funcs sdma_v6_0_b=
uffer_funcs =3D {
>
>  static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       adev->mman.buffer_funcs =3D &sdma_v6_0_buffer_funcs;
> -       adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].ring;
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v6_0_buffer_funcs=
);
>  }
>
>  const struct amdgpu_ip_block_version sdma_v6_0_ip_block =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_0.c
> index 5679a94d0815..60447729271e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1845,8 +1845,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_0_b=
uffer_funcs =3D {
>
>  static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       adev->mman.buffer_funcs =3D &sdma_v7_0_buffer_funcs;
> -       adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].ring;
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_0_buffer_funcs=
);
>  }
>
>  const struct amdgpu_ip_block_version sdma_v7_0_ip_block =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_1.c
> index f20e0fc3fc74..c3428d2731dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1764,8 +1764,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_1_b=
uffer_funcs =3D {
>
>  static void sdma_v7_1_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       adev->mman.buffer_funcs =3D &sdma_v7_1_buffer_funcs;
> -       adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].ring;
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_1_buffer_funcs=
);
>  }
>
>  const struct amdgpu_ip_block_version sdma_v7_1_ip_block =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/am=
dgpu/si_dma.c
> index 3e58feb2d5e4..155067c20a0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -833,8 +833,7 @@ static const struct amdgpu_buffer_funcs si_dma_buffer=
_funcs =3D {
>
>  static void si_dma_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -       adev->mman.buffer_funcs =3D &si_dma_buffer_funcs;
> -       adev->mman.buffer_funcs_ring =3D &adev->sdma.instance[0].ring;
> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &si_dma_buffer_funcs);
>  }
>
>  const struct amdgpu_ip_block_version si_dma_ip_block =3D
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 964efa325908..28dc6886c1ff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -129,13 +129,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *=
adev, dma_addr_t *sys,
>                              struct dma_fence **mfence)
>  {
>         const u64 GTT_MAX_PAGES =3D AMDGPU_GTT_MAX_TRANSFER_SIZE;
> -       struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
> +       struct amdgpu_ring *ring;
>         struct amdgpu_ttm_buffer_entity *entity;
>         u64 gart_s, gart_d;
>         struct dma_fence *next;
>         u64 size;
>         int r;
>
> +       ring =3D to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>         entity =3D &adev->mman.move_entities[0];
>
>         mutex_lock(&entity->lock);
> --
> 2.43.0
>
