Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0521E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 08:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5223610E102;
	Tue, 14 Jan 2025 08:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tk4XIAH7";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CB710E102
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 08:29:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 003CCA40807
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 08:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5153C4CEDD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 08:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736843374;
 bh=REF9R0/AevOC88vpAVmwrLFvgdfE9O7rW7bMxSbbx30=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tk4XIAH7IZgpIBLlaekTk1hbT0dhIR5JjNKx41xyrQTJ1pYG655vBU/sIvP87LqFa
 wNn0IeuvVWmEIoLigNlbFbEM9D1JIKcYT0tf4jBFwj4MmEiRisbb9ygw0jXJ1fyaPu
 TSUZswP6oaS7qSi5NBdIhkIsCpJxSOoRAX8sOIpWwdDJCzbi+3eaSh1DqPyg7+6OKx
 s/zQ9Y12XNCuN8ggIdF7oC8WG1UDfcDXceSMrdS1sG11mp7czKcTr521QmJDpEEZfR
 l1b6zdBzLx8BbFzN7dZ0p63co2ka7AqJB19VK88c8o582xD+uX7OLC4hy6R3CBPkaR
 /oAXkO6nxQCpg==
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-5d437235769so9000215a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 00:29:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWrA8YAYeOky99fhZLaH6w6Zofq/ly/WgsXgJdOdOjYMzT/b3lZnqodsRTKTHYyBCUP+d/Mnu9N@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yynq6MjVsnb9lXgGZZQ4cywDzr7cK/53ufz51nT0EjqfakRktN9
 Gtyp19fqDUSrxAFzUJnLPrYtqKLnxQMdEuCGpj5LfjfKlxSB3GHxtJl/3RIsAB+IoMW4SxorPb5
 b9PluXTRTKlSaigo1ZqpvCr3dtjY=
X-Google-Smtp-Source: AGHT+IElAq3lQGfS+6xEcOQVKwEqVXcMg90XZRj94kUn+TNlDOrojK6m2DR1Q6qZBQph+Trg27dHVUPe59et5X83iTQ=
X-Received: by 2002:a17:907:7fa7:b0:aa6:423c:8514 with SMTP id
 a640c23a62f3a-ab2abc94ef2mr2078085666b.40.1736843373373; Tue, 14 Jan 2025
 00:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20250114061507.30765-1-yangtiezhu@loongson.cn>
 <20250114061557.31120-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250114061557.31120-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 14 Jan 2025 16:29:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H56-xQm5XnS7M4weHj29Z_bB8ZBiF_H4fd+eGe6g+naow@mail.gmail.com>
X-Gm-Features: AbW1kvaQU7lxQPgzhBYhzMIR21QncIr3ZMwrvDUj3OeU5jbc3RfcolKwA9Diink
Message-ID: <CAAhV-H56-xQm5XnS7M4weHj29Z_bB8ZBiF_H4fd+eGe6g+naow@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/amd/display: Add ASSERT_BUG() macro definition
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 loongarch@lists.linux.dev, 
 amd-gfx@lists.freedesktop.org, llvm@lists.linux.dev, 
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

Hi, Tiezhu,

On Tue, Jan 14, 2025 at 2:16=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> In order to keep the current ability for the aim of debugging and avoid
> printing the warning message twice, add ASSERT_BUG() macro definition to
> harden the callers of division functions.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/os_types.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/=
amd/display/dc/os_types.h
> index f2ba76c1e0c0..932bbe05ee0a 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -79,6 +79,11 @@
>                         dc_breakpoint();        \
>         } while (0)
>
> +#define ASSERT_BUG(expr) do {                  \
> +               dc_breakpoint();                \
> +               BUG_ON(!(expr));                \
> +       } while (0)
I don't think this is correct, if KGDB is enabled, then whether expr
is true or false, ASSERT_BUG() will break to KGDB.

Huacai

> +
>  #define BREAK_TO_DEBUGGER() \
>         do { \
>                 DRM_DEBUG_DRIVER("%s():%d\n", __func__, __LINE__); \
> --
> 2.42.0
>
>
