Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B27C55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 14:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E567B10E66D;
	Mon,  3 Aug 2026 14:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VvCEKFG+";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F48010E66D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:59:59 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-84a32ff53fcso288106b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785765598; cv=none;
 d=google.com; s=arc-20260327;
 b=ggYfSMBP0WdK61F6pn//M9AYLNCm34yfWAoEkNIdjutacsS0es6UGZ77ASHvStMDqC
 bISmwW4usJny5hnj5AJEh3S/CPYcGzqMqhVQBLTKCZ0pidkoflbFo3uRUD9Ufg7cnpoE
 MtFh2w3yVbBiI/vLVx1+IKG2ETmM77ZkfHf9UOP9UPuH4EfNq+elT3ejkdfXUbR8PX76
 1RSf+oFkPPt6ARlnti4FCKtwGbSUEBCOVdj+1WU7y565JhXX9TDJdRKWB/YRVuKh4cyd
 BPKyOHKJNnU1X1sC5zHTpT7qcaSlWY2pJTHJDq9Fpk9bGfW6OsbxpHSmyU6xWtOcRDhI
 nzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/NcaeFQwLQ3IoKK3UiewV1tehK0mYSuHgA/av2aKAO0=;
 fh=AajwJS1JdmeCA/R2a2iHSEDl9rLQk6bWvk/8uoWqlmM=;
 b=mbkeRaCJ+uOaxQbucnVKDUC6/j7a3UkBgnq8cEPUxakTIr1LUz5z4slhpbqsnRplpy
 IGUGx3Yj8oOu0GecKBMO1/UE3fDNitmGSMpQqIOTvPppvrPZDEICX+WllUaOLGmdkhja
 h3VgZd06cz/5nYnQLkmFx5ps26OreSGL4Dkc9mkPrdu8mCWku8pGjPXyV9zQc37UxOMA
 RnP20FzdEnMbDKkthrtkQP8kOGUmGQot2B1cBeFtP/fKHu9Y7AlVV+01OXKxAGxXFofQ
 SI2NJcaU6/UJ75WbIpjbnbz7gxlJjAjRTP8xyNH+HH+wlGeT0Q3lnFsSGD0M/ViwDkBd
 wxxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785765598; x=1786370398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/NcaeFQwLQ3IoKK3UiewV1tehK0mYSuHgA/av2aKAO0=;
 b=VvCEKFG+3Q6ZzspyedIsXwjsaKGYcY4eAveBFkPqAiPF/b9gc5ylLMbvFrvT4T3LnQ
 UcPVErl+7NyhXeJ4Vyh60LFNuduLGQ8caDPlPwynpB1zETSr37MJwQQx0nTF+7AOpNZi
 /Z/5bTcFkPSB68CBT9a6frufG5C4BXqQLQoK8eELyDgLnsk+npOdOctb6RZeznvs+RtU
 Nb2Ffa4xGdF3NPkab7XuPsIdLaaAvdq8B39UzHJTlLc12abdkflCP5rAP+qyP+bXwB0l
 oWGJbLfwt+vygaIihytMMxrGt8QMcD7hzC2NNtaJro1BiRRO5AKl7/PspPasaqkOs4IE
 HlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785765598; x=1786370398;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/NcaeFQwLQ3IoKK3UiewV1tehK0mYSuHgA/av2aKAO0=;
 b=aTwKS5TJud1uLqJmjkFnTHvG7m9TmtO9fL08d0Pv4T1WdGxeX3jrBFMgwoSmnn7Cp1
 XlUCYUvpULTSSN5YztqLJR1SCscHZzdo9oMFOmBmGTPtzop/3CR811ANs3WZBufXGnUK
 ZaWe2/TcUE/RjKlSWfT/T1auVKxQGczBisooUubNlG3sOgcOsohA3iSCtvlJz5saXmdf
 +NDF1wCT+WvnuRLhprMijuFVOYsNQ2DAb3cHv3CmjG+rRgqTiwaD1+W/mpL23YhQx4bL
 jTt+bJy4vIlrDszd9fBhiQoTK2wyAPsbhz6dICacVTIQgi8FU85iJrqFj8+zAdbEOhhf
 jFow==
X-Gm-Message-State: AOJu0YxYUooDQKa49Lk6JOAWn/EImKhUt8+YI5bQVuV8s3tVn9ARTyqP
 JLVfZDrI6ELfUPOUA20ZX71ssbsnKb/sUubn6eY2qVnZGowpebLsNHITIWuH2fl1nmr/OZWnxCI
 pbjxiv7g7HP+V4qYb7HCig3qMRhUtqeGxEQ==
