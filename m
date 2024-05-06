Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1159CC10F16
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 15:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857FA11216A;
	Mon,  6 May 2024 15:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K/Lx1mdA";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9A711216A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 15:21:13 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-6f450f43971so1466701b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 May 2024 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715008873; x=1715613673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UROUayVdaz8/NIecXbfHeYiPUUBiZvWGT/dLOM8E3bw=;
 b=K/Lx1mdAWUKkB8ifyezOLvH3U/+bFM3XibL5HMqVFctFQsiNcJaaPP38wxTck7wFHQ
 4trBLNs0V9Hr/XiRxs52kyIstAtZPCj4MA0StIKjQbCrUbj+DJmFZRI+zqUAtE6lqse6
 gA5hF86bgijsi4CQRjovtsmQwegN4FA5uKcKSJ9w4uPEIBL/lcCWndPVabMmWOYotydk
 397jXHFougYpZH3bw2fpncOKcJyDksejLgGA4GKRqwcMUteCNIk7yfYz6OPji4A3RpqB
 P77PwmZvdCRK2a8FshJ44wOhryHlI3Tcb+97PNs/dfZh0hE3q3V6wHfsLIGoICsFhinN
 PbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715008873; x=1715613673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UROUayVdaz8/NIecXbfHeYiPUUBiZvWGT/dLOM8E3bw=;
 b=GHpG5J11S4soKOen8djJzsrm6kfnNFFNWcNpa6HsVWkk43zP/1qPYULyOW0ddkr+yj
 quu1I0Ej2y9iHlZ1eRLm9UFMy8tVrwZDFUMN41kLvHFzhP9RqnmdRuHPw3Hhdtf1LJFM
 /vJWeR64BwkxrlH0+w6XlY8fa4wIgnueRHe+Fb4djWbv13VxpGVgQL4POlPJegA706DZ
 fvRrmjP6HyPv8PE3pojiLHBMiOsZXFGNLQVtzs1PHG6LSm8/hE4VtUIL1zoEZiEi4why
 EAn4DRe/9M/CJWsQK5rMz1lO+PoNpkeFO1Y3ORZckaSLxOYIWvDgkpuTXwyys6M+T1Cl
 JYNw==
X-Gm-Message-State: AOJu0YwHKj63ZdD+38tWPzP8bQ2ucw6QZZ+LJ5DhD10GpPs0MLv1qVss
 bN3nTZLIDIDkf7+7cwVd30jx158iHBNYAXmTmIxhfzgI/XmJuYBEqiKB+qPAtBibob5p7cMsGsV
 vkkb5aacy4gyctpP0kdLlOnKhCyHSnQ==
X-Google-Smtp-Source: AGHT+IHtEH/Ze7jW5IBWfF4YkRcMrAjqxYJuTG3Wz4Ce4HZOixDH8lIvsyr+fsaPz0sF4q7gUE0uIfh98UhtsignsRE=
X-Received: by 2002:a17:90a:e60f:b0:2b3:28be:ddfa with SMTP id
 j15-20020a17090ae60f00b002b328beddfamr9965934pjy.38.1715008873009; Mon, 06
 May 2024 08:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240506095630.258594-1-Jun.Ma2@amd.com>
In-Reply-To: <20240506095630.258594-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 May 2024 11:21:00 -0400
Message-ID: <CADnq5_N4qt0CH9ERjwryiu4PmRw2o_8rBgT1se9UUKcTmabbwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix uninitialized variable warning in
 amdgpu_info_ioctl
To: Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Kenneth.Feng@amd.com, 
 Alexander.Deucher@amd.com, kevinyang.wang@amd.com, christian.koenig@amd.com
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

On Mon, May 6, 2024 at 6:22=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Check the return value of amdgpu_xcp_get_inst_details, otherwise we
> may use an uninitialized variable inst_mask
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index a0ea6fe8d060..977cde6d1362 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -623,25 +623,32 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>                         switch (type) {
>                         case AMD_IP_BLOCK_TYPE_GFX:
>                                 ret =3D amdgpu_xcp_get_inst_details(xcp, =
AMDGPU_XCP_GFX, &inst_mask);
> +                               if (ret)
> +                                       return ret;
>                                 count =3D hweight32(inst_mask);
>                                 break;
>                         case AMD_IP_BLOCK_TYPE_SDMA:
>                                 ret =3D amdgpu_xcp_get_inst_details(xcp, =
AMDGPU_XCP_SDMA, &inst_mask);
> +                               if (ret)
> +                                       return ret;
>                                 count =3D hweight32(inst_mask);
>                                 break;
>                         case AMD_IP_BLOCK_TYPE_JPEG:
>                                 ret =3D amdgpu_xcp_get_inst_details(xcp, =
AMDGPU_XCP_VCN, &inst_mask);
> +                               if (ret)
> +                                       return ret;
>                                 count =3D hweight32(inst_mask) * adev->jp=
eg.num_jpeg_rings;
>                                 break;
>                         case AMD_IP_BLOCK_TYPE_VCN:
>                                 ret =3D amdgpu_xcp_get_inst_details(xcp, =
AMDGPU_XCP_VCN, &inst_mask);
> +                               if (ret)
> +                                       return ret;
>                                 count =3D hweight32(inst_mask);
>                                 break;
>                         default:
>                                 return -EINVAL;
>                         }
> -                       if (ret)
> -                               return ret;
> +
>                         return copy_to_user(out, &count, min(size, 4u)) ?=
 -EFAULT : 0;
>                 }
>
> --
> 2.34.1
>
