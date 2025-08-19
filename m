Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06465CA0EE6
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 12:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF1E10E1A4;
	Tue, 19 Aug 2025 12:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MGNDarWW";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54ABC10E1A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 12:52:05 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b47173edabaso1004334a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 05:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755607925; x=1756212725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dT3jGInlb26OSSp7uZbV8vc3eadim/FwC59TP2EEbDg=;
 b=MGNDarWWlc520t8IEwLX0ZvR7r4wAI9UnGK1TRk3UP5WXDgstW7b/CHCioNZjAqAYm
 BzDJLZcKZMLAzB5yShbjXw222eHi2PXks5gndOPX/ZWq1NsHJbIlKgt5zkTMOzsXKtNz
 X+iL4UwiPXFs3Lxhyvyz80wS6pLaSkqc1CyDKdSpP9vh+LKlEC1M64MtAGGfprkGkWjP
 Rpwi/FSLY4PVRscQNpg/MVI2mfwOzPG6799Ly4ayREX28+ubmk0UX1tnY6jbRQCjxMXj
 ggCfAftnfrLxOaiDOaBF20+D17K8PVBU+Px7yhsMz+0WAG5Ihiyh7xG58j0xBok/6sVK
 syEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755607925; x=1756212725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dT3jGInlb26OSSp7uZbV8vc3eadim/FwC59TP2EEbDg=;
 b=C5jfu3iFD4f5inGFL007asCLoUcOXUy9/uUZo+PQ4gX2qqdvMN79RRO9Y/AB0HNfxo
 ct+6O6PhBA7MKYBToUfDR6ru/s22EEKqQFrTa7r1FCL/0cC9TWnqBUi7wIaq107wqiHJ
 zlIPYzFef2mJEl9xd8u/67Lm2B0HTu6aGjlI0VbOQJ4b8BEc5oemfjDIHjqesh7HrGX+
 GTeFopz/1ZrejSY4irAuU0DIq8clGVXAASlXKTtgl/4B44IabeJ/CyVQVzbfWr44Dwpy
 C6RLq938R19DzLOUMj9kM9AiDR/Pywf6Icb8DtmLBcjYurakYwClQWUp+EbL3dsGIX2W
 68LA==
X-Gm-Message-State: AOJu0YzZdmUmVW5BIvtdR3yLbHAvtI7DnAUQe5fJY+doSt24pn0JMoti
 XiEnVDnh5q5FZ1+qSJci3HcZ1gkwg1dxQdbECf0BlW4LyQoo/5mpTXYFvScQsmakrSWcKUDTJSW
 BVXZtvYrfZFRXE2zVL7HaNFBjJnDaLi+Yjw==
X-Gm-Gg: ASbGncuV2Pu8fJqs73jXcbTzythjSnwVn1y8/wAjYrRhZ3+RaVfVRwJL7Q15VYjptvI
 dgJ5Tigxx6zh0UODWIjKp+8AuZiz84zFI7FqPSfRPoyy3dw/xIwgOsp+RaOZoHklLVmJxmhJ61q
 bKL68gfepJjOLBuCynU9mqRheppRHgy0gbU5XAtgwqM1Dk+WGx5FFzSBGryLnQJwQu4V9lFihXE
 LUfZVUfy58wR9RKtQ==
X-Google-Smtp-Source: AGHT+IGPadk0jaC665mpQiwI/bB80/ZS5Y2BSE0nfT2ErS+oGIipTbb1EoBoGT6hwoJDPoD8etWDmk6La7RXAGOGdRM=
X-Received: by 2002:a17:903:1111:b0:242:fcfd:3f94 with SMTP id
 d9443c01a7336-245e0525027mr17263755ad.11.1755607924461; Tue, 19 Aug 2025
 05:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250819091217.2115134-1-lijo.lazar@amd.com>
In-Reply-To: <20250819091217.2115134-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Aug 2025 08:51:52 -0400
X-Gm-Features: Ac12FXwZsfxauzPQiN-_ihsruXaWuHJPiIXJx2r-1RG6dDRM8cmWniOLmaMK3qg
Message-ID: <CADnq5_MdiPhH8qZuuSKeqvcZSD4qGBKMnNr8ZnH_-kbQaeLadQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Check vcn state before profile switch
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, sathishkumar.sundararaju@amd.com, 
 David.Wu3@amd.com
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

