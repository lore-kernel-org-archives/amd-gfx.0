Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF6FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 19:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D533510E6BF;
	Wed, 25 May 2022 19:28:06 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE2A10E6BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 19:28:05 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id j21so19468815pga.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pH35YM7yeVM2Z6YK2fmADssGmceZ/QV71UC4Y7PruEo=;
 b=OWidnEJEiFRaEJeDKjpFxAnR82jQix3tD8sT8ZcH10ii4lLdkyjZHgyCygyI8YQM4R
 xKOoy4QDeaOciTiMIghlpe7XtifdMe7rNnxLMxFpbDV6HLkwzF3tUyuo8Kg/W9sNuCuA
 3yi3vOOy3ARAbQYUDTZ9hQQCaTbGI2QErRfDnkyLC4hxzm1FlNHzuTgDzLxEWidJNJyy
 Tz3eCtHQXc1j4nz7IsUOKbHvUVroHYrh5fhhcp1yu2tYu5vuJN2E5VZoR7OqPammZd2g
 Roey90LNKQdv2WgA6sFyS1VS4ewUl9zhgpJzrNRduB0JTiuj0V9N3QHr821KvleO6tvF
 Rcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pH35YM7yeVM2Z6YK2fmADssGmceZ/QV71UC4Y7PruEo=;
 b=PdSD1rg3ZaPtWVeDGCe0JcsDtYhOk6obptfGRJd0jHv8KKEuo0mStrMMyAseOItTgI
 BWhQtFk/9810evK4QZyfghyYxo67nlshwlV9HETWpgYFNxbWuWVkZ8z3JpgPt73OzUUG
 gBDkeI7TT7Cpfi5EGyYcepeAaMyYz40O4vqD8eXrfU7WT79S5A/QrAFZD05j/Mp4/76Y
 sarTzRKg9LvbL6XSUIBPjlh/fB9UTZU+6ljihE4jisTqW5pZa9eZ2qIcEWGLls/h6e3C
 3FBtBaMjhnhmBtR5xByg4j79oiouBH23DgC5AmrHT0lPTdaxZQ+7iCcy8vFpCcTcCPuS
 bA5w==
X-Gm-Message-State: AOAM532Vwy02S3VlmhVKGGqRx99Oy1RLh3pu5z1egBLHnHjI/zLP5DkO
 UoPfhRoYQ0os5THVQ8AW22JPcC4vZpxMpTNSij6TdZOe4iQ=
X-Google-Smtp-Source: ABdhPJxJARF/jy4rVQgtKCFn7e++iqgXkgosg5hY35PGZoqI0RyEIOnDdDNJ2z+bcVkAvg4OmX7qbj/XyfKIyFobxp0=
X-Received: by 2002:a05:6a00:299a:b0:518:9489:2c32 with SMTP id
 cj26-20020a056a00299a00b0051894892c32mr19406776pfb.29.1653506884741; Wed, 25
 May 2022 12:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
 <20220525161941.2544055-14-alexander.deucher@amd.com>
In-Reply-To: <20220525161941.2544055-14-alexander.deucher@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 25 May 2022 15:27:28 -0400
Message-ID: <CAAxE2A4DsJV3_0a7RejRodMAydgeJCtRK1CaA8M4i_Jj3u9Ztg@mail.gmail.com>
Subject: Re: [PATCH 14/43] drm/amd: Add GFX11 modifiers support to AMDGPU
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="0000000000007fb2b305dfdb121e"
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000007fb2b305dfdb121e
Content-Type: text/plain; charset="UTF-8"

On Wed, May 25, 2022 at 12:20 PM Alex Deucher <alexander.deucher@amd.com>
wrote:

> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
>
> GFX11 IP introduces new tiling mode. Various combinations of DCC
> settings are possible and the most preferred settings must be exposed
> for optimal use of the hardware.
>
> add_gfx11_modifiers() is based on recommendation from Marek for the
> preferred tiling modifier that are most efficient for the hardware.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 40 ++++++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 74 ++++++++++++++++++-
>  include/uapi/drm/drm_fourcc.h                 |  2 +
>  3 files changed, 108 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index ec395fe427f2..a54081a89282 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -30,6 +30,9 @@
>  #include "atom.h"
>  #include "amdgpu_connectors.h"
>  #include "amdgpu_display.h"
> +#include "soc15_common.h"
> +#include "gc/gc_11_0_0_offset.h"
> +#include "gc/gc_11_0_0_sh_mask.h"
>  #include <asm/div64.h>
>
>  #include <linux/pci.h>
> @@ -662,6 +665,11 @@ static int convert_tiling_flags_to_modifier(struct
> amdgpu_framebuffer *afb)
>  {
>         struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
>         uint64_t modifier = 0;
> +       int num_pipes = 0;
> +       int num_pkrs = 0;
> +
> +       num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
> +       num_pipes = adev->gfx.config.gb_addr_config_fields.num_pipes;
>
>         if (!afb->tiling_flags || !AMDGPU_TILING_GET(afb->tiling_flags,
> SWIZZLE_MODE)) {
>                 modifier = DRM_FORMAT_MOD_LINEAR;
> @@ -674,7 +682,7 @@ static int convert_tiling_flags_to_modifier(struct
> amdgpu_framebuffer *afb)
>                 int bank_xor_bits = 0;
>                 int packers = 0;
>                 int rb = 0;
> -               int pipes =
> ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> +               int pipes = ilog2(num_pipes);
>                 uint32_t dcc_offset = AMDGPU_TILING_GET(afb->tiling_flags,
> DCC_OFFSET_256B);
>
>                 switch (swizzle >> 2) {
> @@ -690,12 +698,17 @@ static int convert_tiling_flags_to_modifier(struct
> amdgpu_framebuffer *afb)
>                 case 6: /* 64 KiB _X */
>                         block_size_bits = 16;
>                         break;
> +               case 7: /* 256 KiB */
> +                       block_size_bits = 18;
> +                       break;
>                 default:
>                         /* RESERVED or VAR */
>                         return -EINVAL;
>                 }
>
> -               if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0))
> +               if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0))
> +                       version = AMD_FMT_MOD_TILE_VER_GFX11;
> +               else if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10,
> 3, 0))
>                         version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
>                 else if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10,
> 0, 0))
>                         version = AMD_FMT_MOD_TILE_VER_GFX10;
> @@ -718,7 +731,17 @@ static int convert_tiling_flags_to_modifier(struct
> amdgpu_framebuffer *afb)
>                 }
>

The switch statement right above this that is not in this patch and changes
"version" should be skipped on >= gfx11. Under no circumstances should the
version be changed on gfx11.

Marek


