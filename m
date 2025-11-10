Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B20FCCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 19:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2FD10E098;
	Mon, 10 Nov 2025 19:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OZXdbCkv";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1A910E098
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 19:22:18 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-297ea4c2933so1125565ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762802538; x=1763407338; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mFgP9hr/5aNOz5C3qoeaJaBdahAr5OuoMeEXN5CLSc=;
 b=OZXdbCkvYUSb32itQW4uTBU/yHpVtp+Ta7MEVNFHUv7V6Bt/7XwrHDAhHB06U6WlKk
 jRG/cxFoN02MYKgQbAt5IUnBqEHkBMRtTQIvLrOxVuPR6YAv5yfNKgBlNR3D6U375ZRp
 /tn2aAgW2tccbOusSpMVLMtep6QVDrxw4HkGPzgZ4dSM6Jo+xDQuRbftV9fRaSecyjCi
 d7CSIJbIgEwefEj7uuUqqWleGhc+lulNWLTnXgt2+6J/mBZHODeHGQzbI8mfC3JMBdAs
 CRPcscvWtBB5l8VmLacsFJnAjONXCD31SX5bfa4XZ7dPE2Fq+0E0+gVBy0W7vou7AFPN
 EYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762802538; x=1763407338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3mFgP9hr/5aNOz5C3qoeaJaBdahAr5OuoMeEXN5CLSc=;
 b=B4q+ppWqfrLKtVWfzhSjTirITYX1kxi4O1c8Og4Dzs3veu5hhF+iLLOHtkNbSFL3VG
 mZYA21GozIwAFJuNTeMje30WLlTFbyKpsZ1InQVV/Q+Xh71AR/JUWItaj1VQiyKSLqlb
 uZl/H2Hp8d8D7QeVCmkfuZ3RPzMq3U1WCpW+WG/U77wuLIjCpi7VIefaN9CEmmBfAEIo
 vzbjztbe0sRYJSNw21ktQlXQOrhXnn4RYeSPS5NBLoT4amwzDC08tC4b79RsefDwii7m
 Y5VNpcG2Pkkf9ciqGmKffH5BIAzAGi8b8ohQrmya3KLMMtkfJRUG0kbruXbhInXPBns/
 qG1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDB/TmVYcE0MJa4WVfd1TXgzx7+qd/cCkC49TgQJHC3BtmZRdSoHNnzHwg/7GDp6tIOqL1T2Kc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXmv+JeblvlyPffvhwbkk2OoAcnR+KlAEnJw4vBY9nV0MegOHw
 VsjIPjvB4dQdNzGz5CB5UzkTvVb9baQ8QOU+LfzySrX4wpwqzInMAiLPLjdvAOkojfG5l73ROsM
 kKqReW1s9UyFzCGoh4R3tqtDO447wL10=
X-Gm-Gg: ASbGncvkkEav0MxjAZVqCCUcTV7bWrsglD1dXD3K4ILdukRXlowENHha2Jg/z9hGlBh
 Y4BZL+xMCrf6qB8UrKAnMDPNfeSIn2X43vipg71M4ziUqrmwLV4eOEQYKQTy7JzU5lGEFXS2phL
 SFlVVepMKcDdpSZZOKWDRz2/PZlvxEXyW7X/WYj99aimn7o3dNOFVsiGO1fk9zWBUCaS0mQHxsl
 uOV6Aq1p84sNxHX4DgED/ydNMhZ9jzSfnNMt3LC0nF3biRmcG28+HJoSwKQj2V9i4VTqEs=
X-Google-Smtp-Source: AGHT+IGtkbP1zydmGkvt2fhybed6rXpI16mAKrpdxE/zca7jpryz0Rv7IZr/ppdOJVSrkv9hhxDsxkdn8QPSL2bqlDo=
X-Received: by 2002:a17:903:2343:b0:297:e67f:cd5 with SMTP id
 d9443c01a7336-29841056288mr2176165ad.7.1762802537730; Mon, 10 Nov 2025
 11:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20251106202709.3242005-1-jonathan.kim@amd.com>
 <CADnq5_Oa-WSYpQOJfoHPqacoyPKiK+DrkAr78jkUvT=mB4iN=Q@mail.gmail.com>
 <CY8PR12MB7435CB5408C5EA5E1C5EA37585C3A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <d679bc66-bdbd-4402-9230-85168b73e77b@amd.com>
In-Reply-To: <d679bc66-bdbd-4402-9230-85168b73e77b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Nov 2025 14:22:06 -0500
X-Gm-Features: AWmQ_blrzqyjjzSeQj5Zgv3Q441W1iG3wZYa1ACpBLkEH5AUr7_y1eGIZigILek
Message-ID: <CADnq5_N+6csBoJhg6JmqhzkuSwTr93h757oD4+PkDi-TCDnkTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: relax checks for over allocation of save area
To: Lancelot SIX <Lancelot.Six@amd.com>
Cc: "Kim, Jonathan" <Jonathan.Kim@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
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

On Fri, Nov 7, 2025 at 10:37=E2=80=AFAM Lancelot SIX <Lancelot.Six@amd.com>=
 wrote:
