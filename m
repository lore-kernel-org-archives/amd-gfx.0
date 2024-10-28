Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DB4D3E2BC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA5610E53E;
	Mon, 28 Oct 2024 19:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eHDA1jRD";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6813010E53E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:42:37 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7202e1a0209so346158b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730144557; x=1730749357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+33xlsUWMMYutOpTmt1UkADb8S7VmE9KtPmjeQ7Cd3k=;
 b=eHDA1jRDW+U/489A7Q1oO5tlR04XFNjmOCfcfOJqDQOzuRailn/YfNWVFNe3/Rr9Lg
 bcW/8iVmkqppfh8Eg8FfybFt/NF7FB6k/CrkpxzyStDPia3ojYWYIXafNuAq0hSvmi7E
 T9YHPX9C8F5FvC2gwl4awqpRGfUGYlx3/UwEHNfPqu73WgT/+9KJTviYXgMtjcZBg3zV
 Nwsvr0lIZuHpa5tBC4tnnW1V6EnqGgOx/DA6nwKHLyv2filUhEQXBPY/Uk7hZDiqSQ2F
 KxKQ9LpIe7IIjfglDEEOFyF/q1XNUF3qwbTAljuMeChQrCbYfe0TpFMiaIQ9z03deKd+
 XkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144557; x=1730749357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+33xlsUWMMYutOpTmt1UkADb8S7VmE9KtPmjeQ7Cd3k=;
 b=PkKp3wreVMxqUluSNJcNxQt0MaV8LUmtT138I/AI1q+vpxPEYNpctgBavhMe0JI8EU
 rIji4b2umvMdPgFaFpCllbzMLFHsiCU+CKijvVISl2+IxZYCBhZt9BEQBiQh/MVu3Lzk
 u/LET0+buviAnLAteT5rwvtH+RoMR4wtD9ZEO0yHc/2yXXXAIQJQkgvpY045ZHjWEYOu
 uUgndos3f37UlkJQDEDw63kzF6acW/N0/DnPDaa6F2LMK8uHet9N+jDt3VqiOCxYAT/A
 KYHpAxJFTjffaQV1HM9RwJJ9ZyLS+CO1KzQBsCQygS1VJefrHpDWmd18/5hytJbVEQIW
 f99w==
X-Gm-Message-State: AOJu0YwmEYCRvwaAF9e4BRt3GbswzEUP4PFlTAqiVmb993l620qkric9
 io7WtRMdXJkRRUUyqbYzokaDvx5umw8Z5AnTaYioJGZ27cD4biYaFiA8el3G14HxrCs4kdFMfX+
 Nq0BqJcXsIVUSnFSvLJW6CLkN4T8YhJR6
X-Google-Smtp-Source: AGHT+IEA0Rhp3dXM4R5cuguFRaDfzMycFmJBNHPm6oF4XPIqFeFNbFRnTvR23c9jRzuf6Tt0uE+o6ng4Nw+dt1Hz5Xo=
X-Received: by 2002:a05:6a00:182a:b0:71e:5099:22bf with SMTP id
 d2e1a72fcca58-7206307c53dmr5448080b3a.7.1730144556684; Mon, 28 Oct 2024
 12:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-25-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-25-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:42:25 -0400
Message-ID: <CADnq5_N0WawWqwbaeUuz10hY0ESggTnO9bv2eDOVKO4j7+d=Ww@mail.gmail.com>
Subject: Re: [PATCH 24/29] drm/amdgpu: suspend for each vcn instance
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

