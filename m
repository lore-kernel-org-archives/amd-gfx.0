Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29B0C55184
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 15:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363C310EAF1;
	Tue,  4 Aug 2026 15:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PTb9IqO9";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FDE10EAF2
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 15:36:33 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca5b707b78aso340898a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2026 08:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785857793; cv=none;
 d=google.com; s=arc-20260327;
 b=DNjubEyECzmHoV5j3yCpRfZmd85+J6u/YVQmSj/TXCFMXhsSphpAV6rGT3ZSeCROH7
 3w0FTZ3UUlLfyh4F/It1CxtMFi99WY14wE8uQiNnsWnvwPF2uXjwDNeG9ZftbT1/GYvq
 Rkj9rn53zmUhRaRFJbmysJyighkxS7yP289WywAJcQcUzK8gWSIUrmuvHKOqFOH3w06o
 Hbw0+/aMeliPDQRxmRuN3tY54fyNSmJa7OUNGm5W/Kyof2W8U2fFvG49TZWvKNedL48m
 r3XFb1Ukf6sVAc9Dx9kM8oDt3j4wE1+vt9DAjPUpU6Tj+1OW9n9HB8NPsOOkHjBOmxdK
 6hNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CDsU1S+3T4Sr2oPUYu9rRfJcjPaPYUA/FwkgGzIYeYA=;
 fh=WBTyrPiTixMkQNbOAtwLLl8VtP8SUcf8VMTDSqg4NsM=;
 b=oUPpm9As88exWk5y94eeohk13aGd3gZqtrXHlMli5Eq2xETyAhtxoD9GA8czOgJuUe
 KTO+b6BTd9hnG9GhR8vA+2Le1+Vq9zZwe89bZULSTw9sEj5u+CFPbbFxPj1IjDO7y4nm
 30UvU3gjrVR5S3bsVXcD8d+47XOHdDnA+odZFB5zPLUbMZXBUgsTfhGPWmOkGhLqXrdA
 D17rtJiOgbtPxE4uDpPk3ihSBjIxAFYg0NpKb3EwSqaaPYYDquWyVaLM+b6cS+q9KomO
 dh1UFdageqY6TwCj+/lQHLG8JlBftMh1KUv8MYOhvz21VvjPImQvO2dq5wBVJihDjrVU
 EXXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785857793; x=1786462593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CDsU1S+3T4Sr2oPUYu9rRfJcjPaPYUA/FwkgGzIYeYA=;
 b=PTb9IqO9WXG8Fr17Ndn1RdS2SY4IrmhwGNNV6+6Azy//FR0+y2fwxfoQ6LZBoKnKSF
 mzuGPUNBAr/zYYmQEMgoZG2PKETm2zmRbOaGeVmbcRA8fsbb/2F6fWp/fae4qDx325JA
 NbUFo0n4tcEzX5zZJ+bCyY40vyH15cYH5cVoubsrcsvEMVruRXt5GPfn/t99RLNP5v+m
 sEWetE6O7GbhkleT0r/GugsrAcpdF+IIhDh3bmIxQbG0Az6c2taDHdzcWRWgJe0FK7C0
 3C5CgP86YLCizrGjPb/lyibrK2zraFkZh33dXlSQjQ2sMHCO0q9gYiIcE0J+8chl8d5B
 5DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785857793; x=1786462593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CDsU1S+3T4Sr2oPUYu9rRfJcjPaPYUA/FwkgGzIYeYA=;
 b=aEOONwDTLUqsWTFUjAZz9b43PzS65GQ8TZ//TQx2C1b6PnJmPUT8irVABymZoHkIKG
 zO35ZPdNIzGtpwQNokiS3FUM1aoW02emZCQdx3nKFfexG4qXkLqlwB9P7YOBraPDgguJ
 C4SZTWYTQPCe2vFo897O/1e5Zen6QCzPF9QB5YsZgCO7jouTXQJM7PENojl3cIn69pq9
 PdKweVJZdmIYSz34eCGrfFmM3p4fwzm3D2zFEcB6gnNgw4ji5d/+4mRHBYvgMszMLxdL
 T2LKtBxxIaCi+2VX1KIlefQKbqjIpKQxC3kKbyuF6kKO12yFq0yyrTF3qaxa+zJW0Vlb
 Lsmg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4RA1sbs0WKPPamH7udG9qFWuxAPhv5f4qEuJpYqizw/GfW3yCCpKtUdgHaMmv/sZzIwOOT0/T@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz++I6ptVffOrK+Y5FbjnMfIHyKQFG26dIsKWxC/DFg4QFIvf8g
 QogZFhwmjKnwlyjFnQOI5SuyaLqXZ+nO/h5UT8w7VOqKwz6judPXrlh5rtGFWm16DAVAAtHT1yn
 6t97MRDKwFkmr+UP1ycVLI9bYcZd5bCk=
