Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E68C04A6B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 15:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4161D10E512;
	Wed, 20 Sep 2023 15:28:28 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6606F10E512
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 15:28:26 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1c504386374so4533024fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695223705; x=1695828505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JiLfTylAL1fUb+oaAk9F6vlJbRL5B6Ek5IXGoWsshE=;
 b=c7jMQmCL7MGrtmmeMMuMKZQ4t5h4+w1Rp6f1MsqpZ0K4VdCi/z6URTWlux3N/bpFTB
 N+ol+XQuivolHhU+rgFMTAH0lTATOeTL9QnN0W3YOJs0irwKDuW4v9h57BvUo/qsI7o/
 H5rG4rKFFsvWo1rzSPYAmYcTYcAEUGkWJpqfLqMK3CHH2rCS4WwcY1tU8nJ5WJ070cWE
 3nZPOVXeGSeWvG6Khmb0N7qfLXGY84Y5TnHAEwsHb9fBEgWg4bplc59IDY6Pi0h/9Nzl
 xaxov22A2WMRpatb8gq5tOJybCj6rOQscUPun01OHen0+kiKH+0kjZuPoL7iHShXeOt7
 slhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695223705; x=1695828505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JiLfTylAL1fUb+oaAk9F6vlJbRL5B6Ek5IXGoWsshE=;
 b=v3jYok4dwFofLkgRbB2aG4Mgc7Vt498tXKQt6/Q9DhWAiqH5LRMQtSZk0Il/KMnNpE
 Nm7HXfBlc3FIPeUe8BlWh7dixOGbMo75JGJGRTVF58TiELW6R0ZV22vJUkvh7z6j5Tun
 xg8HSyHYpG969+v8KvmWH+iXRZ2IA76hgKDLg0Nw/X6Zu/XQAThqa72oKmyUXuFeu15F
 n2tZzOP1wmOCJNbN6qOwES5cqfr2MYkRpuFf5gH02Z4XbZzGXbeRfrtLAD5QlZvFcN/7
 PcL3YLctUhzKKG9NwOsEwo0fj8VVDzqyD2DWzUPjAbuObZ7aVtIQ+zN4Xs+wI7Fqmw8D
 AT0Q==
X-Gm-Message-State: AOJu0Yz+pCEiXo4mn46OZB+M8m0WlfJkiGEshuju53AF2/xTxem8DAk1
 mS4qLW+6yibqnqdaIhLr/dB2fY6gbQeu5p0MoTA=
X-Google-Smtp-Source: AGHT+IEhvuc9c9a8sD3gE50xFHOe4N7L3Q+1EmoOZCKUq9SHIvPHW7ZBF7QPjBblSCinUPu/pIErmpplBLWuPRB2V9w=
X-Received: by 2002:a05:6870:c210:b0:1d6:617d:62eb with SMTP id
 z16-20020a056870c21000b001d6617d62ebmr3197042oae.39.1695223705563; Wed, 20
 Sep 2023 08:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-7-shashank.sharma@amd.com>
In-Reply-To: <20230908160446.2188-7-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Sep 2023 11:28:14 -0400
Message-ID: <CADnq5_OKT9NFHDgjjrxhW4h_KGKhabdKbciPh0BUvV6njQP9QA@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] drm/amdgpu: map usermode queue into MES
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 8, 2023 at 12:20=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> This patch adds new functions to map/unmap a usermode queue into
> the FW, using the MES ring. As soon as this mapping is done, the
> queue would  be considered ready to accept the workload.
>
> V1: Addressed review comments from Alex on the RFC patch series
>     - Map/Unmap should be IP specific.
> V2:
>     Addressed review comments from Christian:
>     - Fix the wptr_mc_addr calculation (moved into another patch)
>     Addressed review comments from Alex:
>     - Do not add fptrs for map/unmap
>
> V3: Integration with doorbell manager
> V4: Rebase
> V5: Use gfx_v11_0 for function names (Alex)
> V6: Removed queue->proc/gang/fw_ctx_address variables and doing the
>     address calculations locally to keep the queue structure GEN
>     independent (Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 72 ++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 8ffb5dee72a9..e266674e0d44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6427,6 +6427,67 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_=
block =3D
>         .funcs =3D &gfx_v11_0_ip_funcs,
>  };
>
> +static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +                                 struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_remove_queue_input queue_input;
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       int r;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> +       queue_input.doorbell_offset =3D queue->doorbell_index;
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r)
> +               DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
> +}
> +
> +static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
> +                              struct amdgpu_usermode_queue *queue,
> +                              struct amdgpu_mqd_prop *userq_props)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       struct mes_add_queue_input queue_input;
> +       int r;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> +
> +       queue_input.process_va_start =3D 0;
> +       queue_input.process_va_end =3D (adev->vm_manager.max_pfn - 1) << =
AMDGPU_GPU_PAGE_SHIFT;
> +       queue_input.process_quantum =3D 100000; /* 10ms */
> +       queue_input.gang_quantum =3D 10000; /* 1ms */
> +       queue_input.paging =3D false;
> +
> +       queue_input.process_context_addr =3D ctx->gpu_addr;
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +       queue_input.inprocess_gang_priority =3D AMDGPU_MES_PRIORITY_LEVEL=
_NORMAL;
> +       queue_input.gang_global_priority_level =3D AMDGPU_MES_PRIORITY_LE=
VEL_NORMAL;

I can't remember, did we have a plan for priority handling?
Compositors would want high priority queues for example.

Alex

> +
> +       queue_input.process_id =3D queue->vm->pasid;
> +       queue_input.queue_type =3D queue->queue_type;
> +       queue_input.mqd_addr =3D queue->mqd.gpu_addr;
> +       queue_input.wptr_addr =3D userq_props->wptr_gpu_addr;
> +       queue_input.queue_size =3D userq_props->queue_size >> 2;
> +       queue_input.doorbell_offset =3D userq_props->doorbell_index;
> +       queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queue->vm=
->root.bo);
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r) {
> +               DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
> +               return r;
> +       }
> +
> +       DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", use=
rq_props->doorbell_index);
> +       return 0;
> +}
> +
>  static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr *u=
q_mgr,
>                                               struct amdgpu_usermode_queu=
e *queue)
>  {
> @@ -6540,8 +6601,18 @@ static int gfx_v11_0_userq_mqd_create(struct amdgp=
u_userq_mgr *uq_mgr,
>                 goto free_mqd;
>         }
>
> +       /* Map userqueue into FW using MES */
> +       r =3D gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
> +       if (r) {
> +               DRM_ERROR("Failed to init MQD\n");
> +               goto free_ctx;
> +       }
> +
>         return 0;
>
> +free_ctx:
> +       gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
> +
>  free_mqd:
>         amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &que=
ue->mqd.cpu_ptr);
>         return r;
> @@ -6552,6 +6623,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr=
 *uq_mgr, struct amdgpu_userm
>  {
>         struct amdgpu_userq_obj *mqd =3D &queue->mqd;
>
> +       gfx_v11_0_userq_unmap(uq_mgr, queue);
>         gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>         amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>  }
> --
> 2.42.0
>
