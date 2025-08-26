Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0BACA0FF2
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 16:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2182E10E384;
	Tue, 26 Aug 2025 16:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BqRneBH3";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0981F10E391
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 16:30:48 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2488be81066so420225ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756225847; x=1756830647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nAQG74f1XoUdzRRVoRYb2hBtj41i0k6MRtVsr9sSDY=;
 b=BqRneBH3+rPGu49ug4ynO6GZkzFdLQQcOXA2kWjuJk7Bl3PmEabGfMg/EyIucnNAeL
 GNAfuVqQzQS4IwGaujy52kw6tGZfk6NIZbgPMCs7NLZSqtiuv5kR8/sr+6QvUpevjGAW
 I03zLA/PcC5yJTAa/XaPlztx5nQAXZfDPyy15D8+Qjf41AmsA7VA9cMqRtbWpvPDTo3K
 g1+e8nx2QnEGLvV+48QNTOZevK5N4AukwrKDPd73mW5PVS48WIMNliNOlu/Ld4fUHytD
 vlTVQmVeJFwbljrBLED68WmcGN7PBAJRh9C63GGO1YsYhbIUe/QOKwZnEvDMaiYCO6qT
 sh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756225847; x=1756830647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nAQG74f1XoUdzRRVoRYb2hBtj41i0k6MRtVsr9sSDY=;
 b=gsrTAzV//EroZG3u6VfjdZYJKYFNb/75JlVuXwAzn9bH/Lwqi2Cwkm35WyeilktuDT
 PQ+gxYq0N27gK+iwchBlAQh5m9TBeoBxQPc4lmfe5EowSxv/4e6x/1KxGVnN5jRLk3ni
 xpsTC9mWV/HuokomqWNTRg04G7fY+XDieUMB7YGH3xk4/gexzLxtCBamOmHkAn1iWvTG
 x1DSI2I/8UPwCCq1TpX1OKsNUnvU6UcpdqoOitnKTznSER4oeMhuZhRKoLK4N5pishz0
 mqGMRPwYqBuXufrpMFpMp6oLKT+VgwAN78PX87v43cb6gUqTSGBLuRJR7SUcZjLNNAsM
 btSQ==
X-Gm-Message-State: AOJu0YzUXdxKv7//gUjmx/SHn1aQyjOngb+lEtlwvpbgzD1x/v0q31IJ
 u1eM45VmVxLf3eJ5M7CRxjkdXqEFLY5+ThzMRUzpqXRyZCLkUSflAa06DhCfxHKoRYnN3Cmyirf
 kaTd2FTgphmQn5Eu74dY6wLln17BSuod0Qg==
X-Gm-Gg: ASbGncvr6eZkMREN8+u5tr9j7nuVQZ+mOb5oLIyp7sjUAAOskRo+lkukX/CEU3QvVkb
 P+NzN8GJcyRFYX4tOOMUOHbLjQvUchJ506RJXOqsGxqLAqQaZKz95cV3P0x+b2Br/CwWuvKhxXg
 fOND7YWGC5Oyta14KZuksprAFv33H9OZWCqlw6KXNpSToojR+EZg5VBqlfpA4T3vPj3rHep39aO
 LrHAmc=
X-Google-Smtp-Source: AGHT+IENgPYQzpBP/EHZyYs3+s5zNsAKcLFkC9cwOdUH8YqdsIfMNOJbQ9ei2CwQ5PcWMU9CsvzAO/nGugDMRNcjltk=
X-Received: by 2002:a17:903:1cc:b0:248:753f:aff1 with SMTP id
 d9443c01a7336-248753fbd5emr16984625ad.4.1756225847463; Tue, 26 Aug 2025
 09:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250818200445.437007-1-alexander.deucher@amd.com>
In-Reply-To: <20250818200445.437007-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 12:30:33 -0400
X-Gm-Features: Ac12FXwMgQjwCUJYgskf0KdWA1tHJVzA0frehfjejdO59PiCNpLVi-j3wtHRE2g
Message-ID: <CADnq5_OZKh2z6hckWitZ==ncmjC=JpChOUmA2T87CtejDSH-cA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amd: add more cyan skillfish PCI ids
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

Ping on this series?

On Mon, Aug 18, 2025 at 4:23=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
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
> index 113e39cd164fd..f5252e8dceb01 100644
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
> 2.50.1
>
