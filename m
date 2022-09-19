Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A682FC54EE9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 14:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90CE10E646;
	Mon, 19 Sep 2022 14:10:08 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD7110E646
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 14:10:03 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 t8-20020a9d5908000000b0063b41908168so19832973oth.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=V4Mhbd5TFJD0BOmK6tiQcMbAATJ9v2sWko1228r6KHw=;
 b=ZdYEdvb+cyS/7tseNA1PFRNrFhT+1XBAHpWIhF15vRYV5bPkso0GaJ/TuIdT8ucLFQ
 j9Vm+rWeDfWJEfiW/ny/szGOYe4900taLp3Sa0Ptj9nLXQwTBsWaGJedJ2nA7H5nCEay
 A1sxStY0kI8Tm7NWCkvdVlxkaGR9hTTvpWQeaf+CSYSJTWAHQcEKIJCeeWrpWfWzVG0v
 ehgkjDTGUFBfraLlMLiGLlkM1bG2hQfuSkT7J1Pd5hw6cI9P/IgEm6JG9YpAAN2lH0S0
 ZZYrlKPMnZosT1AzCtYrFD+xI6KJhXIDak9yDInV+5IDK4gdzrjzD8KiJZJN1xA2o+md
 RF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=V4Mhbd5TFJD0BOmK6tiQcMbAATJ9v2sWko1228r6KHw=;
 b=HPpTrRi5KGHSgE3rcgsP2y0s+F0TTqxAvsQQVK4zc0BciVIS1p4blyxNn5JgvIuiOp
 Axwo8JP3yLbpIur8b9b2GUlsdZk96VjUDZuBIWGRBks6cMt8H1FJJqSfGikvLSFMGE0v
 8H9+mwms37hKsL+pPCTt206AiSr3zQUwNgf9V6fGn/B8HaFLwMKuMgDn9ND3vAsF3l3Z
 nMmUMV/IHWnYi4KXUZZ5PTFDpLiOBUAz6PvqTiA9XWEQSjMU+AG2pe+8jDzpqXBwCAkn
 Fg43c3PTIo3Ot7BbmUOg3h0pYZteCkemwMs1U1vDne+fGq+AqmuVI/LICXBXJlBbZrjX
 UVhQ==
X-Gm-Message-State: ACrzQf1iRctk634bbDql5E3nlLriuY3h0rLTtBinrxth6lZ3XCmFqVRA
 A90C0HztyGyOBOs8bKUQljjid5PvROInEo2synQ=
X-Google-Smtp-Source: AMsMyM5sEvMlLX5Jq450tXDQBUgWDS/R5j2zhEtDvJn1Usi+rJLRM8AI4mVKbGFL04Vov7QwYtjkJ5pnr/fwETv6t1g=
X-Received: by 2002:a9d:450a:0:b0:655:f46f:2bed with SMTP id
 w10-20020a9d450a000000b00655f46f2bedmr7955529ote.123.1663596602712; Mon, 19
 Sep 2022 07:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220919020251.7048-1-evan.quan@amd.com>
 <20220919020251.7048-4-evan.quan@amd.com>
 <CADnq5_MUdrUQ503YOCY9j-ODRY_dYA8LpO1HfXxa-ynx9vdekQ@mail.gmail.com>
In-Reply-To: <CADnq5_MUdrUQ503YOCY9j-ODRY_dYA8LpO1HfXxa-ynx9vdekQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Sep 2022 10:09:51 -0400
Message-ID: <CADnq5_PXtyJAwotYf1zHeqF+J5EiWh1QvCHpSf26NgM07pT=dw@mail.gmail.com>
Subject: Re: [PATCH V2 4/7] drm/amd/pm: move SMU13.0.0 related pptable
 settings to smu_v13_0_0_ppt.c
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
Cc: Alexander.Deucher@amd.com, guchun.chen@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 19, 2022 at 9:48 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Sun, Sep 18, 2022 at 10:04 PM Evan Quan <evan.quan@amd.com> wrote:
> >
> > Separate those ASIC specific settings from common helpers.
> >
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > Change-Id: Ie3224b8719d48c6e6936b738df379959bd1df4ad
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  1 -
> >  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 16 +++++++++++++---
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index 610f9b68ef73..7adbdd3cc13b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1027,7 +1027,6 @@ static void smu_interrupt_work_fn(struct work_struct *work)
> >  static void smu_pptable_source_init(struct smu_context *smu)
> >  {
> >         switch (smu->adev->ip_versions[MP1_HWIP][0]) {
> > -       case IP_VERSION(13, 0, 0):
>
> Is this change intended?

Nevermind, I missed your response on the original thread.

Alex


>
> Alex
>
> >         case IP_VERSION(13, 0, 7):
> >                 smu->pptable_source = PPTABLE_SOURCE_PMFW;
> >                 smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index 1d454485e0d9..fd405e2420cd 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -377,9 +377,12 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
> >         struct amdgpu_device *adev = smu->adev;
> >         int ret = 0;
> >
> > -       ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
> > -                                               &smu_table->power_play_table,
> > -                                               &smu_table->power_play_table_size);
> > +       if (smu->pptable_source == PPTABLE_SOURCE_PMFW)
> > +               ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
> > +                                                       &smu_table->power_play_table,
> > +                                                       &smu_table->power_play_table_size);
> > +       else
> > +               ret = smu_v13_0_setup_pptable(smu);
> >         if (ret)
> >                 return ret;
> >
> > @@ -1753,6 +1756,12 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
> >         return ret;
> >  }
> >
> > +static void smu_v13_0_0_pptable_source_init(struct smu_context *smu)
> > +{
> > +       smu->pptable_source = PPTABLE_SOURCE_PMFW;
> > +       smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
> > +}
> > +
> >  static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
> >         .get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
> >         .set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
> > @@ -1822,6 +1831,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
> >         .mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
> >         .mode1_reset = smu_v13_0_mode1_reset,
> >         .set_mp1_state = smu_v13_0_0_set_mp1_state,
> > +       .pptable_source_init = smu_v13_0_0_pptable_source_init,
> >  };
> >
> >  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> > --
> > 2.34.1
> >
