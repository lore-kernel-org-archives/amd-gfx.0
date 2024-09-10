Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D83ECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 14:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7F710E811;
	Tue, 10 Sep 2024 14:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c3ioCWCL";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11EC410E811
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 14:05:05 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-718e55bca81so248417b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725977104; x=1726581904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQZH51gMfDA10lakEKJrFbI2S52GnGyIzT0v3i0+lmQ=;
 b=c3ioCWCLjtFec/Iv6MOqM24n0AtIECXUX3JJTSr4gIULvtBoUgioz14Y+wc1m4wHJI
 ojwHToT2P6iqr4szpRCtSCbd1fCmyCL83AqpECTGZMVe29zL4s4krn6WS4ptZY0Xu3Re
 MbHv8xvnLCZwxj+kyxVtZWP8Tp2B0Ra/KpPlrgat+gmL5WziOuRpABxGsJwSQTswGUGN
 a1sP/rUDJWpBZY1jYe8FsS2WH+tVyaYObW3CkmO3FhH4zC+HNM1JbCu4D/+EzwPCfAQS
 2rVDQi/LaGl29EVRzi/jUSFifor2AyOyQN02qo1YH1hV+byIilc5lZClPAy/0Vcol/zH
 96mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977104; x=1726581904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQZH51gMfDA10lakEKJrFbI2S52GnGyIzT0v3i0+lmQ=;
 b=QXaduTyQL6c31fBtqD0Cnu4K95lJboXbPgs+4FT+uPaTojPWy7T7bBrwGPN0ISCV4U
 yoKIjuHgow+ABa+ZYUVnftOTixCKj2Y8xkcjFlEcJIyIDq+cPvIMI7ZWqIA07pdKQEmy
 JirZ3DSPjJ6g/ExQcXlIiFGzL7kfNuLb/F5kSwMc4IhHvGcO8oekTRSX55HGqdNVQh1/
 qxmrNGn6xNGb2Mt7WDws8fgFD+rRvQTAqJNKEZWURIdMsPDfH48fvz7/i+w3hiQABCIs
 gdJxs5CloJykfj+70VWyRZkjOIm1u4GA6kygvxeMeIwJyp4CxwyQOn9DwN5zHSAifANi
 2p8A==
X-Gm-Message-State: AOJu0Yz7sjWzSFFjicO2BxZ71HzzFJE0QYA6TAoxWRGogPBKYnE9LW5k
 68ns3fUAc7d7vrSLdjc73qPKUyxI72KHtatcYWJHO332sLVdtFxwa+UxwHEt/XtnrSuNTQD6uLu
 VdHKNOLV2mEaNiO0OJnam4eDKU9eXZA==
X-Google-Smtp-Source: AGHT+IEBS9HS7te17iAOYXIrZMePK5NA1of9XWpoMLZril0fYlcZX/TlHzVup7SP6b+R91kRvz/aryL0KRC8WUUgdhc=
X-Received: by 2002:a05:6a00:3cce:b0:717:8b4e:98ad with SMTP id
 d2e1a72fcca58-718d5c3657emr8073442b3a.0.1725977103769; Tue, 10 Sep 2024
 07:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240910033918.6035-1-jiadong.zhu@amd.com>
 <20240910033918.6035-3-jiadong.zhu@amd.com>
In-Reply-To: <20240910033918.6035-3-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Sep 2024 10:04:51 -0400
Message-ID: <CADnq5_P=w5c_O8SgdX40dFJ8uK+=_jSF_eO2Khi6DTfJofd1gQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu/sdma6: implement ring reset callback
 for sdma6
To: jiadong.zhu@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Mon, Sep 9, 2024 at 11:48=E2=80=AFPM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Implement sdma queue reset callback using mes_reset_queue_mmio.
>
> v2: check instance id before reset queue.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index b2efc678b7e9..581fa550ef29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1491,6 +1491,31 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu=
_ring *ring)
>         return r;
>  }
>
> +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int =
vmid)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       int i, r;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               if (ring =3D=3D &adev->sdma.instance[i].ring)
> +                       break;
> +       }
> +
> +       if (i =3D=3D adev->sdma.num_instances) {
> +               DRM_ERROR("sdma instance not found\n");
> +               return -EINVAL;
> +       }
> +
> +       r =3D amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
> +       if (r)
> +               return r;
> +
> +       return sdma_v6_0_gfx_resume_instance(adev, i, true);
> +}
> +
>  static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
>                                         struct amdgpu_irq_src *source,
>                                         unsigned type,
> @@ -1674,6 +1699,7 @@ static const struct amdgpu_ring_funcs sdma_v6_0_rin=
g_funcs =3D {
>         .emit_reg_write_reg_wait =3D sdma_v6_0_ring_emit_reg_write_reg_wa=
it,
>         .init_cond_exec =3D sdma_v6_0_ring_init_cond_exec,
>         .preempt_ib =3D sdma_v6_0_ring_preempt_ib,
> +       .reset =3D sdma_v6_0_reset_queue,
>  };
>
>  static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev)
> --
> 2.25.1
>
