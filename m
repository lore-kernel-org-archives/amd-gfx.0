Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E27DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 09:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3035B10F28A;
	Tue, 21 Dec 2021 09:13:39 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510CF10E8EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 22:21:21 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id j6so23439229edw.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r30iBIyWjnX41jQlxRLQq+U2Vmh6ouGiDx8IaIMps/o=;
 b=bNh4BbSWLmQUsoqKGAd78Kt78amPXofxdjNr6iFIPrTbKiJQ6g8sSTwrHuZVhpIB6V
 pspDnusT+gEj4NVwvnKn2kMglf/GuyFyo6CR6p+MULnIoayJJfPaoax8pMWYwVaHOQpx
 PkXw/f36QOrx7BAX9QN/8qHB+rHTPj506xPVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r30iBIyWjnX41jQlxRLQq+U2Vmh6ouGiDx8IaIMps/o=;
 b=DvGg9imd7kRBumqCOsAdSrQR00WdxVP5eA9CfsTisIY4rn0KXMSavi92CLG+Bf6pB3
 c15b9Ymu9qwUVhh2Woh+3OM6CDbvB/yq1wAFHxXMIQtt/PYUpzEteczmnDCv+46zWBK1
 T01/G/kXOJ6hscuFm3dmMGEC3ceEbIvpGpPk60rh+50LuQSee8BxvBeBTgAC3H/WywYB
 QdzwRFFebo9eVMgFjXUo3gsttX2SHaliKQ/5W3AUTWOvxyVgfJ7/ppF6IvIdskU+O6M/
 SdX4fvp5VzpVg7ixXJzL69lfQDcivr23dVT857v2uuG10/K4255fB8LkFyOuhihTuo7r
 z+1g==
X-Gm-Message-State: AOAM533pVEe+Jy37mXU8YG1fcHg+qPr1dtqnMCuD/ld/dnHmZ58zd7bU
 RrY9gzYGdLWnqKtRrXJnJunzqANBpgNWEv/Id9Q=
X-Google-Smtp-Source: ABdhPJymyY43CY890PiqQZA2FPuIRoBtpAhiNkDwurLQmTMdruzHCf6uNw4n1Ih9LDKmCXKd/WT1qA==
X-Received: by 2002:aa7:d619:: with SMTP id c25mr177509edr.405.1640038879702; 
 Mon, 20 Dec 2021 14:21:19 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47])
 by smtp.gmail.com with ESMTPSA id b5sm3113717edz.14.2021.12.20.14.21.19
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Dec 2021 14:21:19 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id s1so17520925wra.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 14:21:19 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr152576wru.97.1640038878828;
 Mon, 20 Dec 2021 14:21:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjs4AjAKJ26W69xcMB7snFc+0u+rbgA+Tj0S1GvwY2T3Q@mail.gmail.com>
 <20211220213254.GA7250@ideak-desk.fi.intel.com>
 <CAHk-=winh9=DS2ZJZbgwTFS3r3oWfrZcM9MedQ4dKzsGW8QaTA@mail.gmail.com>
In-Reply-To: <CAHk-=winh9=DS2ZJZbgwTFS3r3oWfrZcM9MedQ4dKzsGW8QaTA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Dec 2021 14:21:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtGHeEqE9e-NSYQ51pU8QR13CL5Njp_wh9n2hwPiKZEg@mail.gmail.com>
Message-ID: <CAHk-=wgtGHeEqE9e-NSYQ51pU8QR13CL5Njp_wh9n2hwPiKZEg@mail.gmail.com>
Subject: Re: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release PCI
 device ..."
To: Imre Deak <imre.deak@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Wentland, Harry" <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 21 Dec 2021 09:13:38 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[ Adding back in more amd people and the amd list, the people Daniel
added seem to have gotten lost again, but I think people at least saw
my original report thanks to Daniel ]

With "amdgpu.runpm=0", things are better, but not perfect. With that I
can lock the screen, and it has to go through *two* cycles of "No
signal, turning off", but on the second cycle it does finally work.

This was exposed by commit 55285e21f045 ("fbdev/efifb: Release PCI
device's runtime PM ref during FB destroy"), probably because that
made runtime PM actually potentially work, but it is then broken on
amdgpu.

Absolutely nothing odd in my setup. Two monitors, one GPU. PCI ID
1002:67df rev e7, subsystem ID 1da2:e353.

I'd expect pretty much any amdgpu person to see this.

On Mon, Dec 20, 2021 at 2:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Note: on my machine, I get that
>
>    amdgpu 0000:49:00.0: amdgpu: Using BACO for runtime pm
>
> so maybe the other possible runtime pm models (ARPX and BOCO) are ok,
> and it's only that BACO case that is broken.

Hmm. The *documentation* says:

    PX runtime pm
        2 = force enable with BAMACO,
        1 = force enable with BACO,
        0 = disable,
        -1 = PX only default

but the code actually makes anything != 0 enable it, except on VEGA20
and ARCTURUS, where it needs to be positive.

My card is apparently "POLARIS10", whatever that means, which means
that any non-zero value of amdgpu_runtime_pm will enable runtime PM as
long as "amdgpu_device_supports_baco()" is true. Which it is.

Whatever. Now I'm just kwetching about the documentation not matching
what I see the code doing, which is never a great sign when things
don't work.

              Linus
