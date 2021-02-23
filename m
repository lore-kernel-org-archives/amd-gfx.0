Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D81C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 18:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6101C64DF3
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 18:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6101C64DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244BB89F73;
	Tue, 23 Feb 2021 18:02:33 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2132B89F73
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 18:02:32 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id 105so10072876otd.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 10:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8mGzcLiUCbAcf84ZP3z+idxc69ixidT0xTKSIw5cfuU=;
 b=L0GjdwHY1EPJWPSEfF1uo3Ez9Kx6lktn45yHap9f0mQWUU0HcDWJkLRkqzcDAMKGEz
 ytbyBwYy9LpRdeE0Vw6qK2jJXa2G1v5oVvinnInx7CJvH6cGWtR5NRDaexwxPODEAb42
 ecdcEVNrwOe7krQRx1iHbCTdXYDvhHQO8N8GGH44qUpz6/9wbu6kcZA6jDRaAtUtX+nz
 cEMm0KccKei7dR8ROhQf+0vYlFEXx19q3C0LAxrIWtAu1lyB7AHUifcS8FRpjP9zybWO
 L31Ggt7Vq+N4w261P0V+IyBTMb/5rmItiWCBn3koAqbie7sUTS3pvBRjbaZXOYZHPrld
 12Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8mGzcLiUCbAcf84ZP3z+idxc69ixidT0xTKSIw5cfuU=;
 b=Y6G85XXEVt3CPmZznhcON18+4UcO+bm2z9mhaNAJum3op4QvZJA1F/ek8U4Hz9ZefM
 lrI8SrArtl/IBn/nSJnT6NOTKcQQb1jCWZPb+iwRyQdykqFFZsSBhhTVWDFyhJiJWOnY
 4SCpAB76DiZizNxJ2GYF4mhZ8aWIvlCE3dKsGnU0D535cvX5WI2IX19Q9wiKQxlpm9O3
 a/XEpvGoGvr++l96bAcfBCLs8qeQNruN7oLDEa97Ih3ujYzIfu9ktflC9cWUckOkHeL0
 K9UY0/tLESGtiRUxKqbJaIsbjhbu1Et/VAeMDXta70pTLALPJEjlM+ySTkIlQCt8v2zy
 mN6A==
X-Gm-Message-State: AOAM530W7SSDKjDfko1GLPSxl7YOZI4Z5f2aVFDzedQbvZM7pO0STBLy
 QYkJZuKYDkUrrUhg40tEGQ+ayu81JfTWrLpRiVg=
X-Google-Smtp-Source: ABdhPJwgadlV17aopClygMR3oriLYaTdYD4pb7vgk9E6T7KdwUN7CG/t8f2vmlRzREI9awjbiowRXjJJQNj2iDddgtg=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr10691061oti.132.1614103350892; 
 Tue, 23 Feb 2021 10:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20210219011913.28464-1-shaoyun.liu@amd.com>
 <CADnq5_PXYRnX25Y=k+5dMxHuQmviD83_dei7oQDLOQDirjX38w@mail.gmail.com>
 <DM6PR12MB383559EFE1D662B8479B13D3F4809@DM6PR12MB3835.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB383559EFE1D662B8479B13D3F4809@DM6PR12MB3835.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Feb 2021 13:02:20 -0500
Message-ID: <CADnq5_PcvW-YnbikAnXBe5yOynzs_pLcJbDsZhS-jxuTo2hQvw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
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

On Tue, Feb 23, 2021 at 1:00 PM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks , Alex.
> Whole four patches are needed for the XGMI reset to work normally .  I try to describe what  these patches for in the first patch. But  If you don't mind this , I can adjust the order as suggested .

Just update the commit messages to indicate that these changes are
needed for big rework in the later patches.

Alex


>
> Thanks
> Shaoyun.liu
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, February 23, 2021 11:26 AM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init
>
> On Thu, Feb 18, 2021 at 8:19 PM shaoyunl <shaoyun.liu@amd.com> wrote:
> >
> > Driver need to get XGMI info function earlier before ip_init since
> > driver need to check the XGMI setting to determine how to perform
> > reset during init
> >
> > Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> > Change-Id: Ic37276bbb6640bb4e9360220fed99494cedd3ef5
>
> I think this patch needs to come first or patch 1 won't work.  With that changed, this patch is:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > index 3686e777c76c..3e6bfab5b855 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -1151,6 +1151,10 @@ static int gmc_v9_0_early_init(void *handle)
> >         adev->gmc.private_aperture_end =
> >                 adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> >
> > +       /* Need to get xgmi info earlier to decide the reset behavior*/
> > +       if (adev->gmc.xgmi.supported)
> > +               adev->gfxhub.funcs->get_xgmi_info(adev);
> > +
> >         return 0;
> >  }
> >
> > @@ -1416,12 +1420,6 @@ static int gmc_v9_0_sw_init(void *handle)
> >         }
> >         adev->need_swiotlb = drm_need_swiotlb(44);
> >
> > -       if (adev->gmc.xgmi.supported) {
> > -               r = adev->gfxhub.funcs->get_xgmi_info(adev);
> > -               if (r)
> > -                       return r;
> > -       }
> > -
> >         r = gmc_v9_0_mc_init(adev);
> >         if (r)
> >                 return r;
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Csh
> > aoyun.liu%40amd.com%7Ceb081cfaf9c94e59521008d8d817ccee%7C3dd8961fe4884
> > e608e11a82d994e183d%7C0%7C0%7C637496944032343059%7CUnknown%7CTWFpbGZsb
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C1000&amp;sdata=CrS5Nv4uCh8sFRILLGM%2FRgxpVlEEs%2Bft%2FHTdoeQyyqo%3D&
> > amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
