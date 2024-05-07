Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ABEC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 16:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B5F10E334;
	Tue,  7 May 2024 16:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BEVYanJE";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2950910F69E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 16:57:59 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2a2da57ab3aso2622581a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 May 2024 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715101078; x=1715705878; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eR64wezUN6raTS7EuhhpGc46bTE7+kRT5ECvCjtWkzY=;
 b=BEVYanJEmdEgB8L4g7cxMBdSxnozT93E09Uv0eZWWzh1G19JaxyDIzTxu4UiZ0kAWJ
 wbBsrSSBK4Iwo6AV9hwmWw1x74KFVEx2j8tL0WBebIoDRyY74/+ozN28Gofslm9Z3keI
 IO2qn2ZXqWrP8fHyLdxEXAm4LcS2N6rW5Sz5BaxbQW+lUT+awVMdkKAvlvdAcXXf9cds
 OF94b5BASKKH3MKRwZhQGlUVyakWNkYh461T8qAN/4rjT0DIPGwwcDbk41TgOoBlwuAb
 rCCz3RfBvnDE4WnCL7/Fr8LT3SdRfBKtieeYvOsRNMNOG0m2CDeZZud+DR34GW7sXr8e
 U5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715101078; x=1715705878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eR64wezUN6raTS7EuhhpGc46bTE7+kRT5ECvCjtWkzY=;
 b=mgavCY8vU8TA4JGNRocM8giOPZAEICrBNaja4PN4BUeF0hF7wQ1Cm//tg+DXRlX3mY
 AKRpti8nRBDSdhHKpeNDWVxK0WVP/Ap31VSV9Op5CR21fbEErk8XiDqYTTekmX5o2ODY
 UZezoHunDL1Ik2NmC3KWl0ZQw/Y6TPV4CSiWNG4doNyGC3Ac/sc7SyXEQe0qliNySi5m
 QVl2OTF2dVl3J8O61iCMTuSTjdQW/zOwgC1szYCOENpaUX8l6yvD56zSBavzu/n7qAFa
 EiY3lnwmktbJp2R7+FfF9Bxeu+Kh/r9ON5UvuqCa/Qma0BlTkI+UabiY6rfmibMNuDkZ
 fXDg==
X-Gm-Message-State: AOJu0YzLcwZZJNd5Dm4t78vd0AJkK0nUDWbyVJ7Cg1DgLP4gI4eJ5fqf
 XxzvrPj/cavSrIJk7AO38uS5y7lSxVybss5+01wOzd7OvHRpDjFvAlSDES/bF+EYwQsrbxBMvE6
 AOr72T61DsN1zJ+0XdAYqB/JQQp9R0Q==
X-Google-Smtp-Source: AGHT+IGvk+0HuFDI6v2V+4fFvFwft9O84Ix2c9M0AfeiV+/mc0g8SQ57HuiTp1WPJY6XuZbnMJ2GuuFn49e22Q81Y1c=
X-Received: by 2002:a17:90b:3583:b0:2b2:9b67:198a with SMTP id
 98e67ed59e1d1-2b6169e23b7mr148904a91.34.1715101078138; Tue, 07 May 2024
 09:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240506080821.40070-1-Frank.Min@amd.com>
 <SA1PR12MB565939BF5969E2CC88C3E70CE9E42@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB565939BF5969E2CC88C3E70CE9E42@SA1PR12MB5659.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 May 2024 12:57:46 -0400
Message-ID: <CADnq5_OB+FcAmZeNHWS-0OiA=YRGQ_nomzDfF_W29KnvEzkZig@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix mqd corruption for gfx12
To: "Min, Frank" <Frank.Min@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Tue, May 7, 2024 at 12:12=E2=80=AFPM Min, Frank <Frank.Min@amd.com> wrot=
e:
>
> [AMD Official Use Only - General]
>
> From: Frank Min <Frank.Min@amd.com>
>
> 1. restore mqd from backup while resuming
>
> 2. use copy_toio and copy_fromio while mqd in vram
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 0bb119be2284..974219386e47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -2720,17 +2720,15 @@ static int gfx_v12_0_gfx_init_queue(struct amdgpu=
_ring *ring)
>                 soc24_grbm_select(adev, 0, 0, 0, 0);
>                 mutex_unlock(&adev->srbm_mutex);
>                 if (adev->gfx.me.mqd_backup[mqd_idx])
> -                       memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, siz=
eof(*mqd));
> -       } else if (amdgpu_in_reset(adev)) {
> -               /* reset mqd with the backup copy */
> +                       memcpy_fromio(adev->gfx.me.mqd_backup[mqd_idx], m=
qd, sizeof(*mqd));
> +       } else {
> +               /* restore mqd with the backup copy */
>                 if (adev->gfx.me.mqd_backup[mqd_idx])
> -                       memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], siz=
eof(*mqd));
> +                       memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx]=
, sizeof(*mqd));
>                 /* reset the ring */
>                 ring->wptr =3D 0;
>                 *ring->wptr_cpu_addr =3D 0;
>                 amdgpu_ring_clear_ring(ring);
> -       } else {
> -               amdgpu_ring_clear_ring(ring);
>         }
>
>         return 0;
> @@ -3091,18 +3089,15 @@ static int gfx_v12_0_kcq_init_queue(struct amdgpu=
_ring *ring)
>                 mutex_unlock(&adev->srbm_mutex);
>
>                 if (adev->gfx.mec.mqd_backup[mqd_idx])
> -                       memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, si=
zeof(*mqd));
> -       } else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
> -               /* reset MQD to a clean status */
> +                       memcpy_fromio(adev->gfx.mec.mqd_backup[mqd_idx], =
mqd, sizeof(*mqd));
> +       } else {
> +               /* restore MQD to a clean status */
>                 if (adev->gfx.mec.mqd_backup[mqd_idx])
> -                       memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], si=
zeof(*mqd));
> -
> +                       memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx=
], sizeof(*mqd));
>                 /* reset ring buffer */
>                 ring->wptr =3D 0;
>                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
>                 amdgpu_ring_clear_ring(ring);
> -       } else {
> -               amdgpu_ring_clear_ring(ring);
>         }
>
>         return 0;
> --
> 2.34.1
>
