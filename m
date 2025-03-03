Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A76C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 17:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1674510E27C;
	Mon,  3 Mar 2025 17:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FIFbnMX6";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458A810E27C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 17:04:46 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2234338f2bbso10950015ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Mar 2025 09:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741021486; x=1741626286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiEKR2kFLNUuWaoH6apoEkCrVlEK9/4NgJgsPbzWjko=;
 b=FIFbnMX60H6godrN+SNmSJ/XIAimfRYkudhhrJD3D9XY9o+rQH/mcAVb2/ty1dIQcX
 Yuwlq0bJzWfwuNjdB6gyD3pPgVnzpnDDl5pLYUghuHLCj71/FzqWHDbvB1cQBqgS3k/2
 OpTZVx+kBLqGwcU6ofNz61GebOhWir6wiS384SuNsOhRziMCO1pFgniWJnhzpfmZMDL0
 YKuIWj8VXW9ZAsftGFKmMFTd1D4t5aasMOJpkM4WN4bVLvm7B+xlMPF2PmEMu0xc/WNX
 zZpa0GNqBFZ3pV72teTcUgu4iFPFJUTKluM5/flB6jCwMYuSDsmBOxEBorcuca7gJ/jk
 60SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741021486; x=1741626286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiEKR2kFLNUuWaoH6apoEkCrVlEK9/4NgJgsPbzWjko=;
 b=Ysy+OZ2dNce/5NqbsnqhD62A/cis7iORERtfxW7H8Bbsy5OsXgqIXyjsDn3HkpNvSK
 ZbOFIAVvMKSRTRH387bKXn79VKeNI0UAXiS07QLCdK1qNU4xH1aHlRsZxfTL4Lv8rG33
 yFiVYnauv/vKDRyj9UeuSnTwOggs7kMiSPVExo0Qjvbcc6QLpfN/SQZdjG0pmj3Wwxci
 /YAVo0gmUa/BTC/pYQU9OSkEfia3dW/qEkBTgJg5A1lavT61prCEhVp6O7DUpQqCSnOE
 yVMGt6ZWsa2iv4f+8ljD/3TDmOG9WRN3QTmecHTDv2o6jONtYfh7aVqEXXId1uHUDbRn
 pDAg==
X-Gm-Message-State: AOJu0YxcSMWca7hZeHb5+7JEam4xMqkeJRIfjexpxmDElE1tAAuW8VNq
 b70kf35XLROf+IqVTlPee0tm6GSXY7haA5kJ+1PMsJM+qR0asAEnduwy5PBVwdRvvkDMBsklC7B
 XrIHAV+f5AUcg/GE0BI6NqPH0HIw=
X-Gm-Gg: ASbGncu58VR9vdhbmUGnEuqDTSvuFyGjCLYW2Qgrw7Z5d0sBSwWfZvhoFPBgApFMiwL
 SN030Qy2878qV9SBsHUE/0lErbxteN3Q0h48eMe4X+1CbjVdRkWaQ7s86jkJG+Jzmj5xTbVHjpu
 TuITy2b9BBv90dR+ihe2w6ag0/ag==
X-Google-Smtp-Source: AGHT+IGaLN0WkICIcpC2Ybmm/jEsVMHMeSK/aa6NLcpkD3BcTaAQWJs96sxUzVcwR/TuuBpIzM5bWUThOYGCekgmxes=
X-Received: by 2002:a17:902:ea10:b0:220:f181:4e70 with SMTP id
 d9443c01a7336-22369215070mr80834515ad.10.1741021485748; Mon, 03 Mar 2025
 09:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20250301041121.9661-1-alexandre.f.demers@gmail.com>
 <20250301041121.9661-2-alexandre.f.demers@gmail.com>
In-Reply-To: <20250301041121.9661-2-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Mar 2025 12:04:34 -0500
X-Gm-Features: AQ5f1JqezU_WwN5gR_4PtPBgv0800Mvyxnw3eZN-E4XSMKszyOqxnMAU-N8zjxw
Message-ID: <CADnq5_Mvj-Zt3PWyRWEjpXdTamh=Hc9m+Jibq9S3-mehtaj-Lg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
To: Alexandre Demers <alexandre.f.demers@gmail.com>
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

Applied.  Thanks.

Alex

On Fri, Feb 28, 2025 at 11:19=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> DCE6 was missing soft reset, but it was easily identifiable under radeon.
> This should be it, pretty much as it is done under DCE8 and DCE10.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 53 ++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 185401d66961..2ccb450b35a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -372,13 +372,41 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_=
device *adev)
>         return mmDC_GPIO_HPD_A;
>  }
>
> +static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
> +{
> +       u32 crtc_hung =3D 0;
> +       u32 crtc_status[6];
> +       u32 i, j, tmp;
> +
> +       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> +               if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CONTR=
OL__CRTC_MASTER_EN_MASK) {
> +                       crtc_status[i] =3D RREG32(mmCRTC_STATUS_HV_COUNT =
+ crtc_offsets[i]);
> +                       crtc_hung |=3D (1 << i);
> +               }
> +       }
> +
> +       for (j =3D 0; j < 10; j++) {
> +               for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> +                       if (crtc_hung & (1 << i)) {
> +                               tmp =3D RREG32(mmCRTC_STATUS_HV_COUNT + c=
rtc_offsets[i]);
> +                               if (tmp !=3D crtc_status[i])
> +                                       crtc_hung &=3D ~(1 << i);
> +                       }
> +               }
> +               if (crtc_hung =3D=3D 0)
> +                       return false;
> +               udelay(100);
> +       }
> +
> +       return true;
> +}
> +
>  static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev,
>                                           bool render)
>  {
>         if (!render)
>                 WREG32(mmVGA_RENDER_CONTROL,
>                         RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_CNTL);
> -
>  }
>
>  static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
> @@ -2860,7 +2888,28 @@ static bool dce_v6_0_is_idle(void *handle)
>
>  static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
> -       DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
> +       u32 srbm_soft_reset =3D 0, tmp;
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (dce_v6_0_is_display_hung(adev))
> +               srbm_soft_reset |=3D SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
> +
> +       if (srbm_soft_reset) {
> +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> +               tmp |=3D srbm_soft_reset;
> +               dev_info(adev->dev, "SRBM_SOFT_RESET=3D0x%08X\n", tmp);
> +               WREG32(mmSRBM_SOFT_RESET, tmp);
> +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> +
> +               udelay(50);
> +
> +               tmp &=3D ~srbm_soft_reset;
> +               WREG32(mmSRBM_SOFT_RESET, tmp);
> +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> +
> +               /* Wait a little for things to settle down */
> +               udelay(50);
> +       }
>         return 0;
>  }
>
> --
> 2.48.1
>
