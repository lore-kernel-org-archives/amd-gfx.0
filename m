Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4B2C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 22:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EF111B6CB;
	Tue, 28 Jun 2022 22:33:30 +0000 (UTC)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CE111B6AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 22:33:29 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id m13so14373320ioj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y0625B9xkGiJc7mPRr/6PxTpLl6gWv8uL5d9UvJ64hw=;
 b=iz2UKdKCE4/6JNkGI5WSNPNhs+3P4kJfNZYe0BG68DnLf2PqNQFZO3axytczhlCjNk
 C+v5BUHBCch43S/iBmK+6r99y9anZDYL6mFjV0vQg9U/w8fK7tKk9soETLb0Ft6DMs0V
 N52+DhWvYtNgenQsTgxxfk0XFLMW5penPP2h7YMyWxBy8AEhXWjd/76mrD7AXS8W1kGU
 XTmd7xm1ci9/K3Mi+2RU4Hh2A/XQU3oYyS3u3xNg9CBKgm5lJ+uOONfOdz3UZrcBX8jh
 WqALOeoWa493gl3QWnXciq/yhcEr1eCZc4Tg4BIld/TI+KjTMfjHmnMgeVQd6+kFkNsN
 Vq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y0625B9xkGiJc7mPRr/6PxTpLl6gWv8uL5d9UvJ64hw=;
 b=RFBLbuyQhPKPt0L40uuRpEjka8F9OqhFtm+uEylfvNCUUeYinUaho3Q0LkzVGv+JPt
 blCyUkZ7PpLDkaAph3w7taPVbqxXjRsmS8p8dgd65+CL7ioQB6LG2KEcIYULGjnS1ZWw
 eb3yBOcKKpWVkhh284S9mOmvRhxCCjWQV7CY/pxBacRX2UlsJ0MjzpyKSqTLWBpCd6uj
 SKDBSSzQeImX0s4OvFei74ox2h6dtpoNOfGaHSNF0huxN/1PDMI9Sx/vbklKiRIOcSSh
 ReXknvUvipViWZ6OVw9nKqjzX9f6TBov73Iw+OChZsAMLuYGOO6VxVqqPquBxzno3iqa
 DHbQ==
X-Gm-Message-State: AJIora/QDQzguwkolsG3ajUzm38kATcAgnwGQc0QYle+rYUM4fOpYj2Q
 0F6HzuiGtt+qg3l2PuDSk2jEWabJspCY5r+DGwonGg==
X-Google-Smtp-Source: AGRyM1t2DPY2rw0YQM9/1OAZRQqvFeZCncTkvTMbuXFwbqItmNBpg96AIf5+BFkLyARlbfavATmafXjRpOmylG5wPRw=
X-Received: by 2002:a05:6638:d86:b0:33c:cbf8:9edb with SMTP id
 l6-20020a0566380d8600b0033ccbf89edbmr254941jaj.126.1656455608840; Tue, 28 Jun
 2022 15:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220628202528.2218174-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220628202528.2218174-1-aurabindo.pillai@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 29 Jun 2022 00:33:25 +0200
Message-ID: <CAP+8YyGbJvaj=NkFYtykRX2_HVqkVbqACmHJcW-QaB1eF0DkAA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: expose additional modifier for
 DCN32/321
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

