Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8C0C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 19:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AB910F957;
	Mon,  7 Feb 2022 19:35:53 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC6410EF97
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 19:34:59 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id y8so12852465qtn.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 11:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9c7vpxYS+6RnfIRFWhHgAcQnmpWWsCXDoIZ8HfcxKVk=;
 b=eyrwc8BMMdOVC7JxxbPkKv0E+7XYg1mWVnxya1gkeBbn+6FIIKA4h5dIP4xxQ6Lyue
 PP3XS1TlpffXxqvfwJvChxVJKrRaJ4INlob/J3j8V4nhPl1/nALzUS4bebpDgN+o/Aus
 QQg2zEZcdkmCLgeogf4eYK3AO+nmond0PimC6gBZEbdgCdCPZ88/G1CIEJ9vhbSZK4os
 tk4KtyYHQy6WXksXzSrn8f5eOqxd/45+LU03LL1E7V5s7Z/zSb/UfyVa4YpBFVPoHCin
 OF1OweCzorEMyWiZQI+JHPsC+t/W26GR57RXRrAWC89poKcjeNO3WJ+VmGSwbNpLPdn4
 ljZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9c7vpxYS+6RnfIRFWhHgAcQnmpWWsCXDoIZ8HfcxKVk=;
 b=rN/ma5ODGdGYnhXXXTo9hpy0US7tk94QdU7k9xBtiUfF/YIrMQvYQiP/KDSvWOccli
 eCn93GeBwsiSEYYIsc5YfxRVsaT4kd8QqaBtxohfVUNQ/4Q2pw7IwKSzdtGqREKtV30e
 JLaplMlmavUGXOeZjJCSaGI5yBON96uKY04B6niO0H2u3CP93jgSxy645/3FBbM8bpVO
 izrV1uicHSRlHkOggJdoQDOUwYgCitrwrI1EPBGp6ar5rY85ePPj0kv0EzZ6Wjdtlrwj
 tu2t/kNmoTcAcWCI5hObEr7Jln/h1xs8zm8zcm0AUuuWnyjSi49rPyminu+mOeYFpmC3
 V2Xg==
X-Gm-Message-State: AOAM533JSr1goXi26q6cohph9O15nm72ZocsDyllXIMUilVOzr63CKjB
 V/GWk1uiefmHYS8WxrL4m8ePTw==
X-Google-Smtp-Source: ABdhPJyvD659xk5KRCKkhy7N4LjGPrkEHjwUHp/EZt//+nT6eRHPcHoug24DbpSsFF9r7utyh5WJCw==
X-Received: by 2002:ac8:7507:: with SMTP id u7mr761226qtq.518.1644262498222;
 Mon, 07 Feb 2022 11:34:58 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id o18sm6033304qkp.26.2022.02.07.11.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Feb 2022 11:34:57 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nH9mq-000I5O-UX; Mon, 07 Feb 2022 15:34:56 -0400
Date: Mon, 7 Feb 2022 15:34:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/8] mm: simplify freeing of devmap managed pages
Message-ID: <20220207193456.GF49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-6-hch@lst.de>
X-Mailman-Approved-At: Mon, 07 Feb 2022 19:35:52 +0000
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
Cc: nvdimm@lists.linux.dev, Ralph Campbell <rcampbell@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, linux-mm@kvack.org,
 Ben Skeggs <bskeggs@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>, Dan Williams <dan.j.williams@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 07, 2022 at 07:32:46AM +0100, Christoph Hellwig wrote:
> Make put_devmap_managed_page return if it took charge of the page
> or not and remove the separate page_is_devmap_managed helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h | 34 ++++++++++------------------------
>  mm/memremap.c      | 20 +++++++++-----------
>  mm/swap.c          | 10 +---------
>  3 files changed, 20 insertions(+), 44 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
