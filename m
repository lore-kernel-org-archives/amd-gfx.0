Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E67CEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 16:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE5C10E420;
	Thu,  6 Jul 2023 16:52:19 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A291E10E420
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 16:52:18 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-560b56b638eso574500eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688662337; x=1691254337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiUH+t/aD9kJa9u8lyhWk1r6QGv1B0HpbdGPJbsbBHU=;
 b=R4Le0g6ujq0al68MSsuQyxjI4MaGnyUqb3xfnN2MEmb7XC7ER0dp6dg/c1UPV28QeX
 QfFVH+Uvw2DT/29Sv/1fmOSU3LEJSBHxoPLoBcjWsNbmVvSX9G8WGevXWZ/qbXvO6v2z
 oDuMGUCkqfUFACP2ndsrPaoojKYmuY+61ZCFlZDwUuS772FGGJ4znfddwLKk1mhAG96f
 OwMcfPsOgfe3jChTCUxEV9TzY9PsySqV/op9H9ypMT/N0dojxdTz9qwg4mGplllz0w55
 a+WxiKQjx1qrwNTXSr88sG5/bBy9HQXFQr0SSiQP0F8QW2stkxKVzrYknFV4T0lT/N+J
 E3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662337; x=1691254337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiUH+t/aD9kJa9u8lyhWk1r6QGv1B0HpbdGPJbsbBHU=;
 b=fCAUDHIH++Oik8qQVzCQODLBb02xdkHZkiMeEkV1Z00cCx5yFO1h0ayGfuQu/sK0kR
 q2Zzx+Ge7Mcf1R1fDK0q11XW4hYEl5Q8zpb+iLZKdnwoybvFxX4GzCpIn2PV7edcMhIR
 p956bMtfYjGsu+DKOwvajEzV66XSmyq7WAUqbj+HSLXjHfSpywdB4Ubhat/H5W3Cd7m3
 VtWZ6uUMZREAC3G+bCYd+vY9eIuUBjpxv/3r/3SB5knJW2JCNn9IclOThWmrL06ah0Db
 WVJZIbzyX8fsJjRZe97Ha6F/c7+kNm2P4HTBXDXdrrriDvZ1qhMv6gphMGc/BdUV6O/d
 tYcA==
X-Gm-Message-State: ABy/qLbBoPWaGaX7NlIPdYgfJ0XgE+42C7SONT3fI62Bw6kKhl9ZVzSV
 pxB8ArxhFiX5r7Q07blS4gG2oacshlZcn3Lx6QIn6/J+
X-Google-Smtp-Source: APBJJlHNS6dRBR7EP4SFTfXezGNBsI+yY4qFx7PSRmYezKCI4TCqSXRvwXXkCq/YCRD4IMNZ9VL7rgJe2Qd6rJSD3Cw=
X-Received: by 2002:a05:6820:1ac4:b0:560:b9f0:b9fc with SMTP id
 bu4-20020a0568201ac400b00560b9f0b9fcmr3373624oob.0.1688662337440; Thu, 06 Jul
 2023 09:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-7-shashank.sharma@amd.com>
In-Reply-To: <20230706123602.2331-7-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 12:52:06 -0400
Message-ID: <CADnq5_PS6Q=OqBf1OzYXkKbO=3EiKoTCk++n7fRKv2BGEk7tYg@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] drm/amdgpu: map usermode queue into MES
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

On Thu, Jul 6, 2023 at 8:36=E2=80=AFAM Shashank Sharma <shashank.sharma@amd=
.com> wrote:
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
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 70 ++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 7d3b19e08bbb..b4a0f26a0e8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6491,6 +6491,65 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_=
block =3D
>         .funcs =3D &gfx_v11_0_ip_funcs,
>  };
>
> +static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +                                 struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_remove_queue_input queue_input;
> +       int r;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> +       queue_input.doorbell_offset =3D queue->doorbell_index;
> +       queue_input.gang_context_addr =3D queue->gang_ctx_gpu_addr;
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
> +       queue_input.gang_context_addr =3D queue->gang_ctx_gpu_addr;
> +       queue_input.process_context_addr =3D queue->proc_ctx_gpu_addr;
> +       queue_input.inprocess_gang_priority =3D AMDGPU_MES_PRIORITY_LEVEL=
_NORMAL;
> +       queue_input.gang_global_priority_level =3D AMDGPU_MES_PRIORITY_LE=
VEL_NORMAL;

Was there an option in the MQD to specify a priority?  What about
secure settings?  If not, we should validate those flags properly and
return an error if they are not currently supported.

> +
> +       queue_input.process_id =3D queue->vm->pasid;
> +       queue_input.queue_type =3D queue->queue_type;
> +       queue_input.mqd_addr =3D queue->mqd.gpu_addr;
> +       queue_input.wptr_addr =3D userq_props->wptr_gpu_addr;
> +       queue_input.queue_size =3D userq_props->queue_size >> 2;

Do we validate the size anywhere?

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
> @@ -6601,8 +6660,18 @@ static int gfx_v11_0_userq_mqd_create(struct amdgp=
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
> @@ -6613,6 +6682,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr=
 *uq_mgr, struct amdgpu_userm
>  {
>         struct amdgpu_userq_obj *mqd =3D &queue->mqd;
>
> +       gfx_v11_0_userq_unmap(uq_mgr, queue);
>         gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>         amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>  }
> --
> 2.40.1
>
