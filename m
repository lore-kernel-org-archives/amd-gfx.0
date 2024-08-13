Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD0BC52D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 13:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F5410E34A;
	Tue, 13 Aug 2024 13:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBC0MTs3";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76FED10E33E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 13:13:22 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1fc566ac769so47966195ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723554802; x=1724159602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hyun60GRhWUSZ/C2cAmtltIl21h7ydwMSNkM5nM+EGk=;
 b=UBC0MTs3hhOwUPHeB6pCW9U61JOtKs9DXiOyQc/q6sZaEaoklXap1qjQHdJADbt3AK
 V0Xom9ZIyLU3hIFaPFlYWKszlW2RJno6lxXx/FZVnF9N8icoKbTgaiRKlGvTQ2zN79oW
 aHKqEx97g6DDNgwnESOQR5nJ95k6lnz7kICssMF/XEw1JanlNI7z+WmIql5qmSUAOmw/
 WYCwoNVESlTvF9PheVJYLqIR0/9YJDmuPOcpWIbztTUhugTh7ZPUouNHVd8Bv4jnORTV
 zJ54LqnvnCIgLpsvgskHgLb76+pp8JW/zdXyxxE4XkDN38dELIenl0nH5XCSYKhzjog8
 y40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723554802; x=1724159602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hyun60GRhWUSZ/C2cAmtltIl21h7ydwMSNkM5nM+EGk=;
 b=dAwyBc6H8hld49zuLREk3mNSUJ+Uhsx3gBXKrdvNks2vCkV+zaoYSxKZs9USDziSvg
 BsW+Gb0vS+TxDs7T9rivnsRswVQfrE9d8i+lEPDHrZaC5ikxqb5d3Hx5cS8/UOsUOtre
 vbg1y9cA93vB3+k4hWUyV27sqovDr2Aikm1ri4ylH1Oi3tAfnz6nNbyO0N+MGx3C4jzZ
 eg3ZFEFb4kRYNYjajLifJFNvNCIuTJLcGrZ8F0ZrutkoOrSNyptOH1vhQuBCGZS6Pp3S
 zN8uteS6h2kiPUssN2PPb4GdsqQr0YldHEZELyRxaYGeo5eYT/k6KzCsUX/wAyIYDbSE
 drHA==
X-Gm-Message-State: AOJu0Yw1EmA/ZWB9rahlNf/Q62M24xAUrvJ/Uh/KQ6owiQ6A0d4Oxsro
 l7NmYLuJIkggvvF/qYl+fEAI9VWrC7/PDwFy4C55sAK/wi5O4vKq10s4n/K0Qsr89xwa+Xhp2TH
 nNVTNxz71XCzUpVGL4RdSIiMrQkBQ4UC0
X-Google-Smtp-Source: AGHT+IGXwhHrk8WMWNicnpX3SJiceUCLxds8PbfvChAbKTaowoQXcdGvon4RqYtGhm75BqzaX79iFQ52nbC+aKQCbok=
X-Received: by 2002:a17:902:e742:b0:1fb:54d9:ebbb with SMTP id
 d9443c01a7336-201ca13ee56mr38697455ad.22.1723554801756; Tue, 13 Aug 2024
 06:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240813060344.3633088-1-kevinyang.wang@amd.com>
In-Reply-To: <20240813060344.3633088-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Aug 2024 09:13:10 -0400
Message-ID: <CADnq5_PjvaqbT7A=Wj+rfPM1Bn2+9UhSA0To-LrVm=RLZTrj8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fixing rlc firmware loading failure issue
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 hawking.zhang@amd.com, yifan1.zhang@amd.com
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

On Tue, Aug 13, 2024 at 2:04=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> Skip rlc firmware validation to ignore firmware header size mismatch issu=
es.
> Refs: 49e133c973ce ("drm/amdgpu: Fix the null pointer when load rlc firmw=
are")
>
> Fixes: e1c6c2c1099f ("drm/amdgpu: refine gfx10 firmware loading")

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3551

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 75a6ca645964..ca983a014ba0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4116,6 +4116,7 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdg=
pu_device *adev)
>
>  static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>  {
> +       char fw_name[53];
>         char ucode_prefix[30];
>         const char *wks =3D "";
>         int err;
> @@ -4149,8 +4150,8 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
>
>         if (!amdgpu_sriov_vf(adev)) {
> -               err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> -                                          "amdgpu/%s_rlc.bin", ucode_pre=
fix);
> +               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", u=
code_prefix);
> +               err =3D request_firmware(&adev->gfx.rlc_fw, fw_name, adev=
->dev);
>                 if (err)
>                         goto out;
>
> --
> 2.34.1
>
