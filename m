Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CB7C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579A710F212;
	Thu, 23 May 2024 18:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RD7Q1Slf";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B1110F212
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:27:29 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-1f304533064so17213925ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716488848; x=1717093648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BC+vwTQ/eOliTFp+wFlfiIPnmqaXj84aed77oWby5X4=;
 b=RD7Q1Slfc1zt06VQU/jtkVCj9auGNK26GqfJAEwDDejU5x5oZtwY9yVHW44ZbINzAx
 EGEvvdpVxJdco8JxtXJYPJdhsVZd8cmHcbrR6fYJfKWL7QT3qMl86Cl2YGV4AtxLdydg
 EuVxhEKGXdvAWSlX/ZbiVkBh8BCc8wQ7uY7Vlb/aiCb6GA778ljWDecI8kEGiLZLa+sx
 O9P8D8rUsGYdA7wKM6xU3sYs6ShOySHQPJf7xAS4uHPFeTl9y1EGcfabWg9X5OvmLnVV
 iRzCbiHKltc7Lsjz2hdYclmKLE2OHC4713i/b3E7zYnOLGQaQAxkBqkxluFSyhqCC6EE
 FVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716488848; x=1717093648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BC+vwTQ/eOliTFp+wFlfiIPnmqaXj84aed77oWby5X4=;
 b=pnzeKvYBpvRB5uwQRpf/+/nXkFjuDsWrGtsenBnOAsvkD6ctn1tvnIa416w1E134uR
 G5WpSgLWGfkofxA24xMlV0g9aVcXu15P4oQkdbRhfLM/D1LmDzHFpqrzdOaf0yyUtDtv
 3cumNzwzdQTjeanVRHQ1l6NsCfwDY9+sbvT0ZGD5QZUrnjaegzSUso7IRAsetH6ZqLzu
 qWjKISfaiQSZfnbQAQUrpLRjWZ2frZhQ09e7f+bWvJfmhci14ZSQSIfFXHfx9J1BbJkd
 T66sAiKHbr60gQrl1WmMFwx+cre2y3igNXUDx4nKIVSYY10u+CoxEJJNXldQ7KuCxDqG
 pW7g==
X-Gm-Message-State: AOJu0YwBKlST/XXNIZs8ufaggoCGaIRIsDvWVKZCs3LBC4epO5vpX4zm
 A6/8wjSi0ykqr/CAsQp+tr2Pq4knVHDNkp5+tnHaPHHCt1yFukq53VDqrDmofaDo37COPWsZFCD
 w06jdNdNa6DJX5LvdyU8hUKDZ8uo=
X-Google-Smtp-Source: AGHT+IGQN/0d4KJayGfSsH7HdSkrbwoFhlOjCLC9VBmmel5RFKD4XTGqbOOn/xYYZoFNrXnJJ0xPFqQRdX1jtOZagAs=
X-Received: by 2002:a17:902:c948:b0:1f2:f817:4d12 with SMTP id
 d9443c01a7336-1f339f60396mr42499395ad.34.1716488848557; Thu, 23 May 2024
 11:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240523140809.1135226-1-jay.cornwall@amd.com>
