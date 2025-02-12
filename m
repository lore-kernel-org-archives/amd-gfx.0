Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB01C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 07:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D980A10E7C4;
	Wed, 12 Feb 2025 07:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dcQhR5le";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFB210E7C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 07:22:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 411E65C010D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 07:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDA3C4CEDF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739344978;
 bh=5tF4DvzDsVt7KQ/mFgmWdWH6GKf+bgfdnRM0E/Qka0c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dcQhR5lebHxfdK1vHdGgzMSiIWrxtwV10WzDMSDwKZJWyRUlX97wK7f3hxXu+thbJ
 QOmyMuOrodb3sNXvU+e0xCIDPInA+frr0zbnFou5EnQWr1EUo9nDMBKrZ46N5R83Vr
 sxXqQ1+s3CJZrBC8jxUpKjwdAw2mDszEbNfGIoN4YG/uXb9AE87xfAa1fR/D9rtO58
 W/Vl+TboOcpUDykNJ0b1DcAFz5k0h4wPdH6Io9MwhkeRwtonoo+5a9AL57Ed6Uolsh
 YlBXEqDeHtxmXPaRhTJhKAaDthABCUHBhRy9KsBWubqdQ3Y7abyi/IwBkCEW1BqN6Y
 io2IEYvrfiUAA==
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5de6e26d4e4so6905340a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 23:22:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUfPRHJtQQfsklP/sXwW5sBhs5EO5yG6Z2raSFqTV5y0S3W5z5qHLdUFB/C5BAblMcX/8zJb2+Z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWHWfg+9lSusSKc1o+90Q9RGnzxrZgqHUOcOBzo4d+OCOP7O0/
 UXonw1LWofA5Mi1C0i1RgobqZU9PmyRY89D5P9a67/dkDaLVEwHwUL4D0l65c9H++qXt5QfYpmx
 E9AlungYhnYnd3f/lqvBnIdKrDbM=
X-Google-Smtp-Source: AGHT+IH4oQXZ75PaiQ5q94lbM6UPkG1or1sTEbMNPus1+v5Ba6Wxh3nB65ZO7Zu13k5WPTyEWCcXXDkoaEPGpZrm2lM=
X-Received: by 2002:a05:6402:13d2:b0:5dc:8845:6a0d with SMTP id
 4fb4d7f45d1cf-5deadd9ccd0mr1570670a12.14.1739344977083; Tue, 11 Feb 2025
 23:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
 <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
 <20250211233056.q47mp5askk7qrxcp@jpoimboe>
In-Reply-To: <20250211233056.q47mp5askk7qrxcp@jpoimboe>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 12 Feb 2025 15:22:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
X-Gm-Features: AWEUYZkwP3dB1uiekSoXe4aycfg9SEbwDK21JX739EF38anakQ8LqK3tzyOMtg0
Message-ID: <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
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

On Wed, Feb 12, 2025 at 7:30=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Feb 11, 2025 at 07:59:57PM +0800, Huacai Chen wrote:
> > Hi, Josh,
> >
> > On Tue, Feb 11, 2025 at 5:26=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel=
.org> wrote:
> > >
> > > On Mon, Feb 10, 2025 at 02:07:43PM +0800, Tiezhu Yang wrote:
> > > > On 01/15/2025 09:34 AM, Josh Poimboeuf wrote:
> > > > > On Sat, Jan 11, 2025 at 02:57:42PM +0800, Tiezhu Yang wrote:
> > > > > > Hi Josh and Peter,
> > > > > >
> > > > > > On 12/17/2024 09:08 AM, Tiezhu Yang wrote:
> > > > > > > This version is based on tip/tip.git objtool/core branch [1],=
 add some weak
> > > > > > > and arch-specific functions to make the generic code more rea=
dable, tested
> > > > > > > with the latest upstream mainline Binutils, GCC and Clang.
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.g=
it/log/?h=3Dobjtool/core
> > > > > > >
> > > > > > > Tiezhu Yang (9):
> > > > > > >   objtool: Handle various symbol types of rodata
> > > > > > >   objtool: Handle different entry size of rodata
> > > > > > >   objtool: Handle PC relative relocation type
> > > > > > >   objtool: Handle unreachable entry of rodata
> > > > > > >   objtool/LoongArch: Add support for switch table
> > > > > > >   objtool/LoongArch: Add support for goto table
> > > > > > >   LoongArch: Enable jump table for objtool
> > > > > > >   LoongArch: Convert unreachable() to BUG()
> > > > > > >   drm/amd/display: Mark dc_fixpt_from_fraction() noinline
> > > > > >
> > > > > > Are you OK with the first 8 patches?
> > > > > > What's the merge plan for this series?
> > > > >
> > > > > Sorry, my inbox is still reeling from the holidays.  I will revie=
w this
> > > > > soon.
> > > >
> > > > What are the status of the first 8 patches?
> > > > What is the next step? Is there anything else to be done here?
> > > > I would really appreciate any advice on how to get this merged.
> > >
> > > Please post a new revision rebased on tip/master, with patch 4 droppe=
d,
> > > and I'll queue them up for -tip.  Thanks for your patience.
> > You will queue the whole series, or the first 5 patches, or the first 3=
 patches?
>
> The new series now has 7 patches:
>
> Tiezhu Yang (7):
>   objtool: Handle various symbol types of rodata
>   objtool: Handle different entry size of rodata
>   objtool: Handle PC relative relocation type
>   objtool/LoongArch: Add support for switch table
>   objtool/LoongArch: Add support for goto table
>   LoongArch: Enable jump table for objtool
>   LoongArch: Convert unreachable() to BUG()
>
> I was planning on queueing all 7.
>
> In particular, patch 6 should stay with the objtool patches since
> they're directly related.
>
> But I was also just going to grab 7 as well.
>
> Please let me know if you disagree.
What about you merge the first 5 patches, and then I merge the last 2
to the loongarch tree? (I prefer to merge the whole series to the
loongarch tree with your acked-by, but that may be inconvenient to
you).


Huacai

>
> --
> Josh
