Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052E2CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 17:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB3910E3B5;
	Thu, 11 Sep 2025 17:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hpqegs/N";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB9610E3B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 17:26:55 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-24aacdf40a2so1860655ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757611615; x=1758216415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FHdkLhA6/NPnT5RD0ZkGc66iVURNbqLzYVVRGjfT6o=;
 b=hpqegs/NVW5GJ1RsbkCiyUOfTo39Av5IseJpvsVZAkQfs2oB1blGx/czRg2xWj4utw
 v2n4bA0tasXrwZVE89S2/MkndCjojkrW2nEM8KRnLKotVDp0W+uqreWiSdztbXveLSae
 EBR+i3XblZfmmeYpA2UzM05Vr7nCr8vP18ZbWIpIN/SVjH6FKqHYi6RKFCUDO2kMhvep
 MAeuz3PXsgp7eUUfHDe8ikD/ygJ8i5Jkqgdd5NYyIfsHyeBigxG2wjcYnYDUT+OpiV7v
 f5YZvhdmCxmTgwG4ZbSsr6pYwrPgYmG7b3bgxTYWz8w5LBXblusknz7Nu2OPOhpNFNo8
 kleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757611615; x=1758216415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FHdkLhA6/NPnT5RD0ZkGc66iVURNbqLzYVVRGjfT6o=;
 b=M7bAAh5+xTa9dfoY+tfMeK4ekLXzUOg0WoYhkEFpuszYIQU19eRYPhwCi+uN34IuLL
 wyVwk3fvL1acO5RooTRIlnsTlKpsIMx8F8Hl7MJqSOfWKDryVczepZ5vQEdaCuDDsJRx
 lCyfy669y/kYfQGWoLXyZShttHp/9a/eIg8QpIeR6v6yx3RxlrkgcyNLiqalf2zb0Sws
 zeVkuWIa2DNdPxTfRlDJJLAVbpWHcTbGn6qxkxD1Tm1w2N6sm+dUEAu10IeKpFePbXRT
 lO6SBM1RvyZvtC9zwNfDnbRQBjsALXBtiYbgZOxtp7UMX7WLPDg0JJVq0GJ7ZGh/XH3L
 w8Ow==
X-Gm-Message-State: AOJu0YyxwX9mn/HMQAqxOYu34zsZ+A2D2iuZqkbNtZj3IP7lXmSgvibO
 1dpEG8qF5zMywOMe9851SRgUQzCOBvesiHR1kBq1M7ka9csKrY23Uag8Pzj5BlMtksZJ+YRcuFV
 v46vx7z3Y0EbQEeDh+gVMEZNF2qHkneLx+mqU
X-Gm-Gg: ASbGncstIUVe9dm61OvnBBrBuskiDzAraNVRQdwzyy8jzofPBnou1XDJ7oAWuZM2/Nj
 1pE3G72suON41QzQ/5S4LHXNo1EgldangYnRecvXEK0SAcdVFxBUzovuPBSMMHPRpH4w/IVpMxd
 AsAWq6A95PetSoGczhgWsXbRbRjTFGrUv/N2oIRBz/yTRSO8Vr22t074CW/llmiDi1UsxDvAXMi
 Z9V8jGTBooMVfc2og==
X-Google-Smtp-Source: AGHT+IFObieo4nt9QUALlh1NyB3k732hAOTGiVv7PAvyE0bDxRBt2EAR1KyZVXw1OpVFC03KjSIt1+iYPi3oR8RGDro=
X-Received: by 2002:a17:903:1a8b:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-25d25e85badmr966965ad.4.1757611614838; Thu, 11 Sep 2025
 10:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250911170658.584379-1-shaoyun.liu@amd.com>
In-Reply-To: <20250911170658.584379-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 13:26:42 -0400
X-Gm-Features: Ac12FXxawBWOa0tpUxXJY7tLweSjO15CuJ-VqfYaxAr_DR5nV3E2BLEx2JRWeTI
Message-ID: <CADnq5_NaDW0U3riWjK_jBqaeMBVbyymKhbLQJJDxvK3vNVwc+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix the mes version that support inv_tlbs
To: Shaoyun Liu <shaoyun.liu@amd.com>
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

On Thu, Sep 11, 2025 at 1:14=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> w=
rote:
>
> MES pipe0 will do VM invalidation with engine set 5 when assign VMID to a=
 process,
> driver will submit inv_tlb package to mes pipe1. It might run into race c=
ondition
> if both pipes use the same invalidate engine set. From MES version 0x83 i=
t will use
> invalidate engine set 6 for pipe1 to fix the issue
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>

Fixes: 87e65052616c ("drm/amd/amdgpu : Use the MES INV_TLBS API for
tlb invalidation on gfx12")
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index 76d3c40735b0..7cc16af1868b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -337,7 +337,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
>         int vmid, i;
>
>         if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE]=
.sched.ready &&
> -           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x81=
) {
> +           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x83=
) {
>                 struct mes_inv_tlbs_pasid_input input =3D {0};
>                 input.pasid =3D pasid;
>                 input.flush_type =3D flush_type;
> --
> 2.34.1
>
