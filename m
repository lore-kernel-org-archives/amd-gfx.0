Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CA3D3E2BB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1E410E536;
	Mon, 28 Oct 2024 19:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I+ESsfBg";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A33810E536
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:30:58 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-71e74f35acaso323641b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730143858; x=1730748658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Af9SwjaePwKLeEV7OEGS0ZFHS2sQgY/Uigmn6msYWa0=;
 b=I+ESsfBgI3j69RLre+UX8wVtftwjn2D60Ww7G2gq+H3GgckZVd8tc8cr5zb1O+2ZzH
 txdG/UWgzZVHOYqiLgdhqeIHoDAnMh4t0sI/io4NABaZLQAYaK82fLwHmk+pf/TyooSD
 w46tzlICu5IVMX7nwli/hyNKE3eokEumzyIhpjPSNlNEFOCvioM6snvLQa7dyFSajAyc
 M1NCO3h7oNZ0bZmVP6XP8lRfYAbiJjJt2xLa6ZJ0xWlSqfVO8mcXMQHEvZH2xlH1oZOm
 2r6HB6k538pErv6mBC9bm5/5lYF3BEkzDRQ219I0d83MxJtSVpjZfwKtIGdTDd/IKnUr
 AMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143858; x=1730748658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Af9SwjaePwKLeEV7OEGS0ZFHS2sQgY/Uigmn6msYWa0=;
 b=oL7l5w8QextKMwtWZrHHGvCsoykKyHVX4RyvfnA5lbBJNjD434N9P4sCx6ym/O3RjR
 OpX+6e6O/XqfLGDSFdUlOYSv3FSpsrJdfgYcmgW9BNPWC6Vr7P3BphtTgEO78+9gvxsF
 K/L7YRr3X+VtUoaaEig3mUUYe3vANogTKAHkataYDa3L8MbKHgh9zHvoOQX77agLzoiS
 RokxgcSnHOkZNt3MId7MBJHGnsDiwbiEaES7v+U1MI6zwg6zg5iXWKzk1nJHCBYuUCQ+
 0pfXrOF8eCKDxAWavNW/0T0zeST5lJLu1XDjy3fyedzMSHvim+UX8+scQr7oA3JSYXZ/
 dhfg==
X-Gm-Message-State: AOJu0Yw6YGlwKj0I6LDuRL7rGI1HXLbDtoiwsVdqKH8yN9/YcaJ/Pl63
 K9GBvLX79eNjolXB01cfA0mAtTAo0UNJ7R/EXk1H03MKQfYs/Eu2qtFAj6nkNvT5HD/wqXNBLxN
 dBTLbdL/gicwT45Ox6IBd2erK7oM=
X-Google-Smtp-Source: AGHT+IExtmMIXWlBM5YNqPDVyASG4beTVEQUG6eY6ABSYqy23P+5DOwEDZvKeN1DXIVd0y73yqzFoMH2cU3Hyu+VZ5Q=
X-Received: by 2002:a05:6a00:998:b0:71e:5033:c6 with SMTP id
 d2e1a72fcca58-7206303212amr5815248b3a.5.1730143857439; Mon, 28 Oct 2024
 12:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-19-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-19-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:30:45 -0400
Message-ID: <CADnq5_OSFpQU6+ziixcLFL+q4WhRZ2huRyNc-xOT9jG6NhN+FA@mail.gmail.com>
Subject: Re: [PATCH 18/29] drm/amdgpu/vcn: separate idle work by instance
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

On Thu, Oct 24, 2024 at 11:23=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Previously idle working handling is for all VCN instances. As a result, w=
hen one
> of the instance finishes its job, the idle work can't be triggered if the=
 other
