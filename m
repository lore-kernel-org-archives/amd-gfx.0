Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA19C3DA5D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 13:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C360010EC2B;
	Fri, 19 Jul 2024 13:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LP3NFsvQ";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46E710EC2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 13:56:32 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1fc5296e214so16261425ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721397392; x=1722002192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/idGMyYvJl0wp3DGJ4tWfcxRmavA9M/n6nBegs11Q08=;
 b=LP3NFsvQqbnoL2N8s07O/vcw1Mb8oYK0jZpUnB6Ai7kjReC2f1Fs6H+Iabm0fb9U1t
 nhpEyIMR53r9nYnBF+JVus8V+zVaPYiIVdlAtYjOvYFA7j2UudgvhwMiUWd7nU7yNgDQ
 IXM14HJBFDUP/n9K/jZytpB/Bv9t/xtv1r7zPXxIF2bqpMseJCL6+8lDBqegMA0tCzHM
 JSwKiYfwkylvSps4NrBPWbRT3JRBbblhpnY0jyRRyFr4LnIduHpXiX6d73CEEWffxxVJ
 zzVPnUuhbixHYQDe73nv0WMxwJ4kzrfa0e7MMzgabIBTWbq4GQ1Un3Df/kAawGLlOAYN
 4jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721397392; x=1722002192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/idGMyYvJl0wp3DGJ4tWfcxRmavA9M/n6nBegs11Q08=;
 b=PqJ/O986yZkYFcjgGzGWLxQG/pW21Dhku7CacwNfMgBAwk1y+w56i9yTnwnXZtY2X+
 K7W4o8TKOIOKClFm3EJ9QTxQPjDMAwO/N58eI+eQSKnEv8Im/dJnQqZkXcybklrxRb9m
 IEXg3QXh20hfmKXLYgpSU7BtFUI2FnsgZnF42OFjMj4GfRwRGI/AopcYZtKfiQgDYmtl
 SQ1PoxX9e16nlDwdQtSfSXjqX/JlWfl8ryhyUKjVdDX0jtjhSIest/aI9GSmPiKmY0kL
 u1SoCAZYwHQZHOPQF7H5gGarXQyg611xtjtU55efQIW9TadF4L5TVeptq6jzHXAQw2wN
 TI4A==
X-Gm-Message-State: AOJu0Ywl26JAMGpt80zuweQY1baxYbYxAbvGlKj5LlP2x9ZZsGDEiY3b
 8bMci6ohL3/miGvo0NjpqcUe4byWy8oBq1FaQRo3JyZBeU7JIlNNlQ3UUXuVi3yXacONfFkatcs
 BCtVTVQL1qQ1s9ITCKXw5XDTZ/qlTMTep
X-Google-Smtp-Source: AGHT+IHBN87q5Os8PtaCG2SNPVSq/C/zYaYUnKmH943BB/+I4yGobYBFF0aO1Z0ZE00eTYBxNv06iF18qZofhBbxvoo=
X-Received: by 2002:a17:90b:30ca:b0:2c8:ac1:d8c3 with SMTP id
 98e67ed59e1d1-2cb52927e76mr6976113a91.29.1721397392312; Fri, 19 Jul 2024
 06:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240719091615.1534436-1-Jack.Xiao@amd.com>
