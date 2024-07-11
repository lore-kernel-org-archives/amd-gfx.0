Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD555C3DA45
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 15:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BC410EABB;
	Thu, 11 Jul 2024 15:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUyKV30d";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8F010EAB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 15:17:38 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-70b0bc1ef81so791644b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720711058; x=1721315858; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HFRfHOqxP0iSCQLpW7b0NTcVaIAkpX9f7OQXGlBlQc=;
 b=gUyKV30diXbp8wxujIpLrXmF4ah/38CT92Lf2rKsRvXukNTxErerZ8zcyv1HfBi+t9
 5VLB3fMlBTidxuL+42eYdXBPXh1Co0Zuj2z7fyq7WM6xDM725g2wIA3PeUSNHW6zNCkM
 /CX3ao0huzQMwULCaW/hYn8zj3UQLV9z3hPtPaVi1LfAkNw49fId63NJcZrrB7DQckHY
 OyFkoncxaF9VwTkTv/rQSiYaJ/GffC4XhPPEtoDHO3IYE3vWgrMXHmQWr+ixbJnwSEvS
 MONJN0fXA1NnKBvSVaA7Xq51mRUPfKSopYQDsID4P2fmFDHkBk0SkrM5JuIsU9MUrd76
 5T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720711058; x=1721315858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HFRfHOqxP0iSCQLpW7b0NTcVaIAkpX9f7OQXGlBlQc=;
 b=TPwbR+DDgtZCsfKQf7wxT6uppWsvB2R3beuVd08DFbCDiBKleWLY4I9Vr9MMbvkyjP
 tuwfXRlTai+jaOanwWs6s9Y3Gjl2yZM384RPVRK8OgAnsCvIi1HpyNGKqY+cFUgZnmuu
 8PMxOH6WIqD74MfC3v5FXKFJSfxoTRe7U0Oy0UvWWVgcmn28i2KFFxUvLX0vaPQb6K2A
 vd6T5dZabqNNLmft8RdqnGYagfITIg/Xlf9W6qqRDtcdTlFHd5tcK76C/Acu54P8TI0V
 D6z6cgrQCKVPYtVGvM9m/6dN7edJ7aoKAlHAc/17YvN5Kl1ynBsv90XVLNNzhQNVQVrn
 +BNw==
X-Gm-Message-State: AOJu0YzE7fwcLsw6X85OW40Mt0IfqPlQEwKW5TU6Vl5Hxyr5UsEbUYBO
 4mazdFbwH0hbzrrh7HlXDM8vQ5JxXKQyhlfbT2f0+QJAWwERatfvZpgNi6JldqD/1qnVS/Eh72j
 9mFl8j7ix2v7FgmAIzLBTf1TcyAaDhw==
X-Google-Smtp-Source: AGHT+IHT3UEVvxcAC9IXz1NTRBRgD55WC++4cgGf6t28Os1SkedsMzC547tv+L4sJ8xaj7YM7I/+MU/t5G71SThNVD0=
X-Received: by 2002:a05:6a20:4fa2:b0:1bd:260e:be97 with SMTP id
 adf61e73a8af0-1c2984ddcecmr8234878637.53.1720711057765; Thu, 11 Jul 2024
 08:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240711140603.2860632-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240711140603.2860632-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Jul 2024 11:17:26 -0400
Message-ID: <CADnq5_NwQt8jL7bbaSKkbq79m6ek_q5rWQaD7kxwenXphSarHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Bump KMS_DRIVER_MINOR version
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 marek.olsak@amd.com
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

On Thu, Jul 11, 2024 at 11:05=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> Increase the KMS minor version to indicate GFX12 DCC support since this
> contains a major change in how DCC is managed across IPs like GFX, DCN
> etc. This will be used mainly by userspace like Mesa to figure out
> DCC support on GFX12 hardware.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 802debd8d9f0..af44cbc90d2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -117,9 +117,10 @@
>   * - 3.56.0 - Update IB start address and size alignment for decode and =
encode
>   * - 3.57.0 - Compute tunneling on GFX10+
>   * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & A=
MDGPU_IDS_FLAGS_MODE_PT
> + * - 3.59.0 - Add GFX12 DCC support
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       58
> +#define KMS_DRIVER_MINOR       59
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  /*
> --
> 2.45.2
>
