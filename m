Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02E1E77187
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 19:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2E510E436;
	Wed, 18 Dec 2024 19:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZjzZ1cHv";
	dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0FF10E436
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 19:22:22 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2161d4b820bso56345ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 11:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734549741; x=1735154541; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Palh2vODSDjcUnt/pqSpnYchNicdY/YA1Ypw0pWez0g=;
 b=ZjzZ1cHvmyJInmIknw+YEb7qVT2nFnqrXcUJFVcPWMCXwT9+3jKNwD4ti4JlS54Pmm
 9uTQhh72g2+5GW1eyqicRjXQpddAn4eIcrRSFCTyCKTu/4O8VRv2ozTE44J/xfhCOLTy
 mM4B54cCuoIluIQjwbGIKKR4uuP5RPYqmNnzyLSwX2rfvigVSioGjx4vaRUvHGB/sjcq
 dxAFPGvSsMY4hHp5HSPw3CkAoIDoP1uj7c4oVen82QQxD8CQu6Z/p+0vQf6GgIgKZP6K
 mjj1mX8p7WTOKOwO/8wQRU+pkOIQ7HZHLxm/Qr7il/9WHf9zgleFTCuxKuBKWefJi2S2
 0Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734549741; x=1735154541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Palh2vODSDjcUnt/pqSpnYchNicdY/YA1Ypw0pWez0g=;
 b=pLMXdsLl2MYjs24IMjDqm8He7lhavNTlYLiAdL5g4+kBt5wol5SG6X7lsuiZi/vSVs
 d9hq8KrRRDus5SXbp8NOK1EUojsed4Iz+dKgz9aVCdPynVRVra0dOIP5wr83z7kWHbBb
 D5ZtXfZsmT8UDPeaQGpArCKMvCgJ33Q99jlpQunvgqlLom5VJ554miOij/+0EzokcHUI
 yCNL6EZbshajm0m5RXsCk9nSLeYRU77r31j4JXAZB5Hyyq5o7wnn6c3oXeh98D+rYy2A
 9Aj4SxFAKk4Z4bciGpMwrZM6QKF9HCsNFk+xpnRhCQsUCqha7pTSm2hx3f720RKs35rh
 gFKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiB0AG3cns5hBklW55yWegS2swfbjhO1JAEsTJgvPGml8N7HF3b3y0W88XNUl6Vd8fr30RrRuV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEunN/Oe401RhRC23Y2DYOhrbGng4dtL2SHZe39mk9/7BrqP/I
 eYNn1r54tRgM6w9DjT7aAH/zTmFR8D+PJYschnBbrb5YBzPtnjnALYjYsijm84xS7j3U6a+kxfB
 rpav1j+ubilH2P4aYrlsXlhWbtuI=
X-Gm-Gg: ASbGnctchMBur/KVpUcQFtb43N98+Xv3dtA1+SAKiO41NnsuAbn3Lwn0sWr78nFpAAr
 Wu7AaJDLnO/0ChnTK5b0FI5/l6IDxnnKe05m5Eg==
X-Google-Smtp-Source: AGHT+IEIpg8nuy30DHaReYoSwehqMfh7Ie8biuS/Pi2iGxu5VzjCpata6lZJHppkgnWTjhMAybw2JvRFtbE3N6KAhOA=
X-Received: by 2002:a17:90b:524e:b0:2ee:a00d:2ef8 with SMTP id
 98e67ed59e1d1-2f2e9394fd4mr2234046a91.8.1734549741525; Wed, 18 Dec 2024
 11:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <20241217015006.30305-1-yangtiezhu@loongson.cn>
 <CAAhV-H4WpcWjrQdkm3Sx4DVbp=2oW9nNGAbNqR4BEmiryrptNQ@mail.gmail.com>
 <20241218190558.g2hykmjgbny4n5i3@jpoimboe>
In-Reply-To: <20241218190558.g2hykmjgbny4n5i3@jpoimboe>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Dec 2024 14:22:10 -0500
Message-ID: <CADnq5_PFcHzob4poLa86_K4yP5gUT7Ei4Rz5vSUofvZTmB48-g@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] drm/amd/display: Mark dc_fixpt_from_fraction()
 noinline
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
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

On Wed, Dec 18, 2024 at 2:18=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Wed, Dec 18, 2024 at 10:36:00PM +0800, Huacai Chen wrote:
> > Hi, Tiezhu,
> >
> > On Tue, Dec 17, 2024 at 9:50=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> > >
> > > When compiling with Clang on LoongArch, there exists the following ob=
jtool
> > > warning in drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.o:
> > >
> > >   dc_fixpt_recip() falls through to next function dc_fixpt_sinc()
> > >
> > > This is because dc_fixpt_from_fraction() is inlined in dc_fixpt_recip=
()
> > > by Clang, given dc_fixpt_from_fraction() is not a simple function, ju=
st
> > > mark it noinline to avoid the above issue.
> > I don't know whether drm maintainers can accept this, because it looks
> > like a workaround. Yes, uninline this function "solve" a problem and
> > seems reasonable in this case because the function is "not simple",
> > but from another point of view, you may hide a type of bug.
>
> Agreed, it sounds like there's definitely a bug which this patch is
> papering over.

Yes, agreed.

Alex

>
> --
> Josh
