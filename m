Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF299C55160
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 13:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C78210E162;
	Thu, 30 Jul 2026 13:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hDa3lpCC";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F0610E162
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 13:20:55 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-ca132e9c54aso215344a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 06:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785417655; cv=none;
 d=google.com; s=arc-20260327;
 b=XlGE35FT5XFIi0oLi+/xivVwMC8MlzIOgLBWWQAtRGcklWhXbaF5ZLZ2LS8Tf8qsLR
 1N/BtZRd0iYAeqLEM3c7cN9Sh6sVmfoJ5vbnG+9+xeLNzzuQjpMgtUUG8LQmDQHtb3pU
 vok9MH1ycFSeD7g6TUw5Ps/KAW/ietkBXwXKSZXDsI9ODjNbE9UNDQZqRDS18yO1n2Qc
 Mx589aFnONMiWhgI3B/MnFJnFlO3IOwVCZZAxdJ7rdFdZU/btdDLraRFRnp/vAILCFu0
 aU9dGI0FlKDhj7kgw3UvjEiAGNN+1viZ8r+oBKm0xnT92jig50LXyZxhaiFdwWBjhYh0
 iE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HhvKEa8+6nWIt5N5ax2MBvzLq/3sd0/Q0PkMqSm8Z/o=;
 fh=AajwJS1JdmeCA/R2a2iHSEDl9rLQk6bWvk/8uoWqlmM=;
 b=f9iD7rOnNcGEF/cEUMlYHIMipg6CT5F1wAVbbLH9ZHQ3eElziNhkQkujVva/c+Q9yn
 purOLz19UO7L1F0kCGYwSYUoH1feDeFm4kbReDseFtnWvP/1ueEsRQJquLbuUx0uWp69
 lDRWQKteX0K6zqkMulpxYcERPTNnV7ExEHaueMZswOYpnjT3sr7ZSnd3a9lfD52Pqt9u
 jfrxuGH/4sng9i4lWmgDwSyo+sf0xjvGHMu0ixw7XDdPaxU89ga9C8MgFSCWqGnsXHe5
 Pu5EOl43hmT7Ghnswz6uTurkzepY9+doq0hQwZ/7v+0pK/6ET7T09uLOIbDs6F570fGw
 H8Dg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785417655; x=1786022455; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HhvKEa8+6nWIt5N5ax2MBvzLq/3sd0/Q0PkMqSm8Z/o=;
 b=hDa3lpCCuJgFzyGmARO6m6h/ojIVhoeAu8NFHqYN8ve2Z5TV896j84T0O1hIZdxqav
 nHxbKpIwLHKMEsNVAs0u3+7RChvQ+VKdJs4HM5nitOeKxQnOhFsw5tSk77ydCPoT+GFg
 SAsRBfZf2BlWkXS/1PBOU8VYGuVdXswYJm6aN4l4O4+Y7UOkctQXMr6ahd2dpmdAmsvm
 ukfbl8RECpo6MGnhFTWWYDoiCuxDe/MZHe0yTHWkBf8V5MhoGZ1Oif45AAXcEZ5CUCID
 AJx9NQmhE93JQ+vokvirHoQK8Cw+WX7MG/DGex1HHt0lIyjJGbxjPjP86Q4DW2McKILq
 +pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785417655; x=1786022455;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HhvKEa8+6nWIt5N5ax2MBvzLq/3sd0/Q0PkMqSm8Z/o=;
 b=fL+hJf30dTVgsF3s3V5fgAJPR7SJPzqnC97t5sJLMFIt5Em10FtDTarj8XG9ZBACK3
 6Zf0cu0i4ORY6f44D1esHD7Ce+bQlYhNPALEaPbSC/ta5LCjkRPW0mR6fGLUplDqmrvW
 XTDGxzS9JK6veLykfdwoIu/IzuI2GzT9eIVlMAtb8LLSqlhiqPPyysJeaamRQ/CNrY4C
 XfROI5WbijbMm2phHx3kOV0pFAP2tYXmE/437iUOtagGJJVFQCohJOQrwqnaNqEn8Zvi
 nwmFR7ySGW7Y2iyGfFoUh6opMMTgDCplApN48yFi63FkB/yiNNPOTgm0YoT3iwj27Fxo
 uzmQ==
X-Gm-Message-State: AOJu0Yxys8c6Xod/Ri08gk4SeIXs5J+t7FYB2fQ/kvei/5vok4I1a3oB
 o3EMINVZbb/LiqGF0SeiwA2nG5Y/eyIMyFzuAZna4TSg+7Pop96n7DU2HLSJCNp/Kjomjv0xwMu
 jec9JvB74nBU1fPU/bSTKs/QTV1oKZ28=
