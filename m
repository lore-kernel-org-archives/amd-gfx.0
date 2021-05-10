Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDF0C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74636144F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74636144F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DC06E42D;
	Mon, 10 May 2021 08:26:26 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F9A89B42
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 02:09:40 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 f75-20020a9d03d10000b0290280def9ab76so13085290otf.12
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 May 2021 19:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=2UaFKZdetO+FOLBGObqhXA7/WqBOaeWMWNijs2fh+G8=;
 b=JV/WyaPActxftlkLOlHGF5ngD2Yrqbk4Neo8CXgStyqbcGOdIj5xtuU4fHOPMal2Eu
 HP18mJHPb9JSqPLdj7zhOqnXM17DjlRKQok4VJmV6JY99dUhsfi1WRMhKovRWfXkDO1x
 NOZdvuXNh4sU63EH8zHXPdV7jJzudsMPMr9R4X5ywLkoZirtOxsXTqPfe1oClhasvdf0
 2FG6bh85kcsFxT0LO/Mqk5c1HRo5FLOLRZo1bwm9zxVGj8uH4VNL+UFZX2G72gJc081H
 FOM5gMIj3LwYLuf9LuDnwBHRnEbsqiPZtpKLAVLxGLLo8OmdF7EkoJsL89mB+vb/KMwB
 yiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=2UaFKZdetO+FOLBGObqhXA7/WqBOaeWMWNijs2fh+G8=;
 b=OlGlO9inq5ggVhzrrAY1nXj+8MRXMn3pY2u8qTPoVFZX1Sjels8BgIECPKjMhiAwwN
 ioRe4TO6UKU0uj8rt16gfZ3lcW72VRZ5M2VeY6OHthC4Ti2YzRBpKAEiTQVr9FEWyf7p
 +5OuHD1KIjDaLEthFscfSZf4x+PcPvt4ZA2koKEsUKyBgJ/3jCVTBEgIoWIE+9qMhM+b
 K6JT51V6WSrP1W/HMid7KgNcveVCk6PosqRLHn+/6DAJ9WnlhuvfmT2rPHzZRGjujPY8
 liDEN+Qdjbv9nPiKCbUpxTyL2nkqEzxN4JMq/ely7r1S5aMl3r2JGdfgpl6xEqg92Pyw
 bcPQ==
X-Gm-Message-State: AOAM533TOZfUNuBVKOfWurZoXqoamD8BPQ7NPlAelAvz0ubeiTpHyANh
 KP9Gx3l3IAUA58YKWBDekDJXL3eFTPVKn2Z7xYo=
X-Google-Smtp-Source: ABdhPJyv8OQJiAaVIxHi5X/ZUqaDKHiiO7z9A/ridtF8KQyoE9RJCL5aCqsvAOStw2AJMG34/hJ+Hc8gRIY8h+TYjmA=
X-Received: by 2002:a9d:6f90:: with SMTP id h16mr1988732otq.8.1620612579917;
 Sun, 09 May 2021 19:09:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:4118:0:0:0:0 with HTTP; Sun, 9 May 2021 19:09:39
 -0700 (PDT)
In-Reply-To: <CAOzgRdYbmnA3M5d30i94TwGNtOWOviChBq9eEdhTjbfvGXaSfw@mail.gmail.com>
References: <20210414233533.24012-2-qingqing.zhuo@amd.com>
 <20210509121055.24728-1-youling257@gmail.com>
 <CADnq5_MF0y0sHH6Vz8KZH5j=iXToq3WPw7+kW=BqMk=oNZ=Ppw@mail.gmail.com>
 <CAOzgRdZf0R7mVY+spDZz_CG1Kpf7qmP6oGaOJ_XKauZA3ZhZeg@mail.gmail.com>
 <CAP+8YyEv3NPqeEVmFvQDoq_+=h8Q_goHUbgt7fNPUXJbR5AcKw@mail.gmail.com>
 <CAOzgRdYbmnA3M5d30i94TwGNtOWOviChBq9eEdhTjbfvGXaSfw@mail.gmail.com>
From: youling 257 <youling257@gmail.com>
Date: Mon, 10 May 2021 10:09:39 +0800
Message-ID: <CAOzgRdaKpwd5ze8om4F22yq_DeREma1H6KUquqJ34dnSTvsjiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
X-Mailman-Approved-At: Mon, 10 May 2021 08:26:24 +0000
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
Cc: Mark Yacoub <markyacoub@chromium.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wheeler,
 Daniel" <daniel.wheeler@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Revert "Revert "drm/amdgpu: Ensure that the modifier requested is
