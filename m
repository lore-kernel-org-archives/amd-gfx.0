Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D354CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 15:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1947D10E467;
	Mon, 18 Aug 2025 15:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QYUL9afb";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B7D10E467
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 15:04:43 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-244581eab34so6662515ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755529483; x=1756134283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZ8qZIsl3F0K7AUol63zdEvdhFOaLwE8mSnabzdih4k=;
 b=QYUL9afbA6wXWDfDolhl8fWH1FXeUCVW9Lp8DbOPuc97JJNiccZ368hxOe5mCeyFCT
 /5Tog9r03H2vC/syVeVw1Ed4LuGRG+cu3kMd31gfDQYpX+lJx1MnUfr0OIwMREGXU5wn
 t56MWD98IrvtspK0v0aBafTtvi2mt+LlCFs//ZghWHoxtSomM4y6Dr/M+Mc6tJelmwqW
 oTMewLng1nxWUfFZNlq1j7+x6Cm2m7pTJEjAfTZCP0k/6D6HN/uSZrW020NZ5JIs0pfQ
 qqfRgOGNMqgt/5/bUpAb6+cDlWun1o87vl/CZ+NdUYh1YAXeckHfyo6zbTwd/yL+rlHN
 Ha5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755529483; x=1756134283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZ8qZIsl3F0K7AUol63zdEvdhFOaLwE8mSnabzdih4k=;
 b=tTNv3yvIUkn9paC782ejByfgbXkXi1w6h85hyUXSk5Nh7GS1ieWPh9b/+ySUT5NV0F
 y+V8HSaPeaq/SLnfWS8vD3ChkU6Ec9jc45cm4DPhDLCv7FG2tEBMKHO0O4Yvtb2uW2tu
 yro3W/YTWTD3m44iZEGaOQeCmhebY1yVEPlcQYgLbu7yFCrriv5ufvkmUdobopWI+Hn4
 Sw1FhRK9Ehz4CJLmMgMscSESyM9WhsZJHciB/zX1fBpwplHuj6d6zDpRJvBzDg4+WBm3
 IkFloOKUhYPEzvRF0Ai6JRDAjBOIi2n6cRWu3irUfnAGcv0/YFeZzFTwtNb9qaBkRcbK
 rfuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFzOAtEB62NT30xNQT//VUNbqIqIuZcOJcxx/ZDybozcc9XEUbgAslrDTdxDlUj8ooYwb40Kkv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywh+kkVuln/V/GCSsycQ+3ECu5NgNZQMDs+5PQ4JfF7KmqL7AaK
 DpIRqi3GxZm7hDaIFEENXkbNhiDbutlInYV2/R2rLdidI4h4dD3jTbF/yKIKi4PLYkG87NzCbzZ
 uxfj76jSVuHwsKNE8e+OLeaYPOCF3+xM=
X-Gm-Gg: ASbGnctZU0ZOLB/SfBcbvRbrDpZhdQkYRLDI+1T+kuI4TuwbhJka6AQMPqrDZDot5Zi
 73kIBGyOxoaXEfPQYBjHnIzA6gwoq+RqUg84beV22dgjIZy2artPxTk1YffgCf/4KnwHTfJwhAr
 pspIKTQYKFdh7YHPYvPhooT8GkE4ih21I2qJTyBgcKwNAJbnufLB+w4kjDeJ8kqtBQ2Bj1902qy
 tivHweoSsOfoKK9pg==
X-Google-Smtp-Source: AGHT+IGll9gBHtl6f+hjT0UNdiElu6IkWfy3wzqO+9ek7DUIsryqJJk1aMjWv9QFqIdIQDSGTQzv/J8FlJqQ8TB+dQ8=
X-Received: by 2002:a17:903:11c8:b0:240:33c7:fbf9 with SMTP id
 d9443c01a7336-2446da155e8mr82460845ad.11.1755529482672; Mon, 18 Aug 2025
 08:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250816162806.1301791-1-siqueira@igalia.com>
 <20250816162806.1301791-2-siqueira@igalia.com>
In-Reply-To: <20250816162806.1301791-2-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 11:04:30 -0400
X-Gm-Features: Ac12FXxqJd0AFDqrW4KRZ1HoPHx39KZnXcqCJQSmhv0gHtq-9PS4qKOYxTbWblE
Message-ID: <CADnq5_OqL2PnQQBY+1UQy26AhH0yG5PGsKDVv7zY1+fZqha89w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/vcn: Use the correct irq for the ring
 initialization
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Sat, Aug 16, 2025 at 12:28=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.=
com> wrote:
>
> In the loop that iterates over the different VCN instances from VCN
> 4.0.3, the same irq source has been passed for different instances.
> This commit addresses the issue by adding the missing index to the array
> access for the IRQ.

This is on purpose.  There are no per instance source ids on 4.0.3.
The IH packets on this chip have a separate field to differentiate the
instances.

Alex

>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index a63a1e3435ab..018a526a8801 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -212,7 +212,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block =
*ip_block)
>
>                 ring->vm_hub =3D AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
>                 sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].a=
id_id);
> -               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->=
irq, 0,
> +               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i=
].irq, 0,
>                                      AMDGPU_RING_PRIO_DEFAULT,
>                                      &adev->vcn.inst[i].sched_score);
>                 if (r)
> --
> 2.47.2
>
