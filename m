Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07B8C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 16:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D72410E57E;
	Thu,  1 Jun 2023 16:19:22 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2E010E57A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 16:19:20 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5585f58ac49so574844eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Jun 2023 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685636359; x=1688228359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0v4dkuocYAAGTe/gCIUat3iFhwSLkszQVHNRMl4jCc=;
 b=oaWgk93pZGh/HhAW1cbVQB7fnNLPMpZR2vEh8ec2fTIVgRNe1HBB2zOhAcCaa+h+rc
 ghpuqTeUXWViqLm0MX4T+LemmRxNn43WcPr+Z6F2f6bAMhxzWmQQBzkyCQ0UDQIJSxHv
 VxmfE2KCicXmFL7v9+Bss/wZYCjpBZNnOXfrACuV7tDzcYBaC7ukQABerHTqa+z/bD5G
 R27t+/wvj0AVzryvlfPYRPeSPglEoL3UBzuDpiWd/+LhqW7lTbogKXql5WSRl6usqPz6
 TOkp5xfwSgUm2C3f405/nFQl/MnXLgSkDT5uV+yq+6+AnjeGryeNW6vRTGQDMawlmwXI
 7WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685636359; x=1688228359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0v4dkuocYAAGTe/gCIUat3iFhwSLkszQVHNRMl4jCc=;
 b=WqciwNCYKEvSzemSDxmu+pLg35zlhCywrcwhGm3kqYo9WPO6Df40ihBSI1gHho2vj/
 z1NHCPQj3A4pRnrhl24KuHnFIXAdfNqFHldUB18Aof0r8qNxmQAJ5rdNpjYTkuTtxT07
 aKkv8khPhJ7VlNOQs/8sB9pNoh1Lf8/XP7xXcHj3TO6H4Z3AgcJtuUTbaJyhGtI4/leD
 XGOaWTEz+Ijls3+fvQni1fHavvNz9ViJR0hZOTEkSDRJlJjMKDRuet/obUNPleGX4zbT
 SjzCEt458C4QBv6ng+ZjYsuS5lFuCyp8URNuf5aD3oeanqNBtvA7ssD9rMwflZSDLRUQ
 Fugw==
X-Gm-Message-State: AC+VfDzdRM6G1uXnxFy1FPLCBIqPJAT4fbyPJpOf6W+jCgVGXM755otL
 7K1kCrdTnnqVkW2fqGK1hFIIHoVn7ntLpNnoVgC5cH71
X-Google-Smtp-Source: ACHHUZ5udHeHu/jfXxDleHyHSIrc1HWoNVPyRmpi79YLE4DPAGmU6Eu23JwvUreJAhUncNkGHH+G82Eq/9ZZhrgrjM0=
X-Received: by 2002:a4a:4913:0:b0:555:8c22:a169 with SMTP id
 z19-20020a4a4913000000b005558c22a169mr4630578ooa.9.1685636359306; Thu, 01 Jun
 2023 09:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230601143137.8633-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230601143137.8633-1-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Jun 2023 12:19:08 -0400
Message-ID: <CADnq5_OZu8KtxJ=QoUG_or-+5xPX5SYAAPKoGTiOXU9sU1F4-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix power context allocation in SMU13
To: Hawking Zhang <Hawking.Zhang@amd.com>
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 1, 2023 at 10:31=E2=80=AFAM Hawking Zhang <Hawking.Zhang@amd.co=
m> wrote:
>
> From: Lijo Lazar <lijo.lazar@amd.com>
>
> Use the right data structure for allocation.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index da059b02a153..09ac66ab9c34 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -534,11 +534,11 @@ int smu_v13_0_init_power(struct smu_context *smu)
>         if (smu_power->power_context || smu_power->power_context_size !=
=3D 0)
>                 return -EINVAL;
>
> -       smu_power->power_context =3D kzalloc(sizeof(struct smu_13_0_dpm_c=
ontext),
> +       smu_power->power_context =3D kzalloc(sizeof(struct smu_13_0_power=
_context),
>                                            GFP_KERNEL);
>         if (!smu_power->power_context)
>                 return -ENOMEM;
> -       smu_power->power_context_size =3D sizeof(struct smu_13_0_dpm_cont=
ext);
> +       smu_power->power_context_size =3D sizeof(struct smu_13_0_power_co=
ntext);
>
>         return 0;
>  }
> --
> 2.17.1
>
