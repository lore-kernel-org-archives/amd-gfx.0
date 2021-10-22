Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 13:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF28961073
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 13:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF28961073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F4A26ED7E;
	Fri, 22 Oct 2021 13:06:42 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5451B6ED7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 13:06:40 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id v77so4948902oie.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WVauixj+XnYe9bhtr6n94PY4vKbUUcSwsKikFaJQvKY=;
 b=DXSfoYpjrYsEHEn5Ia99/wb6zDGY7C5dijbS5L4c6VVaPZJdcrTHOM78VF2CuBMvvq
 rS+E2GAUZNL/SC+O+a/sQOjoTQWrM8IjzhqhfGP8LNOGWt3B2NEQmiLv+MIFy9hRDYuT
 nfc1vmHszSxsUJfNVt3TOYhSN32BmDv24rT6ePPmus+IgPdZth5KixFrLk8/BXqcAmz0
 4MOQrcGmwfFLReGWhLYm1bYXD1V41J7IoemxfdUGoZncBxBYseoOo4q2c3xEGYmcCobL
 OA5Na4rYyrZSxYDYueuXv3HWA0ZOgYBmC9x+cixUvJ5MSVa5nVPac/GnY63BjNxmTG25
 uEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WVauixj+XnYe9bhtr6n94PY4vKbUUcSwsKikFaJQvKY=;
 b=TLiAaRWgATEL1X0lLsPvTZ1yRysz5BqbWGlC9vjoDmRB+RqKH5CdEpzd7GBNZkzCeU
 x52wgdVRFttTkTeczGZr0edLLDHV1hRGdchGHGGmseaMOeiWLQ7KWhBKN5MKFqeZb4N/
 kZ7pwmrfnZVFFbSnr+5w0pe0ba2sTR6l+tMQzKLimVw08n19Ljb9HH08bSC4PBUOf87B
 yTW0RV44lAeNyhy2tr+qt+A9RHbF0qAdxCsIooyfJsa4tgWK78R/zUKtJfhlXAn100/n
 yHv2KbISAEH5Ay3t/GmCxJfyC+JtrCbLpmuIo7mY2L7EjSDibhnEx/3O4NMuRxlpPgtK
 ecWw==
X-Gm-Message-State: AOAM53292worarHQhJSnP7K5OPaWaze6ZkzTN9ijDJPTtuEo56OJk1yB
 ipIjfTjkA5IzyjoF2glPYmYvYDkWeQ95QmVoK+4=
X-Google-Smtp-Source: ABdhPJx+kZ11q7/CWBaoki8xs/AA9gKBZeetTCutBbL1Qd/yBn18J1t3dneCk15+/X3ZrFdI+22gclrT+/cskXfEjU8=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr9594748oia.5.1634907999535; 
 Fri, 22 Oct 2021 06:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211022074433.29717-1-lijo.lazar@amd.com>
In-Reply-To: <20211022074433.29717-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Oct 2021 09:06:28 -0400
Message-ID: <CADnq5_M++Uw12RUe4zDiKUcf1TeaNFTmcvbx3+GPwxMt7_dRBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Disable fan control if not supported
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, 
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 22, 2021 at 3:44 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>
> On arcturus, not all platforms use PMFW based fan control. On such
> ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
> knobs for fan control also as it is not possible to report or control
> fan speed on such platforms through driver.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 082f01893f3d..fd1d30a93db5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -436,6 +436,19 @@ static void arcturus_check_bxco_support(struct smu_context *smu)
>         }
>  }
>
> +static void arcturus_check_fan_support(struct smu_context *smu)
> +{
> +       struct smu_table_context *table_context = &smu->smu_table;
> +       PPTable_t *pptable = table_context->driver_pptable;
> +
> +       /* No sort of fan control possible if PPTable has it disabled */
> +       smu->adev->pm.no_fan =
> +               !(pptable->FeaturesToRun[0] & FEATURE_FAN_CONTROL_MASK);
> +       if (smu->adev->pm.no_fan)
> +               dev_info_once(smu->adev->dev,
> +                             "PMFW based fan control disabled");
> +}
> +
>  static int arcturus_check_powerplay_table(struct smu_context *smu)
>  {
>         struct smu_table_context *table_context = &smu->smu_table;
> @@ -443,6 +456,7 @@ static int arcturus_check_powerplay_table(struct smu_context *smu)
>                 table_context->power_play_table;
>
>         arcturus_check_bxco_support(smu);
> +       arcturus_check_fan_support(smu);
>
>         table_context->thermal_controller_type =
>                 powerplay_table->thermal_controller_type;
> --
> 2.17.1
>
