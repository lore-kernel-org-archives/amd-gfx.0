Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B842CCAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 18:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E2610E097;
	Thu, 11 Sep 2025 18:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHF9wDRc";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7259810E097
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 18:18:14 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-772771b6e0eso103536b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757614694; x=1758219494; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JU2GHaoV2evF+bYkGNB6J0D6r+FRoZYpUwLMBx54Vds=;
 b=PHF9wDRckG/tidp13tGZf6hXjABhy3H4MxPbsw1AuQF0moEdz0IaQ9lDGcqEcadUee
 TJoDyQiDl6DbpfgTpEVvwnsupBlqUDRqh4FgZFbOXclWtX+PBL/+ZACqEf8ID86of+aE
 NjTzjySufOeGasJXKDGWNgzdhq4uGYvouEY3THqjB+o8NuTXuzyIkT/hPXhx4QxIuB+R
 un5Ng5e6KRdxoMHXfsAqnZ+ZQhn7Yf/9bXWGn3/bOmQtJL6cdRhfAZrM057Oxov/UraX
 vzLvlE12LBvTPf177gzkpX8fRwcSAKXys1VkiTrsZwvH5Aq/ZFaWkNDjJTPqnWygn0RI
 YpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757614694; x=1758219494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JU2GHaoV2evF+bYkGNB6J0D6r+FRoZYpUwLMBx54Vds=;
 b=wVGVgl+n4b9Go6mcJVlyC19D/q4xQR8bWas7wxeKZfYkN2Sxpc9QT1Wb4S/dWvtxPQ
 S4a96EHs9AjNxCQ54VZvJdRDf4qdpMuNW/13hO+Gjjqj/5buDTgucidM5TmcztWhmhlc
 rVBjYyCKeYHNesEkkmLuMRwpQ4pyA0myIPhZh/hzIaWd2gUAcuqZKZDESvGN6DyjH/yM
 h2gQCWS98g9D+lSjO9qAKxKz1FdFvr5dwbviDFh9Atg7fROtGz+S0veEovG9R/ypoIb6
 5yz3zoSy3izvovzVYJEBNUZ8BUOeV9T7rxx7/Dd0jmXzidm81C+2ONfqcipK456IWFeS
 e9iw==
X-Gm-Message-State: AOJu0Yz0TJht163eDA7ePbjH7anFcV7f2S9xG+ZhFMCPINApfZ1KB6Ey
 sgRHXG3SHKJQD3GqoKuOHAEMxAKmNwR4vr85sKMQuMGZeoWA9b1Euiewiwhk0Ii32xy4UFnDHLD
 qhZ4s/AmZq5CvFSgqN88+6qbhZH1M8XU=
X-Gm-Gg: ASbGnctr7ZOhG26d2atw0W17V4ga+dbWOJ1EndOwPgiujL+KTHv/2hZj5eEATjZUIv0
 ZP8dCcadIUe4M/9ewkvjkrWT4PkmgDGx2TO5Fqvq0qIZYCrsOTMF+jVPMFslaO4WYm7FDqFxbzj
 XA0KFlf78C5SGftMa//Y0du/wrcB8MAsZJdsU5T7RN2vJBPKIYbuGhr6OlGzC59jxOtvPEORWxp
 uvwE3M=
X-Google-Smtp-Source: AGHT+IHbvjfsFkbuJ5P/VrahSXGWje1hJ+Q3amz/UWpViDENl/yBArGvJ2ZNsFWjPFiM+MRlmDXTlGgbYyO+TzC+F/k=
X-Received: by 2002:a17:902:e552:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-25d21ad61b4mr2018925ad.0.1757614693862; Thu, 11 Sep 2025
 11:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
 <20250911172449.3340848-3-alexander.deucher@amd.com>
In-Reply-To: <20250911172449.3340848-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 14:18:02 -0400
X-Gm-Features: Ac12FXxkiVcr4QDTLiOZH8JlhFbE1KgbmFFAHWznYmmM0BpXrtiV6WYrIDjCl28
Message-ID: <CADnq5_PNL_-YjyYQgNtz5xQKBxxXWdrvKzM6YT4wYZCOE=ooNQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma5.2: adjust SDMA limits
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
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

On Thu, Sep 11, 2025 at 1:25=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> SDMA 5.2.x has increased transfer limits.
>
> v2: fix harder, use shifts to make it more obvious
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index a8e39df29f343..bf227eadbe487 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -2065,11 +2065,11 @@ static void sdma_v5_2_emit_fill_buffer(struct amd=
gpu_ib *ib,
>  }
>
>  static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs =3D {
> -       .copy_max_bytes =3D 0x400000,
> +       .copy_max_bytes =3D 1 << 30,
>         .copy_num_dw =3D 7,
>         .emit_copy_buffer =3D sdma_v5_2_emit_copy_buffer,
>
> -       .fill_max_bytes =3D 0x400000,
> +       .fill_max_bytes =3D 1 << 30,

The hw docs and PAL differ here.  I've asked the hw designers to clarify.

Alex

>         .fill_num_dw =3D 5,
>         .emit_fill_buffer =3D sdma_v5_2_emit_fill_buffer,
>  };
> --
> 2.51.0
>
