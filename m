Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547D1CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 16:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF6A10EF6A;
	Wed, 13 May 2026 16:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJTatM7N";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3FC10EF4E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 16:36:14 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12dc1c0b724so697770c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690174; cv=none;
 d=google.com; s=arc-20240605;
 b=WGQ5GI9bx2mGceS81KNvanI8Yq7j7AufVkCnXYdz/E6c6ChoHpdVE8gWdzBlhWEn/8
 Psu4Fbm0yIVL0omgjtrJinafx0MaAU/Wh5qZFIpAKhkApAMuF5BsXiAIKX6iWKlTRFI8
 fsdQYLj6rnAW/0KMDFsAU4IVC+rpZ/VE+aOjpwEtEGhuQZ0CvVxAfpEBDgOMPCb6fj+f
 2EnbkJXM7H8IvA2Fs5xxsCdgCJVRMToGmhvtJwtugtmtOINAVAEbweDzX7tFwT/OlQs7
 foBt8zB2hUW479pdjXDrPQ3nTS9VWjPhlN1G8quzsO1mG7pXT9bvlKIsZsFyY5DwDS1p
 4qWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BhWFPZ37eM1+qSaCF51aFPPJpfxrL/nJSH25HEWK+U8=;
 fh=36OqtQPF1yizn8w+eX07KcK9DuU7O+Cvcb912TSH3JM=;
 b=OWG7mquDhzNxDGsy1jkHCghdxsQoaANTWpDdpLgCE45fHSD37P5ylegxDt1sNuzHSN
 EkRNbqerMCsenQPAJKAMBPahXj0JA6DXgwhutRkHR90d6E36Pqyh3GatCIqedQwv1U8I
 G9kvVG8fpQAUGTv6rOLnEh22BK2Q1rmN7Jp12o2lTWlFZNkz3ygud/woXrrtNvN9TueX
 uAI7Zcwwlji7fXbKjicbghPy0ryVbyhUEbIlboSL8iAwYtQUy3qHjw4KFVSsGIsX2oNp
 OJ4lEre7vqL+To1ejkiUnNqblpbiWBqid/vfGkBFaAWw7EvHmryaxmci8IQrs0YS6tQv
 UXaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778690174; x=1779294974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhWFPZ37eM1+qSaCF51aFPPJpfxrL/nJSH25HEWK+U8=;
 b=NJTatM7NXtFDMBbBggd67jQLvKrNNq/f4VrBp4C8AC9H9zWHME4xFRFxIk8GtQJrlG
 5v3c69TVOGm23WcF2sjLpADPAopGyi23mns/fl2F0ZTyvY4iI6V2bddjfXeCFCdUZJeO
 lsMwam8N9LH4rwoB1Wt9NWPIfyQao5AqSuQJSmfSzQO3uP4jCor3+1zPhBObV2Tq1Aqc
 fP1/zXCwyufUl5y09ybuf1utdkdpSmWSgvDcIeSyyDav8XHKDvEOMneXt3n0sjYNsLay
 uwnnsuwpTe9h0AQUtveIBkNU0k9xdyBeFOgPrwjB35MeOgI+RDQ+85U0GB253PtCH+WX
 qpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778690174; x=1779294974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BhWFPZ37eM1+qSaCF51aFPPJpfxrL/nJSH25HEWK+U8=;
 b=VaGtdYpEiOjwk9IdrTvdB+9LtsVxMcDjfs1St+BvVRVEGFXh7xNwK98Js/r9E1MxyI
 81xEowyqo4/AAnt1quWijwuu88oF9awJMfrrug6db3SQtdc5KgQZUAXLQGTuGIHQdHYi
 IZDk+UGT2uEWvA35p493L4QQKAYemeX1AxWsX2oUXSEq47GDX9hF4ccvPolq6sXJHBiz
 ixdkBUo86I1Tert+2NqaqIlXwiZ0cwea+0myX+AQJ8+cPmaKv25DpqHY4tek6Xl3uR3+
 Qlw6soJKJG5WC0IVUWx+6KakE1iv8dNTPTr8jaTtjeuuiqTgo0LErBrEG+GAlYH/7Fdp
 jLMA==
