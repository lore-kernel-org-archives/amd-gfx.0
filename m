Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE2FD778AE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 21:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6C210EBD8;
	Fri, 23 Jan 2026 21:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="if58MGJL";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B285710EBDA
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 21:05:02 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1232c98f98cso213065c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 13:05:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769202302; cv=none;
 d=google.com; s=arc-20240605;
 b=K+MVzzmlJOqDcMFE4Hq8Nr4/eRRQKf4kUdvnlc7Uw4bAwmZj3g/aRG9FHF3ktCpTQr
 oCSBen0v97XnAVBfon1HHio+S7GiY1itjC+jfGRVyHsr5nZMvUOpaMARrZJDPdVnovB/
 y9heBXyBC/lMaw3DbG9dOLbZXxQWLq9WAw736U0G9sbCeJ9qvQDUHevvV1puW8t0KGZD
 FjpQ62qOtSFm9NOvAKp/GZiFtRFyEJTPB4DMbUvVVZkCPo1yCXV7Pv/CmVMiClF42W6a
 BEuNbUgODsreE47gHncf38fQdQT3Alhz4Gr5HOZdsTDMGAZRYJV99EjXMzRUJOgzNW1P
 BxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K3497v51MQeryjZMG2yGtdLxdCp/PJbg5fIqfaHcek4=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=Oic8YObjnWgb5Lg2vsUOOdX3jCJvygt8WZ5XbzDaVR1t7vKF/SCAsbRHixb5gsSH6D
 Gm9b0oCFzNsgDvY8Mc/5UxlaoQkC0U9iT7wHfAn7HG2m1ChHKoa/aDzU31Mdi/hPvvTv
 Sl8T2zQBkn7Yr6IXjzfrQ2K1eaRX2Gq3FzvrVKQaAhB2/Mr7taWm/arKe2ZK6YkSP5jm
 5cDhdZDjkCL81drkO4yBlim6fELyJ3u7htqBqzwMz1YY3xsMmj0I058UslWQUdn7Q/Rm
 aXRnYwKNELdbTD8Z9sAW4jzZxPA/OK0TYxzLmOUzMvsCSHRDDKxijp7Ue6o8LTPHUhZ2
 6M+A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769202302; x=1769807102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3497v51MQeryjZMG2yGtdLxdCp/PJbg5fIqfaHcek4=;
 b=if58MGJLkd2KkUCuACQJWpd94t3WaZvdZ2ViySduAgSYzhAdJIDKZMI28LwbjkxxWT
 agt1L5Wljlvvm692Dv6mx9Cwj4yt4xydfo+saAfefgciwQ9JygKt/1g7daaEMZ/RIMIa
 MrqOZqaC7xxldaD0lifBX6ucmenmyGmE65DMvpTkdj/4E/9+FVr24Lm+ZHjwyfq+SUG2
 frUNBXg42MRB4fok2xqQlxUsz9jza8z/GCJ8SW801hcy6DFpBIrxWsAfh/MK2mNSwe0k
 jGSnx89i3FTKAx+S8tIKaw1i4xpB+fECep6fDg0fcJ/J8KNWhYAO/hy/MjmX354+ON9+
 FhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769202302; x=1769807102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K3497v51MQeryjZMG2yGtdLxdCp/PJbg5fIqfaHcek4=;
 b=SRz5ZNwly/Iqmvy0cX3wrdAp9Q3wRod3/Glfz1pdzZQqKM83QlnqORkESkIjShwdeb
 k21LnH/j6Qr3OetD7UIbYOza0H6p3DUeLIN9XQiSNh1s4s+6HIj7NzPgu07XAVnmb049
 vGVfwgjBjWtsjVZcguq64ShU2rPJipAKQCi7sj6UIPABRRIzYGkmLpJt2u2s3lGIOV2X
 IxQnKHr+YI8Y791PnMJrzH+LkfoECDDGGmzM+hVFrHAZYtmOm+n72eNhYfjMLNURMlJY
 Ez7bbnODextGaFZI0pCol0sECKM+sBc/z8MMaso2xTVE/DQvKrrlEAJrEr5bD4D4A3gc
 iVwQ==
