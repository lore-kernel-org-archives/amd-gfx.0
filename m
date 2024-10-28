Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05112D3E2BB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 269A010E37D;
	Mon, 28 Oct 2024 19:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXaAqgFx";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B924910E37D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:38:50 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-71e702c0ac2so325605b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730144330; x=1730749130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXhhsFfWUMsrDueSjx1ugQmFYT0pG5GtKel9jKxmVYA=;
 b=OXaAqgFxJbqxHyP2EtvEep7CYAthPQ7PzT0v3egWMMn7ABuiF7CGR0Xh+Sn9bjOgGV
 PZePJRuxFr1HKBgWOn9kk9R0PqQhJNgV2cQ8ESHrND0G/WfXKnRoP+RBBZ7qb+UUE49U
 WzT/eWkFl71nHEA3Jg/mauFH52ZaicWS98WjGVSVGg9vnRt3Xgq3RYdoFJC/Y/I1jkjW
 sQH08ZkuoiyTly7SZhXjkGcTzDSypF6d7nX7Gs98QNUGC64ftfFC7x7BM5KU609EpgUJ
 eovu66GeM3g7cT/GISIF2sByHpTC7Wryff4W6UoOvCr07Hb+MH4h5Tj/F/09zya09WQ0
 wXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144330; x=1730749130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXhhsFfWUMsrDueSjx1ugQmFYT0pG5GtKel9jKxmVYA=;
 b=wWIjG9rguNBwOii06xx3NNZJcw0VRucZpyFc5BnQm2DWt7eCa/l5sxWq0AXj0ch6av
 lsKZTMjkqh2VLc366hvn6f48EYAidE+UuBVljjXV5ppR9N2Fw3yHVpZpfpicxN8xqU7D
 mAaCGLe88whTvOifhgiCr+KCMY7S9AFYnEgJPfIFt81kxcsY3S4Rf/GhUrCGSiaE0bRi
 SnF1+2dLtEGcCqnkautKGD6dtHqqTFop03KigUGvcvAz3ZWa+c9gPPmG/d5W44re2b3t
 kbl/IRdPO+xgjLFB1PMUNSgtLi8Pz5ejM34hH0/kZuFV7l8AioHq7G6MjnD7Zim/0CWB
 4Zxg==
X-Gm-Message-State: AOJu0Yy9VW5TG0f3fel98/UNnx+hclAkPzfCRUatwx5Cn+nSi9D4K1WZ
 5vA2V8g57nLeo6ua2UaKYL9Nyv+Jpx+ICPukTCjnsG28asYH+TF3oI0OldagPNGNbzq1zk0fuCA
 gcwQmgi3ljRZC83WiLUZbAb8DX9lo980+
X-Google-Smtp-Source: AGHT+IE45zoILLtXGlTJe8JcWPVkIGgHI+sUocu2p7c+7yOJhorZZg+lG3n1h+JCEGW1lj9sm4JrOfs1zgILcQkh4Rg=
X-Received: by 2002:a05:6a21:3283:b0:1cf:4dae:224e with SMTP id
 adf61e73a8af0-1d9a83af7a3mr6017415637.1.1730144330033; Mon, 28 Oct 2024
 12:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-22-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-22-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:38:38 -0400
