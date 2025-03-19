Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE332C35FFF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 18:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735DB10E572;
	Wed, 19 Mar 2025 18:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SpJ8Rh83";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8A610E572
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 18:48:04 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-30144a72db9so1366513a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742410084; x=1743014884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72MfvQ5CCchRFKt0XHB1Q89TEEzEVwiGJATUZBb39Uo=;
 b=SpJ8Rh83p56C7gqDsqaFfdHMydMkqjwoJjr5sEniaM8VMnBjXk4DS5vtIgCd47ByhS
 fJV0cNmDMVG+0y3uFMmN6zFkbUrl+lQZcqDd/quAAJ3tOvCy8nX2OZLe4lf97Ij6wiCO
 uvkGBfCzSmOWSCM3RUhKTYEsSRF8l/vssetWK1jTAcarOc7Yk9vCMkTsaMvAKQo1RFdm
 9NQ7sUf58YnHja4WVcwCJvHnrPmvlba1Ifm6lIa1IxvOCb6RJGv5iNedtL6OTKddU2a6
 HoaVFklK4oZ8wrtTeGd13mnIlMlhlGtCPKTRpZwX0Eic2AVqGM3ktIJb8TNJtqelmN9W
 6FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742410084; x=1743014884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72MfvQ5CCchRFKt0XHB1Q89TEEzEVwiGJATUZBb39Uo=;
 b=vxTdi8LM2efiLsqJsG2JQhjd0ayLLzaGvwd5etGv4DPzWQlQiNtqLr780Pa7l3KksX
 ihP9gxt7BN1WnLA9ZR32t4xPZKM1OMQdBt7yNRUDPCmdDdjTRywfPCLBg9+t+ouVLdLD
 nkrBHq7cI4H9iP4AwMmEzSNZXoADBkL2c0szOy7OpgmETRia5LArU1CK1Z316XLCHDrG
 ISewTi736DZlfnooaZnSpo/Q+f5+Uav9Fh7i2lndKCmCPefiiIHUOQmSNEH7pKez3Qfg
 AdCPvSAFKGrHrE4tWF+QfwiSNWck+flNsJ14B7HU63raOIiVg49UTUjFfcknVAu3ZkPX
 tOPQ==
X-Gm-Message-State: AOJu0YwY7QoIWC04azSwqDosU7qrP/eGUyYCEVdLFt9+Eu2+5p2zZ1sR
 G4qm3vN60aW918YDu4K+Py0oxzflmkwxJwdfbCyuQ+ZXLsaVzGqBy8913vtHqEp5Aiu+PG+K/Oq
 rFZkwcARi2/ULLKB19c00MRV6S5Q=
X-Gm-Gg: ASbGncutAHlsjcL6MO3W0QBRiJ9l7RgayumAOxy3APKf8GyHIr369LHhcMyJjJ1qJBo
 B2CAEtaYGZQsPUAvSBPr9MKszqW0fJ5R+FPALVg/sElfDGGq5+cwWVQT076j7uNG20S/eC8GdT1
 wRXrzJkqBAlr7F6WFjRgn++bbGDmPXhDYYUTo+
X-Google-Smtp-Source: AGHT+IFITbifl5z+eKh5mjcS7s3Q6nVdco2Up7J/0AFgeaTUu0vzgtuVrGJzyseBGNb5lhCqmjmBtaA0qWYi7+G+46g=
X-Received: by 2002:a17:90b:3a87:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-301bfbd4562mr2185531a91.1.1742410084164; Wed, 19 Mar 2025
 11:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250319162415.3776175-1-alexander.deucher@amd.com>
 <20250319162415.3776175-2-alexander.deucher@amd.com>
In-Reply-To: <20250319162415.3776175-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Mar 2025 14:47:52 -0400
X-Gm-Features: AQ5f1Joi6pRLWiHv14wwBb5uCG4OPhYHD5KP6jj1oKKqaa9Plc6RSEjeRDvNt30
Message-ID: <CADnq5_PvqdNJW6iMtDzhsG=mo2-YactLE2VBuG3nn7ojerJ9yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes: enable compute pipes across all MEC
To: Alex Deucher <alexander.deucher@amd.com>
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

On Wed, Mar 19, 2025 at 12:25=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Enable pipes on both MECs for MES.
>

Fixes: 745f46b6a99f ("drm/amdgpu: enable mes v12 self test")

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 920cd1c1eacb6..b8066c0b9014f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -109,8 +109,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>         adev->mes.vmid_mask_gfxhub =3D 0xffffff00;
>
>         for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
> -               /* use only 1st MEC pipes */
> -               if (i >=3D adev->gfx.mec.num_pipe_per_mec)
> +               if (i >=3D (adev->gfx.mec.num_pipe_per_mec * adev->gfx.me=
c.num_mec))
>                         break;
>                 adev->mes.compute_hqd_mask[i] =3D 0xc;
>         }
> --
> 2.48.1
>
