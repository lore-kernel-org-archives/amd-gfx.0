Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D0BFF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 12:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5745B10EBF9;
	Tue, 28 Apr 2026 12:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FBhWctQ4";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE82510E8DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:50:37 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8a08fa355a1so154990456d6.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777315837; cv=none;
 d=google.com; s=arc-20240605;
 b=c/g+p8Bcy0Dua1pc2QKR6mTY6OneB+OnXhWy71J5cvukA6GiRFua9YNhQRai3GUUFN
 3rHaENMWSRs3Rt8coB8l11eLNHqruNujywEwFEsUi23BKTrozJQ+2yNUWVg1B4FVGj/B
 x8nfqiPkf1qev58KT01oVUtOzyRYFVov2RybdkB20IYFIpEtNgsZ9OaO6Anui6bSj523
 XyV8qmlinGA6gOO0ch5oYAs/o3ATLE1psqRXetPQSiSe07Xl/Ds6SFY3TcOdUc2K/jqN
 smD0fIiRW8yVMSqlgukFh2wqwpbHDOueploGZaczklbyNLcDrf9IcgUXELZGqqaZJMHe
 c6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dSOLFHYy9SI+n2qm+x6JMljLNJ1ZfRjTG3TVFgX8eK8=;
 fh=F71s72l3sSGc21cIhK/1muzbs/ShGeR9mm3F4TMRt3w=;
 b=egh1SWBjFH4AoiOPDuBTcjVmpY3l7EnVVxq8S7XwD1Hnu1d2ga4lFDSZYl7nY9Nt3U
 kLsUM0KrPWnLoC2RgJg3wVNbxwqZr02VSHPEL00RjchFZIoUh7uaY9bsmIetbgebZjgZ
 MMrOS45Y2bEaMJAYahC285BvPeSPDu2949MMs7bRjO/D6ssssPmQipkgP1/lG5As+WuN
 SOLgeWxNq3BknoxmzVkJiSL1raOOplbRwIwKIcaIXOfCOVaw7EpNOKPoqWxT/KtsrhD+
 oRglgES+M+Ok2G/lrD7jI17VJUFXh9IqfN929mFiHQ2Wlchqrq6CxDygZhvwcB8s3PRv
 q82g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777315837; x=1777920637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSOLFHYy9SI+n2qm+x6JMljLNJ1ZfRjTG3TVFgX8eK8=;
 b=FBhWctQ4J9IRRb+eND5p1AdE/pXoAbYgqmpi+58Mr9ktuL5HSK2lGUFoVeVLFm9bUc
 6RoCNYQDWPnvJ+EjQ9SNuBeUH7YQhTmInYI8R8TY0Er85hLl8g9O5JDIQ6tzRoMyhymW
 cV0fE/3uExchcFS6IndDfwrhIXGQ7Unfn0CGVPax7JVniH3mOi+0ZRXQx3yZow7eablh
 XLujI/rEeNVRKXBwxqL5NDLpuRsPhKeqRxzWCc45GooH6h9kki2Iz0vCYF0BpuimCiO5
 F0m7YN8hsZNdDg/9GHV8R8/b4WkmX95KXhXSp9pCT2R8QUMl4k0r0ebUQ3h/hGjvEjsC
 aLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777315837; x=1777920637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dSOLFHYy9SI+n2qm+x6JMljLNJ1ZfRjTG3TVFgX8eK8=;
 b=USupSzLdzwLNX/JQ0VkFgBDOvjDG5WQyJfA8iYbTpmQuU2FaIeybCyKEpMXZZiplRk
 cb2E0QA6ioLpW4rS04W76SOo/iYBwdI+g3Jjeq8Voi5x8onrxeuRC9KO9uPvv6gWyCtA
 rsgsH62GmApXK7cbuKjceMCSt2qcxteDiUaO+EUg6GBEQ2f1rYbvKNiuhg++5xE3GVC5
 aIaEx7cYdlN6GbOBNhjciF1IN3GM1lzi5hljlQKB6GjGDPjBXJpuZ5QHb2niJsy42Hv7
 kOl+c8pvDbQ7m+th9qW4kZpiLmwrLGY7e62U8f76+QwicK9EiflbJIh/tDrkbNvTXUYE
 uw5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JCkcWTNLOimiE7MUXsifQHX8PfYlD+7aIIzy3l5tOAM0w+PD/vr2ipr8RSqDepoWKXgUrbcZD@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7I2lDiz8rihQpOfc8Ai8/USXhRwN9NJDEQRjsi4H5+AG4MjG0
 rZ7IKNBhrr0LLMbF+cR/qK1JhaVV/duQ8ZgQ1LhG1xmWtTS9Df+QCHmoJhZv5VeBTSqWGxqerUM
 ztN3NG4ecyhQk6If5JvhUBSnnGIy9S5U=
