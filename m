Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBDBC5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 15:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB6810E826;
	Mon, 17 Aug 2026 15:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IzTMZgmS";
	dkim-atps=neutral
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4079210E826
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 15:12:44 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5c2b6d3f2f6so129301e0c.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 08:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979563; cv=none;
 d=google.com; s=arc-20260327;
 b=QKQ1Xob6lOyzqb5x2+xRXlPbyHyvObJ6LirTJ8PDDut+uxkyrisoT7eAaXZ/whWVDW
 dblxsyVMWTzkmQrNSUvGputgdSZXYeUNECpP9RhuedKVQLZh3dNLXco6F86ymxgNEFrq
 1bF15f3PvP6xg1kze7DZC1Bc1efLHfEe3CDYDTQ8fl0PyRHN6MmqEtwh2b1lWj6APh2z
 A09iEGLlO30kJkuldcivnsJDn0WmEeqnhfi9ixwhRGWjbvZ9XIOkM2rztMcj6UOAtH6t
 YGBOrbH8HclFbdQskMoKUyEMax0/VxTMvGGAdGkOVwPBqT85b1H09FPjfsiKh5hFC+XL
 GJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vaf9Cx5bbS91iI9Sw9I5LhAq5i2BXevWkKrJ5KbO5u0=;
 fh=scc6gZ6Zc9EdtBBqKw1NEusO+BFBA2QhgDoT11kzMYg=;
 b=E16DB21q+hiu07Yans7vQWb+YjpOFMwwOoCQamPYfZ5h2cpqzy50PQNdL8v6eRTics
 sRIZWVnhbVFHTmkBujmZqc/KhUxbUb0XC8KX/H5nlhLfwB78BM978DVmbijbtyW2b6gO
 rC9mRc3QjysXAt/36PLUUf6eCTJQaEuUTHysX/lBM3q7mgyZ4OrGGdvbD0H4WE2WCSwN
 JQaX7uV1OSA3PgeE1SYHvNXPnIppvyQa30QrhkQY06OVEhIdoMNnvOv1h3HGf5WSV3yM
 wwUAhT2mmEzN32xV8wgsJt963j19Yg9AFmUFCSVWpTl8Xu8oqqxChEzbky1OtMhHVFY7
 D1mQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786979563; x=1787584363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vaf9Cx5bbS91iI9Sw9I5LhAq5i2BXevWkKrJ5KbO5u0=;
 b=IzTMZgmSpobJmjpwI427ErVDoEgXXQNl1DRNQfNdiB2SbTxMxZns3GyTnwj+xVjQGF
 N2kdSYDOVGtJf1tvPvgPPSzM+MXM2+XMP/mUft6e6f1KAFDYZR0V2K1VejFk1e/uWRfY
 qoA5eGj5c00MpoGJr1ZJrqWgvlh1Luqg7jMmCHS5THPPuXT14VmqxxTXwNV/0778fIlO
 EniICeW6mJGzm4tE1qVKFADLwEwuNLME4dVRXMepcc3s8T4yDJvWooQYZGidRY2eK0ZR
 IA3PXoYbZAQnAh/agp1ryuK24AQZAvY4112MRWKGS7Jg2i3bfQ4pzb2/XorwC/OZtMgN
 ZFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979563; x=1787584363;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vaf9Cx5bbS91iI9Sw9I5LhAq5i2BXevWkKrJ5KbO5u0=;
 b=EWU5Ogcv0qbHXahtrlQ/UPncKQzS+32vowXItN4g/NGQh02okzc5oOeUrmpre7imBM
 Pvct0XlWU1RwhVtRzyGft+0PbZY59tORUBd7XSvcSPMbawKslDR3C3p5DqdEpi/QKu9+
 WK4OD6uxcJ8hDdpCpSCS1Hjv1uioU00P9BxAUctJW3lQOKCFlXjr3cS7jc+KkyWjcXfu
 car0CN924jGdxXg8G2IDp+WmtTg7dZ87ZCbiQuF9ocfwvXc4q8kDCAeKEduoT8Q5rLKS
 EGnUfM3l36jO4m0LMk/T+2AoX0K/8RzyBCLDNu2bjZtCaymaUsgW3clySuMwiTV6+cKM
 VB+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6oSPPnr/4gdMneElDKIWiATUN/jnPZqyW679JESmrhyXtFIXKeVKfGuNgMWykwHCS58ksdV7/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxec/+aOxyulLS6UirYo+zIGag2/7fFI+Bzm37Y7gpq4Z+JJM0K
 GKZPqcZxcdPdzkKzgz2f0HQV9rIs65Rp/3B0GBJgv7ATf/uYmUuHz4wvMvxILyPjKLUwaBNbhzd
 XxwgXF2YaJL1goFfIj2OTRoxoIZINDSY=
