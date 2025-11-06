Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D6DCCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 21:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE43810E9CC;
	Thu,  6 Nov 2025 21:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iiAl1jir";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF4610E9CC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 21:22:12 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-295291fdde4so33675ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762464131; x=1763068931; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXEe+FmiYQZPvkswE4T2Yu3xHvmMAF1gfGRbZf8VNNE=;
 b=iiAl1jirR7RCZvj3rhkymo8Fk/vw06sK3r2AxiS//T3SKBcJm9Z9Wq9kNzFWk2f2bl
 i7qc2q9bREQ/L7GhdOcV2VAQ/8rAUy/smTWSw8jIoVlqhXD2UHSIQ13QYBcAF4iYvEkN
 wog3xFIcJg9QKpT6XG7yWDwWYqrVoy2yormMwlrZVCg+LHRlTiVlFXeAb92qSDGf7gv4
 SNRCUTdxBtPBE9r6uoiI23YuDhPZztTRh2751fUBtSeo/cwYu3EHLFRx5boNIalRgRHn
 fdCLSCQIxGDOUvjSqxHyPXyimwzdFOevWChC+Ln1AuTiH9flzdOKCdSgj8dcy+Rj4jk8
 BFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762464131; x=1763068931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KXEe+FmiYQZPvkswE4T2Yu3xHvmMAF1gfGRbZf8VNNE=;
 b=W98XYCIM4mlkdAnr60D4KgLXGmkZMP9s61agvYTXyn1TczHYx0ZqQxABsYcZ0WYp4O
 VJrxNrgxbPE1/jVRikWuStBByFgr8zsYxvk+zHbB67jMmomt3M0X1K7vvfmiXWAKGAPY
 ALzaesLePWGF1MXt14yVgroQ1GPMdG894yvK62sS4DTMmRe3FJ5MztXnxWtV01P3PaAI
 0FRcX2poOremXSFOz4QQRcW8vV2YqN2jBPwfqGiG7+gqNccF5vcPy80KeRnrpBh+XBBG
 DkH0KM+AVOvGo8xCk+J/yfuglcH3zPdaQr7Dn7gEmNSFA2XLDtWtEcIHv+Zi1Uz9KKyp
 QE8w==
X-Gm-Message-State: AOJu0YymfnqsJD7StwXWtF6zjRyoNgPamKl9HmYd/Qki3AsBVbd67pqH
 BTPPU9LyYW6q+jRETRjbXWXkUEiHZX55WKTg9nxapKaczVYOBPxKq2Jroa8wOFuPZt+mARY575V
 7yezybb5VQjpzZThjolc7DmPH7sbZCKdYgQ==
X-Gm-Gg: ASbGncs+Ml9g4MTMvrDPIHEnApXhYIoJPh57SMIsa2jYlIWE99nna3XUtpcA5lR2IEy
 wXGjquLpfrobdxprwXSkXQLdcUvGiWPin+3YFN8EGRmVkydaztxRP/T8JKyct7BhIY646SF2ILW
 HnTaVnUCvxa6g2W7C4ixDRMBInSMI+hYl6NYiqnEYc6UzHR1f9xctWkDGi7eaACNRWZBcq4DZBj
 zJh/IF5AW8fzT185+EW8VxzCe6Q9nEoa5d9YIQtTsTMAr34w7uZzFftoyDJbyd5vTwVvPg=
X-Google-Smtp-Source: AGHT+IHC20O9vdpsoqOCQKDmRop72JtQEiJCuppdiUW2QMHhvO+zbI9Ncq4G1UJQBDk4iKMvRFdQcTwD/QXzS5PfixM=
X-Received: by 2002:a17:902:f54b:b0:294:ec58:1d23 with SMTP id
 d9443c01a7336-297c03ae2edmr6416305ad.3.1762464131575; Thu, 06 Nov 2025
 13:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20251106205527.105492-1-superm1@kernel.org>
In-Reply-To: <20251106205527.105492-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Nov 2025 16:22:00 -0500
X-Gm-Features: AWmQ_bk7PlT_UU__QC8SN7CjEAPbkpNNoJz4syAV_aF6t9Bkg6VSuAkeMji3e7s
Message-ID: <CADnq5_N-CaP2=DkF_NRZ1BsZrYfT-G8GJHM7UKnPMaG04_hcHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Clarify that amdgpu.audio only works for non-DC
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
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

On Thu, Nov 6, 2025 at 4:01=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> The comment already explains it bu the module parameter help text
> doesn't.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4684
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 475a385462429..6ae3a1fb8d455 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -310,7 +310,7 @@ module_param_named(moverate, amdgpu_moverate, int, 06=
00);
>   * DOC: audio (int)
>   * Set HDMI/DPAudio. Only affects non-DC display handling. The default i=
s -1 (Enabled), set 0 to disabled it.
>   */
> -MODULE_PARM_DESC(audio, "Audio enable (-1 =3D auto, 0 =3D disable, 1 =3D=
 enable)");
> +MODULE_PARM_DESC(audio, "HDMI/DP Audio enable for non DC displays (-1 =
=3D auto, 0 =3D disable, 1 =3D enable)");
>  module_param_named(audio, amdgpu_audio, int, 0444);
>
>  /**
> --
> 2.43.0
>
