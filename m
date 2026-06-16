Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03857CD98EE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 18:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959ED10EB1E;
	Tue, 16 Jun 2026 18:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F1Vt4HS5";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC16410EB27
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 18:48:30 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304f9bc869aso540874eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781635710; cv=none;
 d=google.com; s=arc-20240605;
 b=bD3REqZPkr7pN++OrpwkViQL1Zq6j2aQF0OLq7nwoRIh6C5yqWBOLGFdkf+VC0VKn4
 Q00d9YaKmxpGOChb8+nxFd/yillYMxKoBVOmP6CnMphPGEWc2tlZ2JworlYQWQ/+kxE5
 f9JBJ2Fvbz4sO9tOgMx5EpOHnp2ZWWCDF5FsLbaxQMdIzPJOEy3Y0BhW0BTkhX8uyODv
 kK3K6kbB4jiM+o7518VSa3AyN2yYNm4f1JoUQB02cJxHPXb04+TqO7li87qllnuK1q8L
 NcGeGnVryXyVoUpoPuA1eAAS4H/Uw44o34ykxidz1MPLb7iqjVKZU2QgrCQmW2MBcXUH
 tLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lJyakZk+4rBtsSsPqmavjlV9sufmp2nAyf+b53qnqLo=;
 fh=7yzT6K2nKUYDPXB1vsqv95xGzPCmGn5VMOMiP0a1Wtc=;
 b=ikOl9P9KRk1wmc3wY9VwjwjnQZvQO0vMwUBx3fZ62eWmaNDUELDnX1927iWy9zVD8g
 0aNkY5ZrDMHZgi2z6V6rdb7vNGN7u3AxOVxG2iGD2sNaCeEzqD/UwakNv5H09xDMxe+w
 aJdUIKq4I8pQPhrbKkSqbuXG8IH/QHhDZBLd/HRlci3n2pI3KeHx7Kf40Uro1lgctfUq
 XDsIGAugtc/guSCNjt99X9pdDtBbPHC7lSXKmr7pdQcFowXXLTpPzHel8epr+y64eLOJ
 Jwovdw7+LcKgjJTZ6ceN2MF/NWw7pECkGBd7uv0jfiU6e8Lvtig102fDAqp9sqqudwMc
 q13Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781635710; x=1782240510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJyakZk+4rBtsSsPqmavjlV9sufmp2nAyf+b53qnqLo=;
 b=F1Vt4HS5dbhwnU6E1RRjcvUGg2BMlfk0IPKrRj2OLDxhadEX7TuMoskiQ4CRgfglpB
 gk2fMym3+NMKkTrBcMZTigNOg8qzNisbX3TyhgiY6dk4uLasJhjv7exCJr8gSEGYC5q+
 eXmrubVqq4NC9A2d3wWdrTruZvxQR912MZZas70yG3njldw+OeDp6lR68768xDhnqotO
 N0r0ia2URLPyoiz+yftTGCOtaCqu0WjV8GD5yup2pzvL/tGvRFd34ZM4wHMMcCm/ZUup
 Xr0j4MOVcwA50dqcQlyrOh16KQ7waYztMvPsfCjufTKglm/gYNb1t4UpsMq/iukxQyrp
 TdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635710; x=1782240510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJyakZk+4rBtsSsPqmavjlV9sufmp2nAyf+b53qnqLo=;
 b=Pk4VW24r+89OdCDswyFyTGiIrMc4Vzg51r+L4H6LOikGH0ii4jMphNEo8vb/ZHlQrF
 R+Q9XQ0tnXOz27OiAgarkfP9NVX5QoNkpB+QeDW17Umew4GGAaV/eIw7Uh7I6rCLA4wR
 INbILPixx4ot8IIsf/PhZRm02rVRKT5B+TJFyqQunnvBO1H4TGcaMO2/u6yf0wmJwmBi
 EzvL53zVvIvSz4rY9s4/YIdLxbIPF7leZDeL/C7HYPZW5vbpve4buBtza2JnbdSliryt
 y6qdsqu1+HJkNr5v4YiWgg7O5G2mAu6cFVQZpOG6HxOOawF7Zi0gQPDKQ3qKvDF9n2gI
 m7Lg==
X-Gm-Message-State: AOJu0Yz/fSCL3RssSravdjyz/eVDQUey90dUE5L31ueLECl6qjjB8W7G
 lLHoOsw3+9BkpeUHHAc9d79VMOTHBe9Y36HMk6B4cisXynFwSLcHuiqlBjuJ8cXANjbn6YovNHl
 cuK0D0ckwxXeUVarWc/wMKaqqms+K4/ZmMg==
