Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAD8C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 15:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DD610E59D;
	Thu,  2 Feb 2023 15:53:50 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFD110E1DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 15:53:46 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1685cf2003aso2942334fac.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Feb 2023 07:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k8845DhxpcCJzS6d7ZTdKxj+bGI6JoA9oeQJ7TOpHew=;
 b=qb29RD6joT2pgdHzoXjWeT3Z25pL61Sb2K7xEp9X/Kbx/8S1hGAd5zUPY+USBGJ5Az
 NbfhXPZ2c92VvcpZV4XBDde1IyhNpaRRRy9RpXn3XZqr4jtRby63InkFJ3OHr2HyUB+v
 UsM5/PjcMCSTfSG+c9f+VdW9L1jle1Y0urIdHMFh2vbN7qVHs2YntBr3vuoIy5czj8t9
 lRvxs5c7X0MeLdO8uQCP7xb+INntJjsjxeQDYwuCtESQYXcFdT2PguZsRgyhX3DiPGi6
 gh2DyGVuSFXaszMk7yLJNevX+MGD/AlY/fapsW1YYG79x1k6C5aH9ZVRmK9AwK9wSGiP
 lsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k8845DhxpcCJzS6d7ZTdKxj+bGI6JoA9oeQJ7TOpHew=;
 b=XTDdTCmUndX5odIaiIxD81lvANV1cbRGuJOeYUPaI+jIypn+5OpFRVcmXJjOtc261q
 vuRNDOUXRL/IMWkfZNDhL42+GS6lPLnHWnNWmYifCWwFaReSuE8wnhGBz72L7VsRZVug
 CJujlgpBITqdh2wg2pDF3kscEFRKjumuUKsnGpxewchZ3E0aiUQ4/sXd3I6wvptfNOfQ
 B1SoRV38ML53OvI+bj7diAGv2XQCVyRO+qtueDmdMccNzVlGZQEt4ZPwjRkQD2K/jLNA
 DpHBNGI81Q6wme1yQtFnHGUwjfN/rqx4ILm0T7EQFaERSm3AGkCJ3UeztMIGrXSrkkHb
 iXyQ==
X-Gm-Message-State: AO0yUKV5ZomNHhIbIFnXo0SFvH2sVCZryNlrfCpOu0YkJv9NF8jSI41Q
 J4/M6uehxQRnzw4H/IdJc2Vm73kZbNcPmcIiJFQ=
X-Google-Smtp-Source: AK7set9yc4/3ckrFKN76PEYg8PZq1j5mv//lDOsFBhl3k68WPmgZa/xg/EYfTERflR8/DYhWppB2tShOHunm+5Z/7RY=
X-Received: by 2002:a05:6870:c087:b0:163:a303:fe2f with SMTP id
 c7-20020a056870c08700b00163a303fe2fmr332956oad.96.1675353226004; Thu, 02 Feb
 2023 07:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20230202075106.2274628-1-kenneth.feng@amd.com>
In-Reply-To: <20230202075106.2274628-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Feb 2023 10:53:34 -0500
Message-ID: <CADnq5_OWwedYahSrMxG6WimVYKwiGcs5us6QC=052KV5y5HBLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: enable athub cg on gc 11.0.3
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 2, 2023 at 2:51 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> enable athub cg on gc 11.0.3
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 2ea0b9142868..0615fdbf0a64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -677,7 +677,9 @@ static int soc21_common_early_init(void *handle)
>                         AMD_CG_SUPPORT_GFX_CGCG |
>                         AMD_CG_SUPPORT_GFX_CGLS |
>                         AMD_CG_SUPPORT_REPEATER_FGCG |
> -                       AMD_CG_SUPPORT_GFX_MGCG;
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_ATHUB_MGCG |
> +                       AMD_CG_SUPPORT_ATHUB_LS;
>                 adev->pg_flags = AMD_PG_SUPPORT_VCN |
>                         AMD_PG_SUPPORT_VCN_DPG |
>                         AMD_PG_SUPPORT_JPEG;
> --
> 2.25.1
>
