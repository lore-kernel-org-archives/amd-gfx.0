Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FF0C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 14:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E96410E2B5;
	Wed,  2 Feb 2022 14:16:26 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7889B10E2B5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 14:16:25 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id q186so39905726oih.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Feb 2022 06:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kUTqJvQLBP4qXCh6Kfo0fkGreFrKjovQO/50myQNXnM=;
 b=V5SBbYnxKwXPvSALwo1UorYb6pK98t/rc1LyNcSJLsIzkOVnHAwbjV+90X0ojs2tT2
 GM2w5Qvy2z/x5XoiS3RC29okjDc6husILnxI8HN19W78vEy9LQeLY9Gip8k/VkYEkU1A
 TdYMnKFHb7wD/1tCTmrKeZQ9Hq4uc/imRGM4RVwXKilvn8GCfQOYd5Wec3wydmcrSXeq
 6ab9sgyPvgX7O7X3YcaRKLVvadNYnCZX43YosbU6xca63cS3mbNXdOD3bhhoNq/V5qId
 Q/Y+l7GqzeEyFrhtaGtreCUxe8mHluX0qVn9imWBqTQpX3qEsUkczbLOWQdJ9E3n9Vpb
 dq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kUTqJvQLBP4qXCh6Kfo0fkGreFrKjovQO/50myQNXnM=;
 b=A0paUTf3hey4WI1wcC8qn8Y0Tg5scku9SfFDBuehauHCR/BCZJvhw1z1nsdi0y9iZZ
 0KmWPr+gGf/1B47hZ/nLEQ9q1ng5RqCFj0o+U85yIRHHbgNI6v6uXyauOGYKrdhuvX3C
 MkPomIwD9wRkkWTP5Lu7Sav+9GMnO2WjO41vjesAKM/OsEi/KL56ITJeiEiUwKTEZpvJ
 usCOm3lUsAjvnLH7xSOBLMGzolWzvBDMIZJ49Yy1UAKn7TGLT8Z6eq+Rur5zRFkoezxJ
 I1t5b7Qp4W/goxhGLsmBTcYe1+KpgLElqSAY96zqzpRVe4WtHP5b6W5KnaWDNL4TrfU5
 DH2w==
X-Gm-Message-State: AOAM533sqKWG/3qo3EeNlrpPr3Eye9cuBJKppxrg64/adYyDf10sctEe
 fNgVLmnsldG+iwRz4WIdqETWTyG0lntE+kXdmnUPfa6ZyO0=
X-Google-Smtp-Source: ABdhPJzrqnHWiOymSYyW5oRy5DN6N1fpNoxjs1iHMwQAa47nGNcyA4vwEd2bxnHn/ngiF6K8bIUGmA0Eb3FXyf1/+dM=
X-Received: by 2002:a05:6808:159e:: with SMTP id
 t30mr2269140oiw.132.1643811384700; 
 Wed, 02 Feb 2022 06:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20220202090644.1031115-1-rajib.mahapatra@amd.com>
In-Reply-To: <20220202090644.1031115-1-rajib.mahapatra@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Feb 2022 09:16:13 -0500
Message-ID: <CADnq5_OhwAXQgNFAmavobSbYEyv6CJ2XeKQ6etot=VqHuGnCjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: skipping SDMA IP suspend for S0ix.
To: Rajib Mahapatra <rajib.mahapatra@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "S, Shirish" <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 2, 2022 at 4:07 AM Rajib Mahapatra <rajib.mahapatra@amd.com> wrote:
>
> [Why]
> amdgpu error observed if suspend is aborted during S0i3
> resume.
>
> [How]
> If suspend is aborted for some reason during S0i3 resume
> cycle, it follows amdgpu errors in resume.
> Skipping SDMA ip in suspend solves the issue on RENOIR
> (green sardine apu) chip. This time, the system is
> able to resume gracefully even the suspend is aborted.
>
> Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7931132ce6e3..f01b1dffff7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2927,6 +2927,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>                      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
>                         continue;
>
> +               /* skip suspend of sdma for S0ix
> +                * Resume has issues if the suspend is aborted during S0i3 cycle.
> +                * Skipping sdma for RN/CZN/BRC chip - green sardine apu.
> +                */
> +               if (adev->in_s0ix &&
> +                   (adev->asic_type == CHIP_RENOIR &&
> +                    (adev->pdev->device == 0x15e7 || adev->pdev->device == 0x1638) &&

The check here seems to contradict the comment above.  Is this all
Renoir based APUs or just green sardine?  If it's just green sardine,
you can check the APU flags rather than the PCI ids.  E.g.,
(adev->apu_flags & AMD_APU_IS_GREEN_SARDINE)
Also move this to sdma 4 code as Mario suggested.

Alex

> +                    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
> +                       continue;
> +
>                 /* XXX handle errors */
>                 r = adev->ip_blocks[i].version->funcs->suspend(adev);
>                 /* XXX handle errors */
> --
> 2.25.1
>