X-Gm-Gg: AeBDieuVAoj+WBmwXZwwlP3HG4jmt5Z3JPDGbSu13dfRYD1rYAgteidSJu4P90CGG3h
 ViazCflyn4p0Nbu5z5tXYJ77YpK9UE3ceIIgt6BQ+EAflxV6HfdpQ+U2dcAjlDZhxUQtpmN+Qaw
 b7QCBQzMHRksutNs8JIXxSE8l43CU8+nLjrUEEwWZmI1FHrHNxgBHIC5psm0cJ7bHjGk33rd82E
 lNZ72DwoSPsy9TnbST6YUNJwvZvmvnfCUhwTQ4ZQzfP4szABwKZu64ygeMawEnpjCZL85XQrxU4
 IcfrTOkJCqeEDRBVd3hSz88r8DwDVCATgiHt6VLEPb+PYdcc0V2fM0rmYwN/n8HnxsCGP5QEgFk
 U/UBC
X-Received: by 2002:ad4:5ded:0:b0:8ac:b402:9af1 with SMTP id
 6a1803df08f44-8b3e3205df3mr441996d6.47.1777315836740; Mon, 27 Apr 2026
 11:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAMYTvdA+yCqU4_9mzMUkX_3S=myExKMBCyB88dYWCMwA1edsrw@mail.gmail.com>
 <6c48aff5-b6ee-40af-98f0-c26ded3095bc@leemhuis.info>
 <ed3171ef-eda8-4907-a35b-2e2b8185e574@leemhuis.info>
 <2730559.vYhyI6sBWr@timur-hyperion>
 <CAMYTvdCtpKsHAjBtZOK8MK4dYJUTUMCwgsur50Np3+yJhnic+A@mail.gmail.com>
In-Reply-To: <CAMYTvdCtpKsHAjBtZOK8MK4dYJUTUMCwgsur50Np3+yJhnic+A@mail.gmail.com>
From: Brandon Taylor <br.ta.2818@gmail.com>
Date: Mon, 27 Apr 2026 13:50:22 -0500
X-Gm-Features: AVHnY4IQNm3dpuDauCnGB_2PCuwhP_WQrG9Oj5XltDol9MaO7I-m1eWlHy-qYHo
Message-ID: <CAMYTvdAbvH9EDz1jBpx2gc4-S=JML-CqiuH1e9eGJHzS7O3wOw@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu error -22 first encountered in kernel 6.19,
 not fixed in 7.0
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Linux regressions mailing list <regressions@lists.linux.dev>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 28 Apr 2026 12:54:19 +0000
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

Sometimes I hate copy-and-paste with a passion... Here's the corrected
link. https://gitlab.freedesktop.org/drm/amd/-/work_items?show=3DeyJpaWQiOi=
I1MjIwIiwiZnVsbF9wYXRoIjoiZHJtL2FtZCIsImlkIjoxNTAxNzl9