>
>                 if (has_xor) {
> +                       if (num_pipes == num_pkrs && num_pkrs == 0) {
> +                               DRM_ERROR("invalid number of pipes and
> packers\n");
> +                               return -EINVAL;
> +                       }
> +
>                         switch (version) {
> +                       case AMD_FMT_MOD_TILE_VER_GFX11:
> +                               pipe_xor_bits = min(block_size_bits - 8,
> pipes);
> +                               packers = min(block_size_bits - 8 -
> pipe_xor_bits,
> +
>  ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs));
> +                               break;
>                         case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
>                                 pipe_xor_bits = min(block_size_bits - 8,
> pipes);
>                                 packers = min(block_size_bits - 8 -
> pipe_xor_bits,
> @@ -752,9 +775,10 @@ static int convert_tiling_flags_to_modifier(struct
> amdgpu_framebuffer *afb)
>                         u64 render_dcc_offset;
>
>                         /* Enable constant encode on RAVEN2 and later. */
> -                       bool dcc_constant_encode = adev->asic_type >
> CHIP_RAVEN ||
> +                       bool dcc_constant_encode = (adev->asic_type >
> CHIP_RAVEN ||
>                                                    (adev->asic_type ==
> CHIP_RAVEN &&
> -                                                   adev->external_rev_id
> >= 0x81);
> +                                                   adev->external_rev_id
> >= 0x81)) &&
> +
>  adev->ip_versions[GC_HWIP][0] < IP_VERSION(11, 0, 0);
>
>                         int max_cblock_size = dcc_i64b ?
> AMD_FMT_MOD_DCC_BLOCK_64B :
>                                               dcc_i128b ?
> AMD_FMT_MOD_DCC_BLOCK_128B :
> @@ -869,10 +893,11 @@ static unsigned int get_dcc_block_size(uint64_t
> modifier, bool rb_aligned,
>                 return max(10 + (rb_aligned ? (int)AMD_FMT_MOD_GET(RB,
> modifier) : 0), 12);
>         }
>         case AMD_FMT_MOD_TILE_VER_GFX10:
> -       case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS: {
> +       case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
> +       case AMD_FMT_MOD_TILE_VER_GFX11: {
>                 int pipes_log2 = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
>
> -               if (ver == AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS && pipes_log2
> > 1 &&
> +               if (ver >= AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS && pipes_log2
> > 1 &&
>                     AMD_FMT_MOD_GET(PACKERS, modifier) == pipes_log2)
>                         ++pipes_log2;
>
> @@ -965,6 +990,9 @@ static int amdgpu_display_verify_sizes(struct
> amdgpu_framebuffer *rfb)
>                         case DC_SW_64KB_S_X:
>                                 block_size_log2 = 16;
>                                 break;
> +                       case DC_SW_VAR_S_X:
> +                               block_size_log2 = 18;
> +                               break;
>                         default:
>                                 drm_dbg_kms(rfb->base.dev,
>                                             "Swizzle mode with unknown
> block size: %d\n", swizzle);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a93affc37c53..badd136f5686 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -88,10 +88,14 @@
>  #include "dcn/dcn_1_0_offset.h"
>  #include "dcn/dcn_1_0_sh_mask.h"
>  #include "soc15_hw_ip.h"
> +#include "soc15_common.h"
>  #include "vega10_ip_offset.h"
>
>  #include "soc15_common.h"
>
> +#include "gc/gc_11_0_0_offset.h"
> +#include "gc/gc_11_0_0_sh_mask.h"
> +
>  #include "modules/inc/mod_freesync.h"
>  #include "modules/power/power_helpers.h"
>  #include "modules/inc/mod_info_packet.h"
> @@ -4885,7 +4889,9 @@ fill_gfx9_tiling_info_from_modifier(const struct
> amdgpu_device *adev,
>         unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS,
> modifier);
>         unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS,
> modifier);
>         unsigned int pkrs_log2 = AMD_FMT_MOD_GET(PACKERS, modifier);
> -       unsigned int pipes_log2 = min(4u, mod_pipe_xor_bits);
> +       unsigned int pipes_log2;
> +
> +       pipes_log2 = min(5u, mod_pipe_xor_bits);
>
>         fill_gfx9_tiling_info_from_device(adev, tiling_info);
>
> @@ -5221,6 +5227,67 @@ add_gfx10_3_modifiers(const struct amdgpu_device
> *adev,
>                     AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX9));
>  }
>
> +static void
> +add_gfx11_modifiers(const struct amdgpu_device *adev,
> +                     uint64_t **mods, uint64_t *size, uint64_t *capacity)
> +{
> +       int num_pipes = 0;
> +       int pipe_xor_bits = 0;
> +       int num_pkrs = 0;
> +       int pkrs = 0;
> +       u32 gb_addr_config;
> +       unsigned swizzle_r_x;
> +       uint64_t modifier_r_x;
> +       uint64_t modifier_dcc_best;
> +       uint64_t modifier_dcc_4k;
> +
> +       /* TODO: GFX11 IP HW init hasnt finish and we get zero if we read
> from
> +        * adev->gfx.config.gb_addr_config_fields.num_{pkrs,pipes} */
> +       gb_addr_config = RREG32_SOC15(GC, 0, regGB_ADDR_CONFIG);
> +       ASSERT(gb_addr_config != 0);
> +
> +       num_pkrs = 1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG,
> NUM_PKRS);
> +       pkrs = ilog2(num_pkrs);
> +       num_pipes = 1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG,
> NUM_PIPES);
> +       pipe_xor_bits = ilog2(num_pipes);
> +
> +    /* R_X swizzle modes are the best for rendering and DCC requires
> them. */
> +    swizzle_r_x = num_pipes > 16 ? AMD_FMT_MOD_TILE_GFX11_256K_R_X :
> +
> AMD_FMT_MOD_TILE_GFX9_64K_R_X;
> +
> +       modifier_r_x = AMD_FMT_MOD |
> +                            AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX11) |
> +                            AMD_FMT_MOD_SET(TILE, swizzle_r_x) |
> +                            AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits)
> |
> +                            AMD_FMT_MOD_SET(PACKERS, pkrs);
> +
> +    /* DCC_CONSTANT_ENCODE is not set because it can't vary with gfx11
> (it's implied to be 1). */
> +       modifier_dcc_best = modifier_r_x |
> +                            AMD_FMT_MOD_SET(DCC, 1) |
> +                            AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 0) |
> +                            AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                            AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_128B);
> +
> +    /* DCC settings for 4K and greater resolutions. (required by display
> hw) */
> +       modifier_dcc_4k = modifier_r_x |
> +                            AMD_FMT_MOD_SET(DCC, 1) |
> +                            AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                            AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                            AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_64B);
> +
> +       add_modifier(mods, size, capacity, modifier_dcc_best);
> +       add_modifier(mods, size, capacity, modifier_dcc_4k);
> +
> +       add_modifier(mods, size, capacity, modifier_dcc_best |
> AMD_FMT_MOD_SET(DCC_RETILE, 1));
> +       add_modifier(mods, size, capacity, modifier_dcc_4k |
> AMD_FMT_MOD_SET(DCC_RETILE, 1));
> +
> +       add_modifier(mods, size, capacity, modifier_r_x);
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +             AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
> +                        AMD_FMT_MOD_SET(TILE,
> AMD_FMT_MOD_TILE_GFX9_64K_D));
> +}
> +
>  static int
>  get_plane_modifiers(const struct amdgpu_device *adev, unsigned int
> plane_type, uint64_t **mods)
>  {
> @@ -5254,6 +5321,9 @@ get_plane_modifiers(const struct amdgpu_device
> *adev, unsigned int plane_type, u
>                 else
>                         add_gfx10_1_modifiers(adev, mods, &size,
> &capacity);
>                 break;
> +       case AMDGPU_FAMILY_GC_11_0_0:
> +               add_gfx11_modifiers(adev, mods, &size, &capacity);
> +               break;
>         }
>
>         add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
> @@ -5292,7 +5362,7 @@ fill_gfx9_plane_attributes_from_modifiers(struct
> amdgpu_device *adev,
>                 dcc->enable = 1;
>                 dcc->meta_pitch = afb->base.pitches[1];
>                 dcc->independent_64b_blks = independent_64b_blks;
> -               if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) ==
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) {
> +               if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >=
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) {
>                         if (independent_64b_blks && independent_128b_blks)
>                                 dcc->dcc_ind_blk =
> hubp_ind_block_64b_no_128bcl;
>                         else if (independent_128b_blks)
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index fc0c1454d275..14cb2dafb0fa 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -1294,6 +1294,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64
> modifier)
>  #define AMD_FMT_MOD_TILE_VER_GFX9 1
>  #define AMD_FMT_MOD_TILE_VER_GFX10 2
>  #define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
> +#define AMD_FMT_MOD_TILE_VER_GFX11 4
>
>  /*
>   * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as
> canonical
> @@ -1309,6 +1310,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64
> modifier)
>  #define AMD_FMT_MOD_TILE_GFX9_64K_S_X 25
>  #define AMD_FMT_MOD_TILE_GFX9_64K_D_X 26
>  #define AMD_FMT_MOD_TILE_GFX9_64K_R_X 27
> +#define AMD_FMT_MOD_TILE_GFX11_256K_R_X 31
>
>  #define AMD_FMT_MOD_DCC_BLOCK_64B 0
>  #define AMD_FMT_MOD_DCC_BLOCK_128B 1
> --
> 2.35.3
>
>

--0000000000007fb2b305dfdb121e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 25, 2022 at 12:20 PM Alex=
 Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.deucher=
@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">From: Aurabindo Pillai &lt;<a href=3D"mailto:aurabindo.pillai@amd.c=
om" target=3D"_blank">aurabindo.pillai@amd.com</a>&gt;<br>
<br>
GFX11 IP introduces new tiling mode. Various combinations of DCC<br>
settings are possible and the most preferred settings must be exposed<br>
for optimal use of the hardware.<br>
<br>
add_gfx11_modifiers() is based on recommendation from Marek for the<br>
preferred tiling modifier that are most efficient for the hardware.<br>
<br>
Signed-off-by: Aurabindo Pillai &lt;<a href=3D"mailto:aurabindo.pillai@amd.=
com" target=3D"_blank">aurabindo.pillai@amd.com</a>&gt;<br>
Acked-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" tar=
get=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_display.c=C2=A0 =C2=A0| 40 ++++++++=
--<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 74 ++++++++++++++++++=
-<br>
=C2=A0include/uapi/drm/drm_fourcc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +<br>
=C2=A03 files changed, 108 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index ec395fe427f2..a54081a89282 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -30,6 +30,9 @@<br>
=C2=A0#include &quot;atom.h&quot;<br>
=C2=A0#include &quot;amdgpu_connectors.h&quot;<br>
=C2=A0#include &quot;amdgpu_display.h&quot;<br>
+#include &quot;soc15_common.h&quot;<br>
+#include &quot;gc/gc_11_0_0_offset.h&quot;<br>
+#include &quot;gc/gc_11_0_0_sh_mask.h&quot;<br>
=C2=A0#include &lt;asm/div64.h&gt;<br>
<br>
=C2=A0#include &lt;linux/pci.h&gt;<br>
@@ -662,6 +665,11 @@ static int convert_tiling_flags_to_modifier(struct amd=
gpu_framebuffer *afb)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D drm_to_adev(afb-=
&gt;<a href=3D"http://base.dev" rel=3D"noreferrer" target=3D"_blank">base.d=
ev</a>);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t modifier =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int num_pipes =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int num_pkrs =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0num_pkrs =3D adev-&gt;gfx.config.gb_addr_config=
_fields.num_pkrs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0num_pipes =3D adev-&gt;gfx.config.gb_addr_confi=
g_fields.num_pipes;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!afb-&gt;tiling_flags || !AMDGPU_TILING_GET=
(afb-&gt;tiling_flags, SWIZZLE_MODE)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modifier =3D DRM_FO=
RMAT_MOD_LINEAR;<br>
@@ -674,7 +682,7 @@ static int convert_tiling_flags_to_modifier(struct amdg=
pu_framebuffer *afb)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int bank_xor_bits =
=3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int packers =3D 0;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rb =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int pipes =3D ilog2=
(adev-&gt;gfx.config.gb_addr_config_fields.num_pipes);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int pipes =3D ilog2=
(num_pipes);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t dcc_offset=
 =3D AMDGPU_TILING_GET(afb-&gt;tiling_flags, DCC_OFFSET_256B);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (swizzle &gt=
;&gt; 2) {<br>
@@ -690,12 +698,17 @@ static int convert_tiling_flags_to_modifier(struct am=
dgpu_framebuffer *afb)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 6: /* 64 KiB _=
X */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 block_size_bits =3D 16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 7: /* 256 KiB =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0block_size_bits =3D 18;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* RESERVED or VAR */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;ip_ver=
sions[GC_HWIP][0] &gt;=3D IP_VERSION(10, 3, 0))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;ip_ver=
sions[GC_HWIP][0] &gt;=3D IP_VERSION(11, 0, 0))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0version =3D AMD_FMT_MOD_TILE_VER_GFX11;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (adev-&gt;i=
p_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10, 3, 0))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 version =3D AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (adev-&gt;i=
p_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10, 0, 0))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 version =3D AMD_FMT_MOD_TILE_VER_GFX10;<br>
@@ -718,7 +731,17 @@ static int convert_tiling_flags_to_modifier(struct amd=
gpu_framebuffer *afb)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><=
div><br></div><div>The switch statement right above this that is not in thi=
s patch and changes &quot;version&quot; should be skipped on &gt;=3D gfx11.=
 Under no circumstances should the version be changed on gfx11.<br></div><d=
