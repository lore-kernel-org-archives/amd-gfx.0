Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6155AC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B9B10E451;
	Mon,  4 Aug 2025 17:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jSE3ppyC";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D25510E451
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:05:16 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-31ef3e9f0adso378329a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754327115; x=1754931915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtdoVqAh+dOLnzDR3Iz9SNfPydbMYt149pEcpEMAt1w=;
 b=jSE3ppyC1Czw0dO0MjLeC0B4q8GBFa+ScUufOA5dCHMX4I5YUeE3xrgmQxAMoblqai
 n7iG1zrFjzXQnFgKf+9ssVon9lL+V1CWCjSYfEJyf5XznOFox3VQxI+MMfXmfJo22ZA+
 PDU4biePLslk6FB5U7nrQ8bovUY/NDz0CV7NhN78xMjpZc8Dtr0mkZJLp+hAKqpN9eEs
 T8abNZYg/Vr2cTXiQb5k7dmxJripB5qzZfAg8ozTDDwojstMzEf/iKHoAHRBIN8NoQgl
 Z8nRs+toFkabwtVU53a7e20+qsuCUagDUgOZV9F0JVOgIPaQt6StHzlXNJMOorFUPSSn
 Hw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754327115; x=1754931915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rtdoVqAh+dOLnzDR3Iz9SNfPydbMYt149pEcpEMAt1w=;
 b=LFXUvj8wJMU7T8dy0WaidxB0mY5laohu+MJaJ94sLmypePJe1spL7Ikgjkk8y6WjZr
 yGUsvOic/aE+bjND+/v4cA8KIADbNLlF4lw35fvUFLKKqdqoYdTVLWCArjm8gFTBTqoU
 rbIpcBfOI3Dc1T3MlluOjLnA/bhtyGgtlTPaTs54fE6qSao69575gbobN4cTGjS6loyv
 Zpk1jhiCOYDWTsZD9V99XCJPFtJ9u4KrQW3jeOLCvVyLJbr0rGLANVxjglO6mmOsG2Q2
 l/y/CnHqtP3WvWK/Wk6L/juwK16JCTUUSSDX5dRfFqOLKIu3nrpgE/mb5zYHPkY82Q47
 T1QA==
X-Gm-Message-State: AOJu0YyumKWqTtfGItVQOaaiKQ/yQdo7EvXfZS0GDI94JP6ZI/Nid1v5
 0eKSn7W2xM4ua/8Qzaj7l5o7X/9YdaRi0N2oRCk7nmE3PrCUCjL9bUYWRvczDt5QSVa3KfGRGyd
 QAq9Az+H9hTg5i1g2QdZEr/bJSUSera79sQ==
X-Gm-Gg: ASbGncvrj4vWFSKwMV3oFWnASa/+lj1L1pHYeOscNig4j5a3p0Y+AfnavqYR+hzyUnG
 KFtheOAXAT04l9XgTOzaQtPuswEymNg0eZaBCX+swcDsmVlp7RBxzxey6PuV/z+sAaeHIHPGonY
 7seWmD134x5KDJ2ZHwwVtoA0QDhQxzlQ2aXJfQBN6ZQnEY43NjsISf22Mu0sUrBzMVDbj58x/26
 Pbs2wOS
X-Google-Smtp-Source: AGHT+IFsCgZvlrTp6cJctNHyXdzabE3MUjlcVVvr5FpTC1PDm44I+45siZniTV9H3kRU9nxKHFrPRWanaiA4xVSwOEM=
X-Received: by 2002:a17:90b:3e87:b0:311:9c9a:58e2 with SMTP id
 98e67ed59e1d1-321162e37bcmr5568230a91.7.1754327115484; Mon, 04 Aug 2025
 10:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
 <20250804084029.863138-5-Jesse.Zhang@amd.com>
In-Reply-To: <20250804084029.863138-5-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:05:03 -0400
X-Gm-Features: Ac12FXxnONkZjmSbjx4UejpESAiVU4lHCVBa4q9VrBxVHvHVHHz3IldsCzzQV-k
Message-ID: <CADnq5_PW+5hqcB_Sc=j41+hdZODJ1OopDVeZcY2dGvHdr93PvA@mail.gmail.com>
Subject: Re: [v6 05/13] drm/amdgpu: Implement active VMID detection in MES12
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

Same comment as the gfx11 versions of these patches.

Alex

> Suggested-by: kyle-hai.chau <kyle-hai.chau@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 51 ++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 29d38aa1897e..579720695e9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -885,6 +885,12 @@ static int mes_v12_0_detect_and_reset_hung_queues(st=
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
>         int pipe;
>
>         memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
> @@ -898,6 +904,51 @@ static int mes_v12_0_detect_and_reset_hung_queues(st=
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
> +                               cp_vmid =3D RREG32_SOC15(GC, 0, regCP_CP_=
VMID);
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
> --
> 2.49.0
>
