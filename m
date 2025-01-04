Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13E6E77188
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2025 13:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9EF10E151;
	Sat,  4 Jan 2025 13:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LykBfxpl";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC13D10E151
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2025 13:59:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C6C6CA40A9C
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2025 13:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8357AC4CED2
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2025 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735999140;
 bh=7pbIvjaKefW11WvMvVmM/XkN38mQUuzJ9Qf2ynzdy9Q=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LykBfxpl020F/6SEDnAP1a5zpMkVWTKnBmkdheoDW6HzDxSFAdf3ERKZlTni4UrLH
 Y84mkKMFQnaTtyP+YlPvo83ZF6Ojw42PLRxJhdCm6f3K88aq1e4qBw8zsmqmNviBfh
 BRKlg0lLtC2URAvN901PixJp/dFfmBuuhHqTE+/b5FziZNfSO+DdfWx19hjkLNlePk
 qGPr/1tu51wSZ6IEiDp6zkF90F2vjIZdpvUNtaL1+P9X7MxhcjMlNzDozMxylKiFZC
 W5mKExw4BMUcyMeOW+DCkze8ECllVjuxxDL3ArO4ETfQNHFO+XV0Edf2cjdrAjXrir
 KldyDeiF9I5oA==
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5d8c1950da7so10820800a12.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 Jan 2025 05:59:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXfMzEL7hl/X5vFVtxiyZKTwGCRbf/hI9qFMvojgUl0TQz3I7ez9M1Mkzw51/ghlIpgBOqxrJW2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgMA7yvd89z62OYmySdBnS9PUNxVUvxtVaZHwTfWgxKxuSfZjt
 7P8jZ8sEOfcyPilkuQuoeE+9Gcf+O38Sdf+/8Y3R11H6shTRoUjKGe5f2nOhuN9uRyC+mXbIKFg
 Lu19jojzGfYOlaIzA973uzkg6zGA=
X-Google-Smtp-Source: AGHT+IHwNO6uo9TkouEchAuDkmSuLkPF1C5kh7VfTJyV8LhTKmWeMsvKRD4Nkcx/JtvpnIm0kp6N6qXUTWfMSEOGuIw=
X-Received: by 2002:a17:907:948b:b0:aac:1e96:e7d2 with SMTP id
 a640c23a62f3a-aac33667eb4mr4776050366b.54.1735999139004; Sat, 04 Jan 2025
 05:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
In-Reply-To: <20241217010905.13054-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 4 Jan 2025 21:58:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ve3Do7U+8UaR=-CwY-x6hv2r3WLZm9e8wCGtwgGzc8A@mail.gmail.com>
X-Gm-Features: AbW1kvbo-ch0NLtu-ndq6VACTO4Rq2CVQkdCFWFdSmDMeju91faYFPP2v-BbMYA
Message-ID: <CAAhV-H5ve3Do7U+8UaR=-CwY-x6hv2r3WLZm9e8wCGtwgGzc8A@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 loongarch@lists.linux.dev, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi, Josh and Peter,

I think this series (except the last patch, but that one can be a
separate one) is good enough now, right? If so, I think there is some
ways to get it upstream:

1) I merge objtool/core from tip.git to the loongarch tree, then apply
this whole series with your acked-by;
2) You apply the first 4 patches to tip.git, and then I apply others
to the loongarch tree (still need to merge objtool/core before apply
to avoid build issues).

I prefer the first method, but I can also accept other ways.

Huacai

On Tue, Dec 17, 2024 at 9:09=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> This version is based on tip/tip.git objtool/core branch [1], add some we=
ak
> and arch-specific functions to make the generic code more readable, teste=
d
> with the latest upstream mainline Binutils, GCC and Clang.
>
> The first 6 patches are preparation for patch #7 to enable jump table for
> objtool on LoongArch, the last 2 patches are small enough to fix objtool
> warnings "funcA() falls through to next function funcB()", one is under
> arch/loongarch and the other is under drm/amd/display.
>
> v6:
>   -- Add arch_reloc_size() for x86 and ppc.
>   -- Call arch_reloc_size() directly in add_jump_table().
>   -- Refine arch_adjust_offset() for LoongArch.
>   -- Rename arch_adjust_offset() to arch_jump_table_sym_offset().
>   -- Get each table size of rodata in time for switch table.
>   -- Update the commit message to make it more clear.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3D=
objtool/core
>
> Tiezhu Yang (9):
>   objtool: Handle various symbol types of rodata
>   objtool: Handle different entry size of rodata
>   objtool: Handle PC relative relocation type
>   objtool: Handle unreachable entry of rodata
>   objtool/LoongArch: Add support for switch table
>   objtool/LoongArch: Add support for goto table
>   LoongArch: Enable jump table for objtool
>   LoongArch: Convert unreachable() to BUG()
>   drm/amd/display: Mark dc_fixpt_from_fraction() noinline
>
>  arch/loongarch/Kconfig                        |   3 +
>  arch/loongarch/Makefile                       |   6 +-
>  arch/loongarch/kernel/machine_kexec.c         |   4 +-
>  .../drm/amd/display/dc/basics/fixpt31_32.c    |   2 +-
>  tools/objtool/arch/loongarch/decode.c         |  28 ++-
>  .../objtool/arch/loongarch/include/arch/elf.h |   7 +
>  tools/objtool/arch/loongarch/special.c        | 159 +++++++++++++++++-
>  tools/objtool/arch/powerpc/decode.c           |  15 ++
>  tools/objtool/arch/x86/decode.c               |  13 ++
>  tools/objtool/check.c                         |  28 ++-
>  tools/objtool/include/objtool/arch.h          |   3 +
>  11 files changed, 251 insertions(+), 17 deletions(-)
>
> --
> 2.42.0
>
