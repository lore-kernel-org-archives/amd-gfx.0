Return-Path: <SRS0=S4aW=CO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24660C43461
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2020 15:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB338206B8
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2020 15:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw5pw/9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB338206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E6F6E133;
	Sat,  5 Sep 2020 15:45:27 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019E26E133
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2020 15:45:26 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id c19so9411032wmd.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 05 Sep 2020 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y7+4F/nQ3j6ddVWrMUGWHbeVcIZ/lISoiP6h7HU7+dM=;
 b=iw5pw/9Wk6xYwxc61kbko1K20fg4vzDqp3bxSmRh9vKrYxBnyaSQb0OPSngTDt2Bux
 wyTUX+2Q/bnlAnZbI4uUcce5k2cYqtkssSfB/38UPGVIvyuBrsPxbjPFs2grMYt8Nmxg
 AEmChEPokF+0OtU/XwQx7/woz7+zZb+kpce3JbPJ3lCdKeOGrJbVEifMXwfdrJoJ4bip
 EG1diit7H92uAgghOFK3USC9ss0FBi0OY1LRtl3CK58kxLVEORFvDCCU9eDB7OD84And
 8hYZDuJbSqrCHCNrYDaqnu3FiEvGZmDH+8mv71ujS/UgE74rbo22zf7buq7bp1XtbO8T
 RlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y7+4F/nQ3j6ddVWrMUGWHbeVcIZ/lISoiP6h7HU7+dM=;
 b=Gc3x/kLEfRO/FAKxPpguULOldJto1XgJav5dNEmGRfSaQbHflBQDYQJpZtitGmvBEu
 qMMeK8lTvc2oe0OfQDBBEmg89ajrNoIc8vORWC2dlQW/FZcuTlsDnCBvOLicvmPWJ27v
 h6hqipeJh6+YBDttkV9+DkgwLZbmz+nV49kJQb4QKrUTHXEZ28eznwnhogh7GZthVH0P
 pIdkij47PJYjboj20fEhdqzt/APTn5QoGiV3bKdm0j6iyocvdQY4E3PZlssNxpfAjBCu
 1mCuv3cWOwxpWegzqVAVvELNQkYLFwY24owYr/q4qF49HGE/uG8G0Dea0IxzDo7o42z/
 8QBw==
X-Gm-Message-State: AOAM532iKfSGMt/bgDwWwpQ0JXtjTuh2MAAjWmOzmIndj0qAyHzjdLkn
 WaBsqJ+2Nbof53y3lBwESoVoVd7vIrBFEwDLndw=
X-Google-Smtp-Source: ABdhPJxnOQh16wRs8ENNpWX5hd043e4QcwD6s7ZbeVwOE7JWJUhELBB/vKD0I2TMVEtk/GtayeEtUX4mAvTyHbfT97w=
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr12776779wmh.56.1599320725586; 
 Sat, 05 Sep 2020 08:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200904082118.19927-1-evan.quan@amd.com>
In-Reply-To: <20200904082118.19927-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 5 Sep 2020 11:45:14 -0400
Message-ID: <CADnq5_NNkvMYk-zz9gf1uQjOMLTLM7uSm=YQSwRtz-fKuKBA4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/pm: process pending AC/DC switch interrupt
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

On Fri, Sep 4, 2020 at 4:21 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Process any pending interrupt that occured before driver register
> for interrupt from GPIO/SMU.
>
> Change-Id: Ie846304408df27c7a7f2b29cec8f7dcb9d08905e
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 40 ++++++++++++++-----
>  1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 5f80ca5a3a31..b710e049db8b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -934,12 +934,39 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
>         return 0;
>  }
>
> +static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
> +{
> +       return smu_cmn_send_smc_msg(smu,
> +                               SMU_MSG_ReenableAcDcInterrupt,
> +                               NULL);
> +}
> +
> +static int smu_v11_0_process_pending_interrupt(struct smu_context *smu)
> +{
> +       int ret = 0;
> +
> +       if (smu->dc_controlled_by_gpio &&
> +           smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
> +               ret = smu_v11_0_ack_ac_dc_interrupt(smu);
> +
> +       return ret;
> +}
> +
>  int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>  {
> -       if (smu->smu_table.thermal_controller_type)
> -               return amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
> +       int ret = 0;
>
> -       return 0;
> +       if (smu->smu_table.thermal_controller_type) {
> +               ret = amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /*
> +        * After init there might have been missed interrupts triggered
> +        * before driver registers for interrupt (Ex. AC/DC).
> +        */
> +       return smu_v11_0_process_pending_interrupt(smu);
>  }
>
>  int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
> @@ -1235,13 +1262,6 @@ static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
>         return 0;
>  }
>
> -static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
> -{
> -       return smu_cmn_send_smc_msg(smu,
> -                               SMU_MSG_ReenableAcDcInterrupt,
> -                               NULL);
> -}
> -
>  #define THM_11_0__SRCID__THM_DIG_THERM_L2H             0               /* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
>  #define THM_11_0__SRCID__THM_DIG_THERM_H2L             1               /* ASIC_TEMP < CG_THERMAL_INT.DIG_THERM_INTL  */
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
