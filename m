Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E541AC0219B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 12:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6170610E27C;
	Tue, 11 Feb 2025 12:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UJy3YIZ9";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C28C10E27C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 12:00:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 959D2A40185
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 11:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36C2C4CEDD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 12:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739275211;
 bh=TA/0R93IHQ5a5+EgaK8V4VBeM1CqKJGCSR6MePdrRSI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UJy3YIZ9fCzPNCmneEjKfEMaIUNOq291JlFZ7Eaix6faH1/8mlqH+lsCbGLKUFFth
 5y+/Qf+64SNXGnUuBUdaj6deqjP3B17hVMFzfyfJzEX6UL3xp4qI/i0JdB21I9cibC
 93YzdS20pHugLhcA/F/F0g1yJoNSR4xP+pPKGmdEbyUYko4bbYYuFzw/EzXUAhrRTI
 cFbdSe3vlDSDHCRYbRUDvpeFEH3lCY2M5MW1sJzG9Odo+hx0+ICGP4FvXPisZI1vQW
 rw5uBQM6SDSyDueaNvCKvCX0C6Wq9cWgvKSWEEx02m8B+T5eSnaKXVBWg2tl/UnZem
 UwdT4DbJJ8JFg==
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5de56ff9851so6645242a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 04:00:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVQNCkdWsJAvBudmUZ2XFKuJ8vNqjaq/aVxgNHrx7C6SMbGW4bkDs0xNc61KzmDo00aI11Sc2I3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+vaTSwHAoU1PkNYdfDNN6cOuq3FQuyfSImVzwjhC1gFPbQJPh
 rd47bwOVeChr/6iBdJX4Kc2Cqa4dqjnTYorIM5JYuwtMW3lrJSmSa3KGCiBbCYDlkEsjHARKyV+
 7r7icqFpAkWYjdXaCq7uxMqX2fAs=
X-Google-Smtp-Source: AGHT+IGHNVu0tpCqBhu4Mn6yiKyLBRk68octjzuRqFLITUadZkfqBm0qT5yqHWB/5lCGcOlApRkFsS/UArIYCQrmr1k=
X-Received: by 2002:a05:6402:2381:b0:5dc:1273:63fd with SMTP id
 4fb4d7f45d1cf-5de9a4646eamr2670591a12.20.1739275210215; Tue, 11 Feb 2025
 04:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
 <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
In-Reply-To: <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 11 Feb 2025 19:59:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
X-Gm-Features: AWEUYZm-JyjLlJb0diDoeBFwWO6Ti4dJ5QC9IXpt6JgfAfQvWaJ4NXEm6A9WSfc
Message-ID: <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra <peterz@infradead.org>,
 loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Hi, Josh,

On Tue, Feb 11, 2025 at 5:26=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Mon, Feb 10, 2025 at 02:07:43PM +0800, Tiezhu Yang wrote:
> > On 01/15/2025 09:34 AM, Josh Poimboeuf wrote:
> > > On Sat, Jan 11, 2025 at 02:57:42PM +0800, Tiezhu Yang wrote:
> > > > Hi Josh and Peter,
> > > >
> > > > On 12/17/2024 09:08 AM, Tiezhu Yang wrote:
> > > > > This version is based on tip/tip.git objtool/core branch [1], add=
 some weak
> > > > > and arch-specific functions to make the generic code more readabl=
e, tested
> > > > > with the latest upstream mainline Binutils, GCC and Clang.
> > > >
> > > > ...
> > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/l=
og/?h=3Dobjtool/core
> > > > >
> > > > > Tiezhu Yang (9):
> > > > >   objtool: Handle various symbol types of rodata
> > > > >   objtool: Handle different entry size of rodata
> > > > >   objtool: Handle PC relative relocation type
> > > > >   objtool: Handle unreachable entry of rodata
> > > > >   objtool/LoongArch: Add support for switch table
> > > > >   objtool/LoongArch: Add support for goto table
> > > > >   LoongArch: Enable jump table for objtool
> > > > >   LoongArch: Convert unreachable() to BUG()
> > > > >   drm/amd/display: Mark dc_fixpt_from_fraction() noinline
> > > >
> > > > Are you OK with the first 8 patches?
> > > > What's the merge plan for this series?
> > >
> > > Sorry, my inbox is still reeling from the holidays.  I will review th=
is
> > > soon.
> >
> > What are the status of the first 8 patches?
> > What is the next step? Is there anything else to be done here?
> > I would really appreciate any advice on how to get this merged.
>
> Please post a new revision rebased on tip/master, with patch 4 dropped,
> and I'll queue them up for -tip.  Thanks for your patience.
You will queue the whole series, or the first 5 patches, or the first 3 pat=
ches?

Huacai

>
> --
> Josh
