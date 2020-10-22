Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BCFC388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B9C21481
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gezuvkGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B9C21481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E38C6E14C;
	Thu, 22 Oct 2020 05:51:02 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CD36E14C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 05:51:01 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id d78so552726wmd.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 22:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7FtzrUaxL4l25vL5z0jLlfPrS+GNMOQZeNy8QGdDNas=;
 b=gezuvkGCye5noaf/v/1qzDjOAOTzRzuHlmdtu5EsSAcD9iGCOyyYgcCrggxzR2/JDj
 8hKnBCTOI+/xpYS/rwoFlh3yEU4OshfK3GY8id8loD5VQJ3yw9j8kexW0Yn285Rdc2dB
 9/tqp5s8eeOOzUBtSQ0qAF+nfvHbxEXEE6alGUt97xqdyG+SyGwFqsDC29v6/ODn/Lh7
 AFNN3pNrrwZzeDqdIYpLbIbbbnACCTvUOBcchzX3wjiapxPGHvlPIRkAQmNH8Cm4dTyK
 7Z6AZS3wGUhVpvCrfZs76BbiwEbu0TJcl+JI/V4jZx9guYtcq2U9Rs1EfNBnMISRX4u/
 gXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7FtzrUaxL4l25vL5z0jLlfPrS+GNMOQZeNy8QGdDNas=;
 b=R47yWqIczlaIpfdJY1hHIzVjEec7sYhJj8yDIVso/7+XFa4KK0ztGJTeTw+OkBvVwN
 s+v9bruhBeowxQ7TY2NTm4vWxEnKuAMoz6EwvENli/+DIVX+QkVsDeogHceww+wg/TAl
 t/y0F3Bum44zqTs46AJJXHxhgkSLxUv2HrhSrtYEN2p6pmNxPGJOr5wKaab5vSceR8Ne
 hvL8QjUzxkNsa6Yq9wOzP6X7OSoFlJZTIgq0n9Viwt1EinAdd8UCsssyXmG4TtiOBwVC
 8S7HASPzfcCOF8P/cX2rJtEu5rSx9yuiXkkSdNAHYSo02j0H6xcuEbfDrZd91PoyTvkL
 0gQQ==
X-Gm-Message-State: AOAM531xkRuutXHcXlo+p462XLiOZ9D0+4jtRRvWmuGamNvk617lGGCR
 54uKUfnBI4fuoG8ynsbNNSdCxJ6FA1LX2cX7mfI=
X-Google-Smtp-Source: ABdhPJw7kE3h9r7Cyw3Z97YbIkMymneZJ/9YZVVOABroNiaqDEL8Q2zVYqtUH+KRU0RXUDZE3mVfeVtZYgiDTwConJk=
X-Received: by 2002:a1c:a1c2:: with SMTP id k185mr815207wme.39.1603345860151; 
 Wed, 21 Oct 2020 22:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
 <20201021233130.874615-11-bas@basnieuwenhuizen.nl>
