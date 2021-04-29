Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DEBC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 03:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B57C60C41
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 03:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B57C60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA656E196;
	Thu, 29 Apr 2021 03:41:10 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F13B6E196
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 03:41:09 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 k26-20020a4adfba0000b02901f992c7ec7bso923081ook.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 20:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q0vKQr0+6NjNCeFcj6pqQyrce7RsUoFwSF6Otq6tg0w=;
 b=UFYMYIvmcfp/WI/nSjEol8kbePFIHL6e7y4cVHg+ocJB3SJA2W36clbjPpnhqWRLap
 ttKCfEh3PW1A9I+AySVlXBsDMWYgZlvkcZ2b1dBXWaXlI82N9A/9QMmt1Nx5gXQgvFq5
 emdhLG+705aFf/sVoTu1yVL2WFJj66nJShm1rey92gPIAs9pd7+mt1wQvqZyG/6Tw7QJ
 sUebOmVu0LRN73PLkFEafZFLiBWo6xEVooe5f4DP8zc+ai2t+BBDZSc+rEMN0SgSRXSJ
 yv0diZracidkSrXPms8lhj0NqXQ+tqv5XEFwHH6nEWE5Kv8Bj/o4OhYTmZI9SQMYjpEA
 WR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q0vKQr0+6NjNCeFcj6pqQyrce7RsUoFwSF6Otq6tg0w=;
 b=YPCUs7gGS9Fatbr3XD6NLxN0k2tyY3Pr19dBCrKCVTeKTrSO001GhmBAHf1Ik9cVC+
 ojGcVK5FcR1PqqcamNDmU7TNt5hYjR9cirbHTTfe9KdJxlBQIzKanK3pnCI+f3DCN3Lv
 w4jOd/I4v4OifRyDxWV7lgm1CvWVxBOXUlivMJ6Rgd/qEXagGfe5W5ivEnOcSr8LsAmu
 ArSFWjDMaJrJcBoPPGVX5Hfk5lPcmsvBWfr+2jsew8+aiIgOhTDE5SqcmFacD55TWhiC
 dYhixpMGWhK2iFyD04z6IY9by8Z5k4u1OKy33sXCM3VkeLjimNsMxsPYGrSJ7EUZsrnx
 Y51A==
X-Gm-Message-State: AOAM532Wdx4KOguvqE/qxketiU1BiCjqk8iVJCl6h9S+M5wUK10Oj24A
 /Z8qksEF0luawQKFnT07rvoNrkcPhGZIyudmo0I=
X-Google-Smtp-Source: ABdhPJz2niz9stA9ecNjt4ME9G0bHba0HIVjc9UUYBh4weifAB94VbFCFj1PhCBAkaKmtbGcVozAYKla9DTDxyvUPuw=
X-Received: by 2002:a4a:cb0c:: with SMTP id r12mr25412409ooq.90.1619667668824; 
 Wed, 28 Apr 2021 20:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210420192739.1906700-1-alexander.deucher@amd.com>
In-Reply-To: <20210420192739.1906700-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Apr 2021 23:40:57 -0400
Message-ID: <CADnq5_O7OWgmX72VBOqSYKkq=A0dVmxGFmg9om54HCqen0r5EA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, Apr 20, 2021 at 3:28 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Add emit mem sync callback for sdma_v5_0
>
> In amdgpu sync object test, three threads created jobs
> to send GFX IB and SDMA IB in sequence. After the first
> GFX thread joined, sometimes the third thread will reuse
> the same physical page to store the SDMA IB. There will
> be a risk that SDMA will read GFX IB in the previous physical
> page. So it's better to flush the cache before commit sdma IB.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 920fc6d4a127..d294ef6a625a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -437,6 +437,33 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
>         amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
>  }
>
> +/**
> + * sdma_v5_0_ring_emit_mem_sync - flush the IB by graphics cache rinse
> + *
> + * @ring: amdgpu ring pointer
> + * @job: job to retrieve vmid from
> + * @ib: IB object to schedule
> + *
> + * flush the IB by graphics cache rinse.
> + */
> +static void sdma_v5_0_ring_emit_mem_sync(struct amdgpu_ring *ring)
> +{
> +    uint32_t gcr_cntl =
> +                   SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB | SDMA_GCR_GLM_INV |
> +                       SDMA_GCR_GL1_INV | SDMA_GCR_GLV_INV | SDMA_GCR_GLK_INV |
> +                       SDMA_GCR_GLI_INV(1);
> +
> +       /* flush entire cache L0/L1/L2, this can be optimized by performance requirement */
> +       amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
> +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD1_BASE_VA_31_7(0));
> +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD2_GCR_CONTROL_15_0(gcr_cntl) |
> +                       SDMA_PKT_GCR_REQ_PAYLOAD2_BASE_VA_47_32(0));
> +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD3_LIMIT_VA_31_7(0) |
> +                       SDMA_PKT_GCR_REQ_PAYLOAD3_GCR_CONTROL_18_16(gcr_cntl >> 16));
> +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD4_LIMIT_VA_47_32(0) |
> +                       SDMA_PKT_GCR_REQ_PAYLOAD4_VMID(0));
> +}
> +
>  /**
>   * sdma_v5_0_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
>   *
> @@ -1643,6 +1670,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
>                 10 + 10 + 10, /* sdma_v5_0_ring_emit_fence x3 for user fence, vm fence */
>         .emit_ib_size = 5 + 7 + 6, /* sdma_v5_0_ring_emit_ib */
>         .emit_ib = sdma_v5_0_ring_emit_ib,
> +       .emit_mem_sync = sdma_v5_0_ring_emit_mem_sync,
>         .emit_fence = sdma_v5_0_ring_emit_fence,
>         .emit_pipeline_sync = sdma_v5_0_ring_emit_pipeline_sync,
>         .emit_vm_flush = sdma_v5_0_ring_emit_vm_flush,
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
