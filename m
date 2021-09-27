Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C782FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 15:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8829B60F44
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 15:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8829B60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 460B889C19;
	Mon, 27 Sep 2021 15:16:53 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B924889C19
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 15:16:51 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id x124so25970140oix.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Ca/r9ETMmPOVufBW2LfgkfXzloR+h0A9e0IDDcfpeY=;
 b=XBP1jOtY7C7Tuy5C8sbMz2l9f9twIqUbcrxKqBS9i9Dmn48s4pEdrZvXvnj7zAckCA
 7yPdYui4ZfQOixbVRvmSczdIT0bwKH/JyEBcnpkWeDKq7PS0mcN8mQ7mjW4UszgFuj8G
 p+PASvgOvlQMtgQ65xNzzMtDLaI5ze+TF7tTfKewuBAE9GRIr9dFzMEYl3+XFfGCH84R
 1HeizmFm/D5VRVzC6gAIDBLjwhZBuw1ODCcOTtzID67ahmVJch684jBZw3lzsERT25rT
 FJV9vS12hs8Tlz/qages3e+sJI2jQp3wwfR4JgOuwJZdZwyjVnQFR7GcAorvszpBtzn9
 Ptdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Ca/r9ETMmPOVufBW2LfgkfXzloR+h0A9e0IDDcfpeY=;
 b=mPNvj8yUSBhFCz0eByosc7rYug+g+8VfFpz/2UjxBnwo6Jur0rLygvi6hIv4yCBtAy
 uTCB2vasb9OebqAhYiRQK05ISCl09rR5rBqezmm4iaZ+xoXMp9DHvNX0Kd4qYuT5Ww11
 Rm4NW/AvovKqwvMi+/2Mdwbiyn30csZBd1BgJzrWTiJdNgsfZzUS3jwHnoNzek7cSl2p
 qcvXrkZgUANMM3I8e4IVS9UuwMKOh0PlBTNmkkpxqWz2MsYQsXQM7JECfuZXvkBbCcrM
 Nup5ZOMxv/X02izc2D4utOxLyhtrDMcn/ljW6e3LiZcYy2rAU00owALCgRQPrT+F4Nqd
 8xTQ==
X-Gm-Message-State: AOAM531si0apjc0dSesy7ViYrBKBIsi+k2tab3TVJ4E6KUqJSpG1PK/X
 eWevzv2oojAj3a4vPdySkpw3lJUIjOMB2alptpo3Untd
X-Google-Smtp-Source: ABdhPJxJfB5b7PhJ7aJTxy+3nWiFOCoqE55kzakV9ZKuQoYf4cv0/Jm/W4YGJW7EW+ZF5QZUUO1Q8UXAAhHW0u028E4=
X-Received: by 2002:a05:6808:1141:: with SMTP id
 u1mr344230oiu.123.1632755811069; 
 Mon, 27 Sep 2021 08:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <1632661843-3923-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1632661843-3923-1-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Sep 2021 11:16:40 -0400
Message-ID: <CADnq5_NGSMJUs_WJKwWX7K9WboN6PuoTVtTeHNnFiCVYmfaWog@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, Huang Rui <ray.huang@amd.com>
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

On Sun, Sep 26, 2021 at 9:14 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> In the s2idle stress test sdma resume fail occasionally,in the
> failed case GPU is in the gfxoff state.This issue may introduce
> by FSDL miss handle doorbell S/R and now temporary fix the issue
> by forcing exit gfxoff for sdma resume.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index e4a96e7e386d..81906955ef52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -868,6 +868,12 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>                         msleep(1000);
>         }
>
> +       /* TODO: check whether can submit a doorbell request to raise
> +        * a doorbell fence to exit gfxoff.
> +        */
> +       if (adev->in_s0ix)
> +               amdgpu_gfx_off_ctrl(adev, false);
> +
>         sdma_v5_2_soft_reset(adev);
>         /* unhalt the MEs */
>         sdma_v5_2_enable(adev, true);
> @@ -876,6 +882,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>
>         /* start the gfx rings and rlc compute queues */
>         r = sdma_v5_2_gfx_resume(adev);
> +       if (adev->in_s0ix)
> +               amdgpu_gfx_off_ctrl(adev, true);
>         if (r)
>                 return r;
>         r = sdma_v5_2_rlc_resume(adev);
> --
> 2.17.1
>
