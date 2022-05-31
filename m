Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BB2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 21:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE74910E528;
	Tue, 31 May 2022 21:13:26 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1324810E2E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 21:13:25 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 t22-20020a0568301e3600b0060b333f7a1eso10480514otr.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5MhKbrzE7l2G6zypqCyJNtPUy9Fhv96I92Zq+CIWdWY=;
 b=X7pcueqNhxHm6byD4fQc25bTGQDP5G6vL5AKzgEax43oBAtuX0gdpC3WI5L5RV3wz7
 eaWBBlIoT8YxBGAR1lxFRICVNaWfirEE1CcEMmRb3PR4xqj1JlpBk6bAwx1i6Vx1CCDS
 xdrlJF2lpjc4AdTjlX+cNUKFxjfQQb1xuTa7uuBI7twcSErZpIlIWsTZ3WU91kveE7U2
 ul0vGlqAroYRIC/mQ6sO1BhpErpmobrik9+nrzhmq+A23szE+e4zLVFrgdwkXAFTeyZG
 X0uMu7NfoYGqTBTXGF1gDRbRtScXaGRZc3006Vvd+sAPFqiTDUFKL0RxvF1Z37AfmsiM
 1B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5MhKbrzE7l2G6zypqCyJNtPUy9Fhv96I92Zq+CIWdWY=;
 b=HqOrEgCQgTwADkH7ySgy5dMJvIFEfCALGIvS+aoz5aQ7eyqOS/n8hYcP9noc6sQYF0
 yZ5/MfdlgCMWPLyEHdXcJB5CEQ3Q90AMUv7//IwpWGld3QmGAmdrnoy3aFQZfsJsCmYn
 N9OCrq/lStzF5fa16v0zlmYWY2yKbvyPEpMdU7GJqdJ9DY8fTfuW+PQdVLpKSPT6PbWs
 UIyVfh1ih41vz/fIt5p2nzroBtn2y/ZamtXmcw/0kO3IktziMS5nBZx1JLS7SdvfJ7ui
 hPdsy3aXFrh4Kg5sciSe/pTCTisv/upfuFUK0EcudGOfkYuVTJtKi/NqkS99BZQLGDQH
 gzbw==
X-Gm-Message-State: AOAM532XBYOnK2wEzoPzaf1WwnG5dQPR5AcdESn40Ihr6mlOP1RcDxnW
 BgqzEf9KV3i0ynqbPPJEbwtdLOgwD0nMZvVbtjg=
X-Google-Smtp-Source: ABdhPJzy6WkLI+DbJ8RsvuhE4SJtxXLo4jpX6OqsfL865K6Jpb0w4IfjAcaHd9cSpgeL6OXwWOm7ckrplNfnL64For0=
X-Received: by 2002:a9d:6b98:0:b0:60b:c54:e22b with SMTP id
 b24-20020a9d6b98000000b0060b0c54e22bmr18157431otq.357.1654031604332; Tue, 31
 May 2022 14:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
In-Reply-To: <20220525020926.1951685-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 17:13:13 -0400
Message-ID: <CADnq5_M-UonUf0Kxy=_64q4DREsGqOes4XAk2M5_bzF4CZi+Jw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: convert
 sienna_cichlid_populate_umd_state_clk() to use IP version
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, May 24, 2022 at 10:09 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Rather than asic type.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 78f3d9e722bb..871435cca3c1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1464,19 +1464,19 @@ static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
>         pstate_table->socclk_pstate.min = soc_table->min;
>         pstate_table->socclk_pstate.peak = soc_table->max;
>
> -       switch (adev->asic_type) {
> -       case CHIP_SIENNA_CICHLID:
> -       case CHIP_NAVY_FLOUNDER:
> +       switch (adev->ip_versions[MP1_HWIP][0]) {
> +       case IP_VERSION(11, 0, 7):
> +       case IP_VERSION(11, 0, 11):
>                 pstate_table->gfxclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK;
>                 pstate_table->uclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK;
>                 pstate_table->socclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK;
>                 break;
> -       case CHIP_DIMGREY_CAVEFISH:
> +       case IP_VERSION(11, 0, 12):
>                 pstate_table->gfxclk_pstate.standard = DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_GFXCLK;
>                 pstate_table->uclk_pstate.standard = DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_MEMCLK;
>                 pstate_table->socclk_pstate.standard = DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_SOCCLK;
>                 break;
> -       case CHIP_BEIGE_GOBY:
> +       case IP_VERSION(11, 0, 13):
>                 pstate_table->gfxclk_pstate.standard = BEIGE_GOBY_UMD_PSTATE_PROFILING_GFXCLK;
>                 pstate_table->uclk_pstate.standard = BEIGE_GOBY_UMD_PSTATE_PROFILING_MEMCLK;
>                 pstate_table->socclk_pstate.standard = BEIGE_GOBY_UMD_PSTATE_PROFILING_SOCCLK;
> --
> 2.35.3
>
