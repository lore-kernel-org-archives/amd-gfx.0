Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3054C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 21:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C8710F8DF;
	Fri, 12 Apr 2024 21:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dokWJJm3";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8B010F8DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 21:50:50 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2a2d0ca3c92so919776a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 14:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712958650; x=1713563450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+oLLg0AlpYvJT55Z8VFrEG8WK2RUv2FXkvCI9N1haBo=;
 b=dokWJJm3C9T9zMV1r2hO2HdLiUBzFYsoP7JwTix6aifoiiPi8RZolL2CaG98CK4ABf
 kAAH5WxyeFpYKZe4Ix0l35Tq8w5Lg+/ucTL10t4IwkbLxGl6DIjgwudALo9LtCK5Tn7u
 TNdcar5luJOHCmcxnP5JKgRhkdd1Go3ilVvXjAKwRc4BW6VZ8FsvY6B0oSz5P/kUwRFV
 h9sLeq+xwfuY3MBd03TebyjcUviD3ydbcSzomn1JNHxui6WdB4IUPKXFkGI11llYqihP
 pzdHrC78W6IEuC/OYl8XQhgyN7dq3MVbVHK3HjJL/jxGSVV5UxrEPYgjZ50SSz0U3tfG
 CJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712958650; x=1713563450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+oLLg0AlpYvJT55Z8VFrEG8WK2RUv2FXkvCI9N1haBo=;
 b=SUzQFqyIAQb2LDh7PLlsP38w5ajomzIfZMh/OHVvipQ9/1DHPdLNBcSPIl8hQaE8J4
 pWs1egJts79gSgNZhyQQB6CzefVRESN2fy539NJ8T+tZWBmGmNZvYX3PN/h8XGri0Oey
 9o8im0JmXnk0GVU/XsC/vC6Zykfw75LQni6FyjGg2/lMoDv5beJeASid25AkQ9YjPquK
 7FjjqbZ9tQ4ZkeZtiG8o/snJDxLzVQonkPjzzn32c4KezpVZ4n1zD9A/j5pd6KHkxfPx
 hK67R2EA4KFf9AbCckxMG02VEF4hUMm4rNovmQhex/hMuntR3vKlDfRiMT0XyrsL4yEF
 AAfQ==
X-Gm-Message-State: AOJu0YyYGFLNb4K/U12KO2JfQG4tKjsfSgTfvHWBwU4fYwfylDzyyh8X
 IRt2FEM3jGp3q900wrMKjEwNAczUCDbGiC5ythic4wpVQaHfmbne5zoEUxBrfVER+MgAvpzEfmN
 pAHOjkmcBef9LH9asiPKKZcsm5jV2PQ==
X-Google-Smtp-Source: AGHT+IHDBvaevA3IoeZHi3L8u6+WdjnLy6WcB9rzwSagDf1RevohYgALn8fee3cpaV7impSuBvv42nrLAWkQpdmKR0g=
X-Received: by 2002:a17:90a:6546:b0:2a4:b04b:d204 with SMTP id
 f6-20020a17090a654600b002a4b04bd204mr5549815pjs.7.1712958650315; Fri, 12 Apr
 2024 14:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240412213214.1098385-1-likun.gao@amd.com>
 <DM4PR12MB518179D34E9421459A96CC4CEF042@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB518179D34E9421459A96CC4CEF042@DM4PR12MB5181.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Apr 2024 17:50:38 -0400
Message-ID: <CADnq5_OZMGQnz50SvupgnbeOdmJCyxfj9-xdRtFCORTmHeYd4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: replace sdma tmz flag on si dma
To: "Gao, Likun" <Likun.Gao@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Fri, Apr 12, 2024 at 5:47=E2=80=AFPM Gao, Likun <Likun.Gao@amd.com> wrot=
e:
>
> [AMD Official Use Only - General]
>
> From: Likun Gao <Likun.Gao@amd.com>
>
> Fix build issue on si dma to replace tmz flag
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/si_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/am=
dgpu/si_dma.c
> index 42c4547f32ec..6672d8a49d66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -776,7 +776,7 @@ static void si_dma_emit_copy_buffer(struct amdgpu_ib =
*ib,
>                                        uint64_t src_offset,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count,
> -                                      bool tmz)
> +                                      uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D DMA_PACKET(DMA_PACKET_COPY,
>                                               1, 0, 0, byte_count);
> --
> 2.34.1
>