On Mon, Apr 27, 2026 at 12:17=E2=80=AFPM Brandon Taylor <br.ta.2818@gmail.c=
om> wrote:
>
> > I'm happy to help, there is no need for personal insults.
>
> Sorry if I came across as insulting; that was most definitely not my
> intention. I simply know Linus' penchant for going insane when an
> error is found in his kernel. But I'm thinking Timur's probably right;
> this may merely be a "me" problem, with my particular GPU.
>
> At any rate, I've created the issue ticket as requested, and here it
> is. https://gitlab.freedesktop.org/drm/amd/-/work-items/5220
>
> Brandon Taylor
>
> On Mon, Apr 27, 2026 at 9:01=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof=
@gmail.com> wrote:
> >
> > Hi,
> >
> > Thank you Thorsten for forwarding this to me, indeed I am working on im=
proving
> > the driver for these GPUs. See my replies below.
> >
> > On Monday, April 27, 2026 11:37:53=E2=80=AFAM Central European Summer T=
ime Thorsten
> > Leemhuis wrote:
> > > [note: please remove Timo Lindfors when replying to this mail and
> > > include Timur Krist=C3=B3f =E2=80=93 sorry everyone and especially Ti=
mo, my mailers
> > > address book tricked me]
> > >
> > > On 4/27/26 11:35, Linux regression tracking (Thorsten Leemhuis) wrote=
:
> > > > On 4/26/26 01:22, Brandon Taylor wrote:
> > > >> I have an AMD Radeon R9 270X GPU (yes, I know it's old) which used=
 to
> > > >> default to the `radeon` firmware
> > > >
> > > > FYI, as using the wrong terms can lead to confusion while dealing w=
ith
> > > > bugs: that's not a firmware, that's the driver (sometimes also call=
ed
> > > > kernel module)
> >
> > - "radeon" is the old kernel driver for these GPUs that didn't support =
Vulkan
> > and therefore was mostly useless for gaming.
> > - "amdgpu" is the new driver, which supports Vulkan and offers better p=
erf,
> > this is the default since Linux 6.19.
> >
> > I don't think this is a firmware issue.
> >
> > > >
> > > >> on kernel versions up to and
> > > >> including 6.18. I could manually change this behavior to use the n=
ew
> > > >> `amdgpu` firmware by setting `radeon.si_support=3D0 amdgpu.si_supp=
ort=3D1`
> > > >> as kernel parameters in the GRUB bootloader. Everything worked fin=
e,
> > > >> and I was able to play my Windows games without any problems.
> > > >>
> > > >> That was, until kernel version 6.19 came out.>
> > > >> 6.19, from what I was able to Google, was supposed to have AMD GPU=
s to
> > > >> default to the new `amdgpu` firmware. Unfortunately, when I update=
d
> > > >> the kernel and rebooted, I got a black screen.
> > > >>
> > > >> Further Google searches led me to reboot, set `nomodeset` in the
> > > >> kernel parameters, switch to a TTY, login, and investigate the out=
put
> > > >> of a `dmesg` command =E2=80=94 and what I saw ... Well, let's just=
 say it's
> > > >> the kind of thing that would make Linus go Chernobyl:
> > > >>
> > > >> `amdgpu: probe with driver amdgpu failed with error -22`
> > > >
> >
> > I am sorry this happened and understand the frustration.
> >
> > Please open an issue here:
> > https://gitlab.freedesktop.org/drm/amd/-/work_items/new
> > and upload your full dmesg log. Please ping me personally @Venemo on th=
at
> > issue after you opened it so we can start investigating what is wrong t=
here.
> >
> > I got curious so I plugged in my R9 270X right now. I am typing this em=
ail on
> > a computer with a Radeon R9 270X using Linux 6.19.12 on Fedora 43 and i=
t works
> > fine. We are going to need to need more details in order to diagnose wh=
at the
> > problem really is. We might ask you to test some proposed fixes, consid=
ering
> > that the issue doesn't happen on my R9 270X, I don't have a way to veri=
fy it.
> >
> > > >> Now, I hope to God that this email finds whoever is responsible fo=
r
> > > >> breaking this `amdgpu` firmware before the same thing happens to L=
inus
> > > >> via Fedora 44, and he goes berserk. I realize that's not a heck of=
 a
> > > >> lot of time, but God only knows HOW many Linux users with AMD GPUs=
 are
> > > >> pissed off by this kind of issue =E2=80=94 and I for one can only =
imagine how
> > > >> Linus' reaction will compare when it happens to HIM!
> >
> > I'm happy to help, there is no need for personal insults.
> >
> > (Note that the issue clearly doesn't affect all AMD GPUs and it clearly=
 doesn't
> > even affect all R9 270X GPUs.)
> >
> > Thanks & best regards,
> > Timur
> >
> >
> >
