Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59362C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 21:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B4361A26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 21:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B4361A26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C378F6E2D5;
	Fri, 26 Mar 2021 21:01:09 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825616E2D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 21:01:08 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 31-20020a9d00220000b02901b64b9b50b1so6458473ota.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QB1otxObrCvbqRRhZkHZJOHxPltX4caYW3sEKwwQ5a8=;
 b=S+OuhbS5fWrGgD40OWuZGSGltKoPi6cbNylg9uEqC6mlCas//Ilmg6j/Jg4bzL6mlt
 if3ElRxtuC3/tc5LRGGsBDEpxlJ6fPS/bMszLg1aKfbh09RWr6ARJhKYwBPIX4nePYyK
 tD9SfzvOTbrOtvOcwbqNmWhzHMRJz30d+Xozatq47l+DXurJA9/LicVnWFWgukF4JspJ
 nwGvNJPWSumLBuOFeVkeWdQXNIiN+jOM/dTqJq/sN4FvNXJ1X3qjHdOMvprChB1HMbLZ
 jNOf7Nh2We+a4V1sEmFq0x1GWGGOsoT5fSQSB2fQeqPBNXoJYWEUiIZHS4DyQpB6WMsi
 /Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QB1otxObrCvbqRRhZkHZJOHxPltX4caYW3sEKwwQ5a8=;
 b=Zco6XGliCBiXaf2LrXVqoamWCRFLqwLKDBfWD3+PRGjNd4HXckYYtRv3LzdLrs//3r
 tiWiZcKP9ycc3ape/ElK2p94AkSsbOFNVGuBFixJm/GZrWASOPsXVGRFVnSRjcNdAY2z
 iI7smfbg9OeBsUJne89hPMRyAkEFCScpJUQp804PnHfMkvSZakEMTRS8X3wX7rvuyqyQ
 YHD9qnY/0tUwuJPFLUxCXVgaA43HzAEgwboe1/lIDKzKwoAz/6GW+jvtoLOKKb6dm+Xx
 S9QwRAT5rwkLcx2OrHNpI8zI7VISXvq0mNMn0Eomr9Ml0tIOw/JkYGD8FcSsbcC3zVpc
 Bopg==
X-Gm-Message-State: AOAM533N2F0axrySZRsn2UMhYebvj2J3W4KCz8jP6PDVFCAsaTh3KCdW
 0qP4ol1OeLntUldxY/eanpu79RhBhfpiUAGKk1g=
X-Google-Smtp-Source: ABdhPJyamJr8lcEiqY2GFMepWbfs35bPVasGp1ESVKvKSuwJ9PX0n+UASAPnBfaihAcYNRt5cC8rxwO1OGXZbgW2CLI=
X-Received: by 2002:a9d:663:: with SMTP id 90mr11028693otn.311.1616792467790; 
 Fri, 26 Mar 2021 14:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210326043731.779691-1-alexander.deucher@amd.com>
 <DM6PR12MB2971DB53BDFD4B623C368A619E619@DM6PR12MB2971.namprd12.prod.outlook.com>
 <MN2PR12MB448857020BBBAEDEC70B6FB0F7619@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448857020BBBAEDEC70B6FB0F7619@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Mar 2021 17:00:55 -0400
Message-ID: <CADnq5_NUnH0Qs5L+JBhr4XfhurZScXztQhJvRjWt0NKJ2Xh-7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
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
Cc: "Liu, Zhan" <Zhan.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like RN is immune due to the way it's is_dpm_running function is
implemented.  Maybe something like this is a better solution:
https://patchwork.freedesktop.org/patch/426293/

Alex

On Fri, Mar 26, 2021 at 10:12 AM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Can someone double check this on RN/CZN with S3 and S0ix?
>
> Alex
>
> ________________________________
> From: Liu, Zhan <Zhan.Liu@amd.com>
> Sent: Friday, March 26, 2021 1:46 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
>
> [AMD Official Use Only - Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: 2021/March/26, Friday 12:38 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on
> > resume
> >
> > The SMU comes back up with DPM enabled by the sbios, but the driver still
> > has to set up the SMU/driver mailbox, etc.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Reviewed-by: Zhan Liu <zhan.liu@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index d4b804c7b986..462917d4d5e2 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1102,7 +1102,7 @@ static int smu_smc_hw_setup(struct smu_context
> > *smu)
> >  uint32_t pcie_gen = 0, pcie_width = 0;
> >  int ret = 0;
> >
> > -if (adev->in_suspend && smu_is_dpm_running(smu)) {
> > +if (!smu->is_apu && adev->in_suspend &&
> > smu_is_dpm_running(smu)) {
> >  dev_info(adev->dev, "dpm has been enabled\n");
> >  /* this is needed specifically */
> >  if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
> > --
> > 2.30.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> > freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > gfx&amp;data=04%7C01%7Czhan.liu%40amd.com%7C500744d08f7946b2c5d
> > e08d8f010ec49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375
> > 23302768646367%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> > CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vN
> > JawxwfojJrxNOG5L8Y2BAWpGRRN6valpk6y00XIQw%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
