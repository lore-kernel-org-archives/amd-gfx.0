Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA4BC2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 13:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EB110E553;
	Tue,  9 Jul 2024 13:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kUmRX4oE";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4451A10E553
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 13:57:29 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2c9a10728abso2855741a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jul 2024 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720533449; x=1721138249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnFNlIBCazOYhipcyT7fNAu0uK2j9YnU8ah4O7Wisqo=;
 b=kUmRX4oENgVM/CgT/VAxByZy+Jw+HDnLknQ4epUeJ3tzg+iQoa7nNWzhWYJ7l6OjE/
 EP1IkRMJkHTEjSQItwRGvFiRoQDHSMHOAZOA0cirJcC+iqAbRaScb8JPV704UZzqyFvb
 SxxbYMZOUrZMS/qJjWEVTOSYgzi5bdIaiyeqHa9U6RKp4fUz/X6LUPOF08HJGrVPEAgs
 oqrrGb7csR1aDdE4t6Pbnt6yNqg2aMm/l67cb3AyTZ+LZG5NJLdo4YwfGJBclqJAP3X0
 8zo2iixMSLUcpms6YYQbATlRV0VX8oAdUCqD3AsycQVpNgpqJqiDs8almScvA9naQwIz
 Fv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720533449; x=1721138249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnFNlIBCazOYhipcyT7fNAu0uK2j9YnU8ah4O7Wisqo=;
 b=AFb8396gY7Sru+TPLzOSnI4mGlz1b9h4/HHFyqQjVnPGwQS6jSQPIvtlNG4td4t/Hv
 kTpGvjOfMd+2ko4LleCrou8JgKXABq8Et5AkIzr2JwzOTMIKbUieuAcYGTMCSk7EOVQm
 FIsz1gL4k2HSR0f/cMD2elAA0ip7I/JUsKU5zp6VQ01vm8Hu9DtPcU6vXdtdlF/TGpIf
 JMLZB1Yx0VcUYCHF44Ci+VromqA+8S1q12shx7vIvc0O03UldiyrWCidvYUg7VCbW9+Y
 wCamCH9XniPQw5f8XOAotil8BQ+fnUq/kIrExsVORNnl6do7YgKQCecqIRFI0s9euA1j
 q8GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVN91I+GknNYIVkozTjDI3vy6NBN4bJUuc9O4h2NiRaYJlbvi4NEdAVJNE2jx50qtlB06L3JjZiGvIn1bErwrTG9YLuvE0tQykqjVIkA==
X-Gm-Message-State: AOJu0YzJ2GhTjoi+g1G3dP1CPp4g28/Ss7DSJ+PxVbj2yWvuWovt0QhB
 dZ04/2QJyR6vD3CS7gvbM27yOfhupgKrMfLUXAxTUW0R1jPZgCEPxVBFT+CyNSZuiEteb/xFaiA
 gy9OajMvvvQue7m/COXyb9jxYtoc=
X-Google-Smtp-Source: AGHT+IE51CfV6WWWfpBHyOu34Kx3ZYeJghBjbcL4bMiJ1MxZsolEpIpTnqpZsGCubtHqdC7VWEecYDDmR7sL2hwzSmI=
X-Received: by 2002:a17:90b:3ccd:b0:2c9:6f03:6fd6 with SMTP id
 98e67ed59e1d1-2ca35c2e8ddmr1993295a91.17.1720533448717; Tue, 09 Jul 2024
 06:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240709060723.1568284-1-sunil.khatri@amd.com>
 <20240709060723.1568284-4-sunil.khatri@amd.com>
In-Reply-To: <20240709060723.1568284-4-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Jul 2024 09:57:16 -0400
Message-ID: <CADnq5_MjruP+4kkzH3RNUTYKqVVTU-YtdMBSyPjT6TNLgEZBpA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/amdgpu: select compute ME engines dynamically
To: Sunil Khatri <sunil.khatri@amd.com>
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

Makes sense, although the pattern elsewhere is to just start at 1 for
mec.  Not sure if it's worth the effort to fix all of those cases up
too.
Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jul 9, 2024 at 2:07=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> GFX ME right now is one but this could change in
> future SOC's. Use no of ME for GFX as start point
> for ME for compute for GFX12.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 084b039eb765..f384be0d1800 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4946,7 +4946,7 @@ static void gfx_v12_ip_dump(void *handle)
>                 for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>                         for (k =3D 0; k < adev->gfx.mec.num_queue_per_pip=
e; k++) {
>                                 /* ME0 is for GFX so start from 1 for CP =
*/
> -                               soc24_grbm_select(adev, 1+i, j, k, 0);
> +                               soc24_grbm_select(adev, adev->gfx.me.num_=
me + i, j, k, 0);
>                                 for (reg =3D 0; reg < reg_count; reg++) {
>                                         adev->gfx.ip_dump_compute_queues[=
index + reg] =3D
>                                                 RREG32(SOC15_REG_ENTRY_OF=
FSET(
> --
> 2.34.1
>
