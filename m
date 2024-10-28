Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A2ED3E2BC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4641A10E530;
	Mon, 28 Oct 2024 19:41:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4ZAm9iS";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9A310E530
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:41:10 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-71e617c3e9bso248847b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730144470; x=1730749270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=St9vlGbZce8E3TRv1x+V1wiJoUhU0MSRw2crylJvQ/w=;
 b=S4ZAm9iSXC3mssaIkt31KmMK7QGXqNeN+pxT34SwPqd2dTyX0uhuPLHuGDT9uvtULd
 UTcPdaxMbsW8ETyRRmfbse9oS2E7BQSLRlAkylrf2mTrzA4kc50BH06JXlHpk+DOLDni
 EqXfELcBnRX6kzSEQFOAOnvMdojSgFL8I3DcR2CqlWCN+XJOeCrxQI9/thsibTUh88LD
 sEXPNoZhJR3ST93Lg4mmXwI4o8cvD42CF9GyOlimERvmxPMN45Yplwrm3vQkD6msxaFE
 QerCGw7LFjc2xv6FplAINBLpun9/MEk92eBzWBvxCyhYxQmp3sFaLEfKd+oQ1sADLN37
 Yn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144470; x=1730749270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=St9vlGbZce8E3TRv1x+V1wiJoUhU0MSRw2crylJvQ/w=;
 b=r9Qr/djiuL9sfV0RbC9y6Hnt5cpR0D8FQg4ynsg89VHU2RZwjKLNu9148SHFnZfndU
 nLCHhECmujZAcC6OU9OK+Gzj2NXbVMzCKulqaGBz48GFeZ053hHv+WpuKqi3Y9i3YQ2H
 1lB3ChgrWfo6KJ3h5/rzcsFSE6IPFdB/+sLNVGZNNDFhFxqfkKEaav1k4d3w4ZRqFYW3
 mKfo4x+iZAXSxbTPdXUf5ZoLGpmQHPxh+GpdS7ixK4clVc5gxTqBBw1p/FxGTAFmQeRo
 /pWGJ0kpDeApga1kzahCetB+N1JLUAWQtVnIdjEfcGu/pMBQ6mpDhY8RXCbe3EQZJ14g
 jTWA==
X-Gm-Message-State: AOJu0YwEB/GrD4ZnKUTUGIRWCd9qwGLukLXWSCwPMHDJWTvR7iZrXl+p
 lHaBO6EdC/H0349Cz7CIOxFJWAym7sMrsgy+ypncXdi7Ed/fz0tZEatyqwuy7y180AQRerEADVD
 2HDMVt718NjSRwXfZ8wbr/o7D82Y=
X-Google-Smtp-Source: AGHT+IFI6DCi/ck7wFTEZ+BA1YnFXgvPrfhiwJuZwuEn7/aMLUEWcxPrTo5vIZ1pttwn2ksB9+zjQ6lI6syD14+SLi8=
X-Received: by 2002:a05:6a20:7488:b0:1cf:2be2:6525 with SMTP id
 adf61e73a8af0-1d9a8516972mr6408915637.11.1730144468346; Mon, 28 Oct 2024
 12:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
 <20241017132053.53214-23-boyuan.zhang@amd.com>
In-Reply-To: <20241017132053.53214-23-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:40:56 -0400
Message-ID: <CADnq5_O_sBV_juOY20c-mgysFaCatveXm2OXZnTZoxVvtACYwQ@mail.gmail.com>
Subject: Re: [PATCH 22/32] drm/amdgpu: sw_fini for each vcn instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com
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

On Thu, Oct 17, 2024 at 11:43=E2=80=AFAM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_sw_fini(), and perform
> sw fini ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thinking about these patches that modify amdgpu_vcn.c to add the
instance to them, will this break anything due to changes in ordering?
 If so, we may want to squash all of these together into one patch.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 36 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 ++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 21 +++++++--------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 16 +++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 +++++++--------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 +++++++--------