>
>
>
> On 07/11/2025 15:12, Kim, Jonathan wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Alex Deucher <alexdeucher@gmail.com>
> >> Sent: Friday, November 7, 2025 9:36 AM
> >> To: Kim, Jonathan <Jonathan.Kim@amd.com>
> >> Cc: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd=
.com>;
> >> Six, Lancelot <Lancelot.Six@amd.com>; Yang, Philip <Philip.Yang@amd.co=
m>
> >> Subject: Re: [PATCH] drm/amdkfd: relax checks for over allocation of s=
ave area
> >>
> >> Caution: This message originated from an External Source. Use proper c=
aution
> >> when opening attachments, clicking links, or responding.
> >>
> >>
> >> On Thu, Nov 6, 2025 at 3:46=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.=
com> wrote:
> >>>
> >>> Over allocation of save area is not fatal, only under allocation is.
> >>> ROCm has various components that independently claim authority over s=
ave
> >>> area size.
> >>>
> >>> Unless KFD decides to claim single authority, relax size checks with =
a
> >>> warning on over allocation.
> >>
> >> Do we want any sort of upper limit?
> >
> > Mmm.  I'd expect early failure on unreasonable user request for over al=
location at the allocation stage prior to acquire on queue create stage and=
 acquire should be bound to what was registered/allocated.
> > So I'm not sure what an upper bound acquire limit check could serve.
> >
>
> One thing to consider is that at the end of the CWSR area, there is
> space dedicated for the debugger (used to implement displaced-stepping
> buffers).  Initially, when KFD did not check the CWSR area size, it was
> just a userspace matter to increase that size if the debugger needed
> extensions.  With this new change, we can't extend this buffer without a
> KFD update.
>
> Having a "check that the buffer the thunk provided is big enough" policy
> would still allow us to extend this allocation if necessary.
>

Fair enough.  We can probably drop the warning as well in that case.

Alex

> Best,
> Lancelot.
>
> >>
> >>>
> >>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 17 +++++++++++------
> >>>   1 file changed, 11 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> >> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> >>> index a65c67cf56ff..448043bc2937 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> >>> @@ -297,16 +297,21 @@ int kfd_queue_acquire_buffers(struct
> >> kfd_process_device *pdd, struct queue_prope
> >>>                  goto out_err_unreserve;
> >>>          }
> >>>
> >>> -       if (properties->ctx_save_restore_area_size !=3D topo_dev-
> >>> node_props.cwsr_size) {
> >>> -               pr_debug("queue cwsr size 0x%x not equal to node cwsr=
 size 0x%x\n",
> >>> +       if (properties->ctx_save_restore_area_size < topo_dev-
> >>> node_props.cwsr_size) {
> >>> +               pr_debug("queue cwsr size 0x%x not sufficient for nod=
e cwsr size
> >> 0x%x\n",
> >>>                          properties->ctx_save_restore_area_size,
> >>>                          topo_dev->node_props.cwsr_size);
> >>>                  err =3D -EINVAL;
> >>>                  goto out_err_unreserve;
> >>>          }
> >>>
> >>> -       total_cwsr_size =3D (topo_dev->node_props.cwsr_size + topo_de=
v-
> >>> node_props.debug_memory_size)
> >>> -                         * NUM_XCC(pdd->dev->xcc_mask);
> >>> +       if (properties->ctx_save_restore_area_size > topo_dev-
> >>> node_props.cwsr_size)
> >>> +               pr_warn_ratelimited("queue cwsr size 0x%x exceeds rec=
ommended
> >> node cwsr size 0x%x\n",
> >>> +                                   properties->ctx_save_restore_area=
_size,
> >>> +                                   topo_dev->node_props.cwsr_size);
> >>
> >> We can probably drop the warning here.
> >
> > Acked.
> >
> > Thanks.
> >
> > Jon
> >
> >>
> >> Alex
> >>
> >>> +
> >>> +       total_cwsr_size =3D (properties->ctx_save_restore_area_size +
> >>> +                          topo_dev->node_props.debug_memory_size) * =
NUM_XCC(pdd-
> >>> dev->xcc_mask);
> >>>          total_cwsr_size =3D ALIGN(total_cwsr_size, PAGE_SIZE);
> >>>
> >>>          err =3D kfd_queue_buffer_get(vm, (void *)properties-
> >>> ctx_save_restore_area_address,
> >>> @@ -352,8 +357,8 @@ int kfd_queue_release_buffers(struct
> >> kfd_process_device *pdd, struct queue_prope
> >>>          topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
> >>>          if (!topo_dev)
> >>>                  return -EINVAL;
> >>> -       total_cwsr_size =3D (topo_dev->node_props.cwsr_size + topo_de=
v-
> >>> node_props.debug_memory_size)
> >>> -                         * NUM_XCC(pdd->dev->xcc_mask);
> >>> +       total_cwsr_size =3D (properties->ctx_save_restore_area_size +
> >>> +                          topo_dev->node_props.debug_memory_size) * =
NUM_XCC(pdd-
> >>> dev->xcc_mask);
> >>>          total_cwsr_size =3D ALIGN(total_cwsr_size, PAGE_SIZE);
> >>>
> >>>          kfd_queue_buffer_svm_put(pdd, properties-
> >>> ctx_save_restore_area_address, total_cwsr_size);
> >>> --
> >>> 2.34.1
> >>>
>
