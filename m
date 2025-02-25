Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291D2C021BC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 15:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A731A10E70B;
	Tue, 25 Feb 2025 15:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbWCjKin";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A9F10E70B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 15:09:56 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fc288da33eso1571694a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740496196; x=1741100996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iwXGTpMHlUZZBEImGZ7sBLi9DqwZqPwF3ZMTijSuf0=;
 b=jbWCjKinaq7URUsuhT08atDqQeDXTkcGXXp3pE9vqc9o3v/AWvSbJk1/IVaKobEVZC
 DaSj10GxGpSC4Rd3iz6E+GW1mKBxxfwbzGNAi6uNFwhuIxWRqPQ3sb+28lJ7bf6L5xod
 TC1hP5w9iKLXzl9GSCiOwuewb4IkP+6J51KQdUyCjEXz6MQoBvWeHQvNC4dWcTzLrJ7E
 NnwSrXfMolO+JThHroivWKoc/ojfbeZTSNrMISdTQYBHbhe0nJZHDPMm9jRdkYheyPCU
 QN0zGSg29ME8+mmjIL8vWUU2xux/qF9dEGVkzh3CjT5zodjLQ1G/SSJpbEnIefxM2wWH
 TjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740496196; x=1741100996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iwXGTpMHlUZZBEImGZ7sBLi9DqwZqPwF3ZMTijSuf0=;
 b=w6hLLg4DfSbdx2rruCQ6CJgpKrnpDGq41PGUdYjQgkxH434g2tMPkDA1HT9LZlluzd
 OdcJu+Go/hZK4Fq+CzQ0tfp5bwwFbH3GF3qkIZ9QFCYomSHyG0XNvutJTvu2OCOGGPYG
 UuNUCirXwY583lUTUBBZPE9nzL6RsoMbC5g+8dX019M4+SV4zUACRQaZZzHDqejBKih/
 hp+mv/ToyBQ07riDpYDuYn8POg225ljdJ/STb+2nVzXPTLCJoaVkBNarRlZ9cUVD2aDx
 oNIYJ8noOeXSNNoadYMdTER8vhILjTd2vvK8GQG0vEhdomu3Ok15ne1lKFz+48IBB2hl
 NzvA==
X-Gm-Message-State: AOJu0YwinV45qGN6Qt0MfBpKFjOcvayWesin/7QYiUG6oYIHDNs2JVac
 gsE8t+lVJLqSCwGlDj8DghQ8hK+3+Q29Yx4QN4c3C7hQae0/Pmuoh6pJOEN5w8PeCHNBWWfRfvO
 wNWsvfBxnuBUhVpF8Army2B+109v8dg==
X-Gm-Gg: ASbGncvyYPrKvQKaXu25Quo0Y0eWhrI4e7BffkCqo6oqHeT2UkU3nLZjRVJZzSBoPdC
 LSjXST4ml6B78UMF00FjTdEsavBPggWtWuTd52hsvji+Vm0IQ0kGIBdPTiJzlo9FHKv4JRb/WM6
 8dTwaG7T8=
X-Google-Smtp-Source: AGHT+IGKX7UXJ1OzgPXnSaQMBbjk+wdmlJEIfc7lODugJqVrrOpRlh2nBNh7yBu7Y1qIKPzOmkcaWZ33H+bcjJbnY5k=
X-Received: by 2002:a17:90b:4a07:b0:2f4:447b:f095 with SMTP id
 98e67ed59e1d1-2fce7b14cc8mr11123141a91.4.1740496196077; Tue, 25 Feb 2025
 07:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20250221145032.3440904-1-alexander.deucher@amd.com>
In-Reply-To: <20250221145032.3440904-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2025 10:09:44 -0500
X-Gm-Features: AWEUYZkycmJrjc70yrtipHQ0_QBqmNlexyxYkiHD-e-iIs30QJEyZMPkuWlloE8
Message-ID: <CADnq5_OnZWaCmNYQPAOGT_UVT0GyQxj8OwD07dr_giO8rSyB+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/userq: handle runtime pm
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Fri, Feb 21, 2025 at 9:51=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Take a reference when we create a queue and drop it
> when we destroy the queue.  We need to keep the device
> active while user queues are active.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 9a6a5553bbc3f..3a71d01b54c92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -26,6 +26,7 @@
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
>  #include "v11_structs.h"
> +#include <linux/pm_runtime.h>
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -287,6 +288,10 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>
>         queue->userq_prop =3D userq_props;
>
> +       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +       if (r)
> +               goto free_mqd;
> +
>         r =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, =
userq_props);
>         if (r) {
>                 DRM_ERROR("Failed to initialize MQD for userqueue\n");
> @@ -321,6 +326,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>
>  free_mqd:
>         amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> +       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>
>  free_props:
>         kfree(userq_props);
> @@ -330,14 +337,19 @@ static int mes_userq_mqd_create(struct amdgpu_userq=
_mgr *uq_mgr,
>
>  static void
>  mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
> -                           struct amdgpu_usermode_queue *queue)
> +                     struct amdgpu_usermode_queue *queue)
>  {
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +
>         if (queue->queue_active)
>                 mes_userq_unmap(uq_mgr, queue);
>
>         amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>         kfree(queue->userq_prop);
>         amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> +
> +       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  }
>
>  static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
> --
> 2.48.1
>
