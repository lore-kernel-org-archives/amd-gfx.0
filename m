Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A251C5517A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212B42151B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOPiLqZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212B42151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7755E6E950;
	Fri, 30 Oct 2020 04:43:12 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073DC6E950
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 04:43:11 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id l8so1755059wmg.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 21:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+1etVNxXORYCYNq7fReLmExUgEd3vCdqyn0Cm3XxJx8=;
 b=OOPiLqZbRhDIcsCrach7AzCeMDOdbTeOS7jxwrtyroHkzlWVOqwvgwAeb9mHFTow02
 1Qj0ZwrMd845uMYFTfFVuzOCFYAQfIOnBAM1TfXk1Jq/fCYhRs3Z8RuFUNaHJM+h5w5L
 HaOhInyXhI5DsPNZcXu3vK1EeRhhrcd/kQI2xGNs2bBYMtMQmSyMcNcot1vhC4L3MR6Z
 o8wr8YLR2we6ukbbwH97VTefls2ODGxrjFxJ2Q9zP0yQJrADvlwmEFWho1PsARO9qQyS
 ov9rfI5b6wvVJZNOFoOtHspdEVs4YZ4FSkbLhhJLtFyMo1M4apRQynkzz0t/n/mkpU7Z
 9l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+1etVNxXORYCYNq7fReLmExUgEd3vCdqyn0Cm3XxJx8=;
 b=OcK0vBZjfBSwlcAw4UcrEVcoBGpgy/e/+ucvd/H6eplXUTWidseKwMSLrWzABWgXeQ
 eNlv4lJxzv5LvxqjGvAub8OLCR3HLlp+R5dSaXGHiVgpfU8EB/yFf+zfBx56svt7E44W
 R03pe2cIl8cbEibUdhD+phRg3WpfpWC2EtunBI6wKUg/gbt7Eb5mr+2CyX2nQa8YY2s9
 y4oyoMqOeIonmU/GDrklhLWw99+38uvjy2c6H0Is2jMVr8i04UnBSub51ZaNr/4vCl3Y
 GNRFCib4hBxmdt4AVaRR8pq6hizZx0y0fenjmvRVimnnQLdX39BGrpbnDS2p3SdDRoK4
 Zkww==
X-Gm-Message-State: AOAM532rjuSpAhinwWy0y4acjb1CtrfQDKpFrRN6BGHBM4HhitQeUOEh
 5K2iDyq4N/rfmY9dRuk0EY7JlVMDKENxwgFW684=
X-Google-Smtp-Source: ABdhPJyEodVMxrXEO5/sW85X1Ayd7YPNm7dCnhkpeb0P3t0syDxHOBDB90K0xow7qBe8lJDil1RMHqU/Jey+0CEcekw=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr425401wmi.70.1604032989654;
 Thu, 29 Oct 2020 21:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201030030427.20560-1-Xiaojian.Du@amd.com>
In-Reply-To: <20201030030427.20560-1-Xiaojian.Du@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Oct 2020 00:42:58 -0400
Message-ID: <CADnq5_Or9W=MBx2F_7b_Cy29d07gteCaowM2nKoZJzDde+J5Hw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: add the reset function of the
 pp_od_voltage_clk sysfs file for RV/RV2/PCO APU
To: Xiaojian Du <Xiaojian.Du@amd.com>
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
Cc: Kevin Wang <kevin1.wang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Xinmei.Huang@amd.com,
 Huang Rui <ray.huang@amd.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 29, 2020 at 11:04 PM Xiaojian Du <Xiaojian.Du@amd.com> wrote:
>
> From: Xiaojian Du <xiaojian.du@amd.com>
>
> From: Xiaojian Du <Xiaojian.Du@amd.com>
>
> This patch is to add the reset function of the pp_od_voltage_clk sysfs
> file for Raven/Raven2/Picasso APU.
> If the min and max sclk frequence are configured, this function can
> be used to restore the default sclk frequence.

typo: frequency

>
> Command guide:
> echo "r" > pp_od_clk_voltage
>         r - reset the sclk level

Not directly related to your patch, but for consistency, we should
only apply the changes when the user sends the 'c' parameter.  That
way you can queue up all the changes before they are applied.

Alex

>
> Example:
> 1) check the default sclk frequence
>         $ cat pp_od_clk_voltage
>         OD_SCLK:
>         0:        200Mhz
>         1:       1400Mhz
>         OD_RANGE:
>         SCLK:     200MHz       1400MHz
> 2) use "s" -- set command to configure the min or max sclk frequence
>         $ echo "s 0 600" > pp_od_clk_voltage
>         $ echo "s 1 1000" > pp_od_clk_voltage
>         $ cat pp_od_clk_voltage
>         OD_SCLK:
>         0:        600Mhz
>         1:       1000Mhz
>         OD_RANGE:
>         SCLK:     200MHz       1400MHz
> 3) use "r" -- reset command to restore the default sclk frequence range
>         $ echo "r" > pp_od_clk_voltage
>         $ cat pp_od_clk_voltage
>         OD_SCLK:
>         0:        200Mhz
>         1:       1400Mhz
>         OD_RANGE:
>         SCLK:     200MHz       1400MHz
>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 32 ++++++++++++++-----
>  1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index cf60f3992303..bbe7f101acbf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1421,18 +1421,34 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>                 return -EINVAL;
>         }
>
> -       if (size != 2) {
> -               pr_err("Input parameter number not correct\n");
> -               return -EINVAL;
> -       }
> -
>         if (type == PP_OD_EDIT_SCLK_VDDC_TABLE) {
> -               if (input[0] == 0)
> +               if (size != 2) {
> +                       pr_err("Input parameter number not correct\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (input[0] == 0) {
>                         smu10_set_hard_min_gfxclk_by_freq(hwmgr, input[1]);
> -               else if (input[0] == 1)
> +               } else if (input[0] == 1) {
>                         smu10_set_soft_max_gfxclk_by_freq(hwmgr, input[1]);
> -               else
> +               } else {
>                         return -EINVAL;
> +               }
> +       } else if (type == PP_OD_RESTORE_DEFAULT_TABLE) {
> +               if (size != 0) {
> +                       pr_err("Input parameter number not correct\n");
> +                       return -EINVAL;
> +               }
> +
> +               uint32_t min_freq, max_freq = 0;
> +
> +               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
> +               smu10_set_hard_min_gfxclk_by_freq(hwmgr, min_freq);
> +               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
> +               smu10_set_soft_max_gfxclk_by_freq(hwmgr, max_freq);
> +
> +       } else {
> +               return -EINVAL;
>         }
>
>         return 0;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