> instance is still busy.
>
> Now, move the idle_work from amdgpu_vcn to amdgpu_vcn_inst, in order to
> track work by vcn instance. Add work_inst to track the instance number
> that the work belongs to. As a result, the idle work can now be triggered
> once the job is done on one of the vcn instance, and no need to consider
> the work on the other vcn instance.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 66 ++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  4 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 14 ++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
>  17 files changed, 58 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 49802e66a358..3d2d2a0d98c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -118,7 +118,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>         unsigned int fw_shared_size, log_offset;
>         int i, r;
>
> -       INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_hand=
ler);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               adev->vcn.inst[i].adev =3D adev;
> +               adev->vcn.inst[i].work_inst =3D i;
> +               INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vc=
n_idle_work_handler);
> +       }
>         mutex_init(&adev->vcn.vcn_pg_lock);
>         mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
>         atomic_set(&adev->vcn.total_submission_cnt, 0);
> @@ -326,7 +330,8 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>  {
>         bool in_ras_intr =3D amdgpu_ras_intr_triggered();
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> +               cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>
>         /* err_event_athub will corrupt VCPU buffer, so we need to
>          * restore fw data and clear buffer in amdgpu_vcn_resume() */
> @@ -382,46 +387,43 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  {
> -       struct amdgpu_device *adev =3D
> -               container_of(work, struct amdgpu_device, vcn.idle_work.wo=
rk);
> -       unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0=
};
> -       unsigned int i, j;
> +       struct amdgpu_vcn_inst *vcn_inst =3D
> +               container_of(work, struct amdgpu_vcn_inst, idle_work.work=
);
> +       struct amdgpu_device *adev =3D vcn_inst->adev;
> +       unsigned int inst =3D vcn_inst->work_inst;
> +       unsigned int fence =3D 0;
> +       unsigned int i;
>         int r =3D 0;
>
> -       for (j =3D 0; j < adev->vcn.num_vcn_inst; ++j) {
> -               if (adev->vcn.harvest_config & (1 << j))
> -                       continue;
> -
> -               for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> -                       fence[j] +=3D amdgpu_fence_count_emitted(&adev->v=
cn.inst[j].ring_enc[i]);
> -
> -               /* Only set DPG pause for VCN3 or below, VCN4 and above w=
ill be handled by FW */
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -                   !adev->vcn.using_unified_queue) {
> -                       struct dpg_pause_state new_state;
> -
> -                       if (fence[j] ||
> -                               unlikely(atomic_read(&adev->vcn.inst[j].d=
pg_enc_submission_cnt)))
> -                               new_state.fw_based =3D VCN_DPG_STATE__PAU=
SE;
> -                       else
> -                               new_state.fw_based =3D VCN_DPG_STATE__UNP=
AUSE;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -                       adev->vcn.pause_dpg_mode(adev, j, &new_state);
> -               }
> +       for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> +               fence +=3D amdgpu_fence_count_emitted(&adev->vcn.inst[ins=
t].ring_enc[i]);
>
> -               fence[j] +=3D amdgpu_fence_count_emitted(&adev->vcn.inst[=
j].ring_dec);
> -               fences +=3D fence[j];
> +       /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +                       !adev->vcn.using_unified_queue) {
> +               struct dpg_pause_state new_state;
> +               if (fence ||
> +                               unlikely(atomic_read(&adev->vcn.inst[inst=
].dpg_enc_submission_cnt)))
> +                       new_state.fw_based =3D VCN_DPG_STATE__PAUSE;
> +               else
> +                       new_state.fw_based =3D VCN_DPG_STATE__UNPAUSE;
> +               adev->vcn.pause_dpg_mode(adev, inst, &new_state);
>         }
>
> -       if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
> +       fence +=3D amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_=
dec);
> +
> +       if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCN,
>                        AMD_PG_STATE_GATE);
>                 r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> -                               false);
> +                                                                        =
               false);
