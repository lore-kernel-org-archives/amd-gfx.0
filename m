Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B91BC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 17:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5177510EE2F;
	Thu,  2 Jun 2022 17:17:19 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2216210EE2F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 17:17:18 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-e93bbb54f9so7504593fac.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XDqvX8QBWl0fv3Q3Ifnswm3aoNzadzHlH0fOFs9SpFM=;
 b=mFqvZc1CqBpXvyeoHDfCfrWi287Am4JsSxWHF+rBX8/iRp9nxj4ibaE+etssPKCNm0
 G892+yVyO0zc9yIvmD51bRnpGGiSLvdnnVxr0KVWrYhW1YGi4TLBtryJWPRWAXAS8v6a
 7wtK/11R3NMhFhKNNOOdsYB15gpKw6A1w6lQGu7awI4pdd7dw+k+V4ZD7h+PnSPubqrE
 8oShJAPggxd/UB5XYgq8D9pnDwCy8jFGPNtvZ4Tl6SQsz+K5fHoM6YL6f1JRI+RieYVD
 +A/BaEFad6SySWaK49PfEEzytajfA5Cj/yYS0trDvjaVCPVroe30o4KOpxPfx8m4Va8J
 JvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XDqvX8QBWl0fv3Q3Ifnswm3aoNzadzHlH0fOFs9SpFM=;
 b=eSO4m1kzwkzkRyQm2L0E2h1oRsRueRYkneCKWYvd4KggTz3y0pH1io3A9f1eu/pHnb
 9xy3F2JhOscz7YsnyPcO1mvqlyNGJoXUlhYl3bCAtAtm2N2pHk8KEwkDRvlajoPfW0zd
 rzJ6Y3F3O6yjEBmTYgyHcYhn14lVdvvzE7Z8QCGkiSpxFXRF6yP5K4trA1wXWDUkhXPk
 XE25UxNsp162/h06gQ5LuAGB8MTRKLX3sRrh4PBaAB5yqs1z7sh8Zcab3CFP9PxluxAa
 bgDEzcf3N8xufYeNv3IgjClQSC08sXTWXOHxU22vsWSBmJzGh+Xvbu+uZ1vA2YgjLE/R
 zvBg==
X-Gm-Message-State: AOAM5336g6a2eYDJfEYuHhRRVumGcrqhKwfhUIL4ZD710Qy1syVtU2GU
 E/k1XTSpAhQ6PYiaOmpuYsWiNgiPgGOUkWQb9pKUFLBE
X-Google-Smtp-Source: ABdhPJyRqC1e12qD5TurUPitLqeMxwZpot8bUkzDNXqQx/jvpPYYRsHXp3KP6rA/BLA3/4YYi0oaT4hNAy3e8BWvl+8=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr19470608oaa.200.1654190237357; Thu, 02
 Jun 2022 10:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220602161210.19380-1-luben.tuikov@amd.com>
 <20220602161210.19380-2-luben.tuikov@amd.com>
In-Reply-To: <20220602161210.19380-2-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Jun 2022 13:17:05 -0400
Message-ID: <CADnq5_OVRyYs0NYYjNH82BVp=PAfs34X_+C9NFrWYPpAhCmw5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: use VRAM|GTT for a bunch of kernel
 allocations
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 2, 2022 at 12:12 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Technically all of those can use GTT as well, no need to force things
> into VRAM.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 20 +++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c       |  9 ++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 14 +++++++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  3 ++-
>  .../amd/pm/powerplay/smumgr/smu10_smumgr.c    | 10 ++++------

We need to audit the new files which have been added since the time
this patch set was written.  E.g., gfx_v10_.c and gfx_v11_0.c, and
psp_v11_0.c, swsmu, etc. have been added in the meantime.

Alex

