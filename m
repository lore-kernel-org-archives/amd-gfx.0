Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1251BC77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 13:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A494410E153;
	Fri, 12 May 2023 13:19:07 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A357E10E65D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 09:45:45 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-55a00da4e53so172000037b3.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1683884744; x=1686476744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SeNDNqSbKtT4juprQIPOMJ5pas9h2iCUoYs/y7tb/+s=;
 b=GtZrqROkH4ZfxGqVx3hrHf4l23PetZ6CMy4woniilPGVWRB8G4rBVVXin8SU4uHEVE
 wtZY3W1oMghoYi0guVodFnlz+uaCahv0XpFAQuvWhtuOwpHYzDzLdczdRUBnyFe0UMnY
 ztzXOPBi7FwwlScghGzKcZOUHy28qYMiHNbWYDdhvyVDU1bi+zqLAaW30ayjTfc5VAix
 MdfGcZ9GWL8VrtC6wj/+gnSAsIGxP/u4QEo67j1tEoedMw500PsRi70JcBCPSeS4tVaz
 wItCQ8APNkxcAOsobVaDsVv67krITCKIYm9EhKTCjpaneEn6E6xTcNKaC8nPgAFpqcIo
 aE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683884744; x=1686476744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SeNDNqSbKtT4juprQIPOMJ5pas9h2iCUoYs/y7tb/+s=;
 b=U+KdY938gEIwcCuC+5OFweQaR6Wy7s2CjobdwJHt34s+cs0hP3gokMcEXsHSxMMNn6
 9QO7o7UmGlxixhLSO1zmC7gcCOa7ckWSsZPmKD7RoDHAsHBDm2sYUyKfUXJc4X1eACDC
 kJDHiNteS8J7UbgX5hn70ILZPpmyUfBUHMYpJal2HKWlN3VLDxhBhr4bBIuJO/ZlL+1P
 yjKBaifLZ9qohqJfJuiq9tLHRNR1Dtq49lxrasp+V8aZktOnsRMU4TpNejRZ0+Ne2A5l
 O8uCqTGXSgj+mIgHbUDWIkNbwlcDcNZONLcXqJF23t3MMX3qzZIpjiIdmQhm/4e5OmeA
 NgJA==
X-Gm-Message-State: AC+VfDzuiMRiAbqf+0RH7b0q8VumAMpUBEaHFC3FcaWQ7AY8QG/OOU4w
 77EwJlIUyjBl85XXmXYiGyqi1+pcgDyCwsit1w56qw==
X-Google-Smtp-Source: ACHHUZ6lutSExTqyZsU/hQjFKIAv55bPUWGU0TtTWdM/WQJARaWIZ1aV+bmHH/6SrdqtE4Nhmy+pjSm4iiG39PZWMJU=
X-Received: by 2002:a0d:d691:0:b0:539:1b13:3d64 with SMTP id
 y139-20020a0dd691000000b005391b133d64mr23654781ywd.48.1683884744449; Fri, 12
 May 2023 02:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230512084152.31233-1-tzimmermann@suse.de>
 <20230512084152.31233-7-tzimmermann@suse.de>
In-Reply-To: <20230512084152.31233-7-tzimmermann@suse.de>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 12 May 2023 12:45:33 +0300
Message-ID: <CAA8EJpr8oGfmZ0f49W6C23K=EOWW0a-E4tzyn+U23sYkPeaArQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] drm/msm: Use regular fbdev I/O helpers
To: Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 12 May 2023 13:19:06 +0000
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
Cc: Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, javierm@redhat.com,
 dri-devel@lists.freedesktop.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Rob Clark <robdclark@gmail.com>, mripard@kernel.org, daniel@ffwll.ch,
 linux-tegra@vger.kernel.org, airlied@gmail.com,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 12 May 2023 at 11:41, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Use the regular fbdev helpers for framebuffer I/O instead of DRM's
> helpers. Msm does not use damage handling, so DRM's fbdev helpers
> are mere wrappers around the fbdev code.
>
> Add CONFIG_DRM_MSM_FBDEV_EMULATION to select the necessary
> Kconfig options automatically. Make fbdev emulation depend on
> the new config option.
>
> By using fbdev helpers directly within each DRM fbdev emulation,
> we can eventually remove DRM's wrapper functions entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> ---
>  drivers/gpu/drm/msm/Kconfig     |  9 +++++++++
>  drivers/gpu/drm/msm/Makefile    |  2 +-
>  drivers/gpu/drm/msm/msm_drv.h   |  2 +-
>  drivers/gpu/drm/msm/msm_fbdev.c | 12 +++++++-----
>  4 files changed, 18 insertions(+), 7 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
