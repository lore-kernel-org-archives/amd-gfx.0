Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BF7D3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF5010E525;
	Mon, 28 Oct 2024 19:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I9m6DNBV";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084C110E525
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:13:03 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-7ea85fa4f45so704022a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730142782; x=1730747582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXVpzQ3Dnrn/kU1+YgOL8SMYcsC1W+JsdWFLwwXlqak=;
 b=I9m6DNBVdu1OVu0IDCYe5wZJGIZGTZL2HJGZH9QSH7JuC9ySWsMe/C116eA+NaZN25
 zbFtidU03cSGj5DXiM5WAJuKgILNq3iWV4Kp3/om7gGiQvO+c1wH9tASWmKtde7gTkhK
 48lF8aNc8ONtA5/bWG0QzHEMKkEupnz+4duj1sM7wjuiO13hnia1yWgnXDlLLVAUOwcN
 +FPLOBm14PEMdM/TY/mXo2XKcpUOlNonsYhWPe5gr7C4NeMkm7niPjIi88P0lqrpX3qC
 f/i7n1Oi4VLBINg8KI0iJ/NmDrwVZ+xNiUbLGK9asyLiOmdB0/McSnNuLgZiG90+CEu/
 8Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730142782; x=1730747582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXVpzQ3Dnrn/kU1+YgOL8SMYcsC1W+JsdWFLwwXlqak=;
 b=bnwzb07XnwH+Egg1RPzwf0ekKG7Hi23oHFu/wlY3y7DDvwvKi+oGddr41ahRXc8lkT
 8Ght7Rxlv+FPwvvkVqFmBXF5690OuIJwpbV9fiBxqH5jqUUGNcGwZ5R7izvRGOQKOk/W
 I7Ite/6erSbI8vRR8z57iklRsH/yXhLgXenoDNEIXHswlEVZa2dKQzzBOnDBAU3RL2NW
 JaNwIjeynavRS/dybRbjkXqUQvHhE7CG4jAmmRFSgWaCPGUmJvRjjetGkvUiYGie47Hs
 AsPKQkZRNUAox78jXWd9kMHMK8FtH1olVZqHXt9NT6VoYM4xgxHG4ldk/P6gMMniMQdU
 rhJA==
X-Gm-Message-State: AOJu0YxcO9z/ovWfHSlyXBOQqki0YdR9zRQoicsP84Q6O826wITep8xZ
 bNDnkxZ9Vt17M/wMfp2lMQCqoFyPhaLWKbTlxgR4JmNEqAo7M/MjS5aE1foVoxQs/wzPYSlK10Y
 +2rRLVpo3wqtGzCEMHXLq2P4aWCE=
X-Google-Smtp-Source: AGHT+IEd/yJYvfLe4ilmRD9alBPrrNrx0Fbb+8zxey0hHFRuIXMrmmM4z104wrcsYZuFkb2vkD/5ZhOSlHRm7by229k=
X-Received: by 2002:a05:6a20:9186:b0:1cf:3130:9966 with SMTP id
 adf61e73a8af0-1d9a83af558mr6176290637.3.1730142782372; Mon, 28 Oct 2024
 12:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-7-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-7-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:12:51 -0400
Message-ID: <CADnq5_M72hE=u9J-GKZc=DyZnXTx+a1jC2UH-5LZtR3wePS6Tw@mail.gmail.com>
Subject: Re: [PATCH 06/29] drm/amdgpu: add inst to amdgpu_dpm_enable_vcn
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

