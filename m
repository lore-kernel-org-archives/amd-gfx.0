Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C44C5CFDB
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 12:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747B510E413;
	Wed, 12 Aug 2026 12:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k1JDh0Rs";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CB210EF12
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 12:56:30 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-385b78b4f9bso180694a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 05:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786539390; cv=none;
 d=google.com; s=arc-20260327;
 b=rw5LxsWbqtPX5O2TFyMrkPHv+wRQG05ldoK9ZUVP0hgMaw9YEFjOaqb4HlcOY7r2bI
 ntfOSufj2Fh/AgXK67/wEC0paXcwoP6e08yzGJgairiZhgdErzOS5U8oz7XjwJgnqX3O
 NMxQqBq3uFX1Ofqoypzp8fh1TaEZkzXnWsA/BLmwwSJWnray+N90YmKku0RYjD4d42X3
 USkos9GS0gSKy6rZD4jz+RQZv2JNEmrkkL3BH5GLehfOM77wVdYMHPkFrzyvI4rvHbHn
 mKbGa7KpmETTMtiWLkv86y7emdLzSXp638Hf5YjJOOLc0q8wog4KZvjHgd4Kw7GjjRTm
 WadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D+LcmQESFF0P0RuY5S7aDIeT7+kIzCB74smOfajljks=;
 fh=8ctcLcTMQegsol4jW1vK0/TpYIQESQo3t9uXEfVRTmA=;
 b=IaHnaMGalww2XrIOkag8RAsaOWLwMexXcDKbOSafW+j/WaJaqQBDWOLbonGhtF0lbM
 SycCU/9fhBzSo0L+BTK5OAmrbn+YV3eMB0Yv326dyCTWvV7XuCEIDf0qMhFMgri9xCd1
 GzQd733LuDHDndYlN9R2KxS2NNUV1/YsX7Hjdne/nmTtINnZtUoL2+SSCBQfy75OEtoy
 Vyu9GhzZroU4KBheuRmJHpNkeyjrqqBAufSq3BntHhYWWQLRBUoiLa9ELHNsbkk1V0N8
 2Ypc9uYnp4axZI6TrMDZQEIQCZjZgZfXAQrD/m05UbyHClVpstktE0+6CD5CkBbf5PL4
 viTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786539390; x=1787144190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D+LcmQESFF0P0RuY5S7aDIeT7+kIzCB74smOfajljks=;
 b=k1JDh0RsbiGyBkhex/G+sEC+L05YebjRdeta6GJLklu4YNtYhgpq21wVnsxfrHaTb2
 SwaXPMGCrz1pzJhIr4KkcEw3l36Ix+WexUr9GljUkMvVftZXK1fohSTwzpHhWxoH2qss
 8e9zAWmk4a+K2K2eIFvmR68sg9r7k0gymvFuoozVo7XzeLTGGwWQ7Pv3814GLFWtU71h
 j4F6XaFGO7pOSYv42+gR//ZCU9OLiIm+KywJcfhZD9S13neeEuZymaCkN1dRmDzjikvA
 IRGpkYaQNkyWpNYYzzsspPQt2EaTCFDCnW650SjpEt8BP3r/GcMRoBuwxH5/lucIvZ+v
 HrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786539390; x=1787144190;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D+LcmQESFF0P0RuY5S7aDIeT7+kIzCB74smOfajljks=;
 b=QPucvDFlKR3MI8VrW57AA/CjVf49Hw3L5J7BDMRrXV2DHcosI5PWfXDjQc4rH/OMIe
 2dXeA4R1bs2GAh6eJEd+1Xy911DsSE677jqRwCllUjAL0JCNZPyG++v7mE1XxH50pWY6
 FeOg1bCbw9Q72lkKcw+ZfH6qXH53Hbp1er41SjVs2svlSd2Rcw6w+S6GJfMVTf2leCP5
 3HmK4DOHPJplpagDJ/6TTWrSSDdIAVOJ3ldawVyyxgvs+S9TPOEeeD/TzC1tAZek1/Ss
 GHS2114Vu5xgwoFKlPcE7/wDjkFP4ZGsf7dRyTgyCpa1pHrroxhpBAwjTG3NmuwI4JQu
 6b8g==
