Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDDDECD9A6
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950D010E122;
	Thu,  5 Feb 2026 21:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IbfrdB8s";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE3210E122
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:39:22 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b71e7dab12so107595eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 13:39:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770327562; cv=none;
 d=google.com; s=arc-20240605;
 b=jEGIzNG+MbE6YubzNp5Uiq+HrvJNT9PUn9C6jCWzPUM38Wvl6Ou4l6fDYsFx3Z7SUy
 xEJepOHbLjpW1tsqsd+AtMLpFJGrHnR7udphwRLWmI7bjeY3PbDpmOqNl5AIjbx9i4OL
 0axxpkWbX6z2/zXdky+xx7PpHH0flwbGbSLFX/YTe5yIjpylKOdOzzbILkhvkbNPQ9xT
 KhWEedLNd4EG5Nu0cfRQn3SPMEJpGPyb/hIHF4oZSG9CxZLM6hFP2aqTYrLuoBKYPIbv
 Uz0GOEwGegkPYbXevEikJ8ppYKzpv1fjR1CdkorLE9RPCM9vzTKzdvV2kykT2QTWBdi6
 lMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MG+A4ghnX5cfIstymqLN/VU6PxPNNqM2aR4YXrkvn+s=;
 fh=+Ev9AEqoCzcCpxAOMGG3ws/C16Jv7PZdXX9Fjj2//a4=;
 b=Zx6QPCJ5JEmWuhMQghT/kMo6T01LufNw3JL6srNkaVew59GTBFhvdj7hGQKaBAxgZQ
 cwV8uuDxQBzvebozwWZTbWnDeT+l+7A5+Qp8feo7hhs5cFUgP5xxKFBagCfc/3Eg38m6
 GocNU6xIICM5nPwFUoTNvv/LIpYUGz1sRVYz5CWQTwYD810RWW25i+W5/f2WKEJtgwxQ
 UANB8Oesm37B4YlqiWAbh0cJgnAryBnEFBdowaJW2xgnOQvWZ3ko+ZOzXNiQ70nZclKU
 3FB4tgVUtK3ji0A6WLo458dTpEQfOq7mLtnOkR29MMHnsIusO32Pr057FiiG0PJq6odZ
 wzdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770327562; x=1770932362; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MG+A4ghnX5cfIstymqLN/VU6PxPNNqM2aR4YXrkvn+s=;
 b=IbfrdB8sa5k0ABUxzPgxgn4aaK3agO03EAJC9N6x21su3t9qfPYZFIGSLjJE4ElbVz
 3K95eDJ5Tnz9fVRGRZicGhzeg3BS1UR17pJ6FAyXxuVNjPfeaAtuNNHmu5fEqrmM++QW
 SSsAPYYkDSP9KbnDZMbymW9/n6RmABDm0kEth7PCg+NV04VpkvKFxmK6ne5frSegILVl
 a3P7LSMG18DLQ72IeMfLW2BylDL5Z5xDPl+Oz5EHm3b55Ku0p2/H422SH5EBBqjyHUC4
 33qPq6EuH00ijN8HJx6Y206FyVUp++1v9zRodbPAr91oXVLtVpVDjxaoaOB8IKbs1UHY
 DYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770327562; x=1770932362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MG+A4ghnX5cfIstymqLN/VU6PxPNNqM2aR4YXrkvn+s=;
 b=W/GSr2kQe7DGyTgLG9nKLXKmzDTRfyxWK9tkEdV1QzCXdWc6LtWsob89Q6NZ4rMPU8
 4iHRSaV4vaEgkNC7cyf0bWHmuM4gBjti0ZW+p0B6Jaskq19Uo3mN/jDgQosrDUvRE7C7
 hiwmbCutasBQiMdK1T33n1n4EqCDFOBTpvBNvkAeFivWwAB/MUBIKn/6gp4ETKg1CYM3
 iTaaWaNw/IyNNAl3eXBSoA/HO+et+49vknqXNSeAWnQwX6sI+jRW18UO1VB6WB/KV56g
 VuTa0Hog3QjxInzbksyrBp2SxBwgABTsVR5Uc2sZUJiLHe4H8JM14Icb0NJUNlB7AnKE
 tiLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoYFMoA8m/ywYO/PnyX6DNUIZ2ofOtyKKDDmZXfu/wl4onja59TS4sTMyQThqLPU0sbxs8PVJm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcnepwYFIg2FWmGaV8ttUWMJCI8Tghr0tUJj1/U4nthWMLJZuI
 /mgQv4wbaS6XT/BoMzy43D7dxM+4x4/M/Hq/tPR9vLmC6oA1U2lj1q5GNEK79ltlyw0FsLr08mb
 NwLL1dLs1k/LN7gyzprYQzy5Bw8k5JSQ=
