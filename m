Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C16C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 17:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE63510E1C9;
	Fri, 31 Jan 2025 17:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lz+uUl3K";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1E210E1C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 17:17:30 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-216325f516fso4586095ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738343850; x=1738948650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5hy936a4WObp58nXdi8du2aCfhjTYYkP9pKmLCBuZw=;
 b=Lz+uUl3KDLrZhjCH3rftqIyqXLRbKbjxAtpSoeGcbyZDPz21fp9UNqte5WfI8wOo1x
 Z3aOEgfafA2xAtEbR+Wsn9Jw8zjY8swmW9WnaNF/OtOLEspMvrkxNYwGYOWHDBs4Hrks
 Uv1ZhmArQXBQ/mbugxgvFkujqWa/EjsDd7tiEhnnfisBiXSFYuo8DL+x/1axalal7pYJ
 oEDuhqUokbFVfYY3Oztd8OOsGBEH6FiyLg4y1dc1RGN6e8FmOtHH5MJtLhCPl819kHNG
 iL2iko1D5x7h0zenmi12gXqESVtlCHuHhV/VAWdY55D7l5hsEprKf3/fSGPAPVbXw4NU
 tHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738343850; x=1738948650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5hy936a4WObp58nXdi8du2aCfhjTYYkP9pKmLCBuZw=;
 b=kw7KrCDPgF1kM0t0+Ovnv78MwJWcfADRhhN2NX9TS3Y6VXgvel+3hsrFOPDhi1vZG/
 qhPpVPHOdrP5ZlNOm3IYgE12khUPq8ML7+WGN8iBSMMb8OfdYshs5xceJJMSEKAWZDrs
 latUg0esD6mA8s9fR51O8wDstt3tjuCcQePJLe4Q3h6COoG+QnZvp1y+sT2Xj77+plUE
 yFnZNdkbLS1QpUIzOvsjofGO0ziT8zJwqZRgNyEsbAdIzkFYwBodcil974g89yzk8+jk
 BRbXSJKeq8uF3Db2gyRD+u5HcPHK5jB6hx7ZEmTmJX8NeTVCh1Hqjf3vs6OKOMTxqZIW
 mnwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7XqCgiSyRA2azTT3eW0xIPq9cmCCgInC0iNPwNNhmqYOGhQvXGM3m83IkGRCN6QxsHZmrPboy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDeJSp2nRAJWIFJHRt5r1C4zrZmC9vUGHQgR/yQUDimAphsDNI
 Erul1UoxULGeu8Cuxls5Dev8FSPLcv+d6hfiDynZlxvO0b7tUvmPpoxau4SoD37RQ5VzBk9ZPu1
 KKCA7QRs2oif7X8LC9rzYIFtC7DN7ow==
X-Gm-Gg: ASbGncuB0sNDcQuLxx8pzHPOFm2dmA8xh4Pxm9P01EVLFrpDXjJbs0KPT8AZGn0WbLD
 bxSaiZEqnfFIVIhwDsTFL06VZKH/Dj04qmuXSq+V8Z7241Fn2YZ0grlUhycCm8fl6rDK8BdNg
X-Google-Smtp-Source: AGHT+IH3ZZ7xe4+AgQeD2MUYwnmC9v/EOzyWiWUcDlZx9kiFu6Ynu+ZOiw4UI0SKkEDpNY6XUmdy8SfNwvf47MHPDGM=
X-Received: by 2002:a17:902:fc4e:b0:215:431f:268b with SMTP id
 d9443c01a7336-21de1d0449fmr45004965ad.1.1738343850133; Fri, 31 Jan 2025
 09:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20250130205110.811511-1-alexander.deucher@amd.com>
 <20250130205110.811511-2-alexander.deucher@amd.com>
 <f152e8ad-f547-2db4-e1b2-c2edf0a8ea62@amd.com>
In-Reply-To: <f152e8ad-f547-2db4-e1b2-c2edf0a8ea62@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Jan 2025 12:17:18 -0500
X-Gm-Features: AWEUYZlFG7DO5BchTimPWkku9LzA0cNQv-6fRAhj56khk2iE2WelYugNxmZyEA4
Message-ID: <CADnq5_PJCQV-Yv-W7X3nKDZpY_UK05kP9mJ7D1nZE80FCcdgeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: use GTT for VRAM on APUs only if GTT is
 larger
To: Philip Yang <yangp@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Jan 31, 2025 at 12:13=E2=80=AFPM Philip Yang <yangp@amd.com> wrote:
>
>
> On 2025-01-30 15:51, Alex Deucher wrote:
>
> If the user has configured a large carveout on a small APU,
> only use GTT for VRAM allocations if GTT is larger than
> VRAM.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 9d2a3e2ad9df5..96ec26946db60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1985,8 +1985,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
>   (unsigned int)(gtt_size / (1024 * 1024)));
>
> - if (adev->flags & AMD_IS_APU)
> - adev->apu_prefer_gtt =3D true;
> + if (adev->flags & AMD_IS_APU) {
> + if (adev->gmc.real_vram_size >=3D gtt_size)
>
> This will not work for MI300 large APU, maybe the condition should be rev=
ersed
>
> + if (adev->gmc.real_vram_size < gtt_size)

yes, sorry, I reversed the check.

Alex

>
> Regards,
> Philip
>
> + adev->apu_prefer_gtt =3D true;
> + }
>
>   /* Initialize doorbell pool on PCI BAR */
>   r =3D amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.=
size / PAGE_SIZE);
