Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AF9C0218C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 15:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCD210E9BE;
	Fri, 24 Jan 2025 15:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QUZomxB9";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC9010E0FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 15:25:35 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2161a4f86a3so4594225ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737732335; x=1738337135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nk3vjwSEctYboqUuHaPUBQxNtW2zpULgdnQ2oNKxhO0=;
 b=QUZomxB99931uw0TCa3aJuJZNxaOlwLSKy08llawMkDu30bm1XlOOIPJhKgeJ10XLJ
 jo8pILZWjVdKCChxRebKJmzyWKzJls6oUbgq5vTxFD1s28KDgSSi0fBHh/iMwMQA7eyq
 V4QlN1/KgqvcD/ALOlrA7e2ldeIfSrfoKD25jGlgWlCFFDRUYqL0MfOu7wdh8Tjzo7qC
 vZ/WtcRnm9WGN2/kbGyYDm4vD45kNsHwe6iMlNxwpSLii2AUSeBPD8d3CUJ7iIUwbX8D
 Xfg8S/D7Ce2TUJghnWmy0PzFbYFHwmJaUmtPVbFfOky42y4OT42WwnZRtMJIx/TdgWE8
 PDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737732335; x=1738337135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nk3vjwSEctYboqUuHaPUBQxNtW2zpULgdnQ2oNKxhO0=;
 b=LwP/ygPsoZFXFBHE0p2l5qEoFW9xvoE2T9mVn9ING+rugb9UuDvAVgyE4k/q6gkFUl
 9WIulhZHrGx+5JvRWe44xG7JxYWqhI66hh+cc5fGi6DeWPfLqDWSXVfj6kIRnOOmLD5F
 T4LSQp4Ly322iigj9jIV4FMI+wjhrpo4mPDvHRLqiQUgAlz6Oa1W91+eucncrxi0Fod/
 YWNjoykz1A8rb0GFgulGExDJULpx072Nf0d635vvRYK9sSmOP69M3ncxuZxKk8aO8L5z
 6Pl4Sd54wuysEpuEAGk3yy2SfAZ5D/JHeOMBdzXpysXwccyJ2hYwtqVSh+N74f0hW0W9
 S9Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZz23Rs5rdLlVQthTv/tv8XlIrxL5Tt8d+oeQmKqVt+Mg2GFgzvuSOlFY1k0cTeGfwtdiH1raN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBA+QpdqNqN5H6NQUx6PSJqIWa6oV9ux8i/wkJ4r9g8+K8DMSc
 DqG+IwmYpWt8ytcyp3C2dOg4gvFRK8ACe+CumAXBKMVAZ8l6rVecYTZ/zcu/uuN1FmaoEw8M2YD
 OjxO4SM6H2VTqs37Nw1DrTrpMyuA=
X-Gm-Gg: ASbGncsJTfZoR0NJjoryr2YeUmM+0k4k0ArI94f2gEm1utGrcyPLsxf5Q/KLX1ITNjB
 v0S+pMKcsAGME5XiQGEQ8bYxcJ693H3STn7PxdTL+gKCIcoJmK3OiepZHx1C8xg==
X-Google-Smtp-Source: AGHT+IEec4tW5+Udu1bkGQVXHauBax1JsfwPNXlx9mdJgDrJe6n2rN27Uip7D5btiaFo1qF/f5sUvEF1EodkvQ/QCXM=
X-Received: by 2002:a17:902:c410:b0:215:a57e:88d6 with SMTP id
 d9443c01a7336-21d79a77e76mr71238865ad.0.1737732333377; Fri, 24 Jan 2025
 07:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20250124063425.3091080-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250124063425.3091080-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Jan 2025 10:25:21 -0500
X-Gm-Features: AWEUYZmsvsMULODRSO9GmAUIrDTzo4mldArrQqLkIUz0gYlwBCyGB4R7LAujDaA
Message-ID: <CADnq5_O-AQbYMdvskEjVu0V_01m8Dgt-A4Q_bj0cigc24870qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Enable cleaner shader for
 GFX10.1.1/10.1.2 GPUs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Jan 24, 2025 at 1:42=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Enable the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide data
> isolation between GPU workloads. The cleaner shader is responsible for
> clearing the Local Data Store (LDS), Vector General Purpose Registers
> (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
> prevent data leakage and ensures accurate computation results.
>
> This update extends cleaner shader support to GFX10.1.1/10.1.2 GPUs,
> previously available for GFX10.1.10. It enhances security by clearing
> GPU memory between processes and maintains a consistent GPU state across
> KGD and KFD workloads.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 1878c83ff7e3..938f7d60a0ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         }
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(10, 1, 10):
> +       case IP_VERSION(10, 1, 1):
> +       case IP_VERSION(10, 1, 2):
>                 adev->gfx.cleaner_shader_ptr =3D gfx_10_1_10_cleaner_shad=
er_hex;
>                 adev->gfx.cleaner_shader_size =3D sizeof(gfx_10_1_10_clea=
ner_shader_hex);
>                 if (adev->gfx.me_fw_version >=3D 101 &&
> --
> 2.34.1
>
