Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14151C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 21:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937D610E374;
	Tue, 16 May 2023 21:40:05 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F8710E13E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 21:40:02 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-39420384cc4so112073b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684273201; x=1686865201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3HCgKuvlqu9B0/rE/ivHKQxLKX4QcFsKm207PPp2Sw=;
 b=D7/6jtwP08tYS2m8QwCuSdNVMWQ5wZCVKUKCbrvW9EGthEcMZ2J0hSACGpKZcYuMNu
 A2u3yIhHmHXY2n8ZOb2fCXzlJGUKD6sJxRDlMitKIyU3jPjgbNXxabJQnyBu5yuIPNCs
 jYklWFcOutGi8gvJml49qBG+QXnV8uOddUsrjgo4pz6djeMvZ6MqrZXHcaiGx5Hn0Jqy
 Wn69qOh7iygN2l/e2kXe6jkNggmgFSxwYhgZ8qjWHMqwtjVJPdvSoO4QVeOikRj/12BW
 WGc8yS1R1l6pS7JuD+xsrx493Sf1fNd9qcZcJBXDx8qXTAM1g9D3NMKX6MJQPvbD8Nmo
 B02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684273201; x=1686865201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3HCgKuvlqu9B0/rE/ivHKQxLKX4QcFsKm207PPp2Sw=;
 b=Mi0nNS/s9DJ9uVmc51kGiRePu2rhPv9zqQrZyJi4hL/dKUpqUqFhLRShaKhVtd5lJA
 a3QS7DrqZoobNd/1EzlPXtfo+uYm/KhZFXLAaQtbUnsPCWAMqEk7mTiJQT1n+Criokul
 4wrlhTX/RYSCMYOdjaI9B1VZuGBgUuojSb8wXLOlaHVXOV3HGdmYLn3wgDdeNY49ohMK
 +penCqGlnnPWJ5X0GXBwmezDHiUatDFTAKyhH7tSP2it2POLEnEXxCJoZgSwseKxwxvP
 QI3bb8y2c1egrcGFjAEM2sXNCJ4WXWjNSHDLLW7I+neoTAVi3tqOGL/TMFqierJO1Suo
 uWig==
X-Gm-Message-State: AC+VfDw6jemwid9ADPJmVITAONuMSr2En4gUPkIZx1MlxvGK/juh8w2q
 lZGTi+aMNDjgEmegg2xTuPkbK8zHMSwEfelXziA=
X-Google-Smtp-Source: ACHHUZ7zAiZ3yF5NfCch4DDmI8IxD7PLn6WbKeoC9SQdYAfukJtOiSMsnJ4c3nnwcfdHTw7TaaiBdpHcAdDI40qyiqU=
X-Received: by 2002:a05:6808:a0c:b0:38e:8a67:213e with SMTP id
 n12-20020a0568080a0c00b0038e8a67213emr13635549oij.32.1684273201139; Tue, 16
 May 2023 14:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230516175214.3491-1-mario.limonciello@amd.com>
 <20230516175214.3491-4-mario.limonciello@amd.com>
In-Reply-To: <20230516175214.3491-4-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 May 2023 17:39:49 -0400
Message-ID: <CADnq5_OH5vRico9MuegyEAM2SfQchdiXVgCSRLdf6jYmhTYO+A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd: Add safety check to make sure RLC is only
 turned off while in GFXOFF
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: anson.tsao@amd.com, Juan.Martinez@amd.com, richard.gong@amd.com,
 amd-gfx@lists.freedesktop.org, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 16, 2023 at 2:15=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On GFX11 if RLC is stopped when not in GFXOFF the system will hang.
> Prevent this case from ever happening.
>
> Tested-by: Juan Martinez <Juan.Martinez@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index dcbdb2641086..f1f879d9ed8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1766,6 +1766,10 @@ static void gfx_v11_0_rlc_stop(struct amdgpu_devic=
e *adev)
>  {
>         u32 tmp =3D RREG32_SOC15(GC, 0, regRLC_CNTL);
>
> +       if (!adev->gfx.gfx_off_state) {
> +               dev_err(adev->dev, "GFX is not in GFXOFF\n");
> +               return;
> +       }

This should move up before the RREG above?  Also, I think it would be
cleaner to just not mess with the RLC in S0i3.  Can we just return
early in smu_disable_dpms() for the APU case?  All of the DPM features
are controlled by the SMU so that function is mostly a nop of APUs
anyway.

Alex

>         tmp =3D REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
>         WREG32_SOC15(GC, 0, regRLC_CNTL, tmp);
>  }
> --
> 2.34.1
>
