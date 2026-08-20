Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A0CC5DF85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 15:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F47B10F098;
	Thu, 20 Aug 2026 15:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JJw/gOGK";
	dkim-atps=neutral
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307C510F098
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 15:05:36 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-739906c1b32so24529137.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 08:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787238335; cv=none;
 d=google.com; s=arc-20260327;
 b=H/SpO1inZgnWeYPCzJYQklJfcfi2Shpdq0WVnqPv80q0WEJWmQ/PTmroB3JV08RLk7
 JLfos+RnDXt6ub5xJeYni9OVS+ZjsHyxGnDWSKzFMfsjBzE6X8BVJpBcLLAPyAymwrJA
 LBTmKg2rSAfu2tioXvTogEaNDned5+GgeLnZYVzROpc274NcY0JY3aMbkNAJwoso5LYo
 ZwuyZ1cYW050pwWn/mXVxitDfyMKb7RSABUZ6pE3TW6HcRe2I1SVUXD9gjrRYVMF8wb/
 u1iV3tNgcOITKerTc7OUPbozdD02zFuTF7kps/HeV34PAnP6j5PAqRmOLk+i2/IMQX0P
 KK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xJjAhRNLRi7+I1TYSq9USODUZZnKTG0KSnmzfnkVVBM=;
 fh=sjBhvESLaW/EhyR1JeRMPVrGAZEVhivFcDDWAoTEjJE=;
 b=X04oKHy091+yb5A8XxKRRnGXuGPx9TGmM4JqZSNKCUb4sQ2cI0dBKluJ+pzeasuvK6
 YhCl/p4wDzo/aEWd4GiDrSIrdTWOtW7fMfK3ew9DA7F0ngxUTcvfUrM7hlv8pBwf9gvU
 aY1pPKHLl2o+VGmoGakHCU6F1ntqesQmw1sEneg35CjUTppc/lAd1mnCfjAuc6NY7NE0
 hqvbtPWC80AM9N4/St2I7wN4gnBLfQSQHStLdjKXnQE14W+bJWyNpadgF4TMcDavnH6O
 8ZKbTvLSgr8vJrNQcpSxeQcwUy3AbwJjhJPZhFegqbFPzGY1MBRC48otP8SF6Mt2RLsm
 I3zA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787238335; x=1787843135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xJjAhRNLRi7+I1TYSq9USODUZZnKTG0KSnmzfnkVVBM=;
 b=JJw/gOGKYeLBcdFwxLhoozv9P6/TUjAjC0S0KsVoRbhCcsVa2d3W5VR4u07/C/YgKv
 HeRNoiidxHBGjQfba19UBo0lLviMtIzwmhCI+OUNGRqmj6+f9rfhA1U/8iBuE1N0qL24
 /kiu+h8/gPBWBxrdHIeBPs4r89VfqHOKSKAqoso7HqHpRMGcwIh3BvrB8kEPwDYaqe58
 JOT+RjRGA9vxZFWDJN9eMKjx8amyaomf02DUut6X/PqTCRT8BwJGxy3Sfo1Mv2n2Ecjl
 uWw1ZNfgS3/Y56LfycoOOc1gbK5jVFlGf0N0E8P3FcTCdNw8cZEYWwh0RMZbkSlitDgf
 4nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787238335; x=1787843135;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xJjAhRNLRi7+I1TYSq9USODUZZnKTG0KSnmzfnkVVBM=;
 b=FALzL/eo8DBwgkptptiZcKm/92FPqe7XTL0DtGG8dDbUQwyemLCD0MqrPpU7lixFlh
 bcELE1Jo20vrEEw1dRJHgOMaYde6WBd6kxTgy1xkDoZorMzg5VOoDb+FfLxrvt/OZ23y
 r3mI7ve74wDXmLebixahJ+kKnDdpLyi9iB0vkLiGBIs4OLhcGbTuejyl2MBLdEqelP/d
 yAwucsENQcj6tKFo+0QDBz0ZzqbI4V5lzj6bpKl2jrIXZJltLPddZv+JqXCPh5Wc5RTW
 buvZI/bMFFbHK1aXV7Cy0uGK6i+o96hKupMWlVJcy5ZKAiyOscOho/GmE9LERAQpF4V6
 MCRQ==
X-Gm-Message-State: AOJu0YzRr/2nNnyHZPDLOXGAilbGnKy1RfRwsJjRVFBfNs7KQSoSnnoL
 wF6Lqqgyh1Js5gLcp3PsKhayChElRtjRbTgaGkQdVaMirhrXwFiy7lMr/IhS88Tr6NfLnjfSFEm
 L4M2clzbLsERS20MYWJ6/3R305TEbMko=
X-Gm-Gg: AR+sD12NGeDMvLSvhF6Wg++vBoEeZytC3OUHu6ACReUMcsW/FBMxXIbZ30DfZYIEl0O
 +H+2UQ8N/DjSG7x+oOIBnGXhhvAwu0aaEsoCWI0pJh7h9DsHEVGuVpPjKNfQKwEAEPFTrBovc1P
 6YU6gyQgCji3ys8V7xfDk8ipPSFeNpSBtitIKN/iOmwz4DX9Wx5Ryeh4F7rkzGmHv2zvG9qH1B3
 WYBdPUk3k+7htKj3NCpJMc6k5JcxQdX/xyRqj4qM+AutXKQWhYO14jaxn4NhXHHkSfJieTJ7lhf
 vNfMXUgCL7sKdvAsqx4Ncfe78Y32kRx9idCY1HvwgcKkRSmBhmNasmeWmXqGmT6C4NiGqUZsbO/
 7Nt+Q/KmWsOpU23ITJx0vfwULVKg7nLg=
X-Received: by 2002:a05:6102:8516:10b0:778:5579:c65e with SMTP id
 ada2fe7eead31-7785579c726mr1080516137.2.1787238334846; Thu, 20 Aug 2026
 08:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260820144727.12484-2-david.rosca@amd.com>
In-Reply-To: <20260820144727.12484-2-david.rosca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 11:05:21 -0400
X-Gm-Features: AcwNN1XkdNquP1H8VulfTRBxrGvKrToyDlfVspzhcxaRXP_J0qUsFZOauwrKnCg
Message-ID: <CADnq5_M+r+Sr3GXRr9O_jqu9zcVYRuihVfczpU1PwFoO1vw7AA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix VCE 3 ring align_mask
To: David Rosca <david.rosca@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Aug 20, 2026 at 11:01=E2=80=AFAM David Rosca <david.rosca@amd.com> =
wrote:
>
> The largest frame is 20 dwords, so 0xf mask is too small.
> This was always wrong, but we were lucky with the VCE_CMD_END
> commands inserted after fence and vm_flush.
>
> Fixes: 7591335141a0 ("drm/amdgpu: Implement insert_end for VCE 3")
> Signed-off-by: David Rosca <david.rosca@amd.com>

Do any other VCE versions need their masks fixed?

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index 9809a23fa521..d5adccd3e689 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -890,7 +890,7 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_p=
hys_funcs =3D {
>
>  static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCE,
> -       .align_mask =3D 0xf,
> +       .align_mask =3D 0x1f,
>         .nop =3D VCE_CMD_NO_OP,
>         .support_64bit_ptrs =3D false,
>         .no_user_fence =3D true,
> --
> 2.43.0
>