In-Reply-To: <20240523140809.1135226-1-jay.cornwall@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 May 2024 14:27:16 -0400
Message-ID: <CADnq5_PkRjc1uqmEFKDf8m1BRKuAEyDyM4DhWf6uyphPKMdRxA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdkfd: Sync trap handler binary with source
To: Jay Cornwall <jay.cornwall@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lancelot Six <lancelot.six@amd.com>
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 23, 2024 at 10:27=E2=80=AFAM Jay Cornwall <jay.cornwall@amd.com=
> wrote:
>
> Source and binary have become mismatched during branch activity.
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 57 ++++++++-----------
>  1 file changed, 24 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu=
/drm/amd/amdkfd/cwsr_trap_handler.h
> index 73d3772cdb76..11d076eb770c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -718,12 +718,12 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
>         0xf4051ebd, 0xfa000008,
>         0xbf8cc07f, 0x87ee6e6e,
>         0xbf840001, 0xbe80206e,
> -       0x876eff6d, 0x01ff0000,
> -       0xbf850005, 0x8878ff78,
> -       0x00002000, 0x80ec886c,
> -       0x82ed806d, 0xbf820005,
> -       0x876eff6d, 0x01000000,
> -       0xbf850002, 0x806c846c,
> +       0x876eff6d, 0x00ff0000,
> +       0xbf850008, 0x876eff6d,
> +       0x01000000, 0xbf850007,
> +       0x8878ff78, 0x00002000,
> +       0x80ec886c, 0x82ed806d,
> +       0xbf820002, 0x806c846c,
>         0x826d806d, 0x876dff6d,
>         0x0000ffff, 0x907a8977,
>         0x877bff7a, 0x003f8000,
> @@ -1136,7 +1136,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
>         0xe0704000, 0x705d0000,
>         0x807c817c, 0x8070ff70,
>         0x00000080, 0xbf0a7b7c,
> -       0xbf85fff8, 0xbf820144,
> +       0xbf85fff8, 0xbf82013e,
>         0xbef4037e, 0x8775ff7f,
>         0x0000ffff, 0x8875ff75,
>         0x00040000, 0xbef60380,
> @@ -1276,10 +1276,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
>         0x80788478, 0xbf8cc07f,
>         0xb9eef815, 0xbefc036f,
>         0xbefe0370, 0xbeff0371,
> -       0x876f7bff, 0x000003ff,
> -       0xb9ef4803, 0xb9f9f816,
> -       0x876f7bff, 0xfffff800,
> -       0x906f8b6f, 0xb9efa2c3,
> +       0xb9f9f816, 0xb9fbf803,
>         0xb9f3f801, 0xb96e3a05,
>         0x806e816e, 0xbf0d9972,
>         0xbf850002, 0x8f6e896e,
> @@ -2309,12 +2306,12 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
>         0xf4051ebd, 0xfa000008,
>         0xbf8cc07f, 0x87ee6e6e,
>         0xbf840001, 0xbe80206e,
> -       0x876eff6d, 0x01ff0000,
> -       0xbf850005, 0x8878ff78,
> -       0x00002000, 0x80ec886c,
> -       0x82ed806d, 0xbf820005,
> -       0x876eff6d, 0x01000000,
> -       0xbf850002, 0x806c846c,
> +       0x876eff6d, 0x00ff0000,
> +       0xbf850008, 0x876eff6d,
> +       0x01000000, 0xbf850007,
> +       0x8878ff78, 0x00002000,
> +       0x80ec886c, 0x82ed806d,
> +       0xbf820002, 0x806c846c,
>         0x826d806d, 0x876dff6d,
>         0x0000ffff, 0x87fe7e7e,
>         0x87ea6a6a, 0xb9f8f802,
> @@ -2549,7 +2546,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
>         0x705d0000, 0x807c817c,
>         0x8070ff70, 0x00000080,
>         0xbf0a7b7c, 0xbf85fff8,
> -       0xbf82013b, 0xbef4037e,
> +       0xbf820135, 0xbef4037e,
>         0x8775ff7f, 0x0000ffff,
>         0x8875ff75, 0x00040000,
>         0xbef60380, 0xbef703ff,
> @@ -2688,10 +2685,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
>         0xf0000000, 0x80788478,
>         0xbf8cc07f, 0xb9eef815,
>         0xbefc036f, 0xbefe0370,
> -       0xbeff0371, 0x876f7bff,
> -       0x000003ff, 0xb9ef4803,
> -       0x876f7bff, 0xfffff800,
> -       0x906f8b6f, 0xb9efa2c3,
> +       0xbeff0371, 0xb9fbf803,
>         0xb9f3f801, 0xb96e3a05,
>         0x806e816e, 0xbf0d9972,
>         0xbf850002, 0x8f6e896e,
> @@ -2749,11 +2743,11 @@ static const uint32_t cwsr_trap_gfx11_hex[] =3D {
>         0xf8000008, 0xbf89fc07,
>         0x8bee6e6e, 0xbfa10001,
>         0xbe80486e, 0x8b6eff6d,
> -       0x01ff0000, 0xbfa20005,
> -       0x8c78ff78, 0x00002000,
> -       0x80ec886c, 0x82ed806d,
> -       0xbfa00005, 0x8b6eff6d,
> -       0x01000000, 0xbfa20002,
> +       0x00ff0000, 0xbfa20008,
> +       0x8b6eff6d, 0x01000000,
> +       0xbfa20007, 0x8c78ff78,
> +       0x00002000, 0x80ec886c,
> +       0x82ed806d, 0xbfa00002,
>         0x806c846c, 0x826d806d,
>         0x8b6dff6d, 0x0000ffff,
>         0x8bfe7e7e, 0x8bea6a6a,
> @@ -2988,7 +2982,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] =3D {
>         0x701d0000, 0x807d817d,
>         0x8070ff70, 0x00000080,
>         0xbf0a7b7d, 0xbfa2fff8,
> -       0xbfa00146, 0xbef4007e,
> +       0xbfa00140, 0xbef4007e,
>         0x8b75ff7f, 0x0000ffff,
>         0x8c75ff75, 0x00040000,
>         0xbef60080, 0xbef700ff,
> @@ -3130,10 +3124,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] =3D {
>         0xf0000000, 0x80788478,
>         0xbf89fc07, 0xb96ef815,
>         0xbefd006f, 0xbefe0070,
> -       0xbeff0071, 0x8b6f7bff,
> -       0x000003ff, 0xb96f4803,
> -       0x8b6f7bff, 0xfffff800,
> -       0x856f8b6f, 0xb96fa2c3,
> +       0xbeff0071, 0xb97bf803,
>         0xb973f801, 0xb8ee3b05,
>         0x806e816e, 0xbf0d9972,
>         0xbfa20002, 0x846e896e,
> @@ -4119,7 +4110,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
>         0x8b6dff6d, 0x0000ffff,
>         0x8bfe7e7e, 0x8bea6a6a,
>         0xb97af804, 0xbe804a6c,
> -       0xbfb00000, 0xbf9f0000,
> +       0xbfb10000, 0xbf9f0000,
>         0xbf9f0000, 0xbf9f0000,
>         0xbf9f0000, 0xbf9f0000,
>  };
> --
> 2.34.1
>
