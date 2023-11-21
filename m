Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62049C61D90
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 18:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF54710E580;
	Tue, 21 Nov 2023 18:53:54 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F5410E575
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 18:53:54 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1f03d9ad89fso3334451fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 10:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700592833; x=1701197633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivY/HIiQjXVe0XnnIADCfB9M9uqRTWJJyHgRqJCkUKI=;
 b=QBfeC5eR3MgpZ3wRufp3b/89h50C+4sWvFJisYypkbbc+Pb9tr4bxpA3kCv6WkxvFs
 Gig1zDa1nGgGnHgK9lxX2cVomupJvlbdRV6zBvEj3ILbpQcv/rYwe70ZWx6fwp8/MyId
 NELgvwtwUymAYU/HkcOuIRcygl7Vbm6pA2h0tRZqFNYCTz1KhA/70PpNUFM/VSjK3IW9
 9kbKyI/yomWDypOn9sIQTgBkMJ90G2cyHGBNpQVp+A7tw/JvfOz3Er7WYf1KYYWugLfP
 Abd6pK5yh6zErWZ0Awp+G9YqwvNSXMG27xD86jZAgAn7x9O/1EJuzgZiC7HYsajSm79U
 NYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700592833; x=1701197633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivY/HIiQjXVe0XnnIADCfB9M9uqRTWJJyHgRqJCkUKI=;
 b=L8ttjwZv3E3bBVRpyh8jEdY5CrFE4ONxHzTA9DVhtxHdn0tRJo3C77UcqFJX6OR5rf
 eb66BA9lqWAnddat41eJ8iKjpPyLTZpxpnGXyCVef0TVsnBNXw3BHA01i1myWfbUA1tA
 q8sh4/Nh7Al6aO3bi1hcchGJDkEKgbFtzuNXl1WeMBKWEwAeCVe6g+rzT6/eKim52nBg
 nAPBuOEEcecN0outf9L1CmNiGW6l862abxrNYeMevrrxINwm1gnwqTcPEj8yAv3UFgTn
 O21p/wzZGdIqRdp/WAC1rLw5Mc7u0mLq9kk88RlYlcqhLa4Xuv2ubZ2TwrdEOl1iW/70
 O1ag==
X-Gm-Message-State: AOJu0Yx9BJK6NTXkbrMTmE/KFmk/PhMGLxpO/qSme57AZmcF21k0hXUG
 y2nXLQU3xYkFtywe3ZwLK4kOv6AWOo0K0gD+en8mD1HY
X-Google-Smtp-Source: AGHT+IEXHe5N0/bUSTo3f8fCXV9tb603rYRtQUoOlKrFhtjB2PID4/zIbPFUN/dwY7Xd9ZEuJh1XAyKD6H+UuehQYCo=
X-Received: by 2002:a05:6870:2e0d:b0:1ea:69f6:fe09 with SMTP id
 oi13-20020a0568702e0d00b001ea69f6fe09mr236790oab.10.1700592833515; Tue, 21
 Nov 2023 10:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20231121091011.3283118-1-li.ma@amd.com>
