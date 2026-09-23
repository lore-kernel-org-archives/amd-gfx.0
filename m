Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2B8C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F2510F0D5;
	Wed, 23 Sep 2026 19:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJRLZSve";
	dkim-atps=neutral
Received: from mail-ua2-f38.google.com (mail-ua2-f38.google.com
 [74.125.226.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62ED10F0D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:27:27 +0000 (UTC)
Received: by mail-ua2-f38.google.com with SMTP id
 a1e0cc1a2514c-97cb5c91d5eso75229241.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 12:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790191646; cv=none;
 d=google.com; s=arc-20260327;
 b=I4n6jqO0EgDVUDWeUV5iyYAivH+IMOEIUCtm+SnRYcRB1HLgIBx5lSCin1PE+QHQvW
 QiB/g7Cx0Se2N2ISs1EWOJfJ1zjn5VYhcrJ9G2EMKu2XafHpkxqHnkA4y1YdNBrhJiqv
 71hy6qagq9Xh1rBhll1/rNtvMy39f707antSzTFppPzozRarxpQSXkYpiCujaK+JqFtX
 w1pX4J6YZ4YUFeI4R9xht/KK8tl3FLbkHDjcl6qr+J90peuojayrz1aVUnQPwq50WW1F
 icSQWppZtS3xwf1ScYKUu9R+rBCoB7uLwFbFDMfcIilcdu55+Uo4cUMrn9hp+d0vFsZJ
 m+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2FC0ieZ2QnQjGdzi6759a6c7gOGhpZZdJjkvsskC7nE=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=SLVkxqguqsfF/qzR1WaPTAcsabEjj61ta0CHTYjfQC/O8C5IPX1JSo/ngKk7TFeG/W
 ww9u0KFPVszATMSZwSDLjxgrFOJ+XUCmOOnVVMpuh2217xxrSP5f3ZZ5A40mXC1C2zNx
 JA1kAf0hhrTozGHnaFt4yvmZMw3tZ/eHHZDuC3esbcarv1OFGYlF7IrVAOxFYgvwq3Ph
 Y149e9m4zxiZ3Nt7gDqPovVDQoMsCzPEFgXV9R1ICFCzDl6T22Qc6IT0cZFK5sik/3xL
 zAHpHpcdk/ETMnwflubTcHIMTfQaAs3uNotKLp1FgkUn6ZHTs2uXblw8r+lTGu1ocnsw
 CGxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790191646; x=1790796446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2FC0ieZ2QnQjGdzi6759a6c7gOGhpZZdJjkvsskC7nE=;
 b=mJRLZSve+z0bY1By4Z2LmY3Ijc7Dz0Sp0VzMC3qbT9PcwnKX2XXN8CB/YPuougSPAL
 9pJKWvfVOPC1sCNPYo3gkNKfTGXUFvltR7MTMBO9z+mVA+rmRIo9qVmnS63yaD8uq/2c
 uusKQOVF7P3oTVpAF5Ff88MyuElEzhqqMbTs5APhs9eK27a//pGuyMtos3yVVnlk04Ex
 d0wluUB+okqBXGT09JtHYABbWu70YPEjW6eSd3VBxkzfef8lnNPFAwO8Tj9dd39SCfMI
 MuQPhnSdXKhtn4FHB93KSDxEF6x/h3hcSjYOWhfFpypDcjBmxe9NvxxT4WIOIZgBHN2j
 Y1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790191646; x=1790796446;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2FC0ieZ2QnQjGdzi6759a6c7gOGhpZZdJjkvsskC7nE=;
 b=a6DgfBeV+mL8Sn8p0deYYLSsbEYHAdQmzTveYAjXi6zw4ZMUx6CCBF1j3hufYtZdCw
 Nq/FaNqNJNRX4tfJw6IwLmNNELWaRJgUNN3gCO8ZObMJvuLw45oBnu4yvc9PC+P9ndZz
 i1jxaGG2X+Su7gI+Xj9tiLuT5UKUHFUULjzpNMmMjCg2GcXqOD5Cz+AweQWLTURyaFWq
 5gyGcd5Ok38/z8yiG/V6PY9eo+wWNfKF7AdeNEzP02FnF02MC7V2QAIXGkpYsToYn9VJ
 vg2Gfm/Df5glxK0meWVPs9GXfC9PW4QZXtfmrAXR9Bx/PtXLJktxFsGfinmFol0b6A47
 Kf8A==
X-Gm-Message-State: AFuF++nd51gmEf8PD+IXoPTwa8izgtZEOxzyB08KVLlltxevQc7dvSfn
 nx1dongI606HMpyAqtWw6/GXBV0njQTmPSn0CTebJTWnxKNqWgVbgCHqTeugjCJKBlFiPF3CaPY
 aYWyIRspU9gYPD/ezfmOhv9VntNiwvF4=
X-Gm-Gg: AYBFou1ijimUZVxFppOR1cmii94uLXAXSqKkDut/lTpQ/ynoNvIMAj7CzgLB+WFuebg
 xk0BGutHQW35snKu0ocTmvEY2Xz20z/7tMJxWMPt271DUuPNOdbs0T2f3YVtgyb5GTlQhmmhi0n
 EmR39kwh/PdqTYDqQyhZ6gNM6DC54kiMDUSmjc1QnC7grOourmjuj9QkyOmxXizoSYQt37cYvMD
 KKGf+7E2B1iM0kKNbZbSiU93mf4XFaNLRxgQMOUqvJvcYV+c1EoEzqThVE9hFWp/WEeKahIA8Vk
 /0IsNZ5oXvmwE8b7x5LQRjzpDh1+22f4gKceLXTVQ5si7ICABnOT3lf+I5KP7LYyKxTn9t8mGRP
 BeMvkplPCMoH640h2xGB3hwEZCwP6iRZ0TtJv7/BV1A==
X-Received: by 2002:a05:6102:4b03:b0:7a9:b6d8:8214 with SMTP id
 ada2fe7eead31-7af1c998c78mr175211137.1.1790191645988; Wed, 23 Sep 2026
 12:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260923191539.191909-1-alexander.deucher@amd.com>
In-Reply-To: <20260923191539.191909-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Sep 2026 15:27:11 -0400
X-Gm-Features: AclHuK_RFjjw4ZgxGhJhwE_bq-B3j4ZafGOCqdbcod8UvUKdjSNzrPkrDnQysgU
Message-ID: <CADnq5_Pc-9H0qgt_u7vbnKLFaVXr_vs0Z0rao+rT3m==ZFEisw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use new reset-affected accessors for
 userspace interfaces
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ignore this patch.  I sent the wrong patch out.

On Wed, Sep 23, 2026 at 3:26=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Use the new reset critical section accessors for debugfs, sysfs,
> and the INFO IOCTL to provide proper mutual exclusivity
> to hardware with respect the GPU resets.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |   4 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c         | 212 ++++++++++++++++++++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c          |   3 +-
>  4 files changed, 221 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 1b7673d239dbb..ba1f224fb99aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1780,7 +1780,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_f=
ile *m, void *unused)
>         }
>
>         /* Avoid accidently unparking the sched thread during GPU reset *=
/
> -       r =3D down_write_killable(&adev->reset_domain->sem);
> +       r =3D amdgpu_reset_domain_access_write_start(adev);
>         if (r) {
>                 pm_runtime_put_autosuspend(dev->dev);
>                 return r;
> @@ -1811,7 +1811,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_f=
ile *m, void *unused)
>                 drm_sched_wqueue_start(&ring->sched);
>         }
>
> -       up_write(&adev->reset_domain->sem);
> +       amdgpu_reset_domain_access_write_end(adev);
>
>         pm_runtime_put_autosuspend(dev->dev);
>
> @@ -2043,7 +2043,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u6=
4 val)
>                 return -ENOMEM;
>
>         /* Avoid accidently unparking the sched thread during GPU reset *=
/
> -       r =3D down_read_killable(&adev->reset_domain->sem);
> +       r =3D amdgpu_reset_domain_access_read_start(adev);
>         if (r)
>                 goto pro_end;
>
> @@ -2084,7 +2084,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u6=
4 val)
>         /* restart the scheduler */
>         drm_sched_wqueue_start(&ring->sched);
>
> -       up_read(&adev->reset_domain->sem);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>  pro_end:
>         kfree(fences);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index f2f179421c4da..a4ed540409ba7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -776,7 +776,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>                 return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT=
 : 0;
