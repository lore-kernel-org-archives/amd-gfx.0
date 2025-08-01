Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F598C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 14:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9EB10E859;
	Fri,  1 Aug 2025 14:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Weu1kHxf";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A148E10E859
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 14:03:21 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-23fef63da72so3822355ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754057001; x=1754661801; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8adeH62axoIq/DKSfe5XejZ3ToooOfHkkLz+AVHDH0=;
 b=Weu1kHxfAK8ZWYH/UmYWiDLFguVX0xZpw31fXZ0LA79mVS8E9OiK6Pl4zZ1ZpRBXN7
 h0BUeitZUYan5iyHpAo3x1BY4rGoBwD7OvOmDwGRnxSB+gmNF3MCdjxQOT5gDRGVxrVt
 s+7ljjDq7C0D/wlDLYOgkgX5vQYlzMwfP+Lo4S8vti2JiWKlLDJ6r4vPdMtmhA9qhUQW
 ODqiRNX7w3sA9TM0ryGjGYVzEjWz/VfuXA9N/uqF7ugb4TLrgs2edUCiRyr39IbI8dag
 7s0N4G7LXBYBCql3vnVp2p0KUk2iP6qbqSjqWhe90tyNnZskgiM45rwuVN+V1k/MxVN5
 hT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754057001; x=1754661801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8adeH62axoIq/DKSfe5XejZ3ToooOfHkkLz+AVHDH0=;
 b=M0molKp5Zr9g12+KQDhzCFWGLdVZ5/VkVguX5mIk0XOalskvkGj878ZvF/3BOACPnB
 aCYJJ0c6oJlqZdE5ZXzeIlEAt9LixT0888ZyK7Nvk+TZAE7fVFOE7j/6KTpzjjRDVz8i
 3tMD1YcusHO8UG8FO7UNDeNRYXue3K1ZHbfPauaFrGBovdJs/NFzsmowlO5XJlknYU56
 BPGjUA6xDW1OpiEvAst9ekw+BCcejKlyfNk+4qH1sdOUdaX6GDL2ovAFUsg+1kxy/6YO
 YCCeEMa7SIsytsdFAg1oB+4jUkDdKLHgP2GdyFP7Ez+YS4P54EBSKkp0EymC6EDGy9Pb
 FZBA==
X-Gm-Message-State: AOJu0YzzNA/kDJtM/7opyJGZJTY9UIUld+c4TD9YFgVHUoGQRmQ2R3zi
 3W++orDOttO/JbjI5lSIXx84gVFGujdlE2L640MjBMKT/50KH3NzSe+Lt2nG9qZqWv79D9IRklo
 Fob0EjvsEQsGiKa158SNZ4PqC9ul/OBg=
X-Gm-Gg: ASbGncvWuIidWnGDm/yTN6eFxOCPt3WKEKvIv235svTZZiU++VH1IC3s7M8NA10EFvA
 6ip+PclfHI0wIOQt+cyk2Q7tUkoR3ps3VvCGcQCsYzoei+wXdQe0eWDH6SIET6fBDQSFdROECsM
 Usb/dOp38IHpvFidzsg8P8b+LteIysNTGvWw3lfP9EKRrgLgUcG4R6016KKBWx9mGp2qCMusDOg
 fqbkC/M
X-Google-Smtp-Source: AGHT+IG2F8ey2QD23aBUz/AMTUrD365Atz6NrdDOQZbXB77qVN+qcJUhGXee0s6tSezDFA0WkDvyt+Cnw8HE9muLfRI=
X-Received: by 2002:a17:90b:4c48:b0:31f:3f3:4516 with SMTP id
 98e67ed59e1d1-31f5dd9ccd4mr6770412a91.2.1754057000694; Fri, 01 Aug 2025
 07:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250801074020.4099827-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250801074020.4099827-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Aug 2025 10:03:07 -0400
X-Gm-Features: Ac12FXxenn0n4j8-OWFJ-yEg41EdDbpo9pKP5zGWygoRkRmQ00RcXAvnbY232AA
Message-ID: <CADnq5_Nf=V2Q--_kPfD2XhXVSXGJsMn6vFxw9cF42qZpa5rwOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Update SDMA firmware version check for user
 queue support
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Fri, Aug 1, 2025 at 3:48=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> This commit fixes a firmware version check for enabling user queue
> support in SDMA v7.0. The previous version check (7836028) was
> incorrect and could lead to issues with PROTECTED_FENCE_SIGNAL
> commands causing register conflicts between MCU_DBG0 and MCU_DBG1.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Please add:
Fixes: 71f82efdc1ad ("drm/amdgpu/sdma7: add ucode version checks for
userq support")
With that,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_0.c
> index ba1f3e3b6eb6..d50db12a44a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1357,7 +1357,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
>         case IP_VERSION(7, 0, 0):
>         case IP_VERSION(7, 0, 1):
> -               if ((adev->sdma.instance[0].fw_version >=3D 7836028) && !=
adev->sdma.disable_uq)
> +               if ((adev->sdma.instance[0].fw_version >=3D 7966358) && !=
adev->sdma.disable_uq)
>                         adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_me=
s_funcs;
>                 break;
>         default:
> --
> 2.49.0
>
