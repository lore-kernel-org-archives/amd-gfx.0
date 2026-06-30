Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B0DC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 13:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F2110EAD0;
	Tue, 30 Jun 2026 13:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FWKlSxEF";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C37C10EAD0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 13:33:27 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-137eb8e3491so450080c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 06:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782826406; cv=none;
 d=google.com; s=arc-20260327;
 b=h9l0LrxqHj+NEAxPDIwTVMmnOEGOrlCmdudYD9+62u2qkZ4Fx50tyMfbQzFhP1T2zX
 qgyB5zc+JF3Wl6iIhIyTpIUkm7c1th5KyF49pxOE31yueH9UbXqHfaEhA1nRRFDiZ9SG
 pt9x1qW+SqcJNV46bT0xb5ioSK1pfALbe2Qy4FDEfBWZeUtDTs0ztmVzIL5xNdYbmUM1
 xI/fOy+prDEHxcxBJXXHGSMu6WEfkg3xtORyNHLLNva2PIiAqYs0RYd/hrcK4yIO1AEp
 jUUSS0FNBsqtwU3Kv1hpwxtMrSft8eGg/N69B59HHEcqOIpAhIMRMJRYG/+SkMAQQNDA
 RDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MxO8NQTZB9THcSU9sWEewow4jOxEhdvT7ds9pL/iUyg=;
 fh=WLp0uyQ5VgooXd+KwajGtyg086yoNX2AEsj1tWPaT2o=;
 b=ehn+FM2nCz11r6pigc15xyt+N+RuhGot3Lo06JuR5W70tqjuk1cax996V1HQfxW360
 NVuwIgauIrsNiTQqyKP/4QQ7OYKGadD5Y3VgixyorJUZUqt/j6BoPMt+eoQ+A5p0XlIV
 W82LYOdHaMPLRjgKjtmYBySZcthUcxm5WnOjm7/DFHG2JvYXhJ1vkJPymnvyjj462xRV
 aAnYUyHw/d5szPISKBt0V7RD4eszdP9EsUHKhCdAjU0J/sJffVwllyLCblYViAJkXBA4
 nkSaXs9PXmwmr4z5ugoqD9plSmtmsO3LPCnkPuEiniBgjkpikCgmslY+D43E+S9xbllO
 +WWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782826406; x=1783431206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MxO8NQTZB9THcSU9sWEewow4jOxEhdvT7ds9pL/iUyg=;
 b=FWKlSxEFv2SLBqsMn4dzT73OSJa42L98HtmLa3WBclAoe14NF5v1a0YoJSVP1Qfwc8
 1NxXu2rQmVTY6MrEcEOvupg4DvVg6ulZ8THQpsgY//SIig3c4QZvkVCT6Bz+sJo4zjQW
 OuXwsqEZb/+Okv/FyJmpVc84hsC3vJH01xM4kO/VXtG/oChNYC5SjdEe3ZCKCFpCQYeJ
 v27JIlPT5OXP/aZYk3kLBEYJXAG6kFPVuEBC/i3mK1IPvVv9hd2zx+qTE0Fm6sDh4I/d
 aJJVnNDRXgzT7PiwtS9g2nX1J0WDMy0hOcC4YzwB9Ewb3iJbVhZm6s710NYNd1Xd95/u
 /N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782826406; x=1783431206;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MxO8NQTZB9THcSU9sWEewow4jOxEhdvT7ds9pL/iUyg=;
 b=etXaVfFPKucvDE8iLci6IRbOeSEzf5v93dCIuu5tGJyRnz7oW/yDMpIFJn7LiO5dj4
 avLWhUCLyy2r3VL3gOK8Y9+IDHgFN8hIy1wdAxcbMTUm+0nyUXSU2Hk0lQxMGkQfl1a0
 hp+fVtbBFQL+B0jro6wAqlpRv4+0OMqcP12+g6CIofmf8duQOnetM/8NPa1+21E6KFg+
 7pjUwB4ZXrFogcGOrpn1re/TsZwF4gZvj8Vu6tBjhlBYo5HAadoLFSK3pK3ekKW2/JvD
 0T5kSTq3QxHywoBiWFAIzOoUaBPRNtcM7KZqjxJG2S/u8E94QtjnBJlXtm7OvOOmA3pL
 A3yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ99RBItZVu6ARerfTFKlXja/FuzEGxoNNze8edqWO3+P7nV58JlH4ntdUyldKU4iRfba2PHXwrv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfulVVYpulxni61qDINE6454KnvvvIbpYCvJu9nJsgs3KK5tw+
 u6vNicMYQod30nSq+iP44BFjTr258dqQtt+yEdboB+BwgUhcOJYKEkJNEqGa3yfMBtZOakj3cVu
 h/gxaOV4/8tb/LkNtTEMvX7KEffiZd7c=
X-Gm-Gg: AfdE7cngjb1VGJGSbECGnNQM3rZyu+63X6W9WYNcNXtIwlCU+EBIqvwWl6vQj9Ws2eH
 IZdrel2cp5fr7M/46PdY+hMvOI6dBFveeBlU//2ELph7b8kT9fGQ7rTbIqY4kSdhRNVnUZ0KW/P
 yPfC0NSzNwuP4btAdfnRWrFTAJ0NDxvRZ0KLrA6of63wgH/E7q+1dAg/b7F8tAGgVtfDtbWx3pe
 tzVAbbAAbqPXiqc7NoA5q78N58Pb8L7yh4LiA5ZrHwrIrhGzLaCqJ700EpRdixSykyE5sY7ECj1
 cbsCbRFp1M2VApgnWc7pBJvgEZyp+Xh29nimrkaKKtchxKkmjP4GT8dPc8c=
X-Received: by 2002:a05:7022:ef0b:b0:139:ed59:8745 with SMTP id
 a92af1059eb24-13b2a1bcf85mr1062085c88.8.1782826406221; Tue, 30 Jun 2026
 06:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260630072838.67086-1-ke.zhao.kernel@gmail.com>
In-Reply-To: <20260630072838.67086-1-ke.zhao.kernel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Jun 2026 09:33:13 -0400
X-Gm-Features: AVVi8CdM88QkmqoCNLlwZsB6fAv5X0TzxYB4d_ZM8E9TNR3nyDqVPkCBZr0u2y8
Message-ID: <CADnq5_PjWYebXd3-MBik0mOvEXheRckZo3KeD4T5G=LS5D0Szg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix typo in comment
To: Ke Zhao <ke.zhao.kernel@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, pierre-eric.pelloux-prayer@amd.com, lijo.lazar@amd.com, 
 felix.kuehling@amd.com, srinivasan.shanmugam@amd.com, 
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

Applied.  thanks!

Alex

On Tue, Jun 30, 2026 at 9:24=E2=80=AFAM Ke Zhao <ke.zhao.kernel@gmail.com> =
wrote:
>
> It should be doorbell.
>
> Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 16c060badaee..b7be28d74e83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2187,7 +2187,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 return r;
>         }
>
> -       /* Create a boorbell page for kernel usages */
> +       /* Create a doorbell page for kernel usages */
>         r =3D amdgpu_doorbell_create_kernel_doorbells(adev);
>         if (r) {
>                 dev_err(adev->dev, "Failed to initialize kernel doorbells=
.\n");
> --
> 2.43.0
>
