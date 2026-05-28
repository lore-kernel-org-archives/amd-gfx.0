Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FE4CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 19:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B544410F598;
	Thu, 28 May 2026 19:06:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TW2Heok4";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CEA10F598
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 19:06:04 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304e86ecebfso15957eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 12:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779995163; cv=none;
 d=google.com; s=arc-20240605;
 b=e7LUJUhv1/bGsbLqq47yqJsNs8nt37IBLT9IMOFrnHSdnvsbD4X3bQiqnH96YoNB7u
 nq6qrsXRTO1tHBxG1IKiOmvayP/YxGpQwibqzH+BF33zh2Dyr+QhFSAfs5z3IRNzngFz
 KoEHVgzeBMSkiMFe6pIg5cc3KvFFa4E2FdYr898FYLoSnLwMkVNZfhC8iJ7TLJWNhovd
 rhMVMub4f2YR6v2P1UNwPhmzxU6dr3fZtYxGzwLcI7SO7VBS+e8TgME2pevb2hCA95Os
 Kt4eCuvKrydE9e1n//qRP0G9O8Dt/XugYLv+EjSgLwSHX0eD0P6ZseOaaKGjSAlGwd1i
 DnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=onifHXX69YdTKcJN4UBC/GPwagl+JwYKtjX1h6y8GQk=;
 fh=gkoPe+54c4oWYF2PVKqr+b0lEaj1PU1ZD5Jdt4G/vK4=;
 b=OeytkPDGeQ/5P7ViFRwH682WYjgBMeDGcCGjdd3+djMQfzhZRSnwIe0fei1KBnPWxR
 qdTvhcHKCNnNm1ALSHoK0kGSfrA0pB1fEE4P42iJv1qUiDPkFX51y74O97AfoXHN7kUp
 ZfheoGd390ICxkVuOA3Xjauohog9i/aVeit3ra+qiFvWTSfISdLwGoEomDLDVvXZkLx1
 4PnmNGHSkeYQuqRM9AHWHPBsVQdzSlBIx4o5F/sPprQNI3UgNmg8UaZK/rgcwuDticYc
 RTs3V7fZFQGWuoPQOqmbNVBO97PRxR2cp12t3ahhjg3+3YxweXyGz3v7721sNmqSibWF
 pbtw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779995163; x=1780599963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onifHXX69YdTKcJN4UBC/GPwagl+JwYKtjX1h6y8GQk=;
 b=TW2Heok4Pl7VKlj8p42+YGXbm+CavnAQUGrJUCVBMWHlPm/38X+0f4yA7wG810zjUT
 bKNHQ6sV/JuOH0Y/4bj8Ptp8oomdC6RcI2kHfuOz8CXq7yqwxJVrle/+Zjq63J++eWHr
 RP0ePm66L0kMKBRQn1+J17h3Wo7CT2NJpDfxUXhfiRqTsemAzXXoC1mv3WTwjVK88q+F
 O/ZJ6ovbdpTq+0EDmNWNVMxxmsY11BBqPeR2OupeXusveCRp67JHLrmRmiw0DrQQtbkk
 5ptFD+7KR+IkCvVDpLc6Vkwm35MrlyPLZK1xU27T9yxnC497rQNrJSy2rIXeXKQJypL3
 IgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779995163; x=1780599963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=onifHXX69YdTKcJN4UBC/GPwagl+JwYKtjX1h6y8GQk=;
 b=GACaT3jTgaPitRNOLfv3dqU2oMOvcVURHJ7stioAS4Q198YqH4bsSS9PzMNrb9lvNs
 HqpuZf161N1VO2aOeLQKC5nWcf5F2XR2tgA94YMxtnemQZoH7S7RVFPdlR6brpH1RRci
 uL47ixnhwyxBBkhVGk1sOrdfYTHCh8DExvR/ZZC15kZa4dTDZSXbLu8NLA7ojEf78BOG
 P2sHU8JoU+I/ce016eYXuM/UC+PxDdrZPtGgTmjTy2AOSCd+pPxcHhk7yM9qxqJNf6AD
 kOf4jHkcuFKPdydxiSUJyGHHcCvgylXF3zy/WokpIGtEHfQVfSGSdpDZX8Hw/hjgheVF
 7j/w==
X-Gm-Message-State: AOJu0Yzr4Gj3rKpiTs6mnokdxzEx5S22Da1iNufjq8atllJxTTnSOz5X
 +RK5rlMtzwqquN55hSTa9xQtFzen6mQKrpqorDL77zvj1IhoGqzfCMSbi3bIKGiT3iGqrS3zx1/
 vyEQTmcFnBPBB2XUj1w1T2IkgM1RyogpA2g==
X-Gm-Gg: Acq92OGIAJyLumFIyCVyW7JjplWH27UQldlclxe4Y9Fm3jZhCg77vHS8Xrid9gFDMY5
 WALvgX/8K/kg9JW6pwRzKL47RAUSFXuI/V2ar2/lRnTuDGk/FnMbVTlIx3vtilJN+UK331eXgED
 coF+8IAtPm6snBjcbCWiy3ym03catJcuwTQIptroGGjCMIMDoOpiEVqv2eDTj/5NlLityY7CAru
 gYhXhlHjU+spqxxDRDIlG705uH+/a5N02OkOTNMxVE8SXYxGnxDv75Bh4ueepXR6U3fMoaJhFIO
 TITd3w87qp4q5wPOiFp0LXvxQ9lK5uj+FBRD8FwZSVuzIaV3k3Ya9mkOy/sWOyLPR1Wz+E7W7FR
 xvuT/L1Vw96ivVh8=
