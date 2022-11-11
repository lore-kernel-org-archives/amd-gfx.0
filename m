Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94F3C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Nov 2022 15:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3445110E867;
	Fri, 11 Nov 2022 15:38:20 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5593E10E867
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Nov 2022 15:38:16 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 l42-20020a9d1b2d000000b0066c6366fbc3so2996668otl.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Nov 2022 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0vjIap1R61bzNm9gS9ybMKcUXG6eCcQmXLMVLr2LLdo=;
 b=F7EPGT828u9kpCiM0+PFQc7+iBDdCu6K0c1Eh/mkAGYPGeSxn75HJ8oT9+AxVA/+Xg
 jA+P3Za0UxnmrMsHF3WN22CAkocVylsfWhHK7sMwaNX8IpREGl3MgWxQBeaeMhinkkL0
 xwbH6ZsVYX+08lDOhlxuUMFwYvV7OjMtsrLZQ48IAJcsUcSZgGa2msCSx0CexmmQCloI
 wrcNIxDYtO20MorH0lnVBPTbJKVWH+yWnDiUOrDb5AeTNseEfoNk4+ZUWc5LAijm3Rv5
 PAtskWdb7x5+wEjUZ2fOq3XkBXqbvizgqFcjIz0xLY0HvM+AwJjxYBIJjbi2piTrHUeQ
 y9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0vjIap1R61bzNm9gS9ybMKcUXG6eCcQmXLMVLr2LLdo=;
 b=Tp8hI4GwhKYoTPszDeu7ACQFRSMdfApKMwfhijVYiY4xshVEmMnEmrgXUdkaKYaS0L
 KFXb09SEI0aWM9fndW4CW0QSqLnWtbWG8jctxH/EKG8EyEQPTOMyqFSJFTgVHTlyyQkI
 rrhd3KvnYbsk+4pOznIHOFczYak2UrYNJ6YX1ZfUqvune0IDV8rRq2W5F56039dq8i6c
 dt7xW3//YwF747aQvBVGVM42mhg9y6EJMUfDOh7llShcD9+yiVwtKlXzFGRz813LaO1f
 f8F2rMWLu7RV4e28y3qbZXd+p6gFRlE0PdtmTpJcpvjTCwEPDCrWIrPMqoNj+xleoMI+
 aTzQ==
X-Gm-Message-State: ANoB5pkWMCDrWcHvP7djWIoXvpnOQ2q99LlYZdeHKQIxhwz9GPSz6lFA
 8auIKScP9nOXrqnN4vB5xO2zuwyJy60M9d4vfhE=
X-Google-Smtp-Source: AA0mqf4299zvWU3FMihMndOy2kdFhqK+8DvwzFyQfrNR3Fe7iepE6FAV0JFObmexvNaNktRLVIr8h4Y1eGyMvDwd85k=
X-Received: by 2002:a9d:32f:0:b0:66c:7982:2d45 with SMTP id
 44-20020a9d032f000000b0066c79822d45mr1510308otv.123.1668181095561; Fri, 11
 Nov 2022 07:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20221111085641.2264671-1-guchun.chen@amd.com>
In-Reply-To: <20221111085641.2264671-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Nov 2022 10:38:04 -0500
Message-ID: <CADnq5_NU-zxf-3Xp-b5ug04fcoO1+43r03AJ0mTxiVKiPv1yOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable BACO support on more cards
To: Guchun Chen <guchun.chen@amd.com>
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com, evan.quan@amd.com,
 amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 11, 2022 at 3:57 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Otherwise, some unexpected PCIE AER errors will be observed
> in runtime suspend/resume cycle.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Please make sure we try and root cause this.  I would hate to have to
leave this in place for a long time.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 6212fd270857..697e98a0a20a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -379,6 +379,10 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
>                     ((adev->pdev->device == 0x73BF) &&
>                     (adev->pdev->revision == 0xCF)) ||
>                     ((adev->pdev->device == 0x7422) &&
> +                   (adev->pdev->revision == 0x00)) ||
> +                   ((adev->pdev->device == 0x73A3) &&
> +                   (adev->pdev->revision == 0x00)) ||
> +                   ((adev->pdev->device == 0x73E3) &&
>                     (adev->pdev->revision == 0x00)))
>                         smu_baco->platform_support = false;
>
> --
> 2.25.1
>
