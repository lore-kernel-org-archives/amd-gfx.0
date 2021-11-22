Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855F4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 19:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBEF899F2;
	Mon, 22 Nov 2021 19:33:17 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96F0899F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 19:33:15 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id o4so39818624oia.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/vSlJdqZ6V1XWuNNTGpAdSYbOWWgaQdrWo9LK79PUzQ=;
 b=OHkUkAghCBm8PascbEjm/Q+Mu5amZnSZ7yJtGut6P1cZ4ePMC5v+X+TNhDSWnng0cz
 leI3GCKl3JA2FuJuFHyMHRI8AeCu77yy1q60EIL7Szx3Swc22tzeUn+HOgOf/EB43/9q
 pjf0S8wYgXxSgu4PFcxFIWCTnFjkPzQq9IrHSvn6d8YDlqnSbPx9WiT3fk+surIRANiX
 7S75lMK2C3pgYi/YVaurwLA+TSD63NPHr7p42V5iUWHJVanCoH7K49eeQ2T5iBMkhtlU
 zk6UaBnHFJ8/UL46KpUwGrdDFRd+7AncmhVDlbRX3ptXwyfxRxzVbAe8te97tniY8XUS
 O5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/vSlJdqZ6V1XWuNNTGpAdSYbOWWgaQdrWo9LK79PUzQ=;
 b=VBWv91u6kDmG0iIce1nms4Fvkqshre01uTuRzRW6oXvsRj1hGTEx1nrsZP6K/+RaAT
 xngdwRb6dusw7fXkEIbVimpYVDVdaU2YQzCEREod6V0YvcaRVrA4ihpXYwthekfQ8PO5
 o+uwy/+sMkb5zHT51dbf0h8kGHainetFo4RRZ1H46hqIHFqEUQAJgE9TzhGa1PNpNwAZ
 fYclyJRyOnodArhWuFKvjtbWBLG4nP4bEuDQ5hv1yv9kJzKcNHWoXM7Kdd8ON+ecsS5Q
 oGpZtOEFTq4eaYd18dtPH6gg5eg2n1RRRuwMAptcpEIKcSDqhgGf1twyZSDHtj5QEiIO
 n5bQ==
X-Gm-Message-State: AOAM5307ueDfDtMbmCg5p7lMgd663x0PerQbGUxC83X46T+lzPB/13w+
 +feIo/j4INvNPnNx4UX+Ui6qw0afaJLIB1IAq8U=
X-Google-Smtp-Source: ABdhPJy86j5SaRdzW4l6HTS347weS9bCKizKf6sCzX+6/0udktqsU+VzJ0tZTaveYYEiCpEkHGoTRUvl0XYQBxnVCWE=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr23703340oia.5.1637609594830; 
 Mon, 22 Nov 2021 11:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20211117223339.29822-1-surbhi.kakarya@amd.com>
In-Reply-To: <20211117223339.29822-1-surbhi.kakarya@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Nov 2021 14:33:03 -0500
Message-ID: <CADnq5_Pix_rt=L7R9XFMJXVtVF83+QO_uY23qjGTyBAXoQ4b7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: add new fields for Navi21.
To: Surbhi Kakarya <surbhi.kakarya@amd.com>
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
 Bokun Zhang <Bokun.Zhang@amd.com>, "monk.liu" <Monk.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 17, 2021 at 5:33 PM Surbhi Kakarya <surbhi.kakarya@amd.com> wrote:
>
> Fill voltage fields in metrics table. This patch is
> based on an existing patch I9e15971919b88e54fe5fbee5b784293eaf18025c.

This seems to be an invalid commit hash.

>
> Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
> Change-Id: I701110d78a85c092f5dda167a52350cc6dda7557
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 3b1bf270ebc6..97d18e764665 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3619,6 +3619,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>         gpu_metrics->energy_accumulator =
>                 use_metrics_v2 ? metrics_v2->EnergyAccumulator : metrics->EnergyAccumulator;
>
> +       if (metrics->CurrGfxVoltageOffset)
> +               gpu_metrics->voltage_gfx =
> +                       (155000 - 625 * metrics->CurrGfxVoltageOffset) / 100;
> +       if (metrics->CurrMemVidOffset)
> +               gpu_metrics->voltage_mem =
> +                       (155000 - 625 * metrics->CurrMemVidOffset) / 100;
> +       if (metrics->CurrSocVoltageOffset)
> +               gpu_metrics->voltage_soc =
> +                       (155000 - 625 * metrics->CurrSocVoltageOffset) / 100;

Assuming these are the same for both the v1 and v2 metrics table
cases, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +
>         average_gfx_activity = use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
>         if (average_gfx_activity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
>                 gpu_metrics->average_gfxclk_frequency =
> --
> 2.25.1
>
