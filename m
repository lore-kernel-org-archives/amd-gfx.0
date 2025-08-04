Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF75C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C302010E21B;
	Mon,  4 Aug 2025 17:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NZNVxvy3";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD26C10E21B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:03:16 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-31ec2ac984eso803144a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754326996; x=1754931796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiO4O7vvoYwAbTNctlSHg9ULRBfpqkXKEzXuAKYn2QU=;
 b=NZNVxvy3JBs//+ix4DqbPET7A2R8LKhrjctSl/iQecHwVy+dFNrEiL588Q8npMux3a
 hKOQoHA1AH572j4D+OXgYMN8gdm6ytWFOPDBVujfxifk8RMAvHgRS18wGlICBEWhSiR+
 WaUvPkFKl7QWtU5YRbzaPLo09oEMd6Dbf7eNf5x/2ftxJR5PM3Z8WEujF7RXUwsbCQdf
 5UQ6CJHXYPFe+0BikvmwQBsyv0dUGcbBHVYU7MasBpMVJ2AH0QECmZ9wDQwVq6Nu3Kng
 SXfXiq6oyDS+uoEnpZeb+TkY0IK9Udo4IEW7ONxWzzQCUZLiACtHiIex7pwxLJYroPV0
 XPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326996; x=1754931796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiO4O7vvoYwAbTNctlSHg9ULRBfpqkXKEzXuAKYn2QU=;
 b=m6nr5nD9TF3Oxj6kwqlH1GbJJ9LHOnm/LHuF/uRr3nbjW8Daeg8fT3f6JZ6UD6u7m4
 szdwKSNffJbI3UMTfomPslHZvK5k1+eIkFRa0gJ2ksdNJ6LBFf8G4y1axSQWVM1Wn4AR
 CFs+n5gFI7LoWz7KGWqJCgbI6xlVK6Jp8fVtWRLwizAMd9T6Pw261Q8SbSdTdwEuEKb8
 u9l/wSAWA2QdTRxeWnDLCbWhPXjcylZN0RAyDAwLr9f1hSj4INMbGZMDs12bqkgb5s62
 hU5a4wqjOPrczLGYE5bAfgCa7kNjd7bgM8UBvEXaRYlH+3Mk/zj2sXQed6Ek/nVU1A6E
 ao5Q==
X-Gm-Message-State: AOJu0YzoAtcK8WaLLctLoVyIQorTyvA1O2T312sKXCPK0Uf57s+tBIsm
 H6a47/w6CymLspoZ/NbIpY11WH5Dpacu5xIu4UwzRRoUjTUsjlG6iTCKBZ/CzV9L2BMdHDdBqIz
 lssVwoq6/lytKmLm5Fs2p8cLv/qJTToh7HQ==
X-Gm-Gg: ASbGncuIkJLq/Oe+0/41RNa0TfqAFFjrElfXWnkmP86B0GGpWkdvFYW7lVaXcl2JaiT
 Bl69v3f4elg+7v1Kx9+m3e4U5at4VGWe6yjeg5apnHKnTzVXd9HExneC/G2eD38V0CXUCHBWDF6
 hMBMTVkFzWH9ogtE7EVIwC6x/609hVdt/iormS0L4ynrUqAABzzDKc61wvN8/E3mMatwfF5S2IT
 TlcPQJU
X-Google-Smtp-Source: AGHT+IETHjsTRY6NpW6CXn+iWreULvnD/6YixLBgRTl96zEVjI7aq7A5t+U+8bjZICki56VuppBdOczi/09bBU2pOsM=
X-Received: by 2002:a17:90b:1c03:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-321161e2197mr6796580a91.1.1754326996005; Mon, 04 Aug 2025
 10:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
 <20250804084029.863138-4-Jesse.Zhang@amd.com>
In-Reply-To: <20250804084029.863138-4-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:03:03 -0400
X-Gm-Features: Ac12FXzKdMl_j25qAYtoBWa-cmZODc6ZbPlmulI5R1UPOHQ4ZNFe_pYDb01xBKk
Message-ID: <CADnq5_MP3EsD7nLxTxr8+QdHisdcVLXx37HJxKNee-0i7rbMtA@mail.gmail.com>
Subject: Re: [v6 04/13] drm/amdgpu: Implement active VMID detection in MES11
 queue reset for GFX
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>,
 "kyle-hai.chau" <kyle-hai.chau@amd.com>
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

On Mon, Aug 4, 2025 at 4:48=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> MES queue reset functionality for GFX queues. The changes include:
>
> 1. Added detection of active VMIDs by reading CP_CNTX_STAT and CP_VMID
>    registers to properly identify contexts that need resetting
>
> 2. Implemented fallback to HPD status method when no active VMIDs are
>    found, checking both pipe 0 and pipe 1 queues
>
> 3. Extended the MES reset packet with:
>    - active_vmids bitmap
>    - connected_queue_index for pipe 0
>    - connected_queue_index_p1 for pipe 1
>

Do we still need this if we switch over to suspending queues before we
run detect and reset?

Alex

