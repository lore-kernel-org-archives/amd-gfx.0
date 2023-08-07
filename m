Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F8DC001DE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 17:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88FD310E32A;
	Mon,  7 Aug 2023 17:11:20 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B62810E323;
 Mon,  7 Aug 2023 17:11:08 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-56d6879dcaaso1355130eaf.3; 
 Mon, 07 Aug 2023 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691428266; x=1692033066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m16fJSelMd4HZcAn1Zx8fvrGuQ+wWIhwtRhDA7myOIk=;
 b=MSYUk2F8V927UzOSmS+4fdZ/330PbUEqDcZWJVNyRRIp9V6BPcn2m0AmB74eqD1M8x
 z0/qzM7eRkxnPVmq3Ch2bhLig/AFhcec/LAVgsAPiyZqPrGIqqVmw+eASt47JkTcht2h
 eMF1YRIkHsN5x5ZGhA39FqaAPr4HCsuZupYPB+yc8N84NnQAy4qJaTbf4MD8fUUdA05K
 FB6fC383Ff6S4GIedCwd25vetvo1EhDYEJFnIqE96l3b0TFbgwKjBz28O69wQ9jJNxZd
 dKRgbnpStZBSuJWUmSdmIUe9EoR57gILkXm9RN/jJtuem6Jw99xiLkSXGmlyXBXA5B0/
 7NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691428266; x=1692033066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m16fJSelMd4HZcAn1Zx8fvrGuQ+wWIhwtRhDA7myOIk=;
 b=AlqmP1FKRsdPPTYqIJ9BgVkxHwF9lcWnh+ax4nbrzuc/E7vEMDEE4d7FqjqZfecB/I
 QXQad8UomMrh2YHShGzB8XWTzLsACTOotlbyh9uN6y3EKKguQplbcKjqUsjJdx3CHfCQ
 gWh7u5GEIhGkQFCUVp4mhAEXduVau3Al/h/D6iIk0YoZaR08hyrDcm/nXvSvTOwSHioZ
 KWlQKPqhj00ofC6PCpoQY09JE/uAeVJxC0wyJyGhaG6Wpc1vzZP5HOxradh+H9s9dy4o
 aBBF5o64KOZmYf4Z4gGEuFZz2nuBE+FanUt48c27N/hJ5fswcW/6EqBEP6tan80mhmhL
 gM8w==
X-Gm-Message-State: AOJu0YycejKVvpxnFIlquaORytX8nTDY///X+MbRT3V6n9BB1WGCa2Zm
 TKC7DZnZt1Rz9GlWMET7RyDeTIPqYJOgp4Waaz7EyRdr
X-Google-Smtp-Source: AGHT+IE0ZWcy0BkKo64iUNra5AF7PwpsSxZjrCHZVah+Pvj31QkLtbNxbEUX8K0sOKFs700TnsTyDte7eqb6HgPsrbs=
X-Received: by 2002:a4a:3818:0:b0:567:154:25dc with SMTP id
 c24-20020a4a3818000000b00567015425dcmr9049143ooa.7.1691428266104; Mon, 07 Aug
 2023 10:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230802025814.10569-1-sunran001@208suo.com>
In-Reply-To: <20230802025814.10569-1-sunran001@208suo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 13:10:55 -0400
Message-ID: <CADnq5_O0O47XB0pbHFTX=afGcfa1LpD1rVVL4a+xbf1w8emEmA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dcn315_smu.c
To: Ran Sun <sunran001@208suo.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Aug 1, 2023 at 10:58=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: code indent should use tabs where possible
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../display/dc/clk_mgr/dcn315/dcn315_smu.c    | 26 +++++++++----------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b=
/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
> index 925d6e13620e..3e0da873cf4c 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
> @@ -33,28 +33,26 @@
>  #define MAX_INSTANCE                                        6
>  #define MAX_SEGMENT                                         6
>
> -struct IP_BASE_INSTANCE
> -{
> +struct IP_BASE_INSTANCE {
>      unsigned int segment[MAX_SEGMENT];
>  };
>
> -struct IP_BASE
> -{
> +struct IP_BASE {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
>  };
>
>  static const struct IP_BASE MP0_BASE =3D { { { { 0x00016000, 0x00DC0000,=
 0x00E00000, 0x00E40000, 0x0243FC00, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } } } };
>  static const struct IP_BASE NBIO_BASE =3D { { { { 0x00000000, 0x00000014=
, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } } } };
>
>  #define regBIF_BX_PF2_RSMU_INDEX                                        =
                                0x0000
>  #define regBIF_BX_PF2_RSMU_INDEX_BASE_IDX                               =
                                1
> --
> 2.17.1
>
