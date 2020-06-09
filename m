Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D010DC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCFB206D5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMEBqK9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCFB206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6C36E334;
	Tue,  9 Jun 2020 19:51:42 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC026E334
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 19:51:40 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id l10so22657448wrr.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jun 2020 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0gdI6ryFMQdLa7UCZhPXHrtTjP7UCBodVWYo4JCB8sI=;
 b=pMEBqK9gjkmVrh76feqGtwE+sCCMUlWXCuyeRk0er7nf3LM+gJKr4K8/xXxlHp8KQt
 ooeiMx7r0WJ9d+5BHQOEsR5UBZJdEgFPvoqPOgbOEyuKxWIzN4yPDz+RaJ/5dskZ7Oyb
 Fh3lJAiVfvmbAGl9/VRWwy1xk8U5DSiEsStqyVe4ZDwuF/3MBhEA3acWUnt9u4vg9ind
 CewfQdPGLAoOgWS1of+XMQfrdamvaP3CeNtFW5U7vLO8I/6h7XFuMfKvSD40S3AmGFSl
 I+qOphGK2K03KudhucrMsfnuwkhvM2bcUGBQGeUQpK+yGAVVRLWW/2OMJmOcuDGAnClW
 eOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0gdI6ryFMQdLa7UCZhPXHrtTjP7UCBodVWYo4JCB8sI=;
 b=RkhO2X+r4NTNKCvxAHAc2tekddjrvs6H/ITUq3QB4YZeUZ/7qp94H1ipSyMJP++Tx1
 1b6ra57qIUF2IQE2t51cmIZblVBxk6JmMvDHwn/RSMYiM5godyC1xyR5zBMTWbNz9Zuq
 DFziCutrzkkWX40ciHaVqGPdK12PuYpgwsebNvhPUsT5OC/DP522aiZub1fBwx0i4hk6
 aE3QUx36XvcbAHYDrl69xovnn8BiEYASjFfLXWPPllq1pNHj+thSUa2c34iSBs0Py3re
 PQ+lqW3uLRHV97giqsEs47bXYTfoRSvCbQHs5+oZfyP5sSUqo1iJSdFVZH3RNrSPZlCt
 Fddg==
X-Gm-Message-State: AOAM532KhpnAIrPWoXVNT3r/A4G/6X314J4V79Tf56zL9Aq89z8EEv1D
 MrV8+Kf1q5nzdNrp/3FYDTHeCSl/YLJI0vO7swpnGKzK
X-Google-Smtp-Source: ABdhPJwZUgj5KEiSNNUH3SJ8d0rl0BLcPbFc+QwDKTj/1Fm2sE94FFB4AORoI7lD4QfQWBQMrbWaOiOqdjv0ufXwleY=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr6568296wrp.419.1591732299275; 
 Tue, 09 Jun 2020 12:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200609102017.12478-1-evan.quan@amd.com>
In-Reply-To: <20200609102017.12478-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Jun 2020 15:51:28 -0400
Message-ID: <CADnq5_OkFvQVUFewsufPT=g-QD2R79Q0xtSjBFfsE1PVqzd6BQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/powerplay: drop unnecessary
 SMU_MSG_GetDpmClockFreq check
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 9, 2020 at 6:20 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Since SMU_MSG_GetDpmClockFreq is known to be supported for Vega20
> and before ASICs only. For those ASICs supporting swSMU, it is not
> supported.
>
> Change-Id: I8ee71664baa32e40df5bb793550785120f3770c6
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 9e3fee9e4aca..d10d15fc7492 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1089,24 +1089,13 @@ int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
>  {
>         int ret = 0;
>         uint32_t freq = 0;
> -       int asic_clk_id;
>
>         if (clk_id >= SMU_CLK_COUNT || !value)
>                 return -EINVAL;
>
> -       asic_clk_id = smu_clk_get_index(smu, clk_id);
> -       if (asic_clk_id < 0)
> -               return -EINVAL;
> -
> -       /* if don't has GetDpmClockFreq Message, try get current clock by SmuMetrics_t */
> -       if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) < 0)
> -               ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
> -       else {
> -               ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmClockFreq,
> -                                                 (asic_clk_id << 16), &freq);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
> +       if (ret)
> +               return ret;
>
>         freq *= 100;
>         *value = freq;
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