X-Gm-Message-State: AOJu0YwmP1+Cg6/rEbroHqOH21/bDJR9wSEES9YtL2LopTI8ZknGs39k
 tZflPU7ygUQH1+xkUv0CQlfds7kot/krGYUkF5LTJAsD/HE2lBmdAl1FIul/UeIYlUI98otH+re
 2aeIZChQ87QHLniBJMFdu343bz1AVABY=
X-Gm-Gg: AZuq6aI1KOS1oIHbuvtUVegKrqAfIRiLosHaKFauZgwvAWzZ4Xrdjk0Q2xm6USUU2kW
 x8aV8G27Djx/WyaKxXm7YkOipmzkM68a/k/Dtqt6s4Yql7Hl8SDlqdZXCKhOX3wu2MbVxTb9uOg
 PEguUuuafsBNCckRAiTcZgeqsMS3wGtqWWxzjIWwc/vIUFgN9viJaZImKuHrMovGNH0YAKmx4s4
 kk/rmcuDhdof4NHq2kVMlE677IlQ6diiTkbC8XFoz1ybRDLGCeA3F3yrSlvQ4ek0qpZaHtm
X-Received: by 2002:a05:7022:61a0:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-1247dc161cemr1091327c88.7.1769202301859; Fri, 23 Jan 2026
 13:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
 <20260123100219.1693990-6-Jesse.Zhang@amd.com>
In-Reply-To: <20260123100219.1693990-6-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 16:04:49 -0500
X-Gm-Features: AZwV_Qh60hUn68pN490c31UZzzG4cCNN0ibRdMa_ZjgUiwSkxgcZw45NVVz7mew
Message-ID: <CADnq5_NNVmS0ZTRwLwyr5kzeOdaenHQoKJ+oZY2j+1bWn_L=Fg@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/amdgpu: implement CU mask modification support
 for AMDGPU user queues
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

