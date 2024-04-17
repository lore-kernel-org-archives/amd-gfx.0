Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F04C001CC
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 13:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C211129AB;
	Wed, 17 Apr 2024 13:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZO+xbVOv";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5644711351B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 13:31:47 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2a502547460so3862045a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713360706; x=1713965506; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70bq9rUIlhmHNj1JbEtd49VpgbD96oR0LRLAHbBAmGQ=;
 b=ZO+xbVOvCMyONLtOknFoK2JW+V7t89YztbByL+ZdL8UV7iTL/sH2f3HVCOHx2i6EEF
 Xg2tmQ7n7WwqvZbKaOEifd50wOLHrsN5DbZ5OkmD9thNhe3JwEcKRl+KoxPFYqiXaPLc
 zOFxKLGIrIgc/GMzki+MakW//2bQOh0eWGcaxJLArLfa2iIUU6ZHzT1sfBFYCacKE7jr
 3AF0Pox8N+80c1zs4n5eBtP4UwL+6y0x4sloC5ZB21PMtU6vpD7sJT5Slqg52Ov1Wksg
 HN5UR2REDmBPqx/z7A5dGbK8QAzl2b8oVF5P+7tauj6OikZ+GAmZy8euPoDRx8Y1Kdjo
 J2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713360706; x=1713965506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70bq9rUIlhmHNj1JbEtd49VpgbD96oR0LRLAHbBAmGQ=;
 b=N5QcTSSW7Aga3ac5ZvhymPutViwT7jx07NCo6zlRer97pFBIGuH5L0vjawRgmU0ity
 ix5sLv8WV6t+xtXjLDm28W4nXZJzgPm+3iBetsJRkk8F4NQB4XxJ/seifr61BCpMPP64
 IaPzAUxXNk+aW0Va3gBj9cl3yv7dwcrLC7+DKaDlcw7LvcLM+GSwKexEmfUmZ/xLp8K/
 sX4Hkcq4/NcVCoqx8i2ls0p5d/kWeAWQwkXEGLyrIEBb5yiOFQehzEmBv1PUQzWP7yKc
 FHbn1eOxErRrduy/CnaLcDKKalP8w9epynG+4ziYJpdqi/6ETfoK2H4Y96NX6ldl798N
 nuZQ==
X-Gm-Message-State: AOJu0YzbujFXSksrUOnyKt+2HQyRz9NdWoQscGjmuKhvxahB7IH2Z5s2
 YYJW/5HeI4SGKi14lBE32n0VVIcDoNQEr2z5lRYZzlo1bpw9e4ih2k6bSQ8iJ6/LqKFWJ95QpSf
 JvxG7+ap8DukXkMLcVIQJYRe//Bhu2A==
X-Google-Smtp-Source: AGHT+IGantYgyVgSfrh0B24HGypgEfq0EmeDKq8DBZxL82hndkunwB9FaMsJDWugNH9DFfnTs2RniwWSAldT8qHkbNs=
X-Received: by 2002:a17:90b:212:b0:2a2:ab2c:da40 with SMTP id
 fy18-20020a17090b021200b002a2ab2cda40mr13876383pjb.33.1713360706398; Wed, 17
 Apr 2024 06:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240417125132.306112-1-li.ma@amd.com>
In-Reply-To: <20240417125132.306112-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Apr 2024 09:31:33 -0400
Message-ID: <CADnq5_O-DbAO30ojDrdrH0-=aRbSC2aG_CCMTrvd1vV2L-cK0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/swsmu: add if condition for smu v14.0.1
To: Li Ma <li.ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 yifan1.zhang@amd.com, kenneth.feng@amd.com, likun.gao@amd.com
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

On Wed, Apr 17, 2024 at 9:02=E2=80=AFAM Li Ma <li.ma@amd.com> wrote:
>
> smu v14.0.1 re-used smu v14.0.0
>
> Signed-off-by: Li Ma <li.ma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 3bc9662fbd28..3ad3d20830fc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -136,7 +136,7 @@ int smu_v14_0_load_microcode(struct smu_context *smu)
>                     1 & ~MP1_SMN_PUB_CTRL__LX3_RESET_MASK);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSIO=
N(14, 0, 0))
> +               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSIO=
N(14, 0, 0) || amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0=
, 1))
>                         mp1_fw_flags =3D RREG32_PCIE(MP1_Public |
>                                                    (smnMP1_FIRMWARE_FLAGS=
_14_0_0 & 0xffffffff));
>                 else
> @@ -209,7 +209,7 @@ int smu_v14_0_check_fw_status(struct smu_context *smu=
)
>         struct amdgpu_device *adev =3D smu->adev;
>         uint32_t mp1_fw_flags;
>
> -       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0,=
 0))
> +       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0,=
 0) || amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0, 1))
>                 mp1_fw_flags =3D RREG32_PCIE(MP1_Public |
>                                            (smnMP1_FIRMWARE_FLAGS_14_0_0 =
& 0xffffffff));
>         else
> @@ -856,7 +856,7 @@ static int smu_v14_0_set_irq_state(struct amdgpu_devi=
ce *adev,
>                 // TODO
>
>                 /* For MP1 SW irqs */
> -               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSIO=
N(14, 0, 0)) {
> +               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSIO=
N(14, 0, 0) || amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0=
, 1)) {
>                         val =3D RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT=
_CTRL_mp1_14_0_0);
>                         val =3D REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL=
, INT_MASK, 1);
>                         WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp=
1_14_0_0, val);
> @@ -872,7 +872,7 @@ static int smu_v14_0_set_irq_state(struct amdgpu_devi=
ce *adev,
>                 // TODO
>
>                 /* For MP1 SW irqs */
> -               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSIO=
N(14, 0, 0)) {
> +               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSIO=
N(14, 0, 0) || amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14, 0=
, 1)) {
>                         val =3D RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT=
_mp1_14_0_0);
>                         val =3D REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID,=
 0xFE);
>                         val =3D REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VAL=
ID, 0);
> --
> 2.25.1
>
