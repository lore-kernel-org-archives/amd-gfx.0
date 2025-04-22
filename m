Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE78AC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 16:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763D2897C8;
	Tue, 22 Apr 2025 16:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FP5YcLky";
	dkim-atps=neutral
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5917897C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 16:33:08 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-86b9e93123aso322196241.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745339587; x=1745944387; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0puXZaHp7UawbCCHUOewZukqMquTxYiZAuf15dDaQw=;
 b=FP5YcLkyKlWklIglG0EJXZyo5z5nBSi546jMT5bWD36nw4tQYL+QBNEebau5+dyU+F
 jxohFvxrQ1XBOiSOm3kwj4cd0nBDKHS//JFb6AvIIzLFu+kg0zYqRKVcf+YFwc9zX6Fj
 rfeJG3yFa7wBWnPm3jy3pzGFs+Xr/n8+1iI7kyfDFXlf3A/ixtBKa1TZWvjqH+4JSzJH
 3+TihqJU9o9UOSxJ7O9/mTGeraJ0hXgf1eX2rv1P4rR7GdRjz5ciJ52T0qGNoafnoyvh
 HlVQWlf/HpMxWbiDwMdPVftbO0LyrU2OWqoZzMt2bq9OlBs96ajjz+mtOMA31MRQ9xIU
 wjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745339587; x=1745944387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0puXZaHp7UawbCCHUOewZukqMquTxYiZAuf15dDaQw=;
 b=qs8VDDA0R4QA4cxP5usqeTgusF0VZxpkjOguDM/zjptZn0N6YUxRUBn1ukRRw41+lw
 HGcdZsRAIt80vP83MFCze5Hl6vLbf44HTNLkYwxywvi9HkHXaYJPDZ9uiRGeY2pzWlyi
 DS6USZYwS4uwJ9OMGg3K013TvJy+SYWKdsqg+caw9mIDlwfywUBih126g4YqLCFmw911
 l1jmmaMXnK9G/G7SaFYD0Hiq13I6v7iCqaYzVOz/cJCmWdpB2FovyyMtXHBsaCZw5bJ+
 4r7NZF/k17OgE71Imj3/rsWnIWUh+qoosm/V0mcZR60ixffEnRzeQhlg8vIylVpylYuz
 MlmQ==
X-Gm-Message-State: AOJu0YxMeoKEX11m6Ylh0gUCwDyFJYe1N1JtSzYFiY1R3BjshaRULF7h
 4pDGQAW06vlaXqqqGgmK+OEmYzpvoiyPfvJfQuiVwjO6zi5dnDzhcPH36aMtZCXXjKTruuVqjiB
 arTbGQWzdQWFc9ANL9ecg3yyoDno=
X-Gm-Gg: ASbGnctw3FbK9MdNL4RGGnI6rFQXwQ4N2/He2ds3mfvBN9PD477HWLYAHRFtAxrorR3
 MyHHLBoziyZhDMP7zrY5D8uq0gJNvQvqU4xIxv1XkpAohcx0qx0z5w2v/jt3hPwivJJaCif9Ord
 /vlpu05G7eq+9vO5MVQR5DP284y/L40FGM
X-Google-Smtp-Source: AGHT+IEqpxEAN5M6nuGN2FyBsR7D83MAkxGS53Y8KKE2g2DaTUg1PVPlo9Z/GLvyKMQGRGFhmzlBj6c04WcWaO9VZAM=
X-Received: by 2002:ac5:c211:0:b0:523:e1cf:5aef with SMTP id
 71dfb90a1353d-529254942a9mr2965555e0c.2.1745339587652; Tue, 22 Apr 2025
 09:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250422160740.3610-1-mario.limonciello@amd.com>
In-Reply-To: <20250422160740.3610-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 12:32:52 -0400
X-Gm-Features: ATxdqUHVppwa7PGEbXLHqF1_tkXhBCZHfasE2vQ1O20vUiVOzVx6yAzt_FMj4Us
Message-ID: <CADnq5_OXpYTfdirM5d=+wFEF12L0+bLxz48V94fza+e4zRf0RQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/amdgpu: Add Ryzen AI Max 300 series
 processor
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
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

On Tue, Apr 22, 2025 at 12:18=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This has been announced so add to the table.
>
> Link: https://www.amd.com/en/products/processors/laptop/ryzen/ai-300-seri=
es/amd-ryzen-ai-max-plus-395.html
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documenta=
tion/gpu/amdgpu/apu-asic-info-table.csv
> index 094e76a65dc0..1d50b539677f 100644
> --- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> @@ -14,3 +14,4 @@ Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0=
.2, 6.0.1, 13.0.4 / 13.0.
>  Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.=
0.4 / 13.0.11
>  Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0
>  Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4
> +Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1
> --
> 2.49.0
>
