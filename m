Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC833C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 14:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78446613BE
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 14:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78446613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8D76E413;
	Tue, 20 Jul 2021 14:50:00 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3706E413
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 14:49:58 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 a17-20020a4ad5d10000b0290263c143bcb2so3908851oot.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7krDxm5SjB8eclZ8UZlGfhzNyli0qKezX3gmbmFlqOg=;
 b=sULyfoAwihdTRmMtek6VOeA0gbTjak55jKy0pnX04qmf6ZpczgfX4ptquXrj5loViP
 7ES+/6PzJnturxDfoZ1VaCXB69AHFtqSTwG44ALpQZr1HEhSNpCmIVSj35HKbru33k9I
 lTq6m4eozLZ+78U7SScMRwF+bJOJZbZTiWLzpKLSA5Beh7Y6DoA8Jlkq+0od+ZQMPmZD
 JBbyRSvMXWmmqOybF9LgX0hLD2162FB4d4IHABIcETdPC/splZYsW/CDnD4m15pfn9BI
 Aa2Gc1iH4P+xoLWP6aOCVFMz+ngiz/bwTInFQV91KiXv7uNsqmSt64UaACrXLd9lW1JB
 rh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7krDxm5SjB8eclZ8UZlGfhzNyli0qKezX3gmbmFlqOg=;
 b=FXb91lsrUSspcn11GSFKhaxm0/03BdxVVvoXg5QBnovPUIlbDvr0xd/MHSa1H9wfQK
 itZfVfWc+w2b6OS/kUAUGqC4G3dcASZODuJ9UR67No3lEiNesfvzidb4sgznauYVqidS
 hsYn+F/sf4HnE7nketSl7MyKc206cYIkBQFRkDOSvvAl408ukQ7cfPUlsyPOxLxiXITw
 HTxEHDVtP75LBGBnoNH3irfPKYTCLaiDsZ+OY5pNV7yHHlQ5YBMLXNdxwZ/938LYvj+L
 bEbk1hOebdC3z4c+EMYCQAgGZsNPuw5yuEB5ODfKcURZH64BgOIwbt7Onbn7j/wlPiqv
 wEBw==
X-Gm-Message-State: AOAM5305/yWvZbRoHw7BorENCgY53ew+ITADhh5b84Lyvu2/pHp011Cr
 HGLPri+FWRfT0BpGfv7T7XC1Cewr6FhlLNpYWQM=
X-Google-Smtp-Source: ABdhPJxvMyyN1f92F07n6VjfLAL9ERbkkSr5HDeDz4m6QAxA6Dov36lF57kHlXqS66IODQ7gmo+P0BLk/fD1dYn8ikQ=
X-Received: by 2002:a4a:acc8:: with SMTP id c8mr20811103oon.72.1626792597837; 
 Tue, 20 Jul 2021 07:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210720143017.613974-1-Anson.Jacob@amd.com>
In-Reply-To: <20210720143017.613974-1-Anson.Jacob@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Jul 2021 10:49:46 -0400
Message-ID: <CADnq5_PJKvuy+_E-G8FJs20cSYBJTOrDCUnfG+vensR-R0TwVw@mail.gmail.com>
Subject: Re: [V2] drm/amdgpu: Fix documentaion for dm_dmub_outbox1_low_irq
To: Anson Jacob <Anson.Jacob@amd.com>
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 20, 2021 at 10:30 AM Anson Jacob <Anson.Jacob@amd.com> wrote:
>
> Fix make htmldocs complaint:
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:628: warning: Excess function parameter 'interrupt_params' description in 'DMUB_TRACE_MAX_READ'
>
> v2:
> Moved DMUB_TRACE_MAX_READ macro above function documentation
>
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
> CC: Harry Wentland <harry.wentland@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7ed104e3756b..829d31e04f09 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -618,6 +618,7 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
>  }
>  #endif
>
> +#define DMUB_TRACE_MAX_READ 64
>  /**
>   * dm_dmub_outbox1_low_irq() - Handles Outbox interrupt
>   * @interrupt_params: used for determining the Outbox instance
> @@ -625,7 +626,6 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
>   * Handles the Outbox Interrupt
>   * event handler.
>   */
> -#define DMUB_TRACE_MAX_READ 64
>  static void dm_dmub_outbox1_low_irq(void *interrupt_params)
>  {
>         struct dmub_notification notify;
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
