Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC936CCFA02
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C64510EAC7;
	Fri, 31 Oct 2025 08:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="O/KJHDj3";
	dkim-atps=neutral
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD7710E292
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 16:21:10 +0000 (UTC)
Received: from relay10 (localhost.localdomain [127.0.0.1])
 by relay10.grserver.gr (Proxmox) with ESMTP id E418246EA9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 18:21:08 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay10.grserver.gr (Proxmox) with ESMTPS id 19DFF46E1A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 18:21:08 +0200 (EET)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id F3268200EB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 18:21:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761841267;
 bh=+idjRu4PpoQdWf9XsLDJ1gdEykn3PH03QGO2tdUOrlo=;
 h=Received:From:Subject:To;
 b=O/KJHDj3/6ZGLEmVLPEFK+hewy2qxkSbExVRuDWo4G0Ya7FNFLSNLKizpX5FVG4l9
 Nuf39NNQRoxj/NbaosF9/AhHlXri1alH3LjQbeZPMAFc+pAaubAhpfPVh8utwmIk2k
 VXBdYrqFyOwVH6duqWrXIpFFczdTOgxUgxcKb62plHz/QxFSefqWPfYsK18gvChiRa
 oQKLdeEv1WxL87LXz/jWzfDeS8CdnDgU/eV+R1FsaXH8P+dQfbblU+gzLQcJmmHmGV
 xpBm07ziZfhrqli1X5iwPSEnPAQ28I/IDW9Dle5u5aAoIwce0rCX4hl0DoDxl5qwDO
 OX99QVHZw5RfQ==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-3737d09d123so15965941fa.2
 for <amd-gfx@lists.freedesktop.org>;
 Thu, 30 Oct 2025 09:21:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCX58hYQV/TIL85pgcSsVeiof8cDKjfFCAOlFWH/MFOCK/S3GPG935Uf0kPOX1ql6dqBmSwpggSs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxH8XSSWyIPuhYp7EbxGluEjNb6a/Z+jxrWyao352wZGSmW7ppC
 WgIyS5dTMR7LUTknOFT8VBm4Mjnkd2euAd3JLdAUo0z8b9otzqNPYXZwInUuxS8WykzB2iP/xVq
 tHGASA90zfB85kPUcQRRh0ZuUIwAKhDA=
X-Google-Smtp-Source: AGHT+IFrhYL6qqTh21cO924rzdDFU1K0dnc+nwx0Lf342q3lXiJXA6jc8Dd9N21Ziz/S5rmAmTlhhEdRhpVLQoAjsfI=
X-Received: by 2002:a05:651c:31ca:10b0:376:3a83:4287 with SMTP id
 38308e7fff4ca-37a18df8373mr1348041fa.49.1761841266353; Thu, 30 Oct 2025
 09:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251024170811.57760-1-alexander.deucher@amd.com>
 <20251024170811.57760-2-alexander.deucher@amd.com>
 <CAGwozwHnROrncN_bLAVqrd=XEV6FGS+sTLJx=wsXqx9GNsNiFQ@mail.gmail.com>
 <0a2f37d4-fd43-40b6-86d5-a0355bc770a7@amd.com>
In-Reply-To: <0a2f37d4-fd43-40b6-86d5-a0355bc770a7@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 30 Oct 2025 17:20:54 +0100
X-Gmail-Original-Message-ID: <CAGwozwGTgGvpR7fBpKhP3tzy_fh7pwyzSR7RZfmNoFXLRQaQ4A@mail.gmail.com>
X-Gm-Features: AWmQ_bkCgxtluYUXmfB9o5Cu7p7s8iOsZ57UQG1D23iDtSUihZc9dyf8sC3XM-M
Message-ID: <CAGwozwGTgGvpR7fBpKhP3tzy_fh7pwyzSR7RZfmNoFXLRQaQ4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/smu: Handle S0ix for vangogh
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 bob.beckett@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176184126736.2115784.11348194835105555189@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Oct 2025 08:12:39 +0000
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

On Thu, 30 Oct 2025 at 16:37, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 10/24/2025 12:14 PM, Antheas Kapenekakis wrote:
> > On Fri, 24 Oct 2025 at 19:08, Alex Deucher <alexander.deucher@amd.com> wrote:
> >>
> >> Fix the flows for S0ix.  There is no need to stop
> >> rlc or reintialize PMFW in S0ix.
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
> >>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
> >>   2 files changed, 9 insertions(+)
> >
> > Sleep failed on the Deck the same way as Mario's attempt
>
> Can you please test patch 2/2 from this series and patch 1/5 from this one:
>
> https://lore.kernel.org/amd-gfx/20251026042942.549389-2-superm1@kernel.org/
>
> I expect that everything GPU wise works with those 2 combined, can you
> confirm?

I will update you tomorrow. Currently traveling.

Antheas

> >
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> index 10d42267085b0..5bee02f0ba867 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> @@ -2054,6 +2054,12 @@ static int smu_disable_dpms(struct smu_context *smu)
> >>              smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
> >>                  return 0;
> >>
> >> +       /* vangogh s0ix */
> >> +       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
> >> +            amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2)) &&
> >> +           adev->in_s0ix)
> >> +               return 0;
> >> +
> >>          /*
> >>           * For gpu reset, runpm and hibernation through BACO,
> >>           * BACO feature has to be kept enabled.
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> >> index 53579208cffb4..9626da2dba584 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> >> @@ -2219,6 +2219,9 @@ static int vangogh_post_smu_init(struct smu_context *smu)
> >>          uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
> >>                  adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
> >>
> >> +       if (adev->in_s0ix)
> >> +               return 0;
> >> +
> >>          /* allow message will be sent after enable message on Vangogh*/
> >>          if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
> >>                          (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
> >> --
> >> 2.51.0
> >>
> >>
> >
> >
>
>

