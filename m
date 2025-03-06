Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD01C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7792110E1EE;
	Thu,  6 Mar 2025 15:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EaEM3PXg";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA0C510E057
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:17:12 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ff66327419so194143a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 07:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741274232; x=1741879032; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWx8dapwT8yRV6RxosPt8gSjxDMCcIT8KB/WCslRNKI=;
 b=EaEM3PXg9VTvvkV3uBlvtuGfoogP0QJLYYwQ3OB8V2ho7gxwTTimDbl/dJM/qVp8QY
 SWSFoKwiubDLGc6VVyRDaRLmY2ihk4JhYEXc37KLEgFS0YGksQGuFbUFkxbxQiML0GgK
 /MhQgi7GFZLzSiqo2iB16qvYZh9hQEdxmBM3wuT3M/PqHL4tYEHvSdm8nyvAvzkAyT07
 DZ/Ujn6mSDLx3Eamapz3uqca3/BAL8NeQuMbsyPfBiwxkDzvGR0ZFN8HjGpveRDCceZV
 pGaRNIPdfUyV7p9OjGWf9oLVNjGdnGBOk+Nrx3UQL/ESdPJ0EGvoYjoxBB5qIyi1dA8w
 a5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741274232; x=1741879032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWx8dapwT8yRV6RxosPt8gSjxDMCcIT8KB/WCslRNKI=;
 b=iGJkoVXbw+BDW1Zs9Yg4EUj63cV/XNk7puz8wG8uV49rIWWOmjafgiSPwHjwkA5lid
 BKhKz7oEEffSMPdtyQcYXMgV6RnbsfmR12kqTeoNnSyeuuVCV6dY2pm1HA3WN9b4IjOC
 Yl7zL/PxiZSNfdLHqxNsm4kmN27eZ9G+z47AzIPlCoItauzFnPDXv6JsfQrbzsL4qRUs
 J6mmCwaoO7x5ffmOIEnE9rVkKzVwfCazHEFWU3AVuriyn8v6EPcrX9wctyADpwWcaXSJ
 +wz5bZEZ5H+Kc0osVlcKHDdfL7tLI78q05+E9qTdVo7piQCfBwfqhg5FF03ArfiQB64c
 PZEw==
X-Gm-Message-State: AOJu0YxDkTujt1zY8XsdohDIp8A7mmYVa2I/rHuBpWchtxSzYCUdlysf
 OvBjG0P+4WtMBJuEFuGUBqTuysE/nH0NuyWjjgcjwtpdmBQcRAfa8/jW5y4ZQ3Tfwa3SoAaymdx
 yuYXR08UJ9rp+IOq+heVyDJf4ixBO3Zt6
X-Gm-Gg: ASbGncuIFlGjoWjOtFvUg/XmVQ4JMA6adAafixKim0tj3pjhzbEJYYpqfA65XCrenPg
 iLfgWinVK3gfUoQvezLFo3S5uMYsb+rHhmioieKkmruSifOWDyHu64pAIWBvs/yWIa128xM5ZT4
 Omne+6S/9C5qFPVasroqEyqV+/bg==
X-Google-Smtp-Source: AGHT+IFoTOw8a31uvY2T0QdwR8mrWhUwoJzjR3//cbES6j9AH8ixVVX0a00V0CIZZrwAKAQn6+Jwn/1Yli9IdbYCzsE=
X-Received: by 2002:a17:90b:1a8a:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-2ff49842fe6mr4916257a91.8.1741274232268; Thu, 06 Mar 2025
 07:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
 <20250306014958.785021-5-alexandre.f.demers@gmail.com>
In-Reply-To: <20250306014958.785021-5-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 10:17:00 -0500
X-Gm-Features: AQ5f1Jq3E9SFHfi6EFX0HD24AojNeu6Y4vKNJgkwHidZZURtWGXr7Io6y0twt4s
Message-ID: <CADnq5_NwQOpe-DLt6icWSE+RFOveE3kbmCAk7jjregaW56sFQg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amdgpu: fix warning and errors caused by
 duplicated defines in sid.h
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

