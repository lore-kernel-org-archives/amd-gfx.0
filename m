Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F87C5321E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 21:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E47F10E084;
	Fri, 23 Aug 2024 21:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jTrWyW4I";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FEE10E084
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 21:23:59 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-20201433461so2396175ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724448238; x=1725053038; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVw3UGVAksq0IK59oQbkTTVPhibGCKRt7ecfvi6uMvU=;
 b=jTrWyW4Ijik3j83EgioMPKTAA3IzRpfSnqpySKpJkC4eSe0QfesEPo7hfnZtw7eQO1
 8M8Vps/alPHEZ+AbmNAnsxrF9UkQhG5uVbRYOo2pFadkSOmnDxbJl4evUNX5+O3Ptjiw
 PDez5r6KStZUvq9mBycYHOIG0LucEPf2EQxRREhocIVhXr4JUOvhyC7fIpuLE3UU5ctF
 jT4xGGz9BgAKMJsA0Uez86YScPL61BUDlz5+nNTbK7ww3nwCYW/imAurS1Rm5UGiuxX0
 sGLICpt9RsEQSNReGNR8JQm0fY06lFFTREXwgg9Ty1mWZpU/n3/WjCt7D6OLcsQj6scB
 HIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724448238; x=1725053038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVw3UGVAksq0IK59oQbkTTVPhibGCKRt7ecfvi6uMvU=;
 b=Pshvf/K28ml2wAue7/Wo4HqsTuLN7qojoyZxZJO9I4kHQqPdA4SKcmRpNNgpH3/yrX
 fMY9p3rJYnMfUt0pZ21WZH0/VTssBFpIXfB0B72w0+LZ5uESWzW/yaHw//P9TJgWm86m
 GKJRHf3/0o51QZNO+Q7FsEr4WmOJNJQXc2+I4ydDHlpdjOl/dxpIKlIQBMCeISWbbZDH
 KtAM7J+c9ckKM8Kb6cHzbp7q6NYALq8FCrjkLKQMNoeA3wZzq+MqG4v89Hcf5sVGlO3x
 1k/lCmeykd1VcoNe5hXxuTfK2Lpa+Dysb8eTB3O4CqHexjbL5n1yynyOGblJ5+AJjx9K
 mrrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH6Y79Zlb+bj2yz7dLKWdDDEUoUlM438RZu2hb2b5Q1rkN/Wpn6i5dtDdQwARY+eGAZVmNCTq4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtQvvIwjHVzRB09S/kx+zfO/b7jEGTLUyFkAVX4YHGjJb2rwyW
 LOiAI/zRwb1wIoP+RuvAu/kw54oEebnfUf9d/tocc6puuJy3XMDAsZWPH88N0AeU3EZUnowxUUQ
 2Lh97AO6tuE60hJNn6i7emV3uinqjyw==
X-Google-Smtp-Source: AGHT+IFlOkaj3R9oJ5MLV1p2+5FXk+ZEOLOmbW8Wg/l2bhgSMmOXoWoM5YzlxCIpuOtkNz77NLUceTnVMAFojKzGrBY=
X-Received: by 2002:a05:6a20:6a07:b0:1c2:5f80:6bc7 with SMTP id
 adf61e73a8af0-1cc8a01ea7emr2752575637.4.1724448238192; Fri, 23 Aug 2024
 14:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh>
In-Reply-To: <2024081558-filtrate-stuffed-db5b@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Aug 2024 17:23:46 -0400
Message-ID: <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
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

On Thu, Aug 15, 2024 at 1:11=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> > On Wed, Aug 14, 2024 at 4:55=E2=80=AFPM Felix Kuehling <felix.kuehling@=
amd.com> wrote:
> > >
> > > On 2024-08-12 11:00, Greg KH wrote:
> > > > Hi all,
> > > >
> > > > As some of you have noticed, there's a TON of failure messages bein=
g
> > > > sent out for AMD gpu driver commits that are tagged for stable
> > > > backports.  In short, you all are doing something really wrong with=
 how
> > > > you are tagging these.
> > > Hi Greg,
> > >
> > > I got notifications about one KFD patch failing to apply on six branc=
hes
> > > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you
> > > already applied this patch on two branches back in May. The emails ha=
d a
> > > suspicious looking date in the header (Sep 17, 2001). I wonder if the=
re
> > > was some date glitch that caused a whole bunch of patches to be re-se=
nt
> > > to stable somehow:
> >
> > I think the crux of the problem is that sometimes patches go into
> > -next with stable tags and they end getting taken into -fixes as well
> > so after the merge window they end up getting picked up for stable
> > again.  Going forward, if they land in -next, I'll cherry-pick -x the
> > changes into -fixes so there is better traceability.
>
> Please do so, and also work to not have duplicate commits like this in
> different branches.  Git can handle merges quite well, please use it.
>
> If this shows up again in the next -rc1 merge window without any
> changes, I'll have to just blackhole all amd drm patches going forward
> until you all tell me you have fixed your development process.

Just a heads up, you will see some of these when the 6.12 merge window
due to what is currently in -next and the fixes that went into 6.11,
but going forward we have updated our process and it should be better.

Thanks,

Alex

>
> thanks,
>
> greg k-h
