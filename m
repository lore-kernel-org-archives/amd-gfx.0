Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DC8CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 21:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8384A10E7D1;
	Wed, 13 Aug 2025 21:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k72l/cJ+";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DBD10E7D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 21:57:15 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2445806dc89so418875ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755122235; x=1755727035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ec1Z7Ps6i6DBfLGzMIOtzm/L3c4dXO1vK/lAvzQC2mY=;
 b=k72l/cJ+LxQYaBDYqpoXNdaZ5BGj3YTTauXuK33Dgj1+kxTul4KAjGQtEaup5msrbf
 lJBa+obpuevp33WuqRN9Ra8gSZw56bjQRXuuB5b0TtqdqEw60Dgb6TBRgfn/k6ZFeJOe
 FriMPtHFRN3HAAQDowhYOGz3mSrcSBuCER3veYyheBV/5zTISpHhRtdmoYyUKd7wqvmi
 szqRalMaL68QJIw8NDpOin4Kephr5ndZZfCJJbSZLHXFvMBuHroGemZqJBKHgELFUl9w
 VJ7ng5CQaw2KKRnxx3Jw1wTAOc3RzPydRhm8tHHI+far1vAEjySxgEl6aUTBOVIRI1Nq
 laSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755122235; x=1755727035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ec1Z7Ps6i6DBfLGzMIOtzm/L3c4dXO1vK/lAvzQC2mY=;
 b=tWn8BbOgelp2RiAwQ/K9ljeRf7QT1s8kO30IpYvHnaBm6wF91xUcN4C0oSeg+AgiAO
 krA/5inDIBFWB+5zicu17yPaX6mp9nz+GzeNgCySyU63Hu4eMfa0YjLbpPeoEL4I9VqY
 8jP29DBPP3X9sQczCl5aeIuawof4tpkeyaUrJnBPxQ4gMIktvvGBjGW9qYbZnyVEbcHg
 zQuBtmODbF4bADR+IxDKSD9qWInI3jsxe7322PBYli3EFExUGFm9tBP8PsOt6T5aZTcX
 U7sqTfjDWwUbIgo19QMV1U2FeazGuzRB5z9UwEyrqLUzz/d62MUaF5QxegES7gRN6tou
 D6Hg==
X-Gm-Message-State: AOJu0YzZlW1KIOFf1V/v59crS0d9RPpF0ZOiDfN9mUyONsnoMkuRNAnB
 Ex1oGGuZXa/YSrVGGUYHdNmcjr0qZ1A/UtnrTa9cvr3621l1yvfYDDJpwG6qfvuitnJOql8yCMY
 8cqD+g4Tf9ok77IQe33rL5L3LQdgjV1E=
X-Gm-Gg: ASbGncvXy7ZtgrZ79IJo0wOT0x/Bop3GejQjRhRiismrJrZEdsnWLwPSy+Q8KiWMmVh
 B9UDorrHhtmku7/c4AKdXGO/uJ86DOcB9u7g7rV2vJm2bgBwU1aO256wvIUipPnlNy5Jb9Evqal
 Dz4Wfbl31QI1EMDNYFVX3h3Umkt7R6xEAQM0nsWliJ7hVOVM7Mk3xIOxk6CiCShEVtryxfk7Tj3
 QOCtlkEdy656PByJg==
X-Google-Smtp-Source: AGHT+IH/EFzwX0D34N3HseKDKcyO4Q5RsEDj0Kk7mlyvBGm62eXraFoSArdpaPRcwH+mQVtu6hj9GFJCB+EbamVuFgE=
X-Received: by 2002:a17:903:32c4:b0:240:71db:fd0 with SMTP id
 d9443c01a7336-244586d661amr3791445ad.8.1755122235081; Wed, 13 Aug 2025
 14:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250813205923.1343041-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250813205923.1343041-1-sathishkumar.sundararaju@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 17:57:03 -0400
X-Gm-Features: Ac12FXyE0VZLBsU367KUfyzTnojWN1absEorTsjryA-TBZJenM50rMQNZZwsoe0
Message-ID: <CADnq5_M1di8Apy2Wqg9B4RrDBn1mDjrWyxMW9738TK23bCJTPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: Fix race condition during dpm off
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 Wu David <davidwu2@amd.com>
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

