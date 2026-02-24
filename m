Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7C1F3C989
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 15:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1206210E5AB;
	Tue, 24 Feb 2026 15:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GCYzn5JK";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 911C810E5AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 15:07:01 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1273c690e5bso318728c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 07:07:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771945621; cv=none;
 d=google.com; s=arc-20240605;
 b=a2r0xe/p8B7RT8b3zZgaqK7mrvBP3wAak7H9Nv657e0YS9CVTrhwQRbHTLhbbtWR1Q
 g2ripjZE8IoBMwN02eVO3YuIEgTD0/VBrTiS6SkG2OfsNtJyeEblV4vspvA7KJE1hh4A
 CUG/keC2Aqsy9S8jikEQ8nki+XvOhfKKWeDtafGtdEpRn+s3HS6TWQDogM5ZxFkxDDNy
 8d0O7BWHUP02RlyV/sQRlQLf2icIwLH2muo3wCetVur5TYFavPHTB4tmGWuZHPj3D7SR
 XOCtZ59ZtiogcyJ6iiwl19QHKNjdy6lBM9ZqmKfSU5DHDAoRT/aNSRLjdVlY08Txbs+D
 RBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1H08MIFYR0hI8akjAJNajM/lF+FJn974fgTnpCHpN5g=;
 fh=pcPV6LR05iyxgJ9EDAAE6oHX+2Nk6EIgqzdZaHsn4Gk=;
 b=BFLyrsE9FgCaGdH05u/XbJPRmSBMYTR2KBDvBOCmJ53Nj2muXONGndAwJkwkI3XTEK
 6pRfAsfgtVuDmgcrX/wRRovlWb+rQIoVseI6JBAdxKe7ryyvluarjkXpDGAtvaYiO+OM
 7Md5G97EzxG9RezZsA7vcnLbr7RCxnQDn+CPvK7UdKv9XCk2di0+FkDkZbUkvPFW1WRj
 G6f0N6FpCFYEn1l+arJ5A/NYeMjjGQuoMvXoy7ZxVnRNnV59y3HNFbI24dW9cBJV8gZA
 CfA4pgXTyq99ecl72449JE92Sp9XtdljMpCtkc70k9d4DFqPwo0uRMPYYE47mKi1Zu7w
 rwnQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771945621; x=1772550421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1H08MIFYR0hI8akjAJNajM/lF+FJn974fgTnpCHpN5g=;
 b=GCYzn5JKYIiQSDjuP7O/bpfOFG+gTbpTJRq1P621EN8IDyXJpKrroaIogKTXoS4lND
 DcZrjExbSXk9v+ElDGjYznOz3TOSCjCT57biq2WBKBbWd1V3V/yzGijtDQJZiaoiW/kn
 zaknpPteiBZkdo0ZUWXFstPmbXY0qcumhtuRw4FEXoUDfXMFY//LLN4roj++xkzp3719
 54Foz7mnLomUXWPUfNynjW3gmSrzzOTRTNjtEAaNRNZMquZ7LXX+i/nEIHXt1JWsmZ9m
 2IXufJxd8Ios65dVNEY3olooZZat8kPvQMb2o65Wp47bPY4+H0S+X84Af+3tnrgRQ9Iy
 FLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771945621; x=1772550421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1H08MIFYR0hI8akjAJNajM/lF+FJn974fgTnpCHpN5g=;
 b=SVCkmPy64dS65qSrrpEPCGjEkEdHUMmtZCaokd3ufWNImgnr3LMVs78OORpeNT5/eU
 MD64XuM8jrSSRzcGQmpllbhjgDIk+uIFFFTh6YvIQPv6v+5UGQfe2MEwfLUJyat/SRju
 FFPoVkbN0nZ+Ya4H2EGSE4xRgtackHC0NvB69liWPWa/yhO6DycPsZWRXlpYiuSwj3Za
 gHb/IzwD5PvvCZwXN4XbCDHn5oz/vK/r2m8VRaty79aOWJ/953CORed6oezpGq4vtvVK
 XpjGunUgFfe6MeOBb/Fn6EWXM/uQfynQAeS/8EVYEz5RLxJZLfVM39jsEEOTgIT3wFdR
 /Jnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjP7rm2MlmGn79IYgAN90cfJvTdW2oNWQJBGFH2c7YkC/C8R/730UENyfUWD5qt1KUcLuBjdbl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziaxlpQrBJCiSDjrv0YyPqP/02pew4s/KULVq6zLu3cNDBobRf
 w9CclAYE20WRsVXTnHvAfWoM63wkVqh0OI44QPEgmQitl2Fl78yvXsryKyP2EkeDcN1qvpgg0kh
 BwNz2tp43fQhAcb6w7mNEW7eZvx4LIws=
X-Gm-Gg: AZuq6aIqcyE7YTRzBN0ytgy15M6qlA00UoqvPC9TahtRE2h1RM/jW4RZ7QOSAvsd8z1
 lagxVlvBYsyu81YQUPoOuACiM2/cp764788NbSJ17vqPJmI4fsRLBkFr7JPqBR1qr4uTnInF+uW
 9u1CQ2Ekjza/apzomj71RexK8V2Om1M3xSpbaUHMv0Ioe8R/eB3RCWx8R52kzg/vJltSwafVL4z
 qnZ5Ad6lQtO4mUSNX70jZkKvbhepe47DWkbZvprf0dhBxFbGKv9YoLYcViDb4dDLKK4K9/pFcVA
 7mEy7kMi4o9OaWgSvPO2icErcilgsNMdimz6uYwU+wCaO0liI4hIP+2TMrLVqr9Gwo8qig==
X-Received: by 2002:a05:7022:69a5:b0:127:2d87:f0fa with SMTP id
 a92af1059eb24-1276ad1be5amr2526103c88.4.1771945620575; Tue, 24 Feb 2026
 07:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20260224091118.4017760-1-sunil.khatri@amd.com>
 <20260224091118.4017760-5-sunil.khatri@amd.com>
In-Reply-To: <20260224091118.4017760-5-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Feb 2026 10:06:49 -0500
X-Gm-Features: AaiRm50Sd_SdzbvRklz6HUv-f8hF7VTlVAdDMkPp5E60VDVXtWCRsiuxLoxUJPc
Message-ID: <CADnq5_ODja_P+9uae4X0P4=sB_Y5HLHnpEeoNRRShGLCcuHFrg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] drm/amdgpu: add upper bound check on user inputs
 in wait ioctl
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 24, 2026 at 4:11=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Huge input values in amdgpu_userq_wait_ioctl can lead to a OOM and
> could be exploited.
>
> So check these input value against AMDGPU_USERQ_MAX_HANDLES
> which is big enough value for genuine use cases and could
> potentially avoid OOM.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 4f9386677c47..e31b2c6cc73b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -636,6 +636,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, =
void *data,
>         if (!amdgpu_userq_enabled(dev))
>                 return -ENOTSUPP;
>
> +       if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +           wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HA=
NDLES ||
> +           wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +           wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> +               return -EINVAL;
> +
>         num_syncobj =3D wait_info->num_syncobj_handles;
>         syncobj_handles =3D memdup_array_user(u64_to_user_ptr(wait_info->=
syncobj_handles),
>                                             num_syncobj, sizeof(u32));
> --
> 2.34.1
>
