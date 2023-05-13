Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D371C77B7A
	for <amd-gfx@archiver.kernel.org>; Sat, 13 May 2023 16:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCE910E103;
	Sat, 13 May 2023 16:15:42 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3269D10E103
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 May 2023 16:15:41 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-54fb0fce238so2161403eaf.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 May 2023 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683994540; x=1686586540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAwewp2kthWWSif09t8xwGEOcMXmK89hPwkmMo5Is8o=;
 b=UzeUzpMkVve/6x5RUROzP/Pr5G/uJ2wpTGBpSqFq3m33qS0mqNnW7Cqftq97NZfHqV
 DjMoLczD9/vL/YNfUpD9ThJ/dQv1asxhZByVhrnpJE1pCFmRlmCGgenZJrlzwP0Cr2LU
 xYWsKzbWXUvm6ANZ4oTPEmAXH4Dhb3jL3cp4p1Ke/xjERpKxuHRbCCSdhyiUtvT9zNHl
 +AIIGndzn2TXDGJmmHPjQBoK2OIpW6NRz6bSonKBZvZhhqhszU5T1Rzz+UI7nGcINhB2
 yR6DFmoI3i69TgKNuSv7cBx/EsmB/litG19WXpII47sKjZYVMv5+kRy1z6PwQmdGVLXr
 Wg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683994540; x=1686586540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAwewp2kthWWSif09t8xwGEOcMXmK89hPwkmMo5Is8o=;
 b=iLgrjkGqEi1QW8X4EV43iubBexCWZXFTYXR77OD3b1m3ZcQHKMil4Z9NP/d03p5hiG
 sNXlrxBj3UcCdXTrc7CQ+4fWH639+8hcutvdS5al5e19S2kGdCoTxS92zReZysv0U6/F
 cq/HRxHT5dLjTkeOOPa5o1VFyBeC03ipxPQmb1TfQbwfAZAshHatXo8oGcKmEYp2nzMA
 2uNgzkyPYs27Of8Njdy8LEiLwq04s2gqrtMu+B2Qc9ZLVv8WQzCDcQDX5fCo34H5ZQUh
 bRWBfQwqicZRbVx22tHyjLeakS2/+fLOd98ZFLqr1ti6I31FhP3ZvUBPJQAYTCnWb+2Z
 BZtw==
X-Gm-Message-State: AC+VfDwBR2AfvuC/G2xQlv/erqRAE4hvffs8R/m6hbSbXYwKCXB+iw0R
 5/10GU5cBMLjQDv6T32gW//QzsqJWLc1mbWCYIU=
X-Google-Smtp-Source: ACHHUZ4JwIaY02RrtBZwd7KHuPZBw7jqM0UkUh1Tb9GM7JscTzR1I4ronR9NBKH6BvNHjh5sREtms0J7+SCs4+C7Ido=
X-Received: by 2002:a4a:d218:0:b0:546:bf26:49c7 with SMTP id
 c24-20020a4ad218000000b00546bf2649c7mr8214553oos.8.1683994538269; Sat, 13 May
 2023 09:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <588c1a66-9976-c96f-dcdd-beec8b7410f0@gmail.com>
 <3e5548e4-5a3e-9346-ec58-3617e1947186@gmail.com>
 <a50537d1f1af34104793218acb954a61@linuxsystems.it>
 <3383ba6e-e62b-cd9b-8a61-39b0de8af579@csgroup.eu>
 <57100be6-d379-0bc7-6d45-228cd46f9c81@csgroup.eu>
 <2023051353-epiphany-retorted-4ad1@gregkh>
In-Reply-To: <2023051353-epiphany-retorted-4ad1@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 13 May 2023 12:15:26 -0400
Message-ID: <CADnq5_OqgEP1S25VfnuptWiOvicXyX3Waq8rq_62rQsqeJTXYQ@mail.gmail.com>
Subject: Re: Fwd: Linux 6.3.1 + AMD RX 570 on ppc64le 4K: Kernel attempted to
 read user page (1128) - exploit attempt? (uid: 0)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Cc: Sasha Levin <sashal@kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Michael Ellerman <mpe@ellerman.id.au>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 Linux for PowerPC <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, May 13, 2023 at 12:11=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 12, 2023 at 03:25:47PM +0000, Christophe Leroy wrote:
> >
> >
> > Le 12/05/2023 =C3=A0 17:16, Christophe Leroy a =C3=A9crit :
> > >
> > >
> > > Le 11/05/2023 =C3=A0 19:25, Niccol=C3=B2 Belli a =C3=A9crit :
> > >> [Vous ne recevez pas souvent de courriers de
> > >> darkbasic@linuxsystems.it. D?couvrez pourquoi ceci est important ?
> > >> https://aka.ms/LearnAboutSenderIdentification ]
> > >>
> > >> Il 2023-05-12 10:32 Bagas Sanjaya ha scritto:
> > >>> #regzbot introduced: f4f3b7dedbe849
> > >>> #regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/2553
> > >>
> > >> It doesn't look like the aforementioned patch made its way into 6.3 =
yet:
> > >>
> > >> niko@talos2 ~/devel/linux-stable $ git branch
> > >> * linux-6.3.y
> > >>    master
> > >> niko@talos2 ~/devel/linux-stable $ git show f4f3b7dedbe8 | patch -p1
> > >> patching file
> > >> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > >> Hunk #1 succeeded at 227 (offset 15 lines).
> > >> Hunk #2 succeeded at 269 with fuzz 2 (offset 19 lines).
> > >> patching file
> > >> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> > >> Hunk #1 succeeded at 49 with fuzz 2 (offset 15 lines).
> > >
> > > As far as I can see that patch has no Fixes: tag, so it will unlikely=
 be
> > > automatically merged into stable.
> > >
> > > Has anybody requested greg/sasha to get it into 6.3 ?
> > >
> >
> > In fact, it seems that patch is already part of 6.3:
> >
> > $ git tag --contains f4f3b7dedbe8
> > v6.3
> > v6.3-rc5
> > v6.3-rc6
> > v6.3-rc7
> > v6.3.1
> > v6.3.2
> > v6.4-rc1
>
> And that commit is already in the following releases:
>         5.10.177 5.15.106 6.1.23 6.2.10 6.3
>
> So what needs to be done here?

Nothing needs to be done here.  We still don't know what the problem
is.  We are working on the issue on:
https://gitlab.freedesktop.org/drm/amd/-/issues/2553
Let's just track it there.  This email thread is just causing confusion.

Alex

>
> confused,
>
> greg k-h
