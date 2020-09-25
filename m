Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A58C4727F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 21:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D751D2371F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHYOACMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D751D2371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A22766ED58;
	Fri, 25 Sep 2020 21:09:24 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3F16ED53
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 21:09:23 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m6so5359715wrn.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KrRg67jgaRBnM7G1xqHVcvsvAIDYniSqALWfwSTsy4k=;
 b=tHYOACMRM2n/nWbwabJTVmgCXQxYOeEV+3efjqoP3KWrgN1vjOSWryassTZju7E9L+
 bIrm4rFnJ1eSrXemS03vIdEFKJFLvDLb6D2b+/HLfb4asybgrq3kCRraksF6kjHYC4Df
 +0znZfVnSRAuYN91xRsiAOXITEQbjG1FJum5Ct7/JF1Ywjy1AyuEcd4Jm58UamUqZM5v
 +obWWWjrFU+uP2t2xOY+DaSXRQAMP928bNMnYcLG8ZRWOS0CRt2bVIn7tLgBAmisBd0o
 WVMs6a9glTmdXa1fEkCeYpPpSNWxNYMLSGE0ytu1u6DYwkjoBzrelYLmxn2veSGokaux
 Yz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KrRg67jgaRBnM7G1xqHVcvsvAIDYniSqALWfwSTsy4k=;
 b=e53EnMahd0VcNBrOVX3ElCEi66H+H2qpHvAXb7qPkBF+dtQLu+nl4mxWJ6im0BcvAV
 uQl+328j+mwGNlSSjrbE1Uj6DBsjhnb3GNIQ/oUNFwfeZz2CWbZgvLJJOs1AQMJfqYVq
 BbGNWCfd2lAZAPt/9Nfs8wdqzyzzhLYI4oDe1teVFSOL0iicE1gSKc/tP4V8S/qAIyaO
 s0gVie+dpWiwXCHE+diI7h3TGWN0+J8cDDsuITyMDqQhGnL8YsduqqGsVbXX4oBsSYtR
 HHTKum1vE6VIQAOTE6kJ03U8ILjxVR9+u4+tcGm8P374UoRJ42xyA3mIe2St46qgE7Lp
 xcSg==
X-Gm-Message-State: AOAM532mozVrSojQP38OOMv811bsjpXgO4/jAoZ/s9Zw8Sef9Br0g0Pw
 S1UBZMzKWf0oYGZdpZ84LPfLRG2bHPwx90Dh6zI=
X-Google-Smtp-Source: ABdhPJy1pw0D7+zrJFcNjlI4wVzut0Kby1aNA2XA9oh9I/0TNmlg7rZbBZsDDwtNYNAfRUbgOpnfFRA4W5acTVt8NPw=
X-Received: by 2002:adf:f290:: with SMTP id k16mr6840586wro.124.1601068161882; 
 Fri, 25 Sep 2020 14:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200924101012.22845-1-evan.quan@amd.com>
 <CADnq5_Nw6mdj38FVqg2Y67_eN04YSm1mSsS04RC09v7BHWNiWA@mail.gmail.com>
 <DM6PR12MB2619DA9B85A535D12D63E915E4360@DM6PR12MB2619.namprd12.prod.outlook.com>
 <d2c11c62-be7b-fe46-e51b-664bb39e210e@gmail.com>
In-Reply-To: <d2c11c62-be7b-fe46-e51b-664bb39e210e@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Sep 2020 17:09:10 -0400
Message-ID: <CADnq5_MtWWUTPSYHFjQ+yT_Zg0dX9_ad7ggrDCfaMfjLzqbdug@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K
 monitors
To: Matt Coffin <mcoffin13@gmail.com>
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
 Evan" <Evan.Quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 25, 2020 at 5:05 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> Sorry to bother you guys, but trying to learn about some of these
> things, and I'm tracking the issue this relates to pretty closely on GitLab.
>
> What does DAL stand for in this context?

DAL is the name of the display team within AMD.

Alex

