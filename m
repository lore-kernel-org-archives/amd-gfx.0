Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0423C04FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 20:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F85261244
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 20:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F85261244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFAB06F8E1;
	Fri, 21 May 2021 20:14:55 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F976F8E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 20:14:54 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id j75so20741820oih.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lb7Mxr14RNMevLzAgancYijo2mt3WI6dyR+GNkxHvuI=;
 b=coOQklXLz4mij68bbMaOG/sqOEDGHbJsIeWHULRzb/VDO0Nz3A0UjtuxbvU6nO0A8K
 NkCuQ8eMQI++Ludd94xWPVLDIuNjdYDQAoOLQXHy5TUxHOpmngJSxBjNyw2FDxaYeze8
 TxDh/HbRj5EmPgRGMDCqqJW6u1vQzbpJzpsSlU8XPfbpALrm9y9ZfMzyhV+GeUrgq1hi
 Kh6LJLNOTPTzaJyerpO3Lf9VDCALM9NVlH1+kxG9aBfmGJw5VXSIdT0e25MX0fPA4yxt
 lP9v3lXkDA6bjpdcIEg94Vtd66ASWf1Nk+MWHXPVjKeBoiEu4OsiYn4EoUC8FJFjZP7f
 6AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lb7Mxr14RNMevLzAgancYijo2mt3WI6dyR+GNkxHvuI=;
 b=CaWlrFSm6tW9hSiwYWOZOzclq3stibZq+br4DHcNGDbrH504OJBznDXCxxUQ3No8Tk
 c+4ILLxQtvAbMHl4VqVNrO+ERp86TRt2od41e1B8hRd05rct6iT7dNUmN329HHu8qR/x
 fgMdx+e2rQvdfSmnnMSFl8aYEuP5oZyU8XM5NTy+4wd9EKsQ8Fq3uuKHx0TM+4qAMjQc
 XRyhp0yLL9+ajX4XsZUEogVmusoenP3lucqbB5S9mYZUYjnzgVe9M96gYsQAMkajwyJ8
 WK43mDFLvpALcZ0oH16/bhQJMK4MYAsHFQeWxeZYYBkT+fxWJawVOcbRzzs8SOFf+hej
 ireQ==
X-Gm-Message-State: AOAM532gMMyrgeaMueGO1+KY6+nje4r83SNULSGb3RXQJrxFEuUO6w0n
 liXmraEkFVU2U/LBT7T8wSid/6htrdPPcM0wfKg=
X-Google-Smtp-Source: ABdhPJz/q8xPDKitLoDEvt88JayW0SJyLThby9baQ494EBrUttff/+5Y6EUNAlk/VBjjm9IFXqUQsAZcqYnxbZyew2k=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr3377481oie.120.1621628094138; 
 Fri, 21 May 2021 13:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210520142930.8369-1-Graham.Sider@amd.com>
 <20210520142930.8369-2-Graham.Sider@amd.com>
 <CADnq5_MnENbvZJTAr8nfmvENZoeZaWxpU=zaeGeUasgz5TfUFA@mail.gmail.com>
 <DM6PR12MB3067FD5B64C665F5E264F6EA8A299@DM6PR12MB3067.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3067FD5B64C665F5E264F6EA8A299@DM6PR12MB3067.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 May 2021 16:14:43 -0400
Message-ID: <CADnq5_O=LP9y_YNmvPC8om7KOf2eKyBr2P+CL1j4zAhBrRak1A@mail.gmail.com>
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

On Fri, May 21, 2021 at 1:39 PM Sider, Graham <Graham.Sider@amd.com> wrote:
>
> Hi Alex,
>
> Are you referring to bumping the gpu_metrics_vX_Y version number? Different ASICs are currently using different version numbers already, so I'm not sure how feasible this might be (e.g. arcturus ==  gpu_metrics_v1_1, navi1x == gpu_metrics_v1_3, vangogh == gpu_metrics_v2_1).
>
> Technically speaking no new fields have been added to any of the gpu_metrics versions, just a change in representation in the throttle_status field. Let me know your thoughts on this.
>

