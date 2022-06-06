Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF84C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 15:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19652112574;
	Mon,  6 Jun 2022 15:27:28 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EB3112574
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 15:27:26 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id r206so20109917oib.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jun 2022 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NsY1V/3SigrZvPfVaxcoPf/HHb9uszGBu14LzeecxRI=;
 b=IbKIXOsed1Us2c/CRpxsbb/7I4jairuB4ofhEoeP41wd/DKC15n7M3i954pQ7ZmmY7
 ozoqyoIOWJua3kqre5mzL9Y9QiNSsP3zl25liZryw6OBNQekf53/iAT7n4tqpU+lMRiP
 Ga+1+b68gGhPYMZwVFuLVQzj1QCGu6JCqN4SLaAS//v8bfqQlHoJLB0jQVDBppOY2VUa
 dKC9CaFFdI5wH3ityx/4fIx3JI8LNOfEcHZsIJksgJtHxm5OjuatMzr3JAkLHPYWwl4i
 j+MJ60BmbQiWGFXPogB64Fkq/4+fZPlkDe/VLb54CaTflET0i56MZ5xdYpFe6ueDxwJy
 Yi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NsY1V/3SigrZvPfVaxcoPf/HHb9uszGBu14LzeecxRI=;
 b=pptl1S33f7llliwY1gU58QQJzMj2M6jqDcOGaXQQBQl5NPQ9LTan1jSRoxbbOca+3x
 FbCRNIGIFaW04e7m2j+RB+Cm1mK1zHTWHiVkTvsHBkgwTICsqOj1vvqX53iK9ERdVfAt
 raMza8KI2PiHkYp11UBhfNHJlb+gAt1tlzATVW6Bjm47NvEzvwaitcNWW0iWGFbNUDvI
 DRzUWZU3LSpK8p3NwzGhulBkJRfGUMPkdPIz7aOQm5AoYjbnHo70Ot8E70GSIDTC7ihu
 YqgYku6qUFxSKR/faSB6EKANwRA8NMoKhaPh5puYtQbM6WRXQNRXpHbB4ZKJrh9oWknt
 htLg==
X-Gm-Message-State: AOAM533KWuSxjtL7y5V4odOjcTzYczjrr66VK7VR4deKBF26ToXuyu9H
 8BF2DXudt7zvz5NAv+9LDKNBOwKrTD4hKv/n4qhHaVMM
X-Google-Smtp-Source: ABdhPJygRDSDc20uX8smJWZy2M4xTaA3t4j6WHeFYqAT/jCfNXnmXxwR/0zy/FcpSqq30VVel35GGLx2MlwyrS2hKGo=
X-Received: by 2002:a54:4f01:0:b0:32e:726c:bced with SMTP id
 e1-20020a544f01000000b0032e726cbcedmr6518944oiy.253.1654529245892; Mon, 06
 Jun 2022 08:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220606031124.1818265-1-evan.quan@amd.com>
 <20220606031124.1818265-6-evan.quan@amd.com>
In-Reply-To: <20220606031124.1818265-6-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jun 2022 11:27:14 -0400
Message-ID: <CADnq5_P+0VPovCROTwGXPe3ww14V_bKHYNrjpvwQKM1Sc4Ai8w@mail.gmail.com>
Subject: Re: [PATCH V2 6/6] drm/amd/pm: drop unneeded dpm features disablement
 for SMU 13.0.0/7
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patches 2-6 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Sun, Jun 5, 2022 at 11:13 PM Evan Quan <evan.quan@amd.com> wrote:
>
> PMFW will handle that properly. Driver involvement may cause some
> unexpected issues.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I77da7d894485a3ac6a1a956e4d2605d0bc730c25
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index a2db68847477..fd269b8510a5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1402,6 +1402,18 @@ static int smu_disable_dpms(struct smu_context *smu)
>                   (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
>                  ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
>
> +       /*
> +        * For SMU 13.0.0 and 13.0.7, PMFW will handle the DPM features(disablement or others)
> +        * properly on suspend/reset/unload. Driver involvement may cause some unexpected issues.
> +        */
> +       switch (adev->ip_versions[MP1_HWIP][0]) {
> +       case IP_VERSION(13, 0, 0):
> +       case IP_VERSION(13, 0, 7):
> +               return 0;
> +       default:
> +               break;
> +       }
> +
>         /*
>          * For custom pptable uploading, skip the DPM features
>          * disable process on Navi1x ASICs.
> @@ -1439,7 +1451,6 @@ static int smu_disable_dpms(struct smu_context *smu)
>                 case IP_VERSION(11, 0, 0):
>                 case IP_VERSION(11, 0, 5):
>                 case IP_VERSION(11, 0, 9):
> -               case IP_VERSION(13, 0, 0):
>                         return 0;
>                 default:
>                         break;
> --
> 2.29.0
>
