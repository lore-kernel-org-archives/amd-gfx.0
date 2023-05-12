Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EAAC77B7C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 15:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC27510E6D5;
	Fri, 12 May 2023 15:17:57 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB9C10E6D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 15:17:54 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-192814aa343so7883133fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683904673; x=1686496673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctKppkhAw3uRkR+N6SWCnWkmJDaZRwXzqRl9zakaLVI=;
 b=YLWU0PQIt0qPnshnk+WbMGy0Px50gQSNPK19Vl1gUU7zWV9Qt9feSZsWdFyJljGwNp
 Pt3Wo4iGof6VXY2WMKUDcTX1qumZvKtzVag9kfo5TMvvrrVvbarlU3T972DPmK/cW8+1
 9R+/R+BFvC6v+cWe25ZFg5GfIe1quh72gYY027YCsTDIfMlvHIBnYvhzFmrX/DKVjq4X
 1ukeOs0d1iUr22XUMTUVB/Lhm692xVtglImstRg4rj7LIVdFBCrH0YCenDCCioxkPTvX
 cRMabkhh6IkgZXE3nXBjh5jSj4dB/NoEbhG3XnfC3MRp3Dd40HDWSGD5OW2wAi4HNpfR
 qy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683904673; x=1686496673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctKppkhAw3uRkR+N6SWCnWkmJDaZRwXzqRl9zakaLVI=;
 b=ch8DxcGPOMFliIX8A2xeY3Vr3k3ACid1fwQh2wQyfz+c1IqnoBvSoILD5gJkwDUnRL
 SPul60Uk4S3DweTuQSe1Rrly5FX6BDaML8HcLy/qDfQ/Wzbi0Ck1f/VqDrHNyj0YE922
 d7vJXfvPvYoxToCLnNfsdqMXB4QMFn2x4XG8zRB37M/fMMpwaQSkgY4GnDLLtMhgB19m
 lLpZjQrmvdeluc0JIAVflAJ1qcfl77Nl5DlrGvc2zliZGUxhLlmR2dg0mlES656H2uRJ
 SrZ+lgjauPgJLzP6GkukXW+WmHZo7QHFSglVNxLGjzmRvWnWDhGQifXoojzDpfvXm+dH
 jcQw==
X-Gm-Message-State: AC+VfDw0JI6F72hK+3h+YRM1T+Bp/HEZO/xK/T+9CaO1aBTeZSw/nImC
 lITDF2F4mF/IBJ1UsnSmE5yvX93qgoOe2n/MliM=
X-Google-Smtp-Source: ACHHUZ4rmrc0Ep+iH+w4WCG4PF2+BkLxKvQ+iN3CIt+pBpeBslZBk3HS6BqY26uH+Pwez3s2rEeG3bYwMR251ayxsCw=
X-Received: by 2002:a05:6870:4294:b0:187:be3c:28b6 with SMTP id
 y20-20020a056870429400b00187be3c28b6mr13338235oah.41.1683904672864; Fri, 12
 May 2023 08:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <588c1a66-9976-c96f-dcdd-beec8b7410f0@gmail.com>
 <3e5548e4-5a3e-9346-ec58-3617e1947186@gmail.com>
 <a50537d1f1af34104793218acb954a61@linuxsystems.it>
 <3383ba6e-e62b-cd9b-8a61-39b0de8af579@csgroup.eu>
In-Reply-To: <3383ba6e-e62b-cd9b-8a61-39b0de8af579@csgroup.eu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 May 2023 11:17:41 -0400
Message-ID: <CADnq5_Nuu+Lvt8SdHmzRZ1eZcHzoSRocGjgwCHBqf9fFd9nubQ@mail.gmail.com>
Subject: Re: Fwd: Linux 6.3.1 + AMD RX 570 on ppc64le 4K: Kernel attempted to
 read user page (1128) - exploit attempt? (uid: 0)
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>,
 Hersen Wu <hersenxs.wu@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Linux for PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 12, 2023 at 11:16=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 11/05/2023 =C3=A0 19:25, Niccol=C3=B2 Belli a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de darkbasic@linuxsystems.it.
> > D?couvrez pourquoi ceci est important ?
> > https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Il 2023-05-12 10:32 Bagas Sanjaya ha scritto:
> >> #regzbot introduced: f4f3b7dedbe849
> >> #regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/2553
> >
> > It doesn't look like the aforementioned patch made its way into 6.3 yet=
:
> >
> > niko@talos2 ~/devel/linux-stable $ git branch
> > * linux-6.3.y
> >    master
> > niko@talos2 ~/devel/linux-stable $ git show f4f3b7dedbe8 | patch -p1
> > patching file
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > Hunk #1 succeeded at 227 (offset 15 lines).
> > Hunk #2 succeeded at 269 with fuzz 2 (offset 19 lines).
> > patching file
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> > Hunk #1 succeeded at 49 with fuzz 2 (offset 15 lines).
>
> As far as I can see that patch has no Fixes: tag, so it will unlikely be
> automatically merged into stable.
>
> Has anybody requested greg/sasha to get it into 6.3 ?

This is no fix identified yet.

Alex
