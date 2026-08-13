Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3428C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 18:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0C710E50A;
	Thu, 13 Aug 2026 18:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hVRmu6Xe";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA7D10E50A
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 18:33:03 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-392af6bda98so29890a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 11:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786645983; cv=none;
 d=google.com; s=arc-20260327;
 b=FWk65eMjuQs/Mn0F17qMGKEZV55qAIZ8lqgh4AmTqob1Bit/YKMZckQfarO7Y3lZ9e
 hG0XQ8L1cG2i51WmVg/cpjzR4IpqqdwVJzq34Mz0UM9A+zx/0tNu3musNFaXxIwSjjD9
 7CqQ6rFS5yO+EQB1eBStj7FX0LTe7Ih8PASZEj/m/BsNN95BSQyxQQ5W+BTEgRZ8NJzl
 /rB6B0gE+yCcMoqWNUPuB2o5T6plPxwPjbd4haZFMCBY2AjKdsWRqVtXciyiZKA00t3h
 sg05pli3/r4f46Ck7ZrKI3kZ+zIObIzu8ZzobINth5lKlzAI16FOdFpNH/VZCwCgL5L+
 +HEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hav6mMeW4xpM/kIYE4giCMkk3YpiDnvoMFDqD4xLPP8=;
 fh=8ctcLcTMQegsol4jW1vK0/TpYIQESQo3t9uXEfVRTmA=;
 b=T1CMJy3FVnYFzAxSZf2Kui7PKqgecabA5dOBXhb6DmfS2rtLBoLYu7iyNEOZWLqQQJ
 DnBrxGVLDb89ei5U13RmHGjVm1Bi8pZvFv5g9oYErDZH3TAjIy05IYTR/qfoEduZZWju
 NGm/q5mANu6rOBW2g3UysD9UHcLTG2BMniQx+RmpFyP7oE363S/TDpZOSWZ1AWFU0Irn
 XVUPpA+GeGGEzVj4AmaA9jvJQdkc1pCHsR17qrTuTO06XIV3n9DH8q1plcPsJUxTM9ZG
 HlZ1nN4dU+78QcHt+IuKq5roi7tQ0fpXEt4Rf7H/TmXHuNKZzG+hL7EzX/S41K/20uBQ
 VwUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786645983; x=1787250783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hav6mMeW4xpM/kIYE4giCMkk3YpiDnvoMFDqD4xLPP8=;
 b=hVRmu6XeADX1zdiyIvf2GrQgDgmeDgh2xrJ4cCszx5c+HVENbehoWkBWr1wgCi2kqG
 sja13zXU8jHSL3yP9JmLiPsB3MIp0yjq3CZsqpOS7O1BOTI70aFqAFW1XcxNp4/VDfTf
 ShDaZmnFM9nmzaTLDuwe6h5bhZ/ZkR6DPll8xaazLvFSja5t7nFcVY13vbsplX5QkGd3
 e6c6UaoTl3hXeNMCkKRrKabCJP1fUBxPzIblhkDOTceVMBSfp/rLNAAeQOy+NNzruS4n
 XUrxeMiDsS9J3i8KMUtWt2VDPJqtgBhiLYl9DgXmxyaUnPU/zhsLEtR6k05digOiyqHg
 U8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645983; x=1787250783;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hav6mMeW4xpM/kIYE4giCMkk3YpiDnvoMFDqD4xLPP8=;
 b=IhaNwaZaqXqkcRkrLHOI+/sMsRpJy8+netgHHqJhPqqS4aN8vj8Q9BEzJeWGFSyBXf
 OEFHN0RIvOHiCYOkOpk55XzxNfYRXaBiuKmnTx/NzhC4pFkfoMgqlY1GmSP6P/ZOB05P
 plk8LA/OQe6uqxLbQzNG87TKN1UECidHWmzK9P0lk0u6Rxg6Z0SJEEfTwvWD3nTuPBeQ
 RwoPt+FtMLEMkezYE33zH8iVn/orJL6YotqBKB5lICKknc4tuErt5H7ZDEmTO7ABiZIA
 UMLRnMfupKRB6VLIt+5eBA3JCJctamVCvZIWFalJjg55JpG8A/nUdUjQQZWboiAa392Z
 jibQ==