On Wed, Aug 13, 2025 at 5:09=E2=80=AFPM Sathishkumar S
<sathishkumar.sundararaju@amd.com> wrote:
>
> There is a race condition which leads to dpm video power profile
> OFF during active video decode on multi-instance VCN hardware.
> Add flags to track ON/OFF vcn instances and check if all
> instances are off before turning OFF video power profile.
>
> v2:
> using per instance lock is wrong, use a global lock (David Wu)
>
> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    | 31 +++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h    |  7 +++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      | 18 +++----------
>  4 files changed, 21 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index f7d7e4748197..69a889b3222a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4444,7 +4444,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         }
>         mutex_init(&adev->gfx.userq_sch_mutex);
>         mutex_init(&adev->gfx.workload_profile_mutex);
> -       mutex_init(&adev->vcn.workload_profile_mutex);

We already have the global vcn.workload_profile_mutex.  Why not just
use that?  It better describes what it is protecting.

>         mutex_init(&adev->userq_mutex);
>
>         amdgpu_device_init_apu_flags(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c18..e034baa77977 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -102,6 +102,7 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev,=
 int i)
>         adev->vcn.inst[i].adev =3D adev;
>         adev->vcn.inst[i].inst =3D i;
>         amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, size=
of(ucode_prefix));
> +       mutex_init(&adev->vcn.lock);

This will get initialized multiple times as this function is called
per instance.  Better to initialize it in amdgpu_device_init().

>
>         if (i !=3D 0 && adev->vcn.per_inst_fw) {
>                 r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
> @@ -134,7 +135,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, in=
t i)
>         int r;
>
>         mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
> -       mutex_init(&adev->vcn.inst[i].vcn_pg_lock);

You can probably drop this lock as a separate patch.  I don't see any
concurrent access where we would need it.

