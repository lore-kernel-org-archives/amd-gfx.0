Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F690C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 15:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71FA2063A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 15:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aREYWiW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71FA2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDF06E0ED;
	Fri, 21 Aug 2020 15:36:11 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54E76E0ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 15:36:10 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id 9so2315125wmj.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iTjtchnrap1M3kJ10eFYGLGiqsBR7fllcBuM334qvIc=;
 b=aREYWiW4t/1sus0npeHc0xfnWJsmCx+EtsaWfhuCiz49u8jIzhPWARIf3WHPPrOs+k
 cuOfLzC+XVhqlM75bwuw81ZnRlL5/K5A5Q7zEM+yeo+IEZABQxJYYY+C0N766Lg6aGve
 hr4+ulWek80y4FXpZifE0dfuaRgJKDO4gIIzMSgof7DOeWYKS7BhR1Pg10PxJ1lhaomU
 ySyyQNnwolaPNi7Iq/5vO2DCFcPrUYrSXuRA8j6taijSroIx73mj7xl8XsdYmin5Zea7
 qJE4P4bzp57OdYWa1f6aML6rLIQR8RQsRaySkuIV9dhHSBS1hMsZacExgW6JrGhXcvvy
 XONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iTjtchnrap1M3kJ10eFYGLGiqsBR7fllcBuM334qvIc=;
 b=DAgK9SToVUcDKzdd/aJ2XkUiwy4XceRgENp6/ZBp1Ov7QSXvUEoxORtDvg0JYTdULH
 CJERZYqOmGG4Kkjxo6aca1cdwR9Qd8d3wkgZ0SVpO+e2oSUjSCo/qoDQxIP+9/ILc484
 EAvw4VtJeVd8Ntsq7I1nYszj8pUFZ5GsDwbs7QmDD+dOYHFT1yOSdp5O1AraaCYP5v+R
 DczJIlKQvUFXgTUgsPn90vKeyjz1WGap+ELPKnkcS8R+FALm5E3YDXoKQNhACB708q/5
 fugjrGsddOj7zRJgHu0Dc9FKscMuyabjjNPi6YEp6zGVTYjdopa2wRDRX/h7dgtW3rdV
 GTTQ==
X-Gm-Message-State: AOAM531L7NmUpwINFSAMtM/zvdwxI1bdsqJJ1mEYvzAKj4GMyDvMGcQk
 +Fmns54B756twrwoxf8DTB2nhuPFV1YZPTfPudg=
X-Google-Smtp-Source: ABdhPJx3VwmpeSvnLbxG63bHnJSzaYzEViyKYwtrsvRWrNRN8ONJjX8HG8rMX7dCQ/Ivf2UsNnUDpE2Oms2XqorNto8=
X-Received: by 2002:a1c:bc85:: with SMTP id m127mr2589621wmf.70.1598024169317; 
 Fri, 21 Aug 2020 08:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200821153145.498408-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200821153145.498408-1-nicholas.kazlauskas@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Aug 2020 11:35:57 -0400
Message-ID: <CADnq5_OqvOKyRKpvLzXpgEN42DqNdwcothGA44+4E_ReFibqdA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Fix hardmins not being sent to SMU for
 RV
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
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
Cc: Hersen Wu <hersenxs.wu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 21, 2020 at 11:31 AM Nicholas Kazlauskas
<nicholas.kazlauskas@amd.com> wrote:
>
> [Why]
> DC uses these to raise the voltage as needed for higher dispclk/dppclk
> and to ensure that we have enough bandwidth to drive the displays.
>
> There's a bug preventing these from actuially sending messages since
> it's checking the actual clock (which is 0) instead of the incoming
> clock (which shouldn't be 0) when deciding to send the hardmin.
>
> [How]
> Check the clocks != 0 instead of the actual clocks.
>
> Fixes: 9ed9203c3ee7 ("drm/amd/powerplay: rv dal-pplib interface refactor powerplay part")
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index c9cfe90a2947..9ee8cf8267c8 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -204,8 +204,7 @@ static int smu10_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32_t clo
>  {
>         struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
>
> -       if (smu10_data->need_min_deep_sleep_dcefclk &&
> -               smu10_data->deep_sleep_dcefclk != clock) {
> +       if (clock && smu10_data->deep_sleep_dcefclk != clock) {
>                 smu10_data->deep_sleep_dcefclk = clock;
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                         PPSMC_MSG_SetMinDeepSleepDcefclk,
> @@ -219,8 +218,7 @@ static int smu10_set_hard_min_dcefclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t c
>  {
>         struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
>
> -       if (smu10_data->dcf_actual_hard_min_freq &&
> -               smu10_data->dcf_actual_hard_min_freq != clock) {
> +       if (clock && smu10_data->dcf_actual_hard_min_freq != clock) {
>                 smu10_data->dcf_actual_hard_min_freq = clock;
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                         PPSMC_MSG_SetHardMinDcefclkByFreq,
> @@ -234,8 +232,7 @@ static int smu10_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t cloc
>  {
>         struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
>
> -       if (smu10_data->f_actual_hard_min_freq &&
> -               smu10_data->f_actual_hard_min_freq != clock) {
> +       if (clock && smu10_data->f_actual_hard_min_freq != clock) {
>                 smu10_data->f_actual_hard_min_freq = clock;
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                         PPSMC_MSG_SetHardMinFclkByFreq,
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