On Wed, Mar 5, 2025 at 8:57=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Let's finish the cleanup in sid.h to calm down things after wiring it int=
o
> dce_v6_0.c.
>
> This is a bigger cleanup.
> Many defines found under sid.h have already been properly moved
> into the different "_d.h" and "_sh_mask.h", so they should have been
> already removed from sid.h and properly linked in where needed.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c |  12 +-
>  drivers/gpu/drm/amd/amdgpu/si.c       |  68 +++---
>  drivers/gpu/drm/amd/amdgpu/si_enums.h |   2 -
>  drivers/gpu/drm/amd/amdgpu/sid.h      | 336 +-------------------------
>  4 files changed, 44 insertions(+), 374 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 2ccb450b35a6..7bb11916a619 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -32,7 +32,6 @@
>  #include "amdgpu.h"
>  #include "amdgpu_pm.h"
>  #include "amdgpu_i2c.h"
> -#include "sid.h"
>  #include "atom.h"
>  #include "amdgpu_atombios.h"
>  #include "atombios_crtc.h"
> @@ -41,18 +40,25 @@
>  #include "amdgpu_connectors.h"
>  #include "amdgpu_display.h"
>
> +#include "dce_v6_0.h"
> +#include "sid.h"
> +
>  #include "bif/bif_3_0_d.h"
>  #include "bif/bif_3_0_sh_mask.h"
> +
>  #include "oss/oss_1_0_d.h"
>  #include "oss/oss_1_0_sh_mask.h"
> +
>  #include "gca/gfx_6_0_d.h"
>  #include "gca/gfx_6_0_sh_mask.h"
> +#include "gca/gfx_7_2_enum.h"
> +
>  #include "gmc/gmc_6_0_d.h"
>  #include "gmc/gmc_6_0_sh_mask.h"
> +
>  #include "dce/dce_6_0_d.h"
>  #include "dce/dce_6_0_sh_mask.h"
> -#include "gca/gfx_7_2_enum.h"
> -#include "dce_v6_0.h"
> +
>  #include "si_enums.h"
>
>  static void dce_v6_0_set_display_funcs(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu=
/si.c
> index 79307ae3e477..a18b3ece635b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1124,41 +1124,41 @@ static struct amdgpu_allowed_register_entry si_al=
lowed_read_registers[] =3D {
>         {mmCP_STALLED_STAT3},
>         {GB_ADDR_CONFIG},
>         {MC_ARB_RAMCFG},
> -       {GB_TILE_MODE0},
> -       {GB_TILE_MODE1},
> -       {GB_TILE_MODE2},
> -       {GB_TILE_MODE3},
> -       {GB_TILE_MODE4},
> -       {GB_TILE_MODE5},
> -       {GB_TILE_MODE6},
> -       {GB_TILE_MODE7},
> -       {GB_TILE_MODE8},
> -       {GB_TILE_MODE9},
> -       {GB_TILE_MODE10},
> -       {GB_TILE_MODE11},
> -       {GB_TILE_MODE12},
> -       {GB_TILE_MODE13},
> -       {GB_TILE_MODE14},
> -       {GB_TILE_MODE15},
> -       {GB_TILE_MODE16},
> -       {GB_TILE_MODE17},
> -       {GB_TILE_MODE18},
> -       {GB_TILE_MODE19},
> -       {GB_TILE_MODE20},
> -       {GB_TILE_MODE21},
> -       {GB_TILE_MODE22},
> -       {GB_TILE_MODE23},
> -       {GB_TILE_MODE24},
> -       {GB_TILE_MODE25},
> -       {GB_TILE_MODE26},
> -       {GB_TILE_MODE27},
> -       {GB_TILE_MODE28},
> -       {GB_TILE_MODE29},
> -       {GB_TILE_MODE30},
> -       {GB_TILE_MODE31},
> +       {mmGB_TILE_MODE0},
> +       {mmGB_TILE_MODE1},
> +       {mmGB_TILE_MODE2},
> +       {mmGB_TILE_MODE3},
> +       {mmGB_TILE_MODE4},
> +       {mmGB_TILE_MODE5},
> +       {mmGB_TILE_MODE6},
> +       {mmGB_TILE_MODE7},
> +       {mmGB_TILE_MODE8},
> +       {mmGB_TILE_MODE9},
> +       {mmGB_TILE_MODE10},
> +       {mmGB_TILE_MODE11},
> +       {mmGB_TILE_MODE12},
> +       {mmGB_TILE_MODE13},
> +       {mmGB_TILE_MODE14},
> +       {mmGB_TILE_MODE15},
> +       {mmGB_TILE_MODE16},
> +       {mmGB_TILE_MODE17},
> +       {mmGB_TILE_MODE18},
> +       {mmGB_TILE_MODE19},
> +       {mmGB_TILE_MODE20},
> +       {mmGB_TILE_MODE21},
> +       {mmGB_TILE_MODE22},
> +       {mmGB_TILE_MODE23},
> +       {mmGB_TILE_MODE24},
> +       {mmGB_TILE_MODE25},
> +       {mmGB_TILE_MODE26},
> +       {mmGB_TILE_MODE27},
> +       {mmGB_TILE_MODE28},
> +       {mmGB_TILE_MODE29},
> +       {mmGB_TILE_MODE30},
> +       {mmGB_TILE_MODE31},
>         {CC_RB_BACKEND_DISABLE, true},

Why not replace this with mmCC_RB_BACKEND_DISABLE as well for consistency?

Alex

> -       {GC_USER_RB_BACKEND_DISABLE, true},
> -       {PA_SC_RASTER_CONFIG, true},
> +       {mmGC_USER_RB_BACKEND_DISABLE, true},
> +       {mmPA_SC_RASTER_CONFIG, true},
>  };
>
>  static uint32_t si_get_register_value(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/=
amdgpu/si_enums.h
> index 8a2ebd725b74..5c3074d4c592 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
> +++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
> @@ -121,8 +121,6 @@
>  #define CURSOR_UPDATE_LOCK             (1 << 16)
>  #define CURSOR_DISABLE_MULTIPLE_UPDATE (1 << 24)
>
> -#define DMA0_REGISTER_OFFSET 0x000
> -#define DMA1_REGISTER_OFFSET 0x200
>  #define ES_AND_GS_AUTO       3
>  #define RADEON_PACKET_TYPE3  3
>  #define CE_PARTITION_BASE    3
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgp=
u/sid.h
> index 16314173e5ce..cbf232f5235b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -692,18 +692,6 @@
>  #define HDP_REG_COHERENCY_FLUSH_CNTL                   0x1528
>
>  /* DCE6 ELD audio interface */
> -#define AZ_F0_CODEC_ENDPOINT_INDEX                       0x1780
> -#       define AZ_ENDPOINT_REG_INDEX(x)                  (((x) & 0xff) <=
< 0)
> -#       define AZ_ENDPOINT_REG_WRITE_EN                  (1 << 8)
> -#define AZ_F0_CODEC_ENDPOINT_DATA                        0x1781
> -
> -#define AZ_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER          0x25
> -#define                SPEAKER_ALLOCATION(x)                   (((x) & 0=
x7f) << 0)
> -#define                SPEAKER_ALLOCATION_MASK                 (0x7f << =
0)
> -#define                SPEAKER_ALLOCATION_SHIFT                0
> -#define                HDMI_CONNECTION                         (1 << 16)
> -#define                DP_CONNECTION                           (1 << 17)
> -
>  #define AZ_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0        0x28 /* LPCM */
>  #define AZ_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR1        0x29 /* AC3 */
>  #define AZ_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR2        0x2A /* MPEG1 *=
/
> @@ -905,26 +893,11 @@
>  #define CRTC_STATUS_FRAME_COUNT                         0x1BA6
>
>  /* Audio clocks */
> -#define DCCG_AUDIO_DTO_SOURCE                           0x05ac
> -#       define DCCG_AUDIO_DTO0_SOURCE_SEL(x) ((x) << 0) /* crtc0 - crtc5=
 */
