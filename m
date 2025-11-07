Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C186CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 14:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC9610EAF5;
	Fri,  7 Nov 2025 14:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kLZL5M29";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E37E10EAEE
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 14:36:37 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-26808b24a00so1064595ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 06:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762526197; x=1763130997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTgD/08MSXXIpkna49lK1Mcyff2v6hLIZ+u4WEEEJfU=;
 b=kLZL5M29Eb0sCxq58CX4Fx5cyDuDib5uaZ8PCbUD/dOk+vmGfXwHo30Zj0MKrzcVtm
 9oxHkht5V6Jh3WcOoV0HrZ5uZMuNdKVIDSrWjeVgP+WSuGZ8rfbbNyLglGuh57QFFNAK
 UOBE1B8j6+G1nwwwQ47a4l692Vg27TIjqAv3uHOVBse2jd5NmXGqLysVU6oWTi8K97+M
 Jao47jY1A5qtyQtAjZTGzJbcvu7XwjqgaVTTCb1J/a6LsXqU806nx4Cgq6Ul8FUrjoGf
 sCRpewgImQHyt+tksy7H4tzuIi4Db8lUnNHRGKdBM8YVmqrMjspeU/duDXIW0sWAYCkB
 HV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762526197; x=1763130997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yTgD/08MSXXIpkna49lK1Mcyff2v6hLIZ+u4WEEEJfU=;
 b=twsVnewmqYKbaYfw+kAn9Zj9n7oyE0473JMDRHeQGuEnGNjmq50e64wBbAkLOck8Vz
 Ng/DEQYuwUPu5BPwvkz2xL60rK64GbJpEO0ljaGCSM+ZESULM9WHWaKf2hJGF244sYKv
 IOEL8o/ixTydQXS+/A7esD8QSRxv0mcsyqGCl3RP62UTcznA86wmiFE61azgrFrBu2Ug
 6VVRiRxp8GNILSKvvyl6ikyrWm0w7z5HiX7JQTvmiW5cE/NP5M1B/8HWaLDniMP/XUV2
 VSRhzwWwMwpFXpSM5i275OnODeyvPi3aUrKwr1CE13crpukQVbLkImPx4Zz9r5V/3lx2
 rUvg==
X-Gm-Message-State: AOJu0Ywq4mzZYVMSmraL65F+Nbi/ffTs8bxANVF1zGaavxGQx18JWwSC
 Irnkh9nmYFmr6UiA+1i7yk45ywAcKmJn+JChZ3F6BJ63niY79xTUP7l49mDaeD5KnDsTws5uimx
 zm0oPzLfrODj6CkW/fCUUzaeew4wY4wg=
X-Gm-Gg: ASbGnctXVV+r3QYSwP1AQwXCTXPZqT6vuC8UXMp5nNOT9LH8ddeOcPe/04yZ6kuDsRQ
 gDa6DU3zYZCy0kpWyxvio9GhstdXJsGhOeNlVfovNnvN+hO3DQQUv2tVs4pUI3Q56Tmnl9bK4Oq
 O++4TUy+NlZ5QBS2enDwUzfLApLVQBYxxRwKUTLTbIs6NTAWXOFtbNQzK/pVL4r0O3n6BHaCarm
 gZxmhucp/lJu7NcloaYHIvA/NQBYlcnlQKGe2ybdcjp/VZO9h04F5IQjdW1sJjttcpj4lI=
X-Google-Smtp-Source: AGHT+IE80KIXwiVGOEM7U85qzUbFLqFAtu+ex+xnZbbCgtHxvtIJsbjA8PstvtqfGm3WqX+a0lUgywr+xOakHb7AbiU=
X-Received: by 2002:a17:902:c40c:b0:290:af0d:9381 with SMTP id
 d9443c01a7336-297c048a8d2mr24980815ad.7.1762526196957; Fri, 07 Nov 2025
 06:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20251106202709.3242005-1-jonathan.kim@amd.com>
In-Reply-To: <20251106202709.3242005-1-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Nov 2025 09:36:24 -0500
X-Gm-Features: AWmQ_bnsmV9f01u4QIVRR6nNrTIuxLwpsjJF1C_aDu-zspYvwdUm25dzMGibcfY
Message-ID: <CADnq5_Oa-WSYpQOJfoHPqacoyPKiK+DrkAr78jkUvT=mB4iN=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: relax checks for over allocation of save area
To: Jonathan Kim <jonathan.kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 Lancelot.six@amd.com, Philip.Yang@amd.com
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

On Thu, Nov 6, 2025 at 3:46=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.com> =
wrote:
>
> Over allocation of save area is not fatal, only under allocation is.
> ROCm has various components that independently claim authority over save
> area size.
>
> Unless KFD decides to claim single authority, relax size checks with a
> warning on over allocation.

Do we want any sort of upper limit?

>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index a65c67cf56ff..448043bc2937 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -297,16 +297,21 @@ int kfd_queue_acquire_buffers(struct kfd_process_de=
vice *pdd, struct queue_prope
>                 goto out_err_unreserve;
>         }
>
> -       if (properties->ctx_save_restore_area_size !=3D topo_dev->node_pr=
ops.cwsr_size) {
> -               pr_debug("queue cwsr size 0x%x not equal to node cwsr siz=
e 0x%x\n",
> +       if (properties->ctx_save_restore_area_size < topo_dev->node_props=
.cwsr_size) {
> +               pr_debug("queue cwsr size 0x%x not sufficient for node cw=
sr size 0x%x\n",
>                         properties->ctx_save_restore_area_size,
>                         topo_dev->node_props.cwsr_size);
>                 err =3D -EINVAL;
>                 goto out_err_unreserve;
>         }
>
> -       total_cwsr_size =3D (topo_dev->node_props.cwsr_size + topo_dev->n=
ode_props.debug_memory_size)
> -                         * NUM_XCC(pdd->dev->xcc_mask);
> +       if (properties->ctx_save_restore_area_size > topo_dev->node_props=
.cwsr_size)
> +               pr_warn_ratelimited("queue cwsr size 0x%x exceeds recomme=
nded node cwsr size 0x%x\n",
> +                                   properties->ctx_save_restore_area_siz=
e,
> +                                   topo_dev->node_props.cwsr_size);

We can probably drop the warning here.

Alex

> +
> +       total_cwsr_size =3D (properties->ctx_save_restore_area_size +
> +                          topo_dev->node_props.debug_memory_size) * NUM_=
XCC(pdd->dev->xcc_mask);
>         total_cwsr_size =3D ALIGN(total_cwsr_size, PAGE_SIZE);
>
>         err =3D kfd_queue_buffer_get(vm, (void *)properties->ctx_save_res=
tore_area_address,
> @@ -352,8 +357,8 @@ int kfd_queue_release_buffers(struct kfd_process_devi=
ce *pdd, struct queue_prope
>         topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
>         if (!topo_dev)
>                 return -EINVAL;
> -       total_cwsr_size =3D (topo_dev->node_props.cwsr_size + topo_dev->n=
ode_props.debug_memory_size)
> -                         * NUM_XCC(pdd->dev->xcc_mask);
> +       total_cwsr_size =3D (properties->ctx_save_restore_area_size +
> +                          topo_dev->node_props.debug_memory_size) * NUM_=
XCC(pdd->dev->xcc_mask);
>         total_cwsr_size =3D ALIGN(total_cwsr_size, PAGE_SIZE);
>
>         kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_a=
ddress, total_cwsr_size);
> --
> 2.34.1
>
