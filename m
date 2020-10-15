Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F16C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 01:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA2D22254
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 01:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmYm+9QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA2D22254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA5A6EC03;
	Thu, 15 Oct 2020 01:08:55 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B84A6EC03
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 01:08:54 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id y12so1183053wrp.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 18:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YaPjsPbj3YGDG3H0Yg4JkU987G2KMJPABu51nsYzrEQ=;
 b=dmYm+9QEzcHrlAyxJcT057AUc2bn2Alr83BkcRaJNmcJsDOsxxZiq64ywK6yjgMjJ/
 Y8cGVP1W4Bi6RPRmSYRCZ7CSf0UMqUIZXoYjF/ewj/IegGV9045/KEF2RIJJdIIDHxZ3
 CrmqhCc6otuWSrRagFR9mo/83xd1amn8A5G42MIHE9zzH7QrxrdkE4GyqCRd5smJ6bp1
 XKu9Pen69vAxVaGVA3TUrCVjm5PZZ+FvONpMc+olK+rR0avOkg7s6KF28tp8Quh3Gk6D
 tAWQgUq16i8Rky7ABu/ISez2qnoY7rmzlc0tnYU8eeacdI3hQ3JTbHK94FtVYDKKxLlL
 dVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YaPjsPbj3YGDG3H0Yg4JkU987G2KMJPABu51nsYzrEQ=;
 b=CZqZR27bRcnbhIC4I0EED8EY8p6UiyHpGJsIAm9GBChCsXNa8Zl/yc8ACoTutTjbug
 mqTGC+qTQ/O8o8J9IBVRY0a1FrBEA6Zuffj8J+xnJkA1CsJPUtj8S6VX6PJoAG+uRCNo
 8uSUy4sCLwrl343b+8RPgbn2WDzeB5V9gQUPcqdVZL3YbiOdilto+zyE++ED+tZO/b8G
 iGXqjsdcWOrd88KBsoBjmC21GfxUKisp9TNIDmCCKfpq7oEd5TV/7FE26LdJnVZWHnuC
 brWqm1XpT2BJvEiu6J3ZpOHVt29gB7vHiSNpucWsnwwWGZd32F5TDNGN4dQQV5D5ZOAK
 Smuw==
X-Gm-Message-State: AOAM532ws/0f9fBrDhRRc1zyreSHq7qh2w86PsWAb28MUrNluDapQZak
 hzLyFP6J5jW8IaqKr1UqnIYR2R1VubdOpNKWmRs=
X-Google-Smtp-Source: ABdhPJxAO3DFbmeO1bmlah2xC/jg4uuZ6V6TRJ8vPFJyIgKcXrpDW+jQekOe5Iu6gkhPy1x5VM+2lSrM0huomyBfRsY=
X-Received: by 2002:adf:f246:: with SMTP id b6mr1334118wrp.111.1602724133195; 
 Wed, 14 Oct 2020 18:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201014052023.7085-1-evan.quan@amd.com>
 <20201014052023.7085-2-evan.quan@amd.com>
 <CADnq5_MxB_N5kAW6AGUYvWRTkZGu9GGrHM4rocMz4gJeyO6i-Q@mail.gmail.com>
 <DM6PR12MB2619C69B7B08A698238F7DACE4020@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619C69B7B08A698238F7DACE4020@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2020 21:08:42 -0400
Message-ID: <CADnq5_No9bwLv-P8TjERH1L7+qB3D9UEb8MheH4dV+c510THig@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: populate Arcturus PCIE link state
To: "Quan, Evan" <Evan.Quan@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 14, 2020 at 9:05 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
>
> It was intended to align with other ASICs. The output for this on Arcturus is:
> 0: 8.0GT/s, x16 618Mhz *
> Is not that OK?

Nevermind, I missed the *.  I got mixed up comparing with the code for
other asics.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> BR
> Evan
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, October 14, 2020 9:18 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 2/2] drm/amd/pm: populate Arcturus PCIE link state
>
> On Wed, Oct 14, 2020 at 1:21 AM Evan Quan <evan.quan@amd.com> wrote:
> >
> > Populate current link speed, width and clock domain frequency.
> >
> > Change-Id: Ic342fbd8f5e2495d212eaa4b85b4e146838e0525
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c             |  3 ---
> >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 18
> > ++++++++++++++++++
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > index 46eea3f8f958..f87411cfa4da 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -2124,9 +2124,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
> >         } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
> >                 if (asic_type < CHIP_VEGA20)
> >                         *states = ATTR_STATE_UNSUPPORTED;
> > -       } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
> > -               if (asic_type == CHIP_ARCTURUS)
> > -                       *states = ATTR_STATE_UNSUPPORTED;
> >         } else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
> >                 *states = ATTR_STATE_UNSUPPORTED;
> >                 if ((is_support_sw_smu(adev) && adev->smu.od_enabled)
> > || diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > index f982b9090d7b..46d950757230 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > @@ -720,6 +720,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
> >         struct smu_11_0_dpm_table *single_dpm_table;
> >         struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> >         struct smu_11_0_dpm_context *dpm_context = NULL;
> > +       uint32_t gen_speed, lane_width;
> >
> >         if (amdgpu_ras_intr_triggered())
> >                 return snprintf(buf, PAGE_SIZE, "unavailable\n"); @@
> > -823,6 +824,23 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
> >                                 now) ? "*" : ""));
> >                 break;
> >
> > +       case SMU_PCIE:
> > +               gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
> > +               lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
> > +               size += sprintf(buf + size, "0: %s %s %dMhz *\n",
> > +                               (gen_speed == 0) ? "2.5GT/s," :
> > +                               (gen_speed == 1) ? "5.0GT/s," :
> > +                               (gen_speed == 2) ? "8.0GT/s," :
> > +                               (gen_speed == 3) ? "16.0GT/s," : "",
> > +                               (lane_width == 1) ? "x1" :
> > +                               (lane_width == 2) ? "x2" :
> > +                               (lane_width == 3) ? "x4" :
> > +                               (lane_width == 4) ? "x8" :
> > +                               (lane_width == 5) ? "x12" :
> > +                               (lane_width == 6) ? "x16" : "",
> > +                               smu->smu_table.boot_values.lclk /
> > + 100);
>
> We should put a * by the link speed for consistency with other asics.
>
> Alex
>
>
> > +               break;
> > +
> >         default:
> >                 break;
> >         }
> > --
> > 2.28.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> > an.quan%40amd.com%7C880ed84a1bc14d8df30108d87043a997%7C3dd8961fe4884e6
> > 08e11a82d994e183d%7C0%7C0%7C637382783197264100&amp;sdata=kz2KbU6Sn00k9
> > jjihiqBnQEkfgI3dFbApLnqLf1Dw98%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
