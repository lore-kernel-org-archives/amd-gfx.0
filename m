Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C747CA0EEB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 20:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F191C10E13E;
	Fri, 22 Aug 2025 20:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NfZ0fuMK";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C361710E13E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 20:50:01 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b4741e1cde5so350441a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755895801; x=1756500601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPUvpN6c2O95TJZIqAZj870OiRfT7nV17BzOY3qLepo=;
 b=NfZ0fuMKJwTkPHMDLIvHDuJFDIlnXpnLeapUUqcbjhIovZaEJOH4UWQKnTJDukhZkU
 r8dOr8N637HqIDNwjoCd0nKLFHs4/iPyesZ9AYX5uQb6N8fCNi+8OYpBeuS/sf4m9HNE
 fV7SW8lGMBsvYxvZ1og6hSQ1tSH7KsTocL/OrfSfzv7iYwVGiMI9groZud9XqrWjQjan
 l6mzuwdDTtJlltTPX/oPKxiw4AzB9E55YwBVTJGVqSRHKF0OsfpOXi3DO8t1Yao6D3BB
 TwzpCBgW7d8ICqilgJs/5szosW2KYxq213k7WoB1qlL0CgJ3wwU7U8WdVlbgbRnNDA3f
 frgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755895801; x=1756500601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPUvpN6c2O95TJZIqAZj870OiRfT7nV17BzOY3qLepo=;
 b=OFMCwZ/oAjFiut+4jAJQd0zrz/FRCp1qRGIqzi6gOp05ycYmJZ36dsVM5cn/OwkUyM
 cy7sdxO08Je78f81+DwWFEJ+GfGRtMZfWyHVeyL/oVt05BwRQ9lbpppRY8Zi0byiL6P4
 sfmX8y82PMOFVKYg/GNhZYQb07CNZw8hvszpjW3u/H0Y9/lqmiveJxQv0pqQYyQT16Dp
 kOsmkktbjwVeupdafgdLXq35GnzCZXHlBH03WwV0c1mtoTTR6wC/dwKMVg/OG9XOnls8
 gtaF0mMfoNqszfKtE96PDTFsPw2LgWPpIPnY+khvjkYXDCcOT0QIIM9ed4wtN9O6ChiQ
 JNYg==
X-Gm-Message-State: AOJu0YyfAXvpazjR7jrasiJI2qkjI5OIudX0CaS9WNA0/NkVfWk6wqCl
 Zx5OhkaNRqydw9/Xrxh/nzgZ6Utcc92W+AWb56cejYjTurOWI2n5EFkQK3jKuC8NBwlxvbN7AZl
 XvhG2pYOIkvBt6dcGio2rWkgQE8RIWwp3Z5a6
X-Gm-Gg: ASbGnctdErVEM2pLHZ/0uv2FDk7VImi5cCxOhv2Sp88JZ6fi75rKImO9fpnkyOr2YKS
 PU/+IytwUm0Rdkj/Mzl66LBz/bWnV0lhN4Y0F84JRjQbGaBO4B1uCCe4DKxl8/KCAoyOFKAVV88
 t4dcc+lYw5lb0PyZazSkzNlKMWI3t+baz5w/IPA1F+2RgCt7u6yEjPZC9Y4y498wE7/TwjM2FTK
 Epddfc=
X-Google-Smtp-Source: AGHT+IEXwiMdRR3bu24yj39UsU3m7QDXsgJuRsvQKhaA3XWSGjM7vkx0I87CVS4w2615xQL5M4MhF+1Wfm4rDa5uBJ4=
X-Received: by 2002:a17:902:d48b:b0:246:5253:6dfc with SMTP id
 d9443c01a7336-24652537015mr16987905ad.7.1755895801084; Fri, 22 Aug 2025
 13:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
 <20250822085434.970798-2-Jesse.Zhang@amd.com>
In-Reply-To: <20250822085434.970798-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Aug 2025 16:49:49 -0400
X-Gm-Features: Ac12FXxeyje-zBSIu7yVn3jNzIAj-EBcZF-bzUH1vgKxwfynV-tafVhP4WuMYbI
Message-ID: <CADnq5_P-oGF3gh1XpCvKWhOFL7bHU3zaOpJgTh7K4yt44bRGqg@mail.gmail.com>
Subject: Re: [v10 02/11] drm/amdgpu: adjust MES API used for suspend and resume
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Fri, Aug 22, 2025 at 6:13=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Use the suspend and resume API rather than remove queue
> and add queue API.  The former just preempts the queue
> while the latter remove it from the scheduler completely.
> There is no need to do that, we only need preemption
> in this case.
>
> V2: replace queue_active with queue state
> v3: set the suspend_fence_addr
> v4: allocate another per queue buffer for the suspend fence, and  set the=
 sequence number.
