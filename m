Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE7ACD37AC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 17:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964F310E3CA;
	Thu, 14 May 2026 17:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mRS9SRmt";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60EB10E3F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 17:18:41 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1324053d600so735846c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 10:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778779121; cv=none;
 d=google.com; s=arc-20240605;
 b=fMH+ghtbcEwjl6y92Ht4V+UyETN1OV4Za6jzxM+MFUv45CtII69qqndS4QcSW2ZnSJ
 pT18MEg1Yy5XWjuWssfWCcnmazzVMd5glgjBQiW21dgHXmI4kywU51dwolnKVQBpW1t7
 Rtu7E0KhIW9i49/Ey5Dbmlr51LUKLQcZHRxQ6g3HTIat/GwXFQUfm2miTP+mC8EHimJn
 VVdu41thdSzD25Hs1+fe+hk5dwrWdhTaKGV63gSpq8yqZw21Ozl3zBQVbYbK1qGAfINn
 WFS0Cq8wMAVUSDvJLb0e4LHJh3lDecY1l26SgKgplb9nFYYNsGq3x6e0a/YlKP8LUjVk
 7Hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OxVk6hGMMZsR+ZvGqV0YSd/BG9IOGehgAbv48evDv4Y=;
 fh=vUQOT68070RVRpbPLobGxOCjS8Cyc0jvG7qfN/LLCn0=;
 b=Xx/YlM/WQTIlCGgLBxh4Jit9Z6GK6s0pYT0ScHPgTxl9JA+tip/yHl5McUFRVY3BX8
 rcUxDOU9UwaBlIco43R+eNU0IdNt1uuc/0L9aSItGrG+EgXCHzwtTgcUOlXXOytrP5X2
 YKZBQTKZL2g+OGDbWGUVIKe+ltxXdAPIouaRYa1IJn2nggCV6awUiogD2DJjcBoqmGk+
 4Qy3jzhMmOmqDedyA6q+mA6ypYUtP0YaUV5NTxTAEd0PcNyHnX7sHJOun1uIv25WJVHK
 RMR+y2f9i5kZVfcSu+Bz25zoLFkzarvFOtCj4oEuVH85YubpNvRc+O+y3Y1/KJG8nKpI
 d9+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778779121; x=1779383921; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxVk6hGMMZsR+ZvGqV0YSd/BG9IOGehgAbv48evDv4Y=;
 b=mRS9SRmtr1T96pIXjUMyTV4LkOhUumyuLclDLyhA2pDMYmOUOMxzKyRVmW2SnGA/+B
 XZh50+hiB79ZWIw1E1xeRr7MIE/pCQHyw/xCO324ra7Ffcgq/w4G6dAVZZW7n8e/XBD1
 nnCtBIjdTYtQc35aCGdyChZzd2QPUM4nYas6KsXbTP1kcsR04qaONc2ONwj0W3JhK+m/
 VqoGB2mDqIDrrx9nyMU9eiVPI9M6thXvb5RlXbHwzDy0Rk0hLZk4vy6c/csfwu4MRIbK
 ypWmpQR93RRK7Qwa8LD+EvcTsfng03WfbGeVo5SRq8lokOG2K1YHfgibA4hxP28k+CFO
 tsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779121; x=1779383921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OxVk6hGMMZsR+ZvGqV0YSd/BG9IOGehgAbv48evDv4Y=;
 b=T+mqjseuC9kpmiLKI2aNpqOF1gynyG8x17s481gRkRmoXfLb5D6W0cHE4ugYhLodRy
 8vMmWw4zxAhquX5HPnuiDr9tQmTZdfFqTFthTgxxXgLWvq9BiDzOxy3mHqmc8yxIZbZf
 MFpKK8040xS+g5iFyNzeq0KGDUPbMOvyaMqZ3y+ig0DfE/r4RPicygrQnNidpLWHA8hL
 qNmGwdw4CEW5Xice5B45fJqnZ2AIWcI4TK+HDgoq50YhBzUIp0Xf2ZSSgYHJYRSbpYVr
 51+yolgw7wfK/QbU8wmvTGpXxMGb3g2gCEOor9nwib3Xa7RXdBOsSF6ve2fnb0FgpMXg
 qzGA==
X-Gm-Message-State: AOJu0Yz/J4TfWIs2uF6RNHzKX1hKrhcf0OOXaCtwotiYKM1UOucJl6Rd
 ZN6nvktgJDGLtxeQ6SVKZAMDj+ulI/wXFKOX+CadfbFXlK+4cI5fRIWALanZLfySZD6WrhzaiEQ
 QeLgFnhzS2ddQ/2eNwTwU6KxveIhPpx0=
