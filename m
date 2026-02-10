Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B769EB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 20:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17DD910E049;
	Tue, 10 Feb 2026 20:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7RpP7sX";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E3F10E049
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 20:57:13 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b86a9613d8so206316eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 12:57:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770757033; cv=none;
 d=google.com; s=arc-20240605;
 b=X+IUDCHIEaFi8wLSM8PMe0WDhHzBo2BMeo5BpAg5FEuVmXZ0msIB3on952Uxz8b3jr
 PHN/6I2JJk8QUYr35ME014limf9FGWQirSGvDexPA/4lwi3VrPGTUUP6mVjosuH0sXVr
 kjIeplFokKG+IMIs/YjxygUfESlt55EnuzyW8+AMs4e34j/0jgozckd8u/SDU37j7qlD
 tZVLf68p1gIo6t8+bkv1FF+T3kWdLecW/pyOljW9yfpJZEd8ZGLbarv117u23eSRX9U/
 ownfgEqJi7JOyDmoct+FKgFMZdHN3IPIbZTugvD/wQJ6HAcUHHmTgwD3PTnWE+ZX2orU
 gdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1XQROPvgdea2FgkJiXt8CkNOwVCQiEbSvFKKpH50mhY=;
 fh=cCJmFHoerL401E4WTln33sQe3ddmb4b7aGLd0mnk40I=;
 b=ISaEwJSP9GEMAh5fQQmQsG0II09hXuKvWDIKEf/mraZiPFQe2XFSOlX1Mt5jqNC74A
 Jwv1e+dCHXoweFYZl3qOdUhQY6Wr+eZ2Xo75JFFa+X+OpKR5SYNRtILGkCqd2BkvRGZu
 I5lXvJa5Vls67SD6WsW0Q9URwZfhbnLLYgtQ2uL7wfDCjAtDmCxo943F5f7/hZeUahR2
 SlxoSAJyGCZHR3WDHVyg72qxiI4zvo3XCtW85Lj2A14HvnY3QEZt1wVhj7EG2qewW+YX
 JwmJ4iYYtZFnxzXi9kWXIGcwjpwlSCUupGYLRVHw45zjgoTSXQDm7i69Sc19RdM1Zu5O
 9x6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770757033; x=1771361833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XQROPvgdea2FgkJiXt8CkNOwVCQiEbSvFKKpH50mhY=;
 b=S7RpP7sXRkHdfWiveSBNJEuUhdNZkHQqYnqpPOr7jGgBZawH+X0hqzaXtlPcR1wekP
 TIDFT+6xzzT723Obp90INyZEtnnQ93pUTmLtQ6i9vY1ksP7L2D77guFdSQtzENDc6jMa
 /AMLwuuH4FK1KDbhH9L8e30mrEvw4UhQuNKF3WDHSLZTbE1Sd9EsMD9q/5jzTCNrfrki
 O1jFQCfr9p2TZJsk501+bEDfC6QCMq0N8OLJgJjT8QZ7dvZKWWP2dYq5Y7WzGH40PYtY
 OI0xcegkwW9iNVQJx4Hf9mp68Fd1iF/v0U9uAxanPs5Q0BiSdv2JYCQJQJmOYWBFaFdr
 pXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770757033; x=1771361833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1XQROPvgdea2FgkJiXt8CkNOwVCQiEbSvFKKpH50mhY=;
 b=N4Of1QooGp4MrAfllnKFn2rrS7lI1HMYx3wZGArVSh7hk14TlON5WEs4yhfnI1Nx6f
 lZKBTEcG6TY7EQsPuMvSmtIpsvqg4PYD+E/Xd+6Cgl+taNpbW+G/glInP6uIWruQkAnH
 V2pw09epKN8qvmOS/V2dHB+DmuVM1B0OCFUHj/BF6TJpA510QVaVxn/dl1BIRHwACmvY
 JlbTCYKaZBdOLRcEYEhyiVHrECBOC3go9uYWI4c8BLGS8/rQE/lFCoASpFPXyyDSkOJ1
 xqouBf6/WCPImXz4p6SRF2DtiEnGntwvxr4ZWfBeEfh6QmuaXASJoM/RIUlHf/BfDlF4
 A0TA==