On Thu, Oct 24, 2024 at 11:13=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Add an instance parameter to amdgpu_dpm_enable_vcn() function, and change
> all calls from vcn ip functions to add instance argument. vcn generations
> with only one instance (v1.0, v2.0) always use 0 as instance number. vcn
> generations with multiple instances (v2.5, v3.0, v4.0, v4.0.3, v4.0.5,
> v5.0.0) use the actual instance number.
>
> v2: remove for-loop in amdgpu_dpm_enable_vcn(), and temporarily move it
> to vcn ip with multiple instances, in order to keep the exact same logic
> as before, until further separation in next patch.
>
> v3: fix missing prefix
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 12 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 12 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 12 ++++++++----
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 12 +++++-------
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
>  10 files changed, 59 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 511d76e188f2..7ad2ab3affe4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *i=
p_block)
>         idle_work_unexecuted =3D cancel_delayed_work_sync(&adev->vcn.idle=
_work);
>         if (idle_work_unexecuted) {
>                 if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_vcn(adev, false);
> +                       amdgpu_dpm_enable_vcn(adev, false, 0);
>         }
>
>         r =3D vcn_v1_0_hw_fini(ip_block);
> @@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_=
struct *work)
>         if (fences =3D=3D 0) {
>                 amdgpu_gfx_off_ctrl(adev, true);
>                 if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_vcn(adev, false);
> +                       amdgpu_dpm_enable_vcn(adev, false, 0);
>                 else
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCN,
>                                AMD_PG_STATE_GATE);
> @@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ri=
ng *ring, bool set_clocks)
>         if (set_clocks) {
>                 amdgpu_gfx_off_ctrl(adev, false);
>                 if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_vcn(adev, true);
> +                       amdgpu_dpm_enable_vcn(adev, true, 0);
>                 else
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCN,
>                                AMD_PG_STATE_UNGATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 697822abf3fc..f34cab96d0b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>         int i, j, r;
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, true);
> +               amdgpu_dpm_enable_vcn(adev, true, 0);
>
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>                 return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_s=
ram);
> @@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev=
)
>
>  power_off:
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, false);
> +               amdgpu_dpm_enable_vcn(adev, false, 0);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 0afbcf72cd51..beab2c24042d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1012,8 +1012,10 @@ static int vcn_v2_5_start(struct amdgpu_device *ad=
ev)
>         uint32_t rb_bufsz, tmp;
>         int i, j, k, r;
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, true);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, true, i);
> +       }
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1485,8 +1487,10 @@ static int vcn_v2_5_stop(struct amdgpu_device *ade=
v)
>                         ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>         }
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, false);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, false, i);
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index b28aad37d9ed..6d047257490c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1141,8 +1141,10 @@ static int vcn_v3_0_start(struct amdgpu_device *ad=
ev)
>         uint32_t rb_bufsz, tmp;
>         int i, j, k, r;
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, true);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, true, i);
> +       }
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1632,8 +1634,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *ade=
v)
>                 vcn_v3_0_enable_static_power_gating(adev, i);
>         }
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, false);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, false, i);
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index d87850dec27c..4b836b4935e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1088,8 +1088,10 @@ static int vcn_v4_0_start(struct amdgpu_device *ad=
ev)
>         uint32_t tmp;
>         int i, j, k, r;
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, true);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, true, i);
> +       }
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1614,8 +1616,10 @@ static int vcn_v4_0_stop(struct amdgpu_device *ade=
v)
>                 vcn_v4_0_enable_static_power_gating(adev, i);
>         }
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, false);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, false, i);
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 6fc52a1bda31..868302d63a4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1091,8 +1091,10 @@ static int vcn_v4_0_3_start(struct amdgpu_device *=
adev)
>         int i, j, k, r, vcn_inst;
>         uint32_t tmp;
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, true);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, true, i);
> +       }
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> @@ -1365,8 +1367,10 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *a=
dev)
>                 vcn_v4_0_3_enable_clock_gating(adev, i);
>         }
>  Done:
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, false);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, false, i);
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 398191a48446..f0ec8bc031c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1000,8 +1000,10 @@ static int vcn_v4_0_5_start(struct amdgpu_device *=
adev)
>         uint32_t tmp;
>         int i, j, k, r;
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, true);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, true, i);
> +       }
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1277,8 +1279,10 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *a=
dev)
>                 vcn_v4_0_5_enable_static_power_gating(adev, i);
>         }
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, false);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, false, i);
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 58f0611b8fb4..9f89e152e875 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -761,8 +761,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *ad=
ev)
>         uint32_t tmp;
>         int i, j, k, r;
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, true);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, true, i);
> +       }
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1008,8 +1010,10 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *a=
dev)
>                 vcn_v5_0_0_enable_static_power_gating(adev, i);
>         }
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, false);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               if (adev->pm.dpm_enabled)
> +                       amdgpu_dpm_enable_vcn(adev, false, i);
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 8531e0993b17..5a9006bfc3cd 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -581,7 +581,7 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev=
, bool enable)
>                           enable ? "enable" : "disable", ret);
>  }
>
> -void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
> +void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int =
inst)
>  {
>         int ret =3D 0;
>
> @@ -599,12 +599,10 @@ void amdgpu_dpm_enable_vcn(struct amdgpu_device *ad=
ev, bool enable)
>                 return;
>         }
>
> -       for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BL=
OCK_TYPE_VCN, !enable, i);
> -               if (ret)
> -                       DRM_ERROR("Dpm %s uvd failed, ret =3D %d. \n",
> -                                 enable ? "enable" : "disable", ret);
> -       }
> +       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_VCN, !enable, inst);
> +       if (ret)
> +               DRM_ERROR("Dpm %s uvd failed, ret =3D %d. \n",
> +                         enable ? "enable" : "disable", ret);
>  }
>
>  void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index e7c84d4a431a..251b389dcf6e 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -442,7 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_devic=
e *adev);
>
>  void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
>  void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
> -void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
> +void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int =
inst);
>  void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
>  void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
>  void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
> --
> 2.34.1
>
