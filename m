Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC051C624A4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 18:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DCE10E142;
	Thu,  3 Sep 2026 18:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="en1uHrnd";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7B210E142
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 18:01:35 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-396afefb35bso9333a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 11:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788458495; cv=none;
 d=google.com; s=arc-20260327;
 b=YYLLXtwKSFURFQhlDeGnhPb8de144dlOF/s4J3scgswUWAp1DI1+JQ6D10wfjOmCmN
 pI3OcfbuCeyAqmyGPGzbCVstVWL9YppsgT/dVXIWwN/ke/YfFCK0LM6moeXA5lp5GcdA
 VyvBDyBj6uM9c4DCQVAulMa96uAietpiucjaNGjV1rk2nL9OtRl12PWmb21tI6Rgqjk2
 86qr/+6uHXUKKXWDTnEgsCZvMNAMCO7s56dIVAmAe65m7k7i+mhfrF+ACiysiLa0FNf4
 hEI9P8BhVuHCO+pDQ0a4u1/14eFkR0NG/1dhP5mJvOfqIqu8f1+i8G49FY1rYhOX9XMi
 Ak2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W6w5eXNC27nWfunPjU0K9NDObVYF9+B6SzJa0R881/E=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=bfDMBqjl5Uu+HjNyXyU+Slw3brQxp4r3ehoXvnp3WDBfYlqN01qQf+fTy4bGqg/uhg
 i6DrQrB3rWzCRHebnDiAxV2fMFFpMOny9MFmlDoQPywsi1Wzcr7P7cMyMETnOFy8o5jn
 STUpsw30oCyiH3Of7hmhK30Lyu+c9+eNh2fXEkJS6YO5AkasXDjmJEw+dXcK+9w0s0oy
 5Jl5ksAIf2SlXYzDFxCsS2xbpRmXpvV9ln6XJ9NVDUB+vFQlKVJEOyOiKDjgyZ0Q2i5r
 LGjy+/Rjj2W/atUHcuiOvNnpreTBew7wQDvNGPpREnYgBR1JxdXVtXsADoCDeKjFDfgY
 ER/Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788458495; x=1789063295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W6w5eXNC27nWfunPjU0K9NDObVYF9+B6SzJa0R881/E=;
 b=en1uHrndDpylW4nB4IRF/u4D0sLf7FM0feGLw837L9dBHIS1lHXoudKhR5wwxMiIz2
 vHhn61oc7jgsco1w4B5XIGIEa/AHAbGHTT1lYnvZpN8fSDCf63GkPv4dsA+/E9fvpxcc
 MmDkGYRdrIuKRe1wPYOoCrMTyigtwx1KjuasbUGOU3mooNlmNX5VEQqy/FCKoczMB/lK
 aPUgDXTC1U2IZev30bJ8nVTR+F71NdFJzYCbJZkEMi3s/Fa5eCI5v+N5ak5Hr1u8uaMC
 fd1O6cW6b0PgbrdNlRQXj/BCM+bPvdQyDyjPnuSNOnlMdNTvS7ZkH/Ex0GY6QxXN/neX
 kcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788458495; x=1789063295;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W6w5eXNC27nWfunPjU0K9NDObVYF9+B6SzJa0R881/E=;
 b=sX3uh9DociK4c/3WPzdn1pO4SaaUxapkLrs2YJ3iJOVYlGAdUNvuRTZ9TtbHrtE0vJ
 wAunFlZmadUk5CbUbWOQpFau4Nsd5q2GThvKxD8tNRXG8B+1HEJiAbMTBgiD/f8zs2TX
 EWgolQri3/C+MvQW/ZmGcnIGA1l4LWdw/RWbUbbN+eHBAGwy3oMbKygY7ktNFbBuOh2j
 QgARvGTJQci907kYLvNtfOWq3TnoZuxEzaoHDfny3tOU/AzWVNHvbQDIPyvlVFpZI8rT
 6TMcyctWF/VIOx9KwcFaNRUhvmJvZhwLgM7KbkWkwp4uEOrZ4wwT7RUjP3F9iYqtQtem
 JCyA==
X-Gm-Message-State: AFuF++k8FfcewHJTyW9xuOzQrfFKBnkFby5vhtnf8PVlGAxezOMQ0V7x
 5kkp20IXi/MLl/gMRFR6QVouFhMMJopXh/ilLL6VUPwbMrwjlT4az7GDKfcVAI1byPXu6KuQzQX
 VhviSB+g6Cec8025P7Cbl2nzp8sr/Y70=
