Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073D4CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 17:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD5D10E0D8;
	Wed,  8 Oct 2025 17:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="guzfjcsn";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B106A10E0D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 17:45:46 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2680ee37b21so159705ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759945546; x=1760550346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5P6Wken1H0ed2Y3+ycAM88TCCOrSYPEDm7/g7SPIuYk=;
 b=guzfjcsnREWgdaQZSlVvxCQEugk4xzV34csDHxYMpIFGlOsZ+qwzcDzQkCIgHKbqNU
 lxZNj+6OcXJy4XrDhLz6mH3R69DghXlJ/0Sfcbve9/1bh9zZnJL/+a5TJbodXVOOdtRS
 Sdm8ASyPOg3nGoI1whnoPJhTk7+onSb7Ahnw5wtJUmjo2TwWy8CgTvjK67hrgvItexid
 EKx2lzVub6M/5unn20PZBjsndfDPhqHZxtI5Pe8Kxib+h2rcnoVQGZ4B3IXMdFF+feqb
 yMZb3hhU2qOwGofY9qVQ3g6hkSTnu26HxLyZvLKAoNOGllHStnxd20fOwQAIAXHr+1+z
 LJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759945546; x=1760550346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5P6Wken1H0ed2Y3+ycAM88TCCOrSYPEDm7/g7SPIuYk=;
 b=bRxK/B28z0eobKn5TZ+li2q85F3PJ70MzaYYuL1dB1zseATS5KOUdf3+xvgA7xuAg2
 wn5gbmLZ+G1Ot9TfoBJg2GIeLeuhPRFeC13YtzF9Adx+fFQc0bnze9mdTL+oRi2PSr9h
 ebpvIaeON6qMfJ7q1KZFB0VxwnsKdYzN/RIQqd8TSp3lphMzyYQjW9J2xSQuRnzLtyo4
 Nneja/IHl4+7Ku/B7GSVfr9c/5jbj9S9xfzOaYA7PRNA5jjmqIyGjMge0djifptd/8Rg
 acYJDFxE0Jv3QAMYJU8uvZ5xTiqlky7+Ip15yNp/WTkcF84w/6PM3DMHp912fZskKmpv
 XQjA==
X-Gm-Message-State: AOJu0Yw0I41Si4Xu5n7FUJIhIxteZBzFbhzdSVI16vTNjz7XSm537ssL
 tb9bjsuKKR6iEQNIs3CQHEYVtj8eaBfFtii33NwK3JrQnIkNLF+vEnpVTlFvgBOTboJcm6ryPl7
 9LKE3YRaO8+LUxQnu1Z0fo5pk0RgIlLYh3qpB
X-Gm-Gg: ASbGncvXbuBzq2CJF9N4wjXaJ61u2YEWsCrFJ7aNajJ+o4LlVS2jBAW4Hy1X7/Qlyl5
 ivqphxMWSUj9NLAy0lYOD6Ac4DCz4XrAQ9OJUGljX45GiZgEIBe1bOdai4D2Tmi2bLvRtfWlJjB
 JcjvI05GnGG85a079mXMhRTwSNOzBugAA1699PhmcRVm1GQaZWxIQ2O74T7B7YkV57TtO8EpYPB
 jgCurqxD1YQR3FkcmaFLvmmCWaFvjk=
X-Google-Smtp-Source: AGHT+IFLtMbEhH/67YUIfhQrrDN2T8FKWqZGexMOR+HBFBKE0LAppp3f9f+U4sfkrDVJmJWm60YRNYMRwysQg/kRcUE=
X-Received: by 2002:a17:902:c410:b0:27e:da7d:32d2 with SMTP id
 d9443c01a7336-290272e1cbfmr34861575ad.7.1759945546073; Wed, 08 Oct 2025
 10:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251008164408.850834-1-jonathan.kim@amd.com>
 <CADnq5_M_Rk9KX_5Vw+3pxPfrReKqhtF5rn+1P2LidFSJ5y7Wzw@mail.gmail.com>
 <CY8PR12MB74354BE47029963B8FEDCD4385E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB74354BE47029963B8FEDCD4385E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 13:45:34 -0400
X-Gm-Features: AS18NWDVyxCdJy6J6LW_QriholLlwCVHr1SD5NzAMWo8HcgQ3t72y3FDsnsgEAI
Message-ID: <CADnq5_PLCEEVbk4ufSnQyqzmW32iBccpk5EXf7kPwdp5=Lpo-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
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

On Wed, Oct 8, 2025 at 1:27=E2=80=AFPM Kim, Jonathan <Jonathan.Kim@amd.com>=
 wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, October 8, 2025 1:12 PM
> > To: Kim, Jonathan <Jonathan.Kim@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status=
 check
> >
> > On Wed, Oct 8, 2025 at 12:51=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.=
com>
> > wrote:
> > >
> > > The driver currently only checks that the MES packet submission fence
> > > did not timeout but does not actually check if the fence return statu=
s
> > > matches the expected completion value it passed to MES prior to
> > > submission.
> > >
> > > For example, this can result in REMOVE_QUEUE requests returning succe=
ss
> > > to the driver when the queue actually failed to preempt.
> > >
> > > Fix this by having the driver actually compare the completion status
> > > value to the expected success value.
> >
> > This should be correct as is:
> >
> > *status_ptr =3D 0;
>
> That's not what I'm observing at the moment.
> amdgpu_fence_wait_polling can still return fine where status_ptr !=3D 0 n=
or 1.
> From what I've been told, only 0x1 =3D=3D success (the completion fence v=
alue passed to MES).
> Shaoyun can probably elaborate or correct me if I'm wrong.
> It's pretty easy for me to put the HW in a bad state (dangling queues pos=
t remove) without the driver knowing in its current state.

1 is just what the driver puts as the fence value to write:
api_status->api_completion_fence_value =3D 1;
and the memory location is initialized to 0:
*status_ptr =3D 0;
The firmware should either write 1 or nothing, writing a random value
in there looks like memory corruption or a firmware bug.  If it
doesn't write the fence, the driver can assume the operation failed.
If it writes random values, then we have no idea what's going on.

Alex

>
> Jon
>
> > ...
> > api_status->api_completion_fence_value =3D 1;
> > ...
> > if (r < 1 || !*status_ptr) {
> >
> > Alex
> >
> > >
> > > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > index aff06f06aeee..58f61170cf85 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > @@ -228,8 +228,7 @@ static int
> > mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> > >                         pipe, x_pkt->header.opcode);
> > >
> > >         r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> > > -       if (r < 1 || !*status_ptr) {
> > > -
> > > +       if (r < 1 || *status_ptr !=3D api_status->api_completion_fenc=
e_value) {
> > >                 if (misc_op_str)
> > >                         dev_err(adev->dev, "MES(%d) failed to respond=
 to msg=3D%s
> > (%s)\n",
> > >                                 pipe, op_str, misc_op_str);
> > > --
> > > 2.34.1
> > >
