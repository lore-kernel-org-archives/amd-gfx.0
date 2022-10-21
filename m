Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF117C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 13:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB71910E301;
	Fri, 21 Oct 2022 13:39:06 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC11610E2D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 13:39:01 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1321a1e94b3so3590431fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/0R+jo97lvIL+TEnXSDafzmbY4hsRiLpxhqIF3lIouc=;
 b=FxjSSalZmQW5XZ0vgwbLV9yokEwV8cKf/AXuu9TF4Yp8KcFaYxZEUfq/fqSPJeVG56
 3FaeqKxy4Ffuq+gnsOWCoyNj3LNbWrF6y0o9KEuzv+CtLTND5IkCdnwji848lVScqez5
 yWuKMaRfzZbKhZWMVce1FluGq9skg7NisY6RbOGMGarPEZGMAzuPOvv9ekqUk4Q8TLje
 CoByZ6zSUvrb0TBfko7ONUfAHIr0HUMuel1hCHHfk0XvSe9nFt1R5kzTix4CsDjB+Vbz
 BIdnWUd6VlXjkYjI6OhvpSKlKQg07jLbOEX+Ws+85RlSzRUYcJ7K2USXTml8f4AFujDL
 7IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/0R+jo97lvIL+TEnXSDafzmbY4hsRiLpxhqIF3lIouc=;
 b=p80Xac5+SDnpHMCMW4StVSyEXxcfqBYbIdKzap86Z8WwSECPTBEjf+qDKxTl+tDvUh
 zUsmvvSOQpFn44KGwwbbqZ3X/Ho/NBU+7n7CmEroVSTExm+D30wVFyNBxy1cDCR66h0Y
 Dk270ur4HIlQCt7deE+ngHndU+EAPYpsZLEzNwmcOsSpBtvuOpEESQhh2PwVlFuv6a3Z
 2bU6jF47ZUX2EsSE0BK9Cj63rvWRroZyK0KSG9DngamlDc6JxYV8k8y36UPm/0F1XYPQ
 fdcoXZ0DfrtyOWz+RjKnowZVtZm+sK/HodD/yTOi/s67112eUWt0uQFdZFBv/Nbu4gy2
 betA==
X-Gm-Message-State: ACrzQf3U7EY6XnmSS5caBdgSpro5tRZdpGJeiReOfak9XDODtw6ghYYU
 nD1zx5v53iiUulBaw2sB0S8qk87yHCCQRN7DvYo=
X-Google-Smtp-Source: AMsMyM4YYFdknOOcj8eRLomxDkI6Qca/tiq8fW4J82mc7HGx5H+Gswllt36ZhiaRg41247VuS3WN77bf7DBIr3UETno=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr12399070oao.96.1666359541147; Fri, 21
 Oct 2022 06:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221021022956.2775675-1-Prike.Liang@amd.com>
In-Reply-To: <20221021022956.2775675-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Oct 2022 09:38:49 -0400
Message-ID: <CADnq5_Of6R-BtZ5dz-e=nPsgNG4g4VqzsbnYznqfi7AKc1DXrw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disallow gfxoff until GC IP blocks complete
 s2idle resume
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 20, 2022 at 10:30 PM Prike Liang <Prike.Liang@amd.com> wrote:
>
> In the S2idle suspend/resume phase the gfxoff is keeping functional so
> some IP blocks will be likely to reinitialize at gfxoff entry and that
> will result in failing to program GC registers.Therefore, let disallow
> gfxoff until AMDGPU IPs reinitialized completely.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 5 +++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e0445e8cc342..1624ed15fbc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4185,6 +4185,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>         /* Make sure IB tests flushed */
>         flush_delayed_work(&adev->delayed_init_work);
>
> +       if (adev->in_s0ix) {
> +               amdgpu_gfx_off_ctrl(adev, true);
> +               DRM_DEBUG("will enable gfxoff for the mission mode\n");
> +       }
>         if (fbcon)
>                 drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, false);
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 4fe75dd2b329..3948dc5b1d6a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1664,6 +1664,11 @@ static int smu_resume(void *handle)
>
>         dev_info(adev->dev, "SMU is resumed successfully!\n");
>
> +       if (adev->in_s0ix) {
> +               amdgpu_gfx_off_ctrl(adev, false);
> +               dev_dbg(adev->dev, "will disable gfxoff for re-initializing other blocks\n");
> +       }
> +

I think it would be better to put this in amdgpu_device.c so it's
clear where its match is.  Also for raven based boards this will get
missed because they still use the powerplay power code.

Alex

>         return 0;
>  }
>
> --
> 2.25.1
>
