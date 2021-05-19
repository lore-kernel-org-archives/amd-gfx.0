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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB207C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF1661074
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF1661074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3824D6E153;
	Wed, 19 May 2021 02:14:29 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12DC6E153
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 02:14:28 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id w127so7914823oig.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 19:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fRAOgrPH2P25v5Muu5F3XJxaB4b0pgqBr4o/EA2EZ9U=;
 b=jHET6wtUq/vdWYWPYbH0UVzv0v5UjHkYdUkJ/6QViTYrsKYaUCKMUvP+CG+UsYQrj8
 x9pfoMK+I70Rgju41gLK1cWwW33/W6d/iK7UyS/ZcIJE0K8V1W1ziDhUbHxWsNDEJS1W
 4tuVUh6lsF/WPJqrLwKWZTMBmjgvisnO8Tqv9ITroAiwQcPaYHzQomaI4TAi8zI7KjoI
 bxDp7auGLxMxhxju0dQOTQB16T7xe4+MF+pYq/dptiEmVEtJNTMRdOt2yO25Cg3CJXwl
 wJnh0zVJBNptRjTW4cPkgemIfOtwXVg2cFQMvJvm7sQ/gHwTr8oMJFwmyDf7se6Xm+sO
 gM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fRAOgrPH2P25v5Muu5F3XJxaB4b0pgqBr4o/EA2EZ9U=;
 b=pbhlM0nSzbXm6iV8mW/wzXkHpSPVJ+UJQugbqpedRhlpjspY0CfbTeV4RCrCUHeovJ
 lVgG+SQau7468uFglnpu8eKuiwkpyMN3pZr4h7KPwyyES/S9jJ7r032M0EIcPSgqfvfw
 K7B+u71JtcQOaJDsHU2P6EsVz6QQswqTKJzubuqgv/kZP7OeRT4j5vJsOjvPvpBqsa8p
 PbFhBPY0qInxUiGNKPlHZVfeheBu31bi1oD0pKsfMOSIF5d060bMgEkb/z8OyBrpn158
 0yFsmUBd1NNsKImqjwPSB3Is94trUWsD5KjFJE9gBElOXtVvDVAjkFG+EyWnjyqfWjsX
 jy1Q==
X-Gm-Message-State: AOAM533eD85vWCpxjr4YyOc1z0Hf3wBNgyxUba9HKijwcHalFH73vDsm
 y261paRiKQkPdtqyhLWDku/kSriqF/NixH8OAIE=
X-Google-Smtp-Source: ABdhPJwaEIl10R3QitnFLElXW9vd5SvvOOqxG2ckeWDo9dxXYywk5y7ozPNdZWSv/h6tfG/o9NhhKVd/uIKbdqrIN84=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr5498548oie.5.1621390468222; 
 Tue, 18 May 2021 19:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210518020502.351803-1-evan.quan@amd.com>
 <BYAPR12MB364031C662ABE2B04ADE75758E2C9@BYAPR12MB3640.namprd12.prod.outlook.com>
 <CADnq5_ObXZajNNTGpp4ffR+aC-mvyXgOJzfPm-oz_K15eq+zjQ@mail.gmail.com>
 <CADnq5_N_U36ZbGvg7SVadn91F2VGEr8EqXw03CjnnjcyW-SgJw@mail.gmail.com>
In-Reply-To: <CADnq5_N_U36ZbGvg7SVadn91F2VGEr8EqXw03CjnnjcyW-SgJw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 May 2021 22:14:17 -0400
Message-ID: <CADnq5_NtT9tkodwjXycA2iiwMA3GU4-9b215R8Tg9W0O0UkBPA@mail.gmail.com>
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

On Tue, May 18, 2021 at 10:13 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Can also add:
> Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/1580

er,
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1580

>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Alex
>
> On Tue, May 18, 2021 at 10:12 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > Do we need a similar check in the vega powerplay code?
> >
> > Alex
> >
> >
> > On Mon, May 17, 2021 at 10:59 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
> > >
> > > [AMD Official Use Only]
> > >
> > > Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> > >
> > > -----Original Message-----
> > > From: Quan, Evan <Evan.Quan@amd.com>
> > > Sent: Tuesday, May 18, 2021 10:05 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> > > Subject: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
> > >
> > > No MGpuFanBoost setting for those ASICs which do not support it.
> > > Otherwise, it may breaks their fan control feature.
> > >
> > > Change-Id: Ifa9c87ac537a07937a0f0f6a670f21368eb29218
> > > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  9 +++++++++
> > >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
> > >  2 files changed, 19 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > index d2063b1e7936..f16c76038f13 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > @@ -2936,6 +2936,8 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
> > >
> > >  static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)  {
> > > +       struct smu_table_context *table_context = &smu->smu_table;
> > > +       PPTable_t *smc_pptable = table_context->driver_pptable;
> > >         struct amdgpu_device *adev = smu->adev;
> > >         uint32_t param = 0;
> > >
> > > @@ -2943,6 +2945,13 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
> > >         if (adev->asic_type == CHIP_NAVI12)
> > >                 return 0;
> > >
> > > +       /*
> > > +        * Skip the MGpuFanBoost setting for those ASICs
> > > +        * which do not support it
> > > +        */
> > > +       if (!smc_pptable->MGpuFanBoostLimitRpm)
> > > +               return 0;
> > > +
> > >         /* Workaround for WS SKU */
> > >         if (adev->pdev->device == 0x7312 &&
> > >             adev->pdev->revision == 0)
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > index 3c3a7f9233e0..159cd698323e 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > @@ -3201,6 +3201,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> > >
> > >  static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)  {
> > > +       struct smu_table_context *table_context = &smu->smu_table;
> > > +       PPTable_t *smc_pptable = table_context->driver_pptable;
> > > +
> > > +       /*
> > > +        * Skip the MGpuFanBoost setting for those ASICs
> > > +        * which do not support it
> > > +        */
> > > +       if (!smc_pptable->MGpuFanBoostLimitRpm)
> > > +               return 0;
> > > +
> > >         return smu_cmn_send_smc_msg_with_param(smu,
> > >                                                SMU_MSG_SetMGpuFanBoostLimitRpm,
> > >                                                0,
> > > --
> > > 2.29.0
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