In-Reply-To: <20231121091011.3283118-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Nov 2023 13:53:42 -0500
Message-ID: <CADnq5_Ork17R1wh4dehSZvYKT9jC_WtbojdxQWtiompbs_Zxqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add init_registers for nbio v7.11
To: Li Ma <li.ma@amd.com>
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, lang.yu@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 21, 2023 at 4:27=E2=80=AFAM Li Ma <li.ma@amd.com> wrote:
>
> enable init_registers callback func for nbio v7.11.
>
> Signed-off-by: Li Ma <li.ma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c       | 18 ++++++------
>  .../asic_reg/nbio/nbio_7_11_0_offset.h        |  2 ++
>  .../asic_reg/nbio/nbio_7_11_0_sh_mask.h       | 29 +++++++++++++++++++
>  3 files changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/am=
d/amdgpu/nbio_v7_11.c
> index 676ab1d20d2f..1f52b4b1db03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> @@ -259,17 +259,17 @@ const struct nbio_hdp_flush_reg nbio_v7_11_hdp_flus=
h_reg =3D {
>
>  static void nbio_v7_11_init_registers(struct amdgpu_device *adev)
>  {
> -/*     uint32_t def, data;
> +       uint32_t def, data;
> +
> +       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_=
USB4_PCIE_MST_CTRL_3);
> +       data =3D REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST=
_CTRL_3,
> +                               CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
> +       data =3D REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST=
_CTRL_3,
> +                               CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
>
> -               def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI25=
6_RC3X4_USB4_PCIE_MST_CTRL_3);
> -               data =3D REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_=
PCIE_MST_CTRL_3,
> -                       CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
> -               data =3D REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_=
PCIE_MST_CTRL_3,
> -                       CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
> +       if (def !=3D data)
> +               WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE=
_MST_CTRL_3, data);
>
> -               if (def !=3D data)
> -                       WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_U=
SB4_PCIE_MST_CTRL_3, data);
> -*/
>  }
>
>  static void nbio_v7_11_update_medium_grain_clock_gating(struct amdgpu_de=
vice *adev,
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset=
.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
> index ff30f04be591..7ee3d291120d 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
> @@ -781,6 +781,8 @@
>  #define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2_BASE_IDX              =
                                5
>  #define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1             =
                                0x420187
>  #define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1_BASE_IDX    =
                                5
> +#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3                  =
                                0x4201c6
> +#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3_BASE_IDX         =
                                5
>
>
>  // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mas=
k.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
> index 7f131999a263..eb8c556d9c93 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
> @@ -24646,6 +24646,35 @@
>  //BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1
>  #define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_=
MASK                                  0x00000001L
>  #define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_=
EN_MASK                               0x00000008L
> +//BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_PAYLOAD=
_SIZE_MODE__SHIFT                     0x8
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_PRIV_MAX_PA=
YLOAD_SIZE__SHIFT                     0x9
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_10BIT_TAG_EN_OVE=
RRIDE__SHIFT                          0xb
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_10BIT_TAG_E=
N_OVERRIDE__SHIFT                     0xd
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__MST_DROP_SYNC_FLOOD=
_EN__SHIFT                            0xf
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_PAYLOAD_SIZE=
_MODE__SHIFT                          0x10
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_PAYLOAD=
_SIZE__SHIFT                          0x11
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_REQUEST=
_SIZE_MODE__SHIFT                     0x14
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_READ_RE=
QUEST_SIZE__SHIFT                     0x15
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_SAFE_MO=
DE__SHIFT                             0x18
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_EXTENDED_TAG_EN_=
OVERRIDE__SHIFT                       0x19
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_RE=
QUEST_SIZE_MODE__SHIFT                0x1b
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_RE=
QUEST_SIZE_PRIV__SHIFT                0x1c
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_EXTENDED_TA=
G_EN_OVERRIDE__SHIFT                  0x1e
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_PAYLOAD=
_SIZE_MODE_MASK                       0x00000100L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_PRIV_MAX_PA=
YLOAD_SIZE_MASK                       0x00000600L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_10BIT_TAG_EN_OVE=
RRIDE_MASK                            0x00001800L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_10BIT_TAG_E=
N_OVERRIDE_MASK                       0x00006000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__MST_DROP_SYNC_FLOOD=
_EN_MASK                              0x00008000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_PAYLOAD_SIZE=
_MODE_MASK                            0x00010000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_PAYLOAD=
_SIZE_MASK                            0x000E0000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_REQUEST=
_SIZE_MODE_MASK                       0x00100000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_READ_RE=
QUEST_SIZE_MASK                       0x00E00000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_SAFE_MO=
DE_MASK                               0x01000000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_EXTENDED_TAG_EN_=
OVERRIDE_MASK                         0x06000000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_RE=
QUEST_SIZE_MODE_MASK                  0x08000000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_RE=
QUEST_SIZE_PRIV_MASK                  0x30000000L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_EXTENDED_TA=
G_EN_OVERRIDE_MASK                    0xC0000000L
>
>  // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
>  //BIF_CFG_DEV0_RC0_VENDOR_ID
> --
> 2.25.1
>