X-Gm-Gg: Acq92OH6ASo2z8HYL1rweeWXgu9hO3k4dOkPC8WiDsPBKSPkgUYrvM+rzJv7hwRGx7a
 eL4jtHjsbOZd660ktJAfFm+oJJClxNezNa84vksim4p/WbfFElDnlTV38z1DOUIqsMUo1z7SBhT
 jeHPLj5PR6rSxh/MSgVejKEJ5FXjoDr08i//3PCyeHrtcFvJstmZels0HZbuSeFi1/42FEoDb6c
 hCOKT5lLyDVe9HO2GeNfkffSDJDSw9txFdaNXhP3u41unPKNXOLwh1lU3IdB4vo9fAxnBYpb39O
 ohcF6CBNoUekmbby08M6zCP8O7w2KLklHRI10xv2rKnXGrwZLSTmdAtJwA7TblIHUlxOYQ==
X-Received: by 2002:a05:7022:6620:b0:134:cf44:5fa9 with SMTP id
 a92af1059eb24-13503fe876fmr17189c88.0.1778779121005; Thu, 14 May 2026
 10:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260514155348.2114429-3-IVAN.LIPSKI@amd.com>
In-Reply-To: <20260514155348.2114429-3-IVAN.LIPSKI@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 May 2026 13:18:29 -0400
X-Gm-Features: AVHnY4LtKe_U5__tBpHCLeWn4yQix1_JYsyvMgkSEr9l0iMC82P7_3LAs4Br--Y
Message-ID: <CADnq5_PDFT1+8G_yAVBa0nGpBgbs=npszsW_G2n85f+zh33_zg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Write REFCLK to 48MHz on DCN21
To: IVAN.LIPSKI@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 mario.limonciello@amd.com, 
 Alex Deucher <alexander.deucher@amd.com>, Max Chernoff <git@maxchernoff.ca>
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

On Thu, May 14, 2026 at 12:04=E2=80=AFPM <IVAN.LIPSKI@amd.com> wrote:
>
> From: Ivan Lipski <ivan.lipski@amd.com>
>
> [Why&How]
> dccg21_init() calls dccg2_init() which hardcodes 100MHz refclk values
> for MICROSECOND_TIME_BASE_DIV and MILLISECOND_TIME_BASE_DIV. DCN21
> uses 48MHz refclk, so the wrong values corrupt DCCG timing and cause eDP
> link training failure on cold boot.
>
> Write the correct 48MHz values directly instead of calling dccg2_init().
>
> Fixes: b7dfeea1e168 ("drm/amd/display: Add missing DCCG register entries =
for DCN20-DCN316")
>
> v2:
> Fixed typo
>
> Reported-by: Max Chernoff <git@maxchernoff.ca>
> Tested-by: Max Chernoff <git@maxchernoff.ca>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

For a future patch, it would be a nice clean up to read the ref clock
from the driver and program the clock as needed rather than requiring
a separate callback for each chip and using a hardcoded programming
sequence.

Alex

> ---
>  .../drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c    | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c b/dri=
vers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
> index bdc3ce5d4f47..be167bbd42b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
> +++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
> @@ -105,15 +105,26 @@ static void dccg21_update_dpp_dto(struct dccg *dccg=
, int dpp_inst, int req_dppcl
>   * dccg2_init() unconditionally overwrites MICROSECOND_TIME_BASE_DIV to
>   * 0x00120264, destroying the marker before it can be read.
>   *
> - * Guard the call: if the S0i3 marker is present, skip dccg2_init() so t=
he
> + * Guard the call: if the S0i3 marker is present, skip init so the
>   * WA can function correctly. bios_golden_init() will handle init in tha=
t case.
> + *
> + * DCN21 uses 48MHz refclk, not 100MHz, so we must explicitly set the co=
rrect
> + * values (48MHz is taken from rn_clk_mgr_construct()).
>   */
>  static void dccg21_init(struct dccg *dccg)
>  {
> +       struct dcn_dccg *dccg_dcn =3D TO_DCN_DCCG(dccg);
> +
>         if (dccg2_is_s0i3_golden_init_wa_done(dccg))
>                 return;
>
> -       dccg2_init(dccg);
> +       /* 48MHz refclk from rn_clk_mgr_construct() */
> +       REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x00120230);
> +       REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x0010bb80);
> +       REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0x0e01003c);
> +
> +       if (REG(REFCLK_CNTL))
> +               REG_WRITE(REFCLK_CNTL, 0);
>  }
>
>  static const struct dccg_funcs dccg21_funcs =3D {
> --
> 2.43.0
>
