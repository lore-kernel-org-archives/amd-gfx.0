Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4725C54E4A
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 12:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB70206DD
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 12:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XRnT+4+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB70206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAED6E12B;
	Tue, 12 May 2020 12:41:20 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F03B289DA8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 12:09:54 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id a136so4261850qkg.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0E+w23r0rm59Sttp+Cx0/u2Fxv6Zhza30yRDAxBOwIM=;
 b=XRnT+4+TWQyHNmyGS+cSdisYi0zNeQpz5uND4j+3R32mzcUZGCtrhnUZduANVucjLs
 fPeDcZnf0jJZdFR18+rXBGExeB/xOfjO6j5ubgczrNSIabiDm3PpWhxkNKaizLg4FP0J
 sa50sZfadORNY04EFhJQrsRUYbYc9oVcbKS2sMEoCu11o9nPs7ZSUus3alQ+pAkKbMAV
 aWmgipf3DUd2+yiqRDwFz9qMTz3IWl1iCgmhXs/gmp7BDs1Z+Hp9W9wAYy5ZacibQ3td
 xqUancRvGLhZbF4o+FHI7mZTtBugkHa1LurSn3oFjsiEMnHhi/WOIzp2ySY0+TXNYike
 G58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0E+w23r0rm59Sttp+Cx0/u2Fxv6Zhza30yRDAxBOwIM=;
 b=Kdq/bDm9+v+1CxGszlj6nUfgQws5uI6mgeu/LV+TYw00CebBzbi2/xPiV/iA4nLRDU
 csOdx3kH8OWn+OUaYlYzBoDvSp1d2q4zS829DAjbPxf9FTYECWFhGQFHVNSdvQEgNKVd
 d5R2TdDXVwAZo9y4vmsc2uPKZVwM2pbIqXT9LQH4U0RAInrHyxZMRh11l4+4N0YQencR
 N0iHrc6KP70M9pyTQ7pWHClwYhZ9X6IZYLZJEje/ItZt2cVMRw8BHWJi4X+86hO+5xwa
 FAhhc1j0HxqxJuoKRE/Zu/irt86KwUgIjLckcxBrTEgKPhuWEuaXDXZdXhsTej8DISCT
 i61w==
X-Gm-Message-State: AGi0Pub6qMvRepqNjstFnGjEFHyfdh42vSHDt8E6RQ7olTQedjzbDgc5
 PL6aWdbtk1qz6q0oplgC6ALYuQ==
X-Google-Smtp-Source: APiQypKyJUyUDzstE5W+rLlCHv8FxVxdeZGVjAl1eRUGduGzlJpYQ83iKZf1ZsgDC1FOpB7AS1NLBw==
X-Received: by 2002:a37:484c:: with SMTP id v73mr8524856qka.496.1589285394059; 
 Tue, 12 May 2020 05:09:54 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id y18sm12534463qty.41.2020.05.12.05.09.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 May 2020 05:09:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jYTjM-0003lT-T7; Tue, 12 May 2020 09:09:52 -0300
Date: Tue, 12 May 2020 09:09:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
Message-ID: <20200512120952.GG26002@ziepe.ca>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200512085944.222637-3-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Tue, 12 May 2020 12:41:18 +0000
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
Cc: linux-rdma@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, linaro-mm-sig@lists.linaro.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 12, 2020 at 10:59:29AM +0200, Daniel Vetter wrote:
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 6802125349fb..d5c0fd2efc70 100644
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -110,6 +110,52 @@ u64 dma_fence_context_alloc(unsigned num)
>  }
>  EXPORT_SYMBOL(dma_fence_context_alloc);
>  
> +#ifdef CONFIG_LOCKDEP
> +struct lockdep_map	dma_fence_lockdep_map = {
> +	.name = "dma_fence_map"
> +};
> +
> +bool dma_fence_begin_signalling(void)
> +{

Why is this global? I would have expected it to be connected to a
single fence?

It would also be alot nicer if this was some general lockdep feature,
not tied to dmabuf. This exact problem also strikes anyone using
completions, for instance, and the same solution should be
applicable??

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
