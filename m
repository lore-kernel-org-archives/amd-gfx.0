Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E1C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 17:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F7364DA8
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 17:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F7364DA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D736E86F;
	Wed, 27 Jan 2021 17:48:50 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7772E6E871
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 17:48:48 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id a77so3064325oii.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nnb62f4fmtDgnbGuoFu18ttWPk/yAWtmo8aZiSWpKcE=;
 b=nM5vBOp52WQN9u9rlCKxnCzbLJBpqHN/nffIshQeiuECkKE5RmkdAFnup81s/Cvlog
 4aqFXT3XccrJ9bkcuUjR9FRewPaHGakE+1I1yQMI8WyyOUJiNogteJAsGTLHammC3Kki
 A+fcZ8fq6hPF+DZravPrA+C2yE6Oo7It9h+8Wz8s5tUBy/vWgmkFneE14rNWZSOLqXzq
 7sSWIPa867DQK+yrn/9RpRFRx958LlAGha490nL75BUp8LSN0DlBvJPmHwnpK0QNvfat
 1NYIsYl2tDYqX83Og3/QKaZy1eDcTUS8BMoLVJLfihgOZENHQidcHkcSQz4ESRNYCkDz
 fTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nnb62f4fmtDgnbGuoFu18ttWPk/yAWtmo8aZiSWpKcE=;
 b=fL1pHzeN0X7ENoNqPSPPMH+TOrB6yP2rSSqNzkgfcjmYX86se/boyHTfzLKW5hIolM
 L9Di7EE3CDGFZdgyk+ZqBtcQERabmwcuj8piTvE/6E6AyQFbAEb9pNakYYC42A1wldSr
 s2HQf+4M1LpXVFWzUrHdgeqJqW8pnG9b2BAXozvVsQC409RtXNqeofqwJVyvqi8NSCsx
 NdZGdQH7oPT2EotM4sUK+J4vML2KUmKFTDGVpKV0p1CCHzmvHF48xHmXyvBWVIO2YoLg
 uyehXocuW2wuqnq5QHsfU3mDUD200ShkN2WfESL3SaxPn+ttvu9JXqcErBJqnNHfZLpw
 Z9og==
X-Gm-Message-State: AOAM532oCm5/GJgt+P6KNTh8rN5BTMUPa35RZfvDRsHtvGjUSJPG7qJA
 VmUsiE/BIR6TrR5m+xPhdGcfy7H8T2y2tnkPpM8=
X-Google-Smtp-Source: ABdhPJzaLvCGTPKQRuO7knpMhDsLVS1Ce2tTlQq/COcJ3OTz4yNi7sbIvgM31LUGj956mDz5nkHKHV7VvW3vv2ePZGw=
X-Received: by 2002:aca:f5d1:: with SMTP id t200mr3850904oih.123.1611769727641; 
 Wed, 27 Jan 2021 09:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20210127014146.10902-1-kenneth.feng@amd.com>
 <CADnq5_PXPj6Fyzpe2wV_Bejx+JtihrbeatM605ATCuYNuzK-Vw@mail.gmail.com>
 <BYAPR12MB364028EC632E6071469468AD8EBB9@BYAPR12MB3640.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB364028EC632E6071469468AD8EBB9@BYAPR12MB3640.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Jan 2021 12:48:36 -0500
Message-ID: <CADnq5_PY7MaeHb1suBuzFoZ9PMN2SnKDJG7Gd6xBZPt-FxWODg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Enable gfx DCS feature
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 27, 2021 at 12:57 AM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
> Actually the FA DCS is dependent on the workload type.
> FA DCS is applied only when there's 3D fullscreen workload or VR workload.
> So we need to disable it if there's a request from the sysfs/user to set the workload type to 3D fullscreen or VR type because we don't have FA DCS so far.
> By removing this hunk is ok functionally, but the DCS will never kick in though the DCS is enabled. That might be a little bit confusing.
> Thanks.

For clarity, does the SMU act differently with regard to DCS when you
set different workloads via the workload interface or is this just
using the assumption that at some point we might dynamically adjust
the workload bits based on hints from userspace?

Alex


>
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, January 27, 2021 12:55 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Enable gfx DCS feature
>
> [CAUTION: External Email]
>
> On Tue, Jan 26, 2021 at 8:42 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
> >
> > Background:
> > Gfx Duty Cycle Scaling(DCS) is applied on the small power limit skus.
> > When the current/power/temperature exceeds the limit with the heavy
> > workload, the gfx core can be shut off and powered on back and forth.
> > The ON time and OFF time is determined by the firmware according to
> > the accumulated power credits.
> > This feature is different from gfxoff.Gfxoff is applied in the idle
> > case and DCS is applied in the case with heavey workload.There are two types of DCS:
> > Async DCS and Frame-aligned DCS.Frame-aligned DCS is applied on 3D
> > fullscreen and VR workload.
> > Since we only supports Async DCS now,disalbe DCS when the 3D
> > fullscreen or the VR workload type is chosen.
> >
> > Verification:
> > The power is lowerer or the perf/watt is increased in the throttling case.
> > To be simplified, the entry/exit counter can be observed from the firmware.
> >
> > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > ---
> >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12
> > ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 24f3c96a5e5e..436d94cbb166 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
> >                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
> >         }
> >
> > +       if (adev->asic_type == CHIP_NAVY_FLOUNDER || adev->asic_type == CHIP_DIMGREY_CAVEFISH)
> > +               *(uint64_t *)feature_mask |=
> > + FEATURE_MASK(FEATURE_GFX_DCS_BIT);
> > +
> >         if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
> >                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
> >                                         |
> > FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> > @@ -1437,6 +1440,15 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
> >         smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> >                                     1 << workload_type, NULL);
> >
> > +       /* have to disable dcs if it's the 3D fullscreen or VR workload type */
> > +       if (smu->adev->asic_type == CHIP_NAVY_FLOUNDER ||
> > +               smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
> > +               ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
> > +                       WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT || workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
>
> Since we don't support FA DCS yet, should we just drop this hunk for now?  I think the workload profile stuff should be independent of FA DCS.  Also so we want to add a ppfeaturemask flag to easily allow us to disable this at driver load time?
>
> Alex
>
>
> >         return ret;
> >  }
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cke
> > nneth.feng%40amd.com%7C2f961319cdd141723c1808d8c27fb554%7C3dd8961fe488
> > 4e608e11a82d994e183d%7C0%7C0%7C637473201048667755%7CUnknown%7CTWFpbGZs
> > b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > %7C1000&amp;sdata=2%2BC7%2FgINP5n9k2M6lXChHQj3scXU279dp6pR2SdRiq4%3D&a
> > mp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
