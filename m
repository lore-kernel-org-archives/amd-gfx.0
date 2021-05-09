Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E22C43460
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D7161076
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D7161076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F1B6E427;
	Mon, 10 May 2021 08:26:29 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA8189DAB
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 May 2021 21:42:21 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 u25-20020a0568302319b02902ac3d54c25eso12762787ote.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 May 2021 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=yGaYATT91hQdu4h6WDvEjJqfoMHklt3pfo9wj23gP18=;
 b=i/6WMll3Jfc3BcDof07cTy0ysb4BOwv+UFr8P/ZLw6Vsa7W3t+tprFyF1qtPnyWG9t
 q4IqPom6JR1J4IQoaLvey54HUA3CxgfypZqyeO5VwbppnJOPHTVh3070e4/zGrQF/hGw
 WcXaYAuJElok1I4Ot6ppl7kwuwwgCdH7XZ+EeRqSzq4jfAbOEtkeOA8VXrq8g+8KD8z+
 1JJF30Cv0o6ywy07lcEfCfHhfMoIH5CjkbPFuxH8DhxrQJXjJl3WgOu7ZBar+26h5K+x
 AN2trsT7/T+N0iY5nh8CQBfw0uux1Jn8rizC339rxTqCvBrADiMbeasZ3U+uAZeKfIgm
 Lg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=yGaYATT91hQdu4h6WDvEjJqfoMHklt3pfo9wj23gP18=;
 b=qXGvnrb41plT+VTrawvkUzLDze/RlUqry5jgbNAGJ7rjpMA/DKDYmEYtnGfBPFi7Jb
 S3bP9nb2bhKetzR87s7NG7aR3gMH1rv0uycJRfYnkK6mnemkYXq0TBrM+i95bKXeTTF/
 Vr+FwpoUtPgmqw4dfX16ElMzWdX1r/kiSy/ZqUO06z1c/AxTHcFWsbuMBiGENAYH41WP
 tt6DJ8grqwisb7UDEzEfdbsM2kJO3xZoTI3QV0zUrFuzQcEdQ1YI/bFwuK9Y6DPD3Plk
 AJS9sX9dFuBoQtPP9f4a/W/BeSKxNTfM3Kzhat1gkKjQ+v6/YPcLWxtgVgEaJ0hmTjlw
 wH8Q==
X-Gm-Message-State: AOAM531iP3avlvGFnRPFJDP9PtGRa3pguB7yOwqXEzxHDGR3pgp1ulbc
 5Fr+8IR1C/kOOEVvr1f3hl8Q/pD1hCXefYkBuGA=
X-Google-Smtp-Source: ABdhPJwqe1gdhwAL1RTZWdtt8hdpsuEtUBRIl5CYd8L+UZ0qNUER3L9hUNtS7dgSKzHULq/xmO4fESBCFG2IV3R0XhI=
X-Received: by 2002:a9d:6f90:: with SMTP id h16mr1287278otq.8.1620596540717;
 Sun, 09 May 2021 14:42:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:4118:0:0:0:0 with HTTP; Sun, 9 May 2021 14:42:20
 -0700 (PDT)
In-Reply-To: <CAP+8YyEv3NPqeEVmFvQDoq_+=h8Q_goHUbgt7fNPUXJbR5AcKw@mail.gmail.com>
References: <20210414233533.24012-2-qingqing.zhuo@amd.com>
 <20210509121055.24728-1-youling257@gmail.com>
 <CADnq5_MF0y0sHH6Vz8KZH5j=iXToq3WPw7+kW=BqMk=oNZ=Ppw@mail.gmail.com>
 <CAOzgRdZf0R7mVY+spDZz_CG1Kpf7qmP6oGaOJ_XKauZA3ZhZeg@mail.gmail.com>
 <CAP+8YyEv3NPqeEVmFvQDoq_+=h8Q_goHUbgt7fNPUXJbR5AcKw@mail.gmail.com>
From: youling 257 <youling257@gmail.com>
Date: Mon, 10 May 2021 05:42:20 +0800
Message-ID: <CAOzgRdYbmnA3M5d30i94TwGNtOWOviChBq9eEdhTjbfvGXaSfw@mail.gmail.com>
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

