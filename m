Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35369F54AC6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 14:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4CC10E6F7;
	Tue, 24 Mar 2026 14:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YHuBfyjF";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E5410E6F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 14:37:51 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12711867ca1so230596c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 07:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363070; cv=none;
 d=google.com; s=arc-20240605;
 b=YZ2uBF/hjG7VcyS2x4auqEeUt7A9dtbUuz0Fnvpm+sovnZTCX10KQHEAp/L0Wl43rg
 HTEGkP4j+aK2HXM7j/e8bVa933BOWZ1BChEmyZU7VZMM1A1rXHioXF8L0ILBNr1Q3gpT
 oYJgBtfn4hFIj1F+g/xmVKtqraN42DUTHQnYH21adY5+XO8DpBlx6WVkPf8f5dv2gf/9
 O5GzieTD3pLfZprotwvlglDOZMJhRHjaxpkAxn/qskRa75D87KT8vC+RRW5WQtkjf8H5
 Wss8iXeFvADdQlDxORZsVnPDX1sBzE7TARV4DxLJkC8IAtX13QH9Ly6nLnCZAOXYveZQ
 fYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4ohm3myHwg9cmAVnpbRUolzwBvkcMRf3i7unYvU0SFM=;
 fh=tmM1mGcBR8h1Ydqp+Gcvtcq5r5htSSh0D3MMaoflD5M=;
 b=LjK0dTWeI/D3N5d6f6+7zpgk5IsFEuERCz7QPt49KMAUT/odTQ1Lbnc4MHsGpJNomA
 mqkI7hfLKhZhpg2bjeff6GMf8CsrhoMMyp1LR/EFdRoG7Sp3dteCDWaKnWXuEyCSIoaQ
 64npTZBWUrnheiUrcCEJcbT0v3ffI/rDWephIRuAZRE3QFypfmBFOnkwFKMp3rFudoh3
 c7i/3PNqJilw2fB2mURRqKVTiQ4PtAVzXBVR16Abp0QglLeA6tR/jjFWurs5tJ1kOMoG
 F36N2NN4LAGOpEN2qNnNYMQSglfFxzzEce4KCHCX24f+wWBurM/S7dXNn4xnkkGWLtCm
 K+rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774363070; x=1774967870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ohm3myHwg9cmAVnpbRUolzwBvkcMRf3i7unYvU0SFM=;
 b=YHuBfyjFsk3rX7bMJiNbkxIZxupiy5QAANvlbwnBdFybi7BOsYCPAPChE6MyKfJ3W7
 yxfYk6O54Hl/OB9pFFyUpXSttWOJpAgsDHXKBgIRRfmvgj41Bxgaba+RJO2Glqt1S2wo
 T418Lglhms2e1tqXHR9/c2K1V9JwRJ0kg1Vqu03Uya9mtL05nkH66HYGxiHr7lrr7uYH
 GUIdHy/HLvOVaLsjDZTcqDz31BJjsda80WnTbflmI2kjr8fStIAF+3r3F5W9m9j1oKoJ
 SHhOQhbTgxp89/UmogSdZdJ0pWN2Vf8vr9OZTCk+K+nqxRputoXXQLKr4eQwDOYCJqXp
 g79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363070; x=1774967870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ohm3myHwg9cmAVnpbRUolzwBvkcMRf3i7unYvU0SFM=;
 b=VEVpvrXFKkOTGS1QRe1ztdgH0BC+0pJDTBEnyI+AYLy9HwIcBOdmVpQY1PyaPWr0gG
 44+18ODcmpISbozyunBA4jbOgpTvvJxsbA8venO94zlhdUqchZ4y0XJeLWYdiwC4Jztl
 An6Pe6dsNiBtGihJOPGuYJJ+T1MejhKIUQw7m0p10EE0+dG0Kf/sw83pgwpjgfC3T3kU
 z5Kkf7dn7NCN/8tjTvEJsOLeCibt1VeeBhv6eYwxxYIQNAzHIZ4OJ9atj9tHhxIoVVXG
 B5S90yGFSZyGI/8ShJeEFbLn3RuEOzNvzrOg8lGldcPBRGaloc78n/X5W5BiWg5K2JnY
 BO2w==
