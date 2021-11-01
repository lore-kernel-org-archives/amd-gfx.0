Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BD8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 19:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB32960E9C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 19:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB32960E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DAD589B38;
	Mon,  1 Nov 2021 19:57:54 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B935989BAF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 19:57:53 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id u2so7388142oiu.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Nov 2021 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x1RYRVeqcwk/VT+jukmJFYZsR2dOjJaY/E4BlsTD4T8=;
 b=qZqwpzCyQyUt3wZmaW0I+1Z91ekJKQ/ZJXybjTrEyPniCXKpgRwqv+FzsXT78HrpEQ
 rgIOhS4EyrZG1xMaNb3YlN6DUHWxitIT8ohO4bKehUUUiff8rjgFEgvcXRcvs6mTqns7
 Qeb80InLuGgolindpR0AUuTXmEP5jp5cxHrgNuPDtuiFs73CQsaG7RzQF4sn2th6kZ+o
 aHH2vjkiwH2t14dU/dR26F9NHKgzxO2ZGm/UwcEIu7UMpsUUoZGp5RqVzIz1Lh3zYWTC
 R70vZzvM9xRS1lYw1OC1bNbRhGg6nXYhcqh6FagkAW4kJpVlu2bcM301t5DtIhz3220t
 TOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x1RYRVeqcwk/VT+jukmJFYZsR2dOjJaY/E4BlsTD4T8=;
 b=An7qYo6O5x7agZDRsCsucjk+sk08KZa3ymuYoYVLRCIBJckcef9Z+P7X1bnwTD4Mew
 phS25+b4YA4cFPFthE2TfN9dYAXvs27GcNBQPIgvCvD2kyrA1KPklBBZaZoPBNoWgd6d
 xIQkGA9jH4CClr3yEk4uGninrbPGgCog1UIOAQ0ILLam0OJVXGrzqUpAJGqUzq2UANBy
 tyrRUOFpimC1GGfAOZzRUCTrRLfrOgzlqbH9AJFYwkuVi8kITql1V0fkV1YCN2Ofv/PH
 Zs8fmo/Y61XlhuQIp3PqHodkWZRapbAB9cLf5RJcX/M89tPa0Uw8NK5k5G2AgBvS9ZKk
 0ZPA==
X-Gm-Message-State: AOAM530LWQ5kFUXPxL/2twBav/PWavpEzR061dvfISikTSa7SM8wXpUo
 qRXNrxoMaVzSR9QtocVYRiMpZ7aMRBTdwZzvuTE=
X-Google-Smtp-Source: ABdhPJwPdE05NXCIXXbDCiV4ocwEEzveWG6lSMmjnrVHU3D8lZ+0wOTNgy6szpA5Zo3F35LrLrmZxamqvACoSxP9xMA=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr980919oia.5.1635796672023;
 Mon, 01 Nov 2021 12:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211101190948.4374-1-mario.limonciello@amd.com>
In-Reply-To: <20211101190948.4374-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Nov 2021 15:57:40 -0400
Message-ID: <CADnq5_N6_BUyBZ0NYA1gvi37ig59dCn8wf8T5Y3xPdKsqyHJMA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/pm: Don't show pp_power_profile_mode for
 unsupported devices
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 1, 2021 at 3:10 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This command corresponding to this attribute was deprecated in the PMFW
> for YC so don't show a non-functional attribute.
>
> Verify that the function has been implemented by the subsystem.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes from v1->v2:
>  * Change smu_get_power_profile_mode to return -EOPNOTSUPP if not
>    supported by underlying implementation
>  * Check amdgpu_dpm_get_power_profile_mode to determine unsupported
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  4 ++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 +++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 49fe4155c374..41472ed99253 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2094,6 +2094,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>         } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>                 if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
>                         *states = ATTR_STATE_UNSUPPORTED;
> +       } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
> +               if (!adev->powerplay.pp_funcs->get_power_profile_mode ||
> +                   amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         }
>
>         switch (asic_type) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b06c59dcc1b4..821ae6e78703 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2534,13 +2534,15 @@ static int smu_get_power_profile_mode(void *handle, char *buf)
>         struct smu_context *smu = handle;
>         int ret = 0;
>
> -       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> +       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> +           !smu->ppt_funcs->get_power_profile_mode)
>                 return -EOPNOTSUPP;
> +       if (!buf)
> +               return -EINVAL;
>
>         mutex_lock(&smu->mutex);
>
> -       if (smu->ppt_funcs->get_power_profile_mode)
> -               ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
> +       ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
>
>         mutex_unlock(&smu->mutex);
>
> @@ -2554,7 +2556,8 @@ static int smu_set_power_profile_mode(void *handle,
>         struct smu_context *smu = handle;
>         int ret = 0;
>
> -       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> +       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> +           !smu->ppt_funcs->set_power_profile_mode)
>                 return -EOPNOTSUPP;
>
>         mutex_lock(&smu->mutex);

You'll need to add similar functionality in
pp_get_power_profile_mode() in amd_powerplay.c to cover the older
asics.

Alex

> --
> 2.25.1
>