On Tue, Jun 28, 2022 at 10:25 PM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> [Why&How]
> Some userspace expect a backwards compatible modifier on DCN32/321. For
> hardware with num_pipes more than 16, we expose the most efficient
> modifier first. As a fall back method, we need to expose slightly inefficient
> modifier AMD_FMT_MOD_TILE_GFX9_64K_R_X after the best option.
>
> Also set the number of packers to fixed value as required per hardware
> documentation. This value is cached during hardware initialization and
> can be read through the base driver.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  3 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 66 ++++++++++---------
>  2 files changed, 36 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 1a512d78673a..0f5bfe5df627 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -743,8 +743,7 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
>                         switch (version) {
>                         case AMD_FMT_MOD_TILE_VER_GFX11:
>                                 pipe_xor_bits = min(block_size_bits - 8, pipes);
> -                               packers = min(block_size_bits - 8 - pipe_xor_bits,
> -                                               ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs));
> +                               packers = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
>                                 break;
>                         case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
>                                 pipe_xor_bits = min(block_size_bits - 8, pipes);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 98bb65377e98..adccaf2f539d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5208,6 +5208,7 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
>         int num_pkrs = 0;
>         int pkrs = 0;
>         u32 gb_addr_config;
> +       u8 i = 0;
>         unsigned swizzle_r_x;
>         uint64_t modifier_r_x;
>         uint64_t modifier_dcc_best;
> @@ -5223,37 +5224,40 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
>         num_pipes = 1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PIPES);
>         pipe_xor_bits = ilog2(num_pipes);
>
> -       /* R_X swizzle modes are the best for rendering and DCC requires them. */
> -       swizzle_r_x = num_pipes > 16 ? AMD_FMT_MOD_TILE_GFX11_256K_R_X :
> -                                              AMD_FMT_MOD_TILE_GFX9_64K_R_X;
> -
> -       modifier_r_x = AMD_FMT_MOD |
> -               AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
> -               AMD_FMT_MOD_SET(TILE, swizzle_r_x) |
> -               AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -               AMD_FMT_MOD_SET(PACKERS, pkrs);
> -
> -       /* DCC_CONSTANT_ENCODE is not set because it can't vary with gfx11 (it's implied to be 1). */
> -       modifier_dcc_best = modifier_r_x |
> -               AMD_FMT_MOD_SET(DCC, 1) |
> -               AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 0) |
> -               AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> -               AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B);
> -
> -       /* DCC settings for 4K and greater resolutions. (required by display hw) */
> -       modifier_dcc_4k = modifier_r_x |
> -                       AMD_FMT_MOD_SET(DCC, 1) |
> -                       AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> -                       AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> -                       AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B);
> -
> -       add_modifier(mods, size, capacity, modifier_dcc_best);
> -       add_modifier(mods, size, capacity, modifier_dcc_4k);
> -
> -       add_modifier(mods, size, capacity, modifier_dcc_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));
> -       add_modifier(mods, size, capacity, modifier_dcc_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));
> -
> -       add_modifier(mods, size, capacity, modifier_r_x);
> +       for (i = 0; i < 2; i++) {
> +               /* Insert the best one first. */
> +               /* R_X swizzle modes are the best for rendering and DCC requires them. */
> +               if (num_pipes > 16)
> +                       swizzle_r_x = !i ? AMD_FMT_MOD_TILE_GFX11_256K_R_X : AMD_FMT_MOD_TILE_GFX9_64K_R_X;
> +               else
> +                       swizzle_r_x = !i ? AMD_FMT_MOD_TILE_GFX9_64K_R_X : AMD_FMT_MOD_TILE_GFX11_256K_R_X;
> +
> +               modifier_r_x = AMD_FMT_MOD |
> +                              AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
> +                              AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                              AMD_FMT_MOD_SET(TILE, swizzle_r_x) |
> +                              AMD_FMT_MOD_SET(PACKERS, pkrs);
> +
> +               /* DCC_CONSTANT_ENCODE is not set because it can't vary with gfx11 (it's implied to be 1). */
> +               modifier_dcc_best = modifier_r_x | AMD_FMT_MOD_SET(DCC, 1) |
> +                                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 0) |
> +                                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B);
> +
> +               /* DCC settings for 4K and greater resolutions. (required by display hw) */
> +               modifier_dcc_4k = modifier_r_x | AMD_FMT_MOD_SET(DCC, 1) |
> +                                 AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                                 AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                                 AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B);
> +
> +               add_modifier(mods, size, capacity, modifier_dcc_best);
> +               add_modifier(mods, size, capacity, modifier_dcc_4k);
> +
> +               add_modifier(mods, size, capacity, modifier_dcc_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));
> +               add_modifier(mods, size, capacity, modifier_dcc_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));
> +
> +               add_modifier(mods, size, capacity, modifier_r_x);
> +       }
>
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>               AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
> --
> 2.36.1
>