Message-ID: <CADnq5_PMqAE04KuxA5tu6njuCDpv_qXWY64tAimEqp_iOqNKMQ@mail.gmail.com>
Subject: Re: [PATCH 21/29] drm/amdgpu: sw_init for each vcn instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Thu, Oct 24, 2024 at 11:58=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_sw_init(), and perform
> sw init ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 83 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  7 ++-
>  10 files changed, 69 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 21701738030f..2c55166e27d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -111,24 +111,23 @@ int amdgpu_vcn_early_init(struct amdgpu_device *ade=
v, int inst)
>         return r;
>  }
>
> -int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
> +int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
>  {
>         unsigned long bo_size;
>         const struct common_firmware_header *hdr;
>         unsigned char fw_check;
>         unsigned int fw_shared_size, log_offset;
> -       int i, r;
> +       int r;
> +
> +       adev->vcn.inst[inst].adev =3D adev;
> +       adev->vcn.inst[inst].work_inst =3D inst;
> +       INIT_DELAYED_WORK(&adev->vcn.inst[inst].idle_work, amdgpu_vcn_idl=
e_work_handler);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               adev->vcn.inst[i].adev =3D adev;
> -               adev->vcn.inst[i].work_inst =3D i;
> -               INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vc=
n_idle_work_handler);
> -       }
>         mutex_init(&adev->vcn.vcn_pg_lock);
>         mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
>         atomic_set(&adev->vcn.total_submission_cnt, 0);
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> -               atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> +
> +       atomic_set(&adev->vcn.inst[inst].dpg_enc_submission_cnt, 0);
>
>         if ((adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) &&
>             (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> @@ -206,45 +205,43 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>         if (amdgpu_vcnfw_log)
>                 bo_size +=3D AMDGPU_VCNFW_LOG_SIZE;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               r =3D amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> -                                           AMDGPU_GEM_DOMAIN_VRAM |
> -                                           AMDGPU_GEM_DOMAIN_GTT,
> -                                           &adev->vcn.inst[i].vcpu_bo,
> -                                           &adev->vcn.inst[i].gpu_addr,
> -                                           &adev->vcn.inst[i].cpu_addr);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) failed to allocate vcn b=
o\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> +                                       AMDGPU_GEM_DOMAIN_VRAM |
> +                                       AMDGPU_GEM_DOMAIN_GTT,
> +                                       &adev->vcn.inst[inst].vcpu_bo,
> +                                       &adev->vcn.inst[inst].gpu_addr,
> +                                       &adev->vcn.inst[inst].cpu_addr);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r)=
;
> +               return r;
> +       }
>
> -               adev->vcn.inst[i].fw_shared.cpu_addr =3D adev->vcn.inst[i=
].cpu_addr +
> -                               bo_size - fw_shared_size;
> -               adev->vcn.inst[i].fw_shared.gpu_addr =3D adev->vcn.inst[i=
].gpu_addr +
> -                               bo_size - fw_shared_size;
> +       adev->vcn.inst[inst].fw_shared.cpu_addr =3D adev->vcn.inst[inst].=
cpu_addr +
> +                       bo_size - fw_shared_size;
> +       adev->vcn.inst[inst].fw_shared.gpu_addr =3D adev->vcn.inst[inst].=
gpu_addr +
> +                       bo_size - fw_shared_size;
>
> -               adev->vcn.inst[i].fw_shared.mem_size =3D fw_shared_size;
> +       adev->vcn.inst[inst].fw_shared.mem_size =3D fw_shared_size;
>
> -               if (amdgpu_vcnfw_log) {
> -                       adev->vcn.inst[i].fw_shared.cpu_addr -=3D AMDGPU_=
VCNFW_LOG_SIZE;
> -                       adev->vcn.inst[i].fw_shared.gpu_addr -=3D AMDGPU_=
VCNFW_LOG_SIZE;
> -                       adev->vcn.inst[i].fw_shared.log_offset =3D log_of=
fset;
> -               }
> +       if (amdgpu_vcnfw_log) {
> +               adev->vcn.inst[inst].fw_shared.cpu_addr -=3D AMDGPU_VCNFW=
_LOG_SIZE;
> +               adev->vcn.inst[inst].fw_shared.gpu_addr -=3D AMDGPU_VCNFW=
_LOG_SIZE;
> +               adev->vcn.inst[inst].fw_shared.log_offset =3D log_offset;
> +       }
>
> -               if (adev->vcn.indirect_sram) {
> -                       r =3D amdgpu_bo_create_kernel(adev, 64 * 2 * 4, P=
AGE_SIZE,
> -                                       AMDGPU_GEM_DOMAIN_VRAM |
> -                                       AMDGPU_GEM_DOMAIN_GTT,
> -                                       &adev->vcn.inst[i].dpg_sram_bo,
> -                                       &adev->vcn.inst[i].dpg_sram_gpu_a=
ddr,
> -                                       &adev->vcn.inst[i].dpg_sram_cpu_a=
ddr);
> -                       if (r) {
> -                               dev_err(adev->dev, "VCN %d (%d) failed to=
 allocate DPG bo\n", i, r);
> -                               return r;
> -                       }
> +       if (adev->vcn.indirect_sram) {
> +               r =3D amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE=
,
> +                               AMDGPU_GEM_DOMAIN_VRAM |
> +                               AMDGPU_GEM_DOMAIN_GTT,
> +                               &adev->vcn.inst[inst].dpg_sram_bo,
> +                               &adev->vcn.inst[inst].dpg_sram_gpu_addr,
> +                               &adev->vcn.inst[inst].dpg_sram_cpu_addr);
> +               if (r) {
> +                       dev_err(adev->dev, "VCN %d (%d) failed to allocat=
e DPG bo\n", inst, r);
> +                       return r;
>                 }
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 58fbb87e5ec4..4809da69bd1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -484,7 +484,7 @@ enum vcn_ring_type {
>  };
>
>  int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
> +int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
>  int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>  int amdgpu_vcn_resume(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 6fd509e6744d..808d69ab0904 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -126,11 +126,12 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>   */
>  static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         struct amdgpu_ring *ring;
>         int i, r;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_1_0);
>         uint32_t *ptr;
> -       struct amdgpu_device *adev =3D ip_block->adev;
>
>         /* VCN DEC TRAP */
>         r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> @@ -146,7 +147,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>                         return r;
>         }
>
> -       r =3D amdgpu_vcn_sw_init(adev);
> +       r =3D amdgpu_vcn_sw_init(adev, inst);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 8f7038190a43..a86cff00d761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -131,11 +131,12 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>   */
>  static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         struct amdgpu_ring *ring;
>         int i, r;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_2_0);
>         uint32_t *ptr;
> -       struct amdgpu_device *adev =3D ip_block->adev;
>         volatile struct amdgpu_fw_shared *fw_shared;
>
>         /* VCN DEC TRAP */
> @@ -154,7 +155,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>                         return r;
>         }
>
> -       r =3D amdgpu_vcn_sw_init(adev);
> +       r =3D amdgpu_vcn_sw_init(adev, inst);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 74814370ddc9..9967ac3fc51b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -156,12 +156,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>   */
>  static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         struct amdgpu_ring *ring;
>         int i, r;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_2_5);
>         uint32_t *ptr;
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -       int inst =3D ip_block->instance;
>
>         if (adev->vcn.harvest_config & (1 << inst))
>                 goto sw_init;
> @@ -185,7 +185,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>  sw_init:
> -       r =3D amdgpu_vcn_sw_init(adev);
> +       r =3D amdgpu_vcn_sw_init(adev, inst);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index a7fb5dda51dd..e89088e3cd1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -160,14 +160,15 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>   */
>  static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         struct amdgpu_ring *ring;
> -       int inst =3D ip_block->instance, j, r;
>         int vcn_doorbell_index =3D 0;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_3_0);
>         uint32_t *ptr;
> -       struct amdgpu_device *adev =3D ip_block->adev;
> +       int j, r;
>
> -       r =3D amdgpu_vcn_sw_init(adev);
> +       r =3D amdgpu_vcn_sw_init(adev, inst);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index c0c2a071ea15..1b492197c2b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -168,14 +168,15 @@ static int vcn_v4_0_fw_shared_init(struct amdgpu_de=
vice *adev, int inst_idx)
>   */
>  static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> -       struct amdgpu_ring *ring;
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int inst =3D ip_block->instance, r;
> +       int inst =3D ip_block->instance;
> +       struct amdgpu_ring *ring;
> +       int r;
>
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_4_0);
>         uint32_t *ptr;
>
> -       r =3D amdgpu_vcn_sw_init(adev);
> +       r =3D amdgpu_vcn_sw_init(adev, inst);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 1d1ee6da7647..5b61000f3004 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -127,12 +127,13 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_b=
lock *ip_block)
>  static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         struct amdgpu_ring *ring;
> -       int inst =3D ip_block->instance, r, vcn_inst;
> +       int r, vcn_inst;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_4_0_3);
>         uint32_t *ptr;
>
> -       r =3D amdgpu_vcn_sw_init(adev);
> +       r =3D amdgpu_vcn_sw_init(adev, inst);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 81efc53e7cd3..4d944636d02b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -131,13 +131,14 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_b=
lock *ip_block)
>   */
>  static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> -       struct amdgpu_ring *ring;
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int inst =3D ip_block->instance, r;
> +       int inst =3D ip_block->instance;
> +       struct amdgpu_ring *ring;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_4_0_5);
>         uint32_t *ptr;
> +       int r;
>
> -       r =3D amdgpu_vcn_sw_init(adev);
> +       r =3D amdgpu_vcn_sw_init(adev, inst);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 7873ca91da4c..8efedf943581 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -115,13 +115,14 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_b=
lock *ip_block)
>   */
>  static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
> -       struct amdgpu_ring *ring;
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int inst =3D ip_block->instance, r;
> +       int inst =3D ip_block->instance;
> +       struct amdgpu_ring *ring;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_5_0);
>         uint32_t *ptr;
> +       int r;
>
> -       r =3D amdgpu_vcn_sw_init(adev);
> +       r =3D amdgpu_vcn_sw_init(adev, inst);
>         if (r)
>                 return r;
>
> --
> 2.34.1
>
