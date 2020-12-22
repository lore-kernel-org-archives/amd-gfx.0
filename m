Return-Path: <SRS0=THln=F2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE6FC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 15:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE9D22583
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 15:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE9D22583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666376E884;
	Tue, 22 Dec 2020 15:10:12 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DD86E884
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Dec 2020 15:10:11 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id j20so12143115otq.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Dec 2020 07:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=56/LUZ/gfjHkY0qyOt4OKxEMvFTOT20GNVIEBwLu0HA=;
 b=fys1DMc/I3/RQs1VM4ZibGA70MqPZUGRGFnDvxUdhZczBvfsZyBjkRq1T62g/fyZX5
 Gdy4ZyPbHiqPIHHepRt70Dptvqwf3NihGRzKeXyQGChz1s0X6XD7LpO26pQG5ubhceN7
 FJ0UDg7V8GVUOWp9LlFHoFON9qOobsePlSecUBkJb3yf/5qEPEJ6LYB919WiCBWd9B+K
 p8s5r5dMM3DSyG9TnFto9Iy1c3IPpfHHBeOGoL1+Wro24LZTF3Az6kaEw8jN8/Wo9IC1
 OukOizwWeONLbfZKb13uBUVbD1Nfz/RVQQ/61MM1LkRqnx5lJAAqwuDe/kx39oCWwy8x
 h2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=56/LUZ/gfjHkY0qyOt4OKxEMvFTOT20GNVIEBwLu0HA=;
 b=lK5ITbEXM/nMR5REPiru77bqpbTjBgkmL08b9LhnKi8cvYKtyyVHR6dDXZZL3VsXQu
 KjK9hdRiy7ddYFbNb2Ls2ojS5rxqyB0m28X986dQiZZp7TothZYxQeSluddEbqcPJke5
 vp0IhJHJOM3L2HRIiIPPo+601aTGuv7YIeGdhndPcRKPyjFO5PFGymrlAMFYuByHfbYH
 egf2Tzyivcz9YOHdsCVE3FLGCtHAx/aRLEANyKf2TVNLXQmljJUKe6WJrxCr0CVsMiH/
 w+NfAXOKz25Q5rCS169oieAci3k8iqKCNaOhimGFHTu4nZJdDylZn6UghulErwIOpf68
 4d9g==
X-Gm-Message-State: AOAM532MVpKUyWN7CHtXCdpLgCZltbWjZqSQOhnLexMsYFZQrtWfJhf7
 yaidWCmG0DonkQMPRq/4ZAEtdLhynPnlF4EoxMQ=
X-Google-Smtp-Source: ABdhPJz+91Vm7Ll2mU+5hhFDoLx2PPEVzwzsGCx9P1sLkOV+GLafVmqCG4bq+2uh5d1ws9gvsk5Npz9BLl4RTcE62rY=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr16447165ote.132.1608649810743; 
 Tue, 22 Dec 2020 07:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20201218221616.2452182-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20201218221616.2452182-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Dec 2020 10:09:59 -0500
Message-ID: <CADnq5_PCBYbnORTENgNE4Z_wd0-4GNq8g0Jj+P=99YHh_YS5OQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Create and Destroy PSR resources for
 DCN302
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Joshua Aberback <joshua.aberback@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 18, 2020 at 5:16 PM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> From: Joshua Aberback <joshua.aberback@amd.com>
>
> We need these to support PSR on DCN302
>
> Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index 808c4dcdb3ac..8d24cd5e484e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -53,6 +53,7 @@
>  #include "dce/dce_i2c_hw.h"
>  #include "dce/dce_panel_cntl.h"
>  #include "dce/dmub_abm.h"
> +#include "dce/dmub_psr.h"
>
>  #include "hw_sequencer_private.h"
>  #include "reg_helper.h"
> @@ -238,6 +239,7 @@ static const struct dc_debug_options debug_defaults_diags = {
>                 .dwb_fi_phase = -1, // -1 = disable
>                 .dmub_command_table = true,
>                 .enable_tri_buf = true,
> +               .disable_psr = true,
>  };
>
>  enum dcn302_clk_src_array_id {
> @@ -1213,6 +1215,9 @@ static void dcn302_resource_destruct(struct resource_pool *pool)
>                         dce_abm_destroy(&pool->multiple_abms[i]);
>         }
>
> +       if (pool->psr != NULL)
> +               dmub_psr_destroy(&pool->psr);
> +
>         if (pool->dccg != NULL)
>                 dcn_dccg_destroy(&pool->dccg);
>  }
> @@ -1469,6 +1474,14 @@ static bool dcn302_resource_construct(
>         }
>         pool->timing_generator_count = i;
>
> +       /* PSR */
> +       pool->psr = dmub_psr_create(ctx);
> +       if (pool->psr == NULL) {
> +               dm_error("DC: failed to create psr!\n");
> +               BREAK_TO_DEBUGGER();
> +               goto create_fail;
> +       }
> +
>         /* ABMs */
>         for (i = 0; i < pool->res_cap->num_timing_generator; i++) {
>                 pool->multiple_abms[i] = dmub_abm_create(ctx, &abm_regs[i], &abm_shift, &abm_mask);
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