In-Reply-To: <20240719091615.1534436-1-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jul 2024 09:56:20 -0400
Message-ID: <CADnq5_PW4BuhEifrUQ9xVaWJjKVD5UgLKYKYPb=0TVxThu6ZJg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Fri, Jul 19, 2024 at 5:35=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote=
:
>
> wait memory room until enough before writing mes packets
> to avoid ring buffer overflow.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Fixes: de3246254156 ("drm/amdgpu: cleanup MES11 command submission")
Fixes: fffe347e1478 ("drm/amdgpu: cleanup MES12 command submission")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18 ++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18 ++++++++++++++----
>  2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 8ce51b9236c1..68c74adf79f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -168,7 +168,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>         const char *op_str, *misc_op_str;
>         unsigned long flags;
>         u64 status_gpu_addr;
> -       u32 status_offset;
> +       u32 seq, status_offset;
>         u64 *status_ptr;
>         signed long r;
>         int ret;
> @@ -196,6 +196,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>         if (r)
>                 goto error_unlock_free;
>
> +       seq =3D ++ring->fence_drv.sync_seq;
> +       r =3D amdgpu_fence_wait_polling(ring,
> +                                     seq - ring->fence_drv.num_fences_ma=
sk,
> +                                     timeout);
> +       if (r < 1)
> +               goto error_undo;
> +
>         api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status=
_off);
>         api_status->api_completion_fence_addr =3D status_gpu_addr;
>         api_status->api_completion_fence_value =3D 1;
> @@ -208,8 +215,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>         mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>         mes_status_pkt.api_status.api_completion_fence_addr =3D
>                 ring->fence_drv.gpu_addr;
> -       mes_status_pkt.api_status.api_completion_fence_value =3D
> -               ++ring->fence_drv.sync_seq;
> +       mes_status_pkt.api_status.api_completion_fence_value =3D seq;
>
>         amdgpu_ring_write_multiple(ring, &mes_status_pkt,
>                                    sizeof(mes_status_pkt) / 4);
> @@ -229,7 +235,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>                 dev_dbg(adev->dev, "MES msg=3D%d was emitted\n",
>                         x_pkt->header.opcode);
>
> -       r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, t=
imeout);
> +       r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
>         if (r < 1 || !*status_ptr) {
>
>                 if (misc_op_str)
> @@ -252,6 +258,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>         amdgpu_device_wb_free(adev, status_offset);
>         return 0;
>
> +error_undo:
> +       dev_err(adev->dev, "MES ring buffer is full.\n");
> +       amdgpu_ring_undo(ring);
> +
>  error_unlock_free:
>         spin_unlock_irqrestore(&mes->ring_lock, flags);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index c9f74231ad59..48e01206bcc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -154,7 +154,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>         const char *op_str, *misc_op_str;
>         unsigned long flags;
>         u64 status_gpu_addr;
> -       u32 status_offset;
> +       u32 seq, status_offset;
>         u64 *status_ptr;
>         signed long r;
>         int ret;
> @@ -182,6 +182,13 @@ static int mes_v12_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>         if (r)
>                 goto error_unlock_free;
>
> +       seq =3D ++ring->fence_drv.sync_seq;
> +       r =3D amdgpu_fence_wait_polling(ring,
> +                                     seq - ring->fence_drv.num_fences_ma=
sk,
> +                                     timeout);
> +       if (r < 1)
> +               goto error_undo;
> +
>         api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status=
_off);
>         api_status->api_completion_fence_addr =3D status_gpu_addr;
>         api_status->api_completion_fence_value =3D 1;
> @@ -194,8 +201,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>         mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>         mes_status_pkt.api_status.api_completion_fence_addr =3D
>                 ring->fence_drv.gpu_addr;
> -       mes_status_pkt.api_status.api_completion_fence_value =3D
> -               ++ring->fence_drv.sync_seq;
> +       mes_status_pkt.api_status.api_completion_fence_value =3D seq;
>
>         amdgpu_ring_write_multiple(ring, &mes_status_pkt,
>                                    sizeof(mes_status_pkt) / 4);
> @@ -215,7 +221,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>                 dev_dbg(adev->dev, "MES msg=3D%d was emitted\n",
>                         x_pkt->header.opcode);
>
> -       r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, t=
imeout);
> +       r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
>         if (r < 1 || !*status_ptr) {
>
>                 if (misc_op_str)
> @@ -238,6 +244,10 @@ static int mes_v12_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>         amdgpu_device_wb_free(adev, status_offset);
>         return 0;
>
> +error_undo:
> +       dev_err(adev->dev, "MES ring buffer is full.\n");
> +       amdgpu_ring_undo(ring);
> +
>  error_unlock_free:
>         spin_unlock_irqrestore(&mes->ring_lock, flags);
>
> --
> 2.41.0
>