iv><br></div><div>Marek<br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_xor) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (num_pipes =3D=3D num_pkrs &amp;&amp; num_pkrs =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;invalid number of pip=
es and packers\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 switch (version) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case AMD_FMT_MOD_TILE_VER_GFX11:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipe_xor_bits =3D min(block_size_bits=
 - 8, pipes);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packers =3D min(block_size_bits - 8 -=
 pipe_xor_bits,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ilog2(adev-&gt;gfx.config.gb_addr_config_fields.num_pkr=
s));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pipe_xor_bits =3D min(block_size_bit=
s - 8, pipes);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packers =3D min(block_size_bits - 8 =
- pipe_xor_bits,<br>
@@ -752,9 +775,10 @@ static int convert_tiling_flags_to_modifier(struct amd=
gpu_framebuffer *afb)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 u64 render_dcc_offset;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Enable constant encode on RAVEN2 and later. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bool dcc_constant_encode =3D adev-&gt;asic_type &gt; CHIP_RAVEN |=
|<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bool dcc_constant_encode =3D (adev-&gt;asic_type &gt; CHIP_RAVEN =
||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(adev-&gt;asic_type =3D=3D CHIP_RAVEN &am=
p;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;external_rev_id &gt;=3D 0x81);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;external_rev_id &gt;=3D 0x81)) &=
amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;ip_versions[GC_HWIP][0] &lt; IP_=
VERSION(11, 0, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int max_cblock_size =3D dcc_i64b ? AMD_FMT_MOD_DCC_BLOCK_64B :<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dcc_i128b ? AMD_FMT_MOD_DCC_BLOCK_128B :<br>
@@ -869,10 +893,11 @@ static unsigned int get_dcc_block_size(uint64_t modif=
ier, bool rb_aligned,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return max(10 + (rb=
_aligned ? (int)AMD_FMT_MOD_GET(RB, modifier) : 0), 12);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FMT_MOD_TILE_VER_GFX10:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_VER_GFX11: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipes_log2 =3D =
AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ver =3D=3D AMD_=
FMT_MOD_TILE_VER_GFX10_RBPLUS &amp;&amp; pipes_log2 &gt; 1 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ver &gt;=3D AMD=
_FMT_MOD_TILE_VER_GFX10_RBPLUS &amp;&amp; pipes_log2 &gt; 1 &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_GET(PACKERS, modifier) =3D=3D pipes_log2)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ++pipes_log2;<br>
<br>
@@ -965,6 +990,9 @@ static int amdgpu_display_verify_sizes(struct amdgpu_fr=
amebuffer *rfb)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 case DC_SW_64KB_S_X:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block_size_log2 =3D 16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case DC_SW_VAR_S_X:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block_size_log2 =3D 18;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_dbg_kms(rfb-&gt;<a href=3D"http:=
//base.dev" rel=3D"noreferrer" target=3D"_blank">base.dev</a>,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;Swizzle mode with unknown block size: %d\n&quot;, swizzle);<br=
>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index a93affc37c53..badd136f5686 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -88,10 +88,14 @@<br>
=C2=A0#include &quot;dcn/dcn_1_0_offset.h&quot;<br>
=C2=A0#include &quot;dcn/dcn_1_0_sh_mask.h&quot;<br>
=C2=A0#include &quot;soc15_hw_ip.h&quot;<br>
+#include &quot;soc15_common.h&quot;<br>
=C2=A0#include &quot;vega10_ip_offset.h&quot;<br>
<br>
=C2=A0#include &quot;soc15_common.h&quot;<br>
<br>
+#include &quot;gc/gc_11_0_0_offset.h&quot;<br>
+#include &quot;gc/gc_11_0_0_sh_mask.h&quot;<br>
+<br>
=C2=A0#include &quot;modules/inc/mod_freesync.h&quot;<br>
=C2=A0#include &quot;modules/power/power_helpers.h&quot;<br>
=C2=A0#include &quot;modules/inc/mod_info_packet.h&quot;<br>
@@ -4885,7 +4889,9 @@ fill_gfx9_tiling_info_from_modifier(const struct amdg=
pu_device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int mod_bank_xor_bits =3D AMD_FMT_MOD_=
GET(BANK_XOR_BITS, modifier);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int mod_pipe_xor_bits =3D AMD_FMT_MOD_=
GET(PIPE_XOR_BITS, modifier);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int pkrs_log2 =3D AMD_FMT_MOD_GET(PACK=
ERS, modifier);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pipes_log2 =3D min(4u, mod_pipe_xo=
r_bits);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pipes_log2;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pipes_log2 =3D min(5u, mod_pipe_xor_bits);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fill_gfx9_tiling_info_from_device(adev, tiling_=
info);<br>
<br>
@@ -5221,6 +5227,67 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));<br>
=C2=A0}<br>
<br>
+static void<br>
+add_gfx11_modifiers(const struct amdgpu_device *adev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t **mods, uint64_t *size, uint64_t *capacity)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int num_pipes =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int pipe_xor_bits =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int num_pkrs =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int pkrs =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 gb_addr_config;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned swizzle_r_x;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t modifier_r_x;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t modifier_dcc_best;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t modifier_dcc_4k;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: GFX11 IP HW init hasnt finish and we g=
et zero if we read from<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * adev-&gt;gfx.config.gb_addr_config_fields.nu=
m_{pkrs,pipes} */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0gb_addr_config =3D RREG32_SOC15(GC, 0, regGB_AD=
DR_CONFIG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ASSERT(gb_addr_config !=3D 0);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0num_pkrs =3D 1 &lt;&lt; REG_GET_FIELD(gb_addr_c=
onfig, GB_ADDR_CONFIG, NUM_PKRS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pkrs =3D ilog2(num_pkrs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0num_pipes =3D 1 &lt;&lt; REG_GET_FIELD(gb_addr_=
config, GB_ADDR_CONFIG, NUM_PIPES);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pipe_xor_bits =3D ilog2(num_pipes);<br>
+<br>
+=C2=A0 =C2=A0 /* R_X swizzle modes are the best for rendering and DCC requ=
ires them. */<br>
+=C2=A0 =C2=A0 swizzle_r_x =3D num_pipes &gt; 16 ? AMD_FMT_MOD_TILE_GFX11_2=
56K_R_X :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 AMD_FMT_MOD_TILE_GFX9_64K_R_X;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0modifier_r_x =3D AMD_FMT_MOD |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER=
_GFX11) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(TILE, swizzle_r_x) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(PACKERS, pkrs);<br>
+<br>
+=C2=A0 =C2=A0 /* DCC_CONSTANT_ENCODE is not set because it can&#39;t vary =
with gfx11 (it&#39;s implied to be 1). */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0modifier_dcc_best =3D modifier_r_x |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 0) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_=
MOD_DCC_BLOCK_128B);<br>
+<br>
+=C2=A0 =C2=A0 /* DCC settings for 4K and greater resolutions. (required by=
 display hw) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0modifier_dcc_4k =3D modifier_r_x |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_=
MOD_DCC_BLOCK_64B);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, modifier_dcc=
_best);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, modifier_dcc=
_4k);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, modifier_dcc=
_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, modifier_dcc=
_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, modifier_r_x=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(TILE_VERSI=
ON, AMD_FMT_MOD_TILE_VER_GFX11) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D));<br>
+}<br>
+<br>
=C2=A0static int<br>
=C2=A0get_plane_modifiers(const struct amdgpu_device *adev, unsigned int pl=
ane_type, uint64_t **mods)<br>
=C2=A0{<br>
@@ -5254,6 +5321,9 @@ get_plane_modifiers(const struct amdgpu_device *adev,=
 unsigned int plane_type, u<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 add_gfx10_1_modifiers(adev, mods, &amp;size, &amp;capacity);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_FAMILY_GC_11_0_0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add_gfx11_modifiers=
(adev, mods, &amp;size, &amp;capacity);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, &amp;size, &amp;capacity, DR=
M_FORMAT_MOD_LINEAR);<br>
@@ -5292,7 +5362,7 @@ fill_gfx9_plane_attributes_from_modifiers(struct amdg=
pu_device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcc-&gt;enable =3D =
1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcc-&gt;meta_pitch =
=3D afb-&gt;base.pitches[1];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcc-&gt;independent=
_64b_blks =3D independent_64b_blks;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (AMD_FMT_MOD_GET=
(TILE_VERSION, modifier) =3D=3D AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (AMD_FMT_MOD_GET=
(TILE_VERSION, modifier) &gt;=3D AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (independent_64b_blks &amp;&amp; independent_128b_blks)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcc-&gt;dcc_ind_blk =3D hubp_ind_blo=
ck_64b_no_128bcl;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else if (independent_128b_blks)<br>
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h<=
br>
index fc0c1454d275..14cb2dafb0fa 100644<br>
--- a/include/uapi/drm/drm_fourcc.h<br>
+++ b/include/uapi/drm/drm_fourcc.h<br>
@@ -1294,6 +1294,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modif=
ier)<br>
=C2=A0#define AMD_FMT_MOD_TILE_VER_GFX9 1<br>
=C2=A0#define AMD_FMT_MOD_TILE_VER_GFX10 2<br>
=C2=A0#define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3<br>
+#define AMD_FMT_MOD_TILE_VER_GFX11 4<br>
<br>
=C2=A0/*<br>
=C2=A0 * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 a=
s canonical<br>
@@ -1309,6 +1310,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modif=
ier)<br>
=C2=A0#define AMD_FMT_MOD_TILE_GFX9_64K_S_X 25<br>
=C2=A0#define AMD_FMT_MOD_TILE_GFX9_64K_D_X 26<br>
=C2=A0#define AMD_FMT_MOD_TILE_GFX9_64K_R_X 27<br>
+#define AMD_FMT_MOD_TILE_GFX11_256K_R_X 31<br>
<br>
=C2=A0#define AMD_FMT_MOD_DCC_BLOCK_64B 0<br>
=C2=A0#define AMD_FMT_MOD_DCC_BLOCK_128B 1<br>
-- <br>
2.35.3<br>
<br>
</blockquote></div></div>

--0000000000007fb2b305dfdb121e--
