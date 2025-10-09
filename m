Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965D3CCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 21:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7492810EB22;
	Thu,  9 Oct 2025 21:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YaUSiFvV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFDF010EB1E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 21:27:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E1F1F6242B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 21:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831ABC116D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 21:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760045261;
 bh=4loDIqhblCjJ30GBRu0k7u8qIz2dPxyVOru+CGKtJ74=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YaUSiFvVHVUtoMbaMFXZECh1Ue/nAlF7ytJcjfdOBeUZ5qKjrmG4Vw4ZQV3Ab6/o0
 8oGRq2w0ekpTSCJuSDfKPzp3ylv9u3fDE5hKK6xoJQh44VL8D2XNG02kUCqrRGhGSA
 9q9R5MidL2Uoio3BihyomjeV9rCOfM2a9q8pyVj5fDn/I1FxIq4pRmjRsaLiWtAqh9
 ESrpzXme7KEHLYul0nVhvk0eVXvBJX0insfF9UFSLR05ft9rZ5PZy0+WcynhkLqA4i
 W5V76/vMCSX72cgCNwUFm5+5lBcL60I6Jykh8MY6aJj+Z0YV1FUhsj34rgK17XeEQr
 tqi/cR5jFxMTA==
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-58d29830058so1755603e87.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 14:27:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVaOHIIw/Mt/DJbYhXD2kSF+Gj21S2miGYTRO4Q89FCJib7WJwNUSiTiXNA9dW1G3sO+ZN/mGi3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyawVwC8ZCTvU/I/0CYZhHIjHZAd+wGiXhMUvjsxQTNBiHcoj1g
 iaAm0BHzarygjGkhylOfX8Fe32rbme0DchoIW+PDCfTPyl5GlMJ3hrA75bcV/8rFxS2XkU0WVsV
 E5Q2l7hB1EK0nO7ojRlUumxsBZrJ+qeU=
X-Google-Smtp-Source: AGHT+IER/TjSS/ftsXuN+vL0Qr19tffVlZEETaCj2FrKKovdy0RneNyLm8hMt38oGA2BPK1mfYI7btUasVrhpusvupY=
X-Received: by 2002:a05:6512:3ca8:b0:57d:92ec:67de with SMTP id
 2adb3069b0e04-5906daeb7b6mr2786494e87.57.1760045259802; Thu, 09 Oct 2025
 14:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251009150621.3886079-2-ardb+git@google.com>
 <bbc089aa-934d-4dd3-825a-53f8e98dfd3f@amd.com>
 <15d5b9dc-8452-411c-9957-ba759d307223@amd.com>
In-Reply-To: <15d5b9dc-8452-411c-9957-ba759d307223@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Oct 2025 14:27:27 -0700
X-Gmail-Original-Message-ID: <CAMj1kXGLdNDJRgQg2Hr9YM4Ke6Sb6KLr8Ws-QY+umR4NpXjg4w@mail.gmail.com>
X-Gm-Features: AS18NWBLRyAo4AK5pdIQjAzn4UZLNTXw2YS4IciwUevqRyoiy4COy88E11E6XIM
Message-ID: <CAMj1kXGLdNDJRgQg2Hr9YM4Ke6Sb6KLr8Ws-QY+umR4NpXjg4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Permit DC_FP_START/END only in non-FP
 compilation units
To: Harry Wentland <harry.wentland@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Austin Zheng <austin.zheng@amd.com>, 
 Jun Lei <jun.lei@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Thu, 9 Oct 2025 at 13:41, Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2025-10-09 12:19, Christian K=C3=B6nig wrote:
> > On 09.10.25 17:06, Ard Biesheuvel wrote:
> >> From: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> Test the existing CPP macro _LINUX_FPU_COMPILATION_UNIT, which is set
> >> when building source files that are permitted to use floating point,
> >> in the implementation of DC_FP_START/END so that those are only usable
> >> in non-FP code. This is a requirement of the generic kernel mode FPU
> >> API, as some architectures (i.e., arm64) cannot safely enable FP codeg=
en
> >> in arbitrary code.
> >
> > If I'm not completely mistaken that is actually an issue on basically a=
ll architectures, at least x86 is affected as well if I'm not completely mi=
staken.
> >
> >> Cc: Austin Zheng <austin.zheng@amd.com>
> >> Cc: Jun Lei <jun.lei@amd.com>
> >> Cc: Harry Wentland <harry.wentland@amd.com>
> >> Cc: Leo Li <sunpeng.li@amd.com>
> >> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> >> Cc: amd-gfx@lists.freedesktop.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Anyway, patch looks sane to me but I'm not so deep in the DC code to fu=
lly judge.
> >
> > Fell free to add Acked-by: Christian K=C3=B6nig <christian.koenig@amd.c=
om>, but Harry and Leo need to take a look.
> >
>
> Thanks. Good safe-guard. Flags a bunch of issues in the
> current code. Let me fix them before merging it.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Thanks.

I already fixed a bunch here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3Dddbfac152830e38d488ff8e45ab7eaf5d72f8527