supported by plane."" is first bad commt.
"drm/amd/display: Fix two cursor duplication when using overlay" is
second bad commit.
they cause same problem, look the video.
i have to revert two patch for my androidx86 run on amdgpu.

2021-05-10 5:42 GMT+08:00, youling 257 <youling257@gmail.com>:
> error dmesg
>
> [  115.977746] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> [  115.980406] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> 0
> [  115.993656] [drm:drm_mode_addfb2 [drm]] [FB:104]
> [  115.993694] [drm:drm_mode_addfb2 [drm]] [FB:105]
> [  115.993722] [drm:drm_mode_addfb2 [drm]] [FB:106]
> [  115.993750] [drm:drm_mode_addfb2 [drm]] [FB:107]
> [  115.993777] [drm:drm_mode_addfb2 [drm]] [FB:108]
> [  115.994215] [drm:drm_mode_addfb2 [drm]] [FB:104]
> [  115.994371] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> [  115.997095] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> 0
> [  116.010298] [drm:drm_mode_addfb2 [drm]] [FB:102]
> [  116.010337] [drm:drm_mode_addfb2 [drm]] [FB:105]
> [  116.010366] [drm:drm_mode_addfb2 [drm]] [FB:106]
> [  116.010394] [drm:drm_mode_addfb2 [drm]] [FB:107]
> [  116.010422] [drm:drm_mode_addfb2 [drm]] [FB:108]
> [  116.010853] [drm:drm_mode_addfb2 [drm]] [FB:102]
> [  116.011018] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> [  116.013694] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> 0
>
>
> normal dmesg
>  3464.827004] [drm:drm_mode_addfb2 [drm]] [FB:105]
> [ 3464.833405] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> 0
> [ 3464.833981] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> 3
> [ 3464.842396] [drm:drm_mode_addfb2 [drm]] [FB:104]
> [ 3464.842476] [drm:drm_mode_addfb2 [drm]] [FB:106]
> [ 3464.842550] [drm:drm_mode_addfb2 [drm]] [FB:107]
> [ 3464.842615] [drm:drm_mode_addfb2 [drm]] [FB:108]
> [ 3464.842679] [drm:drm_mode_addfb2 [drm]] [FB:109]
> [ 3464.842741] [drm:drm_mode_addfb2 [drm]] [FB:110]
> [ 3464.843748] [drm:drm_mode_addfb2 [drm]] [FB:104]
> [ 3464.843821] [drm:drm_mode_addfb2 [drm]] [FB:106]
> [ 3464.850026] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> 0
> [ 3464.850378] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> 3
> [ 3464.858841] [drm:drm_mode_addfb2 [drm]] [FB:102]
> [ 3464.858878] [drm:drm_mode_addfb2 [drm]] [FB:105]
> [ 3464.858906] [drm:drm_mode_addfb2 [drm]] [FB:107]
> [ 3464.858933] [drm:drm_mode_addfb2 [drm]] [FB:108]
> [ 3464.858960] [drm:drm_mode_addfb2 [drm]] [FB:109]
> [ 3464.858987] [drm:drm_mode_addfb2 [drm]] [FB:110]
> [ 3464.859609] [drm:drm_mode_addfb2 [drm]] [FB:102]
> [ 3464.859641] [drm:drm_mode_addfb2 [drm]] [FB:105]
> [ 3464.866353] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> 0
> [ 3464.866653] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe
> 3
>
> 2021-05-10 4:57 GMT+08:00, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>:
>> It would be very helpful if you could enable drm.debug=0x4 and then
>> take the dmesg to figure out what modifier was rejected
>>
>> On Sun, May 9, 2021 at 10:51 PM youling 257 <youling257@gmail.com> wrote:
>>>
>>> look this video,
>>> https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
>>>
>>> 2021-05-09 23:52 GMT+08:00, Alex Deucher <alexdeucher@gmail.com>:
>>> > On Sun, May 9, 2021 at 11:42 AM youling257 <youling257@gmail.com>
>>> > wrote:
>>> >>
>>> >> I using amd 3400g running with android-x86, this patch is a bad
>>> >> commit
>>> >> when i use android-x86 on amdgpu.
>>> >
>>> > Can you provide more details?  What sort of problem are you seeing?
>>> > Please provide your dmesg output.
>>> >
>>> > Alex
>>> >
>>> >
>>> >> _______________________________________________
>>> >> amd-gfx mailing list
>>> >> amd-gfx@lists.freedesktop.org
>>> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>> >
>>
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