>                 if (r)
>                         dev_warn(adev->dev, "(%d) failed to disable video=
 power profile mode\n", r);
>         } else {
> -               schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIME=
OUT);
> +               schedule_delayed_work(&adev->vcn.inst[inst].idle_work, VC=
N_IDLE_TIMEOUT);
>         }
>  }
>
> @@ -432,7 +434,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ri=
ng)
>
>         atomic_inc(&adev->vcn.total_submission_cnt);
>
> -       if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
> +       if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work=
)) {
>                 r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
>                                 true);
>                 if (r)
> @@ -481,7 +483,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring=
)
>
>         atomic_dec(&ring->adev->vcn.total_submission_cnt);
>
> -       schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOU=
T);
> +       schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work, =
VCN_IDLE_TIMEOUT);
>  }
>
>  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 2b8c9b8d4494..2282c4d14ae7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -279,6 +279,7 @@ struct amdgpu_vcn_fw_shared {
>  };
>
>  struct amdgpu_vcn_inst {
> +       struct amdgpu_device *adev;
>         struct amdgpu_bo        *vcpu_bo;
>         void                    *cpu_addr;
>         uint64_t                gpu_addr;
> @@ -301,6 +302,8 @@ struct amdgpu_vcn_inst {
>         enum amd_powergating_state cur_state;
>         uint8_t                 vcn_config;
>         uint32_t                vcn_codec_disable_mask;
> +       struct delayed_work     idle_work;
> +       uint8_t                 work_inst;
>  };
>
>  struct amdgpu_vcn_ras {
> @@ -309,7 +312,6 @@ struct amdgpu_vcn_ras {
>
>  struct amdgpu_vcn {
>         unsigned                fw_version;
> -       struct delayed_work     idle_work;
>         unsigned                num_enc_rings;
>         bool                    indirect_sram;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v1_0.c
> index 03b8b7cd5229..8031406e20ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)
>  static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>  {
>         struct  amdgpu_device *adev =3D ring->adev;
> -       bool    set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.idle_=
work);
> +       bool    set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.inst[=
0].idle_work);
>         int             cnt =3D 0;
>
>         mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.c
> index 1100d832abfc..aed61615299d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -150,7 +150,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *=
ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>
>         if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>               RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_5.c
> index 3d72e383b7df..28a1e8ce417f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -211,7 +211,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *=
ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int i;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>
>         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>                 if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v3_0.c
> index 200403a07d34..f83c7a58b91a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -164,7 +164,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *=
ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>
>         if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>               RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0.c
> index 0a4939895b6a..568ff06b3b6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -195,7 +195,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *=
ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>         if (!amdgpu_sriov_vf(adev)) {
>                 if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>                         RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_5.c
> index d89863213ae7..3d57607bb3f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -219,7 +219,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block=
 *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int i;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>
>         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>                 if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.c
> index 09eaf7f07710..124cb15e3980 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -161,7 +161,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block=
 *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>
>         if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>               RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index c2eb187b0a27..f07a5a8393c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,7 +150,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>                 return r;
>
>         /* Override the work func */
> -       adev->vcn.idle_work.work.func =3D vcn_v1_0_idle_work_handler;
> +       adev->vcn.inst[0].idle_work.work.func =3D vcn_v1_0_idle_work_hand=
ler;
>
>         amdgpu_vcn_setup_ucode(adev);
>
> @@ -277,7 +277,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *i=
p_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>
>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>                 (adev->vcn.inst[0].cur_state !=3D AMD_PG_STATE_GATE &&
> @@ -301,7 +301,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *i=
p_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         bool idle_work_unexecuted;
>
> -       idle_work_unexecuted =3D cancel_delayed_work_sync(&adev->vcn.idle=
_work);
> +       idle_work_unexecuted =3D cancel_delayed_work_sync(&adev->vcn.inst=
[0].idle_work);
>         if (idle_work_unexecuted) {
>                 if (adev->pm.dpm_enabled)
>                         amdgpu_dpm_enable_vcn(adev, false, 0);
> @@ -1830,7 +1830,7 @@ static int vcn_v1_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>  static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>  {
>         struct amdgpu_device *adev =3D
> -               container_of(work, struct amdgpu_device, vcn.idle_work.wo=
rk);
> +               container_of(work, struct amdgpu_device, vcn.inst[0].idle=
_work.work);
>         unsigned int fences =3D 0, i;
>
>         for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> @@ -1863,14 +1863,14 @@ static void vcn_v1_0_idle_work_handler(struct wor=
k_struct *work)
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCN,
>                                AMD_PG_STATE_GATE);
>         } else {
> -               schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIME=
OUT);
> +               schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_I=
DLE_TIMEOUT);
>         }
>  }
>
>  static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>  {
>         struct  amdgpu_device *adev =3D ring->adev;
> -       bool set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.idle_wor=
k);
> +       bool set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.inst[0].=
idle_work);
>
>         mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
>
> @@ -1922,7 +1922,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ri=
ng *ring, bool set_clocks)
>
>  void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
>  {
> -       schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOU=
T);
> +       schedule_delayed_work(&ring->adev->vcn.inst[0].idle_work, VCN_IDL=
E_TIMEOUT);
>         mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 04edbb368903..419ecba12c9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *i=
p_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>
>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>             (adev->vcn.inst[0].cur_state !=3D AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 010970faa5fd..7e7ce00806cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -387,7 +387,7 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *i=
p_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int inst =3D ip_block->instance;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
>
>         if (adev->vcn.harvest_config & (1 << inst))
>                 return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 690224a5e783..ca4ee368db02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -420,7 +420,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *i=
p_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int inst =3D ip_block->instance;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
>
>         if (adev->vcn.harvest_config & (1 << inst))
>                 return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 0cc0eb52b54f..ee6c08707312 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -349,7 +349,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *i=
p_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int inst =3D ip_block->instance;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
>
>         if (adev->vcn.harvest_config & (1 << inst))
>                 return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index db6f8d424777..2c66a7a4ff25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -315,7 +315,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block =
*ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int inst =3D ip_block->instance;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
>
>         if (adev->vcn.inst[inst].cur_state !=3D AMD_PG_STATE_GATE)
>                 vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_G=
ATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 0f3b25d3b9d8..d725c12ffdaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -298,7 +298,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block =
*ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int inst =3D ip_block->instance;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
>
>         if (adev->vcn.harvest_config & (1 << inst))
>                 return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 15620e111d04..3856388179b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -262,7 +262,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block =
*ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int inst =3D ip_block->instance;
>
> -       cancel_delayed_work_sync(&adev->vcn.idle_work);
> +       cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
>
>         if (adev->vcn.harvest_config & (1 << inst))
>                 return 0;
> --
> 2.34.1
>
