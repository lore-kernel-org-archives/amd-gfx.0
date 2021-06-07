Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D67C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 17:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EEC6102A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 17:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EEC6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400A66E95A;
	Mon,  7 Jun 2021 17:17:11 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716A46E95A;
 Mon,  7 Jun 2021 17:17:10 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id w127so18772159oig.12;
 Mon, 07 Jun 2021 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AtFqg3TR/taE0y/EKR7pUF5yxr+poA+jtZYTuPIvfeU=;
 b=UiwljjcSSloI3uGyBgqJOz+hqJuyMgwNynMRAK1DanPqP4KuB6AoDsslE3PDnOhhM5
 IEvI9akDR+vK7Am2aD4pk5XZbUcq/+qzUKMxcuyQPQaaOsLobrsMii9BgFMsgh/jakoo
 5wolJvn0IHCaFGhRZUSgUDFvxKltSFbvS18aP6d/qkncCIPuxppYcfuNzqYxNYBB3m5d
 wLXNTobxjRgZni41zzpE/7OA4ygN+c3UHXuiremmdVsVXW1Z8Tk7u5+HgzIT2YjwiJji
 JQQXlSYiMeGnCRfH2ExbIgXkHjy/+piLVVi4a5MRFP1em605rsOxheuIfwJqFJnsoXNH
 tSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AtFqg3TR/taE0y/EKR7pUF5yxr+poA+jtZYTuPIvfeU=;
 b=CFuMsBXDsrH4CSgHU75IUS43LSEIctBsCFahX7kDbMRIkLkbtG23SvSwGQYRNfLMse
 0Wdu0YeiTptKfYZxvMu7rkzRGYKxAupcWH0BLsNWYVD+j4Pkz6TYm1FRXZqPiju+QHlj
 9h4Ihh+ml+mf+rXhBgwkl15WiWrDkryxJsivLyUht0/jYT3Pj6/0n3m0Zf+C7p7MsQx5
 Arr+Qj6mv7lRnDncM5tREP/SPgapXsYTt5Gp/ntQQV8SAKAMe5dJq2Y6OEm0QahP23/e
 c3OK+nJ3XizoWHc9Y3nqSq1Hv8bd6pRWgNrkAyasENzLPlw33GTo76fyWoxG7m+rZ7uX
 yeig==
X-Gm-Message-State: AOAM532p5gKPO2N+leXqenCNEimUHyxkHBAEwL9P8tSC4tty5A80f//e
 2QAYtuK2USIZcGa9kC/DVYFH8az7ydoybEp5S8TtYfml
X-Google-Smtp-Source: ABdhPJzwkHlxtqTsMiF6NFAkb/Z3ua0k5ZWZ0fLzkk/iXTit2hlNeZTmodS5Bx8mn0idkpNDfkw9O7y6UfTHGGFB9Po=
X-Received: by 2002:a05:6808:999:: with SMTP id
 a25mr167646oic.123.1623086228330; 
 Mon, 07 Jun 2021 10:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <1623061651-33021-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1623061651-33021-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jun 2021 13:16:57 -0400
Message-ID: <CADnq5_PnyYyzZwAMTb-A=fNM3BN5GmkrEciAT_n2XqqcAQKWrw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix duplicate included
 dce110_hw_sequencer.h
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, xinhui pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Jun 7, 2021 at 6:27 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Clean up the following includecheck warning:
>
> ./drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:
> dce110_hw_sequencer.h is included more than once.
>
> No functional change.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index e731987..04d02ce 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -32,7 +32,6 @@
>  #include "core_status.h"
>  #include "resource.h"
>  #include "dm_helpers.h"
> -#include "dce110_hw_sequencer.h"
>  #include "dce110_timing_generator.h"
>  #include "dce/dce_hwseq.h"
>  #include "gpio_service_interface.h"
> --
> 1.8.3.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
