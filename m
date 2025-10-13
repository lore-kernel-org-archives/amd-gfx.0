Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018CBCCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 17:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866DD10E051;
	Mon, 13 Oct 2025 17:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="brP+s01j";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D54210E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 17:28:07 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-269640c2d4bso8148715ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760376487; x=1760981287; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPc0qjv/1OS/fTPatwf14UVkWK1JhWsRqnsOPhj/aF4=;
 b=brP+s01jGNAnZHrHAVnR7btdKzw6biHQEBYSUy8T2TK65BciSjwjx9LjWq+ZpGjXxa
 jvWnsNk2d6FvVw/dRnR1cCu7A8Bq3PX1GyiuDOOpLVSlAGSwQga5IqUwFGSyKo6WM39C
 fNPvzW3503xJjpjnUuXWl8iGDoLFiGrt22txF8utpO4QAJ02T1GQJETPtdSYHqcFh1T4
 UAJ2Fpy75aEAGFDo3uf6F3kQh8JGXWZxzyurwX6iYW7W6TxdYCIqA9sAJ4Cf5MPFYWG0
 JfKDy91oTjh8WSA54cCdkywhcHiIgHq913UlLwxXe0nQRBZwR+KMiYOXFzIU3Pq4rs42
 6aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760376487; x=1760981287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPc0qjv/1OS/fTPatwf14UVkWK1JhWsRqnsOPhj/aF4=;
 b=wcSCXUbpVJhaUGpIUBIhImhBHxpqJWQZzwQf4TsuiXB3oawt3EvJXXhTlW5vLCwo1I
 v+4kgrghDgwuHVb2+aiaNGgoRkH/HxEMVkBjkMWgJcqFkBvF2M4/JN0bfzYfpnfxmVIO
 Te8LpYTQ2NFefjDcIsLp3UktL7MBo/B89w5s66f9nswzZsbHPzp+aSVfr2S2tuw0LrHK
 mQ6ueRATB0aPSCJMPtlPEUoWvaLVK7DljLjIo7PAQIhHBBt06b6VyAi1v2b6pUWSx3Vi
 ARO4SOWY+bQZfroW3+tHwAGfaPqIk0acCvdS/fc6IeYkcxQs2CVCkZTzCXNx7izqRwjV
 MNPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVgf2VxsP9C6tp0vwP1r3t0keBoRX99EaPM7oYe4t7Y/RgB0ufFR8Eko2GwgfLz4ZNJWJPdRJo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkDI2wiY8CiF8cPutRtwCEpC1ws1RPfVyWN1gPmW2lG2+Gri1i
 QCD69Wh6YoKG0WQc8kjV08Oc/WnMXQ7YAGCCQL3jwOUml/7rnJdeY3hBDeUzj8eQGdlV2HgM4c3
 YI+5c0OKtgK8y0lZ8SMPh++wjl19P/FVijQ==
X-Gm-Gg: ASbGncs2OYIzCEWVmjorvw7uWpJuQrQMsZCaBHwLhh3tKUYTOP25ez9k+uWkzfNyw7z
 SSI2oL10UW3cQrr6nc9PsYmR14WXV0RLJdndNWqz6bmyutEOHm1pV8QnzDmimwP7B7UhDCnthK7
 ijnYMSByOpqCGLqZtiKmKOdpmsfSU40wBPOdTZDf2AMtNEQwZfA86dXefytZQ3/cTTFlkzAPvPL
 YV4OleujbsPTwb0F4C9Ytd3Fm3ziWapYxnu
X-Google-Smtp-Source: AGHT+IHO5T7DaJ/L/zUwY5+dE5tEGIqjeR/NL6pM+xQaJs1OyOarzyY1CGqMD0mH8a95wjmENZfV21WC+RKV5Fert5I=
X-Received: by 2002:a17:902:ea08:b0:28d:1904:6e77 with SMTP id
 d9443c01a7336-2902726698dmr157782855ad.3.1760376486882; Mon, 13 Oct 2025
 10:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251012191319.40046-1-adigollamudi@gmail.com>
In-Reply-To: <20251012191319.40046-1-adigollamudi@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Oct 2025 13:27:55 -0400
X-Gm-Features: AS18NWD6Yb5t_3wBA82nRoVkr0DEhgRA5u9sRT4l87JE1mQVPllvTu7iYOlGtj4
Message-ID: <CADnq5_MnKaDMrh8ZRfY7KNieVU9d5vkLMU-rfwF1neTFib6oyw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix typo in display_mode_core_structs.h
To: Aditya Gollamudi <adigollamudi@gmail.com>
Cc: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
 sunpeng.li@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org
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

On Mon, Oct 13, 2025 at 3:35=E2=80=AFAM Aditya Gollamudi <adigollamudi@gmai=
l.com> wrote:
>
> From: Adi Gollamudi <adigollamudi@gmail.com>
>
> Fix a typo in a comment, change "enviroment" to "environment" in
> drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
>
> Signed-off-by: Aditya Gollamudi <adigollamudi@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_struct=
s.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
> index dbeb08466092..d57717b023eb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
> @@ -1894,7 +1894,7 @@ struct display_mode_lib_scratch_st {
>         struct CalculatePrefetchSchedule_params_st CalculatePrefetchSched=
ule_params;
>  };
>
> -/// @brief Represent the overall soc/ip enviroment. It contains data str=
ucture represent the soc/ip characteristic and also structures that hold ca=
lculation output
> +/// @brief Represent the overall soc/ip environment. It contains data st=
ructure represent the soc/ip characteristic and also structures that hold c=
alculation output
>  struct display_mode_lib_st {
>         dml_uint_t project;
>
> --
> 2.34.1
>