X-Gm-Message-State: AOJu0YxVyieg02eicifXtc697Vsw9N/0LMtBh13XHwoNW3fLeXQlV+h3
 NLjETYXDSOkybckr9yk7QchkK/Z1OLjglJ01iIGUOm3ZfHOBtKyJU3rsVN80bFoXCKd2UT6pyoj
 pl/MtZK6b6wlha1mbzoL31CFnqX/OBno=
X-Gm-Gg: ATEYQzzs1HJ3xQVAl0vOPGH37LK3jfcXxAbYXOgDhycPhrpTWxPE4tCxhBVcyan2cpB
 P0b2EqCiihgreEeDyYCCdj+8gABOVrZMWY4d3IHZIDpH4Yp9BV503beRxVcosTq0bJFGAYPq9Cc
 QJbuUrrN7CD0YFANpgtKcS30x8ed+eHr/PWcWuGBzjt0M5+ziPtuqo8saPo+6sTjhuyvSXzwm6f
 1kKWUyKr6HGA6JiMP5DgfHb7BdVwa/4Lg5dhwgtwckpYWn0JoELFpwh3LN40Sh5eaQ4R1mEGoDP
 DJiRKWhJrA0tDDg6x5P2zaDs+GVPVnKeibwb3t7XYBX6RUuwTdJ+v5dfo4MA+B71hzuFumURcP7
 jhfJR
X-Received: by 2002:a05:7022:e16:b0:128:e6e2:0 with SMTP id
 a92af1059eb24-12a726d3218mr3224733c88.6.1774363069847; Tue, 24 Mar 2026
 07:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260323211343.263909-1-sunlightlinux@gmail.com>
In-Reply-To: <20260323211343.263909-1-sunlightlinux@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 10:37:38 -0400
X-Gm-Features: AaiRm51rFGTs41eshW8t3PECnG85cZLG9Q1LK6OKJbeoeY6hB-J5fD-wFronzsQ
Message-ID: <CADnq5_N+CzdUtk3PXHUBvHGWMF+BkoHPp=Qc5vyODGuQsne97A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Wire up dcn10_dio_construct() for all
 pre-DCN401 generations
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>, "LIPSKI,
 IVAN" <IVAN.LIPSKI@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 Ionut Nechita <ionut_n2001@yahoo.com>
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

+ Ivan

