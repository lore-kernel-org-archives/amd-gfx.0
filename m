Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACE9C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A51E10EA64;
	Thu,  6 Mar 2025 18:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GUuX6UZj";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054B510EA64
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:22:37 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso256472a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741285357; x=1741890157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJykGVKcaLP5l3xku6vgViC/HIzBwAj3hWJs+T9WqbA=;
 b=GUuX6UZjtjq1vNtlbSWCDOsUE3lEHjCjBzI5S4yKyrL9ZbfFFXoE6TvQvLi1wE5jFr
 Nfoq9vf1if4zI4g8wnzYSI/LsyBOaHTjMPeC5Xpi/8aMwvnUGrAScvZ1hOELOw9EHYtX
 ob6x9SWal19pBNuW7ogsPZBdI1KXAjGIySgH0srN8GrsiCrXYYIuVf99n8i/HiZqqZpd
 SYE1jFAcqa2YoY88ZyDM8iP+FSIFSfCem34HTOMVOxuG4tN2XXA3DU4X/Cwx1uPHi7lj
 WfY9lEWF5uVtnsIZFWrZFvqeXdfKe9PtA1oHbt2jb3Z2Xyz11mA3Yd1GFmfgl+6hCPAJ
 6VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741285357; x=1741890157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJykGVKcaLP5l3xku6vgViC/HIzBwAj3hWJs+T9WqbA=;
 b=elqGrvDgrcYwIUucdAEJbD3DukO+VbWTGtTmzicxTIutXjE2y4j38uBHOeO3BJlchj
 EqQNwIA361TB5UW/JuXrISZdpRw3+qgTfIQJtAYyDsOYxVp6Qt0bvfdZrNR9hZpGVef3
 EcGgmHg+Je2C2kh+tjtUc+GsfCVgtJluvkdUnepdDT8Il6pAbg+P4PiTYOeDy57dEnKX
 EMBjbLuhEWZxgUbjN/eRmBMhyNsvwJ5xVklU+8pBZETGpi9rz77wrvjHa+ZztV/NYXim
 ikpw+ON9G2rYQ1d4rJ8NXWPDdosE23l1vMaXIcOHuCpeRBYQ6DS3/vImqQmGaZdi/T6F
 r6gg==
X-Gm-Message-State: AOJu0YwmSYsy3IYX6CV/w8zd4z7vylVCZJnw7tBrnhCnyi512fQZiWp6
 LeTaFHTQZWfY4sgtQDuVkyTIYEcOAySAFmBh7Ki/WhusQ3fdbvUfWHIN4QfE6FJFcxtdkqpZiGI
 +QlSxh7vAQDgnnPow+NJYYUlQ7Eoj1A==
X-Gm-Gg: ASbGncsPRwRQFF37V4Aiuk1ogebnv/EzAbZfEyHdxlcZfLsgdiQhdmzOITEPHxKKfDD
 bRyd5acLZqKWRpNcmfntwBsQRkn5Xyu7QoM/GhraXAhk4KUjvXAKAxJ46Rsau/7hJWstiYy3O1U
 Umkmsv+nVO1FEjhrSGeeRPMAYwlg==
X-Google-Smtp-Source: AGHT+IFrrDTMrHWZH22Z53hruG6pUAqTZzNkk5Y0LbAH7Ly8GYunGLkrDtifC3bMETd3nquBWBmV4pGiTdwMjq8k3Jw=
X-Received: by 2002:a17:90a:e7c2:b0:2ff:6ac2:c5b9 with SMTP id
 98e67ed59e1d1-2ff7cef7552mr142811a91.3.1741285355165; Thu, 06 Mar 2025
 10:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20250306181956.14459-1-tom.stdenis@amd.com>
In-Reply-To: <20250306181956.14459-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 13:22:22 -0500
X-Gm-Features: AQ5f1JrISZ9cWnPQRJmUf29ojjiLwPvbLHJvTn6H0Hd-Cc-LYYZTHJw9dUuzg2g
Message-ID: <CADnq5_NTiSTXmgFLJeMv=DGxVq60Zp-kH=nBQAJgcxW0r-wQew@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing GC 11.5.0 register
To: Tom St Denis <tom.stdenis@amd.com>
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

On Thu, Mar 6, 2025 at 1:20=E2=80=AFPM Tom St Denis <tom.stdenis@amd.com> w=
rote:
>
> Adds register needed for debugging purposes.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
> index abdb8728156e..d6c02cf815be 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
> @@ -9478,6 +9478,8 @@
>  #define regRLC_GFX_IMU_CMD_BASE_IDX                                     =
                                1
>  #define regGFX_IMU_RLC_STATUS                                           =
                                0x4054
>  #define regGFX_IMU_RLC_STATUS_BASE_IDX                                  =
                                1
> +#define regGFX_IMU_STATUS                                               =
                               0x4055
> +#define regGFX_IMU_STATUS_BASE_IDX                                      =
                               1
>  #define regGFX_IMU_SOC_DATA                                             =
                                0x4059
>  #define regGFX_IMU_SOC_DATA_BASE_IDX                                    =
                                1
>  #define regGFX_IMU_SOC_ADDR                                             =
                                0x405a
> --
> 2.45.2
>
