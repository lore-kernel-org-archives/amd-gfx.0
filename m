Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2A7CCF9EE
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 09:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B413710E423;
	Mon, 27 Oct 2025 09:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="cBlQFGXx";
	dkim-atps=neutral
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E7110E215
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 16:24:26 +0000 (UTC)
Received: from relay12 (localhost [127.0.0.1])
 by relay12.grserver.gr (Proxmox) with ESMTP id BD00ABDA2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:24:24 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay12.grserver.gr (Proxmox) with ESMTPS id 05702BDC15
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:24:24 +0300 (EEST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id 55221200A18
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:24:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761323063;
 bh=oQdGwlfEvbtCsB8/gEbcoDWrOnl5p/sble/6szBPxSw=;
 h=Received:From:Subject:To;
 b=cBlQFGXx1PtjEky+m747Ymx3Nyv94QlQY5Hi/RAGZdJO4GfvfcpX1WkhuYZTELNSg
 Hq4q5bwX1X7ceI1AqeEXsprTQnxOR4Y+eEVYkmyzfIUTk1P9g3TMJQMQR707tVtyw2
 ZFH5cHf4aGK9ZYjcn/gbg6xEKW+GFvsuTvxPZd4MPbXiDE7onpQJ5tawHuuEP1eW9G
 HYmp0wNErzwG4dilPmUchtigR3NJu75+VdYmD+4Tz77uKgtrKGd7PG3KmfQ3PsdK7p
 9q/vXxscBJ8j8lEutecbMriXmLbR/uO0eoWa0C10fz4R7qZ7q9expz2DVhJ/Q8GBJX
 H6c4CqP187k5A==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-378e8d10494so6542481fa.2
 for <amd-gfx@lists.freedesktop.org>;
 Fri, 24 Oct 2025 09:24:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVd6zAeufNYdUm6kURP4r260mJR6nL5LbfnO7NoXX/0LVKm/9CWP3t92TKFvbSHJqiF2tTpgpQf@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5V0bjqVnA09y4R4Qh0efccR2aG/P6zE9AS8j8/OINkJ4JvFGP
 cXJlvLSNSkAyPb98RZZV8fmcmpjf4Za242vvs+8DNOJaFZ+QSGiY7vupKV7gnlCnzhpEHMXN0aS
 W/sDVwg0m2OhvgF6Cfjw1fr9mXwPJulQ=
X-Google-Smtp-Source: AGHT+IH5FOSurMzNSYAPrkNE9P+crWNlqQYYEhIXZVibnYOAmJfgnkVPquyinjMDDrWg5WSrf+OeT57Af1RwtKlUvyw=
X-Received: by 2002:a2e:a906:0:b0:337:e190:6814 with SMTP id
 38308e7fff4ca-378e43595b5mr9138621fa.20.1761323062708; Fri, 24 Oct 2025
 09:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251024152152.3981721-1-lkml@antheas.dev>
 <20251024152152.3981721-4-lkml@antheas.dev>
 <61da9864-b7c8-43f1-b437-36756077b545@amd.com>
 <27439123-98aa-4096-a4e4-3c8eecb3aaca@amd.com>
In-Reply-To: <27439123-98aa-4096-a4e4-3c8eecb3aaca@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 24 Oct 2025 18:24:11 +0200
X-Gmail-Original-Message-ID: <CAGwozwHAJAvgZEgn1M0ioRP4dT2urMUtQQzNXKXydu0ueoOzsA@mail.gmail.com>
X-Gm-Features: AWmQ_blfIZoPfA-q7agy553x9fEuFss57l-a8Lv0j387NBYXYo5gCy0b2IiG7tc
Message-ID: <CAGwozwHAJAvgZEgn1M0ioRP4dT2urMUtQQzNXKXydu0ueoOzsA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/amdgpu: only send the SMU RLC notification on
 S3
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176132306369.2578093.18066466698353091495@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 27 Oct 2025 09:35:56 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 24 Oct 2025 at 18:20, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 10/24/2025 10:54 AM, Mario Limonciello wrote:
> >
> >
> > On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> >> From: Alex Deucher <alexander.deucher@amd.com>
> >>
> >> For S0ix, the RLC is not powered down. Rework the Van Gogh logic to
> >> skip powering it down and skip part of post-init.
> >>
> >> Fixes: 8c4e9105b2a8 ("drm/amdgpu: optimize RLC powerdown notification
> >> on Vangogh")
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 8 +++++---
> >>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
> >>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
> >>   3 files changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
> >> drm/amd/amdgpu/amdgpu_device.c
> >> index 3d032c4e2dce..220b12d59795 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -5243,9 +5243,11 @@ int amdgpu_device_suspend(struct drm_device
> >> *dev, bool notify_clients)
> >>       if (amdgpu_sriov_vf(adev))
> >>           amdgpu_virt_release_full_gpu(adev, false);
> >> -    r = amdgpu_dpm_notify_rlc_state(adev, false);
> >> -    if (r)
> >> -        return r;
> >> +    if (!adev->in_s0ix) {
> >> +        r = amdgpu_dpm_notify_rlc_state(adev, false);
> >> +        if (r)
> >> +            return r;
> >> +    }
> >
> > Just FYI this is going to clash with my unwind failed suspend series [1].
> >
> > This is fine, just whichever "lands" first the other will need to rework
> > a little bit and I wanted to mention it.
> >
> > Link: https://lore.kernel.org/amd-gfx/20251023165243.317153-2-
> > mario.limonciello@amd.com/ [1]
> >
> > This does have me wondering though why amdgpu_dpm_notify_rlc_state() is
> > even in amdgpu_device_suspend()?  This is only used on Van Gogh.
> > Should we be pushing this deeper into amdgpu_device_ip_suspend_phase2()?
> >
> > Or should we maybe overhaul this to move the RLC notification into
> > a .set_mp1_state callback instead so it's more similar to all the other
> > ASICs?
> >
>
> My proposal as such is here:
>
> https://lore.kernel.org/amd-gfx/20251024161216.345691-1-mario.limonciello@amd.com/
>
> It would need some testing though to make sure it didn't break Steam
> Deck or Steam Deck OLED.

I will give it a quick go on my OLED.


> >>       return 0;
> >>   }
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/
> >> drm/amd/pm/swsmu/amdgpu_smu.c
> >> index fb8086859857..244b8c364d45 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> @@ -2040,6 +2040,12 @@ static int smu_disable_dpms(struct smu_context
> >> *smu)
> >>           smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
> >>           return 0;
> >> +    /* vangogh s0ix */
> >> +    if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
> >> +         amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5,
> >> 2)) &&
> >> +        adev->in_s0ix)
> >> +        return 0;
> >> +
> >
> > How about for GPU reset, does PMFW handle this too?
> >
> >>       /*
> >>        * For gpu reset, runpm and hibernation through BACO,
> >>        * BACO feature has to be kept enabled.
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/
> >> drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> >> index 2c9869feba61..0708d0f0938b 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> >> @@ -2217,6 +2217,9 @@ static int vangogh_post_smu_init(struct
> >> smu_context *smu)
> >>       uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
> >>           adev->gfx.config.max_sh_per_se * adev-
> >> >gfx.config.max_shader_engines;
> >> +    if (adev->in_s0ix)
> >> +        return 0;
> >> +
> >>       /* allow message will be sent after enable message on Vangogh*/
> >>       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
> >>               (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
> >
>
>

