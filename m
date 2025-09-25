Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE10CAC5B5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 21:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F75F10E1E7;
	Thu, 25 Sep 2025 21:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="avsi9B5J";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E5CC10E1E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 21:28:44 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-267fa729a63so2113585ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 14:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758835724; x=1759440524; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dG830pdNECrG8cAmnu6odqsvgM9w7/yehEmT9tLxri4=;
 b=avsi9B5JcYyWpDxJcC29oB1H91aL0LXkz0ZT6JvI8RqbVQl1/xLxN3uv+0hoTVFRY3
 Laxb5msyKVIilEXyI1eodvg/OZqqikMoyTBnXfwsYHZ9MJS+oa6wRSj6mJ5t490+FmNL
 Ymv14oZ2wnqBdL3XLHkJekn7ERo0IlduJ4JpGlNaWeZrJ9H5q6/b57bDLXxcnAFAiGx7
 fSHEmz3xVbwkR4huWAuBEp+kLlVq63dheYfovk2nIBtMYzRMc16FnNvjEKK/3FnPnsCL
 /IXUMbbHm5lDfSq5Kifok0nuLKVMlHgBmbOE8qrfBmQ7AkY77W34mwKPAZZue4vmK+Pu
 h2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758835724; x=1759440524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dG830pdNECrG8cAmnu6odqsvgM9w7/yehEmT9tLxri4=;
 b=Q2P3ktW9kBnjLWHdX9AIug0zRMtCiHaW5AkF4YLg5ShyEnIz+IZ+K8HKFgOymKHEOv
 f7oMgUA8z2vJgdNEC0NaBZGS1ZLUPYpSiuzBy0ZOhmoxweHNDUV4lRMax8y4aj1jazIP
 zYxnpxJYeG4mZxm02/GPD5PgRSta+sfhRZ6sx0upKJhuNc4RVB7+vj3PGyWyD3F9yFox
 kZz7a/TOc0V6g6YAB4GrtkSpu0kJdUpTSTxqlUjFtFxrxbm2MhfPOdaGtem/Poq2DxlL
 wPDMhdj3yMe1AOromDzQmKPgoeKdhIzkkrB6oImH0DxqYq4jsAQdSZxs8OFY82zmoJXl
 3V/w==
X-Gm-Message-State: AOJu0YwK/JkUCfcXZiAk56nufZOyg+s22nxkM21tK9WzSlO9NnsiQbUz
 bvMwgmbf7ympR9Omxt/TDmMXUZ15ulzeS1NqfcOb1WsZV9I5VmNkAxRMu3yxVXhlyX/j6Dy8Ja8
 JCoE8asedbUO1d841yXxGqak7H3QKqxDArw==
X-Gm-Gg: ASbGncuZVvqo1F+n8/0ixbrZwg0Uo5uOYQD7KSRPxDCiBPlIE5BR0xvqnfDbGRU+7cO
 2EklRZic+BEm1eoeiSpcWqkKC5m9bDF2vId336bLMwx6InFuDq7PNv9vmXmVNFEpbAvfkT2ytc2
 PRLRl+2GteXPV/wV1q/InYGkUmzWLZop3D3J1Qnibcs4NeejM03I0OdaEf/61Wg+di/1IlrZonQ
 4G6nHg=
X-Google-Smtp-Source: AGHT+IGWWW9vPUO8pZB4qA1Gd7MuVsg/e/al4Aw5VhopZdGSC4J0XMt1KmiPyZnlKCDTjISjdO0wFQ0wKDbUIEhwK3E=
X-Received: by 2002:a17:902:d508:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-27ed5b0a538mr27863465ad.0.1758835723977; Thu, 25 Sep 2025
 14:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250925184525.43290-1-timur.kristof@gmail.com>
 <20250925184525.43290-3-timur.kristof@gmail.com>
In-Reply-To: <20250925184525.43290-3-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Sep 2025 17:28:32 -0400
X-Gm-Features: AS18NWD8qnVmURobnvULZ3SklcicgT4bn76tXkiVIdPFTQ0gFzfLOA84k05KZVs
Message-ID: <CADnq5_Pq2Tm4qW56QrY7DTr0_8h40gn3SdNeMyz=zqj8=D4UNw@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amd/display: Add missing DCE6
 SCL_HORZ_FILTER_INIT* SRIs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 alex.hung@amd.com, harry.wentland@amd.com, siqueira@igalia.com
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

On Thu, Sep 25, 2025 at 2:45=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Without these, it's impossible to program these registers.
>
> Fixes: 102b2f587ac8 ("drm/amd/display: dce_transform: DCE6 Scaling Horizo=
ntal Filter Init (v2)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

I think it would make sense to just squash patches 2-4 together.
Other than that, these look good to me.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_transform.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers=
/gpu/drm/amd/display/dc/dce/dce_transform.h
> index cbce194ec7b8..ff746fba850b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> @@ -155,6 +155,8 @@
>         SRI(SCL_COEF_RAM_TAP_DATA, SCL, id), \
>         SRI(VIEWPORT_START, SCL, id), \
>         SRI(VIEWPORT_SIZE, SCL, id), \
> +       SRI(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL, id), \
> +       SRI(SCL_HORZ_FILTER_INIT_CHROMA, SCL, id), \
>         SRI(SCL_HORZ_FILTER_SCALE_RATIO, SCL, id), \
>         SRI(SCL_VERT_FILTER_SCALE_RATIO, SCL, id), \
>         SRI(SCL_VERT_FILTER_INIT, SCL, id), \
> --
> 2.51.0
>
