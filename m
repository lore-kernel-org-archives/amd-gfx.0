Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10971FF8875
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 12:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA4610EBF4;
	Tue, 28 Apr 2026 12:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TLgKiC9I";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AA110E852
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 17:17:25 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c7212836bso81172c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 10:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777310244; cv=none;
 d=google.com; s=arc-20240605;
 b=hW/yEYbhwODOSWHUhRsKyKwgEZbLLVEUct5WwQt934u02vBQvHBIdW8Ggs7YK2x0gW
 MTIvADUIZKfgg5TMVmgMbVgxYg+mxixwFeYGSGNcZj+EsjjYVaPlDUtpisNZu3CD3hjC
 dMBSTSeFEI5pxwsTjiSw9/0fWbF0ROFckF60uTUHSW131BfW40Itwrg96dPCZSAI8wa2
 3+VTboz9ws0xCqPKgjvZrg0OrD5/c9S8+LXPiFuQlu8FosCJmNWdBJizZ3RZ+5xmSYQl
 pFn/ahufQsTinPMRIahtpyOjIO259R9noQbcYePpSIaZT3GISXbUalcFP+9xAb4HHCWh
 ldgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d76/vhNDwu/QAcZIz5Xx/7XZ2Yg2CBZFye37EPl8zpI=;
 fh=kdA52a1Mm+omqsf2MPi2zJ3xY/DGYEdA+ugX5gm3PTI=;
 b=hNgudeH59827gYB2LrBJ+yqGCIEHoMPeBZGRZoosMWzIso/eF4IZvyz0MqwlZRcgOU
 /H/XIgk7nWvu892fKtjxXJ5x88a4JERFIVNTa89y716qV4nSkXWzofdrE4ybWfI9W4TK
 EVayWqLA7slO9nDtSGNSp/cX/3t+P6kisskde9QIBreevRuZYeEKLzyMcBHaIDHHrsD1
 qWp2jUxEPlQ/zaUZ43d22+3TfqEbC1xsP48YOjXKrHlh5M2hgYEOM4xQQrTsNtsgctWA
 R4OFsfRKnTapRiAwG3sEX3sDzJXTjMwmNp8RjkBe7et4J60GzY6nAA9lBeTyC5ciFBQP
 4XSA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777310244; x=1777915044; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d76/vhNDwu/QAcZIz5Xx/7XZ2Yg2CBZFye37EPl8zpI=;
 b=TLgKiC9I/qT3WCJfetjVNsEgZMrVo3+Edv+szrnIvKsyq4ptDoHvNjgNukv+oyfWCY
 XiauCg2+TQJ7JCxfs39D7hKhc19Iteha+dS5zmLcnIW0TP8OuaUVemuo0IsIfkyeO+qT
 B7y7B2BLxPPr+mlTud/CpXU1/z2UylCYCvw3Vj/IQbCRZvE4B6Uqk0LSNLu7rOL1fHhB
 M5Rtwv0D/L3gp1+NGOFzFqaWJlN+Q3F9QElqi/mnGtUhR71/CzpnUgO3Y+U5+YY5beqg
 NTYmI6g7jOfPYBVr6m4bP6L5Fm4J8EED3qzJXCNtMlA2d37sojBb4Owyu0eWywO1A272
 JzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777310244; x=1777915044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d76/vhNDwu/QAcZIz5Xx/7XZ2Yg2CBZFye37EPl8zpI=;
 b=OBTsG78qBko4zPmO1EvD7JbCkvuRUXlCAV99wQj48UkrXPth2P1Ho+XW+GYg7q6iaW
 z2/il3q9Q1cZ9UFIEuj7tT7nW0B14/uyqY2X5FO9+mb1QiPBQ2qn0ysvL6/bDhKY22Ds
 qSV0Jk0hng0Htbrw8GI+Tw3GWW9VckRu3rqHCbg0l8U/GQM3gZp0TA8PI0BBCd+XE4lH
 q/rNNTvu79E4Tt/ut/bDwUFfEYcsoW07M8NPoDHQIZj2/s7ym1W7czx0nAYaBw2/uXao
 tF2wDaIpEf214nYxNFX60VCCRAthav4u1jnC35hs3A35jr5JF9Zwhq4Z6o4NAniqTq0U
 yS1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1VfezuqrR7wtFcH3lkdpDCvqo4b9rqUuuwzkJcmDHw+CoM+gBhCIBNIXpIwy7J8/BROg2th3s@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGWadwLgcrYyi7GUYtB/mootnu9oHy/dOUbEzKQKasiSY2FsJV
 ytmKN+MSTebRAx6CSZQ8oAaDRx+OrN9crZUzv3pmMobD5UfQA4VKUwUWlK/AW0qe3fxp6xMJJWx
 I/6YjqH0HwHYYGzGxgYRXX9hD4MZjYiI=
X-Gm-Gg: AeBDietZNRp6wMCMzsplgGRl+y79r8Gks8BmSu34oA8C7sWJpIO+Uz5njpkKjirHDQL
 R/FsbFdMYtkketSZ3UfsqLDoZzmLExALAo192lJh5bwxHPCAZRJQKA4OPBH7GMu+3eyBruHzL1Q
 RwY7u1sQxCZEN57bGbrSJBjgIV7ICnwPCA5OHLEBbdNK8c8Xu7o7sQqUj9VD6nsxzJg8LnWBsjw
 uJjLT22uPbjbZlT5KMDEBsGHKgupfBibALFP8I53mwBbJFzQZa+uvEDQGFOuWI3vvNfJke4H2iW
 dvY2JxaQiEsoxTz1Iq8=
