Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F7DE909D2
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 16:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EDA10E50D;
	Tue, 17 Feb 2026 16:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KD2qBgiF";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D88910E50D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 16:11:54 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-127148c2112so330026c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 08:11:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771344714; cv=none;
 d=google.com; s=arc-20240605;
 b=HgyEK9c6uCf2NrZ4PmC5dUXCSu/j23uI/Z/iBZ/Z64YyG1emPzKjZ+KN8/ZYos3Xy5
 LVhMxabcY3LGg9jS5VTdbeyDvikwEJyO69LiqMPxML3FVbRiWjxqWa5kq7jEJnjIigiu
 QJZbDX4yAzQaybE43lBSnIxh6/JcyPgJVTCVcH5v6OK2wGLfsQY7ALi4ameamgv7Irvi
 QpPcXk6vtW+9qXtajGuxYEbhizacGQS6k7MqMPNZAJKnnkH8AtDDMqHMcIKIBakS8h0s
 G70vwOpD2NGbmWaYlCd1ZxgrKVFaTaej57uaKEVxR/Fpx1iTr4gWR7xZK27Cx0msdep9
 DCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ys2nmb9jfZmDWRjPOlnRXiHNClkGEjC4v6EyMQw4yIs=;
 fh=d+JEqXFCoQt+fegtdVYiV0efE83FqxZXCWXG53p3UYY=;
 b=g0efOZ6E7J+Hz/IXpPWfANevtDHSAN98cDzFI4ZeQDLlOyv4UQDWKhIXvJh4VaPBcI
 X/ytFYQOhzHhPN7Q+T2IhKH//cxsIzQPWymd4FsxyTv4wUyGt/8W7/7fdn0Fxkc/yyTb
 93+DSc0dGD4ffUOyNYi/qNeRgCqNseXSgFOfh26nrBFBqQpEwsuT5fEg8x5bukD+SCZb
 HqHOkCGLM9DWee8WbdjOrLYeXSGzgjjIKuHdPZp/KW1dBCL7XQmrDHLYL38piiNLqPyt
 N9D6/mlHN5sEx4sQzvwaZ1xvjGsPl8G08k0CQpE+2PKVtLFJvnzgns/tSkmnXmZF3p3U
 seKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771344714; x=1771949514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ys2nmb9jfZmDWRjPOlnRXiHNClkGEjC4v6EyMQw4yIs=;
 b=KD2qBgiFZlZFxF/F0K7kqtzb2S6lyCyVmfYns+pMuNJ7jLU+RE7F1aUjqD+2AEN5l7
 3feQQXUKtCUOU/QmLEabRa45kremQjmGYBHwS0CCv0XVXRazPraGRav7KmQzoIAdJr+q
 U6fyAFZ1ZBMd4WQVcjQRjyMdM6KuOLy6NwvfADdYEvm53To6SffeOeZ4EsZ8EiJtlxId
 ufRB31FdSoaHz3A86ejwuEUa3HWjR+LTa2SeZjrN47K5sYZAp+FKgpV26ML6kyHZngpO
 8SuadCCppJ2x6lKYh1q44pdLj1u0gM5Vkas9crzzw4hv7lN6Jk6fvOAGvlGvqbuDdt90
 ygrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771344714; x=1771949514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ys2nmb9jfZmDWRjPOlnRXiHNClkGEjC4v6EyMQw4yIs=;
 b=PpyKpbkVp4avcQ2JYo/+QOBa7chxI8vx/R3pESrIWr5ZgATP6RQUTcViG7OgLJB2X5
 OdsY8fryjvCPv2oBBoKwYTTc7Uf6/Ac4dZpwZ1FSr5Z91F0Ii6oOU2azHtzCLG4utYML
 xGktyZEeitvygsK1recjeYSXcE1nvVPOopvU0iRyLlGxlrmL55b4jgPh5QAVXv2vll8Q
 CPDXRGVpuO6kltME8+jOuVU0HQ3KnLRJVk4MoXgGMqbPXqnpAYB9wnieui0C97wSWSuB
 0QOqZIbmvzGPkgsco7RIaf7rB9wq1lD09BBGnG1XdSxXBisH8UIUQKEnt6oRCax9gnMc
 lPaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWK7nE2m/c76kB3Y7cA1db5IUkk55CuhJR31mEWwX2L9HBkguVCyAV91/a5SNBGT7L8wMM2cLQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIHFaiY9wOSnVuEtoDF4qZ5pE7UfbiqAjai5+KjY6OlPNnLW4d
 x6NaJXvp13T3VDoPygHK/URTIboEWQ1ltqqwd8whXl6Lbz6lxU29ueEX0VNmnFMCpWIxHrS5+UX
 BxnNCAGbdblnrgPMx3vEtiAWJekTDS8sVh8M9
