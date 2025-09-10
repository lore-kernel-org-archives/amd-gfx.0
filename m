Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312A0CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 12:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A571910E2D7;
	Wed, 10 Sep 2025 12:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kIrpTK1Y";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A71EB10E2D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 12:59:33 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-24cb267c50eso10398555ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757509173; x=1758113973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/LQSZwBH5dVI0mhyPDvqEY4kzgsnjSTb7T9Cswt/lo=;
 b=kIrpTK1YOncxu1E3dzyPz02bvtUdldjsFCE5urogU4m/A0vJ2l8Z/kptgGmYR+7iLX
 /RFYy8vv2K9/oviduqDQtZ0LviXVI7v+b76ggBnX6wX5Ag9x7C3e2iWyhiLcgMv3oTY7
 fmXJIEPBpUJ7fzVdIK7sOk+t0EsF/Wt333ge2eWOZHcchs3ocFL9F4Ag8xK4A5U//Qhk
 LNKapu44eIvW45zIG897YsyTPZyaR9dVMdPgXA8DfUrfnZbqsU+S3et+eqXs7UkHPbJL
 Y8aS0l9elCxhYgNiEsayA6M6vlW4vLvLpkH+AAmq77tyuEGZH1U3PvNcKQsScvO4NLxQ
 iVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757509173; x=1758113973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/LQSZwBH5dVI0mhyPDvqEY4kzgsnjSTb7T9Cswt/lo=;
 b=F1cJKd9z22hEwJAHnUrfvCP+vSTUYZCmeQJHsAU13sucidmujGTKegZQ2OFr3mKMsL
 kXsxEEncHseDbpkHjJ34ZNV16qeixK6YVN8x59C8tIcRsVIfoLhNAuHX0ztFWRba2qOi
 P0IzSRuklCvJZSFbp2i2i5wP1JZilZfNnSHyQLNRfDMnVVmplEIoM7F/knb0I3fazKpO
 vP4Vk3rs3fIvlpQFF97yHc9DkaXrGxS3caT8mTLZIFxxg6VHIwqADUfO8tAGutLnmX7k
 bruz0p13GGF0oifp1hTURx5g7xN6f+kz3aXShi+fGkRJxBBppcCYde4SA4vSlGIXfJeM
 xhgA==
X-Gm-Message-State: AOJu0YyPr1RKmaHJ97TaL0boPE1RIe39CIeKcOJLksvPf9QN6pCo1Cz1
 2kbqrWj2k0qAJQGA2qkA+Wug4Tl0Kga/wrEuYRq9l+VUWZOMqdB47HEIfvCcsYCTpc33lvyFQcT
 8m/DbDvKvkz/9Lc+a1h29+wP49J90QqQmng==
X-Gm-Gg: ASbGncv3Bd39MXJOAo8ZG9OOOBoperMe4N3x48xSuAQs/l6vuVLs+N60CWu6yCwuUDB
 jDxDQWJ7Z6ey9tWlRoDgeOZJTiVPSPTEaR1gOD44FOjOVkCJjG0pNaNJK1FIM2dW2GDzSL7ThI9
 2KGu9F/JvSaZA3q0vWZ8hohiVbZSTOCZ9/2yf6pvISEOyb6KVjyhWuTPT0A3oJGhjYYkvm0LkpL
 qIwznE=
X-Google-Smtp-Source: AGHT+IFpWaKCLZ6GD2Hq95WR867GRj6pVxgvpWQ5kabLPBvZec2AEL9d7aWNdPWldgyxXRhgiHlkrK5glvTy3vtyGg4=
X-Received: by 2002:a17:903:2442:b0:24e:4248:3d9b with SMTP id
 d9443c01a7336-2517121749dmr95728405ad.4.1757509172798; Wed, 10 Sep 2025
 05:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250910042254.3718982-1-mario.limonciello@amd.com>
In-Reply-To: <20250910042254.3718982-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Sep 2025 08:59:20 -0400
X-Gm-Features: Ac12FXxSDeCzZI-zI2B4dxaGA3dM5cRft6sJm1z1MQb8R4IVZcdorSJOraZSgtI
Message-ID: <CADnq5_NxDUVKH1L2G+4g9RdES2tjB3P=3QQqSmwo2Oi59Ryjog@mail.gmail.com>
Subject: Re: [PATCH] Documentation/amdgpu: Add Ryzen AI 330 series processor
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Sep 10, 2025 at 12:29=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: "Mario Limonciello" <mario.limonciello@amd.com>
>
> This has been announced so add to the table.
>
> Link: https://www.amd.com/en/products/processors/laptop/ryzen/ai-300-seri=
es/amd-ryzen-ai-5-330.html
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documenta=
tion/gpu/amdgpu/apu-asic-info-table.csv
> index b479c5629146..dee5f663a47f 100644
> --- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> @@ -13,5 +13,6 @@ Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2=
.7, 13.0.8, 13.0.8
>  Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4=
 / 13.0.11, 13.0.4 / 13.0.11
>  Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.=
0.4 / 13.0.11, 13.0.4 / 13.0.11
>  Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0, 1=
4.0.0
> +Ryzen AI 330 series, Krackan Point, 3.6.0, 11.5.3, 4.0.5, 6.1.3, 14.0.5,=
 14.0.5
>  Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4,=
 14.0.4
>  Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1=
, 14.0.1
> --
> 2.49.0
>