> Suggested-by: kyle-hai.chau <kyle-hai.chau@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 51 +++++++++++++++++++
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 13 ++++-
>  2 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index ed6a7f8af544..1422bc59cd40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -789,6 +789,12 @@ static int mes_v11_0_detect_and_reset_hung_queues(st=
ruct amdgpu_mes *mes,
>                                                   struct mes_detect_and_r=
eset_queue_input *input)
>  {
>         union MESAPI__RESET mes_reset_queue_pkt;
> +       struct amdgpu_device *adev =3D mes->adev;
> +       uint32_t active_vmids =3D 0;
> +       uint32_t connected_queue_index =3D 0;
> +       uint32_t queue_status =3D 0;
> +       uint32_t connected_queue_index_p1 =3D 0;
> +       uint32_t queue_status_p1 =3D 0;
>
>         memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
>
> @@ -801,6 +807,51 @@ static int mes_v11_0_detect_and_reset_hung_queues(st=
ruct amdgpu_mes *mes,
>         mes_reset_queue_pkt.doorbell_offset_addr =3D
>                 mes->hung_queue_db_array_gpu_addr;
>
> +       /* Add VMID detection for GFX queues */
> +       if (input->queue_type =3D=3D AMDGPU_RING_TYPE_GFX) {
> +               uint32_t cp_cntx_stat =3D RREG32_SOC15(GC, 0, regCP_CNTX_=
STAT);
> +               uint32_t cp_vmid, grbm_gfx_cntl;
> +
> +               /* Check active contexts in CP_CNTX_STAT */
> +               for (uint32_t i =3D 0; i < 8; i++) {
> +                       if ((cp_cntx_stat >> (0x14 + i)) & 0x1) {
> +                               grbm_gfx_cntl =3D (i << 11);
> +                               WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, grb=
m_gfx_cntl);
> +                               cp_vmid =3D RREG32_SOC15(GC, 0, regCP_VMI=
D);
> +                               active_vmids |=3D (1 << cp_vmid);
> +                       }
> +               }
> +
> +               /* Fallback to HPD status if no active VMIDs found */
> +               if (active_vmids =3D=3D 0) {
> +                       uint32_t hpd_status;
> +
> +                       /* Pipe 0 */
> +                       WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, 0);
> +                       hpd_status =3D RREG32_SOC15(GC, 0, regCP_GFX_HPD_=
STATUS0);
> +                       queue_status =3D hpd_status & 0x1F;
> +                       connected_queue_index =3D (hpd_status & 0xE0) >> =
5;
> +
> +                       /* Pipe 1 */
> +                       WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, (1 << 6));
> +                       hpd_status =3D RREG32_SOC15(GC, 0, regCP_GFX_HPD_=
STATUS0);
> +                       queue_status_p1 =3D hpd_status & 0x1F;
> +                       connected_queue_index_p1 =3D (hpd_status & 0xE0) =
>> 5;
> +               }
> +
> +               mes_reset_queue_pkt.active_vmids =3D active_vmids;
> +               if (active_vmids =3D=3D 0) {
> +                       if (queue_status !=3D 0) {
> +                               mes_reset_queue_pkt.use_connected_queue_i=
ndex =3D 1;
> +                               mes_reset_queue_pkt.connected_queue_index=
 =3D connected_queue_index;
> +                       }
> +                       if (queue_status_p1 !=3D 0) {
> +                               mes_reset_queue_pkt.use_connected_queue_i=
ndex_p1 =3D 1;
> +                               mes_reset_queue_pkt.connected_queue_index=
_p1 =3D connected_queue_index_p1;
> +                       }
> +               }
> +       }
> +
>         if (input->detect_only)
>                 mes_reset_queue_pkt.hang_detect_only =3D 1;
>         else
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v11_api_def.h
> index 15680c3f4970..62ad4f0337eb 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -460,7 +460,11 @@ union MESAPI__RESET {
>                         uint32_t                hang_detect_only : 1;
>                         /* Rest HP and LP kernel queues not managed by ME=
S */
>                         uint32_t                reset_legacy_gfx : 1;
> -                       uint32_t                reserved : 28;
> +                       /* Fallback to use conneceted queue index when CP=
_CNTX_STAT method fails (gfx pipe 0) */
> +                       uint32_t                use_connected_queue_index=
 : 1;
> +                       /* For gfx pipe 1 */
> +                       uint32_t                use_connected_queue_index=
_p1 : 1;
> +                       uint32_t                reserved : 26;
>                 };
>
>                 uint64_t                        gang_context_addr;
> @@ -488,6 +492,13 @@ union MESAPI__RESET {
>                 uint64_t                        wptr_addr_hp;
>
>                 struct MES_API_STATUS           api_status;
> +               uint32_t                        active_vmids;
> +               uint64_t                        timestamp;
> +
> +               uint32_t                        gang_context_array_index;
> +
> +               uint32_t                        connected_queue_index;
> +               uint32_t                        connected_queue_index_p1;
>         };
>
>         uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> --
> 2.49.0
>
