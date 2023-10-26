Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE94C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 18:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED07410E863;
	Thu, 26 Oct 2023 18:57:35 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC2510E863
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 18:57:33 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-581cb88f645so734177eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698346653; x=1698951453; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8t8wBFMT4Tmk37rQeOn8kE+sbcNA34U/ODlKK1hrZs0=;
 b=J/iHc1ttmNu1c0jqSDMPmo4UnrXcDKIIgm/vGrqQy4mx6IGy9ig9HqmGwyp7/Q5l65
 pa77BmZYIbWq6A19SCNFHrDCr/bgBPOlJZeJBpFJ9iM/lY2VMXJ1bjZ3L1TGAsRnxSpC
 rvHEICkBpSCeHLJ9pQjKqZENdbtd7ptewLES724A3ki5B01z1klP4WKaCAv7tIhWvnB+
 47HI8BZNslx6VgvS7YXwOCuL6mN4bmuBi7+0SL+AaFpHBlU2nptGI4p0DV5FIZw/ojtj
 fxPWNX7+A9mpfBzTZo8PFeWVvwN8ZZrnrB8Y9SsXQOl/uFgA5Nh2Eg2BD7hy+w5QwWOv
 iZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698346653; x=1698951453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8t8wBFMT4Tmk37rQeOn8kE+sbcNA34U/ODlKK1hrZs0=;
 b=S+deOk7jIOBd1z2R4Ap4r2V/Z1JoJ1FcAky8uNBLy1WsX0OnXVoz+RinwRgJqigaX9
 pe2dhUOHvYQqdWbE0sRRgVRWYnPcTBvaCjrPmJFdotJHdYtovitN99HNpah2YkvHfEAN
 RAYjQi5rP4vTIbMdHKEDv3EWH63IwJ6zFOVeHmnTQHoCKTdhP5K40ZpOGIqHsQEVb16h
 Z5PKNrH1yJvr/U/lKs+9e9euOmp4niXwZGecOamV+ZuI8DYleJYKGK1Nt1VmmaNcA46c
 wHIWctX+lGSpTgOX75ONNSlifUUf5d9jczTODdAJydCOlEt2yeK42xpxW+HAU2L8VnZq
 8O6w==
X-Gm-Message-State: AOJu0Ywnhrts0UfoOBYIqBcBA8KaiquZswsG25WRv0bVMwh/yHw6r/kL
 NA7nFCzF8iCby/XM3QZXdAoz3W/Hv8G82Tg9KoiXEf1L
X-Google-Smtp-Source: AGHT+IHNc7bjymrqY9wuZGRpnzs2ViDyMj5jyFL5jiDncWLh7WOjqHa8x4MyJ/UBF8zGzOY7E/2klIQbgMnshXaxlEQ=
X-Received: by 2002:a05:6870:120c:b0:1e9:bb20:e71a with SMTP id
 12-20020a056870120c00b001e9bb20e71amr405827oan.51.1698346653025; Thu, 26 Oct
 2023 11:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231026172914.31796-1-hamza.mahfooz@amd.com>
In-Reply-To: <20231026172914.31796-1-hamza.mahfooz@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Oct 2023 14:57:22 -0400
Message-ID: <CADnq5_NC17SDjuuET8bqfETvKeRKLoXtzuoarX40tpZ2E1h2YA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix S/G display enablement
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>,
 Mark Broadworth <mark.broadworth@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 26, 2023 at 1:47=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
>
> An assignment statement was reversed during a refactor which effectively
> disabled S/G display outright. Since, we use
> adev->mode_info.gpu_vm_support to indicate to the rest of the driver
> that S/G display should be enabled and currently it is always set to
> false. So, to fix this set adev->mode_info.gpu_vm_support's value to
> that of init_data.flags.gpu_vm_support.
>
> Fixes: d059c2ec6a23 ("drm/amd/display: enable S/G display for for recent =
APUs by default")
> Reported-by: Mark Broadworth <mark.broadworth@amd.com>
> Tested-by: Mark Broadworth <mark.broadworth@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 781d04eda3d4..adbeb2c897b5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1641,7 +1641,7 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>                 init_data.flags.gpu_vm_support =3D (amdgpu_sg_display !=
=3D 0) && (adev->flags & AMD_IS_APU);
>         }
>
> -       init_data.flags.gpu_vm_support =3D adev->mode_info.gpu_vm_support=
;
> +       adev->mode_info.gpu_vm_support =3D init_data.flags.gpu_vm_support=
;
>
>         if (amdgpu_dc_feature_mask & DC_FBC_MASK)
>                 init_data.flags.fbc_support =3D true;
> --
> 2.42.0
>