X-Gm-Gg: AZuq6aJe2Y62I0kWTQ7HWfodsoIQfXAdbcoUYR2pmsL3JnFn5SJtKmCvACH8ZuKw2gZ
 3g1MHzVT4nNawTWWelI4xtlNFk20tTQ9NJKnmY3hWMZZTYMjBNe96GDFzE/mjEqz7Zmqz6+leLG
 DWJGuuOu7BODsVNSg+aCgSU3g7NSIXYwP7VRBVgMMfJBPYv4f/S3Pf+Co6qLckVsjX9+2aol7r8
 9h9xJbrd6sral210ffdi1o+X9RnQp2QGh4JvujtFXrO5lDoRUUtKBQhlAuyyCH5K7zCzCoW
X-Received: by 2002:a05:7022:e992:b0:11e:3e9:3ea5 with SMTP id
 a92af1059eb24-12703fedaccmr159357c88.7.1770327561952; Thu, 05 Feb 2026
 13:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-3-perry.yuan@amd.com>
In-Reply-To: <20260205065130.654921-3-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 16:39:10 -0500
X-Gm-Features: AZwV_QjvuFo7FukjcGRgaSxym2_XMWsUPryl4WVIu1FS6j45w3zxJXOLaEN79bc
Message-ID: <CADnq5_NKQQ3RgK9UZZsx7iFxu08=A=rrOE4gcfCq5RYbfHHoqA@mail.gmail.com>
Subject: Re: [PATCH 03/22] drm/amdgpu: add PTL enable/query gfx control
 support for GC 9.4.4
To: Perry Yuan <perry.yuan@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 yifan1.zhang@amd.com
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

On Thu, Feb 5, 2026 at 2:02=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wrot=
e:
>
> Introduce hardware detection, runtime state tracking and a
> kgd->ptl_ctrl() callback to enable/disable/query PTL via the
> PSP performance-monitor interface (commands 0xA0000000/1).
> The driver now exposes PTL capability to KFD and keeps the
> software state in sync with the hardware.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 36 +++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index ad4d442e7345..a970913ec66c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2370,11 +2370,45 @@ static int gfx_v9_4_3_hw_init(struct amdgpu_ip_bl=
ock *ip_block)
>         return r;
>  }
>
> +static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, =
bool state)

Rather than state, call the parameter enable or something more obvious
as to what it's doing.

> +{
> +       uint32_t fmt1, fmt2;
> +       uint32_t ptl_state =3D state ? 1 : 0;
> +       int r;
> +
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 4))
> +               return -ENOTSUPP;
> +
> +       if (!adev->psp.funcs)
> +               return -EOPNOTSUPP;
> +
> +       if (!adev->psp.ptl_hw_supported) {
> +               fmt1 =3D GFX_FTYPE_I8;
> +               fmt2 =3D GFX_FTYPE_BF16;
> +       } else {
> +               fmt1 =3D adev->psp.ptl_fmt1;
> +               fmt2 =3D adev->psp.ptl_fmt2;
> +       }
> +
> +       /* initialize PTL with default formats: GFX_FTYPE_I8 & GFX_FTYPE_=
BF16 */
> +       r =3D psp_performance_monitor_hw(&adev->psp, PSP_PTL_PERF_MON_SET=
, &ptl_state,
> +                                                       &fmt1, &fmt2);
> +       if (r)
> +               return r;
> +
> +       adev->psp.ptl_hw_supported =3D true;
> +
> +       return 0;
> +}
> +
>  static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int i, num_xcc;
>
> +       if (adev->psp.ptl_hw_supported)
> +               gfx_v9_4_3_perf_monitor_ptl_init(adev, 0);

Use false rather than 0 here.

> +
>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>         amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> @@ -2549,6 +2583,8 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_bl=
ock *ip_block)
>             adev->gfx.ras->enable_watchdog_timer)
>                 adev->gfx.ras->enable_watchdog_timer(adev);
>
> +       gfx_v9_4_3_perf_monitor_ptl_init(adev, 1);

Use true here rather than 1.

Alex

> +
>         return 0;
>  }
>
> --
> 2.34.1
>
