Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F231AC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 13:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C16110E46A;
	Mon,  7 Jul 2025 13:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cH1izd8p";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5689F10E46A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 13:13:05 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-313862d48e7so372661a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jul 2025 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751893985; x=1752498785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhOipWUG6QdzmZ9AhXjQv9Ug9pYg+cZVTAo5KPMPnOM=;
 b=cH1izd8pkR5XGdKvaRZKccVIAS0Ztvu5d4UobgOCYf9a11cMHRQY+QBsF0OHvve/ik
 fynlt/YaddWk/BuB5aVYxEqQXLn1JnVoAwTqUjOgZdbXArvR+8ao0ZMvV10O/Z4L216b
 HdVuKB5GP1fLZz13MhF8VKUi4lkEATkefxhLUnw+I8Y42D7Y6KnI7sq5xWNsCV/j79mh
 /2veJ/5OPm652AbUeCAvaxJcWEMd6aApyN5pwvw13K0dNaWL0S+c5yXfM7c75wUJSqYw
 NU9jsI83Nx21TG+5baMhgKuvof6lPjEUrzUQE1pa9T/99wlgI4bpfDwnhpAQK8zndp2b
 UZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751893985; x=1752498785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhOipWUG6QdzmZ9AhXjQv9Ug9pYg+cZVTAo5KPMPnOM=;
 b=iL3+Os3Vg3/gURoOjeAdm7C4rmaGS6rt75ikuKB7FUM6aKQhiH4X0M/i3Rco8Dpdke
 M+2kLLlbUFeLubK+58Zr89q+DSTVzD+2m6tD0bOGZgnnv448y2SKWLHUYMsXtJ3v8Fny
 8z1k7+b6S3YwrO+Bh134YiCE8lpqPjiJ8gwdQSq1SkkkoRBEU4LOVOWPiLSieixHHngG
 AFgxzh5mSlybWMHJkCkq/oR21v/vUvXmRhImebCvXCZzOZvZ+uAvU5mxWybvH7FXqfb2
 H/LYzuMV4FzMC21CA1snumeWD00WObT6sKzDYTLl6n/AM2kuIDEU0sTnVpNFBQeFozUK
 UobA==
X-Gm-Message-State: AOJu0Yxh8XPRMZ1NLV5AjO2V8IZgb8cxpruoYdwGsSj/QxizGc3IHfCO
 g4FdvErhOXbA5GWm2qXRsYgK9JgnYYCFMuTrZj1QglWhyzMa6I4zQ+FwVk6VTM1eeHCpWVjCnSq
 IyjqoqJoJg3AmIern2SKlCGE6AFDz3VQS7A==
X-Gm-Gg: ASbGncuVLSOkxzgStLr3H6L0r5vGMUL/7atpFQ9izoXvZL77XLlux/RyZbKyTGyrIVG
 9mnUFpNXnmDJzN5RAB00k3dEBSkWPFhQaprgnrtI/H1/KixmjYtsRjI8YOQEifey37al4x3RXz2
 jBWWWEBWkvh3OTAfL9UZP12jvvtjoCekVNbzqNHn21Ejno
X-Google-Smtp-Source: AGHT+IG6H2xB9AndniGK2rpGyh/HApGql4zGdclVYuVuS5lOoNgTzh18+O8fUrhdu2/xQstmub1nx3kGZ65o4bva/pk=
X-Received: by 2002:a17:90b:5744:b0:314:2d38:3e4d with SMTP id
 98e67ed59e1d1-31aacc1286dmr6745755a91.3.1751893984785; Mon, 07 Jul 2025
 06:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250627143342.23856-1-alexander.deucher@amd.com>
In-Reply-To: <20250627143342.23856-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jul 2025 09:12:52 -0400
X-Gm-Features: Ac12FXyJmlPiD6xfu9waR63D4Qtfk_Y_34HrFRi7S6W5PtKPnnQqi-EU9BlmLl0
Message-ID: <CADnq5_NQ_TB+_Ewgtxh9g6Q_so5bCzym8a=o+SPZ5aX-+NMbog@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amd: add more cyan skillfish PCI ids
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series.

Alex

On Fri, Jun 27, 2025 at 10:34=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Add additional PCI IDs to the cyan skillfish family.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 21aea5d28a161..9a05efd80f278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2172,6 +2172,11 @@ static const struct pci_device_id pciidlist[] =3D =
{
>         {0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
>
>         /* CYAN_SKILLFISH */
> +       {0x1002, 0x13DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
> +       {0x1002, 0x13F9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
> +       {0x1002, 0x13FA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
> +       {0x1002, 0x13FB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
> +       {0x1002, 0x13FC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
>         {0x1002, 0x13FE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
>         {0x1002, 0x143F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFIS=
H|AMD_IS_APU},
>
> --
> 2.50.0
>
