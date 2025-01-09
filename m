Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C71E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 20:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D8610E118;
	Thu,  9 Jan 2025 20:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FMHgJBAG";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A0C10E118
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 20:06:06 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2ef7733a1dcso263960a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2025 12:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736453106; x=1737057906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzQdrXHukF7Jqx9UICdIQqxq7mVhC3Pg+ITqWVfyK1Q=;
 b=FMHgJBAGyAyCAwBy7cR5KxKNyFQkVSyXkX9+jbeYrblfJ9awI++OwWkROzar/iJ7+r
 DAk2lD8PD+3Tk5YsLnQ4zlGkLRRE4jbIRda9FCqol/BzpnCjc7eF+T7SQLM3bi62DGsT
 X4u01+1FkyKh+pUV5klKPOCtb72N5MhYQ3GUeHFbhJ6Kd4LMNp2V5Yji0/pJk/C9oqVw
 4sPB7tycmkfTjHb3ErYJ3Ea6qAT5x/tHwiuycEEWegyGE0e3FVzYIG/Gw7SP5EJS414p
 g9IYj8qujj2pPlkTIDWUx3u3wqXiFMOrMZ5IyXDjy5TaI9c5gHN6M6HXRGtXkA+1pcVB
 qYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736453106; x=1737057906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzQdrXHukF7Jqx9UICdIQqxq7mVhC3Pg+ITqWVfyK1Q=;
 b=HNkXWykdbnMaGkAddepIS4bKoospPDbx7r5rOaVKHMcypeo5oz8yetwp1l2FF/8HQk
 9Fv/XfYHQ+uQQr3SIeQBNJAWHJPkcGiizk9XxghekUK8Iy7UJBGYU6ZUGBJ2Ua7LqUm8
 Y6grmp0x3wBRSpZ8/jBSvCv6yaRmBoJUMMaLlSzzUZ4htEXlY3o/F7iKWqEeyLa84Iu3
 Pm+K6bR4KpVi/MW1qeaHDMJtXDIcU95w8USJTGCt6luRTk4GtCgDtkBcQqlHjEMWWQjt
 eVjMgxCBzK/Z2S5qNw/f4MGNhraRY9jzIYFGCMeb+qWU6APE5PseXdBzjIYU8W8g2u/q
 6QZA==
X-Gm-Message-State: AOJu0YwRIVN0ERon1MkghIeVM9X+/n+ecxT4694yfA6UQlBFIKZf/MdO
 tzxAdPkJffRqxwKUiM23Bjmoyf+bAVi3bFGAoqx5b0eZY5NZiRoviZTdvRjizssV1/Rg+Sh02RV
 ppuym65aw/vUshFqh9YlAcFkDm+U=
X-Gm-Gg: ASbGncutEEDM3eVvDQg4ZZmYjir/UvGhltFBCdBOSpYdtGZem8hyVzw33JyICbZ3rGE
 JOrI6vZpPTkYU5h4/1vFESvpq75xiZU+zfDmKwg==
X-Google-Smtp-Source: AGHT+IHwmsggsH01EkBlMGxka8JkQBE8D9yfazd1xkEPNVijN85aAva9slSc3fuZ8k/jPcA3ryVdGtnEUQO+bjwW/ps=
X-Received: by 2002:a17:90b:538f:b0:2ea:5e0c:2851 with SMTP id
 98e67ed59e1d1-2f548e3c0c8mr4561091a91.0.1736453105834; Thu, 09 Jan 2025
 12:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20250108151829.1495321-1-kent.russell@amd.com>
In-Reply-To: <20250108151829.1495321-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jan 2025 15:04:53 -0500
X-Gm-Features: AbW1kvZXCXUlkCE6EPUCBRJnvIzOE1pVdtlY9B14U-OHEiHCdjIulJf1MxwTyE4
Message-ID: <CADnq5_MD3UF_7of2GVg3HwUSL0-bOHfhS6c+ueP-mUkEfmDTHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Mark debug KFD module params as unsafe
To: Kent Russell <kent.russell@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com
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

On Wed, Jan 8, 2025 at 10:18=E2=80=AFAM Kent Russell <kent.russell@amd.com>=
 wrote:
>
> Mark options only meant to be used for debugging as unsafe so that the
> kernel is tainted when they are used.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index acb9dc3705ac..1371b56beba2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -751,7 +751,7 @@ module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p,=
 int, 0444);
>   * assigns queues to HQDs.
>   */
>  int sched_policy =3D KFD_SCHED_POLICY_HWS;
> -module_param(sched_policy, int, 0444);
> +module_param_unsafe(sched_policy, int, 0444);
>  MODULE_PARM_DESC(sched_policy,
>         "Scheduling policy (0 =3D HWS (Default), 1 =3D HWS without over-s=
ubscription, 2 =3D Non-HWS (Used for debugging only)");
>
> @@ -801,7 +801,7 @@ MODULE_PARM_DESC(send_sigterm,
>   * Setting 1 enables halt on hang.
>   */
>  int halt_if_hws_hang;
> -module_param(halt_if_hws_hang, int, 0644);
> +module_param_unsafe(halt_if_hws_hang, int, 0644);
>  MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang is detected (0 =3D =
off (default), 1 =3D on)");
>
>  /**
> @@ -810,7 +810,7 @@ MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang =
is detected (0 =3D off (defau
>   * check says. Default value: false (rely on MEC2 firmware version check=
).
>   */
>  bool hws_gws_support;
> -module_param(hws_gws_support, bool, 0444);
> +module_param_unsafe(hws_gws_support, bool, 0444);
>  MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers =
(false =3D rely on FW version check (Default), true =3D force supported)");
>
>  /**
> @@ -843,7 +843,7 @@ MODULE_PARM_DESC(no_system_mem_limit, "disable system=
 memory limit (false =3D defa
>   */
>  int amdgpu_no_queue_eviction_on_vm_fault;
>  MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM=
 fault (0 =3D queue eviction, 1 =3D no queue eviction)");
> -module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_evicti=
on_on_vm_fault, int, 0444);
> +module_param_named_unsafe(no_queue_eviction_on_vm_fault, amdgpu_no_queue=
_eviction_on_vm_fault, int, 0444);
>  #endif
>
>  /**
> @@ -851,7 +851,7 @@ module_param_named(no_queue_eviction_on_vm_fault, amd=
gpu_no_queue_eviction_on_vm
>   */
>  int amdgpu_mtype_local;
>  MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (0 =3D MTYPE_RW (d=
efault), 1 =3D MTYPE_NC, 2 =3D MTYPE_CC)");
> -module_param_named(mtype_local, amdgpu_mtype_local, int, 0444);
> +module_param_named_unsafe(mtype_local, amdgpu_mtype_local, int, 0444);
>
>  /**
>   * DOC: pcie_p2p (bool)
> --
> 2.43.0
>
