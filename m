Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93C4C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 15:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD3F10E4C3;
	Tue, 29 Apr 2025 15:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CDJGxset";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C11310E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 15:04:25 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-227c7e4d5feso11845885ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745939065; x=1746543865; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yj7OpkCavTC+Fvw0TBcruibytd6TOhMII3aPSDZGlVA=;
 b=CDJGxsetgLYbHtkMhKabcCLGJxK+2+yXNJoXZPhMq4XvO5RWYCbN8bC+4YH6ch/Wuh
 dmHWPc/Blaiiur0sqFgQWU+iv8Y7fmmabEPY2WBSCq+94kx1KO31Bm8GB12zInKOGZaY
 w7eoz9ttUuwn8h8Klu3LY8RyLxd6m24kDhILBYB7CV45i0EQwyHG2/rw5IzdDs71y72f
 MzWzcSMrqMxdjETSofGiTq0ovdyVoX5p6LYoU/g6JemwfUgOhTiLUL3E6Erfn8iGaGmK
 B9OWMrrBYXb37fD6Ri2ddvOFmpkp1718eQz+WeAbpNMDiDS3MnCCjVc4GfSGizAVcTbb
 z/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745939065; x=1746543865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yj7OpkCavTC+Fvw0TBcruibytd6TOhMII3aPSDZGlVA=;
 b=OJkS3J5LuNe0uq8/39DS5skIFuwsXZ68BQuM0jlVy57sIy0F8Bfu1VwvY4daX/4mKT
 N6mNcAN1/Pf4rKOOTsIxFmsxy7Rnt+VgX21WtkZqcn+up36EvYnPg/rnmSKNH87AIeX/
 8+kuS7sQU6DVSatEvTs0MMOUq6nf9PgkgkEkYmFGwdth593mY3Nt0E/5oLmtTxqEAj2N
 lE2hlfKUWZbmszagewXrpra/ymleQleDTz4Iz1IyNgJAH2mwXdMVrMr44oTiU8ZQU8Ij
 ZqiajLJ5veEWauhxSPaQHtmp/kb0PkBoCjlKf0n3MxiZxXO/WFPW8XkHpXza64t0gKhz
 hkuw==
X-Gm-Message-State: AOJu0YwQ8NNASW8BCFvpxiYMI70BMSc6hp8RAlQuh46Z1zFQUdpqmHaJ
 anro0OSOuxVD89+NHfahHO/MSmAdLkpzA5e2dYhloyDdPAG+XkiamDxZ4VtKTHKH8UNcH75eXLD
 KJoAVHBRlfGhapkSblR+2rEt4fTA=
X-Gm-Gg: ASbGnctO3MagDGZ3Mo9wuM5V4bsZKD0hzIzLx5ODiaA6F8FIK0hEXOJLi8TkkRQh/r9
 /LFgcK4YcW4dMxAtUi4rZc9CBiMlB+X1sEvqvIGGU7u0OW6lyTpAxMtWrsH/dfW/zD7/IePbv8V
 twYNbfQzTastRvC22yCZ0337RxQu5GOZks
X-Google-Smtp-Source: AGHT+IEGwBQcgGM1A0OarT0irBDYCgN2U0ax96pByBpCKUShyNnznJe/Tl16FXmdeOedWUxXHB5Gax7gC4ePL66w0m4=
X-Received: by 2002:a17:903:2305:b0:224:10a2:cad1 with SMTP id
 d9443c01a7336-22dbf63d296mr92568845ad.10.1745939064203; Tue, 29 Apr 2025
 08:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250428135514.20775-1-ray.wu@amd.com>
 <20250428135514.20775-19-ray.wu@amd.com>
In-Reply-To: <20250428135514.20775-19-ray.wu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 11:04:12 -0400
X-Gm-Features: ATxdqUHxUWXGiGRtSgQPyu43mk12LzFKn9zMjqad4iGWKr3l5oGmFxQRgY3la-g
Message-ID: <CADnq5_NV3D1txYenNsit-3H6uqJDJ+rgOSHPbOtta24HmXqD+g@mail.gmail.com>
Subject: Re: [PATCH 18/28] drm/amd/display: Remove unnecessary
 DC_FP_START/DC_FP_END
To: Ray Wu <ray.wu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, 
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
 Zaeem Mohamed <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Hung <alex.hung@amd.com>
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

On Mon, Apr 28, 2025 at 9:57=E2=80=AFAM Ray Wu <ray.wu@amd.com> wrote:
>
> From: Alex Hung <alex.hung@amd.com>
>
> [WHY & HOW]
> Remove the unnecessary DC_FP_START/DC_FP_END pair to reduce time in
> preempt_disable. It also fixes "BUG: sleeping function called from
> invalid context" error messages because of calling kzalloc with
> GFP_KERNEL which can sleep.

Is this safe?  If this function uses FP or calls a function which uses
FP, removing these will lead to register corruption.

Alex

>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Ray Wu <ray.wu@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 2a59cc61ed8c..944650cb13de 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2114,8 +2114,6 @@ static bool dcn32_resource_construct(
>  #define REG_STRUCT dccg_regs
>         dccg_regs_init();
>
> -       DC_FP_START();
> -
>         ctx->dc_bios->regs =3D &bios_regs;
>
>         pool->base.res_cap =3D &res_cap_dcn32;
> @@ -2501,14 +2499,10 @@ static bool dcn32_resource_construct(
>         if (ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev) && (dc=
->config.sdpif_request_limit_words_per_umc =3D=3D 0))
>                 dc->config.sdpif_request_limit_words_per_umc =3D 16;
>
> -       DC_FP_END();
> -
>         return true;
>
>  create_fail:
>
> -       DC_FP_END();
> -
>         dcn32_resource_destruct(pool);
>
>         return false;
> --
> 2.43.0
>
