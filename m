Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616C3C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 18:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008F710E182;
	Mon, 28 Jul 2025 18:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lu+n0HpF";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9248010E182
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 18:18:18 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b34dde96cbfso280256a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753726698; x=1754331498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y8+w2H5og2+5lA0zmiOh5NnxwHWsl/j3gMfSY0uTmU=;
 b=Lu+n0HpFSQInQsyr5BSMkbuGoJ4bhoh719yv/sJ8Z3TT+W4myzLnhmV9vCvljsFji5
 OuHauv8s3KeePEly8yrwRhWmnJdeeuaxsAMDqjCFXI6gs81+l6z3vMT2oK6T3Majo+Hy
 l6KfUxC9VNZkWCBYBFiOPysZ1j9JAgcO/HyTOvL2w538dD2WIi6Gs1ojssTrVTx2N5Nv
 Nd5IMz/UVzOV0DGrOLzZaVBxu75vzcf3i/rh7E2r9p8cegOAI9eD49BLv4voyHjWpcsd
 ed4rExvlLNtqJwu2PiKetTKIVg40aTe2cWJilcozTF90tBjYGzWBneRA+vGz/OIqixub
 3RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726698; x=1754331498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5y8+w2H5og2+5lA0zmiOh5NnxwHWsl/j3gMfSY0uTmU=;
 b=wRhe/xfCueXsp5HCnRJEtya84fKf+trCA7cQYvPPLfnY+qOaNK1U6q+6B+XZCI68tD
 SMUYWqSJoBVux6WkFmYCwlb8JPphpFXVSdaZd3BXUUW0aAd+3LbDY217TMAg6hSuj1el
 keuo2nC1t9nk6QLPbEWf1f5ThhE0JadYw7t4U8QgUvD6/aWinOyMtl+9AmS1rVK77kMn
 WvCdTGit4fdQ2i0adTh3gLcB0ZFP4Rve/IGqPii8xCHqq6Eu7qMfUekeJNjk8OSCAI7o
 wYmjckZPVx/hCKv9DnNEqaxQCuLKGIFyML/z2zAo6QGiPRGjPCGbnMqj1uNGgSRuqYhE
 bcEw==
X-Gm-Message-State: AOJu0Yx7CddcXHFzt/SillNUQVNJCKwM9YxfP8/ujah8kN97l243Wqew
 +Yi9jvxPbegxmBHxyEHxaGmjo6WbEl154yIXMqjv7VJt2dL6SuQTmhMZKicqSWLVnsne6gH1FgN
 IJJSpyeX3sJ9LaCCCOMxYX1+fHUNJZKQ=
X-Gm-Gg: ASbGnctc48WAJ8FSY7BEeUVfP8I1jdO2XO5vgcOg22TXuH0uzDEEDhb4nWO+Yb/fOKs
 qtE3vJGxPGhpzxub6Ms39Cxc59RbEJnmU489cp2gG7QmcZRTHtLfQm4LFVRNKlM1SYMw8wtioph
 xipGmJ+sDVA4LjrTZyvOEVRwaE8GW1zQdCn5lSLvF7KNxxjazQYXkDDpxLv2Zb07CIkXEMdyEyZ
 xbidPfx
X-Google-Smtp-Source: AGHT+IEbK0gFho4mpR0sQHzXK/KKy4t38K2ebTXVH+WSfVM8hDFBYcFdSCFS+jzWRlhNPMABYwC3CGb0Wg5OhECFEN0=
X-Received: by 2002:a17:90b:5206:b0:31e:a421:4dda with SMTP id
 98e67ed59e1d1-31ea421547fmr4985673a91.6.1753726697936; Mon, 28 Jul 2025
 11:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250722155830.67401-1-timur.kristof@gmail.com>
 <20250722155830.67401-3-timur.kristof@gmail.com>
In-Reply-To: <20250722155830.67401-3-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 14:18:06 -0400
X-Gm-Features: Ac12FXzGDVg8C7bGwmkBHMePBWlennsvZylO64uE4TQL-8uCQ8rVCcXcuuxliy8
Message-ID: <CADnq5_MnFYaymx1+23cmQo5WVkKUeBPCnv7dYp_gYDaGRS8Zaw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/display: Don't overwrite dce60_clk_mgr
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

On Tue, Jul 22, 2025 at 11:58=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> dc_clk_mgr_create accidentally overwrites the dce60_clk_mgr
> with the dce_clk_mgr, causing incorrect behaviour on DCE6.
> Fix it by removing the extra dce_clk_mgr_construct.
>
> Fixes: 62eab49faae7 ("drm/amd/display: hide VGH asic specific structs")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/g=
pu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 33b9d36619ff..4071851f9e86 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -158,7 +158,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *=
ctx, struct pp_smu_funcs *p
>                         return NULL;
>                 }
>                 dce60_clk_mgr_construct(ctx, clk_mgr);
> -               dce_clk_mgr_construct(ctx, clk_mgr);
>                 return &clk_mgr->base;
>         }
>  #endif
> --
> 2.50.1
>