X-Gm-Gg: AR+sD12Yj04DbW5BVgkqyQ/+EAayZeeVbOAguSFH55fuvqfptslctNQoIAYIrmeuiuh
 NlHbs3NNmr6JgWP/y9ieGkz99IZORrijKa1EcZya2H57Gh/alY9l8Wv6mPppKCPKtK6CVqMN4AH
 PRMmPF2p2nUVcA8eB37FDN33AYW2X/wbIxy2nd5N9pwgXg9lchYGcCdegDcm7QwhoZSqlvILdnH
 +eY1kUf2veMOJsVx9oq3Jl5R4c5JEGK8mXFvOyb6Xbp+NFVnkKRr4NL1pNt15QlBvsomDONRat3
 mxYOPfiWyrRrxHCVT8wlCiIDmi7kvzyQZDye9O4JAQ8Ex34KUthf0mFaWEjckrt0R5oMZYQRnAZ
 0rI5mZT7jxZwUPUSYhG5DLknBbJWeNvPT
X-Received: by 2002:a05:6102:c13:b0:738:8d0f:72a3 with SMTP id
 ada2fe7eead31-76f2d5762b4mr1616598137.4.1786979563020; Mon, 17 Aug 2026
 08:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260814171335.1099999-1-colin.i.king@gmail.com>
 <3ec52129-0629-46cb-a0d9-cc4dc68a502a@web.de>
In-Reply-To: <3ec52129-0629-46cb-a0d9-cc4dc68a502a@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 11:12:30 -0400
X-Gm-Features: AcwNN1VF2iMgMunOjlyCoDEKc8oOXYaVq-li5iG15rUf9zg_MtFAAXGEZuaCAzQ
Message-ID: <CADnq5_M+DcrDvy+1pvW0u6prJYQvG602-rNkni2Dj06fEpsE_g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake "optmization"
 -> "optimization"
To: Rolf Reintjes <rolf.reintjes@web.de>
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Austin Zheng <austin.zheng@amd.com>, 
 Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
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

Squashed in the additional "resul" fix and applied.  Thanks!

Alex

On Mon, Aug 17, 2026 at 3:20=E2=80=AFAM Rolf Reintjes <rolf.reintjes@web.de=
> wrote:
>
> Hello,
>
> Am 14.08.2026 um 19:13 schrieb Colin Ian King:
> > There is a spelling mistake in a DML_ASSERT_MSG message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >   .../drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c | 2 +=
-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/d=
ml2_top_utm.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dm=
l2_top_utm.c
> > index ab9cadaf5a60..79ec5838c26f 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top=
_utm.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top=
_utm.c
> > @@ -123,7 +123,7 @@ static enum dml2_status dml2_top_perform_stage_opti=
mization(struct dml2_instance
> >       DML_ASSERT_MSG(worksheet->validation_result.is_mode_support_valid
> >                       && worksheet->validation_result.is_mcache_allocat=
ion_valid
> >                       && worksheet->validation_result.is_prefetch_valid=
,
> > -                     "worksheet must be valid on exit independent from=
 optmization resul!\n");
> > +                     "worksheet must be valid on exit independent from=
 optimization resul!\n");
>
> There is another spelling mistake here: "resul" should be "result".
>
> >   //  DML_ASSERT_MSG(iteration <=3D MAX_OPTIMIZATION_ITERATIONS,
> >   //                  "exceeds max optimization iterations!\n"
> >   //                  "\t is_permissible_found =3D %s\n"
>