X-Gm-Gg: AR+sD10DqlRDTu/aKyOdPp4PlpfhuWDiiCjZEZhqyrimeeVraHDsTTRw+7iJhxM/dF9
 seJcBHICEVPdIpzckPEOSmJL4wecjdIA+MqSbX3A8sM4IYfOaIb2A5mb9eW9hBR+qy/C619L+FQ
 7NTRhFy2CJAy1I/HuvhqTf5lpQpla6RXKWll5d79yR20SETDQBDr6QxCq/W53zPVhMGPHglS/rK
 rOPOjFJkzk3rK1t596pGMq90AHkdMwcclLbXqVNJkTwydo7WtiQMn1QLLmhdkNoCyHWlYWJDIC5
 KV2x3IgB7yzDIvmlJZvbJWObkneS4ztOr0Cg4wrlz7iJmxglTxZ4WOaGAqML4EjqYAEQo7zna/K
 RLEcBno2rBPGJonSPUpS9wh1FpN1YwoUObBuNywGIrA==
X-Received: by 2002:a17:90b:5866:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-38fa80cad74mr25740a91.3.1785417655192; Thu, 30 Jul 2026
 06:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260730094011.3466352-1-candice.li@amd.com>
In-Reply-To: <20260730094011.3466352-1-candice.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Jul 2026 09:20:43 -0400
X-Gm-Features: AUfX_mz6UJXCPhIGOc7eMlQV7UaEptlRzY3-GKNuuZHKf6WRza4oBLh3PgoAelE
Message-ID: <CADnq5_N07acyyUs23y9EJser=xzOX4u=g4OVwH+fp882cm1wvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reject oversized IBs on rings with 20-bit
 size fields
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

On Thu, Jul 30, 2026 at 6:08=E2=80=AFAM Candice Li <candice.li@amd.com> wro=
te:
>
> PM4 INDIRECT_BUFFER control words encode IB size in 20 bits.  On GFX
> rings amdgpu_cs_p2_ib() passed user-supplied ib_bytes through to
> ib->length_dw without a limit, and ring_emit_ib() ORed length_dw
> directly into the control dword.

As a follow on patch, it would be good to mask the length_dw in the
gfx emit_ib() functions as well just to be safe.

>
> Reject IB submissions whose length exceeds the hardware maximum in
> amdgpu_cs_p2_ib(), but only for rings whose emit_ib packet format
> documents a 20-bit size field (GFX, compute and SDMA).
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index afc1c631d55aa6..0d06b6d166c576 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -42,6 +42,25 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_hmm.h"
>
> +/*
> + * Maximum IB length (dwords) for rings whose emit_ib packet format
> + * documents a 20-bit size field, e.g. GFX PM4 INDIRECT_BUFFER ([19:0])
> + * and SDMA indirect packets.
> + */
> +#define AMDGPU_IB_PACKET_SIZE_MAX_DW   0xFFFFF

#define AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW   0xFFFFF
#define AMDGPU_MM_IB_PACKET_SIZE_MAX_DW   0x7FFFF0

> +
> +static bool amdgpu_cs_ib_has_packet_length_limit(enum amdgpu_ring_type t=
ype)
> +{

I would make this function return the max IB size is DWs.

> +       switch (type) {
> +       case AMDGPU_RING_TYPE_GFX:
> +       case AMDGPU_RING_TYPE_COMPUTE:
> +       case AMDGPU_RING_TYPE_SDMA:

I suspect VPE also should be covered by this case since it's based on SDMA.

return AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW here.

> +               return true;
> +       default:

and

return AMDGPU_MM_IB_PACKET_SIZE_MAX_DW here.

> +               return false;
> +       }
> +}
> +
>  static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
>                                  struct amdgpu_device *adev,
>                                  struct drm_file *filp,
> @@ -340,7 +359,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p=
,
>
>         job =3D p->jobs[r];
>         ring =3D amdgpu_job_ring(job);
> -       ib =3D &job->ibs[job->num_ibs++];
>
>         /* submissions to kernel queues are disabled */
>         if (ring->no_user_submission)
> @@ -369,6 +387,12 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *=
p,
>                         return -EINVAL;
>         }
>
> +       if (amdgpu_cs_ib_has_packet_length_limit(ring->funcs->type) &&
> +           chunk_ib->ib_bytes / 4 > AMDGPU_IB_PACKET_SIZE_MAX_DW)

Then check the max size returned by the above function here.

Alex

> +               return -EINVAL;
> +
> +       ib =3D &job->ibs[job->num_ibs++];
> +
>         if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
>                 job->preamble_status |=3D AMDGPU_PREAMBLE_IB_PRESENT;
>
> --
> 2.25.1
>
