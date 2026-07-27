Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01F3C531C9
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 16:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F45B10E482;
	Mon, 27 Jul 2026 16:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pzxT3UnE";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1AC10E482
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 16:21:31 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-384422b05b5so370956a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 09:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169291; cv=none;
 d=google.com; s=arc-20260327;
 b=rZGCWQrIz/aSSpz1e6szWiD4OcR8w4Y80e4BMOBsV0tmaNyNwZhImg40OrHIS97Ngv
 dvIR6ySAWlEqnga2BF4GMN7c8q+3p26sfBiNBKOj4zB/t/3qQ/ZsmJs4QtL28rCZHs5x
 zfwFNb1NnMOhCNW5AdGI1tDl2h2FXV+FYhdbXF0x6dtc/nQqpzK9jsD0uaSWrPOw8dE9
 gxQhC6JLKcDgwd15jG2wGyztHz2n1PNEXvWmHHe4S9gEm5tkWIN+Z2qMoYNLKNbzPvYb
 /HII0Dxqq14HL/obUvOuT3dyyDNYZmJCiTOQT62ZTid+m7OdBWCbBrVQGm+DrE4FMxja
 +7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RkDN58d4omR2Qtqlf+m+Fnvo+P7XY6OYMuM0VGPBGVs=;
 fh=KYHpwn9GRgBbNPGRR65xHPhsk1S2YAD7hnaEg2QaKeQ=;
 b=IdtVq1tlw8CQCwK3bF6esVHoTeynDb7we+Y4aoSAZCaRotKT4Rd1pbipP0YxfFdTA0
 qZ2kEq1p754B5Iwog2+vq6hj0a6j2mfbH2KiCCEc5pn1Y92QKO4nFnU5QkYcGsVaosJs
 QBl7havRITcPlyqRqIfdnA9gYNspOAd9NDW0/IHympt8YuFehaYy0sWugcUOLfawG4c3
 +Fa2itrpI+jssyab/p9FJSiy66QlGztRl8nYyIfWWLn/XOZfc6GPN9p4ZWL+YHH4Rmn3
 Zwr+kh3NM/9FomX3/h9R6vxXQiZgaqfSQ7yEfsgV/JRMgdGpUyAvAPQHL1AAtL/2mdXW
 1u7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169291; x=1785774091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RkDN58d4omR2Qtqlf+m+Fnvo+P7XY6OYMuM0VGPBGVs=;
 b=pzxT3UnEHs00BHcVCq0yeCZjIg1olO8qsJqeZ67COw3QuFQ4PDiROu7N1r9UWdAt1h
 vMWGC4afeif+EDqDwUu6hfAUzgVwYKt9yb9tZtZkAI8PIzUU45SSTE9oKBb7/LRR4iEj
 Y6ytjDm6iyUmxVE9qhLhj8WAHB3THLiLHVFSZiDVXQSTuhuxGjF82+wwGHG2oUONWmsG
 /k2e4d8l5gz0KmTlzZjg4iIF/DHtelAEmXxKfuz4iBHfEj0qYJkQXEvijtjZptYpgmav
 sCO2oiaCrvfC4qVYDSb2OOJd68Z8CMA7rajo7x744GZuV0egKOwGmOb60FeFO/qbGB2v
 kSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169291; x=1785774091;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RkDN58d4omR2Qtqlf+m+Fnvo+P7XY6OYMuM0VGPBGVs=;
 b=hChsqhiGBwPJkZj+C5v8DYHS9LhS7RMAmtSXI6WZBh07SqpXd8/wuJ7F6IawzuBtMI
 cWK8rmFp9O8wkL0OY3BRPsdVsJTtCgX7Igf9QwM2T0EnEaFQepf2/nITIPY+iGymJBhw
 mnkEXVUnsdpesvYqPqp62PiQvDyL+zWiMu02UqcqZj3P9O2ANWdi77UY+TItVeTmqP4y
 445Bra1pW/YQwKk330rwbHA6Yuuzt6GHlTLKFqq/kT1ffZTGJ3fkrLTxI3bD9WsEXlvv
 vzX4nkq1jfh9YGBjN7UQyqwhjgOlLJ6DHokbLiI/OxsrnPjKBn3F1DfLdSp5pCDH8eEe
 z2BQ==
