Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B04CC4727E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 13:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCBE2075F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 13:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KME9Dc+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCBE2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377A989B67;
	Wed, 30 Sep 2020 13:11:08 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C04B89B67
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 13:11:07 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e2so1717870wme.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pUyzb9WBxOGhpk26MafEsEvy0Q6lZZGclXhRAdp3YVI=;
 b=KME9Dc+/I61KnMu7fnC109j3D5DaSRfnilBKqrZVtHbzo4Vidv0nxs7LqJMo+kYI6t
 TtXGA78IFTzmZ/j9CIsu44EeF6z+SiVm+yYmTsCZ2ztyhO6Yd1UjJbM5dqugLSwRQaZZ
 FO3w3N/oJic3bMGxdxtd4k8ttTjCtaE2z4hL/0J65xOmmDeFYnoR0yWzCNhgatYpAmWH
 yDxfZeZTIwehLgICIvOw5/bgeaG0rPadgFlrAqMPzwex4PpeOEjrXlGmaB+CJwLysK2j
 2Io9Bs+9eIyi/0fvUMHka6uls2BzgMqe+XvfE+gSEsYCg87jJz+14ztL7cndE0UEzhXT
 s52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pUyzb9WBxOGhpk26MafEsEvy0Q6lZZGclXhRAdp3YVI=;
 b=VJYgukhAucHk8GIbYq2SFvk1MYET8pwgzPJ0zwzwOwFybdPE2zm1SBB8go2nZhQkdq
 BazoC+eEw48nFWJXy217ellWBn12YhbZbVzbzeHjzGsDfE/kztWZ5HyDlrsiDYxY3DN8
 Km1oMXSrkaiocjwL+rgxgetQe8MOZIULqNCV5yFMP6XDK7n9yzVRqS9IyUyBctp4f3XL
 U+THxjDTzwSNN7wCL4d37Dc9zHUN59Lnzz8NWl0QkJXq0a19Xwg2NrM2zVprDEX5P7Ze
 zq8cGOPv86UhPEUNxm+oGhM5XPWWZ2O+y+Np0VwepAk1k7rEaIInP6I7oBKrZM9irsGq
 UAjA==
X-Gm-Message-State: AOAM532O8g7ggomNwUTtuZ/U2B/tmcflz9d3rN+UzdxUSL/Qv5MDHgdJ
 QSYe5/Y4iilz73cYgAybGcaNVF+DptCtb+sOmxU=
X-Google-Smtp-Source: ABdhPJy+A3cU2tXBtBkiqlAnbeMgtCk8nS1dgUHVKxyx+2BqxqLBRRdxcdrmR2gPkrMrr6tNA8v4GOCbcExQxKh0E+Y=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr3015212wme.39.1601471466045; 
 Wed, 30 Sep 2020 06:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200930040756.23559-1-evan.quan@amd.com>
In-Reply-To: <20200930040756.23559-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Sep 2020 09:10:54 -0400
Message-ID: <CADnq5_MHtC+gt1ADceQWsYROL1fH5ypxVxNkc2EB0UnRGOj1gA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: setup APU dpm clock table in SMU HW
 initialization
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Dirk Gouders <dirk@gouders.net>, Huang Rui <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 30, 2020 at 12:08 AM Evan Quan <evan.quan@amd.com> wrote:
>
> As the dpm clock table is needed during DC HW initialization.
> And that (DC HW initialization) comes before smu_late_init()
> where current APU dpm clock table setup is performed. So, NULL
> pointer dereference will be triggered. By moving APU dpm clock
> table setup to smu_hw_init(), this can be avoided.
>
> Change-Id: I2bb1f9ba26f9c8820c08241da62f7be64ab75840
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reported-by: Dirk Gouders <dirk@gouders.net>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f46cf9ea355e..8f6045def272 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -482,17 +482,6 @@ static int smu_late_init(void *handle)
>                 return ret;
>         }
>
> -       /*
> -        * Set initialized values (get from vbios) to dpm tables context such as
> -        * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> -        * type of clks.
> -        */
> -       ret = smu_set_default_dpm_table(smu);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
> -               return ret;
> -       }
> -
>         ret = smu_populate_umd_state_clk(smu);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
> @@ -1021,6 +1010,17 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>                 return ret;
>         }
>
> +       /*
> +        * Set initialized values (get from vbios) to dpm tables context such as
> +        * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> +        * type of clks.
> +        */
> +       ret = smu_set_default_dpm_table(smu);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
> +               return ret;
> +       }
> +
>         ret = smu_notify_display_change(smu);
>         if (ret)
>                 return ret;
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