>  7 files changed, 41 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 16699158e00d8c..d799815a0f288f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -338,8 +338,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ade=
v,
>                  * KIQ MQD no matter SRIOV or Bare-metal
>                  */
>                 r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> -                                           AMDGPU_GEM_DOMAIN_VRAM, &ring=
->mqd_obj,
> -                                           &ring->mqd_gpu_addr, &ring->m=
qd_ptr);
> +                                           AMDGPU_GEM_DOMAIN_VRAM |
> +                                           AMDGPU_GEM_DOMAIN_GTT,
> +                                           &ring->mqd_obj,
> +                                           &ring->mqd_gpu_addr,
> +                                           &ring->mqd_ptr);
>                 if (r) {
>                         dev_warn(adev->dev, "failed to create ring mqd ob=
 (%d)", r);
>                         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index e9411c28d88ba8..116f7fa25aa636 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -748,9 +748,12 @@ static int psp_tmr_init(struct psp_context *psp)
>         }
>
>         pptr =3D amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> -       ret =3D amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE=
(psp->adev),
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> -                                     &psp->tmr_bo, &psp->tmr_mc_addr, pp=
tr);
> +       ret =3D amdgpu_bo_create_kernel(psp->adev, tmr_size,
> +                                     PSP_TMR_SIZE(psp->adev),
> +                                     AMDGPU_GEM_DOMAIN_VRAM |
> +                                     AMDGPU_GEM_DOMAIN_GTT,
> +                                     &psp->tmr_bo, &psp->tmr_mc_addr,
> +                                     pptr);
>
>         return ret;
>  }
> @@ -1039,7 +1042,8 @@ int psp_ta_init_shared_buf(struct psp_context *psp,
>         * physical) for ta to host memory
>         */
>         return amdgpu_bo_create_kernel(psp->adev, mem_ctx->shared_mem_siz=
e,
> -                                     PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
> +                                     PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM |
> +                                     AMDGPU_GEM_DOMAIN_GTT,
>                                       &mem_ctx->shared_bo,
>                                       &mem_ctx->shared_mc_addr,
>                                       &mem_ctx->shared_buf);
> @@ -3397,10 +3401,10 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct =
device *dev,
>
>         /* LFB address which is aligned to 1MB boundary per PSP request *=
/
>         ret =3D amdgpu_bo_create_kernel(adev, usbc_pd_fw->size, 0x100000,
> -                                               AMDGPU_GEM_DOMAIN_VRAM,
> -                                               &fw_buf_bo,
> -                                               &fw_pri_mc_addr,
> -                                               &fw_pri_cpu_addr);
> +                                     AMDGPU_GEM_DOMAIN_VRAM |
> +                                     AMDGPU_GEM_DOMAIN_GTT,
> +                                     &fw_buf_bo, &fw_pri_mc_addr,
> +                                     &fw_pri_cpu_addr);
>         if (ret)
>                 goto rel_buf;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_rlc.c
> index 6373bfb47d55d7..c591ed6553fcc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> @@ -93,7 +93,8 @@ int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, =
u32 dws)
>
>         /* allocate save restore block */
>         r =3D amdgpu_bo_create_reserved(adev, dws * 4, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> +                                     AMDGPU_GEM_DOMAIN_VRAM |
> +                                     AMDGPU_GEM_DOMAIN_GTT,
>                                       &adev->gfx.rlc.save_restore_obj,
>                                       &adev->gfx.rlc.save_restore_gpu_add=
r,
>                                       (void **)&adev->gfx.rlc.sr_ptr);
> @@ -130,7 +131,8 @@ int amdgpu_gfx_rlc_init_csb(struct amdgpu_device *ade=
v)
>         /* allocate clear state block */
>         adev->gfx.rlc.clear_state_size =3D dws =3D adev->gfx.rlc.funcs->g=
et_csb_size(adev);
>         r =3D amdgpu_bo_create_kernel(adev, dws * 4, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> +                                     AMDGPU_GEM_DOMAIN_VRAM |
> +                                     AMDGPU_GEM_DOMAIN_GTT,
>                                       &adev->gfx.rlc.clear_state_obj,
>                                       &adev->gfx.rlc.clear_state_gpu_addr=
,
>                                       (void **)&adev->gfx.rlc.cs_ptr);
> @@ -156,7 +158,8 @@ int amdgpu_gfx_rlc_init_cpt(struct amdgpu_device *ade=
v)
>         int r;
>
>         r =3D amdgpu_bo_create_reserved(adev, adev->gfx.rlc.cp_table_size=
,
> -                                     PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
> +                                     PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM |
> +                                     AMDGPU_GEM_DOMAIN_GTT,
>                                       &adev->gfx.rlc.cp_table_obj,
>                                       &adev->gfx.rlc.cp_table_gpu_addr,
>                                       (void **)&adev->gfx.rlc.cp_table_pt=
r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index aa7acfabf360b0..10350387687e89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -263,8 +263,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>                         continue;
>
>                 r =3D amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> -                                               AMDGPU_GEM_DOMAIN_VRAM, &=
adev->vcn.inst[i].vcpu_bo,
> -                                               &adev->vcn.inst[i].gpu_ad=
dr, &adev->vcn.inst[i].cpu_addr);
> +                                           AMDGPU_GEM_DOMAIN_VRAM |
> +                                           AMDGPU_GEM_DOMAIN_GTT,
> +                                           &adev->vcn.inst[i].vcpu_bo,
> +                                           &adev->vcn.inst[i].gpu_addr,
> +                                           &adev->vcn.inst[i].cpu_addr);
>                 if (r) {
>                         dev_err(adev->dev, "(%d) failed to allocate vcn b=
o\n", r);
>                         return r;
> @@ -285,8 +288,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>
>                 if (adev->vcn.indirect_sram) {
>                         r =3D amdgpu_bo_create_kernel(adev, 64 * 2 * 4, P=
AGE_SIZE,
> -                                       AMDGPU_GEM_DOMAIN_VRAM, &adev->vc=
n.inst[i].dpg_sram_bo,
> -                                       &adev->vcn.inst[i].dpg_sram_gpu_a=
ddr, &adev->vcn.inst[i].dpg_sram_cpu_addr);
> +                                       AMDGPU_GEM_DOMAIN_VRAM |
> +                                       AMDGPU_GEM_DOMAIN_GTT,
> +                                       &adev->vcn.inst[i].dpg_sram_bo,
> +                                       &adev->vcn.inst[i].dpg_sram_gpu_a=
ddr,
> +                                       &adev->vcn.inst[i].dpg_sram_cpu_a=
ddr);
>                         if (r) {
>                                 dev_err(adev->dev, "VCN %d (%d) failed to=
 allocate DPG bo\n", i, r);
>                                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 5349ca4d19e38b..36bd6e5c52ec01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1948,7 +1948,8 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *=
adev)
>         mec_hpd_size =3D adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
>         if (mec_hpd_size) {
>                 r =3D amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_=
SIZE,
> -                                             AMDGPU_GEM_DOMAIN_VRAM,
> +                                             AMDGPU_GEM_DOMAIN_VRAM |
> +                                             AMDGPU_GEM_DOMAIN_GTT,
>                                               &adev->gfx.mec.hpd_eop_obj,
>                                               &adev->gfx.mec.hpd_eop_gpu_=
addr,
>                                               (void **)&hpd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v10_0.c
> index ed2293686f0de3..48ca4a501d40fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> @@ -140,7 +140,8 @@ static int psp_v10_0_ring_init(struct psp_context *ps=
p,
>         /* allocate 4k Page of Local Frame Buffer memory for ring */
>         ring->ring_size =3D 0x1000;
>         ret =3D amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> +                                     AMDGPU_GEM_DOMAIN_VRAM |
> +                                     AMDGPU_GEM_DOMAIN_GTT,
>                                       &adev->firmware.rbuf,
>                                       &ring->ring_mem_mc_addr,
>                                       (void **)&ring->ring_mem);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> index 88a5641465dcf5..7eeab84d421ac3 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> @@ -250,9 +250,8 @@ static int smu10_smu_init(struct pp_hwmgr *hwmgr)
>
>         /* allocate space for watermarks table */
>         r =3D amdgpu_bo_create_kernel((struct amdgpu_device *)hwmgr->adev=
,
> -                       sizeof(Watermarks_t),
> -                       PAGE_SIZE,
> -                       AMDGPU_GEM_DOMAIN_VRAM,
> +                       sizeof(Watermarks_t), PAGE_SIZE,
> +                       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
>                         &priv->smu_tables.entry[SMU10_WMTABLE].handle,
>                         &priv->smu_tables.entry[SMU10_WMTABLE].mc_addr,
>                         &priv->smu_tables.entry[SMU10_WMTABLE].table);
> @@ -266,9 +265,8 @@ static int smu10_smu_init(struct pp_hwmgr *hwmgr)
>
>         /* allocate space for watermarks table */
>         r =3D amdgpu_bo_create_kernel((struct amdgpu_device *)hwmgr->adev=
,
> -                       sizeof(DpmClocks_t),
> -                       PAGE_SIZE,
> -                       AMDGPU_GEM_DOMAIN_VRAM,
> +                       sizeof(DpmClocks_t), PAGE_SIZE,
> +                       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
>                         &priv->smu_tables.entry[SMU10_CLOCKTABLE].handle,
>                         &priv->smu_tables.entry[SMU10_CLOCKTABLE].mc_addr=
,
>                         &priv->smu_tables.entry[SMU10_CLOCKTABLE].table);
> --
> 2.36.1.74.g277cf0bc36
>