On Mon, Mar 23, 2026 at 5:24=E2=80=AFPM Ionut Nechita (Sunlight Linux)
<sunlightlinux@gmail.com> wrote:
>
> From: Ionut Nechita <ionut_n2001@yahoo.com>
>
> Description:
>  - Commit b82f0759346617b2 ("drm/amd/display: Migrate DIO registers acces=
s
>    from hwseq to dio component") moved DIO_MEM_PWR_CTRL register access
>    behind the new dio abstraction layer but only created the dio object f=
or
>    DCN 4.01. On all other generations (DCN 10/20/21/201/30/301/302/303/
>    31/314/315/316/32/321/35/351/36), the dio pointer is NULL, causing the
>    register write to be silently skipped.
>
>    This results in AFMT HDMI memory not being powered on during init_hw,
>    which can cause HDMI audio failures and display issues on affected
>    hardware including Renoir/Cezanne (DCN 2.1) APUs that use dcn10_init_h=
w.
>
>    Call dcn10_dio_construct() in each older DCN generation's resource.c
>    to create the dio object, following the same pattern as DCN 4.01. This
>    ensures the dio pointer is non-NULL and the mem_pwr_ctrl callback work=
s
>    through the dio abstraction for all DCN generations.
>
> Fixes: b82f0759346617b2 ("drm/amd/display: Migrate DIO registers access f=
rom hwseq to dio component.")
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> ---
>  .../dc/resource/dcn10/dcn10_resource.c        | 41 ++++++++++++++++++
>  .../dc/resource/dcn20/dcn20_resource.c        | 42 ++++++++++++++++++
>  .../dc/resource/dcn201/dcn201_resource.c      | 41 ++++++++++++++++++
>  .../dc/resource/dcn21/dcn21_resource.c        | 34 +++++++++++++++
>  .../dc/resource/dcn30/dcn30_resource.c        | 42 ++++++++++++++++++
>  .../dc/resource/dcn301/dcn301_resource.c      | 42 ++++++++++++++++++
>  .../dc/resource/dcn302/dcn302_resource.c      | 41 ++++++++++++++++++
>  .../dc/resource/dcn303/dcn303_resource.c      | 41 ++++++++++++++++++
>  .../dc/resource/dcn31/dcn31_resource.c        | 40 +++++++++++++++++
>  .../dc/resource/dcn314/dcn314_resource.c      | 40 +++++++++++++++++
>  .../dc/resource/dcn315/dcn315_resource.c      | 40 +++++++++++++++++
>  .../dc/resource/dcn316/dcn316_resource.c      | 40 +++++++++++++++++
>  .../dc/resource/dcn32/dcn32_resource.c        | 43 +++++++++++++++++++
>  .../dc/resource/dcn321/dcn321_resource.c      | 43 +++++++++++++++++++
>  .../dc/resource/dcn35/dcn35_resource.c        | 43 +++++++++++++++++++
>  .../dc/resource/dcn351/dcn351_resource.c      | 43 +++++++++++++++++++
>  .../dc/resource/dcn36/dcn36_resource.c        | 43 +++++++++++++++++++
>  17 files changed, 699 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> index bbe185e15eb67..4663456a736a2 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> @@ -71,6 +71,7 @@
>  #include "dce/dce_dmcu.h"
>  #include "dce/dce_aux.h"
>  #include "dce/dce_i2c.h"
> +#include "dio/dcn10/dcn10_dio.h"
>
>  #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
>         #define mmDP0_DP_DPHY_INTERNAL_CTRL             0x210f
> @@ -444,6 +445,33 @@ static const struct dcn_hubbub_mask hubbub_mask =3D =
{
>                 HUBBUB_MASK_SH_LIST_DCN10(_MASK)
>  };
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
> +static struct dio *dcn10_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static int map_transmitter_id_to_phy_instance(
>         enum transmitter transmitter)
>  {
> @@ -917,6 +945,11 @@ static void dcn10_resource_destruct(struct dcn10_res=
ource_pool *pool)
>         kfree(pool->base.hubbub);
>         pool->base.hubbub =3D NULL;
>
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
> +
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.opps[i] !=3D NULL)
>                         pool->base.opps[i]->funcs->opp_destroy(&pool->bas=
e.opps[i]);
> @@ -1653,6 +1686,14 @@ static bool dcn10_resource_construct(
>                 goto fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn10_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto fail;
> +       }
> +
>         if (!resource_construct(num_virtual_links, dc, &pool->base,
>                         &res_create_funcs))
>                 goto fail;
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> index 8b555187ac753..74e8d229c9dd3 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> @@ -82,6 +82,7 @@
>  #include "dce/dce_dmcu.h"
>  #include "dce/dce_aux.h"
>  #include "dce/dce_i2c.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "vm_helper.h"
>
>  #include "link_enc_cfg.h"
> @@ -550,6 +551,33 @@ static const struct dcn_hubbub_mask hubbub_mask =3D =
{
>                 HUBBUB_MASK_SH_LIST_DCN20(_MASK)
>  };
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
> +static struct dio *dcn20_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  #define vmid_regs(id)\
>  [id] =3D {\
>                 DCN20_VMID_REG_LIST(id)\
> @@ -1104,6 +1132,12 @@ static void dcn20_resource_destruct(struct dcn20_r=
esource_pool *pool)
>                 kfree(pool->base.hubbub);
>                 pool->base.hubbub =3D NULL;
>         }
> +
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
> +
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.dpps[i] !=3D NULL)
>                         dcn20_dpp_destroy(&pool->base.dpps[i]);
> @@ -2692,6 +2726,14 @@ static bool dcn20_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn20_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         for (i =3D 0; i < pool->base.res_cap->num_dsc; i++) {
>                 pool->base.dscs[i] =3D dcn20_dsc_create(ctx, i);
>                 if (pool->base.dscs[i] =3D=3D NULL) {
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> index 4ea76e46ab15d..e289be70efb54 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> @@ -56,6 +56,7 @@
>  #include "dce/dce_aux.h"
>  #include "dce/dce_i2c.h"
>  #include "dcn10/dcn10_resource.h"
> +#include "dio/dcn10/dcn10_dio.h"
>
>  #include "cyan_skillfish_ip_offset.h"
>
> @@ -755,6 +756,33 @@ static struct hubbub *dcn201_hubbub_create(struct dc=
_context *ctx)
>         return &hubbub->base;
>  }
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
> +static struct dio *dcn201_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct timing_generator *dcn201_timing_generator_create(
>                 struct dc_context *ctx,
>                 uint32_t instance)
> @@ -930,6 +958,11 @@ static void dcn201_resource_destruct(struct dcn201_r=
esource_pool *pool)
>                 pool->base.hubbub =3D NULL;
>         }
>
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
> +
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.dpps[i] !=3D NULL)
>                         dcn201_dpp_destroy(&pool->base.dpps[i]);
> @@ -1276,6 +1309,14 @@ static bool dcn201_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn201_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         if (!resource_construct(num_virtual_links, dc, &pool->base,
>                         &res_create_funcs))
>                 goto create_fail;
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> index 0f4307f8f3dd5..4333baac96ad7 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> @@ -84,6 +84,7 @@
>  #include "dce/dce_dmcu.h"
>  #include "dce/dce_aux.h"
>  #include "dce/dce_i2c.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dcn21_resource.h"
>  #include "vm_helper.h"
>  #include "dcn20/dcn20_vmid.h"
> @@ -329,6 +330,25 @@ static const struct dcn_hubbub_mask hubbub_mask =3D =
{
>                 HUBBUB_MASK_SH_LIST_DCN21(_MASK)
>  };
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +static const struct dcn_dio_shift dio_shift =3D { 0 };
> +
> +static const struct dcn_dio_mask dio_mask =3D { 0 };
> +
> +static struct dio *dcn21_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
>
>  #define vmid_regs(id)\
>  [id] =3D {\
> @@ -677,6 +697,12 @@ static void dcn21_resource_destruct(struct dcn21_res=
ource_pool *pool)
>                 kfree(pool->base.hubbub);
>                 pool->base.hubbub =3D NULL;
>         }
> +
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
> +
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.dpps[i] !=3D NULL)
>                         dcn20_dpp_destroy(&pool->base.dpps[i]);
> @@ -1654,6 +1680,14 @@ static bool dcn21_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn21_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         for (i =3D 0; i < pool->base.res_cap->num_dsc; i++) {
>                 pool->base.dscs[i] =3D dcn21_dsc_create(ctx, i);
>                 if (pool->base.dscs[i] =3D=3D NULL) {
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> index 2fa86b9587ed0..87b7b4ee04c64 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> @@ -60,6 +60,7 @@
>  #include "dml/display_mode_vba.h"
>  #include "dcn30/dcn30_dccg.h"
>  #include "dcn10/dcn10_resource.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "link_service.h"
>  #include "dce/dce_panel_cntl.h"
>
> @@ -886,6 +887,33 @@ static struct hubbub *dcn30_hubbub_create(struct dc_=
context *ctx)
>         return &hubbub3->base;
>  }
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
> +static struct dio *dcn30_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct timing_generator *dcn30_timing_generator_create(
>                 struct dc_context *ctx,
>                 uint32_t instance)
> @@ -1095,6 +1123,12 @@ static void dcn30_resource_destruct(struct dcn30_r=
esource_pool *pool)
>                 kfree(pool->base.hubbub);
>                 pool->base.hubbub =3D NULL;
>         }
> +
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
> +
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.dpps[i] !=3D NULL)
>                         dcn30_dpp_destroy(&pool->base.dpps[i]);
> @@ -2464,6 +2498,14 @@ static bool dcn30_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn30_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 pool->base.hubps[i] =3D dcn30_hubp_create(ctx, i);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> index 7842bee57e636..6bb1c62124bb4 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> @@ -59,6 +59,7 @@
>  #include "dml/display_mode_vba.h"
>  #include "dcn301/dcn301_dccg.h"
>  #include "dcn10/dcn10_resource.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dcn30/dcn30_dio_stream_encoder.h"
>  #include "dcn301/dcn301_dio_link_encoder.h"
>  #include "dcn301/dcn301_panel_cntl.h"
> @@ -843,6 +844,33 @@ static struct hubbub *dcn301_hubbub_create(struct dc=
_context *ctx)
>         return &hubbub3->base;
>  }
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
> +static struct dio *dcn301_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct timing_generator *dcn301_timing_generator_create(
>         struct dc_context *ctx, uint32_t instance)
>  {
> @@ -1066,6 +1094,12 @@ static void dcn301_destruct(struct dcn301_resource=
_pool *pool)
>                 kfree(pool->base.hubbub);
>                 pool->base.hubbub =3D NULL;
>         }
> +
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
> +
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.dpps[i] !=3D NULL)
>                         dcn301_dpp_destroy(&pool->base.dpps[i]);
> @@ -1582,6 +1616,14 @@ static bool dcn301_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn301_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         j =3D 0;
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
> index 1874d5d6b7820..d02aafd06fd45 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
> @@ -46,6 +46,7 @@
>  #include "dml/dcn30/dcn30_fpu.h"
>
>  #include "dcn10/dcn10_resource.h"
> +#include "dio/dcn10/dcn10_dio.h"
>
>  #include "link_service.h"
>
> @@ -253,6 +254,33 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
> +static struct dio *dcn302_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn302_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1022,6 +1050,11 @@ static void dcn302_resource_destruct(struct resour=
ce_pool *pool)
>                 pool->hubbub =3D NULL;
>         }
>
> +       if (pool->dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->dio));
> +               pool->dio =3D NULL;
> +       }
> +
>         for (i =3D 0; i < pool->pipe_count; i++) {
>                 if (pool->dpps[i] !=3D NULL) {
>                         kfree(TO_DCN20_DPP(pool->dpps[i]));
> @@ -1372,6 +1405,14 @@ static bool dcn302_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->dio =3D dcn302_dio_create(ctx);
> +       if (pool->dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->pipe_count; i++) {
>                 pool->hubps[i] =3D dcn302_hubp_create(ctx, i);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> index d52201cb359fd..30b1403112c6c 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> @@ -46,6 +46,7 @@
>  #include "dml/dcn30/dcn30_fpu.h"
>
>  #include "dcn10/dcn10_resource.h"
> +#include "dio/dcn10/dcn10_dio.h"
>
>  #include "link_service.h"
>
> @@ -249,6 +250,33 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
> +static struct dio *dcn303_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn303_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -966,6 +994,11 @@ static void dcn303_resource_destruct(struct resource=
_pool *pool)
>                 pool->hubbub =3D NULL;
>         }
>
> +       if (pool->dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->dio));
> +               pool->dio =3D NULL;
> +       }
> +
>         for (i =3D 0; i < pool->pipe_count; i++) {
>                 if (pool->dpps[i] !=3D NULL) {
>                         kfree(TO_DCN20_DPP(pool->dpps[i]));
> @@ -1304,6 +1337,14 @@ static bool dcn303_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->dio =3D dcn303_dio_create(ctx);
> +       if (pool->dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->pipe_count; i++) {
>                 pool->hubps[i] =3D dcn303_hubp_create(ctx, i);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> index 2055f1f8af652..4e9c041c707a6 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> @@ -64,6 +64,7 @@
>  #include "dce/dce_audio.h"
>  #include "dce/dce_hwseq.h"
>  #include "clk_mgr.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dio/virtual/virtual_stream_encoder.h"
>  #include "dce110/dce110_resource.h"
>  #include "dml/display_mode_vba.h"
> @@ -810,6 +811,21 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
>  static const struct resource_caps res_cap_dcn31 =3D {
>         .num_timing_generator =3D 4,
>         .num_opp =3D 4,
> @@ -1021,6 +1037,18 @@ static struct mpc *dcn31_mpc_create(
>         return &mpc30->base;
>  }
>
> +static struct dio *dcn31_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn31_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1396,6 +1424,10 @@ static void dcn31_resource_destruct(struct dcn31_r=
esource_pool *pool)
>                 kfree(pool->base.hubbub);
>                 pool->base.hubbub =3D NULL;
>         }
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.dpps[i] !=3D NULL)
>                         dcn31_dpp_destroy(&pool->base.dpps[i]);
> @@ -2063,6 +2095,14 @@ static bool dcn31_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn31_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 pool->base.hubps[i] =3D dcn31_hubp_create(ctx, i);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
> index 1939f720ba295..e26a6427916a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
> @@ -66,6 +66,7 @@
>  #include "dce/dce_audio.h"
>  #include "dce/dce_hwseq.h"
>  #include "clk_mgr.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dio/virtual/virtual_stream_encoder.h"
>  #include "dce110/dce110_resource.h"
>  #include "dml/display_mode_vba.h"
> @@ -822,6 +823,21 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
>  static const struct resource_caps res_cap_dcn314 =3D {
>         .num_timing_generator =3D 4,
>         .num_opp =3D 4,
> @@ -1079,6 +1095,18 @@ static struct mpc *dcn31_mpc_create(
>         return &mpc30->base;
>  }
>
> +static struct dio *dcn314_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn31_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1455,6 +1483,10 @@ static void dcn314_resource_destruct(struct dcn314=
_resource_pool *pool)
>                 kfree(pool->base.hubbub);
>                 pool->base.hubbub =3D NULL;
>         }
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.dpps[i] !=3D NULL)
>                         dcn31_dpp_destroy(&pool->base.dpps[i]);
> @@ -1987,6 +2019,14 @@ static bool dcn314_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn314_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 pool->base.hubps[i] =3D dcn31_hubp_create(ctx, i);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> index e8377c190f635..131a6cd4c7352 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> @@ -63,6 +63,7 @@
>  #include "dce/dce_audio.h"
>  #include "dce/dce_hwseq.h"
>  #include "clk_mgr.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dio/virtual/virtual_stream_encoder.h"
>  #include "dce110/dce110_resource.h"
>  #include "dml/display_mode_vba.h"
> @@ -809,6 +810,21 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
>  static const struct resource_caps res_cap_dcn31 =3D {
>         .num_timing_generator =3D 4,
>         .num_opp =3D 4,
> @@ -1020,6 +1036,18 @@ static struct mpc *dcn31_mpc_create(
>         return &mpc30->base;
>  }
>
> +static struct dio *dcn315_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn31_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1397,6 +1425,10 @@ static void dcn315_resource_destruct(struct dcn315=
_resource_pool *pool)
>                 kfree(pool->base.hubbub);
>                 pool->base.hubbub =3D NULL;
>         }
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.dpps[i] !=3D NULL)
>                         dcn31_dpp_destroy(&pool->base.dpps[i]);
> @@ -2012,6 +2044,14 @@ static bool dcn315_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn315_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 pool->base.hubps[i] =3D dcn31_hubp_create(ctx, i);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> index 045ce01bd74eb..c8c0ce6efcfdc 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> @@ -63,6 +63,7 @@
>  #include "dce/dce_audio.h"
>  #include "dce/dce_hwseq.h"
>  #include "clk_mgr.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dio/virtual/virtual_stream_encoder.h"
>  #include "dce110/dce110_resource.h"
>  #include "dml/display_mode_vba.h"
> @@ -804,6 +805,21 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static const struct dcn_dio_registers dio_regs =3D {
> +               DIO_REG_LIST_DCN10()
> +};
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
>  static const struct resource_caps res_cap_dcn31 =3D {
>         .num_timing_generator =3D 4,
>         .num_opp =3D 4,
> @@ -1013,6 +1029,18 @@ static struct mpc *dcn31_mpc_create(
>         return &mpc30->base;
>  }
>
> +static struct dio *dcn316_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn31_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1392,6 +1420,10 @@ static void dcn316_resource_destruct(struct dcn316=
_resource_pool *pool)
>                 kfree(pool->base.hubbub);
>                 pool->base.hubbub =3D NULL;
>         }
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.dpps[i] !=3D NULL)
>                         dcn31_dpp_destroy(&pool->base.dpps[i]);
> @@ -1887,6 +1919,14 @@ static bool dcn316_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn316_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 pool->base.hubps[i] =3D dcn31_hubp_create(ctx, i);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index c7fd604024d64..c3a6ae14de18b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -66,6 +66,7 @@
>  #include "dce/dce_hwseq.h"
>  #include "clk_mgr.h"
>  #include "dio/virtual/virtual_stream_encoder.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dml/display_mode_vba.h"
>  #include "dcn32/dcn32_dccg.h"
>  #include "dcn10/dcn10_resource.h"
> @@ -643,6 +644,19 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static struct dcn_dio_registers dio_regs;
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
>  static const struct resource_caps res_cap_dcn32 =3D {
>         .num_timing_generator =3D 4,
>         .num_opp =3D 4,
> @@ -833,6 +847,22 @@ static struct clock_source *dcn32_clock_source_creat=
e(
>         return NULL;
>  }
>
> +static struct dio *dcn32_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +#undef REG_STRUCT
> +#define REG_STRUCT dio_regs
> +       DIO_REG_LIST_DCN10();
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn32_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1494,6 +1524,11 @@ static void dcn32_resource_destruct(struct dcn32_r=
esource_pool *pool)
>         if (pool->base.dccg !=3D NULL)
>                 dcn_dccg_destroy(&pool->base.dccg);
>
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
> +
>         if (pool->base.oem_device !=3D NULL) {
>                 struct dc *dc =3D pool->base.oem_device->ctx->dc;
>
> @@ -2373,6 +2408,14 @@ static bool dcn32_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn32_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs, TGs, ABMs */
>         for (i =3D 0, j =3D 0; i < pool->base.res_cap->num_timing_generat=
or; i++) {
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index c1582c27ac872..990aec7eb3d07 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -69,6 +69,7 @@
>  #include "dce/dce_hwseq.h"
>  #include "clk_mgr.h"
>  #include "dio/virtual/virtual_stream_encoder.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dml/display_mode_vba.h"
>  #include "dcn32/dcn32_dccg.h"
>  #include "dcn10/dcn10_resource.h"
> @@ -639,6 +640,19 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static struct dcn_dio_registers dio_regs;
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
>  static const struct resource_caps res_cap_dcn321 =3D {
>         .num_timing_generator =3D 4,
>         .num_opp =3D 4,
> @@ -827,6 +841,22 @@ static struct clock_source *dcn321_clock_source_crea=
te(
>         return NULL;
>  }
>
> +static struct dio *dcn321_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +#undef REG_STRUCT
> +#define REG_STRUCT dio_regs
> +       DIO_REG_LIST_DCN10();
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn321_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1474,6 +1504,11 @@ static void dcn321_resource_destruct(struct dcn321=
_resource_pool *pool)
>         if (pool->base.dccg !=3D NULL)
>                 dcn_dccg_destroy(&pool->base.dccg);
>
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
> +
>         if (pool->base.oem_device !=3D NULL) {
>                 struct dc *dc =3D pool->base.oem_device->ctx->dc;
>
> @@ -1872,6 +1907,14 @@ static bool dcn321_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn321_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs, TGs, ABMs */
>         for (i =3D 0, j =3D 0; i < pool->base.res_cap->num_timing_generat=
or; i++) {
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 3494a40cea99f..598b2f25881da 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -71,6 +71,7 @@
>  #include "dce/dce_hwseq.h"
>  #include "clk_mgr.h"
>  #include "dio/virtual/virtual_stream_encoder.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dce110/dce110_resource.h"
>  #include "dml/display_mode_vba.h"
>  #include "dcn35/dcn35_dccg.h"
> @@ -664,6 +665,19 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static struct dcn_dio_registers dio_regs;
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
>  static const struct resource_caps res_cap_dcn35 =3D {
>         .num_timing_generator =3D 4,
>         .num_opp =3D 4,
> @@ -973,6 +987,22 @@ static struct mpc *dcn35_mpc_create(
>         return &mpc30->base;
>  }
>
> +static struct dio *dcn35_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +#undef REG_STRUCT
> +#define REG_STRUCT dio_regs
> +       DIO_REG_LIST_DCN10();
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn35_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1563,6 +1593,11 @@ static void dcn35_resource_destruct(struct dcn35_r=
esource_pool *pool)
>
>         if (pool->base.dccg !=3D NULL)
>                 dcn_dccg_destroy(&pool->base.dccg);
> +
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
>  }
>
>  static struct hubp *dcn35_hubp_create(
> @@ -2033,6 +2068,14 @@ static bool dcn35_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn35_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 pool->base.hubps[i] =3D dcn35_hubp_create(ctx, i);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index 080bc7f24ffaa..7e15d07df7a33 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -50,6 +50,7 @@
>  #include "dce/dce_hwseq.h"
>  #include "clk_mgr.h"
>  #include "dio/virtual/virtual_stream_encoder.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dce110/dce110_resource.h"
>  #include "dml/display_mode_vba.h"
>  #include "dcn35/dcn35_dccg.h"
> @@ -644,6 +645,19 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static struct dcn_dio_registers dio_regs;
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
>  static const struct resource_caps res_cap_dcn351 =3D {
>         .num_timing_generator =3D 4,
>         .num_opp =3D 4,
> @@ -953,6 +967,22 @@ static struct mpc *dcn35_mpc_create(
>         return &mpc30->base;
>  }
>
> +static struct dio *dcn351_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +#undef REG_STRUCT
> +#define REG_STRUCT dio_regs
> +       DIO_REG_LIST_DCN10();
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn35_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1543,6 +1573,11 @@ static void dcn351_resource_destruct(struct dcn351=
_resource_pool *pool)
>
>         if (pool->base.dccg !=3D NULL)
>                 dcn_dccg_destroy(&pool->base.dccg);
> +
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
>  }
>
>  static struct hubp *dcn35_hubp_create(
> @@ -2005,6 +2040,14 @@ static bool dcn351_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn351_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 pool->base.hubps[i] =3D dcn35_hubp_create(ctx, i);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> index af51ac4ea59e2..83fee2ca61bff 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> @@ -50,6 +50,7 @@
>  #include "dce/dce_hwseq.h"
>  #include "clk_mgr.h"
>  #include "dio/virtual/virtual_stream_encoder.h"
> +#include "dio/dcn10/dcn10_dio.h"
>  #include "dce110/dce110_resource.h"
>  #include "dml/display_mode_vba.h"
>  #include "dcn35/dcn35_dccg.h"
> @@ -651,6 +652,19 @@ static const struct dcn20_vmid_mask vmid_masks =3D {
>                 DCN20_VMID_MASK_SH_LIST(_MASK)
>  };
>
> +static struct dcn_dio_registers dio_regs;
> +
> +#define DIO_MASK_SH_LIST(mask_sh)\
> +               HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh=
)
> +
> +static const struct dcn_dio_shift dio_shift =3D {
> +               DIO_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dcn_dio_mask dio_mask =3D {
> +               DIO_MASK_SH_LIST(_MASK)
> +};
> +
>  static const struct resource_caps res_cap_dcn36 =3D {
>         .num_timing_generator =3D 4,
>         .num_opp =3D 4,
> @@ -960,6 +974,22 @@ static struct mpc *dcn35_mpc_create(
>         return &mpc30->base;
>  }
>
> +static struct dio *dcn36_dio_create(struct dc_context *ctx)
> +{
> +       struct dcn10_dio *dio10 =3D kzalloc_obj(struct dcn10_dio);
> +
> +       if (!dio10)
> +               return NULL;
> +
> +#undef REG_STRUCT
> +#define REG_STRUCT dio_regs
> +       DIO_REG_LIST_DCN10();
> +
> +       dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask)=
;
> +
> +       return &dio10->base;
> +}
> +
>  static struct hubbub *dcn35_hubbub_create(struct dc_context *ctx)
>  {
>         int i;
> @@ -1550,6 +1580,11 @@ static void dcn36_resource_destruct(struct dcn36_r=
esource_pool *pool)
>
>         if (pool->base.dccg !=3D NULL)
>                 dcn_dccg_destroy(&pool->base.dccg);
> +
> +       if (pool->base.dio !=3D NULL) {
> +               kfree(TO_DCN10_DIO(pool->base.dio));
> +               pool->base.dio =3D NULL;
> +       }
>  }
>
>  static struct hubp *dcn35_hubp_create(
> @@ -2012,6 +2047,14 @@ static bool dcn36_resource_construct(
>                 goto create_fail;
>         }
>
> +       /* DIO */
> +       pool->base.dio =3D dcn36_dio_create(ctx);
> +       if (pool->base.dio =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               dm_error("DC: failed to create dio!\n");
> +               goto create_fail;
> +       }
> +
>         /* HUBPs, DPPs, OPPs and TGs */
>         for (i =3D 0; i < pool->base.pipe_count; i++) {
>                 pool->base.hubps[i] =3D dcn35_hubp_create(ctx, i);
> --
> 2.53.0
>
