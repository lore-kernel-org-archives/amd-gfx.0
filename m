Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39D8C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 13:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE2810E6DA;
	Thu, 13 Jul 2023 13:27:58 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6130D10E6DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 13:27:56 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1b060bce5b0so601974fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689254875; x=1691846875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmOimVlgrJ44SAbuQR5tp66hJC0+w7h8mp5M3Z7/x+w=;
 b=KHaBrn+51DPb9TwJ+DpBoqQ1Ma6+Rxj4w494r+ACB0FHY09MwskPsgpuXVO00IXZbg
 nXXr91eoFCQx+QdH+rf/Qw7t5LzIUyOElQc0m8qOkyhqoHWIBOyx8Z2NV6ww0DZ8KVLc
 ZZxf5ZttNbYEgW0+aHaeb/TqcpxJSv9F5wc3yVcRON7uHz5vyrY9rg7DoviVaKDClEeX
 IbPd0IteHcbQEbQhnbH7UI/dKZLmEFOEDZil622q/n1OW1zjgllVUDAtQ85kqscjlzzc
 guVlLD+vY8o7v/RhmDUJZOXeU10wQovWrCPWRYc18Cu8s1mh+qkRzEv828TDyLfFP/SX
 VL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689254875; x=1691846875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmOimVlgrJ44SAbuQR5tp66hJC0+w7h8mp5M3Z7/x+w=;
 b=GTsKYqCtldualLBFOp6W7kEgAPA9b+lmQFw1CIZxeEdzORi7sN0VV0xw6XIsF/XfLN
 10BlMezJDsbxm+LKigsCFzqaA1f9EWajoG2F6E18UfJiXE8UsFUICSUnzswnFJvfwSjO
 TX1V33FXU4ax+wtj/kvACTdYPkwFgSAPQHPpu9pygYgJPLT8BPomM9jF4pzpkVPZ8vuQ
 lXcjaQ4BQvfiZr3TbESoZtx1YfV+DY82pRRWc3crGg+y30LVb1l8wi7BQnI3StANUXvS
 hPgZ+za4Rdndj+iyK/Jf6JNfKm4rBmw7kn4J+YA16IWoF01raOazdpRfWET5ctqu7OUm
 HyDA==
X-Gm-Message-State: ABy/qLbdoCST3SP33KxqHORKZ5jtf91LglN8Kz4ZnnLQFk0e+7Ws2vUv
 gkwdTytg2s186CmKEqr8B1jgrlxYfvL/+iVLVV0=
X-Google-Smtp-Source: APBJJlGiT94j+MswRh9C4MulsZ/32UwwrEr4W79aTv2VsqJ/zQbLb4gutUrzOh1d7H4gEy4grAPn8OI1X7J04w0htAU=
X-Received: by 2002:a05:6870:c698:b0:1b0:151c:9b16 with SMTP id
 cv24-20020a056870c69800b001b0151c9b16mr2067826oab.17.1689254875233; Thu, 13
 Jul 2023 06:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230712184646.7955-1-alexander.deucher@amd.com>
In-Reply-To: <20230712184646.7955-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Jul 2023 09:27:44 -0400
Message-ID: <CADnq5_PL4dAb2bRRfTdGgawAVNVCwBieAKtk36F8BBzXHA+5mw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: enable mcbp by default on gfx9"
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: candice.li@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 12, 2023 at 2:47=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This reverts commit 50a7c8765ca69543ffdbf855de0fd69aea769ccf.
>
> This breaks some SQA tests on gfx9 dGPUs.  Chistian
> also reported problems.

Apparently this is a bug in mesa which this change uncovered:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/24082/diffs

Alex

>
> Cc: candice.li@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 6 +++---
>  2 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index bbe4ea93db611..3673015a7f93a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3699,11 +3699,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_d=
evice *adev)
>         if (amdgpu_mcbp =3D=3D 1)
>                 adev->gfx.mcbp =3D true;
>
> -       if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 0, 0)) &&
> -           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
> -           adev->gfx.num_gfx_rings)
> -               adev->gfx.mcbp =3D true;
> -
>         if (amdgpu_sriov_vf(adev))
>                 adev->gfx.mcbp =3D true;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 33e370d998a87..f829a80e52924 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -180,7 +180,7 @@ uint amdgpu_dc_feature_mask =3D 2;
>  uint amdgpu_dc_debug_mask;
>  uint amdgpu_dc_visual_confirm;
>  int amdgpu_async_gfx_ring =3D 1;
> -int amdgpu_mcbp =3D -1;
> +int amdgpu_mcbp;
>  int amdgpu_discovery =3D -1;
>  int amdgpu_mes;
>  int amdgpu_mes_kiq;
> @@ -635,10 +635,10 @@ module_param_named(async_gfx_ring, amdgpu_async_gfx=
_ring, int, 0444);
>
>  /**
>   * DOC: mcbp (int)
> - * It is used to enable mid command buffer preemption. (0 =3D disabled, =
1 =3D enabled, -1 auto (default))
> + * It is used to enable mid command buffer preemption. (0 =3D disabled (=
default), 1 =3D enabled)
>   */
>  MODULE_PARM_DESC(mcbp,
> -       "Enable Mid-command buffer preemption (0 =3D disabled, 1 =3D enab=
led), -1 =3D auto (default)");
> +       "Enable Mid-command buffer preemption (0 =3D disabled (default), =
1 =3D enabled)");
>  module_param_named(mcbp, amdgpu_mcbp, int, 0444);
>
>  /**
> --
> 2.41.0
>