On Tue, Aug 19, 2025 at 5:28=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> The patch uses power state of VCN instances for requesting video
> profile.
>
> In idle worker of a vcn instance, when there is no outstanding
> submisssion or fence, the instance is put to power gated state. When all
> instances are powered off that means video profile is no longer
> required. A request is made to turn off video profile.
>
> A job submission starts with begin_use of ring, and at that time
> vcn instance state is changed to power on. Subsequently a check is
> made for active video profile, and if not active, a request is made.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 85 ++++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 27 +-------
>  3 files changed, 61 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c18..f3eb64edf6d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -410,6 +410,59 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev, in=
t i)
>         return 0;
>  }
>
> +void amdgpu_vcn_get_profile(struct amdgpu_device *adev)
> +{
> +       int r;
> +
> +
> +       mutex_lock(&adev->vcn.workload_profile_mutex);
> +
> +       if (adev->vcn.workload_profile_active) {
> +               mutex_unlock(&adev->vcn.workload_profile_mutex);
> +               return;
> +       }
> +       r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_=
VIDEO,
> +                                           true);
> +       if (r)
> +               dev_warn(adev->dev,
> +                        "(%d) failed to enable video power profile mode\=
n", r);
> +       else
> +               adev->vcn.workload_profile_active =3D true;
> +       mutex_unlock(&adev->vcn.workload_profile_mutex);
> +
> +       return;
> +}
> +
> +void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
> +{
> +       bool pg =3D true;
> +       int r, i;
> +
> +       mutex_lock(&adev->vcn.workload_profile_mutex);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (adev->vcn.inst[i].cur_state !=3D AMD_PG_STATE_GATE) {
> +                       pg =3D false;
> +                       break;
> +               }
> +       }
> +
> +       if (pg) {
> +               r =3D amdgpu_dpm_switch_power_profile(
> +                       adev, PP_SMC_POWER_PROFILE_VIDEO, false);
> +               if (r)
> +                       dev_warn(
> +                               adev->dev,
> +                               "(%d) failed to disable video power profi=
le mode\n",
> +                               r);
> +               else
> +                       adev->vcn.workload_profile_active =3D false;
> +       }
> +
> +       mutex_unlock(&adev->vcn.workload_profile_mutex);
> +
> +       return;
> +}
> +
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  {
>         struct amdgpu_vcn_inst *vcn_inst =3D
> @@ -417,7 +470,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_=
struct *work)
>         struct amdgpu_device *adev =3D vcn_inst->adev;
>         unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0=
};
>         unsigned int i =3D vcn_inst->inst, j;
> -       int r =3D 0;
>
>         if (adev->vcn.harvest_config & (1 << i))
>                 return;
> @@ -446,15 +498,8 @@ static void amdgpu_vcn_idle_work_handler(struct work=
_struct *work)
>                 mutex_lock(&vcn_inst->vcn_pg_lock);
>                 vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>                 mutex_unlock(&vcn_inst->vcn_pg_lock);
> -               mutex_lock(&adev->vcn.workload_profile_mutex);
> -               if (adev->vcn.workload_profile_active) {
> -                       r =3D amdgpu_dpm_switch_power_profile(adev, PP_SM=
C_POWER_PROFILE_VIDEO,
> -                                                           false);
> -                       if (r)
> -                               dev_warn(adev->dev, "(%d) failed to disab=
le video power profile mode\n", r);
> -                       adev->vcn.workload_profile_active =3D false;
> -               }
> -               mutex_unlock(&adev->vcn.workload_profile_mutex);
> +               amdgpu_vcn_put_profile(adev);
> +
>         } else {
>                 schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIME=
OUT);
>         }
> @@ -464,30 +509,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct amdgpu_vcn_inst *vcn_inst =3D &adev->vcn.inst[ring->me];
> -       int r =3D 0;
>
>         atomic_inc(&vcn_inst->total_submission_cnt);
>
>         cancel_delayed_work_sync(&vcn_inst->idle_work);
>
> -       /* We can safely return early here because we've cancelled the
> -        * the delayed work so there is no one else to set it to false
> -        * and we don't care if someone else sets it to true.
> -        */
> -       if (adev->vcn.workload_profile_active)
> -               goto pg_lock;
> -
> -       mutex_lock(&adev->vcn.workload_profile_mutex);
> -       if (!adev->vcn.workload_profile_active) {
> -               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> -                                                   true);
> -               if (r)
> -                       dev_warn(adev->dev, "(%d) failed to switch to vid=
eo power profile mode\n", r);
> -               adev->vcn.workload_profile_active =3D true;
> -       }
> -       mutex_unlock(&adev->vcn.workload_profile_mutex);
> -
> -pg_lock:
>         mutex_lock(&vcn_inst->vcn_pg_lock);
>         vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>
> @@ -515,6 +541,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ri=
ng)
>                 vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>         }
>         mutex_unlock(&vcn_inst->vcn_pg_lock);
> +       amdgpu_vcn_get_profile(adev);
>  }
>
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index b3fb1d0e43fc..6d9acd36041d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -565,4 +565,7 @@ int amdgpu_vcn_reg_dump_init(struct amdgpu_device *ad=
ev,
>                              const struct amdgpu_hwip_reg_entry *reg, u32=
 count);