On Fri, Jan 23, 2026 at 5:11=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Add support for dynamic Compute Unit (CU) mask modification to
> AMDGPU user queues via a new MODIFY_CU_MASK operation. This enables
> userspace to update CU allocation for existing queues at runtime.
>
> v2: add a new op for AMDGPU_USERQ. E.g., AMDGPU_USERQ_OP_CU_MASK
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 111 ++++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h             |  13 +++
>  2 files changed, 124 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 256ceca6d429..4d7841f47dd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -901,6 +901,113 @@ bool amdgpu_userq_enabled(struct drm_device *dev)
>         return false;
>  }
>
> +static int amdgpu_userq_update_queue(struct amdgpu_usermode_queue *queue=
)
> +{
> +       struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *uq_funcs;
> +       bool unmap_queue =3D false;
> +       int r;
> +
> +       uq_funcs =3D adev->userq_funcs[queue->queue_type];
> +       if (!uq_funcs || (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE))
> +               return -EOPNOTSUPP;
> +
> +       /*
> +        * Unmap the queue if it's mapped or preempted to ensure a clean =
update.
> +        * If the queue is already unmapped or hung, we skip this step.
> +        */
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED ||
> +           queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +               r =3D amdgpu_userq_unmap_helper(queue);
> +               if (r)
> +                       return r;
> +               unmap_queue =3D true;
> +       }
> +
> +       r =3D uq_funcs->mqd_update(queue);
> +
> +       if (unmap_queue) {
> +               r =3D amdgpu_userq_map_helper(queue);
> +               if (r)
> +                       drm_file_err(uq_mgr->file, "Failed to remap queue=
 %llu after update\n",
> +                               queue->doorbell_index);
> +       }
> +
> +       return r;
> +}
> +
> +static int amdgpu_userq_set_cu_mask(struct drm_file *filp,  union drm_am=
dgpu_userq *args)
> +{
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_usermode_queue *queue;
> +       struct amdgpu_mqd_prop *props;
> +       const int max_num_cus =3D 1024;
> +       size_t cu_mask_size;
> +       uint32_t count;
> +       uint32_t *ptr;
> +       int r;
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +       queue =3D amdgpu_userq_find(uq_mgr, args->in.queue_id);
> +       if (!queue) {
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               return -EINVAL;
> +       }
> +       props =3D queue->userq_prop;
> +
> +       if (args->in.cu_mask_count =3D=3D 0 || args->in.cu_mask_count % 3=
2) {
> +               r =3D -EINVAL;
> +               goto unlock;
> +       }
> +
> +       count =3D args->in.cu_mask_count;
> +       /* To prevent an unreasonably large CU mask size, set an arbitrar=
y
> +       * limit of max_num_cus bits.  We can then just drop any CU mask b=
its
> +       * past max_num_cus bits and just use the first max_num_cus bits.
> +       */
> +       if (count > max_num_cus) {
> +               drm_file_err(uq_mgr->file, "CU mask cannot be greater tha=
n 1024 bits");
> +               count =3D max_num_cus;
> +               cu_mask_size =3D sizeof(uint32_t) * (max_num_cus / 32);
> +       } else {
> +               cu_mask_size =3D sizeof(uint32_t) * (args->in.cu_mask_cou=
nt / 32);
> +       }
> +
> +       ptr =3D memdup_user(u64_to_user_ptr(args->in.cu_mask_ptr),
> +                                   cu_mask_size);
> +       if (IS_ERR(ptr)) {
> +               r =3D PTR_ERR(ptr);
> +               goto unlock;
> +       }
> +
> +       /* ASICs that have WGPs must enforce pairwise enabled mask checks=
. */
> +       if (ptr && adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0=
)) {
> +               for (int i =3D 0; i < count; i +=3D2) {
> +                       uint32_t cu_pair =3D (ptr[i / 32] >> (i % 32)) & =
0x3;
> +
> +                       if (cu_pair && cu_pair !=3D 0x3) {
> +                               drm_file_err(uq_mgr->file, "CUs must be a=
djacent pairwise enabled.\n");
> +                               kfree(ptr);
> +                               r =3D -EINVAL;
> +                               goto unlock;
> +                       }
> +               }
> +       }
> +
> +       props->cu_mask =3D ptr;
> +       props->cu_mask_count =3D count;
> +       r =3D amdgpu_userq_update_queue(queue);
> +
> +       kfree(ptr);
> +unlock:
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +
> +       return r;
> +}
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>                        struct drm_file *filp)
>  {
> @@ -920,6 +1027,10 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
>                         drm_file_err(filp, "Failed to create usermode que=
ue\n");
>                 break;
>
> +       case AMDGPU_USERQ_OP_MODIFY_CU_MASK:
> +               amdgpu_userq_set_cu_mask(filp, args);
> +               break;
> +
>         case AMDGPU_USERQ_OP_FREE:
>                 r =3D amdgpu_userq_destroy(filp, args->in.queue_id);
>                 if (r)
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index ab2bf47553e1..cfc3a9313229 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -330,6 +330,7 @@ union drm_amdgpu_ctx {
>  /* user queue IOCTL operations */
>  #define AMDGPU_USERQ_OP_CREATE 1
>  #define AMDGPU_USERQ_OP_FREE   2
> +#define AMDGPU_USERQ_OP_MODIFY_CU_MASK 3
>
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> @@ -410,6 +411,18 @@ struct drm_amdgpu_userq_in {
>          * gfx11 workloads, size =3D sizeof(drm_amdgpu_userq_mqd_gfx11).
>          */
>         __u64 mqd_size;
> +       /**
> +        * @cu_mask_ptr: User-space pointer to CU (Compute Unit) mask arr=
ay
> +        * Points to an array of __u32 values that define which CUs are e=
nabled
> +        * for this queue (0 =3D disabled, 1 =3D enabled per bit)
> +        */
> +       __u64 cu_mask_ptr;
> +       /**
> +        * @cu_mask_count: Number of entries in the CU mask array
> +        * Total count of __u32 elements in the cu_mask_ptr array (each e=
lement
> +        * represents 32 CUs/WGPs)
> +        */
> +       __u32 cu_mask_count;

I'd put these in drm_amdgpu_userq_mqd_compute_gfx11.  Then you can use
the mqd to set the CU mask on queue creation or modification.  I don't
see why we should limit it to just modify.

Alex

>  };
>
>  /* The structure to carry output of userqueue ops */
> --
> 2.49.0
>
