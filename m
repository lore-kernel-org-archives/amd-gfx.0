Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC4CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C53A2077D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHPz61wK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C53A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 721656E5CA;
	Thu,  4 Jun 2020 20:56:51 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214FA6E5CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 20:56:51 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id t18so7591147wru.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j6reEuElvTOt/OIbUtmIANjbdUEhh5Z6wOgQrUYWxD0=;
 b=AHPz61wKCbtwZe+O0VaYVUZsYEE6nyjOgi+qQ+L/ru4iSp3XeAtIiGZ1zNV/SKzUGO
 TBFedrIkIyjN4i8lScyYBP0yNEOfxjQiVXQLmkf2ZLnBn05yiI7xt3YxwkdCf/t3t8wi
 Um9pISnYDiDsq8+k3berDRGxFGxOqXTgPKu63bzMN5o1/7704Iv/jmnqY4c9DuncGQXG
 nxId3j9oU2TAQcFyrRmBMt691LNxPgoD8FLClqzfBdFkqzbjYda7zqJV1Xa0b9d+fbj2
 Ef1kgSa+f/42uFTuJ+PJZrhm7NGbIbqQCJQxWJjH4Vsko9z/eF5ryPDUfLvqFOxtwd1M
 U/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j6reEuElvTOt/OIbUtmIANjbdUEhh5Z6wOgQrUYWxD0=;
 b=q5JaExoQ0BJJk5VMGHmtiyxWH5xwfAheQ5A8AgdSJZDgaTVdP1i27wc3kQxbm5VP+D
 yQ0hcdTF2VzRq9WoxfvhTaco7jsULXoQ6jiJxsAAXVNXk06Plia0Rpj8L24S3V+AYzyw
 9c+VbeS9pVSivBtRtgi0mQRqlez0nvp6GFWKKOptOXmy+DQRWEV3Cgrw3zkvvBi+PB5S
 LPTjKjRnf7x3JwL7UIYl7nRLEkHLZghwBjyhaUhn9IvIvf5ZSK4eoPw7W+hpl3be2i2+
 iUX7B/OREFxc1CRJT3d5HuykY5y+QK4TVZcwPGKyVrXv27hFbBqwre09WCrtIH9a90tI
 IUjA==
X-Gm-Message-State: AOAM532lHh6JzZnRDor5I9X5djJuYTiaWp2jBbKyfT4anRfowGvgRB0+
 C4+dLF5Y/N9eiP7aXpbiZRJxg5C+HSxc5vWVuAD8DjWi
X-Google-Smtp-Source: ABdhPJyU4vXmPOAG/EwuXCcFQmmgOX8vZ4X4X72w1A4lF3EveQygy+xADhhxWmLI3ZRgSle1RS+0705KZBzpOAAA9e8=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr6592506wru.124.1591304209794; 
 Thu, 04 Jun 2020 13:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-8-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-8-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 16:56:38 -0400
Message-ID: <CADnq5_N6dBzBoOhM=BqFTd-+YNGR9urVkYjVV7Lk9ROYorFyXA@mail.gmail.com>
Subject: Re: [PATCH 08/16] drm/amd/powerplay: postpone operations not must for
 hw setup to late_init
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 4, 2020 at 12:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> So that we do not need to perform those unnecessary operations again on
> resume.
>
> Change-Id: I90f8a8d68762b5f88d7477934128a17bf67e3341
> Signed-off-by: Evan Quan <evan.quan@amd.com>

For the patch subject, I think it would be clearer as:

drm/amd/powerplay: postpone operations not required for hw setup to late_init

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 57 +++++++++++-----------
>  1 file changed, 28 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index cd7a3d3efa23..78fb2b42fc93 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -769,10 +769,36 @@ static int smu_late_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         struct smu_context *smu = &adev->smu;
> +       int ret = 0;
>
>         if (!smu->pm_enabled)
>                 return 0;
>
> +       ret = smu_set_default_od_settings(smu);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Set initialized values (get from vbios) to dpm tables context such as
> +        * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> +        * type of clks.
> +        */
> +       ret = smu_populate_smc_tables(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_init_max_sustainable_clocks(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_populate_umd_state_clk(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
> +       if (ret)
> +               return ret;
> +
>         smu_get_unique_id(smu);
>
>         smu_handle_task(&adev->smu,
> @@ -1178,39 +1204,10 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> -       /*
> -        * Set initialized values (get from vbios) to dpm tables context such as
> -        * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> -        * type of clks.
> -        */
> -       if (initialize) {
> -               ret = smu_populate_smc_tables(smu);
> -               if (ret)
> -                       return ret;
> -
> -               ret = smu_init_max_sustainable_clocks(smu);
> -               if (ret)
> -                       return ret;
> -       }
> -
>         ret = smu_override_pcie_parameters(smu);
>         if (ret)
>                 return ret;
>
> -       ret = smu_set_default_od_settings(smu);
> -       if (ret)
> -               return ret;
> -
> -       if (initialize) {
> -               ret = smu_populate_umd_state_clk(smu);
> -               if (ret)
> -                       return ret;
> -
> -               ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
> -               if (ret)
> -                       return ret;
> -       }
> -
>         /*
>          * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
>          */
> @@ -1428,6 +1425,8 @@ int smu_reset(struct smu_context *smu)
>         if (ret)
>                 return ret;
>
> +       ret = smu_late_init(adev);
> +
>         return ret;
>  }
>
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