X-Gm-Message-State: AOJu0YyL/S+EQIyxtYwmySaqK1yfBzzXnoXl0LgYsZcJuQ49NGk+sFvO
 jbFbkmCN6dCtVS6z1LPUmq0PyG7T2+MWRHL8buKvaQtAuAPEERpO3VLnkA4MIm7IWIL5MAzXdlo
 pZB2UTxTs5BL1/1pQ2qQSb3s12Je2TFQ=
X-Gm-Gg: Acq92OH1ElU9AHXMm5ZFBEI/nbRduPXl7BjjAGjjsJZOpFZ9KleiCOWC6AzXSu+SH6X
 RBobFsRdicLHb5YU74MmM9ynt/ZuuZ8P0zDWfmg0Ir8JDDEUe8XOSPlShREDeo/vGGaa2yzGKFE
 lumRMXpJylet/L2TvdJG6KTr2SGq4D+5AXp9ill8x7zwXZWaDMC8jus3ZEF8xcVdKqMajgK2U5B
 6RZqiqWl4XILs50S2RBclPkxyAmi5OoaQk1QVJE31NowS25zK/0j7kfo/FAv+dnlmMrcps404VB
 8XeXBZ3iMbbfGKjlPpXY7xdvY3bpDzppjzwMCw2Rquo1hd+nbA2lzQkY/pFLmqnO8JyRlOSjUGb
 hqRJ1
X-Received: by 2002:a05:7022:62a4:b0:133:4320:9365 with SMTP id
 a92af1059eb24-13428a9992cmr1235063c88.0.1778690173944; Wed, 13 May 2026
 09:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260513163043.8725-1-timur.kristof@gmail.com>
In-Reply-To: <20260513163043.8725-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 May 2026 12:36:02 -0400
X-Gm-Features: AVHnY4I2a6I0h9vmZ-l0BAfpJZbjzHVA3hM3l424uIjoRVXSRBRPFDs5NofeBM8
Message-ID: <CADnq5_Ot+iPKNtxTvA7rWvdsDie3vdrHN8ftwM84FY-+p3A_0g@mail.gmail.com>
Subject: Re: [PATCH 0/6] drm/amdgpu: Improve retry fault handling
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Amir Shetaia <amir.shetaia@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

+ Amir

Amir may have some insights on navi4x as he was looking at this recently.

Alex

On Wed, May 13, 2026 at 12:30=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> Fix some issues regarding retry fault handling,
> such as enabling the retry fault interrupt (necessary
> for retry faults to work) and such.
>
> Improve retry faults on Navi 3 dGPUs by enabling
> the filter CAM, which can filter the repeated page
> fault interrupts that happen when retry faults are
> enabled, making the handling more efficient.
>
> With this series, the kernel is able to mitigate
> most page faults on Navi 3 without causing a hang
> and without a need to reset the GPU, when the
> amdgpu.noretry=3D0 module parameter is set.
>
> Timur Krist=C3=B3f (6):
>   drm/amdgpu: Use gmc->noretry instead of amdgpu_noretry directly
>   drm/amdgpu/gfxhub: Enable retry fault interrupts when needed
>   drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as needed
>   drm/amdgpu/gmc: Don't compare page fault timestamps with other
>     interrupts
>   drm/amdgpu/ih: Add retry_cam_ack IH function pointer
>   drm/amdgpu: Enable retry CAM on Navi 3 dGPUs
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h      |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 17 ++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 17 ++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 19 +++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 15 +++++++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 15 +++++++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 15 +++++++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 15 +++++++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 17 ++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 17 ++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c        | 18 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c        |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c      |  8 +++++++-
>  22 files changed, 134 insertions(+), 71 deletions(-)
>
> --
> 2.54.0
>