X-Gm-Gg: AZuq6aJ715R/KqBt5f1ncQlzH2CQ3qyCPH34L/LHkgd4HZzbphtM17CkPtrPKHd32Pq
 zeeKHsbIq+v6iyuFi6/Bs30m2TJf217SNkrlwJDDsmEYJ18oLyZLsCzdplBeZ/H+K+xCvgA/UQl
 iFfGSSnmET7W/Zboq6CcWQaREUKK/uVcPXirjNyPktBmjew2cN4MzxbAL21FGbRDhrWfzA+9G7N
 kib/aNcZs2k8I0B9T+4Ka8bWlK4StzukluBkWHibN2k3wNfHEAm3saXdMqifSEAw2gPX53JzgVt
 Z8Zy+9cGTfsJxVSUadg5HGEPW/nSF1z2Qq20y5XcohCGUfQyasrVkABw+ZQAWo09ud0jcg==
X-Received: by 2002:a05:7022:920:b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-1273985ace2mr2655137c88.3.1771344713572; Tue, 17 Feb 2026
 08:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com>
 <20260211102657.4180-3-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260211102657.4180-3-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Feb 2026 11:11:42 -0500
X-Gm-Features: AaiRm52pBRBbeOkwLwIwii93PtigtFIgvM8bUjN8oL2VmLbaA8mWe6_bsR4uGDE
Message-ID: <CADnq5_M9xctfe8j-w99+N7Liqq2J9DP+g9xb8vwjugE7baBJfQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] drm/amdgpu: save ring content before resetting the
 device
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 11, 2026 at 5:29=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Otherwise the content might not be relevant.
>
> When a coredump is generated the rings with outstanding fences
> are saved and then printed to the final devcoredump from the
> worker thread.
> Since this requires memory allocation, the ring capture might
> be missing from the generated devcoredump.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 85 +++++++++++++++----
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  | 13 ++-
>  2 files changed, 81 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 0808ca98ccd9..0bf85ab43204 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -204,7 +204,9 @@ amdgpu_devcoredump_format(char *buffer, size_t count,=
 struct amdgpu_coredump_inf
>         struct drm_print_iterator iter;
>         struct amdgpu_vm_fault_info *fault_info;
>         struct amdgpu_ip_block *ip_block;
> -       int ver;
> +       struct amdgpu_ring *ring;
> +       int ver, i, j;
> +       u32 ring_idx, off;
>
>         iter.data =3D buffer;
>         iter.offset =3D 0;
> @@ -294,23 +296,25 @@ amdgpu_devcoredump_format(char *buffer, size_t coun=
t, struct amdgpu_coredump_inf
>
>         /* Add ring buffer information */
>         drm_printf(&p, "Ring buffer information\n");
> -       for (int i =3D 0; i < coredump->adev->num_rings; i++) {
> -               int j =3D 0;
> -               struct amdgpu_ring *ring =3D coredump->adev->rings[i];
> +       if (coredump->num_rings) {
> +               for (i =3D 0; i < coredump->num_rings; i++) {
> +                       ring_idx =3D coredump->rings[i].ring_index;
> +                       ring =3D coredump->adev->rings[ring_idx];
> +                       off =3D coredump->rings[i].offset;
>
> -               drm_printf(&p, "ring name: %s\n", ring->name);
> -               drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
> -                          amdgpu_ring_get_rptr(ring),
> -                          amdgpu_ring_get_wptr(ring),
> -                          ring->buf_mask);
> -               drm_printf(&p, "Ring size in dwords: %d\n",
> -                          ring->ring_size / 4);
> -               drm_printf(&p, "Ring contents\n");
> -               drm_printf(&p, "Offset \t Value\n");
> +                       drm_printf(&p, "ring name: %s\n", ring->name);
> +                       drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask=
: %x\n",
> +                                  coredump->rings[i].rptr,
> +                                  coredump->rings[i].wptr,
> +                                  ring->buf_mask);
> +                       drm_printf(&p, "Ring size in dwords: %d\n",
> +                               ring->ring_size / 4);
> +                       drm_printf(&p, "Ring contents\n");
> +                       drm_printf(&p, "Offset \t Value\n");
>
> -               while (j < ring->ring_size) {
> -                       drm_printf(&p, "0x%x \t 0x%x\n", j, ring->ring[j =
/ 4]);
> -                       j +=3D 4;
> +                       for (j =3D 0; j < ring->ring_size; j +=3D 4)
> +                               drm_printf(&p, "0x%x \t 0x%x\n", j,
> +                                          coredump->rings_dw[off + j / 4=
]);
>                 }
>         }
>
> @@ -354,6 +358,8 @@ static void amdgpu_devcoredump_free(void *data)
>         cancel_work_sync(&coredump->work);
>         coredump->adev->coredump_in_progress =3D false;
>         kfree(coredump->formatted);
> +       kfree(coredump->rings);
> +       kfree(coredump->rings_dw);
>         kfree(data);
>  }
>
> @@ -382,6 +388,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, boo=
l skip_vram_check,
>         struct drm_device *dev =3D adev_to_drm(adev);
>         struct amdgpu_coredump_info *coredump;
>         struct drm_sched_job *s_job;
> +       u64 total_ring_size, ring_count;
> +       struct amdgpu_ring *ring;
> +       int i, off, idx;
> +
> +       if (adev->coredump_in_progress)
> +               return;
>
>         if (adev->coredump_in_progress)
>                 return;
> @@ -410,6 +422,47 @@ void amdgpu_coredump(struct amdgpu_device *adev, boo=
l skip_vram_check,
>                 coredump->ring =3D to_amdgpu_ring(s_job->sched);
>         }
>
> +       /* Dump ring content if memory allocation succeeds. */
> +       ring_count =3D 0;
> +       total_ring_size =3D 0;
> +       for (i =3D 0; i < adev->num_rings; i++) {
> +               ring =3D adev->rings[i];
> +
> +               /* Only dump rings with unsignalled fences. */
> +               if (atomic_read(&ring->fence_drv.last_seq) =3D=3D ring->f=
ence_drv.sync_seq &&
> +                   coredump->ring !=3D ring)
> +                       continue;
> +
> +               total_ring_size +=3D ring->ring_size;
> +               ring_count++;
> +       }
> +       coredump->rings_dw =3D kzalloc(total_ring_size, GFP_NOWAIT);
> +       coredump->rings =3D kcalloc(ring_count, sizeof(struct amdgpu_core=
dump_ring), GFP_NOWAIT);
> +       if (coredump->rings && coredump->rings_dw) {
> +               for (i =3D 0, off =3D 0, idx =3D 0; i < adev->num_rings; =
i++) {
> +                       ring =3D adev->rings[i];
> +
> +                       if (atomic_read(&ring->fence_drv.last_seq) =3D=3D=
 ring->fence_drv.sync_seq &&
> +                           coredump->ring !=3D ring)
> +                               continue;
> +
> +                       coredump->rings[idx].ring_index =3D ring->idx;
> +                       coredump->rings[idx].rptr =3D amdgpu_ring_get_rpt=
r(ring);
> +                       coredump->rings[idx].wptr =3D amdgpu_ring_get_wpt=
r(ring);
> +                       coredump->rings[idx].offset =3D off;
> +
> +                       memcpy(&coredump->rings_dw[off], ring->ring, ring=
->ring_size);
> +                       off +=3D ring->ring_size;
> +                       idx++;
> +               }
> +               coredump->num_rings =3D idx;
> +       } else {
> +               kfree(coredump->rings_dw);
> +               kfree(coredump->rings);
> +               coredump->rings_dw =3D NULL;
> +               coredump->rings =3D NULL;
> +       }
> +
>         coredump->adev =3D adev;
>
>         ktime_get_ts64(&coredump->reset_time);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> index 4c37a852b74a..1c3d22356cc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> @@ -31,6 +31,13 @@
>
>  #define AMDGPU_COREDUMP_VERSION "1"
>
> +struct amdgpu_coredump_ring {
> +       u64                             rptr;
> +       u64                             wptr;
> +       u32                             ring_index;
> +       u32                             offset;
> +};
> +
>  struct amdgpu_coredump_info {
>         struct amdgpu_device            *adev;
>         struct amdgpu_task_info         reset_task_info;
> @@ -41,12 +48,16 @@ struct amdgpu_coredump_info {
>         bool                            skip_vram_check;
>         bool                            reset_vram_lost;
>         struct amdgpu_ring              *ring;
> +
> +       struct amdgpu_coredump_ring     *rings;
> +       u32                             *rings_dw;
> +       u32                             num_rings;
> +
>         /* Readable form of coredevdump, generate once to speed up
>          * reading it (see drm_coredump_printer's documentation).
>          */
>         ssize_t                         formatted_size;
>         char                            *formatted;
> -
>  };
>  #endif
>
> --
> 2.43.0
>
