Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FC8C02198
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 01:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA7C10E039;
	Thu, 13 Feb 2025 01:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="inYD2eNo";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E0C10E025
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 01:07:05 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-220d27d490dso752805ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 17:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739408824; x=1740013624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNguM1uw1pOUbb1Csab8PP0NJ/i5ZHGBvtUh/sO5/GY=;
 b=inYD2eNov0fTpSGIXo7VIvcc1KDNKOLEQv4uW6fDNVYbEkEfKgnWMtGcNs6R9HSpnW
 VmkFZ0VWB1UgdZ9WKLGwLRPOUVDKAl8ugBHufz1ZzeBziRscg9Rw11AWDn6KTGV+CRJZ
 X3FDJX6zxjtpE02BDh2JPmFHPbcOJsLRpet5W4be9FvEEdw560GKXw1q13OlalOc9q5f
 EUnwyflObD4/sWhZ56Ne49lfJJWyPzD8RCihT28bOLvGrsiNZdFpj1ZW+TuMQCB/7IwW
 AcApiq6qQhFXDMWzu9pJ/yX7M0TogofRFJUB/sTmJEiqTETnSr619OCktUffXM5c9sEK
 3L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739408824; x=1740013624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNguM1uw1pOUbb1Csab8PP0NJ/i5ZHGBvtUh/sO5/GY=;
 b=mO2TS4Ie/V1qhm2IKloYZWeWfjHat2aHmMRfN1E9T5ZpfeNDPWh/AwTinjXZyiJjON
 V/Smfj7Yd+4QyyNokY1MMDS7Fg2KVkGL7485485IjJJnDYFsmrVoR+QPFp3wm4sCV/ip
 t0fNvB3pY7jtu1SreDLhXtZ2ATN/3SlWUtPH+f4fUSMp3/rtS9BCMMQjvZ352ss85ScA
 aweY3q+dRXCIuE5Q9B1tjuGQWoAI2w+VeDxE9Rvmf8VmZZBOapLOuaizx/YjOTCDNtvk
 pdE+bThtzoplRMAXF7s18+vPDorbT72ta/XClAhIL1xf2HXJdEc0floADBTgP6qe3ish
 CWWQ==
X-Gm-Message-State: AOJu0Yy6EwiDIBFGPk3RCS5dXwzlhGAR91ieZhDQene8SKhZ2MkuvrFk
 /286qnXeRMPnefFNR+kGE1egD7WUte/ltmtb6uuj+HeTzZRCuzMdVC2ecgyE7hhWAQL+qV643IE
 Yjd6tsKFKuD7/38DMb7JnRC93/HgnnA==
X-Gm-Gg: ASbGncsV3uIt1AaPMkuDjUyj4ivfJI5t1FeObpbImPR9RK+ZQqeWALkuqi3omlUdoyA
 G95oWNkqze/YHFg1zozuDDPxLdXBXfY36dxm0KDhY9J2+HTHPuqR3gWiHVjJDezOx495sgrIh
X-Google-Smtp-Source: AGHT+IGIbfCinTe82eLo/I6533C3F9NwsDITVq2Ugff0ybygtQXJ3f9vQ3HbvSoRsVXhHJNDwFNHqQx5r2zAjPJfbao=
X-Received: by 2002:a17:903:2094:b0:220:c813:dfca with SMTP id
 d9443c01a7336-220c813e53dmr17898205ad.1.1739408824470; Wed, 12 Feb 2025
 17:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20250130000412.29812-1-Philip.Yang@amd.com>
In-Reply-To: <20250130000412.29812-1-Philip.Yang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2025 20:06:52 -0500
X-Gm-Features: AWEUYZmq2I0RKFbaZOvBBTyJtqqRbaKEgJP622vy6AmFGjTOzThz5FgpXxkgPfo
Message-ID: <CADnq5_NeXZx5N5_VAQ5YZpVB+KBiM_jJfvTn-CtZLrWUA-ZDwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix user queue validation on Gfx7/8
To: Philip Yang <Philip.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 alexander.deucher@amd.com, trnka@scm.com
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

On Wed, Jan 29, 2025 at 7:12=E2=80=AFPM Philip Yang <Philip.Yang@amd.com> w=
rote:
>
> To workaround queue full h/w issue on Gfx7/8, when application create
> AQL queues, the ring buffer bo allocate size is queue_size/2 and
> mapped to GPU twice using 2 attachments with same ring_bo backing
> memory.
>
> For this case, user queue buffer validation should use queue_size/2 to
> verify ring_bo allocation and mapping size.
>
> Fixes: 68e599db7a54 ("drm/amdkfd: Validate user queue buffers")
> Suggested-by: Tom=C3=A1=C5=A1 Trnka <trnka@scm.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index ecccd7adbab4..62c635e9d1aa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -233,6 +233,7 @@ void kfd_queue_buffer_put(struct amdgpu_bo **bo)
>  int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct que=
ue_properties *properties)
>  {
>         struct kfd_topology_device *topo_dev;
> +       u64 expected_queue_size;
>         struct amdgpu_vm *vm;
>         u32 total_cwsr_size;
>         int err;
> @@ -241,6 +242,15 @@ int kfd_queue_acquire_buffers(struct kfd_process_dev=
ice *pdd, struct queue_prope
>         if (!topo_dev)
>                 return -EINVAL;
>
> +       /* AQL queues on GFX7 and GFX8 appear twice their actual size */
> +       if (properties->type =3D=3D KFD_QUEUE_TYPE_COMPUTE &&
> +           properties->format =3D=3D KFD_QUEUE_FORMAT_AQL &&
> +           topo_dev->node_props.gfx_target_version >=3D 70000 &&
> +           topo_dev->node_props.gfx_target_version < 90000)
> +               expected_queue_size =3D properties->queue_size / 2;
> +       else
> +               expected_queue_size =3D properties->queue_size;
> +
>         vm =3D drm_priv_to_vm(pdd->drm_priv);
>         err =3D amdgpu_bo_reserve(vm->root.bo, false);
>         if (err)
> @@ -255,7 +265,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_devi=
ce *pdd, struct queue_prope
>                 goto out_err_unreserve;
>
>         err =3D kfd_queue_buffer_get(vm, (void *)properties->queue_addres=
s,
> -                                  &properties->ring_bo, properties->queu=
e_size);
> +                                  &properties->ring_bo, expected_queue_s=
ize);
>         if (err)
>                 goto out_err_unreserve;
>
> --
> 2.47.1
>
