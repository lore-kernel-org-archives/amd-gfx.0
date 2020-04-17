Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A79C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 21:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C145720936
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 21:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmOfjxyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C145720936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85CFC6EABC;
	Fri, 17 Apr 2020 21:27:26 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3ECC6EABC
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 21:27:25 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id t63so3307507wmt.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c5ghpWABB2HAeCyRTWIEskXqF39Roo83ms8428JTYsI=;
 b=dmOfjxyv/TqJP81+OAMSCEsyTAztwALU73CHnf2AhECUeELMC5qlNZ1vIsb1luAaAl
 uEaE8W8/3oStAwu6f52h5LBMRppQ8zP6ikMPFuUoZ489cTE+5l35wKznwGucyZLv5r+X
 We3d6N8uxzxNn5Pr0YwcwR51g2ZN/jCj58wiK3WwTbW32Y0zXf9dGt269khgWUarB3CO
 uNpQNV2kJsMb5qY0BbNVHK+ZuKaHiPV3bHl5Wax5eqKRepiur3pZWwb4NSibXppy6ICv
 azD01WDucd6+IuPp44CmrkaHRljnUVni4RvdAgfstC9pngCtUCV073IsZeWkMMDKShIG
 USwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c5ghpWABB2HAeCyRTWIEskXqF39Roo83ms8428JTYsI=;
 b=OGMbKOwELl2TiMQvE9Twk5lLvH8Nvkmfo9CeYCZr5Io1GLOdxfFXaSxkAw84IZkJ6m
 cumOiWWgZDu8ODpJ7syN+2egixfOgbkXX7EhTSBe6H/fF2uoYP7f326I/sYRcntspF8J
 FTCpWhJp1h9e+jVsiCB+vn5QLTigyZY7omvpvhdrkm01PxWKGVVB/3GJUQGcgyVAgFn3
 faV3rhKpu/GpDv0wnYHX+yCn0YEWeQDm5ZH0P0NmCCrmLoHj2CfVoxkRgUdOb3/itluO
 RyuOqr2Vlu7GVU69rOmVBSYRhwKSkzWXuBBR7MP+72iDVvfC3CTLLmv8ncHcwdRMx6FQ
 AxcQ==
X-Gm-Message-State: AGi0PuZzPPBaEuTuUGB4wdJEVji/Q89+84HhCB3fatW5bfWDXwWAgGWe
 K1sm8fPyt9duepn2HDUHcDGwRPoJdFsAkC/yN0U=
X-Google-Smtp-Source: APiQypIUimvc8lb7SwnWNyECHMXPtMS2jJi+w8G4fp+t8pKXDJkxRvPSw29beyy9A78nUw8lu7jPQjLq4pomrcPv+5g=
X-Received: by 2002:a1c:2842:: with SMTP id o63mr5253135wmo.73.1587158844407; 
 Fri, 17 Apr 2020 14:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200417204446.13999-1-Yong.Zhao@amd.com>
 <20200417204446.13999-3-Yong.Zhao@amd.com>
In-Reply-To: <20200417204446.13999-3-Yong.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2020 17:27:13 -0400
Message-ID: <CADnq5_O9FhbWUpLB1K+xyP5YhS=z8GGVZ3s4JN-hNKn7gOztJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Print CU information by default during
 initialization
To: Yong Zhao <Yong.Zhao@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 17, 2020 at 4:45 PM Yong Zhao <Yong.Zhao@amd.com> wrote:
>
> This is convenient for multiple teams to obtain the information.
>
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 71ea56e220ae..92b7a1ff1dc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3170,7 +3170,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                 goto failed;
>         }
>
> -       DRM_DEBUG("SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
> +       DRM_INFO("SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",

While you are at it, replace this with pr_info or dev_info.  The
output is more useful with multiple devices in a system.

Alex

>                         adev->gfx.config.max_shader_engines,
>                         adev->gfx.config.max_sh_per_se,
>                         adev->gfx.config.max_cu_per_sh,
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
