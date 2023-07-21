Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E28EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 15:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0290910E6A6;
	Fri, 21 Jul 2023 15:41:14 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B4F10E6A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 15:41:12 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b9c434fe75so1737157a34.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689954072; x=1690558872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpKHxLWKHVJhOIopCs7GfZq9v/+6tn+/iX3Ov3iJCtg=;
 b=FWKOUAQWg6dDRAng5Cn93DVGa/MbhUdPUZj/AV5KLjUxVnFdHDYwUvfmm2IuWOdn0d
 AYsvp5GcL4cV/xPx7Az5GOidTS7qfHM6tcvosaVxJYmx+wF4SOyRX/wz2euyzk6icKDz
 fWZR+E/9mumaDFc0chBlMSccq2vMSu/JxL3kUWDoHnKJUqJoVmSNzfYNo1+UBwdaxIpL
 PSeAL5DWQ7ErfwvrBcN3W7hRgHHYJZ+TDlA6gKg8Nrxl3e/CjPL3W7MSJBtjqVHKJkQm
 W357lAHbRdlnqmz14v0FLcP5oeZxw3ZR5F5/bm9vXpFEs099k85p5+xK6w3YPllD7VwY
 LOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954072; x=1690558872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpKHxLWKHVJhOIopCs7GfZq9v/+6tn+/iX3Ov3iJCtg=;
 b=aZx3rFnYrPRZqb+iXCecVnV9UuByjHRAFoDpIniA5JbQr7S3YNuk5neDgkFWFrifSe
 Xla+kBs6ujvfguUURvMdmTpz0ZxhHO+Zpr4adXbMGI14sJkIJCAi4zR1LZ6WFwiqsmma
 AlVGSXYw2I5pYZ1G+DKaTDxLV0GnRmZqeIqkbGMXzQ33MUxeHSE9qu4Tdpm6QzMlbqoV
 P0Hb9TSoCUteVg7MjVHJPOxP7Ezwb3eZJYBYq5lZZzl8lLbfDKu2Y5ozdqHSwPnTp/yL
 CUL2hlCzdIvadCu7s2uwDFQXqTirB9M1wqrJUXetIDyiBN72MkycBc4vcTNd616TMCIX
 VDJw==
X-Gm-Message-State: ABy/qLb7u0N7knJEIqkT+qrHgQFk6xgHHuZ5dO4xR24s0HR0M1a8qv3U
 HnqbyZEUFeOlKJghf0xPQ2MGYPrFy4gz/4vPhukxyV8e+uQ=
X-Google-Smtp-Source: APBJJlGN/NIFApIoqOjnN7E3C2rG14hhBu9OmowBwcINmTNAS1FFDsUYvqQ9t4wHi92ljUwI3OnffIGMERviG/Shq1c=
X-Received: by 2002:a05:6870:c206:b0:1ba:cc76:a266 with SMTP id
 z6-20020a056870c20600b001bacc76a266mr2327876oae.35.1689954071832; Fri, 21 Jul
 2023 08:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230721074917.723184-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230721074917.723184-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Jul 2023 11:41:01 -0400
Message-ID: <CADnq5_PmsPUvm9WH1SkPi8f=AYqQg8urq7=NGP2Ahh7GniuE9g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Prefer #if IS_ENABLED over #if defined in
 amdgpu_drv.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 21, 2023 at 3:49=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Adhere to linux coding style
>
> Fixes the following:
>
> WARNING: Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE
> +#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
>
> WARNING: Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE
> +#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 3d9171eca11c..c315fe390e71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -584,7 +584,7 @@ module_param_named(timeout_period, amdgpu_watchdog_ti=
mer.period, uint, 0644);
>   */
>  #ifdef CONFIG_DRM_AMDGPU_SI
>
> -#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
> +#if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE=
)
>  int amdgpu_si_support =3D 0;
>  MODULE_PARM_DESC(si_support, "SI support (1 =3D enabled, 0 =3D disabled =
(default))");
>  #else
> @@ -603,7 +603,7 @@ module_param_named(si_support, amdgpu_si_support, int=
, 0444);
>   */
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>
> -#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
> +#if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE=
)
>  int amdgpu_cik_support =3D 0;
>  MODULE_PARM_DESC(cik_support, "CIK support (1 =3D enabled, 0 =3D disable=
d (default))");
>  #else
> --
> 2.25.1
>
