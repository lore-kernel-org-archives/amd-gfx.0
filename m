Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F237EC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 16:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D0710E2C8;
	Mon, 29 Jun 2026 16:38:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pydRiZcV";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B7610E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 16:38:55 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30ca276118eso265418eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 09:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782751134; cv=none;
 d=google.com; s=arc-20260327;
 b=WD9mWl0r8KRMtRV0wyqPnieStaTbNdHP2Iko8/1RrjAAWkXX+w7V/vqrqmhc1SzC8k
 L8YzWh0ordDeUa3511cURzQKfv8D6oe87Xl6x8DDRFChLzZqJq1umEEJr0UsddiODZtU
 ySXKmGY2j0IizEoGBpu3y09JYhUMll5+8Rr3LPvgAR2PWA+lVUsNWSh/U5ULXx5Powai
 Hp/uL/f/rxuo+VIR0/S3YJ4XE7DTMXYU1s3uKX+kJirPHGw8zENcBT9FbJC32ITR3iK4
 KcN4vWSKOzEWPJXcTRwRuf0cCQtMalwNA7Lz+nVumc6VlbFB3yHUicXixzssZAPIxtS3
 bJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yog7H6eI9Qthna/Htyjp6W6wQVqOOwEKtKTVb6WAvcU=;
 fh=6roTfgloTyLdLCCOxC0et46dsa9crQU8Jnq36Q6bzKg=;
 b=KCa2ZjRJRnTAoTvCIhz7YQRZsQFkNb1g2IlCTBJfgUVe/gGIoiqvQLqVZ5xc5Zw7V+
 kX0CKH/bANgoAc2SvEjnzOyTM/KwtwbRFI52SKNwDqlWqZpILfwV0Hvv4ZpCQ7ggU4y1
 CcArfAfJPgKiudEHZ/JJ6b7W3cLnIlKsbmu+DtR+KPVWkIoGQkDVgRNTVNWrSjPKRX2T
 6Q6BqCePmGbsyE9/GH9ngk89h3t5Fun5SGAEWUtC9Zws/VN3WnaXaM7K29np4x1e5cUh
 PizFH9FNe47NEtffismEnGvHmj1l5L4rJJ3fFaNZBy8wezdkyGTXbwbkoDxodB6dO3Z/
 fIWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782751134; x=1783355934; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yog7H6eI9Qthna/Htyjp6W6wQVqOOwEKtKTVb6WAvcU=;
 b=pydRiZcVrNcPQiswzjArnbCVlX2SYzd9RsqfJzjoveyUnnMoAb79Wo3w88uvTMwhPc
 SVFWA5bMksoKvbeYz3EMR/+WqtAKFjiZs9Du1C1z94706A50z+9piJmR460xc3V7yp+P
 BE9iEGF0GpNJuPjJTFZaBJnwA/YKgxNLMtptilvH80V30bGo/p1weV7cDUCb8NG8I8Cq
 psSDGma/yUkN3YqNwJN7Db4CLN3Z6b1Z1VPfHEdiEUbhS9ESzbOtVT93rBz+4pxvXRQn
 b/59IHHttpgsxWGdG7hnzCvFzcIk0xgYlqZFJiX5jppIbhbic0SIm3v9hhOZ3TFm4Ilh
 FyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782751134; x=1783355934;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yog7H6eI9Qthna/Htyjp6W6wQVqOOwEKtKTVb6WAvcU=;
 b=frlWyBnLin/HL6YJc0b3EzIpDuQA69crYD+Zg0CXHJg/QohZMgkdbVEW/rCSs+XwcT
 sGdBtJbjsu3AvC1vgBlV/yrLijzmE2Nh9Yc/CrsZVD9Ahexkx8Cg8HhGK5xG+x6WP6aO
 y8KKgmygO+994YsCNe+gCVVND76YMbCTTaoTUnduxp+lVdWQAzzlaqP7mqCGzf+7VG5u
 fta70TJN2udJ+bYxsXHI+StK/8TRLuN5b80FFZbbyN4I6PwfhoXrJvojcuBrSLVCxDNN
 9frS2K6AI/tGQYeDC9S5KlFuiANveyAJT3Jpw8dT/fiOSRhnYt1yrMUTafkHRAZwzcRp
 J+Yg==
X-Gm-Message-State: AOJu0YwDdIIMDC43NvUHN2CUV+OGj1ZjVpfdH1LpeX/S6WZteo54dy7b
 NSjEjOQmOgL4k1Yd44e0fMHTqJir8C8lidYZp3L2/mp+ceoTbpgI9uj2UUBgSCL6LNBWteX0rCW
 ksAgSC0vHyI/GysjBmzA0fkhIWjHBM6I=
X-Gm-Gg: AfdE7cmYMD0IqzUJjyu7gJFyMFgh48uAznJ2utnxAaG83sPJ5aaU1xV2RDCm+udBD67
 YcgrBnlcOVc4eEEEDw8SSNzEkfN4V38uyRTKyfaN5BhktNbwLZ1RsfiyIXTN3qaZu1pfC0kp+GH
 GJy4/71wQhDngRg1bVpkp+v49t566ErbWSv/DiGkrx66s1/w+9y1hGQq6/SO33fvmbKDC53DMUD
 dIoPB88BrrbtAg4I3XB27xjh8j3WjX9T5WdfhkvpvaBbCDduyOy7dUsGM2vIkUJr15bnMTb6c3l
 Blcbas8/FonFHeWRD9x2d3uHYMr9+2eCVm9VzotSJepovkwnDz2ISJ28zyc=
X-Received: by 2002:a05:7022:238e:b0:130:a479:79a8 with SMTP id
 a92af1059eb24-13b2a1430f8mr59725c88.2.1782751133943; Mon, 29 Jun 2026
 09:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260626144319.313979-1-boyuan.zhang@amd.com>
In-Reply-To: <20260626144319.313979-1-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2026 12:38:40 -0400
X-Gm-Features: AVVi8CeauhnHAP4__AWOeiFiydcJhTz193gp6-BFUkAAxeZZm0B1u_AvN3IiINE
Message-ID: <CADnq5_NEG3ePbYFATuPW4dy+7Z8MVnymJeQk0AvBDGKWyZaDsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/jpeg: fix jpeg_v5_0_1_is_idle detection
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, alexander.deucher@amd.com, 
 david.wu3@amd.com
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

On Fri, Jun 26, 2026 at 10:54=E2=80=AFAM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> jpeg_v5_0_1_is_idle() initializes ret to false and then accumulates ring
> idle status using &=3D. Since false & condition always remains false, the
> function can never report the JPEG block as idle.
>
> Initialize ret to true so the function returns true only when all JPEG
> rings report RB_JOB_DONE.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Fixes: tags would be nice.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.c
> index a562369d2d81..01cafa6a4fed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -674,7 +674,7 @@ static void jpeg_v5_0_1_dec_ring_set_wptr(struct amdg=
pu_ring *ring)
>  static bool jpeg_v5_0_1_is_idle(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       bool ret =3D false;
> +       bool ret =3D true;
>         int i, j;
>
>         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> --
> 2.43.0
>