> -#       define DCCG_AUDIO_DTO_SEL            (1 << 4)   /* 0=3Ddto0 1=3D=
dto1 */
> -
>  #define DCCG_AUDIO_DTO0_PHASE                           0x05b0
>  #define DCCG_AUDIO_DTO0_MODULE                          0x05b4
>  #define DCCG_AUDIO_DTO1_PHASE                           0x05c0
>  #define DCCG_AUDIO_DTO1_MODULE                          0x05c4
>
> -#define AFMT_AUDIO_SRC_CONTROL                          0x1c4f
> -#define                AFMT_AUDIO_SRC_SELECT(x)                (((x) & 7=
) << 0)
> -/* AFMT_AUDIO_SRC_SELECT
> - * 0 =3D stream0
> - * 1 =3D stream1
> - * 2 =3D stream2
> - * 3 =3D stream3
> - * 4 =3D stream4
> - * 5 =3D stream5
> - */
> -
>  #define        GRBM_CNTL                                       0x2000
>  #define                GRBM_READ_TIMEOUT(x)                            (=
(x) << 0)
>
> @@ -973,30 +946,6 @@
>  #define                SE_DB_BUSY                                      (=
1 << 30)
>  #define                SE_CB_BUSY                                      (=
1 << 31)
>
> -#define        GRBM_SOFT_RESET                                 0x2008
> -#define                SOFT_RESET_CP                                   (=
1 << 0)
> -#define                SOFT_RESET_CB                                   (=
1 << 1)
> -#define                SOFT_RESET_RLC                                  (=
1 << 2)
> -#define                SOFT_RESET_DB                                   (=
1 << 3)
> -#define                SOFT_RESET_GDS                                  (=
1 << 4)
> -#define                SOFT_RESET_PA                                   (=
1 << 5)
> -#define                SOFT_RESET_SC                                   (=
1 << 6)
> -#define                SOFT_RESET_BCI                                  (=
1 << 7)
> -#define                SOFT_RESET_SPI                                  (=
1 << 8)
> -#define                SOFT_RESET_SX                                   (=
1 << 10)
> -#define                SOFT_RESET_TC                                   (=
1 << 11)
> -#define                SOFT_RESET_TA                                   (=
1 << 12)
> -#define                SOFT_RESET_VGT                                  (=
1 << 14)
> -#define                SOFT_RESET_IA                                   (=
1 << 15)
> -
> -#define GRBM_GFX_INDEX                                 0x200B
> -#define                INSTANCE_INDEX(x)                       ((x) << 0=
)
> -#define                SH_INDEX(x)                             ((x) << 8=
)
> -#define                SE_INDEX(x)                             ((x) << 1=
6)
> -#define                SH_BROADCAST_WRITES                     (1 << 29)
> -#define                INSTANCE_BROADCAST_WRITES               (1 << 30)
> -#define                SE_BROADCAST_WRITES                     (1 << 31)
> -
>  #define GRBM_INT_CNTL                                   0x2018
>  #       define RDERR_INT_ENABLE                         (1 << 0)
>  #       define GUI_IDLE_INT_ENABLE                      (1 << 19)
> @@ -1041,16 +990,6 @@
>
>  #define        VGT_VTX_VECT_EJECT_REG                          0x222C
>
> -#define        VGT_CACHE_INVALIDATION                          0x2231
> -#define                CACHE_INVALIDATION(x)                           (=
(x) << 0)
> -#define                        VC_ONLY                                  =
       0
