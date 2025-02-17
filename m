Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6C7C021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 03:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8AFE10E081;
	Mon, 17 Feb 2025 03:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bcsmt+1D";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D14F10E081
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 03:13:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 38B035C59D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 03:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD74C4CEE4
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 03:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739762035;
 bh=pAyuXlE9n0iPIhV0i94vEhmyYjpu9Z6Gs9XjgJKObMU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bcsmt+1D2s7i/BD/AKkNAhMn9l6KLBp9fffzVlbTZqvRhi0texFb6Kg2y/Ar48Wch
 9PJDine34K28X4ZoZVYZzVbVV9ZqEwcE+ggmcjya1Qc9ztCdrZS6Zc9i5j+jsGmWQg
 d0t18Ki33P/1uNuv9G/VJaQyrgAahvrn+ka+GDk/euWOSINkZ8chE0B+S7u7oawq2r
 0qQmnCAmCOI9IFTZ4Kmk5sK92tGvF807tJ16nufNe0TIKAO+1kzfMCeESLzmgDIqN8
 dC5ID6OeeBBJQmRG9UDhUv7T+KuE4CxgLDpqCow3DZJvrsNigBtzDclhPcV/ONGPXS
 PqRFOmE4BtmAw==
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so580981866b.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Feb 2025 19:13:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCURDqrimEBiXqXo02Cl7HKWi19Jaf1nnEwzzW0pMmj71xHMIxHq8jUwenDUZTFlBcrXvueI+rh8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwADsMLm6n/Gl33fF37FuxJTt0CvvzE+vYI3YEuTP3v4mVVN0dA
 9mSfDfgnxvMvzAndizA+m/rVKRtBxp6y4I7iLkaPStJkhljljPVeXDnyqpUW/Hpd/m9qnZCV9cB
 d4hZDsXT3ng6j33oamEpMKZtv+sg=
X-Google-Smtp-Source: AGHT+IE+lCxd/VN0cFWcgSvPgk7Nu3WrmBw9zHE0Olw6SOhdkJGmzxd7XkXEOYSYzwMWE4/pbWbtUHzEsFxBtaHqNSs=
X-Received: by 2002:a17:907:7854:b0:ab7:c1d5:14f9 with SMTP id
 a640c23a62f3a-abb70931a60mr796940066b.10.1739762033809; Sun, 16 Feb 2025
 19:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
 <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
 <20250211233056.q47mp5askk7qrxcp@jpoimboe>
 <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
 <20250213025108.svqgj5nzseqs6qox@jpoimboe>
In-Reply-To: <20250213025108.svqgj5nzseqs6qox@jpoimboe>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 17 Feb 2025 11:13:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5mYGnxHPxAeXkHo2XBvi-RtPjDQRBnDiDyKVtFv-ZBBQ@mail.gmail.com>
X-Gm-Features: AWEUYZnerjRjGiFDoG8vssKUp_r7uyi3vq83RlWmu1DWGBTmDSKGJJGP4uNTOm4
Message-ID: <CAAhV-H5mYGnxHPxAeXkHo2XBvi-RtPjDQRBnDiDyKVtFv-ZBBQ@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 10:51=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Wed, Feb 12, 2025 at 03:22:45PM +0800, Huacai Chen wrote:
> > > The new series now has 7 patches:
> > >
> > > Tiezhu Yang (7):
> > >   objtool: Handle various symbol types of rodata
> > >   objtool: Handle different entry size of rodata
> > >   objtool: Handle PC relative relocation type
> > >   objtool/LoongArch: Add support for switch table
> > >   objtool/LoongArch: Add support for goto table
> > >   LoongArch: Enable jump table for objtool
> > >   LoongArch: Convert unreachable() to BUG()
> > >
> > > I was planning on queueing all 7.
> > >
> > > In particular, patch 6 should stay with the objtool patches since
> > > they're directly related.
> > >
> > > But I was also just going to grab 7 as well.
> > >
> > > Please let me know if you disagree.
> > What about you merge the first 5 patches, and then I merge the last 2
> > to the loongarch tree? (I prefer to merge the whole series to the
> > loongarch tree with your acked-by, but that may be inconvenient to
> > you).
>
> I want the first 5 patches to go through the -tip tree because we'll
> have other patches depending on them.
>
> I'll go ahead and take the first 5.
>
> If you take in patches 6 & 7 separately, that might introduce a lot of
> warnings.  But it's up to you.
>
> For patches 6 & 7:
>
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
OK, please take the first 5 patches, I will merge your objtool/core to
the loongarch tree and then apply the last 2 to avoid build warnings.

Huacai

>
> --
> Josh