On Thu, Oct 24, 2024 at 10:36=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_suspend(), and perform
> suspend ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> v2: add vcn instance to amdgpu_vcn_save_vcpu_bo()
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 13 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 38 +++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  4 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  7 +++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   |  6 ++--
>  11 files changed, 59 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index 24dae7cdbe95..4fc0ee01d56b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -42,13 +42,14 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(st=
ruct amdgpu_device *adev)
>                 /* XXX handle errors */
>                 amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
>                 adev->ip_blocks[i].status.hw =3D false;
> -       }
>
> -       /* VCN FW shared region is in frambuffer, there are some flags
> -        * initialized in that region during sw_init. Make sure the regio=
n is
> -        * backed up.
> -        */
> -       amdgpu_vcn_save_vcpu_bo(adev);
> +               /* VCN FW shared region is in frambuffer, there are some =
flags
> +               * initialized in that region during sw_init. Make sure th=
e region is
> +               * backed up.
> +               */
> +               if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_VCN)
> +                       amdgpu_vcn_save_vcpu_bo(adev, adev->ip_blocks[i].=
instance);
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index d515cfd2da79..50047c636904 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -294,47 +294,45 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_devic=
e *adev, enum vcn_ring_type t
>         return ret;
>  }
>
> -int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
> +int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst)
>  {
>         unsigned int size;
>         void *ptr;
> -       int i, idx;
> +       int idx;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               if (adev->vcn.inst[i].vcpu_bo =3D=3D NULL)
> -                       return 0;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               size =3D amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
> -               ptr =3D adev->vcn.inst[i].cpu_addr;
> +       if (adev->vcn.inst[inst].vcpu_bo =3D=3D NULL)
> +               return 0;
>
> -               adev->vcn.inst[i].saved_bo =3D kvmalloc(size, GFP_KERNEL)=
;
> -               if (!adev->vcn.inst[i].saved_bo)
> -                       return -ENOMEM;
> +       size =3D amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
> +       ptr =3D adev->vcn.inst[inst].cpu_addr;
>
> -               if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -                       memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, si=
ze);
> -                       drm_dev_exit(idx);
> -               }
> +       adev->vcn.inst[inst].saved_bo =3D kvmalloc(size, GFP_KERNEL);
> +       if (!adev->vcn.inst[inst].saved_bo)
> +               return -ENOMEM;
> +
> +       if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +               memcpy_fromio(adev->vcn.inst[inst].saved_bo, ptr, size);
> +               drm_dev_exit(idx);
>         }
>
>         return 0;
>  }
>
> -int amdgpu_vcn_suspend(struct amdgpu_device *adev)
> +int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst)
>  {
>         bool in_ras_intr =3D amdgpu_ras_intr_triggered();
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> -               cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
>
>         /* err_event_athub will corrupt VCPU buffer, so we need to
>          * restore fw data and clear buffer in amdgpu_vcn_resume() */
>         if (in_ras_intr)
>                 return 0;
>
> -       return amdgpu_vcn_save_vcpu_bo(adev);
> +       return amdgpu_vcn_save_vcpu_bo(adev, inst);
>  }
>
>  int amdgpu_vcn_resume(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index ce8000ca11ef..be681bcab184 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -486,7 +486,7 @@ enum vcn_ring_type {
>  int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
>  int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
>  int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> +int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
>  int amdgpu_vcn_resume(struct amdgpu_device *adev);
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> @@ -520,6 +520,6 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev=
);
>
>  int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>                                enum AMDGPU_UCODE_ID ucode_id);
> -int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev);
> +int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 44370949fa57..a3845e7747b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -226,7 +226,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         int inst =3D ip_block->instance;
>         int r;
>
> -       r =3D amdgpu_vcn_suspend(adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>         if (r)
>                 return r;
>
> @@ -300,9 +300,10 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *=
ip_block)
>   */
>  static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
>  {
> -       int r;
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         bool idle_work_unexecuted;
> +       int r;
>
>         idle_work_unexecuted =3D cancel_delayed_work_sync(&adev->vcn.inst=
[0].idle_work);
>         if (idle_work_unexecuted) {
> @@ -314,7 +315,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_suspend(adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 7b5f2696e60d..8e943d1fae17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -257,7 +257,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>
>         amdgpu_virt_free_mm_table(adev);
>
> -       r =3D amdgpu_vcn_suspend(adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>         if (r)
>                 return r;
>
> @@ -335,13 +335,15 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block =
*ip_block)
>   */
>  static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int r;
>
>         r =3D vcn_v2_0_hw_fini(ip_block);
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_suspend(ip_block->adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 8ce3cea6cf44..9ca07e56b052 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -316,7 +316,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_free_mm_table(adev);
>
> -       r =3D amdgpu_vcn_suspend(adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>         if (r)
>                 return r;
>
> @@ -412,13 +412,15 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block =
*ip_block)
>   */
>  static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int r;
>
>         r =3D vcn_v2_5_hw_fini(ip_block);
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_suspend(ip_block->adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 36100c2612d9..a25d2b9784be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -325,7 +325,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_free_mm_table(adev);
>
> -       r =3D amdgpu_vcn_suspend(adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>         if (r)
>                 return r;
>
> @@ -444,13 +444,15 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block =
*ip_block)
>   */
>  static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int r;
>
>         r =3D vcn_v3_0_hw_fini(ip_block);
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_suspend(ip_block->adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 00ff7affc647..fcf7b23cca90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -277,7 +277,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_free_mm_table(adev);
>
> -       r =3D amdgpu_vcn_suspend(adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>         if (r)
>                 return r;
>
> @@ -372,13 +372,15 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block =
*ip_block)
>   */
>  static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int r;
>
>         r =3D vcn_v4_0_hw_fini(ip_block);
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_suspend(ip_block->adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index feb373a96cfb..ece9b1df2743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -235,7 +235,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_free_mm_table(adev);
>
> -       r =3D amdgpu_vcn_suspend(adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>         if (r)
>                 return r;
>
> @@ -331,13 +331,15 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>   */
>  static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int r;
>
>         r =3D vcn_v4_0_3_hw_fini(ip_block);
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_suspend(ip_block->adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index fb1e1d5bcdbe..f1ec632a9eb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -246,7 +246,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_free_mm_table(adev);
>
> -       r =3D amdgpu_vcn_suspend(adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>         if (r)
>                 return r;
>
> @@ -323,13 +323,15 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>   */
>  static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int r;
>
>         r =3D vcn_v4_0_5_hw_fini(ip_block);
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_suspend(ip_block->adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 137c3b452433..fdfb3084d54e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -210,7 +210,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>                 drm_dev_exit(idx);
>         }
>
> -       r =3D amdgpu_vcn_suspend(adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>         if (r)
>                 return r;
>
> @@ -287,13 +287,15 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>   */
>  static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int r;
>
>         r =3D vcn_v5_0_0_hw_fini(ip_block);
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_suspend(ip_block->adev);
> +       r =3D amdgpu_vcn_suspend(adev, inst);
>
>         return r;
>  }
> --
> 2.34.1
>
