Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF882C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 18:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C7210F202;
	Wed,  1 Jun 2022 18:01:23 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95CF310F1DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 18:01:22 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-f33f0f5b1dso3703569fac.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F6iBcT41BHryTEQuHZzKScVsggTtm/T/JztvuzdpDQk=;
 b=oMOsMsZVAPzK/owWex5u7LXhYb55mK2at8f89KE9pK1brl4uoVwMy105XTQ22HazH1
 lsxvVqzLUlUBEvldG43/ILrEz1y9aLEZN6ZuvdIQfZn74OQ7kUmONKoeQt5Lf+H8zVnd
 dx0N/1GWJnLdysw3b57YfwzW5ndPvsX13sUT4PD0SyA9bczcdYo/N5I+y/rDuJ3dloyg
 IA7ohVQmX5de6YgIGFa3cYGESWOIrm9sxZezsFKde/7kMqOQBQ8JDKnvQFWFy1lp4qZH
 DxVzB4OJ+gGFpLLuw1jFXIyl7ymghOMQSJScXeVVfUgIcSLvdwjDKsDvZ+du6RUm89jo
 q6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F6iBcT41BHryTEQuHZzKScVsggTtm/T/JztvuzdpDQk=;
 b=blhcMGTugDHCiB5IECtR1tuy3io51yvVYC7FHSyJSV1CqkuBFXO4FrXzvKpxqTM33h
 CegdB1jM2qMuzA9eukSleupFRLw4S2ITxJKIGeUwAkfA5G9bnixnXDnzOMPbet2Ej95L
 nGgo//PW0JVulunGtsBvdKWbgrcYLsy1QhM7Ydyzo74TqEluvaScsAJjaP3MpMjHtthY
 1sAcp1yLSPv/WtvDfETHStnghcD524jvwlsfTpG3VozBVXoNzbFNNbNd2saBWol3LHX5
 GMg+Inei3kREVNbSyOUb7fsHaUP8SBkX+4On0XvYbSbMy2xWRDIxIeryJ0Fg0V4GdK9i
 XaqA==
X-Gm-Message-State: AOAM532I2RHbzXoRy8Tl5RkMOXTRd9dnA1WMVAd8+ycTVLu5nzZKJ+lF
 BGB4IfWoTfhlJDP/wnYRn6PCviCyH90f+rnqzxTlLRt5
X-Google-Smtp-Source: ABdhPJwZda/5/3n6unRPtBvl3pEtg4Za5W2mA0oZzr4iYZaZuEe+tejUD+Gpfxib/uNYVQYZaCLCRz8orlDp4w0TzB4=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr16606791oaa.200.1654106481853; Wed, 01
 Jun 2022 11:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220601175610.28448-1-candice.li@amd.com>
In-Reply-To: <20220601175610.28448-1-candice.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jun 2022 14:01:10 -0400
Message-ID: <CADnq5_NbW5PvP=-VpFY7w1RaUTCM16RS+YoaRft8D5HoGLfsSw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Resolve RAS GFX error count issue v2
To: Candice Li <candice.li@amd.com>
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

On Wed, Jun 1, 2022 at 1:57 PM Candice Li <candice.li@amd.com> wrote:
>
> Fix misleading indentation and add ras unsupported checking
> for gfx ras late init.
>
> Signed-off-by: Candice Li <candice.li@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 99c1a2d3dae84d..16699158e00d8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -599,13 +599,15 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>                 if (!amdgpu_persistent_edc_harvesting_supported(adev))
>                         amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
>
> -       r = amdgpu_ras_block_late_init(adev, ras_block);
> -       if (r)
> -               return r;
> +               r = amdgpu_ras_block_late_init(adev, ras_block);
> +               if (r)
> +                       return r;
>
>                 r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
>                 if (r)
>                         goto late_fini;
> +       } else {
> +               amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
>         }
>
>         return 0;
> --
> 2.17.1
>