X-Gm-Message-State: AOJu0YwgS3L6H2viLbeJ9fmpMvLlGr1DtEfO9W8f10pBkDMPJV6JvMc0
 p+W7PBvW3zHk0DVZGdbM4nGSN0Z3rUtk4L+aVupgK1LSIKUGRin94aDKSmWGGz92/AUZDczSZmG
 BY5aKqg7Aix3+4MXVrmw8+X7NTlDka9o=
X-Gm-Gg: AR+sD131mDOYDNS0gD78BPQ8q2vfBwPYqReWcYHCecKtw7iNKP5ZGNmF4+fj23eTFB7
 t5TgOSMLl1/fG2pLVwrg9uWO8+N85Dwmi6iGMFIH9tzIr1KUf+EqtVFC7JZ+wmm6xhkutJQVXe+
 VnvYxildbD1/GR4J6x+UVWMLDEJHnn8+jvXnBP7n/IJHnKBkmQEhNyAeYbJeJoKwXGpu2p7+0bk
 p2FHesA2D/GlSUshJ7YDLgdN3ja2a4LBdiZOBTaM/0G4LEsNKMWQvu6ZZrv4GJ154Uy68LRxuU+
 WwOWwGaT/AzhXvO3VGL62vVZuRTeQjuNGmwG0BlZe0zACGhBXB0fEz3n3MTg9i28ckXAIEaIk28
 frF1MF98T5sfTR/r65k3ZKowDZEgeuge9VhL5waeAWA==
X-Received: by 2002:a17:90a:c796:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-38f57f023e2mr2551284a91.0.1785169290862; Mon, 27 Jul 2026
 09:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260723095431.2831513-1-qiang.yu@amd.com>
In-Reply-To: <20260723095431.2831513-1-qiang.yu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2026 12:21:18 -0400
X-Gm-Features: AUfX_mzD0iy-nD3qJiZAEmxAuLi95tDbKijQCT_OEtaBL-u5CQiDllIJGm6I9r8
Message-ID: <CADnq5_OJoCZceecuKbuXuVfRL1Ke4asMq_rL9AXDLWjR8W-_aw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12
To: Qiang Yu <qiang.yu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Qiang Yu <yuq825@gmail.com>
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

On Thu, Jul 23, 2026 at 5:55=E2=80=AFAM Qiang Yu <qiang.yu@amd.com> wrote:
>
> From: Qiang Yu <Qiang.Yu@amd.com>
>
> TA_CNTL2.TRUNCATE_COORD_MODE selects whether texture coordinate
> truncation is D3D9/GL/Vulkan conformant. gfx11 reads it and reports it to
> userspace via AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, but gfx12 never
> read it, so the flag was always reported as 0 and userspace fell back to
> the non-conformant path.
>
> Read it in gfx_v12_0_constants_init() like gfx11 does.
>
> Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Qiang Yu <Qiang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index b3887c5262a0..d109fa06e32a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1827,6 +1827,12 @@ static void gfx_v12_0_constants_init(struct amdgpu=
_device *adev)
>         gfx_v12_0_get_cu_info(adev, &adev->gfx.cu_info);
>         gfx_v12_0_get_tcc_info(adev);
>         adev->gfx.config.pa_sc_tile_steering_override =3D 0;
> +
> +       /* Set whether texture coordinate truncation is conformant. */
> +       tmp =3D RREG32_SOC15(GC, 0, regTA_CNTL2);
> +       adev->gfx.config.ta_cntl2_truncate_coord_mode =3D
> +               REG_GET_FIELD(tmp, TA_CNTL2, TRUNCATE_COORD_MODE);
> +
>         /* Program DB_RING_CONTROL for multiple GFX pipes
>          * Default power up value is 1.
>          * Possible values:
> --
> 2.43.0
>
