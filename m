Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096A0C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 21:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C56510E619;
	Fri, 19 May 2023 21:22:21 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230A410E619
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 21:22:20 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-195ee1be418so2963612fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684531339; x=1687123339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9IBej/lF+NGcSCEqFY8dSdo2qZYwnsZNiTaH4nACc0=;
 b=LDn1H9D9T7CYnDw5hR7xUDn6z46lY6TTnL/HtEcStIgBHb0yHa7t4ZzmmQJ6mTj+oZ
 gQ5ESMpNvnpenQYxwfWGf73b/5GUzooLev6ebSKKrhQIssA7PULasp2BBirUOGEdH4ma
 jj6RNtPN+DpOvx0Hv/XhtMJOwEMuj4Hf6xPgzv6yUqS6+6U+HuJt7fKuv1XCe3u3PqA/
 nAHmuWaJXhzJ+TKmkSW4bzZfPnVO45fmR5BtW7wJvl+ngvGkjCwEbZ12hF/8nccFy30u
 8Gkx92OqboHwFQRO9RuVxCTkf+843abhg6ESpXoFkJo4vgcFu2Zk/hAqUesynUmiiQSP
 Pm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684531339; x=1687123339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9IBej/lF+NGcSCEqFY8dSdo2qZYwnsZNiTaH4nACc0=;
 b=jRRHCgykfXcuL0Mj/Ws9JWFXE3W0eeDI5Dz41MdoSParqACne8fHfCMmfhCT6EbCen
 IZmZk0fkSeYLldT+PLvVSEri+NytHjMdXb7uQCOwynsxd4PKNXFU0rLuk7562AOOW0bq
 TgfRCgCS+lZJqM+C1SAF9vOxcaq4GwCyeadesWk3+9MF+6Yd4dPCO9moGsw478uzatf3
 RnDp7oVRrKzNA2Mw5ON992kLXLnfCl1YKApv2NUg9T638LHusnARxzwjv7s7B6HBVyGN
 HZkbdGL3SOGxyK6RnfvRJYVeYIk94SvoT7N0IUlPTi6FsO8V1kgvFQAdWySp9xTGlCV1
 4S3w==
X-Gm-Message-State: AC+VfDysUMLDydxnUp/8tloNQnTvDZ6rrdtiKzCqYa3WhhnIXnWYnZ36
 2LTblkrDvAZbBgqa8QQTu/d2ucC8ZDbiCIxGbaN4gtJDj7Y=
X-Google-Smtp-Source: ACHHUZ6SPnUHgjYSDT32hfoCagqY1gRlY0ZBMK30WTjCxyW52L/m8AeMp6KTsImHe1pYV3TWz7IRHIZtGqzXtOaclnM=
X-Received: by 2002:a54:4789:0:b0:396:63a:a713 with SMTP id
 o9-20020a544789000000b00396063aa713mr1823586oic.55.1684531339269; Fri, 19 May
 2023 14:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-7-shashank.sharma@amd.com>
In-Reply-To: <20230424173836.1441-7-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 17:22:08 -0400
Message-ID: <CADnq5_Ncu2zSiJqLOu5h63c77AwO3rMGe5=3w3thEGjtYfFBaw@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] drm/amdgpu: set FW parameters in v11_struct
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
Cc: pierre-eric.pelloux-prayer@amd.com, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 24, 2023 at 1:39=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> From: Arvind Yadav <arvind.yadav@amd.com>
>
> This patch sets new parameters defined in v11_struct for
> usermode queue with the respective allocated gpu context
> space addresses.
>
> V4: Split the patch into two parts, keep only the set parameter
>     part in this series (Alex).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index f6b33faea86f..86de35292f69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6411,6 +6411,21 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_=
block =3D
>         .funcs =3D &gfx_v11_0_ip_funcs,
>  };
>
> +static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,


gfx_v11_0_ for consistency.

Alex

> +                                       struct amdgpu_usermode_queue *que=
ue)
> +{
> +       struct v11_gfx_mqd *mqd =3D queue->mqd.cpu_ptr;
> +
> +       mqd->shadow_base_lo =3D queue->shadow_ctx_gpu_addr & 0xfffffffc;
> +       mqd->shadow_base_hi =3D upper_32_bits(queue->shadow_ctx_gpu_addr)=
;
> +
> +       mqd->gds_bkup_base_lo =3D queue->gds_ctx_gpu_addr & 0xfffffffc;
> +       mqd->gds_bkup_base_hi =3D upper_32_bits(queue->gds_ctx_gpu_addr);
> +
> +       mqd->fw_work_area_base_lo =3D queue->fw_ctx_gpu_addr & 0xfffffffc=
;
> +       mqd->fw_work_area_base_lo =3D upper_32_bits(queue->fw_ctx_gpu_add=
r);
> +}
> +
>  static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mg=
r,
>                                           struct amdgpu_usermode_queue *q=
ueue)
>  {
> @@ -6484,12 +6499,14 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr =
*uq_mgr, struct amdgpu_usermode
>         queue->userq_prop.use_doorbell =3D true;
>         queue->userq_prop.mqd_gpu_addr =3D mqd->gpu_addr;
>         r =3D gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->u=
serq_prop);
> -       amdgpu_bo_unreserve(mqd->obj);
>         if (r) {
> +               amdgpu_bo_unreserve(mqd->obj);
>                 DRM_ERROR("Failed to init MQD for queue\n");
>                 goto free_ctx;
>         }
>
> +       gfx_v11_userq_set_ctx_space(uq_mgr, queue);
> +       amdgpu_bo_unreserve(mqd->obj);
>         DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>         return 0;
>
> --
> 2.40.0
>
