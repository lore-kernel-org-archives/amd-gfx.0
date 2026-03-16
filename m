Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04543F53D69
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 15:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964F710E27D;
	Mon, 16 Mar 2026 15:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DS5I3Hlb";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5EC10E27D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 15:40:45 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso340000eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 08:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773675644; cv=none;
 d=google.com; s=arc-20240605;
 b=OGSKdtCg3c+yFk8T2eBs0L4FKBeJlFmNEkBiwfT9z7dSNWAW3HBgjrY+p83j6AFhCp
 kyAn2RRZ3LDkeg4zwniPNto9NyO1zahkpHBWrHSK9Ml+X8NmA/wNywSmIYfK/CSeHqNb
 uGNpk5p7HEWN7C4rb9zGmxS7ZLEMaxrHH5DT+TioxwyUQsrSrcGIFLws+5h7xbSAr7vs
 tPk0jGSd3jUAD7qalFh00npf/ZEw+DEMkazqBrrM9wOnL6wj18M7w1Cv+uiuH0siPZUo
 IHqFI0HXKGi+yfPsy0/MdAtDom4coS+1WO4w8aH78YB9ICcxJbK1JlqYvl8tvgta4hcH
 j+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Th86OCrfoM7Qg+thEo2YLJ1Ly2fj9GSUGK0sj3CGks=;
 fh=henvRaYNNNePVa7PxIZjNlhVmlhJvZQ6EBPrmTEkVWY=;
 b=R/7VzureVlViYK8dajiNjOjrA1HXIq+IjReJ6Zkw+w8qXmE7oiS2o0skJEnuEBZdbl
 cc+Fd2fri31gq3Q71RJRxt8/YmD9QRiI2JenQgrv6P/Fftv0xTYm1k1DeMZSGivES4eh
 CB2o401B38dtYK+xhGyVdPhTR19NpTSLmC7bEXga2vXzB4UBohlUE6KusHe5chFccvm7
 r3b0Wk4Lcj5WK0nnfUJoo1nIQU0rxVGIjB2q2imAIb/Ocj7EMSLqcAvxHrhxTLBWImem
 ir31YXFqBpgfzFSz/hLGPStm+UN8ozgZv6borRa5ha16S1To5Qpj8IWV1CUkkvFM/vFl
 mbYQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773675644; x=1774280444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Th86OCrfoM7Qg+thEo2YLJ1Ly2fj9GSUGK0sj3CGks=;
 b=DS5I3HlbehEHgkc9DUjTvp3HIsIg9drbbb5UyzxxUkqRMVhfSnc4lqSN6PBEKPlwDb
 QoGsrSaJj+O7aAJYExw+L44LukDPEFNOGoNniHr3Jg56g7hBu2fW2ygim9c/Pf17Lgs+
 IrN1FIICSq7zOxSVwswgIAA6BWix5ueEfWh1ECz8i+4ZYNIMs0KWI6qWT0se1K2YkqCN
 1o/toTPv9E45upzzpWm3dKlZkrvx4X9uHmJKwP3RVOyjT5SCBRKm6GrroAmF++NrP9Jl
 XBdF4POBm8Jc40EwsS4qKAHADBxZYw5fhO1ZSWfXVyoVCK49RAu9kp0ftj9Y+Lj35lp6
 2JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773675644; x=1774280444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Th86OCrfoM7Qg+thEo2YLJ1Ly2fj9GSUGK0sj3CGks=;
 b=BR7/Nr670Yacc9FW2PezrZi/snrB27Ceb6iifMqGJxLfziAg28VsEyQkY+367rc8Tz
 Da50Af4kXrHxvx5n/D/hRbBvZhasKr9Dzx/T1Qj70LZZLynBq7UL+v0/RfIRUUVuoOZZ
 6alG1GilQ8DP0nUlUSSptSlTlJRQzC3EcZYIh3VLNPRB5qkHII22CADAlzuQYA5aoKZg
 bG0Y74ZoAReLvfNP8XrYqDdz2rMh5TzZuoxMcXDvdlHcP9z91Ee4NQLeEk/N8ouC+zMm
 z0OaT/Rm2+arFDHMfS2oaH8/rmnQXXfDV42yB1sPeIPmEAZ1xm/2SMCO8DlyHHEwQWrv
 LaBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuEwvosMAKZD0CwKgCrjlkyjCIRucRKvkYN5YQ7cPwUHvXBA9TWPxC+Q88UNbTWl0AeIkHCKX9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFHtexpBE82gsb7iUl9A5E4cFKjq6p6IMHe1yMa/MOXUmJth6U
 bSXSpMoHZYT5vbKnXzplgn/kHZznu1X6sq+nWLVi9CDXp8e2pz5T2lMtlI2RGwpBlspj2/NSNdV
 obxAHpz+un6LmhyEzvnOs1pBQWSmPqr6W8A==
