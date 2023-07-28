Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475F5C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 17:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C220110E176;
	Fri, 28 Jul 2023 17:20:45 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AF610E176
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 17:20:43 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1bb89ac2013so1740464fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690564843; x=1691169643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LY0Suu3bDXihE2Scz0yFPmObbniBl18mn9zVOGEkkX8=;
 b=dFyNqcDVqpBfyXxDqesG9m8gbvKTDGMA9V1oVHVOmMQoajty7D14c/kooK6rbKCvF4
 1ccgJ+JLu2x93BoBc+T8pS+lDmVm1tMm693DJ/bC+BzFzmscFU/V1YAgO9du932djcnJ
 ArCqn35rrebEhooMovctKWohb48Tz6QygMeItB+HIHklnTfQH2Vp15VVyatKDbk3ciL1
 Z4jebBYI83GteChUlYBuMWvy3N9RrE7Kxk6WpEg6AMYH2QJa1LUIL9Clr8vwzTXUqeqH
 2geMJh+ovZPsXgnbf9IllI0RvR/FJcb1NVJ0/MqTc/KsHhWmYtToAOxiET53CHHyg3tV
 hPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690564843; x=1691169643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LY0Suu3bDXihE2Scz0yFPmObbniBl18mn9zVOGEkkX8=;
 b=NTNJtdY8ARPTP0sqRNMuCqrJl8BttL86S40UPdtUzL7z49v6WDceaUypMOiSB6HB79
 KEZ90ytDZ59zkHhPFMuczqVlJm+upu8AukAZGq9V7QsTDQ7d1/0BjMu4jUk6jJCUspnb
 jYj/aPxKDfeYds32/lgm9gMThJHSfIfNq3xswX+97p4G7Q12H4KTaZr6X4qvmDGPwG/7
 l5Sv8hIVTD1rSZN7aXG4jhkj+hbi9zy5CNpr5nvoitRceoaG/o1ki0fAPovlLBk28SKX
 liW0uWseyBDBgb2L52P1F6U6yjT7DgfT9urLxnzgTbJ8WLF1sIWw8dA9F53bn8Nmnreq
 4Vdw==
X-Gm-Message-State: ABy/qLZxNCDWiB92jIrtFL7Us3bsbIwiJ7a5tD1Xru766ehha6xavFA9
 KxWmG5wpTqAKoGUlE8Z0e8qncVmlHH2aoSCV6ww=
X-Google-Smtp-Source: APBJJlE+koMhTNML1hAWeSZL3uOIA9jdF8qPpJGKWypt2Nh3/rjyq9nHJGP9ijOouHIqI9U98+cS3obklaekLBG1ztw=
X-Received: by 2002:a05:6871:520b:b0:1b0:5baf:a4c3 with SMTP id
 ht11-20020a056871520b00b001b05bafa4c3mr3880703oac.35.1690564843081; Fri, 28
 Jul 2023 10:20:43 -0700 (PDT)
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
In-Reply-To: <e654d536-54c0-258d-c80b-129f95c048cc@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Jul 2023 13:20:31 -0400
Message-ID: <CADnq5_Np7QqvdER3+ayJQB1_7DvL5ddR447q_x1Yp5Ku8yOsTg@mail.gmail.com>
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

On Fri, Jul 28, 2023 at 1:19=E2=80=AFPM Michel D=C3=A4nzer <michel@daenzer.=
net> wrote:
>
> On 7/28/23 18:43, Alex Deucher wrote:
> > On Fri, Jul 28, 2023 at 10:25=E2=80=AFAM Michel D=C3=A4nzer <michel@dae=
nzer.net> wrote:
> >> On 7/28/23 11:30, Michel D=C3=A4nzer wrote:
> >>> On 7/28/23 03:38, Zhang, Jesse(Jie) wrote:
> >>>>
> >>>> Could you try the patch again ?  That work for me.
> >>>>
> >>>> https://patchwork.freedesktop.org/patch/549605/ <https://patchwork.f=
reedesktop.org/patch/549605/>
> >>>
> >>> This patch fixes the symptoms described in https://gitlab.freedesktop=
.org/drm/amd/-/issues/2659 for me as well.
> >>>
> >>> However, it does not fix the IOMMU page faults[0] or the IB test fail=
ures on the compute rings. Should I try amdgpu.ignore_crat=3D1 for these sy=
mptoms as well?
> >>
> >> I tried ignore_crat=3D1, it avoids the remaining symptoms as well.
> >
> > The first 3 patches of this set may also fix it:
> > https://patchwork.freedesktop.org/series/121538/
>
> They do fix all symptoms I'm seeing.
>
> Is this a feasible solution for the final 6.5 release?

I think the first3 are.  The 4th will have to wait for 6.6.

Alex
