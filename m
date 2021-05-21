Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB8C4707E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEAA613EA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEAA613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F39A6F925;
	Fri, 21 May 2021 21:49:48 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9134F6F925
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 21:49:46 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 n32-20020a9d1ea30000b02902a53d6ad4bdso19345953otn.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3RTR8BmdEsfvCoMnWmgsrgtG+oS//NSt8SDYhZ/zruI=;
 b=j2FwQwJH24dI8ow/acw+kxJkk9G9MF7D5TAGpYEdAJFWzUMuMfynsRXdJxveELzfX6
 dKFVU4N76tG7OLBIazrdG84UTl1vmh6rRs5P9yrJA4drIlfGtxiK3doQukHmpfx2gmjh
 Sp9YCsmFmQjPV5rsmrfgaUGVkSBP9uHuBJI3chTxGrT1d3mgvqNXYJcuCFwBxl4RTiXZ
 sHM5oGxBxrm3esRlhTC4Va4mBF92X/P1MJpLJqvSbu7u11b4dSuVE9Jlc5YaXIB2uvXF
 8jJV5ibTJv23rYRYoc5CtkAic8ILpggSIWGoJaB9Z71jp18ud0dOpjLH6SdJyXaQhj/D
 GxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3RTR8BmdEsfvCoMnWmgsrgtG+oS//NSt8SDYhZ/zruI=;
 b=kga0r2ecAIRoUOMygIEja9Mw8oSlwrTgeMfw4nzZMBtxEyjgJrY1vdUm43I4eHQvO4
 xeWL8QoOnX9tIPgg5/OVVpwS4P6LwPvFyiHX/gW3ThxQUqAFz+QF/ve4N59Vn6LhYVdy
 iwCXS/KqQdJudBNMd/pglQ5SYMxJa7WH9szUa+r0/S+6WTHF+ru78JGfTra+XiNm07XA
 4jev/ZNOKJAawYlPw4sJnFXFr6TIw1hU+qs1BSIZNE0HYphVZcd0y3sXFb9uQa/q9OqZ
 CUsamF7IB4Cid6s6CvC9xbPIL5sTWqY2LHREnjWBbgTkrdYYZWWi4GlVG3SvNO22pfYG
 rlCQ==
X-Gm-Message-State: AOAM530uqftbOtVwQXGMRH/AMhnPNkGRxYi4ccLRVdr5CN7I0ecwT95n
 g8PjsMauioz/eyzOdcopzb8ZLUfQ3ZnCXEh4C3wLH2ka
X-Google-Smtp-Source: ABdhPJy8e38L8/hCBaKouH+KC9AbIIr+hu2xmoz1jGXLPqWKpwiGh1xGpM49ru2CLsbKMVj18PC1a7I+PgSeiJ8ENpU=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr10214072otl.132.1621633785941; 
 Fri, 21 May 2021 14:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210520142930.8369-1-Graham.Sider@amd.com>
 <20210520142930.8369-2-Graham.Sider@amd.com>
 <CADnq5_MnENbvZJTAr8nfmvENZoeZaWxpU=zaeGeUasgz5TfUFA@mail.gmail.com>
 <DM6PR12MB3067FD5B64C665F5E264F6EA8A299@DM6PR12MB3067.namprd12.prod.outlook.com>
 <CADnq5_O=LP9y_YNmvPC8om7KOf2eKyBr2P+CL1j4zAhBrRak1A@mail.gmail.com>
 <DM6PR12MB3067E3CC583A472F14DE7A1A8A299@DM6PR12MB3067.namprd12.prod.outlook.com>
 <CADnq5_O257rQg7PW5NiRCdYrmbtzRnxco_FQiaX8sNHO=RSqgg@mail.gmail.com>
In-Reply-To: <CADnq5_O257rQg7PW5NiRCdYrmbtzRnxco_FQiaX8sNHO=RSqgg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 May 2021 17:49:34 -0400
Message-ID: <CADnq5_N1Wh2RNJtdQ200jsbeaeqgfMM+5rPcWp-sWWL2f_6Rmw@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
To: "Sider, Graham" <Graham.Sider@amd.com>
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Sakhnovitch,
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 21, 2021 at 5:47 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, May 21, 2021 at 5:32 PM Sider, Graham <Graham.Sider@amd.com> wrote:
> >
> > Would this be referring to tools that may parse /sys/class/.../device/gpu_metrics or the actual gpu_metrics_vX_Y structs? For the latter, if there are tools that parse dependent on version vX_Y, I agree that we would not want to break those.
> >
> > Since most ASICs are using different version currently, we would have to create a duplicate struct for each gpu_metrics version currently being used, unless I'm misunderstanding. I'm not sure if this is what you had in mind - let me know.
> >
>
> Just update them all to the latest version.  The newer ones are just
> supersets of the previous versions.  I think a newer revision just
> went in in the last day or two for some additional new data, you can
> probably just piggy back on that since the code is not upstream yet.

Another option would be to leave the current throttle status as is,
and add a new one that provides the standardized format.  Not sure if
there is much value in having both though.  That said, we could
increase the size of the new one to 64 bits to accommodate future
throttle status bits.

Alex

