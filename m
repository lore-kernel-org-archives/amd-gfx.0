Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A32C43219
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 14:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F2710E7F7;
	Fri,  4 Nov 2022 14:20:52 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF2EF10E814
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 14:20:42 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id c129so5350201oia.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Nov 2022 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u+GvduzejMIbbWKPTAQrgLHPC5lkS1WL6WlkzBrko8I=;
 b=MRITKC0Trmrv9KVr/1QFCNRLY4J9jtWDIOPAUvLMF4c846yDufA8JkK5OCibk0cXaa
 LBn4w4lui/rYLl1HC2Uoc3QDO6Knj5UrIxf16Mai1E8iDv7AzJ1XAoiCrVqnCVDYCeGS
 JPUBTTisXEZD3D0dk1ICySupvoLdR7namloG2yfh2ocr5PHd1Ah+2M1c0Ulu9mnCJXKr
 RTXuqQw42uyOCQdWlAZKgWTTBUN6stbCCs+WV5NaTDQuGAFlnOadgjYR1mh71T1fB/z0
 3hjsU8F+ZLmM8ZltZUbnVj3Tqv7Dh6NBRMtQqb4lLDBRZmVD4ZNDTJKVEfLp1LP+dajN
 zhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+GvduzejMIbbWKPTAQrgLHPC5lkS1WL6WlkzBrko8I=;
 b=GgdHfUZb+5J/6ptVJLSA2fzoTvMIN4fsVpSFaw8eNI+SjkC/CgPgZKkVpgzaDuPmm7
 Z8ts6Kt+UDYV/boVHnd2HEejRpaI65BU2/IheiilKopAO+AyKJdzU9JibrgrAimUGMsj
 e+5KOgBIyfq+Vj4+ildLuvTjnGPuAgMqNSyz1c+90OPH8ta9aGeLBIAD5mz5zg0QkOlc
 w1098ETte/He9I9cYarDXOxc+hgXPd7l3/hXo3XXq8ZiimMnKuW9bvKIcMKT4TylFYxw
 lKtko3c0JQJR2rnuxPs+NfQUMwXs7F13iEadxCZVVNfAQt54uTLZvZp0NqF4ujWE84rh
 DolQ==
X-Gm-Message-State: ACrzQf1ScHmDpTvfkMXSD7upE/80R0eIL5n/6V4sGpwlL4qmjL+iAafs
 Ig1elkx4gtUAdPsWpdlmCUU6oV34nFRunmikM/c=
X-Google-Smtp-Source: AMsMyM6IFvIztzX0Wf387O5Vb/QT4sbVcJQnf2ynPrBVQEbgfNO/BH0I7g0B5DidOgo1JOQraNLAS0wa32upJLWIOZQ=
X-Received: by 2002:aca:b655:0:b0:35a:4fb4:c3d2 with SMTP id
 g82-20020acab655000000b0035a4fb4c3d2mr4625865oif.96.1667571642143; Fri, 04
 Nov 2022 07:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221104093022.446357-1-Asher.Song@amd.com>
In-Reply-To: <20221104093022.446357-1-Asher.Song@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Nov 2022 10:20:30 -0400
Message-ID: <CADnq5_N5bHiqswNgeC6FTfLn6sVdufQVEd=a7267Foiq45wjSA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: Revert "drm/amdgpu: getting fan speed
 pwm for vega10 properly""
To: Asher Song <Asher.Song@amd.com>
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
Cc: stalkerg@gmail.com, ernstp@gmail.com, Guchun.Chen@amd.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, evan.quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 4, 2022 at 5:30 AM Asher Song <Asher.Song@amd.com> wrote:
>
> This reverts commit 97370f1826eb7ee6880e09ee1eaafe28232cabc6.
>
> The origin patch "drm/amdgpu: getting fan speed pwm for vega10 properly" works fine. Test failure is caused by test case self.

Instead of reverting the revert, can you just reapply the original
patch and amend the commit message with this statement?
Either way:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Signed-off-by: Asher Song <Asher.Song@amd.com>
> ---
>  .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 +++++++++----------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> index dad3e3741a4e..190af79f3236 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> @@ -67,22 +67,21 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
>  int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
>                 uint32_t *speed)
>  {
> -       uint32_t current_rpm;
> -       uint32_t percent = 0;
> -
> -       if (hwmgr->thermal_controller.fanInfo.bNoFan)
> -               return 0;
> +       struct amdgpu_device *adev = hwmgr->adev;
> +       uint32_t duty100, duty;
> +       uint64_t tmp64;
>
> -       if (vega10_get_current_rpm(hwmgr, &current_rpm))
> -               return -1;
> +       duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
> +                               CG_FDO_CTRL1, FMAX_DUTY100);
> +       duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
> +                               CG_THERMAL_STATUS, FDO_PWM_DUTY);
>
> -       if (hwmgr->thermal_controller.
> -                       advanceFanControlParameters.usMaxFanRPM != 0)
> -               percent = current_rpm * 255 /
> -                       hwmgr->thermal_controller.
> -                       advanceFanControlParameters.usMaxFanRPM;
> +       if (!duty100)
> +               return -EINVAL;
>
> -       *speed = MIN(percent, 255);
> +       tmp64 = (uint64_t)duty * 255;
> +       do_div(tmp64, duty100);
> +       *speed = MIN((uint32_t)tmp64, 255);
>
>         return 0;
>  }
> --
> 2.25.1
>
