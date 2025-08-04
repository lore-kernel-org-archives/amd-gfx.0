Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C61C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D1A10E371;
	Mon,  4 Aug 2025 17:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDw+OsYp";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8D310E371
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:04:39 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-32116dd55dcso563447a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754327079; x=1754931879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKHMAEXqsMBU1GxUC99qo6dJQTW3jpxZ0uxGQawl4cQ=;
 b=VDw+OsYpxTq1EEyg/ns5M6t6PZS7eI0c2jq/lpUHjygZ66T3n+owwvIgm97AoSb4zl
 xFR/E52ENCDINTettperLJqvEvomThSf1ifzjWKNSkqrXq9ZbuJbUL0lcLCyiEgARvm9
 clr8GhUh5jdPSG8FSMSdpsqWpw4Mlo540+6WTkByPJuoUmlPq8ruojIQuKnFqMF7x3Pp
 lh2pcNxU//1PEcEnwBzqA9IFn00kfQHvcl+h1VKKn42P0UYo+GrVSqJ488AoJUwctBFW
 0wHbWioaF6mp1ADbTvZ7KMNqgdoaGhQLop9+50AfY6922ggTBpuuv8p1mguxBKQPv2ba
 +EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754327079; x=1754931879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKHMAEXqsMBU1GxUC99qo6dJQTW3jpxZ0uxGQawl4cQ=;
 b=DsqUMZeg2UJQSlbrR1+0nxvkWALyhtw64MPfimC3lF9Jdw98vmY+F74axvNLum8bzF
 fZtGUcyj3xxAADP5z7E5F+CT/swirH94HElg//f6OOAOuRFqS35cIoBPjjetpZnq/Nq7
 2hiw+kjinqvD4RkSaF3ak6MUNs6if/+bk//cjn8e3LhCfKVYLqYL4QYDtMLzZLm9keFd
 jDQkA5wJepw28ytMae2w1qnhhypuwdVgN8XvP6bK5sXYEbnuGsfqge7Dn4182yHLcR3e
 AeZSMg6nvUqsBCLRalGdtDLY1h7RCzuQDHyb0WQ7wlFrVKuwuuZkBIHLHcxC7gL0XORu
 JALw==
X-Gm-Message-State: AOJu0YzxM4AWFjXqnv3poPOETbruh+4qh69Koq6a2IwpGv4AurMxbm2a
 irOZOjAWGq9V2JrTFjDe1UTl5lSF0pk14BONnlxGgun3+AP1tMfe36SR/giZQZ4+j5JmG9xTyjd
 xdM/QVpTlXdHy0N3SaVinRrlso9+alqOixw==
X-Gm-Gg: ASbGncsVdc/gfOWmnVEfPHr7/+M2Op6+YbpI6AnwzOGKMjAYz21kNL/iKIFmZ7yEUYY
 nAhKhCRjxEKcsp65NPIXO5Oak/5la1LonH8sdlzd7HONrBPRX4GsohUJZaSi26gEJAXd+nz0BU1
 viebZlDlTpB2sqvBYyG6UgcSbWiteQ3cLgWo2QsG1bsPUTg/OxbWGfiLZw6z5S9Qitio4qgwwNv
 NdQjmScU7j66OfJ91s=
X-Google-Smtp-Source: AGHT+IH2KUb0WFEJ5ywIFZ1CYmAb+GP7fl635NwwQhOyp/ZNrdtjHvli/me36kLJaEUECyr+ZS9JYQyaBa7ZxESU7kc=
X-Received: by 2002:a17:90b:1c03:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-321161e2197mr6799771a91.1.1754327078889; Mon, 04 Aug 2025
 10:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
 <20250804084029.863138-4-Jesse.Zhang@amd.com>
In-Reply-To: <20250804084029.863138-4-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:04:26 -0400
X-Gm-Features: Ac12FXxZ6y6dBuKdR-mIeX3n2I7RNC1x7CtZdjsWUHY1JiIExR0B16qxUum7GSA
Message-ID: <CADnq5_Ny_J379Mu0Oj2kqvR39uqDNGNmOS4CyQ4bkdtqKOCDMQ@mail.gmail.com>
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

We need a FW check so we know which version added this new API.

Alex

>         };
>
>         uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> --
> 2.49.0
>
