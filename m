Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BC2C35FFC
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 18:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA23510E173;
	Sat, 22 Mar 2025 18:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XStBaKSC";
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40E510E173
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 18:48:15 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-86d5e3ddb66so1337710241.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742669295; x=1743274095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30DlKpUaWic+6Ihaf3Hs+n3OTaCoEW01go3NFK8ShEM=;
 b=XStBaKSCqAMdtEOwP43IZSvOg2E0oC/blctMZ0fLL+W56E2L+3cbfQVeTEIb8+cooV
 UVk91+ODTGXKrLx1oHLLQ+p00d2YCK7regVOOAat4iqStNod+IHJm1Rr6nzqTfTlNxRK
 ngDnVC48Fw515odQU/+tWMhtwa2EbJuEytxNEvZOHTDgbOTjCkW3H0eW/RkGEnFyKolK
 gIVukGVo3nTCAIhHRk0Ce9qJWCcixUb5H+p6FU1svcz2KwJz0epwHk18qo9ocsueLeVc
 ZGYosLE5vJRp2cnIuhVtXsi+dyqzHnFJmUrYSyC4ApOi2NEwU5huMFVCkoxT26feoPwP
 a3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742669295; x=1743274095;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30DlKpUaWic+6Ihaf3Hs+n3OTaCoEW01go3NFK8ShEM=;
 b=M/Ov5wp7DhaYg5S7u+tpJ7QgtLkPSqNtEnl2LD/7QiMjUMd5Igg0tYls7U/r/7Tswg
 LcVu6PfsRHVzyhFw5YmD+rDLFZi861zroG+gjYpVd1Gh2kWm6yXg6wUsNZbuVJAXxbDD
 IZyU0mlDv4LT0FRhr7X1ngYnNC35fL3HjKELqStA6u1zDuK+CO54eKPnlAAyzsMeQrka
 krlpacowmq+aYUKNGiWP+7qWzUCEwu6mGMABUv/OZJ8+MpXP8IURMNargW0gH64M16gP
 NybQxQ222kJ8b150K5qjYPwVXzefc9y9YBIUY1fIeNLPvZEXKilaJimVjFIMpLYXSs4o
 SGrw==
X-Gm-Message-State: AOJu0Yw41ebyOPw5y0xoNZ9QP2tSAOVugbLs4tpd4eMaVh7uoBa38mEx
 QpecIxQ1r0SQhHVra26HapXrK4x8REw77LUXW1wX/K5CqoadStV+gx+oUp6o6lZNyM2JLMiwP/3
 1iEITXI5ZAIijgZozsFc3aEM0iHEBng==
X-Gm-Gg: ASbGncvt32H1ueOa/ne9b/XCXGBUUC8bLvquIGm44Ps7CNLx+1v70XapHafGn/U0XeZ
 adVXjnGFPTQHjF5ug/r4W2OG71t5grGXWjHicd26FTWTufuWZbBtyZbH+2bNhmoLzXFal6SKDiO
 jyaeIXJ0Gw5EStPYQwNqallPTA+r7iK6GELSQ=
X-Google-Smtp-Source: AGHT+IFL02hnAzby1gr7VE2KiziPNsLV2EopYjFuuN1jNKVuhX1XDFYE/KFuJqFmYiAc7jfLBDC85b7VlRSIKHm2nys=
X-Received: by 2002:a05:6102:945:b0:4c4:e0cc:fb39 with SMTP id
 ada2fe7eead31-4c50d4fd939mr6736585137.12.1742669294512; Sat, 22 Mar 2025
 11:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250322183900.86061-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250322183900.86061-1-alexandre.f.demers@gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sat, 22 Mar 2025 14:48:03 -0400
X-Gm-Features: AQ5f1Jp__kLFySBTNtAuHUSdDmLy0PUPPzY0crToRvd3wvBZQDyx4PRKDhCC_8Y
Message-ID: <CAPEhTTHhdbfdtFtNgfrSFRnn3S6Pz+MWnWrPmhMvQb4GW_tD2Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/radeon: fix MAX_POWER_SHIFT value
To: amd-gfx@lists.freedesktop.org
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

The title's prefix should only indicate [PATCH]. It was part of the
series just sent a moment ago, but it was removed from it because it
concerned drm/radeon.
Alexandre

On Sat, Mar 22, 2025 at 2:39=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> While I don't think it is being used anywhere, if it were used, it would
> be wrong. We can base this assumption on MAX_POWER_MASK, where the shift =
is
> by 16 bits.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/radeon/sid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/sid.h b/drivers/gpu/drm/radeon/sid.h
> index 65a911ddd509..f9267b026f8d 100644
> --- a/drivers/gpu/drm/radeon/sid.h
> +++ b/drivers/gpu/drm/radeon/sid.h
> @@ -1109,7 +1109,7 @@
>  #define                MIN_POWER_SHIFT                         0
>  #define                MAX_POWER(x)                            ((x) << 1=
6)
>  #define                MAX_POWER_MASK                          (0x3fff <=
< 16)
> -#define                MAX_POWER_SHIFT                         0
> +#define                MAX_POWER_SHIFT                         16
>  #define SQ_POWER_THROTTLE2                              0x8e5c
>  #define                MAX_POWER_DELTA(x)                      ((x) << 0=
)
>  #define                MAX_POWER_DELTA_MASK                    (0x3fff <=
< 0)
> --
> 2.49.0
>