X-Gm-Gg: AYBFou0VZmwrq/FW55L2AW4b5JKcxUBT+9PUYt3DVdySu24r3YAGEZ/EsMv1jhJRpvD
 YWKBlcd2ODrQJ2M60eEnOz2HHI826BsUxg7Imb0w5BpDpLQ1zugTyLXFMpqELgkGZDbBY/BpLaN
 NnnCKIhwAXKhMhgDt/uwz9jc66ghVsxDqoI0ArLBbAdShoiey90Jgpxe6PDN5PTTHWw8d3MtjN3
 qG51oWjkblNtzv9l/lqEitAH02snaKXHQkuBMvCyxeQqvQLg3yaIrQSoSQLYTFoy0KqgrMIka8L
 tw+KAXgKPwrqfWF8QRr8nFs4Q76kQ+nNtLXofptnvO9r9YAl84p2qtfKJkeu38jkfhSUIa0Gh7Z
 5hxc9+Xzh3v1bAytDEfp/ZxcXiRWxR2M=
X-Received: by 2002:a17:90b:5404:b0:396:d28e:b52 with SMTP id
 98e67ed59e1d1-39b26229b5dmr176402a91.3.1788458495148; Thu, 03 Sep 2026
 11:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
 <20260831052513.1518180-8-Jesse.Zhang@amd.com>
In-Reply-To: <20260831052513.1518180-8-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Sep 2026 14:01:23 -0400
X-Gm-Features: AcwNN1WHjzqWHD16Ndo-MW_Y-Yt31XUSbCsHDDXH10iTudb6oUe-VYjHUGvUf3o
Message-ID: <CADnq5_PC9fRaLvF8ydvM-2HsHo1ue3LimCXK7bQBynLvDZk5TA@mail.gmail.com>
Subject: Re: [PATCH V3 08/10] drm/amdgpu/mes_userqueue: route compute MODIFY
 through init_mqd
To: Jesse Zhang <Jesse.Zhang@amd.com>
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

On Mon, Aug 31, 2026 at 1:50=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Set prop->modify and prop->user_wptr (read from the wptr poll BO) and
> call init_mqd, so a re-enabled compute queue keeps its context-saved
> rptr and resumes at the first un-consumed packet.
>
> Also set modify=3Dfalse on the create and kernel-ring
> (amdgpu_ring_to_mqd_prop) paths, so every init_mqd caller states its own
> value rather than relying on the zeroed prop.
>
> v3: set the mqd_prop modify flag and call init_mqd instead of a separate
>     update_mqd callback, per review.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 20 +++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 686c92e96025..9fd0ab0be40e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -840,6 +840,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_rin=
g *ring,
>         prop->use_doorbell =3D ring->use_doorbell;
>         prop->doorbell_index =3D ring->doorbell_index;
>         prop->kernel_queue =3D true;
> +       /* kernel rings always build the MQD from scratch, never a MODIFY=
 */
> +       prop->modify =3D false;
>
>         /* map_queues packet doesn't need activate the queue,
>          * so only kiq need set this field.
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 82bb4369451e..c6ac3194e4da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -479,6 +479,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>         userq_props->use_doorbell =3D true;
>         userq_props->doorbell_index =3D queue->doorbell_index;
>         userq_props->fence_address =3D queue->fence_drv->gpu_addr;
> +       userq_props->modify =3D false;
>
>         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>                 struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> @@ -681,6 +682,20 @@ static int mes_userq_mqd_create(struct amdgpu_usermo=
de_queue *queue,
>         return r;
>  }
>
> +/* Read the queue's live user wptr from its poll BO; 0 if not mapped. */
> +static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
> +{
> +       u64 user_wptr =3D 0;
> +       void *wc =3D NULL;
> +
> +       if (queue->wptr_obj.obj &&
> +           !amdgpu_bo_kmap(queue->wptr_obj.obj, &wc) && wc) {
> +               user_wptr =3D *(volatile u64 *)wc;
> +               amdgpu_bo_kunmap(queue->wptr_obj.obj);
> +       }
> +       return user_wptr;
> +}

Can't we just skip this?  The firmware should update the MQD and store
the current rptr/wptr when we unmap it.  So when we modify the queue,
all we need to do is skip any changes to the rptr/wrptr when we modify
the MQD.  No need to save the wptr.  Other than that, the patches look
good to me.

Alex

> +
>  static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *qu=
eue,
>                                         struct drm_amdgpu_userq_in *args_=
in)
>  {
> @@ -707,8 +722,11 @@ static int mes_userq_compute_mqd_update(struct amdgp=
u_usermode_queue *queue,
>
>         userq_props->queue_size =3D args_in->queue_size;
>         userq_props->hqd_base_gpu_addr =3D args_in->queue_va;
> +       userq_props->modify =3D true;
> +       userq_props->user_wptr =3D mes_userq_read_user_wptr(queue);
>
> -       retval =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_=
ptr, userq_props);
> +       retval =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_=
ptr,
> +                                        userq_props);
>
>  free:
>         kfree(compute_mqd_v11);
> --
> 2.49.0
>