X-Gm-Message-State: AOJu0YxnGJK56dwZUMKfJyD1bOtXGht9oeFVqmLaFeRlXlCVubvu1wws
 eb89S9fYjDoxiptDJ50cBIwy0+KPjiGzpajgA8PQzkVajEYF6Iib/xrrvclDJuYx/z7KjdteurD
 rQdCigodnKPpxKhsSO0cI4PKXhJEp56ZPPw==
X-Gm-Gg: AR+sD11/7dPEVB9PqkawRvP+rzL1gCcmODrzy+ambFMpJiHU5HopTRPyvR9n+eq1Brp
 gv5c1bxEjD0M6EtPaomqVm2Q6uwrtk/g9xQ94Cm0g+97TrkoRhpWe9zO0tnDjIFehNiwNZNAzzm
 g7UxJF3BQNWwcOXdBPV5eYUMWxT31/APCHfoksWx4G2CRdlvXG5jXyoXD21a1AIzxs1tNmtRLoV
 3AMPekHR6CqHH4XZW5NaExmBX1MWVIFwD/AJ60ACk2DUJJaucoj9IESMJqAXHk+r1ga8POuCRHa
 nOFbsqFieMn8798O8kfWf7cOOojKgI4W5IO8z7w2vT/GrXFn5O+SwlOltkYOGEEpRsA00++RQzA
 nS6Wz4jG/J0EBykj2LY1Ha0Fay+ZXBoE=
X-Received: by 2002:a17:90b:588e:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-3931e31ce69mr6810819a91.4.1786645983209; Thu, 13 Aug 2026
 11:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260813043706.3195196-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260813043706.3195196-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 14:32:51 -0400
X-Gm-Features: AUfX_myi7pHqmJG9FJTPigIv6K9x1N4y8hsr_VCpSCXU2i7Yyc9kZfZUCMlX3-Y
Message-ID: <CADnq5_MamKsSzw0DbU-kmkb387xWkH=q51LnpJts=Fd3CekpYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: force complete the KIQ ring fences on reset
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

On Thu, Aug 13, 2026 at 1:35=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Like the MES scheduler ring, the KIQ ring sets no_scheduler =3D true and =
uses a
> polling fence, so it is skipped by the force-completion loop in
> amdgpu_device_pre_asic_reset(). Its hw fence value lives in wb (GTT) memo=
ry and
> survives a MODE1 reset while fence_drv.sync_seq keeps advancing, so after=
 a
> reset the first KIQ submission can poll forever on a seq that is never wr=
itten
> back.
>
> Force complete the KIQ ring fences too so their hw fence is realigned to
> sync_seq.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 168947747c5c..77426e814e08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5049,6 +5049,18 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_dev=
ice *adev,
>                         amdgpu_fence_driver_force_completion(mes_ring, fe=
nce);
>         }
>
> +       /*
> +        * KIQ rings are polling-fence/no_scheduler like MES, so realign =
their
> +        * fence too (one ring per XCC), otherwise the first post-reset K=
IQ
> +        * submission polls forever on a stale seq.
> +        */
> +       for (i =3D 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
> +               struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[i].ring;
> +
> +               if (kiq_ring->fence_drv.initialized && kiq_ring->sched.re=
ady)
> +                       amdgpu_fence_driver_force_completion(kiq_ring, fe=
nce);
> +       }
> +
>         amdgpu_fence_driver_isr_toggle(adev, false);
>
>         r =3D amdgpu_reset_prepare_hwcontext(adev, reset_context);
> --
> 2.49.0
>