> -#define                        TC_ONLY                                  =
       1
> -#define                        VC_AND_TC                                =
       2
> -#define                AUTO_INVLD_EN(x)                                (=
(x) << 6)
> -#define                        NO_AUTO                                  =
       0
> -#define                        ES_AUTO                                  =
       1
> -#define                        GS_AUTO                                  =
       2
> -#define                        ES_AND_GS_AUTO                           =
       3
>  #define        VGT_ESGS_RING_SIZE                              0x2232
>  #define        VGT_GSVS_RING_SIZE                              0x2233
>
> @@ -1068,11 +1007,6 @@
>
>  #define        VGT_TF_MEMORY_BASE                              0x226E
>
> -#define CC_GC_SHADER_ARRAY_CONFIG                      0x226F
> -#define                INACTIVE_CUS_MASK                       0xFFFF000=
0
> -#define                INACTIVE_CUS_SHIFT                      16
> -#define GC_USER_SHADER_ARRAY_CONFIG                    0x2270
> -
>  #define        PA_CL_ENHANCE                                   0x2285
>  #define                CLIP_VTX_REORDER_ENA                            (=
1 << 0)
>  #define                NUM_CLIP_SEQ(x)                                 (=
(x) << 1)
> @@ -1165,89 +1099,6 @@
>  #define                ROW_SIZE_MASK                           0x3000000=
0
>  #define                ROW_SIZE_SHIFT                          28
>
> -#define        GB_TILE_MODE0                                   0x2644
> -#       define MICRO_TILE_MODE(x)                              ((x) << 0=
)
> -#              define  ADDR_SURF_DISPLAY_MICRO_TILING          0
> -#              define  ADDR_SURF_THIN_MICRO_TILING             1
> -#              define  ADDR_SURF_DEPTH_MICRO_TILING            2
> -#       define ARRAY_MODE(x)                                   ((x) << 2=
)
> -#              define  ARRAY_LINEAR_GENERAL                    0
> -#              define  ARRAY_LINEAR_ALIGNED                    1
> -#              define  ARRAY_1D_TILED_THIN1                    2
> -#              define  ARRAY_2D_TILED_THIN1                    4
> -#       define PIPE_CONFIG(x)                                  ((x) << 6=
)
> -#              define  ADDR_SURF_P2                            0
> -#              define  ADDR_SURF_P4_8x16                       4
> -#              define  ADDR_SURF_P4_16x16                      5
> -#              define  ADDR_SURF_P4_16x32                      6
> -#              define  ADDR_SURF_P4_32x32                      7
> -#              define  ADDR_SURF_P8_16x16_8x16                 8
> -#              define  ADDR_SURF_P8_16x32_8x16                 9
> -#              define  ADDR_SURF_P8_32x32_8x16                 10
> -#              define  ADDR_SURF_P8_16x32_16x16                11
> -#              define  ADDR_SURF_P8_32x32_16x16                12
> -#              define  ADDR_SURF_P8_32x32_16x32                13
> -#              define  ADDR_SURF_P8_32x64_32x32                14
> -#       define TILE_SPLIT(x)                                   ((x) << 1=
1)
> -#              define  ADDR_SURF_TILE_SPLIT_64B                0
> -#              define  ADDR_SURF_TILE_SPLIT_128B               1
> -#              define  ADDR_SURF_TILE_SPLIT_256B               2
> -#              define  ADDR_SURF_TILE_SPLIT_512B               3
> -#              define  ADDR_SURF_TILE_SPLIT_1KB                4
> -#              define  ADDR_SURF_TILE_SPLIT_2KB                5
> -#              define  ADDR_SURF_TILE_SPLIT_4KB                6
> -#       define BANK_WIDTH(x)                                   ((x) << 1=
4)
> -#              define  ADDR_SURF_BANK_WIDTH_1                  0
> -#              define  ADDR_SURF_BANK_WIDTH_2                  1
> -#              define  ADDR_SURF_BANK_WIDTH_4                  2
> -#              define  ADDR_SURF_BANK_WIDTH_8                  3
> -#       define BANK_HEIGHT(x)                                  ((x) << 1=
6)
> -#              define  ADDR_SURF_BANK_HEIGHT_1                 0
> -#              define  ADDR_SURF_BANK_HEIGHT_2                 1
> -#              define  ADDR_SURF_BANK_HEIGHT_4                 2
> -#              define  ADDR_SURF_BANK_HEIGHT_8                 3
> -#       define MACRO_TILE_ASPECT(x)                            ((x) << 1=
8)
> -#              define  ADDR_SURF_MACRO_ASPECT_1                0
> -#              define  ADDR_SURF_MACRO_ASPECT_2                1
> -#              define  ADDR_SURF_MACRO_ASPECT_4                2
> -#              define  ADDR_SURF_MACRO_ASPECT_8                3
> -#       define NUM_BANKS(x)                                    ((x) << 2=
0)
> -#              define  ADDR_SURF_2_BANK                        0
> -#              define  ADDR_SURF_4_BANK                        1
> -#              define  ADDR_SURF_8_BANK                        2
> -#              define  ADDR_SURF_16_BANK                       3
> -#define        GB_TILE_MODE1                                   0x2645
> -#define        GB_TILE_MODE2                                   0x2646
> -#define        GB_TILE_MODE3                                   0x2647
> -#define        GB_TILE_MODE4                                   0x2648
> -#define        GB_TILE_MODE5                                   0x2649
> -#define        GB_TILE_MODE6                                   0x264a
> -#define        GB_TILE_MODE7                                   0x264b
> -#define        GB_TILE_MODE8                                   0x264c
> -#define        GB_TILE_MODE9                                   0x264d
> -#define        GB_TILE_MODE10                                  0x264e
> -#define        GB_TILE_MODE11                                  0x264f
> -#define        GB_TILE_MODE12                                  0x2650
> -#define        GB_TILE_MODE13                                  0x2651
> -#define        GB_TILE_MODE14                                  0x2652
> -#define        GB_TILE_MODE15                                  0x2653
> -#define        GB_TILE_MODE16                                  0x2654
> -#define        GB_TILE_MODE17                                  0x2655
> -#define        GB_TILE_MODE18                                  0x2656
> -#define        GB_TILE_MODE19                                  0x2657
> -#define        GB_TILE_MODE20                                  0x2658
> -#define        GB_TILE_MODE21                                  0x2659
> -#define        GB_TILE_MODE22                                  0x265a
> -#define        GB_TILE_MODE23                                  0x265b
> -#define        GB_TILE_MODE24                                  0x265c
> -#define        GB_TILE_MODE25                                  0x265d
> -#define        GB_TILE_MODE26                                  0x265e
> -#define        GB_TILE_MODE27                                  0x265f
> -#define        GB_TILE_MODE28                                  0x2660
> -#define        GB_TILE_MODE29                                  0x2661
> -#define        GB_TILE_MODE30                                  0x2662
> -#define        GB_TILE_MODE31                                  0x2663
> -
>  #define        CB_PERFCOUNTER0_SELECT0                         0x2688
>  #define        CB_PERFCOUNTER0_SELECT1                         0x2689
>  #define        CB_PERFCOUNTER1_SELECT0                         0x268A
> @@ -1259,10 +1110,6 @@
>
>  #define        CB_CGTT_SCLK_CTRL                               0x2698
>
> -#define        GC_USER_RB_BACKEND_DISABLE                      0x26DF
> -#define                BACKEND_DISABLE_MASK                    0x00FF000=
0
> -#define                BACKEND_DISABLE_SHIFT                   16
> -
>  #define        TCP_CHAN_STEER_LO                               0x2B03
>  #define        TCP_CHAN_STEER_HI                               0x2B94
>
> @@ -1316,101 +1163,12 @@
>  #       define CP_RINGID1_INT_STAT                      (1 << 30)
>  #       define CP_RINGID0_INT_STAT                      (1 << 31)
>
> -#define        CP_MEM_SLP_CNTL                                 0x3079
> -#       define CP_MEM_LS_EN                             (1 << 0)
> -
> -#define        CP_DEBUG                                        0x307F
> -
> -#define RLC_CNTL                                          0x30C0
> -#       define RLC_ENABLE                                 (1 << 0)
> -#define RLC_RL_BASE                                       0x30C1
> -#define RLC_RL_SIZE                                       0x30C2
> -#define RLC_LB_CNTL                                       0x30C3
> -#       define LOAD_BALANCE_ENABLE                        (1 << 0)
> -#define RLC_SAVE_AND_RESTORE_BASE                         0x30C4
> -#define RLC_LB_CNTR_MAX                                   0x30C5
> -#define RLC_LB_CNTR_INIT                                  0x30C6
> -
> -#define RLC_CLEAR_STATE_RESTORE_BASE                      0x30C8
> -
> -#define RLC_UCODE_ADDR                                    0x30CB
> -#define RLC_UCODE_DATA                                    0x30CC
> -
> -#define RLC_GPU_CLOCK_COUNT_LSB                           0x30CE
> -#define RLC_GPU_CLOCK_COUNT_MSB                           0x30CF
> -#define RLC_CAPTURE_GPU_CLOCK_COUNT                       0x30D0
> -#define RLC_MC_CNTL                                       0x30D1
> -#define RLC_UCODE_CNTL                                    0x30D2
> -#define RLC_STAT                                          0x30D3
> -#       define RLC_BUSY_STATUS                            (1 << 0)
> -#       define GFX_POWER_STATUS                           (1 << 1)
> -#       define GFX_CLOCK_STATUS                           (1 << 2)
> -#       define GFX_LS_STATUS                              (1 << 3)
> -
> -#define        RLC_PG_CNTL                                     0x30D7
> -#      define GFX_PG_ENABLE                            (1 << 0)
> -#      define GFX_PG_SRC                               (1 << 1)
> -
> -#define        RLC_CGTT_MGCG_OVERRIDE                          0x3100
> -#define        RLC_CGCG_CGLS_CTRL                              0x3101
> -#      define CGCG_EN                                  (1 << 0)
> -#      define CGLS_EN                                  (1 << 1)
> -
> -#define        RLC_TTOP_D                                      0x3105
> -#      define RLC_PUD(x)                               ((x) << 0)
> -#      define RLC_PUD_MASK                             (0xff << 0)
> -#      define RLC_PDD(x)                               ((x) << 8)
> -#      define RLC_PDD_MASK                             (0xff << 8)
> -#      define RLC_TTPD(x)                              ((x) << 16)
> -#      define RLC_TTPD_MASK                            (0xff << 16)
> -#      define RLC_MSD(x)                               ((x) << 24)
> -#      define RLC_MSD_MASK                             (0xff << 24)
> -
> -#define RLC_LB_INIT_CU_MASK                               0x3107
> -
> -#define        RLC_PG_AO_CU_MASK                               0x310B
> -#define        RLC_MAX_PG_CU                                   0x310C
> -#      define MAX_PU_CU(x)                             ((x) << 0)
> -#      define MAX_PU_CU_MASK                           (0xff << 0)
> -#define        RLC_AUTO_PG_CTRL                                0x310C
> -#      define AUTO_PG_EN                               (1 << 0)
> -#      define GRBM_REG_SGIT(x)                         ((x) << 3)
> -#      define GRBM_REG_SGIT_MASK                       (0xffff << 3)
> -#      define PG_AFTER_GRBM_REG_ST(x)                  ((x) << 19)
> -#      define PG_AFTER_GRBM_REG_ST_MASK                (0x1fff << 19)
> -
> -#define RLC_SERDES_WR_MASTER_MASK_0                       0x3115
> -#define RLC_SERDES_WR_MASTER_MASK_1                       0x3116
> -#define RLC_SERDES_WR_CTRL                                0x3117
> -
> -#define RLC_SERDES_MASTER_BUSY_0                          0x3119
> -#define RLC_SERDES_MASTER_BUSY_1                          0x311A
> -
> -#define RLC_GCPM_GENERAL_3                                0x311E
> -
> -#define        DB_RENDER_CONTROL                               0xA000
> -
> -#define DB_DEPTH_INFO                                   0xA00F
> -
> -#define PA_SC_RASTER_CONFIG                             0xA0D4
> -#      define RB_MAP_PKR0(x)                           ((x) << 0)
> -#      define RB_MAP_PKR0_MASK                         (0x3 << 0)
> -#      define RB_MAP_PKR1(x)                           ((x) << 2)
> -#      define RB_MAP_PKR1_MASK                         (0x3 << 2)
> -#       define RASTER_CONFIG_RB_MAP_0                   0
> -#       define RASTER_CONFIG_RB_MAP_1                   1
> -#       define RASTER_CONFIG_RB_MAP_2                   2
> -#       define RASTER_CONFIG_RB_MAP_3                   3
> +// #define PA_SC_RASTER_CONFIG                             0xA0D4
>  #      define RB_XSEL2(x)                              ((x) << 4)
>  #      define RB_XSEL2_MASK                            (0x3 << 4)
>  #      define RB_XSEL                                  (1 << 6)
>  #      define RB_YSEL                                  (1 << 7)
>  #      define PKR_MAP(x)                               ((x) << 8)
> -#      define PKR_MAP_MASK                             (0x3 << 8)
> -#       define RASTER_CONFIG_PKR_MAP_0                 0
> -#       define RASTER_CONFIG_PKR_MAP_1                 1
> -#       define RASTER_CONFIG_PKR_MAP_2                 2
> -#       define RASTER_CONFIG_PKR_MAP_3                 3
>  #      define PKR_XSEL(x)                              ((x) << 10)
>  #      define PKR_XSEL_MASK                            (0x3 << 10)
>  #      define PKR_YSEL(x)                              ((x) << 12)
> @@ -1422,56 +1180,11 @@
>  #      define SC_YSEL(x)                               ((x) << 20)
>  #      define SC_YSEL_MASK                             (0x3 << 20)
>  #      define SE_MAP(x)                                ((x) << 24)
> -#      define SE_MAP_MASK                              (0x3 << 24)
> -#       define RASTER_CONFIG_SE_MAP_0                  0
> -#       define RASTER_CONFIG_SE_MAP_1                  1
> -#       define RASTER_CONFIG_SE_MAP_2                  2
> -#       define RASTER_CONFIG_SE_MAP_3                  3
>  #      define SE_XSEL(x)                               ((x) << 26)
>  #      define SE_XSEL_MASK                             (0x3 << 26)
>  #      define SE_YSEL(x)                               ((x) << 28)
>  #      define SE_YSEL_MASK                             (0x3 << 28)
>
> -
> -#define VGT_EVENT_INITIATOR                             0xA2A4
> -#       define SAMPLE_STREAMOUTSTATS1                   (1 << 0)
> -#       define SAMPLE_STREAMOUTSTATS2                   (2 << 0)
> -#       define SAMPLE_STREAMOUTSTATS3                   (3 << 0)
> -#       define CACHE_FLUSH_TS                           (4 << 0)
> -#       define CACHE_FLUSH                              (6 << 0)
> -#       define CS_PARTIAL_FLUSH                         (7 << 0)
> -#       define VGT_STREAMOUT_RESET                      (10 << 0)
> -#       define END_OF_PIPE_INCR_DE                      (11 << 0)
> -#       define END_OF_PIPE_IB_END                       (12 << 0)
> -#       define RST_PIX_CNT                              (13 << 0)
> -#       define VS_PARTIAL_FLUSH                         (15 << 0)
> -#       define PS_PARTIAL_FLUSH                         (16 << 0)
> -#       define CACHE_FLUSH_AND_INV_TS_EVENT             (20 << 0)
> -#       define ZPASS_DONE                               (21 << 0)
> -#       define CACHE_FLUSH_AND_INV_EVENT                (22 << 0)
> -#       define PERFCOUNTER_START                        (23 << 0)
> -#       define PERFCOUNTER_STOP                         (24 << 0)
> -#       define PIPELINESTAT_START                       (25 << 0)
> -#       define PIPELINESTAT_STOP                        (26 << 0)
> -#       define PERFCOUNTER_SAMPLE                       (27 << 0)
> -#       define SAMPLE_PIPELINESTAT                      (30 << 0)
> -#       define SAMPLE_STREAMOUTSTATS                    (32 << 0)
> -#       define RESET_VTX_CNT                            (33 << 0)
> -#       define VGT_FLUSH                                (36 << 0)
> -#       define BOTTOM_OF_PIPE_TS                        (40 << 0)
> -#       define DB_CACHE_FLUSH_AND_INV                   (42 << 0)
> -#       define FLUSH_AND_INV_DB_DATA_TS                 (43 << 0)
> -#       define FLUSH_AND_INV_DB_META                    (44 << 0)
> -#       define FLUSH_AND_INV_CB_DATA_TS                 (45 << 0)
> -#       define FLUSH_AND_INV_CB_META                    (46 << 0)
> -#       define CS_DONE                                  (47 << 0)
> -#       define PS_DONE                                  (48 << 0)
> -#       define FLUSH_AND_INV_CB_PIXEL_DATA              (49 << 0)
> -#       define THREAD_TRACE_START                       (51 << 0)
> -#       define THREAD_TRACE_STOP                        (52 << 0)
> -#       define THREAD_TRACE_FLUSH                       (54 << 0)
> -#       define THREAD_TRACE_FINISH                      (55 << 0)
> -
>  /* PIF PHY0 registers idx/data 0x8/0xc */
>  #define PB0_PIF_CNTL                                      0x10
>  #       define LS2_EXIT_TIME(x)                           ((x) << 17)
> @@ -2049,9 +1762,6 @@
>  #define EVERGREEN_DATA_FORMAT                           0x1ac0
>  #       define EVERGREEN_INTERLEAVE_EN                  (1 << 0)
>
> -#define MC_SHARED_CHMAP__NOOFCHAN_MASK 0xf000
> -#define MC_SHARED_CHMAP__NOOFCHAN__SHIFT 0xc
> -
>  #define R600_D1GRPH_ARRAY_MODE_LINEAR_GENERAL            (0 << 20)
>  #define R600_D1GRPH_ARRAY_MODE_LINEAR_ALIGNED            (1 << 20)
>  #define R600_D1GRPH_ARRAY_MODE_1D_TILED_THIN1            (2 << 20)
> @@ -2063,32 +1773,6 @@
>  #define R700_D2GRPH_SECONDARY_SURFACE_ADDRESS_HIGH              0x1847
>  #define R700_D1GRPH_SECONDARY_SURFACE_ADDRESS_HIGH              0x1a47
>
> -#define DISP_INTERRUPT_STATUS__LB_D1_VBLANK_INTERRUPT_MASK 0x8
> -#define DISP_INTERRUPT_STATUS_CONTINUE__LB_D2_VBLANK_INTERRUPT_MASK 0x8
> -#define DISP_INTERRUPT_STATUS_CONTINUE2__LB_D3_VBLANK_INTERRUPT_MASK 0x8
> -#define DISP_INTERRUPT_STATUS_CONTINUE3__LB_D4_VBLANK_INTERRUPT_MASK 0x8
> -#define DISP_INTERRUPT_STATUS_CONTINUE4__LB_D5_VBLANK_INTERRUPT_MASK 0x8
> -#define DISP_INTERRUPT_STATUS_CONTINUE5__LB_D6_VBLANK_INTERRUPT_MASK 0x8
> -
> -#define DISP_INTERRUPT_STATUS__LB_D1_VLINE_INTERRUPT_MASK 0x4
> -#define DISP_INTERRUPT_STATUS_CONTINUE__LB_D2_VLINE_INTERRUPT_MASK 0x4
> -#define DISP_INTERRUPT_STATUS_CONTINUE2__LB_D3_VLINE_INTERRUPT_MASK 0x4
> -#define DISP_INTERRUPT_STATUS_CONTINUE3__LB_D4_VLINE_INTERRUPT_MASK 0x4
> -#define DISP_INTERRUPT_STATUS_CONTINUE4__LB_D5_VLINE_INTERRUPT_MASK 0x4
> -#define DISP_INTERRUPT_STATUS_CONTINUE5__LB_D6_VLINE_INTERRUPT_MASK 0x4
> -
> -#define DISP_INTERRUPT_STATUS__DC_HPD1_INTERRUPT_MASK 0x20000
> -#define DISP_INTERRUPT_STATUS_CONTINUE__DC_HPD2_INTERRUPT_MASK 0x20000
> -#define DISP_INTERRUPT_STATUS_CONTINUE2__DC_HPD3_INTERRUPT_MASK 0x20000
> -#define DISP_INTERRUPT_STATUS_CONTINUE3__DC_HPD4_INTERRUPT_MASK 0x20000
> -#define DISP_INTERRUPT_STATUS_CONTINUE4__DC_HPD5_INTERRUPT_MASK 0x20000
> -#define DISP_INTERRUPT_STATUS_CONTINUE5__DC_HPD6_INTERRUPT_MASK 0x20000
> -
> -#define GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_OCCURRED_MASK 0x1
> -#define GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_CLEAR_MASK 0x100
> -
> -#define DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK 0x1
> -
>  #define R600_D1GRPH_SWAP_CONTROL                               0x1843
>  #define R600_D1GRPH_SWAP_ENDIAN_NONE                    (0 << 0)
>  #define R600_D1GRPH_SWAP_ENDIAN_16BIT                   (1 << 0)
> @@ -2112,8 +1796,6 @@
>  #       define R600_SCK_PRESCALE_CRYSTAL_CLK_SHIFT 28
>  #       define R600_SCK_PRESCALE_CRYSTAL_CLK_MASK  (0xf << 28)
>
> -#define GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK 0x1
> -
>  #define FMT_BIT_DEPTH_CONTROL                0x1bf2
>  #define FMT_TRUNCATE_EN               (1 << 0)
>  #define FMT_TRUNCATE_DEPTH            (1 << 4)
> @@ -2417,19 +2099,6 @@
>  #define mmSRBM_SOFT_RESET__xxSOFT_RESET_MC_MASK 0x800
>  #define mmSRBM_SOFT_RESET__xxSOFT_RESET_MC__SHIFT 0xb
>
> -#define VM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK 0=
x8
> -#define VM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT__SHIFT=
 0x3
