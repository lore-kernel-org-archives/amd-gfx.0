Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDAFC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 20:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8775E10E924;
	Mon, 13 May 2024 20:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UNEqlVGa";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1C510E153
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 20:23:49 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2a2d82537efso3584006a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715631829; x=1716236629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWAdzuu2HAvunklABDp4h5u3tH1XqDJIRHF8CAfzPFM=;
 b=UNEqlVGaZm73yC254D7+9YEcLRqgpiLwK8Xm/1u15IcYPMXULdKUBjpEJfUmem/Ld6
 rfcs2uyclF9xQiF7MycS4ufPGkfM8u3h2lNf2mLLhlK5G21QYSGwqJVYzfOVbkVThbsv
 qcj6TZWIdgAW5u3OH7KwhvkjFCv8SrVsYENxeIxGNx8VUaYyIDa+YNMJA2OzQB4W3nmk
 HKQjrHnJ03pPn+t+oWMnlZF6EQfdv9jfWzd3de7XGHx6Hhg2LYo9t8l33Cfl5IeHj4RQ
 y3LWaTRRtcVFhRFiduGrSSWTiCfOGPXPc2YYDkqPkUG+1edN9waYvHwbxz7SSJ0JMtn/
 U2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715631829; x=1716236629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PWAdzuu2HAvunklABDp4h5u3tH1XqDJIRHF8CAfzPFM=;
 b=RYpUoD+NQI/qU8qRjXMkFl4fX/y4P8GxXHNTgm0jhvCGb0yv7l9IBqqMVFuiabLcSy
 9VQZGdX0H8seYNv+WRCF0oqwKUt2W1OiW0IcSdCrf8kVp/noawOQS7yuFGfIjmbnnIjt
 LJpM2mmc77FqP5MvjVA96dh1FkKZU8xFNUPEPyay7KoU8mNBvkOrWB3zcDVPjl0OPLcW
 4KdeGP06O48Tv3sVQNlXjwNvm0sC4fFqiG0luBAd7s83BknB25fbCfMQezlQBwVaf2wI
 wuClyxStf6IGMZ6lGsosETBczvOWxKvZmiJtJiCWkT34Jjc1iny5+gBRbTf9PUtTjasw
 sgAA==
X-Gm-Message-State: AOJu0YzDAVK/kh9qGUt5vxW2XR6YYzmuIymIGSBN+4+PcfTXOs+75NsY
 wfqNwstKQKd5YdO247Sr5CJmwZy3lwsAgvaOlP7PvIwS7wXxSdH+5VvdSbud8kedd3Lo6yNrsQ8
 gUsEZrp8baGr7vU41nvJ12ygciIc=
X-Google-Smtp-Source: AGHT+IEh5FjT5zbVyXk1pdHqOtY1/yPog0XQ7AOgHoFUFGf05yT5uGufpDBjcwcQKTpfKVoOdZJRvPPtQTFvC8iWpjA=
X-Received: by 2002:a17:90a:fa03:b0:2ac:d9f:de9b with SMTP id
 98e67ed59e1d1-2b6cd1e4e09mr10089033a91.45.1715631829177; Mon, 13 May 2024
 13:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240508192345.3688461-1-alexander.deucher@amd.com>
In-Reply-To: <20240508192345.3688461-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 May 2024 16:23:37 -0400
Message-ID: <CADnq5_MD7sF9nqMt4gXpXToUk8ZAs-wFt=Q0jyOezBadosYq7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/soc24: use common nbio callback to set remap
 offset
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

Ping.

On Wed, May 8, 2024 at 3:42=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> This fixes HDP flushes on systems with non-4K pages.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc24.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index 12900488dd618..66c7138fc6aa4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -372,11 +372,9 @@ static const struct amdgpu_asic_funcs soc24_asic_fun=
cs =3D {
>
>  static int soc24_common_early_init(void *handle)
>  {
> -#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
> -       adev->rmmio_remap.bus_addr =3D adev->rmmio_base + MMIO_REG_HOLE_O=
FFSET;
> +       adev->nbio.funcs->set_reg_remap(adev);
>         adev->smc_rreg =3D NULL;
>         adev->smc_wreg =3D NULL;
>         adev->pcie_rreg =3D &amdgpu_device_indirect_rreg;
> --
> 2.45.0
>
