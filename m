Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F151CF34AD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 14:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E880D10E145;
	Wed, 19 Nov 2025 14:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EQGm5tMP";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B28810E145
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 14:18:35 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7a271fc7e6bso368341b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 06:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763561914; x=1764166714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wx9jily54/HwUXp5+oAW4CQSCLdL1iH2FZYk+9DVTQ4=;
 b=EQGm5tMPa72qGzojnA01S6xZYY7KwcH5P98b5uCkAlqLDAxr5sw8sJg+A4ND33e5Qb
 /outrv+CfrV7z+Ze4FSE7INC7gyasKHiqjBOVzrGUZWNaz1zamwRspuvw+XLj8axclU3
 c1uheL/sCXAipeL/kgTWMCWCramSU1FyNe+ZEE6cJPFucxJGAiR3T5LNXPwo0/KQ/+In
 44Oon7t9w7Yxjazhwsb3ADZSzpMYOHt+r5AtgGv1Cgw1YhK5wF/ijGQ8A5n5yrEeBkoS
 msPtt6uxcwY6o7z8NGuoF/3Kh1u1wTNBblRaN9fjjP9KLlBOG7GZVL3Ebe+Y4jvujduF
 q8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763561914; x=1764166714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wx9jily54/HwUXp5+oAW4CQSCLdL1iH2FZYk+9DVTQ4=;
 b=XJ7fSIPyGXsfNW1OKE4po7s+obWE9TOEboO+ThNDgiFSCLigmlnJLVqAMSUgmlpRSq
 FMTfGneqMPgsM00Tb37S2WbVdBfZ51TDbNVxDrXatTsqiG4BdG9tYGpJJYYIUqGWIsOy
 8mlcCXdPVMExSXBBKvjJrKHYMPqZNSu+1CGm5G+T+E86KlOIjEDPlUp9P5oCPxyFdbfw
 wAU3h3gn19RcQtAM5vM8j3h/3zINigl0gUw4UkXF4f2W3SjSqWWMu94vNz1Hch7Un/hA
 dWDH8lmf5KC2sg9E/+Yx5WBBXbsCwqvPD1lwhSnNSbF4IC3uzaf2t8Jdc09aJM+VKXyz
 X/5g==
X-Gm-Message-State: AOJu0Yzn84NiP6ODaNT7+Vz9jR2/KTbl9ns2Y8a1BTHe+PJJWocsi6MQ
 mnreoTUVG6mUpSNZQ+DMerxOX6ll3V6Oe5UvakJvEMrzKl1QFNFdBCIttpRoFg4XbKrN2TGUSx9
 vOdfQ4toQ3oQmHx65gFOobp8+UHGH4tOGQA==
X-Gm-Gg: ASbGncvjzykSosER7xPGxjAep/cqHEI98rAf8ysbstqNiheQIvKUtZqSjEPS9ZlqnVb
 u+eto4CHdqm76hMEnnrtBxLTOAYAW/RFqd+yKb07xpWXlWWjaNpzLoGcixaX5tVx/s5DnGFBSri
 CkZUVQ3KGMynbrY/uMpxkpRJsUSc1XM1ww3RKnbjPHrpQfssGCAY5mzhlWku53QRxmt3czWxwDt
 CLgww45GP9gLgNE0Atek/+juMKlIy1REFrXqB5U0QpqvgywXT18ukt7tb2McPr6gQMYbX8=
X-Google-Smtp-Source: AGHT+IGdA9gQWJj9VWOjTS37yI3M5YWrlQVsm4EqglCpb3WJUmigiN0zyMh0smMs3/XzB3aN5tkfCVfqG6NI85CRpak=
X-Received: by 2002:a05:7022:411:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-11b40f87c55mr8373270c88.1.1763561914405; Wed, 19 Nov 2025
 06:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20251119092544.222670-1-timur.kristof@gmail.com>
 <20251119092544.222670-3-timur.kristof@gmail.com>
In-Reply-To: <20251119092544.222670-3-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Nov 2025 09:18:23 -0500
X-Gm-Features: AWmQ_bkukm5Ot-cEwsTXiZZ3K_bINwQZE4_7ClS-GM5GpWcrE2rszeEN3WJliGY
Message-ID: <CADnq5_MJuXPaCSevV7FpjahDJyXi-fu2qOOGQ5gYSbx5uqiJbQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation/gpu: Add PRT, PTE, PDE to amdgpu
 glossary (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Applied the series.  Thanks!

Alex

On Wed, Nov 19, 2025 at 4:25=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> PRT =3D Partially Resident Texture (aka. sparse residency)
> PTE =3D Page Table Entry
> PDE =3D Page Directory Entry
>
> v2:
> - Add PDE
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation=
/gpu/amdgpu/amdgpu-glossary.rst
> index 30812d9d53c6..43a36362dc73 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -143,15 +143,24 @@ we have a dedicated glossary for Display Core at
>      PA
>        Primitive Assembler / Physical Address
>
> +    PDE
> +      Page Directory Entry
> +
>      PFP
>        Pre-Fetch Parser (Graphics)
>
>      PPLib
>        PowerPlay Library - PowerPlay is the power management component.
>
> +    PRT
> +      Partially Resident Texture (also known as sparse residency)
> +
>      PSP
>          Platform Security Processor
>
> +    PTE
> +      Page Table Entry
> +
>      RB
>        Render Backends. Some people called it ROPs.
>
> --
> 2.51.1
>