> -#define VM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_M=
ASK 0x40
> -#define VM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT__=
SHIFT 0x6
> -#define VM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK 0x=
200
> -#define VM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT__SHIFT =
0x9
> -#define VM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK 0=
x1000
> -#define VM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT__SHIFT=
 0xc
> -#define VM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK 0x=
8000
> -#define VM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT__SHIFT =
0xf
> -#define VM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK 0=
x40000
> -#define VM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT__SHIFT=
 0x12
> -
>  #define MC_SEQ_MISC0__MT__MASK 0xf0000000
>  #define MC_SEQ_MISC0__MT__GDDR1  0x10000000
>  #define MC_SEQ_MISC0__MT__DDR2   0x20000000
> @@ -2439,10 +2108,7 @@
>  #define MC_SEQ_MISC0__MT__HBM    0x60000000
>  #define MC_SEQ_MISC0__MT__DDR3   0xB0000000
>
> -#define GRBM_STATUS__GUI_ACTIVE_MASK 0x80000000
>  #define CP_INT_CNTL_RING__TIME_STAMP_INT_ENABLE_MASK 0x4000000
> -#define CP_INT_CNTL_RING0__PRIV_REG_INT_ENABLE_MASK 0x800000
> -#define CP_INT_CNTL_RING0__PRIV_INSTR_INT_ENABLE_MASK 0x400000
>  #define PACKET3_SEM_WAIT_ON_SIGNAL    (0x1 << 12)
>  #define PACKET3_SEM_SEL_SIGNAL     (0x6 << 29)
>  #define PACKET3_SEM_SEL_WAIT       (0x7 << 29)
> --
> 2.48.1
>