error dmesg

[  115.977746] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
[  115.980406] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe 0
[  115.993656] [drm:drm_mode_addfb2 [drm]] [FB:104]
[  115.993694] [drm:drm_mode_addfb2 [drm]] [FB:105]
[  115.993722] [drm:drm_mode_addfb2 [drm]] [FB:106]
[  115.993750] [drm:drm_mode_addfb2 [drm]] [FB:107]
[  115.993777] [drm:drm_mode_addfb2 [drm]] [FB:108]
[  115.994215] [drm:drm_mode_addfb2 [drm]] [FB:104]
[  115.994371] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
[  115.997095] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe 0
[  116.010298] [drm:drm_mode_addfb2 [drm]] [FB:102]
[  116.010337] [drm:drm_mode_addfb2 [drm]] [FB:105]
[  116.010366] [drm:drm_mode_addfb2 [drm]] [FB:106]
[  116.010394] [drm:drm_mode_addfb2 [drm]] [FB:107]
[  116.010422] [drm:drm_mode_addfb2 [drm]] [FB:108]
[  116.010853] [drm:drm_mode_addfb2 [drm]] [FB:102]
[  116.011018] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
[  116.013694] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe 0


normal dmesg
 3464.827004] [drm:drm_mode_addfb2 [drm]] [FB:105]
[ 3464.833405] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe 0
[ 3464.833981] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe 3
[ 3464.842396] [drm:drm_mode_addfb2 [drm]] [FB:104]
[ 3464.842476] [drm:drm_mode_addfb2 [drm]] [FB:106]
[ 3464.842550] [drm:drm_mode_addfb2 [drm]] [FB:107]
[ 3464.842615] [drm:drm_mode_addfb2 [drm]] [FB:108]
[ 3464.842679] [drm:drm_mode_addfb2 [drm]] [FB:109]
[ 3464.842741] [drm:drm_mode_addfb2 [drm]] [FB:110]
[ 3464.843748] [drm:drm_mode_addfb2 [drm]] [FB:104]
[ 3464.843821] [drm:drm_mode_addfb2 [drm]] [FB:106]
[ 3464.850026] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe 0
[ 3464.850378] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe 3
[ 3464.858841] [drm:drm_mode_addfb2 [drm]] [FB:102]
[ 3464.858878] [drm:drm_mode_addfb2 [drm]] [FB:105]
[ 3464.858906] [drm:drm_mode_addfb2 [drm]] [FB:107]
[ 3464.858933] [drm:drm_mode_addfb2 [drm]] [FB:108]
[ 3464.858960] [drm:drm_mode_addfb2 [drm]] [FB:109]
[ 3464.858987] [drm:drm_mode_addfb2 [drm]] [FB:110]
[ 3464.859609] [drm:drm_mode_addfb2 [drm]] [FB:102]
[ 3464.859641] [drm:drm_mode_addfb2 [drm]] [FB:105]
[ 3464.866353] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe 0
[ 3464.866653] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end for pipe 3

2021-05-10 4:57 GMT+08:00, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>:
> It would be very helpful if you could enable drm.debug=0x4 and then
> take the dmesg to figure out what modifier was rejected
>
> On Sun, May 9, 2021 at 10:51 PM youling 257 <youling257@gmail.com> wrote:
>>
>> look this video,
>> https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
>>
>> 2021-05-09 23:52 GMT+08:00, Alex Deucher <alexdeucher@gmail.com>:
>> > On Sun, May 9, 2021 at 11:42 AM youling257 <youling257@gmail.com>
>> > wrote:
>> >>
>> >> I using amd 3400g running with android-x86, this patch is a bad commit
>> >> when i use android-x86 on amdgpu.
>> >
>> > Can you provide more details?  What sort of problem are you seeing?
>> > Please provide your dmesg output.
>> >
>> > Alex
>> >
>> >
>> >> _______________________________________________
>> >> amd-gfx mailing list
>> >> amd-gfx@lists.freedesktop.org
>> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
