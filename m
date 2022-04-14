Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC13FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 14:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAF510FE51;
	Thu, 14 Apr 2022 14:24:38 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EEE10FE5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 14:24:36 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-d39f741ba0so5369279fac.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zubuvLbYHMgK+1gHDUQdPuriS0jMN7gwIhgputKjZKA=;
 b=TJ/ko8+zo5ea4EnYIUAlR9nrTkyldWh2TzHcTsGd9SiGpqI2OOj7zJjhmBkC0bkAEC
 g9GXDX9E8EyD23sZ3R+fpC7vqSL7G3NIW9MXaBptIGbVv8vVc6Y05GTZJPI6sPM157pK
 G0pFV3GhbFtqOztmvLZhhbqP2igGUaVdeuqIvxShJka6XtLa2aIW7KQKRiPy+pten+pL
 jTb+KCqXS28oqmK1+CbJxHOzk/B5UZnpNA7JYz0v0Ky7TQeQ2fqquVPwAi2tNpZEFF7p
 gLAjsu5BdrpEAVh27aegdqyrtGJentv5dK5+8d2Gm2Tb5zaw5UxZ/GmKn6eo4Q+cjyBh
 of6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zubuvLbYHMgK+1gHDUQdPuriS0jMN7gwIhgputKjZKA=;
 b=vguuSGNzWE53q/MFOK7I3zpvU1iSMhNFlmL/ZV4qsibsKn8c5Rg2FDR3ZLGv25tUGI
 WtcZZVNntI/KNhePRImoZMJAATK2X4OfHZ1QufTIOM8YnnEPdcFBKd97GHBY8u3qVV05
 vjtjlytdtPp5LFwjvwz/wAy8NjMNJvqgLOOxj5sFvcvdxvfza+JyaQVzqQ7xNFUqbriK
 RK4As7qG/LHbkSmyGcP3dz8m1frvuugjQlUGwbDgx1AfFdR9HTU+tFVIN+QcMGjgrqfa
 n5+Pil/7QBbROHLdxUT8EwFBaW603KOSevSAfs6ZHP7YP8nwNmR5Mfj6cuBzbO4kaAKp
 R9AQ==
X-Gm-Message-State: AOAM530zEgCzzo7oeOvLdagTjrX462k/DAIS8B0os4DDSzm9wviKOAOD
 tFWj4WHixEohp9YT/O/ovfKPWo8y3LgItz12yaHXURC4tGM=
X-Google-Smtp-Source: ABdhPJxgcez0NV0zufHJ7tWnmEJ70CY3D/ECHw3p5L3zKpUrE4cJdIPfLrAsx0uXC+16xUic8K2mbANAe+3uiIhKkJ4=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1571960oaa.200.1649946275863; Thu, 14
 Apr 2022 07:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220413152641.830023-1-Gavin.Wan@amd.com>
In-Reply-To: <20220413152641.830023-1-Gavin.Wan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Apr 2022 10:24:24 -0400
Message-ID: <CADnq5_Msif0acYK_2xfG+cF+yhdHrK5Vuht97K8NAq4q2bqBxA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Remove static from variable in RLCG Reg
 RW.
To: Gavin Wan <Gavin.Wan@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 13, 2022 at 11:27 AM Gavin Wan <Gavin.Wan@amd.com> wrote:
>
> [why] These static variables saves the RLC Scratch registers address.
>       When we installed multiple GPUs (for example: XGMI setting) and
>       multiple GPUs call the function at same time. The RLC Scratch
>       registers address are changed each other. Then it caused
>       reading/writing to wrong GPU.
>
> [fix] Removed the static from the variables. The variables are
>       in stack.

Please add:
Fixes: 5d447e29670148 ("drm/amdgpu: add helper for rlcg indirect reg access")

With that added.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
> Change-Id: Iee78849291d4f7a9688ecc5165bec70ee85cdfbe
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index d5eea031c3e3..d18a05a20566 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -868,11 +868,11 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
>         uint32_t timeout = 50000;
>         uint32_t i, tmp;
>         uint32_t ret = 0;
> -       static void *scratch_reg0;
> -       static void *scratch_reg1;
> -       static void *scratch_reg2;
> -       static void *scratch_reg3;
> -       static void *spare_int;
> +       void *scratch_reg0;
> +       void *scratch_reg1;
> +       void *scratch_reg2;
> +       void *scratch_reg3;
> +       void *spare_int;
>
>         if (!adev->gfx.rlc.rlcg_reg_access_supported) {
>                 dev_err(adev->dev,
> --
> 2.32.0
>
