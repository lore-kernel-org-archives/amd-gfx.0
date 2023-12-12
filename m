Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4A5C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 14:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CAF10E5CF;
	Tue, 12 Dec 2023 14:34:22 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2FFE10E5CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 14:34:19 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b9efed2e6fso3113809b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 06:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702391659; x=1702996459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMUn4OL+zPqCiLvzmg1BVe9qDJwjQv4Wmw62oOvS4Ak=;
 b=HgnZGS65BOPGGNYK5gY6A6ISBB00y7/hnZ1Va0O10iiOBtcZmgFLTtoua8nQ2AIyfn
 Lw+G3+Y5XSRa0Fkmdj0wze7PVVQFMon7V/QuZ6fF61QT5bSsIbLyuZ9CdD8jHfWhwLLw
 EXkriR9J8WAzGt6FNu6aE/c8NixQiHBkRepN+pmTs4cKfB1qtPNmVTmQJzu6kNRZJgc5
 EkKOpTPD3HDXTKQejAK5fl8BeTwtIeLgg0ZQExckIO2xIthh48sEgkTKMv1yfnc6Y3jh
 sK2gXmHMTkHTWwGwsd78RDZ5QdARuEwTcj80pQLMMGpUcXhjHywfzvO4IYba/5H3yy65
 MpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702391659; x=1702996459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMUn4OL+zPqCiLvzmg1BVe9qDJwjQv4Wmw62oOvS4Ak=;
 b=vpXcX+eMpVot3Vgi3N0yxFdFu/fWDGg/s24Js5WsrwDmSpaDbK1IqyvDtCMcroY6IR
 qg7qKn9pd4IEzdgwAP0mqP30E8uPtziDeE0O/jO+VZTd4L2OS1tvSceAqjo4oZkU2glc
 P2pGRm/cEhBS0ZGZ76VWhoA63CCbhlANA6SV2CGHrSX+hdoQ5gGz/t6m7Jm4aXzpd5ez
 STbCmmWcLXaIKKPCNjBd3qZ3vWYRzZwvF0JbEzem5ETHnvljkRzMnZuAcKoIEHK279kJ
 KTMoPoyUtyMA1aiDVCnDlzxRy3jQd7UsgXNVkkAw0GoynP00Mt7cgQjXc2RytgXIWGVg
 JkzA==
X-Gm-Message-State: AOJu0Ywri2MtGGjvGxqklkR8Oqm1yCCZAFm0NQRMtrzaJAYYmE1etkj8
 ykVeQsC7J9L/EJl/0z5vrOddtjDFjATnf4t4/r8=
X-Google-Smtp-Source: AGHT+IGhCopw86oa6u476z5/KC3iuCP6AYltvmOQrPcJ9AXZElwgIuLOhNa5dO//PCjCbfsgMc8hU4Aory2jAk9GWT4=
X-Received: by 2002:a05:6871:8286:b0:1fa:e938:dd8e with SMTP id
 sq6-20020a056871828600b001fae938dd8emr8105578oab.25.1702391658644; Tue, 12
 Dec 2023 06:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
In-Reply-To: <20231202001740.120840-1-friedrich.vock@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Dec 2023 09:34:07 -0500
Message-ID: <CADnq5_PYuZudCQ+M76NaDErn99kXv-qhW8c4dTo693wtBEa9kA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
To: Friedrich Vock <friedrich.vock@gmx.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 1, 2023 at 7:18=E2=80=AFPM Friedrich Vock <friedrich.vock@gmx.d=
e> wrote:
>
> This improves latency if the GPU is already busy with other work.
> This is useful for VR compositors that submit highly latency-sensitive
> compositing work on high-priority compute queues while the GPU is busy
> rendering the next frame.
>
> Userspace merge request:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>

Applied with a minor change to bump the driver version as well so
userspace can detect this if necessary.  It shouldn't matter, but
better safe than sorry.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  3 ++-
>  4 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 9505dc8f9d69..4b923a156c4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {
>         uint64_t eop_gpu_addr;
>         uint32_t hqd_pipe_priority;
>         uint32_t hqd_queue_priority;
> +       bool allow_tunneling;
>         bool hqd_active;
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 231d49132a56..4d98e8879be8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ri=
ng *ring,
>                                     struct amdgpu_mqd_prop *prop)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> +       bool is_high_prio_compute =3D ring->funcs->type =3D=3D AMDGPU_RIN=
G_TYPE_COMPUTE &&
> +                                   amdgpu_gfx_is_high_priority_compute_q=
ueue(adev, ring);
> +       bool is_high_prio_gfx =3D ring->funcs->type =3D=3D AMDGPU_RING_TY=
PE_GFX &&
> +                               amdgpu_gfx_is_high_priority_graphics_queu=
e(adev, ring);
>
>         memset(prop, 0, sizeof(*prop));
>
> @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ri=
ng *ring,
>          */
>         prop->hqd_active =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KI=
Q;
>
> -       if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE &&
> -            amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) ||
> -           (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX &&
> -            amdgpu_gfx_is_high_priority_graphics_queue(adev, ring))) {
> +       prop->allow_tunneling =3D is_high_prio_compute;
> +       if (is_high_prio_compute || is_high_prio_gfx) {
>                 prop->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;
>                 prop->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIORITY_MA=
XIMUM;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index c8a3bf01743f..73f6d7e72c73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
>  #endif
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0)=
;
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> +                           prop->allow_tunneling);
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>         mqd->cp_hqd_pq_control =3D tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index c659ef0f47ce..bdcf96df69e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
>                             (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1))=
;
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0)=
;
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> +                           prop->allow_tunneling);
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>         mqd->cp_hqd_pq_control =3D tmp;
> --
> 2.43.0
>
