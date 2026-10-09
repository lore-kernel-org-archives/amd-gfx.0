Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDB1CA6015
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 14:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333D310E395;
	Fri,  9 Oct 2026 14:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KroZV3iB";
	dkim-atps=neutral
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 351CF10E395
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 14:16:55 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-7ca805eff73so90237137.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2026 07:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791555414; cv=none;
 d=google.com; s=arc-20260327;
 b=ML2zKWIcQ+tRhc4czYNWQSySdTv/X+sViQPk73U4PRjIPNRltoQszB8qUF8B03LNg/
 5FioL8JzHJaeY1kw0eQfvjwabgXEVeQ/xh3yjYBKyj40gX/XaDIf5WuLDzbSIu7G4OLw
 LwIHE1wS1Y2lllddyrGVFG16B7PTyCp/cmTCW262HqZq9+YBR5yXSjtSQcUCWXlG53K4
 uKkfVmk9M5rk4VrAoZW58YzDlXSkoAYSZkYrODli/50PREOTVaLUCvPmMX3MZ20nOLhk
 APHat3tA0HSJPBRZRsnkk4FR7nAjmq1TU2G0UALZm6MHuy24ePauhBnKlmHOrHtOSxgc
 zXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ngU16oSUfUn/06GAOCoaJDhf7l4oWv6/460+i7tXyNE=;
 fh=8Oa+uAoUpvbCf3G4cxXQbcf4gCavfQje28NIBpvidIk=;
 b=YucmOIx9lz6B1ZliMal3LoHpaGI0/N+0v0gnk7wTMHGDyP8SutEO1t7zmkiFqEXOID
 EE5vtCCv701amUFijmuu8IajDoqOskcYMd9jzNITQqN8wWTwGOmtNiMgX7XgceRM/v4q
 e+MO6ELHEklk3AuPCHDZF85mI2clG2XDRqTJZhGHNCIVug8NsmbH8rg0irTm/Cs0ZzdS
 U0+LNE2ILiCBnhicuVQzw8XSTMRYxAq/AyFg4SUMnC4Fc8zC1rwZYImECQI3TrjPRFHI
 yOXQdrA2igZHsCp+iqyymjb7BmTQJaKSfRQ0P0ywNMJoqmBEB7BmvP2h8ENNwzNbK5hp
 5noQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791555414; x=1792160214; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ngU16oSUfUn/06GAOCoaJDhf7l4oWv6/460+i7tXyNE=;
 b=KroZV3iB3AnxhXBdP7FGaZ0MshqxCVfqtQKhUBiDxE8Z/zcmFu6Aas3F4ulPVyyQlW
 az+US5Vnh2plpeB6lTNCeeq6aVYLzTF8YxDE3D1qTNA0NK9eSq843qRS2WVf5FdD5pMT
 aiJYW6R40GWtHSk8jKYt0DqnyXfmSv8w1SMvyL+E3tkfcjJerZTGzWf7IWKB4NrainV8
 lBdtdIcHyDzoAzXLSNn5H0Uekowfsh0StPSiB6vK9wjOXRN5rjKd6dTy4kh/VVGv51Q7
 OF4XKfNOPeloNmINjwonqmKGdbbT/5U+fPF7XIouDUUC0glnfOYJ0p1LNduH4axXdnIi
 +URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791555414; x=1792160214;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ngU16oSUfUn/06GAOCoaJDhf7l4oWv6/460+i7tXyNE=;
 b=psJ+M++xnYY+8ROlw7cRsDdYIiTXJiGFytpq6expwAKvRr/rPGOKRpUF/cKT6e9AVq
 06jDqBW2AmQmMmuOFClwkzxX8vTomWAAKgMzynz62DCdT+SLQ/wtjcuO7359XLsWRQbM
 OkIFddaakyMsMmSNzV6aSqZw+MeMdWLEwQKajAuckJVbTCyA2z8cDqOTz+UsKk7L4t7P
 Hq6dhMrYtkm8v2ilF19/rc5Xnxp+s/ihlvrgHppii0Y2LcwrGlZgbZ7Byv47S8+V4m2d
 7gVzaSzUBVRlrcetFtmiHW6n9RrAIcNjaxjD7qlFEQi5yd8AfS3BstkCl8mxDoSoZAvE
 e/fQ==
