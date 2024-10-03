Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B492BCF34AD
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 13:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6498210E85C;
	Thu,  3 Oct 2024 13:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="esWuwD+O";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1B810E858
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 13:51:30 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-71923694bcfso117532b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Oct 2024 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727963490; x=1728568290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dG4W8UaCYPYrexTYO6QXFe/KxQ5wKFiHXn1oE9+dSPE=;
 b=esWuwD+OZl5uhZgs4rRzydX4oTgvj2lPpQ7EEXKzYOkJecRgPURmjAjIFtpABl2rvO
 pTuYHZJZJsn/yqCtXeyoHLLgEvMSmNEOeb+akbe4J4NS1btVnTKqPjbPFwUOWIW6Vhgd
 aXYmIIlKAOkX6Qey2Nd63s8D/oErpELyP2BchMhXnu956RyCfxoyhZcZXVBewbaUm0vN
 71f7NGpZBbXCFfgUX/kNGOdhaOrI+JtLcgCI66qw/7xXBjaLU1aATqO1ZnDum6vqdy8k
 gAVypE9hm1jSXEdDLKPj8t+9Bvd/6vMY9cG0d+SuaenUWm3wClf+kbDMVPnWB8eGlIDa
 +Hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727963490; x=1728568290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dG4W8UaCYPYrexTYO6QXFe/KxQ5wKFiHXn1oE9+dSPE=;
 b=xN+cah1zKa2u8+n9TMpIanmdhKdh3EiUJ9NDfuWLRFchYFk4UQoyMv6YfHtSpy1pfP
 VuGJ2OJtxQr9GAyh0njWNffBJQS4AUBPVfli4UD6GmoK7Z92dM3chhNv0/WjhBlfJG65
 5JwUDjicCY5vPfTyQHMcvPb2ExEWO2fm8mkp8bkWqaZ078ETzBmGaDsVEPEmu543RVmQ
 3ygmdcL4fJjPa4goD14s44h2Cf+UyXMn7FVCbcnGxHG+JZhdu7YC6OJk5sFyrUdcTM9x
 Wgs0yAe1QhU612n3Xvu/nZjJw8usQRTZ807L+gust0uppgKdaeJzomnD+HqQC3bv0wmM
 9zEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTwPzuYFVi9Elpi6QVQrJvq2JUmJ2b8S8af0byL1i4iR9fMUXhA18C4jmQNwRXgoxjw/zVUIn+@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxd7HVsc9ZucUr0nTTuTAKHVX4DPYpslGfxNB+0gar68LCVfxke
 NzofjdYcPeOzwVQ9MfyZ3i6JedtfjjVVwhxVQiFRX25RXBc7ITlU3HPvc1Kn7D49z1zwkRuo5bB
 wdZOosmN3NvHCSV7fUwh7O098x799/Q==
X-Google-Smtp-Source: AGHT+IE8zc8XWOR5sCPupCF/QH6nTA2Z9v+PP+kUuZD7Cz2FJaVbSl0gZBoHdHFXV9bXvMy8V2SVD100QIVXE9/Z93A=
X-Received: by 2002:a05:6a21:328c:b0:1cf:405b:edf7 with SMTP id
 adf61e73a8af0-1d5db13893fmr5422965637.4.1727963490334; Thu, 03 Oct 2024
 06:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241003134947.268245-1-sunil.khatri@amd.com>
In-Reply-To: <20241003134947.268245-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Oct 2024 09:51:17 -0400
Message-ID: <CADnq5_PBxtCZHeQ4Cg7eEmO9-jgF42WHxdBrVkM0kazLO+qvmg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: Clean up duplicate ip_block object
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Oct 3, 2024 at 9:50=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> remove the duplicate ip_block object in the
> isp_hw_init function.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_isp.c
> index 416e8b3fad79..adc0b80ca5db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -54,12 +54,6 @@ static int isp_hw_init(struct amdgpu_ip_block *ip_bloc=
k)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_isp *isp =3D &adev->isp;
>
> -       const struct amdgpu_ip_block *ip_block =3D
> -               amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP=
);
> -
> -       if (!ip_block)
> -               return -EINVAL;
> -
>         if (isp->funcs->hw_init !=3D NULL)
>                 return isp->funcs->hw_init(isp);
>
> --
> 2.34.1
>