X-Received: by 2002:a05:7022:42:b0:12d:ca31:f1b5 with SMTP id
 a92af1059eb24-12ddd538ab8mr116171c88.26.1777310244307; Mon, 27 Apr 2026
 10:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAMYTvdA+yCqU4_9mzMUkX_3S=myExKMBCyB88dYWCMwA1edsrw@mail.gmail.com>
 <6c48aff5-b6ee-40af-98f0-c26ded3095bc@leemhuis.info>
 <ed3171ef-eda8-4907-a35b-2e2b8185e574@leemhuis.info>
 <2730559.vYhyI6sBWr@timur-hyperion>
In-Reply-To: <2730559.vYhyI6sBWr@timur-hyperion>
From: Brandon Taylor <br.ta.2818@gmail.com>
Date: Mon, 27 Apr 2026 12:17:13 -0500
X-Gm-Features: AVHnY4IAw3_4fcOnTdNIs8ulSKBdL22VjTacDK_lOq82_bswTKBvGSkYygld3KU
Message-ID: <CAMYTvdCtpKsHAjBtZOK8MK4dYJUTUMCwgsur50Np3+yJhnic+A@mail.gmail.com>
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

> I'm happy to help, there is no need for personal insults.

Sorry if I came across as insulting; that was most definitely not my
intention. I simply know Linus' penchant for going insane when an
error is found in his kernel. But I'm thinking Timur's probably right;
this may merely be a "me" problem, with my particular GPU.

At any rate, I've created the issue ticket as requested, and here it
is. https://gitlab.freedesktop.org/drm/amd/-/work-items/5220

Brandon Taylor

On Mon, Apr 27, 2026 at 9:01=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Hi,
>
> Thank you Thorsten for forwarding this to me, indeed I am working on impr=
oving
> the driver for these GPUs. See my replies below.
>
> On Monday, April 27, 2026 11:37:53=E2=80=AFAM Central European Summer Tim=
e Thorsten
> Leemhuis wrote:
> > [note: please remove Timo Lindfors when replying to this mail and
> > include Timur Krist=C3=B3f =E2=80=93 sorry everyone and especially Timo=
, my mailers
> > address book tricked me]
> >
> > On 4/27/26 11:35, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > On 4/26/26 01:22, Brandon Taylor wrote:
> > >> I have an AMD Radeon R9 270X GPU (yes, I know it's old) which used t=
o
> > >> default to the `radeon` firmware
> > >
> > > FYI, as using the wrong terms can lead to confusion while dealing wit=
h
> > > bugs: that's not a firmware, that's the driver (sometimes also called
> > > kernel module)
>
> - "radeon" is the old kernel driver for these GPUs that didn't support Vu=
lkan
> and therefore was mostly useless for gaming.
> - "amdgpu" is the new driver, which supports Vulkan and offers better per=
f,
> this is the default since Linux 6.19.
>
> I don't think this is a firmware issue.
>
> > >
> > >> on kernel versions up to and
> > >> including 6.18. I could manually change this behavior to use the new
> > >> `amdgpu` firmware by setting `radeon.si_support=3D0 amdgpu.si_suppor=
t=3D1`
> > >> as kernel parameters in the GRUB bootloader. Everything worked fine,
> > >> and I was able to play my Windows games without any problems.
> > >>
> > >> That was, until kernel version 6.19 came out.>
> > >> 6.19, from what I was able to Google, was supposed to have AMD GPUs =
to
> > >> default to the new `amdgpu` firmware. Unfortunately, when I updated
> > >> the kernel and rebooted, I got a black screen.
> > >>
> > >> Further Google searches led me to reboot, set `nomodeset` in the
> > >> kernel parameters, switch to a TTY, login, and investigate the outpu=
t
> > >> of a `dmesg` command =E2=80=94 and what I saw ... Well, let's just s=
ay it's
> > >> the kind of thing that would make Linus go Chernobyl:
> > >>
> > >> `amdgpu: probe with driver amdgpu failed with error -22`
> > >
>
> I am sorry this happened and understand the frustration.
>
> Please open an issue here:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/new
> and upload your full dmesg log. Please ping me personally @Venemo on that
> issue after you opened it so we can start investigating what is wrong the=
re.
>
> I got curious so I plugged in my R9 270X right now. I am typing this emai=
l on
> a computer with a Radeon R9 270X using Linux 6.19.12 on Fedora 43 and it =
works
> fine. We are going to need to need more details in order to diagnose what=
 the
> problem really is. We might ask you to test some proposed fixes, consider=
ing
> that the issue doesn't happen on my R9 270X, I don't have a way to verify=
 it.
>
> > >> Now, I hope to God that this email finds whoever is responsible for
> > >> breaking this `amdgpu` firmware before the same thing happens to Lin=
us
> > >> via Fedora 44, and he goes berserk. I realize that's not a heck of a
> > >> lot of time, but God only knows HOW many Linux users with AMD GPUs a=
re
> > >> pissed off by this kind of issue =E2=80=94 and I for one can only im=
agine how
> > >> Linus' reaction will compare when it happens to HIM!
>
> I'm happy to help, there is no need for personal insults.
>
> (Note that the issue clearly doesn't affect all AMD GPUs and it clearly d=
oesn't
> even affect all R9 270X GPUs.)
>
> Thanks & best regards,
> Timur
>
>
>
