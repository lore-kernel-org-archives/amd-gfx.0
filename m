Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44813CCF9EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 09:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1F210E425;
	Mon, 27 Oct 2025 09:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="M1KmfxPo";
	dkim-atps=neutral
X-Greylist: delayed 320 seconds by postgrey-1.36 at gabe;
 Fri, 24 Oct 2025 15:43:42 UTC
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A984B10E20C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 15:43:42 +0000 (UTC)
Received: from relay12 (localhost [127.0.0.1])
 by relay12.grserver.gr (Proxmox) with ESMTP id 86DF9BDC76
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 18:38:20 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay12.grserver.gr (Proxmox) with ESMTPS id C26D7BE030
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 18:38:19 +0300 (EEST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id 388C2200AD8
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 18:38:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761320299;
 bh=eE7WOkDVyRJiHeSEMjNbildsHJzwmYxdrSeSojss7+I=;
 h=Received:From:Subject:To;
 b=M1KmfxPoxTmJHoXMWuS6hAq3HHdnBjUfO/1yZPGuKgZvxi4IJCiePPrtziMJufJs9
 5dxzXny6ukNBp2pKy2zPY92xqjnqSx4+EuxU1l8OvGFEnq0qq+UaRS6VsMpzpliRX1
 5enTHokqnyqH9Ax2ZUEu1BZUqL1rFDzT+4FbMeXn5m9OtlEtJCdvB9tVTEnzqqTB08
 TjY2n4FPwgH8Prv8xCXnXSMKgD5blAQ6EabPVl3QR+honi0FxihB3YXlbAO2LrzZUt
 gM0g75WKRVO8WVH+UDvXMlJDaCfGLXWlixPzgCX6XPtsZtQ/NhOxV800M7Xkt/Xtkk
 0B44EKGaeZQMw==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.174) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f174.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3637d6e9923so22479851fa.3
 for <amd-gfx@lists.freedesktop.org>;
 Fri, 24 Oct 2025 08:38:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUaLMFPEgVcjwUqj9n7pLePEfEltkx3j+F/LPw4LnLA0fdcw6Ch+MEupGheTCP8hm9GsCptphiS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwX88VQ7WUjHImZ0AbdXv0YxYNXq8RYbcPmzDJdVk45bm5HIGVg
 WRYr9QePIA7Q24FwP54YdFLFjW0FzvV4udF0ggIhdMUYoOcOfgJDvWxRNjygI3/wjUN49/UXnUy
 kGFyOtSvgIQJtFTuB4IfAMn72s8EQS3M=
X-Google-Smtp-Source: AGHT+IHxSuFU8jGxWLfAcRJMzub8OItIQWU18+63KmTH6NWzOau5ckGJVk7oQpzgy0uOuN89F0gjkZf/h8PYxxtz6I4=
X-Received: by 2002:a2e:bd05:0:b0:378:e12f:e5ed with SMTP id
 38308e7fff4ca-378e12fe7d7mr12930301fa.39.1761320298675; Fri, 24 Oct 2025
 08:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251024152152.3981721-1-lkml@antheas.dev>
 <c71c3ee5-e101-440f-9533-508d37d05d04@amd.com>
In-Reply-To: <c71c3ee5-e101-440f-9533-508d37d05d04@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 24 Oct 2025 17:38:07 +0200
X-Gmail-Original-Message-ID: <CAGwozwG_uU_sA0npzj6u3Aet2exxMOWdJEi5GX72CSFZJWvyeQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnGAPB1e1DIOoCXwc5AzboX6ZyXgVQP0rByT5pDDuJuAElRJgJRdq7RFTM
Message-ID: <CAGwozwG_uU_sA0npzj6u3Aet2exxMOWdJEi5GX72CSFZJWvyeQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] platform/x86/amd: Add S0ix support to the Xbox Ally
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176132029943.2412234.17478641508646617310@linux3247.grserver.gr>
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

On Fri, 24 Oct 2025 at 17:32, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> > The Xbox Ally features a Van Gogh SoC that on the Steam Deck uses S3.
> > Therefore, kernel support for S0ix was previously absent. Introduce
> > this support in three patches:
> >
> > 1) Add Van Gogh to AMD PMC driver
> > 2) Enable spurious_8042 quirk, as it is common in those generations
> > 3) Adjust the Van Gogh init logic to avoid powering down the rlc
> >     and tweak post init
> >
>
> Just to be clear - there is no need for all 3 patches to go to one tree
> or another.  The PMC patches should go platform-x86 and the DRM patch
> should go through drm.

Perhaps someone wants to test out all three. I will resend only the
first two next time.

> > This allows the Xbox Ally to properly enter and exit S0ix suspend.
> > Perhaps it also allows the Steam Deck to use s2idle without crashing,
> > note it is not currently possible [1].
>
> FWIW I don't anticipate this series actually gets Steam deck into a
> hardware sleep state because you need firmware support as well.
> But the drm patch will probably will help the hang that was observed
> which lead to the patch you've linked below.

That's what I think too

Antheas

> >
> > Currently, around 1/10 times the SoC misses the PMC hint and does not
> > enter S0ix, so perhaps 1 or 3 need tweaking further. It wakes up always,
> > however.
> >
> > @Alex: I tweaked the text on patch 3 a bit. You can resend it separately
> > after the issue with 1/10 failures is fixed.
> >
> > [1]: https://github.com/evlaV/linux-integration/commit/5ab73e9069017aa1b5351f91513ba540ce5905fb
> >
> > Alex Deucher (1):
> >    drm/amdgpu: only send the SMU RLC notification on S3
> >
> > Antheas Kapenekakis (2):
> >    platform/x86/amd/pmc: Add support for Van Gogh SoC
> >    platform/x86/amd/pmc: Add spurious_8042 to Xbox Ally
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 8 +++++---
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
> >   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
> >   drivers/platform/x86/amd/pmc/pmc-quirks.c        | 8 ++++++++
> >   drivers/platform/x86/amd/pmc/pmc.c               | 3 +++
> >   drivers/platform/x86/amd/pmc/pmc.h               | 1 +
> >   6 files changed, 26 insertions(+), 3 deletions(-)
> >
> >
> > base-commit: 6fab32bb6508abbb8b7b1c5498e44f0c32320ed5
>
>

