Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FD4CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 19:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170AC10EAF0;
	Thu,  9 Oct 2025 19:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DxuHJkYJ";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A5CF10EAEF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 19:02:51 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-269ba651d06so2035075ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036570; x=1760641370; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbJRt0GX9VeMIgwFDAmAKeNpsHR25cT6LcfeHwPDHTA=;
 b=DxuHJkYJweySsZ6Y2Uih/yQ3i+rD703q9Ymgbme9Oy62AvU7ebrPdjdmpeafMoXi68
 OsiZuxhxTmkwtogkMxfgMIo4168k0KzLx4x48bNJLnnK4fdOv4VJG5krHEGTn0G8pEkz
 JW1aFrZLeFtI9B8q8NMGy9RwuTa6f4Me6afm7XVEyD/OJOgY8IWHefDvP9BWegCUp64v
 nQJAmgUrePLfl20bTWCBu4sfJGXDZyHIBWp2JIPrX1xKEJ5KHrGBAAL8nw6DEAyrR0v9
 hxcv47IUPm7NysM1UqTEl9D6nP3FhWr2dQLBNUcymvA78hPscYX8BLKDN6U1GWkd+0hJ
 g+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036570; x=1760641370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbJRt0GX9VeMIgwFDAmAKeNpsHR25cT6LcfeHwPDHTA=;
 b=sx9fthZm3OAeNdnKsdExllL5uMcvNUzmXnn+idtHaPoCMROgd95bAAyMvlAk1wFfdc
 IY+I5Cv12bndRjsUuwJy7j2mhoBB9/4uDFfDMvZAy3CejOJNpxeeb375PIU6PNFs4UR1
 wT70VDSfZZNgup0bHZn8XoJn3TarX58lLRH6c4GOC8TJSLduF1laEYh8ZumZsTNx5DGO
 BkxT0GqRdIevI2QxZKUvD9GSRYCy7cwmWqIOxEVr/fimVqc0N68xcTCl7u0G92Bid4YV
 bWJiGuwONSAN1rbDfu7dVZdVOD5fmnIvbU+cZcYf4j5Y4m1xycc+GJyJ0jwww3j0SQvE
 3VCQ==
X-Gm-Message-State: AOJu0YwkacA6NV8BZqfK8ddCDZ00YvtHnzzParVgyNqVu/0zbJkDi5Di
 FfZNGYuMLSaO8SMFC0B+Vvj0dc3skvJBSIsT58jb7l0ZTqK6iY5B+WXPcfQZO/bKKTk668wipjn
 8JFS5sytNgEppWuGniXHulknOJ+JMjfo=
X-Gm-Gg: ASbGncvq9J99Ml3ER7/yEGAWXGU6xcypLSpFHermRO6pc2J4d061c6VSWZPdaYoenRd
 uHP4OfpnnaxzqVADOG3DRsujWs2ddU06Bslwl868nFqNovhDG6lZdaV948D2kr+bMvu/nCNNWJ0
 C6HTIvuQ+CvAQVgACbc1d2EWH5iRInIExCXmZs+GUO6u5KrTN/BsWpLG4zvx0YbMjhbC3AiE/b2
 YeYx6Xb+Dvpy71bb1+5qYrUwOlWD0I=
X-Google-Smtp-Source: AGHT+IHXyctodHVaZhQKhfR9aNCb/CunTZ44EGd9UvkVI5SqHzFO2cBR9fhjdkuSuGtoCn36Gweneqz/LWoUDKC1aFA=
X-Received: by 2002:a17:902:da92:b0:25c:9a33:95fb with SMTP id
 d9443c01a7336-29027448385mr63694215ad.8.1760036570418; Thu, 09 Oct 2025
 12:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
 <20251009184929.1038298-3-jonathan.kim@amd.com>
In-Reply-To: <20251009184929.1038298-3-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 15:02:38 -0400
X-Gm-Features: AS18NWA_SFmawTKQRXfDzAwzTg2nsQ59jzGb6Ri5DaPSXjPZhTumWd6IDUqlA7o
Message-ID: <CADnq5_Pp1otMJ7whEppkX2=6KMHhVgafspTNfMtwOd6O9H3h7w@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: fix initialization of doorbell array for
 detect and hang
To: Jonathan Kim <jonathan.kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Shaoyun.Liu@amd.com, Harish.Kasiviswanathan@amd.com, Amber.Lin@amd.com
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

On Thu, Oct 9, 2025 at 2:50=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.com> =
wrote:
>
> Initialized doorbells should be set to invalid rather than 0 to prevent
> driver from over counting hung doorbells since it checks against the
> invalid value to begin with.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 8d03e8c9cc6d..c698e183beda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -409,7 +409,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct am=
dgpu_device *adev,
>                 return -EINVAL;
>
>         /* Clear the doorbell array before detection */
> -       memset(adev->mes.hung_queue_db_array_cpu_addr, 0,
> +       memset(adev->mes.hung_queue_db_array_cpu_addr, AMDGPU_MES_INVALID=
_DB_OFFSET,
>                 adev->mes.hung_queue_db_array_size * sizeof(u32));
>         input.queue_type =3D queue_type;
>         input.detect_only =3D detect_only;
> --
> 2.34.1
>
