Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE4AC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 20:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4175B10EA11;
	Mon, 28 Apr 2025 20:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G9W/Y6Qp";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E063110EA11
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 20:29:50 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-af907e48e00so306008a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745872190; x=1746476990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muruLZ8jDogUrA97U90RpTPwvwdtevKxgVq9iGiXD/0=;
 b=G9W/Y6Qp7aRIa9tDmbgMYB0ZVjT3TXCsTcS7xp0uOSm2dueFqrU4KG9NGkCMRdhLZe
 AC1soWvfCwrJ5beCk7yK6A1T1xyxR3nun2U8/uGkG0ySom0+02h/SLgY3oJZ/Q62Hz2H
 0Llgjige1zPKRKH7OaSzTb4XA1wWFGMT8IphrmMjmCeANueA0IuKU2rVExcw5bWI4arz
 vAG6ET5CpHl4ByR2X2SZN/4CEVIeErzGwAJE6o+80wKlWlFcuBvX5orqAtYYAWFOOEqA
 W4xppcZ/KZIsYVegnQP+djC+Ob3DUcxluAqCUZ7mO9PM/RswlarpjO2mLTDSxuyOB+gG
 nDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745872190; x=1746476990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muruLZ8jDogUrA97U90RpTPwvwdtevKxgVq9iGiXD/0=;
 b=TNpb6USvYwLcrj+UnQ3JhWn7LELXe6XdiXjQqusHNfpJPCagmM47u6mQNSbh4IfyNB
 c0YedJUJ9VkoSEEAZ1V4tJAHeP67m+8cgLiqu8QSnbeOvLZAdVeZ7t7NzkO+xcwcKfXn
 R7sZ3tZT7EPcoDf0xZ0ryCmd62aa5kbeMJwN+y/t+q6PqryEVI51EX8sncDZWOItabQZ
 hpo0c4zBSJcb70uCKZTQaGChvWfLn+bypuiOHJu7Hy2Whhke2L5z51JwPicuLOtZndY/
 v/7MLdKhaQK+XWfY7MF7eNDLW+Um62sFXvyOn+u7rDKppqDqKTD461DroMpaQ7tkDFo3
 0NPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgNdv8aEudstjkfX4hZH1EGOGSkB5V/UgDgvk9NufmMLJc9kDv381flNZQamdVr86A9hxoABhZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywc71ia5xvOHWJoPR9p9VDsSFHZVNB93ayeVyQWoXrNXeBjlqdk
 eWf0W8ha4QXmhijTMfmSU+Vk7eS12b45GbbOhw3KpGeQWwfJ8SZz7Y9a6hct6L0U4u5WYzTAIaR
 8zEf8K/jEmTKyNXEtC4sNwyMkW6I=
X-Gm-Gg: ASbGnctotBlKJzDNXcj2ME3T/7jy0pRFZXnhcFDnLWZM5UDMZ37OVTFC/ZnqATYIk/R
 OE3Ux+uyJVxcxdeoSiKYLE6Wmvwi+lCm7ZwS6razp8V3TEBqQsAytGv+xGfd729uUO2KI9U6DS/
 sPGkS/yhLsTRSWsjtKVacjhw==
X-Google-Smtp-Source: AGHT+IEUTtzLxs5g5kci6lKCF5KVuZ0xnaZX56Mvsf90g0KbQUQr8wiEQn+WQgoSjGtyk87mNvopu1KNHYsC8JAMUx4=
X-Received: by 2002:a17:90b:4d08:b0:304:eacf:8bba with SMTP id
 98e67ed59e1d1-30a220c9efdmr372231a91.4.1745872190315; Mon, 28 Apr 2025
 13:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250114132856.19463-1-yangtiezhu@loongson.cn>
 <ab7f1ba8-a49c-41a1-9b6f-ca142fbbe9d2@aosc.io>
In-Reply-To: <ab7f1ba8-a49c-41a1-9b6f-ca142fbbe9d2@aosc.io>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Apr 2025 16:29:39 -0400
X-Gm-Features: ATxdqUGv1ycYYD9t-wVox9vr8AM5Fx_3PDDiQ8wX5TQlGWUKZ2inXTmqYb8_VfM
Message-ID: <CADnq5_PCMDBVQn6sL7_3C=aHk-b-wn-JzPnQoTun7DcqN1PNrQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] drm/amd/display: Stop control flow if the divisior
 is zero
To: Mingcong Bai <jeffbai@aosc.io>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Huacai Chen <chenhuacai@loongson.cn>, 
 Nathan Chancellor <nathan@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
 amd-gfx@lists.freedesktop.org, llvm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>
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

On Tue, Apr 22, 2025 at 11:55=E2=80=AFPM Mingcong Bai <jeffbai@aosc.io> wro=
te:
>
> Hi all,
>
> =E5=9C=A8 2025/1/14 21:28, Tiezhu Yang =E5=86=99=E9=81=93:
> > As far as I can tell, with the current existing macro definitions, ther=
e
> > is no better way to do the minimal and proper changes to stop the contr=
ol
> > flow if the divisior is zero.
> >
> > In order to keep the current ability for the aim of debugging and avoid
> > printing the warning message twice, it is better to only use ASSERT_BUG=
()
> > and SPL_ASSERT_BUG() directly after doing the following two steps:
> >
> > (1) Add ASSERT_BUG() macro definition
> > (2) Add SPL_ASSERT_BUG() macro definition
> >
> > This version is based on 6.13-rc7, tested on x86 and LoongArch.
> >
> > Tiezhu Yang (3):
> >    drm/amd/display: Add ASSERT_BUG() macro definition
> >    drm/amd/display: Add SPL_ASSERT_BUG() macro definition
> >    drm/amd/display: Harden callers of division functions
> >
> >   drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c  |  2 +-
> >   drivers/gpu/drm/amd/display/dc/os_types.h           |  7 +++++++
> >   drivers/gpu/drm/amd/display/dc/spl/spl_debug.h      | 11 +++++++++++
> >   drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c |  2 +-
> >   4 files changed, 20 insertions(+), 2 deletions(-)
> >
>
> Gentle ping on this series...
>
> Harry and Huacai, can you please take a look at this updated series
> (since you have both provided comments on previous revisions?), thank you=
!

I grabbed this series, but after reading this thread:
https://lists.freedesktop.org/archives/dri-devel/2025-April/503021.html
I'm wondering if it wouldn't be better to just allow the divide by 0
rather than triggering BUG().

Alex
