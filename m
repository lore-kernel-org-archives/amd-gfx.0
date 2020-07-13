Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA313C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 17:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C54C206F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 17:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpUz9hGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C54C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8CE6E558;
	Mon, 13 Jul 2020 17:37:01 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253956E179
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 17:37:00 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id k6so17470711wrn.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ag7f9XLpzeWFQnjF5qVAVnpQp1aDmbe+SAIg6fWElh8=;
 b=mpUz9hGtrwzSVMjxgepjSTDJe7VwCtHi1x1YGIHhfsUzQJFTqY3D2iWFcGsy/r5kKs
 v7FXddRWb2K/3CRuV4yQbeNw/P3zWCpuTFJqZ6MP3SxLvoK4JZAqKLj3sgQ0FSet5H5f
 TnLnIUtYPBMZ5+2FtjJ4w4IHlzgD1LLYXCYnOZUk1GugIiYux1SplgtXBDnr9vVGalu0
 zBdYlSWyaOhUu75rtzOUXsBCqruv7EzmV7gs+IK58z2Z1sTBVFfVdfYapIBsvfud63dG
 fWZejzW3Bn64DDre8hvLlK4MAk8kCt6bacR0xZpVuEKqA1P+FiLnyPIW+ke6iPQMrDn6
 O+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ag7f9XLpzeWFQnjF5qVAVnpQp1aDmbe+SAIg6fWElh8=;
 b=BGvy4uRylgR71O2bZ4eMSyLD+Q3tfkZa4EuqgNSQvQcO2x3Pw2tex/7op+cLCbbyJp
 TqCVmILIM6+u2wyL0z6ImzutP12E+GIFMwvigkWvTlcWl0YTDorlXR0IFw1RPCUKy/xV
 lOLh/Wgy+qmyKXsITzlH32CYrYf1uZ01YY1eDvbmvU/Fn5hQuKzVoMXqM4q2NsKxDltR
 YY7owwpJGtq4+Vydp85iq21ZRmiVtd4nt0HwucuaLxamyUvztAddnwgC6lQhaHerAaIb
 WpXfQT0rZlYNDZhir0zuFiT/WwwsGyLH0n7nQQrjGkj87VD14ZbzVljvIQ2Ajtb4uWI4
 VdRg==
X-Gm-Message-State: AOAM531dfVRAA+QwrcXEJPdofjWZwawpnWIp7fgJT2er31sQP/c76fVU
 thZMvZ/8ubNrBrqcOdR5YD3oKe6bP+ehcSrqpqEbag==
X-Google-Smtp-Source: ABdhPJz4Tc9JHA8b+FXU38Bsdv5VxI4TwOUXxC/oTp2wVgK/XXV7o7j+sY/pHX3UnGSS4OqDfkAluDF1ffqy3shd08o=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr500725wrl.362.1594661817970; 
 Mon, 13 Jul 2020 10:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200713134744.2731945-1-shashank.sharma@amd.com>
In-Reply-To: <20200713134744.2731945-1-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2020 13:36:46 -0400
Message-ID: <CADnq5_PTpnac=KLM4UrjQgYOnknjxcxM70DSdCNWsKzk22HXag@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't ignore the return from thermal_init
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Sonny Jing <Sonny.Jiang@amd.com>,
 Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 13, 2020 at 9:48 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
> The current hw_init code for si_dpm ignores the return value of the
> function attempting to initialize the thermal controller, which in
> turn sets the dpm_enabled status wrongly to true in hw_init, which
> should be actually false.
>
> This patch:
> - Adds the return value check for thermal controller initialization,
>   and passes the return value to dpm_enable().
> - Adds a DRM_ERROR to indicate this failure.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
> Cc: Sonny Jing <Sonny.Jiang@amd.com>
>
> PS: This issue was observed on OLAND while running the reboot
> stress test.
>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

I have vague memories of this not being a fatal issue so it didn't
need to be checked, but it was so long ago I can't remember, and the
relevant history is not coming to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index c00ba4b23c9a..923a1da554b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -6868,7 +6868,11 @@ static int si_dpm_enable(struct amdgpu_device *adev)
>         si_start_dpm(adev);
>
>         si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
> -       si_thermal_start_thermal_controller(adev);
> +       ret = si_thermal_start_thermal_controller(adev);
> +       if (ret) {
> +               DRM_ERROR("si_thermal_start_thermal_controller failed\n");
> +               return ret;
> +       }
>
>         return 0;
>  }
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
