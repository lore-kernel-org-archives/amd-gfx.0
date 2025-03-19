Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A30C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6655210E0B9;
	Wed, 19 Mar 2025 16:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gW/+HQW+";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B374C10E0B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:45:20 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2240ff0bd6eso17499895ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742402720; x=1743007520; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WokJ8ivGa9l2s5v5UsWeYQlDhyWV1t/8QZYVoIycXVc=;
 b=gW/+HQW+iC8bKA2IsmtsC8YW/FaYD2iSVjXsLao0IGwY5XL6T51mdxfZLz/SV70pTw
 okpWDWXNM0fCYm2Ioe5jKRxC17agoWMKKWsWY9ljpTTWq1F8GE05r2J04CF6rceGFjWe
 oMIyaPTqjYVU8zUqSYMV7pOhQR/eIGawOIP5+bDmZ161jVFB0QNiVh9sX6FkrsL8AIwC
 /gGcQsKaJ0zMJN61Z2a/FfGPV/t4UWCXQ1wOvxfWHTd90iUiT45fyNVfsTlKflHpi4GK
 8czJauwVj/1dWJe+UD86sTyjhgcbSKDArhFFxPPCfe1p87P3n029v9Ox6zm8IoB1SDOw
 abqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402720; x=1743007520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WokJ8ivGa9l2s5v5UsWeYQlDhyWV1t/8QZYVoIycXVc=;
 b=EP8qTMYtYemb8E1fiItTX6AN1AkBwfaPqOZp66iNmrFpCj7rK6VRsEY8wEAa9prKgA
 CMy7ddNqP6iO5EJqpNlHychxaceuliR+9wuBcRV6IPFayqSsRh+1zEX0vFAdiV1sJz+6
 HwZwfIFhZrgD5MsyI/vrhmqJKzbploDiguEFFwwpbf71mvMLBqw/uA7ZvlopJZBmu97Y
 VdpKfwhSuIuKODTN58UA/xI4D74Lmuxu7Ot0H+DqtZ5P4OE3MnfFTELFO65o8U54siBx
 24yeEsmZNvz0OBKVheZapClVbnBL4tylp7cRFfIMlj5oeJR/fRzAEhHHGklEWkDJFArU
 kw0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCULV7kbGfTqv4T/00+72BwI7rrr7xZkzttQrm/aCddrx66n+pF538mOYZCzhC1RQf2o4HZJAtSc@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yygo0HfCn0OBYxiOOKQ4/sLYxPoWvzWyZfSttbmFfWnS1i4tQtN
 WSq7i/ZZsB+XQUY2EqY+/BgSd8jPm/9b6C8LVfDOkO9F4wkO7/NvUjT+nU3zx97Ai7cUQ7FYwOf
 CIrVzWa7jNFfHNRVbF6HoNCpbmj6PxiNB
X-Gm-Gg: ASbGncs8t3PohH5B12Bg+j/Dif7B/uap89ndfltECrHKSfG+XfkJ1SqzHeIu7FlllaE
 nrxaAVOixsQ6uObWYnZy72VYHv3lNkvik2UwQqDRgM7QxpALxoPiITmJViGkKTnOy+NYhPYYFVz
 f2RCzb13Enh9/JdivYGh6JP6FyKQ==
X-Google-Smtp-Source: AGHT+IHAnkbKDHl3ThaqWzyK9cTJ4JzrWdzRQjtFoNQ/1gOwk3zwK4OStsKIykSeIkj1qZyCmEq0A0KL87bg9R1keuA=
X-Received: by 2002:a17:902:fc44:b0:215:8721:30b7 with SMTP id
 d9443c01a7336-2264c6746efmr17282395ad.11.1742402720126; Wed, 19 Mar 2025
 09:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <DM4PR12MB5165690B22C63D856BFFD7708ED92@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CAFqprmyv+WXmBWwOa3uPuOkmLtrkfc7jEXquXEyb-Bjuni_jBQ@mail.gmail.com>
In-Reply-To: <CAFqprmyv+WXmBWwOa3uPuOkmLtrkfc7jEXquXEyb-Bjuni_jBQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Mar 2025 12:45:08 -0400
X-Gm-Features: AQ5f1JrijgdGJTWxfoh91XtPuO75OdXze-sA_5uJlpj7M9rbXF-3Nq4om_unxVM
Message-ID: <CADnq5_NV4hiQCHB7-YE=cN2NNS4AeHsnxntJfQ5a+iiYOaiYGA@mail.gmail.com>
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

On Wed, Mar 19, 2025 at 8:53=E2=80=AFAM Tomasz Paku=C5=82a
<tomasz.pakula.oficjalny@gmail.com> wrote:
>
> On Wed, 19 Mar 2025 at 03:19, Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > -----Original Message-----
> > From: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > Sent: Sunday, March 16, 2025 4:16 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenn=
eth.Feng@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting supp=
ort for SMU 14.0.2
> >
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > Hook up zero RPM stop temperature for 9070 and 9070 XT based on RDNA3 (=
smu 13.0.0 and 13.0.7) code.
> >
> > Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > ---
> >  .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h |  3 +-  .../drm/amd/pm/=
swsmu/smu14/smu_v14_0_2_ppt.c  | 50 ++++++++++++++++++-
> >  2 files changed, 51 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v=
14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> > index c2fd0a4a13e5..a5eba7b91e2f 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> > @@ -846,9 +846,10 @@ typedef struct {
> >    uint16_t               FanTargetTemperature; // Degree Celcius
> >    //zero fan
> >    uint8_t                FanZeroRpmEnable;
> > +  uint8_t                FanZeroRpmStopTemp;
> >    //temperature
> >    uint8_t                MaxOpTemp;
> > -  uint8_t                Padding1[2];
> > +  uint8_t                Padding1;
> > [Kenneth] - This change on this file is not required. The latest versio=
n on drm-next has the change.
> > Could you please confirm?
> > Thanks
>
> I just (19-03-2025 10:48 UTC) checked against the current drm-next and
> this is still needed.
> The last change to smu14_driver_if_v14_0.h was made 5 months ago by
> Kenneth Feng.
> It's the same state against which I made this patch.

What kernel are you using?  I see the variable here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h#n784

Alex

>
> Tomasz
