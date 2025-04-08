Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7655EC36010
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 20:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C40D10E277;
	Tue,  8 Apr 2025 20:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="In+OpAhk";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E5A10E277
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 20:14:07 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2ff62f9b6e4so959967a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744143247; x=1744748047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mr2q9GChdO9DUqvKz9Nj/ykkZ47AO3KGE8nKmciZk10=;
 b=In+OpAhkr79lupqcL/V4ZDBrjPyscGkdMH+1Wnz+je9FPKtAE8sA0HvGEDu+4Vo6Ax
 EClsll00eSn1dIDiL+TT7UDQcNCwmTF2TdlyWKtQgaJ17kf67gpUvzlvVt4SAq+3C9mf
 t7MyHwAdvKvctg0cYgvpGh/iOx1wEpCmqLG2NP07aXsw12npkhhr7AwFrtiVALsDNnZo
 Qe0citqlG2up0lkAjhlgjtwusJ79Pw80ZaXcKzMHu3D9kCM3LFWEH7xsLRqBmHDaXkv5
 LrvAARvt6WPaaQqzp9l5uJ+2Wq2JYcH2yz2QUTzsdgmBOXfgPhKQCmgp9ZFaw3BqlOdP
 1BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744143247; x=1744748047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mr2q9GChdO9DUqvKz9Nj/ykkZ47AO3KGE8nKmciZk10=;
 b=KnXco2lFIwur116jGJW6JsrybcGTXEFWPZKKw1H11ZMVvJfxhAJKOQ6vu8fJuRo01t
 qX+CnRa3mecBvWY6c+IghI9nPzqBDvSjmCdAJTTWSc4x+DY06R6j80uQgtViyO9vu3YN
 bs4nxZj3xERTWh1xuuinB1zLJiht66SlJOs7EgMz0TT8EBHcLjUirRjTTvqZnZ11RxDD
 AS1r5kYaB36hpZAy+JQ/FFG56NdFTWAkLDiyW0lgkteZlRzEOZhihy4G2sQyiAsEzG/J
 KLtbfIkGAO10/gJVxh2prSfzNS96W6VqLtet+yLrq+VTN+CevSToxiPhW8kf3wZsRXC2
 ZV+A==
X-Gm-Message-State: AOJu0YyxEN2+AS9rCAZ18rmnXxyEcgnu3BJdW2Ff+neOfPwrWlBi+VuV
 rAo/zTZwqPfMDNFUxTrqBBgYjk7a3X84jFUTEW0Hi7etN5mSSrs3g6sIOSHw/15p+k3G/vQjWW0
 h2heo8n6rAV54f0MItdrrs0QNzq/dWQ==
X-Gm-Gg: ASbGncvPltMMYFvb6g1sGvn+dCfHneTqb4hUl3cfMhwuY+0Coddf9nSGwGTocx0PVG5
 JM9olPQSw+8mu9RaLWhS6TCTIrGoN0uLREHKvEuhwEnoVgIDHxJb6lZWCQdrxoDKSyt7CGm4tVH
 U5ki9fyeRJL+DLMMmYCLZ7Mg5nWA==
X-Google-Smtp-Source: AGHT+IGvoYJRBEI4x9UUCF7aAnoWdafW545s56ztmTpiXz0k6SM2w+K7m9CMpDFLpqOPp627Ik8vDOA9lj/gvbEwcJI=
X-Received: by 2002:a17:90b:4b81:b0:305:5f25:59ad with SMTP id
 98e67ed59e1d1-306dbc3a122mr264020a91.7.1744143246792; Tue, 08 Apr 2025
 13:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250408180957.4027643-1-superm1@kernel.org>
In-Reply-To: <20250408180957.4027643-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Apr 2025 16:13:55 -0400
X-Gm-Features: ATxdqUEC0qBjPZcVBDxZgTI7Bg-Urkn451i76z9GNH0YHmJ0Q0F4el1BzdBDvwc
Message-ID: <CADnq5_O+tiw2Mfv6LBN-W0==Ew5Pa31W==N3=B2boO5zhjv0eA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Forbid suspending into non-default suspend states
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Tue, Apr 8, 2025 at 2:10=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> On systems that default to 'deep' some userspace software likes
> to try to suspend in 'deep' first.  If there is a failure for any
> reason (such as -ENOMEM) the failure is ignored and then it will
> try to use 's2idle' as a fallback. This fails, but more importantly
> it leads to graphical problems.
>
> Forbid this behavior and only allow suspending in the last state
> supported by the system.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4093
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 6d83ccfa42eeb..d79fd557b2d6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1124,6 +1124,7 @@ struct amdgpu_device {
>         bool                            in_s3;
>         bool                            in_s4;
>         bool                            in_s0ix;
> +       suspend_state_t                 last_suspend_state;
>
>         enum pp_mp1_state               mp1_state;
>         struct amdgpu_doorbell_index doorbell_index;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 26bf896f1444e..24ee4710f807f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2548,8 +2548,20 @@ static int amdgpu_pmops_suspend(struct device *dev=
)
>                 adev->in_s0ix =3D true;
>         else if (amdgpu_acpi_is_s3_active(adev))
>                 adev->in_s3 =3D true;
> -       if (!adev->in_s0ix && !adev->in_s3)
> +       if (!adev->in_s0ix && !adev->in_s3) {
> +               /* don't allow going deep first time followed by s2idle t=
he next time */
> +               if (adev->last_suspend_state !=3D PM_SUSPEND_ON &&
> +                   adev->last_suspend_state !=3D pm_suspend_target_state=
) {
> +                       drm_err_once(drm_dev, "Unsupported suspend state =
%d\n",
> +                                    pm_suspend_target_state);
> +                       return -EINVAL;
> +               }
>                 return 0;
> +       }
> +
> +       /* cache the state last used for suspend */
> +       adev->last_suspend_state =3D pm_suspend_target_state;
> +
>         return amdgpu_device_suspend(drm_dev, true);
>  }
>
> --
> 2.43.0
>
