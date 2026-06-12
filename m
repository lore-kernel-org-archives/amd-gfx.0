Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2637DCD98E4
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 08:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2264810E29B;
	Mon, 15 Jun 2026 08:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="t9D9nNrP";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC7AD10F666
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:43:56 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-68cec9f4c6cso1796970a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289835; cv=none;
 d=google.com; s=arc-20240605;
 b=E71duln4SCQ4smNZB5bU5OqCXvzzzdLF3RPAZW3NNaxefB8Pr6BfMPJc3oTrtSLj92
 hYdiq62Fp3yI1Ae1tOQ/xwSCwKkImTFtzOWfzogMbS1N/sVvSnwiH0/s82ah2LVQ/h2/
 lmvpYAA5fUx6QnOn5HGMbInzl7yU7QarN77cEwAmJ9zR3uFODRXpBh7q4lStnmzr49Hv
 0KyM7I7yAQw5dHi8DYTdxwIIKJXMZhmkjM2lGY0Yl5yJlaGTV6reZeuPU4IfYAK942P2
 7wr9KCPt7dBve/HVNPvdvGx5Pp6r9DGur8lAP1qKqaFIU4tx91iDx0/Pk4ZzzalWzwwI
 FjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6DnumblQJH/uXGfU059VkkZKwxZmNHcGuyxEw+XU2qE=;
 fh=VNN4LOExbvA5JZ/lcGi/djL07gaA2OHX3LS30Lq68ho=;
 b=H9KRrHjTJMQ4jTGo0DgLFqWzVw6HDOOTWGbrv3cRsqGzWKqWGVs2+RkaG+Ckl75+da
 uwPj/BVrp+St2jGZoitv180wsJ/OhlBx4XxazyAL6SKS6ClVycc5rasLfWclzxjrutKn
 JVaQBiPTadYGjtrkzEheGGVdg7F4aCEkL6B+plMbWApAc7cYxpZgkV1+MHkuN72f5glL
 vVsaJDsnpfvK4Z3oooJunmpS2hjUUmqSPPNRHhP4JmZRZc5xMcywUXvPM1TQJ4dmovcs
 4rQUNm7z++tQO7J1MQUUqkcNoUuCNjx9/5yE/eePYwR4sS3yR8/3SsRgeW0fdfJPh63n
 78Ug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781289835; x=1781894635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DnumblQJH/uXGfU059VkkZKwxZmNHcGuyxEw+XU2qE=;
 b=t9D9nNrPoDo6ftXuNApa2mKr7APo9WSckCfd5/tp/tdZN+lObIJiwHeWWaW5rRc0Gy
 iasYRngq+9UWDO0R24kXkePwbL+PCDuUQEmu607hhpePJQzOiBwC5SB/pTqdXm0LRuas
 TKP08Fb/SOwAdUglUTloexF8YmvwVmQIYnSdDYOZXzUfdlfeiufucPcTarOYug12pkiY
 xoH3tAGTS++L7EwkHbIMDQPtzcgyuEWUZ1BYEzqbdoBiFTM2AybSv81QIU0gAx1iBWvF
 j0/DGuNgXRTEgP2Y0uKpcYQqpwzxQ3p3TGFdWUdUrb2cwtxDNZw+qs6EzlCsp7N8EsTi
 JElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289835; x=1781894635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6DnumblQJH/uXGfU059VkkZKwxZmNHcGuyxEw+XU2qE=;
 b=HNuV4pVtERtt1cgUia7uHw2aoeiEfLD6H35P6puc+Mv8Upg5s5nrIRzxWnUgTDCGPH
 yGiV/AEaUXkw8Tfkb0R5TxvOrHCVWX68EZ9e/S46TPLEKUp3zipLF/PNsLIdYIxAwOfw
 5TaK04892rpS3+57/JUiyTtOQIqCIdfLOSUN+sTBxT8FmMRJ1WurWiGLeSiIkToNiKo8
 G8x8P1CKUXkOGLvtl99zAXI+a7+NMWWy5IS+o307heaYrlYKaK/T9NYZ9qO3dtE9gahB
 nof9JFJXmMGBZUXoOY3hkMRJbUtRPhx14JOqhnohydcq26wuxJ0d3o94lc1Dps3nTcdX
 6kDw==
X-Gm-Message-State: AOJu0Yy1zZQFuRAIf6aGQeXHDTqQWbhIgYUjCvg8Qg5YWnXkFBsd0kBo
 kamTluE3cBWbxnjNY86YBaEIly2b6XLvcHjckVr8xY1v+qirotFujy2P/RW2w8AR43dQAf4UumT
 IXCEp+Z30piGWNogNW0LPEbE8H0rEK6bSOPlQc1Xtmjdq4NLYr3iMPg2N8A==