X-Gm-Gg: ATEYQzz073mnWYx1a1s1XpPlUtBAncPZiBGlx4CCrSnMhS72NOV+xLYtD+4TEv4zjpr
 rsiXb9GZEkFRTkvYnviQXSv94cIYBrleVCguqI6r8hWuTRp6ljdBFl494XgyyESiJYmUZXtKeDJ
 pK76p3zGPPhz1YYWIv5qzp++Sms4xSyDOQTzGPOCQVcD8/nkCCg0l0KBSVfKME5Wpy5DVLNhj+A
 bfpC7bJ9I7wb/Vr2oVpEp3qQCm8BXI9ZQKbHCIaOwMbrOqeGeJPxiUHmQILWe2FfzwCdaCyQnIA
 TmkGBPeS36rXvwAAIl18cfoIe9L6RWCNprDc4yz2jzL4thMmg4iXAOGMGDH5TJS0o+RVE0uIZ4Q
 KHxBZ
X-Received: by 2002:a05:7023:88c:b0:128:d359:92bb with SMTP id
 a92af1059eb24-128f3cf6959mr2336731c88.1.1773675644026; Mon, 16 Mar 2026
 08:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260315165147.61189-1-theofficialflow1996@gmail.com>
In-Reply-To: <20260315165147.61189-1-theofficialflow1996@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 11:40:32 -0400
X-Gm-Features: AaiRm53E8tpIH9wP_O5X9HA46HodvoyxnIZyurQrHqn9mz2aTC_KxPh2Q6Aw3oQ
Message-ID: <CADnq5_M_0rMa9d2qqsU3Tkt=RjaCOi0iK=6qS6WRTdQCDw+PRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix dcn 2.01 check
To: Andy Nguyen <theofficialflow1996@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Mon, Mar 16, 2026 at 9:34=E2=80=AFAM Andy Nguyen
<theofficialflow1996@gmail.com> wrote:
>
> The ASICREV_IS_BEIGE_GOBY_P check always took precedence, because it incl=
udes all chip revisions upto NV_UNKNOWN.
>
> Fixes: 54b822b3eac3 ("drm/amd/display: Use dce_version instead of chip_id=
")
> Signed-off-by: Andy Nguyen <theofficialflow1996@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/g=
pu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 08d0e05a313e..d237d7b41dfd 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -255,6 +255,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context =
*ctx, struct pp_smu_funcs *p
>                         BREAK_TO_DEBUGGER();
>                         return NULL;
>                 }
> +               if (ctx->dce_version =3D=3D DCN_VERSION_2_01) {
> +                       dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dc=
cg);
> +                       return &clk_mgr->base;
> +               }
>                 if (ASICREV_IS_SIENNA_CICHLID_P(asic_id.hw_internal_rev))=
 {
>                         dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg=
);
>                         return &clk_mgr->base;
> @@ -267,10 +271,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context =
*ctx, struct pp_smu_funcs *p
>                         dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg=
);
>                         return &clk_mgr->base;
>                 }
> -               if (ctx->dce_version =3D=3D DCN_VERSION_2_01) {
> -                       dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dc=
cg);
> -                       return &clk_mgr->base;
> -               }
>                 dcn20_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
>                 return &clk_mgr->base;
>         }
> --
> 2.43.0
>
