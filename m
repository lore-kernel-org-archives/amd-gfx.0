Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2691C35FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F8610E1C1;
	Wed, 19 Mar 2025 16:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QwBdHE2T";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D1910E1C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:52:01 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-301a6347494so469436a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742403121; x=1743007921; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ahiwF2fA2zLoV0qqcSvjqzu/a9g827sICVDt8CuAVY=;
 b=QwBdHE2TdkrLJbySmCpowoC3xzqwK62Lap3ZsVBlHjSocr5WdwdmGwVtb5jWYBZ6mS
 JiqpzG9IDpFKbCLJgw5FxWYS/HXBsDXdnvWH7dlpvnzeBnhQyetZzl3Nr+opvMa3TbSG
 G9JGebaZ+tMq26zaVn/ixydNcOc/90r7ILMoL7Bckdwd66tBgqpdbykhHZwDkAMCQwE4
 P2tiq98ykztRWMI5+dthAN8GRgAJ57gIMeTexKVFcbbtS2TZz0KXwptTWzcIsh0AscrR
 xz8yqXlOz/rErnsmnLwJGb26Qm+AyTn3sdMrz0KWb8BHORMkT/QpvYLcMvLw/hS2NBg1
 eK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742403121; x=1743007921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ahiwF2fA2zLoV0qqcSvjqzu/a9g827sICVDt8CuAVY=;
 b=D/lgTlDEpE2egKNkbGB3aiP10NWdTxW7XyeVP+3ySAxIQDE33YBpGddz+z9WJFACfz
 US3+bbwbqb8MIAgoYCunVshIpU9Shdo2ELcqELEJZ9ZMZgfYV0QucVr1+LvNDlwik7on
 fCE/s6Sj9dk2AV3L0QXoPpRMUdvS7K6WcqEHul/BwNJ3+yDRP3cU/OYrxZw9FM1yqdu6
 G9xnwsceL5wOwSEvYTD6mpaHnI6jngzXiQBuhhApSmWodzkH2TZX+Yt+6xhsqr6y7os2
 Hnh2dOqtBBTRhnNVNs3WQMdKqmMoG2HSFsn6JXi4qogwX/TCVTWoDf4UxCBuEad1aTyP
 YXtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG4kTGwwwnpflyTdyk8blYgoQY9/PKV4hkOkehydqkDHm7OMQjbKPMcA23zQc0JAzN3NXFJjEo@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywqm0SgRpEdAONncWwHP+tfFTnSau6fARGp5iypt+bRXIi2TJyX
 SZnNhL0RqgGtpwAIxuTPokhvf7Q10QZaAytohuFCXjAcbprJ2SLO1M6GfuSJ6bP1aNIOtYAIjxd
 yIJzfHnhTaMJ5EAxzGsNXGHjGcDhLYw==
X-Gm-Gg: ASbGncvkjZ0hd/O8ztmH34mdua4scnO5+lECUxRcClRRTHxMVhGQg79kZb+nbyY+TT7
 MkpIWcSPytBCN1yLBlRKdRz7g5l6ruOOVqOyScOfJg56IDmik2NQGDisBxqaS4U/i2ayl5+3n8M
 jywua4dDgf96I/3bPN/X/RkDifWA==
X-Google-Smtp-Source: AGHT+IFSadKntbCMNnZu3+DvXwmom02n6duvs4LuTMjec89lfL9oFaDxgG7fQ03H1PZzuZCfwy4d21bcIh/00iUjifo=
X-Received: by 2002:a17:90b:4b04:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-301bfc73453mr1619218a91.3.1742403120746; Wed, 19 Mar 2025
 09:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <DM4PR12MB5165690B22C63D856BFFD7708ED92@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CAFqprmyv+WXmBWwOa3uPuOkmLtrkfc7jEXquXEyb-Bjuni_jBQ@mail.gmail.com>
 <CADnq5_NV4hiQCHB7-YE=cN2NNS4AeHsnxntJfQ5a+iiYOaiYGA@mail.gmail.com>
In-Reply-To: <CADnq5_NV4hiQCHB7-YE=cN2NNS4AeHsnxntJfQ5a+iiYOaiYGA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Mar 2025 12:51:47 -0400
X-Gm-Features: AQ5f1Jp_sE7nNNeZ4E19GS8CsO8GuI6r7Mb4wsci5R2kufs_3HCvlUYsFQlySyA
Message-ID: <CADnq5_OxT2qfxdPAg5=w1PeOBhQdCL-He2rBJOireSidBz9DKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Wed, Mar 19, 2025 at 12:45=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Wed, Mar 19, 2025 at 8:53=E2=80=AFAM Tomasz Paku=C5=82a
> <tomasz.pakula.oficjalny@gmail.com> wrote:
> >
> > On Wed, 19 Mar 2025 at 03:19, Feng, Kenneth <Kenneth.Feng@amd.com> wrot=
e:
> > >
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > -----Original Message-----
> > > From: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > > Sent: Sunday, March 16, 2025 4:16 AM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Ke=
nneth.Feng@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Subject: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting su=
pport for SMU 14.0.2
> > >
> > > Caution: This message originated from an External Source. Use proper =
caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > Hook up zero RPM stop temperature for 9070 and 9070 XT based on RDNA3=
 (smu 13.0.0 and 13.0.7) code.
> > >
> > > Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > > ---
> > >  .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h |  3 +-  .../drm/amd/p=
m/swsmu/smu14/smu_v14_0_2_ppt.c  | 50 ++++++++++++++++++-
> > >  2 files changed, 51 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if=
_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> > > index c2fd0a4a13e5..a5eba7b91e2f 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.=
h
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.=
h
> > > @@ -846,9 +846,10 @@ typedef struct {
> > >    uint16_t               FanTargetTemperature; // Degree Celcius
> > >    //zero fan
> > >    uint8_t                FanZeroRpmEnable;
> > > +  uint8_t                FanZeroRpmStopTemp;
> > >    //temperature
> > >    uint8_t                MaxOpTemp;
> > > -  uint8_t                Padding1[2];
> > > +  uint8_t                Padding1;
> > > [Kenneth] - This change on this file is not required. The latest vers=
ion on drm-next has the change.
> > > Could you please confirm?
> > > Thanks
> >
> > I just (19-03-2025 10:48 UTC) checked against the current drm-next and
> > this is still needed.
> > The last change to smu14_driver_if_v14_0.h was made 5 months ago by
> > Kenneth Feng.
> > It's the same state against which I made this patch.
>
> What kernel are you using?  I see the variable here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h#n784

Nevermind, different structure.

Alex

>
> Alex
>
> >
> > Tomasz
