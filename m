Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF9C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 15:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B8B6101B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 15:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B8B6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E306E4A1;
	Mon, 10 May 2021 15:19:02 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3B06E4A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 15:18:23 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id h4so23970314lfv.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n5mbYpfOJAJ9KGZyI8HWOiQ3tP7ntHicl48FzA+ufqQ=;
 b=aOyEHGjGyNkc2JQnrp0emdDIKeu6YE3OuboE96ZPXaH7q1GJBG3hAS+AwEkIXHy7Sj
 I4qA3U0cwPxQZMZK/gw61hakjlVGV9QDwWzXY3E23D8GunI3DJapZHy4r73JzCKVMa+i
 yqQxQzwxIzHqk6ttl4lYekdoTl+34L5p/QAxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n5mbYpfOJAJ9KGZyI8HWOiQ3tP7ntHicl48FzA+ufqQ=;
 b=DQNyXmV/duPjlzOyUvuYgdGznhfRs4cQJiS9zcGWCG/uxkK2oU6w/oAkIjFTUJ8T0r
 SgyBEib0P9WkyQS2NB1E3tAbFBeYVD144fascQFAHpg3RykyZCUSHWcko++zT6Tgdf9z
 EF3FJPZrwXcyFeCo7ilMAvG6qa5d1LX+O80++HCfVM3q5rhpN/3podd87Jdp62BGNCXj
 t31L26g4PMCi6TYwwzaHZzkOra8O8TnGwSZqZ2fFsmqalo9yrXgDCHUXD2AsY7UDgnFR
 hqOt8FXgWDGRQHoUBXZmTu9iwrhb73tve+ZM18QU6n4pNPPurdGHX4KOx6SlJ+nlSgu7
 e6bg==
X-Gm-Message-State: AOAM531noR63QGhtdvcD4bFObQe8XvVvMkzTOUOCnDKDjjcZAmmOE0gb
 T8A2sSga+L73GxfukcUUNY+pItSecG7Wp9bIigzl4Q==
X-Google-Smtp-Source: ABdhPJxw/q2bFB3ZFN8RVvUOALBhPN06FuMW0drppNljL64hax8khxvJychAGDiudAexUUR5nHXO0DeERDsE9CFXRcc=
X-Received: by 2002:ac2:4a8d:: with SMTP id l13mr16963771lfp.493.1620659900201; 
 Mon, 10 May 2021 08:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210414233533.24012-2-qingqing.zhuo@amd.com>
 <20210509121055.24728-1-youling257@gmail.com>
 <CADnq5_MF0y0sHH6Vz8KZH5j=iXToq3WPw7+kW=BqMk=oNZ=Ppw@mail.gmail.com>
 <CAOzgRdZf0R7mVY+spDZz_CG1Kpf7qmP6oGaOJ_XKauZA3ZhZeg@mail.gmail.com>
 <CAP+8YyEv3NPqeEVmFvQDoq_+=h8Q_goHUbgt7fNPUXJbR5AcKw@mail.gmail.com>
 <CAOzgRdYbmnA3M5d30i94TwGNtOWOviChBq9eEdhTjbfvGXaSfw@mail.gmail.com>
 <CAOzgRdaKpwd5ze8om4F22yq_DeREma1H6KUquqJ34dnSTvsjiQ@mail.gmail.com>
In-Reply-To: <CAOzgRdaKpwd5ze8om4F22yq_DeREma1H6KUquqJ34dnSTvsjiQ@mail.gmail.com>
From: Mark Yacoub <markyacoub@chromium.org>
Date: Mon, 10 May 2021 11:18:09 -0400
Message-ID: <CAJUqKUoxKdp+U5y0gzi=_N94zs6b9DjUoYT3Mfn0-z-X0hCbMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
To: youling 257 <youling257@gmail.com>
X-Mailman-Approved-At: Mon, 10 May 2021 15:19:01 +0000
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wheeler,
 Daniel" <daniel.wheeler@amd.com>, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexdeucher@gmail.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Like the previous time it was reverted, there is a chance it's a user
space bug that's not passing the correct modifier.
Are you able to check what exactly returns false in the code above.
This will give you the greatest hint on what the userspace is missing
and needs to be fixed there.