In-Reply-To: <20201021233130.874615-11-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2020 01:50:48 -0400
Message-ID: <CADnq5_NtCqp+PG4qj+z2Ffa1SKKD08Lz_QQFUZ9qPdioyAAFig@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] drm/amd/display: Expose modifiers.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: Marek Olsak <maraeo@gmail.com>, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Wentland, Harry" <harry.wentland@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 21, 2020 at 7:31 PM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> This expose modifier support on GFX9+.
>
> Only modifiers that can be rendered on the current GPU are
> added. This is to reduce the number of modifiers exposed.
>
> The HW could expose more, but the best mechanism to decide
> what to expose without an explosion in modifiers is still
> to be decided, and in the meantime this should not regress
> things from pre-modifiers and does not risk regressions as
> we make up our mind in the future.
>
> v2:
>   - Added comment that D on Raven is only valid for 64bpp
>     and will be filtered based on format later.
>   - Removed D tiling modes that weren't useful for 64bpp
>     on GFX10+.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 338 +++++++++++++++++-
>  1 file changed, 337 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6b33e030fe20..a1ce325f2fd1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4133,6 +4133,335 @@ fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
>         }
>  }
>
> +enum dm_micro_swizzle {
> +       MICRO_SWIZZLE_Z = 0,
> +       MICRO_SWIZZLE_S = 1,
> +       MICRO_SWIZZLE_D = 2,
> +       MICRO_SWIZZLE_R = 3
> +};
> +
> +static bool dm_plane_format_mod_supported(struct drm_plane *plane,
> +                                         uint32_t format,
> +                                         uint64_t modifier)
> +{
> +       struct amdgpu_device *adev = drm_to_adev(plane->dev);
> +       const struct drm_format_info *info = drm_format_info(format);
> +
> +       enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
> +
> +       if (!info)
> +               return false;
> +
> +       /*
> +        * We always have to allow this modifier, because core DRM still
> +        * checks LINEAR support if userspace does not provide modifers.
> +        */
> +       if (modifier == DRM_FORMAT_MOD_LINEAR)
> +               return true;
> +
> +       /*
> +        * The arbitrary tiling support for multiplane formats has not been hooked
> +        * up.
> +        */
> +       if (info->num_planes > 1)
> +               return false;
> +
> +       /*
> +        * For D swizzle the canonical modifier depends on the bpp, so check
> +        * it here.
> +        */
> +       if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
> +           adev->family >= AMDGPU_FAMILY_NV) {
> +               if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
> +                       return false;
> +       }
> +
> +       if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
> +           info->cpp[0] < 8)
> +               return false;
> +
> +       if (modifier_has_dcc(modifier)) {
> +               /* Per radeonsi comments 16/64 bpp are more complicated. */
> +               if (info->cpp[0] != 4)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static void
> +add_modifier(uint64_t **mods, uint64_t *size, uint64_t *cap, uint64_t mod)
> +{
> +       if (!*mods)
> +               return;
> +
> +       if (*cap - *size < 1) {
> +               uint64_t new_cap = *cap * 2;
> +               uint64_t *new_mods = kmalloc(new_cap * sizeof(uint64_t), GFP_KERNEL);
> +
> +               if (!new_mods) {
> +                       kfree(*mods);
> +                       *mods = NULL;
> +                       return;
> +               }
> +
> +               memcpy(new_mods, *mods, sizeof(uint64_t) * *size);
> +               kfree(*mods);
> +               *mods = new_mods;
> +               *cap = new_cap;
> +       }
> +
> +       (*mods)[*size] = mod;
> +       *size += 1;
> +}
> +
> +static void
> +add_gfx9_modifiers(const struct amdgpu_device *adev,
> +                  uint64_t **mods, uint64_t *size, uint64_t *capacity)
> +{
> +       int pipes = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> +       int pipe_xor_bits = min(8, pipes +
> +                               ilog2(adev->gfx.config.gb_addr_config_fields.num_se));
> +       int bank_xor_bits = min(8 - pipe_xor_bits,
> +                               ilog2(adev->gfx.config.gb_addr_config_fields.num_banks));
> +       int rb = ilog2(adev->gfx.config.gb_addr_config_fields.num_se) +
> +                ilog2(adev->gfx.config.gb_addr_config_fields.num_rb_per_se);
> +
> +
> +       if (adev->family == AMDGPU_FAMILY_RV) {
> +               /* Raven2 and later */
> +               bool has_constant_encode = adev->asic_type > CHIP_RAVEN || adev->external_rev_id >= 0x81;
> +
> +               /*
> +                * No _D DCC swizzles yet because we only allow 32bpp, which
> +                * doesn't support _D on DCN
> +                */
> +
> +               if (has_constant_encode) {
> +                       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +                                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +                                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                                   AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> +                                   AMD_FMT_MOD_SET(DCC, 1) |
> +                                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> +                                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1));
> +               }
> +
> +               add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                           AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +                           AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +                           AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                           AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> +                           AMD_FMT_MOD_SET(DCC, 1) |
> +                           AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                           AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> +                           AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0));
> +
> +               if (has_constant_encode) {
> +                       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +                                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +                                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                                   AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> +                                   AMD_FMT_MOD_SET(DCC, 1) |
> +                                   AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +                                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> +
> +                                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                                   AMD_FMT_MOD_SET(RB, rb) |
> +                                   AMD_FMT_MOD_SET(PIPE, pipes));
> +               }
> +
> +               add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                           AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +                           AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +                           AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                           AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> +                           AMD_FMT_MOD_SET(DCC, 1) |
> +                           AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +                           AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                           AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> +                           AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0) |
> +                           AMD_FMT_MOD_SET(RB, rb) |
> +                           AMD_FMT_MOD_SET(PIPE, pipes));
> +       }
> +
> +       /*
> +        * Only supported for 64bpp on Raven, will be filtered on format in
> +        * dm_plane_format_mod_supported.
> +        */
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
> +
> +       if (adev->family == AMDGPU_FAMILY_RV) {
> +               add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                           AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +                           AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +                           AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                           AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
> +       }
> +
> +       /*
> +        * Only supported for 64bpp on Raven, will be filtered on format in
> +        * dm_plane_format_mod_supported.
> +        */
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +
> +       if (adev->family == AMDGPU_FAMILY_RV) {
> +               add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                           AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
> +                           AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +       }
> +}
> +
> +static void
> +add_gfx10_1_modifiers(const struct amdgpu_device *adev,
> +                     uint64_t **mods, uint64_t *size, uint64_t *capacity)
> +{
> +       int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(DCC, 1) |
> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(DCC, 1) |
> +                   AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
> +
> +
> +       /* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +}
> +
> +static void
> +add_gfx10_3_modifiers(const struct amdgpu_device *adev,
> +                     uint64_t **mods, uint64_t *size, uint64_t *capacity)
> +{
> +       int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> +       int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +                   AMD_FMT_MOD_SET(DCC, 1) |
> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +                   AMD_FMT_MOD_SET(DCC, 1) |
> +                   AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(PACKERS, pkrs));
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(PACKERS, pkrs));
> +
> +       /* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +}
> +
> +static int
> +get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
> +{
> +       uint64_t size = 0, capacity = 128;
> +       *mods = NULL;
> +
> +       /* We have not hooked up any pre-GFX9 modifiers. */
> +       if (adev->family < AMDGPU_FAMILY_AI)
> +               return 0;
> +
> +       *mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
> +
> +       if (plane_type == DRM_PLANE_TYPE_CURSOR) {
> +               add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
> +               add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
> +               return *mods ? 0 : -ENOMEM;
> +       }
> +
> +       switch (adev->family) {
> +       case AMDGPU_FAMILY_AI:
> +       case AMDGPU_FAMILY_RV:
> +               add_gfx9_modifiers(adev, mods, &size, &capacity);
> +               break;
> +       case AMDGPU_FAMILY_NV:

Should probably add:
case AMDGPU_FAMILY_VGH:
here as well.

Alex

> +               if (adev->asic_type >= CHIP_SIENNA_CICHLID)
> +                       add_gfx10_3_modifiers(adev, mods, &size, &capacity);
> +               else
> +                       add_gfx10_1_modifiers(adev, mods, &size, &capacity);
> +               break;
> +       }
> +
> +       add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
> +
> +       /* INVALID marks the end of the list. */
> +       add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
> +
> +       if (!*mods)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
>  static int
>  fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
>                                           const struct amdgpu_framebuffer *afb,
> @@ -6100,6 +6429,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
>         .reset = dm_drm_plane_reset,
>         .atomic_duplicate_state = dm_drm_plane_duplicate_state,
>         .atomic_destroy_state = dm_drm_plane_destroy_state,
> +       .format_mod_supported = dm_plane_format_mod_supported,
>  };
>
>  static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
> @@ -6392,13 +6722,19 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>         int num_formats;
>         int res = -EPERM;
>         unsigned int supported_rotations;
> +       uint64_t *modifiers = NULL;
>
>         num_formats = get_plane_formats(plane, plane_cap, formats,
>                                         ARRAY_SIZE(formats));
>
> +       res = get_plane_modifiers(dm->adev, plane->type, &modifiers);
> +       if (res)
> +               return res;
> +
>         res = drm_universal_plane_init(adev_to_drm(dm->adev), plane, possible_crtcs,
>                                        &dm_plane_funcs, formats, num_formats,
> -                                      NULL, plane->type, NULL);
> +                                      modifiers, plane->type, NULL);
> +       kfree(modifiers);
>         if (res)
>                 return res;
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
