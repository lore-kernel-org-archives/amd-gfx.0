Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D88CCD18A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 19:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7119C10EAF8;
	Thu,  9 Oct 2025 19:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T1GmlAMg";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7127B10EAF8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 19:09:08 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-27eca7297a7so1889795ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036948; x=1760641748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2f0qiPdLVn0zJXkx0STmg3r7ArBWPKQHgzGs185EU4=;
 b=T1GmlAMgEsBxHADDugUv4w5Irbo5uLcj8NmrooktqXbCZhr3r4EjRkUT6xphhBGKib
 ffdc/ZokyvobRxT63lyst7Fkdrmos+Id3nGzuemNZJwUQ6kHOfVR3M6cP3l8aIodpS+g
 JwkTJE61CoRSuZ9pfxYfa1uxruzPItINpIznoBsxAtjN5pj/kHO8Uj9w8hc273VDE3sJ
 c8mK2KK8DaRK7oRc7pJf/Na2uX3diUxdmQvIXu/YDJQq6YY1WNwfvfI9M0LtdG07C5yw
 C4R5hCLT6ae2FL1ZPdq9zcBsHZUv5nqEz0Ww3oLmLk8aF+WkE5xucSFVcQHYBGDHs/jv
 VVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036948; x=1760641748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2f0qiPdLVn0zJXkx0STmg3r7ArBWPKQHgzGs185EU4=;
 b=IfiGdUnJIkE7KuzBRwltn0n9wKl3OZnO+Z2ETkN6dHYGiTxc/kGp/dj+2D7uh9EQIg
 X7DVo+622AEBnIc8pjXDfttQoh0J3XCmZk/NqvrNX4tqreA1rvKBjV+24fKgEZZmGDou
 5w3wnGXgU2vOrrVdgCROvqbjX1ZkszPnI5SL5hkukRseYeYJHXGgV08W/6MMzl+8zYB3
 NYH6a+Alwzt+I4RL7yVZscL62cjh7VPWvrVdXs7BBt1l1KARojkTFgjTczBzdY5aqsDU
 LGDzIoaomau6eF3rB1A1dR/8QOfHoXZuCekCCK6pNT8rkRSh3/yxZBF0zCpd9Z+IJ9Dv
 SITA==
X-Gm-Message-State: AOJu0Yw+nY2yP4fqVPjAAjlpVzF73R9CetrloWP8F14cEdKpCmz5PNcR
 hqwgI8fzEit/pIAdT3F6FLuhLbpUcUQrr3xz+bpBcd7xocW/g77xBObOpOL+9ey8wAV9PWpPVwH
 gyKwTaPnAbEygEG4uTdwrYkGQxS5skOhDrQ==
X-Gm-Gg: ASbGncs1FisyZHLEbNmLnwb4n2P96fPEPvDfPzaGZWktqAXr02s42UuwvbUNTiunLOt
 F6OYKuOBsmXjSDUDwFV9xX6FD0TzYp/PKZQLTGYsFC551Y3WiBtFsqZKOq2/4E8Dwjp15vG3TCn
 axvkt13xrdp8czkGDgn9CxUW2cdhN1fStE3ndP7hHhOjbHt/iVk86VwVYoB9fplsGpy9o7vQES5
 FL/s/YLCT3abcdZuf0EIas/DY+I+48=
X-Google-Smtp-Source: AGHT+IHV2q9O45w8kJ2Fdsf/i5r2m6c7Tv0o8aZyB2F6ciwC7MJkheJhjELOe/zNU40UrHCIt4PP4X2A0dRecMV+m4M=
X-Received: by 2002:a17:902:d506:b0:267:af07:652f with SMTP id
 d9443c01a7336-290273369aemr58030575ad.10.1760036947958; Thu, 09 Oct 2025
 12:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
 <20251009184929.1038298-5-jonathan.kim@amd.com>
In-Reply-To: <20251009184929.1038298-5-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 15:08:56 -0400
X-Gm-Features: AS18NWDiYkJexSlwRlPFi1FY4k9hlYWTGnmw6s4pmFRNmT0Iz_tEXcN-K-XCtQc
Message-ID: <CADnq5_OrEiFhqZFKUgspbjYGY5tXWn_iSK5Jz6pO8XWPJgTCsg@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable suspend/resume all for gfx 12
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
> Suspend/resume all gangs has been available for GFX12 for a while now
> so enable it.

Is this true for all released gfx12 MES firmwares?  If so,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 1af3ddb6f65c..b2f87bc29f00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -698,14 +698,11 @@ int amdgpu_mes_init_microcode(struct amdgpu_device =
*adev, int pipe)
>  bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
>  {
>         uint32_t mes_rev =3D adev->mes.sched_version & AMDGPU_MES_VERSION=
_MASK;
> -       bool is_supported =3D false;
>
> -       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0, 0)=
 &&
> -           amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0) &&
> -           mes_rev >=3D 0x63)
> -               is_supported =3D true;
> -
> -       return is_supported;
> +       return ((amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, =
0, 0) &&
> +                amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, =
0) &&
> +                mes_rev >=3D 0x63) ||
> +               amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(12, 0=
, 0));
>  }
>
>  /* Fix me -- node_id is used to identify the correct MES instances in th=
e future */
> --
> 2.34.1
>
