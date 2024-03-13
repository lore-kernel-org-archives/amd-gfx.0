Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC3DC54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 13:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EEED10E056;
	Wed, 13 Mar 2024 13:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YEfnY/T2";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D539710E056
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 13:17:30 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-3c1f5e14bdbso2533390b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710335850; x=1710940650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DujU72uZmx0vxgEKHs7K4qoxSV34y9gEJ7f2jiacTE=;
 b=YEfnY/T2vcz/kWNr2KURhmLZwpyZohsZsldy7Gd8a1+Kv6TMe4Ook7CLZhK93miGpJ
 vIt5Kh4eBS2c+UkRlvUncOIc0yRD/5bnRYH/7lACWoLbrzT2d+TWTWMYG+WBzEZakH4C
 IIwIPmmxIJvVONR/z5zyb440N02HPKc/W2Oa27mE3qy8LSzPAeabQYp2OH7hWDN94ofh
 h37TIxs0DCifVULHtnAQCIDSfhWQvYXLaxUih2ww9SGY5MtiKDFTPXCs+Zq/FmD3mOuy
 k/949P1C0insJJjPzxCbw7VQcdAeCPxXBD9PjuxLNGqBrVtzMlG5ztV+ASxzNoMpQ+Zs
 f1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710335850; x=1710940650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DujU72uZmx0vxgEKHs7K4qoxSV34y9gEJ7f2jiacTE=;
 b=ggqRib2bzlO9Cv0cVZHn/VfpFPliZV++M1SUWX2wN2m1/tbsECR6Evm5+j7tEVfFuM
 0t5tuoymU1SCTN8V8MK+p04XqQda7pHB9cW+tJ3So2FMdoqKH1l6jU6eZvJFeJAWr/OT
 egQtuxKcJ8Kk5CX0+Y8GYLD/51SCa4qF1EjSpJeggtw7Mh93iqUxcvYZaYLl/kr+RNSK
 N6Ww2spVYAiKoemgZ841DMkMVxqSPvM76U5SV3LppW7JaHFYfj1Wq1CuOzo6euXoHPHO
 tNegKnV9OST9AXTlTwWoytY5+S1tPYvH3Fe4gK4ZAB58dhzXtpTPNOzW/PWlh/xcPrOy
 e2mQ==
X-Gm-Message-State: AOJu0YzX2QRs9S/agX0Y9DegcmDDNjswDMk654n1AZP86lbIFDrAtO7y
 ttvxrSSIThEhzca68qYDdEN3C7KzZEZ2zuQGA20ZST5Mz/9tL+FMzk0mmqWH0V6s4ANyplLqgwm
 jYiqM0cVtn6rFynOv1lYHqR8+Fi0=
X-Google-Smtp-Source: AGHT+IHjWNttGCNqKVOwTZa0PFgGrvYTxKitbjkIt5VJRHVOdvtMbdct2cs9CRHJc4z2o9W7aoqkK7ApVz6JHczaGk8=
X-Received: by 2002:a05:6808:22a3:b0:3c2:5bff:db05 with SMTP id
 bo35-20020a05680822a300b003c25bffdb05mr3860453oib.10.1710335849746; Wed, 13
 Mar 2024 06:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240313114451.1592772-1-peytolee@amd.com>
In-Reply-To: <20240313114451.1592772-1-peytolee@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Mar 2024 09:17:17 -0400
Message-ID: <CADnq5_OTwaLWJ9LiicJu-hO+WDF6fPB5PFQWzAqopyrDVn6R5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
To: Peyton Lee <peytolee@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Yifan Zhang <yifan1.zhang@amd.com>, Li Ma <li.ma@amd.com>,
 Lang Yu <lang.yu@amd.com>
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

On Wed, Mar 13, 2024 at 7:41=E2=80=AFAM Peyton Lee <peytolee@amd.com> wrote=
:
>
> To fix mode2 reset failure.
> Should power on VPE when hw_init.

When does it get powered down again?  Won't this leave it powered up?

Alex

>
> Signed-off-by: Peyton Lee <peytolee@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index 70c5cc80ecdc..ecfe0f36e83e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -396,6 +396,12 @@ static int vpe_hw_init(void *handle)
>         struct amdgpu_vpe *vpe =3D &adev->vpe;
>         int ret;
>
> +       /* Power on VPE */
> +       ret =3D amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VPE,
> +                                                    AMD_PG_STATE_UNGATE)=
;
> +       if (ret)
> +               return ret;
> +
>         ret =3D vpe_load_microcode(vpe);
>         if (ret)
>                 return ret;
> --
> 2.34.1
>
