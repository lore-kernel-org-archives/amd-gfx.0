Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010F6D1D48A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 20:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C8310E7BC;
	Thu,  8 Jan 2026 20:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYjyKJV1";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCAE10E7BC
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 20:08:28 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2ae60d8a05dso63995eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Jan 2026 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767902907; x=1768507707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yo3GfEhIFnNkNV59MMmlmecCL3C94EbnsrLundGefo=;
 b=DYjyKJV1yyyD0NEdEWoxBZG2IHbqWYxKgFUiuR1YmuhpLV+Lin32C58ScwtWkkWAoY
 9Fv7HXjpqex3cMh1aUcY7vt7T1jRRkIakg5e5RbuNTqny0944lmV+300QMNgKzP9bSmR
 JgZ/BmeSBfVAXpKagnB9l8t94q/rtaK1o8+W/gObHeVczn+vDKQ5W4TJhReMoTK7Bxex
 Y2wh5RTC75RnQzT8L+6cM5fKyRi5F6Zu29Bz+GXlL0v8tpqEuKrKuZrvRUsFjvXqdlz2
 nHlUypR+mmsxyTWKBv2TMmnes4mpMw24JsKYxte7DVe1JYhoO2hdffY/5Vd/g8/zDuGy
 k7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902907; x=1768507707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7yo3GfEhIFnNkNV59MMmlmecCL3C94EbnsrLundGefo=;
 b=XUzI1W2HOShJxNvQ0RN3GUm2XMH5z9QXF/0KQyUb2GHVGoY/HWYCslzcX22UBmE1x0
 hslBf2Ld79wjXxzSwFRz+qtZoCBrV18Y5Hd60yYUuhn9mWjLyEaLoPdmH1w/0was42dZ
 dssQEx2pngbkqG+WyannQYBN5rdARGdQgwQ3rGpp212HuHS12RuOPi8xv4zhW+1Nhnpk
 1c0W5c/vNIHE+EIn4PbMtfLrsCouN6lDrVVmYwicf75zGg3iclI0mL+YE7og7/9yYxn9
 wTPYOS2/rivELixTiMv+qoA+JtiD7lyXUQQ/8o1c8qmO1Juw9mRKz4qZfhGL3T2mqvpJ
 5VIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzpYDYOlPdqRVGQ+w5EyxaIrI2v/LFg0oa9faFnXBTk7a3ykWPDUw6xICvf+aXtncCm8XNk0su@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXDUI3Rvmzq1VhOxxaRanHvNc5et0TV6SUfeEshVZ96jvmHAmo
 qAviBRTUGMzESEN7mOxZPWkyuWqdjE4IhI/J4bFr5Zc3KJtgfwytOwIBCK2chbgqdh/sYi0Ewtx
 ltdg/j42iKKGE1jg6PBZudSfNZ5ZFKMY=
X-Gm-Gg: AY/fxX7yhkEUurty3tLtu55CZGddXRVRrEEc7qFXjPfdm6w0gErIdEzVGCnWrH93fJ6
 4e2mn0CIhgR+1QYz4Jzg+mdUYoBgZrc10N934EgItM9jycTOnHEyRjn075rh6BqczC2d/J6tTgG
 EZW4VvQpxfV2pZAQaDjD+BDQZ/c+Jj3RZuR/CDtl//bjFuuQWBO441km+bpbTl10+C10X8MjDCy
 yEgYD1BuHuc+OF9P3gr4FTgxp2ymkDyomvIc+9RdDjjH46VuYUhzRCyIFGbd3wZMmqhCDxd
X-Google-Smtp-Source: AGHT+IGy2Fkxdd2RXEw0ZPxpdFOxi4Q4pWowqNwHArha2nICcnDyeeJgoPbpH9YM4zJP8uYVPg9PGYuVXbpOQJKoBdc=
X-Received: by 2002:a05:7301:100f:b0:2ae:5b8c:324a with SMTP id
 5a478bee46e88-2b17d30df86mr3169752eec.4.1767902907196; Thu, 08 Jan 2026
 12:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20251222-fix-duplicate-amdgpu-v1-1-18e928420d15@redhat.com>
In-Reply-To: <20251222-fix-duplicate-amdgpu-v1-1-18e928420d15@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Jan 2026 15:08:15 -0500
X-Gm-Features: AQt7F2qn0P1VaFQD-rAUEyKJH7yE-RYG3gVAidOOGDlunSfeoe0AtE2ma5e3voI
Message-ID: <CADnq5_Nqq6sXH22utE6=-xAD1Fm8K6vmQ1hfFyvjwB-uX7UcMg@mail.gmail.com>
Subject: Re: [PATCH] Revert duplicate "drm/amdgpu: disable peer-to-peer access
 for DCC-enabled GC12 VRAM surfaces"
To: Peter Colberg <pcolberg@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Mon, Dec 22, 2025 at 12:51=E2=80=AFPM Peter Colberg <pcolberg@redhat.com=
> wrote:
>
> This reverts commit 22a36e660d014925114feb09a2680bb3c2d1e279 once,
> which was merged twice due to an incorrect backmerge resolution.
>
> Fixes: ce0478b02ed2 ("Merge tag 'v6.18-rc6' into drm-next")
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index e22cfa7c6d32f286de94c6e0947c20db41894b68..c1461317eb29877446e69562a=
58e17a77203a79e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -83,18 +83,6 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabu=
f,
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>         int r;
>
> -       /*
> -        * Disable peer-to-peer access for DCC-enabled VRAM surfaces on G=
FX12+.
> -        * Such buffers cannot be safely accessed over P2P due to device-=
local
> -        * compression metadata. Fallback to system-memory path instead.
> -        * Device supports GFX12 (GC 12.x or newer)
> -        * BO was created with the AMDGPU_GEM_CREATE_GFX12_DCC flag
> -        *
> -        */
> -       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(12, 0, 0)=
 &&
> -           bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> -               attach->peer2peer =3D false;
> -
>         /*
>          * Disable peer-to-peer access for DCC-enabled VRAM surfaces on G=
FX12+.
>          * Such buffers cannot be safely accessed over P2P due to device-=
local
>
> ---
> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
> change-id: 20251222-fix-duplicate-amdgpu-44017b1535eb
>
> Best regards,
> --
> Peter Colberg <pcolberg@redhat.com>
>
