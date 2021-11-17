Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C79C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 16:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFE661BFA
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 16:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CFE661BFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6AA6E07B;
	Wed, 17 Nov 2021 16:12:26 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313316E255
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 16:12:25 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 w6-20020a9d77c6000000b0055e804fa524so5580614otl.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gl1VECU8naG8kz2jZe9lNQv9CumTcBf9mVVPzbX6CUM=;
 b=WbpOIFEZomiKcqFZCScEsDv/G8/usLfV9If95lS301U9q2Si3Zwu2fm4jAwezDNk3V
 LyY0Qd1vvrZfgqnHMVQf6ThIbAY7S6qXOHMgtG8iktBvMMifsoEHOi889o02FOnfjJQl
 BfFLoeuCs0q2BFA08A/gOeRIYyVoml54oRRmnI9au/1Bjj0K1Icu2KN8zxpRziGNJ/Kw
 3O4wGQqt3+QSBoYsdUVTw2quxkuJ060OXPE8IYKmrR18pcbtciUakybnI0H69Ic9zVbE
 aXoAKumAoBvDgCmNz+CNIqcGWpHdHWpAnN/hbqImvjZxtGEe3p1OzosoJ3ycHfp+SvMU
 Z7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gl1VECU8naG8kz2jZe9lNQv9CumTcBf9mVVPzbX6CUM=;
 b=ucX1JwJ6elJaLyq/12CoRpIoTg/9mnQRItJs3KybBb0fT7MQqTYdQ/LFIrWw5mI5ys
 Qp1t8A8WW0Xo6QehuqwHq2zYwYEmyMxbgHvYgtCdu77BCN52ghjR/3E1aJWu24nNiM78
 1Oqyjiovue7nAFs2JA09PVahDCXxxECwffITU2kpyWVe0j9mch0SxDm569bS/Ot2ICuB
 +YUUXTLNpKC0Z7eIWTA9ix/567f9prEqjhHVtQXtDsUUSWTcJtXpPFoHvmOBiQO0/rgV
 lhVo5VgaAeUbFHkEw2nNOlCnzgjhhC44P8imko67f1CwMt19Qaan6MSD9lrEcgBOH+fW
 3gnw==
X-Gm-Message-State: AOAM531E/oB1JIUyKr/uMLHWiP92DdSjqGvH3b9xgtNRJVTb+g96+uuD
 9zOtKDhwtHtXgOquVF3YrpE7th5wtvLuw4iEuCs=
X-Google-Smtp-Source: ABdhPJyyHPKr1bLaanbmIESkVWdTcNmxM/uGeqdzQ6wA9mx/oVWwkVMwXVjRxXYxqwR1hEX40NYGmDDLpZ/FWcChbwQ=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr15115874otn.299.1637165544414; 
 Wed, 17 Nov 2021 08:12:24 -0800 (PST)
MIME-Version: 1.0
References: <1637162530-23015-1-git-send-email-Roman.Li@amd.com>
In-Reply-To: <1637162530-23015-1-git-send-email-Roman.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Nov 2021 11:12:13 -0500
Message-ID: <CADnq5_PFiLS_2Ci8gJh==3Um3v_VTeHKErYQYh5noboJPcfxPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix OLED brightness control on eDP
To: Roman Li <Roman.Li@amd.com>
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
 "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>,
 =?UTF-8?Q?Samuel_=C4=8Cavoj?= <samuel@cavoj.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 17, 2021 at 10:22 AM <Roman.Li@amd.com> wrote:
>
> From: Roman Li <Roman.Li@amd.com>
>
> [Why]
> After commit ("drm/amd/display: add support for multiple backlights")
> number of eDPs is defined while registering backlight device.
> However the panel's extended caps get updated once before register call.
> That leads to regression with extended caps like oled brightness control.
>
> [How]
> Update connector ext caps after register_backlight_device
>
> Fixes: b1c61212d8dc ("drm/amd/display: add support for multiple backlights")
> Link: https://www.reddit.com/r/AMDLaptops/comments/qst0fm/after_updating_to_linux_515_my_brightness/

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 26fcc89..44c9994 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4243,7 +4243,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>                 } else if (dc_link_detect(link, DETECT_REASON_BOOT)) {
>                         amdgpu_dm_update_connector_after_detect(aconnector);
>                         register_backlight_device(dm, link);
> -
> +                       if (dm->num_of_edps)
> +                               update_connector_ext_caps(aconnector);
>                         if (psr_feature_enabled)
>                                 amdgpu_dm_set_psr_caps(link);
>                 }
> --
> 2.7.4
>
