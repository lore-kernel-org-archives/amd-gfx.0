Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1F4C87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 20:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5372110E987;
	Fri,  8 Aug 2025 20:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KwSDeayz";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F32010E987
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 20:02:54 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2400a0c3cf7so4474285ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Aug 2025 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754683374; x=1755288174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DupR8FKqFBBxzTG8jaUXynwZtxgZXScXAUs2GZd7C88=;
 b=KwSDeayzCdt+vaNPQbwAxJapSNs0yI64iSEYpbxSrcswVFSzBpm4Z+KhhvPG0Xs246
 EVMv4fyrwnC5582RKACe2Zk93J6ekfMCGPXh+L1+9/MnFMLMTPFgj7xygaJVuB3wP+xS
 ZCCz7NqkMIBObj4hKotXjkAK9alM3EtUuP+XheebgwT/7y6Y5/PetWmOVCklUkAKxOm9
 FQSs0yUx1SOsmqT0eMOUkngpORloPR5ISlXYjgHTlF6XshG3CoO/UZ/SJun+vlvQZ2Zp
 mdRg5bUfdfBPD9eMvnwpxsu3zZONm0xCpQ2MoVMJVas3OVm8RhavjP9XcS52nUvr57oL
 MHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754683374; x=1755288174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DupR8FKqFBBxzTG8jaUXynwZtxgZXScXAUs2GZd7C88=;
 b=s0Xy4S1kXqo5mooHCbLgF0FQaePCrsidFIhpXyEh2SGtnH2DDtTYhf0EPaOPqX9Hd1
 EfM7NE8JYCmbSTbg6NvXL9jqGcU00w5daeDmHbvs92sl3c/nouURI7jumEyf7k5NIUIv
 XMPDaFRYtR0S+AA9gJROkGQJq8FPZdVQb65EV2M6YdHqerac06SflUHAG1e3WkMLQaox
 2yoj1QmG6EnnzwA5pmOItn4pQ8p70BhgGBdC2SsXssC8RsSM08vfgJbvQdrnhN1wAJ+/
 2okm9Woya6bGrwu5ytEnLEGj1mYwsFpNVaJSkD5HZd2Gr6Gp4gC354mQbp7IFAEAJa1C
 noSQ==
X-Gm-Message-State: AOJu0Yxy1sklmK9qltyC/b+S2SOEoa7hkYCTe6Iyuz7+mgQc8rpop0XC
 fx174HTDs6doY2w13wrE4eMr5P0n3m6Nhltwl0g21/EBnAZOVdwxelFxqnyQXh6/d+7kzPVgBlL
 xGZX/8669IrahkfRS9Bf11U7ZcOSFyLDH8w==
X-Gm-Gg: ASbGncs8BkprsEioxi1WpRhFvdBgsUqeHrgOX/JbIYGDlJZvMJhc/DnDPcfvoZAsMjX
 8HR6zkq3qLWXpuOXkXZT/k08qXIQPLH9/Q81PH0X9rEX3l+s84rQ7VO5SUwR5TjA+WKmENDFPZH
 4wOTsbNIZBEDTAQEsMmXHzOp2dFHZQrRGGOrDqTE6uyHkW2VrYmoW1kI5mdYpjKkCqFIcDRlo2w
 2DSu50=
X-Google-Smtp-Source: AGHT+IESkYT7scmqK1tnTJ8BuxKj7MSFYYKMfz2X1GAxQU63HXKbo7DBRIA8wQJp5X4y+9GiKbM6Q2HeOYHqZYcGKtk=
X-Received: by 2002:a17:903:2f85:b0:240:63bd:2701 with SMTP id
 d9443c01a7336-242c26baad9mr28680575ad.6.1754683373516; Fri, 08 Aug 2025
 13:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250808124909.1813022-1-Jesse.Zhang@amd.com>
 <20250808124909.1813022-2-Jesse.Zhang@amd.com>
In-Reply-To: <20250808124909.1813022-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Aug 2025 16:02:41 -0400
X-Gm-Features: Ac12FXz4j8OgiCWAdm7gwhO27qM74rZ14GgQXVJX2K2B63eKZP4GKHIPGtt9Kww
Message-ID: <CADnq5_NA25uSVbmuubfmmPuafRbOe7bE3Exq1eDZQxssP6xRKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/vcn: Add late_init callback for VCN v4.0.3
 reset handling
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Leo.Liu@amd.com,
 Ruili Ji <ruiliji2@amd.com>
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

On Fri, Aug 8, 2025 at 8:49=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> From: Ruili Ji <ruiliji2@amd.com>
>
> This change reorganizes VCN reset capability detection by:
>
> 1. Moving reset mask configuration from sw_init to new late_init phase
> 2. Adding vcn_v4_0_3_late_init() to properly check for per-queue reset su=
pport
> 3. Only setting soft full reset mask as fallback when per-queue reset isn=
't supported
> 4. Removing TODO comment now that queue reset support is implemented
>
> The late initialization allows proper evaluation of SMU capabilities afte=
r
> full system initialization, while maintaining the previous behavior when
> per-queue reset isn't available.
>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 019bd362edb2..55dd86061115 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -134,6 +134,18 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>         return 0;
>  }
>
> +static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (amdgpu_dpm_reset_vcn_is_supported(adev))
> +               adev->vcn.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEU=
E;
> +       else
> +               adev->vcn.supported_reset =3D
> +                       amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0=
].ring_enc[0]);

The else case can be dropped here and left where it is now.


> +       return 0;
> +}
> +
>  static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int ins=
t_idx)
>  {
>         struct amdgpu_vcn4_fw_shared *fw_shared;
> @@ -211,10 +223,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                         adev->vcn.inst[i].pause_dpg_mode =3D vcn_v4_0_3_p=
ause_dpg_mode;
>         }
>
> -       /* TODO: Add queue reset mask when FW fully supports it */
> -       adev->vcn.supported_reset =3D
> -               amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_e=
nc[0]);
> -

This part can stay here as this is unrelated to PMFW versions.  You
can drop the TODO comment however.

>         if (amdgpu_sriov_vf(adev)) {
>                 r =3D amdgpu_virt_alloc_mm_table(adev);
>                 if (r)
> @@ -1871,6 +1879,7 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_=
device *adev)
>  static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs =3D {
>         .name =3D "vcn_v4_0_3",
>         .early_init =3D vcn_v4_0_3_early_init,
> +       .late_init =3D vcn_v4_0_3_late_init,
>         .sw_init =3D vcn_v4_0_3_sw_init,
>         .sw_fini =3D vcn_v4_0_3_sw_fini,
>         .hw_init =3D vcn_v4_0_3_hw_init,
> @@ -2073,6 +2082,7 @@ static int vcn_v4_0_3_ras_late_init(struct amdgpu_d=
evice *adev, struct ras_commo
>
>         r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
>                                 &vcn_v4_0_3_aca_info, NULL);
> +

unrelated change.

Alex

>         if (r)
>                 goto late_fini;
>
> --
> 2.49.0
>
