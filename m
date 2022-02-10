Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3A9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 15:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F8B10E898;
	Thu, 10 Feb 2022 15:47:45 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD13710E89F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 15:47:43 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 g15-20020a9d6b0f000000b005a062b0dc12so4078158otp.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PL1mTu3W3FEj4MB27L8xzWcYjQdw4UJmMif9+njftNk=;
 b=MVK7GYDG6UtNkLkjuqO2lJ5obUyG1Lw3I7+6ukpRjx8n5LfRk5hGG6FPbo3YcgSiMy
 a9FbZkHyS9ndshn3YPZrEBae1h/qM+JRTL1PRhOqG8UiXBQYGpRtqa/9WLlM0zRXCGzV
 2E1h0ZhWrbqik7OXfbJDBzdFJPM+CQTR5auusP5uGTVa4UtunEPmUbcXLJsECJY3Oi0W
 QiIYV9j9Hf4MGHAE0Qp/0xaZDWkLZpdsLnqd0CjCXywfW0Opbhlh6NSNFkMoNQbxE4v4
 NjSGY9azqMajML5HdOrNeqW54rwlEDgq2xMoktQlA8yS35bhrNjgYdp3zOEbbFzAOM4K
 6e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PL1mTu3W3FEj4MB27L8xzWcYjQdw4UJmMif9+njftNk=;
 b=Vbzhls+ThQxmlpeYiHhqdYGXDJ7Jyvjmdu+H9JDu7rN6f9WVymm61vlVc1R+6sHUl+
 WA33lZ/NsfcOIOdf4aL6wEiZ4nxGrmcJEZy7J9KEXRJ1RnZfMHtJN/r4R9fNRHN389nq
 MWoJ9ZEQ24C+I0UJqnXhmYAzFGj4AQWuDK1ZDDu3WeWIotG4jhDBN2jhraY2zaCnsYG4
 1ea/5ft3YSx1zXo00LREXGF2w7GneRFBquzsuPWL7fBGPwygISzG5Wo2yX6UTCYixeSB
 7LSsNypl7zthp+NMKW+JlriMEb45ue9nvkZ6HI/5he05MoIyFqzcbnfp3OOKc5Fap+PX
 2EBA==
X-Gm-Message-State: AOAM531/ee/mJlV3AlXbUrJtHub1476U4ftP3oxrDefaIgc5rH0kUXTd
 3N4yIJ0ChWCsUVjQwRjfI59MvcrsBKNuAfh6r1A=
X-Google-Smtp-Source: ABdhPJymq+fQJeEnpUuSR7w3PMuYmN+Gni96XbC+V+olbQjHE22vAu7HrysnopyxC2rLLmTtGvzUZTMhhvqUORoyOZ8=
X-Received: by 2002:a9d:e94:: with SMTP id 20mr3139010otj.200.1644508063049;
 Thu, 10 Feb 2022 07:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20220210133507.5954-1-rajib.mahapatra@amd.com>
 <BL1PR12MB5157740FA3CFB17B93165A19E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_NQDUyQYKGu3==HhzVN-tjriKjxH4mGgEuKqiX4ffo8ng@mail.gmail.com>
 <BL1PR12MB51574E5BD540B48C975D7502E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51574E5BD540B48C975D7502E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Feb 2022 10:47:32 -0500
Message-ID: <CADnq5_N3fpN=HammdsurdACixsDEbFZ_3P0SD-UEKZ_4gQBSYg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Mahapatra,
 Rajib" <Rajib.Mahapatra@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 10, 2022 at 10:42 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, February 10, 2022 09:28
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> > amd-gfx@lists.freedesktop.org; S, Shirish <Shirish.S@amd.com>
> > Subject: Re: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for
> > S0ix.
> >
> > On Thu, Feb 10, 2022 at 9:04 AM Limonciello, Mario
> > <Mario.Limonciello@amd.com> wrote:
> > >
> > > [Public]
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> > > > Sent: Thursday, February 10, 2022 07:35
> > > > To: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario
> > > > <Mario.Limonciello@amd.com>; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; S, Shirish <Shirish.S@amd.com>;
> > > > Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> > > > Subject: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for
> > S0ix.
> > > >
> > > > [Why]
> > > > SDMA ring buffer test failed if suspend is aborted during
> > > > S0i3 resume.
> > > >
> > > > [How]
> > > > If suspend is aborted for some reason during S0i3 resume
> > > > cycle, it follows SDMA ring test failing and errors in amdgpu
> > > > resume. For RN/CZN/Picasso, SMU saves and restores SDMA
> > > > registers during S0ix cycle. So, skipping SDMA suspend and
> > > > resume from driver solves the issue. This time, the system
> > > > is able to resume gracefully even the suspend is aborted.
> > > >
> > > > v2: add changes on sdma_v4, skipping SDMA hw_init and hw_fini.
> > >
> > > This line in the commit message should be "below" the ---
> > >
> > > Besides that the code is better.
> > >
> > > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > I presume sdma_v5.2.c needs a similar fix?
>
> VG doesn't do s0i3 right?

Right.

> No, YC should not take a similar fix.    YC had an architectural change and to
> avoid a "similar" problem takes 26db706a6d77b9e184feb11725e97e53b7a89519.

Isn't that likely just a workaround for the same issue?  This seems cleaner.

Alex

>
> >
> > Alex
> >
> >
> > >
> > > > Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > > index 06a7ceda4c87..02115d63b071 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > > @@ -2058,6 +2058,10 @@ static int sdma_v4_0_suspend(void *handle)
> > > >  {
> > > >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > > >
> > > > +     /* SMU saves SDMA state for us */
> > > > +     if (adev->in_s0ix)
> > > > +             return 0;
> > > > +
> > > >       return sdma_v4_0_hw_fini(adev);
> > > >  }
> > > >
> > > > @@ -2065,6 +2069,10 @@ static int sdma_v4_0_resume(void *handle)
> > > >  {
> > > >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > > >
> > > > +     /* SMU restores SDMA state for us */
> > > > +     if (adev->in_s0ix)
> > > > +             return 0;
> > > > +
> > > >       return sdma_v4_0_hw_init(adev);
> > > >  }
> > > >
> > > > --
> > > > 2.25.1
