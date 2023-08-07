Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CD6C001DF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 22:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC3010E38E;
	Mon,  7 Aug 2023 22:08:18 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6616C10E38E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 22:08:15 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-56c884e1d74so3345595eaf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Aug 2023 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691446094; x=1692050894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52NzrCq8cerimEVa5e0D/FjskxZbc/UOcz+jEToRYEU=;
 b=DI19mHE3fFilSyK5io69mewgzrvSSOVDRIeRLx0EXK2qlnUuZhEflp5OeDqKTwCjF2
 lPMghHtsUCeprVmLpUW6swP3cfmKRTYINwHOIUBMSn5fQ+YCfuDrhkc9GbAznylzmAFf
 v5+penpTp2bDgehzISCgzxswuWTI30MYu9wAgd5PUo1L9pRrGsdwjrlE7wsZmw4VeKY8
 ywfojbsJ3n9LJPvacc8nIIgcNiXX4VdDW/wzX2sP7MLvFbiUdLmIukX9NTYH4mJA2XKb
 UFLa0WKUMvMH0fVREx9V320XaL41dYeXy7ZDCPfoKSBXl2Wjxp4BHq74qnRS6SBDs1a0
 jf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691446094; x=1692050894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52NzrCq8cerimEVa5e0D/FjskxZbc/UOcz+jEToRYEU=;
 b=f7LXmdLj0SW0rCsYOE55QhlC9a9J2F2PKz7QzfyspyCp7iJPAU6k69yM1kmn0ygm/t
 9uUkjsL1xz9PJEG69Rt/E/aqg5XlW1jltqIjMhAN1Q70oJqe2wVZIJlWxbgzQMpMZlvR
 grpGQ4bj2MmhhpE2zE5rrKQRajjYOW8tJv6oevr0f/boBPAxRbwymaDLahUHE/fX3t7D
 qgsFs9ZclysYwfyjekVq9i6i2Z9TXLjpZnBlkyMDVfu6r8gx3/cunZm1GTNfpcFz7cwP
 mnnbwTiRVaAWFWFrGa6IlSaZg1AlnI1cA+0aWa8PeAEN7SOl6WhqtCfEubJ8FMT+qOBz
 nxpg==
X-Gm-Message-State: AOJu0YyAdkQxoNoA/DkHkf0zAsCVU4+4Z94xah8HM9soJCtIiYHFPBQl
 68WENDoql5tTfFBDTZjCkcjvo9SaCnLnydWwXO4=
X-Google-Smtp-Source: AGHT+IF+8586QZeFXTM4ImPacOfGUraVaenz4Or1/ZmJO/F8k0biMv6TrWUU32lFBVDLOKyKb4rkUWnljnmosiIkMB4=
X-Received: by 2002:a4a:9243:0:b0:566:ec2f:36d0 with SMTP id
 g3-20020a4a9243000000b00566ec2f36d0mr9102706ooh.2.1691446094450; Mon, 07 Aug
 2023 15:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
 <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
 <1da36164-7cd9-c2a3-a42f-558942257727@daenzer.net>
 <f8c83922-f3d4-34d8-6ae1-3112b52bcdf3@amd.com>
 <d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net>
 <0a99c609-c5c2-25fc-4ceb-52a0b4a49f29@amd.com>
 <219fc41b-13f2-8517-1720-eb92fe02083c@amd.com>
 <DM4PR12MB5152DC2873CB6726977F45C9E301A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DM4PR12MB5152E173B970C3974F071E76E306A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <063f67cc-241d-f92f-1c6b-1ec20795690a@daenzer.net>
 <493a9ab5-1665-0188-8bab-69086f7d94a6@daenzer.net>
 <CADnq5_N-5MNq1YjU1w5AgsqFVTc0_nJ+XWgkifhRAzKKiftHZg@mail.gmail.com>
 <e654d536-54c0-258d-c80b-129f95c048cc@daenzer.net>
 <CADnq5_Np7QqvdER3+ayJQB1_7DvL5ddR447q_x1Yp5Ku8yOsTg@mail.gmail.com>
 <84c6f537-ddd6-6a8b-a574-723b8eec231a@daenzer.net>
In-Reply-To: <84c6f537-ddd6-6a8b-a574-723b8eec231a@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 18:08:03 -0400
Message-ID: <CADnq5_NmnX3mz16NcjBp--Z2Mu=io407Cuj4ShfVOQW=SdaBKA@mail.gmail.com>
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 7, 2023 at 12:04=E2=80=AFPM Michel D=C3=A4nzer <michel@daenzer.=
net> wrote:
>
> On 7/28/23 19:20, Alex Deucher wrote:
> > On Fri, Jul 28, 2023 at 1:19=E2=80=AFPM Michel D=C3=A4nzer <michel@daen=
zer.net> wrote:
> >> On 7/28/23 18:43, Alex Deucher wrote:
> >>> On Fri, Jul 28, 2023 at 10:25=E2=80=AFAM Michel D=C3=A4nzer <michel@d=
aenzer.net> wrote:
> >>>> On 7/28/23 11:30, Michel D=C3=A4nzer wrote:
> >>>>> On 7/28/23 03:38, Zhang, Jesse(Jie) wrote:
> >>>>>>
> >>>>>> Could you try the patch again ?  That work for me.
> >>>>>>
> >>>>>> https://patchwork.freedesktop.org/patch/549605/ <https://patchwork=
.freedesktop.org/patch/549605/>
> >>>>>
> >>>>> This patch fixes the symptoms described in https://gitlab.freedeskt=
op.org/drm/amd/-/issues/2659 for me as well.
> >>>>>
> >>>>> However, it does not fix the IOMMU page faults[0] or the IB test fa=
ilures on the compute rings. Should I try amdgpu.ignore_crat=3D1 for these =
symptoms as well?
> >>>>
> >>>> I tried ignore_crat=3D1, it avoids the remaining symptoms as well.
> >>>
> >>> The first 3 patches of this set may also fix it:
> >>> https://patchwork.freedesktop.org/series/121538/
> >>
> >> They do fix all symptoms I'm seeing.
> >>
> >> Is this a feasible solution for the final 6.5 release?
> >
> > I think the first3 are.
>
> Even with Felix's feedback on patch 2?
>
> If so, will you merge these for 6.5 final?

Yes, just sent out a new patch set.  The changes for Felix' feedback
was pretty trivial.  Once they are reviewed, I'll land them for 6.5.
Hopefully this week.

Alex

>
> Or should we revert 84b4dd3f84de ("drm/amdkfd: Refactor migrate init to s=
upport partition switch") for that?
>
>
> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer
>