X-Gm-Message-State: AOJu0YwfQiGwYyqRG0pDZpTCQbjSaFwcoQ6Ozty0IhOSLvTvuslJqW30
 FTv0EuPVz3zkuZTz0zPYhSm26YPcreFtYFI806Qs9tfP3YvdtQAzQMofwupyVr0RpVYoNQJ1Xm8
 5jTdNyZtbda5wEzbhV/PwsKbvm3/VbNY=
X-Gm-Gg: AZuq6aLF/41vTnqq69xHbSt0bzdEws904eZvlWWSqunuvyQnNEbtsdGzlS/ufN+o3LJ
 6N63iDgcretJ7PSKseo5MLY31my3vCw+fPY37oxNg1TbisWuMZd209XofsixlSaOqpS0P7X6udw
 ZjCXF6XoJAK4JKaL0ma80iyJckNpurqbDYkOijUvtHShRN/sycXdRkYQlT+Iu5TUafrHHCI0xxI
 ZuzpNF/g8PJ8+dH8wkpSDWfDFDZeenL6gq0qa2T5y0ZRWjbIKyfI6WrxADf70Fads4ww16Lf+b/
 KLUi6cOF
X-Received: by 2002:a05:7022:a93:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-12724940376mr742684c88.4.1770757032817; Tue, 10 Feb 2026
 12:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20260210203600.9035-1-ekurzinger@gmail.com>
In-Reply-To: <20260210203600.9035-1-ekurzinger@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Feb 2026 15:57:01 -0500
X-Gm-Features: AZwV_QjpCOBIUA5P3TUD1pBv0pRGc4-Q6MrEutR1ZSW5ISO0v7hnPmJrInF5vhM
Message-ID: <CADnq5_OPq09r1FUcFBtJY-wHhOcZkjWq6TnrKUvV1uhr4RkxnA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate format modifier
To: Erik Kurzinger <ekurzinger@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com
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

On Tue, Feb 10, 2026 at 3:36=E2=80=AFPM Erik Kurzinger <ekurzinger@gmail.co=
m> wrote:
>
> amdgpu_dm_plane_get_plane_modifiers always adds DRM_FORMAT_MOD_LINEAR to
> the list of modifiers. However, with gfx12,
> amdgpu_dm_plane_add_gfx12_modifiers also adds that modifier to the list.
> So we end up with two copies. Most apps just ignore this but some (like
> Weston) don't like it.
>
> As a fix, we modify amdgpu_dm_plane_add_gfx12_modifiers to not add
> DRM_FORMAT_MOD_LINEAR to the list, matching the behavior of similar
> functions for other chips.
>
> Signed-off-by: Erik Kurzinger <ekurzinger@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index d3e62f511c8f..12bd0c908d09 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -704,7 +704,7 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struc=
t amdgpu_device *adev,
>         uint8_t max_comp_block[] =3D {2, 1, 0};
>         uint64_t max_comp_block_mod[ARRAY_SIZE(max_comp_block)] =3D {0};
>         uint8_t i =3D 0, j =3D 0;
> -       uint64_t gfx12_modifiers[] =3D {mod_256k, mod_64k, mod_4k, mod_25=
6b, DRM_FORMAT_MOD_LINEAR};
> +       uint64_t gfx12_modifiers[] =3D {mod_256k, mod_64k, mod_4k, mod_25=
6b};
>
>         for (i =3D 0; i < ARRAY_SIZE(max_comp_block); i++)
>                 max_comp_block_mod[i] =3D AMD_FMT_MOD_SET(DCC_MAX_COMPRES=
SED_BLOCK, max_comp_block[i]);
> --
> 2.53.0
>
