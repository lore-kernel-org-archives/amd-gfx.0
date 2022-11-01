Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66695ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 13:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9298910E3B2;
	Tue,  1 Nov 2022 13:30:09 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB73D10E3B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 13:30:04 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 br15-20020a056830390f00b0061c9d73b8bdso8486398otb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Nov 2022 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DeossCrzOjjZPnG68JviF5JpsIBsDfvvHEqAf7YSRAk=;
 b=nLSQr6KvdiGwPPGDifzGMovMgVRo7PeHnPUOps/vmychcmN41Nvf/ewXte5cVFaM5l
 BPAwDeDQFknaDV2+Lh9x3ZwxrpHtEHERQhj4fVa+xU2jXIMWWkyZPVYIYVacbvI48BGl
 zxP5/kKthmF4Goj6AlSGpjCCE8pcO2Psvy6LUkeo7DDtjU4UkN6Da3T/tLMBzqZpRR3Z
 1CHlb6Lf2mWddHp3YSblX7GtyqK1Jb7SWRjo5ZTJqIl1cKahKxd6Ere17AxrgyKVXt8b
 mVhXf1QthhrN0Mi8i79Lg2RPS1EreUEOpQrjNMzYDCpPaNoK17bN0ULO3JoqjIWRU4kY
 Cktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DeossCrzOjjZPnG68JviF5JpsIBsDfvvHEqAf7YSRAk=;
 b=e7fbGTaQ78B30RxBzX8raUVUNmdakBptwJ8ZZnZmuKTRRdNGqvNXxglR90qX+gJq0S
 m2919DFvLOwq37wbRyFnIfct5m4tPQ64RrhpX0pSroiyL7nvAmcQRUHpJv1GeRciofGW
 wiGZzmKtOWutdA45b3fvbNtiSl7nwTxQ8e1BEPntdQIuoakwS5hEO0jlqhjo0rKS5TrH
 lh9X9aSjrQD6ScugXIGZOU0zyUYHMuvjiHDgUF2/UkYAZpu5FzmWumwY7AJaw/owQ+cM
 BP4/2KOxHS/1wXi6g9pHRuZ1W27Y0wTclgc05QNwufY/Qu51Mpc6RCUaJPEHb1Wu+UCv
 MdBw==
X-Gm-Message-State: ACrzQf29/EWo4PTUN9UbYcTKnDWvgSR6lF9jw7wcr1Nx6BYO98VfANKJ
 cTt6D0e6ELQnKXc1NB82IfthfdMlv1ficbMlDQE=
X-Google-Smtp-Source: AMsMyM7ypigvYRPfl3rJ+V+EBPlTr9WgO95S525uO2JT/cOGYs48KgvVIb6uEtrFmumz3su6syJ7JbTHLRSV7Bn98F4=
X-Received: by 2002:a9d:17e2:0:b0:66a:df04:c198 with SMTP id
 j89-20020a9d17e2000000b0066adf04c198mr9376262otj.123.1667309403837; Tue, 01
 Nov 2022 06:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221101084001.707650-1-yiqing.yao@amd.com>
 <20221101084001.707650-2-yiqing.yao@amd.com>
In-Reply-To: <20221101084001.707650-2-yiqing.yao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Nov 2022 09:29:52 -0400
Message-ID: <CADnq5_MEtRsseGN-CV_jrSN0k+OtwZJfQ1Z6PxHo3n7Q+x_s2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Disable MCBP from soc21 for SRIOV
To: Yiqing Yao <yiqing.yao@amd.com>
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
Cc: alexander.deucher@amd.com, horace.chen@amd.com,
 amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 1, 2022 at 4:41 AM Yiqing Yao <yiqing.yao@amd.com> wrote:
>
> [why]
> Start from soc21, CP does not support MCBP, so disable it.
>
> [how]
> Used amgpu_mcbp flag alone instead of checking if is in SRIOV to
> enable/disable MCBP.
> Only set flag to enable on asic_type prior to soc21 in SRIOV.
>
> Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 2 +-
>  5 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ae10acede495..522820eeaa59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2397,7 +2397,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>                         adev->ip_blocks[i].status.hw = true;
>
>                         /* right after GMC hw init, we create CSA */
> -                       if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
> +                       if (amdgpu_mcbp) {
>                                 r = amdgpu_allocate_static_csa(adev, &adev->virt.csa_obj,
>                                                                 AMDGPU_GEM_DOMAIN_VRAM,
>                                                                 AMDGPU_CSA_SIZE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 363946de78f1..c9595cf1dd0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -796,7 +796,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>                 dev_info->ids_flags = 0;
>                 if (adev->flags & AMD_IS_APU)
>                         dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
> -               if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
> +               if (amdgpu_mcbp)
>                         dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
>                 if (amdgpu_is_tmz(adev))
>                         dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
> @@ -1172,7 +1172,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>                 goto error_vm;
>         }
>
> -       if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
> +       if (amdgpu_mcbp) {
>                 uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
>
>                 r = amdgpu_map_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
> @@ -1236,7 +1236,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>         if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
>                 amdgpu_vce_free_handles(adev, file_priv);
>
> -       if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
> +       if (amdgpu_mcbp) {
>                 /* TODO: how to handle reserve failure */
>                 BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
>                 amdgpu_vm_bo_del(adev, fpriv->csa_va);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index c73abe54d974..dc032c44e924 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -64,6 +64,10 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>         ddev->driver_features &= ~DRIVER_ATOMIC;
>         adev->cg_flags = 0;
>         adev->pg_flags = 0;
> +
> +       /* enable mcbp for sriov asic_type before soc21 */
> +       amdgpu_mcbp = (adev->asic_type < CHIP_IP_DISCOVERY) ? 1 : 0;
> +
>  }
>
>  void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index af94ac580d3e..ff3c127cf70d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8489,7 +8489,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>
>         control |= ib->length_dw | (vmid << 24);
>
> -       if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +       if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
>                 control |= INDIRECT_BUFFER_PRE_ENB(1);
>
>                 if (flags & AMDGPU_IB_PREEMPTED)
> @@ -8664,7 +8664,7 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
>  {
>         uint32_t dw2 = 0;
>
> -       if (amdgpu_mcbp || amdgpu_sriov_vf(ring->adev))
> +       if (amdgpu_mcbp)
>                 gfx_v10_0_ring_emit_ce_meta(ring,
>                                     (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f68e13b6282c..84a76c36d9a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5326,7 +5326,7 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>
>         control |= ib->length_dw | (vmid << 24);
>
> -       if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +       if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
>                 control |= INDIRECT_BUFFER_PRE_ENB(1);
>
>                 if (flags & AMDGPU_IB_PREEMPTED)
> --
> 2.34.1
>
