Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A654C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 13:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC4FB89E59;
	Tue,  7 Jul 2026 13:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hC2yj48m";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E7E89E59
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 13:44:40 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84777f07641so274674b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 06:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783431880; cv=none;
 d=google.com; s=arc-20260327;
 b=AooK75ItKCEGWVQpnOJ7JR6VrA4gCID1BOMbcpaJoLGZEHtMl+tpsnV/up2FyJk3ej
 A6AVIrAfS9DEEahGldpH34lqFDG3M53X/+iaB65o6xase889+BbaIFAKRPpY2N7bMr4c
 R881GEvW1VDe9IzRdnEe/9+XQU5kTp0KiaLaeE6LTL6tR/QWZCf5Tgk6bXqj28hJTe4h
 s6J7mS6ps+4oyvYHx1uTYv9Fvya08/bWyuEO2x+GSETAcyO66ylg+hlvTkEWg3XG4D6A
 oKDu3b3y8rPJrIDuM24fZHV6I82TpTP4mYad9LTk1vsEjrRF/Op6GYFTWFagGJNJe4Wr
 osvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p2lwPyPUjQVl1OniZZpOQROdfLJ3GZEp/bzTXdBUkW8=;
 fh=TWw7CjKH/oUmBDR6co52ihjCaPrF1ed6XoUc5ohkm2I=;
 b=GNP8eSNuhvbRJ+Js6mKdxwYeIzqso8kvp/egf7O6wGHbTWWfSjuNMvQEimgG3iLr9m
 TH22x1PED5m12XCU+7yDdKwtgBfT19O2yQ4F5RaiCwN5sdwalWriEfvspVCDtD3HDNTr
 ta1UCrhXtjPbl5R+Eloykwjxi1YTg3Yv2vkRkVyeI4OizHuEsjpHTrMt6tjnA4UOry1z
 ULZSQln1v6/v7CTWD6axPEofP5Wz3x6/VU4LEL+K9qs3sbbYBXNCzydyrE2MpvNz92R2
 CuA+lvoxurVEXVWRlsao2tWRT/W/Kc9FOSTxVFLiXLGx814yQxAS5vf6oB3lsYgDaGYD
 XYKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783431880; x=1784036680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p2lwPyPUjQVl1OniZZpOQROdfLJ3GZEp/bzTXdBUkW8=;
 b=hC2yj48m5beO0ZguNlZqKMHFbEcVQe6dLItzvE3WSXvDEHzZQunhj+GVffHramPmDf
 QPKmSwJOjq5YqnoX298zKXBbBwmH8BdjCxA10751xGM3I9MdjMIvfQ8P80SAehY0J+vI
 CFX2uUqTWoMsbCWwsf6pvRBn5K65MRlDtG/wcbxX/4gOT16vuJCxI0Xhrukil2kts64G
 GqCRSFpfD3y5oomKCaQsm52jOIY3y66N5sO+6fpDWZVN10Oz7HymBPdyMDcVunT/aNNG
 hNEAAVrdxVsl1dGXqh+OkGz42SfhSSiIDw4aVD+pKwZL7dtWf+2b0+Nh6IT7SBc5xM5B
 Thqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783431880; x=1784036680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p2lwPyPUjQVl1OniZZpOQROdfLJ3GZEp/bzTXdBUkW8=;
 b=eICIw3HAE7DTBdSIapf97RPb6Lzd+VcBOztdVfAMekO+ETwnbLNddMwTu5HgDTv1LD
 dnDxaSQOMHcxV3JU8mLggeQWbVjHbUOF7wrJgQ70U06NleSIQMwji5uO1qyWlCHeqwmI
 Bigz3UXtWdmqYCaahwnGgSC6CgF5/8lhkQ8Q/6ISpCdfk+BoWmml+I+s9MGf0GqaS/vi
 95om7ZXAK+R8MMAPYpLqPCv77/wC518IUlczfaHhIOb6sry6TBs/z5nkmj+z1PvsUJd8
 5ljhtlzq2kwV8oGiM/zj4hh2s0VSub2Ik5ihusmhDSxThLrCtVMrKDF9o3vtVJiDceKU
 IH7Q==
