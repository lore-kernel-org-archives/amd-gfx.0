Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC26C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E70D10E137;
	Tue, 17 May 2022 19:35:23 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DDB10E137
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:35:22 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id i66so22551oia.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tq/dtbmeai3VVexprjfKjnewdvXCll90Pzbcq/gXso4=;
 b=j6Actg3KU/y4k9Shy/ts5v/UMHrdhJdoCiaSqCvJsKLqPohIj85X7JWbSCE6Xojb/J
 4+VTULDPOaTqnq2pU6ZLoGigGUiI+eMj20YXZlZPZA4vBu3jHLSczFRl3ku6xMu6Mi0D
 FKnSnPkSobKDbqMEPnY2YiaHMiNLTkSrcUBxda1ZcodujZf/vrZx+eNNAka0NNJZqLSl
 CO9MfBa/H6+EB8AK3M+csvQ2TbxLHnDxSj8V6oS+Jht0VQW95OKEFheA95lyBeIrCfvy
 8JKuHIVvZG4WSEdTXo/TACDVeaZ+QbfFDYVTCEFH5nfC4TUPlYTv1yo5X1wECoOLh+Kp
 cffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tq/dtbmeai3VVexprjfKjnewdvXCll90Pzbcq/gXso4=;
 b=ND5hXuEj8Ondk//0ffjs7lH0aUijkwOzqfaKNNO7TcpZqfqWALfNnhKG2nR5mi5gff
 n12FwK8YYU1UhpDxHRoXL043H49UTJg3DFQbPpkyl08qa3dENTol2/l0M5gQiaLQUPqk
 ZaGuc6jSMRV/GAloTeo+aeIVKjEEYr299/MKlpBYRtJEOdVhuWkdVb1HXvZqfO4eikPt
 DEvqRFljFQ6okZh9ZBPOQeOwFv0tZpp8d169NOfmmdAstN2S+Qy4E0LCxB/sC5p1qezr
 HBYV7VCUfTjD6bg/TybVGi5Hbda3kgcryh0js9fgD5tB7iGvYdPa3g4AkCHuF3vOGY+X
 oDtA==
X-Gm-Message-State: AOAM530WnPzP+Ph5dwhSBezVgJUMbRDrfxBcnkKlKdIZogUYf+vRzjEh
 WumlOgeZUwAjXtf9g0+KtnqGPXRKq45O9Pc5hRiiz+2n
X-Google-Smtp-Source: ABdhPJwGuJNpiwKaqKXc9NVbNKgsCfSD3YijgLV2hUnJS38/H4wB1uaTJKA6ey173DqrTtt76xoo6+Rm44oMmQ3zUkQ=
X-Received: by 2002:a05:6808:178d:b0:326:3fe9:7f03 with SMTP id
 bg13-20020a056808178d00b003263fe97f03mr16067644oib.200.1652816121702; Tue, 17
 May 2022 12:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220517112438.5223-1-ricetons@gmail.com>
In-Reply-To: <20220517112438.5223-1-ricetons@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 15:35:10 -0400
Message-ID: <CADnq5_NsAXonAmyAkY2BXDQfyR6T0Js+EKhNE9nA7V9pvab81g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fully disable the queues and doorbeels in
 gfx_v10 before programing the kiq registers
To: Haohui Mai <ricetons@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied with a reworked commit message.

Thanks,

Alex

On Tue, May 17, 2022 at 7:24 AM <ricetons@gmail.com> wrote:
>
> From: Haohui Mai <ricetons@gmail.com>
>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 27 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index dd8f4344eeb8..9a1b42cc8500 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6956,20 +6956,6 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
>         /* disable wptr polling */
>         WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
>
> -       /* write the EOP addr */
> -       WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
> -              mqd->cp_hqd_eop_base_addr_lo);
> -       WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
> -              mqd->cp_hqd_eop_base_addr_hi);
> -
> -       /* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
> -       WREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL,
> -              mqd->cp_hqd_eop_control);
> -
> -       /* enable doorbell? */
> -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
> -              mqd->cp_hqd_pq_doorbell_control);
> -
>         /* disable the queue if it's active */
>         if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
>                 WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
> @@ -6988,6 +6974,19 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
>                        mqd->cp_hqd_pq_wptr_hi);
>         }
>
> +       /* disable doorbells */
> +       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, 0);
> +
> +       /* write the EOP addr */
> +       WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
> +              mqd->cp_hqd_eop_base_addr_lo);
> +       WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
> +              mqd->cp_hqd_eop_base_addr_hi);
> +
> +       /* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
> +       WREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL,
> +              mqd->cp_hqd_eop_control);
> +
>         /* set the pointer to the MQD */
>         WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR,
>                mqd->cp_mqd_base_addr_lo);
> --
> 2.25.1
>
