Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FFFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 12:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0033F10E975;
	Thu, 24 Mar 2022 12:53:56 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B99C10E972
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 12:53:55 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 v19-20020a056820101300b0032488bb70f5so755352oor.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U7mEK+rdbedeXadTgYUHYawnwz8BXXF4vDe5MmnsLOw=;
 b=m3TOSnBXW+w83bWb2RZhDuwWkGshfFOJJ9cTwikCDsGuLPCXj9Nc63zriiIXKPGwxB
 lz0KNjRAwF3DyRGVqOtaXN/an4bz5Q81G2+xJ7uhK7qRLb9UvJdCWbcsnq6oohBxEMSI
 E2nPmZQn16dbAyz+r9Vo+KidSScp31FqnWIjrOFPb2/VQXeeAa/z5pGkHMBge/I38zA8
 HhjoFFfAqUpSvp7xUUBfK/hS3XZ6XoBjxa7EqkX/Ao3tDFJFuXXP72J+RAylBhfMot0b
 ZSmEfxteymG/SbMyty2Cz+BAbXx51gFVtUZ/E+qplbn4HC56e2n1iE87se8/77r7l+2S
 o8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U7mEK+rdbedeXadTgYUHYawnwz8BXXF4vDe5MmnsLOw=;
 b=deTVXeISRNCXZWK4hXvUfEGZ9TmBaua/Yvimu99FPsEKuiTEb0K/GFgChfmFkuEgpO
 PfLdQZmFp4n0fzToSX7Vm9alQWMhTFL3vSm7Y94oLEkBPFgStRcWdSyz34Lh0TaiQUBt
 mo1vBMgbV20Yyll9m6Lgxn/ODT5YxD1SKufGA2d54SARGVq0Ndo7FXWIrkD86BzIX6fX
 qUK9OSh9SwKoFmGtha/5NCq7sgeoOkZ9qbZcuRR0XuT5wP6Bcjw8jBlB0s7hgbAPvNbh
 sSps1i9Zkwauab/9plAjQPiZxjyMvXmqlGrO2r2GiOs5Lg4P1sxqRfFOZCaZBJ67m74D
 HK/w==
X-Gm-Message-State: AOAM531K8q8Jv+KDWhJyytV8OJmXtIeTeUiKFT+pcvuu5rc1VM3OWfqf
 KEcj8S8N3I0GHaQQx0SmwBvP7ltyS4eysWooYQk=
X-Google-Smtp-Source: ABdhPJwFyw4XXPXF2uN0G5iJju4JADcGmKbNxXFVbvOFDj4IBLS6IYvn13tXB5N185XIJlwb9FzV+oiX+PV3DA8bvTE=
X-Received: by 2002:a4a:e828:0:b0:320:a1e9:3e1 with SMTP id
 d8-20020a4ae828000000b00320a1e903e1mr1866631ood.68.1648126434488; Thu, 24 Mar
 2022 05:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <1648116809-30771-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1648116809-30771-1-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Mar 2022 08:53:43 -0400
Message-ID: <CADnq5_P3MfKt+Fis6WY+a+rMO9gS7MAporx77+zEbx+aMwuNKA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: enable gfx1037 clock counter retrieval
 function
To: Prike Liang <Prike.Liang@amd.com>
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
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Mar 24, 2022 at 6:16 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> Enable gfx1037 clock counter retrieval function for KFDPerfCountersTest.ClockCountersBasicTest.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index f4c6accd3226..a98b78e0b507 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7689,6 +7689,7 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>         switch (adev->ip_versions[GC_HWIP][0]) {
>         case IP_VERSION(10, 3, 1):
>         case IP_VERSION(10, 3, 3):
> +       case IP_VERSION(10, 3, 7):
>                 preempt_disable();
>                 clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh);
>                 clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Vangogh);
> --
> 2.25.1
>