X-Gm-Message-State: AOJu0YxJ3zeE5PpUpRqp5OSIpF93LNiRvgsfhVN9XmGF8I/yke9iGFwk
 4cux4lu85m7zVAcCGIf1u+gakq49J8GFNupnXo6emqbfC1MpGUb8laMCrH4sPCRAbphVWs7MART
 hcVSGpcpXuAJ7F+yiM00froQzi7OKiKs=
X-Gm-Gg: AfdE7cliihT13LROfrtIyHciGa0vmZsp42qmKGbtK7L1Twpq0a/LLEoWi01w7FmtgCC
 LzTWvEwiEmvpkU5R9x0cM1VqKpmpKTZ8N4ztgZOucUoPR9fdspSE/6niZpu/asu6XN+iMQCRcP9
 o7waGXGvEXqBiwW4BDwR0KTxpB/aJJtCOgsQM3Vk9Hui6jfjtAmS+i82s3cWHXrGq9aK3X9DLM1
 3pQr0bzGe++2uO2PSLb5NEzXxJiyjx/vhvFAOaP31Xb6nEheaujFO93W5fla0yYGxPZWkUx77Ex
 2p2gf6+imy/0sasICU0FxCFueYZUKuFSoouHKslyVcmtfTGCu/SHg1fkdhU=
X-Received: by 2002:a05:6a21:a517:b0:3bf:d1f9:b1e2 with SMTP id
 adf61e73a8af0-3c03c7c34f5mr9983934637.8.1783431880414; Tue, 07 Jul 2026
 06:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260626204101.31172-1-alexander.deucher@amd.com>
 <14526594.2vocr9iq0E@timur-max>
In-Reply-To: <14526594.2vocr9iq0E@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jul 2026 09:44:28 -0400
X-Gm-Features: AVVi8Ce1NUsVotZuA6hhfyXbMflb1ltq462g7LasNfzBU6LTa-9YCMS42ulYnkw
Message-ID: <CADnq5_O-Ho6fq+8P=1jg3t0vRwSY1tCY_=erxgetKXUiA-Ma7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/gfx10: Program DB_RING_CONTROL
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 7, 2026 at 4:06=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> On 2026. j=C3=BAnius 26., p=C3=A9ntek 22:40:58 k=C3=B6z=C3=A9p-eur=C3=B3p=
ai ny=C3=A1ri id=C5=91 Alex Deucher
> wrote:
> > This is needed to allocate occlusion counters across
> > both gfx pipes.
> >
> > Fixes: b7a1a0ef12b8 ("drm/amd/amdgpu: add pipe1 hardware support")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c index d72ecf5dab09e..6ff7a8a70=
0939
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -5352,6 +5352,9 @@ static void gfx_v10_0_constants_init(struct
> > amdgpu_device *adev) gfx_v10_0_get_tcc_info(adev);
> >       adev->gfx.config.pa_sc_tile_steering_override =3D
> >               gfx_v10_0_init_pa_sc_tile_steering_override(adev);
> > +     /* program DB_RING_CONTROL for multiple GFX pipes */
> > +     WREG32_FIELD15(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
> > +                    (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);
>
> Hi Alex,
>
> Why do you set this to zero when the number of pipes is more than 1?
> Wouldn't it need to be the other way around and set to the number of pipe=
s (or
> number of rings)?

The hardware default is 1.  The other settings are as follows for this fiel=
d:
0 - split occlusion counters between gfx pipes
1 - all occlusion counters to pipe 0
2 - all occlusion counters to pipe 1

Alex

>
> Thanks,
> Timur
>
> >
> >       /* XXX SH_MEM regs */
> >       /* where to put LDS, scratch, GPUVM in FSA64 space */
>
>
>
>