>  10 files changed, 81 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 791b95867ac2..307615ffeb79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -248,33 +248,31 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, =
int inst)
>         return 0;
>  }
>
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
> +int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst)
>  {
> -       int i, j;
> -
> -       for (j =3D 0; j < adev->vcn.num_vcn_inst; ++j) {
> -               if (adev->vcn.harvest_config & (1 << j))
> -                       continue;
> +       int i;
>
> -               amdgpu_bo_free_kernel(
> -                       &adev->vcn.inst[j].dpg_sram_bo,
> -                       &adev->vcn.inst[j].dpg_sram_gpu_addr,
> -                       (void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               goto done;
>
> -               kvfree(adev->vcn.inst[j].saved_bo);
> +       amdgpu_bo_free_kernel(
> +               &adev->vcn.inst[inst].dpg_sram_bo,
> +               &adev->vcn.inst[inst].dpg_sram_gpu_addr,
> +               (void **)&adev->vcn.inst[inst].dpg_sram_cpu_addr);
>
> -               amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
> -                                         &adev->vcn.inst[j].gpu_addr,
> -                                         (void **)&adev->vcn.inst[j].cpu=
_addr);
> +       kvfree(adev->vcn.inst[inst].saved_bo);
>
> -               amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
> +       amdgpu_bo_free_kernel(&adev->vcn.inst[inst].vcpu_bo,
> +                                 &adev->vcn.inst[inst].gpu_addr,
> +                                 (void **)&adev->vcn.inst[inst].cpu_addr=
);
>
> -               for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> -                       amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
> +       amdgpu_ring_fini(&adev->vcn.inst[inst].ring_dec);
>
> -               amdgpu_ucode_release(&adev->vcn.inst[j].fw);
> -       }
> +       for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> +               amdgpu_ring_fini(&adev->vcn.inst[inst].ring_enc[i]);
>
> +       amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
> +done:
>         mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
>         mutex_destroy(&adev->vcn.vcn_pg_lock);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 825b70a396cd..883b9f9776a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -485,7 +485,7 @@ enum vcn_ring_type {
>
>  int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
>  int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
> +int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>  int amdgpu_vcn_resume(struct amdgpu_device *adev);
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 70d865724463..8203f80be316 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -222,8 +222,9 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>   */
>  static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
> -       int r;
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
> +       int r;
>
>         r =3D amdgpu_vcn_suspend(adev);
>         if (r)
> @@ -231,7 +232,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>
>         jpeg_v1_0_sw_fini(ip_block);
>
> -       r =3D amdgpu_vcn_sw_fini(adev);
> +       r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(adev->vcn.ip_dump);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 834311e13a4c..0481a07054eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -245,9 +245,10 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>   */
>  static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
> -       int r, idx;
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         volatile struct amdgpu_fw_shared *fw_shared =3D adev->vcn.inst->f=
w_shared.cpu_addr;
> +       int r, idx;
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>                 fw_shared->present_flag_0 =3D 0;
> @@ -260,7 +261,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_sw_fini(adev);
> +       r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(adev->vcn.ip_dump);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index f6d2e3e3bf32..ed972d843f93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -297,17 +297,18 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block =
*ip_block)
>   */
>  static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
> -       int i, r, idx;
>         struct amdgpu_device *adev =3D ip_block->adev;
>         volatile struct amdgpu_fw_shared *fw_shared;
> +       int inst =3D ip_block->instance;
> +       int r, idx;
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> -                       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_add=
r;
> -                       fw_shared->present_flag_0 =3D 0;
> -               }
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       goto done;
> +
> +               fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +               fw_shared->present_flag_0 =3D 0;
> +       done:
>                 drm_dev_exit(idx);
>         }
>
> @@ -319,7 +320,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_sw_fini(adev);
> +       r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(adev->vcn.ip_dump);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 9b62296cc233..c45bebeb0aaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -306,19 +306,19 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>  static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, r, idx;
> +       int inst =3D ip_block->instance;
> +       int r, idx;
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       volatile struct amdgpu_fw_shared *fw_shared;
> +               volatile struct amdgpu_fw_shared *fw_shared;
>
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> -                       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_add=
r;
> -                       fw_shared->present_flag_0 =3D 0;
> -                       fw_shared->sw_ring.is_enabled =3D false;
> -               }
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       goto done;
>
> +               fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +               fw_shared->present_flag_0 =3D 0;
> +               fw_shared->sw_ring.is_enabled =3D false;
> +       done:
>                 drm_dev_exit(idx);
>         }
>
> @@ -329,7 +329,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_sw_fini(adev);
> +       r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(adev->vcn.ip_dump);
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 79d5ef8f857c..c87b4e46f2b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -258,20 +258,19 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>  static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, r, idx;
> +       int inst =3D ip_block->instance;
> +       int r, idx;
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +               volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> -
> -                       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_add=
r;
> -                       fw_shared->present_flag_0 =3D 0;
> -                       fw_shared->sq.is_enabled =3D 0;
> -               }
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       goto done;
>
> +               fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +               fw_shared->present_flag_0 =3D 0;
> +               fw_shared->sq.is_enabled =3D 0;
> +       done:
>                 drm_dev_exit(idx);
>         }
>
> @@ -282,7 +281,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_sw_fini(adev);
> +       r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(adev->vcn.ip_dump);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 0932e992d088..0b55d801ae88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -219,16 +219,16 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, r, idx;
> +       int inst =3D ip_block->instance;
> +       int r, idx;
>
>         if (drm_dev_enter(&adev->ddev, &idx)) {
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +               volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +
> +               fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +               fw_shared->present_flag_0 =3D 0;
> +               fw_shared->sq.is_enabled =3D cpu_to_le32(false);
>
> -                       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_add=
r;
> -                       fw_shared->present_flag_0 =3D 0;
> -                       fw_shared->sq.is_enabled =3D cpu_to_le32(false);
> -               }
>                 drm_dev_exit(idx);
>         }
>
> @@ -239,7 +239,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_sw_fini(adev);
> +       r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(adev->vcn.ip_dump);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index e551ba1d1e12..b88fdb00cc5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -227,20 +227,19 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, r, idx;
> +       int inst =3D ip_block->instance;
> +       int r, idx;
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> +               volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>
> -                       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_add=
r;
> -                       fw_shared->present_flag_0 =3D 0;
> -                       fw_shared->sq.is_enabled =3D 0;
> -               }
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       goto done;
>
> +               fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +               fw_shared->present_flag_0 =3D 0;
> +               fw_shared->sq.is_enabled =3D 0;
> +       done:
>                 drm_dev_exit(idx);
>         }
>
> @@ -251,7 +250,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_sw_fini(adev);
> +       r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(adev->vcn.ip_dump);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index dc15a74bb3d8..15cdc7be9062 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -194,20 +194,19 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, r, idx;
> +       int inst =3D ip_block->instance;
> +       int r, idx;
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       volatile struct amdgpu_vcn5_fw_shared *fw_shared;
> -
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> +               volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>
> -                       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_add=
r;
> -                       fw_shared->present_flag_0 =3D 0;
> -                       fw_shared->sq.is_enabled =3D 0;
> -               }
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       goto done;
>
> +               fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +               fw_shared->present_flag_0 =3D 0;
> +               fw_shared->sq.is_enabled =3D 0;
> +       done:
>                 drm_dev_exit(idx);
>         }
>
> @@ -215,7 +214,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_sw_fini(adev);
> +       r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(adev->vcn.ip_dump);
>
> --
> 2.34.1
>