>     also wait for the suspend fence. (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 96 ++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 5111d7dce86f..d58cf48b456b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -65,6 +65,8 @@ struct amdgpu_usermode_queue {
>         struct dma_fence        *last_fence;
>         u32                     xcp_id;
>         int                     priority;
> +       struct amdgpu_userq_obj suspend_fence;
> +       uint64_t suspend_fence_seq;
>  };
>
>  struct amdgpu_userq_funcs {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index d6f50b13e2ba..ce5ac8c2f7e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -28,6 +28,8 @@
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_SUSPEND_FENCE_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_FENCE_TIMEOUT (1000000000)
>
>  static int
>  mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
> @@ -347,9 +349,103 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_m=
gr,
>         amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }
>
> +static int mes_userq_wait_fence(struct amdgpu_userq_mgr *uq_mgr,
> +                               struct amdgpu_userq_obj *fence_obj,
> +                               uint64_t fence_value,
> +                               uint64_t timeout)
> +{
> +       /* This would typically involve polling the fence value in memory
> +        * until it matches the expected value or timeout occurs
> +        */
> +       uint64_t start_time =3D ktime_get_ns();
> +       uint64_t *fence_addr =3D fence_obj->cpu_ptr;
> +
> +       while (*fence_addr !=3D fence_value) {
> +               if (ktime_get_ns() - start_time > timeout) {
> +                       return -ETIMEDOUT;
> +               }
> +               udelay(10);
> +       }
> +       return 0;
> +}

This can be simplified:

signed long amdgpu_userq_fence_wait_polling(uint64_t *fence_addr,
                                      uint64_t wait_seq,
                                  signed long timeout)
{

        while ((int64_t)(wait_seq - *fence_addr) > 0 && timeout > 0) {
                udelay(2);
                timeout -=3D 2;
        }
        return timeout > 0 ? timeout : 0;
}


> +
> +static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
> +                            struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_suspend_gang_input queue_input;
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       int r;
> +
> +       if (queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +               return 0;
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)
> +               return 0;
> +
> +       /* Allocate suspend fence buffer if not already allocated */
> +       if (!queue->suspend_fence.obj) {
> +               r =3D amdgpu_userq_create_object(uq_mgr, &queue->suspend_=
fence, AMDGPU_USERQ_SUSPEND_FENCE_SZ);
> +               if (r) {
> +                       DRM_ERROR("Failed to allocate suspend fence buffe=
r\n");
> +                       return r;
> +               }
> +               queue->suspend_fence_seq =3D 0;
> +       }

We only need a little bit of memory.  It's probably more efficient to
just grab a wb slot.  Also this current code leaks memory because we
never free this.

Something like:

u32 fence_offset;
u64 *fence_ptr;

r =3D amdgpu_device_wb_get(adev, &fence_offset);
if (r)
        return r;

fence_gpu_addr =3D adev->wb.gpu_addr + (fence_offset * 4);
fence_ptr =3D (u64 *)&adev->wb.wb[fence_offset];
*fence_ptr =3D 0;

then later when you are done with it at the end of the function:

amdgpu_device_wb_free(adev, fence_offset);

> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +       queue_input.suspend_fence_addr =3D queue->suspend_fence.gpu_addr;
> +       queue_input.suspend_fence_value =3D ++queue->suspend_fence_seq;

queue_input.suspend_fence_addr =3D fence_gpu_addr;
queue_input.suspend_fence_value =3D 1;

Alex

> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +
> +       if (r) {
> +               DRM_ERROR("Failed to suspend gang: %d\n", r);
> +               return r;
> +       }
> +
> +       /* Wait for suspend fence to be signaled */
> +       r =3D mes_userq_wait_fence(uq_mgr, &queue->suspend_fence,
> +                               queue_input.suspend_fence_value,
> +                               AMDGPU_USERQ_FENCE_TIMEOUT);
> +       if (r) {
> +               DRM_ERROR("Suspend fence timeout\n");
> +               return r;
> +       }
> +
> +       return 0;
> +}
> +
> +static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
> +                           struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_resume_gang_input queue_input;
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       int r;
> +
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG)
> +               return -EINVAL;
> +       if (queue->state !=3D AMDGPU_USERQ_STATE_PREEMPTED)
> +               return 0;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r)
> +               dev_err(adev->dev, "Failed to resume queue, err (%d)\n", =
r);
> +       return r;
> + }
> +
>  const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>         .mqd_create =3D mes_userq_mqd_create,
>         .mqd_destroy =3D mes_userq_mqd_destroy,
>         .unmap =3D mes_userq_unmap,
>         .map =3D mes_userq_map,
> +       .preempt =3D mes_userq_preempt,
> +       .restore =3D mes_userq_restore,
>  };
> --
> 2.49.0
>