X-Gm-Gg: Acq92OErbHtraUGMfWH9n+VJ/AWs1XMpNl59San9sJl2PP4RB6Zzb9gn2z2UZ/dxm46
 m6+xhhuNbeDMa3gPozXn/qVhHivKAKzfLgOfVMa6OIftub4+LVL4sWorgRksOzYfo5up16WDAiB
 uWZWvyEbynsKLvjkEBokUh2gU2aBxW6hh9X/VbP90TUrnnjuvf8ZqKQG1qc3fiFpJ5nHnvVxo1j
 5+KoLbQ/safVXLTqKY4yg1neN5Lkg12aOANoJIyqvRPYDuqRLkUVaydnXXXpXOLWzWEPc6fVIl2
 Zsc89rVFCK25NnOBLBCCdA1a+rqSfOW8bo24RNQBtwIFdJyimnk8tM61Vd9HwSNwVw6LkA==
X-Received: by 2002:a05:7022:690:b0:135:1b09:db43 with SMTP id
 a92af1059eb24-1398f6dd968mr27695c88.6.1781635709924; Tue, 16 Jun 2026
 11:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260616020942.18980-1-tiagodourado@usp.br>
 <20260616020942.18980-3-tiagodourado@usp.br>
In-Reply-To: <20260616020942.18980-3-tiagodourado@usp.br>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 14:48:17 -0400
X-Gm-Features: AVVi8CeTNVHawe2kePEq7a7xErRZiFlzQLoQ4aX8UYN5FUOtpdCBQNMjtI814fA
Message-ID: <CADnq5_MTY1Sa_GgEDfO256mBzT4KQhTX9jj2_NfJCZEuZrrWHQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0
 process_interrupt
To: Tiago Dourado <tiagodourado@usp.br>
Cc: amd-gfx@lists.freedesktop.org, luiz.f.f.fernandes@usp.br
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

On Tue, Jun 16, 2026 at 8:59=E2=80=AFAM Tiago Dourado <tiagodourado@usp.br>=
 wrote:
>
> The jpeg_v5_3_0_process_interrupt function is identical to
> jpeg_v5_0_0_process_interrupt. Remove the duplicate implementation
> in jpeg_v5_3_0 and reuse the jpeg_v5_0_0 version via a macro alias.
> Export jpeg_v5_0_0_process_interrupt through jpeg_v5_0_0.h to allow
> cross-version reuse.
>
> Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
> Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 +++-------------------
>  3 files changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.c
> index 46bf15dce..4575d1f9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -625,7 +625,7 @@ static int jpeg_v5_0_0_set_interrupt_state(struct amd=
gpu_device *adev,
>         return 0;
>  }
>
> -static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
> +int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
>                                       struct amdgpu_irq_src *source,
>                                       struct amdgpu_iv_entry *entry)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.h
> index 5abb96159..4eeb0c147 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
> @@ -32,4 +32,8 @@
>
>  extern const struct amdgpu_ip_block_version jpeg_v5_0_0_ip_block;
>
> +int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
> +                                 struct amdgpu_irq_src *source,
> +                                 struct amdgpu_iv_entry *entry);
> +
>  #endif /* __JPEG_V5_0_0_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_3_0.c
> index 1821dced9..92aaf5dea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -32,8 +32,11 @@
>  #include "vcn/vcn_5_3_0_offset.h"
>  #include "vcn/vcn_5_3_0_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
> +#include "jpeg_v5_0_0.h"
>  #include "jpeg_v5_3_0.h"
>
> +#define jpeg_v5_3_0_process_interrupt jpeg_v5_0_0_process_interrupt

Same comment as patch 1.

Alex

> +
>  static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev);
>  static int jpeg_v5_3_0_set_powergating_state(struct amdgpu_ip_block *ip_=
block,
> @@ -608,25 +611,6 @@ static int jpeg_v5_3_0_set_interrupt_state(struct am=
dgpu_device *adev,
>         return 0;
>  }
>
> -static int jpeg_v5_3_0_process_interrupt(struct amdgpu_device *adev,
> -                                     struct amdgpu_irq_src *source,
> -                                     struct amdgpu_iv_entry *entry)
> -{
> -       DRM_DEBUG("IH: JPEG TRAP\n");
> -
> -       switch (entry->src_id) {
> -       case VCN_5_0__SRCID__JPEG_DECODE:
> -               amdgpu_fence_process(adev->jpeg.inst->ring_dec);
> -               break;
> -       default:
> -               DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
> -                         entry->src_id, entry->src_data[0]);
> -               break;
> -       }
> -
> -       return 0;
> -}
> -
>  static int jpeg_v5_3_0_ring_reset(struct amdgpu_ring *ring,
>                                   unsigned int vmid,
>                                   struct amdgpu_fence *timedout_fence)
> --
> 2.43.0
>
