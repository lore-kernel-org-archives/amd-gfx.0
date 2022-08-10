Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C11C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 15:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DB711B1B4;
	Wed, 10 Aug 2022 15:29:14 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226828DC2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 15:28:30 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-116c7286aaaso2291176fac.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=JGlVYKOhE0vnUO2uJlfhRsy2OU4tbrDN/YlwAH68OlA=;
 b=d2fByg4d4eWVNrjXbt7g4Wnpbdp3QlMHivfhSOsmfJdN3rtz5lmLEO5bcHPCmK3cpB
 02kToal3VgfEsfmOaLaRvnfN9L3rJ3wXLUufbO8HUeN1GIdMNHpMvsdElrmMhugkAmdb
 jiW6UT1XCjR1pOsWvCytvweTFn8nQx/PD5Cbbij1xOT97r8zic6tzSQ2ZuIQXPi34yq2
 sH+p9VshI6HOGNRXY+qjvf3SXQ1osQajxi9ZYHHeocGeuMvARfifKe1XRCAxgdN+DFQU
 WXV3p1uSXOscr27zdt+drJp1QlF7LK9OdsUu3386/BVFdtNWnPq1r5HPLRzmi7Yq7xKM
 cDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=JGlVYKOhE0vnUO2uJlfhRsy2OU4tbrDN/YlwAH68OlA=;
 b=WtFdI76Cz0tFqJvKXkHVPxFsDzg4ZRpbG25PxoX3xWF6sMnrW9zajz9PL3mrydYBP1
 P8DS4AOYU0X80eZ+/x/O4TJwenRFaONPurRdhcb9pNKv65jXY7QdiNV8HbkBXN1N3BGk
 6J2rMuUKnBuw+VupQJoboW7avpt5BY0Zh2Xkc1oRkC2leG6P2x6XHp9u9b+pG6Ap8lBj
 zpFdILDXmkw1LQyoez2Vitq+dUDizhv/PCGQTrbIZBorA53119dAcJnNydxAghTyH86E
 6KnpGKswzmOL2lRWj7GJGKI3sxgY/U7g3gzarj8wOQPz9ZcnUb/OhxJDr/+HQArfnAJ8
 P0bQ==
X-Gm-Message-State: ACgBeo1z0a6KWHAPjjCPY07M64QbH/zBWnWYGmEFTjb/gnxuPMpfuIQL
 Kaq9Ti/3YzV1go64EL9yrI7l+BGRRMphumi5GRA=
X-Google-Smtp-Source: AA6agR72B/i2Sv+68Dtoh6o4c2bgP4iHsBtHCLZLHB7+iUfaZkhkEa0Cnr9ALp5db2cvfBULM6Dx1pJYMsVVsRxXVy0=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr1643409oae.33.1660145309696; Wed, 10
 Aug 2022 08:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220719185659.2068735-1-alexander.deucher@amd.com>
In-Reply-To: <20220719185659.2068735-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Aug 2022 11:28:18 -0400
Message-ID: <CADnq5_MkB8xKHZxVsiXfWPA-QuVrrNCNXF=ScrYAPjNbAH36LA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix check in fbdev init
To: Alex Deucher <alexander.deucher@amd.com>,
 Greg KH <gregkh@linuxfoundation.org>
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
Cc: amd-gfx@lists.freedesktop.org, hgoffin@amazon.com, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 19, 2022 at 2:57 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> The new vkms virtual display code is atomic so there is
> no need to call drm_helper_disable_unused_functions()
> when it is enabled.  Doing so can result in a segfault.
> When the driver switched from the old virtual display code
> to the new atomic virtual display code, it was missed that
> we enable virtual display unconditionally under SR-IOV
> so the checks here missed that case.  Add the missing
> check for SR-IOV.
>
> There is no equivalent of this patch for Linus' tree
> because the relevant code no longer exists.  This patch
> is only relevant to kernels 5.15 and 5.16.
>
> Fixes: 84ec374bd580 ("drm/amdgpu: create amdgpu_vkms (v4)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org # 5.15.x
> Cc: hgoffin@amazon.com

Hi Greg,

Is there any chance this can get applied?  It fixes a regression on
5.15 and 5.16.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> index cd0acbea75da..d58ab9deb028 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -341,7 +341,8 @@ int amdgpu_fbdev_init(struct amdgpu_device *adev)
>         }
>
>         /* disable all the possible outputs/crtcs before entering KMS mode */
> -       if (!amdgpu_device_has_dc_support(adev) && !amdgpu_virtual_display)
> +       if (!amdgpu_device_has_dc_support(adev) && !amdgpu_virtual_display &&
> +           !amdgpu_sriov_vf(adev))
>                 drm_helper_disable_unused_functions(adev_to_drm(adev));
>
>         drm_fb_helper_initial_config(&rfbdev->helper, bpp_sel);
> --
> 2.35.3
>
