Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8571BC19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 13:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A7610FC27;
	Wed,  8 May 2024 13:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gE2KVQIU";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB40E10FC2F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 13:45:45 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1ed96772f92so31939285ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 May 2024 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715175945; x=1715780745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEjKbVsF6ti/hobtc5Kr6pHOenScyHdnH+5+kwJwWAY=;
 b=gE2KVQIUE5FDUz14JBN33SABE/YSc0vnScJmXDKboGLLf8ga0aX1niHllKlVFUHGLm
 L/lX6g3gvt1HmfBW9WHUecJksY8W8hHoRSWBIKyxlWQidvBIIiBFG7ncixgH/2m15Oi+
 DPulizY5aMI3E9PB2976JrhpRGxw1B5WVFnbpbQFtRMt1VC9JBywtN4nR8Kc4zPf5+4B
 d+lPT8ywrmE9MQMDOGEYOLqpNNX0n0kPoj9BDv5NhVWviWYiBkOVlTUIN60dKRfDs1iI
 sZBQ8QTyY3dTRd9/teO5VUFK+jG9l8hltU2zVtjfT9gzb6SGct98CipoZyZ+A1oSYuj1
 tvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715175945; x=1715780745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEjKbVsF6ti/hobtc5Kr6pHOenScyHdnH+5+kwJwWAY=;
 b=RFu3VPrhpNQoIFTBNTa4uS1mre8EQvZu1qkQ+FhNdc8HZ+SSC4Sq4sEcXFaF45mQlZ
 lxyytbtjptU5ZVxISO1Y66RVr2Twkjub8dt7VLkUEVG2g6DRVgx3ms2ChTL5NWPW+X1b
 aikdlRfmePGBeOon6oAkmSluYeu9a+3wk40JVg0h+80SU5Hje2LjJbm0Fv6YjB1bXxTI
 DnfC6qJhp3J/RL2KLYCGt0MJzHEdsQYgGLVSZsxNWy7KRvkqBOxOpptFWWLefrYhNixH
 wnl1woi23NHCQTaOSEe6HF4dQeTWvXxQ7K3TkCZYqtWfxJI+PW7CSjonwGCoeBIJfRTf
 hHiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdygtxbDHJtkF9XrGJdVw6DMgmg5DVdUbVFbTrtdUFbXPgOEUjHphWHi1R2BFdnOc2fyOiFw2QwliztWl9Sw10KXuCaKpL7hwRxDoSZw==
X-Gm-Message-State: AOJu0YztdSwkTvKrZcGQXrLUA24R6kVlRsgtlcD6vl1V8VWIXTkhBODV
 YyM8U3aGZ0F7yatJYE1A1yvgzseXH1ID/2mUjuEC71QqZFttYV2ECWqe8I4f/gv+V8yAgra50O/
 iS1fQvLCn0zsrwFAHtd3qt1rbfYM=
X-Google-Smtp-Source: AGHT+IF30ghQesgBQavmTYn1bIFO+SrT9XCSIDvEKOB3BF2lvh6oTXMqHoBpPj2NOp5uh9lgeCbMlEAPLBNieSBKY/A=
X-Received: by 2002:a17:902:ef52:b0:1ec:c6bd:4157 with SMTP id
 d9443c01a7336-1eeb078eca4mr35603485ad.59.1715175945086; Wed, 08 May 2024
 06:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240508131916.981456-1-michel@daenzer.net>
In-Reply-To: <20240508131916.981456-1-michel@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 May 2024 09:45:33 -0400
Message-ID: <CADnq5_OUpzEi=gjbkaMg2ZueEbcvPB77v2W1dHiU=TE2o_C17Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, May 8, 2024 at 9:25=E2=80=AFAM Michel D=C3=A4nzer <michel@daenzer.n=
et> wrote:
>
> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>
> It incorrectly claimed a resource isn't CPU visible if it's located at
> the very end of CPU visible VRAM.
>
> Fixes: a6ff969fe9 ("drm/amdgpu: fix visible VRAM handling during faults")
> Reported-and-Tested-by: Jeremy Day <jsday@noreason.ca>
> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 109fe557a02b..29c197c00018 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -427,7 +427,7 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *ade=
v,
>
>         amdgpu_res_first(res, 0, res->size, &cursor);
>         while (cursor.remaining) {
> -               if ((cursor.start + cursor.size) >=3D adev->gmc.visible_v=
ram_size)
> +               if ((cursor.start + cursor.size) > adev->gmc.visible_vram=
_size)
>                         return false;
>                 amdgpu_res_next(&cursor, cursor.size);
>         }
> --
> 2.43.0
>
