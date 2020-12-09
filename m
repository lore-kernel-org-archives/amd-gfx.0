Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54910C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 03:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0661D238E3
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 03:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0661D238E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7828789CB9;
	Wed,  9 Dec 2020 03:15:02 +0000 (UTC)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2302D89CB9
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 03:15:01 +0000 (UTC)
Received: by mail-oo1-xc43.google.com with SMTP id 9so50079ooy.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 19:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U5PWD8zILxgNpy8PjAdOkRfC7NOoMW3q2V1hAujqJlE=;
 b=V43C+FkYDxkHMiqQ6LsaAmh3A7Cor9GnAmVrkAIFbfcRPXnZCZdXadFNpYob/VzE6J
 BFibNjnF6amNQEraMhRuF5MWy4HOdyXdgIEALruEeWAEEY65pM8HNoHULcrCSDU/gky+
 z89GnuYbQuVChVwIkSYudTKYUtu1ah1oSGfkkq9o40VWSpHN5lQZMz1TV15mFtWeOCia
 UzCER625B7QihFOGvE0yyELdn4F+brEDhDQiC/gUe8y1ridgc6zczDyzCAsK6RKA51s8
 bFsHqEBBt9pqgWHIeEVzflTAMfyig+/vuJRiqCAXVnaCnQPUwPzl9Zw+jHOlGN8LEg3N
 OPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U5PWD8zILxgNpy8PjAdOkRfC7NOoMW3q2V1hAujqJlE=;
 b=KRB8qQzl7ulQsNZv9/MzfZIa8m6YgVFM+sh0Z4YGS0L6I3zHrNUZhdVhZlxcpgSLkV
 YUMQtIjwWjGkzBXWJueTMHk0peRgQ84XYUYSlX/JQ8OUkwBlZ+3DphQi+der00oXtGfX
 t7BfYCnpTkGLRP2CDyIIuPp6a3dD3Uj5Wy7o4OAVsLXOJbpB7sKrWIT3fpBW4740daew
 0STmSPZPcfzSWzJijAodLrKHbLLKlIQRwrqVXDEnoh7VwlcGyf5+LXQ61fnDt33bWain
 EDYfPlO55lDbvugOSV7K48NryjRRBj7klAmM2MN6p7+eY4LSAAwMlCEHQZTMrE26nvDH
 HbzA==
X-Gm-Message-State: AOAM530EdVHnwRYZ1qrRlOLeHXraY5G3QiJITh3+evpXj/u//B4ln4RT
 TrbHYL4dKIDFhNJjumj4LRyoRDZjLppXK3TFn5c=
X-Google-Smtp-Source: ABdhPJz6UAYLXVlTt78ew2MTibtq99DtgIgXxETa25Xn1ZMObdtdOQvJlCIZwXndylM4lff8MkYjzgkC3UrA0gDUXv8=
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr256817ool.72.1607483700398;
 Tue, 08 Dec 2020 19:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20201207034517.2074717-1-likun.gao@amd.com>
In-Reply-To: <20201207034517.2074717-1-likun.gao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Dec 2020 22:14:49 -0500
Message-ID: <CADnq5_N-XB=nURNN08MUEVCrCu_EC4Gx7LN-_4Ke2hcVk5Dk7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add judgement for suspend/resume sequence
To: Likun Gao <likun.gao@amd.com>
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
Cc: Kenneth Feng <Kenneth.Feng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Dec 6, 2020 at 10:45 PM Likun Gao <likun.gao@amd.com> wrote:
>
> From: Likun Gao <Likun.Gao@amd.com>
>
> Only APU should deal with the situation that amdgpu suspend/resume with
> s0i3 support to skip RLC/CP/GFX disable during suspend.
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Change-Id: Icca91b3497f12a6d78f005ee63461cf0e8f24958
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 79dd85f71fab..75f40a8c59f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2650,7 +2650,8 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>  {
>         int i, r;
>
> -       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev)) {
> +       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev) ||
> +           !(adev->flags & AMD_IS_APU)) {

Could we just add the APU check to amdgpu_acpi_is_s0ix_supported()
directly?  S0ix only makes sense on APUs since they are part of the
platform.  That would simplify the checks and handle any future uses.

Alex

>                 amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>                 amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>         }
> @@ -3710,7 +3711,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>
>         amdgpu_fence_driver_suspend(adev);
>
> -       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
> +       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev) ||
> +           !(adev->flags & AMD_IS_APU))
>                 r = amdgpu_device_ip_suspend_phase2(adev);
>         else
>                 amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
> @@ -3744,7 +3746,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>         if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>                 return 0;
>
> -       if (amdgpu_acpi_is_s0ix_supported())
> +       if (amdgpu_acpi_is_s0ix_supported() && (adev->flags & AMD_IS_APU))
>                 amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
>
>         /* post card */
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