X-Gm-Message-State: AFq9FYIU1AHcMi60+Vb2piMrwYCt0LW6EdB+jzKUHfKVTm9AFUZM3EED
 uwnMlNWIv+IHjn0ZR/JkDI6aXcaCnJ8naWpfafVly71ChCviMp8X1Me9Fjxqrrg0SYpDYdyh1oa
 GrJF4mcfpaMdRrQGepe4aamhEhHQ8hLU=
X-Gm-Gg: AYBFou0T5yDYs1sJWK1flvyrGIP2KQNRwlIVPsNpdqvm1oTeN7IfbckmZOnu7o4vgnn
 G+GGF9ThaFakFZY4EyN1bLiEisC5vWL4OhrYCoE+mpT4/4Q+IJGGpOnJBZ3Espq/x4ZrXvBLxcQ
 ZnUw9wk6DOLjWWuwBv7RzYz3REuorKJVFxuSzHIEyx7D4QXMj/D+fmgNxMIbjc/8zWA+tz9HXcm
 MHBc4TU0j75ApgvuJ2yE+N+UDJ1gsfCx6KoBuRpz2SI0SdW378NF1jEhRwJoBZoxQPyDjYqPEU+
 Ex2J/2fnY1eF/DlDNxMdlLWhnn76jjuGyh2Tj3Zca5+CMKalC+lWcRLuJwLyqNqyGS/Y6+73fHx
 uJzLMDa4N7/v5UtXDAqldH0hcFcYrTR57nxFCDxVaIr70reAVUsrA
X-Received: by 2002:a05:6102:14aa:b0:7ab:e7fa:57a8 with SMTP id
 ada2fe7eead31-7cb361e31dcmr529056137.0.1791555413855; Fri, 09 Oct 2026
 07:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261009090822.4095122-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261009090822.4095122-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Oct 2026 10:16:40 -0400
X-Gm-Features: AclHuK-A6FhITB7AWJUSb4tvPe0CiJAXb8l-01DX6Lwcai66V9eWWFPST0e678E
Message-ID: <CADnq5_OBO68J-pNsA3xi6nVD_MqF=CqgJFkizs3BymYerN6D1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: return -EFAULT from
 AMDGPU_INFO_UQ_FW_AREAS
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, prike.liang@amd.com,
 sukhatri@amd.com
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

On Fri, Oct 9, 2026 at 5:56=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> The UQ_FW_AREAS query computes the copy_to_user() result into ret and
> then returns 0 anyway, so userspace never learns that the metadata was
> not written. With an invalid return pointer all three IP types (GFX,
> COMPUTE, DMA) report success on Navi31.
>
> Return the copy_to_user() result like the other INFO queries do.
>
> Fixes: 44b69cf1d35c ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query fo=
r compute")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 1589b6a6575f..b98091f31dda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1430,25 +1430,22 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)
>                         if (ret)
>                                 return ret;
>
> -                       ret =3D copy_to_user(out, &meta_info,
> -                                               min((size_t)size, sizeof(=
meta_info))) ? -EFAULT : 0;
> -                       return 0;
> +                       return copy_to_user(out, &meta_info,
> +                                           min((size_t)size, sizeof(meta=
_info))) ? -EFAULT : 0;
>                 case AMDGPU_HW_IP_COMPUTE:
>                         ret =3D amdgpu_userq_metadata_info_compute(adev, =
info, &meta_info.compute);
>                         if (ret)
>                                 return ret;
>
> -                       ret =3D copy_to_user(out, &meta_info,
> -                                               min((size_t)size, sizeof(=
meta_info))) ? -EFAULT : 0;
> -                       return 0;
> +                       return copy_to_user(out, &meta_info,
> +                                           min((size_t)size, sizeof(meta=
_info))) ? -EFAULT : 0;
>                 case AMDGPU_HW_IP_DMA:
>                         ret =3D amdgpu_userq_metadata_info_sdma(adev, inf=
o, &meta_info.sdma);
>                         if (ret)
>                                 return ret;
>
> -                       ret =3D copy_to_user(out, &meta_info,
> -                                               min((size_t)size, sizeof(=
meta_info))) ? -EFAULT : 0;
> -                       return 0;
> +                       return copy_to_user(out, &meta_info,
> +                                           min((size_t)size, sizeof(meta=
_info))) ? -EFAULT : 0;
>                 default:
>                         return -EINVAL;
>                 }
> --
> 2.50.1
>
