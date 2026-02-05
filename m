Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4EFECD9AA
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416E210E121;
	Thu,  5 Feb 2026 21:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y5g9nNXM";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A1D10E121
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:42:45 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1233608c7e9so148883c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 13:42:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770327764; cv=none;
 d=google.com; s=arc-20240605;
 b=Z6N3wQlLqHhpzZ7R9cpNNmwOZguud0IBtQgUmJordGPTQLZl2qS/WgB4PXsuVwoplH
 +/AJn1N17sWTujtoHaQsTdd8r2oohKAhZozolRPuoMjZjRK990KlTDTjrmYlwxQb9qCP
 n7i7a//mUmpCxhv0RiXMMnm9gUT5IIlSON8VHuZTwIMOc16Yhnw91/yaMd5dAVgLiPDM
 krLk/E9IppU+uGPvMRNUN5/7+r3Hgr4PUKNgHEA3ns7V9KX68WPvDhCZTted6yGlROPA
 wrelQfLXBc/SaIJkFW1i5yA25X6LcQnbGJxeIjugkkpQKr1hUl4jUHMluteUYzHIJnwr
 j+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jqX+DprsFvZB5zTAP4HE13W1FXGMCPu4sC/TbLP3B3g=;
 fh=M2GbSnAAXpxi5vo3oGWldYpN5R//tkIkxRwRgHWl3d8=;
 b=WBgd/REefG4DMNowK3DU+Y/PGo6ItDEKrX3Yt8QSlrnxi9x/3uxnAcoKIOlUTDIhvq
 pPaIv7uuKSSJCi7D5mmhByflc89YrxK951ozTaxNnEfdlDdmv3S8YXa3DTWXrjhiz9x5
 q38nDGirJ+2sZwqS71TCl6Plf6a3Zp071ojtr+qQkFLYL8sxCmpiwW4InZ3qP4ZfFSRe
 MmtF5j50IneHBjirQ3KgY2OdICqD+xhUNj+3bs9Gw54S5HOl4UfFIewFG/WTjgC+N76i
 Nvo8PsCTefv9bWV4gdF4nOgMPB4/ypj6Z0czzv9pXN3dnqd1uCGkyg4PweqBl1nOp8H6
 +Y2A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770327764; x=1770932564; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqX+DprsFvZB5zTAP4HE13W1FXGMCPu4sC/TbLP3B3g=;
 b=Y5g9nNXM0+hg3GMI9ewClqMCfOqI8x1LUK2OTo4GD0TU3INN7Pu91dqs0QeEJJqZ4F
 C9XHVnw60xrI7unLHD9NumtyAhGx0SBRweWCBR+AsyryEHuZetHktbWSjbUyvG04mclP
 frIyFH7uCUS1lVM8GUg7qykOeN+txPMWbEUCQbGZLHRoTVXeYAQ6fQJR9piPqC0kK3gV
 u56FyykE2kGr1GHOqw5X+HbgD2ybp5zcJw2p+X7uVAxnTV/oqIrVPTrm0cioZb/uVR1u
 wAiEKDLJtZDgQxpPZOXjPy3LhHEhDAddVmUGaQcGwHURaDIP4632X/t0m1socod25KzK
 6/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770327764; x=1770932564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jqX+DprsFvZB5zTAP4HE13W1FXGMCPu4sC/TbLP3B3g=;
 b=OlwXQlDXfX4fRpjLvNSdhoWoHAWLUca/yVgNeBzbk55vA32LChm1ZlOZjg2E6SSr+d
 sBV3zxOW6WK1jmx74NE4iPEfMs9nRiitDjArZTw+zUKfcGUy4AInsq2qI7hQEcnDZuSZ
 0HIHgbeQOA3kXsdCIDESMf8/4bBm9d23smUcb0TLB6Meth3MQXKLN3mMKMbwdfdJlq0T
 qdkCd6LQbI4SxD5tkds3UjDIEKank4Ge5CUE84v9IRGLUTWg1C35CrBioviJp7AkvLrf
 /hZdDkduFebwMeRE+KW6o3x/8IHOoxW1qUZrmNKf0bric45pCsR5y2ikimaTv3HHzzJ8
 rS1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGCSwGGw6Py3GhqZqZF6VVYCK/SEU8QZM5GltoXs2dXI3UId6fZRU4Yeo237hnLiUx5Fm8jEEz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzysTCkORdWXU9ay2rf8iHnC4D1SGV6b2vopHmHdqr9wE6dg6KN
 mgbLFeXzWqbymnjFLARfl/DirAkmz1CX2JXI5oPkLb6STfV415VmIyOWeZkdqqCuotcYef2CXWZ
 eKqdVsn9c32N1MIRmkbkpj/KXFHvxq5Q=
X-Gm-Gg: AZuq6aJu1Nw1BXUHUwx86yd9arR27hdqRh6zQZgqDBWxHCH/5j3UAKxws/uwDOasxwG
 HfWKab8SaWCrurFyEXVsE3TOwZhyYP77tzSVBv7dJBbOeLwrIwVgRq6AskdUub8jyDcwha5nLSC
 9l8CWvIok3wqEAGlmaRsXIMzwnuKBrLTY0qjlsZNy/+DRy0slKp7sGGDSoWLVOJ9RXAAxoh2cXx
 tMOKQoinXGJIbYA5kYuPOjqW3c2xA53hLtUqJ8wmf0MVc7sm6eoR9rWJQtcsrgcyq7CI1bj
X-Received: by 2002:a05:693c:3003:b0:2b0:4a1a:657 with SMTP id
 5a478bee46e88-2b856723fe2mr122494eec.8.1770327764469; Thu, 05 Feb 2026
 13:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-9-perry.yuan@amd.com>
In-Reply-To: <20260205065130.654921-9-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 16:42:33 -0500
X-Gm-Features: AZwV_QhAyULykn_HjS21j5yhpdbVjdU6473kgxUzHML8di-6-P62DaVLs4OPmZM
Message-ID: <CADnq5_P=S+B7EDrRNh9YR9UBOKf6=rT52KHHS+g70T=TwmfbQA@mail.gmail.com>
Subject: Re: [PATCH 09/22] drm/amdgpu: add firmware version check for PTL
 support
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

On Thu, Feb 5, 2026 at 2:17=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wrot=
e:
>
> PTL (Peak TOPS Limiter) functionality is only available starting
> from firmware 0x0036081a.  Add the same firmware version gate in both
> places that already verify PTL hardware capability:
>
> v2 change:
> * move psp and gc version check into psp_performance_monitor_hw()
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

I'd squash this into patch 2.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 9cb30f3e21be..a5f101ef51ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1252,6 +1252,10 @@ int psp_performance_monitor_hw(struct psp_context =
*psp, u32 req_code,
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       if (amdgpu_ip_version(psp->adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4=
, 4) ||
> +                       psp->sos.fw_version < 0x0036081a)
> +               return -EOPNOTSUPP;
> +
>         if (psp_ptl_fmt_verify(psp, *fmt1, &ptl_fmt1) ||
>                         psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index a970913ec66c..d94bf21db281 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2376,9 +2376,6 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct =
amdgpu_device *adev, bool sta
>         uint32_t ptl_state =3D state ? 1 : 0;
>         int r;
>
> -       if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 4))
> -               return -ENOTSUPP;
> -
>         if (!adev->psp.funcs)
>                 return -EOPNOTSUPP;
>
> --
> 2.34.1
>
