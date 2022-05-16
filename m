Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404A7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 19:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B4710E0D7;
	Mon, 16 May 2022 19:00:33 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479B310E0D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 19:00:32 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-e5e433d66dso21395597fac.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XVlXdzoaavuqem50OalPLi3P9k2tHAkJLJokPMqH3D4=;
 b=R53zvnUhKT3W0IKRpzJ+/7ZKu/9oHESQ16SW4LB5wr2aXg9kI5L1LEx40zeLaZPNtI
 o9eM/1d/MiTm1rGo0r7tjAQuV7NeuTvcP/gOEePNThDwR9ZELJ2cjAIpHecmoGS4HS3g
 +IxFqRXj2I/C2E155hwPRoEP27jCh68pMqo+CMUDm5Xq3Y6qMZ/X0J6JZS7PxqNoa34F
 gYBsfHreDzmImS4R62q76V475CijNCv17aItxeAFAGIiph4ewGoAD3Ddz1dGz9Y1ySPy
 iIIsLCDqYj/z2lmH6aPjKUy2w74u2HWnqKQwCFzqD+FsKxWwSj0zKiiI7Z7NOwAAeciM
 +tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XVlXdzoaavuqem50OalPLi3P9k2tHAkJLJokPMqH3D4=;
 b=jYtJ6OQhHmVj5fw0Ob9pQot6kdLw8RGKpdhcft4zVDd2jRE1vHDR/7cK9VcFaFxfe8
 MebLwBvpYLc8u5beYuBIC7F8L0jOKV13f1xIVlqME9nq3LWgm1e1rY/3QQM/F0KDmYlC
 2UCYSUYXNHEP/dJ+0SauH9dgsfSYI4ng78BBYjDCV/i8Jlq06iusnu4CR5Mc/55ohgF5
 6BTHXyxhqAM43RsUYBJcH3XqvuDoNTBdrCZTmoyyNK0iU/iZYtKBa6Z2ZgQWSc4hfpfY
 BORTMSgPsY5euaZwjaZzsLFVl7rhfElrhv7JhODnLWZ6QAb78IklWDgPmT45hr3xND0n
 P7CQ==
X-Gm-Message-State: AOAM531nhNAS7EwB1FeVftNp+L2+uQ4XRjVu3/zEkZutYeDzHh/FKS18
 4lw7hiFocYh5NURlsspJzKSohuzQDLpeC2Ydv+o=
X-Google-Smtp-Source: ABdhPJx3oIKVUmFqAnn0WYnZtzfSx4PY2KYuaMU+ugFH3UNoX9AOV2abKbGr/PROUjz9xnZEDNIDx+H0tYJtvoP65Ik=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr15269809oaa.200.1652727631461; Mon, 16
 May 2022 12:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220516120053.22963-1-ricetons@gmail.com>
In-Reply-To: <20220516120053.22963-1-ricetons@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 May 2022 15:00:20 -0400
Message-ID: <CADnq5_PWksoFcFuwMJVc5wKR-0sf+0fmh29nezfxzRub=6JQYg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up of initializing doorbells for gfx_v9
 and gfx_v10
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

Applied.  Thanks!

Alex

On Mon, May 16, 2022 at 8:01 AM <ricetons@gmail.com> wrote:
>
> From: Haohui Mai <ricetons@gmail.com>
>
> Clean up redundant, copy-paste code blocks during the intialization of
> the doorbells in mqd_init().
>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 -----------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 17 -----------------
>  2 files changed, 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 4b66b9c93754..12f63d6aab12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6919,23 +6919,6 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>         mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
>         mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
>
> -       tmp = 0;
> -       /* enable the doorbell if requested */
> -       if (prop->use_doorbell) {
> -               tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
> -               tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> -                               DOORBELL_OFFSET, prop->doorbell_index);
> -
> -               tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> -                                   DOORBELL_EN, 1);
> -               tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> -                                   DOORBELL_SOURCE, 0);
> -               tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> -                                   DOORBELL_HIT, 0);
> -       }
> -
> -       mqd->cp_hqd_pq_doorbell_control = tmp;
> -
>         /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>         mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 83639b5ea6a9..f49a2dd89ee7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3535,23 +3535,6 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
>         mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
>         mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
>
> -       tmp = 0;
> -       /* enable the doorbell if requested */
> -       if (ring->use_doorbell) {
> -               tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
> -               tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> -                               DOORBELL_OFFSET, ring->doorbell_index);
> -
> -               tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> -                                        DOORBELL_EN, 1);
> -               tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> -                                        DOORBELL_SOURCE, 0);
> -               tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> -                                        DOORBELL_HIT, 0);
> -       }
> -
> -       mqd->cp_hqd_pq_doorbell_control = tmp;
> -
>         /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>         ring->wptr = 0;
>         mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR);
> --
> 2.25.1
>