>  void amdgpu_vcn_dump_ip_state(struct amdgpu_ip_block *ip_block);
>  void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct =
drm_printer *p);
> +void amdgpu_vcn_get_profile(struct amdgpu_device *adev);
> +void amdgpu_vcn_put_profile(struct amdgpu_device *adev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 3a7c137a83ef..904b94bc8693 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -116,7 +116,6 @@ static void vcn_v2_5_idle_work_handler(struct work_st=
ruct *work)
>         struct amdgpu_device *adev =3D vcn_inst->adev;
>         unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0=
};
>         unsigned int i, j;
> -       int r =3D 0;
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[i];
> @@ -149,15 +148,7 @@ static void vcn_v2_5_idle_work_handler(struct work_s=
truct *work)
>         if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_c=
nt)) {
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCN,
>                                                        AMD_PG_STATE_GATE)=
;
> -               mutex_lock(&adev->vcn.workload_profile_mutex);
> -               if (adev->vcn.workload_profile_active) {
> -                       r =3D amdgpu_dpm_switch_power_profile(adev, PP_SM=
C_POWER_PROFILE_VIDEO,
> -                                                           false);
> -                       if (r)
> -                               dev_warn(adev->dev, "(%d) failed to disab=
le video power profile mode\n", r);
> -                       adev->vcn.workload_profile_active =3D false;
> -               }
> -               mutex_unlock(&adev->vcn.workload_profile_mutex);
> +               amdgpu_vcn_put_profile(adev);
>         } else {
>                 schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_I=
DLE_TIMEOUT);
>         }
> @@ -167,7 +158,6 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_rin=
g *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[ring->me];
> -       int r =3D 0;
>
>         atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
>
> @@ -177,20 +167,6 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ri=
ng *ring)
>          * the delayed work so there is no one else to set it to false
>          * and we don't care if someone else sets it to true.
>          */
> -       if (adev->vcn.workload_profile_active)
> -               goto pg_lock;
> -
> -       mutex_lock(&adev->vcn.workload_profile_mutex);
> -       if (!adev->vcn.workload_profile_active) {
> -               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> -                                                   true);
> -               if (r)
> -                       dev_warn(adev->dev, "(%d) failed to switch to vid=
eo power profile mode\n", r);
> -               adev->vcn.workload_profile_active =3D true;
> -       }
> -       mutex_unlock(&adev->vcn.workload_profile_mutex);
> -
> -pg_lock:
>         mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
>         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VC=
N,
>                                                AMD_PG_STATE_UNGATE);
> @@ -218,6 +194,7 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_rin=
g *ring)
>                 v->pause_dpg_mode(v, &new_state);
>         }
>         mutex_unlock(&adev->vcn.inst[0].vcn_pg_lock);
> +       amdgpu_vcn_get_profile(adev);
>  }
>
>  static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
> --
> 2.49.0
>
