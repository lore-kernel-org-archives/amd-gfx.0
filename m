Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E011C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 15:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85B110E261;
	Mon, 12 Aug 2024 15:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PC6adjDV";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD6C10E255
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 15:50:36 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so3220774a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723477835; x=1724082635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVIqOgbHaWtg/qYxjrURWlfqQRhRuImZaShvSa+VBC8=;
 b=PC6adjDV8hATJoJ+BGfUDxrgw5uwAy4DhpkyRiZwBkGW/i4GYSaeSinlsN2OMBuDMm
 8kHyBskkoY4Tiy4pwBEqazBzvGzYAkxal53bgc0lNlNVBWwDwS+U5Xm2HHEi+UVrXYVM
 JhOmkMCKUogxzwCSeoW76DTRm4onaHEGiYIU1M8jH1vfj2fs2THYw8QaP2spsMn4448k
 17IzoxxUGJ0WiIcEXsmB0a399NACr+6tBTlhj9rD3QHlgIwfUpND5iKh2w+IXnRbG5C1
 tjgJnJ3Pq3f5k9SEeIG4whxl8O5ci0Quek1hsi3NONsaAt4N3BiRpYisHBMDweVJCdE3
 x+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723477835; x=1724082635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVIqOgbHaWtg/qYxjrURWlfqQRhRuImZaShvSa+VBC8=;
 b=v2tiB2h8GsTP8/V1YlPQYfl2OJZHJbBjoI5VPz1spKGw93Ze/kwNisimGHFy+w2icN
 g5/GXgAmc4ENwSryx7r9YjQdjA5RQQvlDGJuw3ph54C1VjicA/xI9texPK+cpqCRGcht
 Pm8Uao2Tc7NqhSbGQoTaxGN2AhAT5dij9hBYKVCPzHKGCUg635FZ4cGaD34GgjeKkcjZ
 H7gbdAqE+6Wf7upn4g5O85+1V3Ol3B4doT90XFlNXvAE8tWoJA1Jz9l3iGbLuKcspc56
 VA3eRfOWbJsEF1UDpUtG5DRQRkPQmBV3BaRWHJOOrE7d5pPOwvJ8wXMVulZa+oYuOb8K
 8PJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVun8+oWEN/yfadygs5CEeVIx2eS+plhNYQPuZb1A5XSV7hBiI6JRJzncMV5g0w/GviGK51r2Ch@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+734RDY8NY6mE6QKzwwIV+ZcjMYG0On/+Da0430nx+Zv38vBd
 XA0dUEdufmAB3Rjg+DUewlwn7j04Th2rKnKtiayd6tfqlGe4ubKk97DQurI5hBbRmS0pgDBxHBl
 WLuEb5HUIuukJfOEu0A8Np5quhqQpCw==
X-Google-Smtp-Source: AGHT+IHD/eoH1Esf6fD4LeKQptx9D0urPsCeCJPq564HEQw80Ua2pCowjXGwDnWZtaLobxZUVaPnWgq+7kq6ynyUt14=
X-Received: by 2002:a17:90a:7d11:b0:2c9:9b65:af4d with SMTP id
 98e67ed59e1d1-2d3924e0312mr725918a91.7.1723477835432; Mon, 12 Aug 2024
 08:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240809124822.4063927-1-sunil.khatri@amd.com>
 <20240809124822.4063927-4-sunil.khatri@amd.com>
In-Reply-To: <20240809124822.4063927-4-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Aug 2024 11:50:23 -0400
Message-ID: <CADnq5_ONWggrBLr6wnw7=6kSHMz0SOUKWm0brarNHZvFt1PpGA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/amdgpu: add cp queue registers print for
 gfx9_4_3
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Aug 9, 2024 at 8:54=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> Add gfx9_4_3 print support of CP queue registers
> for all queues to be used by devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 42 +++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 5af4abca759d..7b4ae197eb49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -4362,8 +4362,9 @@ static void gfx_v9_4_3_ring_insert_nop(struct amdgp=
u_ring *ring, uint32_t num_no
>  static void gfx_v9_4_3_ip_print(void *handle, struct drm_printer *p)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -       uint32_t i;
> -       uint32_t xcc_id, xcc_offset, num_xcc;
> +       uint32_t i, j, k;
> +       uint32_t xcc_id, xcc_offset, inst_offset;
> +       uint32_t num_xcc, reg, num_inst;
>         uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_9_4_3);
>
>         if (!adev->gfx.ip_dump_core)
> @@ -4379,6 +4380,43 @@ static void gfx_v9_4_3_ip_print(void *handle, stru=
ct drm_printer *p)
>                                    gc_reg_list_9_4_3[i].reg_name,
>                                    adev->gfx.ip_dump_core[xcc_offset + i]=
);
>         }
> +
> +       /* print compute queue registers for all instances */
> +       if (!adev->gfx.ip_dump_compute_queues)
> +               return;
> +
> +       num_inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_m=
ec *
> +               adev->gfx.mec.num_queue_per_pipe;
> +
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_9_4_3);
> +       drm_printf(p, "\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: =
%d\n",
> +                  num_xcc,
> +                  adev->gfx.mec.num_mec,
> +                  adev->gfx.mec.num_pipe_per_mec,
> +                  adev->gfx.mec.num_queue_per_pipe);
> +
> +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> +               xcc_offset =3D xcc_id * reg_count * num_inst;
> +               inst_offset =3D 0;
> +               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec;=
 j++) {
> +                               for (k =3D 0; k < adev->gfx.mec.num_queue=
_per_pipe; k++) {
> +                                       drm_printf(p,
> +                                                  "\nxcc:%d mec:%d, pipe=
:%d, queue:%d\n",
> +                                                   xcc_id, i, j, k);
> +                                       for (reg =3D 0; reg < reg_count; =
reg++) {
> +                                               drm_printf(p,
> +                                                          "%-50s \t 0x%0=
8x\n",
> +                                                          gc_cp_reg_list=
_9_4_3[reg].reg_name,
> +                                                          adev->gfx.ip_d=
ump_compute_queues
> +                                                               [xcc_offs=
et + inst_offset +
> +                                                               reg]);
> +                                       }
> +                                       inst_offset +=3D reg_count;
> +                               }
> +                       }
> +               }
> +       }
>  }
>
>  static void gfx_v9_4_3_ip_dump(void *handle)
> --
> 2.34.1
>
