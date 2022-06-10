Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84027C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 16:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7B610E98B;
	Fri, 10 Jun 2022 16:08:36 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E270C10FE72
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 16:08:35 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 y16-20020a9d5190000000b0060c1292a5b9so6991064otg.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z6fZXQVJVU0by0Bv1RFgjQxOyjoAA59Tw/JsTbSWsdA=;
 b=QMPdWE5ilPDnDLKhbF8mHbnfPnFVEmUtrMeaTQx6OMlP2CGqwzAitD+N83ftJDz4si
 zkmj1Fgl05seTSxgKQ41nMjSVP6psYMHHAhICX3gG3brfUcNX2zy72M/2hJXHUM08GXQ
 Fu1/rJQNsA4vFgizMQmdPf/8Vcba4EBM3aJYiBTMaHmUNBk34uwzOMbv2shH0PdMhuws
 QL6LMPpFW2BFnGosLQOc86PHAzull5ZCsfha0iRmrxusK3JvcdMplDl1BKqx5Zr38XNG
 3Nac/+PQCi7uLMOe1EZCtRIUacHeKwBgnYFErWuK6zJR0MuV8TcCAU77YPjcWwUK764P
 oxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z6fZXQVJVU0by0Bv1RFgjQxOyjoAA59Tw/JsTbSWsdA=;
 b=7fkpLefSYyFS2qT7udOhmUlIdtnznPrGiAGxdK8qzq73n0mqxrotwcHXJg/A0Pdui7
 IIcxo9M8RfKhenTrIrB9Xv79onKkktYyjIMmFTwHmg3E9iZDZOa98wiaqpB/HavqAlfm
 aTEdm/8xcQ3UuNuMLMiENSdBV1k/lcOKPWJdPiF9FD9GqTO7HkpXBziISvfsmKq0kCYr
 QFAYFNzyExnMmdTVchVS47hAmCnigEWHR1cPI3TVvNlRvnexVHN90MbcZtilIFKDDuoE
 HGbGzSlk7WDyJu1pGssBvG4Iv/bD8cO4zvYuRgjw7oC08nBQ9n6IMLG4bbELWPgPH90H
 Wn8A==
X-Gm-Message-State: AOAM530clI70fKla4cJiZRe9ia3lY30kbl9Gx2DwW6N49UoZqmpIrApo
 vcxSwuIWFm8ak/eujcSYVLBwm1T4yBg6ahNEpa8e4CaNUqw=
X-Google-Smtp-Source: ABdhPJxDvhmzVGmdyTmP59npRIfzWEBBZT0dHJgJqbVSrBDW2TEpsyJ52et45MAaIDgOQtRJUQwuOpOskeJ4N8gDYNE=
X-Received: by 2002:a9d:5f9c:0:b0:60b:f3e3:4658 with SMTP id
 g28-20020a9d5f9c000000b0060bf3e34658mr13531514oti.200.1654877315183; Fri, 10
 Jun 2022 09:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220610062539.3666611-1-evan.quan@amd.com>
 <20220610062539.3666611-2-evan.quan@amd.com>
In-Reply-To: <20220610062539.3666611-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jun 2022 12:08:24 -0400
Message-ID: <CADnq5_PB-kiVta5GsSXLL6=uWfz858X7JpNE9u=2a9Hjn-ibuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: enable MACO support for SMU 13.0.0
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
 Likun Gao <Likun.Gao@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 10, 2022 at 2:26 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Enable BAMACO reset support for SMU 13.0.0.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I67696671c216790a0b6d5b84f7d4b430d734ac3c
> --
> v1->v2:
>   - maximum code sharing around smu13.0.0 and smu13.0.7
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  3 +-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  3 ++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 52 +------------------
>  3 files changed, 7 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index fba0b87d01fb..f18f9605e586 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2271,7 +2271,8 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
>         if (state == SMU_BACO_STATE_ENTER) {
>                 ret = smu_cmn_send_smc_msg_with_param(smu,
>                                                       SMU_MSG_EnterBaco,
> -                                                     0,
> +                                                     smu_baco->maco_support ?
> +                                                     BACO_SEQ_BAMACO : BACO_SEQ_BACO,
>                                                       NULL);
>         } else {
>                 ret = smu_cmn_send_smc_msg(smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 495713e4ebd4..6fb2b072a730 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -325,6 +325,9 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
>             powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
>                 smu_baco->platform_support = true;

Not really related to this patch, but is
SMU_13_0_0_PP_PLATFORM_CAP_MACO really used to determine with the
platform supports BACO in general?  Is this right?  I don't see how we
would ever end up using plain BACO.

This patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>
> +       if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
> +               smu_baco->maco_support = true;
> +
>         table_context->thermal_controller_type =
>                 powerplay_table->thermal_controller_type;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 693bb6bda350..96ae5ff8e19e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1551,54 +1551,6 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>         return ret;
>  }
>
> -static int smu_v13_0_7_baco_set_state(struct smu_context *smu,
> -                            enum smu_baco_state state)
> -{
> -       struct smu_baco_context *smu_baco = &smu->smu_baco;
> -       struct amdgpu_device *adev = smu->adev;
> -       bool is_maco_support = smu_baco->maco_support;
> -       int ret;
> -
> -       if (smu_v13_0_baco_get_state(smu) == state)
> -               return 0;
> -
> -       if (state == SMU_BACO_STATE_ENTER) {
> -               ret = smu_cmn_send_smc_msg_with_param(smu,
> -                                                     SMU_MSG_EnterBaco,
> -                                                     (is_maco_support ? 2 : 0),
> -                                                     NULL);
> -       } else {
> -               ret = smu_cmn_send_smc_msg(smu,
> -                                          SMU_MSG_ExitBaco,
> -                                          NULL);
> -               if (ret)
> -                       return ret;
> -
> -               /* clear vbios scratch 6 and 7 for coming asic reinit */
> -               WREG32(adev->bios_scratch_reg_offset + 6, 0);
> -               WREG32(adev->bios_scratch_reg_offset + 7, 0);
> -       }
> -
> -       if (!ret)
> -               smu_baco->state = state;
> -
> -       return ret;
> -}
> -
> -static int smu_v13_0_7_baco_enter(struct smu_context *smu)
> -{
> -       int ret = 0;
> -
> -       ret = smu_v13_0_7_baco_set_state(smu,
> -                                      SMU_BACO_STATE_ENTER);
> -       if (ret)
> -               return ret;
> -
> -       msleep(10);
> -
> -       return ret;
> -}
> -
>  static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
>         .get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
>         .set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
> @@ -1653,8 +1605,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
>         .set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
>         .baco_is_support = smu_v13_0_baco_is_support,
>         .baco_get_state = smu_v13_0_baco_get_state,
> -       .baco_set_state = smu_v13_0_7_baco_set_state,
> -       .baco_enter = smu_v13_0_7_baco_enter,
> +       .baco_set_state = smu_v13_0_baco_set_state,
> +       .baco_enter = smu_v13_0_baco_enter,
>         .baco_exit = smu_v13_0_baco_exit,
>         .set_mp1_state = smu_cmn_set_mp1_state,
>  };
> --
> 2.29.0
>
