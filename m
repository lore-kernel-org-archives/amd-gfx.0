Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF1C5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 14:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D641F10E330;
	Tue, 27 Aug 2024 14:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gn7TRWlt";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E12010E330
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 14:18:39 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-20228008eebso3042015ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724768319; x=1725373119; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjBmWerqC6TUh045gIHyLYQ6+zsOtBpX2XwcFqpm9Rw=;
 b=gn7TRWltFVpWByiaIheNAxSqnMVvfPeY3v3nHLWCYudvh4arXr4hz4b19FhFSkGyKW
 jkIAoYiPDykbiYNOVPAOr+5oxCtKCXa+0YNUdfuCp7lhe+4ij70dNypasSKWNWIKuX0j
 At2C+qEV+R8qylMhVxh7HfuSkClEJuU/Ml3zo655TAvmMZkNR6RqIh7rv/gCW7VJ1Elb
 jbCzcWmPUd4rrRWeAnlkOultwHf4t/vhd7I6iU5fpPTEjbmPJEQSwt0XYqiKo6qqOOCf
 Wl4SX4oSe5v+XtENk0VAdhmjJ4Fcg8buBtDxPsoMmrelzLTJFG/jwOS/16Z6jTk40PeK
 Efxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724768319; x=1725373119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KjBmWerqC6TUh045gIHyLYQ6+zsOtBpX2XwcFqpm9Rw=;
 b=ZaP7iLiynS1IIHgtiNxGWcVe+xOZbN8JwXIldhWnCNFS3XQcxH2yLR959I/KwC4ssQ
 PTTwQidMCDiGftq8dzQNvTWfne2t0PgpxfwImCaXGeiMMJ4ccZTZXGIZkpmFKZVhBtn7
 wqRomG/l5MbBONNFFFtYc+rbrbsilAQmq4TQg/FzPk2/mUIrzaahyDxrQ983w0cNUFUV
 DsIzfaZpTKAp40laNS6gI4aRfRbHVOOX88fmd9LxuLC/2J5wU4D9wCscGDS3ezWRqpva
 9TdxdR08d4fJIGYy+EbLfSIFUPp/3vWLQ2gullXZGu8ZH4bCQzFKY2Kqn2oApif1aT08
 ee/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUC6nBN5CkpbQHdNR4WBvc0i4sAVsa/95xCFErbOzQCFASPSX+GejRDNX+k39lRfrU/lLlpq6K@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYxwwFvVSPfj1xNqCW4XFv9D8hLgMEtKcs9w3dgl1DF3cHNWdf
 x3NCkzVpaF4qqJLoVQHe7Yveb+mUYMW53v1KET2Rso+US1JcH5dc+z40e/LoTsVtRrPi1J9Ecub
 Dg2Nr7olmMCpJ+DrlBcoW/Ddt3kg=
X-Google-Smtp-Source: AGHT+IGAgkTOlcRp7zgYGJNflHX7StCIJ0sZFV05To4fRH2E6W++LasaeiKxJ4pOOL9eLGayn3aXBSXt7wJHqgRRQuo=
X-Received: by 2002:a17:903:32c1:b0:202:18d7:7ffb with SMTP id
 d9443c01a7336-2039e703c29mr91695645ad.11.1724768318865; Tue, 27 Aug 2024
 07:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh>
 <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh>
In-Reply-To: <2024082439-extending-dramatize-09ca@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Aug 2024 10:18:27 -0400
Message-ID: <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
Subject: Re: AMD drm patch workflow is broken for stable trees
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
 stable@vger.kernel.org
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

On Sat, Aug 24, 2024 at 1:23=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Aug 23, 2024 at 05:23:46PM -0400, Alex Deucher wrote:
> > On Thu, Aug 15, 2024 at 1:11=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> > > > On Wed, Aug 14, 2024 at 4:55=E2=80=AFPM Felix Kuehling <felix.kuehl=
ing@amd.com> wrote:
> > > > >
> > > > > On 2024-08-12 11:00, Greg KH wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > As some of you have noticed, there's a TON of failure messages =
being
> > > > > > sent out for AMD gpu driver commits that are tagged for stable
> > > > > > backports.  In short, you all are doing something really wrong =
with how
> > > > > > you are tagging these.
> > > > > Hi Greg,
> > > > >
> > > > > I got notifications about one KFD patch failing to apply on six b=
ranches
> > > > > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that yo=
u
> > > > > already applied this patch on two branches back in May. The email=
s had a
> > > > > suspicious looking date in the header (Sep 17, 2001). I wonder if=
 there
> > > > > was some date glitch that caused a whole bunch of patches to be r=
e-sent
> > > > > to stable somehow:
> > > >
> > > > I think the crux of the problem is that sometimes patches go into
> > > > -next with stable tags and they end getting taken into -fixes as we=
ll
> > > > so after the merge window they end up getting picked up for stable
> > > > again.  Going forward, if they land in -next, I'll cherry-pick -x t=
he
> > > > changes into -fixes so there is better traceability.
> > >
> > > Please do so, and also work to not have duplicate commits like this i=
n
> > > different branches.  Git can handle merges quite well, please use it.
> > >
> > > If this shows up again in the next -rc1 merge window without any
> > > changes, I'll have to just blackhole all amd drm patches going forwar=
d
> > > until you all tell me you have fixed your development process.
> >
> > Just a heads up, you will see some of these when the 6.12 merge window
> > due to what is currently in -next and the fixes that went into 6.11,
> > but going forward we have updated our process and it should be better.
>
> Can you give me a list of the git ids that I should be ignoring for
> 6.12-rc1?  Otherwise again, it's a huge waste of time on my side trying
> to sift through them and figure out if the rejection is real or not...

8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on Lin=
k
fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
math_ceil2
295d91cbc700 drm/amd/display: Check for NULL pointer
6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_common_=
modes

Thanks.

Alex

>
> thanks,
>
> greg k-h
