Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B439CE8347
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E80610E0D9;
	Mon, 30 Sep 2024 14:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m4Ft4WfO";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6E810E0D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:10:37 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-20b2ee7629fso5852715ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727705437; x=1728310237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McxIwBdoZS9dYb/FR7HkEedBet4OQUoAX6BYObEL1TA=;
 b=m4Ft4WfOrhs5LxvgzZapN6QNEZR0e5xMD6+wRFLyF1yR3RgjtxibVhEHthqaQ//VqF
 l9k18XBKXHMuklMQZhHYSKe07kC+L9hk+/P+wE9CG0Ti5EmBj+R9A4IY8prdU9LJi5m2
 iBlA81eD/pZ6kTxl/EpxWJXDBhBLKLTT9lqGPsZSwWaFjpyFP17f6GT5pVVxssFf0fQj
 b0tlDnKbMB0H+f5VonFJcgoMYo/FuLZW7QbsiIPYcXa5AKJ6rzesdEo0s5axaAfPtx0u
 73zEs4A0ijCA/7XFgeDyi9pUALyZZmwGu4sAIMx0jS6XIfOibRmVkhewqwJMb4ubo2rI
 dKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727705437; x=1728310237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McxIwBdoZS9dYb/FR7HkEedBet4OQUoAX6BYObEL1TA=;
 b=ftlLpeF+LRgOZ20mo/1Q1ARLOcFm3S0nhVdCNyVfFlvN8GBYUU5gQE5Wjgty1NSjTe
 QPI1BBnVO0nKjdxso6ph6NSx9qCXWz+HxR6jm/0a5ZFtkjYNhb3Lfu92wLsSFUuK9Gr5
 jGRFUwECfTPsrZqgenUgZeH+f/YpibCzCWjYhAfeyzdo2hvv8aSu2wHavL+eXH7ONTmG
 CaQlO4i1U3xMoMwXOxn+dsAi07+lddCWfEGglbsbsotiNmkpN0wnqQ0LXWY3aht/+0uv
 s9pWWe5gtxoFMI6PSK1jRlY1VVlZO1yxT/9JRKjIJ2x7CkWauGhaE1uPY5DOV5pks78z
 c2Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz18TyczX+QrUzt9LSy/8p+oKhpku26To1oVlk1gWjwx0gSS+P/hbJs0+NN4uBYP9ayxnNXLW1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5qORs2XUSKLQ3TMpHWnN9ppjGNQC/OVDSAdbipFOUkZU1Di6f
 1ClATkP5851xtj7m2X1ayr3D3CF2vMeMqAfQgLndSDWsONamxDB1jYUL8pWtJcX5+52xWm5m9O7
 dNHP25AQ+uf9haETCu6fVlsksbVs=
X-Google-Smtp-Source: AGHT+IEIbyb8yqyN3WBzcbKuJ/1L0jxWZ6Wt/sQH57R8KgxevzbAT9vgrvIc2AdxFXPJm+OXOMwjGq9Gj+gMKcEkGt4=
X-Received: by 2002:a17:903:184:b0:20b:9aa:efca with SMTP id
 d9443c01a7336-20b579009eamr47443435ad.9.1727705437151; Mon, 30 Sep 2024
 07:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh>
 <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh>
 <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
 <2024090447-boozy-judiciary-849b@gregkh>
In-Reply-To: <2024090447-boozy-judiciary-849b@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Sep 2024 10:10:25 -0400
Message-ID: <CADnq5_MZ8s=jcCt_-=D2huPA=X3f5PWNjMhr88xoiKc_JFwQtw@mail.gmail.com>
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

Resending now that rc1 is out.  These should be ignored for stable.

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


Alex

On Wed, Sep 4, 2024 at 1:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Aug 27, 2024 at 10:18:27AM -0400, Alex Deucher wrote:
> > On Sat, Aug 24, 2024 at 1:23=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Aug 23, 2024 at 05:23:46PM -0400, Alex Deucher wrote:
> > > > On Thu, Aug 15, 2024 at 1:11=E2=80=AFAM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> > > > > > On Wed, Aug 14, 2024 at 4:55=E2=80=AFPM Felix Kuehling <felix.k=
uehling@amd.com> wrote:
> > > > > > >
> > > > > > > On 2024-08-12 11:00, Greg KH wrote:
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > As some of you have noticed, there's a TON of failure messa=
ges being
> > > > > > > > sent out for AMD gpu driver commits that are tagged for sta=
ble
> > > > > > > > backports.  In short, you all are doing something really wr=
ong with how
> > > > > > > > you are tagging these.
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > I got notifications about one KFD patch failing to apply on s=
ix branches
> > > > > > > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, tha=
t you
> > > > > > > already applied this patch on two branches back in May. The e=
mails had a
> > > > > > > suspicious looking date in the header (Sep 17, 2001). I wonde=
r if there
> > > > > > > was some date glitch that caused a whole bunch of patches to =
be re-sent
> > > > > > > to stable somehow:
> > > > > >
> > > > > > I think the crux of the problem is that sometimes patches go in=
to
> > > > > > -next with stable tags and they end getting taken into -fixes a=
s well
> > > > > > so after the merge window they end up getting picked up for sta=
ble
> > > > > > again.  Going forward, if they land in -next, I'll cherry-pick =
-x the
> > > > > > changes into -fixes so there is better traceability.
> > > > >
> > > > > Please do so, and also work to not have duplicate commits like th=
is in
> > > > > different branches.  Git can handle merges quite well, please use=
 it.
> > > > >
> > > > > If this shows up again in the next -rc1 merge window without any
> > > > > changes, I'll have to just blackhole all amd drm patches going fo=
rward
> > > > > until you all tell me you have fixed your development process.
> > > >
> > > > Just a heads up, you will see some of these when the 6.12 merge win=
dow
> > > > due to what is currently in -next and the fixes that went into 6.11=
,
> > > > but going forward we have updated our process and it should be bett=
er.
> > >
> > > Can you give me a list of the git ids that I should be ignoring for
> > > 6.12-rc1?  Otherwise again, it's a huge waste of time on my side tryi=
ng
> > > to sift through them and figure out if the rejection is real or not..=
.
> >
> > 8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on=
 Link
> > fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
> > ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
> > 332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
> > math_ceil2
> > 295d91cbc700 drm/amd/display: Check for NULL pointer
> > 6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
> > 93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
> > 7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_com=
mon_modes
>
> Please resend this after -rc1 is out, so we don't have to hunt for it
> again.
>
> thanks,
>
> greg k-h
