Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD529C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jun 2022 23:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3874510E168;
	Sun, 12 Jun 2022 23:54:26 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3760F10E168
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jun 2022 23:54:25 +0000 (UTC)
Received: by mail-yb1-xb29.google.com with SMTP id k2so7382561ybj.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jun 2022 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JioLri/XVUog/8EjMoRUKYPX8JJJUn5q2SaBCv4eOLA=;
 b=PBfX2ZeO7jyH1q+beDeLGu0FpvWyjZOaZp6wVBXcS6AGqZWyQJYklgrxH9fVav6O3y
 bWyJxfZGZqrv9iqyeN8RMX1r2cJmXz5umGfa7ylmQwMS4/tZL7+zhYAxyOZ9sUCMt5/+
 s0P1/1QV2FeW2xp+CT4eBxXmsa6xUw2asTKGzNjvz2bCW672xxBS3u/mWFbIZs0s0fW2
 XEyOcP05/OS3ZfMvZeNUea5bd4v81FvrcNSyxZ4jqHf/7Na0K4ZM+lsRXVXaCmCNW9aK
 Tt839q9qg5OxPoT7fm565SVSznQflOQoTM3MOqSVf6iS/50NXpRkX7VvKGB66gWgXlba
 myoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JioLri/XVUog/8EjMoRUKYPX8JJJUn5q2SaBCv4eOLA=;
 b=gLZSXrJ5qXJKMpA0ZCP0eggvphjdFpN9T/QnfL1mHbAIaE1PJB6BGDEevGZXay/F/L
 8v9gCp4eiiQnZgSvezYjVJOA2HwbMMvY09LqCGZhNjQPgxfajDhljfqD3+gaaIIYOslv
 2fS9LFg5pyIaU3bhBM6RiM0DG0Vr5OFm+0fAj4s1kf3qV3oW20rNP/3qSaGrYyPiG/CD
 tDKkDmnwXxzDLstAxcIDBEmWiGTnr/EFCihWCeOtU+e9EN5qQHhRpPYEKcNzmWUaYahS
 GrXhewJYUMsHVQURyqFBVuB77Bg5Qv103VN1/0jQRbGENRC0AM5LPWUaQTXXJICt+gGv
 B3JA==
X-Gm-Message-State: AOAM531p8SqP0P4HjYVab7Jv/P9WCTKYMEnunOaCa/Hx9iwnPFWHRCn7
 HqDAqNpBl+oHB6IFZhj657NefnKnAPpzeySQTPDQ5A==
X-Google-Smtp-Source: ABdhPJyn59DvqlwMAh3ueNnsB9TplgY404cfcbNJ+fIRc6rfb86lx22jedNdOVII25tlWOeCUDsfKwYVh8rY7Mq/2nQ=
X-Received: by 2002:a25:d044:0:b0:65c:b987:d884 with SMTP id
 h65-20020a25d044000000b0065cb987d884mr57586225ybg.399.1655078064237; Sun, 12
 Jun 2022 16:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220609142725.28973-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220609142725.28973-1-aurabindo.pillai@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 13 Jun 2022 01:54:38 +0200
Message-ID: <CAP+8YyE1reTB-G=Wkkx2v=eTJUuUCbpAgmEc2Y5ePJLVXYkZKA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: ignore modifiers when checking for
 format support
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>, "Siqueira,
 Rodrigo" <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, ken.qiao@amd.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 9, 2022 at 4:27 PM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> [Why&How]
> There are cases where swizzle modes are set but modifiers arent. For
> such a userspace, we need not check modifiers while checking
> compatibilty in the drm hook for checking plane format.
>
> Ignore checking modifiers but check the DCN generation for the
> supported swizzle mode.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++--
>  1 file changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2023baf41b7e..1322df491736 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4938,6 +4938,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>  {
>         struct amdgpu_device *adev = drm_to_adev(plane->dev);
>         const struct drm_format_info *info = drm_format_info(format);
> +       struct hw_asic_id asic_id = adev->dm.dc->ctx->asic_id;
>         int i;
>
>         enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
> @@ -4955,13 +4956,53 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>                 return true;
>         }
>
> -       /* Check that the modifier is on the list of the plane's supported modifiers. */
> -       for (i = 0; i < plane->modifier_count; i++) {
> -               if (modifier == plane->modifiers[i])
> +       /* check if swizzle mode is supported by this version of DCN */
> +       switch (asic_id.chip_family) {
> +               case FAMILY_SI:
> +               case FAMILY_CI:
> +               case FAMILY_KV:
> +               case FAMILY_CZ:
> +               case FAMILY_VI:
> +                       /* AI and earlier asics does not have modifier support */
> +                       return false;
> +                       break;
> +               case FAMILY_AI:
> +               case FAMILY_RV:
> +               case FAMILY_NV:
> +               case FAMILY_VGH:
> +               case FAMILY_YELLOW_CARP:
> +               case AMDGPU_FAMILY_GC_10_3_6:
> +               case AMDGPU_FAMILY_GC_10_3_7:
> +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
> +                                       return true;
> +                                       break;
> +                               default:
> +                                       return false;
> +                                       break;
> +                       }
> +                       break;
> +               case AMDGPU_FAMILY_GC_11_0_0:
> +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> +                               case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
> +                                       return true;
> +                                       break;
> +                               default:
> +                                       return false;
> +                                       break;
> +                       }
> +                       break;
> +               default:
> +                       ASSERT(0); /* Unknown asic */
>                         break;
>         }

This seems broken to me. AFAICT we always return in the switch so the
code after this that checks for valid DCC usage isn't executed.
Checking the list of modifiers is also essential to make sure other
stuff in the modifier is set properly.

If you have userspace that is not using modifiers that is giving you
issues, a better place to look might be
convert_tiling_flags_to_modifier in amdgpu_display.c

> -       if (i == plane->modifier_count)
> -               return false;
>
>         /*
>          * For D swizzle the canonical modifier depends on the bpp, so check
> --
> 2.36.1
>
