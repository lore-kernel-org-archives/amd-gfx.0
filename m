Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89860C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 15:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1ACB10E0C9;
	Mon,  6 May 2024 15:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LemWUzi3";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E65A10E0C9
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 15:02:31 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-6f43ee95078so1743205b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 May 2024 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715007751; x=1715612551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dTDhYNECvfKXh2TT7i86T96xtuMMKOtejRTQq8F22w=;
 b=LemWUzi3drRkzs1vAVIGp7fiTMRDL8o21PUEaOfrtN6wIb68FjcDuQxWyJEdKw0qKq
 XC5xYvFULTVGuVV5ch548YQA2lJpkP5vMgw2hWcY+5XFForcAl0m8gMioyjgfZVrn8qD
 ZxeztSN4RKJYtc7Gu4q+XjJa8pViOWYVuPmhDbAByvm6n96m19RJrCSffDE+hXEEmIn2
 9sLKpeYBRULt0mHkJHARQlwrH9sf3WeOEeUxqEp4WUUosbviqWJiUIQNMGzIp+Ba1D2Y
 KEh8pGPqMblo4A1Z+PXlF8dILDHGt53nVljRmbTWdEIKiJUKEqMfqC8ZWW0XByv/Bdkl
 26rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715007751; x=1715612551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dTDhYNECvfKXh2TT7i86T96xtuMMKOtejRTQq8F22w=;
 b=SEXgrspwFz0rTRfqAtm07h5KZHg3mvtX4cWLBcBFjcKcQtjjbEbS6aRNDt9kASgS8P
 8bEJPNTCd+M1ZehmTq02OslP6+d/r5Yx1S2v1L5Lj3xqI/SZiW+2i6X2i5Msfa3X7Mrk
 wd3PaD62F/1f1YQrtlvc9+gl8D0J20qLZpRhuS+fUBMzlSUNNcZREywXmg+neOsg6eR/
 s8RdFfaQhp74frapojlkJu57rD3AdU6q9todaI70qHf2STumd09Ksx3d1mDtsrqUOfsb
 9rN7QZJEfTDojZD26HYgBp1W38AIfpR72/DV0AfigGFQh6KZcGkJg3ktPHldH2199rGo
 HoUQ==
X-Gm-Message-State: AOJu0YyqCoMj9dJDfgBe9qXe4GhZ5tYU+3Ob2zBnR9OzfW5ZBgcMUPvO
 4Nrx9RsuoG6EhCbXSOWJ/+stXqAldVgOsKSVzaMEu29yjwLdcwxv/w++DZEPu+AIDJ0SKYNANfj
 RNsoZIjqyl6LZn95tDdMA+HVsGNpmaA==
X-Google-Smtp-Source: AGHT+IHClXJosEwRZy/UivkCiu5VIpFDiPACNl6F+EGPIULF3P3qjxODjGVEiS458CLNsVnVZ9Pqj7/8pv1RmDHcQvw=
X-Received: by 2002:a17:90a:eb0e:b0:2ac:8366:8ab4 with SMTP id
 j14-20020a17090aeb0e00b002ac83668ab4mr9719319pjz.38.1715007750978; Mon, 06
 May 2024 08:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240506092515.2027655-1-Tim.Huang@amd.com>
 <20240506092515.2027655-2-Tim.Huang@amd.com>
In-Reply-To: <20240506092515.2027655-2-Tim.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 May 2024 11:02:19 -0400
Message-ID: <CADnq5_OMTc6Q+YU9F72Vw6DeJGEnu=kWOMLmyOFH3mB_2-nSDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix mc_data out-of-bounds read warning
To: Tim Huang <Tim.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
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

On Mon, May 6, 2024 at 5:37=E2=80=AFAM Tim Huang <Tim.Huang@amd.com> wrote:
>
> Clear warning that read mc_data[i-1] may out-of-bounds.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index 52b12c1718eb..7dc102f0bc1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1484,6 +1484,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu=
_device *adev,
>                                                                          =
       (u32)le32_to_cpu(*((u32 *)reg_data + j));
>                                                                         j=
++;
>                                                                 } else if=
 ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) =3D=3D DATA=
_EQU_PREV) {
> +                                                                       i=
f (i =3D=3D 0)
> +                                                                        =
       continue;
>                                                                         r=
eg_table->mc_reg_table_entry[num_ranges].mc_data[i] =3D
>                                                                          =
       reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
>                                                                 }
> --
> 2.39.2
>
