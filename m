Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75957C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 20:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27B110EE52;
	Thu, 16 Dec 2021 20:18:21 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B97610EE52
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 20:18:20 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id s139so477849oie.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 12:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nTdrCBDvxZFkKBNzBMql6nHEeJsHv9iS95IgBKxJe9g=;
 b=cxK2bWVK8Lvyhk7imqcj4NIE185rvT/Yo+LgsFvob/4+BKhfinolk7TGmtRIPm2cBD
 e+eS2TyRdqCoME1owkkaOXhU5pXZWOJF6FxAM9mTM4vnNJYyHSXCPclHZh85Yn58VoiW
 M20OiZlHgs6leDxO4hckqzT2Zskq2Fn7RqgcOshMBzlGBhKJKVqGVPxSLczAfNjwWzcs
 l65+awTvQra/j3+GEUyRhrxSSLXCrou5EpBJF94KI1CkKdl36r4FEv56s6Hrd9rBD7EP
 kCY2DnarIEZgzkxJI3FD0Cv0Pl3bZk2q4jLIksVnLvwj/sFtw/csS65jLtNbUhx8C3bf
 OhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nTdrCBDvxZFkKBNzBMql6nHEeJsHv9iS95IgBKxJe9g=;
 b=03gw6Z5+hZI90gnP2PwVUV8OS3vtN9Mqfkp03nNaY3r/x+pnF7SVNe3kgzLltYf/rx
 CMtlXGqDsgaR1B8Gs1YR6/B2VdDFu7uEcxVGVAkfVVQebKPNVhvIU2sa00TsReqUIqbS
 4Lgw0WHCzYkdWd63q1dRM/9W4rHGBrR+zCZgAJ6tcW1bYXc/3nVsjXE8JFfTpu0txrD5
 FJRnXq8ZCHpyj0TFMh26J/gAAwSBNskQ9pfT9CKvkKHH75gA6WfNiJzfzrC0THZk8bTd
 trfb4SthoD3atFEKaGxnOxUq39rYqpf3N9WNfEbSJwg1XMUHMeGwzq0jejEf5smmCR4F
 /Tpg==
X-Gm-Message-State: AOAM531bGAhff0FlMH5c0C+WdKzYqqAbgmMPkmmDBX6Y8E194OE8cYJe
 mag/m3waYqr+iGW56y55TDl6WWUYS4MbcQKxw97qfv6+dnY=
X-Google-Smtp-Source: ABdhPJyL0ZpjT3wGLl2tCNCYHKa2Shu1+ZT3OvYqAw+mVeQUptpuOa1Zdcaxf1rxZxvh0mjWS4vwNwyH87PL3K+hOmk=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr5503743oib.120.1639685899742; 
 Thu, 16 Dec 2021 12:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
 <20211216194233.3839-5-victor.skvortsov@amd.com>
In-Reply-To: <20211216194233.3839-5-victor.skvortsov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Dec 2021 15:18:08 -0500
Message-ID: <CADnq5_Ow9sz5Lyho=6ZasS7mbxtXk4TjG9YttZRRuz_xEj8izA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init
To: Victor Skvortsov <victor.skvortsov@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Davis Ming <Davis.Ming@amd.com>, Jingwen Chen <JingWen.Chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Emily Deng <Emily.Deng@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>, Horace Chen <Horace.Chen@amd.com>,
 "monk.liu" <Monk.Liu@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 16, 2021 at 2:43 PM Victor Skvortsov
<victor.skvortsov@amd.com> wrote:
>
> Driver needs to call get_xgmi_info() before ip_init
> to determine whether it needs to handle a pending hive reset.
>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 6 ------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 6 ------
>  3 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5bd785cfc5ca..4fd370016834 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3576,6 +3576,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (r)
>                 return r;
>
> +       /* Need to get xgmi info early to decide the reset behavior*/
> +       if (adev->gmc.xgmi.supported) {
> +               r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +       if (r)

Indentation looks off here, please fix that.  Also, will this conflict
with Shaoyun's xgmi init patch which may or may not have landed?
Other than that, these patches look pretty good to me.

Alex


> +                       return r;
> +       }
> +
>         /* enable PCIE atomic ops */
>         if (amdgpu_sriov_vf(adev))
>                 adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index ae46eb35b3d7..3d5d47a799e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -914,12 +914,6 @@ static int gmc_v10_0_sw_init(void *handle)
>                 return r;
>         }
>
> -       if (adev->gmc.xgmi.supported) {
> -               r = adev->gfxhub.funcs->get_xgmi_info(adev);
> -               if (r)
> -                       return r;
> -       }
> -
>         r = gmc_v10_0_mc_init(adev);
>         if (r)
>                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 2b86c63b032a..57f2729a7bd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1628,12 +1628,6 @@ static int gmc_v9_0_sw_init(void *handle)
>         }
>         adev->need_swiotlb = drm_need_swiotlb(44);
>
> -       if (adev->gmc.xgmi.supported) {
> -               r = adev->gfxhub.funcs->get_xgmi_info(adev);
> -               if (r)
> -                       return r;
> -       }
> -
>         r = gmc_v9_0_mc_init(adev);
>         if (r)
>                 return r;
> --
> 2.25.1
>