>
> Thanks in advance for the help,
> Matt
>
> On 9/24/20 9:38 PM, Quan, Evan wrote:
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > That(postpone SOCCLK/UCLK enablement) will be revised and added back after confirmed with DAL team.
> > For now, we just revert it to get around the screen flicker issue introduced.
> >
> > BR
> > Evan
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, September 24, 2020 9:01 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K monitors
> >
> > On Thu, Sep 24, 2020 at 6:10 AM Evan Quan <evan.quan@amd.com> wrote:
> >>
> >> Revert the guilty change introduced by the commit below:
> >> drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL
> >> initialization(V2)
> >>
> >> Change-Id: I0cab619ffdf0f83b14ba5d2907e1b9c02a984e2f
> >> Signed-off-by: Evan Quan <evan.quan@amd.com>
> >
> > Won't this effectively disable the potential fix for multiple monitors at boot time?
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> >> ---
> >>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 ++++++-------------
> >>  1 file changed, 12 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >> index 1695b36dc23c..be44cb941e73 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >> @@ -316,6 +316,18 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
> >>         if (smu->dc_controlled_by_gpio)
> >>                 *(uint64_t *)feature_mask |=
> >> FEATURE_MASK(FEATURE_ACDC_BIT);
> >>
> >> +       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
> >> +               *(uint64_t *)feature_mask |=
> >> + FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
> >> +
> >> +       /* DPM UCLK enablement should be skipped for navi10 A0 secure board */
> >> +       if (!(is_asic_secure(smu) &&
> >> +            (adev->asic_type == CHIP_NAVI10) &&
> >> +            (adev->rev_id == 0)) &&
> >> +           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
> >> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
> >> +                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> >> +                               |
> >> + FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
> >> +
> >>         /* DS SOCCLK enablement should be skipped for navi10 A0 secure board */
> >>         if (is_asic_secure(smu) &&
> >>             (adev->asic_type == CHIP_NAVI10) && @@ -2629,43 +2641,12
> >> @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
> >>
> >>  static int navi10_post_smu_init(struct smu_context *smu)  {
> >> -       struct smu_feature *feature = &smu->smu_feature;
> >>         struct amdgpu_device *adev = smu->adev;
> >> -       uint64_t feature_mask = 0;
> >>         int ret = 0;
> >>
> >>         if (amdgpu_sriov_vf(adev))
> >>                 return 0;
> >>
> >> -       /* For Naiv1x, enable these features only after DAL initialization */
> >> -       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
> >> -               feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
> >> -
> >> -       /* DPM UCLK enablement should be skipped for navi10 A0 secure board */
> >> -       if (!(is_asic_secure(smu) &&
> >> -            (adev->asic_type == CHIP_NAVI10) &&
> >> -            (adev->rev_id == 0)) &&
> >> -           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
> >> -               feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
> >> -                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> >> -                               | FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
> >> -
> >> -       if (!feature_mask)
> >> -               return 0;
> >> -
> >> -       bitmap_or(feature->allowed,
> >> -                 feature->allowed,
> >> -                 (unsigned long *)(&feature_mask),
> >> -                 SMU_FEATURE_MAX);
> >> -
> >> -       ret = smu_cmn_feature_update_enable_state(smu,
> >> -                                                 feature_mask,
> >> -                                                 true);
> >> -       if (ret) {
> >> -               dev_err(adev->dev, "Failed to post uclk/socclk dpm enablement!\n");
> >> -               return ret;
> >> -       }
> >> -
> >>         ret = navi10_run_umc_cdr_workaround(smu);
> >>         if (ret) {
> >>                 dev_err(adev->dev, "Failed to apply umc cdr
> >> workaround!\n");
> >> --
> >> 2.28.0
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> >> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> >> an.quan%40amd.com%7C3899143b7990458f882c08d86089df67%7C3dd8961fe4884e6
> >> 08e11a82d994e183d%7C0%7C0%7C637365492561293539&amp;sdata=J%2FM6YSLX6d%
> >> 2BMO%2B%2FWzdKAW7JlVZM%2FMFRDpTfi6UHkozk%3D&amp;reserved=0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
