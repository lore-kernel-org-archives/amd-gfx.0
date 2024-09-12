Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95157EED631
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 17:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF6510EBDD;
	Thu, 12 Sep 2024 17:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VwTJHoN9";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACDA10EBDD
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 17:44:24 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-718ebb01fd2so239544b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726163064; x=1726767864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmU6NvTipUQnAiMPxFvqyNnajVhcXQqIALppHUS/BJg=;
 b=VwTJHoN9qTqt6911BjYyk344qcmN9Vq1L/KyyW0szDxEeaTIj8geMFwbw2/XGq4BsS
 ZhXUk5bBfpqw24+i7Kzu1a4dWE7knYyZI5f7ubXUBzcscS4knxjP1Upw6OwuX02ftE4w
 f/DF8iPpRb+leDO0AUB0dj9RridG412vUD8/ZhTHYRJsu7RoRFQOFoIxFLUg5qIevYh4
 OE7QwEus4ZOjCBNEwrm7pLF1zdKEiIgPZ9oIl9k0Jrj5JP358Y1DpeLqQVA3Y+K2SQ7x
 +YJIawMDIONGOzoOcdjr/xjZcDTslpdbDSAyxE+8OQtFDWLxxdJKn134+lb3XF8E/89q
 pVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726163064; x=1726767864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmU6NvTipUQnAiMPxFvqyNnajVhcXQqIALppHUS/BJg=;
 b=NiQTJlvY7e+Z4BV6qxpCkprsYVmVTFYnTfQLNVnJZgilqE+WH3GnwiRVQFrNX4XACz
 iz39wSZdR3iJ2QLQhK2z+5YiVsKbY7VdpNy/IDjWB7jjoOHJhGgJrXEOPrsBCpZRzfBs
 olSpsF7dkjwk7xPChlXQIMhX5lw2tul5gssb4CfLvKNN1FCisYOGtwVdJHSuCGgww9VA
 m97n12wC9fCs/GQn95KRzaKjIcZVquA7hUPZ3UFStnMucF9YfLHI6UI0c6rOK3iiamlX
 KwHW/N+roUblmLEw1/Iviy4cs4Bq6Fk5AGS2Q2CSwjJIkXtBwgyd2FM6D9/LVhc2yddS
 3+hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu3VnLjp5N3RbGPBckA/KphlzAPdxunRkjweYuJvccuJnOAmbwBC+AIHgSY983topzkNP/V0x6@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1YL/1tjSDFnJB1vwu3LyjQhG4My47m+0jOQ2Pu8N1WTmmPUkx
 kdQMKRbFF7abwOrFpcoLws5TaNJjIyibcIS5ElJhsm79V5AHNeWuo81p8ugCpGQbSaKEIVjQchP
 09HEuYj8nw02XmwtZy5zato388Cw=
X-Google-Smtp-Source: AGHT+IG209VaJCuImRMuJYeZV5NozAtI44FMbqkT1gHEYTv8Wh4lzDw/X8yzuCj19xqZszR5qNKIcfOpuifWFLrsjTA=
X-Received: by 2002:a05:6a00:6f53:b0:714:2051:89ea with SMTP id
 d2e1a72fcca58-71926055d75mr2296000b3a.1.1726163064013; Thu, 12 Sep 2024
 10:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240912014850.1016005-1-liaoyu15@huawei.com>
In-Reply-To: <20240912014850.1016005-1-liaoyu15@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Sep 2024 13:44:12 -0400
Message-ID: <CADnq5_PXfv-0DY3V-QnoWL27TyrrQtec7UWEuteQwECa=TLpqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unneeded semicolon
To: Yu Liao <liaoyu15@huawei.com>
Cc: alexander.deucher@amd.com, xiexiuqi@huawei.com, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 sunpeng.li@amd.com, harry.wentland@amd.com
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

On Thu, Sep 12, 2024 at 3:12=E2=80=AFAM Yu Liao <liaoyu15@huawei.com> wrote=
:
>
> Remove unneeded semicolon.
>
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Thanks for the patch.  This was already fixed.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/g=
pu/drm/amd/display/dc/dml2/dml2_utils.c
> index 92238ff333a4..7595355281c2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
> @@ -421,7 +421,7 @@ unsigned int dml2_calc_max_scaled_time(
>
>  void dml2_extract_writeback_wm(struct dc_state *context, struct display_=
mode_lib_st *dml_core_ctx)
>  {
> -       int i, j =3D 0;;
> +       int i, j =3D 0;
>         struct mcif_arb_params *wb_arb_params =3D NULL;
>         struct dcn_bw_writeback *bw_writeback =3D NULL;
>         enum mmhubbub_wbif_mode wbif_mode =3D PACKED_444_FP16; /*for now*=
/
> --
> 2.33.0
>
