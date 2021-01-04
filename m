Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A60C433E9
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB312225E
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB312225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8927B6E029;
	Mon,  4 Jan 2021 17:03:12 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB6389FF7;
 Mon,  4 Jan 2021 17:03:11 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id x13so32868032oic.5;
 Mon, 04 Jan 2021 09:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bkfKIc8TYv8/nRpoPVoMEofElitz2KLsBoBEwufJSM0=;
 b=iGIjA39XdTndy0R3+OqGy5LlHrdqOClBY1/FWEX5jyoMeg3HRVh87Ta21eQsaZnafO
 j3v/KCXJ/0iGc8LDxzKuPWravYhZk0rczR5/b6B//M+D1COrM4LDB80FALGQWNQGXMCR
 v0Qkxb70zsuujhkJJcLO/ungyAjilF5qjZf45da4Qb2ftbQpNpNHYMOZL0IfC9xJrCQT
 qXmoU38fF+1t4Hu2NraVXvCe+X3FHiTSrSdXAWAhq1LbrZTRNlFtjYICJBc/Wmb5vaQB
 mGxl/DIWqhVvUmpDJIRskxfFmckEGMfCz3qgS8jHz4talJtLXnj9eoq6DY88MJ2Sllaj
 g3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bkfKIc8TYv8/nRpoPVoMEofElitz2KLsBoBEwufJSM0=;
 b=CkbuyA8T0skMzK0Z2ltqJZaaeMi1UgRzdCi9dI/v5E2iZJosze3nqKHY56z9v8y482
 gfZJwKFzmuBS2jLOEfvIcsPGerAoH0m6gqGnelz1rsGuUanVD9VgU6qtvsx85rr39813
 T7GqopVqi4Wk/nNXSRVR8wTpedPxZ8HjO4nYcjElhtlR4NolraCZchoOZLIDaAZUJosQ
 VrrEb1sO79G2kYQr3jq/X+rhn2shZ8OVUOJGPu3mMou55PG40x9+NtBfZ3mrkmmJMipU
 85kxZBuqfk4v6d51neryfzJP+Da1oFEdoBxaEUKE3PxJNahaoBa3hP+vEKpxYOSSsYuB
 wVCw==
X-Gm-Message-State: AOAM530h9f1c6FPlKrffeWRcPs/L9hM35fyZlablF995LDDpLWHBW/be
 aKZJ+mu4uwo2Qy3eRY3SRgEwNFtU/t85ew1oUxZHKWQj
X-Google-Smtp-Source: ABdhPJxA/GM8cZ0BIWwtLaCo/AOxg5iblCGFiV28MHKxwkGcJDu7ZQLBuCsqx/yHA/FkZSq2MLM+ksDZ9eivPBKDDGM=
X-Received: by 2002:aca:6202:: with SMTP id w2mr17652648oib.5.1609779790520;
 Mon, 04 Jan 2021 09:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20201222133100.19470-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201222133100.19470-1-zhengyongjun3@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Jan 2021 12:02:59 -0500
Message-ID: <CADnq5_M6a0LOS3UrteaMcPtZVApJQoV=fR8jizbVzk96VFTHrA@mail.gmail.com>
Subject: Re: [PATCH -next] gpu/drm/radeon: use DIV_ROUND_UP macro to do
 calculation
To: Zheng Yongjun <zhengyongjun3@huawei.com>
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
Cc: Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 23, 2020 at 2:06 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Don't open-code DIV_ROUND_UP() kernel macro.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/radeon/r600_cs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
> index 390a9621604a..a3aea5329712 100644
> --- a/drivers/gpu/drm/radeon/r600_cs.c
> +++ b/drivers/gpu/drm/radeon/r600_cs.c
> @@ -219,7 +219,7 @@ int r600_fmt_get_nblocksx(u32 format, u32 w)
>         if (bw == 0)
>                 return 0;
>
> -       return (w + bw - 1) / bw;
> +       return DIV_ROUND_UP(w, bw);
>  }
>
>  int r600_fmt_get_nblocksy(u32 format, u32 h)
> @@ -233,7 +233,7 @@ int r600_fmt_get_nblocksy(u32 format, u32 h)
>         if (bh == 0)
>                 return 0;
>
> -       return (h + bh - 1) / bh;
> +       return DIV_ROUND_UP(h, bh);
>  }
>
>  struct array_mode_checker {
> --
> 2.22.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
