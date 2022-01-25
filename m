Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30A9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 15:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED65710E4E6;
	Tue, 25 Jan 2022 15:27:57 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D854110E4E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 15:27:56 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id bb37so31668039oib.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 07:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3M3ba5sDEfPOL/oSLu4suGFReWLMK+j6rCAdAw3NOJw=;
 b=T09nQn18mZ463vI8ow+kkUeRgSS/XzsMzOugTatzESuLLcIM0abGDDh0esetHopAyy
 0sE2dp712pHj28cHI80SAFhOQ1zrIhIMQfOya409kWnuz5ddeWMVTqjKzPsS9jEozJuj
 62nlo45WwhxTUh6cfn2jtR9hn4PXmyc/8TPWfBZWDESD2Onn5kctFilZ4fTGhfhAu7H5
 DhyymFkGUxrD0XlRzwlSZ1Tn7jtIphy68BlGay5FxhAsqeeEHemJ6JMKZSF7QOK7uslh
 xCZqWn6vHDIF/tIox8z5JjZ5/yga2Av/KCr6mnvlCFwqoUGftSjC7KyGCBio9O/Xq4vv
 Ijwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3M3ba5sDEfPOL/oSLu4suGFReWLMK+j6rCAdAw3NOJw=;
 b=lvP2QLmZ1CF967RBG/var6Jcvan0QJajA0HoE8UbU0RoKR2zbnQrj5DpDZULUxlG5w
 iTWPnyN49DHrvckkrdzDiZ6teQKKoXGYFhttTVkIfYiDEnUEO2/mtvlrcQ9lCaLwdcOU
 6RQ2xAwZlykMpaGZVAYg9Kk/zaOpgVI1BM4HbslGwJxCJPy/IKXMbakw2qAG0TDdf0K5
 tyQIdxBxYxawCBJ1VSIWGTlctGVYCyd6uddhYSFVGFufVDtRQ01kte3ogeNv3LZMAT3O
 xQhVWDliZyf7Buj6xTRBethMxOJDnluvBsO2GbgbDaKrQa0fZMm2BcEum9wvgCfcT3ZC
 JDIw==
X-Gm-Message-State: AOAM533GMtZ3o7CUcoDyY69M2EcFYAnHMYoeKlHZnACSiorlzqS3I/Ib
 7Wjx7GK7+XWbTrHavX4OsEgtWF0tffrfFF99XiZqsNo8
X-Google-Smtp-Source: ABdhPJxel+S0GpREfqrEMx/CCalKVF+yszEO9PtHVVk715Mqvck+hbKjr7OQ/n8KLjODxNW2Lr4+bEN/q9fTpCLslOM=
X-Received: by 2002:a05:6808:2097:: with SMTP id
 s23mr963136oiw.132.1643124476090; 
 Tue, 25 Jan 2022 07:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20220125085614.101348-1-evan.quan@amd.com>
In-Reply-To: <20220125085614.101348-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jan 2022 10:27:44 -0500
Message-ID: <CADnq5_PNbFQUK2=rRsnRkHRWyoeoLQ948FjoxtbXKrMExCCnqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: correct the MGpuFanBoost support for
 Beige Goby
To: Evan Quan <evan.quan@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jan 25, 2022 at 3:57 AM Evan Quan <evan.quan@amd.com> wrote:
>
> The existing way cannot handle Beige Goby well as a different
> PPTable data structure(PPTable_beige_goby_t instead of PPTable_t)
> is used there.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I02208c011e93c4d37769bd022e65e9084faa97e4
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 651fe748e423..dcd35c68e59b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3729,14 +3729,14 @@ static ssize_t sienna_cichlid_get_ecc_info(struct smu_context *smu,
>  }
>  static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
>  {
> -       struct smu_table_context *table_context = &smu->smu_table;
> -       PPTable_t *smc_pptable = table_context->driver_pptable;
> +       uint16_t *mgpu_fan_boost_limit_rpm;
>
> +       GET_PPTABLE_MEMBER(MGpuFanBoostLimitRpm, &mgpu_fan_boost_limit_rpm);
>         /*
>          * Skip the MGpuFanBoost setting for those ASICs
>          * which do not support it
>          */
> -       if (!smc_pptable->MGpuFanBoostLimitRpm)
> +       if (*mgpu_fan_boost_limit_rpm == 0)
>                 return 0;
>
>         return smu_cmn_send_smc_msg_with_param(smu,
> --
> 2.29.0
>
