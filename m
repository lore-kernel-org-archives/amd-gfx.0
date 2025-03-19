Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BF0C35FFB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 12:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DBD710E4F3;
	Wed, 19 Mar 2025 12:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jg1JGjkD";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB8010E4F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 12:53:44 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so1240565a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742388824; x=1742993624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R43In3jtKWhBcif9cevyDYJCDUjTbFZiZP/mbldFrtA=;
 b=jg1JGjkDf9s8tfuquODYaLOmvJPFq5EKetNRL4Wd5HF/lPfA9zgT6IMX36YUH/kmyd
 jy42J4n92YawQ28/v5Bi2uCH+IGdCvGoW4vN0cLoLZT+wtK3t+SXXAAInsHtpWWbAZ1X
 gWeMQOMMwl6/nXRpQqNejaxd+L8u4MBI/2cwNecprrGKO0YTv5M6lZgSRzDHyzJRLi/J
 /ZKuZRbf0uu7BtTTYhGtYxfquOk5wvt8ak+nm/CVgyuXUvgYJpKCeHNwnyDHIQ3vOxLP
 V5MhIY/8PZ+PQtVoAP/ci4H7TENAeHEvB0x8wAgLAWGrt0HTS/+5rxOD5oxTpAoYaiAo
 HVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742388824; x=1742993624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R43In3jtKWhBcif9cevyDYJCDUjTbFZiZP/mbldFrtA=;
 b=xHEbPIkGYZFGSdLRpV2Tt1JTkBPWD20FOVGXcXMvfdEG1Ki8nm3qhG5a4soj0dsxBt
 0NQC9/uU+usV5KXLs967OERt9npcFJ8T4nxrUm/EzSyg84ZSqiPnIyr/LWhgEb/QVgun
 VIv3UgYW1y+ZWwrIr+FrRZPSYr0MVoXTafUDmDZn4lXnuLtux5Pqr2q+oMmDDosCbmxE
 Z/aebMXSiZ0aMEo/ltg1lAlemExtL4cYqItyAR5uu34jJQQ06obFI80a+bkpD6aHzk00
 ojAyqVZXY+MSO3WymUlsqNq8+nXlLfOiF0hoJ2ZYgq8+ONu9GkOvSDFkXTk8zQ556q/Q
 aKhg==
X-Gm-Message-State: AOJu0Yz+IhP12RnrbZBMdZpiglvMoc+ej9Fjwkw+s0wxtknnZh0i1QYO
 z/3vgxUPN0yBni5xqX9SPIPwt5PWu0k+z/ZqtA3G33YajXzrd+8+H501wvTPOwqbewiUWmwxVUP
 at0Q3L+gkr9N1lh/HUuvgN04BaBIBlQ==
X-Gm-Gg: ASbGncu1wl8SJdfqlwB6RYRKMIgXupNBmBCIKc/MsJA/Dg/IoKZXvscube2q0G7+tsj
 fblFnMC5MnGeAbnUcxcMO8X0Q7JfLS179QrFguIdPPzImlI4BdWEurzJPVSH2Ev5ABNc8JXmPhA
 QRsHnqoEDVd+PL3vDdJy5YY6JdHWRHTP9IkVvd
X-Google-Smtp-Source: AGHT+IGFvspS62hF6L+BVI728Oi/BWO78V3x7FkZby3JdnmgAdebnl/35w/rYer2IZwvnUFAssqsmH+VEkJeI6tPzsg=
X-Received: by 2002:a17:90b:33c4:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-301bfcadafemr1194248a91.7.1742388823764; Wed, 19 Mar 2025
 05:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250319063811.680138-1-kenneth.feng@amd.com>
In-Reply-To: <20250319063811.680138-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Mar 2025 08:53:30 -0400
X-Gm-Features: AQ5f1JpTtgA0KT8JA9g0NCrJQ_6HBRU9ExLRDfNvS8ZnQGswLpnDCnTPvzB7moc
Message-ID: <CADnq5_Nx2FGd66uwkmV6Hhrvdfc+VTO=OafZJDK=AVXhBKQM7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Revert "drm/amd/amdgpu: shorten the gfx
 idle worker timeout"
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com
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

On Wed, Mar 19, 2025 at 2:38=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> This reverts commit b00fb9765ea4b05198d67256118445c6f13f9ddf.
>
> Reason for revert: this causes some tests fail with call trace.

Do you have a copy of the call trace?  I can't see how this would be an iss=
ue?

Alex

>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index a6d3a4554caa..75af4f25a133 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -57,8 +57,8 @@ enum amdgpu_gfx_pipe_priority {
>  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
>  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>
> -/* 10 millisecond timeout */
> -#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(10)
> +/* 1 second timeout */
> +#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(1000)
>
>  enum amdgpu_gfx_partition {
>         AMDGPU_SPX_PARTITION_MODE =3D 0,
> --
> 2.34.1
>
