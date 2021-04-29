Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7979CC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A610613FA
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A610613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE2A6F4B2;
	Thu, 29 Apr 2021 20:25:11 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 351AD6F4B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 20:25:11 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id e25so37809656oii.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z9xgKRJkuubYXwOj+UXyQu1ToM36LUEY+F8dxqqUkzE=;
 b=IABQvtAFFb2p8U3VXcNm2XF2StZV1MfvpB/3DTrLS9Vc7InLNNJU51px8/xjbzpIyq
 JVjdhEfCwnVUj1XyMIL7mTCh3TuHK6g0Uh+G2qyJnDHqT0tpqC0iPG0czrcmmE9YZY26
 B8fVnFERsqbXsOZF/mpYXad7AvK279Vx5gt8fZ0Q++jRy2/NO+O9zrlLDUVoBkKeZWle
 I51k4epjZV3FxD1PoyQpvqj6dyinfJmnPaJMPGDmQqS6e+wXpPSM/81R/gXAKLtP6L9V
 X94brEvZcPaC4Erot0GjnER+tMUhq9ibQML2id0ULPLgrk2OQMTs5IQf5Du0IiIV+Ugt
 fm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z9xgKRJkuubYXwOj+UXyQu1ToM36LUEY+F8dxqqUkzE=;
 b=Ns+xp/n8zqKfLX/niXIhgTbWspkLC7KvMWM/9OsMhsDbuRNI4zo/ZfLn6U2kVj7W55
 +iROKHOTRf8mfOUvlEp3bRv17k19qaXKUia6sZmV8kkfMOAlpQn3C381hKyEmTVFoD1p
 wtbqkHbUgK1nKgBO/WJOHSByuwK/U/nCzrFtn/efKN0J85S81Tb/+TZsj2RUsa2WRGqN
 7v7+uDZlLl5U+z5j2NmeYTwO3mzsSq6CP0/VlGZz4tQEh9JClKltP3zJUOmHXQYdd1Xb
 47WnxMn+x+TTn/65skHcqnih7DMYKLZd9i/0w+gIgCEc4QoFUmD2yqM1IZ/JAXek/Fpp
 VkTg==
X-Gm-Message-State: AOAM532Z7Ek+1MEYkJB5QdZWe4s2GFW0t5N+ReVsT/XK/ow1p9SgZkBA
 E5rRerWZboi0yZJRA7bN8OTeJ39Im0YYb5UddAy0STAO
X-Google-Smtp-Source: ABdhPJzT6pL4IaXILKDSceQOmDBaya3C6/Wrv09IcncmQ2YIKCRvksmOb2IQu5AYqlnRqIZ0IOhQFniwrDhPWG7WLoQ=
X-Received: by 2002:aca:c08a:: with SMTP id q132mr8003999oif.5.1619727910485; 
 Thu, 29 Apr 2021 13:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210429201312.10498-1-zhigang.luo@amd.com>
 <20210429201312.10498-2-zhigang.luo@amd.com>
 <CADnq5_M_WSZiWxnXAMBB3rBxXHAbUOkNVkRKchf_PLGEx2VQBA@mail.gmail.com>
 <DM6PR12MB3308AA4FE63C1EBF75D0A74AF15F9@DM6PR12MB3308.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3308AA4FE63C1EBF75D0A74AF15F9@DM6PR12MB3308.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Apr 2021 16:24:59 -0400
Message-ID: <CADnq5_OmzsBSw9+6aO6C51MQo9EWepOYK0yxs2EdJM7NUe4xqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add Aldebaran virtualization support
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>
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

On Thu, Apr 29, 2021 at 4:22 PM Luo, Zhigang <Zhigang.Luo@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks Alex.
>
>  I will add it.

With that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> --Zhigang
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: April 29, 2021 4:17 PM
> To: Luo, Zhigang <Zhigang.Luo@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 2/2] drm/amdgpu: Add Aldebaran virtualization support
>
> On Thu, Apr 29, 2021 at 4:13 PM Zhigang Luo <zhigang.luo@amd.com> wrote:
> >
> > 1. add Aldebaran in virtualization detection list.
> > 2. disable Aldebaran virtual display support as there is no GFX
> >    engine in Aldebaran.
> > 3. skip TMR loading if Aldebaran is in virtualizatin mode as it
> >    shares the one host loaded.
> >
> > Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 1 +
> > drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 ++++++---
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 623044414bb5..17b728d2c1f2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -422,6 +422,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
> >         switch (psp->adev->asic_type) {
> >         case CHIP_NAVI12:
> >         case CHIP_SIENNA_CICHLID:
> > +       case CHIP_ALDEBARAN:
> >                 return true;
> >         default:
> >                 return false;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > index 0c9c5255aa42..691066e9c1f3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -50,9 +50,11 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
> >         struct drm_device *ddev = adev_to_drm(adev);
> >
> >         /* enable virtual display */
> > -       if (adev->mode_info.num_crtc == 0)
> > -               adev->mode_info.num_crtc = 1;
> > -       adev->enable_virtual_display = true;
> > +       if (adev->asic_type != CHIP_ALDEBARAN) {
>
> We should check for ARCTURUS here as well.
>
> Alex
>
> > +               if (adev->mode_info.num_crtc == 0)
> > +                       adev->mode_info.num_crtc = 1;
> > +               adev->enable_virtual_display = true;
> > +       }
> >         ddev->driver_features &= ~DRIVER_ATOMIC;
> >         adev->cg_flags = 0;
> >         adev->pg_flags = 0;
> > @@ -679,6 +681,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
> >                 case CHIP_VEGA10:
> >                 case CHIP_VEGA20:
> >                 case CHIP_ARCTURUS:
> > +               case CHIP_ALDEBARAN:
> >                         soc15_set_virt_ops(adev);
> >                         break;
> >                 case CHIP_NAVI10:
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Czh
> > igang.luo%40amd.com%7C6379911fec0b46ae127e08d90b4bc186%7C3dd8961fe4884
> > e608e11a82d994e183d%7C0%7C0%7C637553242264820358%7CUnknown%7CTWFpbGZsb
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C1000&amp;sdata=sDmmizo0SMOhi8dTIVLRVpkLEocssobJCCQEyASwbGk%3D&amp;re
> > served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
