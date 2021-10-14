Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23729C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 02:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF53610E7
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 02:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFF53610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4AB6E8A0;
	Thu, 14 Oct 2021 02:34:50 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA386E8A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 02:34:48 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id g125so6505737oif.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ukKO+8VYOv3ZKnLioOn6hjC7stTGPyBDE9NCpDT+MSo=;
 b=gkSEhY3fUM7eSvcE/vEBOfC7o/LoNw0ylG67va90EKlv0Ql0hUf1u4QdBb8VWEBtla
 4BP4FV+TBvdO7LryQxNS9wMxV95Bo2F0/MV6jAXCnLx90Z+ylZINW4C8XWV5ZVsBWRhz
 PZrrHeEXjVdQucwBD8/4oAqcyHq1VYEed++5f//gWwxVIvj7APBTVbmahDS44mp0EYum
 W9YKalViv9PUqmztzJfIRgQln+PE1inUxyPlkWmDj2M129hGxikFvmvhxia4zZ59VlGl
 p2qhiHnL96EshiJ6xYZ8ehi1PyiSuIL9fv7duFBu8zE2dziCs+X+3KycKffmRsI07zhF
 VKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ukKO+8VYOv3ZKnLioOn6hjC7stTGPyBDE9NCpDT+MSo=;
 b=BUB+/yzSq0qzkroMqdLWhckDs1Plyu5iOodhHNXeq+5OLsXuo9p/KW8m2jOZSVwLr2
 BofmpgQG4k6LYlaj4Yr4lRVOiqbi8rHXHzV/xTMCA06+91TF8E+vZUuwYSIOo6mSJDzL
 AL8pJ8LTCrW76SpGI820UnaPIV5vYWczK1cL0oKka0K9KiJsjYZ3jIQ+7vukZTgO3oVF
 cRqnLi0qGEQI20qdNZmedBbsvfl6exH7ORMZU5WdaYtSM4iZvUFP/oCL+2bMxC06NBhC
 jYSoXyKLt/2aU5tfxFdE7QUvzALzcPpyIW5b/XF4Ychyes11MVbnd4bw3KTufLnKvCDi
 BoAA==
X-Gm-Message-State: AOAM532yZPTR9i2kNpfLKHHQQm+Q5B1lMqA4w/xAYigCi/3y9hciygdn
 tVToo9dE5R3vFwD+OzFc73o9EkuLjCma8DSnXcE=
X-Google-Smtp-Source: ABdhPJw/t0YU+0eDP7wKInnzNGLIFfoWOETLsgqMUTqNJ/Zk/EESy5vyRSI3dhF1Df1KkPDmE+okefy0hTzCvUShliY=
X-Received: by 2002:a05:6808:1527:: with SMTP id
 u39mr2087833oiw.123.1634178888043; 
 Wed, 13 Oct 2021 19:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211012155307.1059170-1-alexander.deucher@amd.com>
 <20211012155307.1059170-3-alexander.deucher@amd.com>
 <DM6PR12MB261955EC5754D6E20C98DF9BE4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_PVm4fFCNHSodNNSct19waF6nnQGBN_keR_2+Zi4SYF+w@mail.gmail.com>
 <DM6PR12MB2619DCFBA7615E883BB11A29E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619DCFBA7615E883BB11A29E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 22:34:37 -0400
Message-ID: <CADnq5_OnVHaVOeXboEz-bNBhtjpC6iOU2cdYVNcTb-T_VJ0kYQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
 psp_check_pmfw_centralized_cstate_management
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 13, 2021 at 10:29 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, October 14, 2021 10:00 AM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Subject: Re: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
> > psp_check_pmfw_centralized_cstate_management
> >
> > On Wed, Oct 13, 2021 at 9:41 PM Quan, Evan <Evan.Quan@amd.com> wrote:
> > >
> > > [AMD Official Use Only]
> > >
> > > I assume IP_VERSION(11, 0, 0) and IP_VERSION(11, 0, 5) are for Navi10 and
> > Navi14 respectively.
> > > Then according to the code comment that "
> > pmfw_centralized_cstate_management support is available for Navi12 and
> > onwards only", I think they should be handled by "default" branch. That
> > means this patch seems unnecessary.
> > >
> >
> > The original code was this:
> >        if ((adev->asic_type >= CHIP_ARCTURUS) ||
> >            (adev->asic_type >= CHIP_NAVI12))
> >                 psp->pmfw_centralized_cstate_management = true; So navi10 and
> > 14 were included.  Not sure whether they should have been or not.
> [Quan, Evan] OK. That will make sense. Series is reviewed-by: Evan Quan <evan.quan@amd.com>
> Dig a little more about the history.
> It seems at first the centralized_cstate_management was limited to ARCTURUS or >= CHIP_NAIV12. Then it was expanded to all ASICs >= CHIP_ ARCTURUS.
> But the code comment was left outdated. Can you get that updated on code submit?
> @@ -65,7 +65,6 @@ static int psp_securedisplay_terminate(struct psp_context *psp);
>   *
>   * This new sequence is required for
>   *   - Arcturus and onwards
> - *   - Navi12 and onwards
>   */

Will do.  Thanks!

Alex


>
> BR
> Evan
> >
> > Alex
> >
> >
> > > Patch1 and 2 are reviewed-by: Evan Quan <evan.quan@amd.com>
> > >
> > > > -----Original Message-----
> > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > > Alex Deucher
> > > > Sent: Tuesday, October 12, 2021 11:53 PM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > > Subject: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
> > > > psp_check_pmfw_centralized_cstate_management
> > > >
> > > > Missed a few asics.
> > > >
> > > > Fixes: 82d05736c47b19 ("drm/amdgpu/amdgpu_psp: convert to IP
> > version
> > > > checking")
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > > index 6b39e6c02dd8..51620f2fc43a 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > > @@ -77,7 +77,9 @@ static void
> > > > psp_check_pmfw_centralized_cstate_management(struct psp_context
> > *psp
> > > >       }
> > > >
> > > >       switch (adev->ip_versions[MP0_HWIP][0]) {
> > > > +     case IP_VERSION(11, 0, 0):
> > > >       case IP_VERSION(11, 0, 4):
> > > > +     case IP_VERSION(11, 0, 5):
> > > >       case IP_VERSION(11, 0, 7):
> > > >       case IP_VERSION(11, 0, 9):
> > > >       case IP_VERSION(11, 0, 11):
> > > > --
> > > > 2.31.1
