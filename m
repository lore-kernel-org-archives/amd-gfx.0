Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FB8E77187
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 14:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6921110E323;
	Wed, 18 Dec 2024 14:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oJCGs4Yz";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1047410E323
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 14:36:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2B4F35C629B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 14:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5033C4CECE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734532572;
 bh=9n0ZAjSAIhk9F622B8IToa4qtHVMNl9mwzIDA2TI+7k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=oJCGs4YzbcTcFVKmU3XFHzvQVR68fBsTxpeAJV9lZb7eTdjNIVA6BQcWBrY1t673i
 dvHWg0AgSjOdYqxDZ3ktuaitcxSMduGGs+cSMYqZJqCn8vzFsznDrRgZamTD/eJ8Zj
 VQr6q5j9cu6BpmdP99+KuOSFqIRVp/aRFZlkrgT96XzX9olRwpwOK4qxvGfIIAS80g
 LlnKOBrI3qOjCDj/2KyyFBkajJHez/w8zbB8x2aIzxMfwHowwpKSSxHV9U1pObZYRM
 DE3rNPOLNMFOjQ6Fb01zRwrL7vfgMLVtfipcS7OqXc8N4BFfXb/yyXdcJ4x1/W0TFN
 tJTYxwUl0JFJw==
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso1087836166b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 06:36:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXIm6V9UoTfgLNrSoI/vcrkhkNCVhgmG4VaB0HUFthfMAcaS1GTsKF1NaoQVSjSYrWb5NsARkOU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrmSH6rl7sp+/fZTzk6KfAN+kw+OhO0Lvm2wioxOrvlnqdZ8uN
 pqqylk654mZDuQH2VSP30NhVC8+f488m2nq/WparQVT4/+ZNw0BTFZfOKqi08akVwMcXNDUV26I
 tYfyS493K0y8hSG3ERgPvYQwgiwU=
X-Google-Smtp-Source: AGHT+IGH+ozXywB34VYVSAamVS+ZjQCypQ05xEGjN0SqCkq8/WyDDyS7rVXnhhMxnJivZ7v/JZDxOROVB65JAzdxhVI=
X-Received: by 2002:a17:906:328d:b0:aa6:1e9a:e45a with SMTP id
 a640c23a62f3a-aabf48c67c5mr231921266b.46.1734532571420; Wed, 18 Dec 2024
 06:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <20241217015006.30305-1-yangtiezhu@loongson.cn>
In-Reply-To: <20241217015006.30305-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 18 Dec 2024 22:36:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WpcWjrQdkm3Sx4DVbp=2oW9nNGAbNqR4BEmiryrptNQ@mail.gmail.com>
Message-ID: <CAAhV-H4WpcWjrQdkm3Sx4DVbp=2oW9nNGAbNqR4BEmiryrptNQ@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] drm/amd/display: Mark dc_fixpt_from_fraction()
 noinline
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

Hi, Tiezhu,

On Tue, Dec 17, 2024 at 9:50=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> When compiling with Clang on LoongArch, there exists the following objtoo=
l
> warning in drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.o:
>
>   dc_fixpt_recip() falls through to next function dc_fixpt_sinc()
>
> This is because dc_fixpt_from_fraction() is inlined in dc_fixpt_recip()
> by Clang, given dc_fixpt_from_fraction() is not a simple function, just
> mark it noinline to avoid the above issue.
I don't know whether drm maintainers can accept this, because it looks
like a workaround. Yes, uninline this function "solve" a problem and
seems reasonable in this case because the function is "not simple",
but from another point of view, you may hide a type of bug.


Huacai

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers=
/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> index 88d3f9d7dd55..b40c6a21460d 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> @@ -68,7 +68,7 @@ static inline unsigned long long complete_integer_divis=
ion_u64(
>  #define GET_FRACTIONAL_PART(x) \
>         (FRACTIONAL_PART_MASK & (x))
>
> -struct fixed31_32 dc_fixpt_from_fraction(long long numerator, long long =
denominator)
> +noinline struct fixed31_32 dc_fixpt_from_fraction(long long numerator, l=
ong long denominator)
>  {
>         struct fixed31_32 res;
>
> --
> 2.42.0
>
