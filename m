Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05049C19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 14:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F380610EB05;
	Thu, 27 Feb 2025 14:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="frOS4L/e";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB9A10EB0B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 14:22:23 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2217ea6d8daso2290085ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740666143; x=1741270943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdhnDh/eSaAmw0UrdStUJIKsIu+OKL9GWwc2uK+wZ9o=;
 b=frOS4L/eyQF0iRCggzB050/bSoCkI7pnHoFIkq9zQzZbyQLfKbQU726PT5id/M2rbQ
 CC/nBSiEz9Bbon4NSBjGVdj4NxEfpwgssA5Tl+pk40q9ze8kaWdzyGGRP0QVhaBqAc2z
 IQ9WOSplz6Frx7N5Cx8YI5qT/VkMl61cJJiiJTQPAh8gb0TiWVm1UP6iD3GwL2Rl6k42
 WNSZGscnJmCF2rgAHxmLlNt0lEhtivi0w0741YBVe4BYL43PxX4yRK7R72CtTiuUmlzc
 6p8pH4Ru4v1Mr8xgvFBjUlfyXgTLbERwdpTA5nkM+vIg2l0cBotZ49HeCjfrDVWj+1DM
 psIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666143; x=1741270943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdhnDh/eSaAmw0UrdStUJIKsIu+OKL9GWwc2uK+wZ9o=;
 b=oNTKhGn4xlsQTO8LCmZSQFkWeif/e3WPexRIpGkyRf3EoEmPIXzc5SVwpeUlC0OaLQ
 7TPRMb0hJ/Cjie8Xskr7ueyS6kANLEklE/lECoECBrzzLWsD3YhcnnpFllETxYNSNAZc
 3SlLgbbM0rqo7a+aL71uh/DQnBl/14tDhFcZabexenHtSdCuiqu5kwFPEo3bT6pH+mv3
 +eB4vHDCHxTgdBftaLrfyf4cjT9A7+At03GEObMTEwIJXEyQUnPLJga0SazoOLK0Hu6G
 UNbxtAwZW7CWesxMTgY6EE9AqJnked/6vhQGiCwnyzrk237EMV5O7CX+BXMeVrWFi/Wm
 qWBg==
X-Gm-Message-State: AOJu0YwOMlxEKdx8Co2pQJBqanMI6yIonDXexMXPzkbitfthwMtnWjnz
 S5dZbv06n9bn1LYfg+SVpr5mwbtlYORi3piG6wpd99eReQZtcgbn+iHY/VXmmt/2JD2ceuf19uF
 8tfH/29MuUrHwLGpoO0nX6Z69988fNg==
X-Gm-Gg: ASbGncshK32gIsGPt6kQY1VbGLDBgATAE5jQp0QkxDi5Ufahj3pfekp1fqo4Vvf1+y4
 OmGXF6LA5Mste4lyGMQKvGYEvZmU53ab3k1SmXvzOn/8aCj+QwsRy4evI5kfqwEZiLucXS3nKX1
 CZb/YyXfo=
X-Google-Smtp-Source: AGHT+IEE0adjHAD8ilUX0NJomjHxB3S+IxsCAOSUsESWKeyMi0IpClHIL9hKmpv7MizQdw0fdOZJEtb0HJQgZ6PD6Kc=
X-Received: by 2002:a17:903:40c9:b0:215:b8b6:d2c4 with SMTP id
 d9443c01a7336-2219ff4f24fmr156929365ad.4.1740666143071; Thu, 27 Feb 2025
 06:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
 <20250227052241.171102-4-alexandre.f.demers@gmail.com>
In-Reply-To: <20250227052241.171102-4-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2025 09:22:11 -0500
X-Gm-Features: AQ5f1JrX2el5COGfd95nXLMV62RPtL2BSEWetY4HEDi_oVU4jS0JBdic1R3b9Xc
Message-ID: <CADnq5_MQWOLSm_9=syBagpoQSA6i+D7A=RGtvrbuzCTjn9y2OQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu: complete
 dce_v6_0_set_crtc_vline_interrupt_state() in DCE6
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

On Thu, Feb 27, 2025 at 12:23=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> dce_v6_0_set_crtc_vline_interrupt_state() was empty without any info to
> inform the user.

Doesn't hurt to fill it in, but nothing uses the vline interrupt at
the moment.  Might be better to just remove it from all of the non-DC
display code.

Alex


>
> Based on DCE8 and DCE10 code.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 254cb73324c6..e805c4f9222c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -2957,7 +2957,51 @@ static void dce_v6_0_set_crtc_vline_interrupt_stat=
e(struct amdgpu_device *adev,
>                                                     int crtc,
>                                                     enum amdgpu_interrupt=
_state state)
>  {
> +       u32 reg_block, lb_interrupt_mask;
>
> +       if (crtc >=3D adev->mode_info.num_crtc) {
> +               DRM_DEBUG("invalid crtc %d\n", crtc);
> +               return;
> +       }
> +
> +       switch (crtc) {
> +       case 0:
> +               reg_block =3D CRTC0_REGISTER_OFFSET;
> +               break;
> +       case 1:
> +               reg_block =3D CRTC1_REGISTER_OFFSET;
> +               break;
> +       case 2:
> +               reg_block =3D CRTC2_REGISTER_OFFSET;
> +               break;
> +       case 3:
> +               reg_block =3D CRTC3_REGISTER_OFFSET;
> +               break;
> +       case 4:
> +               reg_block =3D CRTC4_REGISTER_OFFSET;
> +               break;
> +       case 5:
> +               reg_block =3D CRTC5_REGISTER_OFFSET;
> +               break;
> +       default:
> +               DRM_DEBUG("invalid crtc %d\n", crtc);
> +               return;
> +       }
> +
> +       switch (state) {
> +       case AMDGPU_IRQ_STATE_DISABLE:
> +               lb_interrupt_mask =3D RREG32(mmINT_MASK + reg_block);
> +               lb_interrupt_mask &=3D ~VLINE_INT_MASK;
> +               WREG32(mmINT_MASK + reg_block, lb_interrupt_mask);
> +               break;
> +       case AMDGPU_IRQ_STATE_ENABLE:
> +               lb_interrupt_mask =3D RREG32(mmINT_MASK + reg_block);
> +               lb_interrupt_mask |=3D VLINE_INT_MASK;
> +               WREG32(mmINT_MASK + reg_block, lb_interrupt_mask);
> +               break;
> +       default:
> +               break;
> +       }
>  }
>
>  static int dce_v6_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
> --
> 2.48.1
>
