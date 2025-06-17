Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59119C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 19:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B5F10E066;
	Tue, 17 Jun 2025 19:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i8RWkOVH";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5874E10E066
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 19:51:41 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-313067339e9so1025543a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750189901; x=1750794701; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADwsG6ai4laZkE+aFMhdesTRJJxk5iGpdMpUoJxwFmo=;
 b=i8RWkOVHe1/28cfOpopiGxwCY7mU8+DmOLSYLSE3aMyeEii+R7BRP2sdBkawLDDxXA
 Mutp9fnfHGuaCD7pmLbc7gNcLVT8YQhEAuZ2KvP6COFWF1Lahgbll9PYUTR2J9Auurkg
 BlqF58XZmvrWLAQfvN75v7P3pz6rR3I3KzmmTtEPiM+hAPVc/yZlHZaktI6Y+v+QwlCp
 W0V/GZiFZ3Tpig43Y+vcyf6LXU2DRVPZWs4iexshXIDqHk58fVuVeE4LqfbUzjJCj9ku
 QEwfvU+imAbJRSUByc79yzlqoplKSbMD4dC5cTOV1SFBE8NVAODUXwups/RkwII1I5BQ
 FiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750189901; x=1750794701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ADwsG6ai4laZkE+aFMhdesTRJJxk5iGpdMpUoJxwFmo=;
 b=mB9ip6MttivZ6A/K0pDbrmRHRKm/nc5/3cQjJy3ntWO0w4dAiZ+asWi/1GXa28boKl
 sZXypfThU9jVbNSQoVOqm0Y6KjvDIhx8M+ELE0cyPt5sPsqL55t6eH2g0UATAiAOUNR4
 +h1sR4zLQV/HfUtpgYPR1rLNK83sv8DeizaOTUQkaViHi6PGHZMOCeHkN6BRXI2zbrRY
 mkycd8GVKBSkZI1VODjdzNFMJW86MQbXbjyTql1Fnu9UNDRmmCg7VJ7vn5bpaiecoE2/
 k3FiLuaJ6i/IYaBxXHFgxoThZGZg5B0i05OsX32v9vgseedh7ytuyu+DumhKowwtH9nC
 z4gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7wJ1ruFu1j6tmIdqNaDqZKB54a2UxMWnP76OgCUO2uyQqAWCPDtYf+SR8OO4IB2araazGnYMf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyRDl1hZZWKU4CLjVwXPQPbEIRzx69NFTq1mXLiYNqCBTpeHum
 FPwA0n5/iWXml4aas1IFBeaqA8tBIXcgF53eK/jIDxejIc8RC3TtK7kdQoaXzVtBi/F7CtVCqSN
 cEYrblNDr4xJnFlzcZmkv/MmDrwRosuMZNQ==
X-Gm-Gg: ASbGncu+k1mCWb/ApMBDSmwgpkOfil3Cy0AeAV+m7HiO0ozLcdhR3MAnbg99bVw/JTg
 V68PmPzOqvZQ7OzuOVnCe/j0pKWdtU82pIwukxNxvWa3qS/gYC9AtkvkoaqDBocPuXWvPuV7j7k
 J8OsrKk/730iuhhDJZRg9fwxX91ub2HuBEMdEdJActYPpL
X-Google-Smtp-Source: AGHT+IGyMNkUdwUPSL0q9R690DeVDd5Wrp7a7dhoyKgwkK+CE+2RkAldEn9IQJvbyn6fBMOvh3FPTAuXpjEwSr90dGc=
X-Received: by 2002:a17:90b:1d0e:b0:311:c1da:3858 with SMTP id
 98e67ed59e1d1-313f19d2a0fmr8005999a91.0.1750189900643; Tue, 17 Jun 2025
 12:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250612144751.104030-1-srinivasan.shanmugam@amd.com>
 <20250612152245.107031-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250612152245.107031-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 15:51:28 -0400
X-Gm-Features: AX0GCFv4Ti91NYhhUiNifJI5pSMi_ncWhmvrYjYFLOwJ4_hg1GaSKXDCJ76A3vY
Message-ID: <CADnq5_PLj9v10P0RLFc5=JGcoWoVrL8o_i6PFOfekNJMXY46dg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/gfx9: Add Cleaner Shader Support for GFX9.x
 GPUs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Manu Rastogi <manu.rastogi@amd.com>
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

On Thu, Jun 12, 2025 at 11:31=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Enable the cleaner shader for other GFX9.x series of GPUs to provide
> data isolation between GPU workloads. The cleaner shader is responsible
> for clearing the Local Data Store (LDS), Vector General Purpose
> Registers (VGPRs), and Scalar General Purpose Registers (SGPRs), which
> helps prevent data leakage and ensures accurate computation results.
>
> This update extends cleaner shader support to GFX9.x GPUs, previously
> available for GFX9.4.2. It enhances security by clearing GPU memory
> between processes and maintains a consistent GPU state across KGD and
> KFD workloads.
>
> Cc: Manu Rastogi <manu.rastogi@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2: Updated comments
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index d50e125fd3e0..866e39f6fab3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2235,6 +2235,25 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         }
>
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(9, 0, 1):
> +       case IP_VERSION(9, 2, 1):
> +       case IP_VERSION(9, 4, 0):
> +       case IP_VERSION(9, 2, 2):
> +       case IP_VERSION(9, 1, 0):
> +       case IP_VERSION(9, 3, 0):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_9_4_2_cleaner_shader=
_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_9_4_2_cleane=
r_shader_hex);
> +               if (adev->gfx.me_fw_version  >=3D 167 &&
> +                   adev->gfx.pfp_fw_version >=3D 196 &&
> +                   adev->gfx.mec_fw_version >=3D 474) {
> +                       adev->gfx.enable_cleaner_shader =3D true;
> +                       r =3D amdgpu_gfx_cleaner_shader_sw_init(adev, ade=
v->gfx.cleaner_shader_size);
> +                       if (r) {
> +                               adev->gfx.enable_cleaner_shader =3D false=
;
> +                               dev_err(adev->dev, "Failed to initialize =
cleaner shader\n");
> +                       }
> +               }
> +               break;
>         case IP_VERSION(9, 4, 2):
>                 adev->gfx.cleaner_shader_ptr =3D gfx_9_4_2_cleaner_shader=
_hex;
>                 adev->gfx.cleaner_shader_size =3D sizeof(gfx_9_4_2_cleane=
r_shader_hex);
> --
> 2.34.1
>
