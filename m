Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649BDC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 02:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F7260F01
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 02:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21F7260F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4046E7F5;
	Thu, 29 Jul 2021 02:24:33 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A136E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 02:24:32 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 68-20020a9d0f4a0000b02904b1f1d7c5f4so4244950ott.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 19:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SFZbz4wE9dQn/Wds/3uwtXHaJNVzxtWiubx3+ynIZMw=;
 b=VUEFvuxHa1Ly2g78aGKLG2iy3D1uy7dB+BhKLBRmVtG2FD6lLDUQs4N4iiCFOWW7ZA
 5K5jdsgTybG4w7YWoY563cvlM6C/yfGof6rwqhAgbHpDot1sd4hggJhMQP1Bv1mzFJF7
 68PJW/oOBUNecABQkPOjYi8jcDlefBI7xQs1Nh7KfWmlL9VUBSfSOAf7aqIej2EE7zyt
 IO7LJL1rKs1SHbRLbbru/caJ8izibg0KFJbTE4MGSuqdIYiXgv4CYJBwAR1HEeOSOrsz
 xVP3Zv/bBwMFnBbM20+Vq05UIX7QVyKV8YHY4yqCPKSOFH7L57hs//BZ9vRhktq3ycaD
 QiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SFZbz4wE9dQn/Wds/3uwtXHaJNVzxtWiubx3+ynIZMw=;
 b=F6L442Zjr7gp70WkES3myadNS4u9AjT2lK54EAvj7Elh+xFSwZRXazUfVFXjn7JOiM
 manRSmNFT60tv2fFStK9UpOGKoH/yPHzok5w8CTMasgmXnvTgU/S8ZzWdDKqDb9ZR3e2
 /gX8s7P7XqZRYy1YfGd1iYRCH3oPMiI+PhrRpMcCLorN+6ujmWuB5xS3B4npBT7EF3lA
 1GXQyITF2EoZqaFhyj4YjM+BgaleuoRdeZ5Yc8ZtjSoI1OwCgsZ1jEcQ3O9dobd+6OMX
 LXgWafy5ayL5XLL67Z+EkQIag8bdFdDei+eg7rXM7qL3tUyBfrZ5zrkJS8qbiu+kvLIF
 Oo9w==
X-Gm-Message-State: AOAM533H+xzPIndDidB6wJT1BL0ULq5zLny7wv+iOpGeGjs15PKAQEhx
 3oNYMX14FHWQCvbOwNANb3Mr3I6QXXQ56kXWfOE=
X-Google-Smtp-Source: ABdhPJzFI16v5rUe6j8God5gJrDHzNTCvA5k6NQsfGN1FmTfkP+buEvW87iWYnZun478RtGMeLyfj5StT+y3W/QumQA=
X-Received: by 2002:a9d:2072:: with SMTP id n105mr2045457ota.132.1627525471799; 
 Wed, 28 Jul 2021 19:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210728061018.2512047-1-yifan1.zhang@amd.com>
 <CADnq5_Oc-TY9e9=wEnhY7mgV8gBpxM=qPSwomW4ceQ-ondngGw@mail.gmail.com>
 <BYAPR12MB3416560A44B08B69871F64FFC1EB9@BYAPR12MB3416.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3416560A44B08B69871F64FFC1EB9@BYAPR12MB3416.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Jul 2021 22:24:20 -0400
Message-ID: <CADnq5_PJONeFX2rNaL-y__geeN=0C5dRiDJdMC5Bq5_V34n0Hg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG
 issue for renoir.
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 28, 2021 at 9:33 PM Zhang, Yifan <Yifan1.Zhang@amd.com> wrote:
>
> Hi Alex,
>
> No, it won't break gfxoff. The "gfxoff broken" issue we saw last time has been fixed on CP firmware update for Renoir, and this patch changes doorbell range setting specifically for Renoir, not covering the other ASICs. I think it is better to change doorbell range setting per ASIC to mitigate possible side effects.
>

Thanks.  Do we need a firmware version check to determine when to set
the range differently?

Alex


> BRs,
> Yifan
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, July 28, 2021 9:46 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG issue for renoir.
>
> On Wed, Jul 28, 2021 at 2:10 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
> >
> > If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
> > Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>
> I assume this won't break gfxoff?  The last time we changed this, it broke a bunch of scenarios.  Won't this cause just about all doorbells to wake gfx?
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 03acc777adf7..70b64b510743 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -3675,7 +3675,15 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
> >         if (ring->use_doorbell) {
> >                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
> >                                         (adev->doorbell_index.kiq * 2) << 2);
> > -               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> > +               /* In renoir, if GC has entered CGPG, ringing doorbell > first page
> > +                * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
> > +                * workaround this issue.
> > +                */
> > +               if (adev->asic_type == CHIP_RENOIR)
> > +                       WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> > +                                       (adev->doorbell.size - 4));
> > +               else
> > +                       WREG32_SOC15(GC, 0,
> > + mmCP_MEC_DOORBELL_RANGE_UPPER,
> >                                         (adev->doorbell_index.userqueue_end * 2) << 2);
> >         }
> >
> > --
> > 2.25.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cyi
> > fan1.zhang%40amd.com%7C4a2605541c22483b4a3a08d951ce097c%7C3dd8961fe488
> > 4e608e11a82d994e183d%7C0%7C0%7C637630767650055129%7CUnknown%7CTWFpbGZs
> > b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > %7C1000&amp;sdata=1TIsNslKHeSNNMDR3MHPaIiP%2BSLVrr5cEfAbCmvZlCw%3D&amp
> > ;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