X-Gm-Gg: AR+sD12I2nnb8HpinP+0q0V6SIX9gs6EaAUwjbKh6BQdNCUukdB3ifXY3pELV28uL2a
 gHnmEOEvxATPsjv68mUe6gEFmDKdDVFDyMvQqbh4uCLZqAheryWH+mp+uPtRQLNsQd6psEsgee2
 1DtjziVpp5QoFkAd5ysBMapk+uAfnUmqb4fcrQztYuVlt764V1fW5WUuWq5uzjll6oEQQB0YGum
 /lsaj3k6K23LRRlE+vjSEi1dofHb6qXosxmWPmXMrtTX4KiDF8MPZxZ8Rgbs6FWgTGoYY/nw15d
 2PHS7ma/WNPt2jTtk9lpHNXM3YQqMbGW4fhRcFmQBHwN+0mXvZhxfOZdGZApeLgr9oHvYdjGJxm
 lGYXOq+gFruTZv58qtxQdPcSJ6Zqbx+A=
X-Received: by 2002:a17:90b:3cce:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-38fbc58f3a6mr12366061a91.3.1785765598566; Mon, 03 Aug 2026
 06:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260803102416.3776005-1-candice.li@amd.com>
In-Reply-To: <20260803102416.3776005-1-candice.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Aug 2026 09:59:46 -0400
X-Gm-Features: AUfX_mxQxoSMecsNdOSkziOYYo7p36lc06tZbt4y3VDU333h2zU2LaM4XzatxTk
Message-ID: <CADnq5_ONAK8PdFjTE85A6kCNTJ96bOiybMek_GgPKBL=yqHqVg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: reject oversized IBs with per-ring packet
 limits
To: Candice Li <candice.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Alexander Deucher <alexander.deucher@amd.com>
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

On Mon, Aug 3, 2026 at 6:33=E2=80=AFAM Candice Li <candice.li@amd.com> wrot=
e:
>
> On GFX rings, amdgpu_cs_p2_ib() passed user-supplied ib_bytes through
> to ib->length_dw without a limit, while ring_emit_ib() encodes length
> into packet fields. Oversized values can corrupt adjacent control bits
> and destabilize command submission.
>
> Add a per-ring IB packet size limit helper and reject command
> submissions exceeding the corresponding dword limit before IB
> allocation. Use the documented 20-bit limit for GFX/compute/SDMA/VPE,
> and apply the MM fallback limit for other ring types.
>
> Signed-off-by: Candice Li <candice.li@amd.com>

Would be good to also enforce the ib length mask in the packet
functions as well as a follow up patch series.  This patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 27 +++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index afc1c631d55aa6..617f53f135f353 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -42,6 +42,26 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_hmm.h"
>
> +/*
> + * Maximum IB length (dwords) for rings whose emit_ib packet format
> + * documents a 20-bit size field.
> + */
> +#define AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW  0xFFFFF
> +#define AMDGPU_MM_IB_PACKET_SIZE_MAX_DW        0x7FFFF0
> +
> +static u32 amdgpu_cs_ib_packet_size_max_dw(enum amdgpu_ring_type type)
> +{
> +       switch (type) {
> +       case AMDGPU_RING_TYPE_GFX:
> +       case AMDGPU_RING_TYPE_COMPUTE:
> +       case AMDGPU_RING_TYPE_SDMA:
> +       case AMDGPU_RING_TYPE_VPE:
> +               return AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW;
> +       default:
> +               return AMDGPU_MM_IB_PACKET_SIZE_MAX_DW;
> +       }
> +}
> +
>  static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
>                                  struct amdgpu_device *adev,
>                                  struct drm_file *filp,
> @@ -340,7 +360,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p=
,
>
>         job =3D p->jobs[r];
>         ring =3D amdgpu_job_ring(job);
> -       ib =3D &job->ibs[job->num_ibs++];
>
>         /* submissions to kernel queues are disabled */
>         if (ring->no_user_submission)
> @@ -369,6 +388,12 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *=
p,
>                         return -EINVAL;
>         }
>
> +       if (chunk_ib->ib_bytes / 4 >
> +           amdgpu_cs_ib_packet_size_max_dw(ring->funcs->type))
> +               return -EINVAL;
> +
> +       ib =3D &job->ibs[job->num_ibs++];
> +
>         if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
>                 job->preamble_status |=3D AMDGPU_PREAMBLE_IB_PRESENT;
>
> --
> 2.50.1
>
