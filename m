Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D83CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 22:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3664A6128B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 22:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3664A6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF0A89CAF;
	Tue, 19 Oct 2021 22:09:13 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E5D89CAF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 22:09:13 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id z126so7081367oiz.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cptNoQLpyZ14q4dHAEbrpq9I1NjZGfbN+ectWVQ+Enc=;
 b=VyqjuUGn+A9hDTaguup/KuTfx3QhaKKL9UqIuN1pSzTMBJ2ujf5FVr4evnKC0xYxAP
 /hPQIevxt3ZmPsGusimJH+CzoNqHmH9hx5reBWllkcP8FmZZQHCsYzgihTdelW0fHxAW
 dUdieD3dKTVjzbFiTFEAigeh6oqo2BuBrkygoMqZP8oEW7vRDUIIXR3P5gR28Iu70raw
 /TOw9g5THUycn6nnU21aQNxJSisLRtHTxZI6ecm0Ck/De8YyHdMAu3rFLYuZax1Z/on8
 po0eag6QqnN2+P/1+ss8qgLKPOsRcUMLUoxfCMujCaikRNR/dyddgvMhMsqTyAgyxOFs
 3TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cptNoQLpyZ14q4dHAEbrpq9I1NjZGfbN+ectWVQ+Enc=;
 b=pA9g+vEespBnGUrLY5x3A81VS1YzguMbpljf8ZNJIcfJMZIw7KDYAKWP1sLVIOSbIF
 2Y5zYXLAKS+c8xbULYEvPxR8fPsQMBxPZNAMOIfuSNQ6Dlhvi4ksdlrRp08kyvWKkBrA
 g/4A2wXP1w6ODcGAsg5T+V+m2rECgShFe+iX9nWbJRFNHFTElTEfU1pTrrBEoHOtkD5l
 PgTsQ5JpFKEj+cWS3ZWE/gCkSbAMeeHJeAjOWQrTQ3BCbW2qIY7BhJu8Jy40UP+vhjJv
 6vgvVBTgdg7GOFHMp7c9ZZW+I56e/nEzePDjS4UcTg2qpn0EF5fUsBGtBbwf2CU+gKgt
 MZHA==
X-Gm-Message-State: AOAM531KKz7a9Tg3uTNeenClWVb71YyCnXZjNg1/gU8yYAC2gCqQEVr9
 ZwAQVatUidagdBkgQRP13C1qNYy7DQ175BfZI80=
X-Google-Smtp-Source: ABdhPJx8VbFomhyKcaBDsI+rTqZA2uvbuoG9BOhP0bKyfSHVCPfJ0ALHQj6vLVqcZgjMO2rROm+sIKipPwzoG5ater8=
X-Received: by 2002:aca:d6d2:: with SMTP id n201mr6129009oig.120.1634681352478; 
 Tue, 19 Oct 2021 15:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211019214934.4088-1-Vignesh.Chander@amd.com>
In-Reply-To: <20211019214934.4088-1-Vignesh.Chander@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Oct 2021 18:09:01 -0400
Message-ID: <CADnq5_OyuuNKrmMLH18iuKTkbNCReMeLDT6kCToc--m2sLgyVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Enable GPU metrics for One VF mode
To: Vignesh Chander <Vignesh.Chander@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Shaoyun Liu <Shaoyun.Liu@amd.com>, "Nieto, David M" <David.Nieto@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 19, 2021 at 5:49 PM Vignesh Chander <Vignesh.Chander@amd.com> wrote:
>

Please add a patch description, something like:

Enable GPU metrics feature in one VF mode.  These are only possible in
one VF mode because the VF
is dedicated in that case.

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
> Change-Id: I14a5c4d6b9d790b7f298b67cece2c501a003e2a7
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index c255b4b8e685..01cca08a774f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2019,15 +2019,15 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>         AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,                              ATTR_FLAG_BASIC),
>         AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,                               ATTR_FLAG_BASIC),
>         AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,                               ATTR_FLAG_BASIC),
> -       AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,                    ATTR_FLAG_BASIC),
> +       AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,                    ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>         AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,                        ATTR_FLAG_BASIC),
> -       AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,                         ATTR_FLAG_BASIC),
> -       AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,                         ATTR_FLAG_BASIC),
> +       AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,                         ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +       AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,                         ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>         AMDGPU_DEVICE_ATTR_RO(pcie_bw,                                  ATTR_FLAG_BASIC),
> -       AMDGPU_DEVICE_ATTR_RW(pp_features,                              ATTR_FLAG_BASIC),
> -       AMDGPU_DEVICE_ATTR_RO(unique_id,                                ATTR_FLAG_BASIC),
> -       AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,               ATTR_FLAG_BASIC),
> -       AMDGPU_DEVICE_ATTR_RO(gpu_metrics,                              ATTR_FLAG_BASIC),
> +       AMDGPU_DEVICE_ATTR_RW(pp_features,                              ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +       AMDGPU_DEVICE_ATTR_RO(unique_id,                                ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +       AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,               ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +       AMDGPU_DEVICE_ATTR_RO(gpu_metrics,                              ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>         AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,                     ATTR_FLAG_BASIC,
>                               .attr_update = ss_power_attr_update),
>         AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,                    ATTR_FLAG_BASIC,
> --
> 2.25.1
>
