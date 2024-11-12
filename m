Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64173D42BAB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 16:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0965310E1DD;
	Tue, 12 Nov 2024 16:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OMDynY/p";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C2910E1DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 16:36:24 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2e9a5ee0384so86748a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 08:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731429384; x=1732034184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjouSI0izvb/26iexlGEJuAmfsnXltnW+xCsLrqmPeY=;
 b=OMDynY/paVH6pu3ei/DNtubu/KJ57YbYU7DLrE7PQhsJlQa/5dyC04A7B58lw+h07i
 QXn1IedAR8NidSqk61Kd3WfmFx35fZ/ke+2XWM7+hxnE0vFZUv0YDVDy18PxwbEoKLtH
 MncxsxesdbVuVKHNxvVc6iPpMBugt2EQabgukpHHKDSC2k7EEXvPZTHU8CeDe8urAz53
 ARe6GjXLDasfV/ZkUXL9i4TGP5SpqFHGgnBOONj/E3+USAoGI0RUFtZyivZiEAYnFJOu
 qh9ODfwd3XO6Huce1AOxpOF2pEQx7fs9wx0NALPzgmu8XUcXytuvN/ucHZZ4IVrLBOhf
 IuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731429384; x=1732034184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AjouSI0izvb/26iexlGEJuAmfsnXltnW+xCsLrqmPeY=;
 b=CjZKMV+KMp5Ia7dYYUNgeENhQ2lmHbr7igIHWZkQpiD3yxDH/ptRgd1h9SxR0zN7T/
 0NSFTfuazVs6DGItDhFicidMUlq24Sdeq6synlEQE9BP7CPIzpAKNlf7DRytHWcL/7W6
 159V0sw2vfeSWSNw7Vl8C4fO4QlLwaC7G9kQVVB8tpbrdvM/GSvb97inmaruBTrXEUo9
 KQZzH9wOLnVN+ocrpD7shNjSYLQjHzKWFk8ZZ+lIbtjFiC71RFsKO+JYRSH+Sdjlm2Y6
 whT4wnRFsa46Q7LLKX0S6HHGEpeMOeVmG5xHa4Ry0wxlM5XZzk3tn299RZc7JRYD1SsT
 eVIw==
X-Gm-Message-State: AOJu0Yx19+smp5YaB4F09RUDaG12Y72Z7WdmsCiGajOCtstOwkwXf80y
 zPpyx8rwdQrcX50qsFunC2aspu8rwVSi891SisiF4K2lCA1LvsEbVlNcpyGIJNfOGWCuuZB9lop
 GvXI3xg0MqXGJxqd6X1JM9wlsdEc=
X-Google-Smtp-Source: AGHT+IFXzaPxUuWuMM2at4cIkgGoDpmt/0yWuwnXMRtnmlHGuHXm5u4gGsUa7Jgm6DDX20TS9g1yG0WPIBtNTjaAe3o=
X-Received: by 2002:a17:90b:1e0f:b0:2e2:abab:c458 with SMTP id
 98e67ed59e1d1-2e9b16aabbbmr9402693a91.8.1731429384390; Tue, 12 Nov 2024
 08:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20241112161142.28974-1-mario.limonciello@amd.com>
In-Reply-To: <20241112161142.28974-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Nov 2024 11:36:12 -0500
Message-ID: <CADnq5_NbBzk52pPUjYzxjEdDXa+jmquitbT59_CdWTT-fih+9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix initialization mistake for NBIO 7.7.0
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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

On Tue, Nov 12, 2024 at 11:13=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>
> There is a strapping issue on NBIO 7.7.0 that can lead to spurious PME
> events while in the D0 state.
>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd=
/amdgpu/nbio_v7_7.c
> index fb37e354a9d5..1ac730328516 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> @@ -247,6 +247,12 @@ static void nbio_v7_7_init_registers(struct amdgpu_d=
evice *adev)
>         if (def !=3D data)
>                 WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
>
> +       switch (adev->ip_versions[NBIO_HWIP][0]) {
> +       case IP_VERSION(7, 7, 0):
> +               data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4) &=
 ~BIT(23);
> +               WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4, data);
> +               break;
> +       }
>  }
>
>  static void nbio_v7_7_update_medium_grain_clock_gating(struct amdgpu_dev=
ice *adev,
> --
> 2.34.1
>