>         mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
>         atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
>         INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_w=
ork_handler);
> @@ -290,7 +290,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, in=
t i)
>         if (adev->vcn.reg_list)
>                 amdgpu_vcn_reg_dump_fini(adev);
>
> -       mutex_destroy(&adev->vcn.inst[i].vcn_pg_lock);
>         mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
>
>         return 0;
> @@ -443,18 +442,18 @@ static void amdgpu_vcn_idle_work_handler(struct wor=
k_struct *work)
>         fences +=3D fence[i];
>
>         if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> -               mutex_lock(&vcn_inst->vcn_pg_lock);
> +               mutex_lock(&adev->vcn.lock);
>                 vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> -               mutex_unlock(&vcn_inst->vcn_pg_lock);
> -               mutex_lock(&adev->vcn.workload_profile_mutex);
> -               if (adev->vcn.workload_profile_active) {
> +               adev->vcn.flags &=3D AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst->=
inst);
> +               if (adev->vcn.workload_profile_active &&
> +                   !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->=
vcn.num_vcn_inst))) {

I still don't see how looking at the global emitted fences here would
race, but I don't have a strong preference on how we solve this.

Alex

>                         r =3D amdgpu_dpm_switch_power_profile(adev, PP_SM=
C_POWER_PROFILE_VIDEO,
>                                                             false);
>                         if (r)
>                                 dev_warn(adev->dev, "(%d) failed to disab=
le video power profile mode\n", r);
>                         adev->vcn.workload_profile_active =3D false;
>                 }
> -               mutex_unlock(&adev->vcn.workload_profile_mutex);
> +               mutex_unlock(&adev->vcn.lock);
>         } else {
>                 schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIME=
OUT);
>         }
> @@ -470,14 +469,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *r=
ing)
>
>         cancel_delayed_work_sync(&vcn_inst->idle_work);
>
> -       /* We can safely return early here because we've cancelled the
> -        * the delayed work so there is no one else to set it to false
> -        * and we don't care if someone else sets it to true.
> -        */
> -       if (adev->vcn.workload_profile_active)
> -               goto pg_lock;
> +       mutex_lock(&adev->vcn.lock);
>
> -       mutex_lock(&adev->vcn.workload_profile_mutex);
>         if (!adev->vcn.workload_profile_active) {
>                 r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
>                                                     true);
> @@ -485,11 +478,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
>                         dev_warn(adev->dev, "(%d) failed to switch to vid=
eo power profile mode\n", r);
>                 adev->vcn.workload_profile_active =3D true;
>         }
> -       mutex_unlock(&adev->vcn.workload_profile_mutex);
>
> -pg_lock:
> -       mutex_lock(&vcn_inst->vcn_pg_lock);
> -       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> +       if (!(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst))=
) {
> +               vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> +               adev->vcn.flags |=3D AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->i=
nst);
> +       }
>
>         /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> @@ -514,7 +507,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ri=
ng)
>
>                 vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>         }
> -       mutex_unlock(&vcn_inst->vcn_pg_lock);
> +       mutex_unlock(&adev->vcn.lock);
>  }
>
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index b3fb1d0e43fc..4457dcc5f9dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -320,7 +320,6 @@ struct amdgpu_vcn_inst {
>         uint8_t                 vcn_config;
>         uint32_t                vcn_codec_disable_mask;
>         atomic_t                total_submission_cnt;
> -       struct mutex            vcn_pg_lock;
>         enum amd_powergating_state cur_state;
>         struct delayed_work     idle_work;
>         unsigned                fw_version;
> @@ -363,9 +362,13 @@ struct amdgpu_vcn {
>         unsigned                fw_version;
>
>         bool                    workload_profile_active;
> -       struct mutex            workload_profile_mutex;
> +       struct mutex            lock;
>         u32 reg_count;
>         const struct amdgpu_hwip_reg_entry *reg_list;
> +#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
> +#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
> +#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
> +       u32 flags;
>  };
>
>  struct amdgpu_fw_shared_rb_ptrs_struct {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 3a7c137a83ef..344ab5c4cb18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -147,9 +147,9 @@ static void vcn_v2_5_idle_work_handler(struct work_st=
ruct *work)
>         }
>
>         if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_c=
nt)) {
> +               mutex_lock(&adev->vcn.lock);
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCN,
>                                                        AMD_PG_STATE_GATE)=
;
> -               mutex_lock(&adev->vcn.workload_profile_mutex);
>                 if (adev->vcn.workload_profile_active) {
>                         r =3D amdgpu_dpm_switch_power_profile(adev, PP_SM=
C_POWER_PROFILE_VIDEO,
>                                                             false);
> @@ -157,7 +157,7 @@ static void vcn_v2_5_idle_work_handler(struct work_st=
ruct *work)
>                                 dev_warn(adev->dev, "(%d) failed to disab=
le video power profile mode\n", r);
>                         adev->vcn.workload_profile_active =3D false;
>                 }
> -               mutex_unlock(&adev->vcn.workload_profile_mutex);
> +               mutex_unlock(&adev->vcn.lock);
>         } else {
>                 schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_I=
DLE_TIMEOUT);
>         }
> @@ -173,14 +173,7 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ri=
ng *ring)
>
>         cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>
> -       /* We can safely return early here because we've cancelled the
> -        * the delayed work so there is no one else to set it to false
> -        * and we don't care if someone else sets it to true.
> -        */
> -       if (adev->vcn.workload_profile_active)
> -               goto pg_lock;
> -
> -       mutex_lock(&adev->vcn.workload_profile_mutex);
> +       mutex_lock(&adev->vcn.lock);
>         if (!adev->vcn.workload_profile_active) {
>                 r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
>                                                     true);
> @@ -188,10 +181,7 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ri=
ng *ring)
>                         dev_warn(adev->dev, "(%d) failed to switch to vid=
eo power profile mode\n", r);
>                 adev->vcn.workload_profile_active =3D true;
>         }
> -       mutex_unlock(&adev->vcn.workload_profile_mutex);
>
> -pg_lock:
> -       mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
>         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VC=
N,
>                                                AMD_PG_STATE_UNGATE);
>
> @@ -217,7 +207,7 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_rin=
g *ring)
>                 }
>                 v->pause_dpg_mode(v, &new_state);
>         }
> -       mutex_unlock(&adev->vcn.inst[0].vcn_pg_lock);
> +       mutex_unlock(&adev->vcn.lock);
>  }
>
>  static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
> --
> 2.48.1
>
