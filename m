Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B28CCD193
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 20:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A43C710E4F5;
	Mon, 20 Oct 2025 20:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g46AVBgI";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B1910E4F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 20:18:09 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-781254d146eso532371b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760991489; x=1761596289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0zYqqVsd3tJB+d0eEMk5ykc3idlnrqcw7UMOvrxUZc=;
 b=g46AVBgInHqJMN4bYJQjHQIs9gsX/vuSYkJR28xOstN66vEc7ApWj7JDfnInZbqIZm
 x0F6SrkfSkgp7Z+QAVyuPnfkEYWBaPkjYj1ZU+7madDKP3hc2R/l8aPiORERXJ56gmZv
 XTqEL4CRGQGneO8+2wmkl9xP2NFgfo5KH2idY0mXpR9g6q8D3lLHNVLrwqk9ycQpmSh0
 WqLxratPFdOoo2DTSAnfq0nvNH7auwRyEwThOEXNHgtSTsYLFU04OuDtEIbgKIkYQTNT
 RgZ1ujVueYcfzUpUO2QwKgPIQhtkEBC3ZcM+KA7Tw5ugY/je8FiYEcjkQbGnK+EOkJ/Z
 iaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760991489; x=1761596289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0zYqqVsd3tJB+d0eEMk5ykc3idlnrqcw7UMOvrxUZc=;
 b=SiPMrEgmelAf9pGjRYcH/n76feLCnMZ17P9645ljpZko6E6X+uqMLXnFF1U9HPXCfc
 fXdGQz0XnXHa8bDTnFOpa6FSHw5AfhhalndhMdcOsKA9Nh+t11Flef4GiftLjK8rTmfB
 Sk7DQERgtgBPbFReB2lr3sZtmjT7AoS18+niGNI4mZemvG+NZPDfYcGuFl+F10Mb64v6
 9ovQtgUE52ubWOJjpdP9UnkzGKsYUBTWOPtuewJt+SEsizOVkjeBEuC2e1e5TleZfeJZ
 7zdJkOu5ePZ+yStbjAYMJcalanBofmiUf3rQ70KD3DyhInFsaBEohakyfhWoAZAwC8EP
 Kk/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZRaZ5nJqzVCuiB2Y0oyQ6GIN67pL9QmXszzNI/joC3L/ZYNDYvzVTearl+K0btQ/fkUnvlGqd@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr9ZU8+DglgARpyiZI+vXSgkTHdO3uKk63wCF6HIBpVx2IwSK5
 1JsAv0WYNzPYW5jrgCIYQmcZwK/6SE8cUaFERKxq6ycC0vqqpijPN6mWS5Tb2FAstyhQwPhkXQx
 ZJl4EI27nGaCDD/3Sbic2NIekFY1fTNE=
X-Gm-Gg: ASbGnctuZ5Nsua27OmxiP+NMHbdlDmbzruBX6DXiFOSSqUN3mnVbNy2TrlX6QVQR1jc
 1krRYrGnKnREIlyp2WZDY9I4dslIqM1fNu+Pi+MsoxOjBNw275rc2tM6ZJKsjUcPYOGZYGmtAzM
 /aSx3xoKqJdBvcsKPJjpryFQfPeMLXHZWNyEtODLC2YacwETkKQy2LOe45E8OEEI2IIdkE/6atn
 HOMgiRyvoMbruW2aomq+/2CFt5L5OaWSW6Du2d1a8Dh8tffe9EcMStoBJ1LwuvBUCmskxf2auvj
 x7K2rg==
X-Google-Smtp-Source: AGHT+IHH8WrpKkeI3BpKvEw0Gf+cQcRVqPU4coKFE/BlwDx2CiuxJQ7yFw/J94NgejIZ2OQK87FLn31UQ/vrNVYU70g=
X-Received: by 2002:a17:903:1212:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-292d3fb7f7dmr4920615ad.6.1760991488881; Mon, 20 Oct 2025
 13:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-3-siqueira@igalia.com>
In-Reply-To: <20251020194631.102260-3-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 16:17:56 -0400
X-Gm-Features: AS18NWAllGxTApnf_8S9SdhU1us3QhzoOcxQ4l40dDQCEA9TAEBHfMNWZBuYi68
Message-ID: <CADnq5_NHeSRQoDjxbBs92Ow=-2VqSSPpOKMzQDfraGY3_8HW4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Documentation/gpu: Add new glossary entries from
 UMR
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Mon, Oct 20, 2025 at 3:47=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> When using UMR, a dashboard is available that displays the CPC, CPF,
> CPG, TCP, and UTCL utilization. This commit introduces the meanings of
> those acronyms (and others) to the glossary to improve the comprehension
> of the UMR dashboard.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation=
/gpu/amdgpu/amdgpu-glossary.rst
> index 30812d9d53c6..eb72e6f6d4f1 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core at
>      CP
>        Command Processor
>
> +    CPC
> +      Command Processor Compute
> +
> +    CPF
> +      Command Processor Fetch
> +
> +    CPG
> +      Command Processor Graphics
> +
>      CPLIB
>        Content Protection Library
>
> @@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core at
>      GMC
>        Graphic Memory Controller
>
> +    GPR
> +      General Purpose Register
> +
>      GPUVM
>        GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports mult=
iple
>        virtual address spaces that can be in flight at any given time.  T=
hese
> @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
>        table for use by the kernel driver or into per process GPUVM page =
tables
>        for application usage.
>
> +    GWS
> +      Global Wave Syncs
> +
>      IH
>        Interrupt Handler
>
> @@ -206,12 +221,18 @@ we have a dedicated glossary for Display Core at
>      TC
>        Texture Cache
>
> +    TCP (AMDGPU)
> +      Texture Cache Processing

I don't recall what the P stands for, but it might be worth calling
out that the texture cache (old name) is basically the path to memory
for shaders.  So it's not just related to textures.  The name is left
over from old designs where shader stages had different cache designs.

> +
>      TOC
>        Table of Contents
>
>      UMSCH
>        User Mode Scheduler
>
> +    UTCL
> +      Universal Texture Cache Line

I think the L is Level.  I.e., it's usually referenced as UTCL2 for
example.  Might want to drop the L?  I think the U might also be
Unified.

Alex

> +
>      UVD
>        Unified Video Decoder
>
> --
> 2.51.0
>