X-Gm-Gg: Acq92OGRpg90ZIZHkMcSOwa5uhcYBu3HK2CoUadfWvQl6YY3hB3cbvrK5+88JaIwxEq
 ookuIKTxe91HvRWvZuwGCBz4NbkpQcv3YHkBl8JblZsdgQT1FAQaM1xDmn3cSRGdmCT3fDGmJk2
 6es47c/K+oLih06Fngax/GiKYoUPUFZ/KklJJX6V6MdSsFKTJxhBdJDaPzK7w4PFjOL71cfMPPs
 dsIGdfvUtwwjTB3IkKIn7g7xDeJ20O2kaGY51c95XVNw1D6H/rT3HmSRyuJq7ZyryCHxySxwc+C
 w1Kpx+yP70jojKZmksn1jc+m/rzg5y0ZJ6lDLtQAgKApqLSe/kJWItofYwA3Ncp8xXFtzCRh4hN
 L26cnJUlRSn4Qoo79DR47kNBVuyCl21vO6OSo
X-Received: by 2002:a05:6402:e85:b0:691:a699:da5c with SMTP id
 4fb4d7f45d1cf-693c6a6ae83mr166917a12.17.1781289835396; Fri, 12 Jun 2026
 11:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260611195026.25125-1-guilherme.bozi@usp.br>
 <33b42033-a5ae-4fa2-bafa-ea007a29eab1@amd.com>
In-Reply-To: <33b42033-a5ae-4fa2-bafa-ea007a29eab1@amd.com>
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Fri, 12 Jun 2026 15:43:42 -0300
X-Gm-Features: AVVi8CcfB6VWasgjDsXNWWEnkpmrEqTP8ocKbH7N_vHLj19h1d7NE8oW539gptM
Message-ID: <CAJgF-xtvOSwB4S8Xw1JwkyWQVEMEMfpmVyTxAKaESi0s9XoRkQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/9] drm/amd/display: convert GPIO translation
 logic to lookup tables
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 airlied@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com, 
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:22:58 +0000
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

On Fri, Jun 12, 2026 at 4:34=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/11/26 21:49, Guilherme Ivo Bozi wrote:
> > This series converts the GPIO HW translation logic used by
> > multiple DCN generations from large switch statements to
> > static lookup tables with shared helper functions.
>
> Not to block this patch set, but please keep in mind that when some array=
 index comes from userspace to use array_index_nospec() to avoid security p=
roblems caused by speculative execution.
>

Thanks for the feedback. I reviewed the relevant GPIO and DDC paths.
In all cases, the offsets and indices are derived from DC BIOS tables
or internal DC GPIO service mappings, not userspace-controlled input.

If you still prefer additional hardening for consistency, I can send a
v2 with array_index_nospec().

> We already had problems with that in the past when people converted switc=
h statements into an array lockup.
>

I=E2=80=99ll keep this in mind for other paths where array indices may be
influenced by userspace.

Kind regards,
Guilherme Ivo


> Regards,
> Christian.
>
> >
> > The new implementation reduces duplicated translation logic
> > across generations and makes the GPIO mappings easier to
> > maintain and extend.
> >
> > The series introduces generic GPIO translation helpers first,
> > followed by per-generation conversions.
> >
> > The following generations were converted:
> >
> >   - dcn10
> >   - dcn20
> >   - dcn21
> >   - dcn30
> >   - dcn315
> >   - dcn32
> >   - dcn401
> >   - dcn42
> >
> > The dce60, dce80, dce110 and dce120 implementations were
> > left unchanged for now.
> >
> > dce60 and dce80 contain special switch-case handling paths
> > that currently do not map cleanly to the new table-based
> > representation, so they were intentionally excluded from
> > this refactor.
> >
> > No functional changes intended.
> >
> > v1 resend:
> >
> > No changes since original submission.
> >
> > Automated review:
> > https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-overall-20260=
512190019.228440-1-guilherme.bozi@usp.br/
> >
> > Guilherme Ivo Bozi (9):
> >   drm/amd/display: add GPIO HW translation helpers
> >   drm/amd/display: convert dcn10 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn20 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn21 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn30 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn315 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn32 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn401 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn42 GPIO translation to lookup tables
> >
> >  .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
> >  .../dc/gpio/dcn20/hw_translate_dcn20.c        | 432 ++++++----------
> >  .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++---------
> >  .../dc/gpio/dcn30/hw_translate_dcn30.c        | 432 ++++++----------
> >  .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 ++++++---------
> >  .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++---------
> >  .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 +++++---------
> >  .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++----
> >  .../drm/amd/display/dc/gpio/hw_translate.c    |  86 ++++
> >  .../drm/amd/display/dc/gpio/hw_translate.h    |  21 +
> >  .../gpu/drm/amd/display/include/gpio_types.h  |  48 ++
> >  11 files changed, 1274 insertions(+), 2035 deletions(-)
> >
>
