Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126ADC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 20:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE1810E22C;
	Fri, 30 May 2025 20:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FQlrhDct";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5B510E22C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 20:29:04 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-309f26c68b8so262872a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748636944; x=1749241744; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hwmwgEugIoedYtMCGzWVj60PJES9DClcSI4jPJlEtk=;
 b=FQlrhDctUSLdC0sss7iGZWT/KC4nItqL+RuMxdDol9W1mgMErJZJ2rbSGSL3IHyimZ
 pnMlwcWcMxA6n/hoZgcLtamzp1xM8JKx21+v0CM9HfvPV/9SPYSHfEh8BEbTYlPPEOe8
 /Uf8p0gmSBwkvOvKuv8nUfcZ0kKNwxG2wBMpVqRlQ1tJMW6alQ4sWKmEAqOZRA0c3+Hh
 kI+zajfI9C9PvaPvSAatTb0I/iWB3HpjGlU3Ac2lc2ynxoxBbU8+HQep01T0dfPwkDbd
 SGlCTv7CX4eR66LOio9okSAkhqN+lgyZz4OGdOipLkcCiD8lT61Q8j8U7ouUgiQ5c4k6
 8fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748636944; x=1749241744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hwmwgEugIoedYtMCGzWVj60PJES9DClcSI4jPJlEtk=;
 b=aZt4CYCcc5NUM2D5D2+fZQHY8DWOMVzpzCrjRuRawnaAkz/YUr/H2XgvHBbbape6gc
 V1Nr34rsFRdjxNWL6Z7SmpJpGoj1TQeF+qnSujxcPOd5u+IfHx+IzzzCMhiGUwoL4Ihn
 SLpeZnukSAU1dVymeSkdvLDO+Yst4u0er0bDxEI3OW3TU+v1lE5QFRICLuR9LJlXl4mG
 +hNsS7ZNMYf7nq/P6bis3Oi4iYPlBvInEQM8HbgTGIINuMxpUkz1KI2FyLeq5fGw0TJu
 mASaNhkwxp8vIVFyXwdWG+JdZiC5RcTAB5Fm9Y2qIPoYYbIXfI/6NDs63lLbGp08e/ag
 VIpQ==
X-Gm-Message-State: AOJu0Yz4nveuVEVspn+Q5nYrJLEezRamUVgBI1jlYrph0sqOGZ3Ojva0
 vFvDvoDbayhJYwBDDmDiO8BrOZMBGki9MKuHnANaIVz4nPJ517QJYSbCLe2pQ1IM6tm+mHPAolF
 zEUgOLgrMpw6sCvll6UW+TRbfDBNtRsBP3Q==
X-Gm-Gg: ASbGnctbH1DkiXWFc1+8UShA7uZv0Iekc0QIMHQWN7PaIwxwSMn1pTEkJ/qOm91SLnh
 YbgZPqqO8Kr/aJjMFo5sJowyGc/MyvfAtiaGDJ5TjTl28L0jSxbXEDQxVjzgTJ1M+S+gj9075HP
 OzpGSmnh7y/HUDN1tpVchYSonWjAFR68hGCw==
X-Google-Smtp-Source: AGHT+IH235aKg3LAyDBhPiEdnz94Y3B59YSAGD+4dXYZaIWGlTxbplfXQL0Our35ZWf98W2LZGqNqtzDb2/JvAzENPI=
X-Received: by 2002:a17:90b:1e01:b0:311:e8cc:424b with SMTP id
 98e67ed59e1d1-3124db244fdmr2138986a91.5.1748636944248; Fri, 30 May 2025
 13:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <CABH-8xf3sg1CiHWM9nN0a3eSRTF9Lc_vkcZDzbvWZAH0f+Gf2g@mail.gmail.com>
In-Reply-To: <CABH-8xf3sg1CiHWM9nN0a3eSRTF9Lc_vkcZDzbvWZAH0f+Gf2g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 May 2025 16:28:52 -0400
X-Gm-Features: AX0GCFsAS-W41WLuouywIlQBb0KQ0NPhV3q3O6zCjd9KfPGON5V1F4g8vCS4w-E
Message-ID: <CADnq5_MYFt1fS4m3gn-TDSbAot2DpXDZtt0f3DFWJKoPXr3-zg@mail.gmail.com>
Subject: Re: Regression: RX 470 fails to boot with amdgpu.dpm=1 on kernel 6.7+
To: =?UTF-8?Q?Durmu=C5=9F?= <dozaltay@gmail.com>
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

On Thu, May 22, 2025 at 11:10=E2=80=AFAM Durmu=C5=9F <dozaltay@gmail.com> w=
rote:
>
> Hello,
>
> I'm experiencing a critical issue on my system with an AMD RX 470 GPU.
> When booting with recent kernel versions (6.7.x or newer), the system
> fails to boot properly unless I explicitly disable Dynamic Power
> Management (DPM) via the `amdgpu.dpm=3D0` kernel parameter.
>
> When DPM is enabled (`amdgpu.dpm=3D1` or omitted, since it's the
> default), the system either freezes during early boot or fails to
> initialize the display. However, using the LTS kernel (6.6.x),
> everything works as expected with DPM enabled.

Are you still having an issue with newer kernels?  E.g., 6.14 or 6.15?
 I haven't seen any problems with polaris boards here.  If 6.6.x
works, but 6.7 does not, can you bisect?

Alex

>
> This seems to be a regression introduced in kernel 6.7 or later, and
> it specifically affects older GCN4 (Polaris) GPUs like the RX 470.
> Disabling DPM allows the system to boot, but significantly reduces GPU
> performance.
>
> Things I=E2=80=99ve tried:
> - Confirmed that the latest `linux-firmware` is installed.
> - Verified correct firmware files exist under `/lib/firmware/amdgpu/`.
> - Tested multiple kernels (mainline and LTS).
> - Using Mesa with ACO (Radeon open driver stack).
> - System boots fine with LTS kernel (6.6.x) + DPM enabled.
>
> System info:
> - GPU: AMD RX 470 (GCN 4 / Polaris)
> - Distro: Arch Linux
> - Kernel (working): linux-lts 6.6.x
> - Kernel (broken): 6.7.x and newer (currently tested on 6.14.6)
>
> Thanks in advance,
> Durmus Ozaltay
