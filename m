Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED51CD6E73
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 14:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DEA610E8AA;
	Wed, 11 Oct 2023 14:20:11 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D86D10E8A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 14:20:08 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6c620883559so4609094a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697034008; x=1697638808; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9kVhLuAnizMPi6swrJjKmBsIKKZQdOxvM3iAsXXrVY=;
 b=etqwhmeuaeOUS0ISRaCsIDJ8U8boqJHYI8Ms5xz6JcYfHYozUhXCkiFzniatT0ZJhy
 bYoVAY4TKobnU2G5bZqeAHdlZp+WXqr8uUzKxs9q+k3fMTdXSFaxmnrVc0ATqnM+oIQx
 OMIfqh3ytaFV9K7CBrQNuXFB+TR30L1rJablCY/u62zXZD2283HwwjFa4CAK58RojUDW
 TRwsD611z75mefJvIqsFeDhCjhyzq5EInlZYLfP5cr64HiOTHmvtIyaeyELIRvPAXvn5
 ngIFoZfW3iTI1fCRaI9jdJG+FYQ68szNiN7DwSZYuh0RHls++btvAGcWASCmomu5SWk1
 mrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034008; x=1697638808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9kVhLuAnizMPi6swrJjKmBsIKKZQdOxvM3iAsXXrVY=;
 b=sjg0m4kNJf+6qqS4NuQxEaAgB0gNoduZKuvuxr0Q+REwlzLCBOlp7x9UMVi2nW0uBD
 lZuzcQDYYUqxomwY/1pFfeLubR+E1jKzqgvxCGeMD1YLiF0X3E1ajEGxAuBG3aRMY6hU
 MSpWsQ28Ld3MHUUzHyLNItSDVVL4/TPF9vw1903T97fCV512UxibwMfJcBs6+8qDTMGf
 DW40uQRsY7xGNLKnK0p9C0TCxysbK0931kA2hU29eA6AxSiy1OWnAeEO0IiBuwxuirUR
 D2b4rqS0X/Odca2NjuoPHj4YPZmxcGlJrQxabv07T5/Lf+cWAPYnPYStwxTkFBecfk4P
 y7ww==
X-Gm-Message-State: AOJu0YxKPSvX9EuCLSnsIu2lnPt25P9uUpJMG0sJlgBzPvcbBzj4DwmV
 cKnwDO1JhZUqr7R/zQmL87ksgn9Np8U85iVO2KifDcaGPYU=
X-Google-Smtp-Source: AGHT+IGBegtGst7qLSb8htlD932cE5qrkjeteasQPkeva5Ar4HY26BKTEsmTkN+3fs3j7TGBgd//8m8NgQx9wGOWU4U=
X-Received: by 2002:a05:6870:348e:b0:1d5:a58d:1317 with SMTP id
 n14-20020a056870348e00b001d5a58d1317mr24004351oah.10.1697034007744; Wed, 11
 Oct 2023 07:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231011072631.1901764-1-jesse.zhang@amd.com>
In-Reply-To: <20231011072631.1901764-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Oct 2023 10:19:56 -0400
Message-ID: <CADnq5_PUDDYMpajRmMqnqgaUh39SDFj6LDD_pxjwHNGr7jqPTw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable GFXOFF and PG during compute for GFX9
To: Jesse Zhang <jesse.zhang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org, Yifan1.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 11, 2023 at 3:52=E2=80=AFAM Jesse Zhang <jesse.zhang@amd.com> w=
rote:
>
> Temporary workaround to fix issues observed in some compute applications
> when GFXOFF is enabled on GFX9.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index d3805dbbbb6f..fef93d4edcbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -683,12 +683,16 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *a=
dev,
>
>  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idl=
e)
>  {
> +       enum amd_powergating_state state =3D idle ? AMD_PG_STATE_GATE : A=
MD_PG_STATE_UNGATE;
>         /* Temporary workaround to fix issues observed in some
>          * compute applications when GFXOFF is enabled on GFX11.
>          */
>         if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11=
) {
>                 pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled")=
;
>                 amdgpu_gfx_off_ctrl(adev, idle);
> +       } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =
=3D=3D 9) &&
> +               (adev->flags & AMD_IS_APU)) {
> +               adev->ip_blocks[AMD_IP_BLOCK_TYPE_GFX].version->funcs->se=
t_powergating_state((void *)adev, state);

Why not use amdgpu_gfx_off_ctrl(adev, idle); for consistency?

Alex

>         }
>         amdgpu_dpm_switch_power_profile(adev,
>                                         PP_SMC_POWER_PROFILE_COMPUTE,
> --
> 2.25.1
>