On Sun, May 9, 2021 at 10:09 PM youling 257 <youling257@gmail.com> wrote:
>
> Revert "Revert "drm/amdgpu: Ensure that the modifier requested is
> supported by plane."" is first bad commt.
> "drm/amd/display: Fix two cursor duplication when using overlay" is
> second bad commit.
> they cause same problem, look the video.
> i have to revert two patch for my androidx86 run on amdgpu.
>
> 2021-05-10 5:42 GMT+08:00, youling 257 <youling257@gmail.com>:
> > error dmesg
> >
> > [  115.977746] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> > [  115.980406] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> > 0
> > [  115.993656] [drm:drm_mode_addfb2 [drm]] [FB:104]
> > [  115.993694] [drm:drm_mode_addfb2 [drm]] [FB:105]
> > [  115.993722] [drm:drm_mode_addfb2 [drm]] [FB:106]
> > [  115.993750] [drm:drm_mode_addfb2 [drm]] [FB:107]
> > [  115.993777] [drm:drm_mode_addfb2 [drm]] [FB:108]
> > [  115.994215] [drm:drm_mode_addfb2 [drm]] [FB:104]
> > [  115.994371] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> > [  115.997095] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> > 0
> > [  116.010298] [drm:drm_mode_addfb2 [drm]] [FB:102]
> > [  116.010337] [drm:drm_mode_addfb2 [drm]] [FB:105]
> > [  116.010366] [drm:drm_mode_addfb2 [drm]] [FB:106]
> > [  116.010394] [drm:drm_mode_addfb2 [drm]] [FB:107]
> > [  116.010422] [drm:drm_mode_addfb2 [drm]] [FB:108]
> > [  116.010853] [drm:drm_mode_addfb2 [drm]] [FB:102]
> > [  116.011018] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> > [  116.013694] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> > 0
> >
> >
> > normal dmesg
> >  3464.827004] [drm:drm_mode_addfb2 [drm]] [FB:105]
> > [ 3464.833405] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> > 0
> > [ 3464.833981] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> > 3
> > [ 3464.842396] [drm:drm_mode_addfb2 [drm]] [FB:104]
> > [ 3464.842476] [drm:drm_mode_addfb2 [drm]] [FB:106]
> > [ 3464.842550] [drm:drm_mode_addfb2 [drm]] [FB:107]
> > [ 3464.842615] [drm:drm_mode_addfb2 [drm]] [FB:108]
> > [ 3464.842679] [drm:drm_mode_addfb2 [drm]] [FB:109]
> > [ 3464.842741] [drm:drm_mode_addfb2 [drm]] [FB:110]
> > [ 3464.843748] [drm:drm_mode_addfb2 [drm]] [FB:104]
> > [ 3464.843821] [drm:drm_mode_addfb2 [drm]] [FB:106]
> > [ 3464.850026] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> > 0
> > [ 3464.850378] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> > 3
> > [ 3464.858841] [drm:drm_mode_addfb2 [drm]] [FB:102]
> > [ 3464.858878] [drm:drm_mode_addfb2 [drm]] [FB:105]
> > [ 3464.858906] [drm:drm_mode_addfb2 [drm]] [FB:107]
> > [ 3464.858933] [drm:drm_mode_addfb2 [drm]] [FB:108]
> > [ 3464.858960] [drm:drm_mode_addfb2 [drm]] [FB:109]
> > [ 3464.858987] [drm:drm_mode_addfb2 [drm]] [FB:110]
> > [ 3464.859609] [drm:drm_mode_addfb2 [drm]] [FB:102]
> > [ 3464.859641] [drm:drm_mode_addfb2 [drm]] [FB:105]
> > [ 3464.866353] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> > 0
> > [ 3464.866653] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> > 3
> >
> > 2021-05-10 4:57 GMT+08:00, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>:
> >> It would be very helpful if you could enable drm.debug=0x4 and then
> >> take the dmesg to figure out what modifier was rejected
> >>
> >> On Sun, May 9, 2021 at 10:51 PM youling 257 <youling257@gmail.com> wrote:
> >>>
> >>> look this video,
> >>> https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
> >>>
> >>> 2021-05-09 23:52 GMT+08:00, Alex Deucher <alexdeucher@gmail.com>:
> >>> > On Sun, May 9, 2021 at 11:42 AM youling257 <youling257@gmail.com>
> >>> > wrote:
> >>> >>
> >>> >> I using amd 3400g running with android-x86, this patch is a bad
> >>> >> commit
> >>> >> when i use android-x86 on amdgpu.
> >>> >
> >>> > Can you provide more details?  What sort of problem are you seeing?
> >>> > Please provide your dmesg output.
> >>> >
> >>> > Alex
> >>> >
> >>> >
> >>> >> _______________________________________________
> >>> >> amd-gfx mailing list
> >>> >> amd-gfx@lists.freedesktop.org
> >>> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>> >
> >>
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
