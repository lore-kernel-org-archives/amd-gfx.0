Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6C4ECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D4310E6CF;
	Mon,  9 Sep 2024 21:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VuGFp+ae";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A3010E6CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:37:30 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-718e25d8b67so576741b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725917850; x=1726522650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eW0oARexwrpTDpruEzVxTR6z66BhxdwHPDndN2APBcs=;
 b=VuGFp+aetbUGtGFZiaUApV75gtgZUSD1dGV/DfV+Mn4KMpsmTSV4wip0GaCRAq3kBj
 KSpY9ND4Zc34KmtbvBvl8SXgmpaF0rcTy1f4M1hng4Euyu3y5mzmiqUy7fqSejEv/uOO
 ok86PRQOX7hd99BPsUS7GzYLexAJvmpjE4cvlJ5Kjr3UYvt2yxwMtNXNcImQrkyCJ8Kv
 144Qo5UBwBPn6cLsF1ptYEJJmu6cqOIQxFbhYkKdXcqLyEZjIqVnafPxsqxSEp2qfLMH
 m+fUhOEHfb7oLzWAonI+MCslRw/Eduu4zMeKydYCYqqepShZscSrovr/vvx8BolrhOkz
 efWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725917850; x=1726522650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eW0oARexwrpTDpruEzVxTR6z66BhxdwHPDndN2APBcs=;
 b=VQpSGNqfboTUkOnNiVQzVy3NHR2Yp6WELgC8PhX5s3o2xng9VnWJ/L6ezcEJ04xAOD
 X2KS5HbLArKgyu7zMNTgq8tGBAwLII/LPAIqZhSmIhD08UeBNnCw4P7/zQXXksQBFulb
 Ju3QSfKww5g0f871xo+YzphEAK4s3a47a6rFJ71RUK9mDwbdroUiE9GbJ7EDoTQPrqL0
 RLdpXycvh3VPzI7fssYgcsLZGvj6Cpncta4qp5ZOJKmiOBiHtRJfYe0W+rrJcGNaf4uD
 8tPY4d7EvRdUa/JGxucevYZvXWPxE2rAZT3lZXN0nkZVrhtaIW96EY3SVQbOQMny3Ynu
 eC3A==
X-Gm-Message-State: AOJu0YzlRAs8C37yUymQX+aafsDt6HftzTjlh7cXCWsnGWP/1kaoAq0D
 peONhp8kGIRMnOSB7sw0Rdyv9RoLlngLjLLx/pIyDEeNETwQDYbZ6rskGv/GUI9tocH75hCSJMD
 isvKcEpzWLUBRf1groCeXAGSgLxxqDg==
X-Google-Smtp-Source: AGHT+IEntmS/DgmoqXML7zs/h5n0n3WsMoAooA1ejFZka5ycuo0w5hobNuTMehStUE566wbpILoIhZBatMZP+iBcBdw=
X-Received: by 2002:a05:6a00:919c:b0:710:51cd:ed43 with SMTP id
 d2e1a72fcca58-718d5e18e5bmr6563469b3a.1.1725917849945; Mon, 09 Sep 2024
 14:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-9-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-9-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:37:18 -0400
Message-ID: <CADnq5_P0WdVvsbiwztHYnCfhHbSRhsD57QQdZvmv_+Mo0XcwGA@mail.gmail.com>
Subject: Re: [PATCH 08/10] drm/amdgpu: Support reset-on-init on select SOCs
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

On Mon, Sep 2, 2024 at 3:34=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add XGMI reset on init support to aldebaran and SOCs with GC v9.4.3.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd=
/amdgpu/aldebaran.c
> index b0f95a7649bf..119acd9fc6cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -417,6 +417,7 @@ static struct amdgpu_reset_handler aldebaran_mode2_ha=
ndler =3D {
>  static struct amdgpu_reset_handler
>         *aldebaran_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] =3D {
>                 &aldebaran_mode2_handler,
> +               &reset_on_init_handler,
>         };
>
>  int aldebaran_reset_init(struct amdgpu_device *adev)
> --
> 2.25.1
>
