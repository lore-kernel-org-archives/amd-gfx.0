Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D21C48BC4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 15:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230DD10EB67;
	Fri, 16 Feb 2024 15:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e2abQ1RU";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF4E10EB67
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 15:08:52 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-6e0eacc5078so1776553b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 07:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708096132; x=1708700932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88GGXIVGc9Soh+KCSNxX6os86qGGtUJZSglWuw8dIqc=;
 b=e2abQ1RUI/2pdGEUlWgVGQ2eZpdVzvSVl7MitI0XMJ0Jk61xGAKsmXk05exFNC0eqN
 cuU1Y1VjwhcDwIoaHcWZwcu9D9zkThlU54h0SFO+P1e2O3F/7sJkE2DZxSsclcm12LRh
 wgdZf8LFXnOS30EEHmGuVgMSB4/MFdQUbnjA/uBZO7/i6cFpuP/uUSngrzlLj6nq1LOb
 KPZe9FhvR2psts2Oe10lmFkmCJusUAXIhH2sWY1efq6GJ5qtdq57oyu3QJaydR58+syC
 l3XrGm6GZEZewQ/ddX6xaIuh/m18hm06gJ5KarfcCtYCy/SLo1qxAMRjZS+muZQ/NVrn
 UPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708096132; x=1708700932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88GGXIVGc9Soh+KCSNxX6os86qGGtUJZSglWuw8dIqc=;
 b=urRYtDGcciQjnwiROC9rGsttOYxFJhAwFui6P1XudHAqJ3tKaVu/G8m3o6/pJjMTY8
 SpXwK1rpT3TGSrzSr6WhTpSoEj3vWy9g9I61KCmfRymxYrybL+Et70IrEmlyrfWUcqRM
 FQ9D8Vgj7MkXicN4zc5Mri0lgToVRZzTqdAEFsLUQN34cKcTYPV2B6KvFjFDMb9+zXzD
 qQffqaZEWPHphwK1uWGVmgG4VgiVxgMQHcMsKzgNfgRa27QRpnBU5dP5bkh8cOw9ygR7
 NFj9SWlJC8FzwXNw5Nfw7W7Bzl+hYgQ6bUPUKZKDbrMx/Z6JdknM3k5b/F5AKe5M40Ir
 dXQA==
X-Gm-Message-State: AOJu0Yx2gFT8tQaSrKGzmzjFv9dvAKlTa8kgekyY2pyDatN4pmS5Pzrr
 eOOE8y8QS8VyMWAMQrJjRzvwtZsDaogLKy7OS7kFf1p6ej6G8U0dhjkXEe3GGN0pgkLHyZx+bH4
 G5R3iKPlEOPwSNu3xtiBqce5vjAuHRNB6
X-Google-Smtp-Source: AGHT+IHIh5FuMOODXEWrgwkSOj1pQ1ElgPuwc1qlfMiMFN5oj+hSZrD3Cc3kac9yaJSCNOhiV0h9aMHj/yrB1hPp0xs=
X-Received: by 2002:a17:90a:928e:b0:298:b0ac:980f with SMTP id
 n14-20020a17090a928e00b00298b0ac980fmr5043127pjo.41.1708096132136; Fri, 16
 Feb 2024 07:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20240215214847.67525-1-mario.limonciello@amd.com>
In-Reply-To: <20240215214847.67525-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Feb 2024 10:08:39 -0500
Message-ID: <CADnq5_MARozBmJkdf5EU5okaojGQGd8mTRRtzyntMamaVcDNGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Change `jpeg_v4_0_5_start_dpg_mode()` to void
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 coverity-bot <keescook+coverity-bot@chromium.org>
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

On Thu, Feb 15, 2024 at 4:58=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> jpeg_v4_0_5_start_dpg_mode() always returns 0 and the return value
> doesn't get used in the caller jpeg_v4_0_5_start(). Modify the
> function to be void.
>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1583635 ("Code maintainability issues")
> Fixes: 0a119d53f74a ("drm/amdgpu/jpeg: add support for jpeg DPG mode")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_5.c
> index 3602738874ee..8d1754e35605 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -358,7 +358,7 @@ static int jpeg_v4_0_5_enable_static_power_gating(str=
uct amdgpu_device *adev, in
>   *
>   * Start JPEG block with dpg mode
>   */
> -static int jpeg_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int in=
st_idx, bool indirect)
> +static void jpeg_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int i=
nst_idx, bool indirect)
>  {
>         struct amdgpu_ring *ring =3D adev->jpeg.inst[inst_idx].ring_dec;
>         uint32_t reg_data =3D 0;
> @@ -411,8 +411,6 @@ static int jpeg_v4_0_5_start_dpg_mode(struct amdgpu_d=
evice *adev, int inst_idx,
>         WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, 0x00000002L);
>         WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_SIZE, ring->ring_size=
 / 4);
>         ring->wptr =3D RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR);
> -
> -       return 0;
>  }
>
>  /**
> @@ -458,7 +456,7 @@ static int jpeg_v4_0_5_start(struct amdgpu_device *ad=
ev)
>                         VCN_JPEG_DB_CTRL__EN_MASK);
>
>                 if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
> -                       r =3D jpeg_v4_0_5_start_dpg_mode(adev, i, adev->j=
peg.indirect_sram);
> +                       jpeg_v4_0_5_start_dpg_mode(adev, i, adev->jpeg.in=
direct_sram);
>                         continue;
>                 }
>
> --
> 2.34.1
>