X-Gm-Message-State: AOJu0YxfXXONd0xO7OH1Tbh7hBxzH+NCrNObUMWBe7ACu18Z1yBgi7bg
 SIfLThnFQDq2QZPBFcpJ7nPX+saqVoFRdmQmwxBRuptnYUkSvrMWMC8dnpp+UOnUjnjvSOqiooQ
 IKLXt0XJ7kPuF5JsGaTSQHY/BMfbA/8Y=
X-Gm-Gg: AR+sD13XMa/cngq5MKrgbZ59FqLzOuXFXGR2nN7JTU3JfQm9QhYM+Gl0fjCK5c0ZD/4
 vnA0IcqH6EDQrxFyY0VtGQ7f81mPudpntwzeHR/eiccno7NFIgWvzIVb5y/UdQBFv9ejvJ0rDUD
 wPhclCQ9qRvfRTr4eS5QnN5dk6Ion3XT3+GBeG/uSQ5kbGsZ7EVr7XdQIh0ACvj8EjTimABIXQb
 IAhGTQdTkoEfL5DneOVPqeUPLH/+zf7lnITCOUYXMLj7eTEZJPWxRRItssYmWR+IgO8iX3bbZje
 htFlWVw8bI2TJ1YG42grIy4FKRz+r7bxDJObH+pp9bcv7t7jhGe8cUEW1EqWoaoEJjpPhtkZLp6
 /EnP0wdCJqOBnz75JtVBcx8kj5kzkU8Y=
X-Received: by 2002:a17:90b:17cd:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-3930140f403mr3748050a91.3.1786539386721; Wed, 12 Aug 2026
 05:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260812092414.2513383-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260812092414.2513383-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 08:56:14 -0400
X-Gm-Features: AUfX_mwgYWpU9m150I8UjJxdN2pooz33hSAPoHakOfNK4yzBb0QrEMr1RpZD7Jo
Message-ID: <CADnq5_MrzP08w+S4nXeo_Xr+9Uxkd627RCJKq0958SCD8TysxQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: force complete the MES scheduler ring
 fences on reset
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
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

On Wed, Aug 12, 2026 at 5:30=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> The MES scheduler ring has no drm scheduler (no_scheduler =3D true), so i=
t is
> skipped by the force-completion loop in amdgpu_device_pre_asic_reset(). I=
t
> uses a polling fence whose hw value lives in wb (GTT) memory and survives=
 a
> MODE1 reset, while fence_drv.sync_seq keeps advancing for every packet.
>
> When the reset is triggered because MES itself stopped responding, the
> timed-out packets advance sync_seq past the last hw fence value MES wrote=
.
> After resume the first MES submission polls forever on a seq that is neve=
r
> written back, failing the resume and wedging the box on a second reset:
>
>   amdgpu: MES ring buffer is full.
>   amdgpu: *ERROR* ring gfx_0.0.0 test failed (-110)
>   amdgpu: resume of IP block <gfx_v11_0> failed -110
>   amdgpu: GPU reset end with ret =3D -110
>
> Force complete the MES scheduler ring fences together with the scheduler
> rings so their hw fence is realigned to sync_seq.
>
> v2: cover all XCCs (one scheduler ring each), not just mes.ring[0].
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

KIQ needs a similar fix.  It also sets ring->no_scheduler =3D true.

Alex

> ---
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 520fd59036d5..e2b8253489f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5036,6 +5036,19 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_dev=
ice *adev,
>                 amdgpu_fence_driver_force_completion(ring, fence);
>         }
>
> +       /*
> +        * MES scheduler rings have no drm scheduler, so they are missed =
by the
> +        * loop above. Realign their polling fence too (one per XCC), oth=
erwise the
> +        * first post-reset submission polls forever on a stale seq. sche=
d.ready
> +        * skips KIQ pipes.
> +        */
> +       for (i =3D 0; i < AMDGPU_MAX_MES_INST_PIPES; i++) {
> +               struct amdgpu_ring *mes_ring =3D &adev->mes.ring[i];
> +
> +               if (mes_ring->fence_drv.initialized && mes_ring->sched.re=
ady)
> +                       amdgpu_fence_driver_force_completion(mes_ring, fe=
nce);
> +       }
> +
>         amdgpu_fence_driver_isr_toggle(adev, false);
>
>         r =3D amdgpu_reset_prepare_hwcontext(adev, reset_context);
> --
> 2.49.0
>
