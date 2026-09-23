Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D5DC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 13:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE04210F01C;
	Wed, 23 Sep 2026 13:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hji+G/n9";
	dkim-atps=neutral
Received: from mail-dy2-f38.google.com (mail-dy2-f38.google.com
 [74.125.229.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC7D10F01C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 13:09:22 +0000 (UTC)
Received: by mail-dy2-f38.google.com with SMTP id
 5a478bee46e88-339795849f6so204854eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 06:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790168961; cv=none;
 d=google.com; s=arc-20260327;
 b=GQl6EUPaBIISHVEiQbpV88uQGTaJ5Z+11U9xxEBwn7HITWyPtmrQuKy+AKYyqzNlSt
 Ggzn+2Wik20PEK0eR+Loe8aIrwxemGF5OKwwYBRFYcewCdMO/JHjyVdkygSEe70UgRnf
 +/KqUoA0v7LuwdO3zeSji/ddbWjEFGekDtXsE1U/gQyzWGwb+zrJ6VHZ9fGPoJtiH0c4
 L/CVP3noSoD1yL4ErhdC1nGQJ+Rx6fpPXTTfl23vvPD0td3QozVUkyIUGpbOEqLU+kxA
 FBAxdJT3QxigiuuJ4iP7upIXZNVLy4P0VeLLXcsUAGlrUS288LoLLGtirsGzbOcupYXa
 FsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T9pABhBqRIUppU9mjpLYQvQCGBBqVmX7zzhS7TrB79U=;
 fh=Zlf+LVUKoazQYvMqwmjEW55CvCKufc/Oxj69vta+J60=;
 b=b0mRrEfPYiuSuio5A/+6Si5c6K9Gn4B7FJLAekp+Tit/eNjDxphsvU2Y/1m2VzmMgb
 /0gBLvgLPypBPS3bLydqKfmzXBIbpFhR/sa7kLeRA86n+V+4F1pQktPsQ4RuP55CCJZg
 mvULbA4ldPYvSHfLcBPWrlAjE9QJvWSKTJOWumOVTZYfQALZIb6NRR4+9o3IIJ5Sdz3k
 V3Qy7RqGsXob99JxZU/lejT2tmXGdu/xt7lTkhO8Mb6oIyKYadkytGQ57Nyb1dL59Dng
 NvgybFfCTwh0H5lnBZE1LSX26I30hMwGTjkNOMLcjqS45SdZktbbfYEvP23ugaFaeItL
 NcLQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790168961; x=1790773761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T9pABhBqRIUppU9mjpLYQvQCGBBqVmX7zzhS7TrB79U=;
 b=hji+G/n9FgNLdYLE39cfxkeVXA+C8MOsNqsDn71SysBdALMem6gN3MeJu74wRFPNwf
 UGe6oqxtnrt2Hx/jLSAo6DVG8Oxhmt/ASQ8g+vmLYSBDwiOncj4Yu4BqT7bvvPw7X4wg
 ZYUGNbTRjgCirN0qzIjnAcynbpMsfZKOYKuMhGcV0Pp6rJRkGdX87Nf+SWA4wQhdkzON
 RhhXE0mh7crt7R8Kjtun4R8D/bH8u/EyFk+2BH1oFLIU9nlCUtTLXKI1p2ZRlYEhU9YX
 hd1Z+WWXfcCRr2yfdgNK7u1KdpUSefVsVM09Cgec2FoXIxIR2bfHI5jcAIoM3AOv4LnN
 mcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790168961; x=1790773761;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T9pABhBqRIUppU9mjpLYQvQCGBBqVmX7zzhS7TrB79U=;
 b=PQqX88F90T+MZmckxnAdMVSV+CR6rRSG6czsvJ522/rT0r9mB95sz6vHfgZqL7u6As
 hutwAH8M9+KOO7c3q2vDkBz2+us3rq7LySwVU6FG8rbdGuFOyvLsfgs/NrDV20ickuQG
 X4LDLcBIwo6o1GfLJPIJUrbN4y3m6Oo9lh8G6z/TUOXez7foGTKn3B5Aa4fXyYIOdPuv
 YeAgfKN3H3T3LqdBG9dTIv1qzJ6WtDNz2TYQTaP3eAMBRB8szcRCW14cUXVQDIXs82fJ
 ADJ5eOvbARZTSgvGkKGJB4xgxurkH7j1fCKfLGw8A0O3oOgnHBgPNdSC6urQCoJ38hv7
 b2Iw==
X-Gm-Message-State: AFuF++k5XSOjkv/URDGCG+RvVDnrYujEhCUr0kaAV9WmOCv5BESXsS68
 MexJubDVzQhfSKXqRBvkYZiIdzJEE1ZVYQY9f7S1vajUyFjaNQ6c/v3JF0rJ4eYHxLsQSdcTGup
 gnqAHBe5zUu9cs//d0LIZy2qa/W1+Uow=
X-Gm-Gg: AYBFou1/d0WATGvqtxTrEIRI4dSbjoe8qujr0UCJ2xfzzJfdD4kNO/psEhzECYFTcN6
 qK6CEE/ZaKRCRbxARUIDH8PnlIQ/Gstw7aGJSWxFb+lFecIa4sL61DGmu45fd4I1d1r8HTwzVc6
 2vF2CMolyOgloKOQ7iHuJ/azVoeTFVV7UFe8d79pqoqouyF1tqUtx4iBn5WQWGIMJsv5UtRUCIc
 kwn/SyfHhO7PsOCj2nLhpqr+zHVJDBAziieHdMQE4H81zyxZvJWPow4NxZGLfCehRVKN8bqqdlR
 1GSwf8hjy9XpfFi0Ggle7U0h3/BYJIPFNjPXE2bqk9Ctx/hlHhOGQvE0L+Rv5SKafI0WkxvlYCy
 n9keYMpDwtvpOh7LlFdzOIBvPGUsS+tcLBxglED1NqA==
X-Received: by 2002:a05:701b:2903:b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-144fd173b86mr2402327c88.0.1790168961379; Wed, 23 Sep 2026
 06:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260923095217.3932523-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260923095217.3932523-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Sep 2026 09:09:09 -0400
X-Gm-Features: AcwNN1W_eX_yVceLdHQM9s6aI9RXXsXedwKGiPbngp_vSoG_C36IYsIpW-KsYfI
Message-ID: <CADnq5_MqtGma8in8TuA64_FSWbz-F_Xy9D2rAOKe4rDa19t_Xg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: fix reading the WPTR at a non-zero BO
 offset
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Sunil.Khatri@amd.com
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

On Wed, Sep 23, 2026 at 5:52=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> The user queue UAPI permits the WPTR at any 8-byte aligned offset within =
a
> BO. amdgpu_userq_fence_read_wptr() locates the mapping containing the WPT=
R
> address, but amdgpu_bo_kmap() returns the start of the BO, so the code re=
ad
> the first u64 regardless of the WPTR offset. USERQ_SIGNAL uses this value=
 as
> the exported fence seqno, so a wrong read makes the fence signal early (o=
r
> never), breaking dependency synchronization.
>
> Translate the WPTR GPU address to a byte offset within the BO, accounting
> for the VA mapping start and the mapping's BO offset, before reading it.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index c270635c907b..b885e90ec5f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -372,7 +372,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu=
_device *adev,
>         struct amdgpu_bo_va_mapping *mapping;
>         struct amdgpu_bo *bo;
>         struct drm_exec exec;
> -       u64 addr, *ptr;
> +       u64 addr, offset, *ptr;
>         int ret;
>
>         addr =3D queue->userq_prop->wptr_gpu_addr;
> @@ -404,7 +404,10 @@ static int amdgpu_userq_fence_read_wptr(struct amdgp=
u_device *adev,
>                 goto lock_error;
>         }
>
> -       *wptr =3D le64_to_cpu(*ptr);
> +       /* The WPTR can be anywhere within the BO's VA mapping. */
> +       offset =3D addr - (mapping->start << AMDGPU_GPU_PAGE_SHIFT);
> +       offset +=3D mapping->offset;
> +       *wptr =3D le64_to_cpu(ptr[offset / sizeof(*ptr)]);
>
>         amdgpu_bo_kunmap(bo);
>         drm_exec_fini(&exec);
> --
> 2.49.0
>
