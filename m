Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37338C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AC110E39E;
	Mon, 15 Jul 2024 12:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i6Uts5E+";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F5110E39E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:54:53 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2c980b08b4bso3286318a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721048093; x=1721652893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjNG+DpEUInU4L8zYZuudX0aAugftazQ1as6Nki+oL8=;
 b=i6Uts5E+lIeP5VQWK41QmJIY6pOYA8s8AZ7QpxhCY2EfrWigY4dMsr1m3A24zTsNf+
 yH5BfCZr6WhQB0E4c6P8U13vodH1P6eLx7+QDs8wxWMuflZmakYg+Bw/CgLibDKiSbkL
 YHYWcI0aMj+ito2u6YuMNYyAkrhurUJH0rfoPNS8G0fKWzvBhzgu4cpwfZ1k7KXDpBn7
 Z5FZhY5I2FMKpAwCmjGwCzVodMoMmvJiWKXxOFTbLwKY7AJ0qwCEDNB/og1/9+VhK73m
 6+FqUNdfZt0q4Q1FhI5kl8jdCRa0BYPLLWoezoBUUmwnDrxSLxzm9w/G1J2Pxi6+Rfmh
 W4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721048093; x=1721652893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjNG+DpEUInU4L8zYZuudX0aAugftazQ1as6Nki+oL8=;
 b=t5pRtLXi4Xd296ZJFzP9+4kQAA53oZGxPvnhZ2/zRrMcOMD/3kgCMWJqxBhxR1o4gc
 rc3VMPRVcVhi8/0m3mybrylirUSbphAm0duXXeI/5nI0jNSG3F36/mqXKgaIfHQ/1Emv
 dbQyD5j4GUN2D0LW8ETQasHqRSKEKiS+Ef4dLEgpPxM/ATNj2QcvzDxoXt9jOH6TDYR6
 LP8p3f1h/QpRt7oJVJDuwAwTehnErOj7FU3A1i2x6sYxCya3w9mOnGrm3uk8xoCM9vdL
 4Xd9YVavBcMpDpxxD5lgVC6BnLWHu8P2pF1Fe/VBkVKhv6DZ2s+HZjA3a5ZutPjtoKip
 m2Og==
X-Gm-Message-State: AOJu0Yx4Rfuugmkqvs/nsuH5rC+gnkwJa023lVqJMRx2AVpauKDS3zDp
 fnJstqvpLem4AAFfhwEsu1o3wlhtuXQegTBmqBgtHBf6rYUSdFr/1uWm1FvJt20k2UUmAv2uhaw
 zrGYp2bBmVq0Pl3DTMnYkNw77IX8=
X-Google-Smtp-Source: AGHT+IE3f6ZZ2wPqM2kQrxS9Sn3E5EAW33p2tM+Wk8W3NlEXIN40275j+0Lm7Pjqxy9QCn12zd7vnbW7aZ9BjPTnAVc=
X-Received: by 2002:a17:90a:578c:b0:2ca:8b71:21f4 with SMTP id
 98e67ed59e1d1-2ca8b7123c2mr11889875a91.18.1721048092852; Mon, 15 Jul 2024
 05:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240715022139.2575229-1-tim.huang@amd.com>
In-Reply-To: <20240715022139.2575229-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jul 2024 08:54:41 -0400
Message-ID: <CADnq5_MNc_p=MehDzQvVV_23pZ_+_os0F0K==ZSQqjjGk1eyTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: early return if disabling DPMS for GFX IP
 v11.5.2
To: Tim Huang <tim.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Yifan1.zhang@amd.com
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

On Sun, Jul 14, 2024 at 11:40=E2=80=AFPM Tim Huang <tim.huang@amd.com> wrot=
e:
>
> This was intended to add support for GFX IP v11.5.2, but it needs
> to be applied to all GFX11 and subsequent APUs. Therefore the code
> should be revised to accommodate this.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index d79bdb1e8cdf..06684e29db23 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1922,20 +1922,12 @@ static int smu_disable_dpms(struct smu_context *s=
mu)
>         }
>
>         /*
> -        * For SMU 13.0.4/11 and 14.0.0, PMFW will handle the features di=
sablement properly
> +        * For GFX11 and subsequent APUs, PMFW will handle the features d=
isablement properly
>          * for gpu reset and S0i3 cases. Driver involvement is unnecessar=
y.
>          */
> -       if (amdgpu_in_reset(adev) || adev->in_s0ix) {
> -               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> -               case IP_VERSION(13, 0, 4):
> -               case IP_VERSION(13, 0, 11):
> -               case IP_VERSION(14, 0, 0):
> -               case IP_VERSION(14, 0, 1):
> -                       return 0;
> -               default:
> -                       break;
> -               }
> -       }
> +       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) >=3D 11 &=
&
> +           smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
> +               return 0;
>
>         /*
>          * For gpu reset, runpm and hibernation through BACO,
> --
> 2.43.0
>
