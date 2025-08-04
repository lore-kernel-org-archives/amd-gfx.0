Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7991C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF3810E5AA;
	Mon,  4 Aug 2025 15:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WM30qCyT";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71E410E59D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:54:36 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-31f3f978cd1so757966a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754322876; x=1754927676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKqQpgir4fGHKbOOz0eB5j2uX2NomFIQcP9zeNRv5Q0=;
 b=WM30qCyToTrZaQ92bCKqo/g7XpLsRKP8FgTnsuiHCnLQ6/Jo7QwuuyZQOdwfoNrRP0
 fsKN9F1NJItvf86f4jWaWjLbI8P+q8eYwA8nPqJrmE2I8QD935mDI4NDDkT3eSkktEDs
 5v0AgFiOR2LaXl+Bmb1EnE9mfLuJLz/2aFh2BYTo2hRhz5ZwWo2cdehqOVHtqr1GknJS
 ymhmk8f98Zn27sNQ3vGCCBGHFtmWKknIsRgxcQWoKnN0j8fTzHZQX8TS5AM+Rs2h2rhZ
 pDoSosH2xU7U44KVrE5rM+8N/5FwktUmzuke/In0Ehv9kC+L0OaodzaadxCQDvQzr7N/
 BfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754322876; x=1754927676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKqQpgir4fGHKbOOz0eB5j2uX2NomFIQcP9zeNRv5Q0=;
 b=fTKe0SJVImXjQVOUqVJVtLpaNMwxpCBBYGGMMPhbIecucs4+2Wtc0pqWsrDGkuuicM
 QNdqptTWNQf+uhpDvfy5U+IwzBiEFgifRiTA4ji7En6wat2HNPbih9kiTaio6tWagMIj
 5C9Ays0uOTrhF18t345Cho7OufFHQkbP7v1aQOArt2e14cT85LhRiOuAZUGjWkVmMKm4
 Pt/JSfQFR30oSIPgwHBwIFECJSeP2AVTTW8xje0UzjeixbobuH+oxhlpdv/Vc1M3qIUY
 fMOZj8aVGNt7dPz0KyH1Wa6p/xWKIAlWEPcp8bR3PW0grBjrI9BvRIrRKqoDtlCrfSFT
 /ZpQ==
X-Gm-Message-State: AOJu0YwJOHG2FNXuhVWZltN+DyoMcYWXr8aIdPB0ql52TWlPgQQuqWZR
 zFizXjNqRU+wolS4JSmVsa0vNiYwcn+fxK/reEpGsARs9SAkZT2Ofmh2Nz5uLY+dv+ak3HA7ivv
 mHOX5IJc6AwYihPnvvkkimbqcQgSJ2mWeiA==
X-Gm-Gg: ASbGncsxzO+058XK2qS+GNk0lZ+lbmPwopHOs9HfLgvmF4un7O4cExX2aFF66YxKEi6
 yI2NpCQXeE38OMao0ZjjbKWdT9fpWBuIMz/0pNqdTLknhAgWLD9IK3zQJA/4dU8IMx/d/ZRpGCc
 v8b0BkDknvt5vNfcV9AdyP9R7iqd+VNMuDgcCEwHHQrmCnQ3mtvo9o6eQWT9O7CHhBFV26sRpMY
 GrxPxGF
X-Google-Smtp-Source: AGHT+IHRXeHbQpRPA9RMxTetKBWxkZyOfmXxVR3UCPIsHnLEjg1A6yhhPjwIf3O1XCyJCXD1hBnw2TVhLpO+wU4JPUk=
X-Received: by 2002:a17:90b:1d05:b0:31f:3d6:6d98 with SMTP id
 98e67ed59e1d1-321162cd943mr6458594a91.5.1754322876261; Mon, 04 Aug 2025
 08:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-2-timur.kristof@gmail.com>
In-Reply-To: <20250731094352.29528-2-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:54:22 -0400
X-Gm-Features: Ac12FXyUR98DtlSKxCaFpTuJNBieR4Pxp658ZlTXRuY--LZbUCNoiVCwROPMxpE
Message-ID: <CADnq5_NspvHDi2vdwNgJoUQD5m8sHbYoJR8SfakqOVOxBO5GhA@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amd/display: Don't overclock DCE 6 by 15%
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Thu, Jul 31, 2025 at 5:44=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> The extra 15% clock was added as a workaround for a Polaris issue
> which uses DCE 11, and should not have been used on DCE 6 which
> is already hardcoded to the highest possible display clock.
> Unfortunately, the extra 15% was mistakenly copied and kept
> even on code paths which don't affect Polaris.
>
> This commit fixes that and also adds a check to make sure
> not to exceed the maximum DCE 6 display clock.
>
> Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
> Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
> Fixes: 3ecb3b794e2c ("drm/amd/display: dc/clk_mgr: add support for SI par=
ts (v2)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c=
 b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> index 0267644717b2..cfd7309f2c6a 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> @@ -123,11 +123,9 @@ static void dce60_update_clocks(struct clk_mgr *clk_=
mgr_base,
>  {
>         struct clk_mgr_internal *clk_mgr_dce =3D TO_CLK_MGR_INTERNAL(clk_=
mgr_base);
>         struct dm_pp_power_level_change_request level_change_req;
> -       int patched_disp_clk =3D context->bw_ctx.bw.dce.dispclk_khz;
> -
> -       /*TODO: W/A for dal3 linux, investigate why this works */
> -       if (!clk_mgr_dce->dfs_bypass_active)
> -               patched_disp_clk =3D patched_disp_clk * 115 / 100;
> +       const int max_disp_clk =3D
> +               clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORM=
ANCE].display_clk_khz;
> +       int patched_disp_clk =3D MIN(max_disp_clk, context->bw_ctx.bw.dce=
.dispclk_khz);
>
>         level_change_req.power_level =3D dce_get_required_clocks_state(cl=
k_mgr_base, context);
>         /* get max clock state from PPLIB */
> --
> 2.50.1
>