X-Gm-Gg: AR+sD10AVTBYk1kugs+ooGw2kEMJIxzgAr6X8F+qt6KkuWpvkUi67I56r8NBeCV33gw
 CZC3Na78Z6ayNwolxoprCCvHY43LKtPJXRkTDRpnGftapv5IEd4Qsg1V0rHlroiOgeM3LV1iBKZ
 W8YXKB1P2eJLYOy5zurukBcCmil9tPp8J3d/eTS3D8VFT0957SP8gwfgio8fhrfj+MbF7nNIyEJ
 iHXKqbSOZYArEMIfks+k1BYQBXlGXQHtEXJZ3I6PgR1KuiyUf5Qo8eoYK4Q7Ui+OSAXLnrhFmgQ
 3htDMcj0uVQALVixPmQUsxXjmsJVuwDgUNl0HferwOkaEa0CidcRCH5/xshsm6ITQ9Q5YNAszJw
 54Ks9lVhx1FxpUCZaT7RD/corvPijhWI=
X-Received: by 2002:a17:90b:278e:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-3903c721be4mr43142a91.4.1785857792766; Tue, 04 Aug 2026
 08:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260617132835.12306-1-pierre-eric.pelloux-prayer@amd.com>
 <20260617132835.12306-3-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260617132835.12306-3-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 11:36:21 -0400
X-Gm-Features: AUfX_mwVPZr4GXOgoFuQ6a4spUwYXFiAddJmOexwhtgA8LhfSz0efu6wxZC8MS0
Message-ID: <CADnq5_M+-sADczApmUUBtYXWpo97EXEcxZGApCiDeT1wU+4gBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: remove useless enable/disable of ttm
 buffer funcs
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Jun 17, 2026 at 9:39=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> amdgpu_ttm_disable_buffer_funcs and amdgpu_ttm_enable_buffer_funcs should
> each only be called once per amdgpu_device: at startup and teardown.
>
> Therefore the other calls are redundant and can be safely dropped.

I think there were originally issues where SDMA was attempted to be
used when it was not ready which is why we added all of these cases,
but I think that should be handled properly now.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 1 -
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 53150fe55350..6abcde8a1a00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3381,8 +3381,6 @@ static int amdgpu_device_ip_resume(struct amdgpu_de=
vice *adev)
>
>         r =3D amdgpu_device_ip_resume_phase2(adev);
>
> -       amdgpu_ttm_enable_buffer_funcs(adev);
> -
>         if (r)
>                 return r;
>
> @@ -4505,8 +4503,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>         if (r)
>                 goto unwind_userq;
>
> -       amdgpu_ttm_disable_buffer_funcs(adev);
> -
>         amdgpu_fence_driver_hw_fini(adev);
>
>         r =3D amdgpu_device_ip_suspend_phase2(adev);
> @@ -4519,7 +4515,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>         return 0;
>
>  unwind_evict:
> -       amdgpu_ttm_enable_buffer_funcs(adev);
>         amdgpu_fence_driver_hw_init(adev);
>
>  unwind_userq:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 6c6ab4dd6ea9..95f879e723ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2099,7 +2099,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         }
>
>         /* Change the size here instead of the init above so only lpfn is=
 affected */
> -       amdgpu_ttm_disable_buffer_funcs(adev);
>  #ifdef CONFIG_64BIT
>  #ifdef CONFIG_X86
>         if (adev->gmc.xgmi.connected_to_cpu)
> --
> 2.43.0
>