>
> Alex
>
>
> > Best,
> > Graham
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, May 21, 2021 4:15 PM
> > To: Sider, Graham <Graham.Sider@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
> > Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
> >
> > [CAUTION: External Email]
> >
> > On Fri, May 21, 2021 at 1:39 PM Sider, Graham <Graham.Sider@amd.com> wrote:
> > >
> > > Hi Alex,
> > >
> > > Are you referring to bumping the gpu_metrics_vX_Y version number? Different ASICs are currently using different version numbers already, so I'm not sure how feasible this might be (e.g. arcturus ==  gpu_metrics_v1_1, navi1x == gpu_metrics_v1_3, vangogh == gpu_metrics_v2_1).
> > >
> > > Technically speaking no new fields have been added to any of the gpu_metrics versions, just a change in representation in the throttle_status field. Let me know your thoughts on this.
> > >
> >
> > I don't know if we have any existing tools out there that parse this data, but if so, they would interpret it incorrectly after this change.  If we bump the version, at least the tools will know how to handle it.
> >
> > Alex
> >
> >
> > > Best,
> > > Graham
> > >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Friday, May 21, 2021 10:27 AM
> > > To: Sider, Graham <Graham.Sider@amd.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan,
> > > Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen)
> > > <Elena.Sakhnovitch@amd.com>
> > > Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler
> > > translation
> > >
> > > [CAUTION: External Email]
> > >
> > > General comment on the patch series, do you want to bump the metrics table version since the meaning of the throttler status has changed?
> > >
> > > Alex
> > >
> > > On Thu, May 20, 2021 at 10:30 AM Graham Sider <Graham.Sider@amd.com> wrote:
> > > >
> > > > Perform dependent to independent throttle status translation for
> > > > arcturus.
> > > > ---
> > > >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 62
> > > > ++++++++++++++++---
> > > >  1 file changed, 53 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > > index 1735a96dd307..7c01c0bf2073 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > > @@ -540,6 +540,49 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
> > > >         return (abs(frequency1 - frequency2) <= EPSILON);  }
> > > >
> > > > +static uint32_t arcturus_get_indep_throttler_status(
> > > > +                                       unsigned long
> > > > +dep_throttler_status) {
> > > > +       unsigned long indep_throttler_status = 0;
> > > > +
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_EDGE_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_EDGE_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_HOTSPOT_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_HOTSPOT_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_MEM_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_MEM_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_GFX_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_VR_GFX_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_MEM_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_VR_MEM_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TDC_GFX_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TDC_GFX_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TDC_SOC_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TDC_SOC_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPT0_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPT0_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPT1_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPT1_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPT2_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPT2_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPT3_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPT3_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPM_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPM_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_FIT_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_FIT_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_VRHOT0_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_VRHOT0_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_VRHOT1_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_VRHOT1_BIT,
> > > > + &dep_throttler_status));
> > > > +
> > > > +       return (uint32_t)indep_throttler_status; }
> > > > +
> > > >  static int arcturus_get_smu_metrics_data(struct smu_context *smu,
> > > >                                          MetricsMember_t member,
> > > >                                          uint32_t *value) @@ -629,7
> > > > +672,7 @@ static int arcturus_get_smu_metrics_data(struct
> > > > +smu_context *smu,
> > > >                         SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> > > >                 break;
> > > >         case METRICS_THROTTLER_STATUS:
> > > > -               *value = metrics->ThrottlerStatus;
> > > > +               *value =
> > > > + arcturus_get_indep_throttler_status(metrics->ThrottlerStatus);
> > > >                 break;
> > > >         case METRICS_CURR_FANSPEED:
> > > >                 *value = metrics->CurrFanSpeed; @@ -2213,13 +2256,13
> > > > @@ static const struct throttling_logging_label {
> > > >         uint32_t feature_mask;
> > > >         const char *label;
> > > >  } logging_label[] = {
> > > > -       {(1U << THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> > > > -       {(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
> > > > -       {(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> > > > -       {(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> > > > -       {(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> > > > -       {(1U << THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> > > > -       {(1U << THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_MEM_BIT), "HBM"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> > > > +       {(1U << INDEP_THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> > > > +       {(1U << INDEP_THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> > > >  };
> > > >  static void arcturus_log_thermal_throttling_event(struct
> > > > smu_context
> > > > *smu)  { @@ -2314,7 +2357,8 @@ static ssize_t
> > > > arcturus_get_gpu_metrics(struct smu_context *smu,
> > > >         gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
> > > >         gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> > > >
> > > > -       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > > > +       gpu_metrics->throttle_status =
> > > > +
> > > > + arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
> > > >
> > > >         gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> > > >
> > > > --
> > > > 2.17.1
> > > >
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > > > st
> > > > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7C
> > > > Gr
> > > > aham.Sider%40amd.com%7Ca3ca9a6b0576479e545808d91c648f50%7C3dd8961fe4
> > > > 88
> > > > 4e608e11a82d994e183d%7C0%7C0%7C637572040495495758%7CUnknown%7CTWFpbG
> > > > Zs
> > > > b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > > > 3D
> > > > %7C1000&amp;sdata=YxUx7BrsQKBauKE3fHpNrkWMAG4dBy11fV9xnJdMHns%3D&amp
> > > > ;r
> > > > eserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
