Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05A4C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 22:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1436A10E0E6;
	Thu, 11 Jan 2024 22:36:07 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9681510E9C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 20:34:30 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e62043a5cso655e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 12:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705005269; x=1705610069;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhucuI11iLm9jZSo5DyrLuQREbxS6U88O/YNonTCxz8=;
 b=BU2jGUcROCWUw3HdWhmskQ6RqDKvHOYC1Abgx+oueP2i18nL7w3ejZqmRQtJMi+8zB
 n8USQRfVbE5tr9H/GhA3jiYotsR6+WTjV3jP6c59OCJLyg9TrJ2sg7AbUTf/xIOzWOTe
 RCWohrB7WfuS76ueVygweZR/gjoiOrZ9djlyqJoLhuKaqOYNtkU3kYT1jjttYU9v8Bfz
 3x8q/FRV7+V5crsQA8prVqyCvqLxVU2J7EiTAoieECt20t0RvmO7CTH/bGhEg9ZL8O/u
 EAdP1f9rq2LT96ovhozUk0to2Xla712xjthHSmkd53ywHhyeUBQX9HBMBNcTsJQFdzY8
 pQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705005269; x=1705610069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhucuI11iLm9jZSo5DyrLuQREbxS6U88O/YNonTCxz8=;
 b=gIHWxMNdnmm6HvyZ3jdyhv5Uyl7KH3sv3gn7siC82XG5dS0i+tkRmWbJsY0V8NIp0b
 qQXoG70c6Ut73d+u8UC/TCVhoZH63enzvhHFtp0o+Zfrx8Kxpy29aT7/OlhQolVrctWh
 B2kMbXJoE+SMMC4b8Tk3DaW+gZ6I2QVetV9nm8+Dj7hMl+dkdVpk77KIJb7L40Y7Kqcd
 PvHFB504+HYpzzY2PB8GypTPvFTr1Mh1tR49zXCXu+Hid4wMWQtRp85IlDAE3P/ZpRlH
 Ssl3GWFR7bCjc5EvO0oEEgkSJ8MqfWy/Hy9fjnmQa4jtIJ/zjjRhxJWTZyk3Pil4PqhO
 tjJA==
X-Gm-Message-State: AOJu0Yy5Cya7pIT3fDjQlYHijHu9ZP9xVH61DdlDilF3cSjDwF9Rm7x6
 veQcrgISdzGcZ3ge6FukQImhWSbMhwwMT9vouDdVkt5FbXmJ
X-Google-Smtp-Source: AGHT+IEwsvtKygl+nvSOgn3WrpQlaoPEPZDIYAeAvmwuubPmfNOdEKX4uyCZcs5X4QVXtXNLJ5Llz2AVykCfzYGX6ws=
X-Received: by 2002:a05:600c:1d1f:b0:40e:61cf:af91 with SMTP id
 l31-20020a05600c1d1f00b0040e61cfaf91mr127026wms.7.1705005268801; Thu, 11 Jan
 2024 12:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org>
 <202401101645.ED161519BA@keescook>
In-Reply-To: <202401101645.ED161519BA@keescook>
From: Fangrui Song <maskray@google.com>
Date: Thu, 11 Jan 2024 12:34:17 -0800
Message-ID: <CAFP8O3+947djoRjnVPuPhHUHbHv_9CugufuXQ+c=N03yLsaEcA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update LLVM Phabricator and Bugzilla links
To: Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 11 Jan 2024 22:36:05 +0000
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
Cc: linux-efi@vger.kernel.org, kvm@vger.kernel.org, llvm@lists.linux.dev,
 ast@kernel.org, dri-devel@lists.freedesktop.org, patches@lists.linux.dev,
 linux-mm@kvack.org, kasan-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, mykolal@fb.com,
 daniel@iogearbox.net, andrii@kernel.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 linux-pm@vger.kernel.org, bridge@lists.linux.dev, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-crypto@vger.kernel.org, akpm@linux-foundation.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 10, 2024 at 4:46=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jan 09, 2024 at 03:16:28PM -0700, Nathan Chancellor wrote:
> > This series updates all instances of LLVM Phabricator and Bugzilla link=
s
> > to point to GitHub commits directly and LLVM's Bugzilla to GitHub issue
> > shortlinks respectively.
> >
> > I split up the Phabricator patch into BPF selftests and the rest of the
> > kernel in case the BPF folks want to take it separately from the rest o=
f
> > the series, there are obviously no dependency issues in that case. The
> > Bugzilla change was mechanical enough and should have no conflicts.
> >
> > I am aiming this at Andrew and CC'ing other lists, in case maintainers
> > want to chime in, but I think this is pretty uncontroversial (famous
> > last words...).
> >
> > ---
> > Nathan Chancellor (3):
> >       selftests/bpf: Update LLVM Phabricator links
> >       arch and include: Update LLVM Phabricator links
> >       treewide: Update LLVM Bugzilla links
> >
> >  arch/arm64/Kconfig                                 |  4 +--
> >  arch/powerpc/Makefile                              |  4 +--
> >  arch/powerpc/kvm/book3s_hv_nested.c                |  2 +-
> >  arch/riscv/Kconfig                                 |  2 +-
> >  arch/riscv/include/asm/ftrace.h                    |  2 +-
> >  arch/s390/include/asm/ftrace.h                     |  2 +-
> >  arch/x86/power/Makefile                            |  2 +-
> >  crypto/blake2b_generic.c                           |  2 +-
> >  drivers/firmware/efi/libstub/Makefile              |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |  2 +-
> >  drivers/media/test-drivers/vicodec/codec-fwht.c    |  2 +-
> >  drivers/regulator/Kconfig                          |  2 +-
> >  include/asm-generic/vmlinux.lds.h                  |  2 +-
> >  include/linux/compiler-clang.h                     |  2 +-
> >  lib/Kconfig.kasan                                  |  2 +-
> >  lib/raid6/Makefile                                 |  2 +-
> >  lib/stackinit_kunit.c                              |  2 +-
> >  mm/slab_common.c                                   |  2 +-
> >  net/bridge/br_multicast.c                          |  2 +-
> >  security/Kconfig                                   |  2 +-
> >  tools/testing/selftests/bpf/README.rst             | 32 +++++++++++---=
--------
> >  tools/testing/selftests/bpf/prog_tests/xdpwall.c   |  2 +-
> >  .../selftests/bpf/progs/test_core_reloc_type_id.c  |  2 +-
> >  23 files changed, 40 insertions(+), 40 deletions(-)
> > ---
> > base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> > change-id: 20240109-update-llvm-links-d03f9d649e1e
> >
> > Best regards,
> > --
> > Nathan Chancellor <nathan@kernel.org>
> >
>
> Excellent! Thanks for doing this. I spot checked a handful I was
> familiar with and everything looks good to me.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
>

These reviews.llvm.org links would definitely be kept like
https://lists.llvm.org/pipermail/llvm-dev/ or cfe-dev links
(discussions have been migrated to Discourse).
However, I agree that the github repo link looks more official. I have
clicked a few links and they look good.

Since I maintain reviews.llvm.org and created the static archive [1],

Acked-by: Fangrui Song <maskray@google.com>

[1]: https://discourse.llvm.org/t/llvm-phabricator-turndown/76137

--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
