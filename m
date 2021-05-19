Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F054DC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B08761074
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B08761074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E9B6E0DA;
	Wed, 19 May 2021 02:13:58 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB006E0DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 02:13:57 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 i23-20020a9d68d70000b02902dc19ed4c15so10491571oto.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BSv6/DrAJZZ/KZe6xEZPVNDMRv/X3i9z7545KO3o1Mc=;
 b=bfJ7Cs31jpbFI0RCjYhiBFBiT5WK+MapQZDSoR3vwhcvQDn5t0wWFOE/U+LQfP98dY
 ODFUzfUm7DrrMeUMI7yoioai3ObDAjwmQuNaa4MwN8WcRPro2sJr1H6K6Bcp4i222teY
 iNmeb0mDkdrPUxuyTTCMMGi6qDe0EWXlrIVSEkskVyka1oCi/5pCskOaT3jGQ9xqDGkz
 YqRhCZ8YPM7bopBVixflPBhW/OrNR1CtSAy3RMhLYY/LzwicNR0f+fh2JINLD7FwbleQ
 nTnOMe5X2CldW/w6suj7AU9vqBNj4nBr/X6pKIFN7Yl4PhsTP/8a+sDlVhNkJSbfjNNl
 nJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BSv6/DrAJZZ/KZe6xEZPVNDMRv/X3i9z7545KO3o1Mc=;
 b=h7aZ4Cc8nviYrsxy+yOqGrWNEUIAEXM2Ij/eSB/RL7Z4SefTWy0SoC/9bVWPlTO3aL
 ksGCtptbDjfHHAcs7gAM683d1AWOC5xRMWJsVIIkMmsSC6WQ9g1Z4C6Ia8M2C7lkzxiZ
 dv6b3Med/zHmcMyt3+0+bWTlS5ZvmyEpb7UCq4iEp25j3FwllpmnB2n+cnqx0g1+pWsj
 2TNFeWaTTuZYivOnt8Un3s2c9eK32Vlj1zk4W9967Y/2SkTsDeMMcBJiLD0ugWOXuuQ8
 N3rRE3NPeROK+zCzWIoOpiceQ5IVMyQ8HJTzQTVm5CnthpQCIP/eoQmjBQJMqMHZQf1D
 kneA==
X-Gm-Message-State: AOAM530tO5bg6M1Z3zhTptWZ65GkMifxY3JApEbbR7J2GRgvkzv+fDO9
 Mja6Bmp9C7LzbzX3EzZ5L/Vp9Dt9AMT6SDTE/TI=
X-Google-Smtp-Source: ABdhPJwIe8JQfuqMvutv3lkgrhv9LzBVlam83K9JRzNLaGFI2/uMnKkB71QNoDhXbmzWJvsU00k5QbQs7EYOvEq2CHw=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr6704610otl.311.1621390436639; 
 Tue, 18 May 2021 19:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210518020502.351803-1-evan.quan@amd.com>
 <BYAPR12MB364031C662ABE2B04ADE75758E2C9@BYAPR12MB3640.namprd12.prod.outlook.com>
 <CADnq5_ObXZajNNTGpp4ffR+aC-mvyXgOJzfPm-oz_K15eq+zjQ@mail.gmail.com>
In-Reply-To: <CADnq5_ObXZajNNTGpp4ffR+aC-mvyXgOJzfPm-oz_K15eq+zjQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 May 2021 22:13:45 -0400
Message-ID: <CADnq5_N_U36ZbGvg7SVadn91F2VGEr8EqXw03CjnnjcyW-SgJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can also add:
Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/1580

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

On Tue, May 18, 2021 at 10:12 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Do we need a similar check in the vega powerplay code?
>
> Alex
>
>
> On Mon, May 17, 2021 at 10:59 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
> >
> > [AMD Official Use Only]
> >
> > Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> >
> > -----Original Message-----
> > From: Quan, Evan <Evan.Quan@amd.com>
> > Sent: Tuesday, May 18, 2021 10:05 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> > Subject: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
> >
> > No MGpuFanBoost setting for those ASICs which do not support it.
> > Otherwise, it may breaks their fan control feature.
> >
> > Change-Id: Ifa9c87ac537a07937a0f0f6a670f21368eb29218
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  9 +++++++++
> >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index d2063b1e7936..f16c76038f13 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -2936,6 +2936,8 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
> >
> >  static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)  {
> > +       struct smu_table_context *table_context = &smu->smu_table;
> > +       PPTable_t *smc_pptable = table_context->driver_pptable;
> >         struct amdgpu_device *adev = smu->adev;
> >         uint32_t param = 0;
> >
> > @@ -2943,6 +2945,13 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
> >         if (adev->asic_type == CHIP_NAVI12)
> >                 return 0;
> >
> > +       /*
> > +        * Skip the MGpuFanBoost setting for those ASICs
> > +        * which do not support it
> > +        */
> > +       if (!smc_pptable->MGpuFanBoostLimitRpm)
> > +               return 0;
> > +
> >         /* Workaround for WS SKU */
> >         if (adev->pdev->device == 0x7312 &&
> >             adev->pdev->revision == 0)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 3c3a7f9233e0..159cd698323e 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -3201,6 +3201,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >
> >  static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)  {
> > +       struct smu_table_context *table_context = &smu->smu_table;
> > +       PPTable_t *smc_pptable = table_context->driver_pptable;
> > +
> > +       /*
> > +        * Skip the MGpuFanBoost setting for those ASICs
> > +        * which do not support it
> > +        */
> > +       if (!smc_pptable->MGpuFanBoostLimitRpm)
> > +               return 0;
> > +
> >         return smu_cmn_send_smc_msg_with_param(smu,
> >                                                SMU_MSG_SetMGpuFanBoostLimitRpm,
> >                                                0,
> > --
> > 2.29.0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