>         }
>         case AMDGPU_INFO_TIMESTAMP:
> +               ret =3D amdgpu_reset_domain_access_read_start(adev);
> +               if (ret)
> +                       return -EFAULT;
>                 ui64 =3D amdgpu_gfx_get_gpu_clock_counter(adev);
> +               amdgpu_reset_domain_access_read_end(adev);
>                 return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT =
: 0;
>         case AMDGPU_INFO_FW_VERSION: {
>                 struct drm_amdgpu_info_firmware fw_info;
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index df5bbdab1ea39..88f6afc9c72fa 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -31,6 +31,7 @@
>  #include "amdgpu_display.h"
>  #include "hwmgr.h"
>  #include <linux/power_supply.h>
> +#include "amdgpu_reset.h"
>  #include "amdgpu_smu.h"
>
>  #define amdgpu_dpm_notify_ac_dc(adev) \
> @@ -46,10 +47,14 @@ int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, b=
ool low)
>         if (!pp_funcs->get_sclk)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return 0;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_sclk((adev)->powerplay.pp_handle,
>                                  low);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -62,10 +67,14 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, b=
ool low)
>         if (!pp_funcs->get_mclk)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return 0;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_mclk((adev)->powerplay.pp_handle,
>                                  low);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -523,12 +532,16 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *ad=
ev, enum amd_pp_sensors senso
>                 return -EINVAL;
>
>         if (pp_funcs && pp_funcs->read_sensor) {
> +               ret =3D amdgpu_reset_domain_access_read_start(adev);
> +               if (ret)
> +                       return ret;
>                 mutex_lock(&adev->pm.mutex);
>                 ret =3D pp_funcs->read_sensor(adev->powerplay.pp_handle,
>                                             sensor,
>                                             data,
>                                             size);
>                 mutex_unlock(&adev->pm.mutex);
> +               amdgpu_reset_domain_access_read_end(adev);
>         }
>
>         return ret;
> @@ -1021,7 +1034,10 @@ void amdgpu_dpm_get_current_power_state(struct amd=
gpu_device *adev,
>                 goto out;
>         }
>
> +       if (amdgpu_reset_domain_access_read_start(adev))
> +               goto out;
>         *state =3D pp_funcs->get_current_power_state(adev->powerplay.pp_h=
andle);
> +       amdgpu_reset_domain_access_read_end(adev);
>         if (*state < POWER_STATE_TYPE_DEFAULT ||
>             *state > POWER_STATE_TYPE_INTERNAL_3DPERF)
>                 *state =3D adev->pm.dpm.user_state;
> @@ -1054,12 +1070,15 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performa=
nce_level(struct amdgpu_device
>         if (!pp_funcs)
>                 return AMD_DPM_FORCED_LEVEL_AUTO;
>
> +       if (amdgpu_reset_domain_access_read_start(adev))
> +               return AMD_DPM_FORCED_LEVEL_AUTO;
>         mutex_lock(&adev->pm.mutex);
>         if (pp_funcs->get_performance_level)
>                 level =3D pp_funcs->get_performance_level(adev->powerplay=
.pp_handle);
>         else
>                 level =3D adev->pm.dpm.forced_level;
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return level;
>  }
> @@ -1091,6 +1110,7 @@ int amdgpu_dpm_force_performance_level(struct amdgp=
u_device *adev,
>                                         AMD_DPM_FORCED_LEVEL_PROFILE_MIN_=
SCLK |
>                                         AMD_DPM_FORCED_LEVEL_PROFILE_MIN_=
MCLK |
>                                         AMD_DPM_FORCED_LEVEL_PROFILE_PEAK=
;
> +       int ret;
>
>         if (!pp_funcs || !pp_funcs->force_performance_level)
>                 return 0;
> @@ -1108,15 +1128,23 @@ int amdgpu_dpm_force_performance_level(struct amd=
gpu_device *adev,
>
>         if (adev->asic_type =3D=3D CHIP_RAVEN) {
>                 if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
> +                       ret =3D amdgpu_reset_domain_access_read_start(ade=
v);
> +                       if (ret)
> +                               return ret;
>                         if (current_level !=3D AMD_DPM_FORCED_LEVEL_MANUA=
L &&
>                             level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)
>                                 amdgpu_gfx_off_ctrl(adev, false);
>                         else if (current_level =3D=3D AMD_DPM_FORCED_LEVE=
L_MANUAL &&
>                                  level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
>                                 amdgpu_gfx_off_ctrl(adev, true);
> +                       amdgpu_reset_domain_access_read_end(adev);
>                 }
>         }
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
> +
>         if (!(current_level & profile_mode_mask) && (level & profile_mode=
_mask))
>                 amdgpu_dpm_enter_umd_state(adev);
>         else if ((current_level & profile_mode_mask) &&
> @@ -1142,6 +1170,7 @@ int amdgpu_dpm_force_performance_level(struct amdgp=
u_device *adev,
>         adev->pm.dpm.forced_level =3D level;
>
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return 0;
>  }
> @@ -1155,10 +1184,14 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_de=
vice *adev,
>         if (!pp_funcs->get_pp_num_states)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
>                                           states);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1173,11 +1206,15 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device=
 *adev,
>         if (!pp_funcs->dispatch_tasks)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
>                                        task_id,
>                                        user_state);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1203,6 +1240,9 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *a=
dev, char *table,
>             !pp_funcs->get_pp_table)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_pp_table(adev->powerplay.pp_handle,
>                                      &pptable);
> @@ -1213,6 +1253,7 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *a=
dev, char *table,
>                 memcpy(table, pptable, ret);
>         }
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1228,12 +1269,16 @@ int amdgpu_dpm_set_fine_grain_clk_vol(struct amdg=
pu_device *adev,
>         if (!pp_funcs->set_fine_grain_clk_vol)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handl=
e,
>                                                type,
>                                                input,
>                                                size);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1249,12 +1294,16 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_d=
evice *adev,
>         if (!pp_funcs->odn_edit_dpm_table)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
>                                            type,
>                                            input,
>                                            size);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1270,12 +1319,16 @@ int amdgpu_dpm_emit_clock_levels(struct amdgpu_de=
vice *adev,
>         if (!pp_funcs->emit_clock_levels)
>                 return -ENOENT;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
>                                            type,
>                                            buf,
>                                            offset);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1289,10 +1342,14 @@ int amdgpu_dpm_set_ppfeature_status(struct amdgpu=
_device *adev,
>         if (!pp_funcs->set_ppfeature_status)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
>                                              ppfeature_masks);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1305,10 +1362,14 @@ int amdgpu_dpm_get_ppfeature_status(struct amdgpu=
_device *adev, char *buf)
>         if (!pp_funcs->get_ppfeature_status)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
>                                              buf);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1323,11 +1384,15 @@ int amdgpu_dpm_force_clock_level(struct amdgpu_de=
vice *adev,
>         if (!pp_funcs->force_clock_level)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->force_clock_level(adev->powerplay.pp_handle,
>                                           type,
>                                           mask);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1340,9 +1405,13 @@ int amdgpu_dpm_get_sclk_od(struct amdgpu_device *a=
dev)
>         if (!pp_funcs->get_sclk_od)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1350,14 +1419,19 @@ int amdgpu_dpm_get_sclk_od(struct amdgpu_device *=
adev)
>  int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
>  {
>         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +       int ret;
>
>         if (is_support_sw_smu(adev))
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         if (pp_funcs->set_sclk_od)
>                 pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         if (amdgpu_dpm_dispatch_task(adev,
>                                      AMD_PP_TASK_READJUST_POWER_STATE,
> @@ -1377,9 +1451,13 @@ int amdgpu_dpm_get_mclk_od(struct amdgpu_device *a=
dev)
>         if (!pp_funcs->get_mclk_od)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1387,14 +1465,19 @@ int amdgpu_dpm_get_mclk_od(struct amdgpu_device *=
adev)
>  int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
>  {
>         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +       int ret;
>
>         if (is_support_sw_smu(adev))
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         if (pp_funcs->set_mclk_od)
>                 pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         if (amdgpu_dpm_dispatch_task(adev,
>                                      AMD_PP_TASK_READJUST_POWER_STATE,
> @@ -1415,10 +1498,14 @@ int amdgpu_dpm_get_power_profile_mode(struct amdg=
pu_device *adev,
>         if (!pp_funcs->get_power_profile_mode)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_power_profile_mode(adev->powerplay.pp_handl=
e,
>                                                buf);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1432,11 +1519,15 @@ int amdgpu_dpm_set_power_profile_mode(struct amdg=
pu_device *adev,
>         if (!pp_funcs->set_power_profile_mode)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_power_profile_mode(adev->powerplay.pp_handl=
e,
>                                                input,
>                                                size);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1451,6 +1542,9 @@ ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_de=
vice *adev, void *buf,
>         if (!pp_funcs->get_gpu_metrics)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
>                                         &table);
> @@ -1459,6 +1553,7 @@ ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_de=
vice *adev, void *buf,
>                 memcpy(buf, table, ret);
>         }
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1472,10 +1567,14 @@ ssize_t amdgpu_dpm_get_pm_metrics(struct amdgpu_d=
evice *adev, void *pm_metrics,
>         if (!pp_funcs->get_pm_metrics)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_pm_metrics(adev->powerplay.pp_handle, pm_me=
trics,
>                                        size);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1489,10 +1588,14 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu=
_device *adev,
>         if (!pp_funcs->get_fan_control_mode)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
>                                              fan_mode);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1506,10 +1609,14 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_de=
vice *adev,
>         if (!pp_funcs->set_fan_speed_pwm)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
>                                           speed);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1523,10 +1630,14 @@ int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_de=
vice *adev,
>         if (!pp_funcs->get_fan_speed_pwm)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
>                                           speed);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1540,10 +1651,14 @@ int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_de=
vice *adev,
>         if (!pp_funcs->get_fan_speed_rpm)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
>                                           speed);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1557,10 +1672,14 @@ int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_de=
vice *adev,
>         if (!pp_funcs->set_fan_speed_rpm)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
>                                           speed);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1574,10 +1693,14 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu=
_device *adev,
>         if (!pp_funcs->set_fan_control_mode)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
>                                              mode);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1593,12 +1716,16 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_devi=
ce *adev,
>         if (!pp_funcs->get_power_limit)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_power_limit(adev->powerplay.pp_handle,
>                                         limit,
>                                         pp_limit_level,
>                                         power_type);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1613,10 +1740,14 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_devi=
ce *adev,
>         if (!pp_funcs->set_power_limit)
>                 return -EINVAL;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_power_limit(adev->powerplay.pp_handle,
>                                         limit_type, limit);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1628,9 +1759,12 @@ int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu=
_device *adev)
>         if (!is_support_sw_smu(adev))
>                 return false;
>
> +       if (amdgpu_reset_domain_access_read_start(adev))
> +               return false;
>         mutex_lock(&adev->pm.mutex);
>         cclk_dpm_supported =3D is_support_cclk_dpm(adev);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return (int)cclk_dpm_supported;
>  }
> @@ -1639,14 +1773,19 @@ int amdgpu_dpm_debugfs_print_current_performance_=
level(struct amdgpu_device *ade
>                                                        struct seq_file *m=
)
>  {
>         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +       int ret;
>
>         if (!pp_funcs->debugfs_print_current_performance_level)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         pp_funcs->debugfs_print_current_performance_level(adev->powerplay=
.pp_handle,
>                                                           m);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return 0;
>  }
> @@ -1661,11 +1800,15 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amd=
gpu_device *adev,
>         if (!pp_funcs->get_smu_prv_buf_details)
>                 return -ENOSYS;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_hand=
le,
>                                                 addr,
>                                                 size);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1728,11 +1871,15 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device =
*adev,
>             !pp_funcs->set_pp_table)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_pp_table(adev->powerplay.pp_handle,
>                                      buf,
>                                      size);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1764,10 +1911,14 @@ int amdgpu_dpm_display_configuration_change(struc=
t amdgpu_device *adev,
>         if (!pp_funcs->display_configuration_change)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->display_configuration_change(adev->powerplay.pp=
_handle,
>                                                      input);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1782,11 +1933,15 @@ int amdgpu_dpm_get_clock_by_type(struct amdgpu_de=
vice *adev,
>         if (!pp_funcs->get_clock_by_type)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
>                                           type,
>                                           clocks);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1800,10 +1955,14 @@ int amdgpu_dpm_get_display_mode_validation_clks(s=
truct amdgpu_device *adev,
>         if (!pp_funcs->get_display_mode_validation_clocks)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_display_mode_validation_clocks(adev->powerp=
lay.pp_handle,
>                                                            clocks);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1818,11 +1977,15 @@ int amdgpu_dpm_get_clock_by_type_with_latency(str=
uct amdgpu_device *adev,
>         if (!pp_funcs->get_clock_by_type_with_latency)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_clock_by_type_with_latency(adev->powerplay.=
pp_handle,
>                                                        type,
>                                                        clocks);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1837,11 +2000,15 @@ int amdgpu_dpm_get_clock_by_type_with_voltage(str=
uct amdgpu_device *adev,
>         if (!pp_funcs->get_clock_by_type_with_voltage)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.=
pp_handle,
>                                                        type,
>                                                        clocks);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1855,10 +2022,14 @@ int amdgpu_dpm_set_watermarks_for_clocks_ranges(s=
truct amdgpu_device *adev,
>         if (!pp_funcs->set_watermarks_for_clocks_ranges)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_watermarks_for_clocks_ranges(adev->powerpla=
y.pp_handle,
>                                                          clock_ranges);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1872,10 +2043,14 @@ int amdgpu_dpm_display_clock_voltage_request(stru=
ct amdgpu_device *adev,
>         if (!pp_funcs->display_clock_voltage_request)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->display_clock_voltage_request(adev->powerplay.p=
p_handle,
>                                                       clock);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1889,10 +2064,14 @@ int amdgpu_dpm_get_current_clocks(struct amdgpu_d=
evice *adev,
>         if (!pp_funcs->get_current_clocks)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
>                                            clocks);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1904,9 +2083,12 @@ void amdgpu_dpm_notify_smu_enable_pwe(struct amdgp=
u_device *adev)
>         if (!pp_funcs->notify_smu_enable_pwe)
>                 return;
>
> +       if (amdgpu_reset_domain_access_read_start(adev))
> +               return;
>         mutex_lock(&adev->pm.mutex);
>         pp_funcs->notify_smu_enable_pwe(adev->powerplay.pp_handle);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>  }
>
>  int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
> @@ -1918,10 +2100,14 @@ int amdgpu_dpm_set_active_display_count(struct am=
dgpu_device *adev,
>         if (!pp_funcs->set_active_display_count)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_active_display_count(adev->powerplay.pp_han=
dle,
>                                                  count);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1935,10 +2121,14 @@ int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct =
amdgpu_device *adev,
>         if (!pp_funcs->set_min_deep_sleep_dcefclk)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return ret;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_h=
andle,
>                                                    clock);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1951,10 +2141,13 @@ void amdgpu_dpm_set_hard_min_dcefclk_by_freq(stru=
ct amdgpu_device *adev,
>         if (!pp_funcs->set_hard_min_dcefclk_by_freq)
>                 return;
>
> +       if (amdgpu_reset_domain_access_read_start(adev))
> +               return;
>         mutex_lock(&adev->pm.mutex);
>         pp_funcs->set_hard_min_dcefclk_by_freq(adev->powerplay.pp_handle,
>                                                clock);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>  }
>
>  void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
> @@ -1965,10 +2158,13 @@ void amdgpu_dpm_set_hard_min_fclk_by_freq(struct =
amdgpu_device *adev,
>         if (!pp_funcs->set_hard_min_fclk_by_freq)
>                 return;
>
> +       if (amdgpu_reset_domain_access_read_start(adev))
> +               return;
>         mutex_lock(&adev->pm.mutex);
>         pp_funcs->set_hard_min_fclk_by_freq(adev->powerplay.pp_handle,
>                                             clock);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>  }
>
>  int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device =
*adev,
> @@ -1980,10 +2176,14 @@ int amdgpu_dpm_display_disable_memory_clock_switc=
h(struct amdgpu_device *adev,
>         if (!pp_funcs->display_disable_memory_clock_switch)
>                 return 0;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return 0;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->display_disable_memory_clock_switch(adev->power=
play.pp_handle,
>                                                             disable_memor=
y_clock_switch);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -1997,10 +2197,14 @@ int amdgpu_dpm_get_max_sustainable_clocks_by_dc(s=
truct amdgpu_device *adev,
>         if (!pp_funcs->get_max_sustainable_clocks_by_dc)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return 0;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerpla=
y.pp_handle,
>                                                          max_clocks);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -2015,11 +2219,15 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states=
(struct amdgpu_device *adev,
>         if (!pp_funcs->get_uclk_dpm_states)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return 0;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
>                                             clock_values_in_khz,
>                                             num_states);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> @@ -2033,10 +2241,14 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_=
device *adev,
>         if (!pp_funcs->get_dpm_clock_table)
>                 return -EOPNOTSUPP;
>
> +       ret =3D amdgpu_reset_domain_access_read_start(adev);
> +       if (ret)
> +               return 0;
>         mutex_lock(&adev->pm.mutex);
>         ret =3D pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
>                                             clock_table);
>         mutex_unlock(&adev->pm.mutex);
> +       amdgpu_reset_domain_access_read_end(adev);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 7fee5c88b6736..f16e512e23de3 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -27,7 +27,6 @@
>  #include "amdgpu_drv.h"
>  #include "amdgpu_pm.h"
>  #include "amdgpu_dpm.h"
> -#include "amdgpu_reset.h"
>  #include "atom.h"
>  #include <linux/pci.h>
>  #include <linux/hwmon.h>
> @@ -144,7 +143,7 @@ static int amdgpu_pm_dev_state_check(struct amdgpu_de=
vice *adev, bool runpm)
>         bool runpm_check =3D runpm ? adev->in_runpm : false;
>         bool full_init =3D (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVE=
L_DEFAULT);
>
> -       if (amdgpu_in_reset(adev) || !full_init)
> +       if (!full_init)
>                 return -EBUSY;
>
>         if (adev->in_suspend && !runpm_check)
> --
> 2.55.0
>
