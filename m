Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C667C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B4F10E560;
	Mon, 28 Jul 2025 17:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X+pY1dM0";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C8D10E560
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:59:53 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b3f2f8469b7so389394a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753725593; x=1754330393; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXt/Fmw0HUO8c3T31k9Ixdhr2dBg+kbb9Cz0K5uj0S4=;
 b=X+pY1dM0impp+4e9vHwJtsksUuZG3oQcxtyglc3hAO1GYlgbBpwTBaibp2WSkoxWws
 iwIy2Dm8v3/ABsqh7RMpmUTaWv82ulBTmq0PqqqV3yCrxqhEUo1OPe/K1vdJtqdzs1wg
 ksy2YdkdkdvL8eixdSwJE3uTYIvuy3OHlqDHpbApGqvE6NSAn1pYzXO53XtqgmBLFl3d
 sx8k0i2LE2TC4yZ+8YUJcAYzajmf/kXDzBxZHSUggdS+4p9s18FPDMcy3NGdLkRzg3oQ
 ZHHKmwp45FjcwDQ2VPcGqYeKhku2E0mUdfXuWKHLBKqQCUhMP4noYaWtR7GGBcuj+/wn
 9vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753725593; x=1754330393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXt/Fmw0HUO8c3T31k9Ixdhr2dBg+kbb9Cz0K5uj0S4=;
 b=wdI+BYJeQU6tAcQtow5PkkLRImxueY/0oE9A/YPh7tNT6uGmSoQnpAijFs3jFGFWjf
 z5bzVqyDjB5f4VUJeVUHR0P3Ea9CMRkGPxSTMwIVisAyEq1HVWHN404t6zJpjmX/Fsx/
 YrganzqHj1t/EqKq3gcdUSAqzUBnTklFDli2TVMDqha3dlQn5uS8KS+mID/kKMDug2yX
 qX6QtKAbsROywDm6wDJhc4PFDe3VUfazPw2+suNBNuwxYErqr/0zdeE+eyaNMAyOTcRz
 5saUAHRV/dT9zzA1C6SStro+401ViroUW/twMCaZqP1ZX0ZQ2+algVytg259gsPQpJ/S
 kC9g==
X-Gm-Message-State: AOJu0YzwJR20qxPwlm803L3iDCFUzpZJen4bSyzHRDJbTxqvrkuHZksO
 qZ8Rrfy+bumiyvAHMKflTL5H7dGBM+1a0kj9szDxoOGve6gb5flRy2erPw/4ChGItVpzApnAkws
 cB+Qxh5g+1177Y/45pr6ouoaDfiTDW3mgkQ==
X-Gm-Gg: ASbGncu8B1RDz3hhaNQRxAL0vfvarQ1y1rpoiVKKCe0nBhlmSHPWFdXHzGukVl0GVp+
 DzjP6x2lgRCf01yUHH3sacSUmhDWubXqNPESE2YvI0mvMBdzvVhUnrBTwqzjTqmS7VtECOvm6xM
 SwKSaD39NA8Rji3unoAbLBC++n93ugWNAt9SNsq+KhQnYUDrF9F49lCu+Yxpdrd7rcqPJOW2RMn
 Zk4dxropRsd6Z49S8Y=
X-Google-Smtp-Source: AGHT+IHVD0J1UwKz8YL065FWaBr3IAJC5VuhAD4SiGCeiogl/NkBFVVDRHD9Gym5NIni69B5oe9P4Udwe2LMYzQu5MY=
X-Received: by 2002:a17:90b:4ac5:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31e77a4a596mr7182285a91.5.1753725592801; Mon, 28 Jul 2025
 10:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250728130128.875-1-Yunxiang.Li@amd.com>
In-Reply-To: <20250728130128.875-1-Yunxiang.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 13:59:40 -0400
X-Gm-Features: Ac12FXwKuvpw1vhdT5AnRX6H28zK302YHdOQ6QvwSLWEfztnFTbYyVfxb2JHQ5I
Message-ID: <CADnq5_NMU+_DFNV=grOQ4SpH928HSUEF2Z2msom2j0vR06JyTw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: skip mgpu fan boost for multi-vf
To: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Mon, Jul 28, 2025 at 9:18=E2=80=AFAM Yunxiang Li <Yunxiang.Li@amd.com> w=
rote:
>
> On multi-vf setup if the VM have two vf assigned, perhaps from two
> different gpus, mgpu fan boost will fail.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 684d66bc0b5f..e0faf7200ec5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3389,7 +3389,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(void=
)
>         for (i =3D 0; i < mgpu_info.num_dgpu; i++) {
>                 gpu_ins =3D &(mgpu_info.gpu_ins[i]);
>                 adev =3D gpu_ins->adev;
> -               if (!(adev->flags & AMD_IS_APU) &&
> +               if (!(adev->flags & AMD_IS_APU || amdgpu_sriov_multi_vf_m=
ode(adev)) &&
>                     !gpu_ins->mgpu_fan_enabled) {
>                         ret =3D amdgpu_dpm_enable_mgpu_fan_boost(adev);
>                         if (ret)
> --
> 2.50.1
>
