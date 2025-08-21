Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63095CA0EEB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 15:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD3C10E9B8;
	Thu, 21 Aug 2025 15:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nnhQbwXv";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197F510E9C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 15:05:21 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-24458051ac6so1556065ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755788720; x=1756393520; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHDp99j+GSN7Nm9auGt5WxtSiR+JPwmEjwsaCDDdAyo=;
 b=nnhQbwXvo4f8a6mDvB4kuWd6sBHHRiRPRGD/+AXgE3Hqr7mG1shbX7zw5TiKk9Dhuq
 7j0AT1m+vy7zRo5t6HrjGdJkvOkO0UvAy5nA83lHDKBSIEWD3B3OuILtDWeVMjeD3dLk
 xtG1jcLjqJZIdHxdpq5vdAbc1KMKEGejWkRpeVlc22Ku36iRRbrb66gst4GogUleAlGv
 IH329f1QWANHSNd76iJH91p37YdyIpZeICEzOGQA90xUiEjx95SOKzHKvcgebR3LYJ/D
 6BZNr8hBVri6fMlEWykZGeKC/1Qxsw1QyII3RFsuEkpFRlvrMusojppIAEOElfAXcYZ4
 U/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755788720; x=1756393520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHDp99j+GSN7Nm9auGt5WxtSiR+JPwmEjwsaCDDdAyo=;
 b=hAAeghzJ3AEkUXQS0ndFKA4ddFKjohI1EEiy4e27rQCMSAYV15hQo6shG6acSIUop7
 fJL07zGppHKiLC75aoZEyDSSAk3YLgX8Q3V0MBTdUz3ZyFdGHtOQpPNNPlfAclxntpgh
 6RZW5SeeUgJ0FFRtP+KrE6JNU1ssALzXZstZ3LrJEk628AKeairoSIkGWAjVXkMnmiq8
 I2pb3YvAFpJS5Jo1Dc+i6DLHmjO8oWPmIv52uFn4C2tZrVs5MiW2ajve6tRYhEbwxj+8
 OG1LpXtE6Pae8joOP2pVyAxqTCBxF3MgOHvFCyRbSj5KPaoMR9Gn7FCEsVI6b2YkfBD4
 dNEg==
X-Gm-Message-State: AOJu0Yz0MdSP3k4iA0HesxrXENLuyVX7NXAzUbOp8qxbXiXnNFtMa4P0
 WRViw1+m2CY7zGDBz8Cu4WqhlL5bOafFQLUOPQNoC8+FcWLGKv9ncOkCBnFsj3Je33sWLGRmH7n
 oTOmc+vlSUbDHfK6acga2EUcaImhmb2DlTkN0
X-Gm-Gg: ASbGncvknsJXuR5OyRHX8QVpYf+3pTV0/ZxQTx8s87EKTLc9AC0dhIslcXU/V17jXRS
 8PKrJoEODLJ0jshm9K83OGrdk9BwdPiA7LJAk/FYijc4EJsGFXXQFzan1xino7UycP9uR3rXAeC
 zDZMng4AoqFvreiA648jHN1wEFvXJGZvFTJqDAtWMWwq5HHnrBogbFhmelZZoxt3vKM1qiFrmF1
 iYK+lo=
X-Google-Smtp-Source: AGHT+IE5Pi7/WFhY6UInBTMghs83uI2ZK+GleSNvoywJq2nyX9LPnM8pgZoFKWdpjRqybOo5S+q0yGjo5fwfUA5jFis=
X-Received: by 2002:a17:902:c40c:b0:243:589d:148e with SMTP id
 d9443c01a7336-245fec1d6e3mr21584115ad.5.1755788720213; Thu, 21 Aug 2025
 08:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
 <20250821014115.566598-2-Jesse.Zhang@amd.com>
In-Reply-To: <20250821014115.566598-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Aug 2025 11:05:08 -0400
X-Gm-Features: Ac12FXzKmBhU1Lyh8id1lSCow7DQ3uHOHfJBvvZwuDg1-KkOuIfstUFEWlg_L-0
Message-ID: <CADnq5_P-kzEa11A9BaSfxbv9_4z+i0mBD-Y7uAOM=ktN=6N_oQ@mail.gmail.com>
Subject: Re: [v9 02/11] drm/amdgpu: adjust MES API used for suspend and resume
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

On Wed, Aug 20, 2025 at 9:58=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
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
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index d6f50b13e2ba..46b24035e14c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -347,9 +347,60 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mg=
r,
>         amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }
>
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
> +       memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +       queue_input.suspend_fence_addr =3D queue->fence_drv->gpu_addr;

You need to allocate another per queue buffer for the suspend fence.
You should also set the sequence number  E.g.,

queue_input.suspend_fence_addr =3D queue->suspend_fence.gpu_addr;
queue_input.suspend_fence_value =3D ++queue->suspend_fence.seq;

You can't use queue->fence_drv->gpu_addr because that will overwrite
the protected fence from userspace.

> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);

Then here, you need to wait for the suspend fence.

Alex


> +       if (r)
> +               dev_err(adev->dev, "Failed to suspend queue, err (%d)\n",=
 r);
> +       return r;
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