X-Received: by 2002:a05:7022:661f:b0:130:a719:a680 with SMTP id
 a92af1059eb24-137a87c855dmr47629c88.7.1779995163449; Thu, 28 May 2026
 12:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260528171917.45575-1-andrew.martin@amd.com>
In-Reply-To: <20260528171917.45575-1-andrew.martin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 15:05:51 -0400
X-Gm-Features: AVHnY4IEsry0LI7IWbqqT7jgfe_n7QdYk0eIYVO6IK2VEdUJkLIiHtYoAI6-Khk
Message-ID: <CADnq5_NOfe=bc0dsekVT0pC0oCm-cLUODJ8mxLSWHnUNb7JQ0A@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdkfd: Fix buffer overflow in SDMA queue
 checkpoint/restore on GFX11
To: Andrew Martin <andrew.martin@amd.com>
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

On Thu, May 28, 2026 at 1:34=E2=80=AFPM Andrew Martin <andrew.martin@amd.co=
m> wrote:
>
> The v11 MQD manager incorrectly assigned the CP-compute variants of
> checkpoint_mqd/restore_mqd for KFD_MQD_TYPE_SDMA queues. These functions
> use sizeof(struct v11_compute_mqd) (2048 bytes) instead of sizeof(struct
> v11_sdma_mqd) (512 bytes), causing a 1536-byte overflow.
>
> During CRIU checkpoint of an SDMA queue on Navi3x:
> - checkpoint_mqd() reads 2048 bytes from a 512-byte SDMA MQD buffer,
>   leaking 1536 bytes of adjacent GTT memory to userspace
>
> During CRIU restore:
> - restore_mqd() writes 2048 bytes into a 512-byte SDMA MQD buffer,
>   corrupting 1536 bytes of adjacent GTT memory (often the ring buffer
>   or neighboring MQDs)
>
> This is a copy-paste regression unique to v11. All other ASIC backends
> (cik, vi, v9, v10, v12) correctly use the SDMA-specific variants.
>
> Add checkpoint_mqd_sdma() and restore_mqd_sdma() functions that properly
> handle the smaller v11_sdma_mqd structure, matching the pattern used in
> other MQD managers.
>
> Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
> Assisted-by: Claude:Sonnet 4-5
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 40 ++++++++++++++++++-
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 4d8cf6008a77..ce0f5e8e5c29 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -355,6 +355,42 @@ static void restore_mqd(struct mqd_manager *mm, void=
 **mqd,
>         qp->is_active =3D 0;
>  }
>
> +static void checkpoint_mqd_sdma(struct mqd_manager *mm,
> +                               void *mqd,
> +                               void *mqd_dst,
> +                               void *ctl_stack_dst)
> +{
> +       struct v11_sdma_mqd *m;
> +
> +       m =3D get_sdma_mqd(mqd);
> +
> +       memcpy(mqd_dst, m, sizeof(struct v11_sdma_mqd));
> +}
> +
> +static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
> +                            struct kfd_mem_obj *mqd_mem_obj, uint64_t *g=
art_addr,
> +                            struct queue_properties *qp,
> +                            const void *mqd_src,
> +                            const void *ctl_stack_src,
> +                            const u32 ctl_stack_size)
> +{
> +       uint64_t addr;
> +       struct v11_sdma_mqd *m;
> +
> +       m =3D (struct v11_sdma_mqd *) mqd_mem_obj->cpu_ptr;
> +       addr =3D mqd_mem_obj->gpu_addr;
> +
> +       memcpy(m, mqd_src, sizeof(*m));
> +
> +       m->sdmax_rlcx_doorbell_offset =3D
> +               qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET_=
_SHIFT;
> +
> +       *mqd =3D m;
> +       if (gart_addr)
> +               *gart_addr =3D addr;
> +
> +       qp->is_active =3D 0;
> +}
>
>  static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>                         struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_a=
ddr,
> @@ -539,8 +575,8 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD=
_TYPE type,
>                 mqd->update_mqd =3D update_mqd_sdma;
>                 mqd->destroy_mqd =3D kfd_destroy_mqd_sdma;
>                 mqd->is_occupied =3D kfd_is_occupied_sdma;
> -               mqd->checkpoint_mqd =3D checkpoint_mqd;
> -               mqd->restore_mqd =3D restore_mqd;
> +               mqd->checkpoint_mqd =3D checkpoint_mqd_sdma;
> +               mqd->restore_mqd =3D restore_mqd_sdma;
>                 mqd->mqd_size =3D sizeof(struct v11_sdma_mqd);
>                 mqd->mqd_stride =3D kfd_mqd_stride;
>  #if defined(CONFIG_DEBUG_FS)
> --
> 2.43.0
>
