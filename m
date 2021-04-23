Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EFFC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 21:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CD9613DB
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 21:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CD9613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38BE6EC50;
	Fri, 23 Apr 2021 21:21:45 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B58FC6EC50
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 21:21:44 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 c8-20020a9d78480000b0290289e9d1b7bcso32425096otm.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OC0HUGyEXe+QUzjtbtojCN4/rYMk0JxQMFteDFx6JeI=;
 b=WW3gAI8KbdXDBC6w9cJOBtDs63UxtyX0m2pvCVW7WQbDiBIaZG8hZlagIrOP9+s4yy
 LEuyB0BPC8m6MMcTZrROHtV/MvWdaT1TplSnJ4/6Ck26t1OVSM+uqJqUUS46wrbOfiMf
 RyhCirEWHdTlo4/A2xmLg/KYt6jVnUJbVJRmAokJDV+EUHZTg7QYvWUGCvXpbnLKF/xl
 oKntdiN7unKTRJ4waTCJzxo1amicKHV/4/bfPvYJf6BtkmZc9uOwYdm8s2JLRJdU3+uU
 O9+gtoqhUwwUdePRAIzLI+Fj7H9UcFPcAIZgEpUzkkvrqtX8eR6hNJ7pUzw1sX92R2iL
 o1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OC0HUGyEXe+QUzjtbtojCN4/rYMk0JxQMFteDFx6JeI=;
 b=GaZ8pQmrIQy65SSMQ3H7FrruyfYzikpOLFXVgKJIF8Jp5BPU8FmweTY7bOj5p3sBxe
 O3xBbjQ7v3Rb5rvqmm6kpGcmMKvOv4/WnXI1rIe6P1VSF/kP77tVJNo9s3y9s/YQjF7J
 lG6tL6+temcUB8DlEPgfDslpB+3cus7Mr/GoHD0ValC+DQYCx9E/0FxTaEv/8IiL+9l5
 CCqAARK+3qFqpnn/Wow7zcC+huXleJ9DIZo8ZgW1mN2nPgkvkRI68DREUAOm3XnL4tWg
 UwzesUHzkUSQIqQYuMSYn9S20QYjYYRdLkZ/qPLF0Y91pbnc7juNynAQMp4wtEInBDIa
 7cPw==
X-Gm-Message-State: AOAM532cu/q76UgZ7HSLfeVAfaK8Hoh+pzg2NSZ32bhGMTdFB8uX/Yh1
 iHhh4rNreMhikjkTols7zggfyAgsxSr3OXGRx8pA2HloO0Czxw==
X-Google-Smtp-Source: ABdhPJwYL6IwczFNYxsMB0fwQUc+9P0DNI0URvzi6el+Gpr0ISbRrz+4EW8na+m2YiPDBC8nUwl9F8AZyxrjP/KaBuA=
X-Received: by 2002:a05:6830:1f12:: with SMTP id
 u18mr5108279otg.132.1619212904095; 
 Fri, 23 Apr 2021 14:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210423190242.2118230-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20210423190242.2118230-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Apr 2021 17:21:32 -0400
Message-ID: <CADnq5_MDLeQEUQOSQLU6Nj=b4j11DF=2aOLfeAazei6-TqL0=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Update energy_accumulator in gpu metrics
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Apr 23, 2021 at 3:02 PM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index dcbe3a72da09..1f02e4ee2909 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1657,7 +1657,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
>         gpu_metrics->average_mm_activity = 0;
>
>         gpu_metrics->average_socket_power = metrics.AverageSocketPower;
> -       gpu_metrics->energy_accumulator = 0;
> +       gpu_metrics->energy_accumulator = metrics.EnergyAcc64bitHigh << 32 |
> +                                         metrics.EnergyAcc64bitLow;
>
>         gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
>         gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
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