I don't know if we have any existing tools out there that parse this
data, but if so, they would interpret it incorrectly after this
change.  If we bump the version, at least the tools will know how to
handle it.

Alex


> Best,
> Graham
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, May 21, 2021 10:27 AM
> To: Sider, Graham <Graham.Sider@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
> Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
>
> [CAUTION: External Email]
>
> General comment on the patch series, do you want to bump the metrics table version since the meaning of the throttler status has changed?
>
> Alex
>
> On Thu, May 20, 2021 at 10:30 AM Graham Sider <Graham.Sider@amd.com> wrote:
> >
> > Perform dependent to independent throttle status translation for
> > arcturus.
> > ---
> >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 62
> > ++++++++++++++++---
> >  1 file changed, 53 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > index 1735a96dd307..7c01c0bf2073 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > @@ -540,6 +540,49 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
> >         return (abs(frequency1 - frequency2) <= EPSILON);  }
> >
> > +static uint32_t arcturus_get_indep_throttler_status(
> > +                                       unsigned long
> > +dep_throttler_status) {
> > +       unsigned long indep_throttler_status = 0;
> > +
> > +       __assign_bit(INDEP_THROTTLER_TEMP_EDGE_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_EDGE_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_HOTSPOT_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_HOTSPOT_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_MEM_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_MEM_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_GFX_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_VR_GFX_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_MEM_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_VR_MEM_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TDC_GFX_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TDC_GFX_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TDC_SOC_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TDC_SOC_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPT0_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPT0_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPT1_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPT1_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPT2_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPT2_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPT3_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPT3_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPM_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPM_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_FIT_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_FIT_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_VRHOT0_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_VRHOT0_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_VRHOT1_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_VRHOT1_BIT,
> > + &dep_throttler_status));
> > +
> > +       return (uint32_t)indep_throttler_status; }
> > +
> >  static int arcturus_get_smu_metrics_data(struct smu_context *smu,
> >                                          MetricsMember_t member,
> >                                          uint32_t *value) @@ -629,7
> > +672,7 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
> >                         SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >                 break;
> >         case METRICS_THROTTLER_STATUS:
> > -               *value = metrics->ThrottlerStatus;
> > +               *value =
> > + arcturus_get_indep_throttler_status(metrics->ThrottlerStatus);
> >                 break;
> >         case METRICS_CURR_FANSPEED:
> >                 *value = metrics->CurrFanSpeed; @@ -2213,13 +2256,13
> > @@ static const struct throttling_logging_label {
> >         uint32_t feature_mask;
> >         const char *label;
> >  } logging_label[] = {
> > -       {(1U << THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> > -       {(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
> > -       {(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> > -       {(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> > -       {(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> > -       {(1U << THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> > -       {(1U << THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> > +       {(1U << INDEP_THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> > +       {(1U << INDEP_THROTTLER_TEMP_MEM_BIT), "HBM"},
> > +       {(1U << INDEP_THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> > +       {(1U << INDEP_THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> > +       {(1U << INDEP_THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> > +       {(1U << INDEP_THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> > +       {(1U << INDEP_THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> >  };
> >  static void arcturus_log_thermal_throttling_event(struct smu_context
> > *smu)  { @@ -2314,7 +2357,8 @@ static ssize_t
> > arcturus_get_gpu_metrics(struct smu_context *smu,
> >         gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
> >         gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> > -       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +       gpu_metrics->throttle_status =
> > +
> > + arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >         gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CGr
> > aham.Sider%40amd.com%7Ca3ca9a6b0576479e545808d91c648f50%7C3dd8961fe488
> > 4e608e11a82d994e183d%7C0%7C0%7C637572040495495758%7CUnknown%7CTWFpbGZs
> > b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > %7C1000&amp;sdata=YxUx7BrsQKBauKE3fHpNrkWMAG4dBy11fV9xnJdMHns%3D&amp;r
> > eserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
