Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CFCCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 16:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2107D10E0DA;
	Tue, 26 Aug 2025 16:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MAt5xKKx";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5261410E384
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 16:29:51 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-32749113e0fso80145a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756225791; x=1756830591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NC9oCSqrEOCOuzmEfslvCD8kTekySKni/q9783N7MDI=;
 b=MAt5xKKxz4Yrn0iW2Y3MkdRsmIFoayImlOJNnz100CFjWQZgs0wkOZNzH8ygC1aH8n
 JNl95wckLT5Rv0kDci4fVAEe/7G92NVtl6q+zD/tsT5MkiKe1oiOf88+myd8Vs20fNXJ
 RETC1bqOIgxJzySS/CfKGaRL68eY0vSPYt1E/MUSFEbWMsKepHkYOaiqfL30JzwhmKTn
 h+h3cdO2hTskmZydCjD260EUspUfIrrGSDfSjMGQFAvSTg1+aK1OA4WgZLMawObTkJjC
 Hv/CS7GcoTVvp+0LZm2tRb3EVZDeAhjtpK2tHOXsMQy1z3nz9H7N2JNEMGM7SAqXCFX3
 +5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756225791; x=1756830591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NC9oCSqrEOCOuzmEfslvCD8kTekySKni/q9783N7MDI=;
 b=b9xLmkMG+0Awn21MT18JvxnavIlW3JMUF2ef/wy9pMI/ScKF9Yl7aNjssSkk6vdqKb
 7qEXEa34CLJGs/D09RYaCcG9XWc8vYFz1BO2H4lXxvhn2FpBmv1tsV0hY4VI/wIW8yUS
 rTffNZxAF3+4GIrnVXhg/7iubiu6gL9LtIUx1emATeh75SZ4rz/V+cyWWnEYeCKOGSC1
 7AxWXEGkf49XsgVKxvM5VtALCsY0Gc3w0mGTbFyb0F75xzNZJmFzciWw5KufPgjqFPKn
 lM0oE+Om56XPc4NsGcS6eM75LQSS0vOPy6dSLmV01bxCXrPBPU/kNV9jvQM6NmQgc6VF
 3vyA==
X-Gm-Message-State: AOJu0YxnBMy0tBVYht+mU+LPgh/ZczN5JeM/6wn62k3X4Y7lXn6iSbJQ
 GkdASbST3pBHkPxIuOXdEyQ5ySYvHf6e8G3BNY5RXKZ1xEf/mLBL/g12af0SH54Ca3mVqtNmVHq
 9UtmrdS5sMnqOYrznDn5rWWFNlByGeMY=
X-Gm-Gg: ASbGncsS3yBkRcITKyWOOJdSd3M++gV41IIEopIAgZqk/MsDti+3JIrC/N8Oe0/HLon
 I+LzRTr3fgBUx9g/7DU1ZlOjvXtiJ+hA15uTpMdMd9AcCM0h5EvebBsiDTCYDNerBGQJ41MgfON
 Q20CYYrphWq2NZvvq7ab2qyMgZsC7AE9OF5J+gjsVYPdoEdxFK8pb/YpBRHsbmgVHMjVOvB0wuC
 7IezI+TQHt6niUXxQ==
X-Google-Smtp-Source: AGHT+IHiL7fy8g1eXr280SI7EbPPm/yYJXiDx0NcbtBMqcKb0c8oUlUHtdPkYci/Aa4c9CCdAjR7bi/szqLTo4rdwHA=
X-Received: by 2002:a17:90b:4d01:b0:31f:3d6:6d98 with SMTP id
 98e67ed59e1d1-32515ee8b50mr11714887a91.5.1756225790708; Tue, 26 Aug 2025
 09:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250825133742.1494754-1-alexander.deucher@amd.com>
In-Reply-To: <20250825133742.1494754-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 12:29:38 -0400
X-Gm-Features: Ac12FXws0QO4Z5gsKXe8MU3RPgcurFOnYPc-1cHSeaDyNrHu1B4aLCIWvdhLdWo
Message-ID: <CADnq5_MkPtrrVeAZr-8HfP1EAYsc8kTB0+pohgmAe3ABFC8qyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vpe: cancel delayed work in hw_fini
To: Alex Deucher <alexander.deucher@amd.com>
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

ping?

On Mon, Aug 25, 2025 at 9:48=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We need to cancel any outstanding work at both suspend
> and driver teardown. Move the cancel to hw_fini which
> gets called in both cases.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index 86573c8d9b91e..474bfe36c0c2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -436,6 +436,8 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_blo=
ck)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_vpe *vpe =3D &adev->vpe;
>
> +       cancel_delayed_work_sync(&adev->vpe.idle_work);
> +
>         vpe_ring_stop(vpe);
>
>         /* Power off VPE */
> @@ -446,10 +448,6 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_bl=
ock)
>
>  static int vpe_suspend(struct amdgpu_ip_block *ip_block)
>  {
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -
> -       cancel_delayed_work_sync(&adev->vpe.idle_work);
> -
>         return vpe_hw_fini(ip_block);
>  }
>
> --
> 2.51.0
>
